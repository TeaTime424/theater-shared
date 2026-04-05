# Critic Review — Home Theater Design Package
_Task 7 output. Sources: tmp_architect.md, tmp_analyst.md, ts_params.json_

---

## 1. CONFLICT RESOLUTION

| # | Conflict | Architect Position | Analyst Position | Ruling | Source |
|---|----------|--------------------|------------------|--------|--------|
| 1 | Cabinet stacking geometry | "Stacked pair = 144\", 24\" clearance" — accepts stacking, deems ceiling OK. Also later says "72\" is the only viable height for stacked pairs." | FLAGS arithmetic error: 2×72" = 144" > 120" ceiling. States this is physically impossible. Offers resolution: single cabinet per corner, not vertically stacked. | **ANALYST IS CORRECT on the arithmetic; ARCHITECT'S FRAMING IS THE ERROR.** The design is 1 cabinet per corner (4 corners × 1 cabinet = 4 cabinets × 2 drivers = 8 drivers). "Stacked rectangular" is the cabinet form factor name (two drivers stacked vertically within one cabinet), NOT two cabinets stacked on each other. A single 72" cabinet per corner = 72" height, 48" clearance to 10' ceiling. No conflict with ceiling. | CLAUDE.md: "4 stacked rectangular cabinets (24\"×24\"×72\")"; task instructions explicit: "1 cabinet per corner = 4 cabinets × 2 drivers = 8 drivers — NOT stacked vertically." |
| 2 | Budget headline vs reconstructed sum | States "$36,600 is unverified — no Option D itemized BOM found" and flags Analyst must build total from scratch. | Reconstructs ~$47,321 vs $36,600 stated; identifies gap is projector-driven. Back-solves: projector must be ~$9K to make headline work. | **ANALYST IS CORRECT.** Gap is real. Projector placeholder of $20,000 is inconsistent with the $36,600 headline. Back-solve of ~$9,279 for projector is arithmetically sound. The headline is internally consistent ONLY if projector is ~$9K entry-level laser or deferred. | Analyst arithmetic: $47,321 − $20,000 projector + ~$9,279 = $36,600. |
| 3 | MrCool price | States $2,359 (complete system) from POR summary. Investigation notes show $2,550 actual / $1,800 allocated — suggests $2,400 split. | Uses $2,359 from POR summary. Confirms $1,359 does NOT appear in source docs. | **$2,359 is the correct figure for this design package.** It comes from the POR summary snapshot (stated value, confirmed). The $1,359 reference is almost certainly the indoor head unit only, or a stale/incorrect source. Budget doc must use $2,359 for MrCool. | tmp_por_summary.md HVAC table (stated ~$2,359); tmp_investigation_notes.md HVAC investigation. |
| 4 | T/S parameter conflicts — Qes, Re, sensitivity, power | Flags conflict between ts_params.json and tmp_por_summary.md: Qes=0.58 vs 0.67, Re=5.8Ω vs 4.2Ω, sensitivity=95.7 vs 90.7 dB, power=1500W vs 1200W. Does not resolve — defers to Analyst. | Does not address Qes/Re/power conflict directly. Uses ts_params.json for all sub calculations. Flags Qts=0.36 and Vas=15.5 as wrong values in POR docs. | **ts_params.json is authoritative.** The por_summary values (Qes=0.67, Re=4.2Ω, sensitivity=90.7 dB, power=1200W) are from older POR docs that predate the ts_params.json consolidation. The divergence on Re particularly (5.8Ω vs 4.2Ω) suggests the por_summary may have been mixing Dayton specs for a different driver revision or dual-VC wiring configuration. ts_params.json is the document purpose-built as the canonical parameter set for this design package. All calculations must use ts_params.json. The Qts=0.36/Vas=15.5 flagged by Analyst are confirmed fabrications — not in any source. | ts_params.json (Qts=0.53, Qes=0.58, Vas=8.77 cuft, Re=5.8Ω, sensitivity=95.7 dB, power=1500W); Analyst Section 3. |
| 5 | AVR model | AVR-X6800H + ATI AT525NC is settled per CLAUDE.md Option D. | AVR-X6800H + ATI AT525NC used throughout calculations. | **BOTH AGREE. AVR-X6800H + ATI AT525NC is the Option D spec.** Any POR doc still citing AVR-A1H is superseded. | CLAUDE.md, Option D section. |
| 6 | DSP platform | ADAU1452 = production; ADAU1701/APM2 = dev/bench only. | ADAU1452 for production (confirmed). APM2/ADAU1701 appears in gain-staging chain (signal path listed as "APM2 ADC → ADAU1701 → I2S → PCM5102"), which contradicts ADAU1452 production claim. | **Ruling: the production sub DSP is ADAU1452.** The APM2/ADAU1701 is a development platform. The signal chain diagram in tmp_investigation_notes.md that shows "X6800H → APM2 ADC → ADAU1701" is from the investigation/learning phase, not the Option D build spec. The 04_electronics doc must show X6800H → ADAU1452 → PCM5102 → 898B → ICEpower. The gain-staging calculations remain valid because the PCM5102 output voltage (2.0 Vrms) and 898B output (3.5 Vrms) are independent of which DSP feeds the I2S bus. | CLAUDE.md: "Sub DSP: ADAU1452 (8.24 fixed-point, full sub-20Hz capability)" |
| 7 | Sub cabinet footprint | 24"×24" settled from coordinates.json and CLAUDE.md. | 24"×24" used for all calculations. Flags 20"×20" in Garage_Conversion doc as stale. | **24"×24" is correct.** The 20"×20" in Garage_Conversion is an older doc superseded by Option D. All calculations in ts_params.json use 24"×24" footprint. | coordinates.json `_footprint_resolved`; ts_params.json `footprint_inches: "24x24"`. |
| 8 | Screen bottom height (Y1) | States Y1=30" from coordinates.json explicit assertion. | Analyst does not verify Y1 independently, notes it as an unresolved gap (Gap #9). | **Y1=30" is correct.** coordinates.json contains an explicit assertion "Bottom at Y=30 not 51". This settles the screen bottom height. Downstream docs must use 30". | coordinates.json screen.Y1=30 with assertion field. |
| 9 | ICEpower module count | 5 modules correct (4 active + 1 spare). One doc says 4 (framing issue). | Resolves as 5 = 4 active + 1 spare; flags as RESOLVED. | **5 modules. Settled.** | CLAUDE.md: "5× ICEpower 1200AS2". |
| 10 | Tactile shaker count | 8× Aura Pro (reduced from 16). | Not directly assessed. | **8× shakers per CLAUDE.md bass-plan-overkill investigation.** | CLAUDE.md + investigation notes. |

