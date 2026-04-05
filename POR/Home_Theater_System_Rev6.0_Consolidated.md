# Home Theater System - Complete Design
## Rev 6.0 — "Weapons-Grade Bass"

**Last Updated:** February 20, 2025  
**Construction Target:** 2027  
**Budget:** $75,000-95,000 (recommended ~$75,000)

---

## Project Overview

**Configuration:** 9.4.6 Dolby Atmos  
**Primary Goal:** THX Reference level (105+ dB) at all listening positions with exceptional 20Hz performance  
**Philosophy:** No-compromise reference system through DIY construction and careful component selection

---

## Room Specifications

| Parameter | Value |
|-----------|-------|
| Width | 16 feet |
| Depth | 26 feet |
| Height | 10 feet |
| Volume | 4,160 cubic feet |
| Screen | 170" diagonal, 2.35:1 aspect ratio, acoustically transparent |

### Layout

| Zone | Distance from Screen | Elevation |
|------|---------------------|-----------|
| Front Stage | 0-2.5 ft | 27" platform |
| Row 1 Seating | 13 ft | Floor level |
| Row 2 Seating | 18 ft | 24" riser platform |
| Rear Wall | 26 ft | — |

---

## Speaker System

### Main Channels (LCR)

| Spec | Value |
|------|-------|
| Model | DIYSG Titan-815LX |
| Quantity | 3 (matched L/C/R) |
| Placement | Behind AT screen on 27" stage |
| Isolation | Sorbothane 50 duro hemispheres (4 per speaker) |
| Cost | ~$4,800 |

### Surrounds

| Spec | Value |
|------|-------|
| Model | DIYSG HT-12 |
| Sensitivity | 96 dB @ 2.83V/1m |
| Quantity | 6 total (2 side + 4 rear) |
| Cost | ~$2,400 |

### Atmos Height Channels

| Spec | Value |
|------|-------|
| Model | DIYSG Volt-10 |
| Sensitivity | 98 dB @ 2.83V/1m |
| Quantity | 6 (4 front + 2 rear) |
| Capability | 107-108 dB at listening positions |
| Cost | ~$2,100 |

**Total Speaker Cost:** ~$9,500

---

## Subwoofer System — "Weapons-Grade Bass"

### Driver Selection

| Spec | Value |
|------|-------|
| Model | Dayton Audio UMII18-22 |
| Size | 18-inch |
| **Total Quantity** | **16 drivers** |
| Fs | 22 Hz |
| Xmax | 28mm (Klippel verified) |
| Power Handling | 1,200W RMS each |
| Voice Coil | Dual 2Ω (wired series = 4Ω) |
| Unit Cost | $349.98 |
| **Total Driver Cost** | **$5,600** |

### System Architecture

| Subsystem | Drivers | Enclosures | Location |
|-----------|---------|------------|----------|
| Main Array | 8× UMII18-22 | 8× triangular columns (2 per corner) | 4 corners, floor-to-ceiling |
| Front Nearfield | 4× UMII18-22 | 2× dual-driver (16 cu ft each) | Riser face, 15" from chest |
| Rear Nearfield | 4× UMII18-22 | 2× dual-driver (25 cu ft each) | Console towers, 15" from chest |
| **Total** | **16 drivers** | **12 enclosures** | |

### Main Subwoofers — Triangular Corner Columns

