# Architect Review — Task #14
**Date:** 2026-03-21
**Sources:** tmp_por_core.md, tmp_por_budget.md, tmp_investigation_notes.md, coordinates.json, ts_params.json

---

## 1. DOCUMENT TREE REVIEW

Target: 7-doc structure (00_index through 06_budget).

| Doc Slot | Expected | Status | Notes |
|----------|----------|--------|-------|
| 00_index | Master index | EXISTS — stale | References NX6000D (superseded), DSP-408 (superseded). Last updated Mar 13, 2026. |
| 01_room | Project overview & room | EXISTS — STALE | Rev 5.2, Nov 2024. Wrong room dims (16'×26' vs 17'×23'). Never updated for Option D. |
| 02_front | Front stage system | EXISTS — STALE | Rev 5.2. Marantz AV10 + PURIFI monoblocks in signal flow. Stage dims/screen bottom height (51") are pre-Option D. |
| 03_sub | Subwoofer system | EXISTS — STALE | Rev 5.9. Triangular column design (superseded). Driver T/S params are correct, cabinet geometry is not. |
| 04_amp | (no standalone amp doc) | MISSING | Amp content split between 05_Speaker and 06_Electronics. If target structure wants a discrete amp doc, this is a gap. |
| 05_speakers | Speaker system | EXISTS — partially current | Rev 7.0, Mar 2026. Uses AVR-A1H — conflicts with CLAUDE.md (X6800H + ATI). |
| 06_electronics | Electronics & control | EXISTS — partially current | Updated Mar 19, 2026. Best Option D alignment. BUT internal conflict: signal flow diagram says X6800H, processor table says A1H. |

**Scope verdict:** The 7-doc structure is appropriate for a 2027 owner build doc. The problem is not scope — it is that 3 of 7 docs are pre-Option D and have never been updated. The new-doc build package must either update these or supersede them explicitly. Do not let the build agent assume legacy docs are current.

**Scope creep risk:** The investigation notes include OBJ model generation skill, SigmaStudio COM details, and audio test pipeline notes. These are operational/build-phase references, not owner design docs. They do not belong in 00-06 build package. Keep them in `POR/skills/` and `tools/` respectively.

---

## 2. INCONSISTENCY FLAGS

### A. T/S Parameter Values (Vas=15.5, Qts=0.36)

| Location | Finding |
|----------|---------|
| 03_Subwoofer_System.md | Vas=248.2 L, Qts=0.53 — CORRECT |
| ts_params.json (W0 output) | Vas_cuft=8.77 (=248.4 L), Qts=0.53 — CORRECT |
| ts_params.json note field | Explicitly flags "NOT from POR docs (which had Vas=15.5, Qts=0.36 — wrong)" |
| Any current source doc | NOT FOUND |

**Verdict:** Vas=15.5 and Qts=0.36 are erroneous values that appear in the ts_params.json note as a warning about what NOT to use. They do not appear in any current POR source. The W0 agent flagged them correctly. No active doc contains these values — but the note implies a prior version or external source did. Build agent must use ts_params.json values only. Flag for documentation header: "these erroneous values circulated in prior sessions — do not reintroduce."

**Additional discrepancy within ts_params.json itself:**
| Param | ts_params.json | tmp_por_core.md (from 03_Sub doc) |
|-------|---------------|----------------------------------|
| Qes | 0.58 | 0.67 |
| Qms | 6.22 | 2.53 |
| Re | 5.8 Ω | 4.2 Ω |
| BL | 21.5 T·m | 19.2 T·m |
| Sd | 1,026 cm² | 1,184 cm² |
| Sensitivity | 95.7 dB | 90.7 dB |

This is a material discrepancy between ts_params.json (Dayton datasheet SKU 295-487) and tmp_por_core.md (from 03_Subwoofer_System.md). The ts_params.json note says values are from Dayton datasheet. Qts=0.53 matches across both, but Qes/Qms/Re/BL/Sd/sensitivity diverge significantly. **This requires resolution before enclosure analysis is used.** Sensitivity difference is 5 dB — that is not a rounding issue.

### B. Sub Cabinet Dimensions

| Source | Width × Depth × Height | Authority |
|--------|------------------------|-----------|
| CLAUDE.md (Option D) | 24" × 24" × 72" | Highest — consolidated config |
| Garage_Conversion_Option1.md | ~20" × 20" × 72" | High — detailed design doc |
| coordinates.json | 24" × 24" (footprint) | Derived from layout_config.json |
| ts_params.json cabinet analysis | 24" × 24" footprint | Derived |
| layout_config.json | 24" × 24" | Source for coordinates.json |

**Verdict:** 24"×24" wins. CLAUDE.md + layout_config.json + coordinates.json all agree. Garage_Conversion_Option1.md's ~20"×20" is likely an early estimate. The `_footprint_resolved` note in coordinates.json explicitly states this resolution. **The 72" height is in CLAUDE.md only; ts_params.json recommends 96" for Qtc=0.700 (closest to Butterworth).** This is a DESIGN DECISION gap — cabinet height is not settled.

### C. Screen Bottom Height

| Source | Bottom Height | Notes |
|--------|--------------|-------|
| 02_Front_Stage_System.md | ~51" from floor | Stage deck 27" + ~24" above = 51". Legacy Rev 5.2. |
| coordinates.json | Y1=30 (30 inches) | Explicit assertion: "Bottom at Y=30 not 51." |
| Garage_Conversion_Option1.md | Not directly stated | Stage depth 3', stage height not explicitly stated |

**Verdict:** 30" is correct for Option D. The 02_Front_Stage_System.md 51" value is from the Rev 5.2 era with a different stage height. The coordinates.json assertion makes this explicit. Any doc referencing 51" screen bottom is stale and must be corrected.

### D. Screen Aspect Ratio

| Source | Aspect Ratio |
|--------|-------------|
| CLAUDE.md | 16:9 |
| 02_Front_Stage_System.md | 2.35:1 |
| 11_Budget_Summary.md | Screen listed at $3,000, no ratio stated |
| 00_Master_Index | 170", no ratio stated |
| tmp_por_budget.md (from 11_Budget) | $3,000 budget, "170" 2.35:1 AT" from 02_Front_Stage |
| Garage_Conversion_Option1.md | 170" 16:9 AT, width 12.3' (148"), height 6.9' (83") |

