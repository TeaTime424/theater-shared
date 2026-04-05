# DSP Subwoofer & Tactile Processing System
## ADAU1701-Based Signal Processing

**Document Version:** 2.1
**Created:** March 4, 2026
**Updated:** March 19, 2026
**Status:** POR — Plan of Record
**Replaces:** DSP-408 for subwoofer/tactile processing (POR/06 Option A external DSP)

---

## 1. Summary

Multiple ADAU1701 DSP boards replace the Dayton DSP-408 for all subwoofer, nearfield, and tactile processing. Each APM2 board provides 2-in/4-out; two boards cover all 8 output channels. The Denon AVR-X6800H's 4 independent sub outputs distribute to all amplifier channels — corner subs, nearfield subs, and tactile transducers — with per-channel room correction.

**Balanced output via THAT1646 line drivers and PCM5102 external DACs delivers 3.54 Vrms differential to unlock full ICEpower 1200AS2 power (620W/ch @ 8 ohm).**

**Key advantages over DSP-408:**
- HPF/LPF down to **any frequency** (DSP-408 minimum is 20 Hz)
- 10 PEQ bands per output (DSP-408: 10, but limited below 20 Hz)
- Automated calibration via Python + REW + SigmaStudio (no manual tuning)
- Full amplifier power via balanced output (620W vs 38.5W with unbalanced)
- One DSP platform handles all sub/nearfield/tactile processing

---

## 2. Signal Architecture

```
X6800H                  APM2 #1 (ADAU1701)          PCM5102    THAT1646    ICEpower 1200AS2
(4 sub outputs)         (2-in / 4-out DSP)          (ext DAC)  (balanced)  (amplification)

Sub Front L ──→ IN 1 ──┬──→ HPF+PEQ ─────→ I2S ──→ DAC ──→ BAL ──→ Corner FL subs
                       │
Sub Front R ──→ IN 2 ──┼──→ HPF+PEQ ─────→ I2S ──→ DAC ──→ BAL ──→ Corner FR subs
                       │
                       ├──→ sum ──→ HPF+LPF+PEQ ──→ I2S ──→ DAC ──→ BAL ──→ Front nearfield (deferred)
                       └──→ sum ──→ BPF+PEQ ──────→ I2S ──→ DAC ──→ BAL ──→ Front tactile

                  APM2 #2 (ADAU1701)
Sub Rear L  ──→ IN 1 ──┬──→ HPF+PEQ ─────→ I2S ──→ DAC ──→ BAL ──→ Corner RL subs
                       │
Sub Rear R  ──→ IN 2 ──┼──→ HPF+PEQ ─────→ I2S ──→ DAC ──→ BAL ──→ Corner RR subs
                       │
                       ├──→ sum ──→ HPF+LPF+PEQ ──→ I2S ──→ DAC ──→ BAL ──→ Rear nearfield (deferred)
                       └──→ sum ──→ BPF+PEQ ──────→ I2S ──→ DAC ──→ BAL ──→ Rear tactile
```

### Channel Map

**APM2 #1 (Front):**

| Output | Source | Processing | Destination | Amp |
|--------|--------|-----------|-------------|-----|
| OUT 1 | IN 1 (Sub FL) | HPF 5Hz + PEQ ×10 | Corner FL subs (2× UMII18-22) | Amp 1, Ch A |
| OUT 2 | IN 2 (Sub FR) | HPF 5Hz + PEQ ×10 | Corner FR subs (2× UMII18-22) | Amp 1, Ch B |
| OUT 3 | IN 1+2 sum | HPF 5Hz + LPF 80Hz + PEQ ×10 | Front nearfield (deferred) | Amp 3, Ch A |
| OUT 4 | IN 1+2 sum | BPF 10-80Hz + PEQ ×10 | Front tactile (4× Aura AST-2B-4) | Amp 3, Ch B |

**APM2 #2 (Rear):**

