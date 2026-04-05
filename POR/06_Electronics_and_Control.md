# Electronics & Control
## Home Theater System - Rev 7.0

**Document Purpose:** AV processor, amplification, signal flow, and calibration.

**Last Updated:** March 10, 2026 — Rev 7.0: Denon AVR-A1H replaces Marantz AV10 + Buckeye separates

---

## Processor & Speaker Amplification

### Denon AVR-A1H (Unified Processor/Amplifier)

The AVR-A1H serves as both the AV processor and speaker amplifier for all 15 channels, eliminating the need for separate Buckeye amplifiers.

| Parameter | Value |
|-----------|-------|
| **Model** | Denon AVR-A1H |
| **MSRP** | ~$6,500 |
| **Channels** | 15.4 processing, 15 channels amplification |
| **Configuration** | 9.4.6 Dolby Atmos |
| **Power** | 150W × 15 @ 8Ω (2ch driven, 20-20kHz, 0.05% THD) |
| **All-channels-driven** | ~105W @ 8Ω (estimated) |
| **Into 4Ω** | ~200W (estimated, current-capable design) |
| **Subwoofer outputs** | 4 independent (RCA + XLR) |
| **Pre-outs** | 17.4ch (XLR + RCA) — growth path for external amps |
| **Room correction** | Audyssey MultEQ XT32 (included); Dirac Live (license required) |
| **HDMI** | 2.1 (7 in / 3 out), 8K/60Hz, 4K/120Hz |
| **DAC** | 10× ESS Sabre ES9018K2M (paired channels) |
| **Weight** | 70.5 lbs |
| **Location** | Equipment rack on front stage |

### Dirac Live Licensing (Required Additions)

The AVR-A1H ships with Audyssey but requires separate Dirac Live licenses:

| License | Cost | Function |
|---------|------|----------|
| Dirac Live Room Correction (Full Bandwidth) | $349 | Full-range room correction |
| Dirac Live Bass Control | $299 | Multi-sub optimization |
| Dirac Live ART | $299 | Active Room Treatment |
| **Bundle (all three)** | **$799** | Recommended — purchase together |

**Total AVR + Dirac: ~$7,300**

### Target Level: -10 dB Reference (95 dB)

All speaker channels are designed to reach 95 dB at the main listening position with substantial headroom. Full THX Reference (105 dB) is not targeted but the AVR-A1H's pre-outs allow adding external LCR amplification if ever desired.

### Why AVR-A1H Over Marantz AV10 + Buckeye Separates

| Factor | AVR-A1H | AV10 + Buckeye | Winner |
|--------|---------|----------------|--------|
| Cost | ~$7,300 (incl. Dirac) | ~$10,500 | AVR-A1H (-$3,200) |
| Complexity | 1 device (15ch) | 3 devices (processor + 2 amps) | AVR-A1H |
| Channel count | 15.4 | 15.4 | Tie |
| Sub outputs | 4 independent | 4 independent | Tie |
| Dirac ART | Yes (license) | Yes (license) | Tie |
| Power @ -10 dB target | +7 dB headroom (LCR) | +11 dB headroom (LCR) | AV10 (but overkill) |
| Pre-outs for growth | 17.4ch XLR + RCA | N/A (already separate) | AVR-A1H |
| Rack space | 1 unit | 3 units | AVR-A1H |
| HDMI 2.1 | Native | Native | Tie |

**Key Insight:** At the -10 dB reference target, the AVR-A1H's internal amplification provides 7+ dB headroom on every channel. The extra power of Buckeye separates is unnecessary for this target level.

> **Note:** The StormAudio ISP Elite MK3 24-channel processor remains an open consideration for professional consultation. If individual driver-level bass control proves necessary, that path is still available. The AVR-A1H decision does not preclude future processor upgrades — it can be repurposed as a secondary zone receiver.

---

## Subwoofer & Bass Amplification

### ICEpower 1200AS2 Platform (Option D)

Corner sub amplification uses ICEpower 1200AS2 modules on 240V with individual driver wiring at 4Ω. Fanless, no infrasonic derating, 1,200W/ch @ 4Ω with balanced input. Each driver gets its own amp channel — amp headroom is 58% at driver Xmax (700W @ 20Hz), ensuring the driver is always the limiter, not the amplifier. Tactile uses existing NX6000D spare.

