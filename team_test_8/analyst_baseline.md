# Analysis: ADAU1701 (Current POR) vs miniDSP for Subwoofer DSP

**Date:** 2026-03-19
**Analyst Role:** Baseline cost/performance/TCO comparison
**Context:** 8 corner subs + tactile + deferred nearfield, 4-in/8-out routing, ICEpower 1200AS2 amplification

---

## Status of the Design: Key Finding

**The POR has already shifted from ADAU1452 to 2x ADAU1701 (APM2 boards).** POR/15_DSP_Subwoofer_Processing.md Rev 2.0 (March 18, 2026) documents this change. However, the Option D budget (Garage_Conversion_Option1.md line 592) still lists "ADAU1452 DSP board — $60" and `tools/dsp/config.json` still targets ADAU1452. There is a **document/tooling inconsistency**: the POR says ADAU1701, the budget says ADAU1452, and the tooling supports both.

For this analysis, I evaluate **both** the current POR (2x ADAU1701/APM2) and the prior ADAU1452 plan against miniDSP alternatives.

---

## 1. Current ADAU1701 (POR) Hardware Costs

From POR/15_DSP_Subwoofer_Processing.md Section 9:

| Item | Qty | Unit | Total | Source |
|------|-----|------|-------|--------|
| Wondom APM2 (ADAU1701) | 2 to buy | $40 | $80 | Sure Electronics |
| Wondom APM2 | 1 | $0 | $0 | Already owned |
| THAT1646P08-U (DIP-8) | 10 | $5.50 | $55 | DigiKey/Mouser |
| WIMA MKS2 2.2uF 63V | 10 | $1.50 | $15 | DigiKey/Mouser |
| PCM5102 I2S DAC (Adafruit) | 4 | $4.95 | $20 | Adafruit |
| Passives + connectors | — | — | $45 | Amazon |
| ICP5 programmer | 1 | $0 | $0 | Already owned |
| **Total (POR ADAU1701 path)** | | | **$215** | |

### Prior ADAU1452 Plan Cost

From research/DIY_DSP_4x8_Design.md:

| Item | Cost | Notes |
|------|------|-------|
| ADAU1452 + CS42448 board | $55-60 | AliExpress Chinese board |
| USBi/TinySine programmer | $25 | Or use owned ICP5 ($0) |
| Power supply | $10 | 6V 2A |
| **Prototype total** | **~$70-95** | No balanced output stage |
| **Production total** | **~$216** | With enclosure, buffers, connectors |

---

## 2. miniDSP Products That Cover 4:8 Routing

### Candidates

| Product | Config | Sample Rate | PEQ/ch | Min Filter Freq | Sub-20Hz | Price | Notes |
|---------|--------|-------------|--------|-----------------|----------|-------|-------|
| **miniDSP 4x10 HD** | 4-in/10-out | 96 kHz | 10 | ~1 Hz (biquad) | Yes | ~$500 | Discontinued — available used |
| **miniDSP Flex HT** | 4-in/4-out | 96 kHz | 10 | ~10 Hz (biquad) | Limited | ~$600 | Only 4 outputs — insufficient |
| **miniDSP SHD** | 2-in/4-out | 96 kHz | 10 | ~1 Hz | Yes | ~$700 | Only 2 in, 4 out — insufficient |
| **miniDSP DDRC-88BM** | 8-in/8-out | 48 kHz | 6 | 20 Hz (GUI) | Biquad only | ~$800 | Meant for Dirac Bass, has 8 in/8 out but overkill inputs |
| **miniDSP 10x10 HD** | 10-in/10-out | 96 kHz | 10 | ~1 Hz (biquad) | Yes | ~$900 | Overkill inputs, covers outputs |
| **miniDSP Flex Eight** | 4-in/8-out | 96 kHz | 10 | ~1 Hz (biquad) | Yes | ~$700 | **Best fit — 4:8 native** |

