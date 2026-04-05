# 05 — Screen, Projector & Seating

Option D Home Theater — Visual System Reference

---

## Screen

| Parameter | Value |
|-----------|-------|
| Size | 170" diagonal |
| Aspect ratio | 16:9 |
| Type | Acoustically transparent (AT) |
| Width | 148.1" (12.34 ft) |
| Height | 83.3" (6.94 ft) |
| Bottom edge | 30" above floor |
| Top edge | ~113.3" above floor |
| Mounting | North wall, behind-screen LCR |

### Wall Clearance

```
Room width:        17' = 204"
Screen width:      148.1"
Total clearance:   204 - 148.1 = 55.9"
Per side:          55.9 / 2 = 27.9"
```

27.9" per side provides room for corner treatment columns (24" wide sub cabinets in NE/NW corners) with ~4" gap.

### Why 16:9 (Not 2.35:1)

- Most content is 16:9 (TV, streaming, gaming). Scope films letterbox within the 16:9 frame — no masking system needed.
- AT screen must accommodate LCR behind it. 2.35:1 screen is shorter, pushing LCR placement into tighter vertical space.
- 170" 16:9 at Row 1 already delivers 60.8-degree viewing angle (IMAX-class). No need for wider AR to fill FOV.
- Constant Image Height (CIH) masking adds $1,500-3,000 and mechanical complexity. Not worth it for this build.

---

## Projector

| Parameter | Value |
|-----------|-------|
| Model | JVC DLA-NZ500 |
| Price | $5,999 |
| Type | Native 4K D-ILA, laser |
| Throw ratio | 1.4:1 to 2.8:1 (zoom lens) |
| Mount | Ceiling, inverted |

### Throw Distance Calculation

```
Screen width:                148.1" = 12.34 ft
Minimum throw ratio:         1.4:1
Required throw distance:     12.34 × 1.4 = 17.3 ft MINIMUM

Room depth:                  23 ft
Projector position:          Z = 60" from south wall = 5 ft from south
Distance to north wall:      23 - 5 = 18 ft
Available throw:             ~18 ft

Margin:                      18.0 - 17.3 = 0.7 ft (8.4")
```

**TIGHT but sufficient.** 8.4" of margin. Projector mount position is adjustable within a few inches. Zoom lens provides additional flexibility beyond minimum throw.

### Projector Position

