# Subwoofer Amplifier Comparison
## RESOLVED: All-Behringer NX6000D Selected

> **✅ FINAL DECISION - December 2025**
> 
> **Selected Configuration:** All-Behringer NX6000D Unified Platform
> 
> | System | Units | Load | Real Power | Cost |
> |--------|-------|------|------------|------|
> | Primary Subs | 2× NX6000D | 8Ω | ~850W/ch | $1,038 |
> | Nearfield | 4× NX6000D | 8Ω | ~850W/ch | $2,076 |
> | Spares | 2× NX6000D | — | — | $1,038 |
> | Fan Mod | 16× Noctua | — | — | $240 |
> | **Total** | **8 amps** | | | **$4,392** |
> 
> **Why This Was Selected:**
> - Best performance per dollar (+2.8 dB vs NC502MP at lower cost)
> - Unified platform (any amp replaces any other)
> - Spares provide immediate failure recovery
> - 8Ω operation matches both primary and nearfield impedance
> - Total savings vs PURIFI plan: **$2,984**
> 
> See `03_Subwoofer_System.md` for current amplifier specifications.
> This document is retained for historical analysis reference.

---

**Document Purpose:** Evaluate amplifier options for 4× dual-driver sealed subwoofers in reference-level home theater  
**Application:** 8 total drivers (4 subs × 2 drivers each)  
**Driver:** Dayton Audio UMII18-22 (dual 2Ω voice coils)  
**Configuration Analysis Date:** November 23, 2024  
**System Budget Context:** $75,000-95,000 total theater

---

## Executive Summary

### Recommendation: **2× Buckeye NC502MP 4-Channel @ $2,500 total**

**IF verified silent/fanless by Buckeye Amplifiers**

**Rationale:**
- ✅ Identical reference performance (109 dB @ 20Hz at MLP)
- ✅ Saves $2,680 vs PURIFI (52% cost reduction)
- ✅ Partial redundancy (2 subs survive single amp failure)
- ✅ Only 0.8 dB less peak capability (inaudible difference)
- ✅ Better overall system through optimized budget allocation

**Critical Dependency:** Silent cooling verification from Buckeye (contacted Dylan)

---

## Product Specifications

### Option A: 1× Buckeye NC502MP 8-Channel

**Product Link:** https://www.buckeyeamp.com/shop/amplifiers/hypex/nc502mp/8_channel

**Specifications:**
- **Price:** $2,500
- **Channels:** 8
- **Power per channel:** 500W @ 4Ω
- **Total power:** 4,000W (8 × 500W)
- **Rack space:** 2U
- **Topology:** Hypex NCore Class D
- **Configuration:** All 8 drivers on single amplifier

**Driver Wiring:**
- Each UM18-22: Voice coils in series (2Ω + 2Ω = 4Ω per driver)
- Each driver connects to one channel
- 4 subwoofers × 2 drivers = 8 channels total

---

### Option B: 2× Buckeye NC502MP 4-Channel

**Product Link:** https://www.buckeyeamp.com/shop/amplifiers/hypex/nc502mp/4_channel

**Specifications:**
- **Price:** $1,250 each = **$2,500 total**
- **Channels:** 4 per unit (8 total)
- **Power per channel:** 500W @ 4Ω
- **Total power:** 4,000W (8 × 500W)
- **Rack space:** 4U (2U per unit)
- **Topology:** Hypex NCore Class D
- **Configuration:** 2 subs per amplifier (4 drivers each)

**Driver Wiring:** Identical to Option A

**Amplifier Assignment:**
- **Amp 1:** Front left sub (2 drivers) + Front right sub (2 drivers)
- **Amp 2:** Rear left sub (2 drivers) + Rear right sub (2 drivers)

---

### Option C: 4× Buckeye PURIFI 1ET9040BA Monoblocks

**Specifications:**
- **Price:** $1,295 each = **$5,180 total**
- **Channels:** 1 per monoblock (4 total for 4 subs)
- **Power per monoblock:** 1,200W @ 2Ω
- **Total power:** 4,800W (4 × 1,200W)
- **Rack space:** 8U (2U per monoblock)
- **Topology:** PURIFI Eigentakt Class D
- **THD+N:** <0.00007% (state-of-the-art)
- **Damping Factor:** >10,000
- **Cooling:** Fanless (verified)

