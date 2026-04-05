# 8 cu ft Front-Firing Subwoofer - Test & Verification Protocol

**Purpose:** Validate UMII18-22 driver performance, sealed alignment modeling, and Behringer NX6000D amplifier behavior before committing to full 16-driver system

**Investment at Risk:** ~$8,700 (16× drivers + 6× amps)  
**Test Build Cost:** ~$1,200 (2× drivers + materials + 1× amp)

**Document Version:** 1.0  
**Created:** January 2025

---

## Test Objectives

### Primary Validation Goals

| Component | What We're Testing | Success Criteria |
|-----------|-------------------|------------------|
| **UMII18-22 Drivers** | T/S parameters, Xmax, power handling | Match Dayton specs, no mechanical issues |
| **Sealed Alignment** | Fc, Qtc, F3 response | Match WinISD predictions ±5% |
| **Polyfill Effect** | Virtual volume multiplier | Quantify actual vs theoretical (1.2-1.4×) |
| **NX6000D Amplifier** | Real power @ 8Ω, ULF derating | Document actual output vs spec |
| **Thermal Behavior** | Driver/amp heat under load | No thermal shutdown, fan noise acceptable |
| **Excursion Limits** | Visual Xmax verification | Safe operation at rated power |

### Questions to Answer

1. Do UMII18-22 drivers perform as specified in real enclosure?
2. Does sealed box modeling accurately predict response?
3. What is actual polyfill volume multiplier for our stuffing density?
4. What power does NX6000D actually deliver at 8Ω (vs 850W claim)?
5. How much does NX6000D derate at 10-20 Hz?
6. Can system safely achieve 105+ dB @ 20 Hz?
7. Are there any mechanical noises or issues under power?

---

## Phase 1: Cabinet Construction

### Materials Required

**Plywood:**
- 2× sheets 3/4" Baltic Birch (4' × 8')

**Drivers:**
- 2× Dayton Audio UMII18-22 ($349.98 each = $700)

**Hardware:**
- 16× 1/4-20 T-nuts (driver mounting)
- 16× 1/4-20 × 2" bolts
- ~60× #8 × 2" wood screws (assembly)
- ~30× #8 × 1.5" wood screws (bracing)
- 1× dual binding post terminal plate
- 1× tube silicone caulk
- 16 oz wood glue (Titebond III)

**Finish:**
- 1 quart ExoHyde or similar texture coating

**Total Material Cost:** ~$500 (excluding drivers)

### Reference Documents

All construction details are in this directory:

| Document | Purpose |
|----------|---------|
| `specifications.md` | Complete cabinet specs |
| `cut_list.md` | Panel dimensions and sheet layouts |
| `bracing_details.md` | Bracing system design |
| `build_guide.md` | Step-by-step assembly |
| `diagrams/ff_01_cut_list.png` | Visual cut layout |
| `diagrams/ff_02_panel_dimensions.png` | Panel drawings |
| `diagrams/ff_14_bracing_details.png` | Bracing components |

### Construction Checklist

