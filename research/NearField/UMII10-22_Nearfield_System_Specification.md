# Nearfield Tactile Subwoofer System - V3 Design

## System Overview

| Parameter | Value |
|-----------|-------|
| **Purpose** | Localized tactile bass impact at couch position |
| **Configuration** | 4× drivers per cabinet, 2 cabinets per couch |
| **Total Cabinets** | 4 |
| **Total Drivers** | 16 |
| **Listening Distance** | 12-18" from listener's back |
| **Target SPL** | 95 dB @ 10Hz (tactile impact, not room-filling) |
| **Integration** | Supplements main 4× dual UMII18-22 corner subs |

---

## V3 Design Changes from Original

| Parameter | Original | V3 Design | Rationale |
|-----------|----------|-----------|-----------|
| Drivers/cabinet | 8 | **4** | Simpler, lower cost per cabinet |
| Cabinets total | 2 | **4** | Two per couch (same total drivers) |
| External dimensions | 48"×24"×14" | **48"×30"×12"** | Taller, shallower |
| Recess depth | 2.5" | **1.5"** | Reduced for volume |
| Volume/driver | 21.2 L | **40.3 L** | Larger = lower Qtc |
| Qtc | 1.00 | **0.88** | More extended bass naturally |
| Fc | 43 Hz | **38 Hz** | Lower resonance |
| Lip on top | Yes | **No** | Separate isolated platform |

---

## Driver Selection

### Dayton Audio UMII10-22 Ultimax II 10" DVC Subwoofer

