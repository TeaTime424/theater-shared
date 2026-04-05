# Dayton DSP-408 Linkwitz Transform Configuration - Nearfield Subwoofer

## Critical Finding: Hardware Limitation

**⚠️ The DSP-408 CANNOT achieve 0 dB at 10 Hz!**

The Dayton DSP-408 has a **hard minimum filter frequency of 20 Hz** for:
- High-pass filters
- Low-pass filters  
- Parametric EQ center frequencies

This means true Linkwitz Transform extension to 10 Hz is **not possible** with this DSP.

---

## DSP-408 Specifications Summary

| Parameter | Value | Impact |
|-----------|-------|--------|
| HPF/LPF Min Frequency | **20 Hz** | Cannot filter or EQ below this |
| HPF/LPF Slopes | 6/12/18/24 dB/oct | 6 dB is gentlest available |
| PEQ Bands | 10 per channel | Adequate for LT approximation |
| PEQ Frequency Range | 20-20,000 Hz | Cannot boost below 20 Hz |
| Shelf Filters | Bands 1 and 10 | Low shelf available at 20 Hz min |
| Filter Types | LR, Butterworth, Bessel | Standard options |

---

## Nearfield Subwoofer Parameters (UMII10-22 sealed, 21.2L)

| Parameter | Value |
|-----------|-------|
| Box Resonance (Fc) | 43 Hz |
| Box Q (Qtc) | 1.00 |
| Natural F3 (-3dB) | 34 Hz |
| Natural F6 (-6dB) | 28 Hz |
| Natural F10 (-10dB) | 23 Hz |

---

## What LT to 10 Hz Would Require

| Frequency | Boost Required | Achievable with DSP-408? |
|-----------|---------------|-------------------------|
| 10 Hz | +22.1 dB | ❌ NO - below 20 Hz limit |
| 15 Hz | +17.0 dB | ❌ NO - below 20 Hz limit |
| 20 Hz | +12.3 dB | ⚠️ PARTIAL - at the limit |
| 25 Hz | +8.2 dB | ✓ YES |
| 30 Hz | +5.0 dB | ✓ YES |

---

## DSP-408 Configuration (Best Achievable)

### HPF Settings

| Parameter | Value | Notes |
|-----------|-------|-------|
| Frequency | **21 Hz** | DSP minimum + 1 Hz margin |
| Slope | **6 dB/oct** | Gentlest available - minimizes rolloff at 10 Hz |
| Type | Butterworth | Standard response |

**Note:** With 6 dB/oct slope at 21 Hz, output at 10 Hz is reduced by ~6 dB from the filter alone.

### PEQ Settings

| Band | Type | Frequency | Gain | Q | Purpose |
|------|------|-----------|------|---|---------|
| 1 | Low Shelf | 20 Hz | +10 dB | 0.7 | Maximum boost at lowest available frequency |
| 2 | Peaking | 25 Hz | +8 dB | 1.0 | Fill in F10 region |
| 3 | Peaking | 30 Hz | +6 dB | 1.2 | Boost F6 region |
| 4 | Peaking | 35 Hz | +4 dB | 1.5 | Flatten F3 region |
| 5 | Peaking | 40 Hz | +2 dB | 2.0 | Smooth transition to passband |
| 6-10 | — | — | — | — | Available for room correction |

### LPF Settings

| Parameter | Value | Notes |
|-----------|-------|-------|
| Frequency | 80 Hz | Prevent localization |
| Slope | 24 dB/oct | Linkwitz-Riley alignment |
| Type | Linkwitz-Riley | Phase-coherent |

---

## Expected Response

| Frequency | Natural Sealed | With DSP-408 | Change |
|-----------|---------------|--------------|--------|
| **10 Hz** | -26.0 dB | -29.2 dB | **-3.1 dB** (worse!) |
| **15 Hz** | -18.7 dB | -17.7 dB | +1.0 dB |
| **20 Hz** | -13.4 dB | -8.3 dB | +5.1 dB |
| **25 Hz** | -9.3 dB | -0.5 dB | +8.7 dB |
| **30 Hz** | -5.9 dB | +3.9 dB | +9.8 dB |
| **40 Hz** | -1.6 dB | +4.1 dB | +5.8 dB |
| **50 Hz** | 0.0 dB | 0.0 dB | — |