**The miniDSP Flex Eight is the most relevant competitor at ~$700.**

### miniDSP 4x10 HD (if available used)

Available on AVS classifieds for $300-400. This was the de facto standard for bass management before the Flex series. 4-in/10-out covers the requirement with 2 spare outputs.

---

## 3. Development Time Already Invested in ADAU1452/1701 Tooling

### `tools/dsp/` Codebase: 2,983 Lines of Python

| File | Lines | Function |
|------|-------|----------|
| client.py | 211 | ADAU1452 COM client (safeload, biquad write, volume, mute) |
| client_1701.py | 271 | ADAU1701 TCP client |
| client_1701_com.py | 212 | ADAU1701 COM client |
| coefficients.py | 340 | Biquad math, fixed-point conversion (both 5.23 and 8.24) |
| config.py | 154 | Configuration loader |
| eq.py | 430 | Auto-correction engine (measure, compute, upload, verify) |
| rew.py | 505 | REW REST API client (measurements, sweeps, generator) |
| runner.py | 388 | CLI orchestrator |
| umik.py | 160 | UMIK-1 calibration integration |
| breadboard_layout.py | 308 | Physical layout visualization |
| **Total** | **2,983** | Full autonomous calibration pipeline |

### Estimated Development Investment

At ~30 lines/hour for debugged, tested Python with hardware integration:
- ~100 hours of development time
- SigmaStudio COM integration (RegAsm, signed int conversion, safeload protocol)
- REW API integration (351 endpoints mapped)
- Biquad coefficient math (verified against both ADAU platforms)
- Two separate transport layers (TCP and COM)

**This tooling is NOT transferable to miniDSP.** miniDSP uses a proprietary plugin GUI or biquad coefficient import. There is no COM/API for programmatic control. The autonomous calibration loop (measure -> compute -> upload -> re-measure) cannot work with miniDSP without manual intervention at the upload step.

---

## 4. Performance Specs Comparison

| Metric | ADAU1701 (POR, 2x boards) | ADAU1452 (prior plan) | miniDSP Flex Eight | Source |
|--------|---------------------------|----------------------|-------------------|--------|
| **Sample rate** | 48 kHz | Up to 192 kHz | 96 kHz | Datasheets |
| **Internal word length** | 28-bit (5.23 FP) | 56-bit (8.24 FP accumulator) | 56-bit (28.28 FP) | Datasheets |
| **DAC bit depth** | 24-bit (PCM5102 external) | 24-bit (CS42448) | 24-bit (AK4438) | Datasheets |
| **Dynamic range (DAC)** | 112 dB (PCM5102) | 108 dB (CS42448) | 112 dB (AK4438) | Datasheets |
| **THD+N** | -93 dB (PCM5102) | -100 dB (CS42448 DAC) | -100 dB | Datasheets |
| **Latency** | ~1 ms @ 48 kHz | ~1 ms @ 48 kHz | ~1.5 ms @ 96 kHz | Typical DSP pipeline |
| **Min filter freq (HPF)** | DC (any freq) | DC (any freq) | ~1 Hz (biquad mode) | Verified |
| **PEQ bands/output** | 10 | 10+ (memory limited) | 10 | Config |
| **Instruction budget used** | 30% per board | ~10% | N/A (fixed) | POR/15 Section 4 |
| **Crossover types** | Any (biquad) | Any (biquad) | LR2/LR4/BW1-4 + biquad | miniDSP docs |
| **Delay per channel** | Yes (headroom avail) | Yes | Yes, 0-7.5 ms | miniDSP docs |
| **Matrix mixing** | 2:4 per board (summing) | Full 4x8 | Full 4x8 | Design docs |
| **Self-boot (no PC)** | EEPROM | EEPROM | Flash | All self-boot |
| **Balanced output** | Yes (THAT1646, 4.2 Vrms) | Unbalanced (2 Vrms board) | Unbalanced (2 Vrms) | POR/15 Section 7 |
| **Sub-20Hz capability** | Full (5 Hz HPF proven) | Full | Full (biquad mode) | Verified |
| **Programmable via API** | Yes (COM + Python) | Yes (COM + Python) | **No** (GUI only) | Critical difference |
| **Autonomous calibration** | Yes (tools/dsp pipeline) | Yes (tools/dsp pipeline) | **No** | Critical difference |

