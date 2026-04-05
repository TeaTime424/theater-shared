# Forum Investigation: Sonic Imagery Labs & Model 898B

**Date:** 2026-03-20
**Status:** RESEARCH -- Not adopted
**Purpose:** Adversarial investigation of Sonic Imagery Labs company reputation and 898B product viability for ADAU1701 DAC -> ICEpower 1200AS2 subwoofer signal chain

---

## Executive Summary

The 898B is a real product from a real company (est. 1988, Castro Valley, CA), but it exists in an information vacuum. **Zero independent reviews or measurements of the 898B exist anywhere on the internet.** The company's discrete op-amps (990ENH, 994ENH, 252AP) have modest but genuine forum presence across Head-Fi, diyAudio, ASR, Gearspace, and Dagogo. The op-amps receive generally positive but not universally enthusiastic reviews. The 898B itself has essentially no user discussion -- only retail listings.

For $389, you are buying on faith in the company's op-amp reputation. A DIY THAT1646-based solution would cost ~$50-80 for 8 channels and would be measurable before deployment.

---

## PRO: Reasons to Buy

### 1. Legitimate Long-Running Company
- Founded **1988** per their website, Castro Valley, CA
- PO Box 20494, Castro Valley, CA 94546; phone 510-728-1146
- AES and NAMM member
- **eBay seller since ~2013+, 4,982 feedback, 100% positive, 6.9K items sold**
- Sells on eBay, Amazon, Reverb -- all under their own name
- Source: [sonicimagerylabs.com](https://www.sonicimagerylabs.com/), [eBay Store](https://www.ebay.com/str/sonicimagerylabs)

### 2. Op-Amps Have Real Forum Presence
- **ASR (Amir):** Measured 990ENH in Nord amplifier. Lower THD than Sparkos SS2590. Noted "differences are very small regardless." [ASR Thread](https://www.audiosciencereview.com/forum/index.php?threads/discrete-opamp-review-sonic-imagery-vs-sparkos.10325/)
- **Head-Fi (Alcophone):** 994ENH-Ticha won op-amp rolling comparison in Gustard H20. Called it "wonderfully seductive and engaging" with "beautifully three dimensional sound stage." Selected as permanent upgrade over Sparkos SS3602. [Head-Fi Review](https://www.head-fi.org/showcase/opamp-rolling-with-the-gustard-h20.23639/)
- **Gearspace:** 252AP included in API 1608 blind listening test. Described as "very balanced and accurate, fairly warm" but with "fair loss of detail on reverbs" and "a little bit sterile." [Gearspace Thread](https://gearspace.com/board/high-end/1328696-api-1608-mix-buss-opamp-comparison-2520-990c-252ap-gar-2520-red-dot-rogue-5-vf600-sparkos.html)
- **Dagogo (Doug Schroeder):** Listed SIL products in discrete op-amp roundup but notably **did not receive a response from SIL** for the review and provided no listening impressions. [Dagogo Article](https://www.dagogo.com/audio-blast-return-discrete-opamp-roller/)
- **diyAudio:** Multiple threads discussing SIL op-amps, generally positive. Users on the for-sale section list them as desirable upgrades.

### 3. eBay Feedback is Genuinely Positive
- Buyers mention "Richard" by first name as responsive and helpful
- "First class experience," "fantastic communication," "great advice"
- "Shipped promptly, answered questions immediately"
- 5 units of the 898B specifically have sold on eBay
- Source: [eBay listing](https://www.ebay.com/itm/251341933874)

### 4. Specs are Reasonable (Not Outlandish)
- THD+N 0.0006% at 1 kHz -- good but not suspiciously good
- Noise floor -101 to -107 dBu -- reasonable for active electronics
- Bandwidth DC-200 kHz -- typical for a well-designed active stage
- Max output +23 dBu -- adequate headroom
- CMRR >90 dB at 60 Hz -- competent
- 50 ohm output impedance (unbal-to-bal direction) -- can drive long cables
- Source: [898B Product Page](https://www.sonicimagerylabs.com/products/Model898B.html)

### 5. Solves a Real Problem Cleanly
- 8 channels in 1U rack -- matches the 5 ICEpower 1200AS2 amps (which have balanced inputs)
- No transformer coloration (active circuit)
- Provides the ~12 dB gain needed to bridge -10 dBV consumer to +4 dBu pro levels
- Bidirectional (8 unbal-to-bal + 8 bal-to-unbal simultaneously) -- future flexibility
- 100-240V universal power supply

---

## CON: Reasons NOT to Buy

### 1. ZERO Independent Measurements of the 898B
This is the single biggest red flag. Despite being listed on Amazon, eBay, and Reverb for years:
- **No ASR review or measurement** exists
- **No audioXpress, Stereophile, or any publication** has tested it
- **No diyAudio thread** discusses it
- **No Reddit thread** discusses it
- **No Head-Fi thread** discusses it
- **No Gearspace thread** discusses it
- **No AVS Forum thread** discusses it
- All performance specs are manufacturer claims only
- The 5 eBay sales over years suggest extremely low volume

### 2. Company Owner is Anonymous
- The website does not name the founder, engineer, or owner
- eBay feedback mentions "Richard" (first name only)
- No LinkedIn, no professional profile, no conference presentations found
- No published papers or technical articles by the designer
- Contrast with competitors: Sparkos Labs (Andrew Sparks, named, active on forums), Burson (named team), THAT Corporation (engineers publish)

### 3. ASR Measurements of Op-Amps Were Not Impressive
- Amir's ASR review of the 990ENH found it **underperformed the stock OPA1612A** IC in the Nord amplifier
- Noted "fair bit of channel inconsistency with respect to THD+N" (part-to-part variation)
- Conclusion: "differences are very small" -- damning with faint praise
- The discrete op-amps are positioned as upgrades but measured worse than a $2 IC
- Source: [ASR Thread](https://www.audiosciencereview.com/forum/index.php?threads/discrete-opamp-review-sonic-imagery-vs-sparkos.10325/)

### 4. Gearspace Blind Test: "Sterile" with Detail Loss
- In the API 1608 op-amp comparison, the 252AP showed "fair loss of detail on reverbs, top end/transient loss" and was described as "a little bit sterile"
- Not a ringing endorsement for an analog stage that's supposed to be transparent
- Source: [Gearspace Thread](https://gearspace.com/board/high-end/1328696-api-1608-mix-buss-opamp-comparison-2520-990c-252ap-gar-2520-red-dot-rogue-5-vf600-sparkos.html)

### 5. $389 is Expensive for What It Is
- The core function (unbal-to-bal with ~12 dB gain) can be done with:
  - **THAT1646 + THAT1246 ICs:** ~$3-5 per channel in parts. 8 channels DIY = ~$50-80 total
  - **ART CleanBox Pro:** $70/pair (2 channels), so $280 for 8 channels (4 units)
  - **SparkFun THAT1646 OutSmarts breakout boards:** $10 each, 8 = $80 + power supply
  - **DIY on veroboard:** Forum consensus is this is trivially easy with THAT ICs
- The 898B's value proposition is convenience (1U, 8ch, done) + active design + brand reputation
- For subwoofer duty below 200 Hz, transformer coloration and bandwidth are irrelevant -- even a passive transformer solution would work

### 6. Product Appears Low Volume / Possibly Built-to-Order
- Only 5 sold on eBay over years of listing
- No dealer network listed (resellers page exists but content unknown)
- Amazon listing exists but reviews are essentially zero (4 seller feedbacks total)
- This is a micro-niche product from what appears to be a one-person operation

### 7. Dagogo Reviewer Got No Response
- Doug Schroeder (Dagogo) contacted SIL for their discrete op-amp review and **never heard back**
- While not damning by itself, it suggests limited bandwidth for customer/press relations
- Source: [Dagogo Article](https://www.dagogo.com/audio-blast-return-discrete-opamp-roller/)

### 8. The 898B's Internal Circuit is a Black Box
- "Precision Analog Line Receivers" and "Precision Balanced Line Drivers" -- no part numbers given
- "Does not use transformers" and "active circuitry" -- no topology disclosed
- Could be THAT ICs, could be discrete, could be NE5532s -- no way to know without opening one
- No schematic published, no service manual
- For $389, you can't verify what you're buying

---

## Alternatives Identified

| Product | Channels | Price | Gain | Notes |
|---------|----------|-------|------|-------|
| **Sonic Imagery 898B** | 8 unbal-to-bal + 8 bal-to-unbal | $389 (direct) / $399 (eBay) | ~12-14 dB | Active, 1U rack, no measurements exist |
| **ART CleanBox Pro** (x4) | 2 per unit | ~$280 for 8ch | Adjustable to +26 dB | Transformer-based, measured on ASR, widely used. diyAudio notes low-freq rolloff mod needed for sub duty |
| **DIY THAT1646 boards** | 8 (build yourself) | ~$50-80 | +6 dB (native) | Trivially simple circuit, measurable, but +6 dB may be insufficient (need 0.9V -> 3.5V = +11.8 dB) |
| **DIY THAT1646 + gain stage** | 8 | ~$80-120 | Configurable | Add op-amp gain stage before THAT1646 to hit target voltage |
| **Rolls MB15 ProMatch** | 8 | ~$100 | +10 dB adjustable | Basic, but cheap and 8-channel |

### Voltage Chain Concern
The ADAU1701 DAC outputs ~0.9 Vrms. The ICEpower 1200AS2 needs 3.5 Vrms for full power. That's a gain requirement of 3.89x = +11.8 dB. The THAT1646 only provides +6 dB natively (0.9V -> 1.8V), which is insufficient. You'd need an additional ~6 dB gain stage, or a different approach entirely.

The 898B's ~12-14 dB gain lands right in the target zone, which is its key advantage -- it's the right amount of gain for this specific application without needing additional stages.

---

## Forum Coverage Summary by Platform

| Forum | 898B Discussion | SIL Op-Amp Discussion | Tone |
|-------|----------------|----------------------|------|
| **diyAudio** | None | Multiple threads (990ENH, 994ENH, 995FET) | Generally positive |
| **ASR** | None | One measured review (990ENH) | Neutral/lukewarm -- measured worse than stock IC |
| **Head-Fi** | None | Multiple threads (994ENH op-amp rolling) | Positive -- won Gustard H20 comparison |
| **Gearspace** | None | API 1608 blind test (252AP) | Mixed -- "balanced/accurate" but "sterile" |
| **Dagogo** | None | Listed but not reviewed (no response from SIL) | N/A |
| **Reddit** | None found | None found | N/A |
| **AVS Forum** | None found | None found | N/A |
| **GroupDIY** | None | THAT IC discussions mention SIL in passing | Neutral |

---

## Bidirectional Search

- **Searched FOR:** "Sonic Imagery Labs 898B review," "Sonic Imagery Labs reputation," "Sonic Imagery 898B user experience," "Sonic Imagery Labs 990ENH measurements," SIL op-amp forum discussions across diyAudio/ASR/Head-Fi/Gearspace/Dagogo, eBay seller feedback, Amazon reviews
- **Searched AGAINST:** "Sonic Imagery Labs problems complaints scam," "Sonic Imagery overpriced," "Sonic Imagery don't buy," "898B" + every major audio forum, adversarial search for negative reviews/experiences, searched for alternatives and DIY cost comparisons
- **Contradicting evidence found:** Yes --
  1. ASR measurements showed 990ENH underperformed stock OPA1612A IC
  2. Gearspace blind test found 252AP "sterile" with detail loss
  3. Dagogo reviewer got no response from SIL
  4. Part-to-part THD+N variation noted by ASR
  5. DIY alternative (THAT1646) costs ~10-20% of the 898B price

---

## Verdict

**The 898B is probably fine, but buying it requires faith rather than evidence.**

The company is real, has been around since 1988, has thousands of positive eBay transactions, and makes products that are discussed (if not universally praised) in the DIY audio community. The 898B's specs are plausible and the gain lands perfectly for the ADAU1701-to-ICEpower application.

However: no one outside the company has ever measured one, the internal circuit is undisclosed, and $389 is a premium price for what could be $50-80 in THAT Corporation ICs on a board. The absence of negative reviews is more likely due to obscurity than excellence.

**Recommendation:** If you value "buy it and it works, 1U, done" and $389 isn't painful, it's a defensible choice. If you want verified performance and cost efficiency, build 8 channels of THAT1646 + a simple gain stage for ~$100 and measure it with REW before deployment. For subwoofer duty below 200 Hz, even a $280 stack of ART CleanBox Pros would be overkill on quality.
