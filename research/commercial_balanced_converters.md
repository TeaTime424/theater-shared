# Commercial Unbalanced-to-Balanced Converters with Gain

**Status:** RESEARCH -- Product survey for ADAU1701 DAC -> ICEpower 1200AS2 signal chain
**Date:** 2026-03-20

---

## Requirements Summary

| Parameter | Value |
|-----------|-------|
| **Source** | ADAU1701 DAC, 0.9 Vrms unbalanced RCA |
| **Target** | ICEpower 1200AS2, 3.61 Vrms balanced for full 620W/8 ohm |
| **Gain needed** | +12.1 dB (0.9 Vrms -> 3.61 Vrms) |
| **Minimum useful gain** | +6 dB (0.9 -> 1.8 Vrms = 154W/ch, weapons-grade margin) |
| **Load impedance** | 38 kohm (ICEpower balanced input) |
| **Frequency range** | 5-200 Hz (sub-bass duty) |
| **Channels** | 8 minimum (5x ICEpower 1200AS2, 2 ch each = 10 ch, but 8 subs) |
| **Output** | Balanced (JST connector on ICEpower, wirable from XLR/TRS/bare wire) |

---

## Product Comparison Table

| Product | Ch | Type | Gain (dB) | Freq Response | Output | Price | Price/8ch | Sub-Bass OK? | Available? |
|---------|-----|------|-----------|--------------|--------|-------|-----------|-------------|-----------|
| **Sonic Imagery Labs 898B** | 8 | Active | ~12-14 (fixed, -10dBV to +4dBu) | DC-200kHz | XLR | $389 | $389 | YES (DC-coupled) | Yes (direct/eBay) |
| **Tascam LA-80mkII** | 8 | Active | +/-12 (trim) | 20Hz-100kHz +/-3dB | XLR | ~$300-500 | ~$300-500 | Likely | DISCONTINUED (used only) |
| **Ebtech LLS-8-XLR** | 8 | Passive (transformer) | ~12 (fixed, -10dBV to +4dBu) | 10Hz-40kHz +/-1dB | XLR | ~$200-250 | ~$200-250 | RISKY (transformer saturation at LF) | Yes (Sweetwater/B&H) |
| **RDL FP-UBC6** | 6 | Active | -5 to +10 (adjustable) | 20Hz-40kHz +/-0.25dB | XLR | ~$540 | ~$720 (need 2) | YES | Yes (B&H/Full Compass) |
| **ART CleanBox Pro** | 2 | Active | up to +21 (adjustable) | 20Hz-20kHz +/-1dB | XLR | ~$97 | ~$388 (need 4) | Probably | Yes (Sweetwater/Amazon) |
| **Rolls MB15b ProMatch** | 2 | Active | up to +20 (adjustable) | Not specified | XLR | ~$99 | ~$396 (need 4) | Unknown | Yes (Parts Express) |
| **Sescom SES-ON-THE-LEVEL** | 2 | Active | up to +20 (adjustable) | Not specified | XLR | ~$140 | ~$560 (need 4) | Unknown | Yes (B&H/Amazon) |
| **Earthquake Sound Hum Kleaner** | 2 | Active | up to +24 (XLR) | 20Hz-20kHz +/-2dB | XLR/TRS | ~$100 | ~$400 (need 4) | Probably | Yes (Amazon) |
| **Orchard Audio RCA-to-XLR** | 2 | Active | +8 (fixed) | DC-80kHz+ | XLR | $300 assembled / $150 module | ~$1200/$600 (need 4) | YES (DC-coupled) | Yes (orchardaudio.com) |
| **Orchard Audio bare board** | 2 | Active (DIY) | +8 (adjustable via resistor) | DC-80kHz+ | Wirable | $12-18/board | ~$48-72 (need 4) | YES (DC-coupled) | Yes (orchardaudio.com) |
| **Catherine North 8ch board** | 8 | Active (DIY) | Configurable (1 resistor/ch) | TBD (DRV134-based) | DB25 (wirable) | $200 | $200 | YES (DRV134 = DC-capable) | Yes (built-to-order, 5-7 days) |
| **ARX Balance 8** | 8 | Active | ~14 (-10dBV to +4dBu) | Not specified | XLR | ~$540 EUR | ~$580 USD | Probably | Limited (Australian, import) |
| **Nobsound NS-05P PRO** | 2 | Active | 0 dB (RCA->XLR) | 20Hz-20kHz | XLR | ~$60 | ~$240 (need 4) | NO (no gain) | Yes (Amazon) |
| **Sonifex CM-ULX1** | 2 | Passive (transformer) | +6 (1:2 ratio) | 20Hz-20kHz +/-0.5dB | XLR | ~$260 EUR | ~$1120 (need 4) | RISKY (transformer) | Yes (EU distributors) |

