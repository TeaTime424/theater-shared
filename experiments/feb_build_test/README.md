# February 2025 Test Build - 8 cu ft Subwoofer

## Purpose

Validate UMII18-22 drivers, NX6000D amplifier, and sealed alignment modeling before committing to full 16-driver "Weapons-Grade Bass" system.

**Investment Protected:** ~$8,700 (16× drivers + 6× amps)  
**Test Build Cost:** ~$1,200 (2× drivers + materials + 1× amp)

---

## Files in This Directory

### Primary Build Document
- **8cf_subwoofer_cut_list_and_build.pdf** (11 pages)
  - Complete materials list
  - Detailed cut list with sheet layouts
  - Step-by-step build instructions
  - Wiring diagrams
  - Safety notes

### Additional Documentation
For complete test protocol and specifications, see:
- **Source Directory:** `C:\Claude\HT\front_firing_sub_8cf\`
  - `test_protocol.md` - Complete 100-hour burn-in and REW testing procedure
  - `test_reference.md` - Quick reference card
  - `specifications.md` - Cabinet specs and acoustic parameters
  - `cut_list.md` - Detailed panel dimensions
  - `build_guide.md` - Assembly instructions
  - `bracing_details.md` - Bracing system design
  - `diagrams/` - 14 PNG visual references

---

## Timeline: 6 Weeks Total

| Week | Phase | Key Activities |
|------|-------|----------------|
| 1-3 | **Construction** | Cut panels, laminate baffle, assemble cabinet, apply finish |
| 4 | **Burn-In** | 100 hours continuous (20-80 Hz sweep at increasing power levels) |
| 5 | **Testing** | REW measurements in empty and stuffed configurations |
| 6 | **Analysis** | Data comparison, go/no-go decision |

---

## Key Specifications

- **External:** 44.0" H × 23.5" W × 18.5" D
- **Weight:** ~195 lbs complete
- **Drivers:** 2× Dayton UMII18-22 (front-firing, vertical stack)
- **Baffle:** 1.5" thick (double-layer laminated)
- **Volume:** 7.95 cu ft → ~10.7 cu ft virtual (with polyfill)
- **Impedance:** 8Ω (both drivers in series)
- **F3:** ~22 Hz (in-room, corner placement)
- **Power Handling:** 2,400W RMS total (1,200W per driver)

---

## What We're Testing

### Success Criteria (✅ = Proceed with 16-driver system)

1. **Driver Performance**
   - T/S parameters match Dayton specs (±10%)
   - No mechanical noises or issues
   - Power handling meets or exceeds 1,200W RMS rating

2. **Sealed Alignment Modeling**
   - Fc within 5% of WinISD prediction (39.4 Hz)
   - Qtc within 0.1 of prediction (0.95)
   - Response shape matches modeled alignment

3. **Polyfill Effectiveness**
   - Virtual volume multiplier 1.2-1.4× achieved
   - Quantify actual vs theoretical effect
   - Optimize stuffing density

4. **NX6000D Amplifier**
   - Real-world power output @ 8Ω (expect 600-800W vs 850W claimed)
   - Document ultra-low frequency derating (10-20 Hz)
   - Thermal stability, fan noise after Noctua mod

5. **System Capability**
   - Achieves 105+ dB @ 20 Hz @ 1m with headroom
   - Clean output to Xmax limits (28mm)
   - Safe for scaled deployment

---

## Build Overview

### Materials Required

**Plywood:**
- 2× sheets 3/4" Baltic Birch (4' × 8')

**Drivers:**
- 2× Dayton Audio UMII18-22 @ $349.98 each = **$700**

**Hardware:**
- 16× 1/4-20 T-nuts, 16× 1/4-20 × 2" bolts (driver mounting)
- ~60× #8 × 2" screws, ~30× #8 × 1.5" screws
- 1× dual binding post terminal
- Silicone caulk, wood glue (Titebond III)

**Finish:**
- 1 quart ExoHyde or texture coating
- 2-3 lbs polyfill (polyester batting)

**Total Material Cost:** ~$500 (excluding drivers)

### Key Construction Notes

1. **Double-Layer Baffle:** Two 0.75" layers laminated = 1.5" total
   - Cut driver holes in BOTH layers BEFORE laminating
   - Install T-nuts from back after lamination
   - Provides rigidity for heavy 18" drivers

2. **3" Driver Recess:** Baffle mounts 4.5" from front edge
   - Creates protective pocket in front of cones
   - Aesthetic recessed appearance

3. **Enhanced Bracing:**
   - Cross-braces (interlocking) at 14" and 28" from bottom
   - Rib braces on sides and back
   - Corner braces (full height L-profiles)
   - Critical for front-firing configuration (no force cancellation)

4. **Series Wiring:** Both drivers in series = 8Ω cabinet
   - Per driver: Voice coils in series (2Ω + 2Ω = 4Ω)
   - Both drivers: Series (4Ω + 4Ω = 8Ω total)

---

## 100-Hour Burn-In Protocol

**Before any measurements:**

| Phase | Duration | Signal | Power Level |
|-------|----------|--------|-------------|
| Initial | 0-10 hrs | 30-80 Hz sweep | 40% (~300W) |
| Medium | 10-50 hrs | 20-80 Hz sweep | 60% (~500W) |
| Full | 50-100 hrs | 20-80 Hz sweep | 70% (~600W) |

**Check every 10 hours:**
- Visual driver inspection
- Temperature monitoring
- Listen for mechanical noises
- Cabinet integrity check

**After 100 hours:**
- Rest drivers 24 hours
- Ready for REW measurements

---

## Testing Overview

### Configuration A: Empty Cabinet

1. Impedance sweep (verify 8Ω, find Fs)
2. Nearfield response (true driver output)
3. Ground plane @ 1m (anechoic-like)
4. SPL capability (max clean output)
5. Distortion measurement (THD)

### Configuration B: With Polyfill

6. Repeat impedance (compare Fs shift)
7. Repeat nearfield (calculate virtual volume)
8. Repeat ground plane (new F3)
9. Corner loading verification
10. Amplifier power verification

### Expected Results

| Parameter | Prediction | Target Measured |
|-----------|------------|-----------------|
| Fc (empty) | 39.4 Hz | 39 ± 2 Hz |
| Qtc (empty) | 0.95 | 0.90-1.00 |
| F3 (empty) | 31.8 Hz | 30-33 Hz |
| Polyfill multiplier | 1.35× | 1.2-1.4× |
| Fc (stuffed) | 35.7 Hz | 34-37 Hz |
| Amp power @ 80 Hz | 850W | 600-800W |
| Amp power @ 20 Hz | ~600W | 500-700W |
| Max SPL @ 20 Hz | ~108 dB | 105+ dB |

---

## Go/No-Go Decision Framework

### ✅ **Proceed with Full System IF:**
- All measurements within acceptable tolerances
- No driver mechanical issues
- Amplifier delivers adequate power (even if derated)
- System achieves 105+ dB @ 20 Hz with headroom
- No thermal or reliability concerns

### ⚠️ **Modify Design IF:**
- Minor deviations from predictions (adjustable)
- Amplifier derating higher than expected (add more amps)
- Polyfill effect different than modeled (adjust stuffing)
- Need more/fewer drivers than planned

### ❌ **Abort/Redesign IF:**
- Driver fails or shows defects
- Massive deviation from modeling (>20%)
- Amplifier grossly underperforms or fails
- Excursion limits prevent target SPL
- Unacceptable mechanical noises
- Safety concerns identified

---

## Equipment Needed for Testing

### Measurement Equipment
- UMIK-1 or UMIK-2 calibrated measurement microphone
- Mic stand (sturdy, adjustable)
- SPL meter (verification)
- Measuring tape (accurate to 1/4")

### Software
- REW (Room EQ Wizard) - latest version
- UMIK calibration file loaded

### Test Environment
- Quiet room (minimize background noise)
- Large space or outdoor area (ground plane measurements)
- Room corner (boundary gain verification)

---

## Safety Notes

### Hearing Protection
- Wear earplugs when testing > 100 dB
- Never exceed 110 dB SPL in test environment
- Rest ears between high-SPL tests

### Driver Protection
- Monitor excursion visually during tests
- STOP if mechanical noises occur
- Never exceed visible Xmax (28mm)
- Allow cooling between high-power runs

### Electrical Safety
- Use dedicated 15A or 20A circuit
- Don't daisy-chain power strips
- Verify connections before power-on

---

## Quick Reference Formulas

### Power from SPL
```
Power (W) = 2.83² × 10^((SPL - 90.7)/10)

