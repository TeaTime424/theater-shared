# Critique: DSP Platform Evaluation — ADAU1701 vs miniDSP

**Date:** 2026-03-19
**Role:** Critic (with advisory panel)

---

## My Blind Assessment

If asked "should I buy a miniDSP or keep my custom ADAU1701 build," I'd start from the amplifier input constraint: the ICEpower 1200AS2 needs balanced differential input for full power. Any DSP solution without balanced output requires the same THAT1646 stage, so the comparison is never "commercial box vs custom build" — it's "commercial box + custom analog vs custom DSP + custom analog." The only escape from custom analog is a product with native balanced output at sufficient voltage, and the only miniDSP that qualifies (2x4 Balanced) doesn't have enough channels. Given that, the ADAU1701 path probably wins on cost, but I'd want to verify the 38.5W unbalanced claim and check whether a miniDSP product with an API was missed.

## Strongest Alternative

**Two miniDSP 2x4 Balanced units ($500 total).** Native 4.0 Vrms balanced XLR output. Zero custom analog construction. Zero soldering. Zero I2S wiring. Zero parasitic power tapping. Each unit covers 2-in/4-out, so two units cover 4-in/8-out. XLR-to-JST adapter cables connect directly to ICEpower P105. Total system: $500 + $40 cables = $540. Loses automated calibration but gains professional build quality, warranty, and swap-a-box troubleshooting. The sub-20Hz biquad limitation is workable — compute coefficients in Python, enter them once in the plugin GUI. You're entering 80 filters manually, but you do it once after Dirac calibration, not iteratively.

This is the alternative both agents should have stress-tested harder.

---

## Issues Found

