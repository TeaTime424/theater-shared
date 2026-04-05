# Phase 2: Critic Review — Option D Design Package

**Date:** 2026-03-15
**Reviewer:** Critic Agent (with New Grad and Senior advisory voices)
**Scope:** Critical review of Phase 1 Architect plan and Analyst baseline for team_test_5

---

## 1. Issue Table

| # | Severity | Location | Issue | Recommendation |
|---|----------|----------|-------|----------------|
| 1 | **BLOCKER** | Analyst E, lines 370-441 | **ADC clipping claim is WRONG.** Analyst states ADAU1701 ADC clips at "~0.9-1.0 Vrms." The ADAU1701 datasheet specifies ADC full-scale = **2.0 Vrms** (with 18k external series resistor, which the Wondom APM2 uses). The X6800H's 2V nominal pre-out sits right at ADC full-scale — no clipping under normal use. The 0.9V figure is the **DAC output**, not the ADC input. The Analyst conflated input and output specs. | Correct the ADC full-scale to 2.0 Vrms. Remove the "POTENTIAL CLIPPING" flag. The input side is fine. The voltage divider / attenuator recommendations are unnecessary. |
| 2 | **BLOCKER** | Analyst E, lines 399-441 | **DAC output voltage mismatch is REAL but severity is overstated.** ADAU1701 DAC outputs 0.9 Vrms. ICEpower 1200AS2 needs 3.61 Vrms for full power at 8 ohm (confirmed: input sensitivity = 5.0 Vp = 3.54 Vrms for 1200W@4ohm; 25.8 dB voltage gain). This limits amplifier output to 38.5W/ch into 8 ohm — **confirmed correct**. However, the Analyst's own SPL calculation shows this still delivers 120.5 dB passband (4-corner sum with boundary loading), which is +15.5 dB above the 105 dB THX LFE target. The system works. The "SHOW-STOPPING" label is wrong — it's a headroom reduction, not a failure. | Reclassify from SHOW-STOPPER to WARNING. Document the 12 dB headroom loss. Add DRV134 balanced line drivers to the design as an upgrade path (not a blocker). The 38.5W/ch system still exceeds the -10 dB reference target by a wide margin. |
| 3 | **WARNING** | Analyst A, lines 37-77 | **Budget arithmetic: THREE errors, not one.** (a) Phase 1 line items sum to **$11,259**, not $11,059 — a $200 error in the source document that the Analyst missed and incorrectly certified as "CORRECT." (b) The Option D grand total table lists Phase 2 = $25,565, but the Phase 2 line items (shared with main budget) sum to $26,155 — a $590 discrepancy the Analyst correctly caught. (c) Grand total should be $11,259 + $26,155 = **$37,414**, not $36,624 ($790 discrepancy). | Fix all three in the design package. Recommend a spreadsheet-based budget with formulaic totals, not hand-summed markdown tables. |
| 4 | **WARNING** | Architect #2, Analyst C | **T/S parameters: POR doc values ARE correct.** Web search confirms UMII18-22 spec sheet (Dayton 295-718): Vas = 248.2L (8.77 cu ft), Qts = 0.53, Qes = 0.67, Fs = 22 Hz. The "corrected" values (Vas=15.5 cu ft, Qts=0.36) are wrong — Qts=0.36 is not even Qes (which is 0.67). Origin unknown; possibly a transcription error from a different driver or measurement condition. The Analyst correctly identified this and used the spec sheet values for calculations. | Use spec sheet values exclusively: Vas=8.77 cu ft, Qts=0.53, Fs=22 Hz. Purge the incorrect values (Vas=15.5, Qts=0.36) from CLAUDE.md and all design docs. |
| 5 | **WARNING** | Architect #3, Analyst G.3 | **DSP architecture: APM2 vs ADAU1452 remains unresolved.** The Architect flags this as blocking. The Analyst demonstrates why APM2 is suboptimal (DAC voltage limitation). Both are correct that this must be decided before writing doc 04. The "known correction" to APM2 appears to reflect what's currently on the bench, not the production architecture. | Present both options in the design package: (a) APM2 as-is with 38.5W/ch (works but reduced headroom), (b) APM2 + DRV134 line drivers for full power, (c) ADAU1452 + CS42448 as original POR. Let the user decide based on cost/complexity tradeoff. |
| 6 | **WARNING** | Analyst D, lines 296-350 | **60A vs 100A feed: unverified critical assumption.** The Analyst correctly flags this but doesn't resolve it. If 100A, all margin calculations are trivially satisfied. If 60A, the pool pump + HVAC startup overlap is tight (43.3A peak vs 60A limit). This must be physically verified at the panel before the electrical plan is finalized. | Add "VERIFY FEEDER BREAKER AT PANEL" as a pre-construction checklist item. Do not design around 60A without confirmation. |
| 7 | **MINOR** | Analyst B, lines 101-115 | **LCR SPL calculation uses optimistic room gain.** Analyst applies +3 dB room gain at Row 1 (10.5 ft). At 10.5 ft from the source in a 17x23x10 room, the listener is not yet in the diffuse field for most of the audible band. The +3 dB figure is reasonable for mid-band but overstated for HF. Doesn't change the conclusion (headroom is massive either way). | Note that +3 dB room gain is a mid-band estimate. The 21.7 dB headroom claim is directionally correct regardless. |
| 8 | **MINOR** | Architect, Diagram #5 | **Senior's suggestion for a 5th diagram (speaker polar view) is valid.** A top-down polar plot showing all 13 channel angles from MLP vs Dolby placement guidelines would be the single most useful validation diagram. Low effort, high value. | Add ff_05_speaker_angles.py to diagram list. |
| 9 | **MINOR** | Analyst C, lines 254-262 | **Sub enclosure Fc/Qtc/F3 calculations are correct.** Independently verified: 72" gives Fc=30.5, Qtc=0.735, F3=29.4 Hz. 96" gives Fc=28.6, Qtc=0.689, F3=29.4 Hz. 120" gives Fc=27.4, Qtc=0.659, F3=29.5 Hz. The observation that F3 is nearly identical across all heights is correct and well-explained. The 72" recommendation is sound — closest to Butterworth (0.707), manageable size, essentially identical F3. | Adopt 72" as the recommended height. |
| 10 | **MINOR** | layout_config.json | **Nearfield subs enabled in layout_config but deferred in design.** The layout_config.json has `nearfield_subs.enabled: true` with 4 drivers in riser face. The design defers nearfield subs. The config should match the design intent. | Set `nearfield_subs.enabled: false` in layout_config.json (or add a `deferred: true` flag). |

