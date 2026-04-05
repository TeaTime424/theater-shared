# Behringer NX6000 vs NX6000D Amplifier Analysis
## Nearfield Tactile Subwoofer System - Revised Architecture

**Date:** December 2024  
**Revision:** 2.0 - Updated for DSP-408 Signal Architecture  
**Application:** 8× UMII10-22 sealed nearfield tactile system

---

## Signal Architecture Update

### Previous Architecture (Redundant DSP)
```
Marantz AV10 → NX6000D (with DSP) → Nearfield Cabinets
                    ↑
              DSP processing here
```

### Revised Architecture (DSP-408 Centralized)
```
Marantz AV10 (4× Sub Pre-outs)
              ↓
        Dayton DSP-408
              ↓
    ┌─────────────────────────────────────────┐
    │  Outputs 1-4: Corner Sub Amplifiers     │ → 4× PURIFI 1ET400A
    │  Outputs 5-6: Nearfield (summed mono)   │ → Behringer NX6000
    │  Outputs 7-8: (spare)                   │
    └─────────────────────────────────────────┘
```

### DSP-408 Handles ALL Processing:
| Function | DSP-408 Capability | Notes |
|----------|-------------------|-------|
| **Input Summing** | 4 inputs → mixed to any output | Creates mono nearfield feed |
| **HPF** | 20Hz minimum, 48dB/oct | Same limitation as NX6000D |
| **LPF** | Full range, 48dB/oct | ✓ Crossover to main subs |
| **PEQ** | 8 bands per output | ✓ Room correction |
| **Delay** | 100ms per output | ✓ Phase alignment |
| **Compressor/Limiter** | Per output | ✓ Driver protection |
| **Level Matching** | Per output gain | ✓ Balance with corner subs |

**CONCLUSION: NX6000D's built-in DSP is completely redundant.**

---

## 20Hz HPF Limitation & Workaround

### The Problem
Both DSP-408 and NX6000D have a **20Hz minimum frequency** for HPF configuration. This cannot be set lower in either device.

### PEQ Workaround
Use a **Low Shelf filter with negative gain** to extend the effective HPF below 20Hz:

```
DSP-408 Configuration:
├── HPF: 20Hz, Butterworth or LR, 24dB/oct
├── PEQ Band 1: Low Shelf @ 20Hz, -5dB gain
└── Result: Effective HPF extends to ~14-15Hz
```

### How It Works
1. **HPF at 20Hz** provides primary rolloff slope (24dB/oct)
2. **Low shelf with negative gain** adds attenuation below 20Hz
3. **Combined response** shifts effective corner frequency lower

### Effective HPF by Configuration
| Filter Combination | Effective HPF | Notes |
|-------------------|---------------|-------|
| 20Hz BW 12dB/oct alone | 20Hz | DSP minimum |
| 20Hz BW 12dB/oct + LS -3dB @ 20Hz | ~17Hz | Modest extension |
| 20Hz BW 12dB/oct + LS -5dB @ 20Hz | ~15Hz | Good protection |
| 20Hz BW 24dB/oct + LS -5dB @ 20Hz | ~14Hz | **Recommended** |

### Combined Protection (Electrical + Acoustic)
| Source | Rolloff | Notes |
|--------|---------|-------|
| DSP-408 HPF | 24dB/oct | Electrical, below 20Hz |
| PEQ Low Shelf | ~6dB additional | Extends to ~14Hz |
| Sealed Box (Qtc 1.0) | 12dB/oct | Acoustic, below ~43Hz |
| **Total below 20Hz** | **~36dB/oct** | Excellent protection |

### Additional Safety Margins
- **Xmax headroom:** 65% margin at 10Hz/105dB (only 35% utilized)
- **Compressor/Limiter:** Catches transients before clipping
- **Content reality:** Sub-20Hz movie content is rare

---

## NX6000 vs NX6000D Comparison

### Specifications (Identical)
| Parameter | NX6000 | NX6000D |
|-----------|--------|---------|
| Power @ 4Ω | 2 × 3000W | 2 × 3000W |
| Power @ 8Ω | 2 × 1600W | 2 × 1600W |
| Amplifier Class | Class D | Class D |
| Weight | 13 lbs (5.9 kg) | 13.2 lbs (6.0 kg) |
| Form Factor | 2U rack mount | 2U rack mount |
| Damping Factor | >140 @ 8Ω | >140 @ 8Ω |
| THD | <0.02% | <0.02% |
| SNR | >100 dB | >100 dB |
| Frequency Response | 20Hz-20kHz | 20Hz-20kHz |
| SmartSense Impedance Comp | ✓ Yes | ✓ Yes |
| "Zero-Attack" Limiters | ✓ Yes | ✓ Yes |
| DC/LF/Thermal Protection | ✓ Yes | ✓ Yes |

