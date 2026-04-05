# ADAU1701 PC-Based Calibration System

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-04
**Revision:** 1.1
**Related:** `research/Wondom_APM2_DSP_Reference.md`, `research/ADAU1452_Signal_Chain_Design.md`

---

## Executive Summary

A self-contained measurement and auto-EQ system using hardware already on hand: Wondom APM2 (ADAU1701), ICP5 programmer, and UMIK-1 calibration microphone — all connected to a Windows PC. No Raspberry Pi required.

**Workflow:** Play test signal → UMIK-1 captures room response → Python computes corrective EQ → writes biquad coefficients to ADAU1701 via I2C bridge → re-measure to verify → save to EEPROM → DSP runs standalone forever.

> **CORRECTION (Rev 1.1):** The original assumption that SigmaStudio exposes a TCP server on port 8086 was **wrong**. SigmaStudio is a TCP **client**, not a server. It connects to an external `sigma_tcp` server that relays commands to the DSP via I2C. The transport layer must be redesigned — see Section 2.1 for the corrected architecture and options.

---

## 1. Hardware You Have

| Item | Model | Role | Connection |
|------|-------|------|------------|
| **DSP board** | Wondom APM2 (ADAU1701) | 2-in/4-out DSP with built-in ADC/DAC | I2C via ICP5 |
| **Programmer** | Wondom ICP5 | USB-to-I2C bridge for SigmaStudio | USB to PC |
| **Measurement mic** | miniDSP UMIK-1 | USB calibration microphone | USB to PC |
| **Audio interface** | MOTU M2 | Line-level output (plays test tones) | USB to PC |
| **PC** | Windows | Runs SigmaStudio + Python tools | — |

### Physical Connections

```
Windows PC
  ├─ USB → ICP5 programmer
  │           └─ I2C ribbon cable → Wondom APM2 (ADAU1701)
  ├─ USB → UMIK-1 microphone (captures room response)
  ├─ USB → MOTU M2 (plays test tones through speakers)
  └─ Strudel MCP (generates test signals)

Wondom APM2
  ├─ RCA IN 1 (L) ← from Marantz AV10 sub output (or test signal source)
  ├─ RCA IN 2 (R) ← from Marantz AV10 sub output
  ├─ RCA OUT 1 → amp/speaker under test
  ├─ RCA OUT 2 → amp/speaker under test
  ├─ RCA OUT 3 → amp/speaker under test
  └─ RCA OUT 4 → amp/speaker under test
```

---

## 2. System Architecture

```
┌──────────────────────────────────────────────────────────────┐
│  Windows PC                                                   │
│                                                               │
│  ┌──────────────┐   ┌────────────────┐   ┌───────────────┐  │
│  │  Strudel MCP  │   │  UMIK-1 mic    │   │ tools/audio/  │  │
│  │  (test tones) │   │  (USB capture) │──▶│  FFT analyze  │  │
│  └──────┬───────┘   └────────────────┘   └───────┬───────┘  │
│         │                                         │           │
│         │ plays through speakers                  │ measured  │
│         │                                         │ response  │
│         │                                         ▼           │
│         │                                 ┌───────────────┐  │
│         │                                 │ tools/dsp/    │  │
│         │                                 │  umik.py      │  │
│         │                                 │  (apply cal)  │  │
│         │                                 │  eq.py        │  │
│         │                                 │  (compute EQ) │  │
│         │                                 │  coeffs.py    │  │
│         │                                 │  (5.23 fmt)   │  │
│         │                                 └───────┬───────┘  │
│         │                                         │           │
│         │                              TCP :8086  │ biquad    │
│         │                                         │ coeffs    │
│         │                                         ▼           │
│         │                              ┌──────────────────┐  │
│         │                              │  SigmaStudio     │  │
│         │                              │  (TCP bridge)    │  │
│         │                              └────────┬─────────┘  │
│         │                                       │ USB         │
└─────────┼───────────────────────────────────────┼────────────┘
          │                                       │
          ▼                                       ▼
    ┌──────────┐                          ┌──────────────┐
    │  MOTU M2  │                          │  ICP5        │
    │  (output) │                          │  (USB→I2C)   │
    └────┬─────┘                          └──────┬───────┘
         │ analog                                │ I2C
         ▼                                       ▼
    ┌──────────┐                          ┌──────────────┐
    │  Speaker  │◄── analog ──────────────│  Wondom APM2 │
    │  / Sub    │    (from DSP out)       │  ADAU1701    │
    └──────────┘                          │  2-in/4-out  │
         │                                └──────────────┘
         │ sound waves
         ▼
    ┌──────────┐
    │  UMIK-1   │ (captures at listening position)
    └──────────┘
```

