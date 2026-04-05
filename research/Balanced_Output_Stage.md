# Balanced Output Stage — PCM5102 + THAT1646 → ICEpower 1200AS2

**Status:** RESEARCH — Design specification
**Date:** 2026-03-17
**Related:** `research/ADAU1452_Signal_Chain_Design.md`, `research/ICEpower_1200AS2_Reference.md`, `team_test/investigation_dsp_platform.md`

---

## 1. Problem Statement

The ADAU1701 internal DAC outputs **0.9 Vrms** (2.54 Vpp). The ICEpower 1200AS2 needs **3.61 Vrms** to deliver full power (620W) into the 8-ohm sub loads. Without intervention:

| Parameter | Value |
|-----------|-------|
| ADAU1701 DAC output | 0.9 Vrms |
| ICEpower voltage gain | 25.8 dB (19.5×) |
| Amp output from 0.9V in | 17.55 Vrms → **38.5W** into 8 ohm |
| Amp rated power @ 8 ohm | 620W (requires 3.61 Vrms input) |
| Power utilization | 6.2% |
| Lost headroom | **12.1 dB** |

The system still exceeds THX reference (+9.5 dB at 20 Hz) at 38.5W/ch, but the $1,865 worth of ICEpower amplification (5× 1200AS2) is operating at 6% capacity.

---

## 2. DRV134 Solution

The Texas Instruments DRV134 is a monolithic audio balanced line driver that converts a single-ended (unbalanced) input to a differential (balanced) output. It provides **unity gain per leg** (2× voltage gain differential) and drives the ICEpower's balanced input directly.

### 2.1 DRV134 Specifications

| Parameter | Value | Source |
|-----------|-------|--------|
| Package | 8-pin DIP (DRV134PA) or SO-8 (DRV134UA) | TI datasheet |
| Supply voltage | ±4.5V to ±18V | TI datasheet |
| Quiescent current | ±5.2 mA typical | TI datasheet |
| Power per IC @ ±15V | ~156 mW quiescent | Calculated |
| Output voltage swing | ±(V+ − 2.5V) per leg | TI datasheet |
| Max output @ ±15V | **±12.5 Vp per leg = 8.84 Vrms differential** | Calculated |
| Output into 600 ohm | 17 Vrms | TI datasheet |
| THD+N @ 1 kHz | 0.0005% (−106 dB) | TI datasheet |
| Slew rate | 15 V/µs | TI datasheet |
| Bandwidth (−3 dB) | >100 kHz | TI datasheet |
| Input impedance | 10 kohm (set by internal network) | TI datasheet |
| Output impedance | ~50 ohm per leg (internal) | TI datasheet |
| Gain | Unity per leg (1× SE→diff = **2× voltage, +6 dB**) | TI datasheet |

### 2.2 Voltage Gain Analysis

The DRV134 has **unity gain from input to each output leg**, but the balanced output is differential — the HOT and COLD legs swing in opposite directions. The effective voltage delivered to the ICEpower's differential input is **2× the input voltage**.

```
Input: 0.9 Vrms (ADAU1701 DAC)
  → DRV134 OUT+ swings +0.9 Vrms
  → DRV134 OUT− swings −0.9 Vrms
  → Differential: 0.9 − (−0.9) = 1.8 Vrms at ICEpower input
```

| Stage | Without DRV134 | With DRV134 |
|-------|---------------|-------------|
| Signal at ICEpower input | 0.9 Vrms (SE) | 1.8 Vrms (balanced) |
| Amp output voltage | 17.55 Vrms | 35.1 Vrms |
| Power into 8 ohm | 38.5W | **154W** |
| Power utilization | 6.2% | **24.8%** |
| Headroom recovered | — | **+6.0 dB** |

154W/ch delivers:
- Per driver: 77W → 87.7 + 10×log10(77) = **106.6 dB** @ 1m
- Per corner (2 drivers): 109.6 dB
- Corner loading (+11 dB): 120.6 dB
- 4-corner sum (+6 dB): 126.6 dB passband
- At 20 Hz (sealed rolloff −6 dB): ~120.6 dB
- **+15.6 dB above THX reference** — weapons-grade margin restored

### 2.3 Getting to Full Power (Optional)

To reach full 620W/ch (3.61 Vrms differential at ICEpower input), the DRV134 needs 1.805 Vrms input. The ADAU1701 DAC only provides 0.9 Vrms. Two options:

**Option A: External DAC (PCM5102) + DRV134**
```
ADAU1701 I2S out → PCM5102 DAC (2.0 Vrms) → DRV134 → 4.0 Vrms differential
```
This **exceeds** the 3.61V needed — actually delivers 4.0 Vrms → 780W/ch (clipping). Would need −0.9 dB DSP attenuation to stay at 620W. Full power unlocked.

**Option B: DRV134 with gain resistor**
The DRV134 supports external gain setting by adding a resistor between pin 3 (sense) and pin 7 (feedback). Default gain is 1×. Adding a 30k resistor in series with a second resistor to ground sets gain > 1.

For 2× gain (needed to hit 3.61V differential from 0.9V input):
- Input resistor: 10k (internal)
- Gain = 1 + (Rf/Rg) — not natively supported by DRV134 topology

**Verdict:** Option A (PCM5102 + DRV134) is the clean path to full power. But the base DRV134 alone (154W/ch, +6 dB) is likely sufficient — it's +15.6 dB above THX at 20 Hz.

---

## 3. Circuit Design

### 3.1 Per-Channel Schematic