---

## 2. Assumptions Tested

| # | Assumption | Source | Verified? | Finding |
|---|-----------|--------|-----------|---------|
| 1 | ADAU1701 ADC clips at 0.9-1.0V | Analyst | **WRONG** | ADC full-scale = 2.0 Vrms with 18k series resistor (per ADAU1701 datasheet, confirmed by Analog Devices EngineerZone). APM2 uses 18k resistors. |
| 2 | ADAU1701 DAC outputs 0.9 Vrms | Analyst | **CORRECT** | Confirmed: DAC full-scale output = 0.9 Vrms (2.5 Vpp). |
| 3 | ICEpower 1200AS2 needs 3.54 Vrms for full power | Analyst | **CORRECT** | Input sensitivity = 5.0 Vp (3.54 Vrms) for 1200W@4ohm. Voltage gain = 25.8 dB (19.5x). For 620W@8ohm, need 3.61 Vrms input. |
| 4 | X6800H sub pre-out = 2V RMS | Analyst | **PLAUSIBLE** | Standard for Denon AVRs. Exact spec not found in X6800H data sheet snippets, but 2V RMS is industry standard for pre-outs. |
| 5 | UMII18-22 Vas = 8.77 cu ft, Qts = 0.53 | POR doc 03 | **CORRECT** | Confirmed from Dayton spec sheet 295-718: Vas = 248.2L = 8.77 cu ft, Qts = 0.53, Fs = 22 Hz (VCs in series). |
| 6 | UMII18-22 Vas = 15.5 cu ft, Qts = 0.36 | CLAUDE.md / task | **WRONG** | No basis found. Qts=0.36 does not match any published parameter. Vas=15.5 cu ft (439L) is nearly double the spec. |
| 7 | Phase 1 budget = $11,059 | Source doc | **WRONG** | Line items sum to $11,259. Source doc has $200 arithmetic error. |
| 8 | Phase 2 budget = $26,155 | Analyst | **CORRECT** | Line items sum to $26,155. Source doc Option D table incorrectly states $25,565 (stale from earlier draft). |
| 9 | Corner loading = +11 dB | Multiple docs | **PLAUSIBLE** | Three-boundary loading theoretically yields +9 dB (3 dB per boundary). +11 dB includes partial room pressurization. Reasonable estimate, measurement-dependent. |
| 10 | 4-corner summing = +6 dB | CLAUDE.md | **CONSERVATIVE** | Below ~25 Hz (wavelength > room dimensions), pressure-zone summation of 4 sources yields +12 dB. Above ~50 Hz, drops toward +6 dB. The +6 dB figure is conservative for the sub band. |
| 11 | Sealed sub Fc/Qtc formulas | Analyst | **CORRECT** | Fc = Fs * sqrt(1 + Vas/Vb), Qtc = Qts * sqrt(1 + Vas/Vb). Standard sealed box formulas. Results independently verified to match. |
| 12 | APM2 powered from ICEpower 5V rail | Task correction | **PLAUSIBLE** | ADAU1701 draws ~100-150 mA @ 3.3V (internal LDO). Board total ~300 mA @ 5V. ICEpower DVDD 5V @ 1A has sufficient margin. Not tested but within spec. |

