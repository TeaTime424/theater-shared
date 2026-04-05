# Speaker System
## Home Theater System - Rev 7.0

**Document Purpose:** LCR, surround, and Atmos speaker specifications and placement.  
**Last Updated:** March 10, 2026 — Rev 7.0: Denon AVR-A1H replaces Buckeye separates; target level -10 dB reference (95 dB)

---

## Speaker System Overview

| Channel Group | Model | Quantity | Sensitivity | Impedance |
|---------------|-------|----------|-------------|-----------|
| LCR | Titan-815LX | 3 | 99 dB | 6Ω (4.2Ω min) |
| Surrounds | Volt-10 | 4 | 95 dB | 8Ω |
| Atmos | Volt-10 | 6 | 95 dB | 8Ω |
| **Total** | | **13** | | |

---

## Main Channels (LCR)

### DIYSG Titan-815LX

**Model:** DIY Sound Group Titan-815LX (all three channels matched)

| Parameter | Value | Source |
|-----------|-------|--------|
| **Sensitivity** | 99 dB @ 2.83V/1m | DIYSG |
| **Impedance** | 6Ω nominal | Matt Grant (HiFi Circuit) |
| **Minimum Impedance** | 4.2Ω @ 110 Hz | Matt Grant (HiFi Circuit) |
| **Power Handling** | 400W (with 80 Hz crossover) | Matt Grant |
| **Cabinet Tuning** | 40 Hz (ported) | Matt Grant |
| **Recommended Crossover** | 60-80 Hz | Matt Grant |
| **Minimum Crossover** | 40 Hz (with good room gain) | Matt Grant |

**Source Citation:** HiFi Circuit forum, Matt Grant, August 5, 2023  
http://www.hificircuit.com/community/threads/anything-on-the-815xl-anything-like-comparison-to-the-615xl-or-818xl.5944/

