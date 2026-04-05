# Critic Report — Task #16
**Date:** 2026-03-21
**Sources:** tmp_architect.md (Task #14), tmp_analyst.md (Task #15), ts_params.json

---

## 1. CONFLICT RESOLUTION

### 1A. Sub Cabinet Height: 72" (CLAUDE.md) vs 96" (ts_params.json)

**Architect position:** CLAUDE.md states 72" (24"×24"×72"). Flagged as a DESIGN DECISION gap. Neither accepts nor rejects the 96" recommendation — defers the decision.

**Analyst position:** 96" is correct. Qtc=0.700 vs Qtc=0.749 at 72". Cleaner response for DSP correction. Calls 72" a "legacy figure."

**Verdict: 96" wins.** See Section 4 for the full decision with rationale. The 72" figure in CLAUDE.md is not derived from any acoustic analysis — it appears to have been an architectural estimate. The ts_params.json calculation (confirmed independently by the Analyst) is the only acoustically-grounded figure. CLAUDE.md must be updated.

---

### 1B. Budget: $36.6K (CLAUDE.md) vs ~$40.9K (Analyst recompute)

**CLAUDE.md position:** ~$36,600 out-of-pocket. No line-item breakdown. Appears in the config header only.

**Analyst position:** Bottom-up resum yields ~$40,876 (excluding projector, using estimated electrical). Gap of ~$4,276. Likely causes: CLAUDE.md zeroes out 2 owned drivers, excludes FW speakers from Volt-10 count, uses $1,800 HVAC (not actual $2,550), omits electrical line.

**Verdict: BLOCKER — see Section 2.** The $36.6K figure is not reliable as a procurement baseline. The Analyst's methodology is sound. See Section 2 for full ruling.

---

### 1C. T/S Secondary Parameters: ts_params.json vs 03_Subwoofer_System.md

**Architect position:** Material discrepancy. Flagged as requiring resolution before enclosure analysis is used. Both claim Dayton datasheet. May be different SKU or driver revision.

**Analyst position:** Used ts_params.json exclusively (per instructions). Noted the divergence. Did not attempt to adjudicate source authority.

**Parameter conflict table (confirmed by reading both sources):**

| Param | ts_params.json | 03_Sub doc | Delta |
|-------|---------------|------------|-------|
| Qts | 0.53 | 0.53 | — (agree) |
| Vas | 8.77 cu ft | 8.77 cu ft (248.4 L) | — (agree) |
| Fs | 22.0 Hz | 22.0 Hz | — (agree) |
| Xmax | 28.0 mm | 28.0 mm | — (agree) |
| Qes | 0.58 | 0.67 | 15.5% |
| Qms | 6.22 | 2.53 | 146% |
| Re | 5.8 Ω | 4.2 Ω | 38% |
| BL | 21.5 T·m | 19.2 T·m | 12% |
| Sd | 1,026 cm² | 1,184 cm² | 13% |
| Sensitivity | 95.7 dB | 90.7 dB | 5 dB |

**Verdict:** The primary enclosure parameters (Qts, Vas, Fs, Xmax) agree across both sources. The enclosure volume calculations in ts_params.json and confirmed by the Analyst are valid — they depend only on Qts and Vas, which are consistent. The secondary parameter divergence (Qes, Qms, Re, BL, Sd, sensitivity) does NOT affect the enclosure analysis but does affect:
- Sensitivity used in SPL calculations (5 dB difference is significant)
- Power handling and excursion modeling

The ts_params.json note explicitly cites Dayton datasheet SKU 295-487 as the source. The 03_Sub doc does not cite a specific SKU or revision. ts_params.json is the more recently curated source and has explicit provenance. **Use ts_params.json for all secondary params.** The 03_Sub doc values are suspect — likely from an earlier driver data version or incorrect SKU. The Analyst's SPL calculations using 95.7 dB sensitivity (ts_params.json) are correct.

**ADVISORY:** The 5 dB sensitivity difference (95.7 vs 90.7 dB) changes SPL headroom materially. At 90.7 dB: sub array SPL drops from ~121 dB to ~116 dB — still well above the 95 dB target. Not a design blocker but the POR doc must be corrected to match ts_params.json.

