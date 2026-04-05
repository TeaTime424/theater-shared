# Professional Audio Driver Analysis for Nearfield Tactile System

## Executive Summary

**CONCLUSION: UMII10-22 remains optimal.** Pro audio drivers (JBL, B&C, Eminence, Celestion) are fundamentally designed for different applications than sealed nearfield tactile systems.

---

## Brands Evaluated

| Brand | Focus | Typical Qts | Typical Xmax | Issue |
|-------|-------|-------------|--------------|-------|
| JBL Professional | PA/SR | 0.25-0.40 | 7-8mm | Horn/ported design |
| B&C Speakers | PA Line Arrays | 0.23-0.35 | 6-14mm | Low Qts, ported |
| Eminence | Pro Audio | 0.20-0.50 | 3-13mm | PA optimization |
| Celestion | PA/MI | 0.26-0.35 | 2-4mm | Mid-bass drivers |

---

## Most Promising Candidate: Eminence LAB 12

### Why It Seemed Interesting
- **Fs = 22 Hz** - Lowest I've found in any 12" driver
- **Price = ~$169** - Same as UMII10-22
- Made in USA, established manufacturer

### Specifications

| Parameter | LAB 12 | UMII10-22 | Comparison |
|-----------|--------|-----------|------------|
| Fs | 22 Hz | 31 Hz | LAB12 better |
| Qts | 0.38 | 0.72 | UMII better for sealed |
| Vas | 125.2 L | 19.5 L | LAB12 needs huge box |
| Xmax | 13 mm | 20 mm | UMII 54% more |
| Sd | 507 cm² | 328 cm² | LAB12 55% more |
| **Vd** | **659 cm³** | **656 cm³** | **SAME!** |
| Power RMS | 400 W | 600 W | UMII more |

### Critical Insight: Volume Displacement (Vd)

Despite LAB 12's 55% larger cone area, its 35% lower Xmax results in **nearly identical volume displacement**:
- UMII10-22 Vd: 20mm × 328cm² = **656 cm³**
- LAB 12 Vd: 13mm × 507cm² = **659 cm³**

This means they can move the **same amount of air** - the LAB 12's larger cone doesn't help.

---

## Sealed Box Analysis

### UMII10-22 × 8 in 48"×18"×14" Cabinet

| Parameter | Value |
|-----------|-------|
| Volume/Driver | 16.7 L |
| Fc | 45.6 Hz |
| Qtc | 1.06 (slightly peaked - good for tactile) |
| F3 | 36.5 Hz |

### LAB 12 × 8 in Large 72"×33"×18" Cabinet

| Parameter | Value |
|-----------|-------|
| Volume/Driver | 63.8 L (4× larger!) |
| Fc | 37.9 Hz |
| Qtc | 0.65 (slightly overdamped) |
| F3 | 23.0 Hz |

### Power Requirements @ 105 dB, 15" Distance

| Freq | UMII10-22 (8×) | LAB 12 (8× large) |
|------|----------------|-------------------|
| 10 Hz | 1,184 W total (25% Xmax) | 608 W total (58% Xmax) |
| 15 Hz | 220 W total (11% Xmax) | 126 W total (26% Xmax) |
| 20 Hz | 64 W total (6% Xmax) | 43 W total (14% Xmax) |

**The LAB 12 COULD work in the large cabinet** with slightly lower power requirements, but:
1. Cabinet is 72"×33"×18" - **impractical for nearfield behind couch**
2. Uses 58% of Xmax at 10Hz vs UMII's 25% - **less headroom**
3. 6Ω impedance complicates amplifier selection

---

## Why Pro Audio Drivers Don't Work

### Design Philosophy Mismatch

| Pro Audio Goal | This Application | Conflict |
|----------------|------------------|----------|
| High sensitivity (95dB+) | Deep extension (10Hz) | Trade-off: can't have both |
| Ported/horn loading | Sealed box | Requires high Qts |
| 40-100Hz focus | Sub-20Hz focus | Different Fs optimization |
| Brief SPL peaks | Sustained reference | Different thermal design |
| Lightweight | Excursion | Less moving mass = less Xmax |

### The Qts Problem

For sealed boxes, optimal Qts range is **0.6-0.9**. Pro audio drivers have Qts of 0.2-0.4 because:
- Ported boxes "add" Q via port resonance
- Horns provide mechanical loading
- Neither applies to sealed nearfield application

When you put a Qts=0.38 driver in a sealed box:
- Box must be HUGE to achieve reasonable Qtc
- Even then, Qtc will be overdamped (weak bass)
- OR box is practical size but Qtc is very high (boomy peak)

---

## Other Pro Audio Drivers Evaluated

### JBL 2206H (12")
- Fs: 52 Hz, Qts: 0.32, Xmax: 7.5mm
- **Verdict:** PA woofer, not subwoofer. High Fs, low Xmax.

### B&C 12SW115 (12")
- Fs: 39 Hz, Qts: 0.25, Xmax: 13.8mm
- **Verdict:** Ported subwoofer design. Very low Qts.
- Price: ~$450 (3× UMII10-22)

### JBL W12GTi MkII (12")
- Fs: 32 Hz, Qts: 0.51, Xmax: 20.3mm
- **Verdict:** Would have been EXCELLENT - **but DISCONTINUED**

### Celestion TF1220 (12")
- Fs: 55 Hz, Qts: 0.33, Xmax: 4mm
- **Verdict:** Mid-bass driver only. Not a subwoofer.

---

## Final Recommendation

### ✓ Dayton Audio UMII10-22 - OPTIMAL CHOICE

| Advantage | Details |
|-----------|---------|
| Purpose-built | Designed for sealed home audio subwoofers |
| Optimal Qts | 0.72 perfect for sealed alignment |
| Large Xmax | 20mm - 54% more than LAB 12 |
| Compact cabinet | 48"×18"×14" fits behind couch |
| Verified specs | Vance Dickason tested, published in Voice Coil |
| Wiring flexibility | DVC 2+2Ω allows 4Ω or 1Ω configurations |
| Established | Widely used in DIY subwoofer community |

### ✗ Eminence LAB 12 - NOT RECOMMENDED

| Issue | Details |
|-------|---------|
| Cabinet size | Requires 72"×33"×18" for proper Qtc |
| Lower Xmax | 13mm limits infrasonic headroom |
| 6Ω impedance | Complicates amplifier matching |
| Design intent | Optimized for LABhorn (horn-loaded) |
| No advantage | Same Vd despite larger cone |

---

## Search Conclusion

After evaluating JBL, B&C, Eminence, and Celestion product lines in the 8"-12" range:

**No pro audio driver offers advantages over the UMII10-22 for sealed nearfield tactile application.**

The fundamental issue is that pro audio design priorities (sensitivity, ported/horn loading, 40Hz+ focus) are incompatible with sealed infrasonic requirements (high Qts, large Xmax, deep extension).

The UMII10-22's home audio heritage makes it uniquely suited for this application.

---

*Analysis completed December 2025*
*Files: LAB12_vs_UMII10_comparison.py in C:\Claude\HT\NearField\*
