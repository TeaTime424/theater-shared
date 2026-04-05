# 2.1 Test System DSP Configuration
## Titan-815LX + UMII18-22 Subwoofer + DSP-408

**Document Version:** 1.0  
**Created:** January 2, 2025  
**Purpose:** DSP settings for reference system testing

---

## System Components

| Component | Model | Key Specs |
|-----------|-------|-----------|
| **Main Speakers** | DIYSG Titan-815LX (pair) | 99 dB/2.83V/1m, 6Ω, F3: 34 Hz |
| **Subwoofer Driver** | Dayton UMII18-22 | 90.7 dB, 4Ω (series), Fs: 22 Hz, Xmax: 28mm |
| **Subwoofer Enclosure** | Sealed 4 cu ft | Fc: 39 Hz, Qtc: 0.95, F3: 30 Hz |
| **Subwoofer Amplifier** | Dayton SPA500DSP | 500W @ 4Ω, built-in DSP |
| **System DSP** | Dayton DSP-408 | 4-in/8-out, 10-band PEQ/channel |
| **Main Amplifier** | TBD (external) | Recommend 100W+ @ 6Ω |

---

## ⚠️ CRITICAL DSP LIMITATIONS

### Dayton DSP-408

| Parameter | Limitation | Impact |
|-----------|------------|--------|
| **HPF/LPF Minimum** | **20 Hz** | Cannot filter below 20 Hz |
| **PEQ Minimum** | **20 Hz** | Cannot EQ below 20 Hz |
| HPF/LPF Slopes | 6/12/18/24 dB/oct | Standard options |
| Filter Types | LR, Butterworth, Bessel | Standard options |
| Delay Resolution | 1 cm (0.029 ms) | Whole cm increments only |

**To "disable" HPF:** Set to 20 Hz @ 6 dB/oct (minimum rolloff)

### Dayton SPA500DSP (Plate Amp)

| Parameter | Specification | Notes |
|-----------|---------------|-------|
| **PEQ Range** | **10-200 Hz** | Better than DSP-408! |
| **PEQ Bands** | 5 | Each 10-200 Hz, ±12/+6 dB |
| LPF Range | Variable | -12/-24 dB/oct |
| Subsonic Filter | Yes | Adjustable |
| HPF Output | Yes | For mains passthrough |
| Limiter | Yes | Threshold, attack, release |
| Phase | 0°/180° | Polarity inversion |

**Key Advantage:** SPA500DSP PEQ can reach 10 Hz - use this for any sub-20 Hz work!

---

## Subwoofer Performance Analysis

### UMII18-22 in 4 cu ft Sealed

| Parameter | Value |
|-----------|-------|
| Box Volume | 4.0 cu ft (113.3 L) |
| Box Resonance (Fc) | **39.3 Hz** |
| Box Q (Qtc) | **0.95** |
| F3 (-3 dB) | **30.1 Hz** |
| Alignment | Slightly underdamped (punchy) |

### Frequency Response (Relative to Passband)

| Frequency | Response | SPL @ 3m/500W | Status |
|-----------|----------|---------------|--------|
| 20 Hz | -11.0 dB | ~100 dB | Reduced |
| 25 Hz | -6.9 dB | ~104 dB | Reduced |
| 30 Hz | -3.9 dB | ~107 dB | F3 point |
| 35 Hz | -1.7 dB | ~109 dB | Near flat |
| 40 Hz | -0.3 dB | ~111 dB | Passband |
| 50-80 Hz | +0.8 dB | ~112 dB | Passband |

### Excursion Safety @ 500W

| Frequency | Est. Excursion | % of 28mm Xmax | Status |
|-----------|----------------|----------------|--------|
| 20 Hz | ~22-25 mm | 80-90% | ⚠️ CAUTION |
| 25 Hz | ~18-20 mm | 65-70% | ✓ OK |
| 30 Hz | ~14-16 mm | 50-57% | ✓ SAFE |
| 40 Hz | ~8-10 mm | 30-36% | ✓ SAFE |

