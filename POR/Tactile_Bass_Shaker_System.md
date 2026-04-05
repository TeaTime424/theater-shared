# Tactile Bass Shaker System

**Status:** Rack-mounted NX6000D, bridged configuration  
**Date:** December 2025  
**Role:** Seat-mounted tactile bass for kick/vibration

---

## Design Rationale

### Why Bass Shakers Instead of Nearfield Subs or Crowsons?

| Factor | Nearfield Subs | Crowson Transducers | Aura Pro Shakers |
|--------|----------------|---------------------|------------------|
| **Cost** | ~$4,200 | ~$2,600 | **~$1,670** |
| **Tactile delivery** | Air pressure | Mechanical lift | **Direct vibration** |
| **Infrasonic (5-15Hz)** | Weak | Excellent | Limited (Fs=40Hz) |
| **Kick/punch (20-60Hz)** | Good | Good | **Excellent** |
| **Installation** | 4 large cabinets | Under furniture legs | **Bolt to couch frame** |
| **Couch modification** | None | None (concrete OK) | Minor (bolt holes) |
| **Amp platform** | NX6000D (separate) | Dedicated amp | **Unified (NX6000D)** |
| **DIY complexity** | High (16 drivers, 4 cabs) | Low | **Very low** |

### Key Insight

With **8× UMII18-22** main subwoofers delivering **111.8 dB @ 20Hz**, the room is already fully pressurized with reference-level bass. The nearfield system's role (localized bass pressure) is redundant.

What's actually needed: **direct tactile vibration in the seat** for:
- Gunshots, explosions (20-40Hz punch)
- Engine rumble, thunder (30-60Hz texture)
- Musical kick drum (40-80Hz impact)

The Aura Pro's 20-80Hz range with Fs=40Hz is **perfectly matched** to this role. This is "low fidelity punch" — not audiophile precision.

---

## System Overview

| Parameter | Value |
|-----------|-------|
| Seating | 2 couches × 4 seats = 8 seats |
| Shakers per seat | 2 |
| **Total shakers** | **16** |
| Shaker model | Aura Pro AST-2B-4 |
| Amplifier | 1× Behringer NX6000D (bridged) |
| Location | Equipment rack on stage |

---

## Component Specifications

### Aura Pro AST-2B-4 Bass Shaker

| Spec | Value | Source |
|------|-------|--------|
| Price | $70 | Parts Express |
| Power (RMS) | 50W | Manufacturer |
| Power (Peak) | 100W | Manufacturer |
| Impedance | 4Ω | Manufacturer |
| Frequency range | 20-80 Hz | Manufacturer |
| Fs (resonance) | 40 Hz | Manufacturer |
| Force | 30 lbs/ft | Manufacturer |
| Dimensions | 6.2" dia × 2.5" H | Manufacturer |
| Weight | 3.25 lbs | Parts Express |

**Purchase Link:** https://www.parts-express.com/Aurasound-AST-2B-4-Pro-Bass-Shaker-299-028

### Behringer NX6000D Amplifier (Bridged Mode)

| Spec | Claimed | Real-World |
|------|---------|------------|
| Power @ 4Ω bridged | ~3,000W | **~1,600W** |
| Minimum impedance (bridged) | 4Ω | 4Ω |
| Rack size | 2U | — |
| Price | $519 | Adorama |

**Purchase Link:** https://www.adorama.com/benx6000d.html

---

## Wiring Configuration

### Bridged Mode: All 16 Shakers on Single Output

**Target impedance: 4Ω** (NX6000D bridged minimum)

**Configuration: 4S4P (4 series, 4 parallel groups)**

```
Group 1: Shakers 1-2-3-4 in series = 16Ω
Group 2: Shakers 5-6-7-8 in series = 16Ω
Group 3: Shakers 9-10-11-12 in series = 16Ω
Group 4: Shakers 13-14-15-16 in series = 16Ω

All 4 groups in parallel: 16Ω ÷ 4 = 4Ω total
```

### Physical Wiring Layout

