# ══════════════════════════════════════════════════════════════════════════════
# NEARFIELD SUBWOOFER PERFORMANCE ANALYSIS
# ══════════════════════════════════════════════════════════════════════════════
# 
# System: 8× Dayton UMII10-22 (4 per cabinet × 2 cabinets per couch)
# Distance: 18" (0.457 m) from cabinet to MLP
# Target: 95 dB SPL
#
# ══════════════════════════════════════════════════════════════════════════════

## DRIVER PARAMETERS (Dayton UMII10-22)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Sd | 345 cm² | Piston area per driver |
| Xmax | 20 mm | One-way linear excursion |
| Vd | 689 cm³ | Volume displacement |
| BL | 13.4 Tm | Force factor |
| Mms | 134 g | Moving mass |
| Re | 4.0 Ω | DC resistance (coils in series) |
| Fs | 39 Hz | Free-air resonance |
| Qts | 0.57 | Total Q |

## SYSTEM TOTALS

| Parameter | Value |
|-----------|-------|
| Total drivers | 8 |
| Total Sd | 2,760 cm² (0.276 m²) |
| Total Vd | 5,512 cm³ (5.51 L) |

## PERFORMANCE AT 95 dB TARGET (18" distance)

| Freq | Excursion | % Xmax | Status | LT Boost | Elec Power |
|------|-----------|--------|--------|----------|------------|
| 10 Hz | 2.45 mm | 12.3% | ✓ OK | +22.1 dB | 49 W |
| 15 Hz | 1.09 mm | 5.4% | ✓ OK | +17.0 dB | 15 W |
| 20 Hz | 0.61 mm | 3.1% | ✓ OK | +12.2 dB | 5 W |
| 25 Hz | 0.39 mm | 2.0% | ✓ OK | +8.2 dB | 2 W |
| 30 Hz | 0.27 mm | 1.4% | ✓ OK | +5.0 dB | <1 W |

## MAXIMUM SPL CAPABILITY (at Xmax = 20mm)

| Freq | Max SPL | Headroom above 95 dB |
|------|---------|---------------------|
| 10 Hz | 113.2 dB | +18.2 dB |
| 15 Hz | 120.3 dB | +25.3 dB |
| 20 Hz | 125.3 dB | +30.3 dB |
| 30 Hz | 132.3 dB | +37.3 dB |

## DRIVER WIRING

**Recommended: All 4 in series per cabinet**

```
Cabinet 1: D1 ─ D2 ─ D3 ─ D4 = 16Ω
Cabinet 2: D5 ─ D6 ─ D7 ─ D8 = 16Ω
                    │
               Parallel
                    │
            Total = 8Ω
```

Alternative (2s2p per cabinet):
- Per cabinet: (2×4Ω)/2 = 4Ω
- 2 cabinets parallel: 2Ω (too low)

## AMPLIFIER REQUIREMENTS

| Load | NX6000 Power | Status |
|------|--------------|--------|
| 8Ω (bridged) | 1,600 W | ✓ Adequate for 95 dB target |
| 4Ω (bridged) | 3,000 W | ✓ Plenty of headroom |

**For 95 dB @ 10 Hz:**
- Electrical power needed: ~49 W
- NX6000 @ 8Ω provides: 1,600 W
- Headroom: 15 dB (32× power reserve)

**For MAX output @ 10 Hz (113 dB at Xmax):**
- Electrical power needed: ~3,235 W
- NX6000 @ 4Ω provides: 3,000 W
- Slightly amp-limited at absolute maximum

## KEY FINDINGS

1. **95 dB @ 10 Hz is trivially easy**
   - Only 12.3% of Xmax used
   - Only 49W of electrical power needed
   - 18 dB of headroom to Xmax limit

2. **Massive output capability**
   - Can achieve 113 dB @ 10 Hz at Xmax
   - System is excursion-limited, not amp-limited for 95 dB target

3. **Nearfield physics work in our favor**
   - At 18" distance, SPL follows 1/r (not 1/r²)
   - Piston area (Sd) directly scales output
   - 8 drivers provide enormous Sd (2,760 cm²)

4. **Amplifier is adequate**
   - NX6000 bridged @ 8Ω handles 95 dB easily
   - Even bridged @ 4Ω (3000W) has headroom
   - For absolute max output, could use 2x channels (stereo mode)

## CONCLUSION

✓ **Target achieved with excellent margins**
✓ **95 dB @ 10 Hz uses only 12% of driver capability**  
✓ **18 dB headroom available above target**
✓ **NX6000 amplification is more than sufficient**
