# DIY 4-in/8-out DSP Design Document
## Production-Grade Bass Management Processor

**Document Version:** 1.0  
**Created:** January 4, 2026  
**Purpose:** Design specification for custom DSP to replace Dayton DSP-408  
**Application:** Post-Dirac bass management for nearfield subwoofers and tactile transducers

---

## Executive Summary

This document specifies a 4-input, 8-output DSP processor designed to overcome the limitations of commercial units (Dayton DSP-408, miniDSP) for home theater bass management. The key advantages:

1. **No artificial frequency limits** - filters to DC (vs. 20Hz minimum on Dayton)
2. **Full transfer function visibility** - actual biquad coefficients, not opaque GUI knobs
3. **Infrasonic capability** - essential for tactile transducers operating at 10-15Hz
4. **REW integration** - import measurement-based correction filters directly
5. **Self-boot operation** - embedded EEPROM stores configuration, no computer required

---

## System Requirements

### Signal Flow Context

```
Marantz AV10 (post-Dirac ART)
    ↓
4× Sub Outputs (analog, line-level)
    ↓
┌─────────────────────────────┐
│   DIY DSP (this design)     │
│   4 IN → 8 OUT              │
└─────────────────────────────┘
    ↓
8× Outputs routed to:
  • Front nearfield subs (2 ch)
  • Rear nearfield subs (2 ch)  
  • Main corner subs (2 ch)
  • Tactile transducers (2 ch)
```

### Functional Requirements

| Requirement | Specification |
|-------------|---------------|
| Analog Inputs | 4 minimum |
| Analog Outputs | 8 minimum |
| Sample Rate | 48/96 kHz (96kHz preferred for better filter resolution) |
| Bit Depth | 24-bit |
| Filter Frequency Range | **DC to 20kHz** (no artificial floor) |
| HPF Capability | 5Hz-100Hz, any slope (6-48 dB/oct) |
| PEQ per Channel | 10+ biquad sections |
| Delay per Channel | 0-50ms, 0.01ms resolution |
| Level per Channel | -60dB to +12dB, 0.1dB steps |
| Matrix Mixing | Full 4×8 matrix |
| Self-Boot | Yes - EEPROM stores configuration |
| Programming Interface | SigmaStudio via USBi/I2C |

---

## Hardware Architecture

### Core Components

```
┌──────────────────────────────────────────────────────────────────┐
│                         SYSTEM BLOCK DIAGRAM                      │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│   4× RCA IN                                                       │
│       │                                                           │
│       ▼                                                           │
│  ┌─────────────┐      ┌─────────────┐      ┌─────────────┐       │
│  │   INPUT     │      │    ADC      │      │  ANTI-ALIAS │       │
│  │  BUFFERS    │─────▶│  CS42448    │◀─────│   FILTERS   │       │
│  │  (OPA1641)  │      │  (6 ch)     │      │  (passive)  │       │
│  └─────────────┘      └──────┬──────┘      └─────────────┘       │
│                              │ I2S/TDM                            │
│                              ▼                                    │
│                       ┌─────────────┐                             │
│                       │  ADAU1452   │                             │
│                       │   or 1466   │◀───── EEPROM (self-boot)   │
│                       │    DSP      │                             │
│                       └──────┬──────┘                             │
│                              │ I2S/TDM                            │
│                              ▼                                    │
│  ┌─────────────┐      ┌─────────────┐      ┌─────────────┐       │
│  │   OUTPUT    │      │    DAC      │      │   RECON     │       │
│  │  BUFFERS    │◀─────│  CS42448    │─────▶│   FILTERS   │       │
│  │  (OPA1641)  │      │  (8 ch)     │      │  (passive)  │       │
│  └──────┬──────┘      └─────────────┘      └─────────────┘       │
│         │                                                         │
│         ▼                                                         │
│   8× RCA OUT                                                      │
│                                                                   │
└──────────────────────────────────────────────────────────────────┘
```

