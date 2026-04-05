# DSP Stack Forum Research: ADAU1701 + ADAU1452 + SigmaStudio + ICP5

**Date:** 2026-03-20
**Status:** RESEARCH — Community experience synthesis
**Sources:** diyAudio, AVS Forum, Audio Science Review (ASR), EngineerZone, GitHub

---

## 1. Amazon B0CJBV1KMP ADAU1701 Board (Noise, Reliability, DAC Quality)

### Positive Experiences
- ASR thread on identical Wondom ADAU1701 unit: "a very nicely designed unit for very little money" — includes PT2259 digital volume per output pair with PIC12 microcontroller, described as "unexpectedly sophisticated for a EUR 45 board"
- PT2259 volume attenuator reduces DAC noise floor at normal listening levels — a useful feature for the preamp use case
- Amazon reviews: 4.7/5 stars (8 reviews). One user confirmed SigmaStudio programmability works
- diyAudio: multiple users running ADAU1701 boards for subwoofer crossover with "silent" operation and "extremely transparent sound"
- One user on diyAudio ran miniDSP (ADAU1701-based) silently with 90+ dB sensitivity speakers for 15 years

### Negative Experiences
- **USB power noise:** Amazon reviewer confirmed "using USB from the PC to power the DSP adds a lot of noise to the audio; a separate USB power bank (battery) works better" — use a dedicated clean 5V supply, not PC USB
- **Documentation void:** "experimenters and programmers may have to rely on fellow users for documentation" — the board ships with minimal docs
- **Build quality lottery:** Some Chinese ADAU1701 boards arrive DOA or with incorrectly soldered components. Wondom JAB5 boards reported with "ridiculously high noise floor"
- **Idle tones:** EngineerZone reports sporadic 1-2 kHz idle tones on DAC output — board/power-supply dependent, not chip-inherent. Filtered out by sub crossover but relevant if used full-range
- **Audible hiss with efficient speakers:** miniDSP 2x4 (same chip) measured -86 dBV broadband noise — audible 5-8" from cones with 84-85 dB sensitivity speakers. NOT a concern for subwoofer-only use (sub crossover removes most noise energy)

### Key Takeaway for Your Build
The B0CJBV1KMP is fine as a DAC/signal source for subwoofer processing. The 0.9 Vrms output, noise, and THD are all adequate when:
1. Powered by a clean dedicated supply (not PC USB)
2. Signal is crossover-filtered (sub-only band)
3. Downstream gain is moderate (the 898B at +12 dB is fine; 32 dB+ would be problematic)

**Risk:** Low for subwoofer use. The enclosure, RCA jacks, and ICP5 header are genuine advantages over bare Wondom APM2 PCBs.

---

## 2. ADAU1452 for Subwoofer Processing — Community Experiences

### Positive Experiences
- The "low cost ADAU1452 China board" diyAudio thread (29+ pages) shows an active community successfully using these boards for multi-way active crossovers including subwoofer processing
- ADAU1452 described as "incredibly flexible in I2S formatting, plus has an ASRC engine that allows different formats/clock speeds to coexist"
- Users report "no audible background hiss or distortion detected" — "impressed, especially given the price point"
- freeDSP Aurora (ADAU1452-based, higher quality PCB) measured THD of -104 dB, THD+N of -102.9 dB with optical input
- 6144 instructions at 48 kHz is massive headroom — 10-band PEQ + crossovers + delays on 8 channels uses only ~13%
- No frequency floor limitation (unlike Dayton DSP-408 which stops at 20 Hz) — filters to DC

### Negative Experiences
- **Chinese board quality is inconsistent:** "all of these boards require a lot of part replacement and hacking to get the noise down to acceptable levels"
- **Incorrect components from factory:** Users found resistors soldered as 50 ohms instead of 6.8k ohms, broken IC13 chips
- **Input voltage limit:** >1.4 Vrms causes distortion on some Chinese CS42448 boards (your AVR outputs ~2 Vrms — need input attenuation or verify your specific board)
- **EEPROM flash failures:** SigmaStudio shows success but board doesn't work — no audio, no readbacks. Multiple users report this
- **Power delivery marginal:** "The hardware is on the edge cost-quality wise" — vendors call them "educational boards." ADAU1452 can sink 2A at full MIPS but board VRMs may not support it
- **Some users gave up entirely:** "just bad boards that do not work out of the factory"
- **Analog output filter inadequate:** CS42448 passive output filter on Chinese boards needs removal/replacement for best performance
- **Signal delay:** ADAU1452 introduces processing latency (~1 ms at 48 kHz) — not relevant for subwoofers but matters if mixing with non-DSP channels