**Driver Wiring:**
- Each driver: Voice coils in series (4Ω per driver)
- Two drivers per sub wired in parallel (4Ω ∥ 4Ω = 2Ω)
- Each subwoofer presents 2Ω load to monoblock
- Power distribution: 1,200W per sub ÷ 2 drivers = 600W per driver

---

## Direct Comparison Table

| Feature | 1× 8-Channel NC502MP | 2× 4-Channel NC502MP | 4× PURIFI Monoblocks |
|---------|---------------------|---------------------|---------------------|
| **Total Cost** | **$2,500** | **$2,500** | **$5,180** |
| **Savings vs PURIFI** | **$2,680** | **$2,680** | Baseline |
| **Cost per Driver** | $312.50 | $312.50 | $647.50 |
| **Rack Space** | **2U** | 4U | 8U |
| **Power per Driver** | 500W @ 4Ω | 500W @ 4Ω | 600W |
| **Driver Excursion @ 20Hz** | 23.7mm (85% Xmax) | 23.7mm (85% Xmax) | 26mm (93% Xmax) |
| **Reference SPL @ MLP** | 109 dB @ 20Hz | 109 dB @ 20Hz | 109 dB @ 20Hz |
| **Peak Capability @ MLP** | 112.5 dB @ 20Hz | 112.5 dB @ 20Hz | 113.3 dB @ 20Hz |
| **Headroom over Reference** | +3.5 dB | +3.5 dB | +4.3 dB |
| **Headroom over THX (105dB)** | **+7.5 dB** | **+7.5 dB** | **+8.3 dB** |
| **Amplifier Utilization** | 45% at reference | 45% at reference | 38% at reference |
| **THD+N (typical)** | ~0.001-0.003% | ~0.001-0.003% | <0.00007% |
| **Damping Factor** | ~2,000-4,000 | ~2,000-4,000 | >10,000 |
| **Cooling Method** | **Must verify** | **Must verify** | Fanless (verified) |
| **Single Point Failure** | All 4 subs | 2 subs | 1 sub |
| **Redundancy** | None | Partial | Maximum |
| **Thermal Load** | 400W in 2U | 200W per 2U | 60W per 2U |

---

## Performance Analysis

### SPL Capability Calculations

**Reference Level (225W per driver - your design baseline):**

All three options achieve **109 dB @ 20Hz at MLP** at reference level:
- Base sensitivity: 90.7 dB @ 2.83V/1m (Dayton spec)
- Sealed rolloff @ 20Hz: -11.2 dB
- Power gain (225W per driver): +20.5 dB
- Dual drivers per sub: +6 dB
- Corner loading: +12 dB
- Four subs combined: +6 dB
- Distance loss (13 feet): -12 dB
- Room losses: -3 dB
- **Result: 109 dB @ 20Hz at MLP** ✅

**Peak Capability (Maximum Power):**

**NC502MP (500W per driver):**
- Additional power: 500W vs 225W = 2.22× = +3.5 dB
- **Peak: 109 + 3.5 = 112.5 dB @ 20Hz** ✅

**PURIFI (600W per driver):**
- Additional power: 600W vs 225W = 2.67× = +4.3 dB
- **Peak: 109 + 4.3 = 113.3 dB @ 20Hz** ✅

**Difference: 0.8 dB peak capability (below audible threshold)**

---

## Excursion and Safety Analysis

### Driver Mechanical Limits (WinISD Verified)

**UM18-22 Specifications:**
- **Xmax:** 28mm (one-way linear excursion, Klippel verified)
- **Mechanical limit:** 700W reaches 28mm Xmax @ 20Hz
- **Thermal limit:** 1,200W RMS per driver

**At Reference Level (225W per driver):**
- Excursion: ~16-18mm (57-64% of Xmax)
- All options operate identically ✅

**At Peak Power:**

**NC502MP (500W per driver):**
- Excursion: ~23.7mm (85% of Xmax)
- **Safe operation verified** ✅
- Thermal: 42% of rating
- Mechanical: 71% of limit

**PURIFI (600W per driver):**
- Excursion: ~26mm (93% of Xmax)
- **Safe operation verified** ✅
- Thermal: 50% of rating
- Mechanical: 86% of limit

**High-Pass Filter @ 18-20Hz (mandatory):**
- Protects against subsonic over-excursion
- Configured in miniDSP Flex HT
- 4th order Linkwitz-Riley recommended
- All options require this protection

**Conclusion: Both NC502MP and PURIFI operate safely within driver limits**

