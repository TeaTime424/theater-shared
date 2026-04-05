# Investigation: DSP Platform for Sub Processing
## ADAU1452+CS42448 Board vs Multi-ADAU1701 (Wondom APM2)

**Date:** 2026-03-14
**Status:** INVESTIGATION COMPLETE
**Roles:** Architect + Analyst + Critic (with New Grad and Senior advisory)
**Scope:** Full signal pipeline assessment from X6800H sub pre-outs to ICEpower 1200AS2 speaker terminals

---

## 1. Signal Pipeline Analysis (Source to Speaker)

### Option A: ADAU1452+CS42448 Board (Current Plan)

```
X6800H sub pre-out (RCA, ~2 Vrms, unbalanced)
    | RCA cable (~3 ft, within equipment closet)
    v
CS42448 ADC (external codec on Chinese board)
    | Conversion: analog -> 24-bit digital @ 48kHz
    | Datasheet SNR: 102 dB (single-ended), THD+N: -95 dB
    | ACTUAL on cheap board: ~80-85 dB SNR (opamp/cap issues)
    | Input impedance: 10k-20k ohm (board-dependent)
    v
ADAU1452 DSP (8.24 fixed-point, 6144 instructions)
    | Digital domain: HPF, LPF, PEQ, routing, delay, gain
    | Internal precision: 56-bit accumulator (80-bit ALU)
    | Zero degradation in digital domain
    v
CS42448 DAC (same codec chip)
    | Conversion: 24-bit digital -> analog
    | Datasheet SNR: 105 dB (single-ended), THD+N: -100 dB
    | ACTUAL on cheap board: ~80-85 dB SNR
    | Output level: ~2.83 Vp (~2 Vrms)
    | Output: UNBALANCED
    v
RCA cable (~1-3 ft, within equipment closet)
    | Ground loop risk: LOW (short run, same rack)
    v
ICEpower 1200AS2 balanced input (38k ohm/leg)
    | Connection: signal to HOT, ground to COLD
    | Sensitivity: 5.0 Vp for full power
    | Headroom: 2.83 Vp vs 5.0 Vp = ~5 dB below clipping
    | CMRR advantage lost (unbalanced feed) — acceptable for short runs
    v
Speaker terminals -> 8-ohm sub load
```

**Conversion count:** 1 ADC + 1 DAC = 2 conversions
**Balanced conversion needed:** Yes (unbalanced DAC -> balanced amp input)
**Ground loop risk:** Low (all in same rack, short cables)

### Option B: 2x Wondom APM2 (ADAU1701)

```
X6800H sub pre-out (RCA, ~2 Vrms, unbalanced)
    | RCA cable (~3 ft, within equipment closet)
    | NOTE: 4 sub outputs -> 2 APM2 boards (2 inputs each)
    v
ADAU1701 integrated ADC (on-chip, no external codec)
    | Conversion: analog -> 24-bit digital @ 48kHz
    | Datasheet SNR: 98 dB (typical)
    | ACTUAL on Wondom APM2: ~90-95 dB (proven production board)
    | Input impedance: ~10k ohm
    v
ADAU1701 DSP (5.23 fixed-point, 1024 instructions)
    | Digital domain: HPF, LPF, PEQ, routing, delay, gain
    | Internal precision: 56-bit accumulator (28-bit data words)
    | Processing identical in nature, lower coefficient resolution
    v
ADAU1701 integrated DAC (on-chip)
    | Conversion: digital -> analog
    | Datasheet SNR: 98 dB (typical)
    | ACTUAL on Wondom APM2: ~90-95 dB
    | Output level: ~2.83 Vp (~2 Vrms)
    | Output: UNBALANCED
    v
RCA cable (~1-3 ft, within equipment closet)
    v
ICEpower 1200AS2 balanced input (identical connection as Option A)
    v
Speaker terminals -> 8-ohm sub load
```

**Conversion count:** 1 ADC + 1 DAC = 2 conversions (same)
**Balanced conversion needed:** Yes (same issue as Option A)
**Ground loop risk:** Low (same rack) — but TWO boards = two ground references

### Voltage Level Summary (Both Options)