```
                          ±15V from ICEpower AVDD/AVSS
                                │        │
                          ┌─────┴──┐  ┌──┴─────┐
                          │100nF   │  │100nF   │
                          │ceramic │  │ceramic │
                          └───┬────┘  └───┬────┘
                              │           │
                     ┌────────┴───────────┴────────┐
                     │                              │
  APM2 DAC OUT ──┤├──┤ 1 IN          8 V+          │
   (0.9 Vrms)  1uF   │                              │
                 film │ 2 ADJ/NC      7 OUT+ ──┤├──── ICEpower P105 IN+
                      │                     10uF     │  (HOT)
                      │ 3 SENSE       6 OUT− ──┤├──── ICEpower P105 IN−
                      │    │               10uF      │  (COLD)
                      │    └─── (connect   │         │
                      │         to GND)    │         │
                      │ 4 V−     5 GND ────┴──────── ICEpower P105 AGND
                      │  │                           │
                      └──┴───────────────────────────┘
                         │
                       AVSS (−15V)
```

### 3.2 Component List Per Channel

| Component | Value | Type | Purpose | Qty |
|-----------|-------|------|---------|-----|
| U1 | DRV134PA | 8-pin DIP | Unbal→bal converter | 1 |
| C_in | 1 µF | Film (WIMA MKS2 or equiv) | DC blocking, input coupling | 1 |
| C_out+ | 10 µF | Film or electrolytic | DC blocking, output HOT | 1 |
| C_out− | 10 µF | Film or electrolytic | DC blocking, output COLD | 1 |
| C_v+ | 100 nF | Ceramic (X7R or C0G) | Supply bypass, V+ | 1 |
| C_v− | 100 nF | Ceramic (X7R or C0G) | Supply bypass, V− | 1 |
| C_bulk+ | 10 µF | Electrolytic | Bulk decoupling, V+ | 1 |
| C_bulk− | 10 µF | Electrolytic | Bulk decoupling, V− | 1 |

### 3.3 Notes

- **Pin 2 (ADJ):** Leave unconnected or tie to pin 3 for unity gain. Do NOT ground.
- **Pin 3 (SENSE):** Connect to signal ground (pin 5) for unity gain.
- **Output caps:** 10 µF film preferred. Electrolytic acceptable for sub frequencies (< 120 Hz). With 38k input impedance on ICEpower, 10 µF gives f_c = 1/(2π × 38000 × 10e-6) = **0.42 Hz** — well below the 5 Hz HPF in the DSP.
- **Input cap:** 1 µF film. With DRV134's 10k input impedance: f_c = 1/(2π × 10000 × 1e-6) = **15.9 Hz**. For sub duty this is acceptable, but **2.2 µF** would push it to 7.2 Hz for more margin below the 10 Hz HPF.

---

## 4. Power Supply — ICEpower AVDD/AVSS

Each ICEpower 1200AS2 module provides:

| Rail | Voltage | Max Current | On Connector |
|------|---------|-------------|-------------|
| AVDD | +15V ±2V | 500 mA | P101 (pin TBD — verify datasheet) |
| AVSS | −15V ±2V | 500 mA | P101 (pin TBD — verify datasheet) |
| Limit | — | Total ≤ 15W | — |

**Power budget per DRV134:**
- Quiescent: ±5.2 mA × ±15V = **156 mW**
- Signal (worst case, full swing into 38k load): negligible additional current
- **Two DRV134 per amp module: ~312 mW — 2% of the 15W limit**

Each ICEpower module drives 2 speaker channels and powers 2 DRV134s. The DRV134 board mounts directly on or adjacent to each amp module, with short power and signal wiring.

---

## 5. ICEpower P105 Connector Wiring

**Connector:** JST B6B-PH-K-S (6-pin, 2mm pitch)
**Mating housing:** JST PHR-6

Standard ICEpower balanced audio input pinout (verify against datasheet page 8):

| Pin | Signal | Connect To |
|-----|--------|------------|
| 1 | IN1+ (HOT) | DRV134 #1 OUT+ (pin 7) via 10 µF cap |
| 2 | IN1− (COLD) | DRV134 #1 OUT− (pin 6) via 10 µF cap |
| 3 | AGND | DRV134 #1 GND (pin 5) |
| 4 | IN2+ (HOT) | DRV134 #2 OUT+ (pin 7) via 10 µF cap |
| 5 | IN2− (COLD) | DRV134 #2 OUT− (pin 6) via 10 µF cap |
| 6 | AGND | DRV134 #2 GND (pin 5) |

**IMPORTANT:** Verify P105 pinout against the official ICEpower 1200AS2 datasheet (v1.7, page 8, figure 12.3) before wiring. The pin order above is the standard convention but has not been confirmed against the physical module.

---

## 6. Physical Implementation

### 6.1 Board Layout

Each DRV134 driver board handles 2 channels (one per ICEpower module). Build on protoboard or custom PCB.

**Board size:** ~50mm × 30mm per 2-channel board (two DRV134 DIP-8 + passives)

```
┌──────────────────────────────────────────────┐
│  ┌──────────┐         ┌──────────┐           │
│  │ DRV134   │         │ DRV134   │           │
│  │ Ch.1     │         │ Ch.2     │           │
│  │ (DIP-8)  │         │ (DIP-8)  │           │
│  └──────────┘         └──────────┘           │
│                                               │
│  [C_in1] [C_out1+] [C_out1-]                │ → P105 JST header
│  [C_in2] [C_out2+] [C_out2-]                │
│                                               │
│  [C_v+ ] [C_v- ] [C_bulk+] [C_bulk-]        │ ← AVDD/AVSS from P101
│                                               │
│  ● IN1 (from APM2 DAC ch1)                  │
│  ● IN2 (from APM2 DAC ch2)                  │
│  ● GND                                       │
└──────────────────────────────────────────────┘
```

### 6.2 Mounting

