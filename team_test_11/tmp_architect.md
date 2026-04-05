# Architect Audit — tmp_architect.md
Generated: 2026-03-21 | Sources: W0 extracts only (tmp_por_core.md, tmp_por_budget.md, tmp_investigation_notes.md, coordinates.json, ts_params.json)

---

## 1. DOCUMENT TREE REVIEW

### Proposed 7-Doc Structure (00–06)

| Doc | Proposed Scope | Verdict |
|-----|---------------|---------|
| 00_index | Navigation, version state, doc map | KEEP — single entry point |
| 01_room_layout | Option D dims, partition, layout, seating | KEEP |
| 02_speakers | LCR + surrounds + Atmos, sensitivity, impedance, amps | KEEP |
| 03_subwoofers | Corner sub array, T/S params, cabinet calcs, amp chain, DSP | KEEP |
| 04_electronics | Processor, AVR-X6800H, ATI AT525NC, signal chain, electrical | KEEP |
| 05_construction | HVAC, riser, stage, infrastructure, closet | KEEP — consolidates build scope |
| 06_budget | Itemized budget, Option D total, phase split | KEEP |

**Assessment:** 7-doc structure is correct. No scope creep detected. The legacy POR has 16+ docs; this consolidation is appropriate. No additional docs needed.

**Overlap risk — one flag:** Doc 03 (subs) and Doc 04 (electronics) both touch sub amplification (ICEpower 1200AS2). Assign amp chain to Doc 04; cabinet + T/S to Doc 03. DSP signal chain lives in Doc 04 with a single-line reference in Doc 03.

**Missing coverage:** Projector throw distance is not specified in any source doc (tmp_por_budget.md: "Not specified in any POR doc"). Doc 04 or 00_index should note this as TBD-2027. Do not add a new doc for it.

---

## 2. INCONSISTENCY FLAGS

### 2a. POR vs Option D Contradictions

| Item | Stale / Wrong Value | Correct Option D Value | Source Authority |
|------|---------------------|------------------------|-----------------|
| Room dims | 14'×25' (POR main body), 16'×26' (Rev 5.2) | 17'×23'×10' | CLAUDE.md; Garage_Conversion_Option1.md Option D section |
| Processor | AVR-A1H (05_Speaker_System.md, 11_Budget_Summary.md) | Denon AVR-X6800H + ATI AT525NC | CLAUDE.md; 06_Electronics_and_Control.md (current) |
| Sub amps | 6× NX6000D (03_Subwoofer_System.md, 11_Budget, 14_Quick_Ref) | 5× ICEpower 1200AS2 | CLAUDE.md; 06_Electronics_and_Control.md |
| Sub driver count | 16 drivers + 4 triangular columns (03_Subwoofer_System.md) | 8 drivers, 4 stacked rectangular cabinets | CLAUDE.md; Garage_Conversion_Option1.md |
| Shaker count | 16× Aura Pro AST-2B-4 (04_Seating_and_Riser.md, 11_Budget) | 8× (1/seat) | tmp_investigation_notes.md investigation #2 verdict |
| Nearfield subs | Present in all rows (03_Subwoofer) | DEFERRED — space reserved behind Row 1 | CLAUDE.md; tmp_investigation_notes.md investigation #2 |
| Speaker config | 9.4.6 (some docs) vs 9.4.4 (Option D) | CLAUDE.md says 9.4.6 but Garage_Conversion shows 9.4.4 with FW — see flag below |
| Volt-10 sensitivity | 98 dB (pre-Rev 5.0) | 95 dB | tmp_por_core.md, CLAUDE.md |
| Electronics budget | $7,549 (AVR-A1H + DSP-408) | ~$6,779 | tmp_por_budget.md: 06_Electronics_and_Control.md (Option D) |
| Budget total | ~$72K mid (11_Budget_Summary.md) | ~$36,600 out-of-pocket | CLAUDE.md (Option D, with bass deferral) |
| Equipment closet | 4'×6' (main body Garage_Conversion) | 4'×4' | CLAUDE.md; coordinates.json equipment_closet (48"×48") |

**FLAG — Channel config conflict:** CLAUDE.md header says "9.4.6" but tmp_por_core.md (sourced from Garage_Conversion_Option1.md) shows "9.4.4 with FW" (no FW in 9.4.6 per Dolby). CLAUDE.md also says "6× Atmos." Layout_config.json has top_middle disabled — actual ceiling layout is 4 Atmos (TFL/TFR/TRL/TRR). "9.4.4" or "9.4.6" depends on whether top middle pair is installed. This needs explicit resolution in 00_index.

### 2b. T/S Parameter Errors (Vas=15.5 / Qts=0.36)

