# Home Theater System - Complete Design
## Rev 5.9 — "Weapons-Grade Bass"

**Last Updated:** December 31, 2024  
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

All enclosures present **8Ω load** to amplifiers:
- Each driver: Voice coils in series (2Ω + 2Ω = 4Ω)
- Two drivers per enclosure in series (4Ω + 4Ω = 8Ω)

---

## Tactile Bass System

| Spec | Value |
|------|-------|
| Model | Aura Pro AST-2B-4 |
| Quantity | 16 total (8 per couch) |
| Impedance | 4Ω each |
| Amplification | NX6000D bridged @ 4Ω (~1,600W) |
| Frequency Range | 20-80 Hz |
| Cost | ~$1,120 |

---

## Amplification

### Subwoofer Amplifiers — Unified NX6000D Platform

| Unit | Assignment | Mode | Load |
|------|------------|------|------|
| NX6000D #1 | Main subs FL + FR | Stereo | 8Ω |
| NX6000D #2 | Main subs RL + RR | Stereo | 8Ω |
| NX6000D #3 | Front nearfield (2 cabs) | Stereo | 8Ω |
| NX6000D #4 | Rear nearfield (2 cabs) | Stereo | 8Ω |
| NX6000D #5 | Bass shakers (16×) | Bridged | 4Ω |
| NX6000D #6 | **Spare** | Any | — |

**Fan Modification Required:** Replace stock fans with Noctua NF-R8 redux-1800 (~17 dB vs 40 dB stock)

**12V Trigger System:** Custom distribution box buffers AV10 trigger output to control all 6 NX6000D via internal relay mod (soft power on/off, eliminates turn-off thump)

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| NX6000D amplifiers | 6 | $519 | $3,114 |
| Noctua fans | 12 | $15 | $180 |
| **Subtotal** | | | **$3,294** |

### Main Speaker Amplifiers — Buckeye Hypex

| Amplifier | Channels | Assignment | Power |
|-----------|----------|------------|-------|
| NC502MP 8-ch | 8 | LCR + Surrounds | 500W @ 4Ω |
| NC252MP 6-ch | 6 | Atmos Heights | 250W @ 4Ω |
| NC252MP 6-ch | 6 | Tactile (Crowson alternative path) | 250W @ 4Ω |

**Verified:** All 3 Buckeye amplifiers combined will not exceed 15A @ 120V at maximum output (confirmed by Dylan at Buckeye, December 2024)

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

**Note:** DSP-408 minimum HPF/LPF is 20Hz, not 10Hz.

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
         (NX6000D   (NX6000D   (NX6000D
          #1-2)      #3-4)      #5)
```

---

## Electrical Requirements

### Circuit Allocation (Verified)

| Circuit | Rating | Equipment | Peak Load |
|---------|--------|-----------|-----------|
| 1 | 20A | NX6000D #1, #2, #3 (subs) | 1,500W |
| 2 | 20A | NX6000D #4, #5, #6 (subs + shakers) | 1,300W |
| 3 | **15A** | All Buckeye amps (verified ≤15A) | 900W |
| 4 | 20A | Processor + Projector + DSP | 551W |
| 5 | 15A | Sources + Support | 575W |

**Total:** 4-5 dedicated circuits required

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
| LF System (subs + shakers + amps) | $12,327 | 16% |
| Speakers (LCR + Surround + Atmos) | $9,500 | 13% |
| Electronics (processor + amps + DSP) | $9,700 | 13% |
| Seating (2× 11-foot couches) | $6,000 | 8% |
| Acoustic Treatment | $5,500 | 7% |
| Screen | $3,000 | 4% |
| Infrastructure (riser, stage, rack) | $3,300 | 4% |
| **TOTAL** | **~$75,000** | 100% |

---

## Key Design Decisions

### Why 16× 18-inch Drivers (All Same Size)

- UMII18-22's low Fs (22 Hz) minimizes EQ boost needed for 15 Hz nearfield
- Smaller drivers (UMII10, UMII12) require +15-20 dB EQ at 15 Hz — unusable
- Unified driver platform simplifies spares and maintenance
- "Overkill" displacement ensures effortless reference+ performance

### Why NX6000D Over PURIFI/Crown

- **vs PURIFI:** $5,000+ savings, adequate power at 8Ω loads
- **vs Crown XLS:** Crown has forced-air fans (noise) and exceeds safe excursion at full power
- **Unified platform:** Single spare covers entire bass infrastructure
- **Fan mod:** Noctua swap achieves acceptable noise floor

### Why Corner Columns (Triangular)

- +5 dB more output at 20 Hz vs rectangular boxes
- Optimal Qtc (0.72) vs peaky (0.95) alignment
- Architectural integration — columns disappear visually
- Integrated acoustic treatment (~88 sq ft)
- Smaller footprint per cabinet

### Why Nearfield Subwoofers (Not Just Shakers)

- **108+ dB @ 15 Hz at 15"** — true chest compression
- Air-coupled bass pressure vs mechanical vibration only
- No couch modification required
- Same amp platform as main subs (shared spares)
- Full infrasonic capability

---

## Document Files (Local: C:\Claude\HT\)

### Core Documentation
- `00_Master_Index.md` — Navigation hub
- `01_Project_Overview_and_Room.md` — Room specs
- `02_Front_Stage_System.md` — Stage construction
- `03_Subwoofer_System.md` — Complete sub system details
- `04_Seating_and_Riser.md` — Platform construction
- `05_Speaker_System.md` — Speaker specs
- `06_Electronics_and_Control.md` — Signal flow, processing
- `11_Budget_Summary.md` — Cost breakdown

### Reference Documents
- `Behringer_NX6000_Reference.md` — Amp specs, DSP limits
- `NX6000_12V_Trigger_Mod.md` — Power control system
- `electrical_load_analysis.md` — Circuit requirements
- `Subwoofer_Amplifier_Comparison.md` — Amp selection rationale
- `Buckeye_Configuration_Matrix.md` — Alternative amp configs

---

## Revision History

| Rev | Date | Changes |
|-----|------|---------|
| 5.0 | Nov 2024 | Upgraded Atmos to Volt-10 |
| 5.5 | Dec 2024 | PURIFI → NX6000D amplifiers |
| 5.6 | Dec 2024 | Added nearfield UMII10 concept |
| 5.7 | Dec 2024 | Unified bass shaker platform |
| 5.8 | Dec 2024 | "Weapons-Grade": 16× UMII18-22 |
| **5.9** | **Dec 2024** | **Triangular corner columns, verified electrical** |

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
├── Amplification: 6× Behringer NX6000D
└── Total Displacement: 3.24 cu ft per stroke

ELECTRONICS:
├── Processor: Marantz AV10 (Dirac ART)
├── Speaker Amps: Buckeye Hypex (NC502MP + NC252MP)
├── Sub DSP: Dayton DSP-408
└── Projector: ~$30K laser (TBD 2027)

ELECTRICAL: 5 dedicated circuits (3×20A + 2×15A)
BUDGET: ~$75,000 recommended
BUILD: 2027
```

---

**Document Version:** 5.9 Consolidated  
**Purpose:** Single-file reference for mobile/cross-device access  
**Full Documentation:** C:\Claude\HT\ (15+ files)