### Component Selection

#### DSP: ADAU1452 or ADAU1466

| Parameter | ADAU1452 | ADAU1466 |
|-----------|----------|----------|
| Sample Rate | Up to 192kHz | Up to 192kHz |
| Bit Depth | 24-bit, 28-bit internal | 24-bit, 28-bit internal |
| Program Memory | 8192 words | 16384 words |
| Data Memory | 5120 words | 10240 words |
| Serial Ports | 4× I2S/TDM | 4× I2S/TDM |
| ASRC | 4× stereo | 4× stereo |
| GPIO | 12 | 12 |
| Power | ~250mW typical | ~250mW typical |
| Package | 72-LFCSP | 72-LFCSP |

**Recommendation:** ADAU1466 - 2× memory for complex filter chains, ~$4 more

**Verified Specifications (Analog Devices Datasheet):**
- THD+N: -100dB typical @ 1kHz
- Dynamic Range: 118dB (A-weighted)
- Latency: ~1ms at 48kHz (fixed pipeline)

#### Codec: CS42448

The Cirrus Logic CS42448 is a highly integrated 24-bit audio codec.

**Verified Specifications (Cirrus Logic Datasheet):**

| Parameter | ADC | DAC |
|-----------|-----|-----|
| Channels | 6 | 8 |
| Resolution | 24-bit | 24-bit |
| Dynamic Range | 105dB (differential) / 102dB (single-ended) | 108dB (differential) / 105dB (single-ended) |
| THD+N | -95dB | -100dB |
| Max Sample Rate | 192kHz | 192kHz |
| SNR | 105dB | 108dB |

**Source Verification:**
1. Cirrus Logic CS42448 Product Page: https://www.cirrus.com/products/cs42448
2. Mouser Datasheet: CS42448_F4-275685.pdf - confirms "108 dB, 192 kHz 6-In, 8-Out CODEC"

**Why CS42448:**
- Perfect match for 4-in/8-out requirement (6 ADC, 8 DAC - headroom for expansion)
- Industry-standard codec used in automotive and home theater
- Single chip solution (vs. separate ADC + DAC)
- Popguard® technology eliminates power-cycling transients
- Same codec used in proven Chinese ADAU1452 boards

#### Known Limitation (from diyAudio forums):
> "adau1452/CS42448 combo have difficulty with 192kHz because of the CS42448 card... ADC struggles with 192k"

**Recommendation:** Run at 96kHz for reliable operation and excellent audio quality

---

## Available Hardware Platforms

### Option A: Chinese ADAU1452 + CS42448 Board (Recommended)

Pre-assembled board from AliExpress/eBay vendors (Nvarcher, Deyin Audio Store).

| Source | Configuration | Price | Notes |
|--------|---------------|-------|-------|
| AliExpress | ADAU1452 + CS42448 | ~$45-60 | 6-in/8-out, proven platform |
| Amazon | ADAU1466 + 2×CS42448 | ~$80-100 | 14-in/18-out, overkill but works |
| eBay | ADAU1452 + CS42448 + USBi | ~$55-70 | Includes programmer |

**Amazon Verified Listings:**
- ASIN: B0F4W9RM67 - "ADAU1466/ADAU1452+CS42448 14 in and 18 Out DSP Audio Decoding Module"
- ASIN: B0F7R9KTQC - "6 inputs and 8 outputs decoding Board ADAU1452 DSP CS42448"

**diyAudio Consensus (Page 28, "low cost ADAU1452 China board" thread):**
> "These boards work but they have skimped on components... The caps distort on input and output stage of CS42448 board... nvarcher call them educational boards"

**Recommendation:** Buy Chinese board for prototyping, upgrade analog stages for production

### Option B: Custom PCB Design

For true production quality, design custom board with:
- Improved analog input/output stages
- Rail-to-rail op-amps (OPA1641 or similar)
- Better power supply filtering
- Proper differential signal routing
- Panel-mount RCA/XLR connectors