---

## 3. Architect vs Analyst Conflict Resolution

| # | Topic | Architect Says | Analyst Says | Resolution |
|---|-------|---------------|-------------|------------|
| 1 | **T/S parameters** | Flags as blocking, asks user which is correct | Uses spec sheet values (Vas=8.77, Qts=0.53), calculates with both | **Analyst is correct.** Spec sheet values confirmed via web search. The CLAUDE.md values are wrong. Resolve by purging incorrect values. No user input needed. |
| 2 | **Sub cabinet height** | Lists as blocking, asks user preference | Calculates all three, recommends 72" with quantitative justification | **Analyst is correct.** 72" gives near-optimal Butterworth alignment (Qtc=0.735), identical F3 to taller options, and is manageable to build/transport. Recommend 72" as default, document alternatives. |
| 3 | **DSP board** | Flags as blocking, asks user to confirm APM2 vs ADAU1452 | Calculates gain staging impact, concludes APM2 is "workable but suboptimal" | **Both are correct but incomplete.** The Analyst's ADC clipping claim is wrong (ADC handles 2V fine). The DAC output limitation is real but not show-stopping. Present both architectures with tradeoffs; let user decide. This IS still blocking for doc 04. |
| 4 | **Equipment closet location** | Asks if "NE of gym" = "NW of building" | Does not address | **Architect is correct that these are the same location.** layout_config.json confirms: `position: "west_outside_NW"` with label "gym side." NE corner of gym = NW corner of building. Non-issue. |
| 5 | **Screen bottom height** | Lists as moderate blocker | Does not calculate | **Neither addresses it.** JVC NZ500 throw ratio 1.4:1-2.8:1 for 148" screen width = 17.2-34.4 ft throw. At 23' room depth, projector at rear wall = ~21 ft from screen (accounting for stage depth). This is within range. Screen bottom at 30" AFF is fine. Non-blocking. |
| 6 | **Budget discrepancy** | Does not address | Finds $590 gap (Phase 2: $26,155 vs $25,565) | **Analyst is partially correct but missed the Phase 1 error.** Phase 1 items sum to $11,259, not $11,059 ($200 error). Combined: the true OOP grand total is $37,414, which is $790 more than stated $36,624. |
| 7 | **Rear clearance** | Lists as moderate, suggests three options | Does not address | **Non-blocking.** Accept 1' rear clearance and note as trade-off. The room is 23' deep; the tight rear is inherent to the N-S partition choice. |

---

## 4. Scope Check

### Is the Architect's Document Tree Complete?