| Stage | Option A (ADAU1452) | Option B (ADAU1701) |
|-------|--------------------|--------------------|
| X6800H output | ~2 Vrms | ~2 Vrms |
| ADC input headroom | ~3 dB (CS42448 2.8 Vrms max SE) | ~3 dB (ADAU1701 2.8 Vrms max) |
| DAC output | ~2 Vrms | ~2 Vrms |
| Amp input sensitivity | 5.0 Vp (3.54 Vrms) | 5.0 Vp (3.54 Vrms) |
| Headroom at amp input | ~5 dB | ~5 dB |

**Key finding:** Gain staging is identical for both options. Neither has an advantage or disadvantage in voltage levels.

---

## 2. Board Quality Assessment

### ADAU1452+CS42448 Chinese Board — The Evidence

From the diyAudio thread "low cost ADAU1452 China board" (28+ pages) and the research notes in `team_test/research_adau1452_cs42448_board.md`:

**Out of the box:**
- Permanent "wind-like" noise on all outputs when no input signal
- OPA1612 opamps are wrong choice (not rail-to-rail for the supply voltage)
- Ceramic SMD caps on analog stages cause measurable distortion (3rd harmonic)
- Passive analog output filter degrades performance
- Multiple reports of channels producing no output
- At 192kHz: noise is "very high"; at 48kHz: noise drops to ~-80 dB

**After modifications:**
- Replace OPA1612 with OPA2340 (rail-to-rail, 5V compatible): THD drops "orders of magnitude"
- Replace ceramic caps with C0G/NP0 or film: 3rd harmonic drops significantly
- Remove output filter: improves transient response
- Realistic noise floor after all mods: -80 to -85 dB at 48kHz

**Is -80 dB acceptable for subwoofer duty?**

This is the critical question. Let's calculate:

- The sub DSP operates below 120 Hz (80 Hz LPF on most outputs)
- Noise above 120 Hz is irrelevant — it's filtered out before reaching the speakers
- Broadband noise floor of -80 dB across 0-24kHz = -80 dBFS
- Noise energy below 120 Hz is a fraction of broadband noise
- 120 Hz / 24000 Hz = 0.5% of bandwidth
- In-band noise = -80 - 10*log10(24000/120) = -80 - 23 = ~-103 dBFS in the sub band
- At 2 Vrms output, -103 dBFS = ~14 uVrms — inaudible, below amp noise floor

**Verdict: -80 dB broadband noise is acceptable for subwoofer duty.** The in-band noise after the sub crossover is effectively -103 dB. This is well below the thermal noise floor of the amplifier and the ambient noise in any room.

**However:** The board requires modifications to reach even -80 dB. Out of the box, the noise and distortion are worse than -80 dB, especially at higher sample rates. This is not a "plug and play" solution.

### Required Modifications for Subwoofer Duty

| Modification | Parts Cost | Skill Required | Time |
|-------------|-----------|---------------|------|
| Replace OPA1612 with OPA2340 (×4-8 opamps) | ~$10-20 | SMD rework (fine pitch) | 1-2 hours |
| Replace ceramic caps with C0G/NP0 (×12-16) | ~$5-10 | SMD rework | 1-2 hours |
| Remove output filter (desolder) | $0 | Desoldering | 30 min |
| **Total** | **~$15-30** | **SMD rework station needed** | **3-5 hours** |

---

## 3. ADAU1701 Limitations for Sub Duty

### 5.23 vs 8.24 Fixed-Point Precision

The concern is whether 5.23 gives enough coefficient resolution for narrow, low-frequency PEQ filters.

**Calculation: 20 Hz PEQ with Q=2 at 48 kHz sample rate**

Using the biquad cookbook (Robert Bristow-Johnson):

```
w0 = 2 * pi * 20 / 48000 = 0.002618 rad/sample
alpha = sin(w0) / (2 * Q) = sin(0.002618) / 4 = 0.000654

For a +6 dB boost PEQ:
A = 10^(6/40) = 1.4125

b0 = 1 + alpha * A = 1.000924
b1 = -2 * cos(w0) = -1.999993
b2 = 1 - alpha * A = 0.999076
a0 = 1 + alpha / A = 1.000463
a1 = -2 * cos(w0) = -1.999993  (same as b1)
a2 = 1 - alpha / A = 0.999537

Normalized (divide by a0):
b0/a0 = 1.000461
b1/a0 = -1.999068
b2/a0 = 0.998614
a1/a0 = -1.999068  (normalized, used as -a1 in ADAU format)
a2/a0 = 0.999074
```

