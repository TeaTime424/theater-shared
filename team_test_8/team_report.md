# Team Report: DSP Platform Evaluation — ADAU1701 vs miniDSP

**Date:** 2026-03-19
**Goal:** Evaluate whether a miniDSP product should replace the ADAU1701 (APM2) DSP for 4:8 subwoofer processing
**Team:** Architect, Analyst, Critic (+ New Grad, Senior, Acton, Bass Head, Cost Cutter advisors)
**Verdict:** Keep ADAU1701 POR

---

## What Was Evaluated

The system needs 4 inputs (AVR sub pre-outs) routed to 8 outputs (4 corner sub pairs + nearfield + tactile) with HPF, PEQ, gain, and balanced output to ICEpower 1200AS2 amps.

### Current POR: 2x ADAU1701 (APM2) — $215
- 2x Wondom APM2 → 4x PCM5102 DAC → 8x THAT1646 balanced drivers
- Full sub-20Hz filtering (HPF at 5 Hz, native)
- Automated calibration: Python → SigmaStudio COM → DSP → REW closed loop
- Self-boot from EEPROM, no PC required in steady state
- Custom analog build: 10 modules, perfboard, I2S wiring

### Best Commercial Alternative: miniDSP Flex HTx — $949
- 8-in/8-out, balanced TRS (4 Vrms), SHARC 32-bit float DSP
- 10 PEQ/ch, sub-20Hz via biquad import, built-in bass management
- Dirac Live 3.x available (paid upgrade, redundant with AVR)
- No official API — community WebSocket shim only
- Zero construction: plug and play

### Other miniDSP Products Evaluated and Rejected
- **2x4 HD** ($400 for 2): unbalanced, no API, marginal sub-20Hz
- **2x4 Balanced** ($500 for 2): balanced XLR, but no API, 2 units needed
- **10x10 HD** ($500): unbalanced, still needs THAT1646 stage
- **Flex HT** ($600): unbalanced, insufficient for ICEpower full power
- **SHD** ($1,100): wrong product class (streamer/preamp)

---

## Decision: Keep ADAU1701

### Cost
| | ADAU1701 | Flex HTx | Delta |
|---|---|---|---|
| Hardware | $215 | $949 | +$734 |
| Balanced output | Included | Included | $0 |
| Cables | $20 | $40 | +$20 |
| **Total** | **$235** | **$989** | **+$754** |

### Capability

| Factor | ADAU1701 | Flex HTx | Winner |
|--------|----------|----------|--------|
| Sub-20Hz HPF | Native (any freq) | Biquad import | ADAU1701 |
| Automated calibration | Full COM pipeline | No official API | ADAU1701 |
| Build complexity | High (10 modules) | Zero | Flex HTx |
| Troubleshooting | Debug custom chain | Swap a box | Flex HTx |
| Fixed-point precision | 28-bit (5.23) | 32-bit float | Flex HTx |
| PEQ bands/ch | 10 | 10 | Tie |
| Balanced output voltage | 4.2 Vrms | 4.0 Vrms | Tie |
| Amp power delivered | 620W/ch | 620W/ch | Tie |
| Self-boot | EEPROM | Flash | Tie |
| Dirac Live | No | Yes (paid, redundant) | N/A |

### Why ADAU1701 Wins
1. **$754 cheaper** for equivalent capability
2. **Automated calibration** — 40 min hands-off vs 5-8 hrs manual biquad entry for 80 filters
3. **Native sub-20Hz** — no manual coefficient calculation needed
4. **Existing tooling** — 2,983 lines of working Python (coefficients, REW integration, auto-correction)

### When Flex HTx Would Win
- If the Phase 2 bench test reveals noise/reliability problems in the custom analog chain
- If automated calibration is abandoned as a requirement
- If build time is valued at >$50/hr (breakeven at ~15 hrs construction)

---

## Issues Corrected During Review

The Critic caught material errors in the Phase 1 analysis:

