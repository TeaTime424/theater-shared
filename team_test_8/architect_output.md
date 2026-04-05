# Architecture: DSP Platform Evaluation — ADAU1701 (Current POR) vs miniDSP Alternatives

**Date:** 2026-03-19
**Author:** Architect (with advisory panel)
**Scope:** Evaluate whether a miniDSP product should replace the current 2x ADAU1701 (APM2) DSP architecture for the 4-input / 8-output subwoofer processing requirement.

---

## Current State

### What Exists Today

The POR (Rev 2.0, updated 2026-03-18) specifies **2x Wondom APM2 boards (ADAU1701)** with external PCM5102 DACs and THAT1646 balanced line drivers. This replaced an earlier ADAU1452 research design, which itself replaced the Dayton DSP-408.

**POR document:** `POR/15_DSP_Subwoofer_Processing.md`

**Current signal chain:**
```
Denon AVR-X6800H (4 sub pre-outs, RCA, 2.0 Vrms)
    |
    v
2x Wondom APM2 (ADAU1701, 2-in/4-out each)
    |  (I2S)
    v
4x PCM5102 DACs (2.1 Vrms)
    |
    v
8x THAT1646 balanced line drivers (3.54 Vrms differential)
    |
    v
4x ICEpower 1200AS2 (2-ch each, 620W/ch @ 8 ohm)
    |
    v
8x UMII18-22 corner subs (4 stacked columns, 2 drivers each, 8 ohm series)
+ tactile/nearfield on remaining channels
```

**Existing tooling:**
- `tools/dsp/client_1701_com.py` — ADAU1701 COM client via SigmaStudio
- `tools/dsp/client.py` — ADAU1452 COM client (written but target hardware changed)
- `tools/dsp/config_1701.json` — ADAU1701 config
- `tools/dsp/config.json` — ADAU1452 config (placeholder addresses)
- `tools/dsp/coefficients.py` — Biquad coefficient math (scipy)
- `tools/dsp/eq.py` — Auto-correction EQ engine
- `tools/dsp/rew.py` — REW REST API integration
- SigmaStudio 4.7, ICP5 programmer — on hand

**Budget allocated for DSP:** $64 (2x APM2 + 2x PCM5102) + ~$135 (THAT1646 + passives) = **$215 total**

### The Actual 4:8 Routing Requirement

**4 inputs** = AVR-X6800H sub pre-outs (Sub FL, Sub FR, Sub RL, Sub RR). These are Dirac-optimized, independent per-corner feeds.

**8 outputs:**

| Output | Source | Processing | Destination |
|--------|--------|------------|-------------|
| 1 | IN 1 (Sub FL) | HPF 5Hz + PEQ x10 | Corner FL subs (2x UMII18-22) |
| 2 | IN 2 (Sub FR) | HPF 5Hz + PEQ x10 | Corner FR subs (2x UMII18-22) |
| 3 | IN 1+2 sum | HPF + LPF 80Hz + PEQ x10 | Front nearfield (deferred) |
| 4 | IN 1+2 sum | BPF 10-80Hz + PEQ x10 | Front tactile (4x Aura) |
| 5 | IN 3 (Sub RL) | HPF 5Hz + PEQ x10 | Corner RL subs (2x UMII18-22) |
| 6 | IN 4 (Sub RR) | HPF 5Hz + PEQ x10 | Corner RR subs (2x UMII18-22) |
| 7 | IN 3+4 sum | HPF + LPF 80Hz + PEQ x10 | Rear nearfield (deferred) |
| 8 | IN 3+4 sum | BPF 10-80Hz + PEQ x10 | Rear tactile (4x Aura) |

Key operations: HPF at 5 Hz, LPF at 80 Hz, BPF 10-80 Hz, 10-band PEQ per output, gain trim, mono summing for derived channels. No crossover (AVR handles that). No delay required between corner subs (all corner-loaded, equal path length from AVR).

---

## ADAU1701 (Current POR) Capability Assessment

### What It Does Well