| Output | Source | Processing | Destination | Amp |
|--------|--------|-----------|-------------|-----|
| OUT 1 | IN 1 (Sub RL) | HPF 5Hz + PEQ ×10 | Corner RL subs (2× UMII18-22) | Amp 2, Ch A |
| OUT 2 | IN 2 (Sub RR) | HPF 5Hz + PEQ ×10 | Corner RR subs (2× UMII18-22) | Amp 2, Ch B |
| OUT 3 | IN 1+2 sum | HPF 5Hz + LPF 80Hz + PEQ ×10 | Rear nearfield (deferred) | Amp 4, Ch A |
| OUT 4 | IN 1+2 sum | BPF 10-80Hz + PEQ ×10 | Rear tactile (4× Aura AST-2B-4) | Amp 4, Ch B |

### Why This Topology Works

1. **4 independent corner channels** — Dirac ART on the X6800H optimizes each sub output for its corner placement. The ADAU1701 preserves this independence with per-channel PEQ for fine room correction that Dirac doesn't handle (narrow modes, seat-to-seat variation).

2. **Derived nearfield/tactile channels** — Nearfield subs and tactile transducers don't need independent steering from the processor. A mono sum of the front or rear pair provides the correct bass content. The DSP adds crossover filtering and EQ specific to those transducers.

3. **All 8 outputs from 4 inputs** — No channels wasted, no external summing hardware needed. The mixing happens inside the DSP.

---

## 3. Per-Output Processing Chain

### Outputs 1-4: Corner Subwoofers (Direct)

```
IN → HPF (5Hz, BW2) → PEQ ×10 → Gain → OUT
```

- **HPF at 5 Hz** — subsonic protection (the DSP-408 couldn't go below 20 Hz)
- **10 PEQ bands** — automated room correction via calibration pipeline
- **Gain** — level trim for amplifier matching
- No LPF needed — the Marantz AV10 handles the sub crossover

### Outputs 5 & 7: Nearfield Subwoofers (Summed)

```
IN_L + IN_R → Sum → HPF (5Hz, BW2) → LPF (80Hz, LR4) → PEQ ×10 → Gain → OUT
```

- **Sum** — mono mix of left+right sub pair (front or rear)
- **HPF at 5 Hz** — subsonic protection
- **LPF at 80 Hz** — nearfield subs play the tactile range, not higher
- **10 PEQ bands** — correct for nearfield placement (riser face, console towers)
- LPF frequency may be adjusted based on measurement

### Outputs 6 & 8: Tactile Transducers (Summed)

```
IN_L + IN_R → Sum → HPF (10Hz, BW2) → LPF (80Hz, LR4) → PEQ ×10 → Gain → OUT
```

- **Sum** — same mono mix as nearfield
- **HPF at 10 Hz** — protect bass shakers from DC/infrasonic content
- **LPF at 80 Hz** — tactile effect above 80 Hz is vibration, not bass feel
- **10 PEQ bands** — shape the tactile response curve (typically a house curve with elevated 20-40 Hz)
- Gain will typically be set lower than subs — tactile is a supplement, not primary

---

## 4. Instruction Budget

Each ADAU1701 has 1,024 instruction cycles at 48 kHz. Each board handles 4 outputs.

**Per APM2 board (4 outputs):**

| Block | Instructions | Per Output | Outputs | Total |
|-------|-------------|-----------|---------|-------|
| HPF (2nd order BW) | 6 | 1 | 4 | 24 |
| LPF (4th order LR) | 12 | 1 | 2 (nearfield/tactile only) | 24 |
| PEQ (2nd order) | 6 | 10 | 4 | 240 |
| Gain (single) | 2 | 1 | 4 | 8 |
| Summing mixer | 4 | 1 | 2 (nearfield/tactile only) | 8 |
| Input/Output routing | 0 | — | — | 0 |
| **Total per board** | | | | **304 / 1,024 (30%)** |

**70% instruction headroom remaining per board.** Sufficient for delay alignment or additional PEQ bands if needed. The ADAU1701's smaller instruction budget (vs ADAU1452's 6,144) is adequate because each board only handles 4 outputs instead of 8.