| # | Severity | Issue | Location | Recommendation |
|---|----------|-------|----------|----------------|
| 1 | **BLOCKER** | **The 38.5W unbalanced figure is misapplied to miniDSP.** POR/15 derives 38.5W from the ADAU1701's internal DAC at 0.9 Vrms. A miniDSP outputs 2.0 Vrms. With 2.0 Vrms single-ended into one leg of the ICEpower differential input (gain 19.5x), output = 39 Vrms, power = 39^2/8 = **~190W**, not 38.5W. The analyst repeated the 38.5W figure for miniDSP without recalculating for the higher output voltage. 190W is 31% utilization — still not full power, but a completely different tradeoff than 6.2%. Both agents built their case on "38.5W is unacceptable" when the actual figure for miniDSP unbalanced is 5x higher. | analyst_baseline.md lines 160-169, architect_output.md lines 121-122 | Recalculate miniDSP unbalanced power using actual 2.0 Vrms output. Redo cost-benefit with 190W as the unbalanced baseline. |
| 2 | **WARNING** | **The "miniDSP Flex Eight" may not exist as a real product.** The analyst lists it at $700 as the "best fit" competitor. miniDSP's current product line includes Flex, Flex HT, 2x4 HD, 2x4 Balanced, SHD, DDRC-88A/BM, and the 10x10 HD. I cannot confirm a product called "Flex Eight" with 4-in/8-out at $700 on miniDSP's website. If this product doesn't exist, the entire cost comparison against the primary competitor is fabricated. The DDRC-88BM (8x8, ~$800) or 10x10 HD ($500) are the real candidates. | analyst_baseline.md line 57 | Verify the miniDSP Flex Eight exists as an actual product on miniDsp.com. If not, redo comparison with DDRC-88BM or 10x10 HD. |
| 3 | **WARNING** | **miniDSP API capability was dismissed without verification.** Both agents state "no public API" for miniDSP. The miniDSP 2x4 HD actually supports **custom biquad coefficient upload via its plugin software**, and the plugin stores presets in XML format. Several AVS Forum users have automated biquad generation and import via scripts. The DDRC-88BM uses the same plugin architecture. It's not a REST API, but it's not zero automation either. The claim "no auto-calibration possible" overstates the limitation. | architect_output.md lines 124, 213; analyst_baseline.md line 117 | Research miniDSP plugin XML preset format. Determine if Python can generate and import coefficient presets programmatically. |
| 4 | **WARNING** | **Sunk cost framing is present.** The analyst cites "100 hours of invested tooling" as a reason to stay on ADAU1701. The tooling is relevant only if it works on the final hardware. The `tools/dsp/` pipeline was originally written for ADAU1452 (client.py), then a new client was written for ADAU1701 (client_1701_com.py). The coefficient math (coefficients.py) and REW integration (rew.py) are platform-agnostic — they'd work with any DSP that accepts biquad coefficients. Only the transport layer (~480 lines across two client files) is ADAU-specific. Framing 2,983 lines as "non-transferable" is misleading. ~2,500 lines transfer to any platform. | analyst_baseline.md lines 82-94 | Separate platform-agnostic tooling (coefficients, REW, EQ engine) from platform-specific transport (~480 lines). The actual sunk cost of switching is rewriting the transport layer, not the entire pipeline. |
| 5 | **WARNING** | **The 2x4 Balanced option was dismissed too quickly.** The architect evaluated it as "Interesting for output voltage" then moved on. Two units at $500 total provide: 4-in/8-out, 4.0 Vrms balanced output (exceeds ICEpower requirement), self-boot, 10 PEQ/ch. The only real limitations are: no API (manual biquad entry) and 10 Hz minimum in GUI (biquad mode extends lower). At $500, it's $285 more than the ADAU1701 path but eliminates ALL custom analog construction — no perfboard, no soldering, no I2S wiring, no THAT1646, no PCM5102, no parasitic power tapping. The Senior flagged this but it wasn't given adequate weight. | architect_output.md lines 132-139 | Run a proper cost-benefit of 2x miniDSP 2x4 Balanced ($500) vs ADAU1701 POR ($215). Include build time, failure modes, and troubleshooting complexity in the comparison. |
| 6 | **MINOR** | **CamillaDSP contingency is speculative.** The New Grad proposes Pi 4 + Behringer UMC1820 at $280. The UMC1820's actual street price is $250-300 (not a flat $200 as implied). A Pi 4 is $55-75 depending on RAM. Total is $305-375, not $280. Also, the UMC1820's 8 outputs are unbalanced on TRS — they're TRS balanced at +4 dBu (1.23 Vrms), which still isn't enough for full ICEpower power. The contingency doesn't actually solve the balanced output problem either. | architect_output.md line 291, analyst_baseline.md line 407 | Verify UMC1820 output voltage and update cost estimate. If balanced output is still needed, the contingency has the same analog problem as every other option. |
| 7 | **MINOR** | **POR/06 vs POR/15 is a real problem but understated.** Both agents flagged the contradiction (POR/06 says DSP-408, POR/15 says ADAU1701) but labeled it an "action item." This is more than a document hygiene issue — if anyone references POR/06 for equipment procurement, they'll buy the wrong DSP. The budget document also references ADAU1452 at $60, which is a third conflicting answer. Three documents, three different DSP platforms. | POR/06 line 104, POR/15 title, analyst_baseline.md line 11 | Update POR/06 immediately to reference ADAU1701 + ICEpower. Update budget to $215 for DSP. Mark ADAU1452 and DSP-408 references as superseded. |

## Assumptions Tested

| Assumption | Valid? | Evidence |
|-----------|--------|----------|
| 38.5W unbalanced from miniDSP | **NO** | 38.5W is from ADAU1701 internal DAC (0.9 Vrms). miniDSP at 2.0 Vrms yields ~190W into 8 ohm single-ended. |
| miniDSP has no API | **PARTIALLY** | No REST API, but plugin XML preset files can be scripted. Not as clean as COM but not zero. |
| miniDSP Flex Eight exists at $700 | **UNVERIFIED** | Cannot confirm this product in miniDSP's current catalog. May be confused with Flex HT or a discontinued product. |
| 100 hrs of tooling is non-transferable | **NO** | ~2,500 of 2,983 lines are platform-agnostic (coefficients, REW, EQ engine). Only ~480 lines are transport-specific. |
| ADAU1701 HPF at 5 Hz is unique | **MOSTLY** | miniDSP can do it via biquad import, but requires manual coefficient calculation. ADAU1701 does it natively in SigmaStudio. Practical advantage, not capability advantage. |
| ICEpower requires 3.54 Vrms for full power | **YES** | Verified in Balanced_Output_Stage.md: gain 25.8 dB (19.5x), rated 620W @ 8 ohm. Back-calculated: sqrt(620*8) / 19.5 = 3.61 Vrms. POR says 3.54 Vrms (slight rounding difference, immaterial). |
| Both agents are free of confirmation bias | **NO** | See below. |

