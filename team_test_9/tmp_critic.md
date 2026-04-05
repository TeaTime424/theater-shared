# Critic Report — Option D Design Package
**Task #7 | 2026-03-20**
**Inputs:** tmp_architect.md (W1-A), tmp_analyst.md (W1-B), ts_params.json

---

## 1. CONFLICT RESOLUTION

### 1A. Sub Footprint: 24"×24" vs 20"×20"

**Architect position:** 24"×24" is authoritative. coordinates.json `_footprint_resolved` note explicitly states layout_config.json overrides the 20"×20" figure in Garage_Conversion_Option1.md. Architect calls this settled.

**Analyst position:** Same — uses 24"×24" for all T/S calculations, then adds a quantified impact table showing what changes if 20"×20" is used (Qtc shifts from 0.749 to 0.875, Fc shifts to 37.7 Hz).

**Resolution: 24"×24" is correct.** Both agents agree. Source: coordinates.json / layout_config.json. The 20"×20" figure in Garage_Conversion_Option1.md is stale and must be corrected in Phase 4. Analyst's 20"×20" impact table is useful context but not a conflict — it quantifies the cost of the wrong dimension, not an alternate recommendation.

**Action for Phase 4:** Garage_Conversion_Option1.md must be updated to 24"×24" or struck with a correction note. Do not publish 20"×20" without explicit supersession markup.

---

### 1B. HVAC Price: $1,359 vs $2,359 vs $2,559

**Architect position:** $1,359 does not appear in any POR doc — dismiss it. POR docs consistently show $2,359 (system) + $200 (hardware) = $2,559. The investigation notes flag a $750 gap vs an older $1,800 allocation. Correct figure: $2,559.

**Analyst position:** Lists $2,359 in Phase 1 table (system cost only), $200 separately for hardware, so the implied total is $2,559. Does not address the $1,359 figure. Flags the price as advisory (verify current street price before build).

**Resolution: $2,559 is the correct all-in HVAC figure.** The $1,359 figure has no source in POR documentation and must not appear in Phase 4 docs. The $2,359 figure is the equipment cost alone (MrCool DIY 12K 5th Gen); the $200 hardware line is separate and must be kept. Total = $2,559.

The old $1,800 allocation in an earlier Option D draft created a $759 gap vs actual — this gap must be reflected in 06_budget.

---

### 1C. Budget Totals: Analyst Found ~$1,100 Gap

**Architect position:** Notes the $25,565 vs $26,620 inconsistency within the source doc, calls $25,565 authoritative (grand total table), acknowledges ~$1,055 discrepancy between tables.

**Analyst position:** Independently recomputed all line items. Found:
- Phase 1: stated $11,059, computed $11,259 — **+$200 error**
- Phase 2: stated $25,565 (grand total), computed $26,472 (using stated $799 Dirac) — **+$907 error**
- Grand total: stated $36,624, computed $37,731 — **+$1,107 error**
- With corrected Dirac pricing ($947 vs $799), shortfall grows to ~$1,255

**Resolution: Analyst arithmetic is correct. The stated $36,624 total is understated by approximately $1,100–$1,255.** The Architect noted the Phase 2 table inconsistency but did not recompute Phase 1 or the grand total — the Analyst's independent verification is more rigorous.

The $148 Dirac discrepancy ($799 stated vs $947 actual list prices) is real and documented. Whether a current bundle discount applies is unverified — treat $947 as the conservative number.

**Realistic budget: ~$37,700–$37,900.** See Section 2 for BLOCKER classification.

---

### 1D. Electrical Feed: "#3 Cu/#1 Al 100A" vs "#2 Al 60A"

**Architect position:** These describe different things — a 100A subpanel feeder vs a 60A main panel breaker. Flagged as unresolved and contradictory. Recommends [NEEDS RESOLUTION] marker in 04_electronics. Does not publish either figure.

**Analyst position:** Does not directly address this conflict in the budget or electrical section. The Phase 1 budget lists circuit costs but does not specify conductor gauge.

**Resolution: Architect is correct that these may not be contradictory on their face** — they could refer to different portions of the circuit. However, a 100A subpanel fed by a 60A breaker at the main panel is an undersize mismatch (NEC violation). These are genuinely unresolved and must not be published as settled specs.

