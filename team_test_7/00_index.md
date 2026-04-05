# Option D Design Package — Master Index
## team_test_7 — Generated 2026-03-16

**Configuration:** 9.4.4 Dolby Atmos | **Room:** 17'×23'×10' | **Budget:** ~$37,418 out-of-pocket (corrected)

---

## System Summary

| Subsystem | Components | Amplification | Target SPL |
|-----------|-----------|---------------|------------|
| LCR | 3× Titan-815LX (99 dB, 6Ω) | ATI AT525NC 5ch NCore (owned) | 108 dB @ Row 1 |
| Front Wides | 2× Volt-10 (95 dB, 8Ω) | ATI AT525NC (2 of 5 ch) | 107 dB |
| Surrounds | 4× Volt-10 (95 dB, 8Ω) | X6800H internal | 107 dB |
| Heights | 4× Volt-10 (95 dB, 8Ω) | X6800H internal | 105 dB |
| Corner Subs | 8× UMII18-22 (4 cabinets) | 2× ICEpower 1200AS2 | ~108 dB @ 20 Hz |
| Tactile | 8× Aura Pro AST-2B-4 | 1× ICEpower 1200AS2 | N/A |
| Nearfield | 4× UMII18-22 (DEFERRED) | 1× ICEpower 1200AS2 (spare) | — |

**All channels exceed 95 dB target by 10+ dB.**

---

## Document Map

| Doc | Title | Contents |
|-----|-------|----------|
| `specs.yaml` | **Single Source of Truth** | All specs, dimensions, costs, calculations |
| `00_index.md` | Master Index (this file) | System summary, doc map, corrections log |
| `01_room_electrical_hvac.md` | Room, Electrical & HVAC | Room dims, partition, closet, circuits, HVAC, room modes |
| `02_speakers.md` | Speaker System | All 13 channels: model, sensitivity, impedance, amp, SPL, headroom |
| `03_subwoofers.md` | Subwoofer System | Corner (8 drivers), nearfield (deferred), tactile, enclosure calcs, T/S analysis |
| `04_amplification_dsp.md` | Amplification & DSP | ICEpower, ATI, X6800H, APM2+PCM5102, signal flow, gain staging |
| `05_screen_seating.md` | Screen & Seating | Screen spec, projector throw, viewing angles, riser, stage |
| `06_budget.md` | Budget | Phase 1 + Phase 2 line items, owned inventory, corrections |

## Diagrams

| Script | Output | Contents |
|--------|--------|----------|
| `diagrams/d01_floor_plan.py` | Floor plan PNG | Top-down: walls, partition, subs, speakers, seating, closet, door |
| `diagrams/d02_signal_flow.py` | Signal flow PNG | Full signal path: sources → processor → amps → drivers |
| `diagrams/d03_front_elevation.py` | Front elevation PNG | Screen wall: screen, LCR, front corner subs, heights |
| `diagrams/d04_wiring.py` | Sub wiring PNG | Sub system: processor → DSP → amps → drivers + power |
| `diagrams/config.py` | Shared config | Loads specs.yaml, provides constants |
| `diagrams/generate_all.py` | Runner | `python generate_all.py` runs all diagrams |

## 3D Models

| Script | Output | Contents |
|--------|--------|----------|
| `models/generate_room.py` | `room_model.obj` | Low-poly room shell, speakers as boxes, subs, seating |
| `models/generate_room_hires.py` | `room_model_hires.obj` | Room + embedded detailed speaker/driver OBJs |
| `models/generate_sub_cabinet.py` | `sub_cabinet.obj` | Detailed sub cabinet: 24×24×72, internal partition, 2× 18" cutouts |

---

## Corrections Log

All corrections applied vs source documents. These fix documented errors.

| # | Field | Source Value | Corrected Value | Reason |
|---|-------|-------------|-----------------|--------|
| 1 | Screen bottom height | 51" | 30" | 51+83=134" exceeds 120" ceiling |
| 2 | Volt-10 sensitivity | 98 dB (some docs) | 95 dB | DIYSG official spec |
| 3 | Sub DSP platform | ADAU1452 | 2× Wondom APM2 (ADAU1701) | APM2 is available/tested |
| 4 | Sub DSP DAC path | Internal DAC | I2S → PCM5102 external DAC | 0.9V internal too low for ICEpower |
| 5 | Electrical breaker | 100A | 60A | Source docs wrong |
| 6 | Sub cabinet footprint | 20"×20" | 24"×24" | layout_config.json is truth |
| 7 | Sub cabinet height | unspecified | 72" (6 ft) | Team assessment: Qtc=0.73, near-Butterworth |
| 8 | Phase 1 budget | $11,059 | $11,259 | $200 arithmetic error in source |
| 9 | UST projectors | not specified | OFF THE TABLE | Incompatible with AT screen |
| 10 | UMII18-22 T/S params | Vas=15.5, Qts=0.36 | Vas=8.77, Qts=0.53 | Dayton spec sheet verified |
| 11 | Sub amp power at seat | 620W rated | ~197W through PCM5102 path | 2.0V output vs 3.55V needed for full power |

