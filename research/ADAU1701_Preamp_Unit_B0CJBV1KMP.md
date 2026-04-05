# ADAU1701 2.1 Preamp Unit (Amazon B0CJBV1KMP)

**Date:** 2026-03-20
**Status:** RESEARCH — Candidate replacement for Wondom APM2 boards in DSP subwoofer processing
**Source:** https://www.amazon.com/dp/B0CJBV1KMP

---

## Product Summary

ADAU1701-based DSP preamp in aluminum enclosure. 2-in / 4-out with built-in RCA jacks, front panel controls, SigmaStudio-compatible via ICP5 programmer. $37 on Amazon.

## Specs (from listing)

| Spec | Value |
|------|-------|
| DSP chip | ADAU1701 |
| Configuration | 2-in / 4-out |
| I/O connectors | 6× RCA (2 in, 4 out) on rear panel |
| Enclosure | Aluminum housing |
| Programming | SigmaStudio via ICP5 (6-pin ribbon) |
| Demo program | Open-source, with HEX file for factory reset |
| Front panel | 4 potentiometers (HP filter, LP filter, HP bass, volume) + 2 switches (mute, phase) + LEDs |
| DAC outputs | 4 (DAC0/DAC1 = Bank A bass, DAC2/DAC3 = Bank B mid) |
| Default crossover | 2-way digital crossover (reprogrammable) |
| Price | $37 |

### GPIO/ADC Pin Mapping (from listing)

| Control | Pin | Default Function |
|---------|-----|-----------------|
| POT1 | MP3/ADC2 | High-pass filter mid-range (3kHz-20kHz) |
| POT2 | MP8/ADC3 | Low-pass filter bass (210Hz-3kHz) |
| POT3 | MP9/ADC0 | High-pass filter bass (10Hz-310Hz) |
| POT4 | VOL | Overall volume |
| SW1 | — | Mute |
| SW2 | — | Phase |

## Relevance to Theater Build

### Why This Board (vs Wondom APM2)

| Feature | APM2 | This unit |
|---------|------|-----------|
| Price | $40 | $37 |
| DSP | ADAU1701 | ADAU1701 (same) |
| Config | 2-in / 4-out | 2-in / 4-out (same) |
| Enclosure | Bare PCB | Aluminum housing |
| I/O | Header pins | RCA jacks |
| Front panel | None | Pots, switches, LEDs |
| ICP5 compatible | Yes | Yes |
| SigmaStudio | Yes | Yes |

### Intended Use in Option B (898B Path)

```
AVR X6800H (RCA) → This unit (RCA in, DSP, internal DAC, RCA out ~0.9 Vrms)
    → Sonic Imagery Labs 898B (RCA in, +12 dB gain, XLR balanced out ~3.6 Vrms)
    → ICEpower 1200AS2 P105 (balanced in, 620W @ 8Ω)
```

- 2 units needed (4 inputs, 8 outputs total)
- 1 unit already owned by Andy
- Demo crossover program would be replaced with custom SigmaStudio project (HPF, PEQ, gain, summing)
- Front panel pots/switches can be ignored or repurposed in custom program

### Key Assumptions to Verify

1. Internal DAC output voltage is ~0.9 Vrms (standard ADAU1701 spec)
2. Internal DAC noise floor is adequate for subwoofer frequencies (< -90 dBFS)
3. ICP5 ribbon cable connector is same pinout as APM2
4. All 4 DAC outputs are accessible on RCA jacks (not just 2)
5. Custom SigmaStudio program can fully replace demo program
6. Aluminum enclosure provides adequate shielding

### Bench Test Plan

See `D:\Projects\Claude\theater\todo.md` for the full test protocol:
- Flash flat passthrough, measure noise floor, THD, frequency response, output voltage
- Pass/fail criteria defined
- If pass → order second unit + 898B

---

## Claim Verification (2026-03-20)

### Claim 1: Contains a genuine ADAU1701 DSP chip
**Verdict: TRUE | Confidence: HIGH**

The board is manufactured by Wondom (Sure Electronics), model ADSP1701-2.4U. Wondom is the largest volume producer of ADAU1701-based boards and has a direct relationship with Analog Devices. The Amazon listing on amazon.ae explicitly brands it as "WONDOM ADAU1701." ASR forum threads confirm Wondom boards use genuine ADAU1701 silicon. No reports of counterfeit chips on Wondom-branded products were found.