## Confirmation Bias Assessment

Both agents arrived at the same conclusion (keep ADAU1701) and both used the same flawed 38.5W figure to make the miniDSP case look worse than it is. The architect evaluated 6 miniDSP products but missed or fabricated the one that matters most (Flex Eight). The analyst used the same fabricated product as the primary comparator. Neither agent checked whether the 38.5W figure applied to miniDSP's 2.0 Vrms output or only to the ADAU1701's 0.9 Vrms DAC.

The advisory panel (6 voices) was also unanimous — 6 for ADAU1701, 0 for miniDSP. When 6 out of 6 reviewers agree on a hardware decision involving cost, complexity, and reliability tradeoffs, that's a signal that the analysis was framed to produce agreement, not to genuinely explore alternatives.

The strongest sign of bias: the Senior correctly identified that 10 custom modules with I2S wiring and parasitic power is a reliability concern, but then conceded anyway because the automation pipeline is valuable. The automation pipeline being valuable doesn't make the analog build reliable. Those are independent assessments. The Senior let the Analyst's framing override his own judgment.

## Scope Check

- **Asked for:** Evaluate whether miniDSP should replace ADAU1701 for 4-in/8-out sub processing.
- **Planned:** Comprehensive evaluation of 6+ miniDSP products, cost comparison, capability matrix, advisory panel review.
- **Delta:** Correct scope, but the evaluation has factual errors (38.5W, possibly fabricated product) that undermine the conclusion even though the conclusion is probably still correct.

## Failure Thresholds

The recommendation (keep ADAU1701) should change to RETHINK if:

1. The Phase 2 bench test (APM2 -> PCM5102 -> THAT1646 -> ICEpower) shows noise floor above -80 dB or measurable hum from parasitic power. At that point, the miniDSP 2x4 Balanced at $500 becomes the correct answer because it eliminates the entire custom analog chain.

2. The miniDSP 2x4 Balanced pair at $500 is verified to deliver >600W from the ICEpower with its 4.0 Vrms balanced output, AND a scripted biquad import path is confirmed. At that point, $285 for professional build quality, warranty, and zero construction risk is defensible.

3. The "miniDSP Flex Eight" doesn't exist. If the primary competitor in the analysis is fabricated, the cost comparison must be redone with real products.

## Verdict

**PROCEED WITH CHANGES**

The ADAU1701 recommendation is probably correct, but the analysis has material errors:

1. Fix the 38.5W misapplication — miniDSP unbalanced delivers ~190W, not 38.5W. The case for balanced output is weaker than presented (190W may be acceptable for some channels, especially tactile).
2. Verify the miniDSP Flex Eight exists. If not, redo the comparison with real products.
3. Properly evaluate 2x miniDSP 2x4 Balanced ($500) as the real alternative — it's the only option that eliminates all custom analog work.
4. Fix POR/06 and budget doc DSP references before any hardware is ordered.

The decision stands, but the reasoning needs repair.

---

## New Grad's Take

### What I'd Change
- The analysis is **too conservative** in exactly one way: it never considers that the miniDSP ecosystem might get an API. miniDSP has been gradually opening up — the SHD series has network control, the DDRC-88BM has Dirac integration. The trajectory is toward more programmability, not less. But "might get an API someday" isn't a reason to buy today. For the 2027 build, you evaluate what exists now.

### What's Outdated Here
- The entire framing assumes you need dedicated DSP hardware. A **$35 ESP32-S3** running open-source audio DSP firmware (e.g., audio-dsp or ESP-ADF) can process 4 channels of biquad filters at 48 kHz with I2S output to PCM5102. That's the APM2's job for 1/10th the cost. Nobody explored microcontroller-based DSP as an option. It's not mature, but for fixed biquad chains on sub-bass signals, it's technically feasible.
- More practically: **HifiBerry DAC+ DSP** ($50) runs ADAU1451 with SigmaStudio support and I2S DAC output. Two of those at $100 total would replace both APM2 boards and use the same tooling.

### Risk I'm Willing to Take
- If the HifiBerry DAC+ DSP (ADAU1451) works with the existing SigmaStudio pipeline, it's a better board than the APM2 for the same role — better analog design, established company, readily available. Worth 2 hours of investigation before committing to more APM2 orders.

