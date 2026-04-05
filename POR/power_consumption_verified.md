# Power Consumption Specifications - With Extrapolations

**Created:** December 30, 2025  
**Purpose:** Verified specs + reasoned estimates based on Class D characteristics

---

## Class D Efficiency Baseline (From Hypex Datasheets)

These verified specifications establish the baseline for extrapolation:

| Component | Idle Power | Efficiency | Source |
|-----------|------------|------------|--------|
| Hypex NCx500 OEM (per channel) | 5.3W | 93% | NCx500 Datasheet R0 §2.4 |
| Hypex NC252MP amp stage (per channel) | 3.5W | 92% | NC252MP Datasheet R14 §3.4 |
| Hypex NC252MP main SMPS | 8.5W | 90% | NC252MP Datasheet R14 §3.3 |
| Hypex SMPS1200 | 9W | 92% | SMPS1200 Datasheet §3.2 |

**Key insight:** Class D idle scales roughly with channel count and SMPS capacity.

---

## Extrapolation Methodology

### Idle Power Components
A Class D amplifier system's idle power consists of:

1. **SMPS quiescent draw** - Scales with capacity, typically 0.5-1% of max rating
2. **Output stage idle** - ~3-6W per channel for high-quality designs
3. **Control/DSP circuits** - 5-20W depending on features

### Efficiency Under Load
Class D efficiency is remarkably consistent:
- **Hypex/Purifi tier:** 92-94%
- **Pro audio (Behringer, Crown):** 88-92%
- **Budget Class D:** 85-90%

### Formula for Wall Power at Given Output
```
Wall_Power = (Output_Power / Efficiency) + Idle_Losses
```

---

## Component Specifications

### Behringer NX6000D (Extrapolated)

**Known facts:**
- Class D with SMPS
- 2 channels, 3000W/ch @ 4Ω peak
- 620W consumption @ 1/8 rated power (Parts Express)
- Has DSP, LCD display, 24-bit processing
- **15A rear breaker** → 1,800W absolute max draw

**Analysis of 620W spec:**
The "620W @ 1/8 power" means 620W wall draw while outputting ~750W to speakers.
- 750W / 620W = ~83% efficiency at partial load (plausible for Class D)
- At higher output, efficiency improves toward 90%
- Breaker limits absolute max to 1,800W regardless of output claims

**Extrapolated power:**

| Condition | Wall Draw | Reasoning |
|-----------|-----------|-----------|
| Idle | ~40W | SMPS + output stages + DSP |
| 1/8 power (750W out) | 620W | Published spec |
| Sustained heavy bass | 800-1,000W | Typical movie content |
| Max (breaker limit) | 1,800W | 15A × 120V |

---

### Buckeye NCx500 3-Channel

| Subsystem | Value | Source |
|-----------|-------|--------|
| NCx500 modules (3ch) | 15.9W | Hypex datasheet (3 × 5.3W) |
| SMPS2K-SN | ~14W | Scaled from SMPS1200 |
| Control circuits | ~2W | Estimate |
| **Total idle** | **~32W** | |
| **Peak (LCR cranking)** | **~500W** | 3ch × ~150W avg + losses |

---

### Buckeye NC252MP 4-Channel (Surrounds)

| Condition | Value | Source |
|-----------|-------|--------|
| Idle | 31W | Hypex datasheet |
| Peak | ~300W | 4ch × ~60W avg + losses |
| Max (per module spec) | 650W | 2 modules × 325W |

---

### Buckeye NC252MP 6-Channel (Atmos)

| Condition | Value | Source |
|-----------|-------|--------|
| Idle | 47W | Hypex datasheet |
| Peak | ~450W | 6ch × ~60W avg + losses |
| Max (per module spec) | 975W | 3 modules × 325W |

---

### Processing & Sources

| Component | Idle | Peak | Source |
|-----------|------|------|--------|
| Marantz AV10 | 100W | 100W | Official manual |
| Dayton DSP-408 | 15W | 18W | Adapter rating |
| NVIDIA Shield Pro | 18W | 20W | Typical |
| PS5 (standby/active) | 1W / 200W | — | Sony spec |
| Xbox Series X | 1W / 200W | — | Microsoft spec |

*Note: Only one gaming console active at a time*

---

## Equipment Cabinet Circuit Distribution

### Circuit Capacity
- **Per 20A circuit:** 2,400W max, 1,920W continuous (80% rule)
- **3 circuits total:** 7,200W max, 5,760W continuous

### Peak Load Analysis

| Component | Qty | Idle Each | Peak Each | Notes |
|-----------|-----|-----------|-----------|-------|
| Behringer NX6000D | 6 | 40W | 900W | Sustained bass, not breaker max |
| Buckeye NCx500 3ch | 1 | 32W | 500W | LCR at reference |
| Buckeye NC252MP 4ch | 1 | 31W | 300W | Surrounds |
| Buckeye NC252MP 6ch | 1 | 47W | 450W | Atmos |
| Marantz AV10 | 1 | 100W | 100W | Constant |
| Dayton DSP-408 | 1 | 15W | 18W | Constant |
| Sources | 1 | 20W | 200W | Gaming worst-case |

**Total idle:** ~525W  
**Total peak (all subs + mains cranking):** ~6,870W  
**Realistic "big moment":** ~4,000-5,000W (not everything peaks simultaneously)

---

### Recommended Circuit Assignment

