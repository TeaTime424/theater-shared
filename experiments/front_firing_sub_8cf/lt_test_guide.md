# 8 cu ft Front-Firing Test Box - Linkwitz Transform Test Guide

## Purpose
Use the 8cf test box with miniDSP to practice LT implementation before building corner columns. This simulates the corner column response using the smaller test enclosure.

---

## Original vs Target Parameters

| Parameter | Original (Test Box) | Target (Simulated Corner) |
|-----------|---------------------|---------------------------|
| Fc | 39.4 Hz | 31.4 Hz |
| Qtc | 0.950 | 0.758 |
| F3 | ~32 Hz | ~28 Hz |
| Character | Slight bump | Flatter (Butterworth-ish) |

---

## LT Options Comparison

| Option | Target Fc | Target Qtc | Boost @ 20Hz | Purpose |
|--------|-----------|------------|--------------|---------|
| A: Flatten Only | 39.4 Hz | 0.707 | -1.1 dB | Just remove the bump |
| B: Moderate | 30.0 Hz | 0.707 | +3.2 dB | Extend a bit |
| **C: Match Corners** | **31.4 Hz** | **0.758** | **+2.9 dB** | **Recommended** |
| D: Aggressive | 25.0 Hz | 0.707 | +5.6 dB | Push limits |

### Recommended: Option C - Match Corner Columns
- Simulates the corner column response
- Moderate boost requirements
- Safe excursion at test power
- Validates your LT DSP setup

---

## Boost & Excursion Impact (Option C)

| Freq | LT Boost | Excursion Mult | Power Mult |
|------|----------|----------------|------------|
| 15Hz | +3.5 dB | 1.49× | 2.2× |
| 20Hz | +2.9 dB | 1.40× | 2.0× |
| 25Hz | +2.1 dB | 1.27× | 1.6× |
| 30Hz | +1.0 dB | 1.13× | 1.3× |
| 35Hz | +0.1 dB | 1.01× | 1.0× |
| 40Hz | -0.5 dB | 0.94× | 0.9× |

At typical test power (100W), excursion remains well within Xmax even with LT applied.

---

## miniDSP 2x4 HD Configuration

### LT Parameters
```
Original (Pole):  Fp = 39.4 Hz,  Qp = 0.950
Target (Zero):    Fz = 31.4 Hz,  Qz = 0.758
Sample Rate:      96000 Hz
```

### Biquad Implementation
The LT requires **TWO cascaded biquads**:
1. **Biquad 1** (Highpass): Removes original Fc/Qtc response
2. **Biquad 2** (Lowpass): Creates target Fc/Qtc response

### Coefficients for miniDSP 2x4 HD
**Note:** miniDSP uses inverted a1/a2 signs - values below are ready for direct entry.

#### Biquad 1 (Highpass)
```
b0 =  0.9986451582
b1 = -1.9972903165
b2 =  0.9986451582
a1 =  1.9972882076    ← Note: POSITIVE (miniDSP convention)
a2 = -0.9972924254    ← Note: NEGATIVE (miniDSP convention)
```

#### Biquad 2 (Lowpass)
```
b0 =  0.0000016602
b1 =  0.0000033204
b2 =  0.0000016602
a1 =  1.9972825950    ← Note: POSITIVE (miniDSP convention)
a2 = -0.9972892358    ← Note: NEGATIVE (miniDSP convention)
```

### miniDSP Setup Steps
1. Open miniDSP 2x4 HD plugin
2. Navigate to PEQ section for subwoofer output
3. Select "Advanced" biquad entry mode
4. Enter Biquad 1 coefficients in first PEQ slot
5. Enter Biquad 2 coefficients in second PEQ slot
6. Both biquads must be active (cascaded)

---

## Expected Response with LT Applied

### SPL @ 1m (Half-Space, 100W Test Power)

| Freq | Without LT | With LT | Change |
|------|------------|---------|--------|
| 15Hz | 97 dB | 101 dB | +4 dB |
| 20Hz | 103 dB | 106 dB | +3 dB |
| 25Hz | 107 dB | 109 dB | +2 dB |
| 30Hz | 110 dB | 111 dB | +1 dB |
| 40Hz | 113 dB | 113 dB | 0 dB |
| 50Hz | 115 dB | 114 dB | −1 dB |

