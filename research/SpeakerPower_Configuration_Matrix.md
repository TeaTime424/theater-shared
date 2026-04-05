# SpeakerPower Amplifier Configuration Matrix
## Complete Analysis of Impedance Options and Power Delivery

**Date:** December 2025  
**Purpose:** Determine optimal amplifier/wiring combinations for main and nearfield subwoofer systems

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

## SpeakerPower Rack Amplifier Specifications

| Model | 1Ω Stable | 2Ω/ch | 4Ω/ch | 8Ω/ch | Voltage | Price (Direct) |
|-------|-----------|-------|-------|-------|---------|----------------|
| **SP2-12000-HT** | ✓ | 6,000W | 3,200W | 1,800W | Universal (220V rated) | $3,399 |
| **SP2-8000-HT** | ✓ | 4,000W | 2,600W | 1,500W | 120V | $2,999 |
| **SP2-6400-HT** | ✓ | 3,200W | — | — | Universal (220V rated) | $3,299 |
| **SP2-4800-HT** | — | — | 2,400W | 1,200W | 120V only | $2,699 |
| **SP2-2400-HT** | — | — | 1,200W | 600W | 120V only | $2,199 |
| **SP2-1400-HT** | — | — | 700W | 350W | 120V only | $1,399 |

**Key:** Models ≤SP2-4800 are **4Ω minimum** (not suitable for 2Ω or 1Ω loads)

---

## Part 1: Main Subwoofer Configurations

### Wiring Options (2× UMII18-22 per cabinet)

Each driver has dual 2Ω voice coils. Per-driver impedance options:
- **VCs in parallel:** 2Ω ÷ 2 = **1Ω per driver**
- **VCs in series:** 2Ω + 2Ω = **4Ω per driver**

| Config | VC Wiring | Driver Wiring | Cabinet Z | Viable? |
|--------|-----------|---------------|-----------|---------|
| A | Parallel (1Ω) | Parallel | 0.5Ω | ❌ Too low |
| B | Parallel (1Ω) | Series | **2Ω** | ✓ |
| C | Series (4Ω) | Parallel | **2Ω** | ✓ |
| D | Series (4Ω) | Series | **8Ω** | ✓ |

**Viable main sub cabinet impedances: 2Ω or 8Ω**

---

### Main Sub Power Matrix (4 cabinets total)

#### Configuration: 2Ω per Cabinet

| Amp Model | Amps Needed | Channels Used | Power/Cabinet | Power/Driver | Driver % | Total Cost |
|-----------|-------------|---------------|---------------|--------------|----------|------------|
| **SP2-12000-HT** | 2 | 4 (stereo) | 6,000W | 3,000W | 250% ⚠️ | $6,798 |
| **SP2-8000-HT** | 2 | 4 (stereo) | 4,000W | 2,000W | 167% ⚠️ | $5,998 |
| SP2-6400-HT | 2 | 4 (stereo) | 3,200W | 1,600W | 133% ⚠️ | $6,598 |
| SP2-4800-HT | — | — | — | — | — | ❌ 4Ω min |
| SP2-2400-HT | — | — | — | — | — | ❌ 4Ω min |

**⚠️ Warning:** At 2Ω, all SP2 models deliver MORE power than driver thermal rating (1,200W). 
**Requires:** Aggressive DSP limiting to prevent thermal damage.

#### Configuration: 8Ω per Cabinet

| Amp Model | Amps Needed | Channels Used | Power/Cabinet | Power/Driver | Driver % | Total Cost |
|-----------|-------------|---------------|---------------|--------------|----------|------------|
| **SP2-12000-HT** | 2 | 4 (stereo) | 1,800W | 900W | 75% ✓ | $6,798 |
| **SP2-8000-HT** | 2 | 4 (stereo) | 1,500W | 750W | 63% ✓ | $5,998 |
| SP2-6400-HT | 2 | 4 (stereo) | ~1,200W | ~600W | 50% ✓ | $6,598 |
| **SP2-4800-HT** | 2 | 4 (stereo) | 1,200W | 600W | 50% ✓ | $5,398 |
| **SP2-2400-HT** | 2 | 4 (stereo) | 600W | 300W | 25% | $4,398 |

**✓ Sweet spot:** SP2-8000-HT @ 8Ω delivers 750W/driver (63% of thermal rating)

---

### Main Sub Bridged Mono Options

For maximum power per cabinet, one amp channel can drive one cabinet in bridged mono:

