# 05 — Screen, Projector & Seating Geometry
**Option D | 2026-03-21**

---

## Screen

| Parameter | Value | Source |
|-----------|-------|--------|
| Diagonal | 170" | specs.yaml screen.size_in |
| Aspect ratio | 16:9 | specs.yaml screen.aspect |
| Type | Acoustically transparent (AT) | specs.yaml screen.type |
| Wall | North, centered | specs.yaml screen.wall |

### Dimensions (calculated)

```
W = 170 × 16 / sqrt(16² + 9²) = 170 × 16 / sqrt(337) = 148.2"
H = 170 × 9  / sqrt(16² + 9²) = 170 × 9  / sqrt(337) = 83.4"
```

| Dimension | Value |
|-----------|-------|
| Width | 148.2" (12.35 ft) |
| Height | 83.4" (6.95 ft) |
| Bottom edge | 30" AFF |
| Top edge | 30 + 83.4 = 113.4" AFF |
| Ceiling height | 120" |
| Ceiling clearance | 120 - 113.4 = **6.6"** |

> **Stale doc conflict:** `02_Front_Stage_System.md` (Rev 5.2) states bottom = 51". That would put the top at
> 51 + 83.4 = 134.4", which exceeds the 120" ceiling. That figure is wrong and has been superseded.
> The correct bottom height is **30"** per `coordinates.json` (Y1=30, Y2=113) and Critic ruling §1A.

### Coordinates (from specs.yaml, traceable to coordinates.json)

```
X1=172, X2=320  →  W = 320-172 = 148"  (≈148.2" calculated)
Y1=30,  Y2=113  →  H = 113-30  = 83"   (≈83.4" calculated)
Z1=248, Z2=249  →  depth = 1" (screen face, 26" from north wall)
```

---

## Projector

> **[UNVERIFIED — no projector model confirmed for 2027. $30,000 is a placeholder budget. JVC NZ500
> is a reference point only; actual purchase model will be the 2027 successor or equivalent.]**

| Parameter | Value |
|-----------|-------|
| Model | TBD — deferred to 2027 |
| Reference model | JVC NZ500 or 2027 successor |
| Budget | $30,000 |
| JVC NZ500 throw ratio range | 1.4–2.8:1 |

### Throw Calculation

```
Available throw  = 23 ft room depth − 2 ft stage depth = 21 ft = 252"
Required ratio   = 252" / 148.2" = 1.70:1
```

The 1.70:1 required ratio falls within the JVC NZ500's 1.4–2.8:1 zoom range, leaving flexibility
for exact placement within the rear of the room.

**UST (ultra-short-throw) projectors are OFF THE TABLE.** UST requires a hard-surfaced screen
placed directly on the wall. An acoustically transparent screen with LCR speakers behind it is
incompatible with UST optics — the speaker grilles and drivers would obstruct the projection cone.

---

## Seating Layout

### Riser

| Parameter | Value | Source |
|-----------|-------|--------|
| Height | 24" | specs.yaml seating.riser.height_in |
| Front edge from north wall | 15.5 ft | specs.yaml seating.riser.front_edge_from_north_ft |
| Depth | 5.5 ft | specs.yaml seating.riser.depth_ft |
| Coordinates | X1=156, X2=336, Z1=90, Z2=156, Y1=0, Y2=24 | coordinates.json riser |

### Row 1 (floor level)

| Parameter | Value |
|-----------|-------|
| Distance from screen face | ~12 ft (144") |
| Floor level | 0" (no riser) |
| Eye height (seated) | 42" AFF |
| Seating coordinates | X1=198, X2=294, Z1=132, Z2=168, Y1=0, Y2=18 |

### Row 2 (on riser)

| Parameter | Value | Calc |
|-----------|-------|------|
| Distance from screen face | ~15 ft (180") | riser front at 15.5 ft from north wall; MLP slightly behind front edge |
| Riser height | 24" | specs.yaml |
| Seat height above riser | 18" | typical seated cushion |
| Eye above seat | 12" | typical adult seated |
| Eye height AFF | **54"** | 24 + 18 + 12 = 54" |
| Seating coordinates | X1=198, X2=294, Z1=96, Z2=132, Y1=24, Y2=42 | coordinates.json row2_seating |

---

## Viewing Angle Analysis

Screen geometry reference:
- Bottom: 30" AFF
- Top: 113.4" AFF
- Center: (30 + 113.4) / 2 = 71.7" AFF
- Half-width: 148.2 / 2 = 74.1"

### Horizontal Angles (to screen edge)

```
Row 1: atan(74.1 / 144) = 27.2°  →  total horizontal subtended: 54.4°
Row 2: atan(74.1 / 180) = 22.4°  →  total horizontal subtended: 44.7°
```

### Vertical Angles (from eye level)

**Row 1 — eye at 42", 12 ft (144") from screen:**

```
To screen top:    atan((113.4 - 42) / 144) = atan(71.4 / 144) = 26.4° up
To screen bottom: atan((42  - 30)   / 144) = atan(12   / 144) =  4.8° down
Total vertical subtended: 31.2°
```

**Row 2 — eye at 54", 15 ft (180") from screen:**

```
To screen top:    atan((113.4 - 54) / 180) = atan(59.4 / 180) = 18.2° up
To screen bottom: atan((54  - 30)   / 180) = atan(24   / 180) =  7.6° down
Total vertical subtended: 25.8°
Screen center (71.7") is 17.7" above Row 2 eye height — slight upward gaze, acceptable.
```

### Summary Table

| Row | Distance | Eye AFF | Horiz to edge | Total horiz | Up to top | Down to bot | Total vert |
|-----|----------|---------|---------------|-------------|-----------|-------------|------------|
| 1 | 12 ft | 42" | 27.2° | 54.4° | 26.4° | 4.8° | 31.2° |
| 2 | 15 ft | 54" | 22.4° | 44.7° | 18.2° | 7.6° | 25.8° |

Both rows are within comfortable viewing geometry. SMPTE recommends 30° horizontal minimum for
reference viewing; Row 1 at 54.4° total exceeds this substantially. Row 2 at 44.7° is also
comfortable for immersive viewing at this screen size.

---

## Sources

- `specs.yaml`: screen, projector, seating, riser sections
- `coordinates.json`: screen (X1=172,X2=320,Y1=30,Y2=113), riser, row1_seating, row2_seating
- Critic ruling §1A: bottom=30" is correct; 51" is a stale doc error
- `CLAUDE.md` Option D section: room dimensions, screen type