---

### 1D. DSP Platform: ADAU1452 vs ADAU1701

**Architect position:** Both coexist. ADAU1452 = sub DSP; ADAU1701 on Wondom APM2 = channel/preamp DSP. These are two different physical devices in the signal chain. Not contradictory — documentary confusion only.

**Analyst position (G8):** Flagged as Critical/unresolved. "These have different fixed-point formats; biquad values would be different."

**Verdict: Architect is correct. These are two different devices, not a conflict.** The signal chain is:
- X6800H pre-out → APM2 (ADAU1701, 5.23 fixed-point) → ICEpower → sub drivers
- The ADAU1452 (8.24 fixed-point) handles sub crossover/EQ/limiting upstream

The Analyst's G8 flag overstates the problem. The two DSPs operate at different points in the chain; their fixed-point formats do not collide. The documentation confusion is real — 00/11/14 docs reference DSP-408 (stale); 06_Electronics and 15_DSP reference ADAU1701 (correct for channel DSP); CLAUDE.md references ADAU1452 (correct for sub DSP). The build docs must explicitly document both devices with their roles, addresses, and fixed-point formats. **This is a DOCUMENTATION ADVISORY, not a design blocker.**

---

### 1E. Projector Throw: Analyst flagged as tight

**Analyst position:** At projector position 18.5 ft from north wall, available throw = 15.0 ft, required ratio = 1.21:1 — below the 1.4:1 minimum. Only feasible from near south wall (~21 ft from north), giving 17.5 ft throw, ratio 1.42:1, barely inside minimum.

**Architect position:** Did not independently address projector throw. Noted the screen aspect ratio conflict (16:9 vs 2.35:1) but deferred throw calculation.

**Verdict: The Analyst's math is correct and the flag is valid.** Screen width = 148.2" = 12.35 ft (confirmed). At 1.4:1 minimum throw: 1.4 × 12.35 = 17.3 ft required. South wall mount at 21 ft: 21 - 3.5 = 17.5 ft available — marginal clearance of 0.2 ft. This leaves essentially zero zoom margin.

However, projector selection is deferred to 2027 and not yet specified. The JVC NZ500 used in the Analyst's calculation is not a committed design choice. The projector budget line is explicitly TBD. **This is an ADVISORY, not a blocker for the current build package** — but the build docs must flag that south-wall mount is required for any 1.4:1+ lens with a 170" 16:9 screen in a 23 ft room.

**Note:** The Analyst correctly identifies that JVC's actual NZ500 minimum throw ratio (1.36:1 per datasheet) differs from the 1.4:1 in the task spec. At 1.36:1: minimum throw = 1.36 × 12.35 = 16.8 ft, achievable at 16.8 + 3.5 = 20.3 ft from north wall. Still near south wall, but the constraint is slightly relaxed.

---

### 1F. Shaker Wiring: 8×4Ω parallel = 0.5Ω

**Analyst position (G15):** Critical safety issue. 8× AST-2B-4 (4Ω) in parallel = 0.5Ω — far below ICEpower 1200AS2 minimum load of 2Ω. No wiring configuration specified in any POR doc.

**Architect position:** Did not flag shaker wiring specifically. Noted shakers as settled (8× Aura Pro AST-2B-4).

**Verdict: The Analyst is correct. This is a BLOCKER.** No wiring configuration can deliver 8× 4Ω shakers from a single ICEpower channel at safe impedance:
- 8 parallel: 0.5Ω (destructive)
- 4 parallel: 1.0Ω (below minimum)
- 2 parallel: 2.0Ω (at minimum limit — marginal, not recommended)
- 4S×2P: 8Ω (safe, but requires 4 separate series groups of 2)
- 2S×4P: 2Ω (at minimum — marginal)

