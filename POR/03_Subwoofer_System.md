# Subwoofer System
## Home Theater System - Rev 5.9

**Document Purpose:** Complete subwoofer system design, specifications, and performance analysis.

**Last Updated:** December 2025 - "Weapons-Grade Bass" configuration (16× UMII18-22)

---

## System Overview

### Configuration Summary

**Total Subwoofer Drivers:** 16× Dayton UMII18-22 (18-inch)

| Subsystem | Drivers | Enclosures | Location | Target |
|-----------|---------|------------|----------|--------|
| Main Array | 8× UMII18-22 | 8× triangular (2 per corner) | 4 corners, floor-to-ceiling columns | Room fill @ 20Hz |
| Front Nearfield | 4× UMII18-22 | 2× dual-driver (16 cu ft each) | Riser face, 15" from chest | Chest impact @ 15Hz |
| Rear Nearfield | 4× UMII18-22 | 2× dual-driver (25 cu ft each) | Floor-standing tower, 15" from chest | Chest impact @ 15Hz |
| **Total** | **16 drivers** | **12 enclosures** | | |

**Tactile Complement:** 16× Aura Pro bass shakers (seat-mounted, separate from subwoofers)

### System Metrics

| Metric | Value | Context |
|--------|-------|---------|
| Total cone area | **20.4 sq ft** (18,944 cm²) | Larger than a sheet of plywood |
| Total displacement/stroke | **3.24 cu ft** (53,040 cm³) | 40× per second at 40Hz |
| Peak system output @ 20Hz | **~130 dB** (combined nearfield) | Louder than a jet at 100 feet |
| Main array @ 20Hz @ MLP | **~113 dB** | +8 dB over THX reference |
| Nearfield @ 15Hz @ 15" | **~120+ dB** | Chest compression territory |
| Total driver weight | **560 lbs** | 16 × 35 lbs |
| Amplifier power (rated) | **~17,000W** | 6× NX6000D |

---

## Driver Selection

**Model:** Dayton Audio UMII18-22 Ultimax II 18-inch Subwoofer
- Quantity: **16 drivers** (2 per enclosure × 8 enclosures)
- Unit cost: $349.98 each
- Total driver cost: **$5,600**
- Official specification sheet: `295718daytonaudioUMII1822specsheet.pdf`

### Verified Thiele-Small Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Fs (resonance) | **22 Hz** | Excellent for nearfield 15Hz target |
| Qts (total Q) | 0.53 | Ideal for sealed alignment |
| Qes (electrical Q) | 0.67 | |
| Qms (mechanical Q) | 2.53 | |
| Vas | 248.2 L (8.77 ft³) | |
| Xmax | **28 mm** | Klippel verified @ 70% BL |
| Sd | 1,184 cm² (183.5 sq in) | |
| Vd | **3,315 cm³** per driver | |
| Re (DC resistance) | 4.2Ω | Voice coils in series |
| Mms (moving mass) | 420g | |
| BL (motor strength) | 19.2 T·m | |
| Sensitivity | 90.7 dB @ 2.83V/1m | |
| Voice coil config | Dual 2Ω | All specs with coils in series = 4Ω |
| RMS Power | 1,200W | AES 426B standard |
| Peak Power | 2,400W | |

### Why UMII18-22 for Nearfield (vs smaller drivers)

The 22Hz Fs is critical for 15Hz nearfield operation:

| Driver | Fs | EQ Needed @ 15Hz | Amp Derating | Total Penalty | Verdict |
|--------|-----|------------------|--------------|---------------|---------|
| UMII10 | 39Hz | +16 dB | +4 dB | -20 dB | Unusable |
| UMII12 | 31Hz | +12 dB | +4 dB | -16 dB | Weak |
| UMII15 | 29Hz | +11 dB | +4 dB | -15 dB | Moderate |
| **UMII18** | **22Hz** | **+6 dB** | **+4 dB** | **-10 dB** | **Reference** |

The UMII18's low Fs minimizes the EQ boost required, preserving headroom despite NX6000D ULF derating.

### Xmax / Xmech Research

Forum research (AVS Forum, diyAudio, Data-bass) confirms the UMII18-22's robustness:

| Parameter | Value | Source |
|-----------|-------|--------|
| Xmax (spec) | 28 mm | Parts Express / Klippel verified |
| Xmech (estimated) | ~35-40 mm | Based on "over 2 inch" travel and forum analysis |
| Safety margin | 7-12 mm | Between Xmax and Xmech |

**Key findings:**
- "I can't recall a death by over excursion" - AVS Forum consensus
- Dual mirror-imaged spiders provide gradual soft limiting
- Operating at 75% Xmax leaves comfortable safety margin

---

## DSP / Linkwitz Transform Configuration

The triangular corner subwoofers have massive headroom (+14 dB over THX LFE reference at passband). This excess can be "traded" for low frequency extension via Linkwitz Transform.

**See detailed analysis:** `triangular_corner_sub/Linkwitz_Transform_Analysis.md`

### Recommended Configuration: LT to 14 Hz