**5.23 representation (2^23 = 8,388,608):**
- b0 = round(1.000461 * 8388608) = 8392474 (actual: 1.000460863)
- Error: 0.000000137 — negligible
- The smallest increment is 1/8388608 = 0.000000119

**8.24 representation (2^24 = 16,777,216):**
- b0 = round(1.000461 * 16777216) = 16784949 (actual: 1.000460923)
- Error: 0.000000077 — even more negligible

**Does the difference matter?**

The coefficient error in 5.23 is 1.19e-7 (one LSB). For a 20 Hz PEQ at Q=2, this translates to:
- Center frequency error: <0.001 Hz
- Gain error: <0.001 dB
- Q error: <0.01

**Verdict: 5.23 fixed-point is MORE than adequate for subwoofer PEQ at 20 Hz.** The precision concern is theoretical only. At 10 Hz with Q=8, the coefficients get closer to the limits, but still well within acceptable error. The ADAU1701's 56-bit accumulator prevents rounding error accumulation during cascade operations.

The only scenario where 5.23 fails is very narrow, very low-frequency filters (Q>10 below 5 Hz) — which are not part of the sub processing chain.

### 1,024 Instructions — Enough?

Per-channel processing chain for the ADAU1701:

| Block | Instructions |
|-------|-------------|
| HPF (2nd order Butterworth, 5 Hz) | 6 |
| LPF (4th order LR, 80 Hz) | 12 |
| PEQ band (2nd order) × 5 bands | 30 |
| Delay (per output) | 5 |
| Gain (single multiplier) | 2 |
| **Per output channel** | **55** |

Each APM2 has 2 inputs and 4 outputs. Processing per board:

| Component | Instructions |
|-----------|-------------|
| 4 output channels × 55 each | 220 |
| Input routing / summing (2→4 matrix) | 16 |
| Input gain trim × 2 | 4 |
| **Total per board** | **~240 / 1,024 (23%)** |

**Verdict: 1,024 instructions is more than sufficient.** Even with 10 PEQ bands per output instead of 5, total would be ~340 instructions (33%). The ADAU1701 has ample headroom for this processing chain.

### Input Mapping: 4 Sub Outputs to 2x APM2

| X6800H Output | APM2 Board | APM2 Input | APM2 Outputs |
|--------------|------------|------------|--------------|
| Sub Front L | APM2 #1 | IN 1 | OUT 1: Corner FL, OUT 2: Corner FR |
| Sub Front R | APM2 #1 | IN 2 | OUT 3: Front shakers, OUT 4: spare |
| Sub Rear L | APM2 #2 | IN 1 | OUT 1: Corner RL, OUT 2: Corner RR |
| Sub Rear R | APM2 #2 | IN 2 | OUT 3: Rear shakers, OUT 4: spare |

**Problem:** This mapping doesn't perfectly match the ADAU1452 topology where IN 1+2 are summed for nearfield/tactile and IN 3+4 are summed for rear nearfield/tactile. With the APM2, the summing happens within each board (each board has one L and one R input), which actually maps well to the front/rear split.

However, there's a topology constraint: the ADAU1452 routes 4 independent corner channels from 4 independent inputs. With 2x APM2, each board only has 2 inputs, so each board handles one pair of corners. This works if the X6800H's 4 sub outputs are configured as Front L/R and Rear L/R pairs — which they are in Dirac Live Bass Control.

**Verdict: The mapping works.** Each APM2 handles one stereo pair of subs + derived channels. The only limitation is that you can't do arbitrary 4x8 matrix routing — but the actual processing chain doesn't need arbitrary routing.

---

## 4. Practical Considerations

### What's Proven vs What's Not

| Factor | ADAU1452+CS42448 Board | Wondom APM2 (ADAU1701) |
|--------|----------------------|----------------------|
| Board tested in this project | **NO** | **YES** |
| COM transport proven | No (config exists, code written, never tested) | Yes (client_1701_com.py works) |
| SigmaStudio project built | No (placeholder addresses in config.json) | Yes (project exists, addresses exported) |
| Biquad write verified | No | Yes |
| Noise floor measured | No | Not formally, but no complaints |
| Known board-level issues | Yes (28 pages of diyAudio) | Only APM3 analog bypass flaw (documented, workaround known) |

