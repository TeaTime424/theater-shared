# Dual-Opposed Vertical Subwoofer - Complete Specifications

**Target Volume:** ~12 cu ft gross (~6 cu ft per driver)  
**Driver:** Dayton Audio UMII18-22 × 2 (vertical opposed)  
**Configuration:** Sealed, force-canceling (one up, one down)  
**Form Factor:** Cube with corner legs  
**Corner Loading:** Full 3-wall boundary reinforcement (+12 dB @ 20Hz)

---

## 1. External Dimensions

| Dimension | Value | Notes |
|-----------|-------|-------|
| Width | 29.5" | Cubic form factor |
| Height | 29.5" | Cabinet only |
| Depth | 29.5" | Cubic form factor |
| Leg Height | 4.0" | Hardwood corner blocks |
| **Total Height** | **33.5"** | Cabinet + legs |

---

## 2. Internal Dimensions

| Dimension | Value | Notes |
|-----------|-------|-------|
| Width | 28.0" | 29.5 - 2×0.75 |
| Depth | 28.0" | 29.5 - 2×0.75 |
| Height | 27.25" | 29.5 - 0.75 (top) - 1.5 (bottom) |
| Gross Volume | 12.36 cu ft | 21,364 in³ |
| Net Volume | ~11.96 cu ft | After displacements |
| Per Driver | ~5.98 cu ft | Matches front-firing design target |

---

## 3. Driver Specifications (UMII18-22)

### Thiele-Small Parameters
| Parameter | Value | Notes |
|-----------|-------|-------|
| Impedance | 2+2 Ω | Wire series = 4Ω per driver |
| Fs | 22 Hz | Free-air resonance |
| Qts | 0.53 | Excellent for sealed |
| Vas | 248.2 L | 8.77 cu ft |
| Xmax | 28 mm | Klippel verified @ 70% BL |
| Power | 1,200 W RMS | AES 426B |
| SPL | 90.7 dB | @ 2.83V/1m |

### Physical Dimensions
| Parameter | Value |
|-----------|-------|
| Cutout Diameter | 16.875" |
| Bolt Circle | 17.75" (8 holes) |
| Overall Diameter | 18.5" |
| Mounting Depth | 9.75" |
| Weight | 47 lbs each |

### Driver Positions (Centered in Top/Bottom Panels)
| Driver | Location | Orientation |
|--------|----------|-------------|
| Top | Center of top panel | Face UP |
| Bottom | Center of bottom panel | Face DOWN |

---

## 4. Panel Cut List

### Shell Panels (0.75" MDF)

| Panel | Qty | Dimensions | Notes |
|-------|-----|------------|-------|
| Top | 1 | 29.5" × 29.5" | 16.875" center cutout, single thickness |
| Bottom | 2 | 29.5" × 29.5" | 16.875" center cutout, **LAMINATED to 1.5"** |
| Sides | 4 | 27.25" × 28.0" | Fit between top/bottom |
| **Shell Total** | 7 | | |

### Bracing (0.75" MDF)

| Component | Qty | Dimensions | Notes |
|-----------|-----|------------|-------|
| Window Brace | 2 | 28.0" × 4.0" | 12" center window cutout |

### Corner Legs (Hardwood)

| Component | Qty | Dimensions | Notes |
|-----------|-----|------------|-------|
| Leg Block | 4 | 3.5" × 3.5" × 4.0" | Oak, maple, or poplar |

---

## 5. Volume Calculation

```
GROSS INTERNAL VOLUME:
  Internal dimensions: 28" × 28" × 27.25"
  Volume: 28 × 28 × 27.25 = 21,364 in³ = 12.36 cu ft

DISPLACEMENTS:
  2× Drivers:     -0.234 cu ft  (0.117 each)
  2× Braces:      -0.12 cu ft   (0.06 each)  
  Wiring/misc:    -0.05 cu ft
  ─────────────────────────────
  Total:          -0.40 cu ft

NET INTERNAL VOLUME:
  12.36 - 0.40 = 11.96 cu ft

PER DRIVER:
  11.96 ÷ 2 = 5.98 cu ft ✓

SEALED BOX PARAMETERS:
  Vb per driver: 5.98 cu ft (169 L)
  Vas: 248.2 L
  Compliance ratio (α): 248.2/169 = 1.47
  Qtc: 0.53 × √(1.47+1) = 0.53 × 1.57 = 0.83
  Fc: 22 × 1.57 = 34.5 Hz
  F3: ~35 Hz (before room gain)
```

---

## 6. Panel Thickness Rationale

### Why Double the Bottom Panel

The bottom driver (47 lbs) hangs inverted from the bottom panel. Unlike the top driver which is supported by gravity compressing into its panel, the bottom driver creates:
- **Static tension load** on T-nuts and mounting bolts
- **Dynamic stress** during driver excursion
- **Risk of T-nut pullout** from single-thickness MDF