**Placement:**
- Location: On stage deck (27" elevation), behind 170" acoustically transparent screen
- Mounted on Sorbothane isolation pucks
- Spacing: Optimized for screen width and acoustic performance

### Speaker Isolation

**Product:** Sorbothane 50 Durometer Hemispheres
- Size: 1.5" diameter × 0.5" thick (hemisphere shape)
- Durometer: 50 (optimal for Titan-815LX weight range)
- Load capacity: 20-30 lbs per puck at optimal compression
- Quantity per speaker: 4 pucks (rectangular pattern)
- Total system: 12 pucks (3 speakers × 4 pucks)
- Cost: $72-96 total ($6-8 per puck)

**Purpose:**
- Decouples speakers from stage deck vibration
- Eliminates structure-borne vibration transmission
- Preserves clean imaging and soundstage
- Essential at reference system investment level

---

## Surround & Atmos Channels

### DIYSG Volt-10 (10 total)

**Model:** DIY Sound Group Volt-10 V2

| Parameter | Value | Source |
|-----------|-------|--------|
| **Sensitivity** | 95 dB @ 2.83V/1m | DIYSG official spec |
| **Impedance** | 8Ω nominal | DIYSG |
| **Power Range** | 10-450W | DIYSG |
| **Frequency Response** | 70 Hz - 20 kHz (sealed) | DIYSG |
| **Crossover Point** | 2000 Hz | DIYSG |
| **Woofer** | Denovo Audio CX-10 (custom Eminence Beta-10CX) | DIYSG |
| **Compression Driver** | Custom Celestion CDX1-1446 | DIYSG |

**Source:** https://www.diysoundgroup.com/volt-10-v2.html

⚠️ **Note:** Previous documentation incorrectly listed sensitivity as 98 dB. The correct specification per DIYSG is **95 dB**.

### Surround Configuration (4 speakers)

**Side Surrounds (positions SL, SR):**
- Quantity: 2
- Placement: Side walls at seating height
- Distance to listener: ~10 ft

**Rear Surrounds (positions SBL, SBR):**
- Quantity: 2
- Placement: Rear wall, mounted above backrest
- Height: 66-72 inches from floor
- Distance to listener: ~10 ft

### Atmos Configuration (6 speakers)

**Front Atmos (positions FL, FR, FC):**
- Quantity: 3
- Placement: Ceiling above front stage area
- Distance to listener: ~12 ft

**Rear Atmos (positions RL, RR, RC):**
- Quantity: 3
- Placement: Ceiling above rear seating
- Distance to listener: ~10 ft

### Why Volt-10 for All Surround/Atmos

**Coaxial Design Advantages:**
- Point source (compression driver fires through woofer center)
- Superior off-axis response
- Consistent sound across multiple seating positions
- Ideal for ceiling mounting
- Better phase coherence

**vs. HT-12 (traditional design):**
- HT-12 optimized for LCR behind-screen duty
- Volt-10 optimized for surround/Atmos applications
- $47/speaker cost savings
- Better off-axis performance for multi-row theater

---

## Amplifier Matching

### Target Level: -10 dB Reference (95 dB)

The system targets -10 dB below THX Reference (95 dB at MLP) rather than full reference (105 dB). This is the typical listening level for enthusiast home theaters and the level at which the owner's current system reaches uncomfortable SPL. All headroom calculations below are against the 95 dB target.

### Amplification: Denon AVR-A1H Internal Amps

All 15 speaker channels are driven by the AVR-A1H's built-in amplification:
- **Rated power:** 150W × 15 @ 8Ω (2ch driven, 20-20kHz, 0.05% THD)
- **All-channels-driven:** ~105W @ 8Ω, ~200W @ 4Ω (estimated)
- **Pre-outs available:** 17.4ch XLR + RCA if external amps ever needed

### LCR Channels (Titan-815LX)

| Parameter | AVR-A1H | Notes |
|-----------|---------|-------|
| Power @ 6Ω | ~200W | Estimated (current-capable design) |
| SPL @ 1m | 122 dB | 99 dB + 23 dB |
| SPL @ Row 1 (13 ft) | ~106 dB | After distance + room losses |
| SPL @ Row 2 (18 ft) | ~102 dB | After distance + room losses |
| vs -10 dB Target (95 dB) | **+7 to +11 dB** | Comfortable headroom at both rows |

**Crossover:** 60-80 Hz (subwoofers handle below)

### Surround/Atmos Channels (Volt-10)

| Parameter | AVR-A1H | Notes |
|-----------|---------|-------|
| Power @ 8Ω | ~105-150W | All-channels to 2ch driven |
| SPL @ 1m | 117 dB | 95 dB + 22 dB |
| SPL @ 10 ft (surrounds) | ~107 dB | |
| SPL @ 12 ft (Atmos front) | ~106 dB | |
| vs -10 dB Target (95 dB) | **+11 to +12 dB** | Substantial headroom |

**Crossover:** 80 Hz (subwoofers handle below)

**Note:** All channels exceed the 95 dB target by 7+ dB — more than sufficient for any realistic listening scenario. The AVR-A1H's pre-outs allow adding external amplification for LCR if full THX Reference (105 dB) is ever desired.

---

## Complete Speaker/Amplifier Matrix

**Amplifier:** Denon AVR-A1H (all 15 channels internal)
**Target:** -10 dB Reference (95 dB at MLP)

| Channel | Speaker | Sensitivity | Impedance | Est. Power | SPL @ Seat | vs 95 dB Target |
|---------|---------|-------------|-----------|------------|------------|-----------------|
| L | Titan-815LX | 99 dB | 6Ω | ~200W | ~102-106 dB | +7 to +11 dB |
| C | Titan-815LX | 99 dB | 6Ω | ~200W | ~102-106 dB | +7 to +11 dB |
| R | Titan-815LX | 99 dB | 6Ω | ~200W | ~102-106 dB | +7 to +11 dB |
| SL | Volt-10 | 95 dB | 8Ω | ~105-150W | ~105-107 dB | +10 to +12 dB |
| SR | Volt-10 | 95 dB | 8Ω | ~105-150W | ~105-107 dB | +10 to +12 dB |
| SBL | Volt-10 | 95 dB | 8Ω | ~105-150W | ~105-107 dB | +10 to +12 dB |
| SBR | Volt-10 | 95 dB | 8Ω | ~105-150W | ~105-107 dB | +10 to +12 dB |
| Atmos FL | Volt-10 | 95 dB | 8Ω | ~105-150W | ~104-106 dB | +9 to +11 dB |
| Atmos FR | Volt-10 | 95 dB | 8Ω | ~105-150W | ~104-106 dB | +9 to +11 dB |
| Atmos FC | Volt-10 | 95 dB | 8Ω | ~105-150W | ~104-106 dB | +9 to +11 dB |
| Atmos RL | Volt-10 | 95 dB | 8Ω | ~105-150W | ~105-107 dB | +10 to +12 dB |
| Atmos RR | Volt-10 | 95 dB | 8Ω | ~105-150W | ~105-107 dB | +10 to +12 dB |
| Atmos RC | Volt-10 | 95 dB | 8Ω | ~105-150W | ~105-107 dB | +10 to +12 dB |

**Note:** SPL range reflects Row 1 (13 ft) to Row 2 (18 ft). All channels exceed target with substantial margin.

---

## Cost Summary

| Item | Qty | Unit Price | Total |
|------|-----|------------|-------|
| Titan-815LX | 3 | ~$1,600 | $4,800 |
| Volt-10 | 10 | $242 | $2,420 |
| Sorbothane isolation | 12 | $7 | $84 |
| **Total Speakers** | | | **$7,304** |

---

## Amplifier Configuration

**Denon AVR-A1H — 15 internal channels (9.4.6)**

All speaker channels driven by the AVR-A1H's built-in Class AB amplification (150W × 15 @ 8Ω rated). No external speaker amplifiers required.

**Growth Path:** The A1H provides 17.4ch pre-outs (XLR + RCA). If full THX Reference (105 dB) is ever desired, external amplification can be added for LCR channels without replacing the processor.

---

## Real-World Validation

### Comparison to Owner's Current Triad System

The AVR-A1H amplifier selection is validated by comparing against the owner's current system:

| Channel | Current (Triad) | New (DIYSG + AVR-A1H) | Improvement |
|---------|-----------------|----------------------|-------------|
| LCR | Gold/6 LCR (89-92 dB) + ATI 200W | Titan-815LX (99 dB) + AVR-A1H ~200W | **+7 to +9 dB** |
| Surrounds | Gold/4 (87 dB) + ATI 200W | Volt-10 (95 dB) + AVR-A1H ~105-150W | **+7 dB** |
| Atmos | Gold/8 Omni SE (~87 dB) + Denon 100W | Volt-10 (95 dB) + AVR-A1H ~105-150W | **+10 dB** |

**Key Finding:** Current Triad system reaches uncomfortable listening levels at -10 dB on volume dial, yet operates **4-9 dB below THX Reference** at maximum output. The -10 dB reference target (95 dB) is validated as the appropriate design target.

**Conclusion:** New system provides +7 to +10 dB more headroom than the proven-adequate current system at the -10 dB reference target. AVR-A1H internal amplification is more than sufficient.

---

*Document Version: 4.0 (Rev 7.0)*
*Created: November 22, 2024*
*Updated: March 10, 2026*
*Changes: Rev 7.0 — Denon AVR-A1H replaces Marantz AV10 + Buckeye separates; target level -10 dB reference (95 dB); all channels driven by AVR-A1H internal amplification*
