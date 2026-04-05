# ADAU1452 Signal Chain Design for Home Theater DSP

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-02
**Revision:** 1.0
**Related:** `research/DIY_DSP_4x8_Design.md`, `research/ICEpower_1200AS2_Reference.md`, `research/Raspberry_Pi_for_DSP.md`, `research/sigmastudio-tcp-control.md`

---

## Executive Summary

This document covers the complete signal chain design for integrating an ADAU1452-based DSP into the home theater system, from the Marantz AV10 processor outputs through the DSP board to the ICEpower 1200AS2 amplifier modules. It addresses the balanced vs unbalanced output question, the role of each chip on the DSP board, and the autonomous measurement/correction system architecture.

---

## 1. Why the ADAU1452 (Not the DSP-408)

The Dayton DSP-408 has a **hard 20Hz minimum frequency limit** on HPF/LPF — a firmware limitation that blocks infrasonic work for tactile transducers (10-15Hz operating range) and proper subsonic protection (5Hz HPF). The ADAU1452 has no such limitation — filters to DC.

| Feature | Dayton DSP-408 | DIY ADAU1452 |
|---------|---------------|--------------|
| Min filter frequency | 20Hz (hard limit) | DC (no limit) |
| Transfer function | Hidden (opaque GUI) | Full biquad coefficients visible |
| Infrasonic HPF | Cannot do <20Hz | 5Hz HPF, 24dB/oct — trivial |
| Tactile bandpass | Limited (20Hz floor) | Full 10-80Hz bandpass |
| REW integration | Manual coefficient entry | Direct biquad import |
| Remote control | None | gRPC via Raspberry Pi (automated) |
| Cost | ~$300 | ~$100-220 depending on build quality |

---

## 2. Understanding the ADAU1452 Board — Three Chips, One System

The ADAU1452 is **only a DSP processor** — it has no analog audio capability. It processes digital numbers. The 4-in/8-out capability comes from three chips working together on the same PCB:

```
Analog In (RCA)              Digital                   Analog Out (RCA)
     │                         │                            ▲
     ▼                         ▼                            │
┌──────────┐            ┌──────────┐              ┌──────────┐
│ CS42448  │    I2S      │ ADAU1452 │     I2S      │ CS42448  │
│  (ADC)   │───────────▶│  (DSP)   │────────────▶ │  (DAC)   │
│ 6 ch in  │   digital  │  math    │    digital   │ 8 ch out │
└──────────┘            └──────────┘              └──────────┘
                              ▲
                              │
                         ┌──────────┐
                         │ EEPROM   │
                         │ (config) │
                         └──────────┘
```

| Chip | Manufacturer | Role | What it does |
|------|-------------|------|-------------|
| **CS42448** | Cirrus Logic | Codec (ADC + DAC) | Converts analog audio to/from 24-bit digital. 6 ADC channels in, 8 DAC channels out, up to 192kHz |
| **ADAU1452** | Analog Devices | DSP processor | Runs biquad filters, crossovers, delays, mixing matrix, gain — all in the digital domain. 6144 instructions @ 48kHz |
| **EEPROM** | Various | Configuration storage | Holds the SigmaStudio program so the DSP self-boots without a computer attached |

The Chinese boards on AliExpress ($45-60) put all three on **one PCB**. Listing titles read "ADAU1452 + CS42448" — that's both chips together.

### Comparison: ADAU1701 vs ADAU1452

The ADAU1701 (used for Phase 1 learning on the Wondom APM2 board) is the smaller sibling:

| | ADAU1701 | ADAU1452 |
|---|---|---|
| **I/O** | 2-in / 4-out | Up to 24-in / 24-out (depends on codec) |
| **ADC/DAC** | **Built-in** (complete system on one chip) | None — needs external codec (CS42448) |
| **Program memory** | 1024 instructions | 6144 instructions |
| **Data memory** | 512 words | 5120 words |
| **Sample rate** | 48kHz max | 192kHz max |
| **Bit depth** | 28-bit internal | 28-bit internal |
| **Self-boot** | Yes (EEPROM) | Yes (EEPROM) |
| **SigmaStudio** | Yes (same workflow) | Yes (same workflow) |
| **Price** | ~$8 chip / ~$25 board | ~$15 chip / ~$45-60 board |