### I'll Concede
- The existing Python pipeline is genuinely valuable engineering. Throwing it away for a miniDSP GUI would be a downgrade in capability. The New Grad in the architect's output was right about CamillaDSP being a viable alternative, but wrong about the UMC1820 solving the balanced output problem. Old hardware constraints don't care about modern software.

---

## Senior's Take

### Keep It Simple
- I flagged this in my advisory during the architect's phase and I'm flagging it again: **10 custom modules connected by I2S digital wiring and parasitic power tapped from amplifier rails is a reliability problem.** The architect and analyst both acknowledged this and then dismissed it because the automation pipeline is good. Those are separate issues. A well-automated system that has a cold solder joint on I2S clock fails just as hard as a manually-tuned system with a cold solder joint.
- The ICP5 "disconnect during operation" requirement is a design smell. If a cable must be physically disconnected for the system to work, someone will forget, and the theater will have no bass at movie night. Put a physical switch on the ICP5 cable. Or better: design the I2S routing so the ICP5 doesn't interfere. The current design accepts a known failure mode as a feature.

### Contracts & Interfaces
- The I2S interface between APM2 and PCM5102 has no error detection. If a wire comes loose, the DAC outputs garbage or silence. There's no heartbeat, no watchdog, no "I2S link is down" indicator. In a commercial product (like a miniDSP box), all of this is on one PCB with machine-soldered traces. In the POR design, it's Dupont jumper wires on header pins. That's prototyping hardware in a permanent installation.
- The THAT1646 boards are on perfboard with DIP sockets. That's fine for bench testing. For a permanent installation in an equipment closet, these should be on proper PCBs. OSHPark does small-run PCBs for $5/sq inch. A 2-channel THAT1646 board is maybe 2 sq inches. $10/board x 4 boards = $40. Add it to the BOM.

### Test First
- The Phase 2 bench test is the right gate. But add specific pass/fail criteria:
  - Noise floor: < -90 dBFS at 1 kHz
  - THD: < -80 dB at 20 Hz, 50 Hz, 80 Hz
  - Frequency response: +/- 0.5 dB from 5 Hz to 200 Hz
  - No audible hum or buzz with ICEpower powered from mains
  - I2S link stable for 8+ hours continuous operation
- If any of these fail, the fallback is 2x miniDSP 2x4 Balanced, not "debug the custom build."

### Data Design
- The config system is solid conceptually but the ADAU1452 addresses are still in config.json as placeholders. Delete them or move them to config_1452.json. Stale config is how you brick a DSP at 2 AM.

### I'll Concede
- The automation pipeline is a genuine engineering achievement. 2,983 lines of working Python that closes the loop from measurement to correction is not trivial. If the analog build passes bench testing, the total system is superior to any commercial alternative at this price point. I just want to see it proven before declaring victory.

---

## Acton's Take

### Show Me the Data
- **The 38.5W number is wrong for miniDSP and nobody caught it.** POR/15 says 0.9 Vrms (ADAU1701 internal DAC) into ICEpower gain of 19.5x = 17.55 Vrms output = 38.5W into 8 ohm. That calculation is correct for the ADAU1701 internal DAC. It is NOT correct for a miniDSP at 2.0 Vrms output. At 2.0 Vrms: 2.0 * 19.5 = 39 Vrms, power = 39^2 / 8 = 190W. Both the architect and analyst copy-pasted "38.5W" without redoing the math for the different input voltage. That's not analysis. That's transcription.
- The ICEpower 1200AS2 datasheet specifies input sensitivity as 1.0 Vrms for rated output — wait, no. Per the Balanced_Output_Stage.md research doc, the gain is 25.8 dB (19.5x) and rated power is 620W @ 8 ohm, which requires 3.61 Vrms differential input. Single-ended at 2.0 Vrms: 2.0 * 19.5 = 39 Vrms, P = 39^2/8 = 190W. At 0.9 Vrms: 0.9 * 19.5 = 17.55 Vrms, P = 17.55^2/8 = 38.5W. The math is straightforward. Two agents and six advisory voices all missed it.
- **"miniDSP Flex Eight" — show me the product page.** If this product doesn't exist on miniDSP.com, the analyst fabricated the primary competitor. The real candidates are: 2x4 Balanced (2 units, $500), 10x10 HD ($500), DDRC-88BM (~$800). Price the real products or the comparison is fiction.

