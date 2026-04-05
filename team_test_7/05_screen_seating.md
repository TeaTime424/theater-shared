# 05 — Screen & Seating
## 170" 16:9 AT Screen, JVC NZ500, 2-Row Seating

All specs from `specs.yaml`.

---

## Screen

| Spec | Value |
|------|-------|
| Size | 170" diagonal, 16:9 |
| Width | 148.2" (12.35 ft) |
| Height | 83.4" (6.95 ft) |
| Type | Acoustically Transparent |
| Wall | North (17 ft wide) |
| Bottom height | **30"** above floor (CORRECTED from 51") |
| Top height | 113.4" (fits under 120" ceiling with 6.6" clearance) |
| Side clearance | 28" per side (room for corner treatment) |
| Cost | $1,000 (screen) + $500 (shipping/mount) = $1,500 |

### Screen Height Correction

Source docs had screen bottom at 51". This puts the top at 51 + 83.4 = 134.4" — **14.4" above the 120" ceiling.** Corrected to 30" bottom, which places the top at 113.4" with comfortable ceiling clearance.

At 30" bottom height:
- Screen center: 30 + 83.4/2 = 71.7" (6.0 ft) — good eye-level alignment
- Row 1 seated eye height: ~42" (floor level) → screen center +30" above eye level → slight upward gaze
- Row 2 seated eye height: ~42" + 24" (riser) = 66" → screen center +6" above eye level → nearly perfect

### Scope Movies

2.35:1 scope content letterboxes within the 16:9 frame:
- Scope image width: 148.2" (full screen width)
- Scope image height: 63.1" (148.2 / 2.35)
- Scope diagonal: ~161"
- Black bars: (83.4 - 63.1) / 2 = 10.15" top and bottom

16:9 content (TV, gaming) uses the full 170" screen.

---

## Projector

| Spec | Value |
|------|-------|
| Model | JVC DLA-NZ500 |
| Type | Native 4K D-ILA, laser |
| Cost | $5,999 |
| Throw ratio | 1.4-2.8:1 (zoom lens) |
| Native contrast | 40,000:1 |
| Lens shift | ±100% V, ±43% H |
| Power | ~400W |
| Weight | ~50 lbs |
| Ceiling mount | $100 |

### Throw Calculation

```
Screen width: 148.2"
Minimum throw distance: 148.2 × 1.4 = 207.5" = 17.3 ft
Maximum throw distance: 148.2 × 2.8 = 415.0" = 34.6 ft

Available distance: ~18 ft (projector mount to screen)
Actual throw ratio: (18 × 12) / 148.2 = 216 / 148.2 = 1.46:1

1.46 is within 1.4-2.8 range ✓
Zoom position: near minimum (wide end) — good for brightness
```

### UST Rejection

UST (ultra-short-throw) projectors are **OFF THE TABLE**:
- AT screen requires LCR speakers behind the screen
- UST projects from below/in front — blocks speaker placement
- UST has inferior contrast ratio for dedicated dark room
- JVC NZ500 or 2027 successor only

### Projector Mount

- Ceiling mount, ~18 ft from north wall (Z≈60 in model coordinates)
- Dedicated 20A/120V circuit
- HDMI 2.1 run from equipment closet through ceiling

---

## Seating

### Row 1 (MLP — Floor Level)

| Spec | Value |
|------|-------|
| Type | 4-seat couch, 8 ft wide |
| Distance from screen | 10.5 ft |
| Elevation | Floor level (0") |
| Viewing angle (170" 16:9) | **61°** |
| Assessment | **IMAX-class immersion** |
| Cost | $1,000 |

### Row 2 (On Riser)

| Spec | Value |
|------|-------|
| Type | 4-seat couch, 8 ft wide |
| Distance from screen | 15.0 ft |
| Elevation | 24" (on riser) |
| Viewing angle (170" 16:9) | **45°** |
| Assessment | **THX Ideal+** |
| Cost | $1,000 |

### Viewing Angle Calculation

```
Viewing angle = 2 × arctan(screen_width / (2 × distance))

Row 1: 2 × arctan(148.2 / (2 × 126)) = 2 × arctan(0.588) = 2 × 30.4° = 60.9° ≈ 61°
Row 2: 2 × arctan(148.2 / (2 × 180)) = 2 × arctan(0.412) = 2 × 22.4° = 44.8° ≈ 45°
```

Both rows exceed the THX recommended minimum of 36°. Row 1 is IMAX-level immersive.

### Seating Geometry

| Dimension | Value |
|-----------|-------|
| Stage depth | ~26" (sub depth 24" + screen 2") |
| Screen surface | ~3.5 ft from north wall |
| Row 1 center | ~14 ft from north wall |
| Row spacing | ~4.5 ft (MLP to MLP) |
| Row 2 center | ~18.5 ft from north wall |
| Space behind Row 2 | **~1 ft** (tight — south wall) |

**Rear clearance note:** 1 ft behind Row 2 is tight for rear wall treatment. Options:
1. Reduce stage depth to 24" (drop screen standoff) → gains 2"
2. Reduce row spacing to 4 ft → gains 6"
3. Accept 1 ft — sufficient for thin absorber panel

---

## Stage Platform

| Spec | Value |
|------|-------|
| Width | Full theater width (17 ft, partition to east wall) |
| Depth | ~26" (sub cabinet depth 24" + screen 2") |
| Height | 27" |
| Construction | Lumber frame + CLD (constrained layer damped) decking |
| Cost | $540 |
| Purpose | Elevate LCR speakers behind AT screen, span between front sub cabinets |

Stage deck spans between front corner sub cabinets (NW and NE). The sub cabinets serve as structural bookends — no separate false wall framing needed.

---

## Riser Platform

| Spec | Value |
|------|-------|
| Width | Theater width minus 2 ft (inset 1 ft from each wall) |
| Depth | 5.5 ft |
| Height | 24" |
| Front edge | ~15.5 ft from north wall |
| Construction | Lumber frame + CLD decking + carpet |
| Cost | $1,500 ($800 frame + $500 CLD + $200 carpet) |

---

## Cost Summary

| Item | Cost |
|------|------|
| AT screen | $1,000 |
| Screen shipping + mount | $500 |
| JVC NZ500 | $5,999 |
| Ceiling mount | $100 |
| Row 1 couch | $1,000 |
| Row 2 couch | $1,000 |
| Stage platform | $540 |
| Riser | $1,500 |
| **Total** | **$11,639** |

---

*All values from specs.yaml. Document generated 2026-03-16.*
