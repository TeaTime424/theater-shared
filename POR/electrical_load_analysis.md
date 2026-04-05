# Electrical Load Analysis
## Home Theater System - Complete Power Requirements

**Document Purpose:** Determine circuit requirements for all theater electronics  
**Created:** December 30, 2024  
**Last Updated:** December 31, 2024  
**Status:** VERIFIED - Buckeye load confirmed

---

## Executive Summary

**Total dedicated 20A circuits required: 4-5 minimum**

Key verification: **All 3 Buckeye amplifiers confirmed to not exceed a single 15A circuit at max output** (per Dylan at Buckeye Amplifiers, December 2024).

---

## Complete Equipment Inventory

### Subwoofer / Bass Amplification (NX6000D)

| Unit | Purpose | Idle | Moderate | Peak |
|------|---------|------|----------|------|
| NX6000D #1 | Primary subs (2 drivers) | 40W | 200W | 500W |
| NX6000D #2 | Primary subs (2 drivers) | 40W | 200W | 500W |
| NX6000D #3 | Primary subs (2 drivers) | 40W | 200W | 500W |
| NX6000D #4 | Primary subs (2 drivers) | 40W | 200W | 500W |
| NX6000D #5 | Nearfield sub (Row 1) | 40W | 150W | 400W |
| NX6000D #6 | Nearfield sub (Row 2) | 40W | 150W | 400W |
| **Subtotal (6 active)** | | **240W** | **1,100W** | **2,800W** |

**Note:** NX6000D peak draw is ~620W at 1/8 rated power per manufacturer spec. Real-world sustained peaks ~500W typical.

### Main Speaker Amplification (Buckeye Hypex)

| Unit | Purpose | Channels | Idle | Moderate | Peak |
|------|---------|----------|------|----------|------|
| NC502MP 8ch | LCR + Surrounds | 8 | 30W | 100W | 400W |
| NC252MP 6ch | Atmos Height | 6 | 25W | 60W | 250W |
| NC252MP 6ch | Tactile (Crowson) | 6 | 25W | 60W | 250W |
| **Subtotal** | | **20** | **80W** | **220W** | **900W** |

**⚠️ VERIFIED:** All 3 Buckeye amplifiers combined will not exceed 15A @ 120V (1,800W) at maximum simultaneous output. Confirmed by Dylan at Buckeye Amplifiers, December 2024.

### Processing & Control

| Unit | Purpose | Idle | Active | Peak |
|------|---------|------|--------|------|
| Marantz AV10 | Processor | 50W | 70W | 80W |
| miniDSP Flex HT | Bass management | 10W | 12W | 15W |
| Trigger Distribution Box | 12V relay buffer | 5W | 6W | 6W |
| **Subtotal** | | **65W** | **88W** | **101W** |

### Display

| Unit | Purpose | Idle/Standby | Active | Peak |
|------|---------|--------------|--------|------|
| Projector (TBD ~$30K laser) | Display | <1W | 400W | 450W |
| **Subtotal** | | **<1W** | **400W** | **450W** |

**Reference:** High-end 4K/8K laser projectors (JVC NZ-series, Sony VW-series) typically draw 400-500W. JVC DLA-NZ9 spec: 440W. Sony VPL-VW890: 490W.

### Source Components (Estimated)

| Unit | Purpose | Idle | Active | Peak |
|------|---------|------|--------|------|
| Zappiti media player | Physical/local media | 30W | 50W | 60W |
| Streaming device | Digital media | 10W | 15W | 20W |
| Gaming console | Gaming | 15W | 150W | 200W |
| Media server/NAS | Local storage | 50W | 75W | 100W |
| Network switch | Infrastructure | 15W | 20W | 25W |
| **Subtotal** | | **120W** | **310W** | **405W** |

### Support Systems

| Unit | Purpose | Idle | Active | Peak |
|------|---------|------|--------|------|
| Rack cooling (AC Infinity) | Thermal management | 10W | 30W | 50W |
| LED lighting (dimmable) | Ambient | 5W | 50W | 100W |
| Control system (if any) | Automation | 10W | 15W | 20W |
| **Subtotal** | | **25W** | **95W** | **170W** |

