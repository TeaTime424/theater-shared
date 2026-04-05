# Architect Review — Home Theater Design Package
_Task 5 output. Sources: tmp_por_summary.md, tmp_investigation_notes.md, coordinates.json, ts_params.json_

---

## 1. DOCUMENT TREE REVIEW

Proposed 7-doc structure: `00_index`, `01_room`, `02_speakers`, `03_subwoofer`, `04_electronics`, `05_construction`, `06_budget`.

| Doc | Justified? | Scope Issue | Verdict |
|-----|-----------|-------------|---------|
| 00_index | Yes — single-page nav, reader entry point | None | Keep |
| 01_room | Yes — walls, door, HVAC, electrical feed, coordinates | None | Keep |
| 02_speakers | Yes — LCR + surround + Atmos, signal path | None | Keep |
| 03_subwoofer | Yes — drivers, cabinets, amps, DSP, signal chain | Risk: absorbs tactile shakers — keep shakers here, not in separate doc | Keep; scope shakers inside |
| 04_electronics | Yes — AVR, DSP platform, signal chain, racks | Risk: overlaps with 02 and 03 on signal chain | Keep but trim; signal chain lives here once only |
| 05_construction | Borderline — only needed if owner is building walls/structure in 2027 | Risk of over-engineering this into a GC spec doc | Keep lean: sub cab build, stage build, riser only |
| 06_budget | Yes — BOM with line items and phase split | None | Keep |

**Finding:** 7 docs is acceptable. No additions warranted. `04_electronics` is the most likely to bloat — cap it at AVR/DSP/racks only; signal chain is a single shared diagram, not repeated in each speaker doc.

---

## 2. INCONSISTENCY FLAGS

### 2a. Cross-Doc Conflicts (all 10 from POR summary)

| # | Conflict | Authority (correct value) | Stale location(s) |
|---|----------|--------------------------|-------------------|
| 1 | AVR model | **AVR-X6800H + ATI AT525NC** (CLAUDE.md Option D) | `06_Electronics_and_Control.md`, `05_Speaker_System.md` — still say AVR-A1H |
| 2 | DSP chip | **ADAU1452** for production sub DSP (CLAUDE.md + Garage_Conversion Option D) | `06_Electronics_and_Control.md`, `15_DSP_Subwoofer_Processing.md` — say ADAU1701/APM2 (APM2 is dev/learning platform, not production) |
| 3 | Sub cabinet footprint | **24"×24"** (CLAUDE.md + coordinates.json `_footprint_resolved` annotation) | Garage_Conversion table: ~20"×20" — stale |
| 4 | Sub cabinet type | **Rectangular stacked** (CLAUDE.md + Option D) | `03_Subwoofer_System.md` Rev 5.9: triangular corner columns — superseded |
| 5 | Screen aspect ratio | **16:9** (CLAUDE.md + coordinates.json) | `01_Project_Overview`, layout diagrams Rev 5.x/7.0: 2.35:1 — superseded |
| 6 | Volt-10 sensitivity | **95 dB** (CLAUDE.md Rev 7.0 correction) | Rev 5.0 docs: 98 dB — superseded |
| 7 | Sub amp platform | **5× ICEpower 1200AS2** (CLAUDE.md + investigation nx6000d-vs-icepower) | `00_Master_Index` Rev 7.0: 6× NX6000D — superseded |
| 8 | MrCool price | **~$2,359** (tmp_por_summary.md, 16_HVAC_Plan_Theater snapshot) | Task spec reference "$1,359" — incorrect; see Section 2e below |
| 9 | Tactile shaker count | **8× Aura Pro** (CLAUDE.md, investigation bass-plan-overkill) | `03_Subwoofer_System.md`, Rev 7.0 budget: 16× — superseded |
| 10 | ICEpower module count | **5 modules** (CLAUDE.md: 4 active + 1 spare) | `06_Electronics` closet list: 4 — ambiguous; 5 is correct per investigation |

### 2b. T/S Parameter Errors (Vas=15.5, Qts=0.36)

These values are **incorrect fabrications**. They do not appear in any source doc.

| Parameter | Wrong value (if seen) | Correct value | Source |
|-----------|-----------------------|---------------|--------|
| Qts | 0.36 | **0.53** | ts_params.json, tmp_por_summary.md |
| Vas | 15.5 (L or ft³ — either is wrong) | **248.2 L / 8.77 ft³** | tmp_por_summary.md (03_Subwoofer_System.md Rev 5.9); ts_params.json Vas_cuft=8.77 |
| Qes | — | 0.58 (ts_params.json) vs 0.67 (por_summary) | CONFLICT: ts_params.json and por_summary disagree on Qes; ts_params.json Qms=6.22 vs por_summary 2.53 — **flag for Analyst to reconcile against Dayton datasheet** |
| Re | — | 5.8Ω (ts_params.json) vs 4.2Ω (por_summary) | **CONFLICT on Re** — same flag |
| Sensitivity | — | 95.7 dB (ts_params.json) vs 90.7 dB (por_summary) | **CONFLICT on sensitivity** — same flag |
| Power | — | 1,500W (ts_params.json) vs 1,200W (por_summary) | **CONFLICT on power rating** |