**Estimated PCB Cost:**
- PCB fabrication (JLCPCB): ~$15-30 for 5 boards
- Components (BOM): ~$80-120 per board
- Assembly (self): ~$0
- Total per unit: ~$100-150

### Option C: ohdsp Open Source Design

GitHub repository with KiCad files: https://github.com/ohdsp/uDSP

| Feature | Specification |
|---------|---------------|
| DSP Support | ADAU1450/1451/1452/1462/1466 |
| I/O | 4× I2S input, 4× I2S output connectors |
| Digital I/O | S/PDIF optical (TX/RX) |
| Self-Boot | EEPROM included |
| Programming | SPI connector for USBi adapter |
| Files | Complete KiCad + Gerbers + BOM |

**Advantage:** Documented open-source design, can modify as needed

---

## Programmer Selection

### Required: USBi-Compatible Interface

| Option | Price | Source | Notes |
|--------|-------|--------|-------|
| EVAL-ADUSB2EBZ | ~$95 | Analog Devices/Mouser | Official, guaranteed compatibility |
| Wondom ICP5 | ~$35 | Amazon B0CBP9YHYZ | Works with SPI, PC UI, BLE app |
| TinySine USBi | ~$25 | Amazon B0CF8Z53DR | Plug-and-play, ADAU1701/1452 compatible |
| CY7C68013A + freeUSBi | ~$8 | AliExpress | Cheapest, requires driver setup |

**Verified from our previous research:**
> "The ICP5 programmer will also work with the ADAU1452/1466 boards when you scale up"

**Recommendation:** TinySine USBi (~$25) - already validated in your ADAU1701 learning setup, confirmed working with ADAU1452

---

## Production Design Specification

### Bill of Materials (Production Unit)

| Component | Part Number | Qty | Unit Cost | Total | Source |
|-----------|-------------|-----|-----------|-------|--------|
| **Core DSP Board** |||||
| ADAU1466 + CS42448 board | Generic Chinese | 1 | $60 | $60 | AliExpress |
| **Analog Stage Upgrades** |||||
| OPA1641 (input buffers) | OPA1641AIDR | 4 | $3.50 | $14 | Mouser |
| OPA1641 (output buffers) | OPA1641AIDR | 8 | $3.50 | $28 | Mouser |
| Input capacitors (film) | WIMA MKS2 1uF 50V | 4 | $0.80 | $3.20 | Mouser |
| Output capacitors (film) | WIMA MKS2 1uF 50V | 8 | $0.80 | $6.40 | Mouser |
| **I/O Connectors** |||||
| RCA panel-mount (gold) | Neutrik NYS367 | 12 | $2.50 | $30 | Parts Express |
| **Enclosure** |||||
| Hammond 1455N1601BK | 160×103×53mm | 1 | $28 | $28 | Mouser |
| **Power Supply** |||||
| 6V 2A wall adapter | Generic | 1 | $10 | $10 | Amazon |
| DC jack panel mount | 2.1mm | 1 | $1.50 | $1.50 | — |
| **Programmer** |||||
| TinySine USBi | — | 1 | $25 | $25 | Amazon |
| **Misc** |||||
| Standoffs, screws, wire | — | — | $10 | $10 | — |
| **TOTAL** | | | | **~$216** | |

### Simplified BOM (Educational/Prototype)

| Component | Price | Source |
|-----------|-------|--------|
| ADAU1452 + CS42448 board | $55 | AliExpress/eBay |
| USBi Programmer | $25 | Amazon |
| 6V 2A power supply | $10 | Amazon |
| RCA cables | $10 | Existing |
| **TOTAL** | **~$100** | |

---

## SigmaStudio Configuration

