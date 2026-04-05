# Verification: The ADAU1701 internal DAC outputs approximately 0.9 Vrms at full scale

**Date:** 2026-03-20
**Verdict:** CONFIRMED
**Confidence:** HIGH

## Claim
The ADAU1701 internal DAC outputs approximately 0.9 Vrms (2.5 Vpp) at full scale (0 dBFS). This is the foundation of the Option B signal chain: ADAU1701 DAC (0.9 Vrms) -> 898B (+12 dB) -> ICEpower 1200AS2 (needs 3.54 Vrms differential for 620W @ 8 ohm).

## Sources

### Source 1: Analog Devices ADAU1701 Datasheet (via EVAL-ADAU1701MINIZ documentation)
- **URL:** https://www.analog.com/media/en/technical-documentation/evaluation-documentation/eval-adau1701miniz.pdf
- **Type:** Datasheet / Manufacturer spec
- **Evidence:** "A full-scale output on the DACs is 0.9 V rms (2.5 V p-p)." This is stated directly in Analog Devices' evaluation board documentation referencing the ADAU1701 DAC specifications.
- **Supports/Contradicts:** SUPPORTS
- **Reliability:** Highest — manufacturer datasheet spec

### Source 2: Analog Devices EngineerZone — ADAU1701 Full Scale Output Voltage
- **URL:** https://ez.analog.com/dsp/f/q-a/54859/adau1701-full-scale-output-voltage-slightly-low-for-full-scale-input-voltage
- **Type:** Manufacturer support forum
- **Evidence:** A user measured output 35mV short of 0.9 Vrms full scale. Analog Devices engineer responded that the gain error on the ADC is +/-11% and for the DAC it is +/-10%, so the measurement was well within tolerance. This confirms 0.9 Vrms as the nominal spec with +/-10% tolerance (0.81 to 0.99 Vrms).
- **Supports/Contradicts:** SUPPORTS (and quantifies tolerance)
- **Reliability:** High — manufacturer engineer response with tolerance specs

### Source 3: diyAudio Forum — Sure Electronics ADAU1701 Module (measured)
- **URL:** https://www.diyaudio.com/community/threads/new-sure-electronics-adau1701-module.294423/page-6
- **Type:** Community measurement
- **Evidence:** User measured 0.927 Vrms at a DAC output, described as "2.6 V p-p" and stated this is "as much as can be obtained from the DAC without clipping." Also notes the DAC outputs are inverting (180-degree phase inversion). Measurements were static tests at 1 kHz.
- **Supports/Contradicts:** SUPPORTS (0.927 Vrms is within +3% of 0.9 Vrms spec)
- **Reliability:** High — actual measurement, consistent with datasheet

### Source 4: diyAudio Forum — ADAU1701 based DSP for sub or 2-way
- **URL:** https://www.diyaudio.com/community/threads/adau1701-based-dsp-for-sub-or-2-way.347460/
- **Type:** Community discussion
- **Evidence:** "The maximum DAC outputs are 0.9 V" with the board configured for 2 Vrms input, resulting in "an expected loss of 6.9 dBV." Also notes that Pro audio line level is 1.23V and "the ADAU1701 is spec'ed at .9V, so extra gain is needed to drive Pro audio."
- **Supports/Contradicts:** SUPPORTS
- **Reliability:** Medium — user reports consistent with datasheet

### Source 5: diyAudio Forum — Sure Electronics Module Extension Board
- **URL:** https://www.diyaudio.com/community/threads/new-sure-electronics-adau1701-module.294423/page-6
- **Type:** Community technical analysis
- **Evidence:** The APM3 extension board uses SGM4917 headphone amplifiers to boost the 0.9 Vrms DAC output to "professional-level 2V nominal output." This confirms the bare ADAU1701 DAC is 0.9 Vrms and that external amplification is the standard approach for higher output levels.
- **Supports/Contradicts:** SUPPORTS (confirms the voltage and the need for external gain)
- **Reliability:** Medium — community analysis of board schematic