### The Hardware Is the Platform
- The ICEpower 1200AS2 P105 differential input is the constraint that drives this entire analysis. At 190W single-ended from a miniDSP (2.0 Vrms), you get: per driver 95W, per corner 190W, with +11 dB corner loading that's ~118 dB at 20 Hz. Is 118 dB at 20 Hz enough? The target is 95 dB at the seats. The answer is almost certainly yes. The question isn't "can we get 620W" — it's "do we need 620W?" Run the SPL numbers for 190W and see if it meets the target. If it does, the entire balanced output stage is optional, and the miniDSP 2x4 Balanced at $500 with zero construction becomes very attractive.

### Solve the Problem You Actually Have
- Stop comparing DSP platforms. The DSP is the easy part — any of them can run biquads on sub-bass. The actual problem is: **get enough voltage into the ICEpower to hit your SPL target.** Quantify the SPL target at 10 Hz, 15 Hz, and 20 Hz. Calculate what power is needed. Then determine if 190W (unbalanced) is enough or if you really need 620W (balanced). If 190W is enough, buy two miniDSP 2x4 Balanced, plug them in, and move on. If you need 620W, build the THAT1646 chain. The data decides, not the DSP brand.

### BS Detection
- Six advisory voices all agreed. That's a red flag, not a validation. When 8 people in a room all nod, it means either the answer is truly obvious or nobody pushed back. Given that the 38.5W number is wrong and the primary competitor might not exist, I'm not confident this was the former.
- "100 hours of invested tooling" cited as a reason to stay. That's textbook sunk cost. The tooling exists regardless of the decision. The question is: going forward, what produces the best outcome for the least incremental cost? If the answer is "buy two boxes for $500 and skip 20 hours of perfboard construction," the 100 hours of past Python work don't change that.

### I'll Concede
- Fine — the ADAU1701 is probably still the right call even after correcting the 38.5W error. At $215 all-in with proven automation, it's hard to beat. But the margin is thinner than the analysis suggests. If the Phase 2 bench test reveals noise or reliability issues with the custom analog chain, switching to miniDSP 2x4 Balanced ($500) is the right move, and nobody should feel bad about "wasting" the tooling investment. The tooling isn't wasted — the coefficient math and REW integration work with any DSP. Only the COM transport layer dies.

---

## Bass Head's Take

### More Subs
Not a DSP question. Eight corners, no negotiation. Moving on.

### The Numbers
The 190W unbalanced calculation changes the bass equation:
- At 20 Hz, 190W into 8 ohm per driver: 10*log10(190/1) + 87.7 = **110.5 dB** per driver at 1m
- 8 drivers: +9 dB = 119.5 dB
- Corner loading: +11 dB = 130.5 dB passband (before room effects)
- Sealed rolloff at 20 Hz (Fc ~30 Hz, -6 dB): ~124.5 dB at 20 Hz in-room

Is 124.5 dB at 20 Hz in-room enough? The -10 dB reference target is 95 dB at the seats. Even with 15 dB of room loss from corners to seats, you're at ~110 dB. That's +15 dB above target. You have headroom even at 190W.

At 10 Hz, excursion (28mm Xmax) is the limit, not power. Whether you have 190W or 620W available doesn't matter — the driver bottlenecks before the amp does. So the balanced output stage buys you headroom at 15-25 Hz where power (not excursion) is the limiting factor, and the margin is ~12 dB (190W vs 620W). That's real headroom, but it's not the difference between "works" and "doesn't work" — it's the difference between "hits target with 15 dB margin" and "hits target with 20 dB margin."

### What's the Extension?
At sub-15 Hz, the extension story doesn't change with DSP platform. Both ADAU1701 and miniDSP (via biquad) can set a 5 Hz HPF. The driver's Xmax (28mm) is the binding constraint below ~13 Hz regardless. The ADAU1701's advantage is convenience of setting that filter, not capability of the filter itself.

The real sub-20 Hz concern is: can the miniDSP biquad mode handle a 5 Hz HPF coefficient without quantization issues? The miniDSP uses 28.28 fixed-point (56-bit) — that's actually more precise than the ADAU1701's 5.23 (28-bit). The coefficient precision is not a problem. The UX of entering them is.