**Verdict:** 16:9 is correct for Option D. CLAUDE.md + Garage_Conversion_Option1.md agree. The 148"×83" dimensions (confirmed: 148²+83²=√(21904+6889)=√28793=169.7"≈170" diagonal) confirm 16:9. The 02_Front_Stage 2.35:1 reference is Rev 5.2 legacy. Screen width=148" matters for projector throw calculation — carry the correct value.

### E. DSP Platform

| Document | DSP Stated | Date |
|----------|-----------|------|
| CLAUDE.md | ADAU1452 (8.24 fixed-point) — sub DSP | Authoritative |
| 06_Electronics_and_Control.md | 2× ADAU1701 (APM2 Wondom) | Mar 19, 2026 |
| 15_DSP_Subwoofer_Processing.md | 2× ADAU1701 (APM2) | Mar 19, 2026 |
| 00_Master_Index | DSP-408 + miniDSP 2×4 HD | Mar 13, 2026 — STALE |
| 11_Budget_Summary | Dayton DSP-408 ($250) | STALE |
| 14_Quick_Reference | DSP-408 + miniDSP 2×4 HD | STALE |
| tmp_investigation_notes.md | ADAU1452 for sub DSP; ADAU1701 (APM2) for preamp/channel DSP | Investigation verdict |

**Verdict:** The investigation notes resolve this correctly. There are TWO DSP devices:
- **Sub DSP:** ADAU1452 (8.24 fixed-point) — replaces DSP-408 + miniDSP chain
- **Channel/preamp DSP:** ADAU1701 on Wondom APM2 board — for ICEpower input matching

The 06_Electronics and 15_DSP docs listing "ADAU1701" refer to the channel DSP (APM2 board), not the sub DSP. CLAUDE.md's ADAU1452 reference is to the sub DSP. These are not contradictory — they describe two different devices in the signal chain. The 00/11/14 docs referencing DSP-408 are stale. **The build package must document both devices explicitly to prevent future confusion.**

### F. Speaker Amplifier

| Source | Processor | External Amp |
|--------|-----------|-------------|
| CLAUDE.md | Denon AVR-X6800H | ATI AT525NC (LCR + FW, 5ch) |
| 05_Speaker_System.md Rev 7.0 | Denon AVR-A1H | None (all 15ch internal) |
| 06_Electronics_and_Control.md | Mixed — signal flow = X6800H, processor table = A1H | ATI AT525NC (5ch) |

