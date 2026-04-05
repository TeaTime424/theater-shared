# Critic Report — Option D Design Package
**Task:** 16 | **Date:** 2026-03-21 | **Agent:** Critic
**Inputs reviewed:** tmp_architect.md, tmp_analyst.md, ts_params.json, coordinates.json, tmp_investigation_notes.md

---

## 1. CONFLICT RESOLUTION

### 1A. Screen Aspect Ratio: 16:9 vs 2.35:1

| Position | Source | Value |
|----------|--------|-------|
| Architect | CLAUDE.md, layout_config.json, coordinates.json | 16:9, RESOLVED |
| Analyst | POR Rev 5.2 / Rev 7.0 docs | 2.35:1 (stale); acknowledges 16:9 is Option D active |
| coordinates.json | screen X1=172, X2=320 → W=148"; Y1=30, Y2=113 → H=83" | 148/83 = 1.783 = 16:9, confirmed |

**RULING: 16:9 is correct.** coordinates.json is authoritative. The 2.35:1 references all trace to Rev 5.2 / Rev 7.0 POR docs that predate Option D. No conflict between Architect and Analyst on the conclusion — both agree 16:9 is the Option D choice. Stale docs should be retired.

**Screen fit verdict:** Bottom at Y1=30", top at Y2=113" (coordinates.json). Ceiling at Y2=120". Clearance = 7". Screen FITS. The Analyst correctly identified that the stale 51" bottom height from 02_Front_Stage_System.md would cause the screen to exceed the ceiling (top = 134.3") — that is a correct finding about a stale doc conflict, not a real layout problem. The correct bottom height is 30" per coordinates.json, confirmed by its own assertion note: "Bottom at Y=30 not 51." This is SETTLED.

---

### 1B. HVAC Price: $1,359 vs $2,550-$2,650

| Source | Value | Scope |
|--------|-------|-------|
| Historical POR allocation | $1,800 | Estimate, no breakdown |
| Some references | $1,359 | Unit-only (model/config uncertain) |
| 16_HVAC_Plan_Theater.md v1.2 (current) | $2,550-$2,650 | System package ($2,359) + lineset/hardware ($175-$280) |
| tmp_investigation_notes.md §1.3 | $2,550 confirmed | Confirms gap vs $1,800 POR allocation |

**RULING: $2,550-$2,650 is correct.** The $1,359 figure is unit-only and not applicable to the full installed DIY cost. The $1,800 POR allocation was an underestimate; the $750 gap is confirmed. 16_HVAC_Plan_Theater.md v1.2 (March 13, 2026) is the authoritative source. Both Architect and Analyst agree. No dispute.

---

### 1C. Sub Footprint: 20" vs 24"

| Source | Value | Authority Level |
|--------|-------|----------------|
| Garage_Conversion_Option1.md | ~20×20" | STALE / ERROR |
| CLAUDE.md | 24×24" | Active config |
| layout_config.json | 24×24" | Authoritative layout |
| coordinates.json corner_subs | NW: X1=144, X2=168 → W=24"; Z1=252, Z2=276 → D=24" | Geometric proof |
| ts_params.json | footprint_nominal_in: "24 x 24" | Confirms |

**RULING: 24×24" is correct.** This is geometrically confirmed by coordinates.json (24" span in both X and Z for every corner sub). The 20×20" figure in Garage_Conversion_Option1.md is an error in that doc and must not carry forward. Both Architect and Analyst agree. SETTLED.

---

### 1D. T/S Parameter Conflict: ts_params.json vs tmp_por_core.md

| Parameter | ts_params.json (Dayton datasheet) | tmp_por_core.md (POR) | Delta |
|-----------|-----------------------------------|-----------------------|-------|
| Vas | 8.77 cu ft | 15.5 (incorrect) | WRONG in POR |
| Qts | 0.53 | 0.36 (incorrect) | WRONG in POR |
| Re | 5.8 Ω | 4.2 Ω | WRONG in POR |
| BL | 21.5 T·m | 19.2 T·m | WRONG in POR |
| Sd | 1,026 cm² | 1,184 cm² | WRONG in POR |
| Sensitivity | 95.7 dB/1W/1m | 90.7 dB | WRONG in POR |
| Power handling | 1,500 W | 1,200 W AES | WRONG in POR |