Key difference: the ADAU1701 has its ADC and DAC **on-chip** — a complete audio system in one IC. The ADAU1452 traded away the built-in converters to get 6x the processing power and flexible I/O count. Everything learned on the 1701 (SigmaStudio workflow, filter design, coefficient export, biquad math) transfers directly to the 1452.

### CS42448 Codec Specifications

| Parameter | ADC | DAC |
|-----------|-----|-----|
| Channels | 6 input | 8 output |
| Resolution | 24-bit | 24-bit |
| Dynamic Range | 105 dB (differential) / 102 dB (single-ended) | 108 dB (differential) / 105 dB (single-ended) |
| THD+N | -95 dB | -100 dB |
| SNR | 105 dB | 108 dB |
| Max Sample Rate | 192 kHz | 192 kHz |

**Known limitation (diyAudio forums):** The CS42448 ADC struggles at 192kHz. **Recommendation: run at 48kHz or 96kHz** for reliable operation and excellent audio quality.

---

## 3. Complete Signal Chain for This Theater

### 3.1 System Block Diagram

```
Sources (HDMI/streaming)
    ↓
Marantz AV10 (9.4.6 Atmos processor, NOT an amplifier)
    ↓ Dirac Live + Dirac ART processing
    ├─ Speaker outputs (LCR, Surrounds, Atmos)
    │   └─ 2× Buckeye Hypex NC252MP (balanced XLR)
    │
    └─ 4× Sub outputs (analog, RCA, ~2Vrms line-level)
        ↓
   ┌─────────────────────────────────────────────────┐
   │  ADAU1452 + CS42448 Board (~$55)                │
   │                                                  │
   │  4× RCA IN → CS42448 ADC → I2S → ADAU1452 DSP  │
   │                                                  │
   │  ADAU1452 DSP processing:                        │
   │    ├─ HPF 5Hz, 24dB/oct (infrasonic protection)  │
   │    ├─ 10-band PEQ per output channel             │
   │    ├─ Crossover LPF 80Hz (subs) / BPF 10-80Hz   │
   │    ├─ Per-channel delay (0-50ms)                  │
   │    ├─ 4×8 routing matrix                          │
   │    └─ Per-channel gain (-60 to +12 dB)            │
   │                                                  │
   │  ADAU1452 DSP → I2S → CS42448 DAC → 8× OUT     │
   └───────────────┬─────────────────────────────────┘
                   │ 8× outputs (unbalanced on Chinese boards)
                   ▼
   ┌───────────────────────────────┐
   │  Balanced Line Drivers (×8)   │  ← production build only
   │  DRV134 or THAT1646           │     skip for prototype
   │  Powered by ICEpower AVDD     │
   └───────────────┬───────────────┘
                   │ 8× balanced differential pairs
                   ▼
   ICEpower 1200AS2 modules (×4 modules, 2ch each = 8 channels)
     ├─ OUT1/2 → Front nearfield subs (2ch)
     ├─ OUT3/4 → Rear nearfield subs (2ch)
     ├─ OUT5/6 → Main corner subs (2ch)
     └─ OUT7/8 → Tactile transducers (2ch, bridged)
        ↓
   Drivers:
     ├─ 8× UMII18-22 nearfield
     ├─ 8× UMII18-22 main corner columns
     └─ 16× Aura Pro AST-2B-4 bass shakers
```

### 3.2 Output Assignment Matrix

| DSP Output | Destination | Amp Module | Filter Config |
|------------|-------------|------------|---------------|
| OUT1 | Front Nearfield L | 1200AS2 #1 Ch.A | HPF 5Hz, LPF 80Hz |
| OUT2 | Front Nearfield R | 1200AS2 #1 Ch.B | HPF 5Hz, LPF 80Hz |
| OUT3 | Rear Nearfield L | 1200AS2 #2 Ch.A | HPF 5Hz, LPF 80Hz |
| OUT4 | Rear Nearfield R | 1200AS2 #2 Ch.B | HPF 5Hz, LPF 80Hz |
| OUT5 | Main Corner FL+RL | 1200AS2 #3 Ch.A | HPF 5Hz, LPF 80Hz |
| OUT6 | Main Corner FR+RR | 1200AS2 #3 Ch.B | HPF 5Hz, LPF 80Hz |
| OUT7 | Tactile L (8× shakers) | 1200AS2 #4 Ch.A | BPF 10-80Hz |
| OUT8 | Tactile R (8× shakers) | 1200AS2 #4 Ch.B | BPF 10-80Hz |

