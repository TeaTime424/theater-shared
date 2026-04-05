# 04 — Amplification & DSP

**Source:** specs.yaml (Option D, 2026-03-21)
**Status:** DRAFT — signal chain topology has advisory flag; see note below.

---

## Amplification

### Channel Assignment Table

| Channel Group | Amp Model | Power (W) | Load (Ω) | Notes |
|---|---|---|---|---|
| L, C, R | ATI AT525NC | 300 | 6 | Already owned |
| FWL, FWR (front wide) | ATI AT525NC | 200 | 8 | Same unit, ch 4–5 |
| SL, SR, SBL, SBR, TFL, TFR, TRL, TRR (+ 2 Atmos) | Denon AVR-X6800H (internal) | 100 | 8 | 11.4ch internal amps |
| Corner subs FL+FR (NW+NE) | ICEpower 1200AS2 unit 1 | 620 | 8 | 240V native, fanless |
| Corner subs RL+RR (SW+SE) | ICEpower 1200AS2 unit 2 | 620 | 8 | 240V native, fanless |
| Tactile bass shakers (8× Aura Pro AST-2B-4) | ICEpower 1200AS2 unit 3 | 620 | 4 | 8 shakers, 1 per seat |
| Nearfield subs (deferred) | ICEpower 1200AS2 unit 4 | 620 | 8 | Spare — add post-build |
| — | ICEpower 1200AS2 unit 5 | 620 | 8 | Spare |

### ICEpower 1200AS2 Notes

- **Voltage:** 240V native — runs directly on dedicated 240V sub circuit, no step-down needed
- **Cooling:** Fanless — no thermal noise contribution in listening environment
- **Infrasonic derating:** None — full 620 W @ 8 Ω maintained at 15–20 Hz
  - Contrast: NX6000D derated to ~500–700 W at 15–20 Hz (~71–88% power). ICEpower 1200AS2 has no such derating.
- **Input sensitivity:** 3.55 Vrms for full rated power (note: §7 of investigation cites 3.61 Vrms; 3.55 used per task spec)
- **Idle power (5 units combined):** 175 W

### ATI AT525NC Notes

- 5-channel Class NC amplifier
- Assigned: L/C/R at 300 W/ch into 6 Ω; FWL/FWR at 200 W/ch into 8 Ω
- Already owned — $0 cost

### Denon AVR-X6800H Notes

- 11.4ch internal amplification: 140 W rated, 100 W all-channel into 8 Ω
- Drives all 12 Volt-10 surround/Atmos channels (SL/SR/SBL/SBR + 6 Atmos + FWL/FWR consumed by ATI)
- Dirac Live Full + Bass Control + ART
- Per-channel sub pre-outs preserved for DSP routing

---

## DSP Platform

**Platform: 2× Wondom APM2 (ADAU1701)**

> **NOT ADAU1452.** The ADAU1452 reference appearing in some earlier docs (investigation §1.1, NX6000D verdict context) is a stale carryover. The committed DSP platform is ADAU1701 on the Wondom APM2 board. Source: tmp_investigation_notes.md §2, specs.yaml `dsp.platform_NOT`.