| Capability | Rating | Notes |
|------------|--------|-------|
| Filter to DC | Yes | HPF at 5 Hz, PEQ at any frequency — the reason DSP-408 was rejected |
| 4:8 routing | Yes | 2 boards x (2-in / 4-out), internal summing for derived channels |
| PEQ bands | 10/ch | 304/1024 instructions used (30%), 70% headroom |
| Automated calibration | Yes | Full Python pipeline exists: REW + scipy + COM transport |
| Self-boot | Yes | EEPROM, runs standalone after calibration |
| Sub-20 Hz performance | Full | No frequency floor, no infrasonic derating |
| Balanced output | Yes | Via external PCM5102 + THAT1646 stage |
| Full amp power | Yes | 3.54 Vrms differential -> 620W/ch @ 8 ohm |

### What It Does Poorly

| Limitation | Impact | Severity |
|------------|--------|----------|
| 2 boards required | More wiring, 2 SigmaStudio projects, 2 EEPROM saves | Medium |
| ICP5 must be disconnected for I2S | Annoyance during recalibration — must disconnect/reconnect programmer | Medium |
| External DAC + balanced driver stage | 4x PCM5102 + 8x THAT1646 = custom analog build | High complexity |
| No GUI for quick adjustments | Must use Python CLI or SigmaStudio | Low (feature, not bug) |
| Chinese board analog quality | Skimped caps on APM2 — but bypassed via I2S to external DAC | Mitigated |

### Total Component Count (Current POR)

| Component | Qty | Purpose |
|-----------|-----|---------|
| Wondom APM2 (ADAU1701) | 2 | DSP processing |
| PCM5102 DAC modules | 4 | I2S to analog conversion |
| THAT1646 ICs | 8 (+2 spare) | Balanced line drivers |
| Coupling caps, bypass caps, sockets | ~50 pcs | Analog stage |
| Perfboards | 4 | THAT1646 mounting |
| JST PH connectors | 4 sets | ICEpower P105 mating |
| **Total unique boards/modules** | **10** | |

---

## miniDSP Product Evaluation

### Candidate Products

#### 1. miniDSP 2x4 HD ($200)

| Spec | Value | Verdict |
|------|-------|---------|
| I/O | 2-in / 4-out | Insufficient — need 4:8. Would need 2 units. |
| Min filter freq | ~10 Hz (custom biquad mode) | Marginal — 5 Hz HPF requires manual biquad entry |
| PEQ | 10/ch (biquad mode) | Adequate |
| Output voltage | 2.0 Vrms (unbalanced RCA) | Too low — ICEpower needs 3.54 Vrms differential for full power. Same problem as raw ADAU1701. |
| Balanced output | No | Would still need THAT1646 stage or accept 38.5W/ch |
| Biquad format | Inverted a1/a2 signs vs standard | Known quirk, documented in project |
| Automation | No API, manual GUI only | No auto-calibration possible |
| Latency | ~1.5 ms | Fine |
| Cost for 4:8 | 2x $200 = $400 | More expensive than ADAU1701 POR |

**Verdict: Rejected.** 2 units needed, no balanced output, no automation API, higher cost, worse sub-20 Hz support.

#### 2. miniDSP 2x4 Balanced ($250)

| Spec | Value | Verdict |
|------|-------|---------|
| I/O | 2-in / 4-out balanced | Still need 2 units for 4:8 |
| Output voltage | 4.0 Vrms (balanced XLR) | Excellent — exceeds ICEpower requirement |
| Min filter freq | Same biquad limitations | Marginal |
| Automation | No API | No auto-calibration |
| Cost for 4:8 | 2x $250 = $500 | Significantly more expensive |

**Verdict: Interesting for output voltage.** Solves the balanced output problem but doubles the cost, still no API, still need 2 units.

#### 3. miniDSP Flex (2x2 or 2x4) ($250-$400)

| Spec | Value | Verdict |
|------|-------|---------|
| I/O | 2-in / 2-out or 2-in / 4-out | Insufficient for 4:8 |
| Dirac integration | Dirac Live capable | Redundant — AVR-X6800H already runs Dirac |
| Digital I/O | USB, SPDIF, Toslink | Irrelevant — analog feeds from AVR |
| Cost for 4:8 | 2x $400 = $800 | Expensive |
| Automation | No public API | No auto-calibration |

**Verdict: Rejected.** Wrong product class — designed for stereo/headphone use. Dirac integration is redundant.

#### 4. miniDSP SHD ($1,100)