---

## 2.1 CORRECTION: TCP Architecture (Rev 1.1)

The original architecture assumed SigmaStudio listens on TCP port 8086. **This is incorrect.**

### What We Assumed (WRONG)
```
Python client → TCP:8086 → SigmaStudio (server) → USBi → I2C → ADAU1701
```

### How It Actually Works
```
SigmaStudio (client) → TCP:8086 → sigma_tcp server → I2C → ADAU1701
```

SigmaStudio's TCPIP1701 communication channel is a **client** that replaces the USBi with a TCP connection to an external server. The server (`sigma_tcp`) must be running on a device with direct I2C access to the ADAU1701.

### Verified Facts
- `SStudio.exe` opens **zero TCP listening ports** (confirmed via `netstat -ano`)
- SigmaStudio 4.7 with USBi connected and "Active: Downloaded" — no port 8086
- The TCPIP1701 channel in SigmaStudio's Hardware Configuration is for connecting TO a server, not hosting one

### Revised Options for Python → ADAU1701 Communication

| Option | How | Cost | Complexity | Status |
|--------|-----|------|-----------|--------|
| **0. COM automation** | Python `win32com` → SigmaStudio → USBi → I2C | $0 | Low | **VERIFIED WORKING** |
| **1. FTDI FT232H** | USB-to-I2C adapter, Python `pyftdi` writes directly | ~$15 | Low | Not tested |
| **2. sigma_tcp on PC** | Run server on PC with I2C adapter, Python connects via TCP | ~$15 + setup | Medium | Not tested |
| **3. ESP32 bridge** | ESP32 runs sigma_tcp, I2C to DSP, WiFi/serial to PC | ~$8 | Medium | Not tested |
| **4. Raspberry Pi** | Pi runs sigmadsp, SPI/I2C to DSP, gRPC to PC | ~$92 | Higher | Not tested |

**Winner:** Option 0 (COM automation). Zero cost, zero extra hardware, verified end-to-end with REW measurement confirming DSP coefficient writes. See `research/ADAU1701_Windows_I2C_Bridge_Research.md` for details on all options.

### Updated Architecture Diagram (Option 2)
```
┌────────────────────────────────────────────────────────────────┐
│  Windows PC                                                      │
│                                                                  │
│  ┌──────────────┐    ┌──────────────┐    ┌─────────────────┐   │
│  │ SigmaStudio  │    │ Python tools │    │  sigma_tcp      │   │
│  │ (TCP client) │──┐ │ (TCP client) │──┐ │  server         │   │
│  └──────────────┘  │ └──────────────┘  │ │  (localhost)    │   │
│                    │                    │ │                 │   │
│                    └── TCP :8086 ──────┴▶│  port 8086      │   │
│                                          │                 │   │
│                                          └────────┬────────┘   │
│                                                   │ I2C via    │
│                                                   │ FT232H USB │
└───────────────────────────────────────────────────┼────────────┘
                                                    │
                                                    ▼
                                            ┌──────────────┐
                                            │  FTDI FT232H │
                                            │  (USB→I2C)   │
                                            └──────┬───────┘
                                                   │ I2C
                                                   ▼
                                            ┌──────────────┐
                                            │  Wondom APM2 │
                                            │  ADAU1701    │
                                            └──────────────┘
```

**Note:** The ICP5/USBi is still used for the initial SigmaStudio project compile & download. The FT232H provides a second I2C path for runtime parameter writes. Both can coexist on the same I2C bus (different masters, but only one active at a time).

---

## 3. SigmaStudio Project Topology

### 3.1 What to Build in SigmaStudio

Open SigmaStudio, create new project, add ADAU1701 hardware, then build this signal flow:

```
┌────────────────────────────────────────────────────────────────────────┐
│  SigmaStudio Project: "HT_Calibration_1701"                           │
│                                                                        │
│  ┌─────────┐                                                           │
│  │ Input 0 │──┐                                                        │
│  │  (L)    │  │   ┌─────────┐                                          │
│  └─────────┘  ├──▶│  Mixer  │                                          │
│  ┌─────────┐  │   │  2×4    │                                          │
│  │ Input 1 │──┘   │         │                                          │
│  │  (R)    │      └────┬────┘                                          │
│  └─────────┘           │                                               │
│                        ├──── Ch1 ──▶ [HPF] ▶ [PEQ×5] ▶ [Gain] ▶ OUT0  │
│                        ├──── Ch2 ──▶ [HPF] ▶ [PEQ×5] ▶ [Gain] ▶ OUT1  │
│                        ├──── Ch3 ──▶ [HPF] ▶ [LPF] ▶ [PEQ×5] ▶ [Gain] ▶ OUT2  │
│                        └──── Ch4 ──▶ [HPF] ▶ [LPF] ▶ [PEQ×5] ▶ [Gain] ▶ OUT3  │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Block-by-Block Setup

#### Input Stage
- Drag **Input** blocks for ADC Channel 0 and Channel 1
- These are the built-in ADCs on the APM2 board

#### Mixer (2×4)
- Drag a **Crossbar Mixer** (2 inputs, 4 outputs)
- This routes either/both inputs to any combination of outputs
- Default: Input 0 → all outputs (mono sub signal)

#### Per-Output Processing Chain (repeat for each of 4 outputs)

**Use these exact SigmaStudio block names** so the parameter addresses are easy to find:

| Block | SigmaStudio Type | Name Convention | Purpose |
|-------|-----------------|-----------------|---------|
| HPF | General (2nd Order) → High Pass | `HPF_Out1` | Subsonic protection (5Hz) |
| LPF | General (2nd Order) → Low Pass | `LPF_Out1` | Crossover (80Hz) — outputs 3-4 only |
| PEQ Band 1 | General (2nd Order) → Parametric EQ | `PEQ1_Out1` | Room correction |
| PEQ Band 2 | General (2nd Order) → Parametric EQ | `PEQ2_Out1` | Room correction |
| PEQ Band 3 | General (2nd Order) → Parametric EQ | `PEQ3_Out1` | Room correction |
| PEQ Band 4 | General (2nd Order) → Parametric EQ | `PEQ4_Out1` | Room correction |
| PEQ Band 5 | General (2nd Order) → Parametric EQ | `PEQ5_Out1` | Room correction |
| Gain | Single slew ext vol | `Gain_Out1` | Level trim |

#### Output Stage
- Drag **Output** blocks for DAC Channels 0-3
- Connect gain blocks to corresponding outputs

### 3.3 Instruction Budget

| Block | Instructions | ×4 outputs | Total |
|-------|-------------|-----------|-------|
| HPF (2nd order) | 6 | 4 | 24 |
| LPF (2nd order) | 6 | 2 (only Out3/4) | 12 |
| PEQ (2nd order) | 6 | 20 (5 per output) | 120 |
| Gain | 2 | 4 | 8 |
| Mixer (2×4) | 8 | 1 | 8 |
| I/O | 0 | — | 0 |
| **Total** | | | **172 / 1024 (17%)** |

Massive headroom. Could add delay (but costs 48 instructions per ms at 48kHz) or more PEQ bands if needed.

### 3.4 Initial Filter Settings

Set these defaults in SigmaStudio before the first compile:

| Block | Setting | Why |
|-------|---------|-----|
| All HPF | 5Hz, Butterworth | Subsonic protection — inaudible but protects drivers |
| LPF (Out 3-4) | 80Hz, Butterworth | Sub/tactile crossover |
| All PEQ | Flat (0 dB gain) | Start neutral — auto-calibration will set these |
| All Gain | 0 dB (unity) | Start at full level |
| Mixer | Input 0 → all outputs at 0 dB | Mono sub routing |

### 3.5 Exporting the Parameter Address Map

**This is the critical step.** After building and compiling the project:

1. In SigmaStudio: **Action → Export System Files**
2. Save to `POR/SigmaStudio/` in the project
3. Open the `.params` file — it lists every parameter cell with its RAM address
4. Find the addresses for each PEQ, HPF, LPF, and Gain block
5. Update `tools/dsp/config_1701.json` with the actual addresses

Example `.params` file content:
```
Cell Name             = PEQ1_Out1
Parameter Name        = B0
Parameter Address     = 0
Parameter Value       = 0x00800000    (1.0 in 5.23 = unity b0)
Parameter Data :
0x00 , 0x80 , 0x00 , 0x00 ,