| Required Coverage | Addressed? | Notes |
|------------------|------------|-------|
| Room geometry and construction | Yes | Doc 01 |
| Speaker system (all 13 channels) | Yes | Doc 02 |
| Subwoofer system (drivers, cabinets, amps, DSP) | Yes | Doc 03 |
| Signal flow and electronics | Yes | Doc 04 |
| Electrical and HVAC | Yes | Doc 05 |
| Budget and construction sequence | Yes | Doc 06 |
| Performance targets | Yes | Doc 07 |
| Machine-readable specs | Yes | specs.yaml |
| Gain staging analysis | **NO** | Critical gap. Not in any document scope. Should be a section in doc 04 or a standalone appendix. |
| Construction sequencing (heavy items first) | **Partial** | Doc 06 covers sequence but Senior correctly notes sub cabinets must go in before riser/carpet. |
| Cable schedule | **NO** | Analyst flags this. Should be in doc 04 or doc 05. |
| Projector throw verification | **NO** | Quick calculation confirms it works (21 ft throw, NZ500 range 17.2-34.4 ft). Should be documented in doc 02 or doc 07. |

### Is the Architect's Diagram List Complete?

| Diagram | Included? | Notes |
|---------|-----------|-------|
| Floor plan | Yes | ff_01 |
| Signal flow | Yes | ff_02 |
| Sub cabinet cross-section | Yes | ff_03 |
| Electrical one-line | Yes | ff_04 |
| Speaker angle polar view | **NO** | Senior's suggestion. High value, low effort. Add as ff_05. |

### Is the Analyst's Baseline Complete?

| Section | Included? | Quality |
|---------|-----------|---------|
| Budget verification | Yes | Good but missed Phase 1 $200 error |
| SPL calculations | Yes | Good, conservative |
| Sub enclosure analysis | Yes | Excellent — calculated all heights, compared T/S sources |
| Electrical load analysis | Yes | Thorough, correctly flags 60A vs 100A uncertainty |
| Gain staging | Yes | **Contains a significant error** (ADC full-scale wrong) but DAC/amp mismatch analysis is correct |
| Specification gaps | Yes | Comprehensive |
| Tradeoff analysis | Yes | Well-structured, all major decisions covered |

---

## 5. Verdict: PROCEED WITH CHANGES

The Architect's plan is well-structured and the Analyst's baseline is thorough, but two corrections are required before Phase 2 writing begins:

### Must Fix (Before Proceeding)

1. **Correct the ADAU1701 ADC full-scale specification.** It is 2.0 Vrms, not 0.9-1.0 Vrms. The input-side clipping concern is unfounded. Remove all recommendations for input attenuation/voltage dividers.

2. **Reclassify the DAC output mismatch.** The 0.9 Vrms DAC → 3.61 Vrms needed gap is real but not a show-stopper. The system delivers 120.5 dB passband even at 38.5W/ch — well above the 105 dB target. Document it as a headroom trade-off, not a failure. Present DRV134 line drivers as an upgrade path.

3. **Fix all three budget arithmetic errors.** Phase 1 = $11,259 (not $11,059). Phase 2 = $26,155 (not $25,565). Grand total OOP = $37,414 (not $36,624).

4. **Purge incorrect T/S parameters.** Use Vas=8.77 cu ft, Qts=0.53, Fs=22 Hz from the Dayton spec sheet. Remove Vas=15.5, Qts=0.36 from CLAUDE.md.

### Should Fix (During Phase 2)

5. **Add gain staging section** to doc 04 (or as appendix) tracing voltage at every node in the signal chain.

6. **Add speaker angle polar diagram** (ff_05) per Senior's recommendation.

7. **Add cable schedule** to doc 04 or doc 05.

8. **Add construction sequencing note** that sub cabinets must be placed before riser platform and carpet.

9. **Present DSP architecture as a decision matrix** (APM2 as-is / APM2 + DRV134 / ADAU1452 + CS42448) rather than forcing a choice now.

### Confirmed Correct / No Changes Needed

- Sub enclosure analysis: 72" height recommendation is well-supported (Qtc=0.735, F3=29.4 Hz)
- Room mode analysis and Schroeder frequency calculation
- Electrical load analysis (pending feeder verification)
- All seven tradeoff assessments (processor, amps, DSP, layout, bass plan, HVAC, screen, projector)
- Document tree structure and dependency ordering
- 3D model scope and approach

---

## New Grad's Take

