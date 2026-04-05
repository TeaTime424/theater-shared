# Triangular Corner Subwoofer — 3D Model Context

**Purpose:** Reference document for generating OBJ 3D models of the triangular corner subwoofer cabinets.

**Skill Reference:** `C:\Claude\HT\skills\obj-model-generation\SKILL.md`

---

## Overview

Floor-to-ceiling triangular columns that fit into room corners. Each corner has two 48" cabinets stacked and joined. Two configurations exist:

1. **Front Corners (Floor-Based):** Both drivers in bottom cabinet
2. **Rear Corners (Platform-Penetrating):** One driver per cabinet, inverted positions

---

## Cabinet Geometry

### Cross-Section (Right Triangle)

```
PLAN VIEW (looking down):

         CORNER (90°)
              ╲
               ╲
                ╲  SIDE WALL
                 ╲
                  ╲
                   ╲
    REAR WALL       ╲
    ═══════════════════╲
    │                    ╲
    │                     ╲
    │    INTERNAL          ╲
    │    CAVITY             ╲
    │                        ╲
    │         24"             ╲  ← Hypotenuse (front face)
    │          ↔               ╲    ~34" long
    │                           ╲
    │                            ╲
    ├─────────────────────────────╲
    │←──────── 24" ────────────→│
    
    Triangle legs: 24" × 24" (internal)
    Hypotenuse: √(24² + 24²) = 33.94" ≈ 34"
```

### Dimensional Specifications

| Parameter | Internal | External | Notes |
|-----------|----------|----------|-------|
| Leg A (wall-facing) | 24" | 25.5" | +1.5" for walls |
| Leg B (wall-facing) | 24" | 25.5" | +1.5" for walls |
| Hypotenuse (front) | 33.94" | ~35.5" | Front face |
| Height per cabinet | 46.5" | 48" | +1.5" for top/bottom |
| Wall thickness | — | 0.75" | 3/4" plywood |
| Front baffle | — | 1.5" | Double layer |

### Panel Breakdown (Per Cabinet)

| Panel | Dimensions | Qty | Material |
|-------|------------|-----|----------|
| Side A (wall) | 25.5" × 48" | 1 | 3/4" plywood |
| Side B (wall) | 24.75" × 48" | 1 | 3/4" plywood (butts against A) |
| Front baffle | 35.5" × 48" | 1 | 1.5" (double 3/4") |
| Top/Bottom | Right triangle 25.5" × 25.5" | 2 | 3/4" plywood |

---

## Driver Specifications

### Dayton UMII18-22

| Parameter | Value |
|-----------|-------|
| Nominal diameter | 18" |
| Cutout diameter | 16.5" |
| Mounting OD | 18.5" |
| Mounting holes | 8× on 17.5" bolt circle |
| Depth behind baffle | ~9" |
| Flange thickness | 0.5" |

### Driver Cutout in Baffle

```
FRONT BAFFLE (hypotenuse face):

    ┌─────────────────────────────────────┐ ← 48" (or 46.5" internal)
    │                                     │
    │         ┌───────────────┐           │
    │         │               │           │
    │         │    DRIVER     │           │ ← 16.5" cutout
    │         │    CUTOUT     │           │    centered on baffle
    │         │               │           │
    │         └───────────────┘           │
    │                                     │
    │              ↕ ~9"                  │ ← Center position varies
    │                                     │    by cabinet type
    │                                     │
    └─────────────────────────────────────┘
    
    Baffle width: ~35.5"
    Driver cutout center: 17.75" from either edge (centered)
```

---

## Configuration 1: Front Corners (Floor-Based)

Both drivers mounted in BOTTOM cabinet. Top cabinet is volume-only.

### Bottom Cabinet (Both Drivers)