### Key Differences
| Feature | NX6000 | NX6000D |
|---------|--------|---------|
| **DSP Processing** | None | Full DSP suite |
| **Crossover** | Basic switch (Full/HF/LF) | 3 types, 48dB/oct, adjustable |
| **PEQ** | None | 8 bands per channel |
| **Delay** | None | 0-300ms |
| **Limiter Control** | Fixed (internal) | Adjustable threshold/release/hold |
| **USB/Software** | None | NX EDIT software |
| **Front Panel** | Simple LEDs + gain | LCD display + controls |

### Limiter Protection Analysis

**Critical Question:** Is the NX6000's fixed limiter adequate for driver protection?

**NX6000 Fixed Limiter:**
- Activates at amp's power limits
- Protects amp from clipping/thermal damage
- No user-adjustable threshold

**NX6000D Adjustable Limiter:**
- User-configurable threshold (dBfs, Vp, or Load)
- Adjustable hold and release times
- Can protect drivers before reaching amp limits

**For UMII10-22 System:**
| Scenario | Fixed Limiter (NX6000) | Adjustable (NX6000D) |
|----------|------------------------|----------------------|
| Normal operation | ✓ Transparent | ✓ Transparent |
| Approaching Xmax | ⚠️ May exceed before limiting | ✓ Can set lower threshold |
| At amp power limit | ✓ Protects amp | ✓ Protects amp |

**HOWEVER:** The Dayton DSP-408 has compressor/limiter on each output, which can provide driver protection BEFORE the signal reaches the amplifier. This makes even the adjustable limiter on NX6000D redundant.

### DSP-408 Limiter Configuration for Driver Protection
```
OUTPUT 5-6 (Nearfield):
├── Compressor/Limiter: ENABLED
├── Threshold: Set for ~80% Xmax (14mm)
├── Attack: Fast (1ms)
├── Release: 50-100ms
└── Ratio: ∞:1 (hard limit)
```

---

## Pricing Comparison

### Current Market Prices (December 2024)

| Retailer | NX6000 (non-DSP) | NX6000D (with DSP) | Difference |
|----------|------------------|-------------------|------------|
| **Thomann** | $433 | ~$500 | $67 |
| **Sweetwater** | $449 (backordered) | $500 | $51 |
| **B&H Photo** | N/A | $500 | - |
| **Amazon** | $649 | ~$500 | -$149 (!) |
| **Full Compass** | ~$450 | ~$500 | $50 |
| **eBay (new)** | $449 | ~$500 | $51 |

**Notes:**
- Amazon NX6000 pricing is inflated ($649) - avoid
- Thomann offers best NX6000 pricing at $433
- Sweetwater NX6000 backordered until Oct 2025

### Cost Analysis for 2-Unit System

| Configuration | Per Unit | Total (2 units) | Notes |
|--------------|----------|-----------------|-------|
| **NX6000D** | $500 | $1,000 | DSP unused |
| **NX6000** (Thomann) | $433 | $866 | Best value |
| **NX6000** (Sweetwater) | $449 | $898 | Backordered |

**Savings with NX6000:** $102-134 for two units

---

## Recommendation

### ✓ RECOMMENDED: Behringer NX6000 (non-DSP)

**Rationale:**
1. **DSP-408 handles all processing** - NX6000D's DSP completely unused
2. **Protection adequate** - DSP-408 limiter + NX6000's fixed limiter provides dual-layer protection
3. **Cost savings** - $102-134 saved goes toward other components
4. **Simpler setup** - No redundant DSP to configure/bypass
5. **Same power output** - Identical 1600W @ 8Ω per channel

### Signal Flow with NX6000
```
Marantz AV10 (4× Sub Outs)
         ↓
    DSP-408 [Summing + HPF + LPF + PEQ + Delay + Limiter]
         ↓
    NX6000 [Pure amplification + built-in protection]
         ↓
    Nearfield Cabinets (8× UMII10-22 each)
```

### When NX6000D Would Be Preferred
- **Standalone operation** without DSP-408 in signal chain
- **Future flexibility** if system architecture changes
- **Adjustable limiter** if DSP-408 limiter proves inadequate
- **Price parity** if NX6000 not available or same price

---

## Updated System Cost

### Nearfield Tactile System - Revised Budget

