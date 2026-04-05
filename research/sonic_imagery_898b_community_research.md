# Sonic Imagery Labs 898B — Community Research & Forum Survey

**Date:** 2026-03-20
**Status:** RESEARCH — Not adopted
**Purpose:** Evaluate the 898B as a gain stage between ADAU1701 DAC output (~0.9 Vrms) and ICEpower 1200AS2 amplifiers for subwoofer duty.

## Executive Summary

The Sonic Imagery Labs 898B is effectively **invisible on audio forums**. Despite searching diyAudio, AVS Forum, AudioScienceReview, Head-Fi, Reddit, and Gearspace, **zero user experience reports, independent measurements, or community discussions about the 898B were found**. The product exists in a vacuum of independent validation — all performance claims come exclusively from the manufacturer.

This is not necessarily damning (it's a niche 8-channel studio utility, not a headphone amp), but it means any purchase is based entirely on manufacturer specs and the general reputation of Sonic Imagery Labs' other products.

## Forum Search Results

| Forum | 898B Discussions Found | Related SIL Product Discussions |
|-------|----------------------|-------------------------------|
| diyAudio | **0** | Yes — 990ENH, 994ENH-Ticha, 995FET op-amps |
| AudioScienceReview | **0** | Yes — 990ENH discrete op-amp review (with measurements) |
| AVS Forum | **0** | One mention of 990ENH in a Nord amplifier listing |
| Head-Fi | **0** | Yes — 994ENH-Ticha, 992ENH-Ticha op-amp rolling |
| Reddit (r/diyaudio, r/diysound) | **0** | None found |
| Gearspace | **0** | None found |
| Amazon reviews | **0 reviews** | Product page exists, no customer reviews |
| eBay feedback | **~4 ratings** | Generic shipping feedback only ("well packed, fast shipping") |

## Manufacturer Specs (898B)

Source: [sonicimagerylabs.com/products/Model898B.html](https://www.sonicimagerylabs.com/products/Model898B.html)

### Unbalanced-to-Balanced Direction (our use case)
| Parameter | Spec |
|-----------|------|
| Input level | -10 dBV (0.316 Vrms nominal) |
| THD+N @ 1 kHz, 600 ohm load | 0.0006% |
| Noise floor (22 Hz–20 kHz) | Better than -101 dBu |
| Max output | +22.3 dBu @ <1% THD+N |
| Bandwidth | DC–165 kHz +/-0.2 dB, 200 kHz -3 dB |
| Input impedance | 10 kohm |
| Output impedance | 50 ohm |
| DC offset | +/-4 mV typical |
| Gain | "Approximately 14 dB" (manufacturer claim) |

### Balanced-to-Unbalanced Direction
| Parameter | Spec |
|-----------|------|
| THD+N @ 1 kHz | 0.0006% |
| Noise floor (22 Hz–20 kHz) | -107 dBu |
| CMRR (Vcm +/-46.5V) | Better than 90 dB @ 60 Hz |
| Input impedance | 24 kohm differential, 18 kohm common mode |
| Output impedance | 100 ohm |
| DC offset | +/-1 mV typical |

### Physical / Other
- 8 channels each direction, simultaneous bidirectional
- RCA (unbalanced), XLR3-1 (balanced)
- 1U rack mount: 1.75"H x 19"W x 4.8"D, 4 lbs 9 oz
- Power: 100–240 VAC, 50/60 Hz (user selectable)
- Active circuitry (no transformers)
- Price: **$389** direct, $399–$429 eBay/Amazon
- 3-year warranty, 30-day satisfaction guarantee

### 898A vs 898B
The 898A is discontinued, replaced by the 898B. The 898A had slightly better THD (0.0005%) and higher max output (+25 dBu) per its spec page, but the 898B is the only version currently sold.

## Gain Analysis for Our Application

### The Gain Discrepancy
The manufacturer says "approximately 14 dB." The standard -10 dBV to +4 dBu conversion is 11.78 dB. Our voltage chain math (0.9 Vrms -> 3.6 Vrms) yields +12.04 dB. The "14 dB" may account for a slightly different internal reference or may be rounding/marketing. **This needs to be measured after purchase.**

### Signal Chain Math
- ADAU1701 DAC output: ~0.9 Vrms (confirmed in verify_adau1701_dac_voltage.md)
- ICEpower 1200AS2 voltage gain: 25.8 dB (per datasheet)
- ICEpower 1200AS2 input: single-ended, via JST 6-pin connector
- Full power @ 4 ohm (1200W) requires ~3.1 Vrms input (calculated from 25.8 dB gain and 69.3 Vrms output)
- Full power @ 8 ohm (600W) requires ~3.6 Vrms input

If the 898B provides +12 dB gain: 0.9 Vrms * 10^(12/20) = **3.58 Vrms** — sufficient for full power @ 8 ohm.
If it provides +14 dB gain: 0.9 Vrms * 10^(14/20) = **4.51 Vrms** — more than sufficient.

Either way, the 898B gets us into the right ballpark. The exact gain should be verified with measurement.

### Noise Budget
- 898B noise floor: -101 dBu (unbal-to-bal direction)
- -101 dBu = 6.9 uVrms
- ICEpower 1200AS2 output noise: 30 uVrms A-weighted
- The 898B noise floor is ~13 dB below the amplifier's own noise floor
- **Verdict: The 898B should not be the dominant noise source in this chain.**

## Alternatives Investigated

### 1. Ebtech LLS-8 (~$200–$250)
- **Passive** (transformer-based) — no active electronics, no power required
- 8 channels -10 dBV to +4 dBu
- Also eliminates ground loops (built-in Hum Eliminator)
- Frequency response: 20 Hz–70 kHz +/-0.5 dB
- THD: 0.005% @ 1 kHz (8x worse than 898B, but irrelevant for subwoofer duty)
- Sound on Sound review: "input and output signals sound identical"
- **Pro:** Half the price, passive reliability, ground loop isolation
- **Con:** Passive — limited drive capability for long cables or low-impedance loads; no gain adjustment; narrower bandwidth (irrelevant for subs)

### 2. DIY THAT1646 / DRV134 Board (~$50–$100 for 8 channels)
- Purpose-built balanced line driver ICs
- THAT1646: +6 dB gain, DC-servoed, no electrolytics in signal path
- DRV134: Similar pinout to THAT1646, well-documented
- Can be built on protoboard — "use 4 stereo boards and it's done"
- Key concern: power supply crosstalk between channels; needs careful PSU decoupling
- **Pro:** Cheapest option, customizable gain, well-understood circuits
- **Con:** Build time, PSU design matters, no enclosure/warranty

### 3. DIY OPA1612 Differential Output Stage (~$30–$80)
- Audiophile-grade op-amp used in many commercial DAC output stages
- Can provide buffer + gain + balanced conversion
- Commonly paired with ADAU1701 in DSP projects
- **Pro:** Lowest noise option, can be integrated directly into DSP board
- **Con:** Requires PCB design, not a drop-in rack solution

### 4. Tube Buffer (PS Audio / DIY Koifarm style)
- Some 1200AS2 builders add a tube input buffer for "warmth"
- PS Audio uses this approach in their commercial ICEpower amps
- **Pro:** Flavor
- **Con:** Completely wrong for subwoofer duty — adds distortion, complexity, cost, tube maintenance

## Key Findings

### What We Know
1. The 898B specs are good on paper — low noise, low distortion, adequate gain, proper I/O
2. Sonic Imagery Labs has a generally positive reputation in DIY audio circles for their discrete op-amps
3. The company is small/niche — one-man operation based in the Bay Area (contact: nerdman@ix.netcom.com)
4. The ASR review of SIL's 990ENH op-amp found good but not exceptional performance, with "a fair bit of channel inconsistency with respect to THD+N"
5. The 898B solves the right problem: 8-channel unbal-to-bal with gain, in 1U rack

### What We Don't Know
1. **No independent measurements of the 898B exist anywhere** — THD, noise, gain are all manufacturer claims
2. **No user experience reports** — we cannot confirm reliability, build quality, or real-world performance
3. **Actual gain** — manufacturer says "~14 dB" but standard conversion is ~12 dB; needs measurement
4. **Channel matching** — the ASR review of SIL's op-amps found channel inconsistency; unknown if 898B has similar issues
5. **Long-term reliability** — no failure reports (could be zero failures or zero users reporting)

### Risk Assessment
- **Functional risk: LOW** — the product does exactly what it claims (level shifting), which is simple analog electronics. Hard to get wrong.
- **Performance risk: LOW-MEDIUM** — specs are good enough for subwoofer duty even if real-world is 2-3x worse than claimed.
- **Value risk: MEDIUM** — $389 for what is essentially 8x op-amp gain stages is expensive. A DIY THAT1646 board would cost $50-100.
- **Validation risk: HIGH** — zero independent verification of any kind. You're trusting the manufacturer entirely.

## Recommendation

For **subwoofer duty** specifically (bandwidth limited to <120 Hz), the 898B is overkill on paper. The THD and noise specs are far better than needed. The real question is whether $389 is worth avoiding a DIY build.

**If you value plug-and-play:** The 898B is the only commercial 8-channel active level shifter available. The Ebtech LLS-8 is the passive alternative at ~$200 less. Both solve the problem.

**If you want to minimize cost:** A DIY THAT1646 or DRV134 board for 8 channels would cost $50-100 in parts and a weekend of build time.

**If you want maximum confidence:** The Ebtech LLS-8 has actual independent reviews (Sound on Sound) and widespread studio use. The 898B has zero independent validation.

## Bidirectional Search

- **Searched FOR:** "Sonic Imagery Labs 898B review," "898B experience," "898B measurements," "898B balanced converter," "898B user feedback," manufacturer specs, Amazon/eBay listings, SIL product pages
- **Searched AGAINST:** "Sonic Imagery 898B problems noise issues complaints," "Sonic Imagery Labs quality reliability," "898B failure," "898B distortion," "898B noise," adversarial searches on diyAudio, ASR, Head-Fi, AVS Forum, Reddit, Gearspace
- **Contradicting evidence found:** No — but critically, no confirming user evidence was found either. The complete absence of community discussion is itself a finding. The only semi-negative data point is the ASR review of the 990ENH op-amp (different product) showing channel-to-channel THD variation.

## Sources

- [Sonic Imagery Labs 898B Product Page](https://www.sonicimagerylabs.com/products/Model898B.html)
- [Sonic Imagery Labs 898A Product Page](https://www.sonicimagerylabs.com/products/Model898A.html)
- [Sonic Imagery Labs Ordering](https://www.sonicimagerylabs.com/ordering.htm)
- [ASR: Discrete OpAmp Review — Sonic Imagery vs Sparkos](https://audiosciencereview.com/forum/index.php?threads/discrete-opamp-review-sonic-imagery-vs-sparkos.10325/)
- [diyAudio: Burson vs SIL 994ENH-Ticha](https://www.diyaudio.com/community/threads/burson-audio-gen-iv-vs-sonicimagerylabs-994enh-ticha-dual-discrete-opamp.263729/)
- [diyAudio: Multichannel unbal-to-bal circuit](https://www.diyaudio.com/community/threads/multichannel-8-low-noise-unbalanced-to-balanced-circuit-example.431953/)
- [diyAudio: DIY input stage for Class D](https://www.diyaudio.com/community/threads/diy-add-on-input-stage-for-class-d-module.363933/)
- [diyAudio: Wiring ICEedge 1200AS2](https://www.diyaudio.com/community/threads/wiring-up-the-iceedge-1200as2-board.343451/)
- [Sound on Sound: Ebtech LLS-2/LLS-8 Review](https://www.soundonsound.com/reviews/ebtech-lls2-lls8-he2-he8)
- [Amazon: Sonic Imagery Labs 898B](https://www.amazon.com/Sonic-Imagery-Labs-898B-Interface/dp/B07HLTP9M8)
- [THAT1646 Balanced Driver Project](https://theslowdiyer.wordpress.com/2016/03/19/project-files-a-bal-driver-with-the-that1646/)
- [Audio Workshop: DRV134 Unbal-to-Bal Converter](https://blog.audioworkshop.org/unbalanced-to-balanced-converter-for-audio-with-drv134/)