### DSP Block Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SIGMASTUIO PROJECT LAYOUT                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  INPUT STAGE (4 channels from Marantz AV10)                                 │
│  ┌───────────────────────────────────────────────────────────────┐          │
│  │ IN1 ──▶ [HPF 5Hz] ──▶ [PEQ 10-band] ──▶ [Delay] ──▶ [Gain] ──│──┐       │
│  │ IN2 ──▶ [HPF 5Hz] ──▶ [PEQ 10-band] ──▶ [Delay] ──▶ [Gain] ──│──│       │
│  │ IN3 ──▶ [HPF 5Hz] ──▶ [PEQ 10-band] ──▶ [Delay] ──▶ [Gain] ──│──│       │
│  │ IN4 ──▶ [HPF 5Hz] ──▶ [PEQ 10-band] ──▶ [Delay] ──▶ [Gain] ──│──│       │
│  └───────────────────────────────────────────────────────────────┘  │       │
│                                                                     │       │
│  ROUTING MATRIX (4×8)                                               │       │
│  ┌───────────────────────────────────────────────────────────────┐  │       │
│  │                                                               │◀─┘       │
│  │   ┌─────────────────────────────────────────────────────┐    │          │
│  │   │              4×8 MATRIX MIXER                       │    │          │
│  │   │   (enables any input to any combination of outputs) │    │          │
│  │   └─────────────────────────────────────────────────────┘    │          │
│  │                                                               │          │
│  └───────────────────────────────────────────────────────────────┘          │
│                              │                                              │
│  OUTPUT STAGE (8 channels to amplifiers)                                    │
│  ┌───────────────────────────────────────────────────────────────┐          │
│  │ OUT1 (Front Nearfield L) ◀── [LPF 80Hz] ◀── [PEQ] ◀── [Gain] │          │
│  │ OUT2 (Front Nearfield R) ◀── [LPF 80Hz] ◀── [PEQ] ◀── [Gain] │          │
│  │ OUT3 (Rear Nearfield L)  ◀── [LPF 80Hz] ◀── [PEQ] ◀── [Gain] │          │
│  │ OUT4 (Rear Nearfield R)  ◀── [LPF 80Hz] ◀── [PEQ] ◀── [Gain] │          │
│  │ OUT5 (Main Corner FL)    ◀── [LPF 80Hz] ◀── [PEQ] ◀── [Gain] │          │
│  │ OUT6 (Main Corner FR)    ◀── [LPF 80Hz] ◀── [PEQ] ◀── [Gain] │          │
│  │ OUT7 (Tactile L)         ◀── [BPF 10-80Hz] ◀── [PEQ] ◀─ [Gain]│          │
│  │ OUT8 (Tactile R)         ◀── [BPF 10-80Hz] ◀── [PEQ] ◀─ [Gain]│          │
│  └───────────────────────────────────────────────────────────────┘          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Critical Filter Configurations

#### Subsonic Protection HPF (All Subwoofer Outputs)

| Parameter | Setting | Rationale |
|-----------|---------|-----------|
| Type | Butterworth HPF | Maximally flat passband |
| Frequency | 5Hz | Protect against subsonic content |
| Slope | 24dB/oct (4th order) | Good protection without audible rolloff at 20Hz |

**Why 5Hz, not 10Hz or 15Hz:**
- Your UMII18-22 drivers have Xmax = 28mm
- At 5Hz, content is inaudible but can cause excursion
- 24dB/oct at 5Hz gives -24dB at 2.5Hz (effectively blocks DC)
- 20Hz response: -0.3dB (negligible)

#### Tactile Channel Bandpass

| Parameter | Setting | Rationale |
|-----------|---------|-----------|
| HPF | 10Hz, 12dB/oct | Protect transducers from subsonic |
| LPF | 80Hz, 24dB/oct | Remove content above tactile range |
| PEQ Boost | +3dB @ 20Hz, Q=1.0 | Enhance "chest thump" region |

### Sample SigmaStudio Biquad Coefficients