| Spec | Value | Verdict |
|------|-------|---------|
| I/O | 2-in / 4-out (unbalanced) | Insufficient |
| Dirac | Built-in Dirac Live | Redundant |
| Streaming | Network streamer, Roon endpoint | Irrelevant for sub processing |
| Balanced | No | Same voltage problem |
| Cost for 4:8 | 2x $1,100 = $2,200 | Absurd |

**Verdict: Rejected.** Wrong product entirely. This is a streamer/preamp, not a bass management DSP.

#### 5. miniDSP 10x10 HD ($500)

| Spec | Value | Verdict |
|------|-------|---------|
| I/O | 10-in / 10-out (unbalanced) | Covers 4:8 in one box |
| Channels | 4 input, 10 output processing | Adequate |
| Min filter freq | 20 Hz GUI, ~10 Hz biquad mode | Marginal for 5 Hz HPF |
| PEQ | 10/ch | Adequate |
| Output voltage | 2.0 Vrms RCA | Too low — still need balanced stage |
| Balanced | No | Same problem |
| Automation | No public API | No auto-calibration |
| Latency | ~1.5 ms | Fine |

**Verdict: Best miniDSP candidate.** Single box covers the routing. But still no balanced output, no API, marginal sub-20 Hz. Would need THAT1646 stage added = ~$565 total + custom build anyway.

#### 6. miniDSP Flex HT ($600)

| Spec | Value | Verdict |
|------|-------|---------|
| I/O | 4-in / 8-out | Exact match |
| Balanced | No (unbalanced RCA) | Still need balanced stage |
| Dirac | Optional license | Redundant |
| Min filter freq | GUI limited, biquad mode extends | Marginal |
| Automation | No public API | No auto-calibration |

**Verdict: Right I/O count but wrong feature set.** $600 + balanced stage, no API.

### miniDSP Summary Table

| Product | I/O Match | Balanced Out | Sub-20Hz | API | Cost (for 4:8) | + Balanced Stage |
|---------|-----------|-------------|----------|-----|----------------|-----------------|
| 2x4 HD | 2 units | No | Marginal | No | $400 | ~$535 |
| 2x4 Balanced | 2 units | Yes | Marginal | No | $500 | $500 |
| 10x10 HD | 1 unit | No | Marginal | No | $500 | ~$635 |
| Flex HT | 1 unit | No | Marginal | No | $600 | ~$735 |
| **ADAU1701 POR** | **2 units** | **Yes (ext)** | **Full** | **Yes** | **$215** | **$215 (included)** |

---

## Proposed Decision: Keep ADAU1701

### Rationale

1. **Cost:** $215 vs $500-$735 for equivalent miniDSP capability. The ADAU1701 path is 2-3x cheaper even including the balanced output stage.

2. **Sub-20 Hz:** No miniDSP product filters to DC. The 5 Hz HPF and 10 Hz tactile BPF are core requirements that drove the original DSP-408 rejection. miniDSP's biquad mode can approximate this but requires manual coefficient calculation and entry — exactly what the Python pipeline automates on the ADAU1701.

3. **Automation:** The existing `tools/dsp/` pipeline provides closed-loop auto-calibration: measure -> compute -> write -> re-measure. No miniDSP product has a public API. Manual GUI tuning for 8 outputs x 10 PEQ bands = 80 filters is untenable.

4. **Balanced output:** Both the ADAU1701 and miniDSP (unbalanced models) need the THAT1646 stage. The ADAU1701 already has this designed and costed. The miniDSP 2x4 Balanced solves this but at $500 for only 4 outputs.

5. **Tooling investment:** The COM client, coefficient math, REW integration, and config system are built and tested. Switching to miniDSP discards this and replaces it with manual GUI work.

### When miniDSP Would Win

- If you didn't need sub-20 Hz filtering (but you do — tactile at 10 Hz, subsonic protection at 5 Hz)
- If you didn't care about automated calibration (but with 80 PEQ filters, you should)
- If the balanced output problem didn't exist (but ICEpower requires 3.54 Vrms differential)
- If you valued plug-and-play over capability (valid for some users, not this build)

---

## Dependencies

1. APM2 board #2 must be ordered (~$40 from Sure Electronics)
2. PCM5102 x4 and THAT1646 x10 ordered per BOM in POR/15
3. SigmaStudio project designed for each APM2 with named blocks per POR/15 Section 5
4. Parameter addresses exported from .params files after compile
5. Config files updated with actual addresses
6. ICP5 must be disconnected during normal operation (I2S conflict)