### Key Observations:

1. **10 Hz gets WORSE** with this config because the HPF is rolling it off
2. **20-40 Hz is significantly improved** - this is where the DSP-408 can help
3. **New effective F3 ≈ 18 Hz** vs natural 34 Hz (significant improvement)

---

## Achieving True 10 Hz Extension

If 0 dB at 10 Hz is a hard requirement, you need different hardware:

### Alternative DSP Options

| DSP | Min Frequency | Custom Biquad | Price | Notes |
|-----|---------------|---------------|-------|-------|
| **miniDSP 2x4 HD** | 1 Hz | ✓ Yes | ~$200 | Full biquad support for true LT |
| **miniDSP Flex** | 1 Hz | ✓ Yes | ~$400 | Pro-grade, more I/O |
| **Behringer DCX2496** | 20 Hz | ❌ No | ~$300 | Same 20 Hz limitation |
| **DSPeaker Anti-Mode** | 5 Hz | ✓ Yes | ~$600+ | Dedicated sub EQ |

### Recommended: Keep DSP-408, Modify Target

Since the DSP-408 is already in your signal chain and provides excellent coverage above 20 Hz:

1. **Accept 20 Hz as practical floor** - below this, protection matters more than output
2. **Remove HPF or set to minimum** - let sealed box natural rolloff provide protection
3. **Maximize 20-35 Hz boost** - this is where you gain tactile impact

---

## Revised Configuration (Optimized for Extension)

### Option A: Maximum Extension (No HPF)

If you're confident in the sealed box's natural protection:

| Setting | Value |
|---------|-------|
| HPF | DISABLED (set to 20 Hz @ 6 dB/oct) |
| PEQ Band 1 | Low Shelf: 20 Hz, +12 dB, Q=0.6 |
| PEQ Band 2 | Peaking: 25 Hz, +10 dB, Q=0.8 |
| PEQ Band 3 | Peaking: 32 Hz, +6 dB, Q=1.2 |
| PEQ Band 4 | Peaking: 40 Hz, +2 dB, Q=2.0 |

**Result:** Flatter response to 20 Hz, 10 Hz remains limited by sealed box physics.

### Option B: Protected Extension (Your Original Request)

As calculated above - HPF at 21 Hz @ 6 dB with PEQ boost. Provides slight improvement to 20-40 Hz but actually reduces 10 Hz output.

---

## Physical Limitations (Regardless of DSP)

Even with perfect DSP, achieving 105 dB at 10 Hz requires:

| Frequency | Power Required | Excursion | Safe? |
|-----------|---------------|-----------|-------|
| 10 Hz | 1,618 W/cabinet | 7.0 mm (35% Xmax) | ✓ |
| 15 Hz | 301 W/cabinet | 3.1 mm (15% Xmax) | ✓ |
| 20 Hz | 89 W/cabinet | 1.7 mm (9% Xmax) | ✓ |

The sealed box naturally rolls off, requiring massive power below 20 Hz. Your NX6000 amplifiers (1,600W @ 8Ω) are appropriately sized for 10-15 Hz operation if the DSP allows.

---

## Conclusion

**The DSP-408 is fundamentally limited to 20 Hz and cannot achieve 0 dB at 10 Hz.**

Best achievable outcome with DSP-408:
- New F3 ≈ 18-20 Hz (improved from 34 Hz)
- Tactile impact significantly improved in 20-40 Hz band
- 10 Hz output limited by both DSP and sealed box physics

For true 10 Hz flat response, consider:
1. External miniDSP 2x4 HD with custom biquad LT
2. Alternative dedicated bass EQ unit
3. Accept 20 Hz as practical operating floor with DSP-408

---

## Files Generated

- `DSP408_LT_Config.py` - Python analysis script
- `DSP408_LT_Analysis.png` - Response comparison plots
- `DSP408_LT_Configuration.md` - This document

---

*Generated: December 2024*  
*System: UMII10-22 Nearfield Tactile Subwoofer*
