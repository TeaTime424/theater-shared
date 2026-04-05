# Buckeye Amplifier Configuration Matrix
## Complete Analysis for UMII18-22 and UMII10-22 Subwoofer Systems

**Date:** December 2025  
**Purpose:** Determine optimal Buckeye/Hypex amplifier configurations for main and nearfield subwoofer systems

---

## Executive Summary

Buckeye amplifiers using Hypex NCORE and PURIFI Eigentakt modules offer **flat frequency response to DC (0Hz)**, eliminating the rolloff issues found in Crown XLS (6dB/oct @ 20Hz) and Behringer NX6000 (severe current limiting below 30Hz). This makes them ideal for infrasonic subwoofer applications including Linkwitz Transform to 10Hz.

**Recommended Configuration:**
- **Main Subs:** 4× NC2K Monoblock @ 2Ω = $4,900
- **Nearfield:** 4× NC2K Monoblock @ 4Ω = $4,900
- **Total:** $9,800 (vs $11,396 SpeakerPower, $4,392 Behringer)

---

## Driver Specifications Summary

### UMII18-22 (Main Subs)
| Parameter | Value |
|-----------|-------|
| Quantity per cabinet | 2 |
| Total cabinets | 4 |
| **Total drivers** | **8** |
| Voice coil config | Dual 2Ω (DVC) |
| RMS power handling | 1,200W per driver |
| Xmax | 28mm |

### UMII10-22 (Nearfield Subs)
| Parameter | Value |
|-----------|-------|
| Quantity per cabinet | 4 |
| Total cabinets | 4 |
| **Total drivers** | **16** |
| Voice coil config | Dual 2Ω (DVC) |
| RMS power handling | 600W per driver |
| Xmax | 20mm |

---

## Buckeye Amplifier Specifications

### Hypex NC2K Monoblock ⭐ PRIMARY CHOICE FOR SUBS

| Parameter | Specification |
|-----------|---------------|
| **Price** | $1,225 |
| **2Ω Power** | 2,000W |
| **4Ω Power** | 2,500W |
| **8Ω Power** | 1,600W |
| **Frequency Response** | **0Hz - 50kHz** (flat to DC!) |
| **S/N Ratio** | 133dB |
| **THD** | 0.002% (1250W, 4Ω) |
| **Output Current** | 48A |
| **Efficiency** | 93% |
| **Dimensions** | 10"W × 13.5"D × 3.5"H |
| **Weight** | 8 lbs |
| **Warranty** | 2 years |

### PURIFI 1ET9040BA Monoblock

| Parameter | Specification |
|-----------|---------------|
| **Price** | $1,295 (with upgraded PSU) |
| **2Ω Power** | 1,200W |
| **4Ω Power** | 750W |
| **8Ω Power** | 375W |
| **Frequency Response** | **0Hz - 80kHz** (flat to DC!) |
| **S/N Ratio** | 140dB |
| **THD** | 0.0001% (400W, 4Ω) |
| **Output Current** | 40A |
| **Efficiency** | 96% |
| **Dimensions** | 10"W × 13"D × 5.5"H |
| **Weight** | 7 lbs |
| **Warranty** | 2 years |

### Hypex NC502MP (Multi-Channel)

| Channels | Price | 2Ω/ch | 4Ω/ch | 8Ω/ch | FR |
|----------|-------|-------|-------|-------|-----|
| 2-ch | $750 | 450W | 500W | 350W | 10Hz-48kHz |
| 4-ch | $1,250 | 450W | 500W | 350W | 10Hz-48kHz |
| 6-ch | $1,850 | 450W | 500W | 350W | 10Hz-48kHz |
| 8-ch | $2,300 | 450W | 500W | 350W | 10Hz-48kHz |

**Note:** NC502MP has insufficient power for these high-excursion drivers in subwoofer duty.

---

## Impedance Configuration Reference

### Main Subs: Achievable Impedances (2× UMII18-22 per cabinet)