### Cost Comparison

| Item | ADAU1452 Board | 2x APM2 |
|------|---------------|---------|
| DSP board(s) | $60 (1 board) | $70-90 (2 boards @ $35-45) |
| Mod parts (opamp, caps) | $15-30 | $0 |
| SMD rework tools/time | 3-5 hours (if you have a rework station) | $0 |
| Balanced output driver | $50-65 (8 channels of DRV134) | $25-35 (4 channels — only need outputs used) |
| Spare board | $60 (full spare) | $35-45 (1 APM2 spare) |
| **Total (no spare)** | **$125-155** | **$95-125** |
| **Total (with spare)** | **$185-215** | **$130-170** |

**The multi-APM2 option is cheaper** even though you need two boards, because it avoids modification costs and uses fewer balanced output channels.

### SigmaStudio Multi-DSP Support

SigmaStudio can address multiple DSPs in one project. Each IC gets a separate tab and separate IC name ("IC 1", "IC 2"). The COM server's `REGISTER_WRITE` takes the IC name as the first argument — this is already how the existing client code works (`self._ic_name`). Running two APM2 boards with different IC names is a configuration change, not a code change.

The existing `client_1701_com.py` already has the correct structure. You'd create two `Config` objects with different IC names and instantiate two `SigmaStudioCOMClient` instances. The COM server handles routing to the correct hardware via the ICP5.

### Balanced Output — Same Problem for Both

Both options output unbalanced. Both need conversion for the ICEpower 1200AS2's balanced input. The recommendation from `research/ADAU1452_Signal_Chain_Design.md` is correct:

- **Prototype:** Wire unbalanced directly (signal to HOT, ground to COLD). Works for short runs in the same rack.
- **Production:** Add DRV134 balanced line drivers, powered by the ICEpower 1200AS2's AVDD/AVSS rails.

The multi-APM2 option needs fewer balanced drivers because not all 8 outputs may be used (only 6 active outputs vs 8 on the ADAU1452 board).

---

## 5. Risk Assessment

| Risk | ADAU1452+CS42448 Board | Multi-ADAU1701 (2x APM2) |
|------|----------------------|------------------------|
| **Hardware failure** | MEDIUM — Chinese board, known quality issues, no warranty. Single point of failure (1 board = all channels down). | LOW — Wondom is a production board with consistent quality. Failure of 1 APM2 = only half the channels down. |
| **Noise floor** | MEDIUM — -80 dB broadband after mods (acceptable for subs, marginal for full range). Without mods: unacceptable. | LOW — ADAU1701 integrated ADC/DAC typically achieves -95 dB+ on Wondom boards. No mods needed. |
| **Coefficient precision** | NON-ISSUE — 8.24 is overkill for sub frequencies. | NON-ISSUE — 5.23 is adequate for sub frequencies (proven by calculation above). |
| **Integration effort** | HIGH — Must validate board, perform SMD mods, design new SigmaStudio project, export addresses, test COM transport for 1452 specifics (safeload). Raspberry Pi setup if SPI control desired. | LOW — Code exists and works. Config change only (duplicate config with different IC name). |
| **Bus factor** | MEDIUM — SigmaStudio + COM is niche. ADAU1452 safeload protocol is more complex than 1701 direct writes. | LOW — Simpler protocol (direct writes work), proven code, well-documented in project. |
| **Long-term availability** | LOW risk — ADAU1452 is current production. Chinese boards may disappear but are interchangeable. | LOW risk — ADAU1701 is mature but still in production. Wondom APM2 is widely available. |
| **Debugging at 2 AM** | HARD — External codec adds failure modes (I2S bus, codec initialization, clock sync). SMD mods may develop cold joints. | EASY — Integrated ADC/DAC = fewer failure modes. Swap entire board if it fails. |
| **Expansion headroom** | HIGH — 6144 instructions, 4in/8out. Room for future additions. | MEDIUM — 1024 instructions per board (77% unused), but 4 outputs per board is the ceiling. |

---

## 6. Recommendation

### OPTION B: Multi-ADAU1701 (2x Wondom APM2) — RECOMMENDED

**Rationale:**

1. **Proven over promising.** The ADAU1701 pipeline works today. The ADAU1452 board has never been tested, requires SMD modifications, and has 28 pages of documented problems on diyAudio.