---

## Detailed Product Notes

### Tier 1: Strong Candidates

#### 1. Sonic Imagery Labs Model 898B
- **Manufacturer:** Sonic Imagery Labs (Castro Valley, CA, USA)
- **Price:** $389 direct, ~$399 eBay
- **Channels:** 8 unbal-to-bal + 8 bal-to-unbal (simultaneous)
- **Gain:** Fixed ~12-14 dB (-10dBV to +4dBu conversion)
- **Active/Passive:** Active
- **Output:** 8x XLR-3 (balanced)
- **Input:** 8x RCA (unbalanced)
- **Frequency Response:** DC to 200 kHz (direct-coupled, no transformers)
- **THD+N:** 0.0006% at 1 kHz
- **Noise floor:** -101 to -107 dBu
- **Max output:** +23 dBu
- **Crosstalk:** >-110 dB
- **Form factor:** 1U rackmount, steel enclosure
- **Power:** External supply included
- **Made in USA, hand-assembled**
- **Where to buy:** sonicimagerylabs.com, eBay, Amazon
- **Issues:** Fixed gain -- cannot adjust per-channel. With 0.9V input (not -10dBV = 0.316V), the output would be 0.9V x ~4.0 = ~3.6V, which is almost exactly the 3.61V target. However, the gain is designed for -10dBV input (0.316V), so it may clip with 0.9V input depending on the internal gain structure. MUST VERIFY if 0.9V input is within its operating range (max input likely +23dBu = 11.0V, so 0.9V is fine). The key question is whether the gain is truly fixed at ~4x voltage or if it's a level-referenced conversion.

**Gain calculation for your use case:**
- If gain is fixed at ~4x (12 dB): 0.9V in -> 3.6V out. PERFECT for ICEpower.
- If it's referenced to -10dBV/+4dBu conversion: 0.9V in -> (0.9/0.316) x 1.228 = 3.50V out. Close enough.
- Either way, this lands squarely in the target zone.

**VERDICT: Best commercial off-the-shelf option. Single 1U rack unit, 8 channels, DC-coupled, right gain, in stock.**

#### 2. RDL FP-UBC6
- **Manufacturer:** RDL (Radio Design Labs)
- **Price:** ~$540 per unit
- **Channels:** 6 per unit (need 2 for 8 channels = ~$1,080)
- **Gain:** -5 dB to +10 dB adjustable per channel
- **Active/Passive:** Active
- **Output:** 6x XLR male (balanced)
- **Input:** 6x RCA (unbalanced)
- **Frequency Response:** 20 Hz to 40 kHz +/-0.25 dB
- **THD:** <0.05%; typ 0.01% at 1 kHz
- **Noise:** <-90 dB ref +4 dBu
- **Max headroom:** >18 dB above +4 dBu
- **Input impedance:** 10 kohm
- **Output impedance:** 150 ohm balanced
- **Form factor:** FLAT-PAK (mounts in RDL rack frame or standalone)
- **Power:** External 24VDC supply
- **Where to buy:** B&H, Full Compass, Markertek, Amazon
- **Issues:** +10 dB maximum gain may be tight for 0.9V -> 3.61V (need +12.1 dB). At max gain +10 dB: 0.9V -> 2.84V = 502W, which is 81% power utilization. Very usable but not quite full power. Also, 6 channels per unit means you need 2 units for 8 channels = $1,080.

**VERDICT: Excellent quality, adjustable, proven broadcast product, but expensive for 8ch and max gain slightly short.**