**Caveat:** Generic/unbranded ADAU1701 boards from AliExpress have been flagged on diyAudio as potentially using remarked chips, but this specific Wondom product has not been implicated.

Sources: Amazon.ae listing (WONDOM branding), ASR "New Wondom ADAU1701 DSP Unit" thread, diyAudio "Sure Adau1701 DSP opinions" thread.

---

### Claim 2: DAC output is ~0.9 Vrms
**Verdict: TRUE (chip spec) / UNCERTAIN (board output) | Confidence: MEDIUM**

The ADAU1701 datasheet specifies DAC full-scale output of 0.9 Vrms (2.5 Vp-p). This is confirmed across the Analog Devices datasheet, Digi-Key hosted datasheet, and EngineerZone posts. A measurement on a Sure Electronics ADAU1701 board confirmed 0.927 Vrms at full scale.

**However:** The ADSP1701-2.4U includes PT2259 volume control ICs in the output path (confirmed by block diagram in user manual). The PT2259 has a maximum attenuation of -79 dB and can only attenuate, not amplify. If the carbon volume pot (POT4) or the PT2259 is not at 0 dB, the actual RCA output will be lower than 0.9 Vrms. Additionally, one diyAudio post noted the "biggest limitation of the 1701 DACs is the limited 0.5V max output" in some board implementations, suggesting output buffering varies by board design.

**Action required:** Bench-verify actual RCA output voltage with custom program at digital full-scale, volume pot at max.

Sources: Analog Devices ADAU1701 datasheet (Rev D), EngineerZone post on input/output levels, diyAudio Sure Electronics ADAU1701 thread (page 6).

---

### Claim 3: Adequate noise performance for subwoofer duty (< -90 dBFS)
**Verdict: LIKELY TRUE | Confidence: MEDIUM**

**Datasheet specs (chip level):**
- DAC SNR: 104 dB
- DAC THD+N: -90 dB
- ADC-to-DAC dynamic range: 98.5 dB

**Real-world board measurements (from ASR and diyAudio):**
- ASR Sigma ADAU1701 review: balanced outputs measured on 3eaudio board, generally consistent with datasheet
- diyAudio user with 15 years on miniDSP (ADAU1701): "silent with good gain staging, no hiss even on 90 dB+ sensitivity speakers"
- EngineerZone: DAC0/DAC1 measured ~110 dB below reference; DAC2/DAC3 measured only ~94 dB below reference on one board (potential board-specific issue)

**Contradicting evidence:**
- Amazon review for B0CJBV1KMP: "aside from the slight hiss, the sound quality is crystal clear" -- confirms audible noise exists
- USB power from PC adds significant noise; separate power supply recommended
- Carbon volume potentiometer (POT4) may contribute noise
- PT2259 in signal path adds another noise source (PT2259 SNR >100 dB A-weighted per datasheet, so minimal)
- One diyAudio poster recommended external DAC chips for subwoofer duty to improve noise performance

**For subwoofer use specifically:** Sub frequencies are less sensitive to hiss (which is broadband/high-frequency). The 898B downstream provides +12 dB gain, which will amplify any DAC noise floor. With 95 dB sensitivity subs at 3-4 meter listening distance, and signals bandlimited to <120 Hz, practical noise audibility is very low.

**Action required:** Bench-measure noise floor with MOTU M2 loopback, clean 5V supply (not PC USB).

Sources: ADAU1701 datasheet, ASR "Sigma ADAU1701 Review" thread, diyAudio "ADAU1701 noise floor & dynamic range notes" thread, Amazon B0CJBV1KMP reviews, EngineerZone DAC2&3 noise thread.

---

### Claim 4: Can be programmed via ICP5/SigmaStudio 4.7
**Verdict: TRUE | Confidence: HIGH**