**Subsonic filter is essential** - excursion below 20 Hz can exceed Xmax rapidly.

---

## Signal Flow Options

### Option A: DSP-408 as Master (Full Control)

```
Source L/R ──► DSP-408 Input 1/2
                    │
                    ├──► DSP-408 Output 1 ──► Main Amp ──► Titan L
                    ├──► DSP-408 Output 2 ──► Main Amp ──► Titan R
                    └──► DSP-408 Output 3 ──► SPA500DSP Line In ──► Sub

DSP-408 handles: Crossover, main EQ, sub routing
SPA500DSP handles: Sub PEQ (10-200 Hz), limiter, subsonic
```

### Option B: SPA500DSP as Master (Simpler)

```
Source L/R ──► SPA500DSP Line In
                    │
                    ├──► SPA500DSP HPF Out ──► Main Amp ──► Titans
                    └──► SPA500DSP Sub Out ──► Sub Driver

SPA500DSP handles: Everything (crossover, EQ, limiter, subsonic)
DSP-408: Not used in signal chain
```

### Option C: Hybrid (Recommended for Testing)

```
Source L/R ──► DSP-408 Input 1/2
                    │
                    ├──► Output 1 (HPF 80Hz) ──► Amp ──► Titan L
                    ├──► Output 2 (HPF 80Hz) ──► Amp ──► Titan R
                    └──► Output 3 (LPF 80Hz) ──► SPA500DSP Line In
                                                      │
                                                      └──► Sub

DSP-408: Main crossover, main channel EQ, delay alignment
SPA500DSP: Sub PEQ (10-200 Hz), limiter, subsonic protection
```

---

## DSP-408 CONFIGURATION

### Subwoofer Channel (Output 3)

#### Low-Pass Filter
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Type | Linkwitz-Riley | Phase-coherent with mains |
| Frequency | **80 Hz** | Standard crossover |
| Slope | **24 dB/oct** | Clean transition |

#### High-Pass Filter (Subsonic Protection)
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Type | Butterworth | |
| Frequency | **20 Hz** | DSP-408 minimum |
| Slope | **24 dB/oct** | Maximum protection |

⚠️ **Note:** 20 Hz @ 24 dB/oct provides -24 dB at 10 Hz. For deeper protection, use SPA500DSP's subsonic filter (goes lower than 20 Hz).

#### Gain/Level
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Initial Gain | **+8 dB** | Compensate for sensitivity diff |
| Fine Tune | Adjust with SPL meter | Match to mains at crossover |

#### Phase
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Initial | **0°** | Start here |
| Adjust | Flip to 180° if needed | Measure summing at XO |

#### Delay
| Parameter | Calculation | Notes |
|-----------|-------------|-------|
| If sub closer | Add delay to sub | 29.4 μs per cm |
| If mains closer | Add delay to mains | Use DSP-408 main output delay |
| Typical sub offset | 30-50 cm | Behind mains position |

#### PEQ (Available Bands 1-10)

**Reserve Bands for Room Correction After Measurement**

| Band | Suggested Use | Initial Setting |
|------|---------------|-----------------|
| 1 | Room mode near Fc (~39 Hz) | Measure first |
| 2 | Room mode 50-60 Hz | Measure first |
| 3 | Room mode 70-80 Hz | Measure first |
| 4 | Integration at XO | Measure first |
| 5-10 | Additional correction | As needed |

**Do NOT boost below 25 Hz** - limited headroom, excursion risk.

### Main Channels (Outputs 1 & 2)

#### High-Pass Filter
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Type | Linkwitz-Riley | Match sub LPF |
| Frequency | **80 Hz** | Standard crossover |
| Slope | **24 dB/oct** | Clean transition |

#### Low-Pass Filter
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Setting | **OFF** | Or 20,000 Hz @ 6 dB/oct |