---

## Interfaces

### Signal Flow (No Change from POR)

```
AVR-X6800H Sub FL ─── RCA ──> APM2 #1 IN1 ──> I2S ──> PCM5102 #1 ──> THAT1646 ──> ICEpower 1200AS2 #1 Ch.A ──> Corner FL
AVR-X6800H Sub FR ─── RCA ──> APM2 #1 IN2 ──> I2S ──> PCM5102 #1 ──> THAT1646 ──> ICEpower 1200AS2 #1 Ch.B ──> Corner FR
                                      (sum) ──> I2S ──> PCM5102 #2 ──> THAT1646 ──> ICEpower 1200AS2 #3 Ch.A ──> NF Front
                                      (sum) ──> I2S ──> PCM5102 #2 ──> THAT1646 ──> ICEpower 1200AS2 #3 Ch.B ──> Tactile Front

AVR-X6800H Sub RL ─── RCA ──> APM2 #2 IN1 ──> I2S ──> PCM5102 #3 ──> THAT1646 ──> ICEpower 1200AS2 #2 Ch.A ──> Corner RL
AVR-X6800H Sub RR ─── RCA ──> APM2 #2 IN2 ──> I2S ──> PCM5102 #3 ──> THAT1646 ──> ICEpower 1200AS2 #2 Ch.B ──> Corner RR
                                      (sum) ──> I2S ──> PCM5102 #4 ──> THAT1646 ──> ICEpower 1200AS2 #4 Ch.A ──> NF Rear
                                      (sum) ──> I2S ──> PCM5102 #4 ──> THAT1646 ──> ICEpower 1200AS2 #4 Ch.B ──> Tactile Rear
```

### Software Interface

```
Python CLI (tools/dsp/) ──> SigmaStudio COM ──> ICP5 (I2C) ──> ADAU1701
                                                                    |
                                                              (self-boot from EEPROM for standalone)
```

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| APM2 board failure (no spare) | Low | High — one board = 4 outputs offline | Order 3rd APM2 as spare ($40) |
| THAT1646 build quality (DIY perfboard) | Medium | Medium — noise, crosstalk | Test each board before install; use DIP sockets |
| ICP5 accidentally left connected (kills I2S) | Medium | Medium — no audio output | Label cable "DISCONNECT AFTER PROGRAMMING" |
| PCM5102 module DOA | Low | Low — $5 each, easy to swap | Buy 1-2 spares |
| SigmaStudio COM server instability | Low | Low — only needed during calibration | Save to EEPROM frequently |
| 2 separate SigmaStudio projects drift | Medium | Low — each board is independent | Version control the .dspproj files |

---

## Open Questions

1. **5th ICEpower amp allocation:** Current POR shows 5 ICEpower 1200AS2. The 4 active + 1 spare mapping is clear for corner subs (amps 1-2) and nearfield/tactile (amps 3-4). Is amp 5 purely a spare, or should it be pre-allocated for the deferred nearfield expansion?

2. **EEPROM write protection:** The APM2 WP pin must be grounded during EEPROM writes. Should the build include a physical switch for this, or is it acceptable to use a jumper?

3. **Config divergence:** POR/06_Electronics_and_Control.md still references DSP-408 + NX6000D amplification (Rev 7.0 baseline). POR/15 references ADAU1701 + ICEpower (Option D). These documents disagree. Which is the source of truth?

---

## New Grad's Take

### What I'd Change
- **CamillaDSP on a Pi:** A Raspberry Pi 4 running CamillaDSP (open source, Rust-based) can do 4-in/8-out at 48 kHz with unlimited PEQ, FIR filters, crossovers, and a REST API for automation. It replaces the ADAU1701 + PCM5102 + THAT1646 stack with a single-board computer + a multi-channel USB audio interface (Behringer UMC1820 at $200, 8 outputs, balanced TRS). Total: ~$280 and you get FIR filters, a web GUI, and a proper API. The ADAU1701 approach is 2005-era DSP engineering.