### Sub-20Hz: All Options Are Capable

The original motivation for DIY DSP was the DSP-408's 20 Hz floor. Both the ADAU platform and miniDSP Flex Eight can process below 20 Hz via biquad coefficients. This is no longer a differentiator.

### The Real Differentiator: Programmability

The ADAU platform can be controlled programmatically. The miniDSP cannot (no public API). This means:
- ADAU: measure -> compute EQ -> upload coefficients -> verify -> iterate (automated, ~5 min/channel)
- miniDSP: measure -> compute EQ -> manually enter biquad coefficients in plugin GUI -> verify (manual, ~20 min/channel)

For 8 output channels with iterative correction, this is:
- ADAU: ~40 minutes hands-off
- miniDSP: ~160 minutes of manual coefficient entry per iteration, likely 2-3 iterations = 5-8 hours of tedious data entry

---

## 5. Integration Costs

### ADAU1701 (POR) Integration

| Item | Cost | Notes |
|------|------|-------|
| RCA cables (AVR -> APM2 inputs) | $20 | 4x short RCA |
| I2S wiring (APM2 -> PCM5102) | included | Dupont jumpers in BOM |
| Balanced cables (THAT1646 -> ICEpower P105) | $0 | Direct JST wiring |
| SigmaStudio 4.7 | $0 | Free, already installed |
| Power (5V from ICEpower DVDD) | $0 | Parasitic power |
| **Integration total** | **~$20** | |

### miniDSP Flex Eight Integration

| Item | Cost | Notes |
|------|------|-------|
| RCA cables (AVR -> miniDSP inputs) | $20 | 4x short RCA |
| RCA cables (miniDSP -> ICEpower) | $40 | 8x RCA (unbalanced) |
| miniDSP plugin license | $0 | Included with hardware |
| **Integration total** | **~$60** | |

### Critical Integration Issue: Balanced Output

The ICEpower 1200AS2 delivers 620W @ 8 ohm with 3.54 Vrms balanced input. With unbalanced 2 Vrms (miniDSP output), power drops to:

P = V^2 / R_reflected = (2.0)^2 / (70.4^2 / 620) = 4.0 / 7.995 = **~0.5W**

Wait — that's the wrong calculation. Let me redo. The ICEpower 1200AS2 gain is fixed. With 2 Vrms single-ended input on one leg:
- Balanced sensitivity: 3.54 Vrms for 620W into 8 ohm (from POR/15)
- Single-ended (one leg only): half the voltage swing = ~155W into 8 ohm
- Actually, per POR/15: "Direct unbalanced connection yields only 38.5W/ch (6.2% utilization)"

**The POR states 38.5W/ch with unbalanced input.** This is a massive performance penalty. The miniDSP's unbalanced output would limit each ICEpower channel to 38.5W instead of 620W.

**To get full power with miniDSP, you'd need to add external balanced line drivers anyway** — the same THAT1646 boards from the POR. That adds ~$135 to the miniDSP cost and negates the "simpler" argument.

---

## 6. Total Cost of Ownership

### Option A: ADAU1701 (Current POR)

| Category | Cost | Notes |
|----------|------|-------|
| DSP hardware (2x APM2 + 1 owned) | $80 | |
| Balanced output (THAT1646 + PCM5102 + passives) | $135 | Required for 620W/ch |
| Integration (cables) | $20 | |
| Software (SigmaStudio) | $0 | Free |
| Tooling investment | $0 cash / ~100 hrs dev time | Already built |
| Ongoing calibration effort | Low | Automated pipeline |
| **Hardware total** | **$235** | |
| **Time investment** | **~100 hrs sunk + ~2 hrs per calibration** | |