```
NX6000D (Bridged Output)
         │
         │ ~25ft home run
         ▼
    ┌─────────────────┐
    │  FRONT COUCH    │
    │  Junction Box   │
    │                 │
    │  Seats 1-2-3-4  │
    │  (8 shakers)    │
    └────────┬────────┘
             │ ~15ft jumper
             ▼
    ┌─────────────────┐
    │  REAR COUCH     │
    │  (daisy chain)  │
    │                 │
    │  Seats 5-6-7-8  │
    │  (8 shakers)    │
    └─────────────────┘
```

**Total cable run: ~40ft** (vs 65ft with separate runs)

### Wiring Diagram (4S4P)

```
Amp (+) ───┬─── [S1]─[S2]─[S3]─[S4] ───┬─── Amp (-)
           │                           │
           ├─── [S5]─[S6]─[S7]─[S8] ───┤
           │                           │
           ├─── [S9]─[S10]─[S11]─[S12] ┤
           │                           │
           └─── [S13]─[S14]─[S15]─[S16]┘

Each series string: 4 × 4Ω = 16Ω
Four strings in parallel: 16Ω ÷ 4 = 4Ω total
```

### Junction Box Layout

**Front couch junction (under couch center):**
- Input: 14 AWG from rack
- Output 1: To front couch shakers (local)
- Output 2: 14 AWG jumper to rear couch

**Rear couch junction (under couch center):**
- Input: 14 AWG from front couch
- Output: To rear couch shakers (local)

---

## Power Analysis

| Metric | Value |
|--------|-------|
| NX6000D bridged @ 4Ω | ~1,600W real-world |
| Per shaker (÷16) | 100W |
| Shaker RMS rating | 50W |
| **Overpowered by** | **2× (3 dB)** |

### DSP Attenuation Required

Set output level **-3 dB** on DSP-408 output 5 to match shaker power handling:
- 1,600W × 0.5 = 800W total
- 800W ÷ 16 = **50W per shaker** ✓

---

## Signal Chain

```
Marantz AV10 (4× LFE out)
        ↓
   Dayton DSP-408 (4 in / 8 out)
        ↓
   ┌────┴────────────────┐
   │                     │
Outputs 1-4           Output 5
   ↓                     ↓
2× NX6000D           1× NX6000D
(main subs)          (bridged)
   ↓                     ↓
4 cabinets           16 shakers
```

### DSP-408 Output Assignment

| Output | Destination | Load | Mode |
|--------|-------------|------|------|
| 1 | NX6000D #1 Ch A → Front Left sub | 8Ω | Stereo |
| 2 | NX6000D #1 Ch B → Front Right sub | 8Ω | Stereo |
| 3 | NX6000D #2 Ch A → Rear Left sub | 8Ω | Stereo |
| 4 | NX6000D #2 Ch B → Rear Right sub | 8Ω | Stereo |
| 5 | NX6000D #3 Bridged → All 16 shakers | 4Ω | **Bridged** |
| 6 | (unused) | — | — |
| 7 | (unused) | — | — |
| 8 | (unused) | — | — |

---

## DSP Settings (via DSP-408)

### Output 5 (Shakers) Settings

| Parameter | Value | Purpose |
|-----------|-------|---------|
| Level | **-3 dB** | Match shaker power rating |
| High-pass | 20 Hz, 24dB/oct | Protect shakers from subsonic |
| Low-pass | 80 Hz, 24dB/oct | Keep shakers in optimal range |
| Delay | 0-5ms | Fine-tune if needed |

### Comparison to Main Subs

| Parameter | Main Subs (Out 1-4) | Shakers (Out 5) |
|-----------|---------------------|-----------------|
| Level | 0 dB (reference) | -3 dB |
| HPF | 20 Hz | 20 Hz |
| LPF | None (full LFE) | 80 Hz |
| Purpose | Acoustic pressure | Tactile vibration |

---

## Installation

### Shaker Mounting

1. **Identify mounting points** — Solid wood frame members under each seat position
2. **Drill pilot holes** — 4× holes per shaker using provided template
3. **Mount shakers** — #6 × 1" wood screws (Parts Express 081-1100)
4. **Orientation** — Shaker face toward seat bottom for maximum transfer
5. **Wire routing** — 14 AWG to junction box under couch