### Response Shape Change
```
Without LT:                    With LT:
                               
SPL                            SPL
 ^    .---.                     ^  .-------.
 |   /     \                    | /         
 |  /       '---               |/           '---
 | /                           /
 |/                           /
 +---+---+---+---+-->         +---+---+---+---+-->
   20  30  40  50  Hz           20  30  40  50  Hz
   
   Bump at 40Hz                 Flatter, extended
   Rolls off at 32Hz            Rolls off at ~28Hz
```

---

## Verification Procedure

### 1. Baseline Measurement (No LT)
- [ ] Connect sub to amp (no DSP in chain)
- [ ] Run REW sweep 15-100Hz
- [ ] Verify response matches "Without LT" expectations
- [ ] Note the bump at ~40Hz (Qtc = 0.95)

### 2. Apply LT via miniDSP
- [ ] Insert miniDSP in signal chain
- [ ] Enter both biquad coefficients
- [ ] Verify both PEQ slots are enabled

### 3. Post-LT Measurement
- [ ] Run REW sweep 15-100Hz
- [ ] Verify bump at 40Hz is reduced/eliminated
- [ ] Verify extension to lower frequencies
- [ ] Response should be flatter overall

### 4. Success Criteria
- [ ] Bump at 40Hz reduced by ~2-3 dB
- [ ] F3 shifted from ~32Hz to ~28Hz
- [ ] No oscillation or instability
- [ ] Clean impulse response (no ringing)

---

## Safety Notes

### Excursion Limits
With LT applied at 100W test power:
- 20Hz excursion: ~12mm (43% of Xmax) ✓ Safe
- 15Hz excursion: ~18mm (64% of Xmax) ✓ Safe

### HPF Requirement
Add a high-pass filter below the LT to protect against subsonic content:
- **Recommended:** 15Hz HPF, 4th order (24dB/oct)
- Configure in miniDSP before the LT biquads

### Test Power Limits
| Power | Max Safe Duration | Notes |
|-------|-------------------|-------|
| 100W | Extended | Standard test power |
| 250W | 30 seconds | Watch excursion |
| 500W | 10 seconds | Brief verification only |
| 850W | 5 seconds | Maximum, very brief |

---

## Troubleshooting

### LT Has No Effect
- Verify both biquads are enabled
- Check coefficient entry (especially signs)
- Confirm miniDSP is in signal chain

### Response Has Excessive Bump
- Biquad order may be wrong (swap 1 and 2)
- Sign error in a1/a2 coefficients
- Wrong sample rate selected

### Oscillation or Ringing
- Coefficient entry error
- Reduce LT target (use Option A instead)
- Check for feedback in measurement setup

### Response Too Quiet
- Biquad 2 has very small b0 coefficient - this is normal
- The cascaded response should have unity gain in passband
- Check input levels to miniDSP

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────┐
│  8CF TEST BOX - LINKWITZ TRANSFORM (OPTION C)              │
├─────────────────────────────────────────────────────────────┤
│  Original: Fc=39.4Hz, Qtc=0.950                            │
│  Target:   Fc=31.4Hz, Qtc=0.758                            │
├─────────────────────────────────────────────────────────────┤
│  BIQUAD 1 (enter in miniDSP):                              │
│    b0= 0.9986451582   a1= 1.9972882076                     │
│    b1=-1.9972903165   a2=-0.9972924254                     │
│    b2= 0.9986451582                                        │
├─────────────────────────────────────────────────────────────┤
│  BIQUAD 2 (enter in miniDSP):                              │
│    b0= 0.0000016602   a1= 1.9972825950                     │
│    b1= 0.0000033204   a2=-0.9972892358                     │
│    b2= 0.0000016602                                        │
├─────────────────────────────────────────────────────────────┤
│  EXPECTED RESULT:                                          │
│    • Bump at 40Hz eliminated                               │
│    • F3 shifts from 32Hz → 28Hz                            │
│    • +3dB boost at 20Hz                                    │
│    • Simulates corner column response                      │
└─────────────────────────────────────────────────────────────┘
```

---

*LT Test Guide - January 2025*
*For: 8 cu ft Front-Firing Test Box with miniDSP 2x4 HD*
