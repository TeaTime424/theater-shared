# NX6000D ULF Power Derating Test Procedure

## Objective
Measure actual power output vs frequency at 8Ω to establish real-world derating curve for the NX6000D when driving subwoofers below 40Hz.

---

## Equipment Required

### Essential
| Item | Purpose | Notes |
|------|---------|-------|
| NX6000D amplifier | Device under test | Stock, no mods |
| UMII18-22 in enclosure | 8Ω load | Wired VCs in series (4Ω), or use resistor |
| Signal generator | Test tones | REW, tone generator app, or function generator |
| True RMS multimeter | Voltage measurement | Must handle low frequency AC accurately |
| Thermometer | Monitor amp temp | IR or probe type |

### Recommended
| Item | Purpose | Notes |
|------|---------|-------|
| 8Ω power resistor (300W+) | Alternative load | More consistent than speaker, no acoustic output |
| Oscilloscope | Waveform verification | Confirm no clipping |
| SPL meter / calibrated mic | Verify output | Cross-check with voltage |
| Variac or Kill-A-Watt | Monitor AC input | Track power consumption |
| Timer/stopwatch | Sustained tests | Track duration to thermal limiting |

### Safety
| Item | Purpose |
|------|---------|
| Hearing protection | Test tones are LOUD |
| Fire extinguisher | Precaution for resistor tests |
| Ventilation | Amp will generate heat |

---

## Test Setup Options

### Option A: Resistive Load (Preferred for Accuracy)

```
Signal Generator → NX6000D Input → 8Ω Power Resistor → Multimeter (AC Volts)
                                          ↓
                                    Heat sink / fan
```

**Advantages:**
- Pure resistive load (no impedance variation with frequency)
- No acoustic output (can test indoors quietly)
- Consistent, repeatable measurements

**8Ω Resistor Options:**
- 4× 2Ω 100W resistors in series (Parts Express, ~$40)
- 8Ω 300W chassis mount resistor (Ohmite, ~$30)
- DIY: Nichrome wire wound on ceramic form

**CRITICAL:** Resistor will dissipate serious heat at 800W+. Options:
1. Mount on large heatsink with forced air cooling
2. Immerse in mineral oil bath (best for sustained tests)
3. Use water-cooled load bank (if available)
4. Keep tests brief (<10 seconds) and allow cooling between

---

### Option B: Subwoofer Load (Real-World)

```
Signal Generator → NX6000D Input → UMII18-22 (8Ω) → Multimeter (AC Volts across terminals)
```

**Advantages:**
- Tests actual intended load
- Includes real impedance characteristics
- Verifies real-world behavior

**Disadvantages:**
- Impedance varies with frequency (not flat 8Ω)
- Produces extremely loud acoustic output
- Must account for driver impedance at each frequency
- Neighbors may complain

**Impedance Consideration:**
The UMII18-22 impedance is NOT flat 8Ω:
- At Fs (22Hz): Impedance peaks (~30-40Ω typical)
- Above Fs: Drops toward Re (~4.2Ω per driver, 8.4Ω for two in series)
- Below Fs: Rises again

You'll need to measure or use the published impedance curve to calculate true power:
```
P = V² / Z(f)   where Z(f) is impedance at frequency f
```

---

## Test Procedure

### Phase 1: Setup Verification

1. **Connect equipment** per chosen setup option
2. **Set NX6000D to STEREO mode**, use one channel only
3. **Gain knob at minimum**, input connected
4. **Verify signal chain** with 100Hz tone at low level (~1W)
5. **Confirm multimeter reads correctly** (compare to known source)
6. **Record ambient conditions** (temperature, AC voltage)

### Phase 2: Baseline Measurement (40Hz Reference)

1. Set signal generator to **40Hz sine wave**
2. Slowly increase NX6000D gain until **LIMIT LED just flickers**
3. Back off gain slightly so LIMIT LED is off but close to triggering
4. Record voltage: **V_40Hz = ______ Vrms**
5. Calculate power: **P_40Hz = V² / 8 = ______ W**
6. This is your **100% baseline**
7. Note amp temperature: **T_start = ______ °C**
8. Note gain knob position (mark with tape for reference)

### Phase 3: Frequency Sweep (Burst Power)

**Method:** At each frequency, find the maximum voltage before LIMIT LED illuminates.

**Keep gain knob at the 40Hz baseline position.** The amp's internal limiting will reveal the derating.

For each frequency:
1. Set signal generator to test frequency
2. Observe if LIMIT LED illuminates at baseline gain
3. If LIMIT is on: amp is derating. Reduce gain until LIMIT just turns off, record voltage
4. If LIMIT is off: amp has headroom. Can try increasing slightly, but baseline voltage is achievable
5. Record voltage within first 5-10 seconds (burst capability)

