# Architect Report — Option D Design Package
**Task:** 14 | **Date:** 2026-03-21 | **Agent:** Architect

---

## 1. DOCUMENT TREE REVIEW

Proposed 7-doc structure for the Option D design package:

| # | Proposed Doc | Justified? | Primary Reader Use |
|---|-------------|------------|--------------------|
| 00_index.md | Master index + revision log | YES — navigation + DAG entry | Find any spec fast |
| 01_room_and_layout.md | Room dims, partition, stage, riser, coordinates | YES — load-bearing for contractors + builders | Buy lumber, plan electrical runs |
| 02_speakers.md | LCR/surround/Atmos models, sensitivity, impedance, placement | YES — drives amp selection + wire sizing | Order speakers, wire runs |
| 03_subwoofers.md | Drivers, cabinets, alignment, corner loading | YES — most complex subsystem | Build cabinets, order drivers |
| 04_amplification.md | Speaker amps + sub amps + signal chain | YES — covers ICEpower + ATI + X6800H | Buy amps, wire racks |
| 05_dsp_and_signal_chain.md | APM2/ADAU1701, 898B, PCM5102, biquad convention | YES — without this the DSP is unbuildable | Build DSP board, set gains |
| 06_budget.md | Option D BOM with line items | YES — owner needs this for 2027 spend plan | Know what to buy and when |

**Verdict:** 7 docs is correct. No scope creep found. All 7 earn their place.

**Docs to ELIMINATE from old POR (do not carry forward):**

| Old POR Doc | Status | Reason to Drop |
|-------------|--------|----------------|
| 01_Project_Overview_and_Room.md | STALE Rev 5.2 | 16'×26' room; $75-95K budget — wrong on both counts |
| 02_Front_Stage_System.md | STALE Rev 5.2 | Pre-Option D stage geometry; triangular corner subs |
| 03_Subwoofer_System.md | STALE Rev 5.9 | NX6000D amps; 16 shakers; nearfield not deferred |
| 11_Budget_Summary.md | STALE Rev 7.0 | DSP-408, NX6000D, 16 shakers, no HVAC — all wrong |
| 14_Quick_Reference.md | STALE Rev 7.0 | NX6000D + DSP-408 + miniDSP — superseded by Option D |

**Note:** 06_Electronics_and_Control.md (Rev 7.0 + Option D overlay) and 15_DSP_Subwoofer_Processing.md (v2.1) are the only POR docs current enough to be source material.

---

## 2. INCONSISTENCY FLAGS

### 2A. T/S Parameter Errors

| Parameter | Incorrect Value (flagged) | Correct Value | Source |
|-----------|--------------------------|---------------|--------|
| Vas | 15.5 (units unclear — cu ft would be wrong, L would be wrong) | 8.77 cu ft / 248.2 L | ts_params.json, tmp_por_core.md |
| Qts | 0.36 | 0.53 | ts_params.json |
| Qes | — | 0.58 | ts_params.json |
| Qms | — | 6.22 | ts_params.json |
| Re | — | 5.8Ω (not 4.2Ω per tmp_por_core.md) | ts_params.json |
| BL | — | 21.5 T·m (not 19.2 per tmp_por_core.md) | ts_params.json |
| Sd | — | 1,026 cm² (not 1,184 cm² per tmp_por_core.md) | ts_params.json |
| Sensitivity | — | 95.7 dB/1W/1m (not 90.7 per tmp_por_core.md) | ts_params.json |
| Power handling | — | 1,500W (not 1,200W AES per tmp_por_core.md) | ts_params.json |

**ACTION REQUIRED:** ts_params.json and tmp_por_core.md disagree on Re, BL, Sd, sensitivity, and power handling. These are the same driver (UMII18-22). The two sources cannot both be correct. This needs Analyst verification against the Parts Express datasheet before 03_subwoofers.md is written. The Vas=15.5 / Qts=0.36 incorrect values are confirmed NOT in POR source docs (tmp_por_core.md, line 80) but ARE flagged in ts_params.json header as values "DO NOT USE."