The biggest takeaway for me is how easy it is to get datasheet specs wrong. The Analyst is clearly competent — the sub enclosure math is textbook-perfect, the tradeoff analysis is thorough — but conflating the ADC input spec (2V) with the DAC output spec (0.9V) cascaded into a "SHOW-STOPPING" flag that could have derailed the entire APM2 recommendation. That's a 2x error on the most critical number in the gain staging chain.

What scares me is that this error was presented with confidence. "FLAG: POTENTIAL CLIPPING" with detailed mitigation options, when the actual ADC handles the input voltage just fine. If I were reviewing this without doing my own datasheet lookup, I might have believed it. Lesson: always verify the actual datasheet, not a summary of it.

The budget errors are also instructive. The Analyst certified Phase 1 as "CORRECT" when it's $200 off. That's a small amount, but the pattern matters — if we can't trust the addition, we can't trust the reconciliation.

On the positive side: the sub enclosure analysis is genuinely excellent. Calculating all three heights, comparing both T/S parameter sets, and arriving at the 72" recommendation with quantitative backing is exactly the kind of engineering analysis that should anchor the design package. The F3 convergence observation (all heights give ~29.4 Hz) is a genuinely useful insight that simplifies the decision.

---

## Senior's Take

Three observations:

**The ADC/DAC confusion is embarrassing but the underlying concern is valid.** Yes, the ADC handles 2V fine. But the DAC output gap is real, and it means the APM2 architecture delivers 6% of the amplifier's rated power. Is that acceptable? Probably — 120.5 dB passband is still obscene. But "weapons-grade bass" implies you want all the headroom you can get, and leaving 12 dB on the table because of a $45 DSP board's output stage is a poor engineering trade-off. The DRV134 balanced line driver stage costs about $30 in parts and recovers the full 620W/ch. That's the real recommendation: APM2 + DRV134, not APM2 alone and not "replace with ADAU1452."

**The budget errors reveal a document maintenance problem, not a math problem.** The source document (Garage_Conversion_Option1.md) has been through 7+ revisions. Line items got updated, subtotals didn't. The Analyst's job was to catch this, and they caught the Phase 2 discrepancy but missed the Phase 1 error because they trusted the document's stated total instead of independently summing. The fix isn't better arithmetic — it's a budget spreadsheet that computes totals from cells, not a markdown table with hand-typed sums.

**The Architect's plan is ready.** The document tree, dependency order, diagram list, and model scope are all correct. The inconsistency table (20 items!) is exactly the kind of work that prevents errors from propagating into the design package. The three blocking questions (T/S params, DSP board, cabinet height) are now resolved or resolvable: T/S is confirmed from spec sheet, cabinet height is 72" per Analyst's analysis, and DSP board should be presented as a decision matrix. Nothing prevents Phase 2 writing from beginning.

---

## Sources

- [ADAU1701 Datasheet (Rev C) — Analog Devices](https://www.analog.com/media/en/technical-documentation/data-sheets/adau1701.pdf)
- [ADAU1701 Input/Output Levels — EngineerZone Q&A](https://ez.analog.com/dsp/sigmadsp/f/q-a/555048/verifying-adau1701-input-and-output-levels)
- [ADAU1701 ADC Input Resistor — EngineerZone Q&A](https://ez.analog.com/dsp/sigmadsp/f/q-a/66130/optimal-adc-input-resistor-for-adau1701)
- [ICEpower 1200AS2 Datasheet](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
- [ICEpower 1200AS2 — Parts Express](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)
- [Dayton Audio UMII18-22 Spec Sheet (295-718)](https://www.daytonaudio.com/images/resources/295-718--dayton-audio-UMII18-22-spec-sheet.pdf)
- [Dayton Audio UMII18-22 — Parts Express](https://www.parts-express.com/Dayton-Audio-UMII18-22-ULTIMAX-II-18-1100W-RMS-DVC-Subwoofer-2-Ohm-Per-Coil-295-718)
- [Wondom APM2 — Sure Electronics](https://store.sure-electronics.com/product/AA-AP23122)
- [Dayton UMII18-22 — Loudspeaker Database](https://loudspeakerdatabase.com/Dayton/UMII18-22)

---

**Document Version:** 1.0
**Author:** Critic Agent
**Date:** 2026-03-15