**Action:** ts_params.json vs por_summary T/S values diverge on 5 parameters. The design package must use one canonical set. Flag for Analyst to verify against Dayton UMII18-22 datasheet before writing `03_subwoofer`.

### 2c. Sub Cabinet Height Ambiguity (72" / 96" / 120")

| Height | Qtc | F3_Hz | Notes |
|--------|-----|-------|-------|
| 72" | 0.7228 | 29.4 | Near-ideal Butterworth; stacked pair = 144", 24" clearance to 10' ceiling |
| 96" | 0.6797 | 29.4 | Overdamped; F3 identical; stacked = 192" — exceeds 120" ceiling by 72" — NOT VIABLE |
| 120" | 0.6525 | 29.6 | Overdamped; F3 essentially same; stacked = 240" — not viable |

Source: ts_params.json `cabinet_options` and `team_recommendation`.

**72" is the only viable height for stacked pairs in a 10' ceiling room.** 96" and 120" single cabinets are non-starters for the stacked configuration. The "open question" on height is resolved by ceiling geometry: 72" settled. (See Section 3.)

### 2d. Screen Bottom Height Error

| Parameter | Wrong value | Correct value | Source |
|-----------|-------------|---------------|--------|
| Screen Y1 (bottom) | 51" (stated in task spec as "error in source") | **30"** | coordinates.json `screen.Y1 = 30` with explicit assertion "Bottom at Y=30 not 51" |

All downstream docs and any 3D model must use Y1=30.

### 2e. DSP Platform Clarification

| Context | Platform | Source |
|---------|----------|--------|
| Production sub DSP (Option D build) | **ADAU1452** — 8.24 fixed-point | CLAUDE.md; Garage_Conversion Option D; investigation nx6000d-vs-icepower |
| Development/learning platform | ADAU1701 on Wondom APM2 | tmp_investigation_notes.md DSP Platform Verdict |

Any doc still writing "ADAU1701" for the production sub DSP is wrong. The APM2/ADAU1701 is a bench development board, not the build component.

### 2f. AVR Model

Option D is settled as **AVR-X6800H + ATI AT525NC** (tmp_por_summary.md cross-doc conflict table, CLAUDE.md). Any doc citing AVR-A1H without ATI AT525NC is describing the superseded Rev 7.0 config.

### 2g. MrCool Price Discrepancy

| Source | Price | Unit |
|--------|-------|------|
| Task spec reference | $1,359 | unspecified — possibly indoor unit only |
| tmp_por_summary.md (16_HVAC_Plan_Theater snapshot) | **~$2,359** | complete system (indoor + outdoor + linesets) |
| tmp_investigation_notes.md (HVAC investigation) | **~$2,550** actual; $1,800 Option D allocation — $750 gap | complete system |

**Resolution:** $2,359–$2,550 is the correct all-in cost. $1,359 likely refers to the indoor head unit only or a stale price. Budget doc must use ~$2,400 (split difference) and flag the $600+ gap vs Option D allocation.

---

## 3. SETTLED vs CONTESTED

### Settled (no team deliberation needed)

| Decision | Value | Source |
|----------|-------|--------|
| Room dimensions | 17'×23'×10' = 3,910 cu ft | CLAUDE.md; coordinates.json; tmp_por_summary.md |
| Screen | 170" 16:9 AT, Y1=30" | CLAUDE.md; coordinates.json (assertion) |
| LCR | 3× DIYSG Titan-815LX, 6Ω, 99 dB | CLAUDE.md; tmp_por_summary.md |
| Surrounds/Atmos | 10× DIYSG Volt-10, 8Ω, 95 dB | CLAUDE.md (Volt-10 sensitivity correction confirmed Rev 7.0) |
| Sub drivers | 8× Dayton UMII18-22 (corner array) | CLAUDE.md; investigation bass-plan-overkill |
| Sub footprint | 24"×24" | coordinates.json `_footprint_resolved`; CLAUDE.md |
| Sub cabinet height | **72"** | ts_params.json team_recommendation; ceiling constraint (see 2c) |
| Sub amps | 5× ICEpower 1200AS2, 240V | CLAUDE.md; investigation nx6000d-vs-icepower |
| Sub DSP (production) | ADAU1452 | CLAUDE.md; investigation nx6000d-vs-icepower |
| AVR | Denon AVR-X6800H | CLAUDE.md Option D |
| Speaker amp (LCR + FW) | ATI AT525NC | CLAUDE.md Option D |
| Tactile shakers | 8× Aura Pro AST-2B-4 | CLAUDE.md; investigation bass-plan-overkill |
| Nearfield subs | Deferred post-build | CLAUDE.md; investigation bass-plan-overkill |
| HVAC unit | MrCool DIY 12K 230V, partition wall | CLAUDE.md; investigation hvac-theater-setup |
| HVAC mount location | Partition wall, 7-8' high, 2-4' from north wall | investigation hvac-theater-setup |
| Electrical | 100A/240V dedicated subpanel | CLAUDE.md |
| SPL target | 95 dB at MLP (-10 dB Reference) | CLAUDE.md |
| Signal chain DAC fix | PCM5102 on I2S output | tmp_investigation_notes.md PCM5102 DAC Fix section |
| Balanced driver | DRV134 or THAT1646 | tmp_investigation_notes.md Signal Chain |
| 898B balanced converter | Sonic Imagery Labs 898B, purchased | MEMORY.md project_898b_purchased |