The only safe configurations are series-parallel combinations. A 4S×2P arrangement (4 shakers in series × 2 parallel groups = 8Ω) is safe but delivers very low power per shaker from a 1200AS2. Alternatively, use a dedicated shaker amplifier (e.g., Crown XLS1502 at 2×525W into 4Ω) with two channels driving 4 shakers each in parallel at 1Ω — still below minimum. **The shaker subsystem needs its own amplifier specified or the wiring configuration must be explicitly resolved before build.** ICEpower 1200AS2 cannot safely drive 8× 4Ω shakers under any single-channel wiring scheme.

---

## 2. BUDGET ARITHMETIC VERDICT

**Is $36.6K reliable?** No.

**Gap:** $40,876 (Analyst resum) vs $36,600 (CLAUDE.md) = **$4,276 gap**.

**Arithmetic verification of Analyst's key line items:**

| Item | Analyst Computed | Source Check | Status |
|------|-----------------|--------------|--------|
| 8× UMII18-22 (2 owned) | $2,799.84 gross / $2,099.88 net new | 8 × $349.98 = $2,799.84 ✓ | OK |
| ICEpower 1200AS2 × 5 | $1,865 | 5 × $373 = $1,865 ✓ | OK |
| Chassis × 5 | $200 | 5 × $40 = $200 ✓ | OK |
| APM2 DSP + balanced out | $215 | Cited to 06_Electronics | OK |
| AVR-X6800H | $3,700 | Retail 2024 — challenge flagged | UNVERIFIED |
| Volt-10 × 12 | $2,904 | 12 × $242 = $2,904 ✓ | OK (but count contested) |
| Shakers 8× | $560 | 8 × $70 = $560 ✓ | OK |
| Screen | $3,000 | From 11_Budget — 2.35:1 era | CHALLENGE flagged |
| Seating | $6,000 | From 11_Budget | Stated only |
| Acoustic treatment | $5,500 | Detail re-summed ✓ | OK |
| Infrastructure | $3,300 | Detail re-summed ✓ | OK |
| HVAC | $2,550 | From 16_HVAC_Plan_Theater | OK |
| Electrical | $1,500 est | No POR source | ESTIMATE |
| Sub enclosures | $800 est | No POR source | ESTIMATE |

**Gap decomposition vs CLAUDE.md $36,600:**

| Adjustment | Amount |
|------------|--------|
| 2 owned drivers at $0 (vs $699.96) | -$700 |
| FW speakers excluded (10 not 12 Volt-10) | -$484 |
| HVAC at $1,800 (not $2,550) | -$750 |
| Electrical excluded | -$1,500 |
| Sub enclosures excluded or lower | -$800 |
| **Subtotal adjustments** | **-$4,234** |

That accounts for $4,234 of the $4,276 gap — the two figures are reconcilable under those assumptions. The CLAUDE.md $36,600 appears to: (a) credit owned equipment at $0, (b) exclude FW speaker pair, (c) use budget HVAC not actual HVAC, and (d) exclude electrical and enclosure costs.

**BLOCKER verdict:** The $36.6K figure is **not a reliable out-of-pocket figure** for procurement planning. It understates actual cost by $2,500–$4,500 depending on:
- Whether owned items are truly not re-purchased
- Whether electrical is DIY or licensed
- Final projector selection (currently TBD/excluded)

**The gap exceeds $500. This is a BLOCKER.** A formal Option D budget document must be created with explicit line items, ownership tracking, and "net new spend" vs "sunk cost" columns. The number to publish as the out-of-pocket estimate is **~$39,000–$41,000** (projector excluded). If projector is included at $4,500–$8,000, total rises to $43,500–$49,000.

---

## 3. T/S PARAMETER VERIFICATION

**Are Analyst calcs from ts_params.json?** Yes. The Analyst explicitly states "T/S Parameters Used (ts_params.json ONLY)" and lists Fs=22.0, Qts=0.53, Vas=8.77, Xmax=28.0 — all matching ts_params.json line-for-line.

**Are stale values used?** No. The Analyst did not use the erroneous Vas=15.5 or Qts=0.36 values. The ts_params.json note field explicitly warns against these.