---

## Total System Load Summary

| Condition | Total Load | Notes |
|-----------|------------|-------|
| **Idle/Standby** | ~430W | All equipment on, no playback |
| **Moderate Listening** | ~2,060W | Typical movie viewing |
| **Reference Peaks** | ~4,825W | Demanding content, all systems active |
| **Absolute Maximum** | ~5,350W+ | Sustained reference + all peaks simultaneous |

---

## Circuit Capacity (US 120V)

| Circuit | Max Draw | NEC 80% Continuous | Notes |
|---------|----------|-------------------|-------|
| 15A @ 120V | 1,800W | 1,440W | Standard outlet |
| 20A @ 120V | 2,400W | 1,920W | Typical dedicated circuit |
| 30A @ 120V | 3,600W | 2,880W | Special installation |
| 20A @ 240V | 4,800W | 3,840W | If available |

---

## Recommended Circuit Allocation

### Circuit 1: Subwoofer Amplifiers Group A (20A dedicated)

| Equipment | Peak Load |
|-----------|-----------|
| NX6000D #1 (Primary subs) | 500W |
| NX6000D #2 (Primary subs) | 500W |
| NX6000D #3 (Primary subs) | 500W |
| **Total** | **1,500W** |
| **Headroom** | 420W (22%) ✓ |

### Circuit 2: Subwoofer Amplifiers Group B (20A dedicated)

| Equipment | Peak Load |
|-----------|-----------|
| NX6000D #4 (Primary subs) | 500W |
| NX6000D #5 (Nearfield Row 1) | 400W |
| NX6000D #6 (Nearfield Row 2) | 400W |
| **Total** | **1,300W** |
| **Headroom** | 620W (32%) ✓ |

### Circuit 3: Main Speaker Amplifiers (15A or 20A dedicated)

| Equipment | Peak Load |
|-----------|-----------|
| Buckeye NC502MP 8ch (LCR + Surrounds) | 400W |
| Buckeye NC252MP 6ch (Atmos) | 250W |
| Buckeye NC252MP 6ch (Tactile) | 250W |
| **Total** | **900W** |
| **Headroom on 15A** | 900W (50%) ✓ |
| **Headroom on 20A** | 1,020W (53%) ✓ |

**✓ CONFIRMED:** Buckeye designer verified all 3 amps will not exceed 15A at max output.

### Circuit 4: Processing & Projector (20A dedicated)

| Equipment | Peak Load |
|-----------|-----------|
| Marantz AV10 | 80W |
| miniDSP Flex HT | 15W |
| Trigger Distribution Box | 6W |
| Projector | 450W |
| **Total** | **551W** |
| **Headroom** | 1,369W (71%) ✓ |

### Circuit 5: Sources & Support (15A or 20A)

| Equipment | Peak Load |
|-----------|-----------|
| Source components | 405W |
| Rack cooling | 50W |
| LED lighting | 100W |
| Control system | 20W |
| **Total** | **575W** |
| **Headroom** | 1,225W+ ✓ |

---

## Circuit Summary

| Circuit | Rating | Purpose | Peak Load | Status |
|---------|--------|---------|-----------|--------|
| 1 | 20A | Subwoofer Amps A (NX6000D ×3) | 1,500W | **REQUIRED** |
| 2 | 20A | Subwoofer Amps B (NX6000D ×3) | 1,300W | **REQUIRED** |
| 3 | 15A | Main Speaker Amps (Buckeye ×3) | 900W | **REQUIRED** ✓ Verified |
| 4 | 20A | Processing + Projector | 551W | **REQUIRED** |
| 5 | 15-20A | Sources + Support | 575W | **RECOMMENDED** |

**Minimum: 4× dedicated circuits (3× 20A + 1× 15A)**  
**Recommended: 5× dedicated circuits**

---

## 12V Trigger Power Control

### NX6000D Amps (Circuits 1 & 2)

