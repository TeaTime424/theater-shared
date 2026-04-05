# Triangular Corner Subwoofer: Linkwitz Transform Analysis

## Overview

This document analyzes the application of Linkwitz Transform (LT) EQ to the triangular corner subwoofer system, enabling extension of flat response well below the natural box tuning while maintaining safe excursion limits.

**Key Strategy**: Attenuate passband to THX LFE reference (115 dB), then "spend" the freed excursion headroom on low frequency extension via Linkwitz Transform.

---

## System Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Driver | Dayton UMII18-22 | Per cabinet: 2 drivers |
| Effective Volume | 238 L / 8.4 cu ft | Per driver, with polyfill |
| Box Fc | 31.4 Hz | Natural sealed box corner |
| Box Qtc | 0.758 | Slightly underdamped |
| Xmax (spec) | 28 mm | Klippel verified @ 70% Bl |
| Power/Driver | 425 W | From NX6000D @ 8Ω |
| Corner Gain | +12 dB | Three-wall boundary loading |

---

## Original Response (No EQ)

Without any EQ, the system produces massive output due to corner loading:

| Frequency | SPL (1m) | Excursion | Notes |
|-----------|----------|-----------|-------|
| 10 Hz | 109 dB | 35 mm | Exceeds Xmax |
| 15 Hz | 116 dB | 28 mm | At Xmax limit |
| 20 Hz | 121 dB | 22 mm | Safe |
| 30 Hz | 126 dB | 12 mm | Excellent headroom |
| 80 Hz | 129 dB | 1.2 mm | Minimal excursion |

**Problem**: The passband (30+ Hz) is ~14 dB over THX LFE reference (115 dB), while the sub-20 Hz region pushes Xmax limits.

---

## THX Reference Levels (Verified)

| Channel Type | Peak SPL | Source |
|--------------|----------|--------|
| Main channels (L/C/R/Surr) | 105 dB | Dolby/THX specification |
| **LFE / Subwoofer** | **115 dB** | +10 dB over mains |

---

## Combined Strategy: Attenuation + Linkwitz Transform

### Step 1: Attenuate Passband to 115 dB

Required attenuation: **-14 dB** (brings 129 dB passband down to 115 dB target)

This creates massive excursion headroom:
- Original @ 20 Hz: 22 mm → Attenuated: 4.4 mm
- Freed headroom: ~18 mm available for LT boost

### Step 2: Apply Linkwitz Transform

LT reshapes the sealed box response from original alignment to target alignment:

| Parameter | Original | Target |
|-----------|----------|--------|
| Fc | 31.4 Hz | 14 Hz |
| Qtc | 0.758 | 0.707 (Butterworth) |

### Step 3: Subsonic HPF for Protection

- Frequency: **11 Hz**
- Type: 4th order Butterworth (24 dB/oct)
- Purpose: Protect drivers from infrasonic content

---

## LT Target Exploration Results

Testing various LT targets to find optimal extension vs. excursion tradeoff:

| LT Target | HPF | Max Excursion | % Xmax | Status |
|-----------|-----|---------------|--------|--------|
| 20 Hz | 17 Hz | 7.4 mm | 26% | ✓ Very conservative |
| 18 Hz | 15 Hz | 10.1 mm | 36% | ✓ Conservative |
| 16 Hz | 13 Hz | 14.3 mm | 51% | ✓ Moderate |
| **14 Hz** | **11 Hz** | **21.0 mm** | **75%** | **✓ Recommended** |
| 12 Hz | 9 Hz | 32.6 mm | 116% | ❌ Exceeds Xmax |
| 10 Hz | 7 Hz | 56.7 mm | 203% | ❌ Way over |

---

## Recommended Configuration: LT to 14 Hz

### Final Response

| Frequency | SPL | Excursion | % Xmax |
|-----------|-----|-----------|--------|
| 10 Hz | 103 dB | 17.5 mm | 62% |
| 12 Hz | 109 dB | 20.9 mm | 75% |
| **14 Hz** | **111 dB** | 17.6 mm | 63% |
| 18 Hz | 114 dB | 12.7 mm | 45% |
| 20 Hz | 114 dB | 9.9 mm | 36% |
| 30 Hz | 115 dB | 3.2 mm | 12% |
| 80 Hz | 115 dB | 0.2 mm | <1% |

### Key Achievements

- **F3 extended from 31 Hz to 14 Hz** (17 Hz improvement!)
- **Flat 115 dB response** from 14 Hz to 80+ Hz
- **Max excursion: 21 mm** (75% of Xmax)
- **25% headroom** for transients

---