**Arithmetic spot-checks (72" cabinet):**

- Internal height: 72 - 2×0.75 = 70.5" ✓
- Gross volume: (22.5 × 22.5 × 70.5) / 1728 = 35,728.125 / 1728 = 20.671 cu ft (ts_params: 20.654 — 0.08% rounding) ✓
- Net volume: 20.654 × 0.85 = 17.556 cu ft ✓
- Vb/driver: 17.556 / 2 = 8.778 cu ft ✓
- α = 8.77 / 8.778 = 0.999 ✓
- Qtc = 0.53 × √(1.999) = 0.53 × 1.4139 = 0.749 ✓
- Fc = 22.0 × 1.4139 = 31.1 Hz ✓

**Arithmetic spot-checks (96" cabinet):**

- Internal height: 96 - 2×0.75 = 94.5" ✓
- Gross volume: (22.5 × 22.5 × 94.5) / 1728 = 47,898.75 / 1728 = 27.720 cu ft (ts_params: 27.686 — 0.12% rounding) ✓
- Net volume: 27.686 × 0.85 = 23.533 cu ft ✓
- Vb/driver: 23.533 / 2 = 11.767 cu ft ✓
- α = 8.77 / 11.767 = 0.745 ✓
- Qtc = 0.53 × √(1.745) = 0.53 × 1.3209 = 0.700 ✓
- Fc = 22.0 × 1.3209 = 29.06 Hz ✓

All Analyst calculations are arithmetically correct and sourced from ts_params.json. No stale values detected.

**Note on SPL sensitivity:** The Analyst used 95.7 dB (ts_params.json). The 03_Sub doc value of 90.7 dB is not used. The 5 dB difference shifts sub SPL from ~121 dB to ~116 dB gross — still well above the 95 dB target. The choice of ts_params.json is correct given its explicit datasheet citation.

---

## 4. SUB CABINET HEIGHT DECISION

**Decision: 96 inches (8 feet).**

This decision is final as of this report.

| Parameter | 72" | **96" (chosen)** | 120" |
|-----------|-----|-----------------|------|
| Vb/driver | 8.778 cu ft | **11.766 cu ft** | 14.755 cu ft |
| Qtc | 0.749 | **0.700** | 0.669 |
| Fc | 31.1 Hz | **29.1 Hz** | 27.8 Hz |
| F3 | 29.4 Hz | **29.4 Hz** | 29.4 Hz |
| Ceiling clearance | 4 ft | **2 ft** | 0 ft |

**Rationale:**

1. **Qtc=0.700 is acoustically superior.** Butterworth optimum is Qtc=0.707. The 96" cabinet is within 1% of Butterworth. The 72" cabinet at Qtc=0.749 produces a ~+1.5 dB shelf hump at Fc that requires DSP correction — wasting headroom and increasing EQ complexity.

2. **F3 is identical.** All three heights produce F3≈29.4 Hz. Room gain in the 3,910 cu ft theater compensates any rolloff below that point. The F3 metric does not favor 72" or 120".

3. **120" is not feasible.** It equals the room height of 120" (10 ft). Even with negligible clearance, practical construction (base isolation, leveling) makes flush-to-ceiling installation unworkable.

4. **2 ft clearance at 96" is adequate.** Sub cabinets in corners will not be moved. 2 ft above 96" = 10 ft total = exactly room height, meaning the cab tops are at 8 ft. Clearance is 2 ft to the 10 ft ceiling. This is workable.

5. **ts_params.json team_recommendation is 96"** — the only acoustically-derived recommendation in any project file. CLAUDE.md's 72" is an architectural estimate with no acoustic justification found in any doc.

**Action required:** Update CLAUDE.md from "24"×24"×72"" to "24"×24"×96"" for sub cabinet height. Update any POR docs that reference 72" height.

---

## 5. SCOPE CHECK

**Is the 7-doc structure right-sized?** Yes, with caveats.

The 00–06 structure (index, room, front stage, sub system, amp/electronics, speakers, budget) is appropriate for a 2027 owner build reference. No scope bloat. The problem is not structure — it is staleness.

**Current doc health:**

| Doc | Status | Priority |
|-----|--------|----------|
| 00_index | Stale (NX6000D, DSP-408 refs) | Update |
| 01_room | Stale (Rev 5.2, wrong dims) | Rebuild |
| 02_front | Stale (Rev 5.2, AV10+PURIFI, 2.35:1 screen) | Rebuild |
| 03_sub | Partially stale (triangular columns, T/S param mismatch in body text) | Update |
| 04_amp | Missing as standalone | Create or absorb into 06 |
| 05_speakers | Partially current (AVR-A1H conflict) | Update |
| 06_electronics | Mostly current (X6800H/A1H internal conflict) | Update |

**What does NOT belong in 00–06:** OBJ model generation procedure, SigmaStudio COM protocol (Python), audio test pipeline. These are operational tools. The build package documents what was designed, not how to operate the DSP.

**What is missing from 00–06:** A formal Option D budget document (currently only in CLAUDE.md as an unstated aggregate). This is the highest-priority missing artifact.

---

## 6. VERDICT

**ADJUST — do not proceed to build agent until BLOCKERs are resolved.**

### BLOCKERs

| # | Issue | Required Action |
|---|-------|----------------|
| B1 | Budget: $36.6K understates out-of-pocket by $2.5K–$4.5K | Create formal Option D budget doc with net-new spend, sunk costs, and estimates flagged. Publish $39K–$41K as the working figure (projector excluded). |
| B2 | Shaker wiring: 8×4Ω cannot be safely driven from a single ICEpower channel | Specify shaker wiring configuration (e.g., 4S×2P = 8Ω per channel pair) OR specify a dedicated shaker amplifier. Update POR before build docs are written. |

### ADVISORYs

| # | Issue | Recommended Action |
|---|-------|--------------------|
| A1 | CLAUDE.md cabinet height: update 72" to 96" | Simple config update — do before next build agent dispatch. |
| A2 | T/S secondary params: 03_Sub doc diverges from ts_params.json on Qes/Qms/Re/BL/Sd/sensitivity | Update 03_Sub doc body text to match ts_params.json (Dayton datasheet SKU 295-487). Note the erroneous prior values. |
| A3 | DSP documentation: two DSP devices (ADAU1452 sub + ADAU1701 APM2 channel) not clearly documented together anywhere | Build docs must include a DSP section that names both devices, their roles, fixed-point formats, and which biquad coefficients apply to each. |
| A4 | Projector throw: south-wall mount required for 170" 16:9 in 23 ft room | Flag in build docs. Verify actual NZ500 throw ratio (1.36:1 datasheet vs 1.4:1 spec) when projector is selected. |
| A5 | Volt-10 count: 10 (budget) vs 12 (9.4.6 config with FW) | Confirm whether FWL/FWR are Volt-10 or separate speaker model. Reconcile budget line item (+$484 if 2 more added). |
| A6 | AVR-X6800H price at $3,700 | Verify current market price — 2024 retail may not hold in 2026–2027 procurement window. |
| A7 | Sub amp circuit sizing | Verify 20A/240V is adequate for 5× ICEpower 1200AS2 inrush + steady-state draw. May need 30A. |
| A8 | Electrical cost (~$1,500 estimate) | Get actual quote or confirm DIY scope before finalizing budget. |

### Cleared Items (no further action needed)

- Room dimensions: 17'×23'×10' — settled across all sources
- Screen: 170" 16:9 AT — settled (02_Front legacy 2.35:1 is documented as stale)
- Screen bottom: 30" — settled (coordinates.json overrides legacy 51")
- Sub enclosure footprint: 24"×24" — settled
- Sub amps: 5× ICEpower 1200AS2, 240V — settled
- Sub DSP: ADAU1452 — settled (sub DSP specifically)
- Channel DSP: ADAU1701 on APM2 — settled (channel DSP specifically)
- Speaker amp: X6800H + ATI AT525NC — settled (A1H in 05_Speaker Rev 7.0 is stale)
- SPL target: 95 dB @ MLP — settled; all channels meet target with large headroom
- HVAC: MrCool DIY 12K, partition wall — settled
- Nearfield subs: deferred — settled
- Sub enclosure analysis: ts_params.json values are correct and arithmetic is verified
- Cabinet height: **96" — DECIDED in this report**