**ANALYST FLAG:** ts_params.json vs tmp_por_core.md — 5 parameters conflict. One source is stale or wrong. Do not use either without cross-referencing Parts Express SKU 295-487 datasheet.

### 2B. Sub Cabinet Dimensions

| Source | Cross-section | Height | Status |
|--------|--------------|--------|--------|
| CLAUDE.md (active) | 24" × 24" | 72" | Active config |
| Garage_Conversion_Option1.md Option D sub table | ~20" × 20" | 72" | Conflict |
| layout_config.json | 24" × 24" | — | Authoritative layout file |
| coordinates.json corner_subs | 24" × 24" | 72" | Confirms 24×24×72 |
| ts_params.json cabinet_geometry | 24" × 24" nominal | 72/96/120 open | Confirms 24×24 footprint |

**RESOLVED:** 24" × 24" footprint is correct. coordinates.json + layout_config.json are the authoritative sources. The "~20×20" in Garage_Conversion_Option1.md is an error in that doc.

**HEIGHT CONTESTED:** 72" per CLAUDE.md/coordinates.json; ts_params.json team recommendation is 96" (Qtc=0.700, maximally flat). This is the primary open design decision. See Section 3.

### 2C. Screen Bottom Height

| Source | Screen Bottom (Y) | Status |
|--------|-------------------|--------|
| 02_Front_Stage_System.md | ~51" from floor | WRONG — stale doc |
| coordinates.json screen.Y1 | **30"** | AUTHORITATIVE |

**RESOLVED:** 30" is correct. (coordinates.json, screen.Y1=30). The 51" figure is from the stale Rev 5.2 doc and must not carry forward.

### 2D. Screen Aspect Ratio

| Source | Aspect Ratio | Status |
|--------|-------------|--------|
| 02_Front_Stage_System.md | 2.35:1 | STALE — not Option D |
| 14_Quick_Reference.md | 2.35:1 | STALE Rev 7.0 |
| 11_Budget_Summary.md | 170" 2.35:1 | STALE |
| CLAUDE.md (Option D) | **16:9** | ACTIVE |
| layout_config.json | 170" 16:9 | CONFIRMS active |
| coordinates.json screen | X1=172, X2=320 = 148" wide | Consistent with 16:9 (148"W × 83"H ≈ 170" diagonal 16:9) |

**RESOLVED:** 16:9 is correct for Option D. All 2.35:1 references are from superseded configurations.

### 2E. HVAC Price Conflict

| Source | Price | What It Covers |
|--------|-------|----------------|
| 16_HVAC_Plan_Theater.md (v1.2, current) | ~$2,550–$2,650 | System package ~$2,359 + hardware $175–$280 |
| "Some references say $1,359" | $1,359 | Likely unit-only price without installation hardware or lineset |
| Investigation verdict (tmp_investigation_notes.md §1.3) | ~$2,550 | Confirms, flags $750 gap vs old $1,800 POR allocation |

**STATUS:** $2,550–$2,650 is the correct all-in DIY figure (tmp_por_budget.md, line 96; tmp_investigation_notes.md, line 59). The $1,359 figure is likely a historical unit-only price or a different model/config. HVAC doc (v1.2, Mar 13 2026) is the current source; use its figure.

### 2F. DSP Platform — Stale References

| Doc | States | Currency |
|-----|--------|----------|
| 14_Quick_Reference.md | DSP-408 + miniDSP 2×4 HD | STALE — Rev 7.0, Mar 10 |
| 11_Budget_Summary.md | Dayton DSP-408 $250 | STALE — Rev 7.0, Mar 10 |
| 00_Master_Index.md | DSP-408 + miniDSP (in Rev 7.0 entry) | STALE entry — not updated |
| 06_Electronics_and_Control.md | 2× ADAU1701 (APM2) | CURRENT — Mar 19 |
| 15_DSP_Subwoofer_Processing.md | 2× ADAU1701 (APM2) | CURRENT — Mar 19 |

**RESOLVED for new package:** DSP platform is APM2 (ADAU1701, 5.23 fixed-point). ADAU1452 references (from the NX6000D investigation verdict, §1.1) are superseded — the final choice landed on ADAU1701 via APM2, not ADAU1452. The new 05_dsp_and_signal_chain.md must use ADAU1701 throughout.