| Parameter | Value |
|-----------|-------|
| Original Fc | 31.4 Hz |
| LT Target Fc | **14 Hz** |
| F3 Extension | 17 Hz improvement |
| Passband Attenuation | -14 dB |
| Subsonic HPF | 11 Hz, 24 dB/oct |
| Max Excursion @ 115 dB | 21 mm (75% Xmax) |
| Excursion Headroom | 25% |

### DSP Signal Chain

```
Input → Gain (-14 dB) → Linkwitz Transform (31→14 Hz) → 11 Hz HPF → Output
```

### Performance Summary

| Frequency | SPL (after EQ) | Excursion |
|-----------|----------------|----------|
| 10 Hz | 103 dB | 17.5 mm |
| 14 Hz | 111 dB | 17.6 mm |
| 20 Hz | 114 dB | 9.9 mm |
| 80 Hz | 115 dB | 0.2 mm |

This extends flat 115 dB response down to 14 Hz - well into infrasonic territory - while keeping excursion within safe limits.

---

## Wiring Configuration

### Individual Driver Wiring: 4Ω per Driver

Each driver gets its own amplifier channel. No series pairs — maximizes amp headroom and enables per-driver DSP control.

**Voice coil wiring (per driver):**
- Coil A (2Ω) + Coil B (2Ω) in SERIES = **4Ω per driver**

```
Amp Ch1 (+) ── Driver 1 VC+ ─[2Ω]─ VC- ─[2Ω]─ VC+ ── Amp Ch1 (-)
                                                         Total: 4Ω

Amp Ch2 (+) ── Driver 2 VC+ ─[2Ω]─ VC- ─[2Ω]─ VC+ ── Amp Ch2 (-)
                                                         Total: 4Ω
```

Each corner enclosure has 2 drivers on 2 separate amp channels (1× ICEpower 1200AS2 module per corner).

### Power Distribution

| System | Load | Amp Power @ 4Ω | Per Driver | Driver Xmax Limit | Amp Utilization |
|--------|------|----------------|------------|-------------------|-----------------|
| Corner subs (8 drivers, 4 modules) | 4Ω each | 1,200W | 1,200W | 700W @ 20Hz | 58% at Xmax |

**Design rationale:** At 700W the driver reaches mechanical Xmax (28mm). The amp delivers 1,200W but the driver limits at 700W — amp at 58% utilization. This ensures the driver is always the limiter, not the amplifier. No clipping, clean transient peaks.

---

## Amplification

### Unified NX6000D Platform

**Total Amplifiers:** 6× Behringer NX6000D

| Unit | System | Config | Load | Channels |
|------|--------|--------|------|----------|
| NX6000D #1 | Main subs FL/FR | Stereo | 8Ω | 2 |
| NX6000D #2 | Main subs RL/RR | Stereo | 8Ω | 2 |
| NX6000D #3 | Front nearfield (2 cabs) | Stereo | 8Ω | 2 |
| NX6000D #4 | Rear nearfield (2 cabs) | Stereo | 8Ω | 2 |
| NX6000D #5 | Bass shakers (16×) | Bridged | 4Ω | 1 |
| NX6000D #6 | **Spare** | Any | Any | — |

### Amplifier Specifications

| Spec | Value |
|------|-------|
| Model | Behringer NX6000D |
| Topology | Class D with SmartSense |
| Power @ 8Ω stereo | ~850W/ch (real-world) |
| Power @ 4Ω bridged | ~1,600W (real-world) |
| Rack size | 2U |
| Price | $549 each (with fan mod) |

### Fan Modification (Required)

Stock fans are ~40 dB (unsuitable for theater). Replace with:
- **Noctua NF-R8 redux-1800** (80mm, 12V)
- Modified noise: ~17 dB
- Cost: $15/fan × 2 fans × 6 amps = **$180**

### Cost Summary

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| NX6000D amplifiers | 6 | $519 | $3,114 |
| Noctua NF-R8 fans | 12 | $15 | $180 |
| **Total Amplification** | | | **$3,294** |

---

## DSP and Room Correction

### Dayton DSP-408 Configuration

**Inputs:** 4× discrete LFE feeds from Marantz AV10

**Output Assignment:**

| Output | Destination | Amp | Load | Level |
|--------|-------------|-----|------|-------|
| 1 | Front Left main sub | NX6000D #1 Ch A | 8Ω | 0 dB |
| 2 | Front Right main sub | NX6000D #1 Ch B | 8Ω | 0 dB |
| 3 | Rear Left main sub | NX6000D #2 Ch A | 8Ω | 0 dB |
| 4 | Rear Right main sub | NX6000D #2 Ch B | 8Ω | 0 dB |
| 5 | Front nearfield L | NX6000D #3 Ch A | 8Ω | TBD |
| 6 | Front nearfield R | NX6000D #3 Ch B | 8Ω | TBD |
| 7 | Rear nearfield L | NX6000D #4 Ch A | 8Ω | TBD |
| 8 | Rear nearfield R | NX6000D #4 Ch B | 8Ω | TBD |

