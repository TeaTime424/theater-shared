---
description: Quick REW measurement — take a sweep, show frequency response at key points
allowed-tools: Bash, Read
---

# Quick REW Measurement

Take a standalone frequency response measurement via REW's REST API and display results. No DSP correction — just measure and report.

## Arguments
- `$ARGUMENTS` — optional: frequency range or preset
  - `sub` — 10-200 Hz, report at sub frequencies (default)
  - `full` — 20-20kHz, report at standard octave points
  - `<start>-<end>` — custom range (e.g., `30-120`)
  - If empty, default to `sub`

## Prerequisites

- REW 5.40+ running with API enabled (`-api` flag)
- Audio I/O configured in REW (mic input or loopback as appropriate)
- UMIK-1 connected if doing acoustic measurements

## Steps

### 1. Verify REW API

```bash
cd D:/Projects/Claude/theater && python -c "
import requests
r = requests.get('http://127.0.0.1:4735/version', timeout=3)
print(f'REW API: v{r.json()[\"version\"]}')
"
```

If this fails, REW is not running or API is not enabled.

### 2. Check Current Measurement Count

```bash
cd D:/Projects/Claude/theater && python -c "
from tools.dsp.rew import get_measurements
ms = get_measurements()
print(f'Existing measurements: {len(ms)}')
if ms:
    print(f'Latest: {ms[-1][\"title\"]} ({ms[-1][\"date\"]})')
"
```

### 3. Trigger Sweep

```bash
cd D:/Projects/Claude/theater && python -c "
from tools.dsp.rew import measure_sweep
print('Triggering sweep...')
m = measure_sweep()
print(f'Done: {m.title}')
"
```

If auto-sweep fails, instruct the user to manually trigger a sweep in REW and press Enter to continue.

### 4. Extract and Display Response

For **sub** range (default):
```bash
cd D:/Projects/Claude/theater && python -c "
from tools.dsp.rew import get_measurements, extract_at_frequencies
ms = get_measurements()
m = ms[-1]
freqs = [10, 15, 20, 25, 30, 35, 40, 50, 60, 80, 100, 120, 160, 200]
f_out, mags = extract_at_frequencies(m, freqs)
print(f'Measurement: {m[\"title\"]}')
print(f'{\"Freq\":>8s}  {\"Level\":>8s}')
print(f'{\"----\":>8s}  {\"-----\":>8s}')
for f, mag in zip(f_out, mags):
    print(f'{f:7.0f} Hz  {mag:+7.1f} dB')
avg = sum(mags) / len(mags)
spread = max(mags) - min(mags)
print(f'\nAverage: {avg:+.1f} dB | Spread: {spread:.1f} dB')
"
```

For **full** range:
```bash
cd D:/Projects/Claude/theater && python -c "
from tools.dsp.rew import get_measurements, extract_at_frequencies
ms = get_measurements()
m = ms[-1]
freqs = [20, 31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000, 16000, 20000]
f_out, mags = extract_at_frequencies(m, freqs)
print(f'Measurement: {m[\"title\"]}')
print(f'{\"Freq\":>8s}  {\"Level\":>8s}')
print(f'{\"----\":>8s}  {\"-----\":>8s}')
for f, mag in zip(f_out, mags):
    print(f'{f:7.0f} Hz  {mag:+7.1f} dB')
"
```

### 5. Report

- Show the frequency/level table
- Note the average level and spread (max - min)
- Flag any anomalies (nulls > 10 dB below average, peaks > 6 dB above)
- If spread > 12 dB, suggest EQ correction may be needed

## Troubleshooting

- **Sweep hangs**: Check REW audio I/O settings — input device must be active
- **SPL limit abort**: Disable `splLimitAbort` in REW generator settings (common with loopback)
- **No new measurement**: Poll `/measurements` count — sweep may still be in progress
- **API timeout**: REW may be busy processing. Wait 5s and retry once
