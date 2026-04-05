---
description: Autonomous DSP correction — measure frequency response, compute corrective EQ, upload biquads to ADAU1452 via SigmaStudio COM, re-measure to verify
allowed-tools: Bash, mcp__strudel__write, mcp__strudel__play, mcp__strudel__stop, mcp__strudel__init, mcp__strudel__status, Read
---

# DSP Correction Pipeline (ADAU1452)

Run an autonomous measurement-correction loop: play test signal, capture response, compute corrective PEQ, upload to ADAU1452 DSP via SigmaStudio COM, re-measure to verify convergence.

## Arguments
- `$ARGUMENTS` — channel name to correct: `sub_main_L`, `sub_main_R`, `sub_near_L`, `sub_near_R`, `tactile_L`, `tactile_R`, `aux_1`, `aux_2`
  - If empty, default to `sub_main_L`

## Prerequisites

- SigmaStudio running on PC with ADAU1452 project loaded and connected to hardware via USBi/ICP5
- COM server registered (one-time): `RegAsm.exe Analog.SigmaStudioServer.dll /codebase /tlb`
- MOTU M2 connected for capture (loopback for electronic, mic input for acoustic)
- Strudel available for test signal generation
- REW 5.40+ running with API enabled (`-api` flag), correct audio I/O configured

## Steps

### 1. Verify DSP Connectivity

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp ping
```

If this fails, check:
- SigmaStudio is running with project compiled ("Active: Downloaded")
- COM server is registered (64-bit RegAsm)
- ICP5 switches: IIC + USBi

### 2. Show Current DSP State

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp status
```

Confirm the target channel exists and has the expected PEQ band count.

### 3. Get the Test Signal Pattern

```bash
cd D:/Projects/Claude/theater && python -m tools.audio pattern sub_sweep
```

### 4. Initialize and Play Test Signal via Strudel

- Use `mcp__strudel__status` to check Strudel state
- Use `mcp__strudel__init` if needed
- Use `mcp__strudel__write` with the sub_sweep pattern, `auto_play: true`
- Verify playback started

### 5. Run Baseline Measurement (No EQ)

First bypass all PEQ on the target channel to measure the raw response:

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp bypass ${CHANNEL:-sub_main_L}
```

Wait 1s for DSP to settle, then capture and analyze:

```bash
cd D:/Projects/Claude/theater && python -m tools.audio test sub_sweep --delay 2
```

### 6. Compute Corrections (Offline First)

Use the measurement JSON to compute corrections without uploading:

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp compute tools/audio/output/<latest_measurement>.json --target-db -20 --bands 10
```

Review the computed filters. Verify:
- No extreme boosts (max +6 dB per plan)
- Q values are reasonable (0.5-10)
- Frequencies make sense for the channel

### 7. Run Autonomous Correction Loop

If the offline computation looks good, run the full closed-loop correction. This will iterate: measure -> compute -> upload -> re-measure until converged or max iterations reached.

**IMPORTANT:** Stop Strudel first (the correction loop manages its own test signals via the audio pipeline).

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp correct ${CHANNEL:-sub_main_L} --target-db -20 --profile sub_sweep
```

The loop will:
1. Measure current response (via REW autonomous sweep or MOTU loopback)
2. Compute error vs target curve
3. Generate corrective PEQ filters
4. Upload to DSP via SigmaStudio COM (safeload for glitch-free writes)
5. Re-measure and check convergence
6. Repeat until max error < tolerance (default 1.0 dB) or max iterations (default 5)

Use `--manual` flag to wait for user-triggered REW sweeps instead of auto-trigger.

### 8. Verify Final State

Read back the DSP coefficients to confirm they were written correctly:

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp verify ${CHANNEL:-sub_main_L}
```

### 9. Stop Strudel and Report Results

- Use `mcp__strudel__stop`
- Read the correction report JSON from `tools/dsp/output/`
- Summarize: converged?, iterations, final error, filters applied
- Show the before/after comparison if available

## Critical Technical Details

- **Communication:** PC → COM → SigmaStudio → USBi/ICP5 → ADAU1452 param RAM → live DSP
- **Safeload writes:** All PEQ coefficient updates use ADAU1452 safeload (registers 0x6000-0x6006) to prevent audio glitches. Target address is actual_address - 1 (hardware off-by-one).
- **Coefficient format:** ADAU1452 8.24 fixed-point. Order: [b0, b1, b2, -a1, -a2] — a1/a2 are NEGATED vs scipy convention.
- **COM signed ints:** Values ≥ 0x80000000 must be converted to signed (subtract 0x100000000) before passing to REGISTER_WRITE.
- **IC name:** Must be "IC 1" (matches SigmaStudio project IC name).
- **Gain limits:** Max boost +6 dB, max cut -15 dB. Excessive boost risks feedback and driver damage.
- **Convergence:** Typically 2-3 iterations for electronic loopback, 3-5 for acoustic measurements.

## Output Files

All outputs go to `tools/dsp/output/`:
- `correction_{channel}_{timestamp}.json` — full correction report with all iterations
- `eq_computed_{timestamp}.json` — offline-computed EQ (from `compute` command)

Audio captures go to `tools/audio/output/` as usual.

## Troubleshooting

- **Ping fails:** Check SigmaStudio running, COM registered, ICP5 connected (IIC + USBi)
- **Safeload write fails:** DSP may not have project loaded. Compile + Download in SigmaStudio
- **Corrections don't converge:** Increase max_iterations, widen tolerance, or reduce smoothing. Room modes below 20 Hz may be uncorrectable with PEQ alone
- **Coefficient overflow:** Filter gain too high. Reduce max_boost_db in config.json
- **No segment data:** Test signal not captured. Check MOTU routing, Strudel playback, capture duration