**RULING: ts_params.json is authoritative.** It explicitly sources the Dayton Audio UMII18-22 datasheet, Parts Express SKU 295-487, and marks the POR values as "DO NOT USE" with the warning directly in the JSON header. The POR values (Vas=15.5, Qts=0.36) were identified errors that ts_params.json was created specifically to correct. This is a KNOWN CORRECTION, not a new discovery. It is NOT a blocker for Phase 4.

The Architect correctly flagged this and asked the Analyst to verify. The Analyst independently verified by computing Qtc/Fc/F3 from ts_params.json values and confirmed all three height calculations matched the JSON to within rounding. That cross-check is sufficient.

**Design package writers MUST use ts_params.json values throughout. POR T/S values must not appear in any new doc.**

---

### 1E. Signal Chain with 898B — PCM5102 Scenario

The Analyst identified two contradictory signal chains in tmp_investigation_notes.md:

| Scenario | Chain | Input to 898B | 898B Output | Result |
|----------|-------|---------------|-------------|--------|
| §3 (committed, updated) | X6800H → 898B | 0.9 Vrms | 0.9 × 3.886 = 3.50 Vrms | Correct: 98% of ICEpower sensitivity (3.55 V) |
| §2 (PCM5102 path) | X6800H → APM2 → ADAU1701 → PCM5102 → 898B | 2.0 Vrms (PCM5102 max) | 2.0 × 3.886 = 7.77 Vrms | CLIPS ICEpower input by +6.80 dB |

**RULING: §3 is the committed signal chain.** The §3 description is explicitly labeled "Signal Chain with 898B (Updated)" and is the most recent statement. The 898B receives X6800H pre-out at 0.9 Vrms and outputs 3.50 Vrms to the ICEpower — within spec with no attenuation required.

**The PCM5102 path (Scenario A) is NOT the committed chain for sub amplification.** PCM5102 is part of the DSP processing chain upstream, but the 898B input is the X6800H pre-out (0.9 Vrms), not the PCM5102 output (2.0 Vrms). The Analyst's Scenario A analysis is correct math but analyzes the wrong topology.

**Confirmed design constraint:** If the PCM5102 output EVER directly drives the 898B (e.g., if the chain topology changes), the DSP must attenuate -6.80 dB before the PCM5102 output stage. As built with §3 topology, no attenuation is needed. This is an ADVISORY for 05_dsp_and_signal_chain.md, not a blocker.

The Analyst's gain staging math is confirmed:
- PCM5102 (2.0 Vrms) × 3.886 = 7.77 Vrms — confirmed arithmetic
- Excess over 3.55 V: 7.77/3.55 = 2.19× = +6.80 dB — confirmed
- Required DSP cut if PCM5102 feeds 898B: -6.80 dB — confirmed

---

### 1F. Sub Cabinet Height: 72" (coordinates.json) vs 96" (ts_params.json recommendation)

This is a genuine Architect/Analyst disagreement. The Architect defers the decision. The Analyst recommends 96". This is settled in Section 4 below.

---

### 1G. DSP Platform: ADAU1452 vs ADAU1701

The Architect correctly identified that tmp_investigation_notes.md §1.1 (NX6000D investigation) adopted ADAU1452, but §2 explicitly overrides this: "DSP Platform: Wondom APM2 (ADAU1701) — NOT ADAU1452 for sub chain." The Analyst used ADAU1701/APM2 throughout. No conflict between Architect and Analyst on the final answer.

**RULING: ADAU1701 via Wondom APM2 is the committed DSP platform.** ADAU1452 is dead. Do not cite it in any new doc.

---

### 1H. 898B Gain: 11.79 dB vs "~14 dB"

**RULING: 11.79 dB is correct.** Creator-confirmed per tmp_investigation_notes.md §3, line 139-143. The "approximately 14 dB" manufacturer claim is for the standard -10 dBV → +4 dBu conversion, which is the correct context but imprecise. 11.79 dB is the verified value for 0.9 Vrms input at the 0.9 gain setting. Use 11.79 dB in all docs.

---

### 1I. Volt-10 Count: 10 vs 12

| Source | Count | Breakdown |
|--------|-------|-----------|
| CLAUDE.md | 10 | "4 surrounds + 6 Atmos" |
| Analyst (tmp_analyst.md §1B) | 12 | "4 surrounds + 6 Atmos + 2 front wide = 12" |
| Rev 7.0 budget | 10 × $242 = $2,420 | Understated |