### Contested (needs Critic assessment)

| Decision | Dispute | Needs |
|----------|---------|-------|
| T/S parameter set | ts_params.json vs tmp_por_summary.md diverge on Qes, Re, sensitivity, power | Analyst: verify against Dayton UMII18-22 datasheet |
| HVAC budget | $2,359–2,550 actual vs $1,800 allocated — $600+ gap | Analyst: update 06_budget line item |
| ICEpower count detail | CLAUDE.md says 5; one doc says 4 | Low stakes — 5 is correct; just fix the stale doc |
| DRV134 vs THAT1646 choice | Both listed as options; no final selection | Low stakes for doc — either works; note both in 04_electronics |

### Open (requires calculation — RESOLVED by ts_params.json)

| Question | Resolution |
|----------|------------|
| Sub cabinet height 72/96/120" | **72" settled.** See Section 2c. F3 is identical across all three (~29.4 Hz); 96" and 120" exceed ceiling for stacked pairs; 72" Qtc=0.723 is near-optimal Butterworth. No further calculation needed. |

---

## 4. INVESTIGATION TRIGGER CHECK

| Item | Status | Action |
|------|--------|--------|
| Dayton UMII18-22 T/S values — ts_params.json vs por_summary conflict | Needs datasheet cross-check | Main conversation: create verify task (Analyst/verify agent) |
| MrCool actual current street price | Approximate resolution (~$2,400); could verify exact | Optional; low stakes — use ~$2,400 in budget doc |
| DRV134 vs THAT1646 final selection | Not blocking doc writing | Defer; note both in signal chain doc as "TBD at build time" |

---

## 5. ADVISORY: SENIOR — SCOPE RIGHT-SIZED?

The 7-doc structure is correctly sized for a single owner building in 2027. Three risks:

1. **`05_construction` is the bloat risk.** It only needs sub cabinet cut list, stage dimensions, and riser spec. Do not let it grow into acoustic treatment schedules, drywall specs, or electrical conduit routing — those are contractor work, not owner reference.

2. **Signal chain duplication.** The signal chain (X6800H → APM2 → PCM5102 → DRV134 → ICEpower → subs) is referenced in `03_subwoofer`, `04_electronics`, and potentially `02_speakers`. Write it once in `04_electronics`. Other docs cite it; they do not reproduce it.

3. **Budget doc should be the single arithmetic surface.** All costs must trace back to `06_budget`. Costs mentioned in body docs (e.g., "MrCool ~$2,359") should have a footnote "see 06_budget" — not create parallel running totals that drift.

The `$36,600` total is a claim (CLAUDE.md), not a verified sum. The Rev 7.0 budget at ~$72K used a completely different hardware config. No Option D itemized total exists in any source file reviewed. The Analyst must build this total from scratch.

---

## 6. ADVISORY: ACTON — SOURCE AUDIT

Every assertion in this document is sourced. Unsourced claims from this review that require follow-up:

| Claim | Status |
|-------|--------|
| "$36,600 total budget" | UNVERIFIED — headline only in CLAUDE.md; no itemized Option D BOM found in any source |
| "5 ICEpower modules sufficient for corners + shakers + spare" | Sourced: investigation nx6000d-vs-icepower + CLAUDE.md |
| "72" cabinet height is settled" | Sourced: ts_params.json team_recommendation + ceiling arithmetic (2×72=144 < 120 ceiling) |
| "HVAC $2,359" | Sourced: tmp_por_summary.md HVAC table |
| "Screen Y1=30" | Sourced: coordinates.json assertion field |
| "Qts=0.53, Vas=8.77 ft³" | Sourced: ts_params.json (authoritative for cabinet calculations); por_summary cites same Qts=0.53 |
| "Qes=0.58 (ts_params) vs 0.67 (por_summary)" | CONFLICT — flag only, not resolved here |
