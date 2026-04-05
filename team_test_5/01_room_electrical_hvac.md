# 01 — Room, Electrical & HVAC

**Date:** 2026-03-15
**References:** specs.yaml, layout_config.json, POR/16_HVAC_Plan_Theater.md

---

## 1. Building Shell

| Parameter | Value |
|-----------|-------|
| Type | Detached garage (separate from house) |
| Internal dimensions | 29' x 23' x 10' |
| Volume | 6,670 cu ft |
| Slab | Concrete |
| Insulation | Fully insulated (walls + attic) |
| Electrical | 100A subpanel (existing) |
| Internet | 1 Gbps |
| Soundproofing | Not required (separate building) |

## 2. Partition Wall

| Parameter | Value |
|-----------|-------|
| Orientation | North-south, at 12' from west wall |
| Length | 23' (full N-S span) |
| Construction | 2x6 stud, floor to ceiling |
| Insulation | R-19 batts |
| Vapor barrier | 6-mil poly on theater side |
| Theater face | Drywall, taped, finished, painted |
| Gym face | Drywall, finished |
| STC rating | 45-50 (estimated) |
| Speaker mounting | FWL and SL mount on this wall; blocking between studs required |

The partition creates two zones:
- **Theater (east):** 17' x 23' x 10' (3,910 cu ft, 391 sq ft)
- **Gym (west):** 12' x 23' (276 sq ft)

## 3. Equipment Closet

| Parameter | Value |
|-----------|-------|
| Location | NW corner of building (gym side, backed against partition + north wall) |
| Dimensions | 4' x 4' (16 sq ft) |
| Access | From gym side (service without entering theater) |
| Contents | X6800H, ATI AT525NC, 5x ICEpower 1200AS2, 2x APM2, UPS, network switch |
| Cable routing | Through partition wall to screen/stage area |
| Heat load | ~750W idle (all equipment) |
| Ventilation | Passive vent or small exhaust fan to gym space |
| Notes | Fan noise and heat completely isolated from theater by partition wall |

## 4. Theater Door

| Parameter | Value |
|-----------|-------|
| Wall | East (exterior wall) |
| Position | 62" from NE corner |
| Width | 36" (existing personnel door, retained) |
| Swing | Into room |
| Light control | Door closed during use; weatherstrip if needed |
| Notes | No vestibule — door opens directly into theater |

## 5. Electrical Panel

| Parameter | Value |
|-----------|-------|
| Wall | East |
| Position | 50" from NE corner |
| Type | 100A subpanel (existing in building) |
| Feed | 60A from house (#2 Al 240V) |
| **VERIFY:** | Read the breaker at the house main panel to confirm 60A |

## 6. Electrical Circuits

### Circuit Schedule

| Circuit | Rating | Voltage | Load | Continuous (A) | Peak (A) |
|---------|--------|---------|------|-----------------|----------|
| Pool (existing) | 30A | 240V | Pentair IntelliFlow VSF | 15 | 25 (startup) |
| HVAC | 20A | 240V | MrCool 12K condenser | 3 | 10 (startup) |
| A — Sub amps | 20A | 240V | 5x ICEpower 1200AS2 | 0.7 | 10.4 |
| C — Processor/amps | 20A | 120V | X6800H + ATI + DSP + sources | 4 | 10 |
| D — Projector | 20A | 120V | JVC NZ500 (ceiling run) | 3.8 | 3.8 |
| F — Gym | 20A | 120V | Outlets + lighting | 2 | 5 |

### NEC Load Calculation (60A Feed)

All circuits draw from the 60A/240V feed. 120V circuits use half-amps at 240V equivalent.

**Continuous load (NEC 80% rule):**
Pool 15A + HVAC 3A + Sub amps 0.7A + Processor 2A + Projector 1.9A + Gym 1A = **23.6A**
80% of 60A = 48A. **PASSES** with 24.4A margin.

**Peak demand (worst case simultaneous):**
Pool 15A + HVAC 10A + Sub amps 10.4A + Processor 5A + Projector 1.9A + Gym 1A = **43.3A**
43.3A < 60A. **PASSES** with 16.7A margin.

**Risk note:** Pool pump + HVAC startup overlap is the worst case. Pool pump is on a timer; schedule to avoid overlap with theater hours. HVAC startup is inverter-driven (soft start). Non-issue in practice.

## 7. HVAC System

### Selected Unit

| Parameter | Value |
|-----------|-------|
| Model | MrCool DIY 5th Generation 12K BTU |
| Voltage | 208-230V / 60Hz / 1-phase |
| Refrigerant | R-454B (pre-charged) |
| SEER2 | 23.5 |
| Installation | DIY Quick Connect (no EPA 608, no vacuum pump) |
| Cost | ~$2,559 total ($2,359 system + $200 hardware) |

### Placement

| Parameter | Value |
|-----------|-------|
| Indoor head | Partition wall (west wall of theater), 7-8' high, 2-4' from north wall |
| Finish | Painted flat black |
| Condenser | North exterior wall, wall-bracket or ground pad |
| Lineset | Condenser (north wall) -> gym space -> partition wall -> head unit (~10-14' run) |
| Condensate | Gravity drain through partition wall to gym side |
| Disconnect | Non-fused 240V, within 6' of outdoor unit |

### Noise Performance

| Fan Speed | dB(A) | Context |
|-----------|-------|---------|
| Silent mode | 23.5 | At or below room ambient |
| Low | 31-37 | Quiet library |
| Medium | 38-41 | Pre-cool only |

**Protocol:** Pre-cool room before movie (medium/high speed). Drop to silent/off during playback. The 12K unit is oversized for the actual 4,300-6,300 BTU/hr theater load, so it will maintain temperature at silent speed.

### Equipment Closet Ventilation

The equipment closet generates ~750W idle heat in 64 cu ft. Without ventilation, temperature would rise rapidly. Solutions (simplest first):
1. **Passive vent** — louvered grille to gym space (top of closet wall + bottom return)
2. **Exhaust fan** — small 4" inline fan, thermostat-controlled, exhausting to gym
3. Gym HVAC (deferred) will handle displaced closet heat when installed

### Gym HVAC

Deferred. Garage door ventilation for now. Add independent MrCool DIY 12K (~$2,550) later. Theater and gym units are fully independent (separate condensers, circuits, refrigerant).

---

## Critical Assessment

**Strengths:**
- Room ratio 1:1.7:2.3 is close to ideal (reference is 1:1.6:2.6)
- Equipment completely isolated from theater listening space
- Single partition wall is the simplest possible construction
- NEC load passes with comfortable margin at 60A

**Concerns:**
- 60A vs 100A feed is unverified — must read breaker at house panel
- 1' rear clearance behind Row 2 is tight; minimal space for rear treatment
- Equipment closet ventilation must be addressed before commissioning
- No light-lock vestibule — door discipline required

---

**Document Version:** 1.0
