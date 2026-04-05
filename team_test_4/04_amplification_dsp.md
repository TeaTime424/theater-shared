# Amplification, DSP & Signal Flow

## Sub Amplification: ICEpower 1200AS2

| Parameter | Value |
|-----------|-------|
| Model | ICEpower 1200AS2 |
| Quantity | 5 (3 active + 2 spare) |
| Voltage | 240V native |
| Power @ 8 ohm | 620W per channel (sustained burst) |
| Power @ 4 ohm | 1,200W per channel |
| Channels per unit | 2 |
| Infrasonic derating | **NONE -- flat to DC** |
| Cooling | **Fanless** |
| Modifications required | **NONE** |
| Input sensitivity | 1.0V for full output |
| AUX 5V output | Yes (powers APM2 boards) |
| Idle power | ~35W per unit |
| Unit cost | $373 |
| Total cost (5 units) | $1,865 |
| Chassis/heatsinks | $200 |
| **Subtotal** | **$2,065** |

### Assignment Table

| Unit | Channel 1 | Channel 2 | Load | Power/ch |
|------|-----------|-----------|------|----------|
| #1 | Corner FL (NW) | Corner FR (NE) | 8 ohm | 620W |
| #2 | Corner RL (SW) | Corner RR (SE) | 8 ohm | 620W |
| #3 | Tactile (4 shakers) | Tactile (4 shakers) | varies | varies |
| #4 | Spare (nearfield L if added) | Spare (nearfield R if added) | -- | -- |
| #5 | Spare | Spare | -- | -- |

### Electrical

All 5 units on a single 20A/240V circuit (Circuit A).

```
Peak draw: 5 x 620W = 3,100W (music peaks, not sustained)
Typical draw: ~500-800W (movie playback)
Idle draw: 5 x 35W = 175W
Circuit capacity: 20A x 240V = 4,800W
Utilization: 65% peak, ~15% typical
```

## Speaker Amplification: ATI AT525NC

| Parameter | Value |
|-----------|-------|
| Model | ATI AT525NC |
| Channels | 5 |
| Topology | NCore |
| Power @ 8 ohm | 200W |
| Power @ 6 ohm | ~300W |
| Power @ 4 ohm | ~500W |
| Cost | $0 (owned, $2,500 value) |

### Assignment

| Channel | Speaker | Impedance | Power |
|---------|---------|-----------|-------|
| 1 | Left (Titan-815LX) | 6 ohm | ~300W |
| 2 | Center (Titan-815LX) | 6 ohm | ~300W |
| 3 | Right (Titan-815LX) | 6 ohm | ~300W |
| 4 | Front Wide Left (Volt-10) | 8 ohm | 200W |
| 5 | Front Wide Right (Volt-10) | 8 ohm | 200W |

## Processor: Denon AVR-X6800H

| Parameter | Value |
|-----------|-------|
| Model | Denon AVR-X6800H |
| Processing channels | 13.4 |
| Internal amplifier channels | 11 |
| Internal amp power | 140W/ch @ 8 ohm (2ch driven) |
| Sub outputs | 4 (independent) |
| Pre-outs | 13.4ch |
| Room correction | Dirac Live Full + Bass Control + ART |
| HDMI | 2.1 (7in/3out), 8K/60Hz, 4K/120Hz |
| Cost | $3,700 |
| Dirac bundle | $799 (Full $349 + BC $299 + ART $299) |
| **Total** | **$4,499** |

### Internal Amp Assignment (8 of 11 channels used)

| Channel | Speaker | Load |
|---------|---------|------|
| 1 | SL (Volt-10) | 8 ohm |
| 2 | SR (Volt-10) | 8 ohm |
| 3 | SBL (Volt-10) | 8 ohm |
| 4 | SBR (Volt-10) | 8 ohm |
| 5 | TFL (Volt-10) | 8 ohm |
| 6 | TFR (Volt-10) | 8 ohm |
| 7 | TRL (Volt-10) | 8 ohm |
| 8 | TRR (Volt-10) | 8 ohm |

3 internal channels unused (LCR and wides handled by ATI via pre-outs).

## Sub DSP: 2x Wondom APM2 (ADAU1701)

| Parameter | Value |
|-----------|-------|
| Platform | 2x Wondom APM2 |
| DSP chip | ADAU1701 |
| Fixed-point format | 5.23 |
| Biquad order | [b0, b1, b2, -a1, -a2] |
| Power source | ICEpower 1200AS2 AUX5V output |
| Unit cost | $25 |
| Quantity | 2 |
| Total cost | $50 |

**CRITICAL: a1/a2 are NEGATED vs scipy convention.**

### DSP Assignment