**Note:** Bass shakers fed separately from DSP-408 output (requires Y-split or second DSP input).

### Signal Flow

```
Marantz AV10 (4× LFE out)
        ↓
   Dayton DSP-408 (4 in / 8 out)
        ↓
   ┌────┴────────────────────────────────┐
   │              │              │       │
Outputs 1-2   Outputs 3-4   Outputs 5-6  Outputs 7-8
   ↓              ↓              ↓          ↓
NX6000D #1    NX6000D #2    NX6000D #3  NX6000D #4
   ↓              ↓              ↓          ↓
FL/FR main    RL/RR main    Front NF    Rear NF

Bass Shakers: Separate feed → NX6000D #5 (bridged)
```

### Critical DSP Settings

**High-Pass Filtering (Driver Protection):**
- All subwoofer outputs: **20 Hz HPF**, 24 dB/oct LR
- Shakers: 20 Hz HPF, 80 Hz LPF

**Nearfield Level Adjustment:**
- Initial setting: -6 to -10 dB relative to mains
- Final setting: Determined by calibration and preference
- Purpose: Blend chest impact without overwhelming room

---

## NX6000D ULF Power Derating

The NX6000D exhibits reduced power output below 30Hz (common in Class D designs):

| Frequency | Power @ 8Ω | % of 40Hz | Notes |
|-----------|------------|-----------|-------|
| 40 Hz+ | ~850W | 100% | Full power |
| 30 Hz | ~850W | ~100% | Minimal derating |
| 25 Hz | ~800W | ~94% | |
| **20 Hz** | **~750W** | **~88%** | Main sub target |
| **15 Hz** | **~600W** | **~71%** | Nearfield target |
| 10 Hz | ~450W | ~53% | Below system range |

### Impact on Performance

**Main Subs @ 20Hz:** Derated power still delivers **~111 dB @ MLP** (+6 dB over THX)

**Nearfield @ 15Hz:** 
- NX6000D delivers ~71% power at 15Hz
- UMII18's low Fs (22Hz) requires only +6dB EQ boost
- Combined penalty: ~10 dB (vs 20 dB for UMII10)
- Result: **~120+ dB @ 15" chest level** — still crushing

---

## Performance Summary

### Main Subwoofer Array (8× UMII18-22 in Triangular Columns)

| Metric | Value | vs THX 105dB |
|--------|-------|--------------|
| SPL @ 40Hz @ MLP | ~114 dB | +9 dB |
| SPL @ 30Hz @ MLP | **~115 dB** | **+10 dB** |
| **SPL @ 20Hz @ MLP** | **~113 dB** | **+8 dB** |
| SPL @ 15Hz @ MLP | **~108 dB** | **+3 dB** |

### Nearfield Arrays (8× UMII18-22 total)

| Metric | Value | Notes |
|--------|-------|-------|
| Distance | 15" from chest | Optimal for pressure sensation |
| SPL @ 20Hz @ 15" | ~125 dB | Per nearfield pair |
| **SPL @ 15Hz @ 15"** | **~120+ dB** | Chest compression |
| Combined front+rear | ~130 dB | "Weapons-grade" |

### System Totals

| System | Drivers | Displacement | Power |
|--------|---------|--------------|-------|
| Main array | 8× UMII18 | 26,520 cm³ | ~3,400W |
| Front nearfield | 4× UMII18 | 13,260 cm³ | ~1,700W |
| Rear nearfield | 4× UMII18 | 13,260 cm³ | ~1,700W |
| **Total** | **16× UMII18** | **53,040 cm³** | **~6,800W** |

**Displacement per stroke:** 3.24 cubic feet — equivalent to 25× SVS SB-16 Ultra subwoofers.

---

## Enclosure Specifications

### Main Subwoofers — Triangular Corner Columns (8 cabinets)

**Design Philosophy:** Floor-to-ceiling triangular columns that integrate into room corners as acoustic panels. Two 4' cabinets per corner (split-build, joined-install) maintain optimal driver positioning for corner loading while enabling manageable construction.

#### Front Corners (Floor-Based)

**Configuration:** Both drivers in BOTTOM cabinet, close to floor for maximum corner loading.

```
FRONT CORNERS — FLOOR-BASED:

  ┌─────────┐ ← 96" (ceiling)
  │▒▒▒▒▒▒▒▒▒│
  │▒▒▒▒▒▒▒▒▒│  TOP CABINET
  │▒▒▒▒▒▒▒▒▒│  (volume only)
  │▒▒▒▒▒▒▒▒▒│  ~130 lbs
  ╠═════════╣ ← 48" (sealed joint)
  │▒▒▒▒▒▒▒▒▒│
  │▒▒┌───┐▒▒│
  │▒▒│(•)│▒▒│ ← Upper driver ~32" AFF
  │▒▒└───┘▒▒│  BOTTOM CABINET
  │▒▒┌───┐▒▒│  (both drivers)
  │▒▒│(•)│▒▒│ ← Lower driver ~11" AFF (corner loaded!)
  │▒▒└───┘▒▒│  ~180 lbs
  └─────────┘ ← Floor (0")
       ↑
     FLOOR = corner loading boundary
```

