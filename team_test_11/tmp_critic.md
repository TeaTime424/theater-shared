# Critic Review — Option D Home Theater Design Package
Generated: 2026-03-21 | Reviewing: tmp_architect.md (W1-A), tmp_analyst.md (W1-B)

---

## 1. CONFLICT RESOLUTION

| # | Topic | Architect Position | Analyst Position | Ruling | Source / Reason |
|---|-------|--------------------|------------------|--------|-----------------|
| C1 | Screen aspect ratio | 16:9 — CLAUDE.md + layout_config authority | **2.35:1 required** — claims 170" 16:9 top = 11.2 ft, exceeds 10 ft ceiling | **Architect is correct. 16:9 fits.** Analyst used stale 51" screen bottom from 02_Front_Stage_System.md instead of coordinates.json Y1=30. With bottom at 30": top = 30 + 83.4 = 113.4" = 9.45 ft. Ceiling = 120". Clearance = 6.6". FITS. The Analyst's "CRITICAL" F1 flag is a calculation error caused by reading the wrong source. | coordinates.json screen Y1=30, Y2=113; _assertion field explicitly overrides 51" legacy value |
| C2 | Sub footprint | **RESOLVED: 24"×24"** — coordinates.json `_footprint_resolved` field is dispositive | Flagged as G3 "HIGH — unresolved" | **Architect is correct.** coordinates.json contains an explicit `_footprint_resolved` key stating "24x24 inches (layout_config.json overrides specs.yaml 20x20)." This is not an open question. The Analyst treated a resolved item as unresolved. | coordinates.json corner_subs `_footprint_resolved` field |
| C3 | HVAC price | ~$2,359 unit / ~$2,550–2,650 total DIY | ~$2,359 unit / ~$2,550–2,650 total — **agrees, $1,359 wrong** | **Both agree.** $1,359 has no source in any POR doc. Correct value is ~$2,359 unit / ~$2,550–2,650 total. | tmp_por_budget.md citing 16_HVAC_Plan_Theater.md |
| C4 | Channel config 9.4.4 vs 9.4.6 | Contested — CLAUDE.md says 9.4.6, Garage_Conversion says 9.4.4, layout_config top_middle disabled | Not addressed | **Architect correctly identifies this as unresolved; owner must decide.** CLAUDE.md header "9.4.6" is the stated design but layout_config has top_middle disabled — actual ceiling array may be 4 Atmos (TFL/TFR/TRL/TRR). This is a documentation inconsistency, not a build blocker for Phase 4. | CLAUDE.md, tmp_por_core.md, layout_config |
| C5 | DSP platform | Current = 2× ADAU1701 (APM2), CLAUDE.md ADAU1452 reference is documentation lag | Same finding — ADAU1701 confirmed current | **Both agree.** 15_DSP_Subwoofer_Processing.md Rev 2.1 (2026-03-19) is authoritative. CLAUDE.md needs a dispatcher-level edit. Not a blocker. | 15_DSP_Subwoofer_Processing.md Rev 2.1 |
| C6 | Sub height recommendation | 72" in coordinates.json; ts_params recommends 96" — flags as open question | Recommends 96" (Butterworth optimum), notes 72" acoustically equivalent in-room | See Section 4 — binding decision made here. | ts_params.json sealed_cabinet_calcs |
| C7 | Grand total arithmetic | Did not recompute category totals | $72K stated vs $74,980 computed — $2,980 discrepancy | **Analyst is correct on the legacy total arithmetic.** The $72K stated figure in 11_Budget_Summary.md is understated by ~$3K. However both agents agree this budget is stale and must be rebuilt for Option D. | tmp_por_budget.md; Analyst Section 1c |
| C8 | Dirac Live pricing | $799 stated in POR | Flags $799 as potentially 2× actual (~$397 direct) | **Analyst flag is valid but unverified.** Dirac pricing varies by bundling. This is an ADVISORY — mark [UNVERIFIED] until confirmed. | tmp_por_budget.md; Analyst Section 1b |

### C1 Detail — Screen Geometry: Correcting the Analyst's Error

The Analyst's F1 "CRITICAL" flag is wrong. The error chain:

