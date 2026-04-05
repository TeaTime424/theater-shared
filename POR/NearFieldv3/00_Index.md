# V3 Nearfield Tactile Subwoofer System - Master Index

## Quick Reference

| Metric | Value |
|--------|-------|
| **Target SPL** | 95 dB @ 10Hz @ 18" |
| **Maximum SPL** | 101.5 dB (excursion-limited) |
| **Total Cost** | ~$4,500-4,700 |
| **Cabinets** | 4 (2 per couch) |
| **Drivers** | 16 (4 per cabinet) |

---

## System Summary

```
┌─────────────────────────────────────────────────────────────────┐
│                    V3 NEARFIELD SYSTEM                          │
│                                                                 │
│   2× Couches  →  4× Cabinets  →  16× Drivers                   │
│                                                                 │
│   Per Couch:                                                    │
│   ┌─────────────┐     ┌─────────────┐                          │
│   │ Cabinet L   │     │ Cabinet R   │                          │
│   │ 4× UMII10-22│     │ 4× UMII10-22│                          │
│   │ 48"×30"×12" │     │ 48"×30"×12" │                          │
│   │    4Ω       │     │    4Ω       │                          │
│   └──────┬──────┘     └──────┬──────┘                          │
│          │                   │                                  │
│          └─────────┬─────────┘                                  │
│                    │                                            │
│            ┌───────┴───────┐                                    │
│            │   NX6000      │                                    │
│            │   Stereo      │                                    │
│            └───────┬───────┘                                    │
│                    │                                            │
│            ┌───────┴───────┐                                    │
│            │ miniDSP 2x4HD │                                    │
│            │ LT + HPF      │                                    │
│            └───────────────┘                                    │
└─────────────────────────────────────────────────────────────────┘
```

---

## Document Index

| # | Document | Description |
|---|----------|-------------|
| 00 | **00_Index.md** | This document |
| 01 | 01_System_Specification.md | Complete system overview |
| 02 | 02_Cabinet_Design.md | Dimensions, construction, cut list |
| 03 | 03_Amplifier_Config.md | NX6000 setup, wiring diagrams |
| 04 | 04_DSP_Config.md | miniDSP biquads, routing |
| 05 | 05_Bill_of_Materials.md | Complete parts list with pricing |
| 06 | 06_SPL_Power_Analysis.md | Performance calculations |

---

## Scripts

| Script | Purpose |
|--------|---------|
| biquad_calculator.py | Generate miniDSP coefficients |

---

## Diagrams

| File | Description |
|------|-------------|
| diagrams/frequency_response.png | DSP + acoustic response curves |
| diagrams/spl_power_analysis.png | SPL vs power requirements |

---

## Key Specifications

### Cabinet (V3)

| Parameter | Value |
|-----------|-------|
| External | 48"W × 30"H × 12"D |
| Drivers | 4× UMII10-22 (2×2) |
| Impedance | 4Ω (2s2p) |
| Net Volume | ~5.7 ft³ |
| Fc | 38 Hz |
| Qtc | 0.88 |

### DSP (miniDSP 2x4 HD)

| Parameter | Value |
|-----------|-------|
| Sample Rate | 96 kHz |
| Biquad 1 | Linkwitz Transform (38Hz→10Hz) |
| Biquad 2-3 | Subsonic HPF 5Hz (24dB/oct) |
| Boost @ 10Hz | +19.5 dB |

### Amplifier (NX6000)

| Parameter | Value |
|-----------|-------|
| Mode | Stereo |
| Load | 4Ω per channel |
| Power @ 10Hz | ~1,000W (real-world) |

---

## Biquad Coefficients (miniDSP 2x4 HD Format)

**IMPORTANT:** miniDSP 2x4 HD requires inverted a1/a2 signs!

```
biquad1,
b0=1.0009512511,
b1=-1.9990713825,
b2=0.9981263141,
a1=1.9990742598,
a2=-0.9990746880

biquad2,
b0=0.9997685917,
b1=-1.9995371834,
b2=0.9997685917,
a1=1.9995371298,
a2=-0.9995372369

biquad3,
b0=0.9997685917,
b1=-1.9995371834,
b2=0.9997685917,
a1=1.9995371298,
a2=-0.9995372369
```

---

## Cost Summary

| Category | Cost |
|----------|------|
| Drivers (16×) | $2,720 |
| Amplifiers (2×) | $866 |
| DSP (2×) | $450 |
| Cabinets (4×) | $353 |
| Wiring | $141 |
| **Total** | **~$4,530** |

---

## Performance Summary

| Target | Power | Status |
|--------|-------|--------|
| 95 dB | 129W | ✓ +8.9 dB headroom |
| 100 dB | 407W | ✓ +3.9 dB headroom |
| 101.5 dB | 600W | ⚠️ Xmax limit |

---

*V3 Nearfield System Documentation*
*Version: 3.0*
*December 2024*
