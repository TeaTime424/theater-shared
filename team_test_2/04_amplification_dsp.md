# Amplification, DSP & Signal Flow
## Option D — ICEpower + ATI + X6800H + 2× Wondom APM2 (ADAU1701)

**Source of truth:** `specs.yaml` | **Date:** 2026-03-15

---

## Amplification Architecture

| Amp | Drives | Channels | Load | Location |
|-----|--------|----------|------|----------|
| ATI AT525NC | L, C, R, FWL, FWR | 5 | 6 ohm (LCR), 8 ohm (FW) | Equipment closet |
| X6800H internal | SL, SR, SBL, SBR, TFL, TFR, TRL, TRR | 8 | 8 ohm | Equipment closet |
| ICEpower 1200AS2 #1 | Corner subs FL/FR | 2 | 8 ohm | Equipment closet |
| ICEpower 1200AS2 #2 | Corner subs RL/RR | 2 | 8 ohm | Equipment closet |
| ICEpower 1200AS2 #3 | Bass shakers (8x) | 2 | varies | Equipment closet |
| ICEpower 1200AS2 #4 | Spare / nearfield | — | — | Equipment closet |
| ICEpower 1200AS2 #5 | Spare | — | — | Shelf |

---

## 1. ICEpower 1200AS2 — Sub Amplification