| System | Amp | Channels | Load | Power/Ch |
|--------|-----|----------|------|----------|
| Corner sub FL (top + bottom) | #1 | 2 | 4Ω each | 1,200W |
| Corner sub FR (top + bottom) | #2 | 2 | 4Ω each | 1,200W |
| Corner sub RL (top + bottom) | #3 | 2 | 4Ω each | 1,200W |
| Corner sub RR (top + bottom) | #4 | 2 | 4Ω each | 1,200W |
| Tactile (bass shakers) | NX6000D (owned) | 2 | varies | ~850W |

**Driver wiring:** Each driver's dual 2Ω voice coils wired in series = 4Ω per driver. Each driver on its own amp channel — no series pairs.

**Cost:**

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| ICEpower 1200AS2 | 4 | $373 | $1,492 |
| Rack chassis (Bud CH-14404) | 1 | $100 | $100 |
| **Total** | | | **$1,592** |

All 4 modules in a single 2U rack chassis in equipment closet. Fanless. 240V native (single 20A/240V circuit). NX6000D on separate 120V circuit.

---

## Bass Management DSP

### 2× ADAU1701 (APM2) + Balanced Output Stage (Option D)

| Spec | Value |
|------|-------|
| **DSP** | 2× Wondom APM2 (ADAU1701), 2-in/4-out each |
| **Inputs** | 4 (from AVR sub outputs, RCA) |
| **Outputs** | 8 (balanced, via PCM5102 DAC + THAT1646 line drivers) |
| **Functions** | HPF to DC (5 Hz), PEQ ×10/ch, gain, mono summing |
| **Output voltage** | 3.54 Vrms differential → 1,200W/ch from ICEpower @ 4Ω |
| **Calibration** | Automated: Python → SigmaStudio COM → DSP → REW closed loop |
| **Self-boot** | EEPROM — no PC required after calibration |
| **Balanced output** | Sonic Imagery Labs 898B (8-ch, +12 dB, RCA→XLR, 1RU) — preferred; DIY THAT1646 as fallback |
| **Cost** | $525 (Option B: 898B) / $215 (Option A: DIY THAT1646) |

Option B (898B) uses the ADAU1701 internal DAC outputs directly into the 898B — no external DACs, no I2S wiring, no perfboard, no ICP5 switch needed. Option A (DIY) uses external PCM5102 DACs via I2S and custom THAT1646 balanced driver boards.

Full details: POR/15_DSP_Subwoofer_Processing.md

---

## Signal Flow

```
Sources → Denon AVR-X6800H (Dirac ART processing, 13.4ch)
              ↓                    ↓                    ↓
    Pre-Outs (5ch)        Speaker Outputs (8ch)   4× Sub Pre-Outs
         ↓                 direct to speakers            ↓
    ATI AT525NC                    ↓              2× ADAU1701 (APM2)
    (5ch NCore)           ┌────────┼────────┐    + PCM5102 + THAT1646
         ↓                ↓        ↓        ↓     (balanced output)
    ┌────┼────┐         Surr(4)  Heights(4)  ↓          ↓
    ↓    ↓    ↓          Volt-10  Volt-10  Corner    Tactile
   LCR   FW                                Subs     (Shakers)
  Titan  Volt-10                          (1200AS2   (NX6000D
 -815LX                                   #1-4)      spare)
                                             ↓          ↓
                                          8 drvrs    8 shkrs
                                          (4Ω each)  (owned)
```

### Signal Path Details

**Source → AVR-X6800H:**
- HDMI inputs from sources (Blu-ray, streaming, gaming)
- Video: Passed through to projector (HDMI 2.1, 4K/120Hz capable)
- Audio: Decoded to 9.4.6 channels
- Dirac Live: Full-range correction for all channels
- Dirac Bass Control: Multi-sub optimization (4 independent outputs)
- Dirac ART: Active room treatment
- Amplification: 8 surround/Atmos channels driven internally; LCR + FW via ATI AT525NC

**AVR-X6800H Sub Outputs → ADAU1701 (APM2):**
- 4 discrete sub feeds from AVR sub pre-outs (RCA, 2.0 Vrms)
- 2× APM2 boards (2-in/4-out each) — 8 outputs total
- Processing: HPF (5 Hz), PEQ ×10/ch, gain, mono summing for derived channels
- I2S output → PCM5102 external DAC → THAT1646 balanced line driver
- 3.54 Vrms differential output → ICEpower 1200AS2 at full 1,200W/ch @ 4Ω
- Automated calibration via Python + REW + SigmaStudio COM pipeline