### What's Outdated Here
- **SigmaStudio COM automation.** This is a Windows-only .NET COM server from 2008. The Python client uses `win32com.client` which is a dead-end technology. CamillaDSP's REST API is cross-platform and can be driven from any language.
- **Fixed-point biquad math.** The ADAU1701 uses 5.23 fixed-point. CamillaDSP uses 64-bit float. No coefficient quantization errors, no manual fixed-point conversion, no sign-negation quirks.
- **EEPROM self-boot.** Self-boot is nice but CamillaDSP starts as a systemd service and is equally autonomous. Plus you can SSH in and tweak filters without a physical programmer.

### Risk I'm Willing to Take
- The UMC1820 adds a USB audio path and a consumer-grade DAC into the sub signal chain. The ADAU1701 path is lower-latency and has fewer failure points. But for sub-bass (5-80 Hz), the UMC1820's specs are more than adequate, and the software flexibility is worth the tradeoff.

### I'll Concede
- The ADAU1701 + EEPROM approach has zero boot time and zero software dependencies in steady state. A Pi running CamillaDSP takes 15-30 seconds to boot and depends on Linux not corrupting the SD card. For a set-and-forget theater, the ADAU1701's embedded reliability is genuinely superior. The Senior is right about this one.

---

## Senior's Take

### Keep It Simple
- The ADAU1701 POR has 10 separate modules (2 DSP boards, 4 DACs, 4 balanced driver boards) connected by I2S digital wiring and analog signal paths. That's a lot of solder joints and potential failure points for what is fundamentally "take 4 signals, filter them, output 8." A miniDSP 2x4 Balanced (2 units, $500) plugs in with XLR cables and works. No soldering. No perfboard. No I2S wiring. No THAT1646 power rail tapping. You lose the automation and the sub-5Hz filtering — but you gain the ability to troubleshoot at 2 AM by swapping a box, not debugging a custom analog chain.

### Contracts & Interfaces
- The APM2-to-PCM5102 I2S interface is the weakest link. It requires disconnecting the ICP5 programmer, specific pin mapping to J4 header, and correct SDATA_OUT routing in SigmaStudio. If this breaks, debugging requires an oscilloscope and SigmaStudio knowledge. A miniDSP box has one contract: RCA in, signal out.

### Test First
- Before committing to 8 THAT1646 boards, build ONE complete signal path (APM2 -> PCM5102 -> THAT1646 -> ICEpower) and measure it with REW. Verify: flat response 5-200 Hz, noise floor below -90 dBFS, no oscillation, no ground loop hum. If that single path works clean, build the other 7. This is Phase 2 in the POR and it's the right sequence.

### Data Design
- The config system is solid. `config_1701.json` with per-channel PEQ addresses, correction limits, and output mapping is the right data structure. The placeholder addresses need to be replaced with real values from `.params` export — that's a known TODO, not a design flaw.

### I'll Concede
- The automation pipeline is genuinely valuable. Manually tuning 80 PEQ filters in a miniDSP GUI is tedious and error-prone. The Python -> COM -> DSP -> REW closed loop is real engineering and will save hours during calibration. The New Grad's CamillaDSP suggestion makes the same argument from a different direction — automation matters. I just want to see the analog path proven before building 8 of them.

---

## Acton's Take

### Show Me the Data

The actual data transformation is:

**Input:** 4 analog signals, 2.0 Vrms, 5-120 Hz content, from AVR sub pre-outs.

**Transform per corner sub output (4 of 8):**
1. ADC: analog -> 28-bit digital (5.23 fixed-point on ADAU1701)
2. HPF: 2nd-order Butterworth at 5 Hz. Five biquad coefficients. One multiply-accumulate operation per sample per coefficient = 5 MACs.
3. PEQ x10: Ten 2nd-order biquads in series. 50 MACs total.
4. Gain: One multiply. 1 MAC.
5. DAC: digital -> analog (PCM5102, 24-bit, 2.1 Vrms)
6. Balanced driver: analog gain x2 (THAT1646, 4.2 Vrms differential, trimmed to 3.54 Vrms)

Total per corner output: 56 MACs per sample at 48 kHz. The ADAU1701 does 1024 instructions per sample. Four corner outputs = 224 instructions. That's 22% utilization. The math works.

**Transform per derived output (4 of 8):**
Same as above plus: sum two inputs (1 add), add LPF (another 5-MAC biquad for 2nd-order, or 12 MACs for 4th-order LR). Marginal cost.

