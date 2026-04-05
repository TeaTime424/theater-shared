# 04 — Amplification & DSP
## Signal Flow, Gain Staging, Power Analysis

All specs from `specs.yaml`.

---

## System Architecture

```
Sources (HDMI) → Denon AVR-X6800H
                     ├── Speaker Outputs (8ch internal amps)
                     │   ├── SL, SR, SBL, SBR (Volt-10)
                     │   └── TFL, TFR, TRL, TRR (Volt-10)
                     │
                     ├── Pre-Outs (5ch) → ATI AT525NC (NCore)
                     │   ├── L, C, R (Titan-815LX)
                     │   └── FWL, FWR (Volt-10)
                     │
                     └── 4× Sub Pre-Outs (RCA, 2V RMS)
                         └── 2× Wondom APM2 (ADAU1701 DSP)
                             └── I2S → 2× PCM5102 DAC (2.0V RMS)
                                 ├── ICEpower #1: Corner FL + FR (8Ω each)
                                 ├── ICEpower #2: Corner RL + RR (8Ω each)
                                 ├── ICEpower #3: Tactile shakers
                                 ├── ICEpower #4: Spare → nearfield
                                 └── ICEpower #5: Spare
```

---

## Processor: Denon AVR-X6800H

| Spec | Value |
|------|-------|
| Cost | $3,700 |
| Processing | 13.4 channels |
| Internal amps | 11 × 140W @ 8Ω (2ch driven) |
| ACD estimate | ~100W @ 8Ω |
| Sub outputs | 4 independent (RCA + XLR) |
| Pre-outs | 13.4ch (5 used for LCR + FW) |
| Room correction | Dirac Live Full + BC + ART ($799 bundle) |

### Why X6800H Over A1H

| Factor | X6800H | A1H | Winner |
|--------|--------|-----|--------|
| Cost (+ Dirac) | $4,499 | $7,299 | **X6800H** (-$2,800) |
| LCR power | ATI NCore 300W | Internal 150W | **X6800H** (better) |
| Processing | 13.4ch (9.4.4) | 15.4ch (9.4.6) | A1H (but 9.4.4 sufficient) |
| Sub outputs | 4 independent | 4 independent | Tie |
| Net | Better LCR + $2,800 saved | More channels | **X6800H** |

---

## Speaker Amplification

### ATI AT525NC (LCR + Front Wides)

| Spec | Value |
|------|-------|
| Channels | 5 (L, C, R, FWL, FWR) |
| Topology | NCore (NC500) |
| Power @ 8Ω | 200W |
| Power @ 6Ω | ~300W (estimated for reactive Titan load) |
| Power @ 4Ω | ~400W |
| Cost | **$0** (already owned, $2,500 value) |
| Connection | X6800H pre-outs → ATI balanced inputs |

### X6800H Internal (Surrounds + Heights)

| Spec | Value |
|------|-------|
| Channels used | 8 (SL, SR, SBL, SBR, TFL, TFR, TRL, TRR) |
| Power @ 8Ω (ACD) | ~100W |
| Unused channels | 3 (growth path) |

---

## Subwoofer Amplification: ICEpower 1200AS2

| Spec | Value |
|------|-------|
| Count | 5 modules (4 active + 1 spare) |
| Unit cost | $373 |
| Chassis/rack | $200 |
| Total cost | $2,065 |
| Voltage | 240V (universal PFC, auto-sensing) |
| Circuit | Single 20A/240V |
| Cooling | **Fanless** (0-40°C ambient) |
| Infrasonic derating | **None** — rated power maintained to 20 Hz |

### Power Output

| Condition | Power |
|-----------|-------|
| Per ch @ 8Ω, both driven, 230V | 620W |
| Per ch @ 4Ω, both driven, 230V | 700W |
| Per ch @ 8Ω, one ch driven | 620W |
| Burst duration (both ch, full power) | 90 sec @ 230V |
| Continuous (both ch, no thermal shutdown) | 280W |
| Input sensitivity | 3.55 Vrms (for full rated power @ 4Ω) |
| Idle consumption (both ch) | 35W |

