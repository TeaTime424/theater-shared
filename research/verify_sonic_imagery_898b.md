# Verification: Sonic Imagery Labs Model 898B is an 8-channel unbalanced-to-balanced converter with +12 dB gain, RCA input, XLR output, priced at $389

**Date:** 2026-03-20
**Verdict:** LIKELY
**Confidence:** MEDIUM

## Claim

"The Sonic Imagery Labs Model 898B is an 8-channel unbalanced-to-balanced converter with +12 dB gain, RCA input, XLR output, priced at $389."

## Sources

### Source 1: Sonic Imagery Labs Official Product Page
- **URL:** https://www.sonicimagerylabs.com/products/Model898B.html
- **Type:** Manufacturer product page
- **Evidence:** 8 channels unbalanced-to-balanced AND 8 channels balanced-to-unbalanced (bidirectional, simultaneous). RCA (unbalanced) and XLR3-1 (balanced) connectors. Converts -10 dBV to +4 dBu. States "approximately 14 dB level shift." THD+N 0.0006% at 1 kHz, noise floor -101 to -107 dBu, crosstalk >-110 dB, max output +23 dBu, bandwidth DC-200 kHz.
- **Supports/Contradicts:** Supports channel count, I/O types. The gain figure is stated as "approximately 14 dB" on the official page, which contradicts the claimed "+12 dB." However, the standard -10 dBV to +4 dBu conversion is 11.78 dB (~12 dB) by definition — see Source 5.

### Source 2: Sonic Imagery Labs Official Ordering Page
- **URL:** https://www.sonicimagerylabs.com/ordering.htm
- **Type:** Manufacturer pricing
- **Evidence:** Model 898B listed at **$389.00 USD**.
- **Supports/Contradicts:** Confirms the $389 price exactly.

### Source 3: eBay Direct Listing (Sonic Imagery Labs Store)
- **URL:** https://www.ebay.com/itm/251341933874
- **Type:** Retailer listing
- **Evidence:** Listed at **$399.00** on eBay (seller: Sonic Imagery Labs). Description matches official specs. Last updated December 2025.
- **Supports/Contradicts:** eBay price is $399, $10 higher than the manufacturer direct price of $389. This is typical eBay markup. Confirms the product exists and is actively sold.

### Source 4: PicClick / eBay Historical
- **URL:** https://picclick.com/Sonic-Imagery-Labs-898B-Active-Balanced-Unbalanced-Line-251341933874.html
- **Type:** Price aggregator
- **Evidence:** Shows $429.00 price point.
- **Supports/Contradicts:** Higher price, likely older listing or different markup period. Does not match $389 claim.

### Source 5: Audio University — Consumer vs Professional Levels
- **URL:** https://audiouniversityonline.com/consumer-vs-professional-audio-levels-what-is-the-difference/
- **Type:** Technical reference
- **Evidence:** The difference between -10 dBV (0.316 Vrms) and +4 dBu (1.228 Vrms) is 11.78 dB, commonly rounded to 12 dB. This is a fixed mathematical relationship.
- **Supports/Contradicts:** Supports the "+12 dB gain" characterization. The 898B's "approximately 14 dB" claim on their product page is slightly overstated vs the mathematical reality of the -10 dBV to +4 dBu conversion, OR the 898B adds ~2 dB of additional gain beyond the standard level shift. The voltage chain in the POR docs (0.9 Vrms in -> 3.6 Vrms out) implies a ratio of 4.0x = +12.04 dB, consistent with +12 dB.

### Source 6: ASR Forum — Sonic Imagery Labs Discrete OpAmp Review
- **URL:** https://audiosciencereview.com/forum/index.php?threads/discrete-opamp-review-sonic-imagery-vs-sparkos.10325/
- **Type:** Measurement / Review (independent)
- **Evidence:** Reviews the Sonic Imagery 990ENH discrete op-amp (not the 898B). Found lower distortion than Sparkos SS2590 but noted "fair bit of channel inconsistency with respect to THD+N." The reviewer found both discrete op-amps underperformed the original integrated circuit in the tested application.
- **Supports/Contradicts:** Does not directly address the 898B. Suggests Sonic Imagery Labs makes competent discrete analog products, but with some part-to-part variation. This is relevant context for the 898B's active circuitry quality.

