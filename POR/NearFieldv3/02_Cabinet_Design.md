# V3 Nearfield Cabinet Design

## Cabinet Overview

| Parameter | Value |
|-----------|-------|
| Drivers | 4× UMII10-22 (2×2 array) |
| External | 48"W × 30"H × 12"D |
| Impedance | 4Ω (2s2p wiring) |
| Purpose | Behind-couch tactile subwoofer |

---

## External Dimensions

```
                              FRONT VIEW
                                 48"
        ◄────────────────────────────────────────────────────────►
        ┌────────────────────────────────────────────────────────┐ ▲
        │                                                        │ │
        │         ╭─────────╮              ╭─────────╮           │ │
        │         │         │              │         │           │ │
        │         │   D3    │              │   D4    │           │ │
        │         │ (10.5") │              │ (10.5") │           │ │
        │         │         │              │         │           │ │
        │         ╰─────────╯              ╰─────────╯           │ │
        │                                                        │ 30"
        │         ╭─────────╮              ╭─────────╮           │ │
        │         │         │              │         │           │ │
        │         │   D1    │              │   D2    │           │ │
        │         │ (10.5") │              │ (10.5") │           │ │
        │         │         │              │         │           │ │
        │         ╰─────────╯              ╰─────────╯           │ │
        │                                                        │ │
        └────────────────────────────────────────────────────────┘ ▼


                               SIDE VIEW
                                 12"
        ◄────────────────────────────────────►
        ┌────────────────────────────────────┐ ▲
        │ ┌──┬───────────────────────────────┤ │
        │ │  │                               │ │
        │ │B │       INTERNAL CAVITY         │ │
        │ │A │         (8.25" deep)          │ 30"
        │ │F │                               │ │
        │ │F │◄─ 1.5" baffle                 │ │
        │ │L │                               │ │
        │ │E │                               │ │
        │ └──┴───────────────────────────────┤ │
        └────────────────────────────────────┘ ▼
        │◄──►│
         1.5"
        recess
```

---

## Dimensional Breakdown

### External
| Dimension | Value |
|-----------|-------|
| EXT_W | 48.0" |
| EXT_H | 30.0" |
| EXT_D | 12.0" |

### Panel Thickness
| Component | Thickness |
|-----------|-----------|
| Standard panels | 0.75" |
| Baffle | 1.5" (2× 0.75") |

### Internal (derived)
| Dimension | Calculation | Value |
|-----------|-------------|-------|
| INT_W | 48 - 2×0.75 | 46.5" |
| INT_H | 30 - 2×0.75 | 28.5" |
| INT_D_TOTAL | 12 - 0.75 | 11.25" |
| Behind baffle | 11.25 - 3.0 | 8.25" |

### Recess/Baffle
| Parameter | Value |
|-----------|-------|
| Recess depth | 1.5" |
| Baffle thickness | 1.5" |
| Cleat position | 3.0" from front |

---

## Volume Calculation

```
Gross Volume = INT_W × INT_H × INT_D_BEHIND_BAFFLE
             = 46.5" × 28.5" × 8.25"
             = 10,932 in³
             = 6.33 ft³

Net Volume   = Gross × 0.9 (bracing/displacement)
             = 5.7 ft³

Per Driver   = 5.7 / 4
             = 1.42 ft³
             = 40.3 L
```

---

## Acoustic Parameters

| Parameter | Formula | Value |
|-----------|---------|-------|
| Qtc | Qts × √(1 + Vas/Vb) | 0.88 |
| Fc | Fs × √(1 + Vas/Vb) | 38 Hz |

```
Qtc = 0.72 × √(1 + 19.5/40.3) = 0.72 × 1.22 = 0.88
Fc  = 31  × √(1 + 19.5/40.3) = 31 × 1.22 = 37.8 Hz ≈ 38 Hz
```

---

## Driver Layout (2×2 Array)

### Center Positions (from baffle bottom-left internal corner)

| Driver | X Position | Y Position |
|--------|------------|------------|
| D1 (bottom-left) | 13.75" | 7.75" |
| D2 (bottom-right) | 32.75" | 7.75" |
| D3 (top-left) | 13.75" | 20.75" |
| D4 (top-right) | 32.75" | 20.75" |

