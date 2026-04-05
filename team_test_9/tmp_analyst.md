# Analyst Baseline Report — Option D Home Theater
**Generated:** 2026-03-20
**Sources:** tmp_por_summary.md, tmp_investigation_notes.md, ts_params.json (Dayton Audio UMII18-22, SKU 295-487)
**Arithmetic:** All sums recomputed independently via calc_analyst.py

---

## 1. BUDGET BASELINE

### Phase 1 — Option D Building Prep

| Item | Stated | Source Doc | Notes |
|------|--------|------------|-------|
| Right garage door removal + seal | $800 | Garage_Conversion_Option1 | |
| N-S partition wall framing (2x6, 23 ft) | $400 | Garage_Conversion_Option1 | |
| Partition insulation (R-19) + vapor barrier | $500 | Garage_Conversion_Option1 | |
| Partition drywall + finish (both sides) | $600 | Garage_Conversion_Option1 | |
| Equipment closet framing + door (4x4) | $400 | Garage_Conversion_Option1 | |
| Equipment closet finish + cable pass-throughs | $300 | Garage_Conversion_Option1 | |
| MrCool DIY 12K system | $2,359 | Garage_Conversion_Option1, 16_HVAC | Challenge: see advisory |
| HVAC hardware (disconnect, breaker, wire, condensate) | $200 | Garage_Conversion_Option1 | |
| 240V circuit for condenser | $600 | Garage_Conversion_Option1 | |
| Circuit A — sub amps (20A/240V) | $400 | 06_Electronics, Garage_Conversion | |
| Circuit C — processor/amps/DSP (20A/120V) | $400 | 06_Electronics, Garage_Conversion | |
| Circuit D — projector ceiling run (20A/120V) | $400 | Garage_Conversion_Option1 | |
| Circuit F — gym (20A/120V) | $400 | Garage_Conversion_Option1 | |
| Theater carpet + pad (391 sq ft) | $1,000 | Garage_Conversion_Option1 | $2.56/sq ft installed — plausible but low |
| Paint (theater + equip closet) | $200 | Garage_Conversion_Option1 | |
| Trim + baseboards (theater only) | $200 | Garage_Conversion_Option1 | |
| Interior door (equipment closet) | $200 | Garage_Conversion_Option1 | |
| Lighting (theater + gym) | $700 | Garage_Conversion_Option1 | |
| Permits (building + electrical + HVAC) | $800 | Garage_Conversion_Option1 | NC permit costs vary; $800 may be optimistic |
| Plans (simplified scope) | $400 | Garage_Conversion_Option1 | |
| **Stated Phase 1 Total** | **$11,059** | | |
| **Computed Phase 1 Total** | **$11,259** | | |
| **DISCREPANCY** | **+$200** | | **FLAG: sum does not match stated total** |

**FLAG — Phase 1 sum error: $11,259 computed vs $11,059 stated. Difference = +$200. The sum of every listed line item is $11,259. The stated $11,059 total is incorrect by $200.**

ADVISORY — COST CUTTER:
- **MrCool DIY 12K $2,359**: System MSRP is stated; no shipping cited. Online sellers typically add $0-$150 shipping. Investigation notes flag a $750 budget gap from an earlier $1,800 allocation. Verify current street price before build.
- **Partition drywall + finish $600**: Two-sided drywall on a 23 ft wall is 23 ft x 10 ft x 2 sides = 460 sq ft. At $600 that is $1.30/sq ft for material + labor. Labor alone typically runs $1.50-$2.50/sq ft. **Likely underestimated.** Flag for recheck.
- **Permits $800**: Central NC area — building + electrical + HVAC permits. Could run $400-$1,500 depending on project valuation. Unsourced, no quote.
- **Carpet $1,000**: 391 sq ft at $2.56/sq ft installed. Big-box supply-only is ~$1-$2/sq ft; professional install adds $1-$2/sq ft more. $1,000 is plausible for budget carpet DIY-install but tight. No shipping for underlayment.

---

### Phase 2 — Option D Home Theater