**Note on ADAU1452:** tmp_investigation_notes.md §1.1 shows the NX6000D investigation adopted ADAU1452. tmp_investigation_notes.md §2 explicitly overrides this: "DSP Platform: Wondom APM2 (ADAU1701) — NOT ADAU1452 for sub chain." ADAU1452 is dead. Do not cite it in the new package.

### 2G. Electrical Feed Wire / Breaker

| Parameter | Value in Source Docs | Source |
|-----------|---------------------|--------|
| Sub amp breaker | 20A double-pole / 240V | tmp_por_budget.md, 06_Electronics_and_Control.md |
| A/V circuit breaker | 20A / 120V | tmp_por_budget.md |
| Subpanel rating | 100A dedicated | tmp_por_budget.md |
| Feed wire gauge | **NOT STATED** in any source doc | — |

**FLAG:** The task description mentions "#2 Al / 60A" as a feed wire spec. This value does NOT appear in any W0 source doc (tmp_por_budget.md, tmp_por_core.md, tmp_investigation_notes.md, coordinates.json, ts_params.json). The source docs specify a 100A subpanel and 20A circuits, but feed wire gauge and main breaker ampacity for the subpanel feed are not documented. **Do not include #2 Al / 60A in the package without a source.** Flag for owner to specify or Analyst to verify.

### 2H. Signal Chain — 898B Committed

**Status: PURCHASED — committed component** (tmp_investigation_notes.md §3, line 125)

Correct signal chain for new docs:

```
X6800H pre-out (0.9 Vrms, RCA unbalanced)
  → APM2 ADC → ADAU1701 → I2S → PCM5102 DAC
  → 898B unbal-to-bal (+11.79 dB)
  → 3.5 Vrms XLR balanced
  → ICEpower 1200AS2 balanced input
  → 620W/ch @ 8Ω
```

898B gain: 11.79 dB (confirmed by creator, tmp_investigation_notes.md §3 line 139). Manufacturer "~14 dB" claim is imprecise; use 11.79 dB.

---

## 3. SETTLED vs CONTESTED

### Settled

| Decision | Value | Source |
|----------|-------|--------|
| Room dimensions | 17' × 23' × 10', N-S partition | coordinates.json, CLAUDE.md |
| Screen | 170" 16:9 AT | layout_config.json, coordinates.json |
| Screen bottom height | 30" AFF | coordinates.json screen.Y1=30 |
| Sub footprint | 24" × 24" | coordinates.json, layout_config.json |
| Sub driver | 8× Dayton UMII18-22 / 4 corners | CLAUDE.md, tmp_por_core.md |
| Sub wiring | 8Ω series per cabinet (dual 2Ω VCs) | tmp_por_core.md |
| Sub amps | 5× ICEpower 1200AS2, 240V | tmp_investigation_notes.md §1.1, 06_Electronics_and_Control.md |
| Sub DSP | APM2 (ADAU1701) — NOT ADAU1452 | tmp_investigation_notes.md §2 |
| Balanced output | Sonic Imagery 898B — PURCHASED | tmp_investigation_notes.md §3 |
| 898B gain | +11.79 dB, 0.9 Vrms → 3.5 Vrms | tmp_investigation_notes.md §3 line 139 |
| Speaker amps | ATI AT525NC (owned) + X6800H internal | tmp_por_core.md §5 |
| SPL target | -10 dB Reference = 95 dB MLP all ch | CLAUDE.md, tmp_por_core.md |
| Nearfield subs | Deferred — space reserved behind Row 1 | tmp_investigation_notes.md §1.2 |
| Bass shakers | 8× Aura Pro AST-2B-4 (reduced from 16) | tmp_investigation_notes.md §1.2, CLAUDE.md |
| HVAC | MrCool DIY 12K, partition wall, ~$2,550 | tmp_investigation_notes.md §1.3, tmp_por_budget.md |
| Aspect ratio | 16:9 | CLAUDE.md, layout_config.json |
| Volt-10 sensitivity | 95 dB (not 98 dB) | tmp_por_core.md line 54 |
| Titan-815LX impedance | 6Ω nominal / 4.2Ω min | tmp_por_core.md |
| Biquad convention | [b0, b1, b2, -a1, -a2] | CLAUDE.md |