### Source 6: Sonic Imagery Labs 898B Product Page
- **URL:** https://www.sonicimagerylabs.com/products/Model898B.html
- **Type:** Manufacturer specification
- **Evidence:** 898B converts -10 dBV (0.316 Vrms) unbalanced to +4 dBu (1.228 Vrms) balanced. Gain ratio: 1.228/0.316 = 3.886x = +11.8 dB (~+12 dB). Max output: +23 dBu (~10.9 Vrms). Input impedance: 10k ohm.
- **Supports/Contradicts:** SUPPORTS the signal chain math (see Cross-Reference below)
- **Reliability:** High — manufacturer spec

## Bidirectional Search

- **Searched FOR:** "ADAU1701 datasheet DAC output voltage full scale Vrms", "ADAU1701 DAC output voltage level diyaudio forum measured", "ADAU1701 DAC full scale 0.9 site:analog.com"
- **Searched AGAINST:** "ADAU1701 DAC output voltage problems low level issues", "ADAU1701 output voltage" (looking for contradicting measurements or specs)
- **Contradicting evidence found:** No. All sources consistently report 0.9 Vrms +/-10%. The only "problem" reports were users measuring slightly below 0.9 Vrms, which Analog Devices confirmed is within the +/-10% DAC gain error tolerance. No source reports a significantly different full-scale value.

## Cross-Reference

**All sources agree:** The ADAU1701 DAC full-scale output is 0.9 Vrms (2.5 Vpp) nominal, with +/-10% tolerance per the datasheet. Real-world measurements (0.865-0.927 Vrms) fall within this range.

**Signal chain validation:**
- ADAU1701 DAC: 0.9 Vrms (confirmed)
- 898B gain: +11.8 dB (3.886x) — confirmed from manufacturer specs
- 898B output from 0.9 Vrms input: 0.9 * 3.886 = **3.50 Vrms differential**
- ICEpower 1200AS2 target: 3.54 Vrms differential for 620W @ 8 ohm
- Delta: 3.50 vs 3.54 = **-0.1 dB shortfall** (1.1%)
- Power delivered: ~599W into 8 ohm (99.7% of rated)
- 898B headroom: +23 dBu max output (10.9 Vrms) vs 3.5 Vrms actual = **9.9 dB headroom**

**Tolerance risk:** With +/-10% DAC tolerance, worst-case low is 0.81 Vrms -> 898B output = 3.15 Vrms -> ~545W (88% of rated, -0.6 dB). Still well above the 95 dB target.

**Important caveat — APM2 vs APM3 output:** The bare APM2 board outputs the raw ADAU1701 DAC level (0.9 Vrms). The APM3 extension board adds SGM4917 headphone amplifiers that boost output to ~2V. Since Option B uses the APM2 internal DAC outputs into the 898B (not through APM3), the 0.9 Vrms figure is correct for this signal chain.

## Verdict
**CONFIRMED**

The ADAU1701 internal DAC outputs 0.9 Vrms at full scale. This is confirmed by the Analog Devices datasheet, manufacturer support (with +/-10% tolerance specification), and multiple independent measurements (0.865-0.927 Vrms). The Option B signal chain math checks out: 0.9 Vrms * 3.886 (898B gain) = 3.50 Vrms, which is within 1.1% of the 3.54 Vrms ICEpower target, delivering ~599W into 8 ohm.

## Caveats

1. **DAC gain tolerance is +/-10%.** Worst-case low output (0.81 Vrms) still delivers 545W (88% rated power). Not a practical concern for this application.
2. **The 898B gain is +11.8 dB, not exactly +12 dB.** The -10 dBV to +4 dBu conversion is 11.79 dB. This is already accounted for in the 3.50 Vrms calculation above.
3. **APM2 vs APM3 matters.** The APM3 extension board has output amplifiers (SGM4917) that boost to ~2V. If you route through APM3, you'd get ~2V into the 898B, which would produce ~7.8 Vrms output -- still within the 898B's +23 dBu max, but would deliver far more power than needed.
4. **DC offset.** The ADAU1701 DAC output has a 1.5V DC bias. The 898B's RCA inputs presumably have coupling capacitors, but verify this before connecting.
5. **Phase inversion.** The ADAU1701 DAC inverts polarity (180 degrees). The 898B's balanced output also inverts one leg. Net polarity through the chain should be verified during commissioning.