Example: SPL @ 1m = 105 dB
Power = 8 × 10^1.43 = ~215W
```

### Virtual Volume from Fc Shift
```
Virtual = Physical × (Fc_empty / Fc_stuffed)²

Example: Fc_empty = 39.4 Hz, Fc_stuffed = 35.7 Hz
Virtual = 7.95 × (39.4/35.7)² = 9.7 ft³
Multiplier = 1.22×
```

---

## File Organization

### Test Results Directory
Create: `C:\Claude\HT\front_firing_sub_8cf\test_results\`

**Subdirectories:**
- `photos/` - Construction progress, completed cabinet, test setup
- `rew_measurements/` - All MDAT files, screenshots
- `burn_in_log.md` - Hour-by-hour log
- `test_report.md` - Final analysis
- `recommendations.md` - Go/no-go decision documentation

---

## Return on Investment

**This $1,200 test build protects an $8,700+ investment by:**

1. Validating driver performance before ordering 14 more
2. Confirming sealed box modeling accuracy
3. Documenting actual amplifier behavior at ULF
4. Quantifying polyfill effectiveness
5. Identifying any issues BEFORE full-scale deployment

**Potential savings:** Entire $8,700 if fundamental issues discovered  
**Confidence gained:** Proceed with validated assumptions  
**Risk mitigated:** No expensive surprises in full system

---

**Document Created:** January 2025  
**Status:** Ready for construction  
**Next Action:** Order materials
- 2× sheets 3/4" Baltic Birch plywood
- 2× Dayton UMII18-22 drivers ($700)
- Hardware and finish supplies (~$100)

**For detailed build instructions, see: 8cf_subwoofer_cut_list_and_build.pdf**