Doubling the bottom panel to 1.5" provides:
- Secure T-nut embedment depth
- Reduced panel flex during excursion
- Same approach used for vertical baffles in front-firing designs
- Peace of mind for a 47 lb driver hanging upside down for 20+ years

### Top Panel Remains Single Thickness

The top driver weight compresses INTO the panel, creating a stable load condition. Single 0.75" MDF is adequate.

---

## 7. Bracing System

### Window Brace Design
Two horizontal window braces positioned to avoid driver motor structures.

```
WINDOW BRACE (×2):

    ←────────────── 28.0" ──────────────→
    ┌──────────┬────────────┬──────────┐  ─┐
    │          │            │          │   │ 4.0"
    │   8.0"   │   12.0"    │   8.0"   │   │
    │          │  (window)  │          │   │
    └──────────┴────────────┴──────────┘  ─┘

    Window provides clearance for driver motor structures
    and allows sound pressure to equalize within cabinet.
```

### Brace Positions
| Brace | Distance from Panel (inside) | Purpose |
|-------|------------------------------|---------|
| Upper | 9.5" from top panel | Above top driver motor |
| Lower | 9.5" from bottom panel | Above bottom driver motor |

**Note:** Since bottom panel is now 1.5" thick, the lower brace is 11" from cabinet bottom exterior (1.5" + 9.5").

```
CROSS-SECTION (Side View):

    ┌─────────────────────────────┐ ← Top panel 0.75" (with driver)
    │  ████████████████████████  │ ← Top driver motor (~5" deep)
    │                             │
    │ ════════════════════════════│ ← Upper brace (9.5" from top)
    │                             │
    │        (open chamber)       │
    │                             │
    │ ════════════════════════════│ ← Lower brace (9.5" from bottom)
    │                             │
    │  ████████████████████████  │ ← Bottom driver motor (~5" deep)
    ╞═════════════════════════════╡ ← Bottom panel 1.5" (doubled)
```

---

## 8. Corner Leg System

### Design
Four solid hardwood blocks attached to cabinet corners, providing:
- 4" clearance for bottom driver airflow
- Stable support for ~289 lb cabinet
- Vibration isolation via rubber feet

### Leg Specifications
| Parameter | Value |
|-----------|-------|
| Material | Hardwood (oak, maple, poplar) |
| Dimensions | 3.5" × 3.5" × 4.0" |
| Quantity | 4 |
| Attachment | Screws from inside cabinet |
| Isolation | Rubber pads on bottom |

### Leg Positions
```
BOTTOM VIEW:

    ←────────────── 29.5" ──────────────→
    ┌───────────────────────────────────┐  ─┐
    │ ████                        ████ │   │
    │ ████                        ████ │   │
    │                                   │   │
    │         ┌─────────────┐          │   │
    │         │             │          │   │ 29.5"
    │         │   DRIVER    │          │   │
    │         │   CUTOUT    │          │   │
    │         └─────────────┘          │   │
    │                                   │   │
    │ ████                        ████ │   │
    │ ████                        ████ │   │
    └───────────────────────────────────┘  ─┘

    ████ = Leg position (3.5" × 3.5")
    Inset: 0.5" from cabinet edges
```

---

## 9. Hardware List

| Item | Quantity | Notes |
|------|----------|-------|
| 18ga × 2" brad nails | ~150 | Shell assembly |
| 18ga × 1¼" brad nails | ~50 | Braces |
| 1/4-20 × 2.5" bolts | 8 | Bottom driver (thicker panel) |
| 1/4-20 × 2" bolts | 8 | Top driver mounting |
| 1/4-20 T-nuts | 16 | Driver mounting |
| #10 × 2.5" wood screws | 16 | Leg attachment (4 per leg) |
| Terminal plate | 1 | Dual binding post |
| Gasket tape | 2 rolls | Driver sealing |
| Titebond III | 24 oz | Primary structural bond (extra for lamination) |
| Silicone caulk | 1 tube | Air sealing |
| Rubber pads | 4 | 3" diameter, adhesive-backed |
| Grille | 1 | Top driver protection |

---

## 10. Material Requirements

### MDF (0.75")
```
Panel areas:
  Top:          29.5 × 29.5 × 1 = 870 sq in = 6.04 sq ft
  Bottom:       29.5 × 29.5 × 2 = 1,740 sq in = 12.08 sq ft (doubled)
  Sides:        27.25 × 28.0 × 4 = 3,052 sq in = 21.19 sq ft
  Braces:       28.0 × 4.0 × 2 = 224 sq in = 1.56 sq ft
  ─────────────────────────────────────────────────────────
  Total:        5,886 sq in = 40.9 sq ft

Sheets required: 2× 4'×8' (64 sq ft available)
Waste allowance: ~36% (still comfortable margin)
```

### Hardwood (for legs)
```
4× blocks: 3.5" × 3.5" × 4.0"
Can be cut from: One 4×4 post × 18" length
Or: Laminate from 1" hardwood stock
```