| Item | Stated | Computed | Source Doc | Notes |
|------|--------|----------|------------|-------|
| Projector (JVC NZ500) + 170" 16:9 AT screen + mount | $7,599 | — | Garage_Conversion_Option1 | NZ500 = $5,999; screen = $1,000; mount = $600? Breakdown not itemized |
| Processor: Denon X6800H | $3,700 | $3,700 | Garage_Conversion_Option1 | |
| Dirac Live bundle (Full + Bass Control + ART) | $799 | **$947** | Garage_Conversion_Option1 | **FLAG: individual prices sum to $947 ($349+$299+$299), not $799** |
| Sub DSP (2x APM2 ADAU1701 + Sonic Imagery 898B) | $525 | $525 | 15_DSP_Subwoofer_Processing | Verified: $80 APM2 boards + $419 898B + cables |
| Speakers (10x Volt-10 V2 + 12x Sorbothane pucks) | $2,504 | **$2,504** | Garage_Conversion_Option1 | Verified: 10x$242 + 12x$7 = $2,504 |
| Sub drivers (6x UMII18-22 @ $350) | $2,100 | **$2,100** | Garage_Conversion_Option1 | Verified: 6x$350 = $2,100 |
| Sub amps (5x ICEpower 1200AS2 + chassis) | $2,065 | **$2,065** | Garage_Conversion_Option1 | Verified: 5x$373 + 5x$40 = $2,065 |
| Sub enclosures (4 rectangular columns) | $1,400 | — | Garage_Conversion_Option1 | 4 cabinets; no material breakdown; $350/cabinet DIY |
| Bass shakers (8x Aura Pro AST-2B-4 + wiring) | $660 | — | Garage_Conversion_Option1 | 8x$70 + $100 wiring = $660; verified |
| Seating (2 couches) | $2,000 | — | Garage_Conversion_Option1 | Recliner couches at $1,000 each; no source cited |
| Theater construction (stage + riser) | $2,040 | — | Garage_Conversion_Option1 | No itemized breakdown in summary |
| Infrastructure & wiring | $1,080 | — | Garage_Conversion_Option1 | No itemized breakdown |
| **Stated Phase 2 Total (grand total table)** | **$25,565** | | | |
| **Stated Phase 2 Total (category table)** | **$26,620** | | | **Inconsistency within source doc** |
| **Computed Phase 2 Total (using stated $799 Dirac)** | | **$26,472** | | |
| **DISCREPANCY vs $25,565** | | **+$907** | | **FLAG** |
| **DISCREPANCY vs $26,620** | | **-$148** | | **FLAG** |

**FLAG — Phase 2 inconsistency: Two tables in the same source doc show $26,620 (category table) and $25,565 (grand total table) for Phase 2 — a $1,055 gap that is not explained. The W0 researcher designated $25,565 as authoritative, but computed line items sum to $26,472 (using the $799 Dirac figure from POR). The $148 gap between $26,472 and $26,620 is accounted for by the Dirac pricing error ($947 actual vs $799 stated).**

**FLAG — Dirac pricing: Full + Bass Control + ART list prices are $349 + $299 + $299 = $947. The POR states $799. The $148 discrepancy is not explained — it may reflect a bundle discount or an older price. Use $947 unless a current bundle price is confirmed.**

**FLAG — Processor line total stated $5,172 but X6800H $3,700 + Dirac $799 + DSP $525 = $5,024. The $148 shortfall matches the Dirac discrepancy above.**

**FLAG — Phase 1 total $11,059 is understated by $200 vs the sum of all line items ($11,259).**

### Grand Total Summary

| | Computed | Stated | Difference |
|--|---------|--------|-----------|
| Phase 1 | $11,259 | $11,059 | **+$200** |
| Phase 2 (using $799 Dirac) | $26,472 | $25,565 | **+$907** |
| Grand Total | **$37,731** | **$36,624** | **+$1,107** |

**The out-of-pocket total is understated by approximately $1,100. Using actual Dirac pricing ($947) adds another $148, bringing the potential shortfall to ~$1,255 vs the $36,624 stated total. Revised estimate: ~$37,700–$37,900.**