#### PEQ
| Band | Suggested Use |
|------|---------------|
| 1-5 | Room correction for mains |
| 6-10 | Additional as needed |

---

## SPA500DSP CONFIGURATION

### Subsonic Filter (HPF)
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Enable | **ON** | Essential for protection |
| Frequency | **20-25 Hz** | 20 Hz for max extension |
| Slope | **-24 dB/oct** | Maximum protection |

**Forum-tested setting:** 25 Hz @ -12 dB/oct (conservative)

### Low-Pass Filter
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Enable | **OFF** if DSP-408 handles | Avoid double filtering |
| Or | 80-100 Hz if sole LPF | Match to mains |
| Slope | -24 dB/oct | |

### PEQ (Bands 1-5)

**Advantage:** PEQ range is 10-200 Hz (lower than DSP-408!)

| Band | Purpose | Initial Setting |
|------|---------|-----------------|
| 1 | Sub-20 Hz boost (if wanted) | OFF initially |
| 2 | Fc region (~39 Hz) | Measure first |
| 3 | Room mode correction | Measure first |
| 4 | Room mode correction | Measure first |
| 5 | Integration smoothing | Measure first |

**For 20 Hz extension boost (after measurement):**
- Band 1: 20 Hz, +6 dB max, Q=0.7 (shelf-like)
- Monitor excursion/limiter!

### Limiter
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Threshold | **-3 dB** | Initial conservative |
| Attack | **5 ms** | Quick response |
| Release | **240 ms** | Natural decay |

Adjust threshold based on:
- If limiter LED never lights: Increase threshold (toward 0 dB)
- If limiter is constantly on: Decrease threshold (toward -12 dB)

### Phase
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Initial | **0°** | |
| Adjust | Flip to 180° if summing dip at XO | |

### HPF Output (to Mains) - If Using Option B
| Parameter | Setting | Notes |
|-----------|---------|-------|
| Enable | ON | |
| Frequency | 80 Hz | |
| Slope | -24 dB/oct | |

---

## SENSITIVITY MATCHING

### The Problem

| Speaker | Sensitivity | Impedance |
|---------|-------------|-----------|
| Titan-815LX | **99 dB** | 6Ω |
| UMII18-22 | **90.7 dB** | 4Ω (series) |
| **Difference** | **+8.3 dB** | Sub needs boost |

### Solution

Apply **+8 dB gain** to subwoofer channel in DSP-408 to level-match with mains at 80 Hz crossover point.

**Fine-tune procedure:**
1. Play 80 Hz test tone
2. Measure SPL at MLP with only sub playing
3. Measure SPL with only mains playing
4. Adjust sub gain until levels match
5. Verify smooth summation with both playing

---

## RECOMMENDED STARTING SETTINGS

### DSP-408 (Sub Channel - Output 3)

| Setting | Value |
|---------|-------|
| **LPF Type** | Linkwitz-Riley |
| **LPF Frequency** | 80 Hz |
| **LPF Slope** | 24 dB/oct |
| **HPF Type** | Butterworth |
| **HPF Frequency** | 20 Hz |
| **HPF Slope** | 24 dB/oct |
| **Gain** | +8 dB |
| **Phase** | 0° |
| **Delay** | Measure & calculate |
| **PEQ** | All flat initially |

### DSP-408 (Main Channels - Outputs 1 & 2)

| Setting | Value |
|---------|-------|
| **HPF Type** | Linkwitz-Riley |
| **HPF Frequency** | 80 Hz |
| **HPF Slope** | 24 dB/oct |
| **LPF** | OFF |
| **Gain** | 0 dB |
| **Phase** | 0° |
| **Delay** | 0 (or match to sub) |
| **PEQ** | All flat initially |

### SPA500DSP

