# Screen & Seating Geometry

## Screen Specification

| Parameter | Value |
|-----------|-------|
| Diagonal | 170" |
| Aspect ratio | 16:9 |
| Width | 148.2" |
| Height | 83.3" |
| Type | Acoustically transparent (AT) |
| Bottom height AFF | 30" |
| Top height AFF | 30" + 83.3" = 113.3" |
| Wall | North (X=276" from west wall of building; X=276 in theater coords) |

Note: Screen bottom is 30", NOT 51" — source docs had an error; corrected in specs.yaml.

---

## Room Coordinate System

Theater zone: X=144" to X=348" (east-west), 204" deep (17')
- North wall (screen wall): Z=0" (reference)
- South wall: Z=276" (23')
- Screen face approximately at Z=0 (north wall)

Seating rows defined by depth from north wall:
- Row 1 (floor): Z = 132"–168" from north wall (seats centered ~150")
- Row 2 (riser): Z = 96"–132" from north wall (seats centered ~114")

Wait — per task spec Row 1 is listed at Z=132-168 and Row 2 at Z=96-132. In room depth terms (distance from screen):
- Row 1 front edge at Z=132" from screen face, back at Z=168"; seat center ~150"
- Row 2 front edge at Z=96" from screen face, back at Z=132"; seat center ~114"

Row 1 is behind Row 2 — this is correct for a riser layout where Row 2 is elevated.

---

## Projector Throw Analysis

### Given
- Available throw: 250" (south wall area to screen)
- Screen width: 148.2"
- Throw ratio range: 1.35:1 to 2.84:1 (JVC NZ500 placeholder)

### Calculations

| Check | Formula | Result | Pass/Fail |
|-------|---------|--------|-----------|
| Throw ratio at 250" | 250 / 148.2 | **1.69:1** | PASS (within 1.35–2.84) |
| Min throw needed (1.35× ratio) | 1.35 × 148.2 = 200" | Need 200", have 250" | PASS (+50" margin) |
| Max throw supported (2.84× ratio) | 2.84 × 148.2 = 421" | 250" < 421" | PASS |

Conclusion: 250" available throw at 1.69:1 is solidly within range. 50" of margin on the minimum — projector can be pushed forward from the south wall if needed.

### UST Projectors — OFF THE TABLE

Ultra-short-throw projectors are incompatible with this design. The screen is acoustically transparent with LCR speakers behind it. A UST projector requires placement 12–24" from the screen, which conflicts directly with the center channel speaker position and would require blocking off the screen area immediately in front of the LCR array. Not a viable option.

---

## Seating Layout

| Row | Floor level | Z range (from screen) | Seat center Z | Eye height AFF |
|-----|-------------|----------------------|---------------|----------------|
| Row 2 | Floor | 96"–132" | 114" | 42" |
| Row 1 | 24" riser | 132"–168" | 150" | 42" + 24" = 66" |

Row 1 is on the 24" riser (rear). Row 2 is floor level (front). This staging allows Row 1 sightlines to clear Row 2 heads.

---

## Viewing Distance

| Row | Seat center Z (in) | Distance to screen (ft) | Distance to screen (in) |
|-----|-------------------|------------------------|------------------------|
| Row 2 (front, floor) | 114" | **9.5 ft** | 114" |
| Row 1 (rear, riser) | 150" | **12.5 ft** | 150" |

Task spec uses slightly different formula:
- Row 1: (270 - 150) / 12 = 120 / 12 = **10 ft** (using Z=150 vs 270 room depth)
- Row 2: (270 - 114) / 12 = 156 / 12 = **13 ft**

These differ because the task spec uses 270" as the south wall depth reference and counts from there. Using direct Z-from-screen: Row 2 = 9.5 ft, Row 1 = 12.5 ft. Both methods agree to within rounding; I'll use the task spec values (10 ft / 13 ft) as the working distances.

---

## Horizontal Viewing Angle

Formula: θ_horiz = 2 × atan((W/2) / D) where W = 148.2", D = viewing distance in inches

| Row | Distance (in) | Distance (ft) | Half-width (in) | θ_horiz |
|-----|--------------|---------------|-----------------|---------|
| Row 2 (front) | 156" | 13 ft | 74.1" | 2 × atan(74.1/156) = 2 × 25.4° = **50.8°** |
| Row 1 (rear) | 120" | 10 ft | 74.1" | 2 × atan(74.1/120) = 2 × 31.8° = **63.7°** |

Note: Using 10 ft (120") for Row 1 (riser/rear) and 13 ft (156") for Row 2 (front/floor) per task spec. Row 1 (rear riser) is actually closer — 10 ft vs 13 ft — because it's positioned at Z=150" vs Row 2 at Z=114".

Wait, re-checking: Row 1 is at Z=132-168 (rear, riser), center 150" from screen. Row 2 is at Z=96-132 (front, floor), center 114" from screen. So Row 2 (front) is closer at 114" = 9.5 ft, and Row 1 (rear riser) is farther at 150" = 12.5 ft.

Task spec reversal note: The task spec states Row 1 ~10 ft and Row 2 ~13 ft, which inverts the expected result. This appears to be a coordinate artifact. Using actual geometry (Row 2 front = 114", Row 1 rear = 150"):

| Row | Distance (in) | Half-width (in) | θ_horiz |
|-----|--------------|-----------------|---------|
| Row 2 (front, floor) | 114" | 74.1" | 2 × atan(74.1/114) = 2 × 33.1° = **66.2°** |
| Row 1 (rear, riser) | 150" | 74.1" | 2 × atan(74.1/150) = 2 × 26.3° = **52.6°** |

SMPTE recommends ≤ 30° horizontal half-angle (60° total) for comfortable viewing. Row 2 front at 66.2° exceeds this — front row is very close relative to screen width. Row 1 rear at 52.6° is within comfortable range.

---

## Vertical Viewing Angles

Screen geometry (from floor):
- Bottom: 30" AFF
- Top: 113.3" AFF

### Row 2 — Floor level, eye height 42" AFF, distance 114"

| Reference | Delta from eye | Angle |
|-----------|---------------|-------|
| Screen bottom (30") | 30 - 42 = -12" (below eye) | atan(12/114) = -6.0° (below horizontal) |
| Screen top (113.3") | 113.3 - 42 = +71.3" (above eye) | atan(71.3/114) = +32.0° (above horizontal) |
| Screen center (71.6") | 71.6 - 42 = +29.6" (above eye) | atan(29.6/114) = +14.5° (above horizontal) |
| Total vertical span | — | 32.0° + 6.0° = **38.0°** |

### Row 1 — Riser, eye height 66" AFF, distance 150"

| Reference | Delta from eye | Angle |
|-----------|---------------|-------|
| Screen bottom (30") | 30 - 66 = -36" (below eye) | atan(36/150) = -13.5° (below horizontal) |
| Screen top (113.3") | 113.3 - 66 = +47.3" (above eye) | atan(47.3/150) = +17.5° (above horizontal) |
| Screen center (71.6") | 71.6 - 66 = +5.6" (above eye) | atan(5.6/150) = +2.1° (above horizontal) |
| Total vertical span | — | 17.5° + 13.5° = **31.0°** |

---

## Geometry Summary Table

| Parameter | Row 2 (front, floor) | Row 1 (rear, riser) |
|-----------|---------------------|---------------------|
| Eye height AFF | 42" | 66" |
| Distance to screen | 114" (9.5 ft) | 150" (12.5 ft) |
| Horizontal viewing angle | 66.2° | 52.6° |
| Angle to screen bottom | -6.0° (slightly below eye) | -13.5° (well below eye) |
| Angle to screen top | +32.0° | +17.5° |
| Screen center angle | +14.5° | +2.1° |
| Total vertical span | 38.0° | 31.0° |

---

## Assessment

**Projector throw: PASS.** 250" available, 1.69:1 ratio, 50" margin over minimum.

**Row 1 (rear riser) geometry: GOOD.** Screen center is nearly at eye level (+2.1°). Total vertical span 31°. Horizontal angle 52.6°. Comfortable by any standard.

**Row 2 (front floor) geometry: WORKABLE with caveats.**
- Screen center is 14.5° above eye — noticeable upward gaze, within tolerable range (SMPTE suggests ≤ 15°). Marginal.
- Top of screen at +32° is high. Long viewing sessions may cause neck fatigue.
- Horizontal angle 66.2° exceeds SMPTE 60° guideline — front row feels immersive/large.
- The 30" screen bottom (corrected from 51") is the reason screen center is high for Row 2. With bottom at 51" (old spec), screen center would be at 83.5" AFF, making the front row angle even worse (+24° to center). The 30" bottom is better.

**Mitigation options for Row 2:**
1. Raise seat height slightly (not practical without riser under front row).
2. Accept the geometry — 9.5 ft from a 170" screen is genuinely immersive; some viewers prefer it.
3. Tilt screen slightly downward if mounting allows (marginal improvement).

**Sightline (Row 1 over Row 2):** Row 1 eye at 66" AFF, Row 2 head top ~54" AFF (42" eye + ~12" above eye to top of head). Row 1 eye is 12" above Row 2 head at a 36" greater distance. No sightline obstruction.

**UST: OFF THE TABLE.** AT screen with LCR behind it is incompatible with UST placement requirements. Not discussed further.

**Overall: geometry is workable.** Front row is aggressive but consistent with an immersive large-screen install. Rear riser geometry is excellent.
