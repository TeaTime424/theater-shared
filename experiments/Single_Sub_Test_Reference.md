# Single Corner Subwoofer Test Reference

## Test Configuration
- **Cabinet:** 1× triangular corner column (2× UMII18-22)
- **Wiring:** Voice coils in series (4Ω/driver), drivers in series (8Ω total)
- **Amplifier:** 1 channel NX6000D @ 8Ω
- **Test Distance:** 1 meter, on-axis

---

## Boundary Loading During Testing

| Test Location | Boundary Gain | Notes |
|---------------|---------------|-------|
| Free field (outdoors) | +0 dB | Unrealistic for this size |
| Half-space (floor only) | +3 dB | Sub on floor, away from walls |
| **Quarter-space (floor + 1 wall)** | **+6 dB** | **Typical garage test** |
| Eighth-space (floor + 2 walls) | +9 dB | Corner without ceiling |
| Full corner (installed) | +12 dB | Theater installation |

**Important:** Your test measurements will be ~6dB lower than installed performance because you won't have full corner loading during bench testing.

---

## Expected SPL @ 1m (Quarter-Space Test Environment)

### Low Power Test (100W) - Safe for Extended Testing

| Freq | SPL @ 1m | Notes |
|------|----------|-------|
| 10Hz | 97 dB | Well below Fc, rolled off |
| 15Hz | 104 dB | Approaching Fc |
| 20Hz | 109 dB | −8 dB from passband |
| 30Hz | 114 dB | Near F3 point |
| 40Hz | 116 dB | Passband |
| 50Hz | 117 dB | Passband |
| 80Hz | 117 dB | Passband |

### Full Power Test (850W) - Brief Tests Only

| Freq | SPL @ 1m | Notes |
|------|----------|-------|
| 10Hz | 106 dB | Excursion-limited region |
| 15Hz | 113 dB | Approaching Fc |
| 20Hz | 118 dB | |
| 30Hz | 123 dB | LOUD! Hearing protection required |
| 40Hz | 125 dB | |
| 50Hz | 126 dB | |
| 80Hz | 126 dB | |

---

## What to Verify During Testing

### 1. Frequency Response Shape
- **Rolloff:** 12 dB/octave below Fc (~31Hz)
- **F3 point:** ~28-32 Hz
- **Passband:** Relatively flat 40-100Hz
- **No peaks/dips:** Smooth curve indicates good construction

### 2. SPL Verification
Compare measured SPL to table above (±3dB is acceptable given room variations)

### 3. Impedance Curve
- **DC resistance:** ~8.4Ω (4.2Ω × 2 drivers in series)
- **At 100Hz:** ~8-10Ω
- **At Fc (~31Hz):** Peak of 20-40Ω typical
- **Smooth curve:** No sharp anomalies

### 4. Physical Checks
- [ ] No air leaks (buzzing/whistling)
- [ ] No mechanical rattles
- [ ] Both drivers moving equally
- [ ] Symmetric excursion (no DC offset)
- [ ] Polarity correct (positive voltage → cone OUT)

### 5. Driver Matching
Test each driver individually if possible:
- Output should match within 1-2 dB
- Impedance curves should overlay

---

## Test vs Installed Performance

| Condition | 30Hz SPL @ 1m (850W) |
|-----------|---------------------|
| Garage test (quarter-space) | 123 dB |
| Installed (full corner) | 129 dB |
| **Difference** | **+6 dB** |

The +6dB gain when installed comes from the ceiling completing the corner boundary loading. This is expected and correct behavior.

---

## Quick Reference: Test Power Levels

| Test Power | Voltage (8Ω) | Use Case |
|------------|--------------|----------|
| 10W | 9 Vrms | Initial checkout, long tests |
| 50W | 20 Vrms | Response measurements |
| 100W | 28 Vrms | **Standard test power** |
| 250W | 45 Vrms | Higher level verification |
| 500W | 63 Vrms | Near-full power, brief only |
| 850W | 82 Vrms | Maximum, very brief only |

---

## Pass/Fail Criteria

### PASS if:
- [ ] SPL within ±3dB of expected at 40Hz
- [ ] Rolloff shape matches 12dB/octave below 30Hz
- [ ] No audible rattles, buzzes, or air leaks
- [ ] Impedance curve smooth with peak at ~31Hz
- [ ] Both drivers producing equal output

### FAIL if:
- [ ] SPL more than 5dB below expected (driver problem or air leak)
- [ ] SPL more than 3dB above expected (measurement error likely)
- [ ] Rattles or buzzes at any frequency
- [ ] Impedance anomalies (sharp dips = short, sharp peaks = open)
- [ ] Visible asymmetric excursion

---

*Test Reference Document - January 2025*
*Related: Main_Sub_SPL_Capability_Analysis.md*
