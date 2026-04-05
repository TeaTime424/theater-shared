# Rear Vertical Subwoofer - MDF Cutting Layout and Construction Guide
## Home Theater System - Construction Document

**Document Purpose:** Complete cutting layout, measurements, and assembly instructions for the rear vertical subwoofer enclosures (quantity: 2 units).

**Source:** Derived from Home_Theater_System_Complete_Design_Rev5_2.md
**Created:** November 25, 2025
**Revised:** Corrected baffle inset design

---

## 1. Design Overview

### Design Concept

The enclosure is a **box with an inset baffle**. The sides, top, and bottom panels extend **3" forward** from the front face of the baffle, creating a protective recess for the drivers. The front of the box is open (no front panel) - you look directly at the baffle set back 3" from the box edges.

```
SIDE CROSS-SECTION:

    ┌─────────────────────────────────────┬──────┬─────┐
    │                                     │      │     │
    │                                     │ 1.5" │ 3"  │ ← Sides extend 3" past baffle
    │      SEALED VOLUME                  │DOUBLE│recess
    │      (behind baffle)                │BAFFLE│     │
    │                                     │      │     │
    │         16.75" depth               │      │     │ ← FRONT (open)
    │                                     │      │     │
    │                                     │      │     │
    └─────────────────────────────────────┴──────┴─────┘
    BACK                              
    
    ←───────────────── 22" total depth ────────────────→
```

### Finished Enclosure Specifications

| Parameter | Value | Notes |
|-----------|-------|-------|
| **External Width** | 30" | Box outer dimension |
| **External Height** | 48" | Box outer dimension |
| **External Depth** | 22" | Box outer dimension (increased for 12.5 ft³) |
| **Baffle Inset** | 3" | Distance from front face to baffle |
| **Baffle Thickness** | 1.5" | Double layer (2× 3/4" MDF laminated) |
| **Sealed Volume** | 12.85 ft³ gross | Behind baffle (28.5" × 46.5" × 16.75") |
| **Net Volume** | ~12.0 ft³ | After braces, drivers, wiring displacement |
| **Baffle Size** | 28.5"W × 46.5"H | Fits inside box (2 layers) |
| **Drivers** | 2× Dayton Audio UMII18-22 | Vertically stacked |

### Construction Materials (per enclosure)

| Material | Specification | Quantity |
|----------|---------------|----------|
| MDF | 3/4" (0.75" / 19mm) | ~1.9 sheets (4×8) |
| Wood Glue | Titebond III or equivalent | 16 oz |
| Screws | #8 × 2" wood screws | ~60 |
| Cleats | 3/4" × 3/4" MDF or hardwood | 10 linear feet |
| T-Nuts | 1/4"-20 | 16 per enclosure |
| Acoustic Caulk | Silicone or polyurethane | 1 tube |
| Binding Posts | Heavy-duty speaker terminals | 1 pair |

---

## 2. Panel Cut List (3/4" MDF)

### Cut List Summary

```
╔════════════════════════════════════════════════════════════════════════╗
║                    PANEL CUT LIST (PER ENCLOSURE)                      ║
╠════════════════════════════════════════════════════════════════════════╣
║  Panel           │  Width    │  Height/Depth │  Qty │  Notes           ║
╠══════════════════╪═══════════╪═══════════════╪══════╪══════════════════╣
║  Back Panel      │  30.00"   │  48.00"       │   1  │  Full external   ║
║  Top Panel       │  30.00"   │  22.00"       │   1  │  Full W × D      ║
║  Bottom Panel    │  30.00"   │  22.00"       │   1  │  Full W × D      ║
║  Left Side       │  22.00"   │  46.50"       │   1  │  Fits inside T/B ║
║  Right Side      │  22.00"   │  46.50"       │   1  │  Fits inside T/B ║
║  Baffle Layer 1  │  28.50"   │  46.50"       │   1  │  Driver cutouts  ║
║  Baffle Layer 2  │  28.50"   │  46.50"       │   1  │  Driver cutouts  ║
╚══════════════════╧═══════════╧═══════════════╧══════╧══════════════════╝

Total MDF area: ~58 ft² per enclosure (~1.9 sheets of 4×8)
(Includes double-thickness baffle)
```

### Dimension Derivation