**Verdict:** CLAUDE.md is highest authority. X6800H + ATI AT525NC is the Option D design. The AVR-A1H entry in 05_Speaker_System.md Rev 7.0 appears to be a prior sub-revision that was not carried forward. The 06_Electronics signal flow diagram (X6800H) aligns with CLAUDE.md. This conflict exists WITHIN 06_Electronics (two descriptions of the same doc disagree) — that doc needs a single authoritative table.

**Budget impact:** AVR-X6800H ($3,700) + ATI AT525NC (owned) vs AVR-A1H ($6,500) = $2,800 difference. The Option D ~$36.6K total uses X6800H cost.

### G. Electrical: Wire Gauge and Breaker

| Circuit | Breaker | Wire | Source |
|---------|---------|------|--------|
| Sub amps (240V) | 20A double-pole | Not specified in tmp_por_budget | 06_Electronics |
| HVAC | 20A double-pole | 12 AWG 3-conductor | 16_HVAC_Plan_Theater |
| Processor/misc (120V) | 20A single | Not specified | 06_Electronics |

**Assessment:** No direct wire gauge contradiction found across docs reviewed. The 20A/240V for 5× ICEpower 1200AS2 deserves scrutiny: 5 modules at max draw could exceed 20A on 240V. Investigation notes say "one 20A/240V circuit" — this should be validated. 12 AWG for HVAC 20A circuit is code-correct. No contradiction flagged here, but the sub amp circuit sizing is an open engineering question (see Section 4).

### H. HVAC Pricing

| Source | Price |
|--------|-------|
| Option D budget (CLAUDE.md) | $1,800 budgeted |
| 16_HVAC_Plan_Theater.md | ~$2,359 system package + $175-280 accessories = ~$2,550 total |
| tmp_investigation_notes.md | "~$2,550 ($750 gap from $1,800 budget)" |
| tmp_por_budget.md | $2,359 system + additional items = $2,550-2,650 total |

**Verdict:** $1,359 does not appear in any source reviewed. The real figures are: $1,800 (Option D budget, understated) vs ~$2,559 actual (midpoint of $2,550-2,650 range). Gap is ~$759. The $2,359 is the unit price; total with accessories is ~$2,559. No $1,359 figure found — if that number appears in a downstream doc, it is fabricated or from an unread source.

---

## 3. SETTLED vs CONTESTED

| Decision | Status | Basis |
|----------|--------|-------|
| Room dims: 17'×23'×10' | SETTLED | CLAUDE.md + Garage_Conversion + 16_HVAC all agree |
| Screen: 170" 16:9 AT | SETTLED | CLAUDE.md + Garage_Conversion agree; 02_Front (2.35:1) is legacy |
| Screen bottom: 30" | SETTLED | coordinates.json explicit assertion overrides 02_Front legacy |
| LCR: Titan-815LX × 3 | SETTLED | Consistent across all current docs |
| Surrounds/Atmos: Volt-10 V2 × 10 | SETTLED | CLAUDE.md, 05_Speaker agree; sensitivity = 95 dB (not 98) |
| Corner subs: 8× UMII18-22, 4 cabs | SETTLED | CLAUDE.md, investigation notes, coordinates.json |
| Sub cab footprint: 24"×24" | SETTLED | CLAUDE.md + layout_config.json + coordinates.json |
| Sub cab height | CONTESTED | CLAUDE.md says 72"; ts_params.json analysis recommends 96" (Qtc=0.700) |
| Sub wiring: 8Ω series per pair | SETTLED | CLAUDE.md, 06_Electronics |
| Sub amps: 5× ICEpower 1200AS2, 240V | SETTLED | CLAUDE.md, investigation verdict |
| Sub DSP: ADAU1452 | SETTLED | CLAUDE.md, investigation notes (confirmed over DSP-408+miniDSP) |
| Channel DSP: ADAU1701 (APM2) | SETTLED | 06_Electronics, 15_DSP, investigation notes |
| Speaker amp: X6800H + ATI AT525NC | SETTLED | CLAUDE.md; 05_Speaker Rev 7.0 A1H is a stale sub-revision |
| SPL target: 95 dB @ MLP (-10 dB Ref) | SETTLED | CLAUDE.md, 05_Speaker, 06_Electronics |
| HVAC: MrCool DIY 12K, partition wall | SETTLED | Investigation verdict + 16_HVAC |
| HVAC budget: ~$2,559 actual vs $1,800 budgeted | CONTESTED | Gap of ~$759 needs budget correction |
| Nearfield subs: deferred | SETTLED | CLAUDE.md, investigation notes |
| Shakers: 8× Aura Pro AST-2B-4 | SETTLED | CLAUDE.md (reduced from 16) |
| Option D total budget: ~$36.6K | CONTESTED | CLAUDE.md states it; no POR doc has an Option D budget summary |
| T/S params: Qts=0.53, Vas=8.77 cu ft | SETTLED | ts_params.json + 03_Sub agree on Qts/Vas; other params diverge (see flags) |
| T/S params: Qes, Qms, Re, BL, Sd | CONTESTED | ts_params.json vs 03_Sub doc disagree materially |