- Mount each DRV134 board adjacent to its ICEpower module using standoffs or Velcro
- Keep signal wires short (< 6 inches from APM2 DAC output to DRV134 input)
- Power wires from ICEpower P101 AVDD/AVSS can be up to 12 inches (DC, not signal-sensitive)
- Use twisted pair for DRV134 balanced outputs to P105

---

## 7. System Topology — Full Signal Chain

```
X6800H sub pre-outs (4× RCA, 2.0 Vrms)
    │
    ├── Sub FL ──→ APM2 #1 IN1 (2.0V, no clipping)
    ├── Sub FR ──→ APM2 #1 IN2
    ├── Sub RL ──→ APM2 #2 IN1
    └── Sub RR ──→ APM2 #2 IN2
                      │
              ADAU1701 DSP processing
              (HPF, PEQ, gain, routing)
                      │
              ADAU1701 internal DAC (0.9 Vrms per output)
                      │
    ┌─────────────────┼─────────────────────────────┐
    │  APM2 #1 outputs (4ch)    APM2 #2 outputs (4ch)  │
    │  DAC1: 0.9V → DRV134 #1   DAC5: 0.9V → DRV134 #5│
    │  DAC2: 0.9V → DRV134 #2   DAC6: 0.9V → DRV134 #6│
    │  DAC3: 0.9V → DRV134 #3   DAC7: 0.9V → DRV134 #7│
    │  DAC4: 0.9V → DRV134 #4   DAC8: 0.9V → DRV134 #8│
    └─────────────────┼─────────────────────────────┘
                      │
              DRV134 balanced output (1.8 Vrms differential)
                      │
    ┌─────────────────┼─────────────────────────────┐
    │  ICEpower 1200AS2 × 5 modules (10 channels)     │
    │  Ch1: Corner FL ──→ 154W @ 8Ω ──→ 2× UMII18-22│
    │  Ch2: Corner FR ──→ 154W @ 8Ω ──→ 2× UMII18-22│
    │  Ch3: Corner RL ──→ 154W @ 8Ω ──→ 2× UMII18-22│
    │  Ch4: Corner RR ──→ 154W @ 8Ω ──→ 2× UMII18-22│
    │  Ch5: Front NF  ──→ 154W @ 8Ω ──→ 2× UMII18-22│  (deferred)
    │  Ch6: Front Tac ──→ 154W @ 8Ω ──→ 8× Aura Pro │
    │  Ch7: Rear NF   ──→ 154W @ 8Ω ──→ 2× UMII18-22│  (deferred)
    │  Ch8: Rear Tac  ──→ 154W @ 8Ω ──→ 8× Aura Pro │
    │  Ch9-10: spare                                    │
    └───────────────────────────────────────────────┘
```

### Active Channels for Initial Build (Bass Deferral)

| Channel | Source | DRV134 | ICEpower | Destination |
|---------|--------|--------|----------|-------------|
| 1 | APM2 #1 OUT1 | Board A, Ch1 | Module 1, Ch A | Corner FL (2× UMII18-22) |
| 2 | APM2 #1 OUT2 | Board A, Ch2 | Module 1, Ch B | Corner FR (2× UMII18-22) |
| 3 | APM2 #2 OUT1 | Board B, Ch1 | Module 2, Ch A | Corner RL (2× UMII18-22) |
| 4 | APM2 #2 OUT2 | Board B, Ch2 | Module 2, Ch B | Corner RR (2× UMII18-22) |
| 5 | APM2 #1 OUT3 | Board C, Ch1 | Module 3, Ch A | Front shakers (4× Aura) |
| 6 | APM2 #1 OUT4 | Board C, Ch2 | Module 3, Ch B | Spare |
| 7 | APM2 #2 OUT3 | Board D, Ch1 | Module 4, Ch A | Rear shakers (4× Aura) |
| 8 | APM2 #2 OUT4 | Board D, Ch2 | Module 4, Ch B | Spare |

**Note:** Only 6 active channels for initial build (4 corners + 2 shaker zones). Nearfield deferred.

---

## 8. Bill of Materials

### Per 2-Channel DRV134 Board

| Component | Part Number | Qty | Unit Cost | Source |
|-----------|-------------|-----|-----------|--------|
| DRV134PA (DIP-8) | DRV134PA | 2 | $5.50 | Mouser/DigiKey |
| 1 µF film cap (input) | WIMA MKS2 | 2 | $0.50 | Mouser |
| 10 µF film cap (output) | WIMA MKS4 or equiv | 4 | $1.00 | Mouser |
| 100 nF ceramic (bypass) | — | 4 | $0.10 | Mouser |
| 10 µF electrolytic (bulk) | — | 4 | $0.15 | Mouser |
| DIP-8 socket | — | 2 | $0.20 | Mouser |
| Protoboard (50×30mm) | — | 1 | $1.00 | Amazon |
| JST PHR-6 housing + pins | — | 1 | $0.50 | DigiKey |
| **Per board total** | | | **~$19** | |

### Full System (4 boards × 2 channels = 8 channels)

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| DRV134 boards (2ch each) | 4 | $19 | $76 |
| Wire, connectors, standoffs | 1 | $10 | $10 |
| **Total** | | | **$86** |
| **Active channels only (3 boards)** | 3 | $19 | **$67** |

### Compared to Doing Nothing

| Approach | Cost | Power/ch @ 8Ω | Headroom vs THX @ 20 Hz |
|----------|------|---------------|------------------------|
| No DRV134 (DAC direct) | $0 | 38.5W | +9.5 dB |
| DRV134 (this design) | $67-86 | 154W | +15.6 dB |
| PCM5102 + DRV134 | $100-120 | 620W | +21.5 dB |

---

## 9. Validation Plan

### Bench Test (Before Installation)