```
EXTERNAL BOX: 30"W × 48"H × 22"D

Assembly Method: Butt joints with glue and screws
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│  • Back Panel: Full external W × H                                 │
│    30" × 48"                                                       │
│                                                                     │
│  • Top Panel: Full external W × D                                  │
│    30" × 22" (sits on top of assembly)                            │
│                                                                     │
│  • Bottom Panel: Full external W × D                               │
│    30" × 22" (base of assembly)                                   │
│                                                                     │
│  • Side Panels: Full depth × (Height - top - bottom)              │
│    22" × (48" - 0.75" - 0.75") = 22" × 46.5"                      │
│    (Sides fit between top and bottom panels)                       │
│                                                                     │
│  • Baffle: Internal width × Internal height (DOUBLE THICKNESS)    │
│    (30" - 0.75" - 0.75") × (48" - 0.75" - 0.75")                  │
│    = 28.5" × 46.5" × 2 LAYERS                                     │
│    (Two 3/4" MDF panels laminated = 1.5" total)                   │
│    (Mounts inside box on cleats, 3" from front)                   │
│                                                                     │
│  INTERNAL SEALED VOLUME (behind baffle):                           │
│  • Width:  30" - 1.5" = 28.5"                                     │
│  • Height: 48" - 1.5" = 46.5"                                     │
│  • Depth:  22" - 0.75"(back) - 1.5"(baffle) - 3"(recess) = 16.75"│
│  • Volume: 28.5 × 46.5 × 16.75 = 22,198 in³ = 12.85 ft³ (GROSS)   │
│  • Net Volume: ~12.0 ft³ (after ~0.85 ft³ displacement)           │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 3. Baffle Layout with Driver Cutouts

### Driver Specifications (Dayton Audio UMII18-22)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Overall Diameter | 18.50" (470mm) | Frame OD |
| **Cutout Diameter** | **16.80"** (426.7mm) | Required hole size |
| Mounting Hole Circle | 17.60" (447mm) | Bolt circle diameter |
| Mounting Depth | 10.18" (258.5mm) | Magnet protrusion |
| Mounting Holes | 8 × 1/4" | Evenly spaced |

### Baffle Dimensions and Driver Layout

```
                           28.5"
        ←───────────────────────────────────────────→
        
   ┌─────────────────────────────────────────────────┐ ─┬─
   │                                                 │  │
   │                    5.0"                         │  │
   │                                                 │  │
   │              ┌───────────────┐                  │  │
   │             ╱                 ╲                 │  │
   │            │                   │                │  │  TOP DRIVER
   │            │    TOP DRIVER     │  ← 16.8" dia  │  │  Center Y = 33.1"
   │            │      CUTOUT       │                │  │  from bottom
   │             ╲                 ╱                 │  │
   │              └───────────────┘                  │  │
   │                                                 │  │
   │                    2.9"                         │  │  46.5"
   │                (gap between                     │  │  BAFFLE
   │                 driver edges)                   │  │  HEIGHT
   │                                                 │  │
   │              ┌───────────────┐                  │  │
   │             ╱                 ╲                 │  │
   │            │                   │                │  │  BOTTOM DRIVER
   │            │   BOTTOM DRIVER   │  ← 16.8" dia  │  │  Center Y = 13.4"
   │            │      CUTOUT       │                │  │  from bottom
   │             ╲                 ╱                 │  │
   │              └───────────────┘                  │  │
   │                                                 │  │
   │                    5.0"                         │  │
   │                                                 │  │
   └─────────────────────────────────────────────────┘ ─┴─
   
        │←─ 5.85" ─→│←─ 16.8" ─→│←─ 5.85" ─→│
                    └── cutout ──┘
                   centered at 14.25"
```

### Precise Cutout Coordinates

```
╔═══════════════════════════════════════════════════════════════════════╗
║           DRIVER CUTOUT COORDINATES (FROM BAFFLE BOTTOM-LEFT)         ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                       ║
║  ORIGIN: Bottom-left corner of baffle = (0, 0)                       ║
║                                                                       ║
║  ┌─────────────────────────────────────────────────────────────┐     ║
║  │  BOTTOM DRIVER                                              │     ║
║  │  • Center X: 14.25" (centered on 28.5" baffle width)       │     ║
║  │  • Center Y: 13.40" from baffle bottom                      │     ║
║  │  • Cutout radius: 8.40" (16.80" diameter)                  │     ║
║  │  • Bottom edge of cutout: 13.40" - 8.40" = 5.00"           │     ║
║  │  • Top edge of cutout: 13.40" + 8.40" = 21.80"             │     ║
║  └─────────────────────────────────────────────────────────────┘     ║
║                                                                       ║
║  ┌─────────────────────────────────────────────────────────────┐     ║
║  │  TOP DRIVER                                                 │     ║
║  │  • Center X: 14.25" (centered on 28.5" baffle width)       │     ║
║  │  • Center Y: 33.10" from baffle bottom                      │     ║
║  │  • Cutout radius: 8.40" (16.80" diameter)                  │     ║
║  │  • Bottom edge of cutout: 33.10" - 8.40" = 24.70"          │     ║
║  │  • Top edge of cutout: 33.10" + 8.40" = 41.50"             │     ║
║  └─────────────────────────────────────────────────────────────┘     ║
║                                                                       ║
║  VERIFICATION:                                                        ║
║  • Gap between cutouts: 24.70" - 21.80" = 2.90" ✓                   ║
║  • Left edge clearance: 14.25" - 8.40" = 5.85" ✓                    ║
║  • Right edge clearance: 28.50" - 14.25" - 8.40" = 5.85" ✓          ║
║  • Bottom edge clearance: 5.00" ✓                                    ║
║  • Top edge clearance: 46.50" - 41.50" = 5.00" ✓                    ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
```

### T-Nut Mounting Holes

```
MOUNTING HOLE PATTERN (per driver):

  Bolt Circle Diameter: 17.60" (radius 8.80")
  Hole Size: 1/4" (for 1/4"-20 T-nuts)
  Pattern: 8 holes evenly spaced at 45° intervals
  
  
            0° (TOP)
              ●
        315° ╱ ╲ 45°
            ●   ●
           ╱     ╲
    270° ●    ○    ● 90°     ← ○ = driver center
           ╲     ╱
            ●   ●
        225° ╲ ╱ 135°
              ●
           180° (BOTTOM)


  HOLE COORDINATES (offset from driver center):
  ┌───────────────────────────────────────────────┐
  │  Angle  │  X offset    │  Y offset           │
  ├─────────┼──────────────┼─────────────────────┤
  │    0°   │    0.000"    │   +8.800"           │
  │   45°   │   +6.223"    │   +6.223"           │
  │   90°   │   +8.800"    │    0.000"           │
  │  135°   │   +6.223"    │   -6.223"           │
  │  180°   │    0.000"    │   -8.800"           │
  │  225°   │   -6.223"    │   -6.223"           │
  │  270°   │   -8.800"    │    0.000"           │
  │  315°   │   -6.223"    │   +6.223"           │
  └─────────┴──────────────┴─────────────────────┘
  
  TIP: Use driver as template - place driver on baffle,
  mark through mounting holes with transfer punch.