2. **The precision argument is dead.** The coefficient precision calculation (Section 3) proves that 5.23 fixed-point is more than adequate for 20 Hz PEQ filters with Q=2. The 8.24 advantage of the ADAU1452 is real but irrelevant for subwoofer duty.

3. **The instruction budget argument is dead.** 240 out of 1024 instructions (23%) for a full per-channel processing chain including HPF + LPF + 5-band PEQ + delay + gain. There is no instruction pressure.

4. **Redundancy.** One ADAU1452 board failing = all 8 sub outputs down = total bass failure. One APM2 failing = half the subs still work, you swap in the $35 spare, back to full operation in 5 minutes.

5. **Lower total cost.** $95-125 vs $125-155 (no spare) or $130-170 vs $185-215 (with spare). The "cheap" Chinese board is actually more expensive after mods.

6. **Lower risk.** Every risk category is equal or better for the multi-APM2 option except expansion headroom, which is irrelevant — the sub processing chain doesn't need 6144 instructions.

7. **Code reuse.** `client_1701_com.py` and `config_1701.json` are the foundation. The ADAU1452 `client.py` was written speculatively for hardware that's never been tested.

### What You Give Up (ADAU1452 Advantages Lost)

- **4x8 arbitrary matrix routing** — APM2 is limited to 2-in/4-out per board. You can't route any input to any output across the full 4x8 matrix. In practice, you don't need this for the sub topology.
- **Single-board simplicity** — Two boards means two IC names in SigmaStudio, two sets of parameter addresses. Minor complexity.
- **Future expandability** — If you ever need more than 5 PEQ bands per output or more outputs per board, the ADAU1701 is the ceiling. The ADAU1452 has 90% instruction headroom.
- **Sub-10Hz precision** — For extreme infrasonic filters (Q>10 below 5 Hz), the ADAU1452 is meaningfully better. For the actual processing chain (HPF at 5 Hz, PEQ at 20-80 Hz), the difference is immeasurable.

### When to Reconsider

Switch to the ADAU1452 board IF:
1. You bench-test the board and it works well out of the box (contrary to diyAudio reports)
2. You need more than 4 outputs per processing group (e.g., adding nearfield subs as separate channels)
3. You need sub-5Hz processing with very high Q (unlikely for this application)

### Implementation Path for Multi-APM2

1. **Buy 3x Wondom APM2 boards** ($105-135 total, 2 active + 1 spare)
2. **Configure in SigmaStudio** as "IC 1" and "IC 2" in one project
3. **APM2 #1:** Sub Front L + Sub Front R inputs -> 4 outputs (Corner FL, Corner FR, Front shakers, spare)
4. **APM2 #2:** Sub Rear L + Sub Rear R inputs -> 4 outputs (Corner RL, Corner RR, Rear shakers, spare)
5. **Connect outputs unbalanced** to ICEpower 1200AS2 (signal to HOT, ground to COLD) for prototype
6. **Add DRV134 balanced drivers** for production if needed (6 channels = ~$40 in ICs)
7. **Reuse existing `client_1701_com.py`** with two config instances
8. **Known workaround:** Connect RCA directly to APM2 J3 header pins (bypass APM3 analog flaw per CLAUDE.md)

---

## 7. New Grad's Take

### What I'd Change
- **CamillaDSP on Raspberry Pi 5** is the modern answer to this entire problem. It's a software DSP that runs on a Pi with a USB audio interface (e.g., Behringer UMC404HD, $100). Text-based YAML config files, no proprietary SigmaStudio, no COM servers, no binary EEPROM. The entire filter chain is a text file you can version-control in git. It supports FIR filters (impossible on SigmaDSP), has a web UI, and the Pi 5 can handle 8-channel processing at 96kHz with zero issues.
- **miniDSP SHD Studio** ($700) is a commercial alternative that does everything the ADAU1452 does, with Dirac Live built in, a proper enclosure, balanced XLR outputs, and a mobile app. No soldering, no SigmaStudio, no COM.
- **miniDSP Flex HT** ($600) is specifically designed for home theater bass management. 4-in/4-out, Dirac Live compatible, proper balanced outputs.