1. Analyst sourced screen bottom from 02_Front_Stage_System.md: 51"
2. coordinates.json explicitly states `_assertion: "Bottom at Y=30 not 51"` and sets Y1=30
3. The Analyst did not treat coordinates.json as the authoritative override, or did not cross-check it

**Correct 170" 16:9 geometry:**
- Width = 170 × 16/sqrt(16²+9²) = 170 × 16/18.358 = **148.2"** (matches coordinates.json X: 320-172 = 148")
- Height = 170 × 9/18.358 = **83.4"** (matches coordinates.json Y: 113-30 = 83")
- Bottom at 30" → top at 113.4" → 6.6" below 120" ceiling → **FITS**

coordinates.json Y2=113 is the geometric ground truth. The screen geometry is internally consistent and valid. The Analyst's recommendation to switch to 2.35:1 or reduce diagonal to ~141" is **incorrect and must not be acted upon.**

### C2 Detail — Sub Footprint: Already Resolved

The Analyst's G3 gap ("20"×20" vs 24"×24" — HIGH") misreads the source state. coordinates.json contains:

```
"_footprint_resolved": "24x24 inches (layout_config.json overrides specs.yaml 20x20)"
```

All four corner sub entries confirm 24"×24" (e.g., NW: X1=144, X2=168 = 24", Z1=252, Z2=276 = 24"). The Analyst's Qtc=0.834 calculation at 20"×20" is moot — that footprint is superseded. The 20"×20" figure in Garage_Conversion_Option1.md is stale.

---

## 2. BUDGET ARITHMETIC VERDICT

### Legacy Budget (11_Budget_Summary.md Rev 7.0)

**FAIL.** The Analyst correctly found the legacy stated total ($72K) is understated by ~$2,980 vs the sum of its own line items ($74,980).

| Category | Stated | Analyst Recompute |
|----------|--------|-------------------|
| Projector | $30,000 | $30,000 |
| LF System | $12,327 | $12,324.68 (+$2.32 rounding error in enclosures) |
| Speakers | $7,304 | Not verifiable — no line items in source |
| Electronics | $7,549 | $7,549 (Rev 7.0) |
| Seating | $6,000 | $6,000 |
| Acoustic Treatment | $5,500 | $5,500 |
| Screen | $3,000 | $3,000 |
| Infrastructure | $3,300 | $3,300 |
| **Stated total** | **~$72,000** | |
| **Computed total** | | **$74,980** |
| **Discrepancy** | | **$2,980 (stated understated)** |

### Option D Budget

**NOT COMPUTABLE from current source docs.** The legacy LF budget ($12,327) is entirely stale — reflects 16 drivers + NX6000D + fan mods + triangular cabs. Option D uses 8 drivers + ICEpower + rectangular enclosures. No verified Option D LF line items exist in any source document.

**ADVISORY (not BLOCKER):** The design package (Doc 06_budget) must build Option D budget from scratch. CLAUDE.md states "~$36,600 out-of-pocket" but this is not derivable from current docs. The budget doc cannot be written until:
- ICEpower 1200AS2 per-unit price is verified [UNVERIFIED]
- Dirac Live bundle price is verified [UNVERIFIED]
- Speaker line items (Titan-815LX + Volt-10) are itemized

The $36,600 figure in CLAUDE.md is the target; the arithmetic path to it is not yet documented. This is an ADVISORY for the budget doc author, not a BLOCKER on the overall design package.

---

## 3. T/S PARAMETER VERIFICATION

**PASS — with one flag.**

All sub cabinet calculations in ts_params.json and the Analyst's verification use:
- Qts = 0.53 (correct)
- Vas = 8.77 cu ft (correct)
- Fs = 22.0 Hz (correct)

The erroneous values (Vas=15.5, Qts=0.36) appear only in ts_params.json's `_incorrect_values_in_por` warning field. They do not appear in any calculation. Neither agent used them.

**Secondary T/S conflict (Architect flag, not used in calcs):**

ts_params.json and tmp_por_core.md agree on Qts=0.53/Vas=8.77 but disagree on secondary parameters (Qes, Qms, BL, Re, sensitivity, Sd, power handling). These secondary params are not used in the sealed cabinet Fc/Qtc/F3 calculations. The sensitivity discrepancy (95.7 dB per ts_params vs 90.7 dB per tmp_por_core.md) matters for SPL projections but not for cabinet tuning.