---

## Cost-Benefit Analysis

### Budget Context: $75,000-95,000 Theater

**NC502MP Investment: $2,500**
- Subwoofer amplification: 3.3% of $75K budget
- Maintains 109 dB reference performance
- 7.5 dB headroom above THX Reference
- Handles extreme film content

**PURIFI Investment: $5,180**
- Subwoofer amplification: 6.9% of $75K budget
- Adds 0.8 dB peak capability (inaudible)
- State-of-the-art specifications
- Maximum redundancy

**Cost Difference: $2,680 (107% premium)**

### Performance per Dollar

**NC502MP:**
- $312.50 per driver channel
- 112.5 dB @ 20Hz peak capability
- **$22.22 per peak dB** ($2,500 ÷ 112.5)

**PURIFI:**
- $647.50 per driver channel
- 113.3 dB @ 20Hz peak capability
- **$45.72 per peak dB** ($5,180 ÷ 113.3)

**Marginal cost for +0.8 dB:** $2,680 ÷ 0.8 = **$3,350 per additional dB**

---

## Where $2,680 Savings Could Go

### Option 1: System Optimization Package ($2,680 total)

1. **Professional Dirac Live Calibration:** $1,000-1,500
   - Multi-position measurements
   - Dirac ART bass optimization
   - SPL verification
   - May improve system by MORE than 0.8 dB through optimization

2. **Spare NC502MP 4-Channel:** $1,250
   - Insurance against failure
   - Can temporarily restore 2 subs during repair
   - Long-term peace of mind

3. **Enhanced Acoustic Treatment:** $500
   - Additional bass traps
   - Corner treatment upgrade
   - May reduce room losses by 0.5-1 dB

**Result: Better overall system performance than cutting budget elsewhere**

### Option 2: Content Library Investment

- **80-100 4K UHD discs** @ $25-30 each
- Actually enjoy the theater you built
- Dolby Vision/Atmos content to showcase system

### Option 3: Projector Upgrade Fund

- Add to $30K projector budget
- Step up to higher-tier model in 2027
- May provide more visible improvement than 0.8 dB

---

## Redundancy Analysis

### Single Point of Failure Scenarios

**1× 8-Channel NC502MP:**

**If amplifier fails:**
- ❌ ALL 4 subwoofers offline
- ❌ System SPL drops to LCR + surrounds only (~85-90 dB capable)
- ❌ Theater experience severely compromised
- ⏱️ Repair/replacement: 1-2 weeks typical

**Mitigation:**
- Keep spare 8-channel on hand (+$2,500)
- Extended warranty coverage
- Accept risk (Class D very reliable)

---

**2× 4-Channel NC502MP:**

**If one amplifier fails:**
- ✅ 2 subwoofers remain operational (front OR rear pair)
- ✅ System maintains ~106 dB @ 20Hz capability
- ✅ Still exceeds THX Reference (105 dB)
- ✅ Theater remains usable, event can continue
- ⏱️ Repair one unit at leisure

**Failure mode SPL:**
- 2 of 4 subs operational = -3 dB from full system
- 109 dB - 3 dB = **106 dB @ 20Hz**
- Still +1 dB above THX Reference
- Most films still have adequate bass impact

**Cost of redundancy:** $0 (same price as 8-channel)

---

**4× PURIFI Monoblocks:**

**If one monoblock fails:**
- ✅ 3 subwoofers remain operational
- ✅ System maintains ~108 dB @ 20Hz capability
- ✅ Minimal impact on experience
- ✅ May not even notice during movie
- ⏱️ Replace one unit at leisure

**Failure mode SPL:**
- 3 of 4 subs operational = -1.25 dB from full system
- 109 dB - 1.25 dB = **~108 dB @ 20Hz**
- Essentially full performance maintained

**Cost of maximum redundancy:** +$2,680

---

## Thermal Considerations

### Heat Dissipation Analysis

**1× 8-Channel NC502MP:**
- Total output: 8 × 500W = 4,000W
- Efficiency: ~90% (Class D typical)
- Heat dissipation: **~400W in single 2U chassis**
- Thermal density: **200W per rack unit**

**Concern:** May require forced ventilation (fan cooling)

---

**2× 4-Channel NC502MP:**
- Output per unit: 4 × 500W = 2,000W
- Heat per unit: **~200W per 2U chassis**
- Thermal density: **100W per rack unit**
- Better heat distribution