| Unit | Input | Output | Drives |
|------|-------|--------|--------|
| APM2 #1 | X6800H Sub Out 1-2 | ICEpower #1 (corners FL/FR) + ICEpower #3 (shakers) | 2 corner cabs + 8 shakers |
| APM2 #2 | X6800H Sub Out 3-4 | ICEpower #2 (corners RL/RR) | 2 corner cabs |

### Per-Channel Independence (C9)

Dirac ART sends unique MIMO correction signals per sub output. The APM2 units **must not sum or mix** sub channels. Each X6800H sub output maps 1:1 through DSP to a unique amplifier channel and speaker.

## Signal Flow

```
Sources (Blu-ray, streaming, gaming)
    |
    v
Denon AVR-X6800H
  |-- Dirac Live Full + Bass Control + ART
  |-- 13.4ch processing
  |
  |-- Pre-outs (5ch) -----> ATI AT525NC -----> L, C, R, FWL, FWR
  |                                             (Titan-815LX x3, Volt-10 x2)
  |
  |-- Speaker outs (8ch) -----> SL, SR, SBL, SBR, TFL, TFR, TRL, TRR
  |                              (Volt-10 x8, internal amps)
  |
  +-- Sub outs (4ch)
       |
       |-- Sub Out 1 ---> APM2 #1 Ch1 ---> ICEpower #1 Ch1 ---> Corner FL (NW)
       |-- Sub Out 2 ---> APM2 #1 Ch2 ---> ICEpower #1 Ch2 ---> Corner FR (NE)
       |                    +-- sum -------> ICEpower #3 -------> Tactile (8x Aura Pro)
       |
       |-- Sub Out 3 ---> APM2 #2 Ch1 ---> ICEpower #2 Ch1 ---> Corner RL (SW)
       +-- Sub Out 4 ---> APM2 #2 Ch2 ---> ICEpower #2 Ch2 ---> Corner RR (SE)

Power:
  ICEpower AUX5V ---> APM2 #1, APM2 #2 (no separate PSU needed)
```

## Gain Staging

| Stage | Level | Notes |
|-------|-------|-------|
| X6800H sub pre-out | ~2.0 Vrms | Typical AVR sub output |
| APM2 (ADAU1701) max input | 1.9 Vrms (0 dBFS = 1.0 Vrms) | Clip at ~1.9V |
| APM2 required trim | -3 to -6 dB | Prevent ADAU1701 input clipping |
| APM2 output (post-DSP) | ~1.0 Vrms | After EQ + trim |
| ICEpower input sensitivity | 1.0 Vrms for full output | Matched to APM2 output |
| ICEpower output @ 8 ohm | 620W (70 Vrms) | Full power |

**Key concern:** X6800H sub output at 2V exceeds APM2 comfortable input range. The APM2 DSP must apply -3 to -6 dB input trim to prevent clipping the ADAU1701 ADC. This is programmed in SigmaStudio as an input gain block.

## Critical Assessment

### Why ICEpower 1200AS2 over NX6000D?

| Factor | ICEpower 1200AS2 | Behringer NX6000D |
|--------|------------------|-------------------|
| Power @ 8 ohm | 620W | ~700W (but see below) |
| Infrasonic derating | **NONE -- flat to DC** | Drops to 500-700W at 15 Hz |
| Power at 15 Hz | 620W | ~500W |
| Cooling | Fanless | Fan (audible) |
| Voltage | 240V native | 120V or 240V |
| Modifications | None | None |
| Form factor | Module (needs chassis) | Rack unit |
| Cost (5 units) | $1,865 + $200 chassis = $2,065 | ~$2,500 |
| AUX 5V | Yes (powers APM2) | No |

**Verdict:** ICEpower wins on the metric that matters most for subwoofers: sustained infrasonic power. The NX6000D's specs look good at 40 Hz but it derates significantly below 20 Hz where weapons-grade bass lives. The 1200AS2 delivers rated power to DC. Fanless operation eliminates noise floor contribution. AUX5V powers the DSP boards for free.

### Why APM2 (ADAU1701) over ADAU1452?

| Factor | APM2 (ADAU1701) | ADAU1452 board |
|--------|-----------------|----------------|
| Fixed-point | 5.23 | 8.24 |
| Dynamic range | 98 dB | 144 dB |
| Proven in this system | Yes -- existing tooling | No -- new board, new toolchain |
| COM server control | Working Python pipeline | Would need new integration |
| Power supply | ICEpower AUX5V | Dedicated PSU required |
| Cost | $50 (2x $25) | ~$60 + PSU |
| Sub-band resolution | Adequate (5.23 is 98 dB SNR) | Overkill for sub frequencies |
| Risk | Low | Medium (untested hardware) |

**Verdict:** The ADAU1452's superior specs are irrelevant for subwoofer DSP. Sub frequencies don't need 144 dB dynamic range. The APM2 has a working Python control pipeline, powers from ICEpower AUX5V, and costs less. Proven > theoretical.