```

---

## 4. Assembly Cross-Sections

### Side Cross-Section (Critical View)

```
                    ←────────────── 19" total depth ──────────────→
                    
    ┌───────────────────────────────────────────────────────┬───────┐
    │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│░░░░░░░│ ← TOP PANEL
    ├───────────────────────────────────────────────────────┼───────┤   (0.75")
    │                                                       │▒▒▒▒▒▒▒│
    │                                                       │▒▒▒▒▒▒▒│
    │                                                       │▒▒▒▒▒▒▒│
    │              ┌─────────────────────┐                  │▒▒▒▒▒▒▒│
    │              │   DRIVER MAGNET    │                  │▒▒▒▒▒▒▒│
    │              │   (protrudes ~9")  │                  │▒▒▒▒▒▒▒│
    │              └─────────────────────┘                  │▒ B ▒▒▒│
    │                                                       │▒ A ▒▒▒│
    │                                                       │▒ F ▒▒▒│
    │           SEALED VOLUME                               │▒ F ▒▒▒│
    │             11.1 ft³                                  │▒ L ▒▒▒│
    │                                                       │▒ E ▒▒▒│
    │                                                       │▒▒▒▒▒▒▒│
    │              ┌─────────────────────┐                  │▒▒▒▒▒▒▒│
    │              │   DRIVER MAGNET    │                  │▒▒▒▒▒▒▒│
    │              │   (protrudes ~9")  │                  │▒▒▒▒▒▒▒│
    │              └─────────────────────┘                  │▒▒▒▒▒▒▒│
    │                                                       │▒▒▒▒▒▒▒│
    │                                                       │▒▒▒▒▒▒▒│
    │                                                       │▒▒▒▒▒▒▒│
    ├───────────────────────────────────────────────────────┼───────┤
    │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│░░░░░░░│ ← BOTTOM PANEL
    └───────────────────────────────────────────────────────┴───────┘   (0.75")
    
    │←─0.75"─→│←────────── 14.5" ──────────→│←0.75"→│←─ 3" ─→│
       BACK              sealed depth         BAFFLE   recess
      PANEL                                   
    
    
    LEGEND:
    ▓▓▓ = Top/Bottom panels (run full depth)
    ▒▒▒ = Baffle (mounted on cleats inside box)
    ░░░ = Side panel edge (visible in cross-section)
    
    FRONT IS OPEN - no front panel, just the 3" recess
    formed by the sides/top/bottom extending past the baffle
```

### Top View (Section Through Middle)

```
                           ←───────────── 30" ─────────────→
                           
    ┌──────────────────────────────────────────────────────────┐
    │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│ ← LEFT SIDE (0.75")
    │▓                                                        ▓│
    │▓                                                        ▓│
    │▓     SEALED VOLUME             ║                       ▓│ ↑
    │▓       (behind baffle)         ║ BAFFLE                ▓│ │
    │▓                               ║                       ▓│ 19"
    │▓     28.5" × 14.5"            ║         3" recess     ▓│ │
    │▓                               ║                       ▓│ ↓
    │▓                                                        ▓│
    │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│ ← RIGHT SIDE (0.75")
    └──────────────────────────────────────────────────────────┘
    
    BACK                                                    FRONT
                                                           (open)
    
    │←0.75"→│←──────── 28.5" ────────→│←0.75"→│
              internal width             baffle
```

---

## 5. Baffle Mounting Detail

The baffle mounts inside the box on **cleats** (support strips). The baffle front face must be exactly **3"** from the front edges of the box.

### Cleat Position Calculation

```
Position measured from FRONT of box (front edge = 0"):

• Front of box:           0"
• Front face of baffle:   3.00" (the 3" recess)
• Back face of baffle:    3.00" + 0.75" = 3.75"
• Cleat supports baffle back face
• Cleat front edge:       3.75" from front of box

Alternative measurement from BACK of box (back panel inside face = 0"):

• Back panel inside face: 0"
• Cleat position:         19" - 0.75"(back) - 3.75" = 14.50"
• This equals the sealed depth ✓
```

### Cleat Installation

```
CLEAT DETAIL (side view):

           ←── 0.75" ──→
           
    ───────┬───────────────────────────────────────────┬───
           │                                           │
           │        ┌─┐ ← Cleat (3/4" × 3/4")         │ SIDE
           │        │ │                                │ PANEL
           │        │ │   BAFFLE rests on cleat       │
           │        │▓│                                │
           │        │▓│                                │
           │        │▓│                                │
           │        │ │                                │
           │        └─┘                                │
           │                                           │
    ───────┴───────────────────────────────────────────┴───
    
           │←─ 14.5" ──→│←0.75"→│←── 3" ──→│
              sealed      baffle    recess
              depth


CLEAT CUT LIST:
• Left side cleat:   3/4" × 3/4" × 46.5" (full internal height)
• Right side cleat:  3/4" × 3/4" × 46.5"
• Bottom cleat:      3/4" × 3/4" × 27" (between side cleats)
• Top cleat:         3/4" × 3/4" × 27" (optional - baffle can also
                     be secured with screws through top panel)

Position cleats so their FRONT face is 3.75" from front of box.
Baffle rests against cleats with its back face.
```

---

## 6. Exploded Assembly View

```
                            EXPLODED ASSEMBLY VIEW
    
    
                                 ┌─────────────────────┐
                                 │     TOP PANEL       │
                                 │     30" × 19"       │
                                 └─────────────────────┘
                                          │
                                          ↓
                    ┌─────────┐                        ┌─────────┐
                    │         │                        │         │
                    │  LEFT   │                        │  RIGHT  │
                    │  SIDE   │                        │  SIDE   │
                    │         │                        │         │
                    │ 19" ×   │                        │ 19" ×   │
                    │ 46.5"   │                        │ 46.5"   │
                    │         │                        │         │
                    │         │                        │         │
                    └─────────┘                        └─────────┘
                         │                                  │
                         └──────────────┬──────────────────┘
                                        │
                                        ↓
                         ┌──────────────────────────┐
                         │                          │
                         │       BAFFLE             │
                         │     28.5" × 46.5"        │
                         │                          │
                         │    ┌──────────────┐      │
                         │    │  TOP CUTOUT  │      │
                         │    │    16.8"     │      │
                         │    └──────────────┘      │
                         │                          │
                         │    ┌──────────────┐      │
                         │    │ BOTTOM CUTOUT│      │
                         │    │    16.8"     │      │
                         │    └──────────────┘      │
                         │                          │
                         └──────────────────────────┘
                                        │
                                        ↓
                    ╔═══════════════════════════════════════╗
                    ║                                       ║
                    ║            BACK PANEL                 ║
                    ║             30" × 48"                 ║
                    ║                                       ║
                    ║  (Binding posts mount here,           ║
                    ║   centered, 4" from bottom)           ║
                    ║                                       ║
                    ╚═══════════════════════════════════════╝
                                        │
                                        ↓
                                 ┌─────────────────────┐
                                 │    BOTTOM PANEL     │
                                 │      30" × 19"      │
                                 └─────────────────────┘
```

---

## 7. MDF Sheet Layout (Cutting Optimization)

### Layout for One Enclosure (~1.25 sheets of 4×8)

```
╔═══════════════════════════════════════════════════════════════════════════════╗
║                     SHEET #1 (4' × 8' MDF)                                    ║
╠═══════════════════════════════════════════════════════════════════════════════╣

    ←─────────────────────────── 96" ───────────────────────────→
    
    ┌────────────────────────────┬────────────────────────────────┐ ─┬─
    │                            │                                │  │
    │      BACK PANEL            │         LEFT SIDE              │  │
    │        30" × 48"           │          19" × 46.5"           │  │
    │                            │                                │  │
    │                            │                                │  │  48"
    │                            │                                │  │
    │                            │                                │  │
    │                            │                                │  │
    │                            │                                │  │
    │                            │                                │  │
    │                            │                                │  │
    └────────────────────────────┴────────────────────────────────┘ ─┴─
    
    │←──────── 30" ────────────→│←──────────── 19" ──────────────→│
    
    Waste/Remaining: 96" - 30" - 19" = 47" width remaining
    (Used for Sheet #2 pieces)

╠═══════════════════════════════════════════════════════════════════════════════╣
║                     SHEET #2 (4' × 8' MDF) - Partial                          ║
╠═══════════════════════════════════════════════════════════════════════════════╣

    ←─────────────────────────── 96" ───────────────────────────→
    
    ┌──────────────────────┬───────────────────┬─────────────────┐ ─┬─
    │                      │                   │                 │  │
    │      BAFFLE          │    RIGHT SIDE     │   TOP PANEL     │  │
    │    28.5" × 46.5"     │    19" × 46.5"    │   30" × 19"     │  │  48"
    │                      │                   │                 │  │
    │   (driver cutouts)   │                   ├─────────────────┤  │
    │                      │                   │  BOTTOM PANEL   │  │
    │                      │                   │   30" × 19"     │  │
    │                      │                   │                 │  │
    └──────────────────────┴───────────────────┴─────────────────┘ ─┴─
    
    │←───── 28.5" ────────→│←──── 19" ───────→│←───── 30" ─────→│
    
    Total: 28.5 + 19 + 30 = 77.5" (fits in 96")

╚═══════════════════════════════════════════════════════════════════════════════╝
```

### Cutting Order

1. **Sheet #1:** Cut back panel (30" × 48"), then left side (19" × 46.5")
2. **Sheet #2:** Cut baffle (28.5" × 46.5"), right side (19" × 46.5"), top (30" × 19"), bottom (30" × 19")
3. **Baffle cutouts:** Cut driver holes LAST, after panel is sized
4. **T-nut holes:** Drill after cutouts, using driver as template

---

## 8. Assembly Sequence

### Step-by-Step Construction

```
╔════════════════════════════════════════════════════════════════════════════════╗
║                           ASSEMBLY SEQUENCE                                     ║
╠════════════════════════════════════════════════════════════════════════════════╣
║                                                                                ║
║  PHASE 1: PREPARATION                                                         ║
║  ─────────────────────                                                        ║
║  □ Cut all MDF panels to dimension                                           ║
║  □ Cut driver cutouts in baffle (16.80" diameter)                           ║
║  □ Drill T-nut holes in baffle (use driver as template)                     ║
║  □ Install T-nuts from back of baffle (hammer in)                           ║
║  □ Drill binding post holes in back panel (centered, 4" from bottom)        ║
║  □ Cut cleats: 2× 46.5" and 2× 27" pieces                                   ║
║  □ Dry-fit all panels to verify dimensions                                   ║
║  □ Sand all edges smooth                                                     ║
║                                                                                ║
║  PHASE 2: BOX ASSEMBLY                                                        ║
║  ──────────────────────                                                       ║
║  □ Lay bottom panel flat                                                     ║
║  □ Attach back panel to bottom (glue + screws, back edge flush)             ║
║  □ Attach left side to bottom and back (glue + screws)                      ║
║  □ Attach right side to bottom and back (glue + screws)                     ║
║  □ Attach top panel (glue + screws)                                         ║
║  □ Verify box is square (measure diagonals)                                 ║
║  □ Apply acoustic caulk to ALL internal corners/joints                      ║
║  □ Let cure 24 hours                                                         ║
║                                                                                ║
║  PHASE 3: CLEAT INSTALLATION                                                  ║
║  ────────────────────────────                                                 ║
║  □ Mark cleat position: 3.75" from front of box                             ║
║  □ Install left side cleat (glue + screws from outside)                     ║
║  □ Install right side cleat                                                  ║
║  □ Install bottom cleat (between side cleats)                               ║
║  □ Optional: Install top cleat OR plan to screw through top                 ║
║                                                                                ║
║  PHASE 4: BAFFLE INSTALLATION                                                 ║
║  ─────────────────────────────                                                ║
║  □ Install binding posts in back panel                                       ║
║  □ Run speaker wire from binding posts (leave slack for baffle connection)  ║
║  □ Apply bead of caulk to cleats                                            ║
║  □ Slide baffle into position (rests on cleats)                             ║
║  □ Secure baffle with screws through sides into baffle edge                 ║
║  □ Optional: Screw through top panel into baffle top edge                   ║
║  □ Seal baffle perimeter with acoustic caulk                                ║
║                                                                                ║
║  PHASE 5: DRIVER INSTALLATION                                                 ║
║  ─────────────────────────────                                                ║
║  □ Connect speaker wire to driver terminals (verify polarity!)              ║
║  □ Apply foam gasket tape to driver mounting flange                         ║
║  □ Position driver in cutout                                                 ║
║  □ Install 1/4"-20 bolts through driver into T-nuts                        ║
║  □ Tighten in star pattern (even compression of gasket)                     ║
║  □ Repeat for second driver                                                  ║
║  □ Test for air leaks (play low frequency, feel for air movement)           ║
║                                                                                ║
╚════════════════════════════════════════════════════════════════════════════════╝
```

---

## 9. Binding Post Location

```
                    BACK PANEL (30" × 48")
                    
    ┌────────────────────────────────────────────────────┐
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │  44"
    │                                                    │  from
    │                                                    │  bottom
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                                                    │
    │                   ⊕   ⊕                           │  ← 4" from bottom
    │                (binding posts)                     │    Centered (15" from sides)
    │                                                    │
    └────────────────────────────────────────────────────┘
    
    Binding Post Spacing: 3/4" between posts (standard)
    Hole size: Per binding post specifications
```

---

## 10. Bill of Materials (Per Enclosure)

```
╔════════════════════════════════════════════════════════════════════════════════╗
║                      BILL OF MATERIALS (PER ENCLOSURE)                         ║
╠════════════════════════════════════════════════════════════════════════════════╣
║                                                                                ║
║  MDF 3/4" (4×8 sheets)                                                        ║
║  ─────────────────────                                                        ║
║  • Quantity: 1.25 sheets (can share between 2 enclosures)                    ║
║  • Estimated cost: $45-60                                                     ║
║                                                                                ║
║  Hardware                                                                      ║
║  ────────                                                                      ║
║  • T-nuts, 1/4"-20: 16 pieces                              $8                 ║
║  • Bolts, 1/4"-20 × 1.5": 16 pieces                       $8                 ║
║  • Wood screws, #8 × 2": 60 pieces                         $10                ║
║  • Binding posts (pair): Heavy-duty 5-way                  $15-25             ║
║  • 12 AWG speaker wire: 6 feet                             $3                 ║
║                                                                                ║
║  Adhesives & Sealants                                                         ║
║  ────────────────────                                                         ║
║  • Wood glue (Titebond III): 16 oz                         $10                ║
║  • Acoustic caulk: 1 tube                                  $8                 ║
║  • Foam gasket tape (1/8" × 3/8"): 1 roll                 $10                ║
║                                                                                ║
║  Cleats                                                                        ║
║  ──────                                                                        ║
║  • 3/4" × 3/4" strips: 10 linear feet                      $5                 ║
║                                                                                ║
║  Drivers (not included in enclosure cost)                                     ║
║  ────────────────────────────────────────                                     ║
║  • 2× Dayton Audio UMII18-22: $578 ($289 each)                               ║
║                                                                                ║
╠════════════════════════════════════════════════════════════════════════════════╣
║  ENCLOSURE MATERIALS TOTAL (per sub): ~$125-140                               ║
║  WITH DRIVERS: ~$700-720                                                       ║
║  × 2 REAR SUBS: ~$1,400-1,440                                                 ║
╚════════════════════════════════════════════════════════════════════════════════╝
```

---

## 11. Critical Dimensions Quick Reference

```
╔════════════════════════════════════════════════════════════════════════════════╗
║                     CRITICAL DIMENSIONS - QUICK REFERENCE                      ║
╠════════════════════════════════════════════════════════════════════════════════╣
║                                                                                ║
║  EXTERNAL BOX DIMENSIONS                                                       ║
║  ───────────────────────                                                       ║
║  Width:   30"                                                                  ║
║  Height:  48"                                                                  ║
║  Depth:   19"                                                                  ║
║                                                                                ║
║  INTERNAL SEALED VOLUME (behind baffle)                                       ║
║  ──────────────────────────────────────                                       ║
║  Width:   28.5"                                                               ║
║  Height:  46.5"                                                               ║
║  Depth:   14.5"                                                               ║
║  Volume:  11.1 ft³                                                            ║
║                                                                                ║
║  BAFFLE                                                                        ║
║  ──────                                                                        ║
║  Width:   28.5"                                                               ║
║  Height:  46.5"                                                               ║
║  Inset:   3" from front face of box                                          ║
║  Cleat position: 3.75" from front (supports baffle back face)                ║
║                                                                                ║
║  DRIVER CUTOUTS                                                               ║
║  ──────────────                                                               ║
║  Diameter: 16.80"                                                             ║
║  Center X: 14.25" (centered on baffle)                                       ║
║  Bottom driver center Y: 13.40" from baffle bottom                           ║
║  Top driver center Y: 33.10" from baffle bottom                              ║
║  Gap between cutout edges: 2.90"                                             ║
║                                                                                ║
║  MOUNTING HOLES                                                               ║
║  ─────────────                                                                ║
║  Bolt circle: 17.60" diameter (8.80" radius from driver center)              ║
║  Hole quantity: 8 per driver (16 total)                                      ║
║  Hole size: 1/4" (for 1/4"-20 T-nuts)                                       ║
║                                                                                ║
╚════════════════════════════════════════════════════════════════════════════════╝
```

---

## 12. Verification Checklist

Before final assembly, verify:

```
□ Back panel: 30" × 48" (±1/16")
□ Top panel: 30" × 19" (±1/16")
□ Bottom panel: 30" × 19" (±1/16")
□ Side panels: 19" × 46.5" (±1/16")
□ Baffle: 28.5" × 46.5" (±1/16")
□ Driver cutouts: 16.80" diameter (±1/32")
□ Driver centers correctly positioned
□ T-nut holes align with driver mounting holes
□ Box is square after assembly (measure diagonals)
□ Cleats positioned 3.75" from front of box
□ Baffle front face is 3" from front of box when installed
□ Internal volume ~11 ft³
□ All joints sealed with caulk
□ Binding posts installed and wired
```

---

## 13. Internal Bracing - Detailed Specifications

### Purpose of Bracing

Internal bracing serves three critical functions in subwoofer enclosures:

1. **Panel Resonance Control** - Large MDF panels will flex and resonate at certain frequencies, causing audible coloration and energy loss. Bracing stiffens panels and shifts resonant frequencies out of the operating range.

2. **Structural Integrity** - Sealed subwoofers experience significant internal pressure changes during operation. Bracing prevents panel flexing that could cause air leaks or joint failures.

3. **Standing Wave Reduction** - Braces help break up internal standing waves that can create peaks and nulls in the frequency response.

### Bracing Design Philosophy

For this enclosure (28.5" × 46.5" × 14.5" internal), the bracing uses a **ladder frame** approach:
- Three horizontal braces spanning the full internal width
- Two vertical braces connecting the horizontals (split by baffle cutouts)
- All braces connect the back panel to the baffle

### Brace Cut List (3/4" MDF)

```
╔═══════════════════════════════════════════════════════════════════════════════╗
║                    INTERNAL BRACING - CUT LIST                                ║
╠═══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║  HORIZONTAL BRACES (span full internal width)                                ║
║  ─────────────────────────────────────────────                               ║
║  Brace A (top):     26" × 3" × 16.75"   Qty: 1   WINDOW: 22" × 12.75"     ║
║  Brace B (middle):  26" × 3" × 16.75"   Qty: 1   WINDOW: 22" × 12.75"     ║
║  Brace C (bottom):  26" × 3" × 16.75"   Qty: 1   WINDOW: 22" × 12.75"     ║
║                                                                               ║
║  VERTICAL BRACES (connect horizontals, avoid driver zones)                   ║
║  ─────────────────────────────────────────────────────────                   ║
║  Brace V1 (lower):  3" × 17" × 16.75"   Qty: 1   WINDOW: 13" × 12.75"     ║
║  Brace V2 (upper):  3" × 17" × 16.75"   Qty: 1   WINDOW: 13" × 12.75"     ║
║                                                                               ║
║  NOTES:                                                                       ║
║  • All braces are 16.75" deep (spanning from back panel to 1.5" baffle)   ║
║  • WINDOW BRACES: 2" solid border, rectangular cutout in center            ║
║  • Braces have 1.25" clearance from side walls                              ║
║  • Horizontal braces positioned to avoid driver magnet zones                 ║
║  • Center vertical brace positioned at enclosure centerline                  ║
║                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════╝
```

### Brace Positioning

```
              FRONT VIEW - BRACING LAYOUT
              (Looking at baffle from inside box)
              
    ←───────────────── 28.5" ─────────────────→
    
    ┌─────────────────────────────────────────────┐ ─┬─
    │                                             │  │ 2"
    │ ╔═══════════════════════════════════════╗   │ ─┼─
    │ ║         BRACE A (top)                 ║   │  │ 3"
    │ ║           26" × 3"                   ║   │ ─┼─
    │ ╚═══════════════════════════════════════╝   │  │
    │           ┌───────────────┐                 │  │
    │          ╱                 ╲                │  │
    │         │   TOP DRIVER     │  ←16.8" cutout│  │
    │          ╲                 ╱                │  │
    │           └───────────────┘                 │  │
    │               ╔═══╗                         │  │
    │               ║V2 ║ ← 3" × 17"             │  │  46.5"
    │               ╚═══╝                         │  │
    │ ╔═══════════════════════════════════════╗   │ ─┼─
    │ ║        BRACE B (middle)               ║   │  │ 3"
    │ ║           26" × 3"                   ║   │ ─┼─
    │ ╚═══════════════════════════════════════╝   │  │
    │               ╔═══╗                         │  │
    │               ║V1 ║ ← 3" × 17"             │  │
    │               ╚═══╝                         │  │
    │           ┌───────────────┐                 │  │
    │          ╱                 ╲                │  │
    │         │  BOTTOM DRIVER   │  ←16.8" cutout│  │
    │          ╲                 ╱                │  │
    │           └───────────────┘                 │  │
    │ ╔═══════════════════════════════════════╗   │ ─┼─
    │ ║        BRACE C (bottom)               ║   │  │ 3"
    │ ║           26" × 3"                   ║   │ ─┼─
    │ ╚═══════════════════════════════════════╝   │  │ 2"
    └─────────────────────────────────────────────┘ ─┴─
    
    │←1.25"→│←───────── 26" ───────────→│←1.25"→│
```

### Brace Position Coordinates

```
╔══════════════════════════════════════════════════════════════════════════════╗
║             BRACE POSITIONS (measured from internal bottom-left)             ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║  HORIZONTAL BRACES                                                           ║
║  ──────────────────                                                          ║
║  Brace A (top):                                                              ║
║    • X position: 1.25" from left wall                                       ║
║    • Y position: 41.5" from internal bottom (bottom edge of brace)          ║
║    • Top of brace at: 44.5" (leaves 2" to internal top)                    ║
║                                                                              ║
║  Brace B (middle):                                                           ║
║    • X position: 1.25" from left wall                                       ║
║    • Y position: 22.5" from internal bottom (centered in 3" driver gap)    ║
║    • Positioned in the ~3" gap between driver cutout edges                  ║
║                                                                              ║
║  Brace C (bottom):                                                           ║
║    • X position: 1.25" from left wall                                       ║
║    • Y position: 2" from internal bottom                                    ║
║                                                                              ║
║  VERTICAL BRACES                                                             ║
║  ─────────────────                                                           ║
║  Both vertical braces:                                                       ║
║    • X position: 12.75" from left wall (centered on 28.5" width)           ║
║    • Width: 3"                                                               ║
║                                                                              ║
║  Brace V1 (lower section):                                                   ║
║    • Y position: 5" to 22" (below bottom driver, connects C to B)          ║
║    • Height: 17"                                                             ║
║                                                                              ║
║  Brace V2 (upper section):                                                   ║
║    • Y position: 25.5" to 42.5" (above top driver, connects B to A)        ║
║    • Height: 17"                                                             ║
║                                                                              ║
║  CLEARANCE CHECK                                                             ║
║  ───────────────                                                             ║
║  • Bottom driver cutout edge: 5" from internal bottom                       ║
║  • Brace V1 top: 22" - clears bottom driver with 17" margin ✓              ║
║  • Top driver cutout bottom edge: 24.7" from internal bottom                ║
║  • Brace V2 bottom: 25.5" - clears gap with margin ✓                       ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### Brace Cross-Section (Side View)

```
              SIDE VIEW - BRACE DEPTH
              
    ←──────────────── 19" total depth ────────────────→
    
    ┌───┬───────────────────────────────────────┬───┬─────┐
    │   │                                       │   │     │
    │ B │                                       │ B │     │
    │ A ├───────────────────────────────────────┤ A │     │
    │ C │           BRACE                       │ F │ 3"  │
    │ K │        (14.5" deep)                  │ F │recess
    │   │                                       │ L │     │
    │   │     Spans from back panel             │ E │     │
    │   │         to baffle                     │   │     │
    │   │                                       │   │     │
    │   ├───────────────────────────────────────┤   │     │
    │   │                                       │   │     │
    └───┴───────────────────────────────────────┴───┴─────┘
    
    │0.75│←────────── 14.5" ─────────────→│0.75│← 3" →│
     back           brace depth           baffle  recess
    panel
    
    
    BRACE ATTACHMENT:
    • Glue + screw through back panel into brace end
    • Glue + screw through baffle into brace end
    • Creates rigid connection between front and back
```

### Bracing Installation Sequence

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                      BRACING INSTALLATION SEQUENCE                           ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║  PHASE 1: MARK BRACE POSITIONS                                              ║
║  ─────────────────────────────                                               ║
║  □ Mark horizontal brace positions on back panel (inside face)              ║
║  □ Mark corresponding positions on baffle (back face)                       ║
║  □ Mark vertical brace centerlines on horizontal braces                     ║
║                                                                              ║
║  PHASE 2: ATTACH BRACES TO BACK PANEL                                       ║
║  ───────────────────────────────────                                         ║
║  □ Apply glue to end of Brace C (bottom horizontal)                         ║
║  □ Position against back panel at marked location                           ║
║  □ Drive 2" screws through back panel into brace (3 screws)                ║
║  □ Repeat for Brace B (middle) and Brace A (top)                           ║
║  □ Attach vertical braces V1 and V2 to horizontal braces                   ║
║     - Use glue + screws through horizontals into vertical ends             ║
║  □ Let glue cure 30 minutes before continuing                               ║
║                                                                              ║
║  PHASE 3: COMPLETE BOX ASSEMBLY                                             ║
║  ───────────────────────────────                                             ║
║  □ Assemble box shell (back + sides + top + bottom)                        ║
║  □ Braces are now inside the box, extending toward front                    ║
║                                                                              ║
║  PHASE 4: ATTACH BAFFLE TO BRACES                                           ║
║  ─────────────────────────────                                               ║
║  □ Apply glue to front ends of all braces                                   ║
║  □ Apply caulk to cleats                                                     ║
║  □ Position baffle against cleats and brace ends                            ║
║  □ Drive screws through baffle into brace ends (accessible from front)     ║
║  □ Seal baffle perimeter with acoustic caulk                                ║
║                                                                              ║
║  SCREW PATTERN FOR BRACES:                                                   ║
║  • Horizontal braces: 3 screws per end (6 total per brace)                 ║
║  • Vertical braces: 2 screws per end (4 total per brace)                   ║
║  • Use #8 × 2" wood screws, pre-drill 1/8" pilot holes                     ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### Bracing Materials (per enclosure)

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                    BRACING MATERIALS - PER ENCLOSURE                         ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║  3/4" MDF for braces:                                                       ║
║  ─────────────────────                                                       ║
║  • 3× horizontal braces: 26" × 3" × 14.5" each                            ║
║    - MDF volume: 3 × (26 × 3 × 14.5) = 3,393 in³                           ║
║  • 2× vertical braces: 3" × 17" × 14.5" each                              ║
║    - MDF volume: 2 × (3 × 17 × 14.5) = 1,479 in³                           ║
║                                                                              ║
║  TOTAL BRACE MDF: ~4,872 in³ = ~2.8 ft³                                    ║
║  This is approximately 0.25 sheets of 4×8 MDF per enclosure                 ║
║                                                                              ║
║  Hardware for bracing:                                                       ║
║  ─────────────────────                                                       ║
║  • Wood screws #8 × 2": 30 per enclosure                                   ║
║  • Wood glue: 4 oz per enclosure                                            ║
║                                                                              ║
║  VOLUME DISPLACEMENT:                                                        ║
║  ────────────────────                                                        ║
║  Gross internal volume: 11.1 ft³                                            ║
║  Brace displacement: ~0.5 ft³                                               ║
║  Driver displacement: ~0.3 ft³ (2× drivers)                                 ║
║  NET INTERNAL VOLUME: ~10.3 ft³                                             ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### Alternative Bracing Options

If the full ladder-frame bracing is too complex, consider these alternatives:

**Option A: Horizontal-Only Bracing**
- Use only the three horizontal braces (A, B, C)
- Simpler construction, still very effective
- Omit vertical braces V1 and V2

**Option B: Window Bracing**
- Cut large rectangular openings in horizontal braces
- Reduces weight and material while maintaining stiffness
- More complex to cut but common in commercial designs

**Option C: Dowel Bracing**
- Use 1" hardwood dowels instead of MDF panels
- Drill matching holes in back panel and baffle
- Faster to install, less volume displacement
- May not be as rigid as panel bracing

---

## 14. Construction Images Reference

The following images are provided with this document:

1. **panel_diagrams.png** - Individual panel dimensions and features
2. **assembly_sequence.png** - 4-stage assembly progression
3. **bracing_layout.png** - Internal bracing positions (front and side views)
4. **panel_connections.png** - How panels slot together, joint details
5. **final_form.png** - Completed enclosure from all angles
6. **rear_sub_FINAL_corrected.png** - Design overview with cross-sections
7. **brace_options.png** - Comparison of flat vs window brace designs
8. **brace_cut_diagrams.png** - Detailed window brace cutout dimensions
9. **updated_crosssection.png** - Side view with 1.5" double baffle
10. **double_baffle_detail.png** - Baffle lamination construction detail
11. **revised_12.5ft3_crosssection.png** - Updated cross-section for 22" depth
12. **revised_brace_cutouts.png** - Updated window brace dimensions
13. **revised_panel_cutlist.png** - Updated panel cut list for 22" depth

---

## 15. Updated Bill of Materials (Including Bracing)

```
╔════════════════════════════════════════════════════════════════════════════════╗
║              COMPLETE BILL OF MATERIALS (PER ENCLOSURE)                        ║
╠════════════════════════════════════════════════════════════════════════════════╣
║                                                                                ║
║  MDF 3/4" (4×8 sheets)                                                        ║
║  ─────────────────────                                                        ║
║  • Box panels: 1.25 sheets                                                    ║
║  • Double baffle (2×): 0.35 sheets additional                                ║
║  • Window bracing: 0.20 sheets (less than solid)                             ║
║  • TOTAL: 1.9 sheets per enclosure                            $95-120        ║
║                                                                                ║
║  Hardware                                                                      ║
║  ────────                                                                      ║
║  • T-nuts, 1/4"-20: 16 pieces                                  $8             ║
║  • Bolts, 1/4"-20 × 1.5": 16 pieces                           $8             ║
║  • Wood screws, #8 × 2": 90 pieces (box + bracing)            $12            ║
║  • Binding posts (pair): Heavy-duty 5-way                      $15-25         ║
║  • 12 AWG speaker wire: 6 feet                                 $3             ║
║                                                                                ║
║  Adhesives & Sealants                                                         ║
║  ────────────────────                                                         ║
║  • Wood glue (Titebond III): 24 oz                             $12            ║
║  • Acoustic caulk: 1 tube                                      $8             ║
║  • Foam gasket tape (1/8" × 3/8"): 1 roll                     $10            ║
║                                                                                ║
║  Cleats                                                                        ║
║  ──────                                                                        ║
║  • 3/4" × 3/4" strips: 10 linear feet                          $5             ║
║                                                                                ║
╠════════════════════════════════════════════════════════════════════════════════╣
║  ENCLOSURE MATERIALS TOTAL (per sub): ~$180-220                               ║
║                                                                                ║
║  Drivers (not included in enclosure cost)                                     ║
║  ────────────────────────────────────────                                     ║
║  • 2× Dayton Audio UMII18-22: $578 ($289 each)                               ║
║                                                                                ║
║  COMPLETE SUBWOOFER COST: ~$760-800                                           ║
║  × 2 REAR SUBS: ~$1,520-1,600                                                 ║
╚════════════════════════════════════════════════════════════════════════════════╝
```

---

**Document Version:** 5.0 (Revised: 22" depth for 12.85 ft³ gross volume)
**Created:** November 25, 2025
**Revised:** November 26, 2025
**For:** Home Theater Project - Rear Subwoofer Enclosures (×2)

---

## Key Revisions in v5.0:
- **External depth: 19" → 22"** (added 3" to achieve target volume)
- Sealed depth: 13.75" → 16.75"
- Gross volume: 10.55 ft³ → 12.85 ft³
- Net volume (after displacement): ~12.0 ft³
- Brace depth: 13.75" → 16.75"
- Window cutout depth: 9.75" → 12.75"
- Panel cut list: Top/Bottom 19"→22", Sides 19"→22"