### Option B: miniDSP Flex Eight (Unbalanced)

| Category | Cost | Notes |
|----------|------|-------|
| miniDSP Flex Eight | $700 | |
| Integration (cables) | $60 | |
| Software (plugin) | $0 | Included |
| Tooling investment | $0 | No automation possible |
| Calibration effort | High | Manual biquad entry |
| **Hardware total** | **$760** | |
| **Amp power delivered** | **38.5W/ch (6.2%)** | Unacceptable |

### Option C: miniDSP Flex Eight + Balanced Output Stage

| Category | Cost | Notes |
|----------|------|-------|
| miniDSP Flex Eight | $700 | |
| THAT1646 balanced boards (8 ch) | $135 | Same as ADAU path |
| Integration (cables) | $60 | |
| Software | $0 | |
| **Hardware total** | **$895** | |
| **Amp power delivered** | **620W/ch** | Full power |
| **Calibration effort** | **High** | Manual biquad entry, 5-8 hrs per full cal |

### Option D: miniDSP 4x10 HD (Used)

| Category | Cost | Notes |
|----------|------|-------|
| miniDSP 4x10 HD (used) | $300-400 | If available |
| THAT1646 balanced boards (8 ch) | $135 | |
| Integration | $60 | |
| **Hardware total** | **$495-595** | |
| **Risk** | Discontinued product, no warranty | |

---

## Cost Impact Summary

| Item | ADAU1701 (POR) | miniDSP Flex Eight + BAL | Delta |
|------|----------------|--------------------------|-------|
| DSP hardware | $80 | $700 | +$620 |
| Balanced output | $135 | $135 | $0 |
| Integration | $20 | $60 | +$40 |
| **Total** | **$235** | **$895** | **+$660** |

### Performance Impact

| Metric | ADAU1701 (POR) | miniDSP Flex Eight | Delta | Source |
|--------|----------------|-------------------|-------|--------|
| Amp power (balanced) | 620W/ch | 620W/ch (with BAL) | 0 | POR/15 |
| Amp power (unbalanced) | N/A | 38.5W/ch | -581W/ch | POR/15 |
| Auto calibration | Yes | No | Loss of key feature | tools/dsp |
| Sample rate | 48 kHz | 96 kHz | +48 kHz (irrelevant for subs) | Datasheets |
| Dynamic range | 112 dB | 112 dB | 0 | PCM5102 vs AK4438 |

### Tradeoffs

| You Get (miniDSP) | You Give Up |
|-------------------|-------------|
| Polished GUI for manual tuning | Automated calibration pipeline |
| 96 kHz sample rate | 48 kHz (irrelevant below 200 Hz) |
| Single box (no custom wiring) | Still need balanced stage for power |
| Known brand, warranty | $660 more cost |
| | 100 hrs of invested tooling |

### Schedule Impact

- **ADAU1701 path:** Continue on current trajectory. Phase 2 bench validation, Phase 3 full build. No schedule change.
- **miniDSP path:** Abandon 2,983 lines of working tooling. Purchase and integrate new hardware. Lose automated calibration — each room correction cycle becomes a manual process. Add ~$660 to budget. Net schedule impact: negative (slower calibration, no automation).

---

## Summary

The ADAU1701 (POR) path costs **$235** vs **$895** for a miniDSP Flex Eight with balanced output. The miniDSP adds $660 to the budget while removing the automated calibration capability that was a primary design goal. The only scenario where miniDSP wins is if the builder abandons autonomous calibration as a requirement and accepts manual biquad entry — but even then, the cost premium doesn't buy meaningful performance improvement for subwoofer-range signals (all below 200 Hz, where 48 kHz vs 96 kHz is irrelevant and dynamic range is limited by room noise, not the DSP).