**Advantage:** More likely to maintain fanless operation

---

**4× PURIFI Monoblocks:**
- Output per unit: 1,200W
- Efficiency: ~95% (PURIFI Eigentakt)
- Heat per unit: **~60W per 2U chassis**
- Thermal density: **30W per rack unit**
- Fanless operation verified ✅

**Advantage:** Guaranteed silent operation

---

### Cooling Verification CRITICAL

**Your zero-light theater demands absolute silence:**
- No fan noise during quiet passages
- No mechanical noise during blackouts
- Reference environment requires reference silence

**Action Required:**
- Awaiting response from Dylan (Buckeye Amplifiers)
- Must confirm fanless or whisper-quiet operation
- **If audible fan required → PURIFI is only option**

**Questions Asked:**
1. Is NC502MP 4-channel fanless with all 4 channels @ 500W × 4Ω sustained?
2. Case temperature after 2 hours at full power?
3. Does 8-channel version require fan cooling?
4. Recommendation for home theater subwoofer application?

---

## Technical Specifications Detail

### Hypex NCore NC502MP

**Topology:** Class D with Hypex NCore technology

**Specifications (typical):**
- THD+N: ~0.001-0.003% (20Hz-20kHz)
- SNR: >110 dB
- Damping Factor: 2,000-4,000
- Frequency Response: 20Hz-20kHz ±0.5dB
- Input Impedance: 10kΩ balanced
- Gain: Adjustable
- Protection: DC, thermal, short circuit
- Efficiency: ~90%

**Advantages:**
- Proven Hypex NCore technology
- Excellent measured performance
- Cost-effective for multi-channel
- Reliable Class D platform

---

### PURIFI Eigentakt 1ET9040BA

**Topology:** Class D with PURIFI Eigentakt technology

**Specifications:**
- THD+N: <0.00007% (20Hz-20kHz) - **state-of-the-art**
- SNR: >125 dB
- Damping Factor: >10,000 - **exceptional bass control**
- Frequency Response: 0Hz-50kHz ±0.1dB
- Input Impedance: 10kΩ balanced
- Gain: Fixed
- Protection: DC, thermal, short circuit
- Efficiency: ~95%
- Cooling: Fanless passive heatsink ✅

**Advantages:**
- Cutting-edge PURIFI technology
- Best-in-class measured performance
- Guaranteed silent operation
- Monoblock isolation (no shared power supply)

---

## System Integration

### Signal Chain (All Options)

**Source → Marantz AV10:**
- HDMI from media player
- Dolby Atmos/DTS:X decoding
- Video to projector

**AV10 → Dirac Processing:**
- Dirac Live: Full-range room correction
- Dirac Bass Control: Multi-sub optimization
- Dirac ART: Active room treatment (4 independent outputs)

**AV10 → miniDSP Flex HT:**
- 4 discrete LFE feeds from AV10
- High-pass filtering @ 18-20Hz (mandatory)
- Level matching across subs
- PEQ, delay, individual sub control

**miniDSP → Amplifier(s):**

**Option A (8-Channel):**
- 8 discrete outputs from miniDSP (via splitters/processing)
- Each output → one NC502MP channel → one driver

**Option B (2× 4-Channel):**
- Amp 1: Channels 1-4 → Front left/right subs (4 drivers)
- Amp 2: Channels 5-8 → Rear left/right subs (4 drivers)

**Option C (4× PURIFI):**
- 4 outputs from miniDSP → 4 monoblocks → 4 subs
- Each sub's 2 drivers wired in parallel internally

**Amplifier(s) → Drivers:**
- All speaker-level connections
- 12-14 AWG wire appropriate for runs
- Banana plugs or spade terminals

---

## Installation Considerations

### Rack Layout (42U Available, 22U Currently Occupied)

**Current Design (Rev 5.2 with PURIFI):**
- Marantz AV10: 3U
- 4× PURIFI monoblocks: 8U (2U each)
- Other amplifiers: 8U
- miniDSP Flex HT: 1U
- Power distribution: 2U
- **Total: 22U used, 20U available**

**With 2× NC502MP 4-Channel:**
- Marantz AV10: 3U
- 2× NC502MP: 4U (2U each) - **saves 4U vs PURIFI**
- Other amplifiers: 8U
- miniDSP Flex HT: 1U
- Power distribution: 2U
- **Total: 18U used, 24U available**