---

## Team Process

This package was generated using the full agent team framework with all advisory voices:
- **Architect** — designed document tree, identified inconsistencies
- **Analyst** — verified all budget arithmetic and performance calculations
- **Critic** — challenged assumptions, validated scope
- **Builder** — generated all deliverables
- **Verifier** — ran scripts, cross-checked specs
- **Advisory voices** — New Grad, Senior, Acton, Bass Head, Cost Cutter

### Key Team Decisions

| Decision | New Grad | Senior | Acton | Bass Head | Cost Cutter | Resolution |
|----------|----------|--------|-------|-----------|-------------|------------|
| Sub cabinet height | "72\" is fine" | "72\" — don't over-build" | "Show me the Qtc" | "96\" for more volume" | "72\" saves $0 but avoid overkill" | **72"** — Qtc=0.73 near-optimal |
| DSP platform | "ADAU1452 is newer" | "APM2 is tested, use it" | "What hardware do you OWN?" | "Either works below 20Hz" | "APM2 is $25 vs $60" | **APM2** — tested, cheaper, sufficient |
| PCM5102 DAC path | "Clean solution" | "External DAC adds a board" | "0.9V vs 2.0V — the data is clear" | "190W is enough for 95dB target" | "2× $7 modules, no-brainer" | **PCM5102** — 5× the power of internal DAC |
| Sub footprint | "24\" matches layout" | "Resolve discrepancy, pick one" | "Two numbers = one is wrong" | "Bigger is better" | "24\" same cost" | **24"×24"** — layout_config.json is truth |

---

## Open Issues (from Agent Team Audit)

These items were flagged by the Architect and Analyst agents and need verification before hardware purchase.

| # | Issue | Severity | Detail |
|---|-------|----------|--------|
| 1 | **ADAU1701 ADC full-scale** | HIGH | May be 1.0 Vrms (not 2.0V as documented). If 1.0V, AVR 2V output clips by 6 dB. MUST verify with APM2 hardware or datasheet. Mitigation: resistive pad at ADC input. |
| 2 | **PCM5102 output voltage** | HIGH | TI datasheet says 1.05V RMS differential (~0.53V single-ended). Some breakout boards add an output buffer to 2V — verify the specific board purchased. If 0.53V: ICEpower gets only ~14W/ch (unusable). |
| 3 | **Gain stage needed** | HIGH | Both issues above suggest a DRV134 or THAT1646 balanced line driver with +6-12 dB gain is mandatory between DAC and ICEpower. Budget ~$65. Already documented in research/ADAU1452_Signal_Chain_Design.md but not in Phase 2 budget. |
| 4 | **Surround headroom overstatement** | LOW | Source docs claim +13-15 dB headroom. Actual at all-channels-driven (~100W) is +9-12 dB. Still adequate but the claim should be corrected. |
| 5 | **99 Hz room mode cluster** | LOW | Width 3rd (99.7 Hz) and Depth 4th (98.3 Hz) overlap within 1.4 Hz. Dirac ART handles this but worth noting for manual EQ. |
| 6 | **DSP architecture ambiguity** | MEDIUM | Some research docs reference Raspberry Pi for DSP control. CLAUDE.md says SigmaStudio COM on PC. Resolved: use PC + SigmaStudio COM per established pipeline. |

### Recommended Pre-Purchase Action

Before ordering APM2 + PCM5102 boards:
1. Verify APM2 ADC full-scale input voltage on actual hardware (measure with signal generator)
2. Verify PCM5102 breakout board output voltage (measure with multimeter + test tone)
3. If either is below 2.0V: add DRV134 balanced line driver with gain to the BOM ($65)
4. If the ADAU1452+CS42448 board ($55-60) provides 2V DAC output without external DAC, consider it as alternative despite being less tested

---

**Package Version:** 1.0
**Generated:** 2026-03-16
**Source:** POR Rev 7.0 + Garage_Conversion_Option1.md v3.7 + known corrections
