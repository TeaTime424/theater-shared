# Home Theater Design Package — Master Index
Revision: 2026-03-21

---

## System Summary

| Category | Spec | Source Field |
|---|---|---|
| Room (theater zone) | 17'×23'×10', 3,910 cu ft | `room.theater_zone`, `room.theater_volume_cuft` |
| Configuration | 9.4.6 Dolby Atmos | speakers: LCR 3 + surrounds 4 + atmos 6 |
| LCR | 3× DIYSG Titan-815LX, 99 dB, 6Ω | `speakers.lcr` |
| Surrounds | 4× DIYSG Volt-10, 95 dB, 8Ω | `speakers.surrounds` |
| Atmos | 6× DIYSG Volt-10, 95 dB, 8Ω | `speakers.atmos` |
| Subwoofers | 8× Dayton UMII18-22, 4 corner cabinets, sealed | `subwoofers.corner_count`, `subwoofers.corner_cabinet` |
| Sub cabinets | 24"×24"×72", series 8Ω, Qtc=0.723, F3=29.4 Hz | `subwoofers.corner_cabinet` |
| Tactile | 8× Aura Pro AST-2B-4 | `subwoofers.tactile` |
| Sub amps | 5× ICEpower 1200AS2, 240V, 600W/8Ω, fanless | `amplification.sub_amps` |
| LCR amp | ATI AT525NC, 5ch | `amplification.lcr_amp` |
| Processor | Denon AVR-X6800H, 11.4ch, Dirac Live Full+BC+ART | `amplification.processor` |
| DSP (production) | ADAU1452 (8.24 fixed-point) | `dsp.platform` |
| DSP (dev bench) | 2× Wondom APM2 (ADAU1701) | `dsp.dev_bench` |
| Signal chain | X6800H → ADAU1452 → PCM5102 (2.0V) → 898B (3.5V) → ICEpower | `dsp.signal_chain` |
| Screen | 170" 16:9 AT, 148.2"W × 83.3"H, bottom at 30" | `screen` |
| Projector | TBD 2027 (JVC NZ500 placeholder) | `projector` |
| HVAC | MrCool DIY 12K, partition wall, 23 dB(A) | `hvac` |
| Electrical | 60A/240V at main panel, dedicated subpanel | `electrical` |
| Phase 1 budget | $37,020 (~$36,600 target, within ~$400) | `budget.phase1_total` |
| Phase 2 (deferred) | $2,342 (nearfield subs + amp) | `budget.phase2_total` |
| Grand total | $39,362 | `budget.grand_total` |

---

## Document Map

| Doc | Covers |
|---|---|
| `00_index.md` | System summary, document map, corrections log, team decisions |
| `01_room_layout.md` | Room dimensions, partition, theater/gym zones, equipment closet |
| `02_speakers.md` | LCR, surround, Atmos specs; sensitivity, impedance, placement |
| `03_subwoofers.md` | Corner sub array, cabinet design, T/S alignment, driver specs |
| `04_amplification.md` | ICEpower 1200AS2, ATI AT525NC, AVR-X6800H signal levels |
| `05_dsp_signal_chain.md` | ADAU1452 production chain, APM2 dev bench, PCM5102, 898B |
| `06_budget.md` | Phase 1 itemized, Phase 2 deferred, grand total |

---

## Known Corrections Log

All corrections from `corrections_applied` in specs.yaml:

| # | Corrected Value | Was (Error) | Now (Correct) |
|---|---|---|---|
| 1 | Screen bottom height | 51" | 30" |
| 2 | Volt-10 sensitivity | 98 dB | 95 dB |
| 3 | Titan-815LX impedance | 8Ω | 6Ω |
| 4 | UMII18-22 T/S | Qts=0.36, Vas=15.5 | Qts=0.53, Vas=8.77 |
| 5 | Sub cabinet footprint | 20"×20" | 24"×24" |
| 6 | MrCool DIY 12K price | $1,359 | $2,359 |
| 7 | Electrical feed at main | 100A | 60A |
| 8 | DSP production platform | ADAU1701 | ADAU1452 |
| 9 | AVR/amp configuration | AVR-A1H (integrated) | X6800H + ATI AT525NC (separate) |
| 10 | Shaker count | 16× | 8× |
| 11 | ICEpower unit count | unspecified | 5× confirmed (4 active + 1 spare) |

---

## Team Decisions

| Decision | Value | Source Field |
|---|---|---|
| Sub cabinet height | 72" | `subwoofers.corner_cabinet.height_in` |
| Sub DSP platform | ADAU1452 (production) | `dsp.platform` |
| Sub cabinet footprint | 24"×24" | `subwoofers.corner_cabinet.footprint_in` |
| Screen bottom height | 30" above floor | `screen.bottom_height_in` |

---

## Revision

| Field | Value |
|---|---|
| Run date | 2026-03-21 |
| Source | `specs.yaml` (team_test_14) |
| Status | Phase 1 design — pre-build |