```
FRONT VIEW — BOTTOM CABINET:

    ┌─────────────────────────────────────┐ ← 48"
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒┌───────────────┐▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│               │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│    UPPER      │▒▒▒▒▒▒▒▒▒▒▒│ ← 32" center from bottom
    │▒▒▒▒▒▒▒▒▒│    DRIVER     │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│               │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒└───────────────┘▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒┌───────────────┐▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│               │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│    LOWER      │▒▒▒▒▒▒▒▒▒▒▒│ ← 11" center from bottom
    │▒▒▒▒▒▒▒▒▒│    DRIVER     │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│               │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒└───────────────┘▒▒▒▒▒▒▒▒▒▒▒│
    └─────────────────────────────────────┘ ← 0" (floor)
    
    ▒ = 2" OC 703 + AT fabric overlay (with driver cutouts)
```

**Driver positions (from cabinet bottom, external):**
- Lower driver center: **11"**
- Upper driver center: **32"**
- Driver spacing: 21" center-to-center

### Top Cabinet (Volume Only)

```
FRONT VIEW — TOP CABINET:

    ┌─────────────────────────────────────┐ ← 96" (ceiling)
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒ NO DRIVER CUTOUT ▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    └─────────────────────────────────────┘ ← 48" (joint)
    
    Solid OC 703 face, no cutouts
```

---

## Configuration 2: Rear Corners (Platform-Penetrating)

One driver per cabinet, positions INVERTED. Column penetrates 24" platform.

### Bottom Cabinet (Driver at TOP)

```
FRONT VIEW — BOTTOM CABINET (REAR):

    ┌─────────────────────────────────────┐ ← 48"
    │▒▒▒▒▒▒▒▒▒┌───────────────┐▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│               │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│    DRIVER     │▒▒▒▒▒▒▒▒▒▒▒│ ← 27" center from floor
    │▒▒▒▒▒▒▒▒▒│   (at TOP)    │▒▒▒▒▒▒▒▒▒▒▒│    (3" above platform)
    │▒▒▒▒▒▒▒▒▒│               │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒└───────────────┘▒▒▒▒▒▒▒▒▒▒▒│
════╪═════════════════════════════════════╪════ ← 24" PLATFORM
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│    (column penetrates)
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒ NO DRIVER HERE ▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒ (volume only) ▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    └─────────────────────────────────────┘ ← 0" (floor)
```

**Driver position (from cabinet bottom, external):**
- Single driver center: **27"** from floor (3" above 24" platform)

### Top Cabinet (Driver at BOTTOM)

```
FRONT VIEW — TOP CABINET (REAR):

    ┌─────────────────────────────────────┐ ← 96" (ceiling)
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒ NO DRIVER HERE ▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒ (volume only) ▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒┌───────────────┐▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│               │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒│    DRIVER     │▒▒▒▒▒▒▒▒▒▒▒│ ← 51" center from floor
    │▒▒▒▒▒▒▒▒▒│  (at BOTTOM)  │▒▒▒▒▒▒▒▒▒▒▒│    (3" above joint)
    │▒▒▒▒▒▒▒▒▒│               │▒▒▒▒▒▒▒▒▒▒▒│
    │▒▒▒▒▒▒▒▒▒└───────────────┘▒▒▒▒▒▒▒▒▒▒▒│
    └─────────────────────────────────────┘ ← 48" (joint)
```

**Driver position (from cabinet bottom, external):**
- Single driver center: **3"** from cabinet bottom (51" from floor)

---

## OC 703 Acoustic Overlay

2" thick rigid fiberglass panel covers entire front face (hypotenuse), with cutouts for drivers.

### Overlay Specifications

| Parameter | Value |
|-----------|-------|
| Material | Owens Corning 703 |
| Thickness | 2" |
| Panel size | ~35.5" × 48" per cabinet |
| Covering | Guilford FR701 AT fabric |
| Driver cutouts | 18" diameter (slightly larger than driver) |

```
OC 703 OVERLAY DETAIL:

    ┌─────────────────────────────────────┐
    │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
    │░░░░░░░░░┌ ─ ─ ─ ─ ─ ─ ─┐░░░░░░░░░░░│
    │░░░░░░░░░    DRIVER      ░░░░░░░░░░░│ ← 18" cutout
    │░░░░░░░░░│   CUTOUT     │░░░░░░░░░░░│    (if applicable)
    │░░░░░░░░░└ ─ ─ ─ ─ ─ ─ ─┘░░░░░░░░░░░│
    │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
    └─────────────────────────────────────┘
    
    ░ = 2" OC 703 (rigid fiberglass)
    Entire assembly wrapped in AT fabric
```