---

## 5. SigmaStudio Project Design

### Hardware Configuration Tab

```
ICP5 ──→ ADAU1701 (IC 1) ──→ E2Prom (IC 2)
```

- IC type: ADAU1701
- Clock: 48 kHz (internal)
- Communication: I2C via ICP5
- One SigmaStudio project per APM2 board

### Signal Flow (Schematic Tab)

Build in SigmaStudio using these exact block names for consistent parameter address export:

**APM2 #1 (Front channels):**

Input Stage:
- `Input_FL` — ADC Channel 0 (Sub Front Left)
- `Input_FR` — ADC Channel 1 (Sub Front Right)
- `Sum_Front` — Mix Input_FL + Input_FR (equal gain)

| Output | Block Names |
|--------|------------|
| OUT 1 (Corner FL) | `HPF_CorFL`, `PEQ1_CorFL` ... `PEQ10_CorFL`, `Gain_CorFL` |
| OUT 2 (Corner FR) | `HPF_CorFR`, `PEQ1_CorFR` ... `PEQ10_CorFR`, `Gain_CorFR` |
| OUT 3 (NF Front) | `HPF_NFFr`, `LPF_NFFr`, `PEQ1_NFFr` ... `PEQ10_NFFr`, `Gain_NFFr` |
| OUT 4 (Tac Front) | `HPF_TacFr`, `LPF_TacFr`, `PEQ1_TacFr` ... `PEQ10_TacFr`, `Gain_TacFr` |

Serial Output: I2S master → PCM5102 #1 (SDATA_OUT0, ch 1-2) + PCM5102 #2 (SDATA_OUT1, ch 3-4)

**APM2 #2 (Rear channels):**

Input Stage:
- `Input_RL` — ADC Channel 0 (Sub Rear Left)
- `Input_RR` — ADC Channel 1 (Sub Rear Right)
- `Sum_Rear` — Mix Input_RL + Input_RR (equal gain)

| Output | Block Names |
|--------|------------|
| OUT 1 (Corner RL) | `HPF_CorRL`, `PEQ1_CorRL` ... `PEQ10_CorRL`, `Gain_CorRL` |
| OUT 2 (Corner RR) | `HPF_CorRR`, `PEQ1_CorRR` ... `PEQ10_CorRR`, `Gain_CorRR` |
| OUT 3 (NF Rear) | `HPF_NFRr`, `LPF_NFRr`, `PEQ1_NFRr` ... `PEQ10_NFRr`, `Gain_NFRr` |
| OUT 4 (Tac Rear) | `HPF_TacRr`, `LPF_TacRr`, `PEQ1_TacRr` ... `PEQ10_TacRr`, `Gain_TacRr` |

Serial Output: I2S master → PCM5102 #3 (SDATA_OUT0, ch 1-2) + PCM5102 #4 (SDATA_OUT1, ch 3-4)

**Note:** Audio output goes via I2S serial port to external PCM5102 DACs, NOT the internal DAC. Internal DAC outputs left disconnected. Route signal to serial output port in SigmaStudio.

### Initial Filter Settings

| Block Type | Default Setting | Notes |
|-----------|----------------|-------|
| HPF (corners) | 5 Hz, Butterworth 2nd order | Subsonic protection |
| HPF (nearfield) | 5 Hz, Butterworth 2nd order | Subsonic protection |
| HPF (tactile) | 10 Hz, Butterworth 2nd order | Protect bass shakers |
| LPF (nearfield) | 80 Hz, LR 4th order | Adjust after measurement |
| LPF (tactile) | 80 Hz, LR 4th order | Adjust after measurement |
| All PEQ | Flat (0 dB, bypassed) | Set by auto-calibration |
| All Gain | 0 dB (unity) | Trim after calibration |

