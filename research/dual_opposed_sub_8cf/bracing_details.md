# 8 cu ft Dual-Opposed Subwoofer - Bracing Details

## Overview

This design uses **enhanced bracing** to compensate for plywood's weaker edge joints and potential internal voids compared to MDF.

### Bracing Components
1. **Cross-braces** (interlocking) — Wall-to-wall panel coupling
2. **Rib braces** — Panel stiffening
3. **Corner braces** — Edge joint reinforcement (plywood-specific)

---

## Cross-Braces (Interlocking)

### Purpose
- Couples opposite walls together through cabinet center
- Prevents panel flexing at center of large spans
- Allows motor structure clearance through center gap

### Specifications
| Parameter | Value |
|-----------|-------|
| Quantity | 4 total (2 per level) |
| Dimensions | 25" × 4" × 0.75" |
| Material | Same 3/4" plywood as cabinet |

### Notch Details
- Width: 4" (full brace width)
- Depth: 2" (half brace width)
- Location: Centered on brace length

```
BRACE A (×2) - Notch from TOP:

         ←────────── 25" ──────────→
         ┌─────────┬─────┬─────────┐
         │         │ 4"  │         │  ↑
         │  10.5"  │notch│  10.5"  │  4"
         │         │     │         │  ↓
         └─────────┴─────┴─────────┘
                   ↑
                2" deep


BRACE B (×2) - Notch from BOTTOM:

         ←────────── 25" ──────────→
         ┌─────────┴─────┴─────────┐
         │         │     │         │  ↑
         │  10.5"  │notch│  10.5"  │  4"
         │         │ 4"  │         │  ↓
         └─────────┬─────┬─────────┘
                   ↑
                2" deep
```

### Installation Positions
| Level | Distance from Panel |
|-------|---------------------|
| Upper | 9.5" from top panel (inside) |
| Lower | 9.5" from bottom panel (inside) |

### How They Interlock

```
TOP VIEW (interlocked braces):

                    BRACE A
         ┌─────────────────────────────┐
         │                             │
         │                             │
    ─────┤            ┌──┐             ├─────
    B    │            │  │             │    B
    R    │            │  │             │    R
    A    │            │  │             │    A
    C    │            │  │             │    C
    E    │            │  │             │    E
         │            │  │             │
    B    │            │  │             │    B
    ─────┤            └──┘             ├─────
         │                             │
         │                             │
         └─────────────────────────────┘
                    BRACE A

    Notches interlock at center, creating rigid + shape
    4" gap at center allows driver motor clearance
```

---

## Rib Braces

### Purpose
- Stiffens side panels against flexing
- Breaks up large unsupported panel spans
- Creates T-beam effect with panel (dramatically increases rigidity)

### Specifications
| Parameter | Value |
|-----------|-------|
| Quantity | 16 total (4 per side panel) |
| Dimensions | 1.5" × 24.5" × 0.75" |
| Material | Same 3/4" plywood as cabinet |

### Position on Each Side Panel
- 2 ribs per panel at 1/4 and 3/4 positions
- On 25" wide panel: 6.25" and 18.75" from edge
- This divides the 25" span into: 6.25" | 12.5" | 6.25"

```
SIDE PANEL WITH RIBS (interior view):

    ←────────────── 25" ──────────────→

    ┌──┬─────────────────────────┬──┐  ─┐
    │  │                         │  │   │
    │  │                         │  │   │
    │  │                         │  │   │
    │R │                         │R │   │
    │I │                         │I │   │ 24.5"
    │B │                         │B │   │
    │  │                         │  │   │
    │  │                         │  │   │
    │  │                         │  │   │
    └──┴─────────────────────────┴──┘  ─┘
    ↑                             ↑
  6.25"                        18.75"
```

### T-Beam Effect

When a strip is glued perpendicular to a panel, it creates a T-shaped cross-section that dramatically increases the panel's moment of inertia (resistance to bending):