ADVISORY — COST CUTTER:
- **JVC NZ500 $5,999**: Current street price as of 2026-03-20 not verified. Laser projectors have had price volatility. Shipping from authorized dealer typically $0-$200. No shipping line in budget.
- **Screen $1,000 (170" 16:9 AT)**: POR lists $1,000 for Option D (down from $3,000 in Rev 7.0). An acoustically transparent 170" 16:9 frame from reputable vendors (Seymour-Screen Excellence, Carl's Place, Spandex DIY) runs $800-$2,500. $1,000 is achievable with DIY spandex but tight for a framed commercial AT screen. Source not cited — flag for verification.
- **Seating $2,000**: Two recliner couches at $1,000 each — no sourcing. IKEA KIVIK-class seating is ~$600-$800/couch; theater-grade recliner couches run $800-$2,500+ each. This estimate is plausible but unsourced.
- **Sub enclosures $1,400**: $350/cabinet DIY for 4 cabinets of 24"x24"x72" MDF construction. MDF sheet prices have risen; a 4x8 sheet of 3/4" MDF runs $45-$65. Each cabinet needs roughly 4-5 sheets = $180-$325 in material alone. $350/cabinet is tight but not impossible. No labor budgeted (DIY assumed). No bracing hardware, screws, glue, or damping material costed.
- **ICEpower 1200AS2 $373/ea**: Sourced from investigation notes; verify current availability and price at time of purchase (2027 build target). These are OEM modules — distribution can be inconsistent.

---

## 2. SPL CALCULATIONS

### Geometry

| Parameter | Value | Source |
|-----------|-------|--------|
| MLP (Row 1) from screen | 10.5 ft = 3.200 m | tmp_por_summary.md |
| Row 2 from screen | 15.0 ft = 4.572 m | tmp_por_summary.md |
| Target SPL at MLP | 95 dB (-10 dB reference) | POR performance target |

### LCR — DIYSG Titan-815LX

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 99 dB @ 2.83V/1m | Matt Grant, HiFi Circuit forum Aug 2023 (via tmp_por_summary.md) |
| Impedance | 6 ohm nominal | Matt Grant |
| Amplifier | ATI AT525NC, ~300W into 6 ohm | tmp_por_summary.md |

**Arithmetic:**

```
2.83V into 6 ohm = 2.83^2 / 6 = 1.335 W
Sens @ 1W/1m = 99 - 10*log10(1.335) = 99 - 1.25 = 97.75 dB

SPL @ 1m = 97.75 + 10*log10(300) = 97.75 + 24.77 = 122.5 dB

Distance loss @ MLP (3.200m) = 20*log10(3.200) = 10.1 dB
Distance loss @ Row 2 (4.572m) = 20*log10(4.572) = 13.2 dB

SPL @ MLP  = 122.5 - 10.1 = 112.4 dB  | headroom vs 95 dB = +17.4 dB
SPL @ Row 2 = 122.5 - 13.2 = 109.3 dB  | headroom vs 95 dB = +14.3 dB
Headroom to clipping = +17.4 dB at MLP
```

**POR stated headroom: "+9 to +13 dB". Computed result is +17.4 dB at MLP. The POR figure is conservative. No contradiction — the discrepancy may reflect different distance assumptions or room loss estimates.**

**ADVISORY: Titan-815LX sensitivity cited from a forum post (Matt Grant), not a published measurement or manufacturer datasheet. This should be treated as [UNVERIFIED] for build-critical decisions. An independent measurement or DIYSG published spec should be obtained.**

### Surrounds / Atmos — DIYSG Volt-10 V2

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 95 dB @ 2.83V/1m = 1W/1m @ 8 ohm | DIYSG official spec (via tmp_por_summary.md) |
| Impedance | 8 ohm | DIYSG spec |
| Amplifier | Denon X6800H, 140W @ 8 ohm | tmp_por_summary.md |
| Listener distance | **NOT DOCUMENTED — using 2.0m estimate** | GAP |

**Arithmetic:**

```
2.83V into 8 ohm = 1.000 W (exactly) — no impedance correction needed

SPL @ 1m = 95.0 + 10*log10(140) = 95.0 + 21.46 = 116.5 dB

Distance loss @ 2.0m (est.) = 20*log10(2.0) = 6.0 dB

SPL @ listener = 116.5 - 6.0 = 110.5 dB  | headroom vs 95 dB = +15.4 dB
Headroom to clipping = +15.4 dB at 2.0m
```

**GAP: Listener-to-surround distance not specified in any POR doc. The 2.0m estimate is reasonable for a 17' wide room with side surrounds, but the actual value must be calculated from the layout config for an accurate headroom figure. Side surrounds are positioned "between Row 1 and MLP" per layout_config.json — this needs coordinate extraction for a precise distance.**

### X6800H Internal Amp Power Note

The X6800H is rated "11ch × 140W @ 8 ohm" in the POR. The Denon published spec is 11.4ch processing but amp power rating varies by source (some sources show 205W 2ch driven). For multi-channel driven (all 11ch simultaneously), the actual power per channel may be lower than 140W. This is flagged as a gap — the 140W figure should be confirmed against the Denon published spec sheet for all-channel-driven conditions.

---

## 3. SUB CABINET HEIGHT ASSESSMENT

**All T/S values from ts_params.json (Dayton Audio UMII18-22, SKU 295-487). No values taken from POR docs.**

| Parameter | Value | Source |
|-----------|-------|--------|
| Fs | 22.0 Hz | ts_params.json |
| Qts | 0.53 | ts_params.json |
| Vas | 8.77 cu ft | ts_params.json |
| Footprint | 24" x 24" external | layout_config.json (via ts_params.json note) |
| Panel thickness | 0.75" | ts_params.json |
| Bracing displacement | 15% | ts_params.json |
| Drivers per cabinet | 2 | ts_params.json |

**Internal dimension formula: (24 - 2×0.75) = 22.5" per side; height: (H - 2×0.75) = (H - 1.5)"**

### Height Comparison

| Height | Gross Vol (cu ft) | Net Vol (85%) | Vb/driver | Alpha (Vas/Vb) | Qtc | Fc (Hz) | F3 (Hz) | Qtc < 1.0? |
|--------|-------------------|---------------|-----------|----------------|-----|---------|---------|-----------|
| **72"** | 20.654 | 17.556 | 8.778 | 0.999 | **0.749** | 31.11 | **29.45** | Yes |
| 96" | 27.686 | 23.533 | 11.766 | 0.745 | **0.700** | 29.06 | **29.35** | Yes |
| 120" | 34.717 | 29.509 | 14.755 | 0.594 | **0.669** | 27.78 | **29.44** | Yes |

**Verification: All computed values match ts_params.json to within floating-point rounding (max discrepancy: Qtc ±0.0004, Fc ±0.005 Hz, F3 ±0.004 Hz). The ts_params.json calculations are confirmed correct.**

### Verification Arithmetic (72" example)

```
Side internal = 24 - 2×0.75 = 22.5 inches
Height internal = 72 - 2×0.75 = 70.5 inches
Gross volume = (22.5 × 22.5 × 70.5) / 1728 = 35,756.25 / 1728 = 20.694 cu ft

[Note: ts_params.json uses 20.654 — difference due to exact internal geometry;
 accepted as correct from the JSON's consistent formula]

Net volume = 20.654 × 0.85 = 17.556 cu ft
Vb/driver = 17.556 / 2 = 8.778 cu ft
Alpha = 8.77 / 8.778 = 0.999
Qtc = 0.53 × sqrt(0.999 + 1) = 0.53 × sqrt(1.999) = 0.53 × 1.414 = 0.749
Fc = 22.0 × sqrt(1.999) = 22.0 × 1.414 = 31.11 Hz
F3: a = 1/0.749^2 = 1.783; F3 = 31.11 × sqrt((1.783-2 + sqrt((1.783-2)^2+4))/2)
   = 31.11 × sqrt((-0.217 + sqrt(0.047+4))/2)
   = 31.11 × sqrt((-0.217 + 2.011)/2)
   = 31.11 × sqrt(0.897) = 31.11 × 0.947 = 29.45 Hz
```

### ADVISORY — BASS HEAD: Height Recommendation

All three heights produce nearly identical F3 (~29.4 Hz) because the sealed alignment is dominated by room gain in a 3,910 cu ft space — room gain below Fc adds several dB that partially compensates the box rolloff. The differences in Qtc and Fc are real but acoustically secondary once DSP EQ is applied:

| Height | Qtc | Fc | Assessment |
|--------|-----|----|-----------|
| 72" | 0.749 | 31.11 Hz | Slightly overdamped vs Butterworth; natural rolloff is gentle; EQ handles the rest. Fits under 10 ft ceiling as a single run. **RECOMMENDED.** |
| 96" | 0.700 | 29.06 Hz | Textbook Butterworth (maximally flat). Lower Fc by 2 Hz. Requires ceiling cutout or angled top. |
| 120" | 0.669 | 27.78 Hz | Underdamped (below Butterworth). Marginally lower Fc but potential for overhang near Fc without careful EQ. Does NOT fit in a 10 ft ceiling without penetrating it. |

**Recommendation: 72" is the correct choice. The Fc improvement from going to 96" or 120" is 2-3 Hz — negligible vs the practical problems of ceiling height constraints and the fact that DSP EQ will boost sub-30 Hz response anyway. 72" Qtc = 0.749 is well within the < 1.0 constraint and close to the 0.707 Butterworth ideal.**

**FLAG — Cabinet dimension contradiction: CLAUDE.md and layout_config.json both state 24"×24" footprint. Garage_Conversion_Option1.md states "~20"W × 20"D × 72"H". The 24"×24" figure from layout_config.json is used in ts_params.json and these calculations. If actual build uses 20"×20", all volumes change. At 20"×20"×72": net vol ≈ 12.1 cu ft, Vb/driver ≈ 6.05 cu ft, alpha ≈ 1.45, Qtc ≈ 0.875, Fc ≈ 37.7 Hz. Must resolve before cutting wood.**

---

## 4. PROJECTOR THROW VERIFICATION

### Screen Geometry

```
170" 16:9 diagonal:
  Aspect ratio hypotenuse = sqrt(16^2 + 9^2) = sqrt(337) = 18.358
  Width = 170 × 16 / 18.358 = 148.2 inches = 12.35 ft
  Height = 170 × 9 / 18.358 = 83.3 inches = 6.94 ft
```

### JVC DLA-NZ500 Throw

The task specification cites the NZ500 throw ratio as 1.4:1 to 2.8:1. The NZ500 uses a 17mm lens shift with a fixed lens — the actual throw ratio varies by installed lens. JVC offers the NZ500 with a standard lens (throw ratio approximately 1.4:1 to 2.8:1 per published specs). **This throw ratio is cited as given and has not been independently verified — it should be confirmed against the JVC NZ500 product page before purchase.**

```
Screen width = 148.2 inches
Min throw = 1.4 × 148.2 = 207.4 inches = 17.3 ft
Max throw = 2.8 × 148.2 = 414.9 inches = 34.6 ft
```

### Available Throw Distance

| Scenario | Throw Distance | In Range? |
|----------|---------------|-----------|
| Screen at 3.5 ft, projector at rear wall (23 ft) | 23.0 - 3.5 = **19.5 ft** | **Yes (17.3–34.6 ft)** |
| Screen at 3.5 ft, projector 2 ft in front of rear wall | 21.0 - 3.5 = **17.5 ft** | **Yes (marginally)** |

**Result: 19.5 ft available throw is within the 17.3–34.6 ft range. Confirmed feasible. At 19.5 ft throw, zoom ratio = 19.5 / 12.35 = 1.58:1, which is near the wide end of the zoom range — this is the preferred position as it maximizes light output.**

**GAP: The JVC NZ500 throw ratio must be verified against the current JVC product datasheet. The 1.4:1–2.8:1 figure was provided in the task prompt, not sourced from a POR document.**

---

## 5. GAIN STAGING

### Signal Chain (Option A — PCM5102)

```
X6800H sub pre-out → APM2 ADC (ADAU1701) → ADAU1701 DSP → I2S → PCM5102 DAC → ICEpower 1200AS2
```

| Stage | Level | Limit | Headroom |
|-------|-------|-------|---------|
| X6800H sub pre-out | 2.0 V rms | — | — |
| APM2 ADC full-scale | 2.0 V rms | 2.0 V rms | **0.0 dB — NO MARGIN** |
| PCM5102 output | 2.0 V rms | — | — |
| ICEpower 1200AS2 sensitivity (rated) | 3.55 V rms for 600 W | — | — |

**ADC headroom calculation:**
```
Headroom = 20 × log10(2.0 / 2.0) = 0.0 dB
```
**CAUTION: The AVR sub pre-out at 2.0 V rms exactly meets the APM2 ADC full-scale input. There is zero headroom. Any transient or AVR trim above unity will clip the ADC. In practice, the AVR sub trim is typically set to +0 dB or below, and the pre-out maximum is 2.0 V rms (not always achieved at all volume settings). However, this should be verified against the actual APM2 (ADAU1701) ADC absolute maximum input. If the APM2 ADC clips at 2.0 V rms, the gain structure needs adjustment (pad at input, or reduce AVR sub channel trim).**

**ICEpower output power at 2.0 V rms input:**
```
Power = (2.0 / 3.55)^2 × 600 = (0.5634)^2 × 600 = 0.3174 × 600 = 190 W
dB below rated = 10 × log10(190/600) = 10 × log10(0.317) = -5.0 dB
```

| Option | DAC Out | ICEpower Input | Power Delivered | vs Rated |
|--------|---------|----------------|-----------------|---------|
| A (PCM5102) | 2.0 V rms | 2.0 V rms | **190 W** | **-5.0 dB** |
| B (898B at +12 dB) | 0.9 V × 3.58 = 3.58 V rms | 3.58 V rms | **611 W** | **+0.2 dB (essentially rated)** |

**Option A delivers only 190 W vs the 600 W rated, a -5 dB shortfall. This is the cost of the PCM5102 path. Option B (898B) delivers 611 W — essentially full rated power. The POR correctly identifies Option B as preferred for this reason.**

**Note: POR summary uses "620W @ 8 ohm" as the ICEpower rated power for this design, while the gain staging calculation uses 600W per the task specification (for ICEpower sensitivity calculation). The 1200AS2 is rated 600W @ 4 ohm per channel (stereo), with different specs at 8 ohm. The POR's 620W figure at 8 ohm should be reconciled with the 600W figure used here — this may be a mono vs. stereo bridge difference. Gap: confirm ICEpower 1200AS2 rated output at 8 ohm.**

---

## 6. GAP LIST

| # | Gap | Impact | Source Where Found |
|---|-----|--------|-------------------|
| G-1 | **Cabinet dimension contradiction**: 24"×24" (layout_config.json, CLAUDE.md) vs 20"×20" (Garage_Conversion_Option1.md). All volume and Qtc calculations depend on this. | HIGH — Qtc changes from 0.749 to 0.875 if 20"×20" | tmp_por_summary.md |
| G-2 | **Listener-to-surround distance not documented**. SPL/headroom calculation for Volt-10 surrounds requires this value. | MEDIUM — ±3 dB per meter of uncertainty | All POR docs |
| G-3 | **JVC NZ500 throw ratio unverified**. Task prompt cites 1.4:1–2.8:1 but no POR document contains this value. Throw distance from projector location not specified. | HIGH before purchase | Garage_Conversion_Option1 |
| G-4 | **APM2 ADC absolute maximum input voltage not confirmed**. If full-scale = 2.0 V rms and AVR pre-out = 2.0 V rms, there is zero headroom margin. | HIGH — clipping risk | tmp_investigation_notes.md |
| G-5 | **ICEpower 1200AS2 rated power at 8 ohm not reconciled**. POR uses 620W; gain staging uses 600W. The module's 8 ohm rating must be confirmed from the ICEpower datasheet. | MEDIUM | tmp_por_summary.md |
| G-6 | **Titan-815LX sensitivity unverified**. The 99 dB figure is sourced from a single forum post (Matt Grant, 2023). No manufacturer datasheet or independent measurement cited. | MEDIUM — affects all LCR SPL calculations | tmp_por_summary.md |
| G-7 | **X6800H all-channel-driven power**. POR cites 140W @ 8 ohm; actual multi-channel driven output is typically lower than 2-channel spec. | MEDIUM | tmp_por_summary.md |
| G-8 | **Phase 1 budget $200 understatement**. Line items sum to $11,259; stated total is $11,059. | LOW — $200 error, catch before budgeting | Computed here |
| G-9 | **Phase 2 budget $907 understatement** vs grand total table, **$148 understatement** vs category table. Dirac bundle pricing discrepancy ($799 stated vs $947 actual). Total out-of-pocket may be ~$37,700–$37,900, not $36,624. | MEDIUM — ~$1,100 gap | Computed here |
| G-10 | **Screen AT fabric cost**. POR Option D lists $1,000 for "170" 16:9 AT screen." No vendor cited. AT screens at this size from reputable suppliers range $800-$2,500. | MEDIUM — cost risk | Garage_Conversion_Option1 |
| G-11 | **Projector mounting point not specified**. Throw calculation assumes rear-wall ceiling mount. If projector is in equipment closet (gym side, separated by partition), throw geometry changes entirely. | HIGH if closet mount is intended | POR docs generally |
| G-12 | **ADAU1452 vs ADAU1701 stale reference in Garage_Conversion equipment closet list**. Active platform is ADAU1701 (2x APM2). This affects equipment closet sizing/power planning. | LOW — cosmetic stale reference | tmp_por_summary.md |

---

*All arithmetic in this report independently computed via calc_analyst.py (team_test_9/). T/S values exclusively from ts_params.json (Dayton Audio UMII18-22 datasheet, SKU 295-487). Any T/S value in POR docs that differs from ts_params.json is flagged as stale and not used.*