Confirmed by multiple independent sources:
- Wondom's own user manual for ADSP1701-2.4U provides step-by-step ICP5 programming instructions
- Sure Electronics published a SigmaStudio programming guide specifically for their ADAU1701 products
- Amazon listing explicitly states "Support Sigmastudio" and mentions ICP5 connection
- ICP5 switch settings documented: SW1=USBi, SW4=IIC (I2C for ADAU1701)
- 6-pin ribbon ICP port on rear panel confirmed in manual photos

No contradicting evidence found. This is a standard, well-documented capability.

Sources: Wondom ADSP1701-2.4U user manual, Sure Electronics SigmaStudio programming guide PDF, Amazon listing, boomaudio.de hosted manual PDF.

---

### Claim 5: PT2259 volume control is included on the board
**Verdict: TRUE | Confidence: HIGH**

Confirmed by the ADSP1701-2.4U user manual block diagram, which shows two PT2259 ICs:
- One PT2259 on DAC0/DAC1 (Bank A, bass channels)
- One PT2259 on DAC2/DAC3 (Bank B, mid channels)

The POT4 (VOL) knob on the front panel controls overall volume through the PT2259. The PT2259 is an I2C-controlled 2-channel volume attenuator (0 to -79 dB in 1 dB steps, SNR >100 dB).

**Implication for custom use:** The PT2259 sits between the ADAU1701 DAC outputs and the RCA jacks. In a custom SigmaStudio program, you can implement volume control digitally in DSP and leave the PT2259 at 0 dB (pot fully CW), but you cannot bypass the PT2259 hardware without PCB modification.

Sources: ADSP1701-2.4U user manual block diagram (boomaudio.de PDF, manuals.plus, device.report), PT2259 datasheet.

---

### Claim 6: Reliable enough for permanent installation
**Verdict: UNCERTAIN | Confidence: LOW**

**Supporting evidence:**
- Aluminum enclosure provides physical protection and some EMI shielding
- Wondom/Sure Electronics is an established manufacturer (10+ years in market)
- ADAU1701 chip itself is industrial-grade, widely deployed
- 1-year warranty from Wondom
- No moving parts, solid-state design

**Contradicting evidence:**
- diyAudio reports of DOA units from Sure Electronics ("boards seem to go out untested")
- Low-cost Chinese manufacturing with potential QC variance
- Amazon reviews are sparse (only ~8 reviews on .ca)
- USB-C power only (5V/1A) -- no barrel jack alternative, single point of failure
- Carbon potentiometers degrade over time (though irrelevant if pots are set-and-forget)
- No conformal coating or environmental protection visible
- No long-term reliability data found from any source

**For theater equipment closet use:** The board would sit in a climate-controlled, low-vibration environment powered by a quality 5V USB supply. These are favorable conditions. The main risk is infant mortality (DOA or early failure), not long-term degradation.

**Mitigation:** You already own one unit. Bench testing will catch infant mortality. Keep a spare ($37 is cheap insurance).

Sources: diyAudio "Sure Adau1701 DSP opinions" thread, Amazon reviews, Wondom warranty terms.

---

## Bidirectional Search

- **Searched FOR:** "ADAU1701 preamp B0CJBV1KMP review," "ADAU1701 DAC 0.9 Vrms datasheet," "ADAU1701 ICP5 SigmaStudio programming," "PT2259 volume control ADSP1701," "ADAU1701 noise subwoofer adequate," "Wondom ADAU1701 reliability"
- **Searched AGAINST:** "cheap ADAU1701 board fake counterfeit clone quality issues," "ADAU1701 noise hiss problem dead DOA," "ADAU1701 DAC 0.5V limitation," "ADAU1701 not good enough subwoofer"
- **Contradicting evidence found:** Yes --
  1. Amazon reviewer reports "slight hiss" on this specific unit
  2. diyAudio reports DOA units from Sure Electronics product line
  3. USB PC power causes significant noise (mitigated by clean external supply)
  4. One diyAudio poster claims DAC limited to 0.5V output on some boards (unconfirmed for this specific board)
  5. diyAudio community members recommend external DAC for subwoofer duty over built-in ADAU1701 DACs
  6. Carbon potentiometer identified as potential noise source

---

## Summary Table