| Config | VC Wiring | Driver Wiring | Cabinet Z | Notes |
|--------|-----------|---------------|-----------|-------|
| A | Parallel (1Ω) | Series | **2Ω** | ✓ Maximum power transfer |
| B | Series (4Ω) | Parallel | **2Ω** | ✓ Same result |
| C | Series (4Ω) | Series | **8Ω** | ✓ Lower power, cooler operation |
| D | Parallel (1Ω) | Parallel | 0.5Ω | ❌ Too low for any amp |

### Nearfield: Achievable Impedances (4× UMII10-22 per cabinet)

| Config | VC Wiring | Driver Array | Cabinet Z | Notes |
|--------|-----------|--------------|-----------|-------|
| A | Parallel (1Ω) | 2S2P | **1Ω** | ✓ Requires 1Ω-stable amp |
| B | Series (4Ω) | 2S2P | **4Ω** | ✓ Best balance |
| C | Series (4Ω) | 4S | **16Ω** | ✓ Low power |
| D | Parallel (1Ω) | 4P | 0.25Ω | ❌ Too low |

**Critical:** 2Ω is NOT achievable with 4 identical UMII10-22 drivers.

---

## Part 1: Main Subwoofer Configurations

### NC2K Monoblock (1 amp per cabinet)

| Config | Cabinet Z | Power/Cabinet | Power/Driver | Driver % | Thermal Status |
|--------|-----------|---------------|--------------|----------|----------------|
| **2Ω** | 2Ω | 2,000W | 1,000W | 83% | ✓ Excellent |
| **8Ω** | 8Ω | 1,600W | 800W | 67% | ✓ Very good |

**Cost for 4 cabinets:** 4 × $1,225 = **$4,900**

### PURIFI 1ET9040BA Monoblock (1 amp per cabinet)

| Config | Cabinet Z | Power/Cabinet | Power/Driver | Driver % | Thermal Status |
|--------|-----------|---------------|--------------|----------|----------------|
| **2Ω** | 2Ω | 1,200W | 600W | 50% | ✓ Conservative |
| **8Ω** | 8Ω | 375W | 188W | 16% | ⚠️ Underpowered |

**Cost for 4 cabinets:** 4 × $1,295 = **$5,180**

### NC502MP Multi-Channel Options

| Amp Config | Channels for 4 Cabs | Power @ 2Ω | Power/Driver | Driver % | Status |
|------------|---------------------|------------|--------------|----------|--------|
| 2× NC502MP 4-ch | 4 stereo | 450W | 225W | 19% | ❌ Underpowered |
| 4× NC502MP 2-ch | 4 stereo | 450W | 225W | 19% | ❌ Underpowered |

**NC502MP not recommended for main subs** - insufficient power density.

---

## Part 2: Nearfield Subwoofer Configurations

### NC2K Monoblock (1 amp per cabinet) ⭐ RECOMMENDED

| Config | Cabinet Z | Power/Cabinet | Power/Driver | Driver % | Thermal Status |
|--------|-----------|---------------|--------------|----------|----------------|
| **4Ω** | 4Ω | 2,500W | 625W | 104% | ✓ Slight headroom needed |
| **1Ω** | 1Ω | ~3,000W* | 750W | 125% | ⚠️ Needs DSP limiting |
| **16Ω** | 16Ω | ~800W* | 200W | 33% | ❌ Underpowered for LT |

*Estimated from power curve

**Cost for 4 cabinets:** 4 × $1,225 = **$4,900**

**Note:** At 4Ω, 625W/driver is 4% over the 600W thermal rating. This is within safe operating margin with typical music/movie content duty cycles. For sustained sine wave testing at full power, use DSP limiting.

### PURIFI 1ET9040BA Monoblock (1 amp per cabinet)

| Config | Cabinet Z | Power/Cabinet | Power/Driver | Driver % | Thermal Status |
|--------|-----------|---------------|--------------|----------|----------------|
| **4Ω** | 4Ω | 750W | 188W | 31% | ⚠️ Underpowered for LT |
| **2Ω** | — | — | — | — | ❌ Not achievable |

**PURIFI 1ET9040BA not recommended for nearfield** - insufficient power for Linkwitz Transform.

