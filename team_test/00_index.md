# Option D — Active Design Package
## 9.4.4 Dolby Atmos | 17'x23'x10' | Garage Conversion

**THIS IS THE ACTIVE DESIGN — supersedes all POR Rev 7.0 documents.**

POR docs (03_Subwoofer_System.md, 05_Speaker_System.md, 06_Electronics, 14_Quick_Reference.md, 11_Budget_Summary.md) describe the Rev 7.0 reference design (A1H, NX6000D, 9.4.6, 16'x26'). That design is NOT being built. This package IS.

**Date:** 2026-03-15 | **Source of truth:** `specs.yaml`

---

## System Summary

| Parameter | Value |
|-----------|-------|
| Configuration | 9.4.4 Dolby Atmos (13 channels) |
| Room | 17' x 23' x 10' (3,910 cu ft) |
| Target level | -10 dB Reference (95 dB at MLP) |
| Screen | 170" 16:9 AT |
| Projector | JVC DLA-NZ500 (selection deferred to 2027) |
| LCR | 3x Titan-815LX (99 dB, 6 ohm) — owned |
| Surr+Atmos+FW | 10x Volt-10 (95 dB, 8 ohm) |
| Corner subs | 8x UMII18-22, 4 sealed rectangular cabinets |
| Sub amps | 5x ICEpower 1200AS2 (240V, fanless, zero mods) |
| Sub DSP | 2x Wondom APM2 (ADAU1701), powered from ICEpower AUX5V |
| Speaker amps | ATI AT525NC (LCR+FW, owned) + X6800H internal (8ch surr/Atmos) |
| Processor | Denon AVR-X6800H + Dirac Live Full+BC+ART |
| HVAC | MrCool DIY 12K 230V, partition wall mount |
| Budget | $37,744 out-of-pocket ($11,059 Phase 1 + $26,685 Phase 2) |
| Already owned | $13,450 |

---

## Documents

| File | Description | Status |
|------|-------------|--------|
| `specs.yaml` | Single source of truth for all specs and budget | Complete |
| `01_room_electrical_hvac.md` | Room construction, electrical circuits, HVAC | Complete |
| `02_speakers.md` | All 13 speaker channels, SPL, headroom | Complete |
| `03_subwoofers.md` | Corner subs, nearfield (deferred), tactile | Complete |
| `04_amplification_dsp.md` | ICEpower, ATI, X6800H amps, 2x APM2, signal flow | Complete |
| `investigation_dsp_platform.md` | ADAU1452 vs multi-ADAU1701 assessment + Dirac ART analysis | Complete |
| `research_adau1452_cs42448_board.md` | Chinese ADAU1452 board known issues | Complete |
| `investigation_electrical_capacity.md` | 60A feed capacity deep dive — ADEQUATE (39.6A NEC calc, 34% headroom) | Complete |
| `research_ust_projector.md` | UST projector assessment — REJECTED (AT screen incompatible) | Complete |
| `05_screen_seating.md` | Screen spec, projector throw, viewing geometry | Complete |
| `06_budget.md` | Complete budget, corrections, deferrals | Complete |

## Diagrams

| File | Description |
|------|-------------|
| `diagrams/config.py` | Shared configuration from specs.yaml |
| `diagrams/generate_all.py` | Master runner |
| `diagrams/d01_floor_plan.py` | Top-down room layout with all elements |
| `diagrams/d02_signal_flow.py` | Full signal path, all channels |
| `diagrams/d03_front_elevation.py` | Screen wall front view |
| `diagrams/d04_wiring.py` | Sub system wiring: X6800H → APM2 → ICEpower → drivers + power |

## 3D Model

| File | Description |
|------|-------------|
| `models/generate_room.py` | Python OBJ generator — full room with all elements |

---

## Key Corrections vs Source Documents

1. **Phase 2 budget:** $26,655 (not $25,565). Line items summed to $26,155; screen corrected from $1,000 to $1,500 adds $500.
2. **Screen price:** $1,500 (not $1,000). 170" 16:9 AT screens start at $1,500 commercially.
3. **Screen bottom height:** ~30" above floor (not 51"). 51" puts top at 134" — above 120" ceiling.
4. **Projector mount:** 17.3+ ft from screen surface (rear wall ceiling). NZ500 throw ratio 1.4:1 minimum.
5. **Gain staging:** No overdrive risk. 1200AS2 input sensitivity is 5.0 Vp (not 1V). CS42448 outputs ~2.83 Vp.
6. **Sub enclosures:** Rectangular 20x20x72" (not triangular). ~8.5 cu ft/driver, Fc ~33 Hz, Qtc ~0.78.
7. **Electrical feed:** 60A (not 100A). #2 Al 240V from house. Existing 30A/240V pool circuit (IntelliFlow VSF ~5A typical). Theater peak ~25A — well within 60A service.