---

## 4. The Balanced Output Question

### 4.1 The Problem

The Chinese ADAU1452+CS42448 boards output **unbalanced** (single-ended) RCA signals. The ICEpower 1200AS2 modules accept **balanced** (differential) inputs on a JST connector (P105: JST B6B-PH-K-S).

### 4.2 ICEpower 1200AS2 Input Specifications

| Parameter | Value |
|-----------|-------|
| Input type | Balanced (differential) |
| Input impedance | 38 kΩ per leg |
| Input sensitivity | 5.0 Vp for full power (1200W @ 4Ω) |
| Connector | P105: JST B6B-PH-K-S (2-channel balanced audio) |
| Voltage gain | 25.8 dB |

### 4.3 Three Options

#### Option 1: Feed Unbalanced Directly (Prototype — Simplest)

Connect the CS42448's single-ended output to the ICEpower's balanced input by wiring signal to HOT and ground to COLD:

```
CS42448 DAC output (signal) → ICEpower HOT (+)
Ground                      → ICEpower COLD (-)
Ground                      → ICEpower GND
```

**Pros:**
- Zero additional hardware
- Works immediately
- Adequate for prototype testing and sub-bass frequencies

**Cons:**
- No common-mode noise rejection
- Susceptible to ground loops on longer cable runs
- 6 dB less signal level vs true balanced (not an issue — gain is adjustable in DSP)

**Verdict:** Fine for cable runs under 3 feet within the same rack. For sub-bass signals in an enclosed equipment rack, noise pickup is negligible. Many DIY builds use this permanently.

#### Option 2: Balanced Line Driver Stage (Production — Best)

Add a differential driver IC between the DAC output and the amp input:

```
CS42448 DAC → DRV134 (or THAT1646) → balanced pair → ICEpower 1200AS2
              (unbal→bal converter)
```

| Driver IC | Price (each) | ×8 Total | Notes |
|-----------|-------------|----------|-------|
| **DRV134** (Texas Instruments) | ~$6 | ~$48 | Industry standard unbal→bal converter |
| **THAT1646** (THAT Corp) | ~$5 | ~$40 | Popular in pro audio, excellent specs |
| **OPA1632** (Texas Instruments) | ~$4 | ~$32 | Differential output op-amp, very clean |

For 8 outputs: ~$32-48 in driver ICs plus passives (~$10-15). Total ~$50-65 for the balanced output stage.

**Pros:**
- True balanced differential output
- Full common-mode noise rejection (30-50 dB improvement)
- Professional signal integrity over any cable length
- Proper impedance matching

**Cons:**
- Additional PCB or adapter board needed
- Adds ~$50-65 to the build
- Requires ±15V power supply (but see Option 3)

**Verdict:** Recommended for the production theater install. Proper engineering.

#### Option 3: Power the Driver Stage from ICEpower Aux Rails (Clever)

Each ICEpower 1200AS2 module provides auxiliary power outputs:

| Rail | Voltage | Available Current | Purpose |
|------|---------|-------------------|---------|
| AVDD | +15V ±2V | 500 mA | Op-amp / line driver positive rail |
| AVSS | -15V ±2V | 500 mA | Op-amp / line driver negative rail |
| DVDD | +5V ±0.2V | 1A (40mA standby) | Digital logic power |
| Limitation | — | — | Total AVDD + AVSS must not exceed 15W |

**This means:** each ICEpower module can power the DRV134 line drivers for its own 2 input channels. No separate power supply needed for the output stage. One DRV134 per channel, powered by the AVDD/AVSS of the amp it feeds.