| Amp Model | Mode | Load | Power/Cabinet | Power/Driver | Amps for 4 Cabs | Total Cost |
|-----------|------|------|---------------|--------------|-----------------|------------|
| SP2-12000-HT | Bridged | 4Ω | ~9,000W* | 4,500W | 4 | $13,596 |
| SP2-8000-HT | Bridged | 4Ω | ~6,000W* | 3,000W | 4 | $11,996 |
| SP2-4800-HT | Bridged | 8Ω | ~3,600W* | 1,800W | 4 | $10,796 |

*Bridged power estimates (typically ~1.5× per-channel @ doubled impedance)

**Not recommended:** Bridging wastes channel capacity and doesn't scale well for 4 cabinets.

---

## Part 2: Nearfield Subwoofer Configurations

### Wiring Options (4× UMII10-22 per cabinet)

Each driver has dual 2Ω voice coils. Per-driver impedance options:
- **VCs in parallel:** 1Ω per driver
- **VCs in series:** 4Ω per driver

| Config | VC Wiring | 4-Driver Wiring | Cabinet Z | Viable? |
|--------|-----------|-----------------|-----------|---------|
| A | Parallel (1Ω) | 4P (all parallel) | 0.25Ω | ❌ Too low |
| B | Parallel (1Ω) | 2S2P | **1Ω** | ✓ (1Ω stable amps only) |
| C | Parallel (1Ω) | 4S (all series) | **4Ω** | ✓ |
| D | Series (4Ω) | 4P (all parallel) | **1Ω** | ✓ (1Ω stable amps only) |
| E | Series (4Ω) | 2S2P | **4Ω** | ✓ |
| F | Series (4Ω) | 2P2S | **4Ω** | ✓ |
| G | Series (4Ω) | 4S (all series) | **16Ω** | ✓ (low power) |

**Viable nearfield cabinet impedances: 1Ω, 4Ω, 16Ω**

**Note:** 2Ω is NOT achievable with 4 identical drivers in this configuration.

---

### Nearfield Power Matrix (4 cabinets total)

#### Configuration: 1Ω per Cabinet (requires 1Ω-stable amp)

| Amp Model | Amps Needed | Channels Used | Power/Cabinet | Power/Driver | Driver % | Total Cost |
|-----------|-------------|---------------|---------------|--------------|----------|------------|
| **SP2-12000-HT** | 2 | 4 (stereo) | ~9,000W* | 2,250W | 375% ⚠️ | $6,798 |
| **SP2-8000-HT** | 2 | 4 (stereo) | ~6,000W* | 1,500W | 250% ⚠️ | $5,998 |

*1Ω power not published; estimates based on PSU capacity

**⚠️ DANGER:** At 1Ω, power FAR exceeds driver thermal rating (600W). Would require severe DSP limiting.

#### Configuration: 4Ω per Cabinet ⭐ RECOMMENDED

| Amp Model | Amps Needed | Channels Used | Power/Cabinet | Power/Driver | Driver % | Total Cost |
|-----------|-------------|---------------|---------------|--------------|----------|------------|
| **SP2-12000-HT** | 2 | 4 (stereo) | 3,200W | 800W | 133% ⚠️ | $6,798 |
| **SP2-8000-HT** | 2 | 4 (stereo) | 2,600W | 650W | 108% | $5,998 |
| **SP2-4800-HT** | 2 | 4 (stereo) | 2,400W | 600W | 100% ✓ | $5,398 |
| **SP2-2400-HT** | 2 | 4 (stereo) | 1,200W | 300W | 50% | $4,398 |
| **SP2-1400-HT** | 2 | 4 (stereo) | 700W | 175W | 29% | $2,798 |

**✓ Best match:** SP2-4800-HT @ 4Ω delivers exactly 600W/driver (100% of thermal rating)

#### Configuration: 16Ω per Cabinet (low power, not recommended)

| Amp Model | Amps Needed | Power/Cabinet | Power/Driver | Driver % | Notes |
|-----------|-------------|---------------|--------------|----------|-------|
| Any SP2 | 2 | ~300-600W | 75-150W | 12-25% | Insufficient for 10Hz LT |

**❌ Not viable:** 16Ω wastes amplifier capacity for infrasonic duty.

---

## Part 3: Optimal System Configurations

### Option A: Maximum Headroom (Both at 2Ω/4Ω)

| System | Amp | Qty | Config | Z | Power/Driver | Cost |
|--------|-----|-----|--------|---|--------------|------|
| Main | SP2-12000-HT | 2 | Stereo | 2Ω | 3,000W (250%) | $6,798 |
| Nearfield | SP2-8000-HT | 2 | Stereo | 4Ω | 650W (108%) | $5,998 |
| **Total** | | **4** | | | | **$12,796** |