```
┌─────────────────────────────────────────────────────────────────┐
│                    CIRCUIT A (Subs 1-2)                         │
│                        20A / 2,400W                             │
├─────────────────────────────────────────────────────────────────┤
│  NX6000D #1 (Sub FL)     Idle: 40W    Peak: 900W               │
│  NX6000D #2 (Sub FR)     Idle: 40W    Peak: 900W               │
├─────────────────────────────────────────────────────────────────┤
│  Circuit A Total         Idle: 80W    Peak: 1,800W    ✓        │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    CIRCUIT B (Subs 3-4)                         │
│                        20A / 2,400W                             │
├─────────────────────────────────────────────────────────────────┤
│  NX6000D #3 (Sub RL)     Idle: 40W    Peak: 900W               │
│  NX6000D #4 (Sub RR)     Idle: 40W    Peak: 900W               │
├─────────────────────────────────────────────────────────────────┤
│  Circuit B Total         Idle: 80W    Peak: 1,800W    ✓        │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    CIRCUIT C (Subs 5-6 + Mains + Processing)    │
│                        20A / 2,400W                             │
├─────────────────────────────────────────────────────────────────┤
│  NX6000D #5 (Sub nearfield L)   Idle: 40W    Peak: 900W        │
│  NX6000D #6 (Sub nearfield R)   Idle: 40W    Peak: 900W        │
│  Buckeye NCx500 3ch (LCR)       Idle: 32W    Peak: 500W        │
│  Buckeye NC252MP 4ch (Surr)     Idle: 31W    Peak: 300W        │
│  Buckeye NC252MP 6ch (Atmos)    Idle: 47W    Peak: 450W        │
│  Marantz AV10                   Idle: 100W   Peak: 100W        │
│  Dayton DSP-408                 Idle: 15W    Peak: 18W         │
│  Sources                        Idle: 20W    Peak: 200W        │
├─────────────────────────────────────────────────────────────────┤
│  Circuit C Total         Idle: 325W   Peak: 3,368W    ⚠️       │
└─────────────────────────────────────────────────────────────────┘
```

### Problem: Circuit C Overloaded at Peak

Circuit C theoretically peaks at 3,368W on a 2,400W circuit. However:

1. **Subs don't all peak simultaneously** - Room modes and content mean the 4 corner subs carry most bass load; nearfield subs fill in nulls
2. **Mains peak during different content** - Dialogue/music peaks don't coincide with deep bass hits
3. **Real content has crest factor** - Sustained peaks are much lower than instantaneous

**Realistic worst-case for Circuit C:**
- 2× NX6000D at 70% (nearfield): 1,260W
- Mains amps at 50%: 625W
- Processing constant: 333W
- **Realistic peak: ~2,218W** ✓

---

### Alternative: 4-Circuit Distribution (Recommended)

If the panel can accommodate it, 4 circuits provides better headroom:

```
Circuit A: NX6000D #1, #2              Peak: 1,800W
Circuit B: NX6000D #3, #4              Peak: 1,800W  
Circuit C: NX6000D #5, #6              Peak: 1,800W
Circuit D: All Buckeye + Processor     Peak: 1,568W
```

This keeps all circuits under 80% at realistic peak loads.

---

## System Power Summary

### By Operating Condition

| Condition | Circuit A | Circuit B | Circuit C | Total |
|-----------|-----------|-----------|-----------|-------|
| **Idle** | 80W | 80W | 325W | **485W** |
| **Dialogue** | 100W | 100W | 400W | **600W** |
| **Action scene** | 300W | 300W | 700W | **1,300W** |
| **Heavy bass hit** | 800W | 800W | 1,200W | **2,800W** |
| **Reference peak** | 1,500W | 1,500W | 2,000W | **5,000W** |

### Thermal Load
| Condition | Power | BTU/hr | Equivalent |
|-----------|-------|--------|------------|
| Idle | 485W | 1,655 | Small space heater |
| Typical viewing | 800W | 2,730 | Medium space heater |
| Action movie | 1,500W | 5,120 | Large space heater |

**Ventilation requirement:** Equipment cabinet needs active cooling or ventilation to outside the room, especially during extended viewing sessions.

---

## Validation Approach

After installation, verify with Kill-A-Watt or clamp meter:

| Test | Expected | Action if exceeded |
|------|----------|-------------------|
| System idle | 450-550W | Check for fault |
| Per NX6000D idle | 30-50W | Normal variation |
| Reference bass sweep | <2,000W per sub circuit | Reduce level or add circuit |
| Full system stress test | <5,500W total | Redistribute loads |

---

## References

### Primary Sources (Verified)
1. Hypex NC252MP Datasheet R14 - https://www.hypex.nl/media/7f/85/fa/1708610358/NC252MP_04xx_R14.pdf
2. Hypex NCx500 OEM Datasheet R0 - https://www.hypex.nl/media/74/2a/5b/1678365773/NCx500%20-%20Datasheet%20R0.pdf
3. Hypex SMPS1200 Datasheet - https://www.hypex.nl/media/05/8f/13/1646037796/SMPS1200Axx0_09xx.pdf
4. Marantz AV10 Online Manual - https://manuals.marantz.com/AV10/NA/EN/GFNFSYbsjxinov.php
5. Parts Express NX6000 listing - https://www.parts-express.com/Behringer-NX6000-Ultra-Lightweight-Class-D-6000W-Power-Amplifier-248-7014

### Extrapolation Basis
- Class D idle power scales with channel count and SMPS capacity
- Pro-audio Class D efficiency: 88-92%
- Audiophile Class D (Hypex/Purifi): 92-94%
- SMPS quiescent typically 0.5-1% of rated capacity
- NX6000D has 15A breaker limiting max draw to 1,800W