| Parameter | Bottom Cabinet | Top Cabinet |
|-----------|----------------|-------------|
| Internal dimensions | 24" × 24" × 48" | 24" × 24" × 48" |
| Drivers | **2× UMII18-22** | **None** (volume only) |
| Lower driver center | ~11" AFF | — |
| Upper driver center | ~32" AFF | — |
| Weight | ~180 lbs | ~130 lbs |

#### Rear Corners (Platform-Penetrating)

**Configuration:** Column penetrates through 24" platform. Drivers clustered near platform level for corner loading at platform boundary. Driver positions INVERTED vs front corners.

```
REAR CORNERS — PLATFORM-PENETRATING:

  ┌─────────┐ ← 96" (ceiling)
  │▒▒▒▒▒▒▒▒▒│
  │▒▒▒▒▒▒▒▒▒│  TOP CABINET
  │▒▒▒▒▒▒▒▒▒│  (driver at BOTTOM)
  │▒▒┌───┐▒▒│  ~130 lbs
  │▒▒│(•)│▒▒│ ← Upper driver ~51" AFF (3" above joint)
  │▒▒└───┘▒▒│
  ╠═════════╣ ← 48" (sealed joint)
  │▒▒┌───┐▒▒│
  │▒▒│(•)│▒▒│ ← Lower driver ~27" AFF (3" above platform)
  │▒▒└───┘▒▒│  BOTTOM CABINET
══╬═════════╬══ ← 24" PLATFORM (column penetrates)
  │▒▒▒▒▒▒▒▒▒│  (driver at TOP)
  │▒▒▒▒▒▒▒▒▒│  ~180 lbs
  │▒▒▒▒▒▒▒▒▒│  (volume below platform)
  └─────────┘ ← Floor (0")
       ↑
     PLATFORM = corner loading boundary
```

| Parameter | Bottom Cabinet | Top Cabinet |
|-----------|----------------|-------------|
| Internal dimensions | 24" × 24" × 48" | 24" × 24" × 48" |
| Drivers | **1× UMII18-22 (at TOP)** | **1× UMII18-22 (at BOTTOM)** |
| Driver center | ~27" AFF (3" above platform) | ~51" AFF (3" above joint) |
| Weight | ~180 lbs | ~130 lbs |

**Why This Works:**
- Platform acts as acoustic boundary (solid, massive at 20 Hz)
- Lower driver is 3" above platform — excellent boundary coupling
- Full 96" column height = same volume as front corners
- Corner loading gain: **+10-12 dB** (identical to floor-based)

#### Cabinet Specifications Summary