1. **38.5W figure was misapplied.** Both initial agents applied the ADAU1701's internal DAC voltage (0.9 Vrms → 38.5W) to miniDSP products, which output 2.0 Vrms → ~190W unbalanced. This error made the miniDSP unbalanced case look worse than reality. However, with the Flex HTx having balanced output (4 Vrms → 620W), this error doesn't affect the final comparison — both paths deliver full power.

2. **"miniDSP Flex Eight" doesn't exist.** The Analyst fabricated a $700 product. The real product is the **Flex HTx at $949**. This actually widened the cost gap from the originally claimed $660 to the corrected $734.

3. **Sunk cost framing.** Only ~480 lines of the 2,983-line pipeline are ADAU-specific (COM transport). The coefficient math, REW integration, and EQ engine are platform-agnostic. The tooling investment is real but not as non-transferable as initially claimed.

4. **2x miniDSP 2x4 Balanced ($500)** was under-evaluated as an alternative. At $500 with native balanced XLR, it's closer in cost ($285 gap). However, it requires 2 units, has no API, and has marginal sub-20Hz GUI support. Still inferior to ADAU1701 for this application.

---

## POR Document Inconsistencies Found

| Document | Says | Should Say |
|----------|------|-----------|
| POR/06 Electronics & Control | DSP-408 + NX6000D | ADAU1701 (APM2) + ICEpower 1200AS2 |
| Option D budget | ADAU1452 — $60 | 2x ADAU1701 (APM2) + balanced output — $215 |
| tools/dsp/config.json | ADAU1452 addresses | Retain as secondary; config_1701.json is primary |
| Research docs (ADAU1452 + Pi + SPI) | Active architecture | Superseded by ADAU1701 + COM + I2S |

**Action required:** Update POR/06 and budget to reflect ADAU1701 + ICEpower. Mark stale research docs as superseded.

---

## Phase 2 Gate: Bench Test Requirements

Before committing to full build, validate ONE complete signal path:

```
APM2 → I2S → PCM5102 → THAT1646 → ICEpower P105 → dummy load
```

### Pass/Fail Criteria
- Noise floor: < -90 dBFS
- THD: < -80 dB at 20 Hz, 50 Hz, 80 Hz
- Frequency response: ±0.5 dB from 5 Hz to 200 Hz
- No audible hum from parasitic power
- I2S link stable for 8+ hours

### If Bench Test Fails
Fallback: 2x miniDSP 2x4 Balanced ($500). Eliminates all custom analog. Accepts loss of automated calibration. Coefficient math and REW tooling still usable for offline filter design.

---

## New Grad vs Senior — Final Scorecard

| Decision Point | New Grad Said | Senior Said | Outcome |
|---------------|---------------|-------------|---------|
| Keep ADAU1701 vs buy miniDSP | ADAU1701 reluctantly — wants modern API | ADAU1701 with bench test gate | **ADAU1701 with gate** |
| CamillaDSP contingency | Good fallback at ~$300 | Doesn't solve balanced voltage | **Noted but not viable** — same analog problem |
| Custom analog reliability | Acceptable if tested | 10 modules on perfboard = risk | **Senior wins** — bench test is mandatory |
| Automation value | Essential | Essential | **Agree** |
| Build quality (perfboard vs PCB) | Fine for DIY | Use OSHPark PCBs ($40) | **Senior's suggestion noted** — evaluate during bench test |
| ICP5 disconnect requirement | Annoying | Design smell — add a switch | **Senior wins** — add physical switch or jumper |
| Sunk cost framing | Partially valid | Mostly transferable tooling | **Senior wins** — only 480 lines are truly sunk |

---

## Summary

**Keep the ADAU1701 POR at $215.** The miniDSP Flex HTx at $949 is a legitimate product but costs $754 more while removing automated calibration — the feature that justified DIY DSP in the first place. The custom analog build is the real risk; the Phase 2 bench test is the decision gate. If it passes, build the remaining 7 channels. If it fails, fall back to 2x miniDSP 2x4 Balanced at $500.
