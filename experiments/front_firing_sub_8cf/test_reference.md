# Test Build Quick Reference Card

**Project:** 8 cu ft Front-Firing Subwoofer Verification Build  
**Purpose:** Validate drivers, alignment, and amplifier before $8,700+ investment

---

## The Build

- **2 sheets** 3/4" Baltic Birch plywood
- **2× UMII18-22** drivers ($700)
- **1× NX6000D** amplifier (with Noctua mod)
- External: 44" H × 23.5" W × 18.5" D
- Weight: ~195 lbs
- Volume: 7.95 cu ft → **~10.7 cu ft virtual** (with polyfill)

---

## The Timeline

| Week | Phase | Key Tasks |
|------|-------|-----------|
| 1-3 | **Construction** | Cut, assemble, finish cabinet |
| 4 | **Burn-In** | 100 hours continuous (20-80 Hz sweep) |
| 5 | **Testing** | REW measurements (empty + stuffed) |
| 6 | **Analysis** | Data review, go/no-go decision |

---

## What We're Testing

### ✅ Success = Proceed with 16-driver system

1. **Drivers:** Match Dayton specs? No mechanical issues?
2. **Alignment:** WinISD predictions accurate?
3. **Polyfill:** Actual multiplier = 1.2-1.4× ?
4. **Amp:** Real power @ 8Ω? ULF derating?
5. **SPL:** Can achieve 105+ dB @ 20 Hz?

### ⚠️ Issues = Modify design

### ❌ Major Problems = Abort/redesign

---

## Burn-In Protocol

**100 hours before testing:**
- 0-10 hrs: 30-80 Hz @ 40% power (gentle)
- 10-50 hrs: 20-80 Hz @ 60% power (normal)
- 50-100 hrs: 20-80 Hz @ 70% power (full flex)

**Check every 10 hours:** Visual inspection, temps, mechanical noises

---

## Key Measurements

### Configuration A: Empty Cabinet
1. Impedance sweep (verify 8Ω, find Fs)
2. Nearfield response (true driver output)
3. Ground plane @ 1m (anechoic-like)
4. SPL capability (max clean output)
5. Distortion (THD at 80/90/100/105 dB)

### Configuration B: With Polyfill
6. Repeat impedance (compare Fs shift)
7. Repeat nearfield (calculate virtual volume)
8. Repeat ground plane (new F3)
9. Corner loading (boundary gain)
10. Amp power verification (actual watts)

---

## Expected Results

| Parameter | Prediction | Target Measured |
|-----------|------------|-----------------|
| Fc (empty) | 39.4 Hz | 39 ± 2 Hz |
| Qtc (empty) | 0.95 | 0.90-1.00 |
| F3 (empty) | 31.8 Hz | 30-33 Hz |
| Polyfill multiplier | 1.35× | 1.2-1.4× |
| Virtual volume | 10.7 ft³ | 10-11 ft³ |
| Fc (stuffed) | 35.7 Hz | 34-37 Hz |
| Amp power @ 80 Hz | 850W | 600-800W |
| Amp power @ 20 Hz | ~600W | 500-700W |
| Max SPL @ 20 Hz | ~108 dB | 105+ dB |

---

## Power Calculation (from SPL)

```
Power = 2.83² × 10^((SPL - 90.7)/10)

Example:
SPL @ 1m = 105 dB
Power = 8 × 10^((105-90.7)/10) = 8 × 10^1.43 = ~215W
```

---

## Virtual Volume (from Fc shift)

```
Virtual = Physical × (Fc_empty / Fc_stuffed)²

Example:
Fc_empty = 39.4 Hz, Fc_stuffed = 35.7 Hz
Virtual = 7.95 × (39.4/35.7)² = 7.95 × 1.22 = 9.7 ft³
Multiplier = 9.7 / 7.95 = 1.22×
```

---

## Safety Limits

- **Never exceed 28mm Xmax** (visual check)
- **Hearing protection** above 100 dB
- **Stop if:** Mechanical noise, thermal shutdown, visible distortion
- **Cool down** between high-power runs

---

## Go/No-Go Decision Tree

```
All tests pass? ──────────────────► BUILD 16-DRIVER SYSTEM ✅
    │
    │ Minor issues?
    ▼
Adjustments needed? ──────────────► MODIFY & PROCEED ⚠️
    │
    │ Major problems?
    ▼
Fundamental issues? ──────────────► ABORT / REDESIGN ❌
```

---

## Files

All documentation in: `C:\Claude\HT\front_firing_sub_8cf\`

- `test_protocol.md` - Full test procedure (this summary references)
- `specifications.md` - Cabinet specs
- `cut_list.md` - Build instructions
- `build_guide.md` - Assembly steps
- `diagrams/` - Visual references

Save test results to: `test_results/`

---

**Investment Protected:** ~$8,700 (16× drivers + 6× amps)  
**Test Cost:** ~$1,200 (2× drivers + materials + 1× amp)  
**ROI:** Avoid expensive mistakes, validate assumptions, confidence to proceed

---

*Quick Reference v1.0 — Test Build Verification*