| Spec | Value |
|------|-------|
| Power @ 8 ohm (240V, both ch) | 620W/ch |
| Power @ 4 ohm (240V, both ch) | 700W/ch |
| Burst duration (240V) | 90 seconds at full power |
| Continuous (no thermal shutdown) | 280W combined |
| Input sensitivity | **5.0 Vp (3.54 Vrms) for 1200W/4ohm** |
| Voltage gain | 25.8 dB |
| Idle power | 35W per module |
| Mains | 100-240V AC auto-sensing PFC |
| Minimum load | 2.7 ohm |
| Fanless | Yes |
| Modifications required | **Zero** |
| Cost | $373 each (Parts Express #326-117) |

### Why ICEpower 1200AS2 (not NX6000D)

| Factor | ICEpower 1200AS2 | NX6000D |
|--------|-------------------|---------|
| Power @ 15 Hz | 620W (no derating) | ~600W (71% derated) |
| Power @ 20 Hz | 620W (no derating) | ~750W (88% derated) |
| Mods required | Zero | 12 fan swaps + trigger box + DSP bypass |
| Idle power (5 units) | 175W | ~300-375W |
| Circuits needed | 1x 20A/240V | 2x 20A/120V |
| Cost (5 units + chassis) | $2,065 | $3,894 (6 units + fans + trigger + DSP) |
| Fanless | Yes | No (even after Noctua swap) |
| Savings | — | **-$1,769** |

Below 30 Hz — the target frequency range for "weapons-grade bass" — the 1200AS2 equals or exceeds the NX6000D. The NX6000D's power advantage only exists above 30 Hz where boundary loading provides massive headroom already.

### Chassis Design

Modules rack-mount in equipment closet. Custom chassis or shelf:
- Aluminum baseplate serves as heatsink (0.8 K/W target)
- 4 modules in 2U-3U rack shelf with heatsink rails
- Fanless operation viable at <40 degC ambient (closet must be ventilated)
- Budget: $200 for chassis materials
- If DIY stalls: Protocase fabrication ~$300-400

### Thermal

- Operating temp (fanless): 0-40 degC ambient
- Thermal warning: 110 degC amplifier / 85 degC PSU
- Thermal shutdown: 125 degC amplifier / 95 degC PSU
- At movie crest factors (50-200W sustained), well within continuous limits
- Sustained test tones at high level WILL trigger thermal protection — this is by design

---

## 2. ATI AT525NC — LCR + Front Wides

| Spec | Value |
|------|-------|
| Channels | 5 |
| Power @ 8 ohm | 200W |
| Power @ 6 ohm | ~270W (realistic NCore estimate) |
| Topology | NCore |
| Status | **Owned** ($2,500 value) |
| Drives | L, C, R (6 ohm), FWL, FWR (8 ohm) |

**Why external amp for LCR instead of X6800H internal:**
The ATI is already owned ($0 cost) and provides better power delivery into the 6 ohm Titan load than the X6800H's internal amps. NCore topology has excellent damping factor and current delivery. This is the correct use of an owned asset.

---

## 3. Denon AVR-X6800H — Processor + Surround/Atmos Amp

| Spec | Value |
|------|-------|
| Cost | $3,700 |
| Processing | 13.4 channels |
| Internal amps | ~140W @ 8 ohm (2ch), ~100W @ 8 ohm (ACD) |
| Sub outputs | 4 independent (RCA + XLR) |
| Pre-outs | All channels |
| Room correction | Audyssey MultEQ XT32 (included) |
| Dirac Live | Full + Bass Control + ART ($947 add-on) |

**Why X6800H (not A1H):**
Saves $2,800. 13.4ch processing is sufficient for 9.4.4. The ATI handles LCR better than A1H internal amps would. If future upgrade to 9.4.6 is desired, processor replacement is needed — but at that point, next-gen processors will be available.

---

## 4. Sub DSP — 2× Wondom APM2 (ADAU1701)

Replaces the originally-planned ADAU1452+CS42448 Chinese board. See `investigation_dsp_platform.md` for full rationale.

| Spec | Value |
|------|-------|
| Platform | 2× Wondom APM2 (AA-AP23122) |
| Cost | ~$90 (2× $45) |
| Channels | 2 in / 4 out per unit (4 in / 8 out total) |
| DSP chip | ADAU1701 (56-bit ALU, 1024 instructions) |
| Bit depth | 5.23 fixed-point |
| Instruction usage | ~240/1024 per unit (23%) |
| Filter floor | DC (no 20 Hz minimum like DSP-408) |
| ADC/DAC | Integrated (on-chip, -95 dB noise floor) |
| Biquad format | [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy |
| Transport | PC → SigmaStudio 4.7 COM → ICP5 → I2C → DSP |
| Self-boot | Yes (EEPROM — runs standalone after programming) |
| Power | 5V from ICEpower 1200AS2 AUX5V output |
| Output | 4× unbalanced analog on J1 header pins (per unit) |
| Replaces | DSP-408 ($250) + miniDSP 2x4 HD ($200) = $450 saved |
| Status | **Proven** — existing tools/dsp/ pipeline works with ADAU1701 |

### Why 2× APM2 over ADAU1452+CS42448 board

| Factor | 2× APM2 (ADAU1701) | ADAU1452+CS42448 board |
|--------|--------------------|-----------------------|
| Board quality | Production (Wondom) | Chinese clone, documented issues |
| Noise floor | -95 dB (integrated ADC/DAC) | -80 dB (after opamp/cap mods) |
| Mods required | Zero | Opamp swap + cap replacement + filter removal |
| Proven in project | Yes (client_1701_com.py) | Never bench tested |
| Redundancy | 1 unit fails = half subs work | Board fails = total bass failure |
| 5.23 vs 8.24 precision | <0.001 Hz error at 20 Hz PEQ | Irrelevant advantage for subs |
| Cost | $90 | $60 + $65 mods = $125 |

### Routing

```
APM2 #1 (Sub Pre-outs 1,2):
  In 1 ← X6800H Sub Out 1
  In 2 ← X6800H Sub Out 2
  Out 1 → ICEpower #1 ch1 → FL corner sub pair
  Out 2 → ICEpower #1 ch2 → FR corner sub pair
  Out 3 → DSP sum(1,2) → nearfield front (deferred)
  Out 4 → spare / shakers front

APM2 #2 (Sub Pre-outs 3,4):
  In 1 ← X6800H Sub Out 3
  In 2 ← X6800H Sub Out 4
  Out 1 → ICEpower #2 ch1 → RL corner sub pair
  Out 2 → ICEpower #2 ch2 → RR corner sub pair
  Out 3 → DSP sum(3,4) → nearfield rear (deferred)
  Out 4 → spare / shakers rear
```

**Dirac ART compatibility:** Each corner sub output preserves ART's unique per-position MIMO signal. Nearfield sum collapses 2 ART channels — acceptable for single-position nearfield application.

### Power

Both APM2s powered from ICEpower 1200AS2 #1 AUX5V output (5V auxiliary rail). <500 mA per unit, well within AUX5V spec. DSP powers up/down with sub amps — clean behavior, no separate supply needed.

### DSP Processing Chain (per output)

```
Input (from X6800H sub pre-out) →
  Input gain/trim →
  PEQ (parametric EQ, Dirac supplement) →
  HPF (subsonic protection, e.g., 5 Hz Butterworth 24 dB/oct) →
  Delay (time alignment) →
  Output gain →
  Output (J1 header pins → wire to ICEpower 1200AS2 input)
```

Shaker outputs get an additional bandpass (30-80 Hz).

Total instruction cost per output: ~55. Per APM2 (4 outputs): ~240 of 1024 (23%).

---

## 5. Signal Flow

```
SOURCES (HDMI)
    ↓
DENON AVR-X6800H
    ├── [Speaker outputs: 8ch] → SL, SR, SBL, SBR, TFL, TFR, TRL, TRR
    ├── [Pre-outs: 5ch RCA] → ATI AT525NC → L, C, R, FWL, FWR
    └── [Sub pre-outs: 4x RCA]
              ↓                          ↓
         Sub Out 1,2                Sub Out 3,4
              ↓                          ↓
         APM2 #1                    APM2 #2
         (ADAU1701)                 (ADAU1701)
         EQ/HPF/delay/gain          EQ/HPF/delay/gain
              ↓                          ↓
    ┌────┬────┬────┐          ┌────┬────┬────┐
    O1   O2   O3   O4         O1   O2   O3   O4
    ↓    ↓    ↓    ↓          ↓    ↓    ↓    ↓
   1200AS2#1  NF  spare      1200AS2#2  NF  spare
   FL   FR  (def)            RL   RR  (def)
    ↓    ↓                    ↓    ↓
   NW   NE                  SW   SE
   subs subs                subs subs

Shakers: APM2 #1 O4 + APM2 #2 O4 → 1200AS2 #3 → 8x Aura Pro
Power: Both APM2s ← 5V from 1200AS2 #1 AUX5V
```

### Interface Voltages

| Interface | Voltage | Notes |
|-----------|---------|-------|
| X6800H sub pre-out → APM2 ADC | ~2 Vrms | Standard consumer line level |
| ADAU1701 DAC → 1200AS2 | ~1.5 Vrms | Integrated DAC, unbalanced |
| 1200AS2 input sensitivity | 5.0 Vp (3.54 Vrms) | **No overdrive risk** |
| Headroom at interface | ~7 dB | 1.5 Vrms vs 3.54 Vrms full power |

**The gain staging is clean.** The ADAU1701 integrated DAC outputs ~1.5 Vrms. The 1200AS2 requires 3.54 Vrms for full power at 4 ohm (620W at 8 ohm uses less). At 8 ohm loads the amp is already well below thermal limits — the headroom gap is a non-issue and recoverable via DSP output gain if needed.

**Balanced vs unbalanced:** The ADAU1701 outputs unbalanced from J1 header pins. The 1200AS2 accepts balanced input (38k ohm per leg). Connection: signal wire to hot (+), ground to cold (-), shield to ground. Short runs within equipment closet (~2 ft) — ground loop risk is negligible at these distances.

---

## 6. Dirac Live

| License | Cost | Purpose |
|---------|------|---------|
| Full Bandwidth | $349 | Room correction for all speaker channels |
| Bass Control | $299 | Multi-sub optimization (4 sub outputs) |
| ART | $299 | Advanced room targeting |
| **Total** | **$947** | |

**Note:** X6800H includes Audyssey MultEQ XT32 at no cost. Consider testing Audyssey first. Buy Dirac only if Audyssey measurably fails on bass management or correction quality. Could save $500-947.

---

## 7. Electrical Load

| Equipment | Idle (W) | Peak (W) |
|-----------|----------|----------|
| 5x ICEpower 1200AS2 | 175 | ~2,500 (burst) |
| X6800H | ~200 | ~400 |
| ATI AT525NC | ~200 | ~600 |
| 2x APM2 (ADAU1701) | ~2 | ~2 |
| Projector | ~350 | ~350 |
| Misc (network, UPS) | ~50 | ~50 |
| **Total** | **~977W** | **~3,902W** |

Peak draw is burst (90 seconds max for 1200AS2). Sustained during movie playback: ~500-800W total. Well within circuit capacity.

---

## Critical Assessment

**Why this amplification architecture:**
- Three-tier amplification matches speaker requirements exactly: NCore for demanding LCR load, AVR internal for easy surround loads, dedicated modules for sub duty
- ATI is free (owned). X6800H internal amps are free (included). ICEpower modules are $373 each — total amp cost is $2,065.
- Zero modifications on any amplifier. No fan swaps, no DSP bypass, no trigger mods.
- Single 240V circuit for all sub amps (vs 2x 120V for NX6000D)

**Why 2× APM2 (ADAU1701) over alternatives:**
- Filters to DC — no 20 Hz minimum (DSP-408's fatal limitation)
- Replaces TWO boxes (DSP-408 + miniDSP) with two proven $45 boards
- **Already proven** — existing tools/dsp/ pipeline (client_1701_com.py) works
- Integrated ADC/DAC with -95 dB noise floor (no cheap external codec)
- Self-boots from EEPROM — no computer needed for operation
- Redundancy: one unit failure = half subs still work
- Powered from ICEpower AUX5V — no separate supply

**Weaknesses:**
- 5.23 fixed-point (vs 8.24) — verified irrelevant for sub-frequency coefficients (<0.001 Hz error)
- 1024 instructions (vs 6144) — verified sufficient at 23% utilization per unit
- Nearfield sum loses Dirac ART per-channel independence — acceptable for deferred single-position nearfield
- SigmaStudio COM dependency — proprietary IDE, Windows-only. Bus factor: 1 person.
- Custom chassis for ICEpower modules — not commercially available. One-time fabrication.
- X6800H has 13.4ch processing — if 9.4.6 is desired later, need new processor.
- Dirac license tied to processor — replacement X6800H needs new license.

**What would change this:**
- If ADAU1452 board passes bench test with clean measurements → reconsider for full 4-in/8-out routing (preserves ART independence for nearfield)
- If CamillaDSP on Pi 5 matures → consider as future replacement (text configs vs binary EEPROM)
- If ICEpower 1200AS2 is discontinued → buy spare modules now ($373 insurance)