**ADAU1701 → ICEpower 1200AS2 → Drivers:**
- Balanced connection via JST PH to ICEpower P105 input
- Individual 4Ω driver wiring per amp channel (corner subs, 1 driver per channel)
- Tactile channels via NX6000D (existing spare, 120V)

---

## Electrical Power Distribution

### Rev 7.0 Simplification

The AVR-A1H eliminates the Buckeye amplifiers, reducing circuit requirements.

### Equipment Power Summary

| Component | Qty | Idle (each) | Peak (each) |
|-----------|-----|-------------|-------------|
| Denon AVR-X6800H | 1 | ~80W | ~600W |
| ATI AT525NC | 1 | ~50W | ~500W |
| ICEpower 1200AS2 | 4 | ~35W | ~650W |
| Behringer NX6000D (tactile) | 1 | ~30W | ~400W |
| ADAU1701 (APM2) + DAC + balanced | 2 | ~2W | ~3W |
| Source devices | 1 | 20W | 200W |

### Circuit Distribution

**2× Dedicated Circuits Required**

```
┌─────────────────────────────────────────────────────────────────────┐
│              CIRCUIT A - Sub Amps (20A / 240V)                      │
├─────────────────────────────────────────────────────────────────────┤
│  ICEpower 1200AS2 #1 (Corner FL)       Idle: 35W    Peak: 650W     │
│  ICEpower 1200AS2 #2 (Corner FR)       Idle: 35W    Peak: 650W     │
│  ICEpower 1200AS2 #3 (Corner RL)       Idle: 35W    Peak: 650W     │
│  ICEpower 1200AS2 #4 (Corner RR)       Idle: 35W    Peak: 650W     │
├─────────────────────────────────────────────────────────────────────┤
│  Circuit A Total                  Idle: 140W   Peak: 2,600W    ✓   │
│  Note: Single 240V circuit, ICEpower PFC native 240V                │
│                                                                      │
│              CIRCUIT B - Tactile Amp (20A / 120V)                   │
├─────────────────────────────────────────────────────────────────────┤
│  Behringer NX6000D (Tactile)           Idle: 30W    Peak: 400W     │
│  Note: Existing spare, no additional cost                            │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│              CIRCUIT C - Processor + Amps + DSP (20A / 120V)        │
├─────────────────────────────────────────────────────────────────────┤
│  Denon AVR-X6800H                 Idle: 80W    Peak: 600W          │
│  ATI AT525NC                      Idle: 50W    Peak: 500W          │
│  ADAU1701 (2× APM2 + DAC)        Idle: 4W     Peak: 6W            │
│  Source devices                   Idle: 20W    Peak: 200W          │
├─────────────────────────────────────────────────────────────────────┤
│  Circuit C Total                  Idle: 154W   Peak: 1,306W    ✓   │
└─────────────────────────────────────────────────────────────────────┘
```

**Note:** Dedicated 100A subpanel provides ample headroom. ICEpower 1200AS2 runs natively on 240V — single circuit for all sub amps. Fanless operation, no Noctua fan mods needed (unlike NX6000D).

### Projector

| Spec | Value |
|------|-------|
| Budget | $30,000 |
| Type | 4K/8K Laser (model TBD) |
| Power | ~450W typical |
| Selection | Deferred to 2027 |
| Circuit | Dedicated (not included in above) |

---

## Cost Summary — Electronics & Control

| Item | Rev 7.0 (POR) | Option D | Notes |
|------|---------------|----------|-------|
| Denon AVR-X6800H | — | $3,700 | Replaces AVR-A1H |
| ATI AT525NC | — | $0 | Owned |
| Dirac Live bundle | $799 | $799 | |
| ICEpower 1200AS2 (4 units + chassis) | — | $1,592 | Replaces NX6000D; tactile on existing NX6000D |
| ADAU1701 DSP + balanced output | — | $215 | Replaces DSP-408 |
| **Total** | — | **$6,306** | |

---

**Document Version:** 4.0 (Option D)
**Created:** November 22, 2025
**Updated:** March 26, 2026 — Individual 4Ω driver wiring (1 channel per driver, 8 channels total); 4× 1200AS2 (was 5); tactile moved to existing NX6000D spare; single Bud CH-14404 rack chassis; amp headroom 58% at driver Xmax