**Ruling:** Use ts_params.json (cites "Dayton Audio UMII18-22 datasheet, Parts Express SKU 295-487") for all calculations. The 90.7 dB figure in tmp_por_core.md appears to be a transcription error — 5 dB below spec is implausible for an 18" driver of this class. The Analyst's gain staging section already uses 95.7 dB from ts_params.json, which is correct.

**No BLOCKER on T/S params.** The Vas=15.5/Qts=0.36 values appear nowhere in the calculation chain.

---

## 4. SUB CABINET HEIGHT DECISION

**BINDING DECISION: 72 inches.**

| Height | Vb (ft³) | Qtc | Fc (Hz) | F3 (Hz) | Practical Height |
|--------|----------|-----|---------|---------|-----------------|
| 72" | 8.778 | 0.749 | 31.1 | 29.45 | 6 ft — manageable |
| 96" | 11.766 | 0.700 | 29.1 | 29.35 | 8 ft — near ceiling |
| 120" | 14.755 | 0.669 | 27.8 | 29.44 | 10 ft — full ceiling height |

**Rationale for 72":**

1. **F3 is acoustically identical across all three heights.** 29.45 vs 29.35 vs 29.44 Hz — a 0.1 Hz spread. Room gain in a 3,910 cu ft sealed room adds ~10–12 dB below 30 Hz, rendering this difference inaudible and unmeasurable without a calibrated anechoic chamber.

2. **Qtc=0.749 is not a problem.** The ts_params.json note calls it "near-maximally-flat, very close to Butterworth 0.707 target." In-room EQ (Dirac Live + ADAU1701) will shape the response below 80 Hz regardless of enclosure alignment. A 0.049 Qtc difference from Butterworth is swamped by room modal behavior.

3. **72" already exists in coordinates.json.** The coordinate file was validated 2026-03-21 and is the geometric ground truth. Changing to 96" requires updating coordinates.json, rechecking all dependent geometry (screen wall structure, stage clearance), and revalidating the layout. This is not zero-cost.

4. **Structural role.** The front corner pair serves as screen wall structure. 72" (6 ft) is the correct height for a structural element in a room with 10 ft ceilings — it does not compete visually or structurally with the 10 ft ceiling. 96" cabinets at 8 ft would dominate the room visually and complicate the screen wall integration.

5. **ts_params.json recommends 96"** — this recommendation is noted but overridden on practical grounds. The acoustic case for 96" is weak (F3 within 0.1 Hz) and the practical case against it (structural, geometric, visual) is strong.

**Final answer: 72", Qtc=0.749, Fc=31.1 Hz, F3=29.45 Hz.** Downstream agents use these values. The 96" and 120" options are closed.

---

## 5. SCREEN GEOMETRY CRITICAL CHECK

**The Analyst's screen geometry claim (F1 CRITICAL) is WRONG.** See Section 1, C1.

Summary of correct 170" 16:9 geometry:

| Parameter | Analyst's Calculation | Correct Calculation |
|-----------|-----------------------|---------------------|
| Screen bottom | 51" (from stale POR doc) | 30" (coordinates.json Y1=30) |
| Screen height | 83.4" | 83.4" (correct) |
| Screen top | 51 + 83.4 = **134.4" = 11.2 ft** | 30 + 83.4 = **113.4" = 9.45 ft** |
| Ceiling clearance | **NEGATIVE — doesn't fit** | **6.6" — FITS** |
| Verdict | "CRITICAL: 170" 16:9 impossible" | PASSES. 16:9 confirmed. |

Cross-check against coordinates.json:
- X span: 320 - 172 = 148" wide → 170 × 16/18.358 = 148.2" ✓
- Y span: 113 - 30 = 83" tall → 170 × 9/18.358 = 83.4" ✓
- Y2 = 113" = 9.42 ft < 10 ft ceiling ✓

The Analyst's F1 flag and G1 gap ("Screen aspect ratio unresolved") are both **closed**. 16:9 is confirmed. No aspect ratio change needed. No diagonal reduction needed.

---

## 6. SCOPE CHECK

The 7-doc structure (00_index through 06_budget) is right-sized for a single-owner 2027 build guide.