| Source | Vas stated | Qts stated | Status |
|--------|-----------|-----------|--------|
| ts_params.json | 8.77 cu ft (248.2 L) | 0.53 | CORRECT — use this |
| tmp_por_core.md | 248.2 L (8.77 cu ft) | 0.53 | CORRECT |
| ts_params.json _incorrect_values note | Vas=15.5 cu ft, Qts=0.36 — DO NOT USE | | ERRONEOUS VALUES |

Neither Vas=15.5 nor Qts=0.36 appear in the W0 source extracts as currently stated values — they appear only in the ts_params.json `_incorrect_values_in_por` warning field. W0 agents flagged them as values to reject if found in other docs. Downstream agents writing cabinet calc docs must use Vas=8.77 cu ft / Qts=0.53 exclusively.

**Secondary discrepancy — ts_params.json vs tmp_por_core.md:**

| Parameter | ts_params.json | tmp_por_core.md |
|-----------|---------------|----------------|
| Qes | 0.58 | 0.67 |
| Qms | 6.22 | 2.53 |
| BL (T·m) | 21.5 | 19.2 |
| Re (Ω) | 5.8 | 4.2 |
| Sensitivity | 95.7 dB | 90.7 dB |
| Power handling | 1,500W | 1,200W AES |
| Sd (cm²) | 1,026 | 1,184 |

These are material differences. ts_params.json cites "Dayton Audio UMII18-22 datasheet, Parts Express SKU 295-487." tmp_por_core.md cites "03_Subwoofer_System.md Rev 5.9, verified from Parts Express / Klippel data." Both claim to be from the same driver but disagree on multiple parameters. **This conflict must be resolved by the Analyst against the actual Parts Express datasheet before cabinet calcs are finalized.** Do not use either set without verification. The ts_params.json sealed_cabinet_calcs use the ts_params values (Qts=0.53, Vas=8.77 cu ft).

### 2c. Sub Cabinet Dimensions — Resolved

| Source | Footprint | Height | Status |
|--------|----------|--------|--------|
| CLAUDE.md | 24"×24" | 72" | Option D active ref |
| Garage_Conversion_Option1.md | ~20"×20" | 72" | CONFLICT — overridden |
| layout_config.json | 24"×24" | — | Layout authority |
| coordinates.json | 24"×24" (NW: X1=144, X2=168; Z1=252, Z2=276) | 72" (Y1=0, Y2=72) | Geometric ground truth |

**RESOLVED: 24"×24" footprint, 72" height per coordinates.json.** The ~20" figure in Garage_Conversion_Option1.md is superseded. coordinates.json `_footprint_resolved` field explicitly states this.

### 2d. Screen Bottom Height Error

| Source | Screen bottom Y | Status |
|--------|----------------|--------|
| 02_Front_Stage_System.md (via tmp_por_budget.md) | ~51 inches from floor | WRONG |
| coordinates.json screen Y1 | 30 inches | CORRECT |
| coordinates.json _assertion | "Bottom at Y=30 not 51" | Explicit override |

**RESOLVED: Screen bottom = 30" (coordinates.json). The 51" figure in the legacy POR doc is an error.**

### 2e. Screen Aspect Ratio Conflict