### NC502MP Multi-Channel Options

| Amp Config | Channels for 4 Cabs | Power @ 4Ω | Power/Driver | Driver % | Status |
|------------|---------------------|------------|--------------|----------|--------|
| 2× NC502MP 4-ch | 4 stereo | 500W | 125W | 21% | ❌ Underpowered |

**NC502MP not recommended for nearfield** - insufficient power for Linkwitz Transform.

---

## Part 3: Complete System Configurations

### Option A: NC2K Monoblocks Throughout ⭐ RECOMMENDED

| System | Amp | Qty | Cabinet Z | Power/Driver | Driver % | Cost |
|--------|-----|-----|-----------|--------------|----------|------|
| Main | NC2K Mono | 4 | 2Ω | 1,000W | 83% | $4,900 |
| Nearfield | NC2K Mono | 4 | 4Ω | 625W | 104% | $4,900 |
| **Total** | | **8** | | | | **$9,800** |

**Advantages:**
- ✓ Flat 0Hz-50kHz response (DC-coupled!)
- ✓ Full power at 10Hz for Linkwitz Transform
- ✓ Unified platform (all same amplifier model)
- ✓ 48A output current handles reactive loads
- ✓ Silent operation (no fans)
- ✓ 93% efficiency = low heat
- ✓ Compact: 8 amps fit in single 4U rack space

### Option B: Mixed NC2K + PURIFI

| System | Amp | Qty | Cabinet Z | Power/Driver | Driver % | Cost |
|--------|-----|-----|-----------|--------------|----------|------|
| Main | 1ET9040BA Mono | 4 | 2Ω | 600W | 50% | $5,180 |
| Nearfield | NC2K Mono | 4 | 4Ω | 625W | 104% | $4,900 |
| **Total** | | **8** | | | | **$10,080** |

**Advantages:**
- ✓ PURIFI has 140dB S/N (vs NC2K 133dB) - inaudible difference for subs
- ✓ Main subs run very conservatively at 50%

**Disadvantages:**
- ✗ Main subs have less headroom for peaks
- ✗ Mixed platform complicates spares strategy
- ✗ Costs $280 more than all-NC2K

### Option C: Maximum Power (NC2K @ Lower Impedance)

| System | Amp | Qty | Cabinet Z | Power/Driver | Driver % | Cost |
|--------|-----|-----|-----------|--------------|----------|------|
| Main | NC2K Mono | 4 | 2Ω | 1,000W | 83% | $4,900 |
| Nearfield | NC2K Mono | 4 | 1Ω | ~750W | 125% | $4,900 |
| **Total** | | **8** | | | | **$9,800** |

**Warning:** Nearfield at 1Ω delivers 125% of driver thermal rating. Requires:
- DSP limiting to -1dB below clipping
- HPF protection below 8Hz
- Monitoring during demanding content

---

## Part 4: Wiring Diagrams

### Main Subs: 2Ω Configuration (VCs Series + Drivers Parallel)

```
                    CABINET WIRING (2Ω TOTAL)

            ┌─── Driver 1 VC1(+) ─[2Ω]─ VC1(-)/VC2(+) ─[2Ω]─ VC2(-) ───┐
            │    (4Ω per driver, voice coils in series)                 │
NC2K (+) ───┤                                                           ├─── NC2K (-)
            │    Driver 2 VC1(+) ─[2Ω]─ VC1(-)/VC2(+) ─[2Ω]─ VC2(-) ───┤
            └───                                                     ───┘

Total: 4Ω || 4Ω = 2Ω
Power: 2,000W → 1,000W per driver
```

### Main Subs: 8Ω Configuration (VCs Series + Drivers Series)

```
                    CABINET WIRING (8Ω TOTAL)
                    
NC2K (+) ────┬─── Driver 1 VC1(+) ─[2Ω]─ VC1(-)/VC2(+) ─[2Ω]─ VC2(-)
             │                                                    │
             │    (4Ω per driver, voice coils in series)         │
             │                                                    │
             │                    ┌───────────────────────────────┘
             │                    │
             │    Driver 2 VC1(+) ─[2Ω]─ VC1(-)/VC2(+) ─[2Ω]─ VC2(-)
             │                                                    │
NC2K (-) ────┴────────────────────────────────────────────────────┘

Total: 4Ω + 4Ω = 8Ω
Power: 1,600W → 800W per driver
```

