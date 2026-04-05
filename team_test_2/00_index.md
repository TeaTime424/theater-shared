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
| Budget | $37,944 out-of-pocket ($11,259 Phase 1 + $26,685 Phase 2) |
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

## 3D Models

| File | Description |
|------|-------------|
| `models/generate_room.py` | Low-poly OBJ: room shell, speakers as boxes, all elements |
| `models/generate_room_hires.py` | Hi-res OBJ: embedded detailed speaker/driver models from POR/ |
| `models/generate_sub_cabinet.py` | Detailed sub cabinet OBJ: 20"x20"x72" sealed, 2 driver cutouts |

---

## Key Corrections vs Source Documents

1. **Phase 1 budget:** $11,259 (not $11,059). MrCool system price $2,359 not reflected in original total (+$200).
2. **Phase 2 budget:** $26,685 (not $25,565). Processor & DSP subtotal corrected $4,707→$4,737 (+$30); screen $1,000→$1,500 (+$500); line items sum correction (+$590).
2. **Screen price:** $1,500 (not $1,000). 170" 16:9 AT screens start at $1,500 commercially.
3. **Screen bottom height:** ~30" above floor (not 51"). 51" puts top at 134" — above 120" ceiling.
4. **Projector mount:** 17.3+ ft from screen surface (rear wall ceiling). NZ500 throw ratio 1.4:1 minimum.
5. **Gain staging:** No overdrive risk. 1200AS2 input sensitivity is 5.0 Vp (not 1V). ADAU1701 DAC outputs ~1.5 Vrms.
6. **Sub enclosures:** Rectangular 20x20x72" (not triangular). ~8.1 cu ft/driver virtual (with polyfill), Fc ~32 Hz, Qtc ~0.76.
7. **DSP platform:** All ADAU1452 references corrected to 2x Wondom APM2 (ADAU1701) per investigation verdict.
8. **Processor & DSP subtotal:** $4,737 (not $4,707). Arithmetic: 3700+349+299+299+90=4737.