**RULING: Analyst is correct — 12× Volt-10.** Option D is 9.4.6 configuration. The front wide channels are Volt-10 per CLAUDE.md: "All 10 surround/Atmos are identical Volt-10" — but this statement precedes the front wide addition. The 9.4.6 count (9 base + 4 surrounds + 6 Atmos) implies 2 front wides as part of the 9-channel base or as additional wides. The Analyst's G10 flag is valid. Speaker subtotal should use 12× $242 = $2,904, not 10× $2,420. Delta = +$484.

---

## 2. BUDGET ARITHMETIC VERDICT

### Rev 7.0 Budget (Stale — for reference only)

Analyst recomputed: stated ~$72,000 mid vs computed $74,980. **Delta: +$2,980. Arithmetic error in source doc.** This is the stale POR budget and will not be carried forward.

**Rev 7.0 verdict: FAIL (arithmetic error, +$2,980 discrepancy). ADVISORY only — doc is superseded.**

### Option D Budget

The Analyst could not reconstruct the CLAUDE.md "$36,600 out-of-pocket" figure from available line items. Key gaps:

| Gap | Notes |
|-----|-------|
| Enclosure BOM (4× sub cabinets, 24×24×72") | Not in any Option D source doc. Estimate $800-1,200 |
| Electrical subpanel/wiring | No line item. Estimate $1,500-3,000 |
| ICEpower chassis/connectors | $2,065 stated but per-unit math ($373×5=$1,865) leaves $200 unaccounted |
| Projector | $30,000 placeholder excluded from $36,600 per Analyst (plausible) |
| Seating | $6,000 excluded from $36,600 (plausible — "out-of-pocket A/V+construction") |

**The $36,600 figure is not reconstructible from available line items.** A full Option D BOM with sources is required before 06_budget.md can be written accurately.

**Option D Budget verdict: INCOMPLETE — not verifiable. BLOCKER for 06_budget.md specifically, but does not block other docs.**

---

## 3. T/S PARAMETER VERIFICATION

**All Analyst sub calculations use ts_params.json values. Confirmed.**

| Parameter | ts_params.json | Analyst Used | Match |
|-----------|---------------|--------------|-------|
| Fs | 22.0 Hz | 22.0 Hz | Yes |
| Qts | 0.53 | 0.53 | Yes |
| Vas | 8.77 cu ft | 8.77 cu ft | Yes |
| Footprint | 24×24" | 24×24" | Yes |
| Panel thickness | 0.75" | 0.75" | Yes |
| Bracing factor | 0.85 | 0.85 | Yes |

No calculation uses Vas=15.5 or Qts=0.36. The incorrect POR values do NOT appear in any Analyst output.

**Independent arithmetic check (Critic):**

72" cabinet: gross = 22.5² × 35.25 = 17,864 in³ = 10.337 ft³; net = 8.787 ft³; α = 8.77/8.787 = 0.998; sqrt(1.998) = 1.414; Qtc = 0.53 × 1.414 = **0.749**; Fc = 22 × 1.414 = **31.1 Hz**. Matches ts_params.json and Analyst.

96" cabinet: gross = 22.5² × 47.25 = 23,943 in³ = 13.856 ft³; net = 11.778 ft³; α = 8.77/11.778 = 0.745; sqrt(1.745) = 1.321; Qtc = 0.53 × 1.321 = **0.700**; Fc = 22 × 1.321 = **29.1 Hz**. Matches ts_params.json and Analyst.

**T/S PARAMETER VERIFICATION: PASS.** All calcs use correct Dayton datasheet values.

---

## 4. SUB CABINET HEIGHT DECISION

### Acoustic Summary

| Height | Vb net (ft³) | Qtc | Fc (Hz) | F3 (Hz) | Notes |
|--------|-------------|-----|---------|---------|-------|
| 72 in | 8.79 | 0.749 | 31.1 | 29.5 | Mild hump (0.4 dB at Fc); in coordinates.json; structural screen wall role |
| 96 in | 11.78 | 0.700 | 29.1 | 29.4 | Butterworth; NOT in coordinates.json |
| 120 in | 14.77 | 0.669 | 27.8 | 29.4 | Underdamped; 120" in 120" ceiling = zero clearance — EXCLUDED |

### 120" is eliminated: a 10-foot cabinet in a 10-foot room leaves zero clearance for a top plate, mounting, or any ceiling irregularity. Not viable.

### 96" vs 72": The Acoustic Case Is Weak

F3 spread across all viable heights: 29.4–29.5 Hz — **0.1 Hz.** The acoustic difference between 72" and 96" is unmeasurable in a real room with corner loading. The Analyst's own analysis concedes this: "room gain from corner loading will dominate below 30 Hz regardless of alignment choice."

The Qtc difference (0.749 vs 0.700) produces a theoretical +0.4 dB hump at Fc for the 72" cabinet. In a room with +11 dB boundary gain and 6 dB acoustic summing from 4 corners, this 0.4 dB is drowned by real-room variation. It is DSP-correctable in one biquad.

### The Non-Acoustic Case Is Decisive

**72" is already in coordinates.json.** All geometry is built around it. The NW/NE/SW/SE corner sub entries in coordinates.json are Y1=0, Y2=72. The stage is Y2=27. The screen bottom is Y1=30. These relationships are consistent with 72" cabinets that double as screen wall structure (stacked pair = 72" height visible behind/beside stage).

Changing to 96" requires:
1. Updating coordinates.json (Y2 for all 4 corner subs: 72 → 96)
2. Re-checking screen clearance (screen top Y2=113; sub top Y2=96 — 17" below screen top, no conflict)
3. Re-verifying stage-to-sub height relationship
4. Updating any OBJ model generated from coordinates.json

The 96" cabinets fit physically: 96" sub top < 113" screen top, both below 120" ceiling. No geometric conflict. But the change requires a coordinates.json update and has no acoustic payoff.

### DECISION: 72 INCHES

**Chosen height: 72" (6 feet)**
**Qtc: 0.749**
**Fc: 31.1 Hz**
**F3: 29.5 Hz**

**Rationale:**
1. Already in coordinates.json — no downstream updates required.
2. F3 = 29.5 Hz vs 96" F3 = 29.4 Hz. The 0.1 Hz difference is not audible and not measurable.
3. The 0.4 dB Qtc hump is correctable by one DSP shelf/peak filter.
4. 72" cabinets serve structural screen wall role — documented in CLAUDE.md and coordinates.json.
5. 6-foot cabinets are buildable, movable, and room-appropriate.
6. Changing to 96" for a theoretical Butterworth target that room gain will override below 30 Hz is not justified.

**Downstream agents treat 72" as settled.** coordinates.json stands as-is. 03_subwoofers.md uses 72" throughout.

---

## 5. SCOPE CHECK

### 7-Doc Structure Assessment

| Doc | Justified? | Risk |
|-----|-----------|------|
| 00_index.md | Yes — navigation required for any multi-doc package | Low |
| 01_room_and_layout.md | Yes — contractors need exact dimensions | Low |
| 02_speakers.md | Yes — drives amp selection and wire sizing | Low |
| 03_subwoofers.md | Yes — most complex subsystem, has build instructions | Moderate — DSP overlap risk with 05 |
| 04_amplification.md | Yes — ICEpower + ATI + X6800H integration | Low |
| 05_dsp_and_signal_chain.md | Yes — without this the DSP is unbuildable | High — scope creep risk |
| 06_budget.md | Yes — 2027 spend plan | Moderate — gaps exist |

**Verdict: 7 docs is correct.** No scope creep found at the structural level.

**05_dsp_and_signal_chain.md bloat risk:** The Architect's caution is correct. This doc covers APM2 hardware, ADAU1701 register map, biquad coefficient format, PCM5102 interface, 898B gain staging, ICEpower sensitivity, and the full signal chain. It will want to become a tutorial. Enforce: one biquad coefficient table, one gain staging table, one signal chain diagram. No explanatory prose on how biquads work.

**Old POR docs to retire:** 01_Project_Overview_and_Room.md (Rev 5.2), 02_Front_Stage_System.md (Rev 5.2), 03_Subwoofer_System.md (Rev 5.9), 11_Budget_Summary.md (Rev 7.0), 14_Quick_Reference.md (Rev 7.0). These contain wrong room dimensions, wrong amp platforms, wrong driver configs, and wrong DSP. They must not be referenced by any new doc.

---

## 6. VERDICT

### PROCEED with two BLOCKERs and four ADVISORIEs

---

### BLOCKER LIST

| # | Blocker | Affected Doc | Resolution Required |
|---|---------|-------------|---------------------|
| B1 | Option D budget is not reconstructible from available line items. CLAUDE.md "$36,600" figure has no verified BOM backing it. Key gaps: enclosure BOM, electrical subpanel cost, ICEpower chassis/connectors itemization. | 06_budget.md | Build full Option D BOM with line-item sources before writing 06_budget.md. Other docs can proceed. |
| B2 | Signal chain topology ambiguity (G9): tmp_investigation_notes.md §2 and §3 give contradictory descriptions of where PCM5102 output goes. §3 is labeled "updated" and shows X6800H → 898B directly, which is the committed chain. But §2's "full chain" note says PCM5102 → [signal to X6800H or direct] → 898B, leaving routing ambiguous. 05_dsp_and_signal_chain.md CANNOT be written until this topology is definitively locked. | 05_dsp_and_signal_chain.md | **Owner or Architect must confirm: does PCM5102 output feed the 898B, or does X6800H pre-out feed the 898B?** The Critic's reading of §3 says X6800H pre-out → 898B is the committed chain. If confirmed, PCM5102 is only in the DSP processing path before the X6800H input (or the pre-out bypasses it entirely). Lock this before writing 05. |

**Note on B2:** The Critic leans toward §3 as definitive, but the ambiguity in §2's last line ("Full chain: X6800H → APM2 ADC → ADAU1701 → I2S → PCM5102 → [signal to X6800H or direct] → 898B") is not self-resolving. "Or direct" means the topology is explicitly branch-conditional. This must be stated as a single unambiguous path before 05_dsp_and_signal_chain.md is written. **Blocker for that doc only.**

---

### ADVISORY LIST

| # | Advisory | Impact | Action |
|---|---------|--------|--------|
| A1 | POR T/S values (Re, BL, Sd, sensitivity, power) are wrong. ts_params.json has the correct Dayton datasheet values. 03_subwoofers.md must use ts_params.json values only. | Medium — wrong values in any calcs produce wrong results | 03_subwoofers.md writer: source ts_params.json exclusively. Note in doc that POR values are superseded. |
| A2 | "#2 Al / 60A" subpanel feed wire spec appears in the task description but is NOT in any W0 source document. Source docs specify 100A subpanel and 20A/240V sub amp circuit, but feed wire gauge and main breaker for the subpanel are not documented. | Low-Medium — affects 01_room_and_layout.md electrical section | Mark as [UNVERIFIED] in design package. Owner must confirm with electrician. Do NOT write "#2 Al / 60A" without a source. Does not block Phase 4. |
| A3 | Volt-10 count: CLAUDE.md says 10 but Option D 9.4.6 configuration requires 12 (4 surrounds + 6 Atmos + 2 front wide). Speaker subtotal should be 12 × $242 = $2,904, not $2,420. Delta: +$484. | Low — budget line item only | Update speaker BOM in 06_budget.md to 12× Volt-10. |
| A4 | If PCM5102 output ever directly feeds the 898B (topology change), DSP must attenuate -6.80 dB before the PCM5102 output reaches the 898B to avoid clipping the ICEpower input. Document this constraint in 05_dsp_and_signal_chain.md as a design guard. | Low — advisory for build phase | Note in 05_dsp_and_signal_chain.md: PCM5102 max output (2.0 Vrms) × 898B gain (×3.886) = 7.77 Vrms, which clips ICEpower input (3.55 Vrms). If PCM5102 ever feeds 898B directly, apply -6.80 dB DSP attenuation ceiling. |

---

### DECISIONS BINDING ON DOWNSTREAM AGENTS

1. **Sub height: 72 inches.** Qtc=0.749, Fc=31.1 Hz, F3=29.5 Hz. coordinates.json stands unchanged.
2. **Screen aspect ratio: 16:9.** Bottom at Y=30". Fits ceiling with 7" clearance.
3. **Sub footprint: 24×24 inches.** Geometrically confirmed by coordinates.json.
4. **T/S source: ts_params.json only.** POR values are known errors.
5. **DSP platform: ADAU1701 via Wondom APM2.** ADAU1452 is dead.
6. **898B gain: 11.79 dB.** Not 14 dB.
7. **HVAC cost: $2,550-$2,650 DIY all-in.**
8. **Committed signal chain (pending B2 confirmation): X6800H pre-out (0.9 Vrms) → 898B → 3.50 Vrms → ICEpower 1200AS2.**

---

### PHASE 4 GATE

- **01_room_and_layout.md:** PROCEED (mark electrical feed [UNVERIFIED])
- **02_speakers.md:** PROCEED
- **03_subwoofers.md:** PROCEED (use ts_params.json, 72" height)
- **04_amplification.md:** PROCEED
- **05_dsp_and_signal_chain.md:** BLOCKED (B2 — signal chain topology must be locked)
- **06_budget.md:** BLOCKED (B1 — BOM rebuild required)

Docs 01-04 can be written in parallel. 05 and 06 require blocker resolution first.