| # | Claim | Verdict | Confidence | Bench Test Needed? |
|---|-------|---------|------------|-------------------|
| 1 | Genuine ADAU1701 chip | TRUE | HIGH | No |
| 2 | DAC output ~0.9 Vrms | TRUE (chip), uncertain (board) | MEDIUM | **Yes** |
| 3 | Noise < -90 dBFS for sub duty | Likely TRUE | MEDIUM | **Yes** |
| 4 | ICP5/SigmaStudio programmable | TRUE | HIGH | No (already confirmed by Andy) |
| 5 | PT2259 volume control included | TRUE | HIGH | No |
| 6 | Reliable for permanent install | Uncertain | LOW | Partially (infant mortality) |

**Bottom line:** Claims 1, 4, 5 are solid. Claims 2 and 3 are plausible but the PT2259 in the output path and USB power design introduce variables that only bench measurement can resolve. Claim 6 has insufficient long-term data -- mitigate with a spare unit. Proceed with the bench test plan already defined.

---

## Forum Investigation: Community Experiences (2026-03-20)

Adversarial investigation across diyAudio, AudioScienceReview (ASR), AVS Forum, EngineerZone, and general web. Reddit blocked by crawler. Head-Fi had no relevant ADAU1701 threads.

### Board Identity

The B0CJBV1KMP is the **Wondom AA-AP23123** (also sold as ADSP1701-2.4U). Same board sold via Amazon, AliExpress, Audiophonics (EU), and Sure Electronics store. The aluminum-enclosed version is the newer variant of Wondom's bare ADAU1701 boards.

Key detail: **the miniDSP 2x4 (non-HD) uses the same ADAU1701 chip internally.** The B0CJBV1KMP is essentially the same DSP in a different package at ~1/3 the price.

---

### PRO: Reasons to Use This Board