```
                    ┌─────────────────────────────┐
                    │          PANEL              │ 0.75"
    ════════════════╪═════════════════════════════╪════════
                    │                             │
                    │           RIB               │ 0.75"
                    │                             │
                    └─────────────────────────────┘
                              1.5"
```

A flat 0.75" panel has very low stiffness. Adding the 1.5" × 0.75" rib creates a T-beam with ~8× the stiffness in that direction.

---

## Corner Braces (Plywood-Specific)

### Purpose
- Reinforces weaker plywood edge-glue joints
- Adds mechanical strength at corners
- Compensates for plywood's inconsistent edge grain

### Why Needed for Plywood (Not MDF)
- MDF has uniform density throughout, including edges
- Plywood has alternating grain direction; edges are weak
- Glue joints into plywood edges have lower strength
- Corner braces add direct mechanical reinforcement

### Specifications
| Parameter | Value |
|-----------|-------|
| Quantity | 4 total (one per vertical corner) |
| Dimensions | 3" × 3" L-shape, 24.5" tall |
| Material | Same 3/4" plywood as cabinet |

### Configuration Options

**Option 1: True L-Shape (Recommended)**
```
    ┌───┐
    │   │ 3"
    │   │
    │   └────┐
    │        │ 0.75"
    └────────┘
       3"
```
Made by ripping a strip off a 3" wide piece and gluing back at 90°

**Option 2: Two-Piece L**
```
    ┌───┐
    │   │ 1.5"
    │   ├────┐
    │   │    │ 1.5"
    │   │    │
    └───┴────┘
```
Two 1.5" strips glued at 90°

**Option 3: Simple Strip**
Single 3" × 24.5" strip glued flat to one wall at each corner. Less rigid than L-shape but simpler.

### Installation
- Glue into all 4 interior vertical corners
- Full height of cabinet (24.5")
- Install after side frame assembly, before top/bottom panels

---

## Bracing Layout Summary

```
CUTAWAY VIEW (one quarter of cabinet):

    TOP PANEL
    ╔═══════════════════════════════╗
    ║                               ║
    ║   ┌───────────────────────┐   ║ ← Upper cross-brace level
    ║   │                       │   ║    (9.5" from top)
    ║   │    ║           ║      │   ║
    ║   │    ║  CORNER   ║ RIB  │   ║
    ║   │    ║  BRACE    ║      │   ║
    ║   │    ║           ║      │   ║
    ║   │                       │   ║
    ║   └───────────────────────┘   ║ ← Lower cross-brace level
    ║                               ║    (9.5" from bottom)
    ╚═══════════════════════════════╝
    BOTTOM PANEL (doubled)

    ║ = Vertical braces (ribs and corners)
    ─ = Horizontal cross-braces
```

---

## Material Summary

| Component | Qty | Dimensions | Total Area |
|-----------|-----|------------|------------|
| Cross-Brace A | 2 | 25" × 4" | 1.39 sq ft |
| Cross-Brace B | 2 | 25" × 4" | 1.39 sq ft |
| Rib Braces | 16 | 1.5" × 24.5" | 4.08 sq ft |
| Corner Braces | 4 | 3" × 24.5" | 2.04 sq ft |
| **Total Bracing** | **24 pieces** | | **8.90 sq ft** |

---

## Volume Displacement

| Component | Calculation | Displacement |
|-----------|-------------|--------------|
| Cross-braces (4) | 25×4×0.75×4 / 1728 | 0.17 cu ft |
| Rib braces (16) | 1.5×24.5×0.75×16 / 1728 | 0.26 cu ft |
| Corner braces (4) | ~3×24.5×0.75×4 / 1728 | 0.13 cu ft |
| **Total bracing** | | **~0.56 cu ft** |

This is accounted for in the net volume calculation.

---

*Bracing Details — 8 cu ft Dual-Opposed Subwoofer*  
*Document Version: 1.0*  
*November 2025*
