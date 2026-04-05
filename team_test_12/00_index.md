# Option D Home Theater — Design Package Index
**Revision:** 2026-03-21 | **Authority:** specs.yaml (generated 2026-03-21)

---

## System Summary

| Parameter | Value | Source (specs.yaml field) |
|-----------|-------|--------------------------|
| Room (theater zone) | 17' × 23' × 10' (3,910 cu ft) | `room.theater_zone` |
| Configuration | 9.4.6 Dolby Atmos | `speakers.surround_atmos.count_breakdown` |
| Screen | 170" 16:9, acoustically transparent | `screen.size_in`, `screen.aspect` |
| Screen position | Bottom 30", top 113", 7" ceiling clearance | `screen.bottom_height_in`, `screen.top_height_in` |
| Projector | TBD — deferred 2027 (ref: JVC NZ500) [UNVERIFIED] | `projector.model` |
| LCR speakers | 3× DIYSG Titan-815LX, 99 dB (2.83V), 6Ω nominal | `speakers.lcr` |
| Surround/Atmos/FW | 12× DIYSG Volt-10 V2, 95 dB, 8Ω | `speakers.surround_atmos.count` |
| Processor | Denon AVR-X6800H + Dirac Live Full + Bass Control + ART | `amplification.processor` |
| LCR amp | ATI AT525NC (owned) — 300W @ 6Ω LCR, 200W @ 8Ω FW | `amplification.lcr_amp` |
| Sub drivers | 8× Dayton UMII18-22 (corner array, sealed) | `subwoofers.driver.corner_count` |
| Nearfield subs | 4× UMII18-22 — deferred post-build | `subwoofers.driver.nearfield_note` |
| Sub cabinets | 4× sealed, 24" × 24" × 72", 2 drivers each, 8Ω series | `subwoofers.corner_cabinet` |
| Sub alignment | Qtc = 0.749, Fc = 31.1 Hz, F3 = 29.5 Hz | `subwoofers.corner_cabinet.Qtc`, `.Fc_Hz`, `.F3_Hz` |
| Sub amps | 5× ICEpower 1200AS2 (4 active, 1 spare), 240V, 620W @ 8Ω | `amplification.sub_amps` |
| DSP platform | 2× Wondom APM2 (ADAU1701, 5.23 fixed-point) [UNVERIFIED — signal chain] | `dsp.platform` |
| Signal chain | X6800H pre-out (0.9 Vrms) → 898B → 3.50 Vrms XLR → ICEpower | `dsp.signal_chain_committed` |
| Tactile shakers | 8× Aura Pro AST-2B-4, 4Ω, ICEpower unit 3 | `subwoofers.tactile` |
| HVAC | MrCool DIY 12K, 23 dB(A), partition wall [UNVERIFIED — pricing] | `hvac.model`, `hvac.noise_dba` |
| SPL target | 95 dB all channels at MLP (-10 dB Reference) | `spl_performance.target_dB` |
| LCR SPL headroom | 111.3 dB peak → +16.3 dB over target | `spl_performance.lcr` |
| Budget (Option D) | ~$36,600 out-of-pocket (basis unverified — Critic B1) [UNVERIFIED] | `budget.option_d_out_of_pocket_claimed_usd` |

---

## Document Map