### Parameter Address Export

After compiling each APM2 project:
1. **Action → Export System Files** → save `.params` file
2. Parse for PEQ base addresses per output
3. Update `tools/dsp/config_1701.json` with actual addresses
4. Each PEQ biquad = 5 consecutive addresses: B0, B1, B2, −A1, −A2 (a1/a2 NEGATED vs scipy)
5. Separate config file per APM2 board if addresses differ

---

## 6. Calibration Procedure

The auto-calibration pipeline (`tools/dsp/`) handles per-output room correction. The workflow for each output:

```
1. Bypass all PEQ bands (flat)
2. Play test signal (Strudel or REW sweep generator)
3. REW captures response (loopback or mic at listening position)
4. Python reads REW measurement via REST API
5. EQ engine computes corrective PEQ filters
6. Python writes biquad coefficients to ADAU1701 via SigmaStudio COM
7. Repeat sweep → measure → refine until converged
8. Save final state to EEPROM for standalone operation
```

**CLI command:**
```bash
python -m tools.dsp correct corner_FL --target-db 85 --freq-range 10,200
```

**Calibration order:**
1. Corner subs first (OUT 1-4) — these are the primary channels
2. Nearfield subs (OUT 5, 7) — secondary, depends on corner sub correction
3. Tactile (OUT 6, 8) — last, lowest priority for flat response

See `/dsp-calibrate` skill for the full step-by-step procedure.

---

## 7. Hardware

### DSP Boards

| Spec | Value |
|------|-------|
| DSP | Analog Devices ADAU1701 (×2 boards) |
| Board | Wondom APM2 (AA-AP23122) — built-in ADC/DAC |
| I/O Extension | **None** — APM3 ditched due to significant crosstalk. Audio I/O via APM2 header pins directly. |
| Analog I/O | 2 inputs, 4 outputs per board (8 outputs total with 2 boards) |
| Sample Rate | 48 kHz |
| Word Length | 28-bit (5.23 fixed-point) |
| Instructions | 1,024 per board |
| Self-boot | EEPROM (I2C) — ground WP pin during writes |
| Programmer | Wondom ICP5 (already owned) |
| Software | SigmaStudio 4.7 (free, already installed) |

### Balanced Output Stage (Required)

The ADAU1701 internal DAC outputs only **0.9 Vrms**. The ICEpower 1200AS2 needs **3.54 Vrms differential** for full power (620W @ 8 ohm). Direct unbalanced connection yields only 38.5W/ch (6.2% utilization) — unacceptable. A balanced output stage with gain is required.

Two options are documented below. Both deliver the same result (balanced ~3.5-4.0 Vrms to ICEpower). Option B is strongly preferred for build simplicity.

---

### Option A: DIY — PCM5102 + THAT1646 (Custom Build)

External PCM5102 DAC (2.1 Vrms) fed via I2S from ADAU1701, into THAT1646 balanced line drivers (2x differential gain) = **4.2 Vrms differential**. Trim DSP gain −1.5 dB → 3.54 Vrms → 620W.