### Assignment

| Module | Load | Impedance |
|--------|------|-----------|
| #1 | Corner FL + FR | 8Ω per ch |
| #2 | Corner RL + RR | 8Ω per ch |
| #3 | Tactile shakers | varies |
| #4 | Spare → nearfield | — |
| #5 | Spare | — |

### AUX Power

Each ICEpower 1200AS2 provides AUX5V output (1A). This powers the APM2 DSP boards — no separate power supply needed.

---

## Sub DSP: 2× Wondom APM2 (ADAU1701)

### CORRECTED from ADAU1452

Source docs referenced an ADAU1452 board. **Corrected to 2× Wondom APM2 (ADAU1701):**

| Spec | ADAU1452 (original) | APM2/ADAU1701 (corrected) |
|------|---------------------|---------------------------|
| Status | Not yet procured | **Available, tested** |
| Cost | ~$60 | ~$50 (2× $25) |
| Fixed-point | 8.24 | 5.23 |
| Inputs | 8 (via CS42448) | 2 per board (4 total) |
| Outputs | 8 (via CS42448) | 4 per board (8 total via I2S) |
| Sub-20Hz | Yes | **Yes** — no HPF floor unlike DSP-408 |
| Biquad order | [b0, b1, b2, -a1, -a2] | **[b0, b1, b2, -a1, -a2]** (same) |
| COM control | SigmaStudio COM | SigmaStudio COM |
| Power | External | ICEpower AUX5V |

### Why APM2, Not ADAU1452

1. **APM2 is tested** — existing `tools/dsp/` pipeline works with it
2. **$10 cheaper** total ($50 vs $60)
3. **Simpler** — 2-in/4-out per board, exactly matches need
4. **Powered from ICEpower AUX5V** — no separate supply
5. **SigmaStudio COM works** — proven with existing Python tooling

### Internal DAC Problem

The ADAU1701's **internal DAC outputs only 0.9 Vrms**. The ICEpower 1200AS2 needs 3.55 Vrms for full rated power.

```
At 0.9V input:
Power = (0.9/3.55)² × 620 = 0.064 × 620 = 39.7W per ch @ 8Ω
→ UNUSABLE for sub amplification
```

### Solution: External PCM5102 DAC

| Spec | Value |
|------|-------|
| Module | PCM5102 breakout board |
| Output | **2.0 Vrms** |
| SNR | 112 dB |
| Connection | I2S from ADAU1701 digital output |
| Cost | ~$7 each |
| Count | 2 (4 stereo outputs = 8 channels) |

```
At 2.0V input:
Power = (2.0/3.55)² × 620 = 0.317 × 620 = 197W per ch @ 8Ω
→ 5× better than internal DAC (197W vs 39.7W)
→ -5.0 dB from rated power (620W)
→ Adequate for 95 dB target with 13+ dB headroom
```

---

## Gain Staging — Complete Signal Chain

### Sub Channel Path

| Stage | Signal | Level | Notes |
|-------|--------|-------|-------|
| 1. X6800H sub pre-out | Analog RCA | **2.0 Vrms** | Typical AVR sub output |
| 2. APM2 ADC input | Analog → Digital | 2.0V full-scale | **Zero headroom** — verify no clipping |
| 3. ADAU1701 processing | Digital | 0 dBFS max | HPF, PEQ, delay, level, crossover |
| 4. ADAU1701 I2S output | Digital | — | To PCM5102 |
| 5. PCM5102 DAC output | Digital → Analog | **2.0 Vrms** | External DAC module |
| 6. ICEpower input | Analog balanced | 2.0V received | 3.55V = full power |
| 7. ICEpower output | Speaker level | **~197W @ 8Ω** | (2.0/3.55)² × 620 |

### LCR Channel Path

| Stage | Signal | Level |
|-------|--------|-------|
| 1. X6800H pre-out | Analog XLR | ~2.0 Vrms |
| 2. ATI AT525NC input | Balanced | — |
| 3. ATI output | Speaker level | ~300W @ 6Ω |

### Surround/Height Path