For 5Hz HPF, 24dB/oct at 96kHz sample rate:

```
Section 1 (2nd order):
b0 = 0.999672
b1 = -1.999345
b2 = 0.999672
a1 = -1.999344
a2 = 0.999345

Section 2 (2nd order):
b0 = 0.999672
b1 = -1.999345
b2 = 0.999672
a1 = -1.999344
a2 = 0.999345
```

**Verified:** These coefficients are calculated using standard biquad cookbook formulas, not relying on DSP-408's 20Hz limitation.

---

## Integration with Home Theater System

### Signal Chain (Rev 5.9 Context)

```
Sources → Marantz AV10 → Dirac Live → Dirac ART
                              │
              ┌───────────────┴───────────────┐
              │                               │
         Main Speakers                    4× Sub Outputs
         (direct to amps)                     │
                                              ▼
                                    ┌─────────────────┐
                                    │   DIY DSP       │
                                    │   (this unit)   │
                                    └────────┬────────┘
                                             │
              ┌──────────────────────────────┼──────────────────────────────┐
              │                              │                              │
        ┌─────┴─────┐              ┌─────────┴─────────┐          ┌────────┴────────┐
        │ Main Subs │              │  Nearfield Subs   │          │ Tactile System  │
        │ NX6000D   │              │     NX6000D       │          │    NX6000D      │
        │  #1, #2   │              │     #3, #4        │          │      #5         │
        └─────┬─────┘              └─────────┬─────────┘          └────────┬────────┘
              │                              │                              │
        8× UMII18-22                   8× UMII18-22                  16× Aura Pro
        (corner columns)              (riser + console)              (bass shakers)
```

### Output Assignment Matrix

| DSP Output | Destination | Amp Channel | Filter Config |
|------------|-------------|-------------|---------------|
| OUT1 | Front Nearfield L | NX6000D #3 Ch.A | HPF 5Hz, LPF 80Hz |
| OUT2 | Front Nearfield R | NX6000D #3 Ch.B | HPF 5Hz, LPF 80Hz |
| OUT3 | Rear Nearfield L | NX6000D #4 Ch.A | HPF 5Hz, LPF 80Hz |
| OUT4 | Rear Nearfield R | NX6000D #4 Ch.B | HPF 5Hz, LPF 80Hz |
| OUT5 | Main Corner FL+RL | NX6000D #1 Ch.A | HPF 5Hz, LPF 80Hz |
| OUT6 | Main Corner FR+RR | NX6000D #2 Ch.A | HPF 5Hz, LPF 80Hz |
| OUT7 | Tactile L (8× shakers) | NX6000D #5 Bridge | BPF 10-80Hz |
| OUT8 | Tactile R (8× shakers) | NX6000D #5 Bridge | BPF 10-80Hz |

---

## Performance Specifications (Target)

| Parameter | Specification | Verification Method |
|-----------|---------------|---------------------|
| Frequency Response | 5Hz - 20kHz ±0.5dB | REW sweep measurement |
| THD+N @ 1kHz | <0.01% (-80dB) | REW distortion measurement |
| SNR | >100dB (A-weighted) | REW noise floor measurement |
| Dynamic Range | >100dB | Calculated from SNR + THD |
| Channel Separation | >90dB | REW crosstalk measurement |
| Input Impedance | 10kΩ | Design specification |
| Output Impedance | <100Ω | Design specification |
| Max Input Level | 2Vrms | Match AV10 output |
| Max Output Level | 2Vrms | Match NX6000D input sensitivity |
| Latency | <2ms @ 96kHz | SigmaStudio pipeline analysis |

---

## Comparison: DIY vs. Commercial

