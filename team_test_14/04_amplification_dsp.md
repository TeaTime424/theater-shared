# Section 04 — Amplification & DSP

## Amplification

### Channel Amplification Table

| Channel Group | Count | Amp Model | Power | Load Impedance |
|---|---|---|---|---|
| LCR (Titan-815LX) | 3 | ATI AT525NC | 5× 180W @ 8Ω / 300W @ 4Ω | 6Ω nominal |
| Front Wides | 2 | ATI AT525NC | (channels 4–5 of same unit) | 8Ω |
| Surrounds (Volt-10) | 4 | Denon AVR-X6800H internal | ~140W × 2 shared | 8Ω |
| Atmos (Volt-10) | 6 | Denon AVR-X6800H internal | ~140W × 2 shared | 8Ω |
| Subwoofers (UMII18-22, series) | 4× cabinets (8 drivers) | 5× ICEpower 1200AS2 | 600W @ 8Ω | 8Ω (series-wired pair) |

Notes:
- ATI AT525NC: 5-channel class NC; handles LCR + 2 front wides from a single chassis
- Denon AVR-X6800H: 11.4-channel processing; internal amplification used for surrounds and Atmos only (10 channels)
- ICEpower 1200AS2: 240V operation, fanless, no infrasonic derating — 5 units (4 active + 1 spare)

### ICEpower 1200AS2 Key Properties

| Property | Value |
|---|---|
| Supply voltage | 240V AC |
| Rated power (8Ω) | 600W |
| Cooling | Fanless (convection) |
| Infrasonic derating | None — full rated power at 10Hz and below |
| Sensitivity (Vrms for full power) | 3.55 Vrms |

The absence of infrasonic derating is a critical selection criterion. The NX6000D alternative drops to ~500–700W at 15Hz. The 1200AS2 delivers full rated output at any sub-sonic frequency the DSP passes.

---

## DSP

### Platform Assignment

| Platform | Role | Notes |
|---|---|---|
| ADAU1452 | **Production** — all sub DSP processing | 8.24 fixed-point; full sub-20Hz capability |
| ADAU1701 (Wondom APM2) | **Dev bench only** — testing, biquad validation | 5.23 fixed-point; not used in final install |

The ADAU1701 / APM2 is development infrastructure only. It does not appear in the production signal chain and is not installed in the theater.

Why ADAU1452 and not ADAU1701 for production:
- 8.24 fixed-point gives greater headroom and precision at very low frequencies (10–20Hz)
- ADAU1701 5.23 format introduces coefficient quantization error in steep low-frequency filters
- ADAU1452 safeload writes support full real-time parameter updates without glitches

Why ADAU1452 and not miniDSP:
- miniDSP 2×4 HD has a high-pass filtering floor that limits sub-20Hz output
- miniDSP biquad convention inverts a1/a2 signs vs standard — requires per-unit workarounds
- ADAU1452 provides direct register-level control via SigmaStudio COM server from Python
- ADAU1452 supports Dirac ART per-channel sub pre-out routing without summing compromise

---

## Signal Chain

### Production Signal Chain

```
X6800H sub pre-out (2.0 Vrms)
  → ADAU1452 (DSP: EQ, crossover, room correction)
  → I2S
  → PCM5102 external DAC module (2.0 Vrms output)
  → Sonic Imagery 898B balanced driver (3.5 Vrms output)
  → ICEpower 1200AS2 (600W @ 8Ω, sensitivity 3.55 Vrms)
  → Subwoofer cabinet (8Ω series-wired driver pair)
```

### Dev Bench Signal Chain

```
X6800H sub pre-out
  → Wondom APM2 ADC
  → ADAU1701 (DSP testing/biquad validation)
  → I2S
  → PCM5102 external DAC module
  → ICEpower 1200AS2
  → Test load / measurement
```

---

## Gain Staging

### Why PCM5102 External DAC (Not ICEpower Internal DAC)

The ICEpower 1200AS2 internal DAC outputs approximately 0.9 Vrms. At that level, the amplifier cannot reach rated power:

```
P = (V_in / V_sens)² × P_rated
P = (0.9 / 3.55)² × 600 = 38.5W
```

38.5W into 8Ω is -11.9 dB below rated power. Unacceptable for a subwoofer array targeting reference SPL.

The PCM5102 external DAC module outputs 2.0 Vrms, which recovers the majority of amplifier headroom:

```
P = (2.0 / 3.55)² × 600 = 190.5W
dB below rated: 10 × log10(190.5 / 600) = -4.98 dB
```

### Why Sonic Imagery 898B Balanced Driver

The 898B provides 11.79 dB of gain, stepping 2.0 Vrms to 3.5 Vrms. This brings the ICEpower to near its full rated output:

```
P = (3.5 / 3.55)² × 600 = 583.1W
dB below rated: 10 × log10(583.1 / 600) = -0.12 dB
```

0.12 dB below rated power is effectively full output. The 898B also provides balanced drive to the ICEpower differential input, which improves common-mode noise rejection over the unbalanced PCM5102 output.

### Gain Staging Table (Production Chain, Per Sub Channel)

| Stage | Output (Vrms) | Notes |
|---|---|---|
| X6800H sub pre-out | 2.0 | Denon rated sub pre-out voltage |
| ADAU1452 | — | DSP processing; unity gain path assumed |
| PCM5102 DAC | 2.0 | External DAC module; replaces 0.9V internal DAC |
| Sonic Imagery 898B | 3.5 | +11.79 dB gain (2.0 → 3.5 Vrms) |
| ICEpower 1200AS2 input sensitivity | 3.55 | Reference: full rated power threshold |
| ICEpower output power | **583.1W** | (3.5 / 3.55)² × 600 = 583.1W |
| Headroom vs rated | **-0.12 dB** | Effectively full rated output |

### Power Comparison by DAC Configuration

| DAC | Output (Vrms) | ICEpower Output (W) | dB Below Rated |
|---|---|---|---|
| ICEpower internal | 0.9 | 38.5 | -11.9 dB |
| PCM5102 alone | 2.0 | 190.5 | -4.98 dB |
| PCM5102 + 898B | 3.5 | **583.1** | **-0.12 dB** |

---

## Dirac ART Integration

Denon AVR-X6800H with Dirac Live Full + Bass Control + ART provides per-channel sub pre-outs. Dirac ART (Adaptive Room Treatment) operates per-channel — the sub pre-outs are not summed before the ADAU1452. Each ICEpower channel receives its own corrected signal. This preserves the spatial distribution of the 4-corner sub array rather than collapsing it to a mono or stereo feed.