| Specification | Value |
|---------------|-------|
| Part Number | 295-710 |
| Price | $169.98 |
| Link | [Parts Express](https://www.parts-express.com/Dayton-Audio-UMII10-22-ULTIMAX-II-10-600W-RMS-DVC-Subwoofer-2-Ohm-Per-Coil-295-710) |

**Thiele-Small Parameters:**

| Parameter | Value |
|-----------|-------|
| Fs | 31 Hz |
| Qts | 0.72 |
| Qes | 0.94 |
| Qms | 3.02 |
| Vas | 19.5 L (0.69 ft³) |
| Xmax | 20 mm |
| Xmech | 28 mm (est.) |
| Sd | 327.8 cm² |
| BL | 12.3 T·m |
| Mms | 192 g |
| Re | 3.7 Ω (series) |

**Electrical:**

| Parameter | Value |
|-----------|-------|
| Impedance | Dual 2Ω (4Ω series, 1Ω parallel) |
| Power Handling (RMS) | 600W |
| Power Handling (Peak) | 1200W |
| Sensitivity | 83.6 dB @ 2.83V/1m |

**Physical:**

| Parameter | Value |
|-----------|-------|
| Overall Diameter | 10.5" (267 mm) |
| Cutout Diameter | 9.32" (237 mm) |
| Bolt Circle | 9.92" (252 mm) |
| Mounting Depth | 5.98" (152 mm) |
| Weight | 14.9 lbs (6.8 kg) |

---

## V3 Cabinet Sealed Box Parameters

### Per Cabinet (4 drivers sharing ~5.7 ft³ net)

| Parameter | Value |
|-----------|-------|
| Net Volume | 5.7 ft³ (161 L) |
| Volume per Driver | 1.42 ft³ (40.3 L) |
| **Qtc** | **0.88** |
| **Fc** | **37.8 Hz** |
| F3 (-3dB) | ~32 Hz (natural, no EQ) |
| F6 (-6dB) | ~26 Hz (natural, no EQ) |

### With Linkwitz Transform (Fc=38Hz → Fp=10Hz)

| Parameter | Value |
|-----------|-------|
| Target Fp | 10 Hz |
| Target Qp | 0.707 (Butterworth) |
| F3 (-3dB) | ~10 Hz |
| Boost @ 10Hz | ~19 dB |
| Subsonic HPF | 5 Hz, 24dB/oct |

---

## Cabinet Design (V3)

### External Dimensions

| Dimension | Value |
|-----------|-------|
| Width | 48.0" (1219 mm) |
| Height | 30.0" (762 mm) |
| Depth | 12.0" (305 mm) |

### Construction

| Component | Specification |
|-----------|---------------|
| Material | 3/4" MDF or Baltic Birch |
| Baffle | 1.5" (double layer) |
| Recess Depth | 1.5" |
| Bracing | Center vertical + horizontal cross |
| Finish | Black texture or veneer |
| Grille | Acoustically transparent fabric |

### Internal Volume

| Parameter | Value |
|-----------|-------|
| Gross Volume | 6.33 ft³ |
| Net Volume (after bracing) | ~5.7 ft³ |
| Per Driver | 1.42 ft³ (40.3 L) |

### Driver Layout (2×2 Array)

```
┌────────────────────────────────────────────────────┐
│                                                    │ 
│         ╭───────╮              ╭───────╮           │
│         │       │              │       │           │
│         │  D3   │              │  D4   │           │  30"
│         │       │              │       │           │
│         ╰───────╯              ╰───────╯           │
│                                                    │
│         ╭───────╮              ╭───────╮           │
│         │       │              │       │           │
│         │  D1   │              │  D2   │           │
│         │       │              │       │           │
│         ╰───────╯              ╰───────╯           │
│                                                    │
└────────────────────────────────────────────────────┘
                        48"
```

**Driver Center Positions (from baffle bottom-left):**
- D1: (13.75", 7.75")
- D2: (32.75", 7.75")
- D3: (13.75", 20.75")
- D4: (32.75", 20.75")

---

## Wiring Configuration

### Per Cabinet (4 drivers, 2s2p = 4Ω)

```
         ┌─────────────────┐
         │                 │
    ┌────┴────┐       ┌────┴────┐
    │ Driver 1 │       │ Driver 2 │
    │   4Ω     │       │   4Ω     │
    │  (2+2Ω)  │       │  (2+2Ω)  │
    └────┬────┘       └────┬────┘
         │ (series)        │
    ┌────┴────┐       ┌────┴────┐
    │ Driver 3 │       │ Driver 4 │
    │   4Ω     │       │   4Ω     │
    │  (2+2Ω)  │       │  (2+2Ω)  │
    └────┬────┘       └────┬────┘
         │                 │
         └────────┬────────┘
              (parallel)
                  │
          CABINET = 4Ω
```

**Voice Coil Wiring (per driver):**
- UMII10-22 is DVC 2+2Ω
- Wire voice coils in SERIES for 4Ω per driver
- 2 drivers series = 8Ω per pair
- 2 pairs parallel = 4Ω per cabinet

---

## Signal Chain (Per Couch)

```
Summed Subwoofer Signal (Mono)
              │
              ▼
        miniDSP 2x4 HD
              │
              ├─► Output 1 ──► NX6000 CH.A ──► Cabinet L (4Ω)
              └─► Output 2 ──► NX6000 CH.B ──► Cabinet R (4Ω)
```

### miniDSP 2x4 HD Processing

| Function | Setting |
|----------|---------|
| Biquad 1 | Linkwitz Transform (Fc=38Hz→Fp=10Hz, Qp=0.707) |
| Biquad 2 | Subsonic HPF 12dB/oct @ 5Hz |
| Biquad 3 | Subsonic HPF 12dB/oct @ 5Hz (cascaded = 24dB/oct) |
| Delay | 0 ms (adjust for alignment) |
| Gain | 0 dB (adjust during calibration) |

---

## Amplifier Selection

### Behringer NX6000 or NX6000D (Stereo Mode)

| Specification | Value |
|---------------|-------|
| Model | NX6000 / NX6000D |
| Price | $433-500 |
| Configuration | Stereo (one channel per cabinet) |

**Power Output (Real-World, Forum-Verified):**

| Frequency | Manufacturer Spec | Real-World |
|-----------|-------------------|------------|
| 40Hz+ | 3,000W/ch @ 4Ω | 1,600-2,000W/ch |
| 20-40Hz | 3,000W/ch @ 4Ω | 1,200-1,600W/ch |
| **<20Hz** | 3,000W/ch @ 4Ω | **800-1,200W/ch** |

**Per Couch:**
- 1× NX6000/NX6000D
- 1× miniDSP 2x4 HD
- 2× Cabinets (4Ω each)

---

## SPL & Power Analysis

### Target: 95 dB @ 10 Hz @ 18" Distance

| Parameter | Value |
|-----------|-------|
| Power Required | ~49W total |
| Power Available | ~2,000W (real-world @ 10Hz) |
| **Headroom** | **~16 dB** |

### Maximum Output (Amplifier-Limited)

| SPL Target | Power Required | Status |
|------------|----------------|--------|
| 95 dB | 49W | ✓ 16 dB headroom |
| 100 dB | 155W | ✓ 11 dB headroom |
| 105 dB | 490W | ✓ 6 dB headroom |
| 110 dB | 1,550W | ✓ Achievable |
| **111 dB** | **1,950W** | ⚠️ Near amp limit |

---

## Bill of Materials (Per Couch)

### Drivers

| Item | Qty | Unit Price | Total |
|------|-----|------------|-------|
| Dayton UMII10-22 (295-710) | 8 | $169.98 | $1,360 |

### Amplification & DSP

| Item | Qty | Unit Price | Total |
|------|-----|------------|-------|
| Behringer NX6000 | 1 | $433 | $433 |
| miniDSP 2x4 HD | 1 | $225 | $225 |

### Cabinet Materials (2 cabinets)

| Item | Qty | Unit Price | Total |
|------|-----|------------|-------|
| 3/4" MDF/Plywood 4×8 | 2 | ~$40 | ~$80 |
| Wood glue, screws, terminals | 1 | ~$50 | ~$50 |
| Gasket tape, damping | 1 | ~$30 | ~$30 |
| Grille fabric & frame | 2 | ~$25 | ~$50 |

### Wiring & Accessories

| Item | Qty | Unit Price | Total |
|------|-----|------------|-------|
| 12 AWG speaker wire (50ft) | 1 | ~$25 | ~$25 |
| Speakon connectors | 4 | ~$5 | ~$20 |
| XLR cables (6ft) | 2 | ~$10 | ~$20 |

### Cost Summary (Per Couch)

| Category | Cost |
|----------|------|
| Drivers (8×) | $1,360 |
| Amp + DSP | $658 |
| Cabinets (2×) | $210 |
| Wiring/Accessories | $65 |
| **Subtotal per Couch** | **$2,293** |

### Total System Cost (2 Couches)

| Category | Cost |
|----------|------|
| Drivers (16×) | $2,720 |
| Amps + DSP (2×) | $1,316 |
| Cabinets (4×) | $420 |
| Wiring/Accessories | $130 |
| **TOTAL** | **$4,586** |

---

## Placement

- 2 cabinets behind each couch
- 12-18" from listener's back
- Vertical centering at torso level
- Isolated drink platform on top (separate accessory)

---

## Related Documents

- `nearfield_cabinet/intermediates/config.py` - V3 cabinet configuration
- `miniDSP_2x4HD_Nearfield_LT_Config.txt` - DSP settings (needs biquad update for Fc=38Hz)
- `miniDSP_2x4HD_Setup_Guide.md` - Setup instructions
- `Behringer_NX6000_Reference.md` - Amplifier specifications

---

*Document Version: 3.0 (V3 Design)*  
*December 2024*  
*Updated: V3 cabinet design - 4 drivers/cabinet, 4 cabinets total*