Cell Name             = PEQ1_Out1
Parameter Name        = B1
Parameter Address     = 1
...
```

Each biquad filter occupies 5 consecutive addresses: B0, B1, B2, A1, A2.
The `.params` file gives you the starting address. Put that address into `config_1701.json` as the `peq_base_addr` for the corresponding channel.

---

## 4. ICP5 Switch Settings (Reference)

From `research/Wondom_APM2_DSP_Reference.md`:

| Switch | Position | Why |
|--------|----------|-----|
| **SW4** | IIC | ADAU1701 uses I2C protocol |
| **SW** | PROGRAM | Programming mode (not run mode) |

### EEPROM Write Procedure

1. Complete Live Programming first (Link Compile Download)
2. **Bridge GND + WP pins** with screwdriver on APM2 header
3. Right-click ADAU1701 → "Write Latest Compilation to E2PROM"
4. Select I2C protocol, click OK, click "Start Download"
5. **Hold screwdriver until progress bar reaches 100%**
6. Release screwdriver
7. Verify: unplug everything, reconnect power, DSP should self-boot with saved config

---

## 5. Measurement Workflow

### 5.1 Calibration Session Setup

```
Step 1: Physical Setup
  - Wondom APM2 connected to amp + speaker/sub under test
  - APM2 connected to ICP5 via ribbon cable
  - ICP5 connected to PC via USB
  - UMIK-1 at listening position, connected to PC via USB
  - MOTU M2 connected to PC (for test signal output if not using DSP input)

Step 2: Software Setup
  - SigmaStudio open, project loaded, connected to hardware
  - SigmaStudio shows "Active: Compiled" (TCP server is active)
  - UMIK-1 calibration file path set in config_1701.json