1. **Build one 2-channel DRV134 board** ($19, 1 hour)
2. **Connect:** APM2 DAC OUT → DRV134 → ICEpower 1200AS2 P105
3. **Power:** ICEpower AVDD/AVSS → DRV134 V+/V−
4. **Measure with REW via UMIK-1:**
   - Noise floor (no signal): should be < −100 dBV at 20-80 Hz
   - THD at 40 Hz, 0 dBFS DSP output: should be < −90 dB
   - Frequency response 5-120 Hz: should be flat ±0.5 dB
   - Output voltage at ICEpower P105: confirm 1.8 Vrms differential
5. **Compare to direct DAC→amp connection:**
   - Same measurements without DRV134
   - Verify +6 dB gain difference
6. **Ground loop test:** Listen for hum with all equipment connected

### Integration Test

1. **Full chain:** X6800H → APM2 → DRV134 → ICEpower → dummy load
2. **Verify Dirac ART independence:** Play ART-processed content, confirm 4 outputs are different
3. **Thermal soak:** Run 30 minutes at moderate level, check DRV134 temperature (should be barely warm)

---

## 10. Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| P105 pinout wrong | LOW | HIGH (channel swap or short) | Verify against datasheet before wiring. Test with multimeter. |
| Ground loop hum | LOW | MEDIUM | Short signal runs in same rack. DRV134 CMRR rejects common-mode. |
| DRV134 oscillation | LOW | MEDIUM | Keep output wiring short. 100 nF bypass caps close to pins. |
| AVDD/AVSS current limit | NEGLIGIBLE | LOW | 312 mW vs 15W limit. |
| Input cap too small (1 µF) | LOW | LOW | Use 2.2 µF if measured rolloff > expected at 10 Hz |
| Need more power than 154W | LOW | LOW | Add PCM5102 external DAC stage later for full 620W |

---

## 11. PCM5102 External DAC — Full Power Upgrade

### 11.1 Why

The DRV134 alone recovers +6 dB (154W/ch) but still only uses 25% of the ICEpower's rated power. To reach full 620W/ch, the DRV134 needs ~1.8 Vrms input (for 3.6 Vrms differential output). The ADAU1701 internal DAC only provides 0.9 Vrms. An external PCM5102 DAC provides 2.1 Vrms — enough to exceed the amp's full-power threshold.

### 11.2 PCM5102A Specifications

| Parameter | Value | Source |
|-----------|-------|--------|
| Manufacturer | Texas Instruments | TI datasheet |
| Output voltage | **2.1 Vrms** (ground-centered) | TI datasheet |
| Dynamic range / SNR | 112 dB | TI datasheet |
| THD+N | −93 dB (0.0022%) | TI datasheet |
| Sample rates | 8 kHz – 384 kHz | TI datasheet |
| Bit depth | Up to 32-bit | TI datasheet |
| Power supply | 3.3V (digital + analog) | TI datasheet |
| Current consumption | ~20 mA | TI datasheet |
| I2S format | Standard I2S, left-justified | TI datasheet |
| MCLK required | **No** — internal PLL, self-clocking | TI datasheet |
| Channels per chip | **2** (stereo) | TI datasheet |
| Module price | **$5-8** (breakout boards from Amazon/AliExpress) | Market |

**Key advantage:** No MCLK connection needed. The PCM5102 generates its own master clock from BCK via an internal PLL. This dramatically simplifies wiring — only 3 data lines required.

### 11.3 ADAU1701 I2S Output Port

The ADAU1701 has a dedicated serial output port on MP pins 6-11:

| ADAU1701 Pin | Function | APM2 J4 Pin | Direction |
|-------------|----------|-------------|-----------|
| MP11 | OUTPUT_BCLK | J4 pin 3 | Master out → PCM5102 BCK |
| MP10 | OUTPUT_LRCLK | J4 pin 4 | Master out → PCM5102 LRCK |
| MP6 | SDATA_OUT0 | J4 pin 5 | Data out → PCM5102 #1 DIN (ch 1-2) |
| MP7 | SDATA_OUT1 | J4 pin 6 | Data out → PCM5102 #2 DIN (ch 3-4) |

**Capacity:** Each SDATA_OUT line carries 2 channels (L+R) in standard I2S mode. Two SDATA_OUT lines = **4 channels per APM2 board**. With 2× APM2 boards = 8 channels total.

**SigmaStudio configuration:** Set the output port to **Master mode**, I2S format, 48 kHz. The output BCLK and LRCLK are generated by the ADAU1701 and shared across all PCM5102 modules on that APM2.

### 11.4 Wiring — Per APM2 Board

Each APM2 board connects to 2× PCM5102 modules (4 analog outputs):

```
APM2 J4 Header                  PCM5102 Module #1 (Ch 1-2)
────────────                     ──────────────────────────
  MP11 (BCLK)  ─────┬──────────── BCK
  MP10 (LRCLK) ─────┼─┬────────── LRCK (WSEL)
  MP6 (SDATA0) ─────┼─┼────────── DIN
  GND          ─────┼─┼────────── GND
                     │ │
                     │ │          PCM5102 Module #2 (Ch 3-4)
                     │ │          ──────────────────────────
                     ├─┼────────── BCK    (shared clock)
                     └─┼────────── LRCK   (shared clock)
  MP7 (SDATA1) ────────┼───────── DIN    (different data)
  GND          ────────┼───────── GND
                       │
              (BCK + LRCK are shared;
               each PCM5102 gets its own SDATA line)
```

**Power:** PCM5102 modules run on 3.3V. Options:
- USB power (if module has onboard regulator accepting 5V)
- ICEpower DVDD (5V, 1A available) → module's onboard 3.3V regulator
- Dedicated 3.3V LDO

### 11.5 Voltage at Every Stage (With PCM5102 + DRV134)