### Nearfield Subs: 4Ω Configuration (VCs Series + 2S2P)

```
                    CABINET WIRING (4Ω TOTAL)
                    
                    ┌─── D1 (4Ω) ─── D2 (4Ω) ───┐   = 8Ω series pair
                    │                            │
NC2K (+) ───────────┤                            ├─── NC2K (-)
                    │                            │
                    └─── D3 (4Ω) ─── D4 (4Ω) ───┘   = 8Ω series pair

Total: 8Ω || 8Ω = 4Ω (2 series pairs in parallel)
Power: 2,500W → 625W per driver

Driver wiring detail: Each driver's voice coils in series (2Ω + 2Ω = 4Ω)
```

### Nearfield Subs: 1Ω Configuration (VCs Parallel + 2S2P)

```
                    CABINET WIRING (1Ω TOTAL)
                    
                    ┌─── D1 (1Ω) ─── D2 (1Ω) ───┐   = 2Ω series pair
                    │                            │
NC2K (+) ───────────┤                            ├─── NC2K (-)
                    │                            │
                    └─── D3 (1Ω) ─── D4 (1Ω) ───┘   = 2Ω series pair

Total: 2Ω || 2Ω = 1Ω (2 series pairs in parallel)
Power: ~3,000W → ~750W per driver (requires DSP limiting)

Driver wiring detail: Each driver's voice coils in parallel (2Ω || 2Ω = 1Ω)
```

---

## Part 5: Comparison Matrix

### All Amplifier Options Compared

| Amplifier | Main 2Ω | Main 8Ω | NF 4Ω | 10Hz Response | Total Cost |
|-----------|---------|---------|-------|---------------|------------|
| **Buckeye NC2K** | 1,000W (83%) | 800W (67%) | 625W (104%) | **Flat to DC** | **$9,800** |
| Buckeye 1ET9040BA | 600W (50%) | 188W (16%) | 188W (31%) | Flat to DC | $10,360 |
| SpeakerPower SP2-8000 | 2,000W (167%) | 750W (63%) | — | Flat to 5Hz | $11,396* |
| Crown XLS 2502 | ~700W (58%) | ~300W (25%) | ~400W (17%) | -6dB @ 10Hz | ~$5,200 |
| Behringer NX6000D | Limited | Limited | Limited | -7dB+ @ 20Hz | $4,392 |

*SpeakerPower uses SP2-8000 for main + SP2-4800 for nearfield

### Feature Comparison

| Feature | NC2K | SpeakerPower | Crown XLS | Behringer |
|---------|------|--------------|-----------|-----------|
| Frequency Response | 0Hz-50kHz | 5Hz-500Hz | 20Hz-20kHz (-6dB@10Hz) | 30Hz+ (limited) |
| 10Hz Full Power | ✓ Yes | ✓ Yes | ✗ -6dB | ✗ Severe limiting |
| Fan Noise | None (fanless) | Near-silent | Low | Loud (mod required) |
| Efficiency | 93% | 92% | ~85% | ~85% |
| Weight (per unit) | 8 lbs | 45+ lbs | 12 lbs | 18 lbs |
| Built-in DSP | No | Basic | Yes | Yes |
| 2Ω Stable | ✓ Yes | ✓ Yes | ✓ Yes | ✓ Yes |
| 1Ω Stable | ✓ Yes | ✓ Yes | ✗ No | ✗ No |
| Warranty | 2 years | 3 years | 3 years | 3 years |

---

## Part 6: Rack Layout

### 8× NC2K Monoblock Physical Configuration