- **Design:** Floor-to-ceiling triangular columns integrated into room corners
- **Construction:** Split-build (2× 48" cabinets per corner), joined on install
- **Volume:** ~10.25 cu ft per driver (20.5 cu ft per corner)
- **Alignment:** Fc 30 Hz, Qtc 0.72 (optimal Butterworth)
- **Corner Loading:** +10-12 dB gain from full boundary reinforcement
- **Integrated Treatment:** 2" OC 703 face provides ~88 sq ft absorption
- **Finish:** AT fabric wrapped (Guilford FR701)

### Nearfield Subwoofers

| Parameter | Front (Riser) | Rear (Console) |
|-----------|---------------|----------------|
| Physical Volume | 16 cu ft each | 25 cu ft each |
| Virtual Volume (stuffed) | ~22 cu ft | ~34 cu ft |
| Fc | ~30 Hz | ~27 Hz |
| Distance to Listener | 15" from chest | 15" from chest |
| SPL @ 15Hz @ 15" | ~121 dB | ~123 dB |

### Performance Summary

| Metric | Value | vs THX Reference |
|--------|-------|------------------|
| Main Array @ 20Hz @ MLP | ~113 dB | +8 dB |
| Main Array @ 30Hz @ MLP | ~115 dB | +10 dB |
| Nearfield @ 15Hz @ 15" | ~120+ dB | Chest compression |
| Peak Combined Output | ~130 dB | "Weapons-grade" |
| Total Displacement/Stroke | 3.24 cu ft | 25× SVS SB-16 Ultra |
| Total Cone Area | 20.4 sq ft | Larger than plywood sheet |

### Wiring Configuration

Each driver presents **4Ω load** to its own amplifier channel:
- Each driver: Voice coils in series (2Ω + 2Ω = 4Ω)
- One ICEpower 1200AS2 channel per driver (individual control)
- 16 discrete amplifier channels for 16 drivers

---

## Tactile Bass System

| Spec | Value |
|------|-------|
| Model | Aura Pro AST-2B-4 |
| Quantity | 16 total (8 per couch) |
| Impedance | 4Ω each |
| Amplification | ICEpower 1200AS2 module #9, stereo mode |
| Wiring | 8 shakers per couch: 2 parallel groups of 4 series = 8Ω per couch |
| Power | 610W/ch @ 8Ω = ~76W per shaker |
| Frequency Range | 20-80 Hz |
| Cost | ~$1,120 |

---

## Amplification

### Subwoofer & Bass Amplifiers — Unified ICEpower 1200AS2 Platform

**Module:** ICEpower 1200AS2 (2-channel, integrated PFC power supply)

| Spec | Value |
|------|-------|
| Power per channel @ 4Ω (240V) | 700W |
| Power per channel @ 4Ω (120V) | 670W |
| Power per channel @ 8Ω | 610W |
| Minimum load | 2.7Ω |
| Cooling | Fanless (ICEedge technology, aluminum baseplate) |
| Power supply | Integrated PFC (100-240V auto-sensing) |
| 12V trigger | Built-in |
| Monitoring | Per-channel Vmon/Imon outputs |
| Unit cost | $373 (Parts Express) |

### Module Assignments

| Module | Assignment | Load | Power/Driver |
|--------|------------|------|-------------|
| #1 | Main sub FL corner (2 drivers) | 4Ω/ch | 700W each |
| #2 | Main sub FR corner (2 drivers) | 4Ω/ch | 700W each |
| #3 | Main sub RL corner (2 drivers) | 4Ω/ch | 700W each |
| #4 | Main sub RR corner (2 drivers) | 4Ω/ch | 700W each |
| #5 | Front nearfield cab 1 (2 drivers) | 4Ω/ch | 700W each |
| #6 | Front nearfield cab 2 (2 drivers) | 4Ω/ch | 700W each |
| #7 | Rear nearfield cab 1 (2 drivers) | 4Ω/ch | 700W each |
| #8 | Rear nearfield cab 2 (2 drivers) | 4Ω/ch | 700W each |
| #9 | Bass shakers (couch 1 + couch 2) | 8Ω/ch | 610W/ch |
| #10 | **Spare** | Any | — |

**Total: 10 modules (8 subs + 1 shakers + 1 spare)**

### Why ICEpower 1200AS2 Over NX6000D

| Feature | ICEpower 1200AS2 | Behringer NX6000D |
|---------|-------------------|-------------------|
| Driver control | **16 individual channels** | 8 series-pairs |
| Cooling | **Fanless native** | Fan mod required (Noctua) |
| 12V trigger | **Built-in** | Custom relay mod required |
| Power @ 4Ω (240V) | **700W/ch** | ~425W/driver (series pair) |
| Power @ 15Hz (nearfield) | **~550W available** | ~300-340W/driver |
| Nearfield SPL @ 15Hz | **~117-119 dB** | ~114-116 dB |
| Burst duration (240V) | **90 seconds** | ~15 seconds |
| Driver monitoring | **Vmon/Imon per channel** | None |
| Total cost | ~$3,730 | ~$3,294 (after mods) |
| Real cost delta | **~$250-300 more** (no mods needed) | Requires fan + trigger mods |

**Key advantage:** +2-3 dB nearfield output at 15Hz moves from "chest compression" to "full violence" territory. Individual driver control enables per-driver EQ, delay, and protection via DSP.

### Main Speaker Amplifiers — Buckeye Hypex

| Amplifier | Channels | Assignment | Power |
|-----------|----------|------------|-------|
| NC502MP 8-ch | 8 | LCR + Surrounds | 500W @ 4Ω |
| NC252MP 6-ch | 6 | Atmos Heights | 250W @ 4Ω |

**Verified:** All Buckeye amplifiers combined will not exceed 15A @ 120V at maximum output (confirmed by Dylan at Buckeye, December 2024)

### Amplification Cost Summary

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| ICEpower 1200AS2 modules | 10 | $373 | $3,730 |
| Wiring harnesses / mounting | — | — | ~$100 |
| **LF Amplification Subtotal** | | | **~$3,830** |

---

## Electronics & Processing

### AV Processor

| Spec | Value |
|------|-------|
| Model | Marantz AV10 |
| Processing | 15.4 channels |
| Room Correction | Dirac Live + Bass Control + ART |
| Subwoofer Outputs | 4 independent (Dirac ART) |
| HDMI | 2.1 (7 in / 3 out), 8K capable |
| Cost | ~$7,000 |

**Alternative Under Investigation:** StormAudio ISP Elite MK3 24-channel ($26,000) — provides individual driver control for all 24+ bass channels. Decision pending professional consultation.

### Bass Management DSP

| Spec | Value |
|------|-------|
| Model | Dayton DSP-408 (or miniDSP Flex HT) |
| Inputs | 4 (from AV10 sub outputs) |
| Outputs | 8 |
| Functions | HPF (20Hz), PEQ, delay, level |
| Cost | ~$250 |

**Note:** DSP-408 minimum HPF/LPF is 20Hz, not 10Hz. For nearfield systems targeting 15Hz, external DSP (miniDSP 2x4 HD with custom biquads) handles sub-20Hz processing.

### Signal Flow

```
Sources → Marantz AV10 (Dirac processing)
              ↓
    ┌─────────┴─────────┐
    ↓                   ↓
Main Speakers      4× Sub Outputs
(direct to amps)        ↓
                   DSP-408
                       ↓
              ┌────────┼────────┐
              ↓        ↓        ↓
         Main Subs  Nearfield  Shakers
         (1200AS2   (1200AS2   (1200AS2
          #1-4)      #5-8)      #9)
              ↓        ↓        ↓
         8 drivers  8 drivers  16 shakers
         (individual channels, 4Ω each)
```

---

## Electrical Requirements

### Dedicated 100A Subpanel

A dedicated 100A subpanel is installed in the theater room, fed from the main panel via 100A double-pole breaker (#3 copper or #1 aluminum feeder). Short runs from subpanel to rack (~10-15 feet), single ground point for entire room eliminates ground loop paths.

### Subpanel Circuit Allocation

| Breaker | Type | Circuit | Equipment | Peak Load |
|---------|------|---------|-----------|-----------|
| 1-2 | 20A/240V | Bass amps group 1 | 1200AS2 #1, #2, #3 | ~20A peak |
| 3-4 | 20A/240V | Bass amps group 2 | 1200AS2 #4, #5, #6 | ~20A peak |
| 5-6 | 20A/240V | Bass amps group 3 | 1200AS2 #7, #8, #9 + spare | ~20A peak |
| 7 | 15A/120V | Speaker amps | Buckeye NC502MP + NC252MP | ~900W |
| 8 | 20A/120V | Electronics | AV10 + Projector + DSP + sources | ~600W |
| 9 | 15A/120V | Convenience | Rack lighting, test gear, soldering | Variable |
| 10 | 15A/120V | Spare | Future use | — |

**Total:** 8 breaker slots used (~20-24 available in typical 100A panel)

### Why 240V for Bass Amplification

The ICEpower 1200AS2 PFC power supply accepts 100-240V natively (no configuration needed). Operating at 240V provides:
- **6× longer burst duration:** 90 seconds vs 15 seconds at full power (both channels)
- **+30W per channel:** 700W vs 670W @ 4Ω
- **Lower current draw:** ~6.7A peak per module vs ~15.4A (reduces breaker trip risk during correlated transients)
- **Fewer circuits required:** 3× 240V/20A handles all 10 modules comfortably

**240V Outlets:** NEMA 6-20R receptacles on standard 20A double-pole breakers  
**Wiring:** 10/2 Romex (~$50-100 more per run vs 12/2 for 120V)

### Circuit Loading at 240V (Conservative)

- 3 modules per 20A/240V circuit
- Peak transient (all 3 modules, both channels full): ~20A (at breaker limit, very brief)
- Average during loud action scenes: 3-6A per circuit
- Comfortable headroom for correlated bass hits across all 16 drivers

### Projector

| Spec | Value |
|------|-------|
| Budget | $30,000 |
| Type | 4K/8K Laser (JVC NZ-series or equivalent) |
| Power Consumption | ~450W typical |
| Selection | Deferred to 2027 (technology advancing rapidly) |

---

## Construction Elements

### Front Stage Platform

- **Dimensions:** 16' W × 2.5' D × 27" H
- **Three zones:** Equipment (center), Subwoofer pockets (corners)
- **Screen mounting:** Behind false wall with AT fabric

### Riser Platform

- **Dimensions:** 16' W × 8' D × 24" H
- **Construction:** Sectional with Green Glue CLD
- **Isolation:** Sorbothane hemispheres under seating
- **Nearfield integration:** Front face houses 2× dual-driver cabinets

### Rear Wall System

- **Backrest:** 36" tall padded wall
- **AT panels above:** Absorption behind listener
- **Console:** Contains rear nearfield subwoofer towers

### Acoustic Treatment

- **Materials:** OC 703, Roxul Safe'n'Sound, Guilford FR701 fabric
- **Coverage:** Full room treatment (DIY construction)
- **Corner columns:** Provide ~88 sq ft integrated absorption
- **Cost:** ~$5,500

---

## Budget Summary

| Category | Cost | % |
|----------|------|---|
| Projector | $30,000 | 40% |
| LF System (subs + shakers + amps) | $12,863 | 17% |
| Speakers (LCR + Surround + Atmos) | $9,500 | 13% |
| Electronics (processor + amps + DSP) | $9,700 | 13% |
| Seating (2× 11-foot couches) | $6,000 | 8% |
| Acoustic Treatment | $5,500 | 7% |
| Screen | $3,000 | 4% |
| Infrastructure (riser, stage, rack, subpanel) | $3,500 | 5% |
| **TOTAL** | **~$76,000** | 100% |

### LF System Cost Breakdown

| Item | Cost |
|------|------|
| 16× UMII18-22 drivers | $5,600 |
| 10× ICEpower 1200AS2 modules | $3,730 |
| 16× Aura Pro bass shakers | $1,120 |
| Enclosure materials (plywood, bracing, hardware) | $2,000 |
| Wiring harnesses, mounting, connectors | $200 |
| Polyfill, gaskets, terminals | $213 |
| **LF System Total** | **$12,863** |

---

## Key Design Decisions

### Why 16× 18-inch Drivers (All Same Size)

- UMII18-22's low Fs (22 Hz) minimizes EQ boost needed for 15 Hz nearfield
- Smaller drivers (UMII10, UMII12) require +15-20 dB EQ at 15 Hz — unusable
- Unified driver platform simplifies spares and maintenance
- "Overkill" displacement ensures effortless reference+ performance

### Why ICEpower 1200AS2 Over NX6000D/PURIFI/Crown

- **vs NX6000D:** Individual driver control (16 channels vs 8 pairs), fanless native (no Noctua mod), built-in 12V trigger (no custom relay work), +2-3 dB at 15Hz nearfield, 6× burst duration at 240V. Real cost delta only ~$250-300 after accounting for eliminated mods.
- **vs PURIFI:** $1,350 savings (10× 1200AS2 at $3,730 vs 4× PURIFI at $5,180), comparable fanless operation, 16 channels of individual control vs 4 monoblocks driving series pairs.
- **vs Crown XLS:** Crown has forced-air fans (noise) and exceeds safe excursion at full power.
- **Unified platform:** Single spare module covers any position in entire bass infrastructure.
- **Monitoring:** Per-channel Vmon/Imon enables real-time driver protection via DSP feedback loop.

### Why Corner Columns (Triangular)

- +5 dB more output at 20 Hz vs rectangular boxes
- Optimal Qtc (0.72) vs peaky (0.95) alignment
- Architectural integration — columns disappear visually
- Integrated acoustic treatment (~88 sq ft)
- Smaller footprint per cabinet

### Why Nearfield Subwoofers (Not Just Shakers)

- **117-119 dB @ 15 Hz at 15"** — true chest compression to full violence
- Air-coupled bass pressure vs mechanical vibration only
- No couch modification required
- Same amp platform as main subs (shared spares)
- Full infrasonic capability

### Why 240V / Dedicated Subpanel

- 6× burst duration at full power (90 sec vs 15 sec) covers any action sequence
- Lower current per module reduces correlated-transient breaker trip risk
- Single ground point for entire theater eliminates ground loop paths
- Short runs from subpanel to rack (~10-15 feet), no voltage drop
- Room for future expansion (8 of ~24 slots used)

---

## Document Files (Local: D:\Projects\Claude\theater\)

### Core Documentation (POR/)
- `00_Master_Index.md` — Navigation hub
- `01_Project_Overview_and_Room.md` — Room specs
- `02_Front_Stage_System.md` — Stage construction
- `03_Subwoofer_System.md` — Complete sub system details
- `04_Seating_and_Riser.md` — Platform construction
- `05_Speaker_System.md` — Speaker specs
- `06_Electronics_and_Control.md` — Signal flow, processing
- `11_Budget_Summary.md` — Cost breakdown

### Reference Documents
- `Behringer_NX6000_Reference.md` — Legacy amp reference (superseded by 1200AS2)
- `Subwoofer_Amplifier_Comparison.md` — Original amp selection rationale
- `Buckeye_Configuration_Matrix.md` — Alternative amp configs
- `electrical_load_analysis.md` — Circuit requirements

---

## Revision History

| Rev | Date | Changes |
|-----|------|---------|
| 5.0 | Nov 2024 | Upgraded Atmos to Volt-10 |
| 5.5 | Dec 2024 | PURIFI → NX6000D amplifiers |
| 5.6 | Dec 2024 | Added nearfield UMII10 concept |
| 5.7 | Dec 2024 | Unified bass shaker platform |
| 5.8 | Dec 2024 | "Weapons-Grade": 16× UMII18-22 |
| 5.9 | Dec 2024 | Triangular corner columns, verified electrical |
| **6.0** | **Feb 2025** | **ICEpower 1200AS2 platform (16 individual channels), 240V/dedicated 100A subpanel** |

---

## Quick Reference

```
SYSTEM: 9.4.6 Dolby Atmos + Weapons-Grade Bass
ROOM: 16' × 26' × 10' (4,160 cu ft)
SCREEN: 170" 2.35:1 AT

SPEAKERS:
├── LCR: 3× DIYSG Titan-815LX
├── Surrounds: 6× DIYSG HT-12
└── Atmos: 6× DIYSG Volt-10

SUBWOOFERS:
├── Main: 8× Dayton UMII18-22 (triangular corners)
├── Nearfield: 8× Dayton UMII18-22 (riser + console)
├── Tactile: 16× Aura Pro bass shakers
├── Amplification: 10× ICEpower 1200AS2 (fanless, 240V)
│   ├── 8 modules → 16 sub drivers (individual 4Ω channels)
│   ├── 1 module → bass shakers (stereo, 8Ω/ch)
│   └── 1 module → spare
└── Total Displacement: 3.24 cu ft per stroke

ELECTRONICS:
├── Processor: Marantz AV10 (Dirac ART)
├── Speaker Amps: Buckeye Hypex (NC502MP + NC252MP)
├── Sub DSP: Dayton DSP-408
└── Projector: ~$30K laser (TBD 2027)

ELECTRICAL: Dedicated 100A subpanel
├── 3× 20A/240V circuits (bass amplification)
├── 1× 15A/120V (speaker amps)
├── 1× 20A/120V (electronics)
├── 1× 15A/120V (convenience)
└── 1× 15A/120V (spare)

BUDGET: ~$76,000 recommended
BUILD: 2027
```

---

**Document Version:** 6.0 Consolidated  
**Purpose:** Single-file reference for mobile/cross-device access  
**Full Documentation:** D:\Projects\Claude\theater\ (POR/, research/, experiments/)