### Spacing
| Dimension | Value |
|-----------|-------|
| Horizontal center-to-center | 19.0" |
| Vertical center-to-center | 13.0" |
| Horizontal edge clearance | 8.5" |
| Vertical edge clearance | 2.5" |
| Gap between frames (H) | 8.5" |
| Gap between frames (V) | 2.5" |

---

## Cut List (Per Cabinet)

### Main Panels

| Panel | Qty | Width | Height | Notes |
|-------|-----|-------|--------|-------|
| Back | 1 | 48.0" | 30.0" | Full external |
| Side | 2 | 11.25" | 30.0" | Depth minus back |
| Top | 1 | 46.5" | 11.25" | Between sides |
| Bottom | 1 | 46.5" | 11.25" | Between sides |
| Baffle Layer 1 | 1 | 46.5" | 28.5" | 4× cutouts |
| Baffle Layer 2 | 1 | 46.5" | 28.5" | 4× cutouts |

### Cleats (baffle support)

| Cleat | Qty | Length | Cross-section |
|-------|-----|--------|---------------|
| Side cleats | 2 | 28.5" | 0.75" × 0.75" |
| Top/bottom cleats | 2 | 45.0" | 0.75" × 0.75" |

### Bracing

| Brace | Qty | Dimensions | Notes |
|-------|-----|------------|-------|
| Vertical center | 1 | 3" × 27" × 0.75" | Between driver columns |
| Horizontal cross | 1 | 45" × 3" × 0.75" | Between driver rows |

---

## Driver Cutouts

| Parameter | Value |
|-----------|-------|
| Cutout diameter | 9.32" |
| Bolt circle | 9.92" |
| Bolt holes | 8× evenly spaced |
| Bolt size | 1/4" or M6 |

---

## Wiring Configuration (2s2p = 4Ω)

```
                    ┌─────────────────┐
                    │   SPEAKON (+)   │
                    │                 │
               ┌────┴────┐       ┌────┴────┐
               │ Driver 1 │       │ Driver 2 │
               │   4Ω     │       │   4Ω     │
               │ (VC: 2+2)│       │ (VC: 2+2)│
               └────┬────┘       └────┬────┘
                    │ series          │ series
               ┌────┴────┐       ┌────┴────┐
               │ Driver 3 │       │ Driver 4 │
               │   4Ω     │       │   4Ω     │
               │ (VC: 2+2)│       │ (VC: 2+2)│
               └────┬────┘       └────┬────┘
                    │                 │
                    └────────┬────────┘
                         parallel
                             │
                    ┌────────┴────────┐
                    │   SPEAKON (-)   │
                    │                 │
                    │  CABINET = 4Ω  │
                    └─────────────────┘
```

**Voice Coil Wiring:** Each driver's dual 2Ω voice coils wired in SERIES = 4Ω per driver

---

## Clearances

| Clearance | Value | Minimum | Status |
|-----------|-------|---------|--------|
| Driver rear | 1.75" | 1.0" | ✓ OK |
| Baffle to grille | 1.375" | 0.8" | ✓ OK |
| Driver edge (H) | 8.25" | 5.25" | ✓ OK |
| Driver edge (V) | 2.25" | 0" | ✓ OK |

---

## Construction Sequence

1. **Cut all panels** per cut list
2. **Laminate baffle** - glue two 0.75" layers
3. **Cut driver holes** - 9.32" diameter, 4 positions
4. **Drill bolt holes** - 8 per driver on 9.92" bolt circle
5. **Attach cleats** - 3.0" from front edge
6. **Assemble box** - back, sides, top, bottom
7. **Install bracing** - vertical center, horizontal cross
8. **Seal joints** - caulk all internal seams
9. **Add damping** - 1.5" acoustic foam on back/sides
10. **Install baffle** - screw to cleats with gasket
11. **Wire drivers** - 2s2p configuration
12. **Mount drivers** - bolt through baffle
13. **Install terminal** - rear panel
14. **Add grille** (optional) - acoustically transparent fabric

---

*Document Version: 3.0*
*Created: December 2024*