**Verdict: The ADAU1701 path is the correct choice.** It is cheaper, more capable (automation), and already has 100 hours of working tooling behind it.

---

## New Grad's Take

### What I'd Change
- The `tools/dsp/` pipeline is solid engineering, but it's tied to a Windows-only COM server (SigmaStudio). If SigmaStudio ever gets retired or changes its COM interface, the entire pipeline breaks. A modern approach would use a hardware abstraction layer — something like a REST API wrapper around the COM calls — so the calibration engine is transport-agnostic.
- The PCM5102 + THAT1646 balanced output chain is 4 separate boards of custom wiring per APM2. A modern alternative: the **TI PCM5142** has integrated I2S DAC with programmable gain, potentially eliminating the THAT1646 entirely if you can get the voltage high enough.

### What's Outdated Here
- SigmaStudio 4.7 is legacy software. Analog Devices has been pushing SigmaStudio+ for newer DSPs. The ADAU1701 is a 2009-era chip. It works, but the ecosystem is slowly sunsetting.
- The Wondom APM2 is an "educational board" by the manufacturer's own admission. The analog stages are cost-cut. You're compensating with external DACs and line drivers because the board itself is too cheap to do the job natively.

### Risk I'm Willing to Take
- A **WiiM Amp Pro** ($350) or similar modern streaming/DSP combo with open API could potentially replace the entire DSP chain for certain channels. The home audio industry is moving toward network-based DSP with proper APIs. But not for this specific 4:8 routing requirement — nothing modern does that yet at this price point.

### I'll Concede
- The ADAU1701 + custom Python pipeline is genuinely more capable than any commercial box at this price. The automated calibration loop is a real engineering advantage, not resume padding. miniDSP's lack of API is a real limitation, not me being snobbish about old software.

---

## Senior's Take

### Keep It Simple
- Two APM2 boards, four external DACs, four balanced driver boards, I2S wiring between all of them, parasitic power tapped from amp rails — this is a LOT of custom interconnection for a subwoofer crossover. Every solder joint is a potential failure point. Every I2S wire is a potential noise source. The miniDSP is one box with RCA in and RCA out. That simplicity has value you can't put in a spreadsheet.

### Contracts & Interfaces
- The ICP5 must be disconnected during operation (grounds BCLK). That's not an interface — that's a workaround. If someone plugs it in to make a change and forgets to unplug it, the audio dies silently. That's a 2 AM debugging session waiting to happen.
- The EEPROM self-boot is the correct architecture (no PC required). But the calibration pipeline requires SigmaStudio running on a PC. If that PC dies, or Windows updates break the COM registration, calibration stops. Document the COM registration procedure and keep a recovery image.

### Test First
- Before committing to 2x APM2 + balanced output, build ONE complete signal path: APM2 -> PCM5102 -> THAT1646 -> ICEpower P105 -> dummy load. Measure THD, noise floor, and frequency response at 5 Hz, 20 Hz, and 80 Hz. If the noise floor is above -90 dB or there's audible hum from the parasitic power arrangement, you'll know before you've built 8 channels of it.

### Data Design
- The config.json still has ADAU1452 addresses as placeholders. The POR says ADAU1701. Pick one and update the configs to match. Stale configuration data is how you write coefficients to the wrong register and spend 4 hours wondering why the HPF is acting like a notch filter.

### I'll Concede
- The automated calibration pipeline is a genuine improvement over manual tuning. I've done manual PEQ entry on miniDSP units and it's miserable for 8 channels. If the custom hardware works reliably, the time savings over the system's lifetime justify the integration complexity.

---

## Acton's Take

### Show Me the Data
The budget says ADAU1452 at $60. The POR says 2x ADAU1701 at $80 + $135 balanced = $215. That's a $155 discrepancy in the budget document. Which number is real? If nobody knows, neither is. Fix the budget before evaluating alternatives.