| Parameter | Value |
|---|---|
| Module | Wondom APM2 |
| DSP chip | ADAU1701 |
| Fixed-point format | 5.23 |
| Biquad order | [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy |
| Count | 2 |
| Power source | ICEpower 1200AS2 AUX5V output |
| Unit cost | $40 |
| Total cost | $80 |

---

## DAC: PCM5102 External Module

The output DAC is an **external PCM5102 module**, not the internal ADAU1701 DAC.

**Why PCM5102, not the internal ADAU1701 DAC:**

The ADAU1701 internal DAC maximum output is ~0.9 Vrms. Even with the 898B gain stage (+11.79 dB, ×3.886):

```
0.9 Vrms × 3.886 = 3.50 Vrms → 601 W (97% of rated 620 W at 8 Ω)
```

That appears adequate, but the internal DAC's 0.9 Vrms output is also the same level as the X6800H sub pre-out — meaning the DSP adds no headroom advantage over skipping the DSP DAC entirely. Using the PCM5102 (2.0 Vrms full-scale) in the DSP processing chain gives a better signal level for clean gain staging through the 898B.

**Without PCM5102 (internal DAC only, 0.9 Vrms → 898B → ICEpower):**
```
(0.9 / 3.55)^2 × 620 = 0.0642 × 620 = 38.5 W
```
38.5 W is insufficient. The 898B gain alone cannot compensate for a 0.9 Vrms DAC.

**With PCM5102 (2.0 Vrms → 898B → ICEpower):**
```
(2.0 / 3.55)^2 × 620 = 0.317 × 620 = 197 W (pre-attenuation baseline)
```
After DSP attenuation alignment (see gain staging table below), full 620 W is accessible.

---

## Signal Chain (COMMITTED)

```
X6800H sub pre-out (0.9 Vrms RCA)
  → APM2 ADC (ADAU1701 ADC input, 2.0 Vrms full-scale)
    → ADAU1701 DSP (EQ, crossover, delay, -6.8 dB attenuation)
      → I2S
        → PCM5102 DAC (2.0 Vrms full-scale output)
          → Sonic Imagery 898B (+11.79 dB, ×3.886, unbal→bal XLR)
            → ICEpower 1200AS2 (3.55 Vrms sensitivity, 620 W @ 8 Ω)
```

**898B status: COMMITTED — purchased 2026-03-21**

**Why the 898B:**
1. Converts unbalanced RCA signal to balanced XLR for ICEpower input
2. Provides +11.79 dB gain to bring PCM5102 output up to ICEpower rated sensitivity
3. Enables full rated 620 W from the ICEpower modules

---

## Gain Staging

| Stage | Voltage (Vrms) | Notes |
|---|---|---|
| X6800H sub pre-out | 0.9 | AVR sub pre-out level (measured/spec) |
| APM2 ADC input | 0.9 | Within 2.0 Vrms full-scale — no clipping |
| ADAU1701 DSP output | variable | EQ, crossover, delay applied here |
| PCM5102 output | 2.0 | DAC full-scale |
| 898B output (from 2.0 Vrms) | 7.77 | 2.0 × 3.886 = 7.772 Vrms — EXCEEDS ICEpower 3.55 Vrms sensitivity |
| Required DSP attenuation | -6.8 dB | To keep 898B output ≤ 3.55 Vrms for ICEpower |
| 898B output after -6.8 dB DSP atten | 3.55 | 7.77 × 10^(-6.8/20) = 3.55 Vrms |
| ICEpower at 3.55 Vrms | **620 W** | Full rated power |

### Voltage Calculations

**PCM5102 full-scale → 898B (no DSP attenuation):**
```
898B output = 2.0 × 3.886 = 7.772 Vrms
ICEpower fraction = 7.772 / 3.55 = 2.189
Power = 2.189^2 × 620 = 2,968 W — clips ICEpower input
```

**Required DSP attenuation to reach exactly 3.55 Vrms at ICEpower input:**
```
Target 898B output = 3.55 Vrms
Required PCM5102-equivalent input to 898B = 3.55 / 3.886 = 0.913 Vrms
DSP attenuation = 20 × log10(0.913 / 2.0) = 20 × log10(0.4568) = -6.81 dB ≈ -6.8 dB
```

**ICEpower at committed input (3.55 Vrms after attenuation):**
```
fraction = 3.55 / 3.55 = 1.000
Power = 1.000^2 × 620 = 620 W (full rated)
```

**Cross-check — committed chain without DSP attenuation factored (actual committed input):**
```
X6800H 0.9 Vrms → 898B → 0.9 × 3.886 = 3.497 Vrms ≈ 3.50 Vrms
fraction = 3.50 / 3.55 = 0.9859
Power = 0.9859^2 × 620 = 0.9720 × 620 = 601 W (97% of rated)
```

The committed chain (X6800H pre-out direct to 898B, per §3 topology) delivers **601 W** per ICEpower module without requiring DSP attenuation. The -6.8 dB attenuation figure applies only if the PCM5102 output (2.0 Vrms) were to feed the 898B directly without DSP gain control.

---

## Signal Chain Advisory

> **Topology note:** specs.yaml flags an ambiguity between investigation §2 (full DSP path with PCM5102 → 898B) and §3 (committed chain: X6800H pre-out → 898B direct). The task spec defines the full DSP path as: `X6800H sub pre-out → APM2 ADC → ADAU1701 → I2S → PCM5102 → 898B → ICEpower`, which is the path shown above. If the PCM5102 output feeds the 898B, the -6.8 dB DSP attenuation is required to avoid clipping the ICEpower input. Owner must confirm final topology before construction.
>
> See specs.yaml `dsp.signal_chain_b2_advisory` and `dsp.signal_chain_committed`.

---

## Verification Status

- **ICEpower 1200AS2 specs (620 W @ 8 Ω, 3.55 Vrms sensitivity, 240V, fanless, no infrasonic derating):** Sourced from investigation notes and POR docs. Cross-referenced within project docs only.
- **Sonic Imagery 898B gain (+11.79 dB, ×3.886):** [UNVERIFIED — creator-confirmed spec, zero independent measurements exist]. Manufacturer page states "~14 dB" (imprecise). 11.79 dB is the creator-confirmed value for 0.9 Vrms input.
- **ATI AT525NC power ratings:** From POR core docs.
- **Denon AVR-X6800H internal amp power:** 140 W rated / 100 W all-channel from POR core docs.