---

## 4. INVESTIGATION TRIGGER CHECK

| Question | Priority | Reason |
|----------|----------|--------|
| T/S parameter reconciliation: ts_params.json vs 03_Sub doc | HIGH | 5 dB sensitivity difference; Qes/Qms/Re/BL/Sd all diverge. Both claim Dayton datasheet. One may be from an earlier driver revision or wrong SKU. Use wrong params = wrong box tuning. |
| Sub cabinet height: 72" (CLAUDE.md) vs 96" (ts_params.json analysis) | HIGH | Qtc=0.749 at 72" vs Qtc=0.700 at 96". F3 is ~29 Hz either way due to room gain. But 72" fits inside 10' room with margin; 96" also fits. Decision should be explicit, not left as conflict. |
| Sub amp 20A/240V circuit for 5× ICEpower 1200AS2 | MEDIUM | Each 1200AS2 draws ~175W idle, up to ~600W peak. 5 units = up to 3,000W peak = 12.5A @ 240V. Seems OK for 20A but verify with inrush. May need 30A circuit. |
| Option D budget: create a formal doc | MEDIUM | ~$36.6K total is in CLAUDE.md but no POR file documents it. Build package needs a verified Option D budget table. |
| AVR-X6800H vs ATI AT525NC channel assignment | LOW | Which 5 channels does ATI drive? LCR + FW = 5ch confirmed. But 06_Electronics is internally inconsistent about this. |

---

## 5. ADVISORY — SENIOR (Right-Sized for 2027 Build Owner Doc?)

The 7-doc structure (00-06) is appropriate. A 2027 build owner needs:
- Room/layout (01) — UPDATE needed
- Front stage (02) — REBUILD needed (most stale)
- Sub system (03) — UPDATE cabinet geometry only; driver params need resolution first
- Amp/electronics (04/06) — CONSOLIDATE; the AVR/ATI conflict must be resolved in a single authoritative table
- Budget (11/06_budget) — REBUILD; no Option D budget doc exists

**What to cut:** OBJ model generation details, SigmaStudio COM protocol, audio test pipeline notes — these belong in operational/build-phase docs, not in the owner design package. The design package should state what was built and why, not how to operate the DSP via Python.

**What's missing:** A one-page Option D summary that supersedes Rev 7.0 POR where they conflict. CLAUDE.md serves this role informally but is not a design doc — it is a Claude operational config.

---

## 6. ADVISORY — ACTON (Every Assertion Must Cite Source)

Downstream build agents must follow this rule. Failures found in W0 outputs:

| Assertion | Citation Status |
|-----------|----------------|
| "24x24 footprint resolved" in coordinates.json | CITED: layout_config.json override |
| "Bottom at Y=30 not 51" in coordinates.json | CITED: assertion block |
| T/S param note "NOT from POR docs (which had Vas=15.5, Qts=0.36)" | SOURCE CLAIMED (Dayton datasheet SKU 295-487) but no URL/date |
| tmp_por_core.md T/S params "from 03_Subwoofer_System.md" | CITED |
| Investigation notes: "23.5 dB(A) silent mode" for MrCool | CITED: investigation file 06_noise_assessment.md |
| Option D total "$36.6K" | NOT CITED in any POR doc — appears only in CLAUDE.md |
| "$1,800 HVAC budget" from Option D | CITED as CLAUDE.md but value not found in W0 budget extract — needs source |

**Enforcement rule for build agents:** Any spec value in the new docs must trace to either (a) a POR file with revision date, (b) a coordinates.json/ts_params.json resolved value with provenance note, or (c) a completed investigation file. Values that trace only to CLAUDE.md should be flagged as "config reference — verify against POR."