---

## Sealed Joint Detail

Cabinets join at 48" height with battle-ready dual seal.

### Joint Components

| Component | Specification |
|-----------|---------------|
| Butyl rope tape | 3/8" diameter, continuous bead |
| Internal batten | 3/4" × 3" × full perimeter |
| T-nuts | 1/4"-20, 10 per cabinet |
| Machine screws | 1/4"-20 × 2" |

```
JOINT CROSS-SECTION:

    TOP CABINET
    ┌──────────────────────────────────────┐
    │                                      │
    │      ┌────────────────────────┐      │
    │      │   INTERNAL BATTEN      │      │ ← 3/4" × 3" spans joint
    │      │   (1.5" into each)     │      │
    ├──────┴────────────────────────┴──────┤
    │██████████████████████████████████████│ ← 3/8" butyl rope
    ├──────┬────────────────────────┬──────┤
    │      │   INTERNAL BATTEN      │      │
    │      │                        │      │
    │      └────────────────────────┘      │
    │                                      │
    │             ◉         ◉              │ ← Bolt locations (~8" spacing)
    └──────────────────────────────────────┘
    BOTTOM CABINET
```

---

## 3D Model Requirements

### Models to Generate

| Model | Description | Driver Cutouts |
|-------|-------------|----------------|
| `front_bottom.obj` | Front corner bottom cabinet | 2 (at 11" and 32") |
| `front_top.obj` | Front corner top cabinet | 0 |
| `rear_bottom.obj` | Rear corner bottom cabinet | 1 (at 27") |
| `rear_top.obj` | Rear corner top cabinet | 1 (at 3" from bottom) |
| `oc703_front_bottom.obj` | Acoustic overlay for front bottom | 2 cutouts |
| `oc703_front_top.obj` | Acoustic overlay for front top | 0 cutouts |
| `oc703_rear_bottom.obj` | Acoustic overlay for rear bottom | 1 cutout |
| `oc703_rear_top.obj` | Acoustic overlay for rear top | 1 cutout |

### Coordinate System

```
        Y (height)
        │
        │
        │
        └───────── X (width along hypotenuse)
       ╱
      ╱
     Z (depth into corner)

Origin: Bottom-front-left corner of cabinet
Units: Inches (multiply by 2.54 for cm in OBJ)
```

### Key Dimensions Summary

| Dimension | Value (inches) |
|-----------|----------------|
| Cabinet height | 48" |
| Internal triangle legs | 24" × 24" |
| External triangle legs | 25.5" × 25.5" |
| Hypotenuse (front face) | ~35.5" |
| Wall thickness | 0.75" |
| Baffle thickness | 1.5" |
| Driver cutout diameter | 16.5" |
| OC 703 thickness | 2" |
| OC 703 driver cutout | 18" |

### Driver Center Positions (from cabinet bottom external)

| Cabinet | Driver 1 | Driver 2 |
|---------|----------|----------|
| Front Bottom | 11" | 32" |
| Front Top | — | — |
| Rear Bottom | 27" | — |
| Rear Top | 3" | — |

---

## Notes for OBJ Generation

1. **Scale factor:** OBJ typically uses meters or cm. Apply ×2.54 for cm conversion.

2. **Winding order:** Consistent counter-clockwise for outward-facing normals.

3. **Triangle construction:** Use ring topology for circular cutouts (driver holes).

4. **Separate meshes:** Generate cabinet shell and OC 703 overlay as separate objects.

5. **Baffle recess:** Front baffle is 1.5" thick; driver mounts flush with outer surface.

6. **Internal bracing:** Optional — can add shelf braces at 1/3 and 2/3 height if desired.

---

## Reference Documents

- `C:\Claude\HT\03_Subwoofer_System.md` — Full system specifications
- `C:\Claude\HT\04_Seating_and_Riser.md` — Platform integration details
- `C:\Claude\HT\skills\obj-model-generation\SKILL.md` — OBJ generation best practices
- `C:\Claude\HT\journal.txt` — Design evolution and rationale