**Action for Phase 4:** 04_electronics must carry [NEEDS RESOLUTION] on the electrical feed spec. State both figures found, state the contradiction, and flag for electrical permit/inspection resolution. Do not pick either figure without a code basis.

---

### 1E. Gain Staging: PCM5102 (190W) vs 898B Path — Design Baseline

**Architect position:** Option B (898B) is the POR baseline; Option A (PCM5102 path) is the fallback. Both reference investigation notes §1 and tmp_por_summary §7.

**Analyst position:** Computes both paths quantitatively. Option A (PCM5102) delivers 190W into ICEpower 1200AS2 — -5.0 dB below rated 600W. Option B (898B at +12 dB gain) delivers ~611W — essentially full rated power. Analyst also flags zero ADC headroom in Option A as a clipping risk (2.0V rms sub pre-out exactly meets APM2 ADC full-scale). Confirms Option B as preferred.

**Resolution: Both agents agree Option B (898B) is the design baseline.** The Analyst's quantitative analysis strengthens this — Option A's -5 dB power shortfall and zero ADC headroom margin are two independent reasons not to use it as the primary path. Option A can be documented as a fallback with explicit caveats.

**Critic adds:** The Analyst's 190W figure for Option A is correct from the arithmetic, but the more serious issue is the ADC headroom flag (G-4 in the Analyst gap list). If the APM2 ADC clips at 2.0V rms and the AVR sub pre-out runs at exactly 2.0V rms, there is a real clipping risk in Option A that makes it unsuitable even as a fallback without a pad. Phase 4 must document Option A as "fallback — requires input pad, verify APM2 ADC maximum."

---

## 2. BUDGET ARITHMETIC VERDICT

**Did Analyst's re-sum match stated totals? No.**

| Phase | Stated | Computed (Analyst) | Discrepancy |
|-------|--------|-------------------|------------|
| Phase 1 | $11,059 | $11,259 | **+$200** |
| Phase 2 | $25,565 | $26,472 | **+$907** |
| Grand Total | $36,624 | $37,731 | **+$1,107** |

With corrected Dirac pricing ($947 vs $799): grand total shortfall **~$1,255**.

**BLOCKER: The stated $36,624 budget is understated by $1,100–$1,255.** This exceeds the $500 threshold. Phase 4 must not publish the $36,624 figure. 06_budget must carry the recomputed total ($37,700–$37,900 range) with a note that the original figure was based on a line-item arithmetic error and a potentially stale Dirac bundle price.

ADVISORY — COST CUTTER:

- **Partition drywall $600**: Two-sided drywall on 23 ft × 10 ft wall = 460 sq ft. At $600 that is $1.30/sq ft material + labor. Labor alone is typically $1.50–$2.50/sq ft. This line is likely underestimated by $300–$600. Flag for recheck.
- **Permits $800**: No source, no quote. Sanford NC area building + electrical + HVAC permits could run $400–$1,500 depending on project valuation. Unsourced estimate.
- **Sub enclosures $1,400**: $350/cabinet DIY for 24"×24"×72" sealed MDF construction. Each cabinet needs ~4–5 sheets of 3/4" MDF ($45–$65/sheet = $180–$325 material alone). Bracing, screws, glue, damping material not costed. This line is tight — $500–$600/cabinet is more realistic.
- **JVC NZ500 $5,999 + screen $1,000**: No shipping lines in budget. Projector shipping from authorized dealer: typically $0–$200. AT screen shipping for 170" frame: can run $100–$300 for freight. Missing from Phase 2.
- **Seating $2,000**: Two recliner couches at $1,000 each, no sourcing. Theater-grade recliner couches often run $800–$2,500+ each. If owner upgrades, this line is vulnerable to 50–100% overrun.

ADVISORY — ACTON: Every total in 06_budget must come from summing line items — not from copying a stated figure from a prior doc that was never independently verified. The Analyst has now demonstrated that both prior doc totals were incorrect. Phase 4 budget writers must compute from the bottom up.

---

## 3. T/S PARAMETER VERIFICATION

**Are all sub calculations sourced from ts_params.json?**