Power budget per module: 2× DRV134 consume ~50mA total from ±15V = ~1.5W. Well within the 15W/500mA limit.

**Verdict:** Use this approach for production. Eliminates a separate PSU entirely.

### 4.4 Recommendation

| Phase | Approach | Cost | Why |
|-------|----------|------|-----|
| **Prototype/validation** | Option 1 — unbalanced direct | $0 | Get everything working first. Filters, correction loop, the whole pipeline. Noise is irrelevant for digital loopback testing and sub-bass frequencies in a rack |
| **Production install** | Option 2+3 — DRV134 powered by ICEpower AVDD/AVSS | ~$50-65 | Proper balanced output, no separate PSU, professional signal integrity |

---

## 5. Multiple DSPs — One Pi Controls All

### 5.1 SPI Bus Architecture

SPI is a shared bus. All DSP boards share the same 3 data wires (MOSI, MISO, SCLK). Each board gets its own **chip select (CS)** line — the Pi pulls that line low to address a specific DSP.

```
                    ┌──── CS0 (GPIO 8) ──── ADAU1452 #1 (subs)
Pi SPI0 ── MOSI ───┤
           MISO ───┤──── CS1 (GPIO 7) ──── ADAU1452 #2 (nearfield + tactile)
           SCLK ───┤
                    └──── CS2 (any GPIO) ── ADAU1452 #3 (future expansion)
```

| Resource | Pi 4 has | Per DSP board | Notes |
|----------|----------|---------------|-------|
| Hardware CS lines (SPI0) | 2 (CE0, CE1) | 1 | 2 DSPs with zero tricks |
| Software CS (any GPIO) | ~20 spare | 1 | 3-4+ DSPs easily |
| RESET pin | — | Shareable | All boards reset together (fine) |
| SELFBOOT pin | — | Shareable | Same boot behavior for all |

**For this system:** 2 ADAU1452 boards (16 total outputs) covers everything. One Pi, two chip selects, done.

### 5.2 DSP Capacity per Board

Each ADAU1452 has 6144 instructions at 48kHz:

| Function | Instructions per channel | ×8 channels |
|----------|------------------------|-------------|
| 10-band PEQ | ~60 | 480 |
| HPF (4th order) | ~12 | 96 |
| LPF (4th order) | ~12 | 96 |
| Delay | ~5 | 40 |
| Gain + mute | ~3 | 24 |
| 4×8 routing matrix | ~40 | 40 |
| **Total** | | **~776 / 6144 (13%)** |

Massive headroom. One board handles all 8 output channels with room to spare.

---

## 6. Raspberry Pi Integration

### 6.1 Role

The Raspberry Pi sits between the Windows measurement PC and the ADAU1452 DSP board. It runs the `sigmadsp` (blus-audio) backend as a systemd service, receives commands over Ethernet (gRPC), and relays register read/write operations to the DSP via SPI. It does **no audio processing** — just command relay. Draws 2.7W.

### 6.2 Recommended Hardware

**Raspberry Pi 4 Model B, 2GB — $92 total build:**

| Item | Purpose | Price |
|------|---------|-------|
| Pi 4 Model B 2GB | Proven sigmadsp compatibility, mature SPI driver | $55 |
| Flirc aluminum case | Passive cooling (no fan noise), <50C idle | $16 |
| Official 15W USB-C PSU | Stable 5.1V, prevents undervoltage crashes | $8 |
| 32GB microSD (Samsung EVO Select) | OS + sigmadsp, reliable | $8 |
| Cat6 Ethernet cable (3ft) | Pi to network switch | $3 |
| Velcro strips | Rack shelf mounting | $2 |

See `research/Raspberry_Pi_for_DSP.md` for full model comparison (Pi 4 vs Pi 5 vs Pi Zero 2 W) and rationale.

### 6.3 Pi ↔ DSP Wiring (SPI)