**With 1× NC502MP 8-Channel:**
- Marantz AV10: 3U
- 1× NC502MP: 2U - **saves 6U vs PURIFI**
- Other amplifiers: 8U
- miniDSP Flex HT: 1U
- Power distribution: 2U
- **Total: 16U used, 26U available**

**Rack space is NOT a constraint in 42U rack** - ventilation already adequate

---

### Cable Management

**All Options:**
- 8 discrete speaker cable runs (one per driver)
- From rack to subwoofer locations:
  - Front left sub: Under stage, corner pocket (short run)
  - Front right sub: Under stage, corner pocket (short run)
  - Rear left sub: Through false wall, floor corner (long run)
  - Rear right sub: Through false wall, floor corner (long run)

**12-14 AWG speaker wire appropriate for all runs**

---

## Decision Framework

### Choose 2× NC502MP 4-Channel IF:

1. ✅ Buckeye confirms fanless or whisper-quiet operation
2. ✅ You value $2,680 savings for optimization elsewhere
3. ✅ Partial redundancy is important (2 subs survive failure)
4. ✅ 0.8 dB peak difference is acceptable (it's inaudible)
5. ✅ Better overall system balance matters (calibration + treatment)

### Choose 1× NC502MP 8-Channel IF:

1. ✅ Buckeye confirms fanless operation
2. ✅ You want absolute minimum rack space (2U)
3. ⚠️ You accept single-point-of-failure risk
4. ❌ **Not recommended** - same price as 2× 4-channel with worse risk profile

### Choose 4× PURIFI Monoblocks IF:

1. ✅ You want absolute maximum redundancy
2. ✅ State-of-the-art specs provide peace of mind
3. ✅ $2,680 premium is insignificant in your budget
4. ✅ You value cutting-edge technology throughout system
5. ✅ Guaranteed silent operation is critical (no verification needed)
6. ✅ +0.8 dB peak capability matters to you

---

## Risk Assessment

### Technical Risk

**NC502MP:**
- ⚠️ **Unknown cooling method** (awaiting Buckeye response)
- ⚠️ Thermal behavior under sustained load unverified
- ✅ Hypex NCore is proven reliable technology
- ✅ Buckeye Amplifiers has good reputation

**PURIFI:**
- ✅ Fanless operation verified
- ✅ Thermal characteristics well-documented
- ✅ Proven in reference applications
- ✅ No unknowns

### Failure Risk

**1× 8-Channel NC502MP:**
- ❌ Single point of failure (all 4 subs)
- ⚠️ Theater unusable if amp fails
- 💰 Mitigation: Keep spare (+$2,500)

**2× 4-Channel NC502MP:**
- ⚠️ Partial failure (lose 2 of 4 subs)
- ✅ Theater remains usable (106 dB capable)
- 💰 Mitigation: Keep spare (+$1,250, optional)

**4× PURIFI Monoblocks:**
- ✅ Minimal impact (lose 1 of 4 subs)
- ✅ Theater essentially unaffected (108 dB capable)
- 💰 Mitigation: Keep spare (+$1,295, optional)

### Budget Risk

**NC502MP:**
- ✅ Saves $2,680 for other priorities
- ⚠️ If must replace with PURIFI later: -$2,680 sunk cost
- ✅ Can redirect savings to calibration/treatment

**PURIFI:**
- ✅ No regrets on performance
- ⚠️ Opportunity cost of $2,680
- ⚠️ May have cut budget elsewhere unnecessarily

---

## Performance in Context

### Real-World Film Examples

**THX Reference Level: 105 dB @ 20Hz**

**All Three Options Provide 7+ dB Headroom Above THX:**

**Demanding Film Scenes:**
- *Blade Runner 2049* - Opening scene: ~100-105 dB @ 20Hz
- *Dunkirk* - Dive bomber scenes: ~100-105 dB @ 20-30Hz  
- *Tenet* - Temporal pincer: ~105-108 dB @ 20-40Hz
- *Godzilla* (2014) - MUTO roar: ~105-110 dB @ 15-25Hz
- *War for the Planet of the Apes* - Avalanche: ~105-110 dB @ 20Hz

**NC502MP Capability: 112.5 dB peak**
- ✅ Handles all above content with 2-7 dB headroom
- ✅ Clean, undistorted bass
- ✅ No compression or limiting

**PURIFI Capability: 113.3 dB peak**
- ✅ Handles all above content with 3-8 dB headroom
- ✅ Slightly more headroom (0.8 dB)
- ✅ Functionally identical to NC502MP

**The 0.8 dB difference matters in theory, not in practice.**

---

## Audibility Analysis

### Just Noticeable Difference (JND) for SPL

**Research consensus:**
- **1 dB:** Minimum detectable by trained listeners in controlled conditions
- **3 dB:** Clearly noticeable change in level
- **10 dB:** Perceived as "twice as loud"

**Context factors:**
- High SPL (>100 dB): Harder to detect small differences
- Complex program material: Harder to detect than pure tones
- Transient peaks: Detection threshold higher

**0.8 dB difference between NC502MP and PURIFI:**
- Below 1 dB JND threshold
- At 112+ dB SPL levels
- During complex film soundtracks
- On transient bass peaks

**Conclusion: The 0.8 dB difference is effectively inaudible in real-world use.**

---

## Long-Term Value Considerations

### 15-20 Year System Lifespan

**NC502MP Path:**
- Save $2,680 upfront
- Invest in professional calibration: +0.5 to +2 dB improvement possible
- Enhanced treatment: +0.5 to +1 dB room loss reduction
- **Net result: May EXCEED PURIFI system performance through optimization**
- Spare amp provides long-term security

**PURIFI Path:**
- Maximum performance out-of-box
- State-of-the-art specs for entire lifespan
- Maximum redundancy (minimal failure impact)
- Peace of mind from cutting-edge technology

**Both paths result in reference-level system that exceeds expectations.**

---

## What Professional Calibrators Would Say

**Likely perspective from Dirac/THX calibration engineer:**

> "Both amplifier options provide more than adequate power for your subwoofer system. At 109 dB @ 20Hz with 7+ dB headroom, you're well into reference territory. The 0.8 dB difference in peak capability is academically interesting but won't be audible in practice.
>
> What WILL make a bigger difference:
> - Proper Dirac ART optimization (can improve response by 2-3 dB in problem areas)
> - Acoustic treatment quality (can reduce room losses by 1-2 dB)
> - Subwoofer placement precision (can improve modal smoothness)
>
> I'd rather see you invest the $2,680 savings in professional calibration and enhanced treatment than in the amplifier power difference you'll never use."

---

## Updated System Budget (Rev 5.3 Estimate)

### With 2× NC502MP 4-Channel

**Previous estimate (Rev 5.2 with PURIFI): $68,676-85,044**

**Component Changes:**
- Subwoofer amplification: $5,180 → $2,500 (-$2,680)

**Updated estimate (Rev 5.3): $65,996-82,364**

**Recommended allocation of savings:**
- Professional Dirac calibration: $1,000-1,500
- Enhanced acoustic treatment: $500-800
- Spare NC502MP 4-channel: $1,250 (optional)
- Content library: Remainder

**Result: Better overall system performance through optimized investment**

---

## Manufacturer Support & Warranty

### Buckeye Amplifiers (NC502MP)

**Reputation:**
- Well-established in DIY audio community
- Excellent customer service reputation
- Direct communication with Dylan (owner)
- Responsive to technical inquiries

**Warranty:**
- Typical 3-5 year warranty (verify with Dylan)
- US-based service and support
- Hypex module replacement straightforward

**Community:**
- Active AVS Forum presence
- Many satisfied customers in home theater applications
- Good track record with multi-channel installs

### PURIFI (via Buckeye)

**Technology:**
- Cutting-edge PURIFI Eigentakt modules
- State-of-the-art performance
- Proven in high-end applications

**Support:**
- Also through Buckeye Amplifiers
- PURIFI modules serviceable
- Premium product with premium support

**Both options have solid manufacturer support.**

---

## The 0.8 dB Reality Check

### What 0.8 dB Actually Means

**In terms of power:**
- NC502MP: 500W per driver
- PURIFI: 600W per driver
- Difference: 100W per driver (20% more power)
- SPL difference: 0.8 dB

**In terms of excursion:**
- NC502MP: 23.7mm (85% of Xmax)
- PURIFI: 26mm (93% of Xmax)
- Difference: 2.3mm (8% more excursion)

**In terms of audibility:**
- Below 1 dB JND threshold
- During transient peaks only
- At already extreme SPL levels
- **Effectively imperceptible**

**In terms of capability:**
- Both handle most extreme film content
- Both vastly exceed THX Reference
- Both provide clean, undistorted bass
- **Functionally equivalent**

**The $2,680 question: Is 0.8 dB worth 107% more cost?**

---

## Final Recommendation

### **Purchase 2× Buckeye NC502MP 4-Channel @ $2,500 total**

**Contingent on verification from Dylan that cooling is fanless or whisper-quiet**

### Comprehensive Rationale:

**1. Performance Equivalence**
- ✅ Identical 109 dB @ 20Hz reference capability
- ✅ 7.5 dB headroom above THX Reference
- ✅ Handles most extreme film content
- ✅ Only 0.8 dB less peak capability (inaudible)
- ✅ Safe driver operation (85% Xmax vs 93%)

**2. Cost Optimization**
- ✅ $2,680 savings (52% cost reduction)
- ✅ 3.3% of theater budget vs 6.9%
- ✅ Better system through optimized allocation:
  - Professional calibration: $1,000-1,500
  - Enhanced treatment: $500-800
  - Spare amp: $1,250 (optional)
  - Content: Remainder

**3. Practical Advantages**
- ✅ Partial redundancy (2 subs survive failure)
- ✅ Same price as 8-channel (no penalty)
- ✅ Better thermal distribution (200W vs 400W per chassis)
- ✅ Logical amp assignment (front/rear pairs)
- ✅ Easier service (swap one 4-ch vs repair 8-ch)

**4. System Philosophy Alignment**
- ✅ Measured performance over brand names
- ✅ Value engineering throughout (DIYSG speakers, DIY subs)
- ✅ Reference capability at optimized cost
- ✅ Invest savings where they provide greater benefit

**5. Risk Management**
- ✅ Partial redundancy at zero cost premium
- ✅ Hypex NCore proven reliable technology
- ✅ Buckeye Amplifiers solid reputation
- ⚠️ Pending: Silent operation confirmation

---

## Alternative Decision Path

### IF Buckeye Response Indicates Fan Cooling Required:

**Then choose: 4× PURIFI 1ET9040BA Monoblocks @ $5,180**

**Rationale:**
- Your zero-light theater demands absolute silence
- Fan noise is non-negotiable deal-breaker
- PURIFI fanless operation verified
- Worth $2,680 premium for guaranteed silence
- Maximum redundancy bonus (1 of 4 failure minimized)

**In this scenario, PURIFI becomes the ONLY acceptable option.**

---

## Action Items

### Before Final Purchase Decision:

1. ✅ **Email sent to Dylan (Buckeye Amplifiers)** - Awaiting response
   - Questions: Fanless operation, thermal characteristics, recommendation

2. ⏳ **Await Dylan's response on cooling method**
   - Critical for decision
   - Must confirm silent operation

3. ⏳ **Make final decision based on cooling verification:**
   - Fanless/silent confirmed → **2× NC502MP 4-Channel**
   - Fan required → **4× PURIFI Monoblocks**

4. 📋 **Update Rev 5.3 documentation** with final amplifier choice

5. 💰 **Allocate savings** (if NC502MP chosen):
   - Budget professional calibration
   - Plan enhanced acoustic treatment
   - Consider spare amp purchase
   - Build content library

---

## Conclusion

**The Buckeye NC502MP 4-Channel amplifiers represent an optimized choice for your subwoofer system:**

- ✅ **Reference-level performance maintained** (109 dB @ 20Hz)
- ✅ **Substantial cost savings** ($2,680 = 52% reduction)
- ✅ **Better overall system** through optimized budget allocation
- ✅ **Practical redundancy** at zero cost premium
- ✅ **Only 0.8 dB less peak capability** (below audibility threshold)

**The PURIFI monoblocks remain the fallback option if:**
- ❌ NC502MP requires audible fan cooling (silence non-negotiable)
- ✅ Maximum redundancy is highly valued
- ✅ State-of-the-art specs provide important peace of mind
- ✅ $2,680 premium is insignificant in overall budget

**Both paths result in exceptional reference-level bass performance that will exceed your expectations and handle the most demanding film content with substantial headroom.**

**The right choice depends on Dylan's response regarding thermal characteristics.**

---

*Document Version: 1.0*  
*Created: November 23, 2024*  
*Status: Awaiting Buckeye Amplifiers cooling verification*  
*For: Reference Home Theater Build (2027)*  
*System Budget: $75,000-95,000*  
*Pending Action: Dylan's response on NC502MP thermal characteristics*