Yes. The Analyst explicitly states: "All T/S values from ts_params.json (Dayton Audio UMII18-22, SKU 295-487). No values taken from POR docs." The verification arithmetic in Section 3 of the Analyst report uses Fs=22.0, Qts=0.53, Vas=8.77 cu ft — all matching ts_params.json exactly.

**Did any calculation cite Vas=15.5 or Qts=0.36?** No. Neither stale value appears in the Analyst report.

**ts_params.json verification (direct read):**

| Parameter | ts_params.json | Analyst Used | Match? |
|-----------|---------------|-------------|--------|
| Fs | 22.0 Hz | 22.0 Hz | Yes |
| Qts | 0.53 | 0.53 | Yes |
| Vas | 8.77 cu ft | 8.77 cu ft | Yes |
| Qes | 0.58 | Not used in box calcs | N/A |
| Re | 5.8Ω | Not used in box calcs | N/A |
| BL | 21.5 T·m | Not used in box calcs | N/A |

No BLOCKER. The Analyst correctly drew exclusively from ts_params.json for sealed box calculations. The Architect's flag on Re/Qes/BL/Sd discrepancies (por_summary vs ts_params.json) remains open as a secondary parameter gap — these do not affect the sealed box Qtc/Fc/F3 calculations but matter for sensitivity and power calculations. ts_params.json is authoritative per its `_source` field.

---

## 4. SUB CABINET HEIGHT DECISION

**Decision: 72 inches.**

| Height | Qtc | Fc (Hz) | F3 (Hz) |
|--------|-----|---------|---------|
| 72" | 0.749 | 31.11 | 29.45 |
| 96" | 0.700 | 29.06 | 29.35 |
| 120" | 0.669 | 27.78 | 29.44 |

Source: ts_params.json (confirmed by Analyst arithmetic to within floating-point rounding).

**Rationale:**

ADVISORY — BASS HEAD: The F3 difference across all three heights is 0.10 Hz (29.35–29.45 Hz) — acoustically inaudible. This convergence occurs because sealed box F3 is nearly independent of box volume beyond a certain point, especially when Qtc is in the 0.67–0.75 range. The real acoustic action is below F3 in the transition band, where room gain takes over.

In a 3,910 cu ft sealed room with 8 corner-loaded sealed subs, room gain below the room's pressure-rise frequency (approximately 20–25 Hz in a room this size) adds 6–12 dB of reinforcement. This room gain partially compensates the box rolloff below Fc, extending usable bass response well below the 29 Hz F3 figure. The Fc difference between 72" and 96" is 2.05 Hz — with DSP EQ applied (ADAU1701 shelf boost below Fc), this difference is entirely correctable and will not be audible in the final system.

The 72" cabinet fits within a 10' ceiling without ceiling penetration, as a single piece, with no angled top required. It serves a structural role as part of the screen wall at the front corners. It provides Qtc=0.749, which is acceptably close to the 0.707 Butterworth target and within the conventional 0.7–1.0 design range. The 96" option achieves textbook Butterworth but gains nothing acoustically that DSP cannot correct, while adding ceiling fit complexity. The 120" option is physically impossible in a 10' room without penetrating the ceiling and its Qtc=0.669 (below Butterworth) is arguably less desirable for a DSP-corrected system.

**Chosen: 72". Qtc=0.749. Fc=31.11 Hz. F3=29.45 Hz.**

This decision is made here and is not deferred to Phase 4. Phase 4 writers use 72" without reopening the question.

---

## 5. SCOPE CHECK

**Is the 7-doc structure right-sized?**

The structure is correct. No doc should be added or removed. However, three specific scope boundary violations are likely unless explicitly constrained.