| Pi GPIO | Physical Pin | ADAU1452 Board | Signal |
|---------|-------------|---------------|--------|
| GPIO 10 (MOSI) | Pin 19 | SPI_MOSI | Data out |
| GPIO 9 (MISO) | Pin 21 | SPI_MISO | Data in |
| GPIO 11 (SCLK) | Pin 23 | SPI_CLK | Clock |
| GPIO 8 (CE0) | Pin 24 | SPI_CS | Chip select (DSP #1) |
| GPIO 7 (CE1) | Pin 26 | SPI_CS | Chip select (DSP #2, if used) |
| GPIO 17 | Pin 11 | RESET | DSP reset (active low) |
| GPIO 22 | Pin 15 | SELFBOOT | Self-boot enable |
| GND | Pin 6/9/etc | GND | Common ground |

### 6.4 Software Stack

```
Windows PC                              Raspberry Pi 4
┌────────────────────────┐              ┌──────────────────────┐
│  tools/dsp/client.py   │── gRPC ────▶│  sigmadsp backend    │
│    connect()           │   :50051    │    (systemd service) │
│    safeload_write()    │              │    ↕ SPI bus         │
│    read_register()     │              │    ↕ GPIO            │
│    write_biquad()      │              │                      │
└────────────────────────┘              └──────────┬───────────┘
                                                   │ SPI (4-wire)
                                                   ▼
                                        ┌──────────────────────┐
                                        │  ADAU1452 DSP board  │
                                        │  + CS42448 codec     │
                                        └──────────────────────┘
```

---

## 7. Autonomous Measurement & Correction System

### 7.1 Architecture Overview

The `tools/dsp/` Python package (implemented, see `tools/dsp/architecture.svg` for visual) closes the loop between measurement and correction:

```
1. Strudel MCP generates test signal (tone sweep or pink noise)
     ↓
2. Signal plays through system → ADAU1452 DSP → DAC → speakers
     ↓
3. Microphone (UMIK-1) captures room response
     ↓  (or MOTU M2 loopback captures DSP output for electronic verification)
4. tools/audio/ captures + FFT analyzes (sync-free tone extraction)
     ↓
5. tools/dsp/eq.py computes corrective biquad coefficients (scipy.signal)
     ↓
6. tools/dsp/client.py converts to 8.24 fixed-point, safeload writes via gRPC → Pi → DSP
     ↓
7. Re-measure (go to step 1) — iterate until response meets target curve
```

### 7.2 CLI Commands

```bash
python -m tools.dsp ping                    # Check Pi connectivity
python -m tools.dsp status                  # Show channel map + config
python -m tools.dsp bypass sub_main_L       # Flatten all PEQ on a channel
python -m tools.dsp write-eq sub_main_L --freq 40 --gain 6 --q 2  # Test PEQ
python -m tools.dsp compute measurement.json --target-db -20       # Offline EQ
python -m tools.dsp correct sub_main_L --target-db -20             # Auto loop
python -m tools.dsp verify sub_main_L       # Read back coefficients
```

### 7.3 Critical Technical Details

- **Coefficient format:** ADAU1452 uses 8.24 signed fixed-point. `int(value * 2^24) & 0xFFFFFFFF`
- **Biquad order:** `[b0, b1, b2, -a1, -a2]` — a1 and a2 are **negated** vs scipy/standard convention
- **Safeload:** All coefficient writes use safeload registers (0x6000-0x6006) for glitch-free updates. Target address register takes `actual_address - 1` (hardware off-by-one)
- **Correction limits:** Max +6 dB boost, -15 dB cut, Q range 0.5-10.0
- **Convergence:** Typically 2-3 iterations for electronic loopback, 3-5 for acoustic

---

## 8. Complete Bill of Materials

### 8.1 Prototype Build (Validation)

| Item | Price | Source | Notes |
|------|-------|--------|-------|
| ADAU1452 + CS42448 board | $55 | AliExpress (Nvarcher) | 4-in/8-out, proven platform |
| TinySine USBi programmer | $25 | Amazon | Initial SigmaStudio project upload |
| 6V 2A power supply (DSP board) | $10 | Amazon | Board power |
| Raspberry Pi 4 2GB + case + PSU + SD | $92 | CanaKit / PiShop | sigmadsp host |
| SPI jumper wires (6 wires) | $5 | Amazon | Pi → DSP connection |
| RCA cables (4× input, 8× output) | $15 | Existing / Amazon | Signal wiring |
| **Prototype Total** | **~$202** | | |

### 8.2 Production Build (Theater Installation)

| Item | Price | Source | Notes |
|------|-------|--------|-------|
| ADAU1452 + CS42448 board | $55 | AliExpress | Or $60 for ADAU1466 (2× memory) |
| OPA1641 input buffers (×4) | $14 | Mouser | Upgraded analog input stage |
| DRV134 balanced line drivers (×8) | $48 | Mouser | Unbalanced → balanced conversion |
| Film capacitors (WIMA MKS2) | $10 | Mouser | Coupling caps for I/O stages |
| Neutrik NYS367 RCA jacks (×12) | $30 | Parts Express | Panel-mount gold-plated |
| Hammond 1455N1601BK enclosure | $28 | Mouser | Proper chassis |
| TinySine USBi programmer | $25 | Amazon | One-time use for initial upload |
| Raspberry Pi 4 2GB full kit | $92 | CanaKit | sigmadsp host (shared across DSPs) |
| SPI + GPIO wiring | $5 | Amazon | Pi → DSP |
| Miscellaneous (standoffs, wire) | $10 | — | Assembly hardware |
| **Production Total** | **~$317** | | |

**Note:** The DRV134 balanced drivers are powered by the ICEpower 1200AS2's AVDD/AVSS rails (+15V/-15V, 500mA). No separate power supply needed for the output stage.

### 8.3 Cost in Context

| Component | Cost | % of Theater Budget |
|-----------|------|-------------------|
| DSP system (production build) | ~$317 | 0.4% of $76K |
| Raspberry Pi (one-time) | ~$92 | 0.1% |
| vs. Dayton DSP-408 | ~$300 | Same cost, fewer capabilities |
| vs. miniDSP Flex HT | ~$600 | 2× the cost |

---

## 9. Implementation Phases

### Phase 1: Learn on ADAU1701 (Current)
- Wondom APM2 board + ICP5 programmer (already ordered)
- Validate SigmaStudio workflow
- Design and test infrasonic filters (5Hz HPF)
- Export biquad coefficients and verify math
- Everything transfers to the 1452

### Phase 2: Prototype ADAU1452
- Order Chinese ADAU1452+CS42448 board (~$55)
- Set up Raspberry Pi with sigmadsp
- Wire SPI, verify register read/write from Windows PC
- Load SigmaStudio project via USBi
- Test with unbalanced output directly to ICEpower (Option 1)
- Run autonomous correction loop on loopback

### Phase 3: Production Build
- Upgrade analog stages (OPA1641 input buffers)
- Add DRV134 balanced line drivers (powered by ICEpower AVDD/AVSS)
- Build into Hammond enclosure with panel-mount RCA
- Final calibration with REW + autonomous correction
- Create EEPROM backup of final configuration

### Phase 4: Theater Installation
- Mount DSP + Pi in AV rack
- Wire Marantz AV10 sub outputs → DSP inputs
- Wire DSP balanced outputs → ICEpower 1200AS2 inputs
- Run full room correction with microphone measurement
- Verify convergence and save final state

---

## 10. Reference Documents

| Document | Location | Contents |
|----------|----------|----------|
| DIY DSP 4×8 Design | `research/DIY_DSP_4x8_Design.md` | Full hardware design, SigmaStudio topology, BOM |
| ICEpower 1200AS2 Reference | `research/ICEpower_1200AS2_Reference.md` | Amp specs, input requirements, aux power rails |
| Raspberry Pi for DSP | `research/Raspberry_Pi_for_DSP.md` | Pi model comparison, SPI compatibility, setup checklist |
| SigmaStudio TCP Control | `research/sigmastudio-tcp-control.md` | sigmadsp protocol, gRPC interface, register map |
| DSP Software Tools | `tools/dsp/` | Python package: client, coefficients, EQ engine, CLI |
| Architecture Diagram | `tools/dsp/architecture.svg` | Visual system block diagram |
| Audio Test Pipeline | `tools/audio/` | Measurement capture, FFT analysis, dashboard plots |

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-02 | Initial signal chain design document |
