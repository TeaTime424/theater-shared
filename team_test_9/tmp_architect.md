# Architect Audit — Option D Design Package
## Task #5 | 2026-03-20

---

## 1. DOCUMENT TREE REVIEW

Proposed 7-doc structure (00_index through 06_budget):

| Doc | Title | Scope Assessment |
|-----|-------|-----------------|
| 00_index | Master Index | OK — table of contents only, keep lean |
| 01_overview | Room + Layout + Screen | OK — room, seating geometry, screen, projector |
| 02_speakers | Speaker System | OK — LCR, surrounds, Atmos, amp chain |
| 03_subwoofers | Sub System | OK — drivers, cabinets, amps, DSP, tactile |
| 04_electronics | Processor + Control + Electrical | OK — AVR, Dirac, electrical circuits |
| 05_construction | Construction + HVAC + Acoustic Treatment | POTENTIAL OVERLAP — construction touches room (01) and mechanical; watch for bleed |
| 06_budget | Budget | OK — single budget doc |

**Senior check — scope right-sized?**

7 docs is acceptable if 05_construction is kept to build-sequence items only (framing, riser, stage, HVAC, treatment). Do not let it absorb room geometry (belongs in 01) or electrical (belongs in 04).

**Overlap / gap flags:**

| Issue | Action |
|-------|--------|
| Electrical circuits appear in both proposed 04_electronics and 05_construction | Pin all electrical to 04. Construction doc only references "see 04" for circuit specs. |
| Acoustic treatment: POR has no dedicated doc — currently split across 03 (sub placement), 04 (room), and 11_Budget | Fold treatment materials + budget into 05_construction. Confirmed gap in old POR. |
| No dedicated projector doc | Projector belongs in 01_overview (it's a room-level deliverable). Do not add an 8th doc. |
| Nearfield sub deferral note | Must appear in 03_subwoofers AND 06_budget — it affects both. Cross-reference, not duplication. |

**Verdict:** 7-doc structure is correct. No 8th doc warranted.

---

## 2. INCONSISTENCY FLAGS

### T/S Parameter Errors

| Doc / Source | Incorrect Value | Correct Value | Action |
|---|---|---|---|
| ts_params.json `_incorrect_values_in_por` note | Vas=15.5 cu ft, Qts=0.36 | Vas=8.77 cu ft, Qts=0.53 | Replace everywhere — DO NOT USE stale values |
| tmp_por_summary.md §5 "STALE FLAG" | Vas=15.5 L (different unit, different doc) | Vas=248.2 L = 8.77 cu ft | Same error, different unit expression |
| Note on unit mismatch | tmp_por_summary shows Vas=248.2 L (8.77 cu ft) for UMII18-22; ts_params.json shows 8.77 cu ft directly | These are consistent — both correct | No action needed |

Source for correct values: ts_params.json, `_source`: "Dayton Audio UMII18-22 datasheet, Parts Express SKU 295-487"

Additional T/S discrepancy between W0 sources:

| Parameter | tmp_por_summary value | ts_params.json value | Which is authoritative |
|---|---|---|---|
| Qes | 0.67 | 0.58 | ts_params.json (datasheet-sourced) |
| Qms | 2.53 | 6.22 | ts_params.json (datasheet-sourced) |
| Re | 4.2Ω (series coils) | 5.8Ω | Discrepancy — needs resolution |
| BL | 19.2 T·m | 21.5 T·m | Discrepancy — needs resolution |
| Sd | 1,184 cm² | 1,026 cm² | Discrepancy — needs resolution |
| Sensitivity | 90.7 dB @ 2.83V/1m | 95.7 dB @ 1W/1m | Different measurement basis — not contradictory |
| Power handling | 1,200W AES | 1,500W | Discrepancy |

**ACTION:** Re and Qes/Qms/BL/Sd discrepancies must be resolved from the actual datasheet before 03_subwoofers is finalized. ts_params.json claims datasheet sourcing — treat as authoritative pending verification.

---

### Sub Cabinet Dimension Ambiguity

| Source | Dimension |
|--------|-----------|
| CLAUDE.md | 24"×24"×72" |
| Garage_Conversion_Option1.md Option D section | ~20"W × 20"D × 72"H |
| coordinates.json `_footprint_resolved` | 24×24 inches — layout_config.json overrides specs.yaml 20×20 |
| tmp_investigation_notes.md layout config | Width: 24 inches, Depth: 24 inches |

**RESOLVED:** 24"×24" footprint. layout_config.json is authoritative. The 20"×20" figure in Garage_Conversion Option D section is stale/incorrect. All design package docs must use 24"×24".

The 20"×20" figure must not appear in any new doc without a strikethrough or explicit note that it was superseded.

---

### Cabinet Height — OPEN

| Height | Qtc | Fc (Hz) | F3 (Hz) | Status |
|--------|-----|---------|---------|--------|
| 72" | 0.749 | 31.1 | 29.5 | Team recommendation (ts_params.json) |
| 96" | 0.700 | 29.1 | 29.4 | Butterworth but taller |
| 120" | 0.669 | 27.8 | 29.4 | Near-floor-to-ceiling |

Team recommendation: 72" (fits 10' ceiling single-piece, Qtc within target, F3 nearly identical across all options due to room gain).

**Architect position:** Accept 72" as the working spec. F3 delta between 72" and 120" is <0.1 Hz — the room gain argument from ts_params.json is valid. This is not contested.

---

### Screen Bottom Height Error

| Doc/Source | Value | Correct Value |
|---|---|---|
| coordinates.json screen.Y1 | 30 | 30 (correct) |
| Any doc citing 51" screen bottom | 51" | **30"** |
| coordinates.json `_assertion` | "Bottom at Y=30 not 51" | Confirmed |

**ACTION:** Any doc referencing 51" screen bottom must be corrected to 30". Coordinates.json is authoritative.

---

### DSP Platform Flags

| Location | What It Says | Correct |
|---|---|---|
| Garage_Conversion_Option1.md equipment closet list | "ADAU1452" | WRONG — active platform is 2× ADAU1701 (APM2) |
| Investigation notes §1 verdict | References ADAU1452 as sub DSP | Stale — investigation was conducted for ADAU1452 but platform is now ADAU1701 |
| tmp_por_summary.md §7 | "STALE FLAG: Version 1.0 of 15_DSP specified a single ADAU1452" | Confirmed |
| 06_Electronics_and_Control.md | One signal flow reference to ADAU1452 | Must be corrected to ADAU1701 |

**All new docs:** Platform = 2× ADAU1701 (Wondom APM2). ADAU1452 must not appear.

Also note: investigation_notes.md DSP signal chain shows:
```
ADAU1701 → I2S → PCM5102 DAC → ICEpower 1200AS2
```
But tmp_por_summary §7 shows preferred option as Sonic Imagery 898B (unbalanced→balanced, not PCM5102). These are different options (A vs B). The design package must declare Option B (898B) as the spec and note Option A as fallback.

---

### HVAC Price Discrepancy

| Source | Figure | Notes |
|--------|--------|-------|
| All POR docs | ~$2,359 system + $200 hardware = $2,559 | Consistent across 16_HVAC + Garage_Conversion |
| Task specification mention | $1,359 | Does NOT appear in any POR doc |
| Investigation notes §3 "budget gap" | "Option D allocates $1,800 for HVAC; actual ~$2,550 — $750 gap" | $1,800 figure in an older Option D draft |

**Conclusion:** $1,359 is not a valid POR figure. Use $2,559 (system + hardware). The $750 budget gap (old $1,800 allocation vs $2,559 actual) must be noted in 06_budget.

---

### Electrical Feed Discrepancy

| Source | Claim |
|--------|-------|
| POR Rev 6.0 consolidated | "#3 Cu or #1 Al for 100A subpanel feeder" |
| Task specification | "#2 Al, 240V, 60A breaker at main panel" |
| Active Option D docs | No explicit main-panel-to-subpanel wire spec stated |

**Conclusion:** The "#3 Cu or #1 Al" vs "#2 Al at 60A" conflict is unresolved in active docs. These describe different things: the subpanel feeder rating (100A) vs the breaker at the main panel (60A is undersized for a 100A subpanel). This needs an electrical calculation or permit-based resolution. Flag for 04_electronics as [NEEDS RESOLUTION]. Do not publish either figure as settled.

---

### Other Contradictions: POR vs Option D

| Topic | Old POR | Option D | Action |
|-------|---------|---------|--------|
| Room size | 16'×26'×10' (4,160 cu ft) | 17'×23'×10' (3,910 cu ft) | Use Option D everywhere |
| Screen AR | 2.35:1 | 16:9 | Use Option D (16:9) |
| Screen cost | $3,000 | $1,000 | Use Option D |
| Projector | TBD $30,000 | JVC NZ500 $5,999 | Use Option D |
| Processor | AVR-A1H $6,500 | X6800H $3,700 | Use Option D |
| Channel config | 9.4.6 (15ch internal) | 9.4.4 (X6800H + ATI) | Use Option D |
| Sub count | 16 drivers | 8 corner (4 deferred) | Use Option D |
| Sub amp | 6× NX6000D | 5× ICEpower 1200AS2 | Use Option D |
| Sub columns | Triangular, floor-to-ceiling, 96" | Rectangular 24"×24"×72" | Use Option D |
| Bass shakers | 16× | 8× | Use Option D |
| Budget total | ~$72,000 | ~$36,600 out-of-pocket | Use Option D |
| Volt-10 sensitivity | 98 dB (old stale) | 95 dB (correct per DIYSG) | 95 dB everywhere |

---

## 3. SETTLED vs CONTESTED DECISIONS

### Settled (no deliberation needed)

| Decision | Source |
|----------|--------|
| Room: 17'×23'×10' N-S partition | CLAUDE.md, Garage_Conversion_Option1.md |
| Screen: 170" 16:9 AT | CLAUDE.md, coordinates.json |
| Screen bottom: Y=30" | coordinates.json |
| Sub footprint: 24"×24" | coordinates.json (overrides 20"×20") |
| Sub count: 8 corners, nearfield deferred | investigation_notes.md §2 |
| Sub amp: 5× ICEpower 1200AS2 | investigation_notes.md §1 |
| DSP platform: 2× ADAU1701 (APM2) | tmp_por_summary.md §7 |
| DSP output: Option B (898B) preferred | tmp_por_summary.md §7 |
| HVAC: MrCool DIY 5th Gen 12K, partition wall mount | investigation_notes.md §3 |
| HVAC cost: $2,559 | tmp_por_summary.md §9 |
| AVR: Denon X6800H + ATI AT525NC | CLAUDE.md, tmp_por_summary.md §4 |
| Budget out-of-pocket: ~$36,600 | CLAUDE.md, tmp_por_summary.md §11 |
| T/S correct values: Vas=8.77 cu ft, Qts=0.53 | ts_params.json |
| Cabinet height: 72" (working spec) | ts_params.json team_recommendation |
| Volt-10 sensitivity: 95 dB | CLAUDE.md |
| Nearfield subs: deferred, space reserved | investigation_notes.md §2 |

### Contested (needs explicit critical assessment before publishing)

| Decision | Issue | Owner |
|----------|-------|-------|
| T/S secondary params (Re, BL, Qes, Qms, Sd) | W0 sources disagree (por_summary vs ts_params) | Task #6 (Analyst) |
| HVAC $1,359 vs $2,359 | Mystery figure — not in POR | Dismiss $1,359; use $2,559 |
| Electrical feed spec ("#3 Cu/#1 Al" vs "#2 Al/60A") | Unresolved, no active doc settles it | Flag in 04_electronics [NEEDS RESOLUTION] |
| DSP Option B vs Option A | Option B preferred but Option A documented as fallback | Settle in 03_subwoofers: "Option B is POR; Option A is fallback" |
| Phase 2 budget: $25,565 vs $26,620 | $1,055 discrepancy in Garage_Conversion tables | Use $25,565 grand total; note line-item sum error in 06_budget |

### Open (requires calculation)

| Question | Status |
|----------|--------|
| Sub cabinet height: 72/96/120" | Resolved by ts_params.json — 72" recommended |
| Screen viewing angles | Already calculated: Row 1 = 61°, Row 2 = 45° (tmp_por_summary §1) |

---

## 4. INVESTIGATION TRIGGER CHECK

| Open Question | Research Needed? | Action |
|---|---|---|
| T/S secondary param discrepancy (Re, BL, Sd) | Verify vs Dayton datasheet | Create verify task — does NOT block Phase 4 overall |
| Electrical feed wire gauge / breaker size | Electrical code lookup OR defer to permit | Flag in doc as [NEEDS RESOLUTION]; do not block |
| JVC NZ500 throw distance for 17' room, 170" screen | Needs calculation vs throw ratio | Can be in 01_overview as an open note; non-blocking |

None of these block the design package. Write docs with [NEEDS RESOLUTION] markers where appropriate.

---

## 5. ADVISORY VOICE: SENIOR

**Is the scope right-sized for a 2027 build owner reading POR docs?**

- 7 docs at ~1,000–1,500 words each is the ceiling. This owner is technical but not an acoustics engineer. Each doc should answer: what is it, what does it cost, what do I buy.
- 03_subwoofers is at risk of over-engineering. The Qtc/Fc/F3 table belongs in a technical appendix or as a single-line callout, not a full section. The owner needs: "build 24"×24"×72" sealed, 2 drivers per cabinet."
- 06_budget must be a single clean table. No sub-tables within tables, no ($26,620 vs $25,565) confusion. Pick the number, note the discrepancy in one line, move on.
- Do not document the investigation process in the POR. Verdicts go in; deliberation stays in the investigation files.

**Scope creep risks:**

| Risk | Mitigation |
|------|-----------|
| 05_construction absorbing electrical details | Hard boundary: electrical specs live in 04 |
| 03_subwoofers absorbing DSP biquad math | DSP biquad tables are tools/dsp territory, not POR |
| 01_overview growing into a projector research doc | One paragraph on JVC NZ500 with cost; no specs deep-dive |

---

## 6. ADVISORY VOICE: ACTON

Every assertion in this audit cites a source. Confirm same standard applies to all design package docs.

**Unsourced claims that appeared in W0 data — flag for Phase 4 writers:**

| Claim | Where Found | Source Given? | Action |
|---|---|---|---|
| "113 dB at 20 Hz at MLP" for corner array | tmp_por_summary §5, investigation_notes §2 | Yes — investigation verdict | Cite investigation verdict in 03_subwoofers |
| "+11 dB corner gain + ~6 dB acoustic summing" | tmp_por_summary §5, CLAUDE.md | No primary source cited | Must cite Welti/Harman or equivalent when used in POR |
| "95 dB at MLP" as -10 dB reference level | CLAUDE.md, tmp_por_summary §12 | No derivation shown | Acceptable as design target, not a derived claim — cite as "design target" |
| Row 1 viewing angle 61° (IMAX-class) | tmp_por_summary §1 | Calculated from geometry | Include calculation basis or cite SMPTE/THX standard for comparison |
| Sub F3 of ~15 Hz | tmp_por_summary §5 | No calculation shown | ts_params.json shows F3 at box resonance = ~29 Hz; "15 Hz" must refer to room-gain-extended response — document this distinction clearly |

**Critical discrepancy on F3:** tmp_por_summary states bass extension "-3 dB at ~15 Hz" but ts_params.json calculated F3 is ~29.4–29.5 Hz (box only). The 15 Hz figure requires room gain — which is real and expected in a 3,910 cu ft sealed room, but must be labeled "with room gain" in the POR. Publishing 15 Hz as a bare spec without qualification is misleading.

---

## SUMMARY TABLE — PHASE 4 WRITER INPUTS

| Item | Status | Value to Use | Source |
|------|--------|-------------|--------|
| Room | Settled | 17'×23'×10' | CLAUDE.md |
| Sub footprint | Settled | 24"×24" | coordinates.json |
| Sub height | Settled (72") | 72" | ts_params.json |
| T/S Fs, Qts, Vas | Settled | Fs=22, Qts=0.53, Vas=8.77 cu ft | ts_params.json |
| T/S Re, BL, Qms | Contested | Verify vs datasheet | — |
| Screen bottom | Settled | Y=30" (not 51") | coordinates.json |
| DSP platform | Settled | ADAU1701 (APM2 ×2) | tmp_por_summary §7 |
| DSP output stage | Settled | Option B (898B) POR, Option A fallback | tmp_por_summary §7 |
| ADAU1452 references | Flag and remove | Replace with ADAU1701 | everywhere |
| HVAC cost | Settled | $2,559 total | tmp_por_summary §9 |
| $1,359 HVAC figure | Dismiss | Not a POR value | — |
| Electrical feed spec | Contested | [NEEDS RESOLUTION] | — |
| Budget out-of-pocket | Settled | $36,624 (~$36,600) | Garage_Conversion grand total |
| Phase 2 budget | Settled | $25,565 | grand total table |
| Vas=15.5 (any unit) | Eliminated | Never use | — |
| Volt-10 sensitivity | Settled | 95 dB | CLAUDE.md |
| F3 claim "~15 Hz" | Qualified | ~15 Hz with room gain; box F3 ~29 Hz | ts_params.json |
