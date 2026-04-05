# Option D Design Package — Master Index
## THIS IS THE ACTIVE DESIGN
## 17'x23' Theater + 12'x23' Gym — N-S Partition

**Date:** 2026-03-15
**Status:** ACTIVE — Option D is the likely build scenario
**Configuration:** 9.4.4 Dolby Atmos + 8x corner UMII18-22 + ICEpower 1200AS2 + APM2 DSP
**Budget:** $37,414 OOP ($50,864 total value including $13,450 owned inventory)

---

## System Summary

| Parameter | Value |
|-----------|-------|
| Room | 17' x 23' x 10' (3,910 cu ft) |
| Screen | 170" 16:9 AT, bottom at 30" AFF |
| Projector | JVC DLA-NZ500, rear wall ceiling mount |
| Processor | Denon AVR-X6800H + Dirac Live Full/Bass/ART |
| LCR | 3x Titan-815LX (99 dB, 6 ohm) via ATI AT525NC |
| Surrounds/Atmos | 10x Volt-10 (95 dB, 8 ohm) — 8 via X6800H internal |
| Front Wides | 2x Volt-10 via ATI AT525NC |
| Corner Subs | 8x UMII18-22 in 4 cabinets (24"x24"x72") |
| Sub Amps | 5x ICEpower 1200AS2 (3 active + 2 spare) |
| Sub DSP | 2x Wondom APM2 (ADAU1701) |
| Tactile | 8x Aura Pro AST-2B-4 (1/seat) |
| Nearfield Subs | Deferred (space reserved) |
| HVAC | MrCool DIY 12K 230V, partition wall mount |
| Electrical | 60A feed (#2 Al 240V) |
| Target Level | -10 dB Reference (95 dB at MLP) |

---

## Document Index

| Doc | File | Contents |
|-----|------|----------|
| -- | `specs.yaml` | Single source of truth — all numbers |
| 00 | `00_index.md` | This file — master index |
| 01 | `01_room_electrical_hvac.md` | Room, partition, closet, door, panel, circuits, HVAC |
| 02 | `02_speakers.md` | All 13 channels — models, amps, SPL calculations |
| 03 | `03_subwoofers.md` | 8x corner subs, cabinet design, T/S calcs, tactile |
| 04 | `04_amplification_dsp.md` | ICEpower, ATI, APM2, signal flow, gain staging |
| 05 | `05_screen_seating.md` | Screen, projector throw, viewing angles, riser |
| 06 | `06_budget.md` | Phase 1 + Phase 2, corrections, deferrals |

## Diagram Index

| Diagram | Script | Output |
|---------|--------|--------|
| Floor Plan | `diagrams/d01_floor_plan.py` | Top-down layout with all positions |
| Signal Flow | `diagrams/d02_signal_flow.py` | Full signal chain with voltages |
| Front Elevation | `diagrams/d03_front_elevation.py` | Screen wall dimensioned |
| Wiring | `diagrams/d04_wiring.py` | Sub system wiring detail |

## 3D Model Index

| Model | Script | Output |
|-------|--------|--------|
| Room (low-poly) | `models/generate_room.py` | Building shell + furniture |
| Room (hi-res) | `models/generate_room_hires.py` | Room with embedded speaker OBJs |
| Sub Cabinet | `models/generate_sub_cabinet.py` | Detailed 24"x24"x72" cabinet |

---

## Corrections Log

| # | Item | Original | Corrected | Source |
|---|------|----------|-----------|--------|
| 1 | T/S params | Vas=15.5 cuft, Qts=0.36 | Vas=8.77 cuft (248.2L), Qts=0.53 | Dayton spec sheet 295-718 |
| 2 | Phase 1 total | $11,059 | $11,259 | Line items sum |
| 3 | Phase 2 total (in Option D table) | $25,565 | $26,155 | Line items sum |
| 4 | Grand total OOP | $36,624 | $37,414 | $11,259 + $26,155 |
| 5 | Screen price | $1,000 | $1,500 | Realistic for 170" 16:9 AT |
| 6 | DSP board | ADAU1452 ($60) | 2x APM2 ($90) | Decision gate |
| 7 | ADC full-scale | 0.9 Vrms (wrong) | 2.0 Vrms | ADAU1701 datasheet |
| 8 | DAC output | -- | 0.9 Vrms (limits to 38.5W/ch) | Known limitation |
| 9 | Electrical feed | 100A | 60A (#2 Al 240V) | Decision gate |
| 10 | Equipment closet | NE of gym | NW of building (same location) | Spatial confirmation |

---

**Document Version:** 1.0
**Author:** Builder Agent
**Date:** 2026-03-15
