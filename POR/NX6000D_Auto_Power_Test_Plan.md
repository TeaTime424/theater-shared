# NX6000D Auto-Power Test Plan

**Status:** PRE-TEST — awaiting bench validation  
**Date:** 2025-02-14  
**Supersedes:** Portions of `NX6000_12V_Trigger_Mod.md` (internal relay mod may not be needed)

---

## Background

AVS Forum user DavidinGA confirmed running an NX6000D via a 40A solid-state relay that interrupts AC power using the 12V trigger from his AVR. No internal modifications. No thump issues reported. He has used this approach across Sony, Onkyo, Denon, and Marantz processors.

Source: AVS Forum — "New Behringer NX Series" thread, page 28.

The NX6000D uses a momentary front-panel power button that toggles an internal latching relay. A latching relay holds its mechanical position with no power applied. This means if the amp was ON when AC is removed, the relay remains in the ON position. When AC is restored, the amp's standby supply boots, sees the relay in the ON position, and proceeds through its normal soft-start sequence (DSP init → limiters → output stage enable).

If confirmed, this eliminates the need for any internal modification. The amp is controlled entirely by switching AC power externally via the AV10's 12V trigger, identical to the RCS650-6 outdoor system.

---

## Test 1: AC Restore Behavior (Primary)

**Goal:** Confirm the NX6000D auto-powers-on when AC is restored after being in the ON state.

**Equipment needed:**

- NX6000D (no speakers connected — test with open load)
- AC power cable
- Eyes and ears

**Procedure:**

1. Plug in the NX6000D and let it sit in standby
2. Press the front panel power button — amp boots, LCD shows startup, power LED illuminates
3. Wait for full boot (LCD settles, fans spin up, signal LEDs active) — approximately 5-10 seconds
4. **Pull the IEC power cable from the rear of the amp**
5. Wait 15 seconds (let SMPS caps fully discharge)
6. **Plug the IEC cable back in**
7. Observe what happens

**Expected outcomes:**

| Result | Meaning | Next Step |
|--------|---------|-----------|
| Amp boots up on its own (LCD lights, fans spin, power LED on) | Latching relay confirmed — AC restore works | **Done. Use IoT Power Relay. No internal mod needed.** |
| Amp stays in standby (power LED off or dim, no LCD) | Relay resets to OFF on AC loss, or MCU defaults to standby | Proceed to Test 2 |
| Amp behaves erratically (protect mode, flashing LEDs) | Power cycling issue | Repeat test. If consistent, proceed to Test 2 |

**Run this test 3 times** to confirm repeatable behavior.

---

## Test 2: Held Button on AC Restore (Fallback Validation)

**Goal:** If Test 1 fails, determine whether the MCU reads button state on boot (level-triggered) vs. only responding to transitions (edge-triggered).

**Procedure:**

1. With amp unplugged, **press and hold the front panel power button**
2. While holding the button, **plug in the IEC cable**
3. Continue holding for 5 seconds after plug-in
4. Observe whether the amp boots

**Expected outcomes:**

| Result | Meaning | Next Step |
|--------|---------|-----------|
| Amp boots while button is held | MCU reads button state on boot — permanent bridge mod works | Proceed to Option B below |
| Amp does not boot until button is released and pressed again | MCU is edge-triggered only — needs pulse circuit | Proceed to Option C below |
| Amp boots on plug-in then immediately shuts off | MCU detects sustained press as "off" toggle | Proceed to Option C below |

---

## Resolution Paths

### Option A: IoT Power Relay (if Test 1 passes)

Zero internal modification. Identical to the RCS650-6 outdoor system.

**Setup:**

1. Press NX6000D power button ON — leave it on permanently
2. Plug NX6000D into IoT Power Relay "normally off" outlet
3. Connect AV10 Trigger Out → IoT Power Relay DC input (cut 3.5mm mono cable, tip = +, sleeve = −)
4. AV10 powers on → trigger goes 12V → IoT relay energizes → AC flows → NX6000D boots via soft-start
5. AV10 powers off → trigger drops → IoT relay opens → AC cut → NX6000D loses power

