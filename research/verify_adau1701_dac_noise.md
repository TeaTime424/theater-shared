# Verification: ADAU1701 internal DAC has adequate noise performance for subwoofer processing (5-200 Hz), with noise floor below -90 dBFS

**Date:** 2026-03-20
**Verdict:** LIKELY
**Confidence:** MEDIUM

## Claim
The ADAU1701 internal DAC has adequate noise performance for subwoofer processing (5-200 Hz), with noise floor below -90 dBFS.

## Sources

### Source 1: Analog Devices ADAU1701 Datasheet
- **URL:** https://www.analog.com/media/en/technical-documentation/data-sheets/adau1701.pdf
- **Type:** Datasheet (manufacturer)
- **Evidence:** DAC SNR = 104 dB, DAC THD+N = -90 dB. Combined ADC-to-DAC dynamic range = 98.5 dB. Full-scale output = 0.9 Vrms (2.5 Vpp). 24-bit sigma-delta DACs.
- **Supports/Contradicts:** SUPPORTS the -90 dB THD+N claim. The 104 dB DAC SNR exceeds -90 dBFS. However, these are DAC-only specs measured under ideal conditions.

### Source 2: diyAudio — "Is ADAU1701 good enough for real speakers?"
- **URL:** https://www.diyaudio.com/community/threads/is-adau1701-good-enough-for-real-speakers.428058/
- **Type:** Forum (community)
- **Evidence:** ernperkins confirmed DAC THD+N at -90 dB. DAC output voltage is 0.9 Vrms, described as "low compared to many DACs whose outputs are 2 or 4V RMS." newvirus2008 stated ADAU devices are adequate because "loudspeakers are the weak link in the signal chain." One user reported running miniDSP (ADAU1701-based) silently with 90 dB+ sensitivity speakers for 15 years.
- **Supports/Contradicts:** SUPPORTS — experienced users confirm adequate performance, especially for low-frequency applications.

### Source 3: diyAudio — "ADAU1701 based DSP for sub or 2 way" (Page 4)
- **URL:** https://www.diyaudio.com/community/threads/adau1701-based-dsp-for-sub-or-2-way.347460/page-4
- **Type:** Forum (community, with measurements)
- **Evidence:** CyberPit measured the internal ADC at approximately -83 dB THD+N, while external PCM5102A achieves -93 dB — a 10 dB gap. However, Baldin concluded "there is actually not that much improvement in performance with the added PCM5102A." The internal DAC's -83 dB end-to-end performance was considered adequate for subwoofer applications.
- **Supports/Contradicts:** PARTIALLY CONTRADICTS — the measured end-to-end (ADC+DAC) performance is -83 dB, not -90 dB. The -90 dB is DAC-only. For subwoofer use (DAC-only, no ADC in feedback path), the claim holds.

### Source 4: diyAudio — "miniDSP 2x4 noise floor"
- **URL:** https://www.diyaudio.com/community/threads/minidsp-2x4-noise-floor.251361/
- **Type:** Forum (measurements)
- **Evidence:** miniDSP 2x4 (ADAU1701 reference circuit) measured at approximately -86 dBV output noise with inputs shorted. Users reported "distinct hiss" audible 5-8 inches from cones with efficient speakers. Multiple users with 84-85 dB sensitivity speakers found noise audible. Described as "not a real hi-fi device" for efficient full-range speakers.
- **Supports/Contradicts:** PARTIALLY CONTRADICTS — measured -86 dBV (broadband noise) is worse than -90 dBFS. However, this is full-bandwidth measurement; subwoofer-only band (5-200 Hz) would be significantly lower noise.

### Source 5: diyAudio — "New Sure Electronics ADAU1701 Module" + Sure FAQ
- **URL:** https://www.diyaudio.com/community/threads/new-sure-electronics-adau1701-module.294423/page-6
- **Type:** Forum (community)
- **Evidence:** Amps with 32 dB gain produce audible hiss; 26 dB gain works best with ADAU1701's 0.9V max output. 20 dB gain is quietest. Gain staging is critical. Power supply noise (switching supplies in ADC oversampling band) can inject additional noise.
- **Supports/Contradicts:** CONDITIONAL — noise depends heavily on gain staging and power supply. With proper design, quiet operation is achievable.

### Source 6: EngineerZone — ADAU1701 noise/tone issues
- **URL:** https://ez.analog.com/dsp/sigmadsp/f/q-a/65144/adau1701-noise-tone-issues
- **Type:** Forum (manufacturer support)
- **Evidence:** Users report idle tones (1-2 kHz spurious sine waves) on DAC output. Some powerups show -120 to -112 dB noise floor, while others randomly show elevated noise by 2-3 dB. The idle tone issue appears board-dependent, not intrinsic to the chip.
- **Supports/Contradicts:** PARTIALLY CONTRADICTS — idle tones are a known issue with some implementations, though they occur at 1-2 kHz (above subwoofer band).