#### 3. Catherine North Electronics 8-Channel Board
- **Manufacturer:** Catherine North Electronics
- **Price:** $200
- **Channels:** 8
- **Gain:** Configurable per-channel via one resistor each
- **Active/Passive:** Active (BurrBrown/TI balanced line drivers, likely DRV134 or OPA1632)
- **Output:** DB25 (bare-wire/custom termination)
- **Input:** Solder pads/through-holes (bare-wire)
- **Frequency Response:** TBD (depends on driver IC used -- if DRV134, then >100 kHz)
- **Form factor:** Bare PCB -- requires enclosure, power supply, connectors
- **Power:** Requires external bipolar supply (+/-V), draws <75mA idle
- **Built to order, 5-7 business days**
- **Where to buy:** catherinenorthelectronics.com
- **Issues:** Bare board -- no enclosure, no connectors, no power supply. Need to source and build all of that. Gain is set by resistor value which must be specified at order time or soldered yourself. Not a turnkey solution, but extremely flexible and cheap.

**VERDICT: Best value if you're comfortable with DIY assembly. $200 for 8 channels with configurable gain.**

---

### Tier 2: Viable but Compromised

#### 4. ART CleanBox Pro
- **Manufacturer:** ART Pro Audio
- **Price:** ~$97
- **Channels:** 2 per unit (need 4 = ~$388)
- **Gain:** Up to +21 dB (adjustable via level control)
- **Active/Passive:** Active
- **Output:** 2x XLR male (balanced)
- **Input:** 2x RCA + 3.5mm stereo
- **Frequency Response:** 20 Hz - 20 kHz +/-1 dB
- **THD:** <0.01% at 1 kHz
- **SNR:** >90 dB
- **Max output:** +21 dBu balanced
- **Input impedance:** Unbalanced 100k ohm
- **Power:** 9V adapter
- **Form factor:** Small box (NOT rackmount)
- **Where to buy:** Sweetwater, Amazon, B&H, Full Compass
- **Issues:** Only 2 channels per box -- need 4 boxes for 8 channels. No rackmount. Plenty of gain headroom (+21 dB). Frequency response spec starts at 20 Hz which may mean rolloff below that -- needs verification for sub-bass duty down to 5 Hz. Low-cost design, potentially noisy.

**VERDICT: Cheap, tons of gain, but 4 separate boxes with 4 wall warts = messy. Frequency response at 5 Hz unverified.**

#### 5. Earthquake Sound Hum Kleaner
- **Manufacturer:** Earthquake Sound
- **Price:** ~$100
- **Channels:** 2 per unit (need 4 = ~$400)
- **Gain:** Up to +24 dB on XLR, up to +18 dB on RCA
- **Active/Passive:** Active
- **Output:** XLR + TRS + RCA (all available)
- **Input:** XLR + TRS + RCA
- **Frequency Response:** 20 Hz - 20 kHz +/-2 dB
- **THD:** <0.0003% at 1 kHz
- **SNR:** 114 dB at full level
- **Max output:** XLR 18V, TRS 18V, RCA 9V
- **Input impedance:** Balanced 20k, Unbalanced 100k
- **Output impedance:** Balanced 100 ohm, Unbalanced 300 ohm
- **Power:** 12V adapter
- **Form factor:** Small box (NOT rackmount)
- **Where to buy:** Amazon, Earthquake Sound direct
- **Issues:** 2 channels/box. The +/-2 dB frequency response tolerance is loose. 20 Hz lower limit -- sub-bass performance below 20 Hz unverified. Not rackmountable.

**VERDICT: Very high gain available, decent THD specs, but loose frequency response tolerance and 20 Hz floor is concerning for sub-bass.**

#### 6. Tascam LA-80mkII
- **Manufacturer:** Tascam
- **Price:** ~$300-500 (used/NOS)
- **Channels:** 8
- **Gain:** +/-12 dB trim per channel, switchable +4dBu/-20dBu reference
- **Active/Passive:** Active
- **Output:** 8x XLR (balanced)
- **Input:** 8x RCA (unbalanced)
- **Frequency Response:** 20 Hz - 100 kHz +/-3 dB
- **Form factor:** 1U rackmount
- **Where to buy:** eBay, Reverb (used only)
- **Issues:** DISCONTINUED in North/Central/South America. Available only used or NOS. The +/-12 dB trim around -10dBV reference should provide enough gain. Frequency response +/-3 dB tolerance is loose. Good unit but supply risk.

**VERDICT: Would be perfect if it were still in production. Used market only -- risky for a 2027 build.**

---

### Tier 3: Unsuitable or Marginal