| Setting | Value |
|---------|-------|
| **Subsonic Filter** | ON, 20-25 Hz, -24 dB/oct |
| **LPF** | OFF (DSP-408 handles) |
| **PEQ** | All flat initially |
| **Limiter Threshold** | -3 dB |
| **Limiter Attack** | 5 ms |
| **Limiter Release** | 240 ms |
| **Phase** | 0° |

---

## TUNING PROCEDURE

### Step 1: Basic Setup
1. Connect signal chain per Option C diagram
2. Set all PEQ bands to OFF/flat
3. Apply initial settings above
4. Verify audio passes through system

### Step 2: Level Matching
1. Disconnect sub (mute Output 3)
2. Set main amp gain for comfortable listening level
3. Reconnect sub
4. Play 80 Hz test tone
5. Adjust DSP-408 Output 3 gain until sub matches mains level
6. Use SPL meter at MLP for accuracy

### Step 3: Phase Alignment
1. Play 80 Hz test tone (both sub and mains)
2. Note SPL at MLP
3. Flip sub phase to 180° in DSP-408
4. Compare SPL - use whichever setting is LOUDER
5. Louder = better summation = correct phase

### Step 4: Time Alignment
1. Measure distance: Sub to MLP
2. Measure distance: Mains to MLP
3. Calculate difference in cm
4. Add delay to closer speaker
5. Enter in DSP-408 (1 cm increments)

### Step 5: Measure & EQ
1. Use REW with UMIK-1 (or similar)
2. Measure at MLP
3. Identify room modes (peaks/dips)
4. Apply cuts (not boosts) for peaks
5. For sub frequencies below 20 Hz correction: use SPA500DSP PEQ
6. For 20-200 Hz: use either DSP

### Step 6: Limiter Calibration
1. Play bass-heavy content at reference level
2. Monitor SPA500DSP limiter LED
3. If constantly lit: reduce sub gain or limiter threshold
4. If never lit: system has headroom (good)
5. Occasional lighting on peaks is normal

---

## EXPECTED PERFORMANCE

### With Recommended Settings

| Metric | Value | vs Reference |
|--------|-------|--------------|
| Sub F3 | ~30 Hz | Good extension |
| Sub F10 | ~20 Hz | Usable with boost |
| Max SPL @ 30 Hz | ~107 dB | +2 dB over THX |
| Max SPL @ 40 Hz | ~111 dB | +6 dB over THX |
| Max SPL @ 50 Hz | ~112 dB | +7 dB over THX |
| Mains SPL | ~120+ dB @ 1m | Reference+ capable |
| Crossover | 80 Hz LR24 | THX standard |

### Limitations

- **20 Hz is practical floor** with DSP-408 HPF
- Below 25 Hz requires careful excursion management
- Heavy bass content may trigger limiter
- Room gain will affect actual in-room response

---

## TROUBLESHOOTING

| Symptom | Likely Cause | Solution |
|---------|--------------|----------|
| Sub localizable | XO too high or phase wrong | Lower XO to 60-70 Hz, check phase |
| Thin at crossover | Summation cancellation | Flip phase, adjust delay |
| Limiter always on | Sub gain too high | Reduce Output 3 gain by 3-6 dB |
| Boomy bass | Room mode reinforcement | Apply cut with PEQ at problem freq |
| No deep bass | HPF too high | Check subsonic setting on SPA500DSP |
| Clipping on amp | Input too hot | Enable input attenuation on SPA500DSP |

---

## DOCUMENT REFERENCES

- DSP-408 Manual: 20 Hz minimum confirmed for all filters
- SPA500DSP Manual: PEQ range 10-200 Hz confirmed
- UMII18-22 Specs: 28mm Xmax, 22 Hz Fs, 90.7 dB sensitivity
- Titan-815LX Specs: 99 dB sensitivity, 34 Hz F3, 40 Hz tuning

---

*Document Version: 1.0*  
*Created: January 2, 2025*  
*System: 2.1 Titan-815LX Test Configuration*