| Doc | Risk | Constraint |
|-----|------|-----------|
| 03_subwoofers | At risk of absorbing full Qtc/Fc/F3 derivation, DSP biquad tables, and gain staging math. These belong in tools/dsp/ and investigation files, not POR. | POR gets: build spec (24"×24"×72", 2 drivers/cabinet, sealed, 8Ω series wiring). One-line callout of Qtc and F3. No derivation. |
| 04_electronics | At risk of absorbing construction electrical details (conduit, panel location). | All circuit specs in 04. Construction doc says "see 04_electronics for circuit specs." No duplication. |
| 05_construction | At risk of absorbing room geometry (belongs in 01) and HVAC tech specs (belongs in 04 or a callout). | Construction doc = build sequence: framing, riser, stage, HVAC installation, treatment materials. Not a design spec doc. |

ADVISORY — SENIOR: The owner is building this in 2027. The design package needs to answer three questions per doc: what is it, what does it cost, what do I buy or build. Investigation rationale, alternative analysis, and technical derivations that supported decisions do not belong in POR docs — they belong in the investigation and research files. Keep each doc to 1,000–1,500 words maximum. 03_subwoofers is the highest risk for scope creep because the sub system has the most technical depth.

The projector fits in 01_overview as a single paragraph (JVC NZ500, $5,999, ceiling mount, throw verified). No 8th doc warranted.

---

## 6. VERDICT

**ADJUST**

The design is sound. No fundamental architecture decisions need to be revisited. However, two items must be corrected before Phase 4 publishes anything to the owner.

### BLOCKER Items (must resolve before Phase 4)

| # | Blocker | Required Action |
|---|---------|----------------|
| B-1 | **Budget understatement: $1,107–$1,255** | 06_budget must be rebuilt from line-item sums. Published total must be ~$37,700–$37,900. Do not carry $36,624 forward. |
| B-2 | **Electrical feed spec unresolved** ("#3 Cu/#1 Al 100A" vs "#2 Al 60A") | 04_electronics must carry [NEEDS RESOLUTION]. Do not publish either wire gauge as settled. Flag for permit resolution. |

### ADVISORY Items (address but non-blocking)

| # | Advisory | Notes |
|---|---------|-------|
| A-1 | **Sub enclosure cost likely underestimated** ($350/cabinet vs ~$500–$600 realistic) | Recheck in 06_budget |
| A-2 | **Partition drywall $600 likely underestimated** for 460 sq ft two-sided | Recheck in 06_budget |
| A-3 | **Permits $800 unsourced** | Note as estimate; flag for quote |
| A-4 | **Dirac bundle pricing**: $799 stated vs $947 list — may reflect bundle discount | Verify current Dirac bundle price before publishing |
| A-5 | **Option A (PCM5102) ADC headroom = 0 dB** — document as "fallback requires input pad" | Note in 03_subwoofers or 04_electronics |
| A-6 | **F3 "~15 Hz" claim in POR docs** requires "with room gain" qualifier | Box F3 is ~29.4 Hz; 15 Hz is room-gain-extended response. Must be labeled clearly in 03_subwoofers |
| A-7 | **Titan-815LX 99 dB sensitivity** is from a single forum post, not a datasheet | Mark [UNVERIFIED] in 02_speakers or source independently |
| A-8 | **JVC NZ500 throw ratio** (1.4:1–2.8:1) not in any POR doc — came from task prompt | Verify against JVC product page before 01_overview is finalized |
| A-9 | **ICEpower 1200AS2 rated power at 8 ohm** — POR uses 620W, gain staging uses 600W | Reconcile from ICEpower datasheet |
| A-10 | **Scope discipline in 03_subwoofers** — keep Qtc/Fc/F3 as a one-line callout, not a derivation section | Phase 4 writer instruction |

### Items Settled — No Further Action

| Item | Value | Authority |
|------|-------|-----------|
| Sub footprint | 24"×24" | coordinates.json / layout_config.json |
| Sub height | 72" | ts_params.json (confirmed by Critic, Section 4) |
| T/S Fs, Qts, Vas | 22.0 Hz, 0.53, 8.77 cu ft | ts_params.json |
| DSP platform | 2× ADAU1701 (APM2) | tmp_por_summary §7 |
| DSP output baseline | Option B (898B) | tmp_por_summary §7 + Analyst gain staging |
| HVAC cost | $2,559 | tmp_por_summary §9 |
| $1,359 HVAC figure | Discard | Not in any POR doc |
| Screen bottom | Y=30" (not 51") | coordinates.json |
| Room dimensions | 17'×23'×10' | CLAUDE.md / Garage_Conversion |
| Volt-10 sensitivity | 95 dB | DIYSG official spec |
| 7-doc structure | Correct | This report |
| Cabinet height | 72" | This report (Section 4) |