#### 7. Ebtech LLS-8-XLR
- **Manufacturer:** Morley / Ebtech
- **Price:** ~$200-250
- **Channels:** 8
- **Gain:** ~12 dB (passive transformer, -10dBV to +4dBu)
- **Active/Passive:** PASSIVE (transformer-based)
- **Output:** 8x XLR
- **Input:** 8x 1/4" TRS (NOT RCA -- needs adapters)
- **Frequency Response:** 10 Hz - 40 kHz +/-1 dB
- **Form factor:** 1U rackmount
- **Power:** None required
- **Where to buy:** Sweetwater, B&H, Best Buy, Amazon
- **Issues:**
  - **CRITICAL: Passive transformers saturate at low frequencies with high signal levels.** ASR forum and Sound on Sound explicitly note that cheap transformers "wimp out" at low bass frequencies, and transformer-based converters can show saturation/distortion at sub-bass frequencies (below 50 Hz). For a subwoofer application pushing 5-20 Hz content, this is a serious concern.
  - Input is 1/4" TRS, not RCA -- needs RCA-to-1/4" adapters.
  - No gain adjustment.
  - The "gain" is really just impedance matching, not true voltage amplification.

**VERDICT: DO NOT USE for sub-bass. Transformer saturation at LF will cause distortion exactly where you need it clean. Fine for mid/high frequency level shifting.**

#### 8. Nobsound NS-05P PRO
- **Manufacturer:** Nobsound / Douk Audio
- **Price:** ~$60
- **Channels:** 2
- **Gain:** 0 dB in RCA-to-XLR direction
- **Active/Passive:** Active
- **Issues:** ZERO gain in the direction you need. Only provides gain in XLR-to-RCA direction (+5 dB). Useless for this application.

**VERDICT: REJECTED. No gain in the required direction.**

#### 9. Sonifex CM-ULX1
- **Manufacturer:** Sonifex (UK)
- **Price:** ~$260 EUR per unit (2 channels)
- **Channels:** 2 per unit (need 4 = ~$1,120 EUR / ~$1,200 USD)
- **Gain:** +6 dB (1:2 transformer ratio)
- **Active/Passive:** PASSIVE (transformer)
- **Issues:** Same transformer saturation concerns as Ebtech. Only +6 dB gain (0.9V -> 1.8V). Extremely expensive for passive. Not enough gain. European distribution.

**VERDICT: REJECTED. Passive, insufficient gain, expensive, transformer LF concerns.**

#### 10. ARX Balance 8
- **Manufacturer:** ARX (Australia)
- **Price:** ~$540 EUR (~$580 USD)
- **Channels:** 8
- **Gain:** ~14 dB (-10dBV to +4dBu)
- **Active/Passive:** Active
- **Output:** XLR
- **Issues:** Australian company, limited US distribution. Specifications sparse. Import adds cost and lead time.

**VERDICT: Potentially viable but hard to source in the US, expensive.**

---

### Tier 4: Audiophile/DIY Options

#### 11. Orchard Audio Stereo RCA-to-XLR Converter (assembled)
- **Price:** $300 per unit (2ch), need 4 = $1,200
- **Gain:** +8 dB fixed
- **Freq:** DC to 80kHz+
- **Components:** OPA1612, OPA1632, LT3042/LT3090 LDOs
- **Issues:** +8 dB gain gives 0.9V -> 2.26V = 320W/ch. Not full power but substantial. Expensive for 8 channels. Audiophile-grade overkill for sub-bass.

#### 12. Orchard Audio bare boards (DIY)
- **Price:** $12-18 per board (2ch), need 4 = $48-72 + components + enclosure
- **Gain:** +8 dB stock, adjustable via resistor change
- **Freq:** DC to 80kHz+
- **Issues:** Requires DIY assembly, power supply, enclosure. But gain is adjustable and quality is excellent.

---

## Voltage Output Analysis for Your Use Case

Starting from ADAU1701 DAC at 0.9 Vrms:

| Product | Gain (dB) | Output (Vrms) | ICEpower Power (W/8ohm) | Power Utilization |
|---------|-----------|---------------|------------------------|------------------|
| No converter (SE to bal) | +6 (bal doubling) | 1.8 | 154 | 24.8% |
| Ebtech LLS-8 | ~+12 | ~3.6 | ~620 | ~100% |
| Sonic Imagery 898B | ~+12 | ~3.6 | ~620 | ~100% |
| RDL FP-UBC6 (max +10) | +10 | 2.84 | 502 | 81% |
| ART CleanBox Pro | adjustable | adjustable | adjustable | adjustable |
| Earthquake Hum Kleaner | adjustable | adjustable | adjustable | adjustable |
| Orchard Audio (+8 dB) | +8 | 2.26 | 320 | 51.6% |
| DIY DRV134 (unity bal) | +6 | 1.8 | 154 | 24.8% |
| Catherine North (configurable) | configurable | configurable | configurable | configurable |

**Note:** The Ebtech row assumes no transformer saturation losses at sub-bass frequencies, which is unrealistic. Actual sub-bass output will be lower due to core saturation.

---

## Recommendation Ranking

### For a turnkey commercial solution:
1. **Sonic Imagery Labs 898B** -- $389, 8 channels, DC-coupled, right gain, rack-mount, in stock. Best single-purchase option.
2. **RDL FP-UBC6 x2** -- $1,080, 12 channels (8 needed), adjustable gain, broadcast-grade quality. Expensive but adjustable and proven.
3. **ART CleanBox Pro x4** -- $388, 8 channels, tons of gain headroom. Cheap but messy (4 boxes, 4 wall warts, no rackmount).

### For best value with some DIY:
4. **Catherine North 8ch board** -- $200 + enclosure/PSU/connectors (~$100-150 more). Configurable gain, 8 channels, DRV134-based. Total ~$300-350.
5. **Orchard Audio bare boards x4** -- ~$60-72 + components + enclosure. Excellent quality, DC-coupled, adjustable gain.

### For comparison, the full DIY path from your existing research:
6. **DRV134 x 8 on custom PCB** -- ~$50-80 in components, powered from ICEpower AVDD/AVSS. Lowest cost, most integration, but most labor.

---

## Bidirectional Search

- **Searched FOR:** "unbalanced to balanced converter with gain," "8 channel balanced converter," "-10 dBV to +4 dBu converter," "Sonic Imagery 898B," "Tascam LA-80mkII," "RDL FP-UBC6," "ART CleanBox Pro," "balanced line driver rack," "Ebtech LLS-8," product pages, Sweetwater, B&H, Amazon, Parts Express, manufacturer sites
- **Searched AGAINST:** "Ebtech LLS-8 transformer saturation sub-bass," "passive transformer low frequency saturation," "Sonic Imagery 898B problems," "RDL FP-UBC6 sub-bass problems," "unbalanced balanced converter subwoofer problems audiosciencereview," "Nobsound NS-05P PRO gain RCA to XLR" (confirmed 0 dB -- rejected)
- **Contradicting evidence found:** YES --
  - Ebtech LLS-8 (passive transformer) has documented transformer saturation issues at low frequencies per ASR forum and Sound on Sound reviews. Unsuitable for sub-bass.
  - Nobsound NS-05P PRO provides 0 dB gain in the RCA-to-XLR direction. Unsuitable.
  - Sonifex CM-ULX1 is passive transformer with only +6 dB gain. Insufficient and same LF concerns.
  - Tascam LA-80mkII is discontinued in the Americas. Supply risk for 2027 build.
  - No negative reviews found for Sonic Imagery 898B, but very few independent measurements exist (niche product).
  - ART CleanBox Pro and Earthquake Hum Kleaner frequency response specs start at 20 Hz -- sub-5 Hz performance unverified.

---

## Key Conclusion

**The Sonic Imagery Labs 898B at $389 is the standout commercial option.** It delivers 8 channels of DC-coupled, active conversion with ~12 dB gain in a single 1U rackmount unit -- purpose-built for exactly this use case. The 0.9 Vrms input from the ADAU1701 would produce ~3.6 Vrms balanced output, hitting the ICEpower 1200AS2's full-power sensitivity almost exactly.

The only uncertainty is whether the 898B's fixed gain structure handles a 0.9V input (vs its design point of 0.316V = -10dBV) correctly. At +23 dBu max output capability (~11V), there's massive headroom, so clipping is not a concern. Contact Sonic Imagery Labs to confirm the gain behavior with non-standard input levels before purchasing.

**The DIY DRV134 path from your existing research remains the lowest-cost option** ($50-80 total) with the tightest integration (powered from ICEpower AVDD/AVSS, no external PSU), but requires PCB design and assembly.