| Component | Function | Key Specs |
|-----------|----------|-----------|
| **PCM5102A** (Adafruit #6250) | External DAC via I2S | 2.1 Vrms output, 112 dB SNR, no MCLK needed (internal PLL) |
| **THAT1646P08-U** (DIP-8) | Balanced line driver | Pin-compatible DRV134 replacement, −101 dBu noise floor, active production |

**Why THAT1646, not DRV134:**
- DRV134PA is **NRND** (not recommended for new designs) — end of life at TI
- Amazon DRV134 units have high counterfeit risk
- THAT1646 is the standard pro-audio replacement: same pinout, better noise (−101 vs −93.4 dBu), graceful clipping

**Voltage chain (Option A):**

| Stage | Voltage | Notes |
|-------|---------|-------|
| X6800H sub pre-out | 2.0 Vrms | RCA unbalanced |
| APM2 ADC input | 2.0 Vrms | No clipping |
| ADAU1701 DSP | Digital (28-bit) | HPF, PEQ, gain |
| I2S to PCM5102 | Digital | 3 wires: BCK, LRCK, DIN |
| PCM5102 DAC output | 2.1 Vrms | Analog, ground-centered |
| THAT1646 output (trimmed −1.5 dB) | **3.54 Vrms differential** | Full power match |
| ICEpower output @ 8 ohm | 70.4 Vrms | **620W** |

**I2S wiring (per APM2):** Each APM2 connects to 2× PCM5102 modules via J4 header:
- MP11 → BCK (shared), MP10 → LRCK (shared)
- MP6 → DIN on PCM5102 #1 (channels 1-2), MP7 → DIN on PCM5102 #2 (channels 3-4)
- **Critical:** ICP5 must be disconnected during operation — it grounds BCLK over I2C, killing I2S output. Use self-boot (EEPROM) mode.

**ICP5 Programmer Switch:** Install a jumper shunt (2-pin header) inline on the ICP5 ribbon cable (BCLK line). Jumper ON = PROGRAM mode (ICP5 connected). Jumper OFF = RUN mode (I2S active). Eliminates risk of forgetting to disconnect the cable.

**Power for THAT1646:** ±15V from ICEpower AVDD/AVSS rails (500 mA each, 15W limit). Two THAT1646 per amp = ~312 mW (2% of limit).

**Power for PCM5102:** 5V from ICEpower DVDD or USB, through module's onboard 3.3V regulator.

**Connection to Amplifiers (Option A):**

```
APM2 #1                PCM5102         THAT1646         ICEpower 1200AS2
I2S OUT0 (ch 1-2) ──→ DAC #1 ──→ BAL board A ──→ P105 (amp 1) ──→ Corner FL + FR subs
I2S OUT1 (ch 3-4) ──→ DAC #2 ──→ BAL board B ──→ P105 (amp 3) ──→ Front shakers + spare

APM2 #2
I2S OUT0 (ch 1-2) ──→ DAC #3 ──→ BAL board C ──→ P105 (amp 2) ──→ Corner RL + RR subs
I2S OUT1 (ch 3-4) ──→ DAC #4 ──→ BAL board D ──→ P105 (amp 4) ──→ Rear shakers + spare
```

**Option A cost:** $155 (4× PCM5102 $20 + 8× THAT1646 $55 + passives $45 + caps $15 + 20 pcs spare $20)
**Option A build:** 4 perfboards, 8 DIP-8 ICs, I2S wiring, parasitic power tapping. ~15 hours.

---

### Option B: Sonic Imagery Labs 898B (Retail Unit) — PREFERRED

Use the ADAU1701 internal DAC outputs (0.9 Vrms, 4 outputs per board) directly into a Sonic Imagery Labs Model 898B 8-channel unbalanced-to-balanced converter. The 898B provides +12 dB gain and balanced XLR output in a single 1RU rack unit.

**This eliminates ALL custom analog construction** — no PCM5102 DACs, no THAT1646 boards, no I2S wiring, no perfboard, no parasitic power tapping.

| Component | Function | Key Specs |
|-----------|----------|-----------|
| **Sonic Imagery Labs 898B** | 8-ch unbal→bal converter + gain | RCA in, XLR out, +12 dB fixed gain, +23 dBu max output, 1RU rack |

**Voltage chain (Option B):**

| Stage | Voltage | Notes |
|-------|---------|-------|
| X6800H sub pre-out | 2.0 Vrms | RCA unbalanced |
| APM2 ADC input | 2.0 Vrms | No clipping |
| ADAU1701 DSP | Digital (28-bit) | HPF, PEQ, gain |
| APM2 internal DAC output | 0.9 Vrms | 4 outputs per board, RCA |
| 898B (+12 dB, balanced) | **~3.6 Vrms differential** | Within 2% of 3.54 Vrms target |
| ICEpower output @ 8 ohm | ~69.2 Vrms | **~599W** (99.7% of rated) |

**Connection to Amplifiers (Option B):**

```
APM2 #1                        Sonic Imagery 898B              ICEpower 1200AS2
DAC OUT 1 (Corner FL) ── RCA ──→ Ch 1 In ──→ Ch 1 XLR ──→ P105 (amp 1, ch A)
DAC OUT 2 (Corner FR) ── RCA ──→ Ch 2 In ──→ Ch 2 XLR ──→ P105 (amp 1, ch B)
DAC OUT 3 (NF Front)  ── RCA ──→ Ch 3 In ──→ Ch 3 XLR ──→ P105 (amp 3, ch A)
DAC OUT 4 (Tac Front) ── RCA ──→ Ch 4 In ──→ Ch 4 XLR ──→ P105 (amp 3, ch B)

APM2 #2
DAC OUT 1 (Corner RL) ── RCA ──→ Ch 5 In ──→ Ch 5 XLR ──→ P105 (amp 2, ch A)
DAC OUT 2 (Corner RR) ── RCA ──→ Ch 6 In ──→ Ch 6 XLR ──→ P105 (amp 2, ch B)
DAC OUT 3 (NF Rear)   ── RCA ──→ Ch 7 In ──→ Ch 7 XLR ──→ P105 (amp 4, ch A)
DAC OUT 4 (Tac Rear)  ── RCA ──→ Ch 8 In ──→ Ch 8 XLR ──→ P105 (amp 4, ch B)
```

**Option B cost:** $389 (898B) + XLR-to-JST adapter cables (~$30) = **~$419**
**Option B build:** Zero custom analog. RCA cables from APM2 to 898B, XLR-to-JST from 898B to ICEpower P105.

**No ICP5 switch needed with Option B.** Since audio uses the internal DAC (not I2S), the ICP5 does not interfere with audio output. The programmer can remain connected at all times, enabling live calibration without any cable/switch management.

**Risk:** The APM2's internal DAC analog output quality is unproven — the board is cheap and may have noise or poor analog layout. However, for subwoofer frequencies (5-200 Hz), DAC performance requirements are less demanding than full-range audio. The Phase 2 bench test will validate this.

---

### Option A vs Option B Comparison

| | Option A (DIY) | Option B (898B) |
|---|---|---|
| **Cost** | $155 | $419 |
| **Build effort** | ~15 hours (perfboard, soldering, I2S) | ~1 hour (cables) |
| **Custom modules** | 10 (4 DAC + 4 balanced + 2 DSP) | 2 (2 DSP boards only) |
| **I2S wiring** | Yes (4 connections per board) | None |
| **Perfboard soldering** | Yes (8× THAT1646 DIP-8) | None |
| **Parasitic power tapping** | Yes (±15V from ICEpower) | None |
| **ICP5 switch/jumper** | Required | Not needed |
| **Failure points** | Many (solder joints, I2S, power) | Few (RCA + XLR cables) |
| **Troubleshooting** | Debug custom analog chain | Swap cables |
| **Output voltage** | 3.54 Vrms (trimmed) | ~3.6 Vrms |
| **Amp power** | 620W | ~599W |
| **Rack space** | None (in chassis) | 1RU |
| **DAC quality** | PCM5102 (112 dB SNR, proven) | APM2 internal (unproven, adequate for subs) |

**Recommendation:** Option B. The $264 premium eliminates all custom analog construction, removes the ICP5 switch requirement, and reduces failure points from ~50 solder joints to zero. The APM2 internal DAC risk is low for subwoofer frequencies and will be validated during Phase 2 bench testing.

---

### ICEpower P105 Connector (Both Options)

**ICEpower P105 connector:** JST B6B-PH-K-S (6-pin, 2mm pitch). Mating housing: JST PHR-6.

| P105 Pin | Signal | Option A (THAT1646) | Option B (898B XLR) |
|----------|--------|---------------------|---------------------|
| 1 | IN1+ (HOT) | THAT1646 OUT+ via 10 µF cap | XLR pin 2 (hot) |
| 2 | IN1− (COLD) | THAT1646 OUT− via 10 µF cap | XLR pin 3 (cold) |
| 3 | AGND | THAT1646 GND | XLR pin 1 (ground) |
| 4 | IN2+ (HOT) | THAT1646 OUT+ via 10 µF cap | XLR pin 2 (hot) |
| 5 | IN2− (COLD) | THAT1646 OUT− via 10 µF cap | XLR pin 3 (cold) |
| 6 | AGND | THAT1646 GND | XLR pin 1 (ground) |

**IMPORTANT:** Verify P105 pinout against ICEpower 1200AS2 datasheet (v1.7, page 8) before wiring.

---

## 8. Why ADAU1701 Over DSP-408

| Limitation | DSP-408 | ADAU1701 (×2) |
|-----------|---------|----------|
| **Minimum HPF/LPF** | 20 Hz | Any frequency (including 5 Hz, 10 Hz) |
| **Minimum PEQ** | 20 Hz | Any frequency |
| **Automated calibration** | Manual only | Python + REW auto-correction pipeline |
| **Inputs/Outputs** | 4-in/8-out | 4-in/8-out (2 boards × 2-in/4-out) |
| **PEQ bands** | 10/ch | 10/ch (same, could add more) |
| **Cost (DSP only)** | ~$250 | ~$120 (2× APM2 + 1 owned) |
| **Cost (with balanced output)** | N/A | ~$255 total (DSP + PCM5102 + THAT1646) |
| **Balanced output** | No | Yes — THAT1646, unlocks full amp power |
| **Summing** | External or input matrix | Internal (DSP mixer blocks) |
| **Integration** | Standalone box | Calibration pipeline, Python + COM control |

The DSP-408's 20 Hz floor is the primary driver for this change. Subsonic protection at 5 Hz and tactile HPF at 10 Hz are impossible on the DSP-408. The balanced output path also unlocks the full 620W/ch from the ICEpower amps, vs 38.5W with direct unbalanced connection.

---

## 9. Bill of Materials

### Option B BOM (Preferred — 898B)

| # | Item | Source | Qty | Unit $ | Total | Notes |
|---|------|--------|-----|--------|-------|-------|
| 1 | Wondom APM2 (ADAU1701) | Sure Electronics | 2 | $40 | $80 | 1 owned, 2 to order |
| 2 | Sonic Imagery Labs 898B | sonicimagerylabs.com | 1 | $389 | $389 | 8-ch unbal→bal, +12 dB, 1RU |
| 3 | RCA cables (APM2 → 898B) | Amazon | 8 | $3 | $24 | Short patch cables |
| 4 | XLR-to-JST P105 adapter cables | DIY | 4 | $8 | $32 | XLR female → JST PHR-6 |
| | **Total (Option B)** | | | | **$525** | |

### Option A BOM (Fallback — DIY THAT1646)

| # | Item | Source | Qty | Unit $ | Total | Notes |
|---|------|--------|-----|--------|-------|-------|
| 1 | Wondom APM2 (ADAU1701) | Sure Electronics | 2 | $40 | $80 | 1 owned, 2 to order |
| 2 | THAT1646P08-U (DIP-8) | DigiKey/Mouser | 10 | $5.50 | $55 | 8 needed + 2 spares |
| 3 | WIMA MKS2 2.2µF 63V | DigiKey/Mouser | 10 | $1.50 | $15 | Input coupling caps |
| 4 | PCM5102 I2S DAC | Adafruit #6250 | 4 | $4.95 | $20 | 2 per APM2 board |
| 5 | Passives + connectors | Amazon | — | — | $45 | Caps, sockets, perfboard, JST, jumpers |
| | **Total (Option A)** | | | | **$215** | |

**Do NOT buy DRV134PA from Amazon** — NRND, high counterfeit risk. **Do NOT buy WIMA caps from Amazon** — documented counterfeits. Use DigiKey/Mouser for ICs and precision caps.

### Already Owned

| Item | Status |
|------|--------|
| Wondom APM2 (×1) | On hand |
| ICP5 programmer | On hand |
| SigmaStudio 4.7 | Installed |
| MOTU M2, UMIK-1, REW 5.40 | On hand |

### Cost Summary

| Path | DSP | Balanced Output | Total |
|------|-----|----------------|-------|
| **Option B (898B)** | $80 (2× APM2) | $445 (898B + cables) | **$525** |
| Option A (DIY) | $80 (2× APM2) | $135 (THAT1646 + PCM5102 + passives) | **$215** |

---

## 10. Implementation Path

### Phase 1: ADAU1701 Bench Validation (Current)
- Prove calibration pipeline end-to-end on single APM2 (2-in/4-out)
- Verify biquad math, COM transport, REW integration
- Board stack: ICP5 (top) → 6-pin ribbon → APM2 (bottom). No APM3.
- Audio I/O via APM2 header pins directly (APM3 ditched — crosstalk)

### Phase 2: Balanced Output Validation
- **Option B (preferred):** Connect APM2 internal DAC → 898B → ICEpower P105 (via dummy load)
- **Option A (fallback):** Build one 2-channel THAT1646 board ($19, 1 hour), connect APM2 I2S → PCM5102 → THAT1646 → ICEpower P105
- Measure with REW: confirm ~3.5 Vrms differential, flat 5-120 Hz
- **Pass/fail criteria:**
  - Noise floor: < −90 dBFS
  - THD: < −80 dB at 20 Hz, 50 Hz, 80 Hz
  - Frequency response: ±0.5 dB from 5 Hz to 200 Hz
  - No audible hum from power arrangement
- If Option B APM2 internal DAC is too noisy, fall back to Option A (external PCM5102 + THAT1646)

### Phase 3: Full Build
- **Option B:** Order 898B + 2 more APM2 boards. Build XLR-to-JST adapter cables. Done.
- **Option A:** Order 2 more APM2 boards. Build 4× THAT1646 boards (8 channels). Wire 4× PCM5102 modules (I2S). Install ICP5 jumper switch.
- Run calibration on each output channel

### Phase 4: Install
- Mount in equipment rack (898B takes 1RU)
- Connect X6800H sub outputs → APM2 inputs (RCA)
- **Option B:** APM2 DAC out → 898B (RCA) → ICEpower P105 (XLR-to-JST)
- **Option A:** APM2 I2S → PCM5102 → THAT1646 → ICEpower P105 (JST)
- Save calibration to EEPROM
- DSP runs standalone — no PC needed after calibration
- **Option B:** ICP5 can remain connected (no I2S conflict)
- **Option A:** Remove ICP5 jumper for RUN mode

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-04 | Initial POR — single ADAU1452 replaces DSP-408 for all sub/nearfield/tactile |
| 2.0 | 2026-03-18 | Major revision: ADAU1452 → 2× ADAU1701 (APM2). APM3 removed (crosstalk). Balanced output now POR via THAT1646 + PCM5102 (not optional). DRV134 replaced by THAT1646 (NRND/counterfeit risk). Full BOM with sourcing ($215 total). Voltage chain documented end-to-end. Implementation phases updated. |
| 2.1 | 2026-03-19 | ICP5 programmer jumper added. POR/06 and budget doc updated to match ADAU1701 + ICEpower (removed stale DSP-408 / NX6000D / ADAU1452 references). Team evaluation confirmed ADAU1701 over miniDSP Flex HTx ($949). Added Option B: Sonic Imagery Labs 898B ($389) as preferred balanced output path — eliminates all custom analog (no PCM5102, no THAT1646, no I2S wiring, no perfboard). Option A (DIY THAT1646) retained as fallback. |