---

## 2. BUDGET ARITHMETIC VERDICT

**FAIL — BLOCKER**

| Item | Value |
|------|-------|
| Stated headline | ~$36,600 |
| Analyst reconstructed sum | ~$47,321 |
| Discrepancy | +$10,721 |
| Primary driver of gap | Projector line item ($20,000 estimate vs ~$9,279 implied) |

**Root cause:** The $36,600 headline is consistent only if the projector is budgeted at approximately $9,279 (entry-level laser, 2027 pricing) or is explicitly deferred out of scope. The Analyst's $20,000 projector placeholder (labeled "2027 flagship") is inconsistent with the headline.

**Back-solve confirmation:** $47,321 − $20,000 + $9,279 = $36,600. The headline is internally consistent at ~$9K projector.

**Binding resolution:** The budget document (06_budget) must either:
- (a) Set projector line item to ~$9,279 and explain it is an entry-level laser projection budget for 2027, OR
- (b) Explicitly mark projector as "Deferred — TBD 2027" and state the ex-projector total (~$27,321), noting the $36,600 headline assumes a ~$9K projector

The gap is **$10,721 — materially exceeds the $2K threshold — BLOCKER.** Phase 4 must not use either the $36,600 headline or the $47,321 sum without first resolving projector scope.

**Confirmed arithmetic (non-projector items):**

| Item | Stated | Computed | Match? |
|------|--------|----------|--------|
| ICEpower 5 × $373 | $1,865 | $1,865 | MATCH |
| ICEpower sub-total | $2,065 | $1,865 + $200 = $2,065 | MATCH |
| PCM5102A × 4 | ~$20 | 4 × $4.95 = $19.80 | MATCH |
| MrCool HVAC | ~$2,359 | stated | CONFIRMED |