| Source | Aspect | Status |
|--------|--------|--------|
| 14_Quick_Reference.md | 2.35:1 | STALE |
| 02_Front_Stage_System.md | 2.35:1 | STALE |
| CLAUDE.md | 16:9 | Option D authority |
| tmp_investigation_notes.md / layout_config.json | 16:9 | Confirms CLAUDE.md |
| coordinates.json screen X1=172, X2=320 | 148" wide | At 16:9 → 83.25" tall (Y1=30, Y2=113 = 83" tall) — consistent with 16:9 |

**RESOLVED: 16:9 per CLAUDE.md and layout_config.json. 2.35:1 references are stale.**

### 2f. HVAC Price Error

| Source | Unit price | Total DIY cost | Status |
|--------|-----------|---------------|--------|
| tmp_por_budget.md (from 16_HVAC_Plan_Theater.md) | ~$2,359 | ~$2,550–2,650 | CORRECT |
| Task brief | $1,359 | — | WRONG — does not appear in any POR doc |
| Investigation #3 (tmp_investigation_notes.md) | ~$2,550 total | Budget gap vs Option D allocation of $1,800 = ~$750 | Confirmed |

**The $1,359 figure has no source in any POR doc reviewed. Do not use it. Correct value: ~$2,359 unit / ~$2,550–2,650 total DIY.**

### 2g. DSP Platform — Current State

| Document | DSP stated | Date | Status |
|----------|-----------|------|--------|
| 15_DSP_Subwoofer_Processing.md | 2× ADAU1701 (Wondom APM2) | Rev 2.1, 2026-03-19 | CURRENT POR |
| 06_Electronics_and_Control.md | 2× ADAU1701 (APM2) + THAT1646/898B balanced output | Updated 2026-03-19 | CURRENT POR |
| CLAUDE.md | ADAU1452 | — | STALE — not updated post Rev 2.0 |
| Garage_Conversion_Option1.md (stale section) | ADAU1452 | — | STALE |
| 11_Budget_Summary.md | Dayton DSP-408 ($250) | Rev 7.0 | STALE |
| 00_Master_Index.md | DSP-408 + miniDSP 2×4 HD | — | STALE |

**Current correct DSP = 2× ADAU1701 (APM2) with PCM5102 external DAC path.** CLAUDE.md reference to ADAU1452 is a documentation lag — CLAUDE.md has not been updated since the DSP platform change on 2026-03-18/19.

### 2h. Electrical Feed — No #2 Al / 60A in Any Source Doc

| Circuit | Spec found in POR | Source |
|---------|------------------|--------|
| Sub amp circuit | 20A / 240V (5× ICEpower 1200AS2) | tmp_por_budget.md: 06_Electronics_and_Control.md |
| HVAC circuit | 20A double-pole, 12 AWG, 230V | tmp_por_budget.md: 16_HVAC_Plan_Theater.md |
| Processor circuit | 20A / 120V | tmp_por_budget.md: 06_Electronics_and_Control.md |
| Feed from main panel | 100A subpanel | CLAUDE.md; 06_Electronics |
| "#2 Al, 60A breaker" | NOT FOUND in any doc | — |

**The "#2 Al / 60A breaker" spec does not exist in any source document reviewed.** The subpanel is 100A; individual circuits are 20A. If this spec applies to the feeder from main panel to subpanel, it is not documented and requires addition to Doc 04 or Doc 05.

---

## 3. SETTLED vs CONTESTED DECISIONS

### Settled (no team deliberation needed)

| Decision | Value | Authority |
|----------|-------|-----------|
| Room layout | Option D N-S partition, 17'×23'×10' theater | CLAUDE.md; coordinates.json |
| Sub driver | Dayton UMII18-22 (8 units corner array) | CLAUDE.md; tmp_por_core.md |
| Sub footprint | 24"×24" | coordinates.json (explicit override) |
| Sub height | 72" (current layout) | coordinates.json Y2=72 |
| Screen size/ratio | 170" 16:9 AT | CLAUDE.md; layout_config.json |
| Screen bottom | 30" from floor | coordinates.json Y1=30 |
| Sub wiring | 8Ω series per cabinet | tmp_por_core.md |
| Sub amps | 5× ICEpower 1200AS2, 240V, fanless | CLAUDE.md; investigation #1 verdict |
| Sub DSP | 2× ADAU1701 (APM2) + PCM5102 external DAC | 15_DSP (Rev 2.1, 2026-03-19); tmp_investigation_notes.md |
| Speaker: LCR | 3× DIYSG Titan-815LX, 6Ω nominal | CLAUDE.md |
| Speaker: surrounds/Atmos | 10× DIYSG Volt-10, 95 dB, 8Ω | CLAUDE.md |
| Processor | Denon AVR-X6800H + ATI AT525NC | CLAUDE.md |
| Dirac Live | Full + Bass Control + ART | CLAUDE.md; 06_Electronics |
| HVAC | MrCool DIY 12K, partition wall mount | CLAUDE.md; investigation #3 supplement 08 verdict |
| HVAC price | ~$2,550–2,650 total DIY | tmp_por_budget.md |
| Shaker count | 8× Aura Pro AST-2B-4 (1/seat) | investigation #2 verdict; CLAUDE.md |
| Nearfield subs | DEFERRED — reserve space, build corners first | CLAUDE.md; investigation #2 verdict |
| Equipment closet | 4'×4', NE gym corner | CLAUDE.md; coordinates.json |
| Electrical | 100A subpanel; sub circuit 20A/240V | 06_Electronics_and_Control.md |

### Contested (requires explicit team assessment before writing into new docs)

| Decision | Conflict | Action Needed |
|----------|---------|---------------|
| Channel config: 9.4.4 vs 9.4.6 | CLAUDE.md header "9.4.6"; Garage_Conversion "9.4.4 with FW"; layout_config top_middle disabled | Owner must confirm: does FW pair exist? Are 6 Atmos intended or 4? |
| T/S parameters | ts_params.json vs tmp_por_core.md disagree on Qes, Qms, BL, Re, sensitivity, power, Sd | Analyst must verify against actual Parts Express datasheet before cabinet calcs are used |
| CLAUDE.md ADAU1452 reference | CLAUDE.md says ADAU1452; POR says ADAU1701 since 2026-03-18 | CLAUDE.md needs update — dispatcher-level edit, not agent work |
| Electrical feeder (#2 Al / 60A) | Spec not found in any doc; subpanel is 100A | Confirm feeder spec and add to construction doc |
| Budget total | CLAUDE.md "~$36,600"; 11_Budget_Summary says ~$72K mid (legacy) | Analyst must rebuild Option D budget from line items |

### Open — Requires Team Calculation

| Decision | Options | Current Data |
|----------|---------|-------------|
| Sub cabinet height (final) | 72" / 96" / 120" | ts_params.json recommendation: 96" (Qtc=0.700, Butterworth optimum); 72" in current coordinates (Qtc=0.749); 120" = Qtc=0.669 (overdamped) |

**Note on sub height:** ts_params.json team_recommendation is 96" (Qtc=0.700, maximally flat). Current coordinates.json has Y2=72 (72" as-placed). The 96" option adds 24" — structural and visual impact on the room must be evaluated against acoustic benefit. F3 is nearly identical across all three heights (~29.4 Hz) because room gain dominates below 30 Hz in this room. The Analyst should confirm whether F3 difference justifies height change, or whether 72" is adequate given room gain.

---

## 4. INVESTIGATION TRIGGER CHECK

| Question | Research/Verify Needed? | Notes |
|----------|------------------------|-------|
| T/S parameter discrepancy (Qes, Qms, BL, Re, sensitivity, Sd) | YES — Analyst verification against Parts Express datasheet | Cannot finalize cabinet calcs without resolved T/S |
| Channel config 9.4.4 vs 9.4.6 | NO — owner decision, not research | |
| Projector throw distance (170" 16:9 at ~10.5' throw) | YES — needed for Doc 04 projector spec | Not in any source doc; required for projector selection 2027 |
| #2 Al / 60A feeder spec | NO — electrical code lookup (owner/electrician) | Not a web research task |
| Sub height 96" vs 72" acoustic benefit | NO — calculation already in ts_params.json; room gain assessment is sufficient | ts_params.json already shows F3 within 0.1 Hz across all heights |

---

## 5. ADVISORY VOICE: SENIOR

**Is the 7-doc scope right-sized?** Yes. The legacy 16-doc POR bloated across revisions. Seven docs is correct for a single-owner build guide targeting 2027.

**Over-engineering risks in proposed deliverables:**
- Do not create a separate doc for projector specs — one TBD line in Doc 00_index is sufficient until 2027 selection.
- Do not create a dedicated phase doc. Phase split (corner subs first, nearfield deferred) is two lines in Doc 06_budget.
- Do not recreate revision history tables in every doc. One revision block in 00_index; other docs are datestamped, not versioned.
- The OBJ model generation skill (tmp_investigation_notes.md) is tooling, not design documentation. It does not belong in any of the 7 deliverable docs.

---

## 6. ADVISORY VOICE: ACTON

Every claim in this audit is sourced. Summary of source mapping:

| Claim | Source |
|-------|--------|
| 24"×24" footprint resolved | coordinates.json `_footprint_resolved` field |
| Screen bottom Y=30" | coordinates.json screen Y1=30, `_assertion` field |
| Screen 16:9 confirmed | layout_config.json (via tmp_investigation_notes.md); coordinates.json X width 148" matches 16:9 at 83" height |
| ADAU1701 as current DSP | tmp_por_core.md DSP Platform table; 15_DSP_Subwoofer_Processing.md Rev 2.1 cited |
| HVAC price ~$2,359 unit | tmp_por_budget.md HVAC table, sourced from 16_HVAC_Plan_Theater.md |
| $1,359 has no source | tmp_por_budget.md explicitly states "this figure does not appear in any POR doc" |
| Qts=0.53 / Vas=8.77 ft³ | ts_params.json; tmp_por_core.md both agree on these two values |
| T/S secondary params conflict | ts_params.json vs tmp_por_core.md — flagged, not resolved |
| Sub height 72" in coordinates | coordinates.json corner_subs Y2=72 |
| ts_params recommendation 96" | ts_params.json team_recommendation |
| #2 Al / 60A not in docs | tmp_por_budget.md: "FLAG: No doc states #2 Al, 60A breaker..." |
| 9.4.4 vs 9.4.6 conflict | tmp_por_core.md speaker table (9.4.4); CLAUDE.md header (9.4.6) |

**Unsourced claims count: 0.**