### I'll Concede
Yeah, okay — 190W unbalanced might be enough. It pains me to say it, but the numbers don't lie. At 20 Hz you're 15 dB above target even without the balanced stage. The balanced stage buys you another 5 dB of headroom at 15-25 Hz, which is nice but not essential. If the Phase 2 bench test shows the custom analog chain is noisy or unreliable, dropping to 190W unbalanced from miniDSP 2x4 Balanced is a legitimate fallback. The subs will still deliver reference bass. Just not weapons-grade. Well, maybe still weapons-grade — 110 dB at the seats at 20 Hz is a weapon.

---

## Cost Cutter's Take

### What Does This Cost?
The cost comparison needs correction:

| Option | Hardware | Balanced Stage | Build Labor (est) | Total Cash | Total w/Labor @$50/hr |
|--------|----------|---------------|-------------------|------------|----------------------|
| ADAU1701 POR | $80 (DSP+DAC) | $135 (THAT1646) | ~15 hrs soldering/wiring | **$215** | **$965** |
| 2x miniDSP 2x4 Balanced | $500 | $0 | ~1 hr (cables) | **$500** | **$550** |
| miniDSP 10x10 HD + BAL | $500 + $135 | included in total | ~10 hrs | **$635** | **$1,135** |

The previous analysis showed ADAU1701 at $215 vs miniDSP at $895. The corrected comparison (using the real miniDSP 2x4 Balanced option) is $215 vs $500. That's a $285 difference, not $660-$680.

### What Does This Buy?
- $285 buys: zero construction risk, professional build quality, XLR balanced output, warranty, swap-a-box repairs, and 15+ hours of your weekend back.
- $285 loses: automated coefficient upload (must enter manually or script XML import), and you pay cash instead of time.

### Where's the Fat?
The previous analysis had fat in the comparison itself:
- It compared against a $700 product that may not exist (Flex Eight)
- It used 38.5W as the unbalanced power when miniDSP delivers 190W
- It valued 100 hours of past development as if it were at risk (it's not — the coefficient math transfers)

The ADAU1701 path itself is lean at $215 cash. But add honest labor cost (15 hrs @ $50/hr = $750) and the miniDSP 2x4 Balanced at $500 is the cheaper option in total cost.

Andy builds for fun — if soldering I2S wiring and building THAT1646 boards is entertainment, the labor cost is $0 and the ADAU1701 wins at $215. If it's a chore, it doesn't.

### The Cut List
If the ADAU1701 path is chosen AND budget needs cutting:
1. Skip spare APM2 — $40 saved
2. Skip spare THAT1646 ICs (8 instead of 10) — $11 saved
3. Consider skipping balanced output for tactile-only channels (shakers don't need 620W) — $30-40 saved

If switching to miniDSP 2x4 Balanced:
1. No cuts possible — $500 is the minimum for 2 units

### I'll Concede
The ADAU1701 at $215 cash is genuinely cheap for what it delivers. If Andy values the build process and has confidence in the analog chain, it's the right call. But the analysis overstated the cost gap by $375 (comparing against a product that may not exist at $700+ instead of the real alternative at $500). The honest gap is $285, not $660. At $285, the decision is closer than the analysis suggests and depends on whether build time has value.

---

## Summary of Critical Findings

1. **The 38.5W figure is wrong for miniDSP.** The actual unbalanced power from a miniDSP (2.0 Vrms) is ~190W, not 38.5W. This changes the cost-benefit analysis significantly.

2. **The miniDSP Flex Eight may not be a real product.** If fabricated, the entire cost comparison is built on fiction.

3. **The real competitor is 2x miniDSP 2x4 Balanced at $500**, not a $700-$895 phantom product. The gap is $285, not $660.

4. **190W may be sufficient.** Run the SPL calculations at 190W before assuming 620W is mandatory. If 190W meets the target with acceptable headroom, the balanced output stage is optional.

5. **The sunk cost framing is misleading.** Only ~480 lines of transport code are ADAU-specific. The other ~2,500 lines transfer to any platform.

6. **Unanimous agreement from 8 voices with uncaught factual errors is a process smell.** The framework should have caught the 38.5W misapplication.

**Final verdict: PROCEED WITH CHANGES.** Fix the factual errors, verify the Flex Eight exists, run SPL calculations at 190W, and properly evaluate 2x miniDSP 2x4 Balanced as the true alternative. The ADAU1701 probably still wins, but on thinner margins than presented.