Non-projector line items are arithmetically consistent. The discrepancy is isolated to the projector placeholder.

---

## 3. T/S PARAMETER VERIFICATION

**PASS — with one mandatory action**

All sub cabinet calculations in tmp_analyst.md Section 3 use ts_params.json values exclusively:
- Fs = 22.0 Hz (ts_params.json)
- Qts = 0.53 (ts_params.json)
- Vas = 8.77 cu ft (ts_params.json)
- Bracing displacement = 15% (ts_params.json)

The Analyst independently verified every calculation (alpha, Qtc, Fc, F3) for all three heights and they match ts_params.json to 4 significant figures. No fabricated values (Qts=0.36, Vas=15.5) appear in any calculation.

**BLOCKER condition if violated:** If any downstream doc (03_subwoofer) cites Vas=15.5 or Qts=0.36, that document must be rejected and rewritten. These are fabrications with no source.

**Advisory — por_summary parameter divergence:** The por_summary cites Qes=0.67, Re=4.2Ω, sensitivity=90.7 dB, power=1200W. These differ from ts_params.json values. The discrepancy is real but does not affect the sealed box calculations (which depend only on Fs, Qts, Vas). It does affect power handling and sensitivity claims in 03_subwoofer. Binding ruling: use ts_params.json values (Qes=0.58, Re=5.8Ω, sensitivity=95.7 dB, power=1500W) for all doc writing.

---

## 4. SUB CABINET HEIGHT DECISION

**BINDING DECISION: 72 INCHES**