| Frequency | Test Order |
|-----------|------------|
| 40 Hz | 1 (baseline) |
| 35 Hz | 2 |
| 30 Hz | 3 |
| 25 Hz | 4 |
| 20 Hz | 5 |
| 18 Hz | 6 |
| 15 Hz | 7 |
| 12 Hz | 8 |
| 10 Hz | 9 |
| 8 Hz | 10 (if amp can produce) |

**Between each test:**
- Return gain to minimum
- Stop signal for 30 seconds
- Allow amp to stabilize
- Check amp temperature hasn't risen excessively

### Phase 4: Sustained Power Test (Critical Frequencies)

Test sustained output at key frequencies to find thermal limiting:

**Procedure for each frequency:**
1. Set to the voltage level achieved in Phase 3
2. Start timer when signal begins
3. Record voltage every 10 seconds for 60-120 seconds
4. Note if/when voltage drops (thermal limiting kicking in)
5. Note LIMIT LED behavior (flickering → solid = current limiting)
6. Stop if PROTECT LED illuminates or amp gets too hot

**Test these frequencies:**
- **20 Hz** (primary target for main subs)
- **15 Hz** (nearfield target)
- **10 Hz** (extreme infrasonic)

**Watch for:**
- Gradual voltage drop over time → thermal limiting
- Sudden voltage drop → current limiting engaged
- LIMIT LED flickering → at edge of capability
- LIMIT LED solid → hard current limit
- PROTECT LED → fault, stop immediately
- Fan speed increase → thermal stress
- Case temperature rise → approaching thermal limit

### Phase 5: Impedance Measurement (If Using Speaker Load)

If testing with actual subwoofer, you must know the impedance at each frequency.

**Option 1: Use REW**
- REW can measure impedance with a calibrated soundcard
- Requires UMIK-1 or similar calibrated mic for SPL, or
- Use REW's impedance measurement with soundcard loopback

**Option 2: Manual Measurement**
1. Put a known resistor (e.g., 10Ω 10W) in series with the driver
2. Apply ~1Vrms at each test frequency from a signal generator
3. Measure voltage across the driver (V_driver)
4. Measure voltage across the resistor (V_resistor)
5. Calculate: Z_driver = R_known × (V_driver / V_resistor)

**Option 3: Use Published Curve**
- Dayton publishes impedance curves in spec sheets
- Less accurate but adequate for this purpose

Record impedance at each test frequency to correct power calculations.

---

## Data Recording Sheet

### Test Conditions
- **Date:** __________
- **Ambient temp:** ______ °C
- **AC mains voltage:** ______ V (measure at outlet)
- **NX6000D serial #:** __________
- **Firmware version (if DSP model):** __________
- **Load type:** □ 8Ω resistor  □ UMII18-22 (8Ω wiring)
- **Signal source:** __________
- **Multimeter model:** __________

### Burst Power Results (First 5-10 Seconds)

| Freq (Hz) | V_rms | Z (Ω)* | Power (W) | % of 40Hz | Notes |
|-----------|-------|--------|-----------|-----------|-------|
| 40 | | 8.0 | | 100% | Baseline |
| 35 | | 8.0 | | | |
| 30 | | 8.0 | | | |
| 25 | | 8.0 | | | |
| 20 | | 8.0 | | | |
| 18 | | 8.0 | | | |
| 15 | | 8.0 | | | |
| 12 | | 8.0 | | | |
| 10 | | 8.0 | | | |
| 8 | | 8.0 | | | |

*Z = 8.0Ω for resistive load; enter measured impedance if using speaker

### Sustained Power Results

**20 Hz Sustained Test:**

| Time (s) | V_rms | Power (W) | Amp Temp (°C) | LIMIT LED | Notes |
|----------|-------|-----------|---------------|-----------|-------|
| 0 | | | | | |
| 10 | | | | | |
| 20 | | | | | |
| 30 | | | | | |
| 40 | | | | | |
| 50 | | | | | |
| 60 | | | | | |
| 90 | | | | | |
| 120 | | | | | |

**15 Hz Sustained Test:**

| Time (s) | V_rms | Power (W) | Amp Temp (°C) | LIMIT LED | Notes |
|----------|-------|-----------|---------------|-----------|-------|
| 0 | | | | | |
| 10 | | | | | |
| 20 | | | | | |
| 30 | | | | | |
| 40 | | | | | |
| 50 | | | | | |
| 60 | | | | | |
| 90 | | | | | |
| 120 | | | | | |

**10 Hz Sustained Test:**

| Time (s) | V_rms | Power (W) | Amp Temp (°C) | LIMIT LED | Notes |
|----------|-------|-----------|---------------|-----------|-------|
| 0 | | | | | |
| 10 | | | | | |
| 20 | | | | | |
| 30 | | | | | |
| 40 | | | | | |
| 50 | | | | | |
| 60 | | | | | |
| 90 | | | | | |
| 120 | | | | | |