| Component | Qty | Unit Price | Total |
|-----------|-----|------------|-------|
| Dayton UMII10-22 drivers | 16 | $170 | $2,720 |
| **Behringer NX6000** | 2 | $433 | **$866** |
| Cabinet materials (est.) | 2 | $150 | $300 |
| Hardware/wiring | 1 | $100 | $100 |
| **TOTAL** | | | **$3,986** |

### Comparison to Previous Budget
| Item | Previous (NX6000D) | Revised (NX6000) | Savings |
|------|-------------------|------------------|---------|
| Amplifiers | $1,000 | $866 | $134 |
| **Total System** | $4,120 | $3,986 | $134 |

---

## DSP-408 Configuration for Nearfield Outputs

### Output 5 & 6 Settings (Nearfield L/R)

```
INPUT MIXING:
├── Source: Mix of Inputs 1-4 (all sub channels summed)
├── Mix Level: 0dB (unity)
└── Polarity: Normal (adjustable per measurement)

HIGH-PASS FILTER:
├── Type: Butterworth or Linkwitz-Riley
├── Frequency: 20Hz (DSP minimum)
└── Slope: 24dB/octave

PEQ BAND 1 (HPF EXTENSION):
├── Type: Low Shelf
├── Frequency: 20Hz
├── Gain: -5dB
└── Effect: Extends effective HPF to ~14-15Hz

LOW-PASS FILTER:
├── Type: Linkwitz-Riley (matches main subs)
├── Frequency: Match corner sub crossover (~100Hz)
└── Slope: 24dB/octave

PEQ (8 bands available):
├── Band 1: Low Shelf @ 20Hz, -5dB (HPF extension - see above)
├── Band 2-5: Room mode correction (per REW measurement)
├── Band 6-7: House curve shaping
└── Band 8: Fine-tuning / reserved

DELAY:
├── Range: 0-100ms
├── Set per measurement for phase alignment with corner subs
└── Typical: 5-15ms depending on placement

COMPRESSOR/LIMITER:
├── Threshold: Set for 80% Xmax protection
├── Attack: 1ms (fast)
├── Release: 50ms
├── Ratio: ∞:1 (brick wall)
└── Makeup Gain: 0dB

OUTPUT GAIN:
├── Adjust for level match with corner subs
└── Calibrate with SPL meter at MLP
```

---

## Purchase Recommendations

### Primary Source: Thomann (Germany)
- **NX6000:** $433 each
- Ships to USA
- May have import duties/longer shipping
- Lowest price available

### Alternative: Sweetwater
- **NX6000:** $449 each (when in stock)
- Currently backordered (Est. October 2025)
- US-based, no import issues
- Excellent customer service

### Avoid:
- **Amazon NX6000** at $649 (severely inflated)
- Third-party sellers with limited return policies

---

## Final Specifications Summary

### Behringer NX6000 for Nearfield System

| Specification | Value | Requirement | Status |
|---------------|-------|-------------|--------|
| Power @ 8Ω | 1600W/channel | 1618W needed | ✓ MEETS |
| Channels | 2 (stereo) | 2 cabinets | ✓ MATCHES |
| Protection | Zero-Attack + DC/LF/Thermal | Driver safety | ✓ ADEQUATE |
| Damping Factor | >140 | High control | ✓ EXCELLENT |
| THD | <0.02% | Low distortion | ✓ EXCELLENT |
| Weight | 13 lbs | Rack-mountable | ✓ GOOD |
| Price | $433-449 | Budget-conscious | ✓ EXCELLENT |

### System Integration
```
┌─────────────────────────────────────────────────────────┐
│                    EQUIPMENT RACK                        │
├─────────────────────────────────────────────────────────┤
│  Marantz AV10 (3U)                                      │
│  ├── Sub Pre-Out 1 ──┐                                  │
│  ├── Sub Pre-Out 2 ──┼──→ Dayton DSP-408               │
│  ├── Sub Pre-Out 3 ──┤    ├── Out 1-4 → PURIFI amps    │
│  └── Sub Pre-Out 4 ──┘    └── Out 5-6 → NX6000         │
│                                                         │
│  Dayton DSP-408 (1U)                                    │
│  └── [All bass processing centralized here]            │
│                                                         │
│  4× PURIFI 1ET400A (various) → Corner Subs             │
│                                                         │
│  Behringer NX6000 (2U)                                  │
│  ├── Ch A → Nearfield Cabinet L                        │
│  └── Ch B → Nearfield Cabinet R                        │
└─────────────────────────────────────────────────────────┘
```

---

## References

- Behringer NX6000 Product Page
- Behringer NX6000D Product Page  
- Thomann Product Listings
- Sweetwater Product Specifications
- Dayton DSP-408 Manual
- AVS Forum: NX Series Discussion Threads
