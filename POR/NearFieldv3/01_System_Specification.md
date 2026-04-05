# Nearfield Tactile Subwoofer System - V3 Design

## System Overview

| Parameter | Value |
|-----------|-------|
| **Purpose** | Localized tactile bass impact at seating positions |
| **Configuration** | 4 drivers per cabinet, 2 cabinets per couch |
| **Total Cabinets** | 4 (2 couches × 2 cabinets) |
| **Total Drivers** | 16 |
| **Listening Distance** | 12-18" from listener's back |
| **Target SPL** | 95 dB @ 10Hz (tactile impact) |
| **Maximum SPL** | ~101 dB @ 10Hz (excursion-limited) |
| **Integration** | Supplements main 4× dual UMII18-22 corner subs |

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           COUCH 1 (Row 1)                                   │
│                                                                             │
│  ┌─────────────────────┐              ┌─────────────────────┐               │
│  │    CABINET 1-L      │              │    CABINET 1-R      │               │
│  │   4× UMII10-22      │              │   4× UMII10-22      │               │
│  │   48"W × 30"H × 12"D│              │   48"W × 30"H × 12"D│               │
│  │        4Ω           │              │        4Ω           │               │
│  └──────────┬──────────┘              └──────────┬──────────┘               │
│             │                                    │                          │
│             └────────────┬───────────────────────┘                          │
│                          │                                                  │
│                   ┌──────┴──────┐                                           │
│                   │  NX6000 #1  │                                           │
│                   │   Stereo    │                                           │
│                   │ CH.A   CH.B │                                           │
│                   └──────┬──────┘                                           │
│                          │                                                  │
│                   ┌──────┴──────┐                                           │
│                   │ miniDSP #1  │                                           │
│                   │   2x4 HD    │                                           │
│                   └──────┬──────┘                                           │
│                          │                                                  │
└──────────────────────────┼──────────────────────────────────────────────────┘
                           │
┌──────────────────────────┼──────────────────────────────────────────────────┐
│                          │          COUCH 2 (Row 2)                         │
│                          │                                                  │
│                   ┌──────┴──────┐                                           │
│                   │ miniDSP #2  │                                           │
│                   │   2x4 HD    │                                           │
│                   └──────┬──────┘                                           │
│                          │                                                  │
│                   ┌──────┴──────┐                                           │
│                   │  NX6000 #2  │                                           │
│                   │   Stereo    │                                           │
│                   │ CH.A   CH.B │                                           │
│                   └──────┬──────┘                                           │
│             ┌────────────┴───────────────────────┐                          │
│             │                                    │                          │
│  ┌──────────┴──────────┐              ┌──────────┴──────────┐               │
│  │    CABINET 2-L      │              │    CABINET 2-R      │               │
│  │   4× UMII10-22      │              │   4× UMII10-22      │               │
│  │   48"W × 30"H × 12"D│              │   48"W × 30"H × 12"D│               │
│  │        4Ω           │              │        4Ω           │               │
│  └─────────────────────┘              └─────────────────────┘               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Signal Flow (Per Couch)

```
AVR Subwoofer Output (Mono)
         │
         ▼
   miniDSP 2x4 HD
   ┌─────────────────────────────────────┐
   │  Input 1                            │
   │    │                                │
   │    ├─► Biquad 1: Linkwitz Transform │
   │    │   (Fc=38Hz → Fp=10Hz)          │
   │    │                                │
   │    ├─► Biquad 2: HPF 5Hz (12dB/oct) │
   │    │                                │
   │    ├─► Biquad 3: HPF 5Hz (12dB/oct) │
   │    │   (cascaded = 24dB/oct total)  │
   │    │                                │
   │    ├─► Output 1 ──────────────────────► NX6000 CH.A
   │    └─► Output 2 ──────────────────────► NX6000 CH.B
   └─────────────────────────────────────┘
         │                    │
         ▼                    ▼
   Cabinet L (4Ω)      Cabinet R (4Ω)
```

---

## V3 Cabinet Specifications

### External Dimensions

| Dimension | Value | Metric |
|-----------|-------|--------|
| Width | 48.0" | 1219 mm |
| Height | 30.0" | 762 mm |
| Depth | 12.0" | 305 mm |