```
┌─────────────────────────────────────────────────────────────┐
│                    EQUIPMENT RACK                            │
├─────────────────────────────────────────────────────────────┤
│  [NC2K #1]  [NC2K #2]  [NC2K #3]  [NC2K #4]    ← Main Subs  │  1U (2 side-by-side per U)
│  Main FL    Main FR    Main RL    Main RR                    │
├─────────────────────────────────────────────────────────────┤
│  [NC2K #5]  [NC2K #6]  [NC2K #7]  [NC2K #8]    ← Nearfield  │  1U
│  NF FL      NF FR      NF RL      NF RR                      │
├─────────────────────────────────────────────────────────────┤
│  [miniDSP 2×4 HD]  [miniDSP 2×4 HD]            ← DSP        │  1U
│  Main Subs DSP      Nearfield DSP                            │
├─────────────────────────────────────────────────────────────┤
│  [Power Conditioner]                                         │  1U
└─────────────────────────────────────────────────────────────┘

Total rack space: 4U for subwoofer amplification
Amp dimensions: 10"W × 13.5"D × 3.5"H each
Two NC2K units fit side-by-side in standard 19" rack with shelf
```

---

## Part 7: DSP Requirements

### Main Subwoofers (NC2K @ 2Ω)
- **HPF:** 10Hz, 24dB/oct (driver protection)
- **LPF:** 80Hz, 24dB/oct (integration with mains)
- **Limiting:** Not required (83% driver capacity)
- **EQ:** Room correction via Dirac ART

### Nearfield Subwoofers (NC2K @ 4Ω)
- **HPF:** 8Hz, 24dB/oct (driver protection below LT range)
- **LPF:** 120Hz, 24dB/oct (tactile range)
- **Linkwitz Transform:** 10Hz target (sealed alignment extension)
- **Limiting:** Soft limiter -0.5dB below clipping recommended
- **EQ:** Tactile response curve shaping

### DSP Hardware Options
| Device | Channels | Adequate? | Price |
|--------|----------|-----------|-------|
| miniDSP 2×4 HD | 4 out | ✓ 1 per sub system | $200 |
| miniDSP Flex | 4 out + Dirac | ✓ Premium option | $500 |
| Dayton DSP-408 | 8 out | ✓ Both systems | $250 |

---

## Part 8: Final Recommendation

### Recommended System: 8× Buckeye NC2K Monoblock

| Component | Quantity | Unit Price | Total |
|-----------|----------|------------|-------|
| NC2K Monoblock (Main) | 4 | $1,225 | $4,900 |
| NC2K Monoblock (Nearfield) | 4 | $1,225 | $4,900 |
| **Amplifier Total** | **8** | | **$9,800** |

### Why NC2K?

1. **True DC Response:** 0Hz-50kHz flat - no compensation needed for 10Hz LT
2. **Adequate Power:** 83% main / 104% nearfield driver utilization
3. **Silent Operation:** Fanless Class-D design
4. **Compact:** 8 amps in ~4U of rack space
5. **Efficient:** 93% = minimal heat, low power bills
6. **Unified Platform:** All same model simplifies spares/service
7. **Cost Effective:** $9,800 vs $11,396 SpeakerPower = $1,596 savings
8. **Proven Reliability:** Hypex NCORE used in high-end commercial products

### Wiring Summary

| System | Cabinet Z | VC Config | Driver Config | Power/Driver |
|--------|-----------|-----------|---------------|--------------|
| Main | 2Ω | Series (4Ω each) | Parallel | 1,000W (83%) |
| Nearfield | 4Ω | Series (4Ω each) | 2S2P | 625W (104%) |

---

## Cost Comparison Summary

| Configuration | Amps | Total Cost | 10Hz Power | Notes |
|---------------|------|------------|------------|-------|
| **Buckeye NC2K** | 8 | **$9,800** | Full | ⭐ Recommended |
| SpeakerPower Mixed | 4 | $11,396 | Full | +$1,596 vs Buckeye |
| Behringer NX6000D | 8 | $4,392 | Limited | Cannot sustain 10Hz |
| Crown XLS 2502 | 8 | ~$5,200 | -6dB | Requires DSP boost |

---

**Document Version:** 1.0  
**Created:** December 2025