| Parameter | Value |
|-----------|-------|
| Distance from south wall | ~5 ft (60") |
| Distance from north wall | ~18 ft |
| Height | Ceiling mount, lens at ~110" |
| Horizontal | Centered on screen (X = 246") |

### Why NZ500

- Native 4K (no pixel-shifting artifacts on AT screen weave).
- Laser light source — no lamp replacements over theater lifetime.
- 1.4:1 minimum throw fits 170" screen in 23' room. Barely.
- $5,999 is entry-level for native 4K laser. Alternatives (NZ7/NZ8) are $10K+.
- JVC has best native contrast in the segment — critical for dark room performance.

### UST Rejection

UST (ultra-short-throw) projectors are incompatible with this design:
- AT screen has LCR speakers behind it. UST sits directly in front of the screen, blocking speaker path.
- UST throw geometry creates hot-spotting on AT woven material.
- No UST projector offers native 4K D-ILA performance at this price.

---

## Viewing Angles

### Row 1 — Floor Level

```
Distance from screen:   10.5 ft = 126"
Screen width:           148.1"
Half-angle:             atan(148.1 / (2 × 126)) = atan(0.5877) = 30.4°
Full viewing angle:     2 × 30.4° = 60.8°
```

| Standard | Minimum Angle | Row 1 (60.8°) |
|----------|---------------|----------------|
| SMPTE minimum | 30° | 2.0x |
| THX certified | 36° | 1.7x |
| THX ideal | 40° | 1.5x |
| IMAX | 58° | **Exceeds** |

Row 1 delivers IMAX-class viewing angle at 60.8°.

### Row 2 — On Riser

```
Distance from screen:   15.0 ft = 180"
Screen width:           148.1"
Half-angle:             atan(148.1 / (2 × 180)) = atan(0.4114) = 22.4°
Full viewing angle:     2 × 22.4° = 44.8°
```

| Standard | Minimum Angle | Row 2 (44.8°) |
|----------|---------------|----------------|
| SMPTE minimum | 30° | 1.5x |
| THX certified | 36° | 1.2x |
| THX ideal | 40° | **Exceeds** |
| IMAX | 58° | 77% |

Row 2 exceeds THX ideal at 44.8°. Both rows are above THX ideal — excellent.

---

## Seating

| Parameter | Row 1 | Row 2 |
|-----------|-------|-------|
| Type | 4-seat couch | 4-seat couch |
| Width | 8 ft | 8 ft |
| Depth | 3 ft | 3 ft |
| Distance from screen | 10.5 ft | 15.0 ft |
| Floor elevation | 0" (floor level) | 24" (on riser) |
| Viewing angle | 60.8° | 44.8° |
| Price | $1,000 | $1,000 |
| Bass shakers | 4x Aura Pro AST-2B-4 | 4x Aura Pro AST-2B-4 |

Total capacity: 8 seats.

---

## Riser

| Parameter | Value |
|-----------|-------|
| Position | 15.5 ft from north wall (screen wall) |
| Depth | 5.5 ft |
| Height | 24" |
| Width | Theater width minus 2 ft (1 ft inset each side) |
| Inset | 1 ft from east wall, 1 ft from partition |
| Construction | Lumber frame, CLD (constrained layer damping) decking |
| Carpet | Matched to theater floor |

### Riser Coordinates

```
X: 156" to 336" (15 ft wide, 1 ft inset each side of 17 ft room)
Z: 90" to 156" (5.5 ft deep)
Y: 0" to 24" (2 ft high)
```

24" riser height provides clear sightline from Row 2 over Row 1 heads. With Row 1 on floor and Row 2 elevated 24", eye height difference is approximately 18-20" — sufficient for unobstructed screen view.

---

## Stage

| Parameter | Value |
|-----------|-------|
| Width | Full theater width (17 ft) |
| Depth | 26" (24" sub cabinet + 2" screen clearance) |
| Height | 27" deck |
| Position | Against north wall |
| Purpose | Houses front sub pair (NW + NE corners), supports AT screen frame |

Front sub cabinets (24" x 24" x 96") sit at NW and NE corners, flanking the screen. Stage deck spans between them at 27" height. Screen bottom is at 30" — 3" above stage deck surface.

---

## Equipment Rack

| Parameter | Value |
|-----------|-------|
| Type | 42U open frame rack |
| Size | 24"W x 78"H x 30"D |
| Location | Equipment closet, NW corner of building (gym side) |
| Closet dimensions | 4 ft x 4 ft |
| Cable routing | Through partition wall to theater |
| Ventilation | Passive (open frame) + closet ventilation |
| Price | $550 |

Equipment in rack: X6800H, ICEpower modules, APM2 boards, sources, network gear.

---

## Cost Summary

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| JVC DLA-NZ500 | 1 | $5,999 | $5,999 |
| 170" 16:9 AT screen (frame + fabric) | 1 | $1,000 | $1,000 |
| AT screen shipping + mount hardware | 1 | $500 | $500 |
| Projector ceiling mount | 1 | $100 | $100 |
| Row 1 couch (4-seat) | 1 | $1,000 | $1,000 |
| Row 2 couch (4-seat) | 1 | $1,000 | $1,000 |
| Stage platform (lumber, CLD, hardware) | 1 | $540 | $540 |
| Riser frame sections | 1 | $800 | $800 |
| Riser CLD decking | 1 | $500 | $500 |
| Riser carpet | 1 | $200 | $200 |
| Equipment rack (open frame) | 1 | $550 | $550 |
| **Screen & Seating total** | | | **$12,189** |

---

## Critical Assessment

**Strengths:**
- 170" 16:9 AT screen is the largest 16:9 that fits the 17' wall with corner treatment clearance. Both rows exceed THX ideal viewing angle.
- NZ500 is the correct projector — native 4K, laser, best-in-class contrast at $6K. The 1.4:1 minimum throw barely fits but it fits.
- AT screen enables LCR behind screen — correct phantom center, no compromise on speaker placement.
- 24" riser with CLD provides sightline clearance and structural bass isolation from floor-coupled sub energy.

**Risks:**
- Throw distance margin is only 8.4". Projector mount position must be precise. Verify exact ceiling mount location against NZ500 lens shift range before ordering mount bracket.
- $1,000 per couch is budget-tier. For 8 seats with shaker integration, expect to spend time on mounting brackets and custom wiring. No recliners at this price.
- Screen bottom at 30" puts the bottom edge low for Row 2 viewers elevated 24" — their eye level is ~48" + seated height (~44") = ~68". Screen bottom at 30" means 38" below eye line. Vertical viewing angle is fine — entire screen is visible.

**No-go items:**
- UST projector: incompatible with AT screen (LCR behind screen).
- 2.35:1 aspect ratio: majority of content is 16:9, masking adds cost and complexity.
- Screen sizes above 170": insufficient wall clearance for corner treatment.