### Source 7: diyAudio — Sonic Imagery Labs Discussion
- **URL:** https://www.diyaudio.com/community/threads/burson-audio-gen-iv-vs-sonicimagerylabs-994enh-ticha-dual-discrete-opamp.263729/
- **Type:** Community forum
- **Evidence:** Discussion of SIL discrete op-amps. Users report good results. No discussion of the 898B specifically.
- **Supports/Contradicts:** General positive reputation for the company in DIY audio circles. No 898B-specific data.

## Bidirectional Search

- **Searched FOR:** "Sonic Imagery Labs 898B specifications," "Sonic Imagery Labs 898B price buy," "Sonic Imagery Labs 898B review measurements"
- **Searched AGAINST:** "Sonic Imagery 898B problems noise issues complaints," "Sonic Imagery Labs quality reliability," "Sonic Imagery Labs" 898 diyAudio OR "audio science review" OR head-fi
- **Contradicting evidence found:** No complaints, problems, or negative reviews found for the 898B specifically. However, the adversarial search was limited by the product's niche market — very few independent reviews or measurements of the 898B exist anywhere. The ASR review of SIL's discrete op-amps (different product) noted part-to-part variation, which is a minor concern but not a defect.

## Cross-Reference

**Agreement across sources:**
- Channel count (8-ch unbal-to-bal) — confirmed by manufacturer, all retailers
- I/O types (RCA in, XLR out) — confirmed by manufacturer, all retailers
- Price ($389 from manufacturer direct) — confirmed by ordering page; eBay is $399-$429 (markup)
- Bidirectional capability (also does bal-to-unbal) — confirmed; the claim omits this feature but doesn't contradict it

**Disagreement / ambiguity:**
- **Gain figure:** The official product page says "approximately 14 dB level shift." The standard -10 dBV to +4 dBu conversion is 11.78 dB (~12 dB). The POR voltage chain math (0.9 Vrms -> 3.6 Vrms = +12.04 dB) is consistent with +12 dB. The "14 dB" on the official page may account for slightly different reference levels or rounding. The "+12 dB" in the claim is the correct figure for the standard level conversion and matches the voltage chain math.

**Source independence:**
- The manufacturer page and ordering page are from the same entity (sonicimagerylabs.com)
- eBay/Amazon listings are from the manufacturer's own store accounts, not truly independent
- No independent measurements of the 898B exist (no ASR review, no audioXpress test)
- The -10 dBV to +4 dBu = ~12 dB figure is independently verifiable mathematics

## Verdict

**LIKELY**

The claim is largely accurate but cannot be fully CONFIRMED due to:

1. **Gain:** The claim says "+12 dB" which matches the standard -10 dBV to +4 dBu conversion (11.78 dB) and the project's own voltage chain math (0.9 -> 3.6 Vrms = +12.04 dB). However, the manufacturer's own product page says "approximately 14 dB." This discrepancy is minor and likely a rounding/reference issue on SIL's part, but it introduces ambiguity.

2. **Price:** $389 is confirmed on the manufacturer's ordering page. Correct as of 2026-03-20.

3. **Channel count, I/O:** Fully confirmed — 8-ch, RCA in, XLR out.

4. **No independent measurements exist** for the 898B. All performance claims come from the manufacturer. The product has essentially zero independent review coverage.

## Caveats

- **No independent measurements.** The 898B has never been reviewed or measured by ASR, audioXpress, or any independent testing entity. All THD/noise specs are manufacturer claims only.
- **Niche product with minimal market presence.** Very few users discuss this product online. The absence of complaints could mean it works well, or simply that very few people own one.
- **eBay price varies.** The $389 price is manufacturer direct; eBay and Amazon listings from SIL's own accounts may be $399-$429.
- **Gain clarified by creator (2026-03-21):** Unbal-to-bal at 0.9 gain setting = 11.79 dB, yielding 3.5 Vrms output. This matches the standard -10 dBV to +4 dBu math (11.78 dB). The "~14 dB" on the product page likely refers to a different gain setting or is imprecise marketing copy.
- **The 898B is bidirectional** — it also provides 8 channels of balanced-to-unbalanced conversion simultaneously. The claim omits this but doesn't contradict it.

## Official Documentation (added 2026-03-21)