---

## Calculations

### Power from Voltage (Resistive Load)
```
P = V² / R
P = V² / 8

Example: 82.5 Vrms into 8Ω
P = 82.5² / 8 = 6806 / 8 = 850W
```

### Power from Voltage (Reactive Load - Speaker)
```
P = V² / Z(f)

Example: 80 Vrms into speaker showing 10Ω at 20Hz
P = 80² / 10 = 6400 / 10 = 640W
```

### Derating Percentage
```
Derating % = (P_freq / P_40Hz) × 100

Example: 650W at 15Hz vs 850W at 40Hz
Derating = (650 / 850) × 100 = 76.5%
```

### Voltage for Target Power
```
V = √(P × R)

Example: What voltage for 850W into 8Ω?
V = √(850 × 8) = √6800 = 82.5 Vrms
```

---

## Expected Results

### Based on NU3000 8Ω Measurements (Scaled to NX6000D)

| Frequency | Expected Derating | Expected Power @ 8Ω | Expected Voltage |
|-----------|-------------------|---------------------|------------------|
| 40 Hz | 100% | ~850W | ~82 Vrms |
| 30 Hz | ~97% | ~825W | ~81 Vrms |
| 20 Hz | ~94% | ~800W | ~80 Vrms |
| 15 Hz | ~86% (interpolated) | ~730W | ~76 Vrms |
| 10 Hz | ~77% | ~655W | ~72 Vrms |

Your measurements will confirm, refute, or refine these estimates.

---

## Potential Findings

### If Derating is LESS Than Expected
- NX6000D is more capable than NU3000 data suggested
- 8Ω nearfield system has even more headroom
- SpeakerPower upgrade becomes even less necessary

### If Derating is WORSE Than Expected
- Calculate actual headroom with measured data
- Determine if reference (105dB) is still achievable
- Quantify benefit of SpeakerPower upgrade

### If Sustained Power Drops Significantly
- Thermal limiting is the constraint, not instantaneous power
- Real-world movie content is dynamic (not sustained sine waves)
- May still be adequate for actual use case

---

## Safety Notes

⚠️ **HIGH POWER TEST - EXERCISE CAUTION**

1. **Never disconnect load while amp is outputting signal** - can damage amp output stage
2. **Resistors get EXTREMELY hot** - 800W into 8Ω = 800W of heat
   - 300W resistor will be over 2× its rating - WILL FAIL if sustained
   - Use oil bath or brief tests with cooling periods
3. **Low frequency tones can cause physical discomfort** - nausea, disorientation
   - Take breaks every few minutes
   - Use hearing protection even at "low" levels
4. **Monitor amp temperature continuously** - stop if case exceeds 60°C (140°F)
5. **Secure all connections** - vibration can loosen terminals at high power
6. **Keep flammables away from resistor** - can reach ignition temperatures
7. **Never touch resistor during or immediately after test** - severe burn hazard
8. **Work in well-ventilated area** - resistors may produce smoke/fumes if overheated
9. **Have fire extinguisher nearby** - just in case
10. **Don't test alone** - have someone nearby in case of emergency

---

## Reporting Results

When you have data, we can:
1. **Plot the actual derating curve** (frequency vs % power)
2. **Compare to NU3000 reference data** (validate scaling assumptions)
3. **Update Behringer_NX6000_Reference.md** with measured values
4. **Recalculate nearfield headroom** with real numbers
5. **Make definitive determination** on SpeakerPower necessity

### Community Value
This data would be valuable for the DIY subwoofer community. Consider posting results to:
- AVS Forum (Behringer amplifier threads)
- DIYAudio (Class D amplifier forum)
- Data-bass.com (if they accept user submissions)

Include:
- Test methodology (this document)
- Raw data tables
- Calculated derating curve
- Comparison to existing NU3000 data
- Your conclusions

---

## Quick Reference Card

**For 8Ω Load:**
```
Power (W) = V² / 8
Voltage (V) = √(P × 8)

850W = 82.5 Vrms
800W = 80.0 Vrms
700W = 74.8 Vrms
600W = 69.3 Vrms
500W = 63.2 Vrms
```

**Derating Formula:**
```
Derating % = (V_test / V_40Hz)² × 100
```

**Expected Baseline (NX6000D @ 8Ω):**
- ~850W per channel
- ~82-83 Vrms at clipping

---

*Document created: January 2025*
*Purpose: Establish real-world NX6000D derating curve at 8Ω for home theater subwoofer application*
*Related: Behringer_NX6000_Reference.md, SpeakerPower_Reference.md*