```
X6800H sub pre-out ──→ APM2 ADC ──→ ADAU1701 DSP ──→ I2S out
   2.0 Vrms              2.0V         (digital)       (digital)
                        (no clip)

   ──→ PCM5102 DAC ──→ DRV134 ──→ ICEpower 1200AS2 ──→ Speakers
       2.1 Vrms        4.2 Vrms      81.9 Vrms          8Ω load
       (analog)       (balanced)      output

   Power: 81.9² / 8 = 838W (exceeds rated 620W — need DSP attenuation)
```

**At 4.2 Vrms differential, the amp clips.** The ICEpower needs 3.54 Vrms for full power (1200W @ 4Ω / 620W @ 8Ω). So we'd set DSP gain to −1.5 dB to land at exactly 3.54 Vrms → 620W.

| Stage | Voltage | Notes |
|-------|---------|-------|
| X6800H pre-out | 2.0 Vrms | RCA unbalanced |
| APM2 ADC input | 2.0 Vrms | Full-scale, no clipping |
| ADAU1701 DSP | Digital (28-bit) | HPF, PEQ, gain |
| I2S to PCM5102 | Digital | 3 wires: BCK, LRCK, DIN |
| PCM5102 DAC output | **2.1 Vrms** | Analog, ground-centered |
| DRV134 output | **4.2 Vrms differential** | Exceeds target — trim in DSP |
| DRV134 output (trimmed −1.5 dB) | **3.54 Vrms differential** | Full power match |
| ICEpower output @ 8Ω | 70.4 Vrms | **620W** |
| ICEpower output @ 4Ω | — | **1200W** (not used) |

### 11.6 SPL at Full Power

```
620W per channel into 8Ω (2× UMII18-22 in series)
Per driver: 310W → 87.7 + 10×log10(310) = 87.7 + 24.9 = 112.6 dB @ 1m
Per corner (2 drivers): 115.6 dB
+ corner loading (+11 dB): 126.6 dB
+ 4-corner sum (+6 dB): 132.6 dB passband
At 20 Hz (sealed rolloff −6 dB): ~126.6 dB
```

**+21.6 dB above 105 dB THX reference.** Truly weapons-grade — mechanical limits (Xmax) become the constraint before amplifier power.

### 11.7 Bill of Materials — PCM5102 Addition

| Component | Qty | Unit Cost | Total | Source |
|-----------|-----|-----------|-------|--------|
| PCM5102A breakout module | 4 | $6 | $24 | Amazon/AliExpress |
| Dupont jumper wires (I2S) | 4 sets | $1 | $4 | Amazon |
| **PCM5102 subtotal** | | | **$28** | |

### 11.8 Combined BOM — Full Power Path

| Stage | Qty | Cost |
|-------|-----|------|
| PCM5102 DAC modules (2 per APM2 × 2 boards) | 4 | $24 |
| DRV134 boards (2ch each) | 4 | $76 |
| Wire, jumpers, connectors | — | $14 |
| **Total for full-power balanced output** | | **$114** |
| **Active channels only (6ch = 3 DRV134 + 3 PCM5102)** | | **$85** |

### 11.9 Comparison — All Three Options

| Approach | Added Cost | Power/ch @ 8Ω | SPL @ 20 Hz | Headroom vs THX | Complexity |
|----------|-----------|---------------|-------------|-----------------|------------|
| Nothing (internal DAC, SE) | $0 | 38.5W | 114.5 dB | +9.5 dB | None |
| DRV134 only (internal DAC) | $67-86 | 154W | 120.6 dB | +15.6 dB | Low — solder 3 boards |
| **PCM5102 + DRV134** | **$85-114** | **620W** | **126.6 dB** | **+21.6 dB** | **Medium — I2S wiring + solder** |