The NX6000D amplifiers produce turn-off thump when AC power is cut. Solution: internal relay mod triggered by AV10's 12V output via buffered distribution box.

**See:** [NX6000_12V_Trigger_Mod.md](NX6000_12V_Trigger_Mod.md)

| Component | Function |
|-----------|----------|
| Marantz AV10 Trigger Out 1 | 12V / 150mA source |
| Trigger Distribution Box | Buffered 6-output splitter with PTC protection |
| NX6000D internal mod (×6) | Relay triggers soft power button |

**Signal Flow:**
```
AV10 Trigger Out → Distribution Box → 6× NX6000D trigger inputs
                        ↑
              12V 500mA wall adapter (current source)
```

### Buckeye Amps (Circuit 3)

Buckeye amplifiers have 12V trigger input capability. Can daisy-chain or use AV10's second trigger output.

| Option | Implementation |
|--------|----------------|
| Daisy-chain | AV10 Trigger Out 2 → NC502MP → NC252MP → NC252MP |
| Parallel | Second trigger distribution box (simpler version) |

### Trigger Output Allocation

| AV10 Output | Destination | Load |
|-------------|-------------|------|
| Trigger Out 1 | NX6000D Distribution Box | ~40mA |
| Trigger Out 2 | Buckeye amps (direct or daisy) | ~30mA |

Both outputs operate well within AV10's 150mA per output capacity.

---

## Inrush Current Consideration

Class D amplifiers have significant inrush current when powered on.

| Scenario | Inrush Risk | Mitigation |
|----------|-------------|------------|
| 3× NX6000D on Circuit 1 | MODERATE | Relay sequencing inherent in soft-start |
| 3× NX6000D on Circuit 2 | MODERATE | Relay sequencing inherent in soft-start |
| 3× Buckeye on Circuit 3 | LOW | Efficient Class D, modest inrush |

**Note:** The 12V trigger relay mod causes each NX6000D to execute its native soft-start sequence, which inherently limits inrush current. No additional sequencing required.

---

## Wiring Recommendations

### Dedicated Circuits

All dedicated circuits should be:
- Home run to panel (no shared neutrals)
- 12 AWG minimum for 20A, 14 AWG acceptable for 15A
- Spec-grade or hospital-grade outlets
- Isolated ground optional (reduces noise floor)

### Outlet Placement

| Location | Circuits | Outlets |
|----------|----------|---------|
| Equipment rack (front stage area) | 1, 2, 3, 4 | 4× duplex minimum |
| Projector location (ceiling/shelf) | 4 (or separate) | 1× duplex |
| Rear equipment area (if applicable) | 5 | 2× duplex |

### Conduit/Raceway

Consider:
- Dedicated conduit for audio circuits (separate from lighting/HVAC)
- Adequate pull boxes for future expansion
- Label all circuits clearly at panel and outlets

---

## Budget Impact

| Item | Estimated Cost |
|------|----------------|
| 3× dedicated 20A circuits (labor + materials) | $600-1,200 |
| 2× dedicated 15A circuits | $300-600 |
| 12V trigger distribution box (DIY) | ~$34 |
| Per-amp relay mods (×6 NX6000D) | ~$41 |
| Trigger cables (×7) | ~$23 |
| Spec-grade outlets (×10) | $100-200 |
| **Total Electrical Addition** | **$1,100-2,100** |

---

## Verification Log

| Date | Item | Source | Status |
|------|------|--------|--------|
| 2024-12-31 | Buckeye 3-amp load ≤15A | Dylan @ Buckeye | ✓ CONFIRMED |
| 2024-12-31 | JVC NZ9 projector power 440W | ProjectorCentral specs | ✓ CONFIRMED |
| 2024-12-30 | AV10 trigger spec 150mA ×2 | Marantz specs | ✓ CONFIRMED |
| 2024-12-30 | NX6000D 1/8 power draw 620W | Behringer specs | ✓ CONFIRMED |

---

**Document Version:** 1.1  
**Next Review:** Prior to construction electrical rough-in