| Stage | Signal | Level |
|-------|--------|-------|
| 1. X6800H internal | Digital → Class AB | — |
| 2. Speaker output | Speaker level | ~100W @ 8Ω |

### Gain Staging Risk: ADC Headroom

The APM2 ADC full-scale is 2.0V. The X6800H sub pre-out is also ~2.0V at 0 dB volume. **This means zero headroom at the ADC.**

**Mitigation:**
- AVR sub outputs rarely hit 0 dBFS — Dirac processing typically reduces peak levels
- APM2 ADC has soft clipping behavior (not hard digital clipping)
- If clipping observed: reduce X6800H sub output trim by 3 dB, compensate in ADAU1701 digital domain
- Monitor: APM2 has no clip indicator — use REW measurement to verify clean signal

---

## Dirac Live Configuration

| License | Cost | Function |
|---------|------|----------|
| Full Bandwidth | $349 | Full-range room correction (all channels) |
| Bass Control | $299 | Multi-sub optimization (4 independent outputs) |
| ART | $299 | Active Room Treatment |
| **Bundle** | **$799** | |

### Dirac ART + Corner Subs

**CRITICAL:** Dirac ART sends unique MIMO signals per sub output. The 4 corner sub channels must preserve per-channel independence:
- X6800H Sub Out 1 → APM2 Board 1, Ch A → ICEpower #1, Ch A → NW corner
- X6800H Sub Out 2 → APM2 Board 1, Ch B → ICEpower #1, Ch B → NE corner
- X6800H Sub Out 3 → APM2 Board 2, Ch A → ICEpower #2, Ch A → SW corner
- X6800H Sub Out 4 → APM2 Board 2, Ch B → ICEpower #2, Ch B → SE corner

Each corner receives a unique ART-processed signal. No summing, no combining. The APM2 DSP must process each channel independently.

---

## DSP Processing Functions

Each ADAU1701 channel provides:

| Function | Range | Purpose |
|----------|-------|---------|
| High-pass filter | **5+ Hz** (no 20 Hz floor like DSP-408) | Driver protection |
| Parametric EQ | 5-20,000 Hz | Room mode correction |
| Delay | 0-21.3 ms | Time alignment |
| Level | ±∞ dB | Channel balance |
| Low-pass filter | Configurable | Crossover |

**Key advantage over DSP-408:** No 20 Hz HPF floor. Can filter to DC. Essential for sub-20 Hz processing.

### ADAU1701 Biquad Convention

**CRITICAL:** Biquad coefficient order is `[b0, b1, b2, -a1, -a2]` — a1 and a2 are NEGATED versus scipy output. This applies to both ADAU1701 and ADAU1452.

---

## Cost Summary

| Item | Cost |
|------|------|
| X6800H | $3,700 |
| Dirac bundle | $799 |
| ATI AT525NC | $0 (owned) |
| 5× ICEpower 1200AS2 + chassis | $2,065 |
| 2× APM2 + 2× PCM5102 | $64 |
| **Amplification & DSP total** | **$6,628** |

---

## Critical Assessment

### Settled
- X6800H + ATI AT525NC combo — saves $2,800 vs A1H, better LCR power
- ICEpower 1200AS2 — fanless, no derating, 240V, proven
- APM2 (ADAU1701) — tested with existing tools, powered by ICEpower AUX5V
- PCM5102 external DAC — 5× power improvement over internal DAC

### Known Weakness
- **Gain staging limits sub amp to ~197W** (vs 620W rated). This is the system's binding constraint.
  - Impact: -5 dB from theoretical max output
  - At 95 dB target: still +13 dB headroom — more than sufficient
  - Full power recovery would require: higher-output DAC (e.g., PCM1794 at 4.5V), or external preamp, or op-amp gain stage between PCM5102 and ICEpower
  - **Not recommended to add complexity** — 197W is adequate for -10 dB reference
- **ADC headroom is zero** at 2.0V in = 2.0V full scale. Mitigated by AVR trim and soft clipping.

---

*All values from specs.yaml. Document generated 2026-03-16.*