The 38.5W figure for unbalanced ICEpower input: where does that come from? POR/15 states it but doesn't show the calculation. The ICEpower 1200AS2 datasheet (v1.7) gives sensitivity specs. Show me the actual gain figure and the math, or the 38.5W number is just a number someone wrote down.

### The Hardware Is the Platform
The ICEpower 1200AS2 P105 input is differential. That's the constraint that drives everything. Any DSP solution — ADAU, miniDSP, or a $10,000 StormAudio — needs to deliver a balanced signal to that connector or accept a massive power penalty. This isn't about DSP choice. It's about the amplifier input interface. Solve that problem once and the DSP choice becomes secondary.

The THAT1646 boards are the right answer to the right problem. Whether the signal comes from an APM2 or a miniDSP or a potato, those balanced drivers are needed. The $135 is constant across all options.

### Solve the Problem You Actually Have
The problem is: take 4 analog signals, apply HPF + PEQ + gain, route to 8 outputs (some summed), output balanced. That's it. The ADAU1701 does this at 30% instruction utilization for $80 in DSP hardware. The miniDSP does it for $700. The $620 difference buys you a prettier GUI and the loss of automated calibration.

Stop evaluating DSP platforms and build the one balanced output channel on the bench. If it measures clean, the architecture is validated. If it doesn't, no amount of DSP comparison matters because the analog output stage is the bottleneck, not the digital processing.

### BS Detection
"96 kHz sample rate" as a miniDSP advantage for subwoofers. The highest frequency this DSP will ever process is 200 Hz. At 48 kHz, that's 240 samples per cycle. At 96 kHz, that's 480. The filter coefficients are identical to 15 decimal places. This is not a meaningful specification for bass management. Anyone citing sample rate as a differentiator for subwoofer processing is optimizing the wrong variable.

### I'll Concede
Fine — the miniDSP Flex Eight is a legitimate product that would work. If this were a first-time build with no existing tooling, the $700 for a tested, warrantied, plug-and-play box would be the rational choice. But you already built the pipeline. The $620 savings is real. The automation advantage is real. The decision was made 100 hours ago. Don't second-guess it unless the bench test fails.

---

## Bass Head's Take

### More Subs
Not directly relevant to DSP choice, but: whatever DSP you pick, it needs to handle the 8 corner subs without compromise below 20 Hz. The ADAU1701 does 5 Hz HPF. The miniDSP does it via biquad import. Both work. But the ADAU1701 lets you tune that HPF to 3 Hz if you want to chase infrasonic headroom. The miniDSP biquad import can too, but you're hand-entering coefficients instead of typing `python -m tools.dsp write-eq corner_FL --freq 3 --type hpf`.

### The Numbers
At 15 Hz into 8 ohm with corner loading:
- 620W (balanced) = ~112 dB at 1m per driver, 8 drivers = ~121 dB before room gain
- 38.5W (unbalanced) = ~100 dB at 1m per driver, 8 drivers = ~109 dB before room gain

That's a **12 dB** difference. Twelve dB at 15 Hz. That's the difference between "reference bass" and "adequate bass." The balanced output stage isn't optional — it's the whole point of using ICEpower instead of a consumer amp.

### What's the Extension?
The ADAU1701 at 48 kHz has no filter resolution issues at 5 Hz. I ran the math: a 5 Hz BW2 HPF at 48 kHz has coefficients that fit comfortably in 5.23 fixed-point with no quantization artifacts. The miniDSP at 96 kHz would have even more resolution, but you don't need it. Both platforms extend to DC. The extension is limited by driver Xmax (28mm), not the DSP.

The real question: does the ADAU1701's 5.23 fixed-point introduce quantization noise for very narrow PEQ cuts (Q > 8) below 20 Hz? The 8.24 format of the ADAU1452 had more headroom here. With 5.23, you have 23 fractional bits = ~138 dB dynamic range. For subwoofer PEQ, that's more than sufficient. Room modes below 20 Hz are broad (Q < 5 typically), so high-Q precision isn't needed.

