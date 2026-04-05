---
description: ADAU1701 DSP calibration — measure via REW, compute corrective EQ, write to DSP via SigmaStudio COM, iterate until converged
allowed-tools: Bash, Read, Write, Edit
---

# DSP Calibration (ADAU1701 + REW + SigmaStudio COM)

Closed-loop measurement and auto-EQ for the Wondom APM2 (ADAU1701). REW 5.40+ API 0.9.0 enables fully autonomous operation — Python triggers sweeps, reads measurements, computes corrective PEQ, writes biquad coefficients to the DSP via SigmaStudio COM automation. No manual intervention needed.

## Arguments
- `$ARGUMENTS` — output channel to calibrate: `out_1`, `out_2`, `out_3`, `out_4`
  - If empty, default to `out_1`

## Prerequisites Checklist

Before running, verify ALL of these:

1. **SigmaStudio 4.7** running, project loaded, connected to APM2 via ICP5
   - Must show "Active: Downloaded"
   - ICP5 switches: **IIC** + **USBi**

2. **COM server registered** (one-time setup, requires admin):
   ```
   C:\Windows\Microsoft.NET\Framework64\v4.0.30319\RegAsm.exe "C:\Program Files\Analog Devices\SigmaStudio 4.7\Analog.SigmaStudioServer.dll" /codebase /tlb
   ```

3. **REW 5.40+ running with API enabled** — start with `-api` flag or enable in Preferences → API
   - API 0.9.0+ required for autonomous sweep triggering
   - Verify: `GET http://127.0.0.1:4735/version` should show `5.40` or later

4. **Parameter addresses** in `tools/dsp/config_1701.json` match your SigmaStudio project
   - Export via Action → Export System Files → parse `.params` file
   - Each PEQ block = 5 consecutive addresses (B0, B1, B2, A1, A2)

5. **Audio signal path** configured — REW can capture (loopback or mic)

## Step 1: Verify Connectivity

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp --config tools/dsp/config_1701.json ping
```

Expected: `Status: CONNECTED`. If failed:
- COM error → SigmaStudio not running or COM not registered
- Check `tasklist | grep -i SStudio` — must be running

```bash
cd D:/Projects/Claude/theater && python -c "from tools.dsp.rew import check_api; print('REW API:', 'OK' if check_api() else 'FAILED')"
```

Expected: `REW API: OK`. If failed:
- REW not running or API not enabled
- Start REW with: `"C:\Program Files\REW\roomeqwizard.exe" -api`

## Step 2: Show Configuration

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp --config tools/dsp/config_1701.json status
```

Confirm channel exists, PEQ addresses, and band count.

## Step 3: Check Current REW Measurements

```bash
cd D:/Projects/Claude/theater && python -c "
from tools.dsp.rew import get_measurements
for m in get_measurements():
    print(f'  [{m[\"index\"]}] {m[\"title\"]} ({m[\"date\"]})')
"
```

Note the count — the correction loop waits for NEW measurements after this point.

## Step 4: Bypass All PEQ (Flat Baseline)

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp --config tools/dsp/config_1701.json bypass ${CHANNEL:-out_1}
```

## Step 5: Baseline Measurement

Trigger an automatic sweep via the REW API:

```bash
cd D:/Projects/Claude/theater && python -c "
from tools.dsp.rew import measure_sweep, extract_at_frequencies
print('Triggering baseline sweep...')
m = measure_sweep(start_freq=10, end_freq=200)
print(f'Measurement: {m.title} ({m.date})')
freqs, mags = extract_at_frequencies(m, [20, 25, 30, 40, 50, 60, 80, 100, 120, 160, 200])
print('Baseline response:')
for f, mag in zip(freqs, mags):
    print(f'  {f:6.0f} Hz: {mag:+.1f} dB')
"
```

Use this to determine the target level — typically the average in the passband.

**Fallback (manual):** If auto-sweep fails, tell the user to run a sweep manually in REW, then use `get_latest_measurement()` instead.

## Step 6: Run Auto-Correction Loop

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp --config tools/dsp/config_1701.json correct ${CHANNEL:-out_1} --target-db TARGET --freq-range 20,200
```

Replace TARGET with the average level from Step 5 (e.g., `--target-db 85`).

The loop will:
1. Trigger a sweep via REW API automatically
2. Wait for measurement to complete
3. Read response, compute corrections
4. Write PEQ coefficients to DSP via COM
5. Trigger next sweep automatically
6. Repeat until converged or max iterations

Add `--manual` flag to require manual sweep triggers instead of auto-triggering.

## Step 7: Review Results

After convergence, check the report:

```bash
cd D:/Projects/Claude/theater && ls -t tools/dsp/output/correction_* | head -1 | xargs python -c "
import json, sys
r = json.load(open(sys.argv[1]))
print(f'Channel: {r[\"channel\"]}')
print(f'Converged: {r[\"converged\"]}')
print(f'Iterations: {r[\"total_iterations\"]}')
for f in r['final_filters']:
    print(f'  PEQ: {f[\"freq\"]:.0f}Hz {f[\"gain_db\"]:+.1f}dB Q={f[\"q\"]}')
"
```

## Step 8: Save to EEPROM (Manual)

Instruct the user:
1. In SigmaStudio: right-click ADAU1701 → "Write Latest Compilation to E2PROM"
2. **Bridge GND + WP pins** on APM2 header with screwdriver
3. Select I2C, click OK, click "Start Download"
4. **Hold screwdriver until progress bar reaches 100%**
5. Release. Power cycle to verify self-boot.

**Note:** EEPROM saves the SigmaStudio project state. If Python wrote coefficients via COM that SigmaStudio doesn't know about, they may not persist. The user may need to manually enter the final filter values into SigmaStudio's GUI before writing EEPROM.

## Quick Test (Proof of Life)

To verify the write path works without running the full loop:

```bash
cd D:/Projects/Claude/theater && python -c "
import win32com.client
server = win32com.client.Dispatch('Analog.SigmaStudioServer.SigmaStudioServer')
# Read param RAM address 0
val = server.REGISTER_READ('IC 1', 0, 4)
print(f'Param RAM addr 0: 0x{val & 0xFFFFFFFF:08X}')
print('COM connection working!')
"
```

To write a test notch and verify in REW:

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp --config tools/dsp/config_1701.json write-eq out_1 --freq 50 --gain -12 --q 2
```

Run a REW sweep — should see a -12dB dip at 50Hz. Then restore:

```bash
cd D:/Projects/Claude/theater && python -m tools.dsp --config tools/dsp/config_1701.json bypass out_1
```

## Technical Reference

- **Signal chain:** Python → COM → SigmaStudio → USBi/ICP5 → I2C → ADAU1701 param RAM
- **Coefficient format:** 5.23 fixed-point, biquad order [b0, b1, b2, -a1, -a2]
- **COM method:** `REGISTER_WRITE(IC_NAME, addr, 4, intValue)` — NOT REGISTER_WRITE_ARRAY
- **REW API:** v0.9.0 — 351 endpoints, full control (generator, sweep, measurements, RTA, EQ)
  - Spec saved: `tools/dsp/rew_api_spec.json`
  - Sweep: `POST /measure/command {"command": "SPL"}`
  - Generator: `POST /generator/command {"command": "Play"/"Stop"}`
  - Measurements: `GET /measurements/{id}/frequency-response`
- **Research docs:** `research/ADAU1701_PC_Calibration_System.md`, `research/ADAU1701_Windows_I2C_Bridge_Research.md`