| Assessment | Finding |
|------------|---------|
| Doc count | 7 — appropriate. Legacy POR at 16+ docs was bloated. |
| Coverage | All major systems covered: room, speakers, subs, electronics, construction, budget |
| Overlap risk | Sub amp chain (ICEpower) touches both Doc 03 and Doc 04. Architect's split (amp chain in 04, cabinet + T/S in 03) is correct. |
| Missing coverage | Projector throw/model: TBD-2027, one line in 00_index is sufficient. Do not add a doc. |
| Over-engineering risk | No separate phase doc, no revision history tables per doc, no OBJ model generation doc — all correct per Architect advisory. |
| Projector budget | $30K lump — acceptable placeholder; projector not purchased until 2027. |

No scope changes needed.

---

## 7. VERDICT

**ADJUST** — one analytical error in the Analyst output must be corrected before Phase 4 proceeds. No STOP-level blockers exist.

### BLOCKER List

None. No item prevents Phase 4 from starting.

The two highest-severity Analyst flags (F1 screen geometry, G3 sub footprint) are both factually wrong and are closed by this review. The budget is stale but that is a known condition (Option D supersedes Rev 7.0 budget) — budget doc authorship in Phase 4 is expected to rebuild from scratch.

### ADVISORY List

| ID | Item | Action |
|----|------|--------|
| A1 | **Analyst F1/G1 is wrong — do not propagate** | Phase 4 agents must not act on the "170" 16:9 doesn't fit" conclusion. Screen is 16:9, bottom at 30", top at 113". |
| A2 | **Analyst G3 is wrong — do not propagate** | Sub footprint is 24"×24" per coordinates.json. No recalculation needed. |
| A3 | **Option D budget arithmetic** | Doc 06_budget author must rebuild LF line items from scratch: 8× UMII18-22 + 5× ICEpower + rectangular enclosures. Cannot carry forward $12,327 LF figure. |
| A4 | **Dirac Live bundle price** | $799 stated; verify actual bundle pricing before budget is finalized. Mark [UNVERIFIED] until confirmed. |
| A5 | **ICEpower 1200AS2 per-unit price** | $373/unit not sourced to a vendor. Verify before budget is finalized. Mark [UNVERIFIED]. |
| A6 | **Channel config 9.4.4 vs 9.4.6** | Owner decision required. CLAUDE.md says 9.4.6; layout_config has top_middle disabled suggesting 9.4.4. One line in 00_index to clarify. Not a build blocker. |
| A7 | **CLAUDE.md ADAU1452 reference** | Dispatcher-level edit: update CLAUDE.md to reflect 2× ADAU1701 (APM2) as current DSP platform. |
| A8 | **Speaker budget line items** | $7,304 lump has no itemization in source docs. Doc 06 author must itemize: 3× Titan-815LX flat-pack + 10× Volt-10 + drivers. |
| A9 | **Secondary T/S params discrepancy** | ts_params.json vs tmp_por_core.md disagree on Qes, Qms, BL, Re, Sd, sensitivity. Does not affect cabinet calcs. Sensitivity (95.7 vs 90.7 dB) affects SPL projections — use ts_params.json 95.7 dB. |

### Binding Decisions Summary (for downstream agents)

| Decision | Value | Status |
|----------|-------|--------|
| Screen aspect ratio | **16:9** | CLOSED |
| Screen bottom | **30"** (Y1=30) | CLOSED |
| Screen top | **113"** (Y2=113) | CLOSED — fits 10 ft ceiling |
| Sub footprint | **24"×24"** | CLOSED |
| Sub height | **72"** | CLOSED |
| Sub Qtc | **0.749** | CLOSED |
| Sub Fc | **31.1 Hz** | CLOSED |
| Sub F3 | **29.45 Hz** | CLOSED |
| T/S params | **Qts=0.53, Vas=8.77 ft³, Fs=22 Hz, sensitivity=95.7 dB** | CLOSED — use ts_params.json exclusively |
| DSP platform | **2× ADAU1701 (Wondom APM2)** | CLOSED |
| Sub amps | **5× ICEpower 1200AS2** | CLOSED |
| HVAC price | **~$2,550–2,650 total DIY** | CLOSED |
| Budget total (legacy) | **~$75K mid (Rev 7.0, stale)** | STALE — rebuild for Option D |
| Budget total (Option D) | **~$36,600 target** | Arithmetic not yet verified |