### 11.10 Risks Specific to PCM5102 Path

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| J4 I2S pins not accessible | LOW | HIGH | Inspect APM2 board; MP6/7/10/11 are on J4 per Wondom docs |
| I2S clock/format mismatch | MEDIUM | HIGH | PCM5102 auto-detects I2S format. Set ADAU1701 output port to I2S master mode in SigmaStudio |
| PCM5102 PLL lock failure | LOW | MEDIUM | Module includes decoupling. Keep BCK wires short (< 6"). Add 100 pF cap on BCK line if needed |
| Power supply noise | LOW | LOW | Use ICEpower DVDD (5V) through module's onboard regulator. Add 10 µF bulk cap |
| Internal DAC still active | LOW | LOW | In SigmaStudio, route signal to serial output port only. Internal DAC outputs can be left disconnected or muted |
| 4ch limit per APM2 | NONE | NONE | Each APM2 has 4 outputs; 2 SDATA_OUT lines × 2ch each = 4ch. Perfect match |

### 11.11 Implementation Sequence

1. **Phase 1: DRV134 only** — Build one 2ch board, bench test with internal DAC (0.9V → 1.8V balanced → 154W). Validate the balanced output path works.
2. **Phase 2: Add PCM5102** — Wire one PCM5102 module to APM2 J4 (MP6 for SDATA_OUT0). Verify 2.1 Vrms output. Confirm I2S lock.
3. **Phase 3: Full chain** — PCM5102 → DRV134 → ICEpower. Measure 4.2 Vrms differential at P105. Trim DSP gain to −1.5 dB → 3.54 Vrms → 620W.
4. **Phase 4: Build all boards** — 4× PCM5102 modules, 4× DRV134 boards. Full 8-channel system.

---

## 12. Component Investigation — Quality & Sourcing

Pre-purchase investigation of every component in the signal chain, informed by the ADAU1452+CS42448 board experience (28 pages of diyAudio problems, SMD rework required, untested in project).

### 12.1 THAT1646 Replaces DRV134 — CRITICAL FINDING

**Do NOT buy DRV134PA from Amazon.** Investigation found:

- DRV134PA is **NRND (Not Recommended for New Designs)** at TI — production winding down
- Amazon sellers are unauthorized third parties with machine-translated listings, no reviews
- [diyAudio thread specifically asks about DRV134 fakes from China](https://www.diyaudio.com/community/threads/drv134-from-china-fakes-or-original-components.388438/)
- If Amazon unit price is below $5, it fails the price sanity check vs authorized distributor cost

**Replacement: THAT1646P08-U (DIP-8)** — pin-compatible, drop-in, and superior:

| Spec | DRV134PA | THAT1646P08-U |
|------|----------|---------------|
| THD+N @ 1 kHz | 0.0008% | 0.0007% |
| Output noise floor | −93.4 dBu | **−101 dBu** (7.6 dB better) |
| Slew rate | 15 V/µs | 15 V/µs |
| Supply range | ±4.5V to ±18V | ±4V to ±18V |
| Clipping behavior | Harsh (cross-coupled) | **Graceful (OutSmarts)** |
| Pin-compatible? | — | **Yes, drop-in for DRV134** |
| Production status | **NRND** (end-of-life) | **Active production** |
| DigiKey price (qty 1) | $6.25 | ~$5-6 |
| DigiKey stock | 1,038 units | In stock |

The THAT1646 is the standard DRV134 replacement in pro audio. Same pinout, same PCB, better specs, active production. All circuit designs in this document apply identically — substitute "DRV134" with "THAT1646" throughout.

**Only difference:** THAT1646 bypass caps are 100 nF (same as already specified). DRV134 datasheet calls for 1 µF — the 100 nF in the BOM works for both.

Sources:
- [THAT Corporation: 1606/1646 Line Driver ICs](https://thatcorp.com/that-1606-1646-balanced-line-driver-ics/)
- [diyAudio: DRV134 replacement, THAT1646](https://www.diyaudio.com/community/threads/drv134-replacment-better-chip-that1646-se-to-balanced.136059/)
- [THAT Corp: Line Driver Comparison (PDF)](https://thatcorp.com/datashts/Line_Driver_Comparison.pdf)
- [DigiKey DRV134PA listing](https://www.digikey.com/en/products/detail/texas-instruments/DRV134PA/275875)

### 12.2 PCM5102A Modules — PROVEN

**Feasibility: Confirmed.** The ADAU1701 → PCM5102A I2S path is used in commercial products:

- **Enovo-77 board** ships with ADAU1701 + PCM5102A as a production design
- Multiple EngineerZone threads document working setups
- Internal DAC + serial output work **simultaneously** — no channel loss
- APM2 J4 header **does expose** MP6/MP10/MP11 for I2S output
- Measured result: −93 dB THD+N on PCM5102A vs −83 dB from ADAU1701 internal DAC (10 dB improvement)

**Cheap clone quality: Inconsistent.** GY-PCM5102 boards from Amazon have reports of:
- Sloppy solder, flux residue, deformed 3.5mm jacks
- DOA units (no audio output despite correct wiring)
- ME6211C33M5G voltage regulator (adequate but not low-noise)
- Single shared regulator for AVDD and DVDD (proper designs separate them)

**Recommendation: Buy Adafruit (#6250, $4.95/ea).** Open-source design, proper power regulation, documented. $2 premium over clones eliminates QC risk.

**Known gotcha:** Disconnect ICP5 programmer during operation — it grounds BCLK over I2C, killing I2S output. Use self-boot (EEPROM) mode for normal operation.

Sources:
- [EngineerZone: ADAU1701 I2S output to PCM5102 DAC](https://ez.analog.com/dsp/sigmadsp/f/q-a/574351/adau1701-i2s-output-to-pcm5102-dac)
- [EngineerZone: ADAU1701 as master with PCM5102 DAC](https://ez.analog.com/dsp/f/q-a/588734/adau1701-as-master-and-wm8782-adc-and-pcm5102-dac-as-slaves-possible)
- [EngineerZone: ADAU1701 signal routing (internal DAC + serial simultaneous)](https://ez.analog.com/dsp/sigmadsp/w/documents/5194/adau1701-input-and-output-signal-routing)
- [EngineerZone: No output when programmer connected via I2C](https://ez.analog.com/dsp/sigmadsp/f/q-a/110867/no-output-from-adau1701-to-pcm5102-dac-on-i2s-when-programmer-connected-via-i2c)
- [Enovo-77: TDA7388 + ADAU1701 + PCM5102 commercial board](https://www.enovo-circuits.com/audio-amplifiers/adau1701-tda7388-pcm5102.html)
- [diyAudio: ADAU1701 based DSP for sub or 2-way](https://www.diyaudio.com/community/threads/adau1701-based-dsp-for-sub-or-2-way.347460/page-4)
- [Adafruit PCM5102 product page](https://www.adafruit.com/product/6250)
- [Adafruit PCM510x PCB — GitHub (open-source design)](https://github.com/adafruit/Adafruit-PCM510x-I2S-DAC-PCB)

### 12.3 WIMA Caps — DO NOT BUY FROM AMAZON

Counterfeit WIMA capacitors are well-documented on diyAudio and GroupDIY forums. Tells include wrong lettering color (gold instead of white/black), steel leads instead of tin-plated copper, and missing cream-colored underside.

**Buy from Mouser or DigiKey.** WIMA MKS2 2.2µF 63V is ~$1.50 each. Total spend is ~$15 for 10 caps — negligible price difference vs Amazon, guaranteed genuine.

Sources:
- [diyAudio: Fake WIMAs?](https://www.diyaudio.com/community/threads/fake-wimas.330965/)
- [GroupDIY: Identify faked WIMA capacitors](https://groupdiy.com/threads/identify-faked-wima-capacitors.45867/)
- [PedalPCB: Are these WIMA capacitors fake?](https://forum.pedalpcb.com/threads/are-these-wima-capacitors-fake.14261/)

### 12.4 Passives — LOW RISK

| Component | Risk | Verdict |
|-----------|------|---------|
| Nichicon Muse FG 10µF 50V (output coupling) | LOW | fc = 0.42 Hz into 38k load — 10× below 5 Hz floor. Electrolytic fine for sub frequencies. |
| 100nF ceramic disc (bypass) | NONE | Commodity part, no counterfeit concern |
| DIP-8 sockets | NONE | Commodity part |
| JST PH 2.0mm connectors | LOW | Generic clones dimensionally compatible. Quick continuity check after crimping. |
| Perfboard | NONE | Commodity part |
| Dupont jumper wires | NONE | Commodity part |

---

## 13. Revised Bill of Materials — Investigated & Sourced

### Sourcing Strategy

- **ICs and precision caps** → DigiKey/Mouser (authorized, traceable, no counterfeits)
- **PCM5102A modules** → Adafruit (open-source design, proper regulation, documented)
- **Commodity passives and connectors** → Amazon (low counterfeit risk, fast shipping)

### Order 1: DigiKey or Mouser (genuine ICs + precision caps)

| Item | Part Number | Qty | Unit $ | Total | Notes |
|------|-------------|-----|--------|-------|-------|
| THAT1646P08-U (DIP-8) | THAT1646P08-U | 10 | ~$5.50 | $55 | 8 needed + 2 spares. Pin-compatible DRV134 replacement. |
| WIMA MKS2 2.2µF 63V | MKS2C042201N00JS | 10 | $1.50 | $15 | Input coupling caps (8 needed + 2 spares) |
| **Order 1 subtotal** | | | | **$70** | Hits free shipping threshold |

### Order 2: Adafruit (PCM5102A DAC modules)

| Item | Part Number | Qty | Unit $ | Total | Notes |
|------|-------------|-----|--------|-------|-------|
| PCM5102 I2S DAC | [Adafruit #6250](https://www.adafruit.com/product/6250) | 4 | $4.95 | $20 | 2 per APM2 board. Open-source design, proper regulation. |
| **Order 2 subtotal** | | | | **$20** | |

### Order 3: Amazon (commodity passives + connectors)

| Item | Link | Qty | Total | Notes |
|------|------|-----|-------|-------|
| Nichicon Muse FG 10µF 50V | [5-pack × 4](https://www.amazon.com/Nichicon-FG-Audio-Grade-Capacitor-12-5mm/dp/B076S78JFZ) | 20 pcs | $6 | Output coupling caps (16 needed + spares) |
| DIP-8 sockets | [20-pack](https://www.amazon.com/Solder-Profile-Socket-2-54mm-Distance/dp/B0BVXKYQB2) | 20 pcs | $7 | Sockets for THAT1646 |
| 100nF ceramic disc 50V | [150-pack](https://www.amazon.com/IIVVERR-Capacitor-orificio-capacitor-cer%C3%A1mico/dp/B08LDWTWYM) | 150 pcs | $6 | Supply bypass (16 needed, lifetime supply) |
| 10µF electrolytic (bulk bypass) | Parts bin or Amazon | 16 pcs | $3 | Bulk supply decoupling |
| Perfboard 50×70mm | [10-pack](https://www.amazon.com/Stripboard-Printed-Circuit-Soldering-Prototype/dp/B019Q14GRQ) | 10 pcs | $7 | Cut to size for driver boards |
| JST PH 2.0mm connector kit | [150-set](https://www.amazon.com/CQRobot-Connector-Terminal-Industrial-Integrated/dp/B0731MZCGF) | 150 sets | $10 | For ICEpower P105 connectors |
| Dupont jumper wires | [120-pack](https://www.amazon.com/gp/product/B072L1XMJR) | 120 pcs | $6 | I2S wiring from APM2 J4 to PCM5102 |
| **Order 3 subtotal** | | | | **$45** | |

### Cost Summary

| Order | Source | Total |
|-------|--------|-------|
| 1 | DigiKey/Mouser | $70 |
| 2 | Adafruit | $20 |
| 3 | Amazon | $45 |
| **Grand total** | | **$135** |

This builds **all 4 driver boards** (8 channels) with spares on every critical component. Enough parts to bench-test one channel and then build out the full system without reordering.

### What You Get for $135

| Metric | Value |
|--------|-------|
| Full-power output per channel @ 8Ω | **620W** |
| SPL at 20 Hz (4 corners, loaded, summed) | **126.6 dB** |
| Headroom over 105 dB THX reference | **+21.6 dB** |
| Equivalent commercial product | miniDSP Flex HT ($600) |
| Cost savings vs commercial | **$465** |

### Already Owned

| Item | Status |
|------|--------|
| Wondom APM2 (×1) | On hand — bench tested, COM pipeline proven |
| ICP5 programmer | On hand |
| SigmaStudio 4.7 | Installed |
| MOTU M2 (measurement interface) | On hand |
| UMIK-1 (measurement mic) | On hand |
| REW 5.40 | Installed |

---

## 14. Complete Purchase List — Full Sub Amplification System

Everything needed to go from "APM2 on bench" to "8-corner sub array at full power." Organized by vendor for minimum orders.

### Order 1: Parts Express — ICEpower Amplification

| Item | Part # | Qty | Unit $ | Total | Notes |
|------|--------|-----|--------|-------|-------|
| ICEpower 1200AS2 module | [326-117](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117) | 5 | $373 | $1,865 | 2ch/module, 10ch total. 4 corner + 1 shaker/spare. Free shipping. |
| ICEpower 1200AS2 wiring harness | 326-290 | 5 | ~$15 | $75 | P100-P108 pre-crimped harness set (sold separately) |
| **Order 1 subtotal** | | | | **$1,940** | |

### Order 2: Sure Electronics — DSP Boards

| Item | Part # | Qty | Unit $ | Total | Notes |
|------|--------|-----|--------|-------|-------|
| Wondom APM2 (ADAU1701) | [AA-AP23122](https://store.sure-electronics.com/product/AA-AP23122) | 2 | ~$40 | $80 | Need 2 more (have 1). 2 active + 1 spare. |
| **Order 2 subtotal** | | | | **$80** | |

*Alternative: [Amazon](https://www.amazon.com/Audio-Digital-Signal-Processor-Kernal/dp/B07HHNQ74B) if Sure Electronics is out of stock.*

### Order 3: DigiKey or Mouser — ICs + Precision Caps

| Item | Part Number | Qty | Unit $ | Total | Notes |
|------|-------------|-----|--------|-------|-------|
| THAT1646P08-U (DIP-8) | THAT1646P08-U | 10 | ~$5.50 | $55 | Balanced line driver. 8 needed + 2 spares. |
| WIMA MKS2 2.2µF 63V | MKS2C042201N00JS | 10 | $1.50 | $15 | Input coupling caps (8 needed + 2 spares) |
| **Order 3 subtotal** | | | | **$70** | Hits free shipping threshold |

### Order 4: Adafruit — External DAC Modules

| Item | Part # | Qty | Unit $ | Total | Notes |
|------|--------|-----|--------|-------|-------|
| PCM5102 I2S DAC | [#6250](https://www.adafruit.com/product/6250) | 4 | $4.95 | $20 | 2 per APM2 board. Open-source design, proper regulation. |
| **Order 4 subtotal** | | | | **$20** | |

### Order 5: Amazon — Commodity Passives + Connectors

| Item | Link | Qty | Total | Notes |
|------|------|-----|-------|-------|
| Nichicon Muse FG 10µF 50V | [5-pack × 4](https://www.amazon.com/Nichicon-FG-Audio-Grade-Capacitor-12-5mm/dp/B076S78JFZ) | 20 pcs | $6 | Output coupling caps (16 needed + spares) |
| DIP-8 sockets | [20-pack](https://www.amazon.com/Solder-Profile-Socket-2-54mm-Distance/dp/B0BVXKYQB2) | 20 pcs | $7 | Sockets for THAT1646 |
| 100nF ceramic disc 50V | [150-pack](https://www.amazon.com/IIVVERR-Capacitor-orificio-capacitor-cer%C3%A1mico/dp/B08LDWTWYM) | 150 pcs | $6 | Supply bypass (16 needed, lifetime supply) |
| 10µF electrolytic (bulk bypass) | Parts bin or Amazon | 16 pcs | $3 | Bulk supply decoupling |
| Perfboard 50×70mm | [10-pack](https://www.amazon.com/Stripboard-Printed-Circuit-Soldering-Prototype/dp/B019Q14GRQ) | 10 pcs | $7 | Cut to size for driver boards |
| JST PH 2.0mm connector kit | [150-set](https://www.amazon.com/CQRobot-Connector-Terminal-Industrial-Integrated/dp/B0731MZCGF) | 150 sets | $10 | For ICEpower P105 audio input connectors |
| Dupont jumper wires | [120-pack](https://www.amazon.com/gp/product/B072L1XMJR) | 120 pcs | $6 | I2S wiring from APM2 J4 to PCM5102 |
| **Order 5 subtotal** | | | | **$45** | |

### Grand Total

| Order | Vendor | Total | What |
|-------|--------|-------|------|
| 1 | Parts Express | $1,940 | 5× ICEpower 1200AS2 + harnesses |
| 2 | Sure Electronics | $80 | 2× APM2 (ADAU1701) |
| 3 | DigiKey/Mouser | $70 | THAT1646 ICs + WIMA caps |
| 4 | Adafruit | $20 | 4× PCM5102 DAC modules |
| 5 | Amazon | $45 | Passives, connectors, protoboard |
| **TOTAL** | | **$2,155** | |

### Breakdown by Function

| Function | Cost | % |
|----------|------|---|
| Amplification (5× ICEpower 1200AS2) | $1,940 | 90% |
| DSP (2× APM2 additional) | $80 | 4% |
| Output stage (PCM5102 + THAT1646 + passives) | $135 | 6% |

### What This System Delivers

| Metric | Value |
|--------|-------|
| Channels | 10 (8 sub + 2 spare) |
| Active channels (initial) | 6 (4 corner + 2 shaker) |
| Power per channel @ 8Ω | **620W** |
| Power per channel @ 4Ω | **1,200W** |
| SPL at 20 Hz (4 corners, boundary-loaded) | **126.6 dB** |
| Headroom over 105 dB THX reference | **+21.6 dB** |
| Signal chain | X6800H → APM2 ADC → ADAU1701 DSP → I2S → PCM5102 → THAT1646 → ICEpower |
| Equivalent commercial system | miniDSP Flex HT ($600) + 5× pro amps (~$3,000+) |
| Sub-20 Hz filtering | Yes (DSP-408 couldn't) |
| Automated calibration | Yes (REW + Python pipeline) |
| Self-boot (no PC needed) | Yes (EEPROM) |

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-17 | Initial DRV134 balanced output stage design |
| 1.1 | 2026-03-17 | Added Section 11: PCM5102 external DAC for full-power path |
| 1.2 | 2026-03-17 | Added Section 12-13: Component investigation, revised BOM, THAT1646 replacement |