### Contested / Open

| Issue | Options | Blocker? |
|-------|---------|---------|
| **Sub cabinet height** | 72" (CLAUDE.md/coordinates.json) vs 96" (ts_params.json team recommendation, Qtc=0.700) vs 120" | YES — affects 03_subwoofers.md, OBJ model, coordinates.json |
| **UMII18-22 T/S params** | ts_params.json vs tmp_por_core.md disagree on Re, BL, Sd, sensitivity, power | YES — affects cabinet calculations |
| **Subpanel feed wire** | #2 Al / 60A mentioned in task but not in any source doc | Moderate — affects 01_room_and_layout.md electrical section |
| **Projector model** | TBD, budget $30K, deferred to 2027 | Low — placeholder OK in budget doc |
| **DSP chain topology** | PCM5102 role: does it stay in chain or is 898B direct from X6800H pre-out? | Moderate — tmp_investigation_notes.md §2 is ambiguous on final topology |

---

## 4. ADVISORY VOICE: SENIOR

**Is the scope right-sized?**

Yes, with one caution. The 7-doc structure is lean and justified. Every doc has a build-time consumer.

The one risk is that 05_dsp_and_signal_chain.md will balloon. The DSP work (APM2, ADAU1701, PCM5102, 898B, biquad coefficient table, gain staging math) is genuinely complex and the temptation will be to dump everything in. Hold the line: that doc must be a build reference, not a tutorial. Biquad math goes in a table, not in paragraphs.

Drop 11_Budget_Summary.md and 14_Quick_Reference.md entirely. They're wrong on every Option D line item and will confuse anyone who reads both old and new docs. The new 06_budget.md replaces both.

**The contested sub height decision is the only thing that can block the build package.** Everything else is either resolved or a known-placeholder (projector). Get that decision made before dispatching the sub cabinet doc writer.

---

## 5. ADVISORY VOICE: ACTON

**Every assertion above has a citation. Uncited assertions below:**

The task description states "#2 Al / 60A" for the subpanel feed wire. This reviewer searched all five W0 source files and found no mention of that spec. It is either:
- An assumption from the 100A subpanel rating (100A panel + 20A sub circuit ≠ 60A feed), or
- A spec from a POR doc not included in W0 (06_Electronics_and_Control.md was not fully ingested)

**Do not write "#2 Al / 60A" into 01_room_and_layout.md without a source.** Mark it [UNVERIFIED] or pull the full electrical section from 06_Electronics_and_Control.md before the room doc is written.

The budget total "$36,624 total" stated in CLAUDE.md is a claimed figure. tmp_por_budget.md shows the Option D electronics subtotal is $6,779 and the HVAC is ~$2,550-2,650. Full budget arithmetic has not been verified in W0 outputs — no single source shows a roll-up to $36,624 with itemized verification. **Flag for Analyst to verify.**

The 898B "~14 dB" manufacturer claim vs confirmed 11.79 dB: the 2.21 dB discrepancy is resolved by the creator communication cited in tmp_investigation_notes.md line 143. No action needed, but the new docs must use 11.79 dB, not 14 dB.

---

## 6. IMMEDIATE BLOCKERS BEFORE WRITING

| Blocker | Who Resolves | Impact |
|---------|-------------|--------|
| Sub cabinet height: 72" vs 96" | Owner decision | 03_subwoofers.md, coordinates.json, OBJ models |
| UMII18-22 T/S param conflict (Re, BL, Sd, sensitivity) | Analyst — verify vs Parts Express datasheet | 03_subwoofers.md cabinet calcs |
| Subpanel feed wire spec (#2 Al / 60A sourcing) | Analyst or owner | 01_room_and_layout.md electrical |
| $36,624 total budget verification | Analyst arithmetic | 06_budget.md |
| DSP chain final topology (PCM5102 in or out of sub chain) | Clarify from 898B signal chain notes | 05_dsp_and_signal_chain.md |