```

### 5.2 Automated Calibration Cycle

```
┌─────────────────────────────────────────────────────────────┐
│  CALIBRATION LOOP                                            │
│                                                              │
│  1. BYPASS ──── Set all PEQ bands to unity (flat)            │
│       │                                                      │
│  2. PLAY ───── Generate test signal (swept sine or noise)    │
│       │         via Strudel or direct from MOTU M2           │
│       │                                                      │
│  3. CAPTURE ── UMIK-1 records room response                  │
│       │         via WASAPI (physical input, not loopback)     │
│       │                                                      │
│  4. ANALYZE ── tools/audio/ FFT analysis                     │
│       │         + UMIK-1 calibration correction               │
│       │                                                      │
│  5. COMPUTE ── tools/dsp/eq.py finds deviations from target  │
│       │         Generates corrective PEQ filters              │
│       │                                                      │
│  6. UPLOAD ─── tools/dsp/client_1701.py writes coefficients  │
│       │         via TCP → SigmaStudio → I2C → ADAU1701       │
│       │                                                      │
│  7. VERIFY ─── Re-measure with corrections applied           │
│       │         Compare before/after                          │
│       │                                                      │
│  8. CONVERGED? ── Max error < tolerance?                     │
│       │    YES → Save to EEPROM, done                        │
│       │    NO  → Go to step 5 (refine corrections)           │
│       │                                                      │
│  9. SAVE ───── Write to EEPROM via SigmaStudio               │
│                Unplug USBi. DSP runs standalone.              │
└─────────────────────────────────────────────────────────────┘
```

### 5.3 Measurement Details

**Test signal options:**

| Method | Signal | Pros | Cons |
|--------|--------|------|------|
| **Strudel tone sweep** | Discrete sine tones (10-50Hz) | Precise per-frequency data, proven pipeline | Slow (18s+ for sub sweep) |
| **REW sweep** | Log-swept sine | Very fast, high resolution | Needs REW integration |
| **Pink noise** | Broadband noise | Natural, averaged response | Less precise per-frequency |

**Recommended:** Start with Strudel tone sweep (sub_sweep profile) — it's already built and tested. The `tools/audio/` pipeline handles the capture and analysis automatically.

**Capture source:** UMIK-1 is a USB mic. In the audio config, set the capture device to the UMIK-1 instead of the MOTU loopback:

```json
// tools/audio/config.json — add UMIK-1 device
"devices": {
  "loopback": {"match_name": "MOTU", "description": "WASAPI loopback (digital)"},
  "motu": {"match_name": "MOTU M2", "description": "Physical input"},
  "umik": {"match_name": "UMIK", "description": "UMIK-1 measurement mic (physical)"}
}
```

Then capture with: `python -m tools.audio test sub_sweep --source umik`

---

## 6. UMIK-1 Calibration Integration

### 6.1 Calibration File

The UMIK-1 ships with a per-unit calibration file (download from miniDSP). It's a text file with frequency/correction pairs:

```
"Sens Factor =-23.4dB, DBFS"
"Frequency(Hz)" "SPL(dB)"
20.00   -0.87
20.50   -0.84
21.00   -0.80
...
20000.00  0.15
```

**Place this file at:** `tools/dsp/umik_cal.txt` (or wherever — set the path in `config_1701.json`)

### 6.2 How Correction Works

The correction values are **additive**:

```
corrected_level = measured_level + calibration_correction
```

The `tools/dsp/umik.py` module handles this:
1. Loads the calibration file
2. Interpolates corrections at measurement frequencies (log-frequency)
3. Adds corrections to raw measured levels
4. Returns corrected measurements to the EQ computation engine

### 6.3 Why It Matters

Without calibration, the UMIK-1's response rolls off at low frequencies. A raw measurement might show a -3 dB dip at 20Hz that's actually the mic, not the room. The calibration file corrects for this, so the EQ engine computes corrections for the room/speaker, not the microphone.

---

## 7. Software Components

### 7.1 Existing (Already Built)

| Module | File | What it does |
|--------|------|-------------|
| Audio capture | `tools/audio/capture.py` | WASAPI recording (loopback or physical input) |
| FFT analysis | `tools/audio/analysis.py` | Sync-free tone detection, per-frequency levels |
| Dashboard plots | `tools/audio/plots.py` | 6-panel analysis + before/after comparison |
| Biquad math | `tools/dsp/coefficients.py` | PEQ/HPF/LPF computation, 5.23 + 8.24 conversion |
| EQ engine | `tools/dsp/eq.py` | Response smoothing, deviation detection, correction loop |
| CLI | `tools/dsp/runner.py` | Subcommands: status, bypass, write-eq, compute, correct |

### 7.2 New for 1701 (Built in This Session)

| Module | File | What it does |
|--------|------|-------------|
| TCP client | `tools/dsp/client_1701.py` | TCPIP1701 protocol client for SigmaStudio TCP bridge |
| UMIK-1 parser | `tools/dsp/umik.py` | Calibration file loading and measurement correction |
| 1701 config | `tools/dsp/config_1701.json` | Channel addresses, correction limits, UMIK path |
| 1701 coefficients | `tools/dsp/coefficients.py` | `to_adau1701()` / `from_adau1701()` — 5.23 format |
| Calibrate skill | `.claude/commands/dsp-calibrate.md` | Claude Code skill for the full workflow |

### 7.3 CLI Usage (1701 Mode)

```bash
# Use the 1701 config file
export DSP_CONFIG=tools/dsp/config_1701.json

# Check SigmaStudio TCP connectivity
python -m tools.dsp --config tools/dsp/config_1701.json ping

# Show channel config
python -m tools.dsp --config tools/dsp/config_1701.json status

# Bypass all PEQ (flat response)
python -m tools.dsp --config tools/dsp/config_1701.json bypass out_1

# Write a test PEQ filter
python -m tools.dsp --config tools/dsp/config_1701.json write-eq out_1 --freq 40 --gain 6 --q 2

# Compute corrections from a measurement (offline)
python -m tools.dsp compute tools/audio/output/sub_sweep_20260303.json --target-db -20