**1. Exceptional value for money**
- ASR user Weeb Labs (Aug 2023): "very nicely designed unit for very little money"
- ASR user kemmler3D (Nov 2023): praised as breaking the "MiniDSP monopoly"
- $37 vs $100+ for miniDSP 2x4
- Source: [ASR -- New Wondom ADAU1701 DSP Unit](https://www.audiosciencereview.com/forum/index.php?threads/new-wondom-adau1701-dsp-unit.46656/)

**2. Proven chip, mature ecosystem**
- ADAU1701 is the same chip in miniDSP 2x4, Dayton DSP-408, countless DIY builds
- diyAudio user reports running ADAU1701-based system "24/7 for years" transparently
- 15+ year track record in DIY audio community
- Source: [diyAudio -- Is ADAU1701 good enough for real speakers?](https://www.diyaudio.com/community/threads/is-adau1701-good-enough-for-real-speakers.428058/)

**3. Adequate performance for subwoofer DSP specifically**
- Multiple diyAudio users confirm ADAU1701 is "as good as you'll ever need" for subwoofers
- Subwoofer frequencies are well below where ADC/DAC limitations matter most
- At sub frequencies, speaker and room are the dominant noise sources
- THD+N of -90 dB on DAC is irrelevant when the driver itself is orders of magnitude worse
- Source: [diyAudio -- DSP recommendations](https://www.diyaudio.com/community/threads/dsp-recommendations-decent-performance-for-less-than-minidsp.372440/)

**4. Aluminum enclosure with RCA I/O**
- No bare PCB wiring -- plug-and-play RCA connections
- Enclosure provides EMI shielding (relevant in a rack near ICEpower amps)
- Front panel controls can be ignored in custom SigmaStudio program

**5. Fully reprogrammable**
- Custom SigmaStudio projects fully replace factory firmware
- Wondom publishes open-source demo programs
- ICP5 programming confirmed working (4 wires: +5V, GND, SCL, SDA)
- Source: [ASR thread, Weeb Labs posts](https://www.audiosciencereview.com/forum/index.php?threads/new-wondom-adau1701-dsp-unit.46656/)

**6. PT2259 digital volume control reduces noise at normal levels**
- Onboard PT2259 IC reduces DAC noise floor at normal listening levels
- ASR user Weeb Labs described this as "unexpectedly sophisticated" for the price
- Source: [ASR thread page 1](https://www.audiosciencereview.com/forum/index.php?threads/new-wondom-adau1701-dsp-unit.46656/)

---

### CON: Reasons NOT to Use This Board

**1. Low DAC output voltage (~0.5-0.9 Vrms)**
- ASR measurement (Amirm, Feb 2021): output clips above 1.1V on 3e Audio board
- ADAU1701 datasheet max DAC output: 0.9 Vrms
- Some boards report only 0.5V due to implementation/buffering choices
- Requires careful gain staging with downstream amplifier
- With 898B providing +12 dB gain, 0.9V -> ~3.6V -- adequate for ICEpower 1200AS2
- Source: [ASR -- Sigma ADAU1701 Review](https://www.audiosciencereview.com/forum/index.php?threads/sigma-adau1701-review-dsp-board.19981/)

**2. Mediocre ADC/DAC specs (on-chip)**
- DAC THD+N: -83 to -90 dB (varies by implementation)
- ADC THD+N: -83 dB
- Dynamic range: ~98.5 dB (per Wondom spec sheet)
- "Dynamic range barely makes it past 16 bits" -- Amirm, ASR
- For subwoofer use this is likely acceptable; for full-range it's borderline
- Source: [ASR review](https://www.audiosciencereview.com/forum/index.php?threads/sigma-adau1701-review-dsp-board.19981/)

**3. Supply voltage issues on THIS SPECIFIC BOARD**
- ASR measurements (net-david, Nov 2023): analog supply U203 at only 3.18V
- SGM8904 line driver spec requires minimum 5V for optimal performance
- PT2259 volume IC requires minimum 4V
- Both chips are undervolted -- limits output swing and increases distortion
- THD+N measured at 0.115% at -6.76 dB -- worse than chip's raw capability
- Voltage regulator bypass mod fixes this (see Modifications below)
- Source: [ASR thread pages 2-3](https://www.audiosciencereview.com/forum/index.php?threads/new-wondom-adau1701-dsp-unit.46656/page-2)

**4. QC and DOA risk**
- diyAudio user grahamgraham: DOA units from Sure Electronics
- diyAudio user grahamgraham: destroyed two boards due to unclear labeling/connector spacing
- Boards may ship untested (per Turbowatch2, diyAudio)
- Wondom provides no software support -- hardware distributor only
- Source: [diyAudio -- Sure ADAU1701 DSP opinions](https://www.diyaudio.com/community/threads/sure-adau1701-dsp-opinions.350431/)

**5. No SPDIF I/O (analog only)**
- RCA analog in/out only -- double A/D-D/A conversion if source is digital
- For this use case (AVR analog sub out -> DSP -> amp) this is fine
- Source: ASR user kemmler3D specifically wished for SPDIF variant

**6. Potential thermal distortion failure mode**
- diyAudio report: ADAU1701 audio becomes "completely distorted" after ~30 minutes
- Root cause: missing DC discharge path on ADC input coupling capacitor
- Fix: add 100K resistor to ground after coupling cap
- Reported on custom board, not confirmed on Wondom enclosure -- but worth monitoring
- Source: [diyAudio -- ADAU1701 audio completely distorted after a while](https://www.diyaudio.com/community/threads/adau1701-audio-completely-distorted-after-a-while.372088/)

**7. Power-on/off pop**
- Multiple diyAudio users report audible pop at power on/off
- No mute circuit on cheap boards
- Manageable with separate power sequencing (DSP on before amps)
- Source: [diyAudio -- ADAU1701 based DSP for sub](https://www.diyaudio.com/community/threads/adau1701-based-dsp-for-sub-or-2-way.347460/)

**8. EEPROM write protection gotcha**
- WP pin must be bridged to GND to write EEPROM (Weeb Labs, ASR)
- If you can't flash new firmware, check this first
- Source: [ASR thread](https://www.audiosciencereview.com/forum/index.php?threads/new-wondom-adau1701-dsp-unit.46656/)

**9. USBi programmer quirks**
- 10-pin USBi cable may not fit Wondom's 6-pin JST connector
- Tinysine USBi recommended as "far more stable and robust" than Wondom ICP
- Dupont jumper wires work -- only 4 connections needed (+5V, GND, SCL, SDA)
- Must provide external USB-C power during programming
- Source: [ASR thread](https://www.audiosciencereview.com/forum/index.php?threads/new-wondom-adau1701-dsp-unit.46656/)

---

### Modifications People Have Made

1. **Voltage regulator bypass** -- Remove U203, jumper across inductors for ~4.74V output. "Easiest route" per ASR user. Fixes undervolted SGM8904/PT2259.
2. **External DAC** -- Replace internal DAC with PCM5102 for better performance (overkill for sub use).
3. **Input resistor swap** -- Change to 18.8K for 2.0 Vrms input sensitivity (3e Audio board variant).
4. **SPDIF add-on** -- Headers exist for TOSLINK RX/TX on some variants.
5. **DC bias resistor** -- Add 100K to ground after coupling caps to prevent thermal drift distortion.

---

### Comparison with Alternatives

| Feature | B0CJBV1KMP (Wondom) | miniDSP 2x4 | miniDSP 2x4 HD | Dayton DSP-408 |
|---------|---------------------|-------------|----------------|----------------|
| DSP chip | ADAU1701 | ADAU1701 | ADAU1452 | ADAU1701 |
| Price | $37 | $100 | $200 | $150 |
| Config | 2-in/4-out | 2-in/4-out | 2-in/4-out | 4-in/8-out |
| Dynamic range | ~98 dB | ~98 dB | ~103 dB | ~98 dB |
| I/O | RCA analog | RCA analog | RCA + TOSLINK | RCA analog |
| Enclosure | Aluminum | Aluminum | Aluminum | Aluminum |
| GUI software | SigmaStudio | miniDSP plugin | miniDSP plugin | DSP-408 app |
| Programming | ICP5/USBi required | USB plug-in | USB plug-in | USB plug-in |

Key insight: the miniDSP 2x4 (non-HD) has **identical DSP performance** -- same ADAU1701 chip. The $63 premium buys miniDSP's user-friendly plugin software vs. SigmaStudio's learning curve. Since you already know SigmaStudio, the Wondom board is the rational choice.

---

### Verdict for Subwoofer DSP Use

**GO -- with caveats.** The board is suitable for subwoofer DSP processing in this signal chain:

```
AVR X6800H (RCA sub out) -> B0CJBV1KMP (DSP: HPF, PEQ, gain) -> 898B (+12 dB) -> ICEpower 1200AS2
```

**Why it's fine:**
- Subwoofer bandwidth (10-120 Hz) is extremely forgiving of DAC limitations
- 0.9V output + 898B gain = ~3.6V into ICEpower -- good gain staging
- Same chip as miniDSP 2x4, which thousands use for sub DSP
- You already own one and know SigmaStudio
- Aluminum enclosure with RCA = clean installation

**What to validate in bench test:**
1. Measure actual DAC output voltage (confirm 0.9V or check if undervolted to 0.5V)
2. Measure noise floor with flat passthrough -- if hiss is audible at sub amp idle, consider voltage regulator bypass mod
3. Run for 60+ minutes and check for thermal drift distortion
4. Confirm EEPROM write works (check WP pin if not)
5. Confirm all 4 RCA outputs are independently controllable

**Risk mitigations:**
- 898B gain stage downstream compensates for low output voltage
- If board fails bench test, you're out $37 and pivot to ADAU1452 (already in the design)
- Subwoofer frequencies mask most analog deficiencies
- Keep a spare unit ($37 insurance)

---

### Forum Investigation Bidirectional Search

- **Searched FOR:** "ADAU1701 preamp board review," "Wondom ADAU1701 experience," "ADAU1701 subwoofer DSP adequate," "ADAU1701 good enough real speakers," "B0CJBV1KMP review," "3e audio ADAU1701 quality," "ADAU1701 vs miniDSP comparison"
- **Searched AGAINST:** "ADAU1701 noise floor problem," "ADAU1701 failure reliability dead," "ADAU1701 output voltage too low hiss," "ADAU1701 distorted after a while," "ADAU1701 board DOA," "cheap DSP board problems," "ADAU1701 board failure reliability problems dead"
- **Contradicting evidence found:** Yes -- undervolted supply rails (3.18V vs 5V spec for line driver), 0.115% THD+N measurement, DOA reports on Sure boards, thermal drift distortion failure mode, power-on pop, "slight hiss" reported by Amazon reviewer. All documented above with sources.