| Parameter | Front Corners | Rear Corners |
|-----------|---------------|---------------|
| Total height | 96" | 96" |
| Bottom cabinet | Both drivers (11"/32") | Single driver at TOP (27") |
| Top cabinet | Volume only | Single driver at BOTTOM (51") |
| Volume per driver | 10.25 cu ft | 10.25 cu ft |
| Fc | 30 Hz | 30 Hz |
| Qtc | 0.72 | 0.72 |
| Corner boundary | Floor (0") | Platform (24") |
| Corner loading | +10-12 dB | +10-12 dB |

#### Combined Performance (Per Corner)

| Parameter | Value |
|-----------|-------|
| Total internal height | 96" |
| Gross internal volume | 16 cu ft |
| Net volume | ~15.2 cu ft |
| Virtual (stuffed) | **~20.5 cu ft** |
| Per driver | **~10.25 cu ft** |
| Fc | **~30 Hz** |
| Qtc | **~0.72** (optimal Butterworth) |
| Corner loading | **Full** (+10-12 dB) |

#### Why Split-Build?

| Benefit | Details |
|---------|--------|
| Manageable weight | 180 lbs + 130 lbs vs 310 lb monolith |
| Fits through doors | 4' cabinets navigate standard doorways |
| Two-person install | Bottom cabinet is heaviest, still manageable |
| Shop flexibility | Build on workbench, not floor |
| Transport | Fits in SUV/truck bed |
| Identical acoustics | Same total volume when joined |

#### Sealed Joint Design (Battle-Ready)

These subs will be abused. The joint uses **dual-seal construction** for absolute reliability:

```
CROSS-SECTION AT JOINT:

    TOP CABINET
    ┌──────────────────────────────────────┐
    │                                      │
    │      ┌────────────────────────┐      │
    │      │   INTERNAL BATTEN      │←─────┼── Screwed to top cabinet
    │      │   (spans joint 1.5"    │      │
    │      │    into each cabinet)  │      │
    ├──────┴────────────────────────┴──────┤
    │██████████████████████████████████████│←── Butyl rope tape (primary seal)
    ├──────┬────────────────────────┬──────┤
    │      │   INTERNAL BATTEN      │      │
    │      │   (continuous with     │←─────┼── Screwed to bottom cabinet  
    │      │    top section)        │      │
    │      └────────────────────────┘      │
    │                                      │
    │             ◉         ◉              │←── T-nut + bolt locations
    │                                      │
    └──────────────────────────────────────┘
    BOTTOM CABINET
```

**Sealing Components:**

| Component | Specification | Purpose |
|-----------|---------------|--------|
| Butyl rope tape | 3/8" diameter, continuous bead | Primary seal — never cures, self-healing |
| Internal batten | 3/4" × 3" × full perimeter, triangular | Spans joint, redundant seal path, rigidity |
| T-nuts | 1/4"-20, embedded in top cabinet flange | Threaded anchor points |
| Machine screws | 1/4"-20 × 2", 10 per cabinet | Clamping force, ~8" spacing |
| Wood screws | #10 × 1.5", 12 per batten section | Batten attachment |

**Bolt Pattern (10 bolts, ~8" spacing):**

```
FLANGE TOP VIEW (triangular):

           ╱╲
          ╱  ╲
         ╱ ◉  ╲
        ╱      ╲
       ╱ ◉    ◉ ╲
      ╱          ╲
     ╱ ◉        ◉ ╲
    ╱              ╲
   ╱ ◉     ◉     ◉ ╲
  ╱__________________╲
     ◉          ◉

  ◉ = T-nut + bolt location (10 total)
```

**Assembly Procedure:**

1. **Install T-nuts** in top cabinet flange (drill pilot, hammer flush)
2. **Attach batten sections** to each cabinet (glue + screw)
3. **Dry fit** — verify alignment, test-fit bolts
4. **Apply butyl rope** — continuous 3/8" bead on bottom cabinet flange
5. **Position top cabinet** — align bolt holes, lower carefully
6. **Insert bolts** — hand-tighten all, then torque in star pattern
7. **Verify squeeze-out** — butyl visible around entire perimeter confirms seal
8. **Smoke test** — incense near seam while playing 20 Hz tone
9. **Install OC 703** — covers joint, completes appearance

**Why This Seal Survives Abuse:**

| Challenge | How It's Handled |
|-----------|------------------|
| Pressure cycling (20+ Hz) | Butyl flexes, never fatigues |
| Peak excursion events | Batten prevents joint separation |
| Vibration/resonance | 10 bolts distribute load evenly |
| Temperature cycling | Butyl stable -20°F to 200°F |
| Long-term creep | Batten provides mechanical backup |
| Transport/repositioning | Joint is structural, not just sealed |

#### Physical Layout

```
PLAN VIEW (corner cross-section):

              WALL
               │
    ═══════════╪═══════════
               │╲
               │ ╲  24" (internal)
               │  ╲
               │   ╲▒▒▒▒  ← 2" OC 703
    ═══════════╪════╲════
         24"   │     ╲
      (internal)      ↑
                  Hypotenuse (~34")
                  faces room
```

```
FRONT VIEW (one corner, two stacked cabinets):

    ┌─────────────────────────┐ ← 96" (ceiling)
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│ ← Upper cabinet
    │▒▒▒▒▒▒┌─────────┐▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒│   (•)   │▒▒▒▒▒▒▒▒│ ← Driver (cutout in OC 703)
    │▒▒▒▒▒▒└─────────┘▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    ├─────────────────────────┤ ← 48" (cabinet junction)
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒┌─────────┐▒▒▒▒▒▒▒▒│ ← Lower cabinet
    │▒▒▒▒▒▒│   (•)   │▒▒▒▒▒▒▒▒│ ← Driver (cutout in OC 703)
    │▒▒▒▒▒▒└─────────┘▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    └─────────────────────────┘ ← Floor
    
    ▒ = 2" OC 703 rigid fiberglass
    All wrapped in AT fabric (Guilford FR701 or similar)
    
           ← ~35" →
```

#### Driver Height Positions

| Corner | Lower Driver | Upper Driver | Boundary | Notes |
|--------|--------------|--------------|----------|-------|
| Front Left | **11" AFF** | **32" AFF** | Floor | Both drivers in bottom cab |
| Front Right | **11" AFF** | **32" AFF** | Floor | Both drivers in bottom cab |
| Rear Left | **27" AFF** | **51" AFF** | Platform | Drivers split between cabs |
| Rear Right | **27" AFF** | **51" AFF** | Platform | Drivers split between cabs |

**Corner Loading Preserved:** 
- Front corners: Drivers at 11" and 32" above floor boundary
- Rear corners: Drivers at 3" and 27" above platform boundary (24" AFF)
- All drivers within optimal coupling distance of their corner boundary
- Full corner loading gain of **+10-12 dB** maintained for all corners

**Modal Distribution Benefit:** Different driver heights front vs rear (11"/32" vs 27"/51") excite different vertical room modes, potentially improving bass uniformity across listening positions.

#### Integrated Acoustic Treatment

The 2" OC 703 face provides significant mid/high frequency absorption:

| Frequency | Absorption Coefficient |
|-----------|------------------------|
| 125 Hz | 0.17 |
| 250 Hz | 0.86 |
| 500 Hz | 1.14 |
| 1000 Hz | 1.07 |

**Total treatment area:** 8 cabinets × ~11 sq ft each = **~88 sq ft**

This replaces the need for separate corner bass traps and provides substantial room treatment as a bonus.

#### Performance vs Previous Design

| Metric | Old (8 cu ft box) | New (Triangular Split) | Improvement |
|--------|-------------------|------------------------|-------------|
| Volume/driver | 4 cu ft | **10.25 cu ft** | +156% |
| Fc | 39 Hz | **30 Hz** | -9 Hz |
| Qtc | 0.95 (peaky) | **0.72 (optimal)** | Flatter |
| Corner loading | +11 dB | **+11 dB** | **Maintained** |
| 20 Hz @ MLP | +3 dB | **+8 dB** | **+5 dB** |
| 15 Hz @ MLP | -3 dB | **+3 dB** | **+6 dB** |
| Footprint | 3.0 sq ft × 4 | **2.1 sq ft × 8** | -33% per unit |
| Visual integration | Freestanding boxes | **Architectural columns** | Invisible |
| Bonus treatment | None | **~88 sq ft absorption** | Free |

#### Wiring (Main Subs)

Each driver has voice coils wired in series (4Ω). Two drivers per corner wired in series = 8Ω load.

**Front Corners (both drivers in bottom cabinet):**
```
Amp Ch (+) ─── Bottom Cab Driver 1 (+) ───[4Ω]─── Driver 1 (-)
                                                    │
                Bottom Cab Driver 2 (-) ───[4Ω]─── Driver 2 (+) ─── Amp Ch (-)

Both drivers in same cabinet, series wired internally
Total load: 4Ω + 4Ω = 8Ω per corner
```

**Rear Corners (drivers split between cabinets):**
```
Amp Ch (+) ─── Bottom Cab Driver (+) ───[4Ω]─── Bottom Cab Driver (-)
                                                    │
                                              (cable through joint)
                                                    │
                Top Cab Driver (-) ───[4Ω]─── Top Cab Driver (+) ─── Amp Ch (-)

Drivers in separate cabinets, series wired via cable through sealed joint
Total load: 4Ω + 4Ω = 8Ω per corner
```

**Note:** Rear corners require speaker cable to pass through the sealed joint between cabinets. Route cable through a small grommet-sealed hole in the batten/flange area before applying butyl seal.

**Amp assignment:**
- NX6000D #1 Ch A: Front Left corner @ 8Ω
- NX6000D #1 Ch B: Front Right corner @ 8Ω
- NX6000D #2 Ch A: Rear Left corner @ 8Ω
- NX6000D #2 Ch B: Rear Right corner @ 8Ω

#### Material Cost (8 Cabinets + Sealing Hardware)

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| 3/4" plywood sheets | 6 | $45 | $270 |
| Bracing lumber | — | — | $60 |
| Polyfill (~48 lbs total) | — | — | $72 |
| OC 703 2" (24×48 panels) | 8 | $25 | $200 |
| AT fabric (Guilford FR701) | 40 ln ft | $5 | $200 |
| Internal battens (3/4"×3") | 32 ln ft | $1 | $32 |
| Butyl rope tape (3/8") | 4 rolls | $12 | $48 |
| T-nuts (1/4"-20) | 40 | $0.50 | $20 |
| Machine screws (1/4"-20×2") | 40 | $0.40 | $16 |
| Wood screws (#10×1.5") | 100 | $0.10 | $10 |
| Hardware (misc) | — | — | $50 |
| **Total** | | | **$978** |

**Note:** Previous 8 cu ft rectangular design was ~$700 for 4 enclosures. New design adds ~$200 for dramatically improved performance and integrated treatment.

### Nearfield Subwoofers (4 enclosures)

| Parameter | Front Pair | Rear Pair |
|-----------|------------|-----------|
| Configuration | Dual-driver sealed | Dual-driver sealed |
| Location | Riser face (built-in) | Floor-standing console tower |
| Physical volume | **16 ft³ per enclosure** | **25 ft³ per enclosure** |
| Stuffing | Heavy polyfill (~16 lbs each) | Heavy polyfill (~25 lbs each) |
| Virtual volume | **~22 ft³ per enclosure** | **~34 ft³ per enclosure** |
| Fc | **~30 Hz** | **~27 Hz** |
| Qtc | **~0.71** | **~0.65** |
| Distance to listener | ~15" from row 1 chest | ~15" from row 2 chest |
| Amplification | 1× NX6000D stereo @ 8Ω | 1× NX6000D stereo @ 8Ω |
| SPL @ 15 Hz @ 15" | ~121 dB | **~123 dB** |
| 15 Hz headroom vs 8 cu ft | +5 dB | **+7 dB** |
| Orientation | Forward-firing | Forward-firing |
| Finish | Fabric-wrapped (match riser) | Furniture-grade |

**Front Nearfield Enclosure Details:**

The front nearfield enclosures extend deep into the riser cavity, taking advantage of the 8-foot platform depth:

| Dimension | Value |
|-----------|-------|
| External width | ~46" |
| External height | ~22" |
| External depth | **~34"** |
| Physical volume | ~16 cu ft |
| Stuffing | Heavy polyfill (1 lb/cu ft) |
| Virtual volume | ~22 cu ft (11 cu ft/driver) |
| Riser depth used | 34" of 96" available |

**Performance gain vs 8 cu ft unstuffed:**

| Metric | 8 cu ft (old) | 16 cu ft stuffed | Improvement |
|--------|---------------|------------------|-------------|
| Fc | 39 Hz | **30 Hz** | -9 Hz |
| Qtc | 0.95 | **0.71** | Flatter |
| EQ needed @ 15 Hz | +16.5 dB | **+11 dB** | 5.5 dB less |
| Headroom @ 15 Hz | Baseline | **+5 dB** | Free output |

**Rear Nearfield Enclosure Details:**

The rear nearfield enclosures are floor-standing console towers extending from floor to usable-surface height (60"), taking advantage of the full vertical space:

| Dimension | Value |
|-----------|-------|
| External width | ~36" (each side of 84" console) |
| External height | **~60"** (floor to top surface) |
| External depth | ~24" |
| Physical volume | ~25 cu ft |
| Stuffing | Heavy polyfill (1 lb/cu ft) |
| Virtual volume | ~34 cu ft (17 cu ft/driver) |
| Driver height | ~42-48" from floor (chest level) |

**Performance gain vs on-platform design:**

| Metric | On platform (14 cu ft) | To floor (25 cu ft stuffed) | Improvement |
|--------|------------------------|----------------------------|-------------|
| Fc | 31 Hz | **27 Hz** | -4 Hz |
| Qtc | 0.74 | **0.65** | Flatter |
| EQ needed @ 15 Hz | +13 dB | **+9 dB** | 4 dB less |
| Headroom @ 15 Hz | +4 dB | **+7 dB** | +3 dB |

---

## Nearfield Tactile Perception Analysis

The nearfield subwoofer system's output vastly exceeds human tactile perception thresholds across the entire operating band. This isn't marginal — the system operates 10-15 dB above "strong tactile" levels, firmly in chest-compression territory.

### Tactile Perception Thresholds vs System Output

| Frequency | Feel Threshold | "Strong" Tactile | System @ 15" | Margin Over Strong |
|-----------|----------------|-------------------|--------------|--------------------|
| 15 Hz | ~100-105 dB | ~110-115 dB | 120-122 dB | **+7-10 dB** |
| 20 Hz | ~95-100 dB | ~105-110 dB | 124-125 dB | **+15-19 dB** |
| 30 Hz | ~90-95 dB | ~100-105 dB | 128+ dB | **+23+ dB** |

Thresholds based on published psychoacoustic research for infrasonic/low-frequency tactile perception (chest, torso). Values represent air-coupled pressure sensation, not mechanical vibration (which the bass shakers provide separately).

### Nearfield Acoustic Coupling

Standard T-S box models (WinISD, etc.) apply inverse-square distance correction when estimating SPL at the listening position. At 15" from an 18" driver operating at 15 Hz, this assumption is conservative — the listener is in the acoustic nearfield transition zone where the driver behaves more like a plane-wave source than a point source.

**Why models underestimate nearfield SPL:**
- Wavelength at 15 Hz: ~75 feet
- Driver radius: ~9 inches
- Listening distance: 15 inches (1.7× driver radius)
- Driver is not a point source at this ratio — approaching piston-in-baffle behavior

**Measured data (Mehlau nearfield subwoofer comparisons):**
- "The efficiency of a subwoofer is increased by about 10 dB when placed in the near field"
- Inverse-square alone predicts +8.4 dB (1m → 0.38m)
- Measured nearfield gain: **+10 dB** (1.6 dB more than model)
- Corroborated by AVS Forum community data: room dominates response beyond 1-2 feet

**Impact on performance estimates:**

| Metric | Box Model (inverse-square) | With Measured Coupling | Delta |
|--------|---------------------------|------------------------|-------|
| Front NF @ 15 Hz | ~118 dB | **~120 dB** | +2 dB |
| Rear NF @ 15 Hz | ~120 dB | **~122 dB** | +2 dB |
| Shortfall vs original target | ~3 dB | **~1 dB** | Within JND |

The ~1 dB residual shortfall at 15 Hz is within measurement uncertainty and below the just-noticeable difference threshold. Original design targets are effectively met.

### Context: Community Nearfield Builds

The AVS Forum nearfield subwoofer community consistently describes the effect from **single 12-15" drivers** at similar distances as "violent," "addictive," and "chest compression." This system deploys **dual 18" drivers per seat** with 28mm Xmax each — roughly 4-6× the displacement per seat of typical community builds.

The practical question is not whether the effect will be perceptible, but whether attenuation will be needed to keep it from being overwhelming. This is the correct design position — headroom to dial back means every viewer experiences the effect at their comfort level without the system ever straining.

### Three-Layer Bass Architecture

The nearfield subs are one layer of a three-tier system, each targeting different perceptual mechanisms:

| Layer | System | Mechanism | Frequency Focus | Sensation |
|-------|--------|-----------|-----------------|----------|
| 1 | Main array (8× UMII18) | Room pressurization | 20-80 Hz | Envelopment, weight |
| 2 | Nearfield subs (8× UMII18) | Air-coupled chest pressure | 15-40 Hz | Chest compression, breath |
| 3 | Bass shakers (16× Aura Pro) | Mechanical seat vibration | 30-80 Hz | Punch, rumble, impact |

All three layers are independently level-adjustable via the DSP-408, allowing precise blending per content type and viewer preference. The nearfield channel initial calibration target is -6 to -10 dB relative to mains, with final setting determined by preference testing.

### Verification Opportunity

A real-world nearfield coupling test can be performed with the existing 3.75 cu ft Dayton sealed sub kit:

1. Place sealed sub on surface, measure SPL at 1 meter (REW + UMIK-1)
2. Move mic to 15 inches without changing level
3. Compare delta between measurements

**Expected results:**
- Delta = +8.4 dB: Inverse-square holds exactly (no nearfield bonus)
- Delta = +10 to +12 dB: Nearfield coupling confirmed (consistent with Mehlau data)
- Delta = +12 to +14 dB: Strong plane-wave effect, exceeds predictions

The delta is driver-geometry dependent, not box dependent — same 18" cone at same 15" distance produces the same coupling ratio regardless of enclosure volume. This test is optional given strong existing measured data, but available for final validation.

---

## Tactile Bass System

**Retained from Rev 5.7:** 16× Aura Pro bass shakers

The bass shakers complement the nearfield subs by providing direct seat vibration:

| System | Role | Frequency Focus |
|--------|------|-----------------|
| Main subs | Room pressurization | 20-80 Hz |
| Nearfield subs | Chest impact/pressure | 15-40 Hz |
| Bass shakers | Seat vibration/punch | 30-80 Hz |

See: `Tactile_Bass_Shaker_System.md` for shaker details.

---

## Upgrade Path

### SpeakerPower SP2-8000-HT

If NX6000D ULF derating proves problematic:

| Spec | NX6000D | SP2-8000-HT |
|------|---------|-------------|
| Price (×4 for main+nearfield) | $2,196 | $11,996 |
| Power @ 8Ω @ 20Hz | ~750W (derated) | 1,500W (full) |
| Power @ 8Ω @ 15Hz | ~600W (derated) | 1,500W (full) |
| Frequency response | Derates &lt;30Hz | 5Hz-500Hz flat |

**Recommendation:** Start with NX6000D. System already delivers +6 dB over THX at 20Hz and ~120+ dB nearfield at 15Hz. Upgrade only if real-world testing reveals deficiency.

---

## Cost Summary

### Driver and Enclosure Costs

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| UMII18-22 drivers | 16 | $349.98 | $5,600 |
| Main enclosures (8× triangular + sealing + OC 703 + AT fabric) | 8 | ~$122 | $978 |
| Front nearfield (riser integration + polyfill) | 1 | ~$450 | $450 |
| Rear nearfield (console tower + polyfill) | 1 | ~$550 | $550 |
| **Subtotal Drivers/Enclosures** | | | **$7,578** |

### Amplification Costs

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| NX6000D amplifiers | 6 | $519 | $3,114 |
| Noctua NF-R8 fans | 12 | $15 | $180 |
| **Subtotal Amplification** | | | **$3,294** |

### Bass Shaker Costs (from Rev 5.7)

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| Aura Pro AST-2B-4 | 16 | $70 | $1,120 |
| (Amp included in NX6000D count above) | — | — | — |
| Wiring/junction boxes | — | — | $35 |
| **Subtotal Shakers** | | | **$1,155** |

### Wiring and Miscellaneous

| Item | Cost |
|------|------|
| Speaker cable (14 AWG) | $100 |
| Speakon connectors | $80 |
| Terminal cups/binding posts | $120 |
| **Subtotal Wiring** | **$300** |

### Grand Total (LF System)

| Category | Cost |
|----------|------|
| Drivers and enclosures | $7,578 |
| Amplification | $3,294 |
| Bass shakers | $1,155 |
| Wiring/misc | $300 |
| **Complete LF System** | **$12,327** |

---

## AVS Forum Signature Block

```
LF SYSTEM:
├── Mains: 8× Dayton UMII18-22 (triangular corner columns, split-build/joined-install)
├── Nearfield: 8× Dayton UMII18-22 (riser + console tower)
├── Tactile: 16× Aura Pro Bass Shakers
├── Amplification: 6× Behringer NX6000D (17,000W)
├── DSP: Dayton DSP-408
├── Total Displacement: 53,040 cm³ / 3.24 cu ft per stroke
└── Integrated Treatment: ~88 sq ft OC 703 (corner columns)

"Yes, all 16 are 18-inch. And they disappear into the corners."
```

---

**Document Version:** 3.0 (Weapons-Grade Bass)
**Created:** November 22, 2025
**Updated:** December 2025 — 16× UMII18-22 configuration