### Key Takeaway for Your Build
The ADAU1452+CS42448 Chinese boards are a viable platform but expect to debug hardware issues. The chip itself is excellent; the board implementation is the weak link. Consider:
1. **Budget for a spare board** (~$55) in case you get a dud
2. **Verify input voltage handling** before connecting AVR outputs (attenuate to <1.4 Vrms if needed, or use the Denon's sub pre-out level control)
3. **freeDSP Aurora** (~$150-200) is the higher-quality alternative if Chinese boards frustrate you, but it's 3-4x the price
4. **tecteun's GitHub repo** (github.com/tecteun/ADAU1452_DSP) documents the Chinese board pinout and SigmaStudio project — community resource

---

## 3. ADAU1701 DAC Output Quality — Real-World vs Spec

### Datasheet Specs (ADAU1701)
| Parameter | Spec |
|-----------|------|
| DAC SNR | 104 dB |
| DAC THD+N | -90 dB |
| Full-scale output | 0.9 Vrms (2.5 Vpp) |
| DAC gain tolerance | +/-10% |

### Real-World Measurements
| Source | Measurement | Context |
|--------|-------------|---------|
| diyAudio user (Sure module) | 0.927 Vrms | 1 kHz static test, within spec |
| EngineerZone (ADI engineer) | 0.865 Vrms | Within +/-10% tolerance, confirmed normal |
| miniDSP 2x4 (diyAudio) | -86 dBV broadband noise | Full-bandwidth, inputs shorted |
| CyberPit (diyAudio) | -83 dB THD+N end-to-end | ADC+DAC cascaded; DAC alone is better |
| CyberPit (diyAudio) | -93 dB THD+N | With external PCM5102A DAC (10 dB better) |
| ASR (Wondom unit) | "ADCs and DACs perfectly adequate for almost any purpose" | Qualitative assessment |

### Consensus
- DAC-only performance meets the -90 dB THD+N spec
- End-to-end (ADC+DAC) degrades to -83 dB due to ADC limitations — irrelevant for your use case (no ADC in the signal path when using as DAC/signal source)
- Broadband noise is -86 dBV, but subwoofer-band noise (5-200 Hz) is dramatically lower because noise energy is concentrated at higher frequencies
- The 0.9 Vrms output is low by modern standards but adequate with proper gain staging (your 898B at +12 dB is appropriate)
- External PCM5102A gains ~10 dB improvement — not worth the complexity for sub-only use

---

## 4. ADAU1701/1452 Combo for Home Theater Sub Processing

### Forum Evidence
- **No one found using this exact combo** (ADAU1701 as preamp/DAC feeding ADAU1452 for sub DSP). This is a custom architecture.
- Multiple users run ADAU1701 boards standalone for 2.1 crossover with subwoofer output — proven use case
- Multiple users run ADAU1452 boards for multi-way active crossover — proven use case
- The ADAU1452+AD1938 combo board is popular for 3-way active speakers on diyAudio
- Your architecture (ADAU1701 as DAC source -> balanced output -> ICEpower) is simpler than most forum builds since you're not using the ADAU1701's DSP processing at all — just its DAC

### Closest Comparable Projects
1. **diyAudio "ADAU1701 based DSP for sub or 2 way"** — users building 2.1 systems with ADAU1701 handling crossover and sub EQ
2. **diyAudio "ADAU1452+AD1938 DSP crossover"** — active multi-way with ADAU1452 doing all processing
3. **freeDSP Aurora** — ADAU1452-based 8-channel DSP used for subwoofer amplifier projects (AVS Forum thread)

---

## 5. SigmaStudio COM Automation Experiences

### Positive
- Official Python scripting example exists: `wiki.analog.com/resources/tools-software/sigmastudio/usingsigmastudio/scripting/python`
- Users have successfully used `win32com` to read/write I2C registers from Python
- `server.new_project`, `REGISTER_WRITE`, and related methods documented
- tkrome's GitHub `SigmaStudio-Server-Registration` tool automates COM server registration
- Wei1234c's GitHub `SigmaDSP` project controls ADAU1701/1401 from PC or ESP32

### Negative
- **Inconsistent behavior across PCs:** "the original code works on some PCs but not others — even with exactly the same SigmaStudio, Python, and win32com library versions"
- **Cryptic errors:** "debugging these COM errors is not a simple task, as the layers between Python and SigmaStudio are somewhat black boxes"
- **Return value bug:** "Most API calls that return a value return it as the last argument to the function. However, from Python, the returned value ends up in an unexpected location"
- **Extra parameters workaround:** Adding three additional parameters set to 0 can resolve some `set_object_property` invocations
- **REGISTER_WRITE_ARRAY fails from Python** — must use individual `REGISTER_WRITE` calls (you already know this from your pipeline)
- **Must compile and download project first** before register writes work
- **Wrong register address = unforeseen consequences** — no guard rails

### Key Takeaway for Your Build
You've already navigated most of these issues in your `tools/dsp/` pipeline. The main remaining risks are:
1. SigmaStudio updates breaking COM interface (pin to 4.7)
2. COM server registration can break after Windows updates (keep RegAsm command documented)
3. Values >= 0x80000000 must be converted to signed (you already handle this)

---

## 6. ICP5 Programmer Gotchas

### Critical Issues
1. **Reversed connector = destroyed hardware:** Connecting the 6-pin ribbon backwards applies +5V to the WP pin, which can **burn both the DSP and EEPROM**. Triple-check pin 1 orientation before connecting.
2. **EEPROM write failures:** Progress bar completes but checksum mismatch prevents actual programming. May require multiple attempts or recompiling the SigmaStudio project.
3. **Noise injection:** ICP5 connected = audible noise in speakers (white noise, whine, periodic ticking). Disconnect ICP5 after programming for listening/measurement.
4. **Random EEPROM refusal:** Sometimes refuses to write with no settings changes — may be related to incorrect checksum during compilation
5. **Power supply sensitivity:** Board voltage below 3.3V causes DSP to run hot when programmer is connected

### ICP5 vs Alternatives
- ICP5 runs cooler than ICP3
- USBi is the official ADI programmer ($25 TinySine clone) — also works but same ribbon cable risk
- ICP5 works with both ADAU1701 and ADAU1452

### Key Takeaway for Your Build
1. **Mark pin 1 clearly** on both the ICP5 cable and board header before first connection
2. **Disconnect ICP5 during measurement** — noise injection will corrupt your measurements
3. **Keep a known-good EEPROM backup** — export hex after every successful flash
4. **Use SigmaStudio "Link Compile Download"** rather than EEPROM write during development — faster iteration, saves EEPROM write cycles

---

## 7. Alternative Platforms Worth Knowing About

| Platform | Price | Pros | Cons |
|----------|-------|------|------|
| **freeDSP Aurora** | ~$150-200 | Open source, USB Audio, WiFi, measured -104 dB THD, proper analog stages | Higher cost, may need assembly |
| **3E Audio ADAU1701** | ~$40-60 | Higher input sensitivity (3V vs 0.9V), balanced outputs, quality op-amps | Still ADAU1701 (limited processing) |
| **miniDSP 2x4 HD** | ~$200 | Proven, GUI, community support | 20 Hz floor on some filters, closed ecosystem |
| **Dayton DSP-408** | ~$300 | 4-in/8-out, app control | Hard 20 Hz minimum, opaque processing |
| **BDSP2.4U** | ~$50 | ADAU1701-based, measured on ASR | Limited I/O |

---

## Bidirectional Search

- **Searched FOR:** "ADAU1701 reliable silent subwoofer," "ADAU1452 subwoofer processing success," "ADAU1701 DAC adequate quality," "SigmaStudio COM automation works Python," "ICP5 programmer reliable," "B0CJBV1KMP positive review," "Chinese ADAU1452 board works well"
- **Searched AGAINST:** "ADAU1701 noise problems hiss failures," "ADAU1452 Chinese board problems quality issues DOA," "SigmaStudio COM unreliable bugs crashes," "ICP5 programmer destroy burn gotcha," "B0CJBV1KMP noise issues," "ADAU1701 reliability long term failures distorted," "freeDSP Aurora vs Chinese board quality"
- **Contradicting evidence found:** Yes — significant. Chinese ADAU1452 boards have documented QC issues (wrong components, EEPROM failures, noise). ICP5 reversed connector can destroy hardware. SigmaStudio COM has cross-machine inconsistencies. However, the chips themselves (ADAU1701, ADAU1452) are well-regarded and the issues are implementation/board-quality related, not silicon defects.

---

## Summary Risk Assessment

| Component | Risk Level | Primary Risk | Mitigation |
|-----------|-----------|--------------|------------|
| B0CJBV1KMP (ADAU1701 preamp) | **LOW** | USB power noise, documentation gaps | Clean 5V supply, bench test before committing |
| ADAU1452+CS42448 Chinese board | **MEDIUM** | QC lottery, input voltage limit, EEPROM failures | Budget spare board, verify input levels, keep hex backups |
| SigmaStudio 4.7 COM | **LOW-MEDIUM** | Cross-machine inconsistencies, cryptic errors | Pin to 4.7, document working RegAsm config, test on target PC |
| ICP5 programmer | **LOW** | Reversed connector = hardware damage | Mark pin 1, disconnect during measurement |
| ADAU1701 DAC quality | **LOW** | 0.9 Vrms output, -86 dBV broadband noise | Adequate for sub-only; 898B gain staging is appropriate |
| ADAU1452 DSP processing | **VERY LOW** | None significant — chip is proven | N/A |

---

## Sources

### diyAudio
- [Sure ADAU1701 DSP opinions?](https://www.diyaudio.com/community/threads/sure-adau1701-dsp-opinions.350431/)
- [Is ADAU1701 good enough for real speakers?](https://www.diyaudio.com/community/threads/is-adau1701-good-enough-for-real-speakers.428058/)
- [ADAU1701 based DSP for sub or 2 way](https://www.diyaudio.com/community/threads/adau1701-based-dsp-for-sub-or-2-way.347460/)
- [Low cost ADAU1452 China board (29+ pages)](https://www.diyaudio.com/community/threads/low-cost-adau1452-china-board.309680/)
- [Cheap AliExpress/eBay ADAU1452 development boards](https://www.diyaudio.com/community/threads/cheap-aliexpress-ebay-adau1452-development-boards.320994/)
- [New Sure Electronics ADAU1701 Module](https://www.diyaudio.com/community/threads/new-sure-electronics-adau1701-module.294423/)
- [FreeDSP Aurora, JAB5, ADAU1452, ADAU1701 - Mess](https://www.diyaudio.com/community/threads/freedsp-aurora-jab5-adau1452-adau1701-mess.417218/)
- [ADAU1701 audio completely distorted after a while](https://www.diyaudio.com/community/threads/adau1701-audio-completely-distorted-after-a-while.372088/)
- [ADAU1452+AD1938 DSP crossover](https://www.diyaudio.com/community/threads/adau1452-ad1938-dsp-crossover.423506/)
- [ADAU1701 programmer](https://www.diyaudio.com/community/threads/adau1701-programmer.354277/)
- [miniDSP 2x4 noise floor](https://www.diyaudio.com/community/threads/minidsp-2x4-noise-floor.251361/)
- [WONDOM ADAU1701 without extension board](https://www.diyaudio.com/community/threads/wondom-adau1701-without-extension-board.393160/)
- [freeDSP V2.0 (ADAU1452) development thread](https://www.diyaudio.com/community/threads/freedsp-v2-0-adau1452-developement-thread.268660/)

### Audio Science Review (ASR)
- [Sigma ADAU1701 Review (DSP Board)](https://www.audiosciencereview.com/forum/index.php?threads/sigma-adau1701-review-dsp-board.19981/)
- [New Wondom ADAU1701 DSP Unit](https://www.audiosciencereview.com/forum/index.php?threads/new-wondom-adau1701-dsp-unit.46656/)
- [BDSP2.4U ADAU1701 DSP review](https://www.audiosciencereview.com/forum/index.php?threads/bdsp2-4u-adau1701-dsp-review.65189/)

### AVS Forum
- [FreeDSP Aurora high quality 8 channel DSP](https://www.avsforum.com/threads/freedsp-aurora-high-quality-8-channel-dsp-low-price-fir-usb-open-source.3051190/)
- [Sure Electronics AA-AP23123 with ADAU1701](https://www.avsforum.com/threads/anyone-has-experience-with-this-cheap-dsp-sure-electronics-aa-ap23123-with-adau1701.3298374/)
- [DIY Subs DSP needed with flagship Denon AVR?](https://www.avsforum.com/threads/diy-subs-dsp-needed-with-flagship-denon-avr.3190076/)

### Analog Devices EngineerZone
- [ADAU1701 noise/tone issues](https://ez.analog.com/dsp/sigmadsp/f/q-a/65144/adau1701-noise-tone-issues)
- [ADAU1452 how to use SafeLoad mechanism](https://ez.analog.com/dsp/sigmadsp/f/q-a/65655/adau1452-how-to-use-the-safeload-mechanism)
- [SigmaStudio COM interface Python example fails](https://ez.analog.com/dsp/sigmadsp/f/q-a/534278/sigmastudio-com-interface-python-example-fails)
- [Control SigmaDSP ADAU1701/1401 from PC or ESP32](https://ez.analog.com/dsp/sigmadsp/f/discussions/555812/control-sigmadsp-adau1701-adau1401-from-pc-or-esp32)
- [ADAU 1452/51 I2C Safeload doesn't work](https://ez.analog.com/dsp/sigmadsp/f/discussions/64555/adau-1452-51-i2c-safeload-doesnt-work)

### GitHub
- [tecteun/ADAU1452_DSP — Chinese low cost eval board](https://github.com/tecteun/ADAU1452_DSP)
- [tkrome/SigmaStudio-Server-Registration](https://github.com/tkrome/SigmaStudio-Server-Registration)
- [Wei1234c/SigmaDSP — Control from PC or ESP32](https://github.com/Wei1234c/SigmaDSP)
- [freeDSP/freeDSP-aurora](https://github.com/freeDSP/freeDSP-aurora)

### Amazon
- [ADAU1701 2.1 DSP Preamp Crossover (B0CJBV1KMP)](https://www.amazon.com/ADAU1701-Digital-Processing-AdjustmentSupport-Sigmastudio/dp/B0CJBV1KMP)