**Product:** Digital Loggers IoT Power Relay  
**Already purchased for:** RCS650-6 outdoor system  
**Second unit needed:** Yes, one per amp (or one per pair if using a power strip on the relay's outlet)

**Thump concern:** DavidinGA reports no thump. The NX6000D's SMPS and output stage have inherent soft-start behavior on AC restore. The DSP initializes and enables the output stage in sequence even on a cold boot. The output muting relay inside the amp doesn't close until the startup sequence completes, so speakers are isolated during boot.

**Capacity concern:** NX6000D draws ~5-6A steady-state at 120V for sub duty. Peak transients during heavy bass could reach 10-12A. The IoT relay's 12A thermal breaker is adequate for typical home theater use. DavidinGA uses a 40A SSR for extra headroom — this is a belt-and-suspenders option documented below.

**Higher-headroom alternative — DIY SSR box:**

Build a simple outlet box with a solid state relay, identical to the well-documented AVS Forum guide by notNYT:

| Component | Part | Price |
|-----------|------|-------|
| Omron G3NE-220T-US-DC12 (240V/20A SSR, 12VDC trigger) | Mouser | ~$16 |
| Metal square box + single-gang cover + 20A outlet | Home Depot | ~$8 |
| 12-gauge SJOOW cable + NEMA 5-15P plug | Home Depot | ~$10 |
| 3.5mm to bare wire (trigger cable) | Amazon / on-hand | ~$3 |
| Quick disconnects + hardware | Home Depot | ~$4 |
| **Total** | | **~$41** |

Reference: AVS Forum — "Automatically Powering on Pro Amps via Relay (guide w/ pics)" thread.

### Option B: Permanent Button Bridge + IoT Relay (if Test 1 fails, Test 2 passes)

Minimal internal mod — solder one jumper wire across the power button contacts, then use IoT Power Relay for AC control.

**Internal mod procedure:**

1. Disconnect AC, wait 5 minutes for cap discharge
2. Remove top cover
3. Locate power button — trace from front panel to PCB
4. Identify the two PCB pads that short when button is pressed (verify with multimeter in continuity mode)
5. Solder a short jumper wire across those two pads
6. Reassemble

**Result:** Amp always boots when AC is applied (MCU sees "button pressed" on every power-up). IoT relay controls AC. Front panel button no longer toggles — power state is entirely controlled by AC presence.

**Trade-off:** You lose the ability to manually power off via the front button. Power off = unplug or kill the IoT relay. For a rack-mounted amp behind an AT screen controlled entirely by the AV10, this is acceptable.

### Option C: Edge-Triggered Pulse Circuit (if both Test 1 and Test 2 fail)

This is the most complex option and should only be pursued if the MCU requires a momentary pulse edge to toggle power state.

**Concept:** Detect the rising edge of AC restore (or an internal standby rail) and generate a single ~400ms pulse to momentarily short the power button contacts via an optocoupler.

**Key components:**

- TLC555 CMOS monostable timer (powered from amp's standby rail)
- PC817 optocoupler (galvanic isolation to button pads)
- RC differentiator for edge detection
- 3.5mm panel-mount jack on rear panel for external trigger

**Estimated complexity:** ~$10 in parts, perfboard build, 4 internal wire connections (trigger in ×2, standby power ×2, button pads ×2). Requires identifying the standby voltage rail inside the amp.

**Full design is documented in the conversation history dated 2025-02-14.** If this option becomes necessary, a detailed schematic and build guide will be created.

---

## Decision Matrix

| Test 1 Result | Test 2 Result | Solution | Complexity | Internal Mod? |
|---------------|---------------|----------|------------|---------------|
| PASS | — | Option A: IoT Relay only | None | No |
| FAIL | PASS | Option B: Button bridge + IoT Relay | 1 solder joint | Minimal |
| FAIL | FAIL | Option C: Pulse circuit + IoT Relay | Perfboard build | Yes |

---

## Scaling to 6 Amplifiers

The current POR calls for 6× NX6000D amps (4 sub channels + 2 additional). Regardless of which option is selected:

**If Option A or B:** Each amp needs its own AC switching device (IoT relay or SSR box). The AV10 has 2× 12V trigger outputs at 150mA each. Options for distributing to 6 amps:

- **IoT relays:** Each draws ~30mA from trigger. 5 units × 30mA = 150mA — right at limit for one trigger output. Split across both AV10 trigger outputs (3 per output) for margin.
- **SSR boxes:** Each SSR trigger input draws ~10-15mA. 6 units easily within one trigger output's capacity.
- **Trigger distribution box:** Use the existing design from `NX6000_12V_Trigger_Mod.md` to buffer one trigger output to 6 buffered outputs, each driving an IoT relay or SSR.

**If Option C:** The existing trigger distribution box design in `NX6000_12V_Trigger_Mod.md` applies directly. Each amp gets the internal pulse circuit, fed by the distribution box.

---

## Related Documents

- [NX6000_12V_Trigger_Mod.md](NX6000_12V_Trigger_Mod.md) — Original internal relay mod design (fallback reference)
- [Behringer_NX6000_Reference.md](Behringer_NX6000_Reference.md) — Amplifier specifications and DSP config
- [06_Electronics_and_Control.md](06_Electronics_and_Control.md) — System integration context

---

## Version History

| Rev | Date | Changes |
|-----|------|---------|
| 1.0 | 2025-02-14 | Initial release — AC restore test plan based on AVS Forum findings |