| Feature | DIY DSP (This Design) | Dayton DSP-408 | miniDSP Flex HT |
|---------|----------------------|----------------|-----------------|
| **Inputs** | 4 (expandable to 6) | 4 | 4 |
| **Outputs** | 8 | 8 | 4 |
| **Min Filter Freq** | **DC (no limit)** | 20Hz | ~10Hz (biquad mode) |
| **Transfer Function Visibility** | **Full coefficients** | Hidden | Hidden |
| **Sample Rate** | 96kHz | 96kHz | 96kHz |
| **REW Import** | **Direct biquad** | Manual entry | Limited |
| **Self-Boot** | Yes | Yes | Yes |
| **Cost** | ~$100-220 | ~$300 | ~$600 |
| **Learning Curve** | High | Low | Low |
| **Flexibility** | **Maximum** | Limited | Moderate |

---

## Implementation Phases

### Phase 1: Validation (Current - with ADAU1701)
- [x] Order Wondom APM2 + ICP5 (completed)
- [ ] Validate SigmaStudio workflow
- [ ] Design and test infrasonic filters (5Hz HPF)
- [ ] Verify REW measurement integration
- [ ] Export biquad coefficients and verify math

### Phase 2: Prototype (Pre-Theater Build)
- [ ] Order ADAU1452 + CS42448 board (~$55)
- [ ] Validate 4-in/8-out configuration
- [ ] Test with actual theater amplifiers (NX6000D)
- [ ] Measure performance (THD, noise floor, crosstalk)
- [ ] Document known issues and workarounds

### Phase 3: Production (Theater Installation)
- [ ] Upgrade analog stages if needed
- [ ] Build into proper enclosure with panel-mount RCA
- [ ] Final calibration with REW
- [ ] Create backup of EEPROM configuration
- [ ] Document final settings

---

## Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Chinese board quality issues | Medium | Medium | Buy from reputable seller (Nvarcher), test before installation |
| 192kHz not stable | High | Low | Use 96kHz (still excellent quality) |
| Op-amp clipping at high input | Medium | Medium | Upgrade to OPA1641 or reduce input gain |
| Noise floor too high | Medium | Medium | Upgrade power supply, add filtering |
| Programming difficulty | Low | Low | Already validated workflow on ADAU1701 |

---

## References

### Datasheets
1. ADAU1466 Datasheet - Analog Devices (verified)
2. CS42448 Datasheet - Cirrus Logic (verified: 108dB, 192kHz, 6-in/8-out)

### Community Resources
1. diyAudio thread: "low cost ADAU1452 China board" (28+ pages of documented experience)
2. GitHub: ohdsp/uDSP - Open source ADAU145x board design
3. electro-dan.co.uk - "Getting started with a ADAU1466 14 in 18 out board"

### Software
1. SigmaStudio (free from Analog Devices, Windows only)
2. REW - Room EQ Wizard (measurement and filter design)
3. biquad calculator tools (online, verify coefficients)

---

## Appendix A: Why Not Just Use Dayton DSP-408?

From our analysis, the DSP-408 has a **hard 20Hz minimum frequency limit** in both its HPF and LPF settings. This is a firmware/software limitation, not hardware.

**Impact on this system:**
1. Cannot design proper 5Hz subsonic protection (must use 20Hz)
2. Cannot properly filter tactile transducers which operate at 10-15Hz
3. Cannot implement Linkwitz Transform for sealed subs extending to 10Hz
4. Cannot see actual transfer function - must calculate manually

**Expert opinion (CyberPit, diyAudio):**
> "It seems too hard to hack the DSP-408 firmware for me, developing a new ADAU1701 board is much easier for me..."

---

## Appendix B: miniDSP 2x4 HD Biquad Coefficient Format

For reference (from our previous documentation):

> miniDSP 2x4 HD biquad format: requires inverted a1/a2 signs (positive a1, negative a2) vs standard DSP convention

The ADAU1452 uses standard DSP convention, so coefficients from REW or biquad calculators work directly without sign inversion.

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-01-04 | Initial design document |

---

*This document supports the Home Theater System Rev 5.9 "Weapons-Grade Bass" design.*