### Construction

| Component | Value |
|-----------|-------|
| Material | 3/4" MDF or Baltic Birch |
| Baffle | 1.5" (double 3/4" layers) |
| Recess Depth | 1.5" |
| Panel Thickness | 0.75" |

### Internal Volume

| Parameter | Value |
|-----------|-------|
| Gross Volume | 6.33 ft³ |
| Net Volume | ~5.7 ft³ (after bracing) |
| Per Driver | 1.42 ft³ (40.3 L) |

### Acoustic Parameters

| Parameter | Value |
|-----------|-------|
| **Fc** | **38 Hz** |
| **Qtc** | **0.88** |
| Natural F3 | ~32 Hz |
| With LT F3 | ~10 Hz |

---

## Driver Specifications

### Dayton Audio UMII10-22 Ultimax II 10" DVC

| Specification | Value |
|---------------|-------|
| Part Number | 295-710 |
| Price | $169.98 |

**Thiele-Small Parameters:**

| Parameter | Value |
|-----------|-------|
| Fs | 31 Hz |
| Qts | 0.72 |
| Qes | 0.94 |
| Qms | 3.02 |
| Vas | 19.5 L (0.69 ft³) |
| Xmax | 20 mm |
| Sd | 327.8 cm² |
| BL | 12.3 T·m |

**Electrical:**

| Parameter | Value |
|-----------|-------|
| Impedance | Dual 2Ω (4Ω series) |
| Power Handling | 600W RMS |
| Sensitivity | 83.6 dB @ 2.83V/1m |

**Physical:**

| Parameter | Value |
|-----------|-------|
| Overall Diameter | 10.5" |
| Cutout Diameter | 9.32" |
| Bolt Circle | 9.92" |
| Mounting Depth | 5.98" |
| Weight | 14.9 lbs |

---

## Amplifier Specifications

### Behringer NX6000 / NX6000D

| Specification | Value |
|---------------|-------|
| Configuration | Stereo Mode |
| Load | 4Ω per channel |
| Units Required | 2 (one per couch) |

**Real-World Power (Forum-Verified):**

| Frequency | Rated | Real-World |
|-----------|-------|------------|
| 40Hz+ | 3,000W/ch | 1,600-2,000W |
| 20-40Hz | 3,000W/ch | 1,200-1,600W |
| <20Hz | 3,000W/ch | 800-1,200W |

Design figure @ 10Hz: **1,000W per channel**

---

## DSP Specifications

### miniDSP 2x4 HD

| Specification | Value |
|---------------|-------|
| Sample Rate | 96 kHz |
| Units Required | 2 (one per couch) |
| Biquads Used | 3 per output |

**Processing:**

| Biquad | Function |
|--------|----------|
| 1 | Linkwitz Transform (Fc=38Hz → Fp=10Hz) |
| 2 | Subsonic HPF 5Hz (12dB/oct) |
| 3 | Subsonic HPF 5Hz (12dB/oct) |

**Total subsonic protection:** 24dB/oct @ 5Hz

---

## Performance Summary

### SPL vs Power @ 10Hz (per cabinet, 18" distance)

| Target SPL | Power Required | Status | Headroom |
|------------|----------------|--------|----------|
| **95 dB** | **129W** | ✓ | +8.9 dB |
| 100 dB | 407W | ✓ | +3.9 dB |
| 101.5 dB | ~600W | ⚠️ | Xmax limit |
| 105 dB | 1,286W | ✗ | Exceeds limits |

### System Limits

| Limit | Maximum SPL |
|-------|-------------|
| Excursion (Xmax) | **101.5 dB** |
| Amplifier (1,000W) | 103.9 dB |
| **Actual Limit** | **101.5 dB** (excursion) |

---

## Document Index

| Document | Description |
|----------|-------------|
| 01_System_Specification.md | This document |
| 02_Cabinet_Design.md | Dimensions, construction, layout |
| 03_Amplifier_Config.md | NX6000 setup, wiring |
| 04_DSP_Config.md | miniDSP biquads, routing |
| 05_Bill_of_Materials.md | Parts list with pricing |
| 06_SPL_Power_Analysis.md | Performance calculations |

---

*Document Version: 3.0*
*Created: December 2024*