**Week 1: Panel Prep**
- [ ] Cut all panels from sheets per cut list
- [ ] Cut driver holes in BOTH baffle layers (16.875" diameter)
- [ ] Drill 8× bolt holes per driver (5/16", 17.75" bolt circle)
- [ ] Dry-fit baffle layers to verify alignment
- [ ] Laminate baffle layers (glue + clamp 24hrs)
- [ ] Install T-nuts in laminated baffle (from back side)
- [ ] Cut all bracing components

**Week 2: Assembly**
- [ ] Seal all interior panel surfaces (optional: shellac or poly)
- [ ] Attach rib braces to side panels and back
- [ ] Assemble box: back → sides → bottom → top
- [ ] Install cross-braces at 14" and 28" from bottom
- [ ] Install corner braces (full height L-profiles)
- [ ] Install baffle support cleats (4.5" from front edge)
- [ ] Seal all internal joints with silicone caulk
- [ ] Let cure 24 hours

**Week 3: Finishing**
- [ ] Install baffle on cleats (screws from front)
- [ ] Install terminal plate on back panel
- [ ] Wire drivers (series: Driver 1 → Driver 2 → terminal)
- [ ] Mount drivers to baffle (torque bolts evenly)
- [ ] Apply exterior finish (ExoHyde or paint)
- [ ] Add rubber feet (isolation from floor)

**Documentation:**
- [ ] Take photos at each major step
- [ ] Note any construction issues or deviations
- [ ] Record actual panel dimensions (verify vs plan)
- [ ] Weigh completed cabinet (target: ~195 lbs)

---

## Phase 2: Initial Setup & Burn-In

### Equipment Required

**Amplifier:**
- 1× Behringer NX6000D
- Noctua fan mod (NF-R8 redux-1800)
- 12V trigger cable (optional)

**Signal Source:**
- Test PC or media player
- Audio interface or direct connection

**Test Signals:**
- REW (Room EQ Wizard) software
- Burn-in test tones (20-80 Hz sweep)

**Safety:**
- SPL meter (verify reasonable levels)
- Visual inspection capability (driver excursion)

### Amplifier Configuration

**NX6000D Settings:**
- Mode: **STEREO** (single cabinet on Channel A)
- Load: 8Ω (both drivers in series)
- Expected power: ~800-850W (real-world at 8Ω)
- HPF: OFF or 20 Hz (if using built-in DSP)
- Gain: Start at minimum, increase as needed

**Wiring:**
- Cabinet terminal → NX6000D Channel A output (Speakon or binding posts)
- Channel B: Unused (or mirror signal for future second cabinet)

### 100-Hour Burn-In Protocol

**Purpose:**
- Loosen driver suspensions
- Stabilize T/S parameters
- Verify thermal stability
- Identify any mechanical issues before measurements

**Burn-In Signal:**
- 20-80 Hz sweep, continuous
- Duration: 3-5 minutes per sweep
- Level: Moderate (60-70% of rated power = ~500W)
- Alternative: Pink noise filtered 20-100 Hz

**Schedule:**

| Phase | Duration | Signal | Level | Notes |
|-------|----------|--------|-------|-------|
| **Initial** | 0-10 hrs | 30-80 Hz sweep | 40% power (~300W) | Gentle break-in |
| **Medium** | 10-50 hrs | 20-80 Hz sweep | 60% power (~500W) | Normal break-in |
| **Full** | 50-100 hrs | 20-80 Hz sweep | 70% power (~600W) | Full suspension flex |

**Safety Monitoring:**

Every 10 hours, check:
- [ ] Driver surround condition (no tears or separation)
- [ ] Basket temperature (should be warm but not hot)
- [ ] Amplifier temperature (check heatsink)
- [ ] Cabinet integrity (no buzzes, rattles, loose panels)
- [ ] Listen for mechanical noises (voice coil rub, suspension issues)

**Automated Burn-In Setup:**

```
REW Generator Settings:
- Signal: Log sweep 20-80 Hz
- Duration: 180 seconds (3 min)
- Level: -10 dB (adjust for ~500W output)
- Repeat: Continuous loop

OR use PC audio player:
- Generate 3-hour WAV file (20-80 Hz sweep repeated)
- Loop for 24-hour periods
- Monitor periodically
```

**Burn-In Log:**

Create a simple log tracking:
- Date/time
- Hours accumulated
- Signal type and level
- Visual inspection notes
- Any anomalies

**After 100 Hours:**
- [ ] Final visual inspection (driver condition)
- [ ] Let drivers rest 24 hours before measurements
- [ ] Verify no mechanical damage or issues
- [ ] Ready for Phase 3 testing

---

## Phase 3: Pre-Test Preparation

### Test Equipment Setup

**Required Equipment:**

| Item | Purpose | Notes |
|------|---------|-------|
| UMIK-1 or UMIK-2 mic | REW measurements | Calibrated measurement mic |
| Mic stand | Positioning | Sturdy, adjustable height |
| Measuring tape | Distance verification | Accurate to 1/4" |
| SPL meter | Level verification | Cross-check REW readings |
| Laser level (optional) | Alignment | Ensure mic on-axis |
| Voice coil gap gauge (optional) | Excursion measurement | Verify Xmax visually |

**Software:**
- REW (Room EQ Wizard) - latest version
- UMIK calibration file loaded
- Audio interface drivers installed

**Test Environment:**

Ideally test in:
- [ ] Quiet room (minimize background noise)
- [ ] Large space (minimize reflections for outdoor/GP measurements)
- [ ] OR outdoor ground plane setup (most accurate for subwoofers)

**Cabinet Preparation:**

Test cabinet in TWO configurations:

**Configuration A: Empty (No Polyfill)**
- Baseline measurements
- Verify base T/S parameters
- Establish reference

**Configuration B: Stuffed (Medium Polyfill)**
- Add polyfill (medium density, ~2-3 lbs)
- Remeasure to quantify virtual volume effect
- Document actual multiplier

---

## Phase 4: Measurement Protocol

### Test Matrix

| Test | Configuration | Location | Purpose |
|------|---------------|----------|---------|
| 1. Impedance Sweep | Empty | Benchtop | Verify 8Ω, find resonances |
| 2. Nearfield Response | Empty | Driver cone (6") | True driver response |
| 3. Ground Plane | Empty | Outdoor/1m | Anechoic-like measurement |
| 4. SPL Capability | Empty | 1m | Max clean output |
| 5. Distortion | Empty | 1m | THD at various levels |
| 6. Impedance Sweep | Stuffed | Benchtop | Compare to empty |
| 7. Nearfield Response | Stuffed | Driver cone (6") | Polyfill effect |
| 8. Ground Plane | Stuffed | Outdoor/1m | Final response |
| 9. Corner Loading | Stuffed | Room corner | In-room gain verification |
| 10. Amplifier Power | Both | 1m | Actual NX6000D output |

### Test 1: Impedance Sweep

**Purpose:** Verify 8Ω load, identify resonances

**Setup:**
- REW → Audio interface → NX6000D → Cabinet
- REW Impedance measurement mode
- Sweep: 10 Hz - 200 Hz

**Measurements:**
- [ ] DC resistance (Re) - expect ~4.2Ω
- [ ] Impedance at resonance (Zmax) - calculate Qes
- [ ] Resonant frequency (Fs) - verify alignment
- [ ] Impedance @ 50 Hz, 80 Hz (verify ~8Ω nominal)

**Record:**
- Screenshot of impedance curve
- Export data to CSV
- Note any anomalies (extra peaks = panel resonances)

### Test 2: Nearfield Response (Empty Cabinet)

**Purpose:** Measure true driver output without room influence

**Setup:**
- Mic positioned 6" from driver cone center
- Measure BOTH drivers separately
- Average the two measurements

**Procedure:**
1. Position mic 6" from top driver, on-axis
2. REW SPL measurement, 10-200 Hz sweep
3. Repeat for bottom driver
4. REW: Average the two measurements
5. Apply nearfield correction (+6 dB for two drivers)

**Measurements:**
- [ ] Response 20-200 Hz
- [ ] Identify Fc (resonant peak)
- [ ] Measure rolloff slope below Fc
- [ ] Verify predicted Qtc from shape

**Record:**
- Raw measurements (both drivers)
- Averaged + nearfield corrected curve
- Fc and Qtc estimates

### Test 3: Ground Plane Measurement (Empty)

**Purpose:** Anechoic-like measurement simulating free-field

**Setup:**
- Outdoors on large flat surface (driveway, parking lot)
- Cabinet on ground
- Mic at 1 meter, ~4" above ground
- Or use outdoor measurement at 1m height if ground plane unavailable

**Procedure:**
1. Position cabinet on ground
2. Measure 1m from baffle center
3. Mic height: 4" above ground (splits hemisphere)
4. REW SPL + phase measurement
5. Gate reflections if needed

**Measurements:**
- [ ] SPL 10-200 Hz at 1 meter
- [ ] Phase response
- [ ] F3 (-3dB point)
- [ ] Verify alignment (Qtc from shape)

**Record:**
- Full frequency response
- Compare to WinISD prediction
- Note F3 and rolloff characteristics

### Test 4: SPL Capability (Power Handling)

**Purpose:** Determine maximum clean output, verify Xmax limits

**Setup:**
- 1 meter ground plane or 1m outdoor
- REW SPL measurement
- Gradually increase level

**Procedure:**

**At each test frequency (20, 25, 30, 40, 60, 80 Hz):**

1. Start at low level (~70 dB)
2. Increase in 3 dB steps
3. Measure SPL at each step
4. **STOP when:**
   - Visible distortion (driver losing control)
   - Amplifier clips (LED indicators)
   - Mechanical noise (voice coil rub, suspension)
   - Estimated Xmax exceeded (~25mm safe limit)

**Document:**
- Maximum SPL at each frequency
- Limiting factor (excursion, amp, thermal, or distortion)
- Calculate estimated power delivered

**Safety:**
- Never exceed visible Xmax (28mm)
- Stop if mechanical noises appear
- Allow driver to cool between high-power runs

### Test 5: Distortion Measurement

**Purpose:** Characterize THD at reference and elevated levels

**Setup:**
- 1 meter measurement
- REW distortion measurement mode
- Test at 80 dB, 90 dB, 100 dB, 105 dB

**Procedure:**

For each level (80, 90, 100, 105 dB):
1. Set REW generator to target level
2. Measure THD 20-100 Hz
3. Record 2nd, 3rd harmonic distortion
4. Note where distortion rises above 1%, 3%, 10%

**Measurements:**
- [ ] THD vs frequency at each level
- [ ] Identify frequency where distortion rises
- [ ] Note clean output limits

**Record:**
- THD curves for each level
- Maximum clean SPL per frequency

### Test 6-8: Repeat with Polyfill

**After empty measurements complete:**

1. **Add polyfill:**
   - Medium density stuffing (2-3 lbs polyester batting)
   - Distribute evenly in cabinet
   - Don't over-stuff (should not compress when baffle installed)

2. **Repeat Tests 1-3:**
   - Impedance sweep (compare Fs shift)
   - Nearfield response (verify virtual volume effect)
   - Ground plane (measure new F3)

3. **Calculate virtual volume multiplier:**
   - Compare Fc shift: Empty vs Stuffed
   - Calculate actual volume increase
   - Verify against theoretical (1.2-1.4× expected)

### Test 9: Corner Loading Verification

**Purpose:** Measure boundary reinforcement gain

**Setup:**
- Place cabinet in room corner (tri-corner ideal)
- Measure at listening position
- Compare to ground plane measurement

**Procedure:**
1. Position in corner (both walls + floor)
2. Measure response at ~10 feet (typical listening distance)
3. Compare to ground plane (note gain)

**Measurements:**
- [ ] Response with corner loading
- [ ] Estimate boundary gain (compare to GP)
- [ ] New in-room F3
- [ ] Verify expected +9-12 dB gain at 20 Hz

### Test 10: Amplifier Power Verification

**Purpose:** Measure actual NX6000D output vs manufacturer spec

**Setup:**
- Cabinet as 8Ω load
- 1 meter measurement
- Known driver sensitivity (90.7 dB @ 2.83V/1m)

**Procedure:**

**At each test frequency (20, 30, 40, 60, 80 Hz):**

1. Measure SPL at 1 meter with REW
2. Use known driver sensitivity to back-calculate power:
   - SPL measured = Sensitivity + 10×log10(Power/2.83²)
   - Power = 2.83² × 10^((SPL - Sensitivity)/10)

3. Increase amp gain until:
   - Amplifier clips (red LED)
   - Record SPL at clip point
   - Calculate power at clip

**Expected Results:**
- Rated: 850W @ 8Ω (manufacturer claim)
- Realistic: 600-800W @ 8Ω (based on forum data)
- At 20 Hz: Expect derating to ~500-650W
- At 10 Hz: Expect ~400-500W

**Document:**
- Actual power vs frequency
- Derating percentage at ULF
- Compare to specification
- Thermal rise after sustained use

**Thermal Test:**
- Run at 50% power for 1 hour
- Monitor heatsink temperature
- Verify fan noise (post-Noctua mod)
- Check for thermal shutdown

---

## Phase 5: Data Analysis

### Comparison Matrices

**1. Driver Parameters: Measured vs Spec**

| Parameter | Dayton Spec | Measured (Empty) | Delta | Pass/Fail |
|-----------|-------------|------------------|-------|-----------|
| Fs | 22 Hz | _____ Hz | _____ | ⬜ |
| Qts | 0.53 | _____ | _____ | ⬜ |
| Impedance (nominal) | ~8Ω | _____ Ω | _____ | ⬜ |

**2. Alignment: Predicted vs Measured**

| Parameter | WinISD Prediction | Measured | Delta | Pass/Fail |
|-----------|-------------------|----------|-------|-----------|
| Fc (empty) | 39.4 Hz | _____ Hz | _____ | ⬜ |
| Qtc (empty) | 0.95 | _____ | _____ | ⬜ |
| F3 (empty, anechoic) | 31.8 Hz | _____ Hz | _____ | ⬜ |
| F3 (stuffed) | ~32 Hz | _____ Hz | _____ | ⬜ |

**3. Polyfill Effect**

| Parameter | Empty | Stuffed | Multiplier |
|-----------|-------|---------|------------|
| Fc | _____ Hz | _____ Hz | _____ |
| Effective Volume | 7.95 ft³ | _____ ft³ (calculated) | _____× |

**4. Amplifier Output: Claimed vs Actual**

| Frequency | Spec (850W) | Measured | Derating % |
|-----------|-------------|----------|------------|
| 80 Hz | 850W | _____ W | _____ % |
| 40 Hz | 850W | _____ W | _____ % |
| 20 Hz | 850W | _____ W | _____ % |
| 15 Hz | 850W | _____ W | _____ % |
| 10 Hz | 850W | _____ W | _____ % |

**5. SPL Capability (@ 1m, stuffed)**

| Frequency | Max Clean SPL | Limiting Factor | Estimated Power |
|-----------|---------------|-----------------|-----------------|
| 20 Hz | _____ dB | ⬜ Excursion ⬜ Amp ⬜ Distortion | _____ W |
| 30 Hz | _____ dB | ⬜ Excursion ⬜ Amp ⬜ Distortion | _____ W |
| 40 Hz | _____ dB | ⬜ Excursion ⬜ Amp ⬜ Distortion | _____ W |
| 60 Hz | _____ dB | ⬜ Excursion ⬜ Amp ⬜ Distortion | _____ W |

### Success Criteria Evaluation

**⬜ PASS / ⬜ FAIL - Driver Performance**
- T/S parameters within 10% of specification
- No mechanical noises or issues
- Power handling meets or exceeds rating

**⬜ PASS / ⬜ FAIL - Alignment Modeling**
- Fc within 5% of WinISD prediction
- Qtc within 0.1 of prediction
- Response shape matches model

**⬜ PASS / ⬜ FAIL - Polyfill Effect**
- Virtual volume multiplier 1.2-1.4× achieved
- Fc reduced as expected
- Qtc improved (closer to 0.707)

**⬜ PASS / ⬜ FAIL - Amplifier Performance**
- Delivers >500W at 20 Hz (even if derated)
- No thermal shutdown under sustained use
- Fan noise acceptable post-Noctua mod

**⬜ PASS / ⬜ FAIL - System Capability**
- Achieves 105 dB @ 20 Hz @ 1m with headroom
- Clean output to Xmax limits
- Safe for scaled deployment

---

## Phase 6: Scaling Analysis

### Extrapolation to Main System

**If test successful, scale to full system:**

| Configuration | Test (2 drivers) | Main System (16 drivers) | Gain |
|---------------|------------------|--------------------------|------|
| Drivers | 2× UMII18-22 | 16× UMII18-22 | 8× = +9 dB |
| Volume | ~8 ft³ | ~80 ft³ total (distributed) | Varies |
| SPL @ 20Hz (1m) | _____ dB | _____ dB (+9 dB) | +9 dB |
| SPL @ MLP (13') | _____ dB | _____ dB | TBD |

**Corner Loading (Main System):**
- 8× corner drivers: +12 dB boundary gain
- 8× nearfield: Chest-coupled, distance-independent
- Combined: "Weapons-grade" capability

**Amplifier Scaling:**
- Test: 1× NX6000D → 2 drivers @ 8Ω
- Main: 4× NX6000D → 16 drivers (8 pairs @ 8Ω each)
- Shakers: 1× NX6000D bridged
- Spare: 1× NX6000D

### Issues & Mitigations

**If Driver Issues Found:**
- Consider alternative (e.g., UMII15-22 smaller)
- Investigate mechanical fixes
- Contact Dayton for RMA if defective

**If Alignment Doesn't Match:**
- Verify internal volume (bracing displacement)
- Check for air leaks
- Adjust polyfill density

**If Amplifier Underperforms:**
- Consider PURIFI or Hypex alternatives
- Use multiple amps with lower per-channel load
- Accept derating and design around it

**If Excursion-Limited:**
- Reduce target SPL
- Add more drivers (reduce per-driver demand)
- Implement subsonic protection filter

---

## Documentation & Reporting

### Required Deliverables

**Test Report Contents:**

1. **Executive Summary**
   - Pass/fail on each objective
   - Key findings
   - Recommendation (proceed / modify / abort)

2. **Construction Notes**
   - Build time
   - Issues encountered
   - Actual vs planned dimensions
   - Weight verification

3. **Burn-In Log**
   - Total hours
   - Any issues observed
   - Driver condition post burn-in

4. **Measurement Data**
   - All REW measurements (MDAT files)
   - Screenshots of key plots
   - Comparison tables (measured vs predicted)

5. **Photos**
   - Construction progress
   - Completed cabinet
   - Test setup
   - Driver close-ups (condition check)

6. **Recommendations**
   - Proceed with 16-driver system? (Yes/No)
   - Any design modifications needed?
   - Amplifier choice validation
   - Polyfill recommendation for main system

### File Storage

Save all data to:
```
C:\Claude\HT\front_firing_sub_8cf\test_results\
├── photos\
├── rew_measurements\
├── burn_in_log.md
├── test_report.md
└── recommendations.md
```

---

## Timeline

| Phase | Duration | Dependencies |
|-------|----------|--------------|
| 1. Construction | 3 weeks | Materials arrival |
| 2. Burn-In | 100 hours (~4-5 days continuous) | Completed cabinet |
| 3. Rest Period | 24 hours | Post burn-in |
| 4. Measurements (empty) | 1 day | Weather (if outdoor GP) |
| 5. Add polyfill + remeasure | 1 day | Completed empty tests |
| 6. Analysis & reporting | 2-3 days | All measurements complete |

**Total: ~5-6 weeks from start to final report**

---

## Safety Notes

**Hearing Protection:**
- Wear earplugs when testing at >100 dB
- Never exceed 110 dB SPL in test environment
- Allow ears to rest between high-SPL tests

**Driver Protection:**
- Monitor excursion visually during high-power tests
- STOP immediately if mechanical noises occur
- Never exceed visible Xmax (28mm)
- Allow cooling between sustained high-power runs

**Amplifier Protection:**
- Verify adequate ventilation during burn-in
- Don't block NX6000D heatsinks
- Monitor for thermal shutdown
- Have fire extinguisher nearby for extended burn-in

**Electrical:**
- Use dedicated 15A or 20A circuit
- Don't daisy-chain power strips
- Verify all connections before power-on

---

## Go/No-Go Decision

**After test completion, evaluate:**

### Proceed with Full System IF:

✅ All measurements within acceptable tolerances  
✅ No driver mechanical issues  
✅ Amplifier delivers adequate power (even if derated)  
✅ System achieves target SPL with headroom  
✅ No thermal or reliability concerns  
✅ Cost/performance ratio justified  

### Modify Design IF:

⚠️ Minor deviations from predictions (adjustable)  
⚠️ Amplifier derating higher than expected (add more amps)  
⚠️ Polyfill effect different than modeled (adjust stuffing)  
⚠️ Need more/fewer drivers than planned  

### Abort/Redesign IF:

❌ Driver fails or shows defects  
❌ Massive deviation from modeling (>20%)  
❌ Amplifier grossly underperforms or fails  
❌ Excursion limits prevent target SPL  
❌ Unacceptable mechanical noises  
❌ Safety concerns identified  

---

**Document Version:** 1.0  
**Status:** Ready for execution  
**Next Action:** Order materials and begin Phase 1 construction

---

## Appendix: Quick Reference Formulas

### Calculate Power from SPL

```
Power (W) = 2.83² × 10^((SPL_measured - Sensitivity)/10)

Where:
- SPL_measured = dB measured at 1m
- Sensitivity = 90.7 dB @ 2.83V/1m (UMII18-22)
- Result = Power in watts
```

### Calculate Virtual Volume from Fc Shift

```
Virtual_Volume = Physical_Volume × (Fc_empty / Fc_stuffed)²

Where:
- Fc_empty = measured resonance without polyfill
- Fc_stuffed = measured resonance with polyfill
- Result = effective volume in same units as physical
```

### Estimate Qtc from Response Shape

```
Qtc ≈ sqrt(Fc / F3)

Where:
- Fc = resonant frequency (peak in response)
- F3 = -3dB point
- Approximation valid for sealed alignments
```

---

*Test Protocol — 8 cu ft Front-Firing Subwoofer*  
*Validation build before 16-driver "Weapons-Grade" system*  
*Investment at risk: ~$8,700 | Test cost: ~$1,200*