### Source: 898B Datasheet Rev 0 (1.23.2013)
- **URL:** https://www.sonicimagerylabs.com/products/product_images_docs/898B_Docs/898B_Datasheet_Rev0.pdf

**Unbalanced-to-Balanced (-10 dBV → +4 dBu) specs:**
| Parameter | Value |
|-----------|-------|
| Nominal input | -10 dBV (0.316 Vrms) |
| Channel accuracy | ±1% (0.08 dB) |
| Bandwidth | DC–165 kHz ±0.2 dB, 200 kHz –3 dB |
| THD+N @ 1 kHz, 600Ω | 0.0006% (Vo=10 Vrms) |
| Noise floor (22 Hz–20 kHz) | better than –101 dBu |
| Headroom (THD+N <1%) | +22.3 dBu (28.5 Vpp, 10.1 Vrms) |
| Output DC offset (600Ω) | ±4 mV typical |
| Input impedance | 10 kΩ |
| Output impedance | 50Ω |

**Balanced-to-Unbalanced (+4 dBu → –10 dBV) specs:**
| Parameter | Value |
|-----------|-------|
| Nominal input | +4 dBu (1.228 Vrms) |
| Channel accuracy | ±1% (0.08 dB) |
| Bandwidth | DC–165 kHz ±0.2 dB, 200 kHz –3 dB |
| CMRR (60 Hz, Vcm ±46.5V, Rs 50Ω) | >90 dB |
| THD+N @ 1 kHz, 600Ω | 0.0006% (Vo=2 Vrms) |
| Noise floor (22 Hz–20 kHz) | –107 dBu |
| Headroom (THD+N <1%) | +22.3 dBu (28.5 Vpp, 10.1 Vrms) |
| Output DC offset (10 kΩ) | ±1 mV typical |
| Input impedance | 24 kΩ differential, 18 kΩ common mode |
| Output impedance | 100Ω |

**Block diagram signal path (from datasheet):**
- Unbal→Bal: RCA input → Low Noise Preamp (+5.8 dB) → Balanced Line Driver (+6 dB) → XLR output
- Bal→Unbal: XLR input → Precision Differential Line Receiver (–6 dB) → Line Driver (–5.8 dB) → RCA output

**General:**
- AC input: 100–240 VAC, 50–60 Hz (user selectable)
- Max output: +23 dBu, can drive 300Ω loads
- DC coupled throughout (no interstage capacitors)
- XLR wiring: pin 2 hot (+), pin 3 cold (–), per IEC 268-12
- Physical: 1U rack, 19"W × 1.75"H × 4.8"D, 4 lb 9 oz
- 3-year warranty

### Source: 898B Operations Manual Rev 0 (12.30.2012)
- **URL:** https://www.sonicimagerylabs.com/products/product_images_docs/898B_Docs/898B_OpsManual_Rev0.pdf
- 12-page manual covering safety, line voltage selection, front/rear panel connections, block diagram, and Pin 1 termination options
- Front panel: 8× RCA unbalanced inputs, 2× XLR balanced input banks (ch 1-4, ch 5-8), Pin 1/shield termination switches
- Rear panel: 8× RCA unbalanced outputs, 2× XLR balanced output banks, Pin 1 termination switch, AC mains fuse, voltage select
- Pin 1 options: AGND / Open / Chassis (front and rear independently)

### Creator-Confirmed Gain (2026-03-21)
- **Source:** Direct communication from Sonic Imagery Labs creator
- **Claim:** At 0.9 gain setting, unbal-to-bal conversion yields **11.79 dB gain → 3.5 Vrms output**
- **Math check:** 0.316 Vrms × 10^(11.79/20) = 0.316 × 3.884 = 1.227 Vrms... this doesn't match 3.5 Vrms from 0.316 Vrms input
- **Alternate interpretation:** If input is 0.9 Vrms (Denon AVR pre-out level, not –10 dBV reference), then: 0.9 × 10^(11.79/20) = 0.9 × 3.884 = 3.50 Vrms. **This checks out.**
- **Significance for theater project:** Denon AVR-X6800H pre-out at 0.9 Vrms → 898B → 3.5 Vrms balanced to ICEpower 1200AS2. This is the actual signal chain gain, not the –10 dBV reference level conversion.