## DSP Signal Chain

```
Input → Gain (-14 dB) → Linkwitz Transform → 11 Hz HPF → Output
```

### 1. Passband Attenuation
- Type: Gain reduction (or low shelf)
- Amount: **-14.0 dB**

### 2. Linkwitz Transform (2 cascaded biquad sections)
- Original: Fc = 31.4 Hz, Qtc = 0.758
- Target: Fc = 14.0 Hz, Qtc = 0.707
- Boost at 20 Hz: +5.9 dB
- Boost at 14 Hz: +8.0 dB

### 3. Subsonic High-Pass Filter
- Type: Butterworth/Linkwitz-Riley
- Frequency: **11 Hz**
- Order: 4th (24 dB/oct)

---

## Xmax / Xmech Research Summary

### UMII18-22 Specifications

| Parameter | Value | Source |
|-----------|-------|--------|
| Xmax (geometric) | 28 mm | Parts Express spec |
| Xmax (Klippel 70% Bl) | 28 mm | Datasheet confirmed |
| Total cone travel | >50.8 mm p-p | "Over 2 inches" marketing |
| Xmech (estimated) | ~35-40 mm | Based on forum research |

### Forum Research Findings (AVS Forum, diyAudio)

**Original UM18-22 (for reference):**
- Spec Xmax: 22 mm
- Klippel verified: ~25 mm
- Usable excursion (data-bass): ~28 mm
- Xmech: "much higher" - no confirmed failures from over-excursion

**Key quotes from AVS Forum:**

> "the numbers that i recall are around 25mm Klippel verified and 28mm usable (calculated from data-bass distortion testing) and much higher xmech"

> "XMax is where you start to get a LOT more distortion but you haven't 'damaged' the driver persay if you dont have it there all the time. XMech is the Mechanical limit of the driver before you start smoking it for sure."

> "the um18's seem to be holding up pretty well. i can't recall a death by over excursion."

### What Happens Between Xmax and Xmech

| Excursion Range | Effect |
|-----------------|--------|
| 0 - Xmax | Linear operation, low distortion |
| Xmax - Xmech | Rising distortion (THD 10%→20%+), soft compression |
| > Xmech | Risk of permanent damage (voice coil bottoming, suspension damage) |

The UMII18-22's dual mirror-imaged spiders provide "gradual soft limiting" as excursion approaches mechanical limits, reducing risk of catastrophic failure.

### Safety Assessment for 14 Hz LT Target

| Metric | Value | Assessment |
|--------|-------|------------|
| Max modeled excursion | 21 mm | 75% of Xmax |
| Margin to Xmax | 7 mm | Comfortable |
| Margin to Xmech (est.) | 14-19 mm | Very safe |
| HPF protection | 11 Hz, 24 dB/oct | Blocks infrasonic |

**Conclusion**: The 14 Hz LT configuration is safe for continuous operation. The 11 Hz HPF prevents infrasonic content from pushing drivers beyond limits.

---

## Alternative Configurations

### Conservative (18 Hz LT)
- Lower risk, 36% Xmax utilization
- Less impressive extension
- Good for "set and forget" installations

### Aggressive (12 Hz LT) - NOT RECOMMENDED
- Exceeds Xmax by 16%
- Would operate in distorted region
- Risk of damage from sustained peaks

---

## Implementation Notes

### DSP Platform Options

1. **DSP-408 (Dayton)**: 4-in, 8-out, biquad capable
   - Note: HPF minimum is 20 Hz, not 10 Hz
   - May need external biquads for 11 Hz HPF

2. **miniDSP 2x4 HD**: Full biquad flexibility
   - Note: Requires inverted a1/a2 signs for biquad entry

3. **Dirac Live (via AV10)**: Room correction + bass management
   - Can implement LT via target curve

### Calibration Procedure

1. Set amp gains for unity with DSP output
2. Implement -14 dB attenuation
3. Add LT biquads (Fc 31→14 Hz, Qtc 0.76→0.71)
4. Add 11 Hz HPF (4th order)
5. Verify with REW sweep that excursion stays safe
6. Run Dirac calibration with LT already applied

---

## References

- THX Reference Level specifications (Dolby, THX)
- AVS Forum: "Dayton UM18 Xmax/XMech" thread
- AVS Forum: "Using a subwoofer past Xmax?" thread
- AVS Forum: "It Looks Like Dayton Went Back to Their Roots With the Ultimax II"
- diyAudio: "Dayton Xmax and Acoustic Origin"
- Data-bass.com: UM18-22 sealed measurements

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-12-28 | Initial document - LT analysis and Xmax research |