**Pros:** Massive headroom, handles any content  
**Cons:** Requires strict DSP limiting, expensive, overkill

---

### Option B: Balanced Power (8Ω Main / 4Ω Nearfield) ⭐ RECOMMENDED

| System | Amp | Qty | Config | Z | Power/Driver | Cost |
|--------|-----|-----|--------|---|--------------|------|
| Main | SP2-8000-HT | 2 | Stereo | 8Ω | 750W (63%) | $5,998 |
| Nearfield | SP2-4800-HT | 2 | Stereo | 4Ω | 600W (100%) | $5,398 |
| **Total** | | **4** | | | | **$11,396** |

**Pros:**
- Main subs at safe 63% thermal utilization with massive headroom
- Nearfield exactly matched to driver capability
- Both systems run cool
- 5Hz frequency response for 10Hz LT
- Virtually silent fans in home theater use

**Cons:** Still ~2× cost of PURIFI + Behringer

---

### Option C: Budget Optimized (8Ω Main / 4Ω Nearfield)

| System | Amp | Qty | Config | Z | Power/Driver | Cost |
|--------|-----|-----|--------|---|--------------|------|
| Main | SP2-4800-HT | 2 | Stereo | 8Ω | 600W (50%) | $5,398 |
| Nearfield | SP2-2400-HT | 2 | Stereo | 4Ω | 300W (50%) | $4,398 |
| **Total** | | **4** | | | | **$9,796** |

**Pros:** Lowest SpeakerPower cost, adequate power for most content  
**Cons:** Less headroom for peaks, nearfield may limit on sustained infrasonic content

---

### Option D: Economy with Headroom Trade-off

| System | Amp | Qty | Config | Z | Power/Driver | Cost |
|--------|-----|-----|--------|---|--------------|------|
| Main | SP2-4800-HT | 2 | Stereo | 8Ω | 600W (50%) | $5,398 |
| Nearfield | SP2-4800-HT | 2 | Stereo | 4Ω | 600W (100%) | $5,398 |
| **Total** | | **4** | | | | **$10,796** |

**Pros:** Unified platform (all same amp), full nearfield power  
**Cons:** Main subs at only 50% driver capacity

---

## Part 4: Detailed Wiring Diagrams

### Main Subs: 8Ω Configuration (VCs Series + Drivers Series)

```
                    CABINET WIRING (8Ω TOTAL)
                    
Amp (+) ────┬─── Driver 1 VC1(+) ─[2Ω]─ VC1(-)/VC2(+) ─[2Ω]─ VC2(-)
            │                                                    │
            │    (4Ω per driver, voice coils in series)         │
            │                                                    │
            │                    ┌───────────────────────────────┘
            │                    │
            │    Driver 2 VC1(+) ─[2Ω]─ VC1(-)/VC2(+) ─[2Ω]─ VC2(-)
            │                                                    │
            │    (4Ω per driver, voice coils in series)         │
            │                                                    │
Amp (-) ────┴────────────────────────────────────────────────────┘

Total: 4Ω + 4Ω = 8Ω
```

### Main Subs: 2Ω Configuration (VCs Series + Drivers Parallel)

```
                    CABINET WIRING (2Ω TOTAL)

            ┌─── Driver 1 VC1(+) ─[2Ω]─ VC1(-)/VC2(+) ─[2Ω]─ VC2(-) ───┐
            │    (4Ω per driver, voice coils in series)                 │
Amp (+) ────┤                                                           ├──── Amp (-)
            │    Driver 2 VC1(+) ─[2Ω]─ VC1(-)/VC2(+) ─[2Ω]─ VC2(-) ───┤
            └───                                                     ───┘

Total: 4Ω || 4Ω = 2Ω
```

### Nearfield Subs: 4Ω Configuration (VCs Series + 2S2P)

```
                    CABINET WIRING (4Ω TOTAL)
                    
                    ┌─── D1 (4Ω) ─── D2 (4Ω) ───┐   = 8Ω series pair
                    │                            │
Amp (+) ────────────┤                            ├──── Amp (-)
                    │                            │
                    └─── D3 (4Ω) ─── D4 (4Ω) ───┘   = 8Ω series pair

Total: 8Ω || 8Ω = 4Ω (2 series pairs in parallel)

Driver wiring: Each driver's voice coils in series (2Ω + 2Ω = 4Ω)
```