# Run auto-correction loop
python -m tools.dsp correct out_1 --target-db -20 --config tools/dsp/config_1701.json
```

---

## 8. Differences: 1701 vs 1452 Path

| Aspect | ADAU1701 (PC + USBi) | ADAU1452 (PC + Pi) |
|--------|---------------------|-------------------|
| **Transport** | TCP → SigmaStudio → I2C | gRPC → Pi → SPI |
| **Fixed-point** | 5.23 (28-bit, scale 2^23) | 8.24 (32-bit, scale 2^24) |
| **Safeload** | Not available (writes are direct) | Available (glitch-free) |
| **Remote** | No — need SigmaStudio running | Yes — Pi runs 24/7 |
| **Channels** | 2-in / 4-out | 4-in / 8-out (with CS42448) |
| **PEQ bands** | ~5 per output (instruction limited) | 10 per output |
| **Max sample rate** | 48 kHz | 192 kHz |
| **Calibrate once** | Yes — save to EEPROM | Yes, or adjust remotely anytime |
| **Cost** | ~$60 (board + programmer) | ~$250 (board + Pi + programmer) |

**Key point:** The biquad math, EQ engine, correction algorithm, and measurement pipeline are **identical**. Only the transport layer and coefficient scale factor change. Everything learned on the 1701 transfers directly to the 1452.

---

## 9. Use Cases for the 1701

The 2-in/4-out ADAU1701 is perfect for:

### 9.1 Tactile Transducer Processor
```
Input:  1× mono sub signal from Marantz AV10
Output: 2× stereo tactile zones (L/R)
Filter: HPF 10Hz → BPF 10-80Hz → PEQ × 5 → Gain

This is the #1 use case. The DSP-408 can't do 10Hz HPF.
The 1701 can. Configure once, save to EEPROM, done.
```

### 9.2 Nearfield Subwoofer Processor (Partial)
```
Input:  1× mono sub signal
Output: 2× nearfield L/R (front or rear pair)
Filter: HPF 5Hz → LPF 80Hz → PEQ × 5 → Gain

Handles one stereo pair of nearfield subs.
Need a second 1701 board for the other pair.
```

### 9.3 Learning / Validation Platform
```
Input:  1× test signal (from MOTU M2 or any source)
Output: 1× to speaker under test
Filter: Anything — test HPF/LPF/PEQ designs before moving to 1452

Prove the entire auto-calibration pipeline works.
Verify biquad math against SigmaStudio's own calculations.
Build confidence before buying the 1452 board.
```

---

## 10. Step-by-Step: First Calibration Run

### Prerequisites
- [ ] SigmaStudio installed (free from Analog Devices)
- [ ] SigmaStudio project built (Section 3 topology)
- [ ] Project compiled and downloaded to ADAU1701 via ICP5
- [ ] Parameter addresses exported and entered in `config_1701.json`
- [ ] UMIK-1 calibration file placed and path set in config
- [ ] UMIK-1 device name added to `tools/audio/config.json`
- [ ] Speaker/sub connected to DSP output and powered on
- [ ] UMIK-1 placed at listening position

### Run

```bash
# 1. Verify SigmaStudio TCP connection
python -m tools.dsp --config tools/dsp/config_1701.json ping

# 2. Bypass all PEQ (measure raw response first)
python -m tools.dsp --config tools/dsp/config_1701.json bypass out_1

# 3. Play test signal via Strudel
# (use /audio-test sub_sweep or manually play)

# 4. Capture via UMIK-1
python -m tools.audio test sub_sweep --source umik --delay 3

# 5. Compute corrections
python -m tools.dsp compute tools/audio/output/<latest>.json \
    --target-db -20 --config tools/dsp/config_1701.json

# 6. Review computed filters, then run full correction loop
python -m tools.dsp --config tools/dsp/config_1701.json correct out_1 \
    --target-db -20 --profile sub_sweep

# 7. Save to EEPROM (in SigmaStudio: right-click → Write to E2PROM)
# Bridge GND+WP pins with screwdriver during write!

# 8. Verify self-boot
# Unplug ICP5, power cycle APM2, confirm DSP processes audio correctly
```

---

## 11. Cost Summary

| Item | Have it? | Cost |
|------|----------|------|
| Wondom APM2 (ADAU1701) | Yes | $25 |
| ICP5 programmer | Yes | $35 |
| UMIK-1 calibration mic | Yes | $90 |
| MOTU M2 | Yes | (existing) |
| Windows PC | Yes | (existing) |
| SigmaStudio | — | Free |
| Python tools | — | Built |
| **Additional cost** | | **$0** |

Everything is already in hand. The only work is building the SigmaStudio project, exporting the parameter addresses, and running the calibration.

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-03 | Initial system topology and workflow |
| 1.1 | 2026-03-04 | CORRECTION: SigmaStudio is TCP client, not server. Added Section 2.1 with revised transport options. Fixed CLI `--config` flag order. |