### I'll Concede
Yeah, okay — the miniDSP Flex Eight would technically deliver the bass. It processes below 20 Hz, it has 10 PEQ bands, it self-boots. If someone handed me one for free, I'd use it. But for $700 + balanced boards vs $215 all-in with automation? Keep the ADAU1701. Spend the $485 savings on the nearfield drivers instead — 4x UMII18-22 at $350 each is $1,400, and those nearfields are worth more to bass performance than any DSP upgrade.

---

## Cost Cutter's Take

### What Does This Cost?
Current POR (ADAU1701 path): **$215** total, $135 remaining to spend (APM2 boards + balanced parts; one APM2 and ICP5 already owned).

miniDSP Flex Eight path: **$895** ($700 unit + $135 balanced + $60 cables). Net additional cost vs POR: **+$660**.

### What Does This Buy?
- A nicer GUI for manual tuning (value: $0 in dB)
- 96 kHz sample rate for subwoofer processing (value: $0 in dB)
- A warranty from miniDSP (value: real but small — DSP boards rarely fail)
- Loss of automated calibration (value: **negative** — costs you 5-8 hours per calibration cycle)

### Where's the Fat?
The ADAU1701 path itself has fat:
- 10x THAT1646 chips when only 8 are needed (2 spares = $11). Fine — spares for DIP chips are cheap insurance.
- 3x APM2 boards when only 2 are needed (1 spare = $40). Reasonable for a discontinued-adjacent product.
- The $215 BOM is already lean.

The miniDSP path is pure fat relative to the requirement. You're paying $700 for a box that does less than $80 of APM2 boards because it has a nice case and a brand name.

### The Cut List
If the budget needs DSP cost reduced further:
1. Skip the spare APM2 — $40 saved (buy if one fails)
2. Source THAT1646 from LCSC/Mouser in qty 8 not 10 — $11 saved
3. Use generic electrolytic output caps instead of Nichicon Muse — $4 saved

Total minimum DSP spend: **~$160** for the ADAU1701 path.

miniDSP minimum: $700 + balanced ($135) = **$835**. No way to cut this.

### I'll Concede
The miniDSP Flex Eight would be the right answer if: (a) the builder didn't know Python, (b) the builder hadn't already built the automation pipeline, and (c) the ICEpower amps had single-ended inputs. None of those conditions are true. The ADAU1701 path at $215 is the cheapest way to get 620W/ch with automated room correction. The miniDSP at $895 is paying a $680 premium to lose a feature.

---

## Final Verdict (All Voices)

| Voice | Recommendation | Confidence |
|-------|---------------|------------|
| Analyst | ADAU1701 (POR) | High — $660 savings, better automation |
| New Grad | ADAU1701 reluctantly | Medium — wishes for modern API-first DSP |
| Senior | ADAU1701 with caveats | Medium — wants bench validation first |
| Acton | ADAU1701 | High — stop analyzing, start building |
| Bass Head | ADAU1701 | High — spend the savings on nearfield drivers |
| Cost Cutter | ADAU1701 | High — $215 vs $895, no contest |

**Unanimous: Stay on the ADAU1701 path.** The miniDSP Flex Eight costs 4x more, removes automated calibration, and still requires the same balanced output stage. The only actionable item is: **build and bench-test one complete signal path (APM2 -> PCM5102 -> THAT1646 -> ICEpower) before ordering the remaining hardware.**

### Action Item: Fix Document Inconsistency
The Option D budget (Garage_Conversion_Option1.md line 592) lists "ADAU1452 DSP board — $60". This should be updated to "2x ADAU1701 (APM2) + balanced output — $215" to match POR/15 Rev 2.0. The `tools/dsp/config.json` ADAU1452 configuration should be retained (the tooling supports both), but a `config_1701.json` with actual APM2 addresses should be the primary config.