| Document | Covers |
|----------|--------|
| `00_index.md` | This file — summary table, document map, corrections log, team decisions, revision status |
| `01_room_electrical_hvac.md` | Room dimensions, partition, coordinate system; electrical subpanel, circuits; HVAC model/placement/circuit. Electrical feed marked [UNVERIFIED]. |
| `02_speakers.md` | LCR (Titan-815LX), surround/Atmos/FW (Volt-10 V2, 12 units), sensitivity corrections, SPL headroom calculations |
| `03_subwoofers.md` | UMII18-22 T/S params, corner cabinet design (24×24×72", Qtc/Fc/F3), wiring, corner loading, tactile shakers, nearfield deferral |
| `04_amplification_dsp.md` | AVR-X6800H, ATI AT525NC, ICEpower 1200AS2 assignments, ADAU1701/APM2 DSP, PCM5102 DAC, 898B signal chain, voltage/power scenarios |
| `05_screen_seating.md` | 170" 16:9 AT screen coordinates, projector throw ratio, Row 1/Row 2 positions, riser, MLP distance |
| `06_budget.md` | Option D line items with confidence levels, open gaps (G3/G5/G6), blockers (B1) — BLOCKED pending full BOM |

---

## Known Corrections Log

All corrections from `specs.yaml corrections_applied`:

| # | Item | Old Value | New Value | Authority |
|---|------|-----------|-----------|-----------|
| 1 | Screen bottom height | 51" (02_Front_Stage_System.md Rev 5.2) | 30" | coordinates.json Y1=30, Critic §1A |
| 2 | Screen aspect ratio | 2.35:1 (Rev 5.2, Rev 7.0 budget) | 16:9 | CLAUDE.md, coordinates.json geometry (148/83=16:9), Critic §1A |
| 3 | Volt-10 sensitivity | 98 dB (v5.0 docs) | 95 dB | DIYSG official spec, tmp_por_core.md §2 |
| 4 | Titan-815LX impedance | 8Ω (stale) | 6Ω nominal, 4.2Ω minimum | DIYSG spec, tmp_por_core.md §2 |
| 5 | Sub cabinet footprint | ~20×20" (Garage_Conversion_Option1.md) | 24×24" | CLAUDE.md, layout_config.json, coordinates.json, Critic §1C |
| 6 | Sub cabinet height | 96" (ts_params.json recommendation) | 72" | coordinates.json Y2=72, Critic §4 ruling |
| 7 | DSP platform | ADAU1452 (investigation §1.1 NX6000D verdict) | ADAU1701 via Wondom APM2 | tmp_investigation_notes.md §2, Critic §1G |
| 8 | Internal DAC | ADAU1701 internal DAC (0.9 Vrms) | PCM5102 external DAC module (2.0 Vrms) | tmp_investigation_notes.md §2, research/Balanced_Output_Stage.md |
| 9 | T/S parameters | POR values (Vas=15.5 cuft, Qts=0.36, Re=4.2) | Dayton datasheet values from ts_params.json | ts_params.json header, Critic §1D |
| 10 | Signal chain | No 898B balanced stage | Added 898B as gain/level-conversion stage (purchased 2026-03-21) | tmp_investigation_notes.md §3 |
| 11 | HVAC cost | $1,800 POR allocation | $2,550–$2,650 actual ($2,600 midpoint) | 16_HVAC_Plan_Theater.md v1.2, Critic §1B |
| 12 | Volt-10 count | 10 (CLAUDE.md, Rev 7.0 budget) | 12 (4 surrounds + 6 Atmos + 2 front wide) | tmp_analyst.md §1B, Critic §1I |
| 13 | Rev 7.0 grand total | ~$72,000 (stated) | $74,980 (computed sum of line items) | tmp_analyst.md §1A arithmetic verification |

---

## Team Decisions (Settled)

| Decision | Value | Authority |
|----------|-------|-----------|
| Sub cabinet height | 72" (not 96") — F3 delta vs 96" is 0.1 Hz (unmeasurable); front cabs double as screen wall structure | coordinates.json Y2=72, Critic §4 |
| Sub cabinet footprint | 24" × 24" | coordinates.json NW sub X-span=24", Z-span=24", Critic §1C |
| DSP platform | ADAU1701 via Wondom APM2 (not ADAU1452) | tmp_investigation_notes.md §2, Critic §1G |
| DAC | PCM5102 external module (2.0 Vrms) — internal ADAU1701 DAC (0.9 Vrms) insufficient without 898B | tmp_investigation_notes.md §2 |
| Screen aspect ratio | 16:9 (not 2.35:1) | CLAUDE.md, coordinates.json, Critic §1A |
| 898B committed | Sonic Imagery 898B purchased 2026-03-21; committed signal chain: X6800H → 898B → ICEpower | tmp_investigation_notes.md §3 |
| Volt-10 count | 12 (not 10) — includes 2 front wide channels (FWL/FWR) added in Option D | Critic §1I, tmp_analyst.md §1B |

---

## Open Blockers

| ID | Description | Blocked Document | Resolution Required |
|----|-------------|-----------------|---------------------|
| B1 | $36,600 out-of-pocket figure not reconstructible from available line items | `06_budget.md` | Full Option D BOM with line-item sources |
| B2 | Signal chain topology ambiguity: §2 vs §3 of investigation notes contradict (PCM5102→898B vs X6800H pre-out→898B directly) | `04_amplification_dsp.md` (partial) | Owner confirms: does PCM5102 output feed 898B, or X6800H pre-out feeds 898B directly? |

---

## UNVERIFIED Items

All items tagged UNVERIFIED in specs.yaml:

| Item | Tag Scope | specs.yaml Field |
|------|-----------|-----------------|
| HVAC cost ($2,600) | POR doc only, not cross-referenced against vendor pricing | `hvac.verification_status` |
| Electrical feed wire/breaker (#2 Al / 60A) | Not found in any POR source doc — do not treat as confirmed | `electrical.subpanel.feed_wire` |
| UMII18-22 T/S parameters | ts_params.json sourced from Dayton datasheet; datasheet not fetched/verified this session | `subwoofers.driver.verification_status` |
| DSP signal chain / 898B gain (11.79 dB) | Creator-confirmed only; zero independent measurements | `dsp.verification_status`, `signal_voltages.sonic_imagery_898b.verification_status` |
| Projector model / $30,000 budget | No model confirmed; placeholder only | `projector.verification_status` |
| Budget ($36,600 out-of-pocket) | Not reconstructible from line items | `budget.verification_status` |

---

## Revision Status

| Field | Value |
|-------|-------|
| Date | 2026-03-21 |
| Authority | specs.yaml (sole number source — do not use POR Rev 7.0 values) |
| Design version | Option D |
| Stale docs (do not reference) | 01_Project_Overview_and_Room.md (Rev 5.2), 02_Front_Stage_System.md (Rev 5.2), 03_Subwoofer_System.md (Rev 5.9), 11_Budget_Summary.md (Rev 7.0), 14_Quick_Reference.md (Rev 7.0), Garage_Conversion_Option1.md (v1–v3.3) |
