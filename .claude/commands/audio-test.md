---
description: Run the audio test pipeline — Strudel generates test tones, WASAPI captures, FFT analyzes, matplotlib produces dashboard
allowed-tools: Bash, mcp__strudel__write, mcp__strudel__play, mcp__strudel__stop, mcp__strudel__init, mcp__strudel__status, Read
---

# Audio Test Pipeline

Run an end-to-end audio verification test using Strudel + WASAPI capture + FFT analysis.

## Arguments
- `$ARGUMENTS` — test profile name: `sub_sweep`, `full_sweep`, `single_tone`, `pink_noise`
  - If empty, default to `sub_sweep`

## Critical Details

- **Audio routes through MOTU M2**, not Realtek. Loopback device is `Out 1-2 (MOTU M Series) [Loopback]` (index 26)
- **Capture duration must be 2x the full cycle** — the pipeline computes this automatically from `n_tones * tone_duration_s * 2`. This guarantees every tone is captured in full regardless of when recording starts relative to the Strudel cycle
- **Sync-free analysis** — the analysis module uses sliding-window FFT to detect where each tone actually plays in the capture, finds the longest contiguous run per expected frequency, and trims 0.2s from edges. No need to sync capture start with Strudel cycle
- **Level measurement uses FFT peak magnitude** (window-normalized), NOT time-domain peak. Time-domain `np.max(np.abs())` has frequency-dependent sampling artifacts. FFT-based level gives consistent results across frequencies
- **Strudel pattern format** for flat test tones uses `freq().s("sine").sustain().gain().attack(0).decay(0).release(0).slow()` — zero envelope for instant on/off transitions

## Steps

1. **Get the Strudel pattern** for the requested profile:
   ```bash
   cd D:/Projects/Claude/theater && python -m tools.audio pattern ${PROFILE:-sub_sweep}
   ```

2. **Initialize Strudel** if not already running:
   - Use `mcp__strudel__status` to check
   - Use `mcp__strudel__init` if needed

3. **Write and play the pattern** in Strudel:
   - Use `mcp__strudel__write` with the pattern from step 1, set `auto_play: true`
   - Verify playback started

4. **Wait for Strudel to stabilize** (2s), then **run capture + analysis**:
   ```bash
   cd D:/Projects/Claude/theater && python -m tools.audio test ${PROFILE:-sub_sweep} --delay 2
   ```
   This will:
   - Wait 2s for audio to stabilize
   - Capture via MOTU WASAPI loopback for 2x the cycle length
   - Run sync-free tone extraction + per-segment FFT analysis
   - Compute frequency accuracy, THD, clipping, levels
   - Generate dashboard PNG + JSON results + WAV file

5. **Stop Strudel playback**:
   - Use `mcp__strudel__stop`

6. **Show results** to the user:
   - Read the dashboard PNG path from the output and display it
   - Summarize the verdict (PASS/WARN/FAIL)
   - Report the per-tone table: frequency error, level, THD
   - List the full paths to all output files

## Expected Results (Loopback Baseline)

For a digital loopback capture with no analog path:
- Frequency error: **0.0 Hz** on all tones
- Level: **flat** (identical dBFS across all frequencies)
- THD: **< 0.5%** on all tones
- Clipping: **none**
- Verdict: **PASS**

Any deviation from this baseline indicates a problem in the signal chain.

## Output Files
All outputs go to `tools/audio/output/`:
- `{profile}_{timestamp}.wav` — raw capture
- `{profile}_{timestamp}.json` — analysis results
- `{profile}_{timestamp}.png` — dashboard visualization (6-panel: waveform, spectrogram, freq accuracy, level curve, THD bars, summary)

## Troubleshooting

- **Capture hangs**: Audio is not routing through MOTU. Check Windows sound settings — default output must be MOTU M Series
- **Missing tones**: Capture too short. The pipeline auto-calculates 2x cycle but verify config.json `tone_duration_s` matches the Strudel pattern's `.slow()` value
- **Level variance across frequencies**: If using time-domain peak, switch to FFT-normalized measurement (already fixed in analysis.py)
- **High freq error / misdetection**: Tones too short for FFT resolution at low frequencies. Use >= 2s/tone for sub-bass (10-50 Hz)