### Source 7: Project POR (existing design)
- **URL:** D:\Projects\Claude\theater\POR\15_DSP_Subwoofer_Processing.md
- **Type:** Documentation (project)
- **Evidence:** The current POR already uses external PCM5102 DACs for the signal chain, bypassing the internal DAC. This suggests the project team already determined external DACs were worth adding.
- **Supports/Contradicts:** CONTRADICTS the premise — if internal DAC were fully adequate, the POR would not specify external DACs.

## Bidirectional Search

- **Searched FOR:** "ADAU1701 DAC SNR 104 dynamic range specifications," "ADAU1701 subwoofer adequate quiet enough," "ADAU1701 DAC specifications SNR THD"
- **Searched AGAINST:** "ADAU1701 noise problems hiss DAC quality issues," "ADAU1701 DAC output noise -86 dBV," "miniDSP 2x4 ADAU1701 noise floor measurement," "ADAU1701 internal DAC vs external DAC PCM5102 comparison," "Wondom APM2 noise floor measured ASR diyAudio"
- **Contradicting evidence found:** Yes — measured broadband noise of -86 dBV on miniDSP 2x4 (ADAU1701 reference design), audible hiss with efficient speakers, idle tone artifacts, and the project's own POR specifying external DACs all suggest the internal DAC has limitations.

## Cross-Reference

**Where sources agree:**
- The ADAU1701 DAC datasheet spec of -90 dB THD+N and 104 dB SNR is consistent across all references
- All sources agree the 0.9 Vrms output is low, requiring careful gain staging
- Multiple sources confirm that for subwoofer-only applications, the internal DAC is more acceptable than for full-range use

**Where sources disagree:**
- Datasheet specs (-90 dB THD+N, 104 dB SNR) vs real-world measurements (-86 dBV broadband on miniDSP 2x4)
- Some users report silent operation for years; others report audible hiss — this is implementation-dependent (gain staging, PSU quality, board layout)

**Key caveat — the -90 dBFS claim needs context:**
- The datasheet DAC THD+N is -90 dB (DAC alone, optimal conditions) — this meets the claim
- The datasheet DAC SNR is 104 dB — this exceeds the claim
- Real-world broadband noise measurements show -86 dBV — this fails the claim
- But the subwoofer band (5-200 Hz) is a small fraction of the audio bandwidth; in-band noise will be significantly lower than broadband figures, likely meeting -90 dBFS within that band

## Verdict
**LIKELY**

The ADAU1701 DAC's datasheet specs (104 dB SNR, -90 dB THD+N) meet the -90 dBFS noise floor claim. Real-world broadband measurements on ADAU1701-based products (miniDSP 2x4) show -86 dBV, which is slightly worse, but this is full-bandwidth. For subwoofer-only processing (5-200 Hz), the in-band noise should be well below -90 dBFS because the subwoofer bandwidth is roughly 1/100th of the full audio band. Multiple users confirm quiet operation for subwoofer use specifically. However, the project's own POR chose external PCM5102 DACs, suggesting the team identified concrete benefits to bypassing the internal DAC.

## Caveats

1. **Broadband vs in-band:** The -90 dBFS claim is likely true within the 5-200 Hz subwoofer band, but broadband noise is approximately -86 dBV on real boards. Subwoofer crossover filtering will remove most of the noise energy (which is concentrated at higher frequencies).

2. **Implementation-dependent:** Noise performance varies significantly with PCB layout, power supply quality, and gain staging. The Wondom APM2 and Amazon B0CJBV1KMP unit may perform differently from the miniDSP reference design.

3. **Gain staging is critical:** The 0.9 Vrms DAC output is low. If the downstream amplifier has high gain (32 dB+), noise will be amplified proportionally. The 898B path adds +12 dB, which is moderate — this should be acceptable but will raise the noise floor by 12 dB at the amplifier output.

4. **Idle tones:** Some ADAU1701 implementations exhibit spurious tones at 1-2 kHz. These would be filtered out by the subwoofer crossover, so they are not a concern for sub-only use.

5. **The POR chose external DACs for a reason:** The PCM5102 provides 2.0 Vrms output (vs 0.9 Vrms), better THD+N (-93 vs -90 dB), and eliminates startup pop. For the Option B path (internal DAC + 898B gain), the lower output voltage means the 898B must provide more gain, amplifying noise proportionally. This is the real risk — not the DAC noise floor itself, but the system-level SNR after gain staging.