### Nearfield Subs: 1Ω Configuration (VCs Parallel + 2S2P)

```
                    CABINET WIRING (1Ω TOTAL)
                    
                    ┌─── D1 (1Ω) ─── D2 (1Ω) ───┐   = 2Ω series pair
                    │                            │
Amp (+) ────────────┤                            ├──── Amp (-)
                    │                            │
                    └─── D3 (1Ω) ─── D4 (1Ω) ───┘   = 2Ω series pair

Total: 2Ω || 2Ω = 1Ω (2 series pairs in parallel)

Driver wiring: Each driver's voice coils in parallel (2Ω || 2Ω = 1Ω)
```

---

## Part 5: Cost Comparison vs Current Plan

### Current Plan (Behringer NX6000D)

| System | Amp | Qty | Cost/Unit | Total |
|--------|-----|-----|-----------|-------|
| Main | NX6000D | 2 | $519 | $1,038 |
| Nearfield | NX6000D | 4 | $519 | $2,076 |
| Spares | NX6000D | 2 | $519 | $1,038 |
| Fans | Noctua | 16 | $15 | $240 |
| **Total** | | **8** | | **$4,392** |

### SpeakerPower Option B (Recommended)

| System | Amp | Qty | Cost/Unit | Total |
|--------|-----|-----|-----------|-------|
| Main | SP2-8000-HT | 2 | $2,999 | $5,998 |
| Nearfield | SP2-4800-HT | 2 | $2,699 | $5,398 |
| **Total** | | **4** | | **$11,396** |

### Delta Analysis

| Factor | Behringer | SpeakerPower | Difference |
|--------|-----------|--------------|------------|
| **Cost** | $4,392 | $11,396 | +$7,004 |
| **10Hz Power** | ~200-280W | Full rated | SP wins |
| **20Hz Power** | ~280-400W | Full rated | SP wins |
| **Reliability** | ~3yr typical | OEM-grade | SP wins |
| **Fan Noise** | Loud (mod required) | Near-silent | SP wins |
| **Frequency Response** | Rolls off <30Hz | Flat to 5Hz | SP wins |
| **DSP Built-in** | Yes (NX6000D) | Basic (HT models) | Behringer wins |
| **Spare Strategy** | 8 identical units | 2 different models | Behringer wins |

---

## Part 6: Final Recommendations

### For Reference-Level 10Hz Nearfield Performance

**SpeakerPower is the correct choice** because:
1. Flat response to 5Hz (Behringer rolls off below 30Hz)
2. Full sustained power at infrasonic frequencies
3. No thermal protection shutdowns during demanding content
4. Linkwitz Transform to 10Hz requires sustained power below 20Hz

### Recommended Configuration

| System | Amp | Qty | Impedance | Wiring | Power/Driver |
|--------|-----|-----|-----------|--------|--------------|
| **Main** | SP2-8000-HT | 2 | 8Ω | VCs series, drivers series | 750W (63%) |
| **Nearfield** | SP2-4800-HT | 2 | 4Ω | VCs series, 2S2P | 600W (100%) |

### Total System Cost: $11,396

This is $7,004 more than Behringer but delivers:
- True 5Hz-500Hz response (not 30Hz+ like Behringer)
- Full rated power at 10Hz for Linkwitz Transform
- OEM-grade reliability (used by JTR, Seaton, PSA, Danley)
- Near-silent operation (no fan mod required)
- Professional-grade protection circuits

---

## Appendix: Quick Reference Tables

### Main Sub Impedance Quick Reference

| VC Wiring | Driver Wiring | Cabinet Z | Power @ SP2-8000 |
|-----------|---------------|-----------|------------------|
| Series (4Ω) | Series | **8Ω** | 1,500W |
| Series (4Ω) | Parallel | 2Ω | 4,000W |
| Parallel (1Ω) | Series | 2Ω | 4,000W |

### Nearfield Impedance Quick Reference

| VC Wiring | 4-Driver Config | Cabinet Z | Power @ SP2-4800 |
|-----------|-----------------|-----------|------------------|
| Series (4Ω) | 2S2P | **4Ω** | 2,400W |
| Series (4Ω) | 4P | 1Ω | N/A (min 4Ω) |
| Series (4Ω) | 4S | 16Ω | ~400W |
| Parallel (1Ω) | 4S | 4Ω | 2,400W |
| Parallel (1Ω) | 2S2P | 1Ω | N/A (min 4Ω) |

---

**Document Version:** 1.0  
**Created:** December 2025