---

## 11. Weight Estimate

| Component | Calculation | Weight |
|-----------|-------------|--------|
| Drivers (×2) | 47 lbs × 2 | 94 lbs |
| Top panel | 6.04 sq ft × 4.5 lbs | 27 lbs |
| Bottom panel (doubled) | 12.08 sq ft × 4.5 lbs | 54 lbs |
| Side panels (×4) | 21.19 sq ft × 4.5 lbs | 95 lbs |
| Window braces (×2) | 1.56 sq ft × 4.5 lbs | 7 lbs |
| Corner legs (×4) | ~1.5 lbs × 4 | 6 lbs |
| Hardware & misc | Estimate | 6 lbs |
| **TOTAL** | | **~289 lbs** |

---

## 12. Acoustic Performance

### Sealed Box Alignment
| Parameter | Value |
|-----------|-------|
| Qtc | 0.83 |
| Fc | 34.5 Hz |
| F3 (anechoic) | ~35 Hz |
| F3 (in-room) | ~22-25 Hz (with room gain) |
| Alignment | Slightly underdamped, extended bass |

### SPL Capability
Same as front-firing design:
- **109 dB @ 20Hz at MLP** (reference level, 450W/sub)
- **113 dB @ 20Hz at MLP** (peak, 1,200W/sub)
- **+4 to +8 dB headroom** above THX Reference

### Force Cancellation Benefit
- Opposing drivers eliminate net cabinet reaction force
- Reduces cabinet vibration and "walking"
- Reduces transmitted vibration to floor/structure
- Allows lighter bracing than front-firing equivalent

---

## 13. Comparison to Front-Firing Design

| Parameter | Front-Firing (30×48×21.5) | Dual-Opposed (29.5 cube) |
|-----------|---------------------------|--------------------------|
| External dimensions | 30" × 48" × 21.5" | 29.5" × 29.5" × 29.5" |
| Height (with legs) | 48" | 33.5" |
| Footprint | 645 sq in | 870 sq in |
| Gross volume | 12.47 cu ft | 12.36 cu ft |
| Net volume | ~11.93 cu ft | ~11.96 cu ft |
| Per driver | ~6.0 cu ft | ~5.98 cu ft |
| Weight | ~250 lbs | ~289 lbs |
| Force cancellation | No | Yes |
| Bracing complexity | High (5 U-braces) | Lower (2 window braces) |
| SPL @ 20Hz | 109 dB | 109 dB |

---

## 14. Quick Reference

```
╔════════════════════════════════════════════════════════════╗
║  DUAL-OPPOSED VERTICAL SUBWOOFER                          ║
║  Force-Canceling Corner-Loaded Design                     ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║  EXTERNAL:  29.5" × 29.5" × 29.5" (cube)                  ║
║  WITH LEGS: 29.5" × 29.5" × 33.5" total height            ║
║  WEIGHT:    ~289 lbs                                       ║
║                                                            ║
║  INTERNAL:  28.0" × 28.0" × 27.25"                        ║
║  VOLUME:    12.36 cu ft gross, ~6.0 cu ft per driver      ║
║                                                            ║
║  DRIVERS:   2× Dayton UMII18-22 (47 lbs each)            ║
║    Top:     Centered, face UP (with grille)               ║
║    Bottom:  Centered, face DOWN (into leg gap)            ║
║    Cutout:  16.875" diameter                              ║
║    Bolts:   17.75" bolt circle, 8 holes per driver        ║
║                                                            ║
║  PANELS:                                                   ║
║    Top:     29.5" × 29.5" × 0.75" (single)               ║
║    Bottom:  29.5" × 29.5" × 1.5" (DOUBLED)               ║
║    Sides:   27.25" × 28.0" × 0.75" (×4)                  ║
║                                                            ║
║  BRACING:   2× Window braces (28" × 4" with 12" window)  ║
║    Upper:   9.5" from top panel                           ║
║    Lower:   9.5" from bottom panel                        ║
║                                                            ║
║  LEGS:      4× Hardwood blocks (3.5" × 3.5" × 4")        ║
║    Inset:   0.5" from cabinet corners                     ║
║    Feet:    Rubber isolation pads                         ║
║                                                            ║
║  MATERIALS: 2× MDF sheets (4'×8'×0.75")                   ║
║             1× Hardwood 4×4 × 18"                         ║
║                                                            ║
║  PERFORMANCE:                                              ║
║    Qtc:     0.83                                           ║
║    F3:      ~35 Hz (anechoic), ~22 Hz (in-room)          ║
║    SPL:     109 dB @ 20Hz at MLP                          ║
║    Corner:  +12 dB boundary gain                          ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
```

---

*Complete Specifications — Dual-Opposed Vertical Subwoofer*
*Document Version: 1.1 (doubled bottom panel)*
*Created: 2025*