| Height | Qtc | Fc (Hz) | F3 (Hz) | Single-cabinet ceiling fit (120") | Verdict |
|--------|-----|---------|---------|----------------------------------|---------|
| 72" | 0.723 | 30.0 | 29.4 | 72" < 120" — 48" clearance | SELECTED |
| 96" | 0.680 | 28.2 | 29.4 | 96" < 120" — 24" clearance | Rejected |
| 120" | 0.653 | 27.1 | 29.6 | 120" = ceiling — 0" clearance | Rejected |

**Rationale:**

1. **F3 is identical.** All three heights produce F3 of 29.4–29.6 Hz — a difference of 0.2 Hz. Larger cabinets yield zero meaningful LF extension. This eliminates acoustic performance as a reason to go larger.

2. **Qtc nearest Butterworth.** 72" gives Qtc=0.723, within 2% of the 0.707 maximally-flat alignment. The 96" (0.680) and 120" (0.653) options are progressively overdamped — flatter but with a slower initial rolloff that wastes excursion budget in the transition band.

3. **Ceiling clearance.** The "stacked rectangular" cabinets are a form factor: 2 drivers per cabinet in a single tall enclosure. The design calls for 1 cabinet per corner (4 corners × 1 cabinet = 4 cabinets × 2 drivers = 8 total drivers). A single 72" cabinet at each corner leaves 48" clearance under a 120" ceiling — ample. A single 120" cabinet provides 0" clearance — not buildable. A single 96" cabinet provides 24" clearance — feasible but wasteful with no acoustic benefit.

4. **Structural/cost.** 72" = 24" × 24" × 72" = 24.0 cu ft gross. Less lumber, lighter cabinet, easier to move into corners, lower cost than 96" or 120". The front pair doubling as screen wall supports is consistent with 72" height.

5. **Room gain.** The 3,910 cu ft room provides +3 to +6 dB boundary gain below ~28 Hz, compensating the sealed rolloff below Fc=30 Hz. There is no reason to chase Fc reduction by increasing cabinet volume when F3 doesn't change.

**Chosen height: 72". Qtc: 0.723. Fc: 30.0 Hz. F3: 29.4 Hz.**

This decision is settled. Downstream docs must not reopen it.

---

## 5. SCOPE CHECK

The 7-doc structure (00_index, 01_room, 02_speakers, 03_subwoofer, 04_electronics, 05_construction, 06_budget) is correctly sized for a single-owner 2027 build reference. Verdict: **right-sized with three constraints.**

| Doc | Risk | Binding constraint |
|-----|------|--------------------|
| 04_electronics | Overlap with 02/03 on signal chain | Signal chain written ONCE in 04_electronics. All other docs reference it; they do not reproduce it. |
| 05_construction | Bloat toward GC spec | Scope to: sub cabinet cut list (72" design), stage dimensions, riser spec only. No acoustic treatment schedules, no drywall specs, no conduit routing. |
| 06_budget | Parallel totals drift | 06_budget is the only arithmetic surface. Body docs that mention a price include a footnote "see 06_budget". No embedded running totals in 01–05. |

No additional documents are warranted. The doc count is appropriate.

---

## 6. VERDICT

**ADJUST — two issues must be resolved before Phase 4 may begin.**

### BLOCKERS (must resolve before Phase 4)

| # | Blocker | Required Action |
|---|---------|----------------|
| B1 | Budget discrepancy: $36,600 stated vs $47,321 computed, $10,721 gap | 06_budget must resolve projector scope: set to ~$9,279 (entry-level laser) OR explicitly defer projector with ex-projector total stated. Phase 4 must not write any doc citing $36,600 until 06_budget is reconciled. |
| B2 | T/S parameter set canonicity | 03_subwoofer must use ts_params.json values exclusively. If any draft cites Qts=0.36 or Vas=15.5, it is rejected. This is a write-time constraint, not a pre-Phase-4 action, but must be enforced on first draft review. |

### ADVISORIES (note for build docs, do not gate Phase 4)

| # | Advisory | Note for build docs |
|---|----------|---------------------|
| A1 | ATI AT525NC power at 6Ω not confirmed in source docs | Analyst used ~180W estimate. Even at 125W (8Ω spec applied to 6Ω), LCR achieves 104.4 dB — 9.4 dB above target. Not a feasibility risk. Verify actual 6Ω rating before finalizing 02_speakers. |
| A2 | DSP chip labeling in signal chain | Production signal chain must show ADAU1452, not ADAU1701/APM2. The gain-staging math is unaffected (PCM5102/898B voltages are DSP-independent). Fix the chain diagram in 04_electronics. |
| A3 | DRV134 vs THAT1646 final selection | Note both in 04_electronics as "TBD at build time." Either works; not a design constraint for the doc. |
| A4 | Surround back channels at 113.8 dB SPL | 18.8 dB above 95 dB target. AVR attenuation range is ±12 dB standard. Verify X6800H has adequate negative trim range before finalizing 02_speakers. Likely fine; call it out. |
| A5 | Sub wire gauge not in source docs | 06_electronics or 05_construction must specify wire gauge for 240V ICEpower sub feed per NEC. This is a code compliance note, not a design-blocking issue. |
| A6 | Projector model is a placeholder | "2027 flagship" is not a spec. 06_budget should label the projector line as "Projector — TBD (est. $9,279 for entry-level laser 2027)" to be honest about uncertainty. |
| A7 | Screen Y1=30" | Settled from coordinates.json. 01_room must use Y1=30" for screen bottom height — not 51". |
| A8 | MrCool $2,359 vs HVAC investigation $2,550 | Budget uses $2,359 (POR summary stated value). The $191 gap to investigation notes' $2,550 actual is not material. Flag in 06_budget as "±$200 depending on 2027 pricing." |

### Settled items downstream docs must accept as closed

- Cabinet height: **72"** (Qtc=0.723, Fc=30.0 Hz, F3=29.4 Hz)
- Cabinet count: **4 single cabinets, one per corner, NOT stacked pairs**
- Drivers per cabinet: **2 (stacked within the 72" enclosure)**
- Total corner sub drivers: **8**
- Cabinet footprint: **24"×24"**
- AVR: **Denon AVR-X6800H + ATI AT525NC**
- Sub DSP (production): **ADAU1452**
- Sub amps: **5× ICEpower 1200AS2, 240V**
- Shakers: **8× Aura Pro AST-2B-4**
- Nearfield subs: **Deferred**
- Screen: **170" 16:9, Y1=30"**
- T/S source: **ts_params.json exclusively**
- MrCool price: **$2,359**