### Junction Box Wiring

**Front couch box:**
1. Receive home run from rack
2. Connect local 8 shakers in 2 series strings of 4
3. Parallel the 2 strings locally
4. Jumper out to rear couch

**Rear couch box:**
1. Receive jumper from front couch
2. Connect local 8 shakers in 2 series strings of 4
3. Parallel the 2 strings locally
4. Connect in parallel with front couch circuit

### Amplifier Setup (NX6000D #3)

1. Set mode switch to **BRIDGE**
2. Connect DSP-408 output 5 to **Channel A input**
3. Connect speaker cable to **Speakon output** (bridged taps)
4. Set gain to match other NX6000D units
5. Replace stock fans with Noctua NF-R8 redux-1800

---

## Unified Amplifier Platform

All bass amplification on NX6000D:

| System | Amps | Config | Load | Channels Used |
|--------|------|--------|------|---------------|
| Main subs | 2× NX6000D | Stereo | 8Ω | 4 |
| **Shakers** | **1× NX6000D** | **Bridged** | **4Ω** | **1** |
| Spare | 1× NX6000D | — | — | — |
| **Total** | **4× NX6000D** | | | **5** |

### Advantages

1. **Any amp can replace any other** (full interchangeability)
2. **Single spare covers entire bass infrastructure**
3. **Bulk fan purchase** (8 fans for 4 amps)
4. **Consistent thermal and reliability characteristics**
5. **Simplified troubleshooting**
6. **All electronics in equipment rack**

---

## Cost Summary

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| Aura Pro AST-2B-4 | 16 | $70 | $1,120 |
| NX6000D (shaker amp) | 1 | $519 | $519 |
| Noctua NF-R8 fans | 2 | $15 | $30 |
| 14 AWG speaker wire | 1 spool | ~$15 | $15 |
| Junction boxes + terminals | 2 | ~$10 | $20 |
| **Total Shaker System** | | | **~$1,704** |

---

## Comparison: Previous vs Current

| Factor | 4× BSA-200 (old plan) | 1× NX6000D Bridged |
|--------|----------------------|-------------------|
| Amp cost | $1,280 | **$549** |
| Location | Under couches | **Equipment rack** |
| Cable runs | 4 short local | **1 daisy-chain** |
| DSP outputs used | 4 | **1** |
| Fault = seats down | 2 | 16 |
| Platform | Separate | **Unified (NX6000D)** |
| Spare needed | BSA-200 ($320) | **Shared NX6000D** |

**Savings: $731 + unified spare strategy**

---

## Failure Impact Assessment

| If Shaker Amp Dies | Impact |
|-------------------|--------|
| Tactile effect | **Lost (all 16 shakers)** |
| Acoustic bass | **Unaffected (111.8 dB)** |
| Movie experience | Reduced but functional |
| Recovery time | 10-minute swap from spare |

For "low fidelity punch," this trade-off is acceptable. The main subs continue delivering reference-level bass regardless.

---

## Parts List Summary

| Part Number | Description | Qty | Unit | Total | Link |
|-------------|-------------|-----|------|-------|------|
| 299-028 | Aura Pro AST-2B-4 Bass Shaker | 16 | $70 | $1,120 | [Parts Express](https://www.parts-express.com/Aurasound-AST-2B-4-Pro-Bass-Shaker-299-028) |
| — | Behringer NX6000D | 1 | $519 | $519 | [Adorama](https://www.adorama.com/benx6000d.html) |
| — | Noctua NF-R8 redux-1800 (80mm) | 2 | $15 | $30 | [Amazon](https://www.amazon.com/dp/B00KF7OMTI) |
| 100-025 | 14 AWG Speaker Wire 50ft | 1 | $15 | $15 | [Parts Express](https://www.parts-express.com/14-AWG-2-Conductor-Speaker-Cable-50-ft.-100-025) |
| | **Total** | | | **~$1,704** | |

---

**Document Version:** 2.0  
**Created:** December 2025  
**Updated:** December 2025 — Rack-mounted NX6000D, bridged configuration  
**Supersedes:** BSA-200 distributed plan, nearfield subs, Crowson transducers