**Total data throughput:** 4 x 48,000 samples/sec x 28 bits = 5.4 Mbit/sec in, 10.8 Mbit/sec out. This is trivial for any DSP made after 1995.

The question is not whether the ADAU1701 can do the math. It can. The question is whether the analog signal chain around it (ADC -> DSP -> I2S -> external DAC -> balanced driver) introduces enough noise, distortion, or failure modes to matter.

### The Hardware Is the Platform

The platform constraint that actually matters: **ICEpower 1200AS2 needs 3.54 Vrms differential input for full power.** Everything in this analysis flows from that one number. If you could accept 38.5W/ch (unbalanced direct), the entire THAT1646 stage disappears and the build is trivially simple. But 38.5W into an UMII18-22 at 8 ohm is 6.2% utilization. You bought a 620W amplifier channel. Use it.

The miniDSP 2x4 Balanced is the only product that solves this without custom analog work. At $250/unit x 2 = $500, it's more expensive than the ADAU1701 path ($215) but eliminates all custom analog construction. That tradeoff has a real dollar value if you account for build time.

### Solve the Problem You Actually Have

You have 4 signals that need filtering and routing to 8 amp channels. The filters are: one 2nd-order HPF per output, ten 2nd-order PEQ per output, one LPF for derived channels. That's it. The "4x8 routing matrix" in the research docs is theater — the actual routing is fixed: input 1 -> output 1, input 2 -> output 2, inputs 1+2 summed -> outputs 3+4. You don't need a matrix. You need hard-wired signal paths with filter blocks.

### BS Detection

The research documents (`ADAU1452_Signal_Chain_Design.md`, `DIY_DSP_4x8_Design.md`) were written for a Raspberry Pi + SPI + ADAU1452 + CS42448 architecture that no longer exists. The POR moved to ADAU1701 + COM + I2S + PCM5102. Those research docs are stale. They reference NX6000D amplifiers (also replaced by ICEpower 1200AS2). They reference Marantz AV10 (replaced by Denon AVR-X6800H). Three layers of architecture that have been superseded but the documents remain in the repo giving contradictory guidance.

POR/06_Electronics_and_Control.md still references DSP-408 and NX6000D. POR/15 references ADAU1701 and ICEpower. The budget doc (team_test_7/06_budget.md) shows 2x APM2 + 2x PCM5102 at $64, which is the ADAU1701 path — correct. But POR/06 says DSP-408 at $250. That's a $186 discrepancy and a factual contradiction in the plan of record.

### I'll Concede

Fine — the ADAU1701 is the right call on capability per dollar. $215 for 4:8 with sub-5Hz filtering, automated calibration, and balanced output is genuinely hard to beat. But the reason it's right is the ICEpower input spec (3.54 Vrms differential), not the DSP capability. Any DSP can run biquads. The ADAU1701 wins because its I2S output feeds an external DAC chain that reaches the voltage the amplifier needs. That's an analog engineering win, not a DSP win.

---

## Bass Head's Take

### More Subs
Eight corners is the right number. The DSP choice doesn't change that. What matters is: does the DSP let the subs do their job down to 10 Hz without getting in the way?

### The Numbers
The ADAU1701 HPF at 5 Hz, Butterworth 2nd order: -0.01 dB at 20 Hz, -0.1 dB at 10 Hz. That's essentially transparent through the entire sub-bass range. A miniDSP 2x4 HD in biquad mode can approximate this, but its GUI minimum is ~10 Hz, and the biquad coefficient entry is manual with inverted a1/a2 signs (documented in POR). One sign error and you've got an oscillating filter that could damage drivers.

At 10 Hz with corner loading, you need every watt the ICEpower can deliver. The balanced output stage (THAT1646) is non-negotiable — 620W vs 38.5W is the difference between "I can feel the Blade Runner 2049 sea wall" and "I can hear a vague rumble." The ADAU1701 path delivers this. No miniDSP product delivers this without adding the same balanced output stage.

### What's the Extension?
With the ADAU1701 HPF at 5 Hz and the UMII18-22's 28mm Xmax:
- At 20 Hz: full power, 26mm excursion (93% Xmax)
- At 15 Hz: excursion-limited, ~100 dB at MLP with corner loading
- At 10 Hz: ~95 dB at MLP (at -10 dB reference target)
- At 5 Hz: HPF rolls off, protecting drivers