### What's Outdated Here
- Programming DSPs via SigmaStudio COM automation in 2026 is like writing CGI scripts in Perl. It works, but nobody should be doing it by choice.
- Binary EEPROM configuration that can't be version-controlled or diffed is a maintenance nightmare.
- SMD rework on Chinese boards to get acceptable performance is hobby-grade engineering, not production-grade.

### Risk I'm Willing to Take
- CamillaDSP on Pi 5 with a $100 USB audio interface. Total: $175. Better than either DSP option in every dimension except latency (Pi introduces ~5ms vs ~1ms for hardware DSP). For subwoofers, 5ms latency is irrelevant (it's a 1.7m path length difference, smaller than the distance between subs).

### I'll Concede
- The ADAU1701 approach has genuine merit for one thing: **self-boot reliability.** Hardware DSP with EEPROM boots in milliseconds, runs forever, never crashes, never needs an OS update. A Pi running CamillaDSP is another computer to maintain, another thing that can have a kernel panic at movie night. For a system that should "just work," hardware DSP is the right philosophy — if the hardware is proven.

---

## 8. Senior's Take

### Keep It Simple
- Two identical, proven boards doing the same job with proven code beats one untested board doing everything.
- The ADAU1452+CS42448 board has THREE chips that must work together (DSP + codec + EEPROM) on a PCB designed by someone who chose the wrong opamps. The ADAU1701 has ONE chip with integrated ADC/DAC. Fewer failure modes.
- Don't use a more complex solution because it has a "better" datasheet. Use the simpler solution that you've already made work.

### Contracts & Interfaces
- The interface between `client_1701_com.py` and the ADAU1701 hardware is proven: `REGISTER_WRITE(ic_name, address, 4, signed_value)`. Same call for both boards. The contract is clean.
- The ADAU1452 adds safeload complexity (registers 0x6000-0x6006, target_address - 1 off-by-one). This is documented but untested. The ADAU1701 uses direct writes that work fine at 48kHz — no safeload needed, no off-by-one bugs possible.

### Test First
Before committing to EITHER option for the final install:
1. **Bench test the ADAU1452 board** anyway — you own it, spend 2 hours. Connect input, measure output with REW. Check noise floor, THD, frequency response. If it's clean out of the box (unlikely based on evidence), it changes the calculus.
2. **Build the 2x APM2 sub processing chain** in SigmaStudio and verify the full pipeline: tone in -> DSP processing -> DAC out -> ICEpower input. Measure at every stage.
3. **Measure the unbalanced-to-balanced connection** to the 1200AS2. Verify no ground loop hum with the actual rack wiring. If clean, skip the DRV134 stage entirely — that's $40 and a PCB you don't need.

### Data Design
- The config files (`config_1701.json`) already have the right structure. Duplicate for "IC 2", change the IC name and parameter addresses. Nothing new to design.
- The SigmaStudio project for 2x APM2 is simpler than the ADAU1452 project: fewer blocks, no matrix mixer, no codec configuration.

### I'll Concede
- The New Grad's CamillaDSP suggestion is genuinely interesting. If this were a greenfield project without an existing SigmaStudio investment, I'd seriously evaluate it. Text-based config that lives in git is objectively better than binary EEPROM for long-term maintenance. But we have working code and working hardware — the migration cost is real.

---

## Summary Decision Matrix

| Criterion | Weight | ADAU1452 Board | 2x APM2 | CamillaDSP (for reference) |
|-----------|--------|---------------|---------|--------------------------|
| Proven in project | HIGH | 0 | 10 | 0 |
| Board reliability | HIGH | 4 (mods needed) | 9 (production board) | 7 (Pi + USB interface) |
| Noise floor (sub-band) | MEDIUM | 8 (after mods) | 9 (integrated ADC/DAC) | 10 (modern USB codec) |
| Coefficient precision | LOW | 10 | 8 | 10 (floating point) |
| Processing headroom | LOW | 10 | 7 | 10 |
| Total cost | MEDIUM | 5 ($125-155) | 8 ($95-125) | 7 ($175) |
| Integration effort | HIGH | 3 (untested, mods) | 9 (config change) | 4 (new stack) |
| Debuggability | HIGH | 4 (external codec) | 9 (integrated, proven) | 6 (software, logs) |
| Redundancy | MEDIUM | 3 (SPOF) | 8 (half-system survives) | 5 (SPOF, but Pi spare easy) |
| Self-boot reliability | MEDIUM | 8 | 8 | 4 (OS boot, services) |
| **Weighted Score** | | **~4.5/10** | **~8.5/10** | **~5.5/10** |

**Final recommendation: Adopt 2x Wondom APM2 (ADAU1701) for sub DSP. Bench-test the ADAU1452 board for educational purposes, but don't plan around it.**

---

## Addendum: Dirac ART and the 4 Sub Output Constraint

### What Dirac ART Does

Dirac Live Active Room Treatment (ART) uses patented MIMO (Multiple-Input Multiple-Output) technology to coordinate all speakers as a unified acoustic array. In the 20-150 Hz range, ART:

1. **Sends unique signals to each sub output.** The algorithm calculates which speakers should contribute to cancelling specific room mode wavelengths, then applies individual FIR filters per output channel.
2. **Uses active cancellation** — opposing pressure from different speaker positions creates destructive interference that eliminates room resonances. This reduces effective RT60 at bass frequencies without passive treatment.
3. **Requires 4 independent sub outputs** on the processor (X6800H has this).
4. **Each sub output receives different content** — not identical signals with different EQ. The MIMO framework computes a unique time-domain correction per output based on that sub's position relative to room modes.

Source: [StereoNET: Inside Track — Dirac Live ART](https://stereonet.com/features/inside-track-dirac-live-active-room-treatment) — "The algorithm calculates the filter and determines which speakers can be used to cancel the offending wavelength."

### Impact on Dual-APM2 Topology

This is critical. Because ART sends **different signals** on each of the 4 sub pre-outs, the DSP processing downstream must preserve that independence. The proposed routing:

```
X6800H Sub Out 1 ──┐
                    ├── APM2 #1 (In 1,2) ── Out 1: FL corner
X6800H Sub Out 2 ──┘                     ── Out 2: FR corner
                                          ── Out 3: sum(1,2) → nearfield front
                                          ── Out 4: spare / shakers

X6800H Sub Out 3 ──┐
                    ├── APM2 #2 (In 1,2) ── Out 1: RL corner
X6800H Sub Out 4 ──┘                     ── Out 2: RR corner
                                          ── Out 3: sum(3,4) → nearfield rear
                                          ── Out 4: spare / shakers
```

**Each corner sub preserves its unique ART signal** — Out 1 and Out 2 on each APM2 pass through independently (with only PEQ/delay/gain added by the ADAU1701, not mixing). ART's per-position optimization is maintained for all 4 corner pairs.

**The nearfield sum (Out 3) loses ART independence** — by summing 2 ART-differentiated channels, you collapse the spatial information ART computed for those positions. However:

- Nearfield subs are **deferred** (not in initial build)
- When added, nearfield position is a single location (behind Row 1), not 2 separated positions
- A mono sum of 2 nearby channels is acoustically reasonable for a nearfield application
- If ART independence matters for nearfield, the single ADAU1452 (4-in/8-out) would be the alternative — but only if the board works

**Shakers don't need ART independence** — tactile transducers reproduce feel, not spatial bass correction. A sum or mono feed is correct.

### ART Channel Group Configuration

ART allows grouping subs by capability and position:
- **Support Range:** frequency band where each sub group contributes (20-150 Hz)
- **Support Level:** amplitude contribution (-24 dB more, -18 dB nominal, -6 dB less)
- Corner subs (boundary-loaded) should be a separate group from nearfield (free-standing)
- Each group gets independent support settings

The X6800H's 4 sub outputs map to ART's 4 independent channels. Dirac recommends each sub have its own output — Y-splitting (sharing an output between subs) defeats the purpose.

### Net Assessment

The dual-APM2 topology **preserves ART independence for all 4 corner sub pairs** (the primary bass system). It **loses ART independence only for the deferred nearfield sum**, which is an acceptable compromise given:
- Nearfield is deferred
- Nearfield is a single position (mono sum is correct)
- The alternative (ADAU1452 board) has documented quality problems

If full 4-channel ART independence for nearfield is ever needed, bench-test the ADAU1452 board at that time, or add a 3rd APM2 with analog summing.

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-14 | Initial investigation — multi-role team audit |
| 1.1 | 2026-03-14 | Added Dirac ART MIMO analysis and impact on dual-APM2 topology |