A miniDSP with a 10 Hz HPF minimum throws away 5-10 Hz content. That's the Tenet prologue. That's the Edge of Tomorrow beach landing. Is it physically felt more than heard? Yes. Does it matter? If you're building weapons-grade bass, yes.

### I'll Concede
Yeah, okay — most miniDSP users are building 2.1 or 5.1 systems where a 10 Hz HPF is fine. For a normal theater build, a miniDSP 2x4 Balanced pair would work. But this isn't a normal build. Eight corner-loaded 18" subs with 28mm Xmax driven by 620W/ch ICEpower amps deserve DSP that can keep up. The ADAU1701 + THAT1646 chain is the only option on this list that does.

---

## Cost Cutter's Take

### What Does This Cost?

| Option | Hardware Cost | Balanced Stage | Total | Custom Build? |
|--------|-------------|---------------|-------|---------------|
| **ADAU1701 POR** | $144 (2x APM2 + 4x PCM5102) | $71 (8x THAT1646 + passives) | **$215** | Yes — perfboard, soldering, I2S wiring |
| miniDSP 2x4 HD x2 | $400 | $71 (same THAT1646 needed) | **$471** | Partial — still need balanced stage |
| miniDSP 2x4 Balanced x2 | $500 | $0 (built in) | **$500** | No — plug and play |
| miniDSP 10x10 HD | $500 | $71 | **$571** | Partial |
| miniDSP Flex HT | $600 | $71 | **$671** | Partial |
| CamillaDSP + Pi + UMC1820 | $280 | $0 (balanced TRS out) | **$280** | Software config only |

### What Does This Buy?

The ADAU1701 path buys: sub-5Hz filtering, automated calibration, full amp power, and $285-$456 in savings vs miniDSP alternatives with equivalent capability.

The miniDSP 2x4 Balanced path buys: zero custom construction, professional build quality, swap-a-box troubleshooting. You pay $285 more for that simplicity.

### Where's the Fat?

- **10 THAT1646 ICs ordered (8 needed + 2 spare):** $11 in spare ICs. Keep it — ICs fail and they're $5.50 each.
- **CamillaDSP option:** The New Grad's suggestion at $280 is worth investigating as a backup plan. If the ADAU1701 analog build proves too fiddly, a Pi + UMC1820 is a clean fallback that keeps the automation pipeline (just rewrite the transport layer).
- **The 5th ICEpower amp ($373):** Not a DSP question, but it's sitting there. If it's a spare, it's $373 earning nothing. Defer purchase until a failure occurs or nearfield expansion happens.

### The Cut List

If the DSP budget needs to shrink:
1. Drop to 1x APM2 (4 outputs only — corners only, no nearfield/tactile) — saves $72 in DSP + DAC + balanced parts. Nearfield is deferred anyway.
2. Use unbalanced direct connection for tactile channels only (shakers don't need 620W) — saves 2x THAT1646 + 2x PCM5102 = ~$30
3. Accept lower amp power temporarily, skip THAT1646 entirely — saves $135, drops to 38.5W/ch. Revisit when nearfield subs are added.

### I'll Concede

The ADAU1701 at $215 is the budget option AND the capability leader. That's unusual — normally you trade cost for features. The reason it works is the DIY labor: you're paying in time (soldering, testing, debugging) instead of dollars. If your time is worth $50/hr and the THAT1646 build takes 10 hours, that's $500 in implicit labor — making the miniDSP 2x4 Balanced at $500 essentially equivalent. But Andy builds for fun, not billable hours. The $215 sticker price wins.

---

## Final Recommendation

**Keep the ADAU1701 POR.** No miniDSP product matches its combination of sub-20Hz capability, automated calibration, balanced output integration, and cost. The complexity of the analog build (PCM5102 + THAT1646) is real but documented and phased — build one path, validate, then replicate.

**Secondary recommendation:** Note CamillaDSP as a contingency. If the I2S + THAT1646 analog chain proves unreliable in Phase 2 testing, a Pi 4 + Behringer UMC1820 provides the same 4:8 routing with software DSP, balanced outputs, and REST API automation for ~$280.

**Immediate action:** Resolve the POR/06 vs POR/15 contradiction. POR/06 still says DSP-408 + NX6000D. POR/15 says ADAU1701 + ICEpower. One of them is wrong.
