# 05 — Screen & Seating

**Date:** 2026-03-15
**References:** specs.yaml, layout_config.json

---

## 1. Screen

| Parameter | Value |
|-----------|-------|
| Size | 170" diagonal |
| Aspect ratio | 16:9 |
| Type | Acoustically transparent (AT) |
| Width | 148.2" (12.35 ft) |
| Height | 83.3" (6.94 ft) |
| Bottom edge | 30" above finished floor (AFF) |
| Top edge | 113.3" AFF (~9.4 ft) |
| Screen wall | North wall (17' wide) |
| Clearance per side | 28" (plenty for corner treatment) |
| Cost | $1,500 (corrected from $1,000) |

### Why 16:9 (Not 2.35:1)

- 17' screen wall accommodates full 170" 16:9 with 28" per side clearance
- 16:9 content (TV, gaming) uses the full screen area
- 2.35:1 scope movies letterbox within the 16:9 frame (~161" diagonal scope image)
- Multi-use theater — significant TV and gaming alongside movies
- Simpler than masking system for aspect ratio switching

### Screen Construction

The front corner sub cabinets (24" x 24" x 72") flank the screen and act as structural supports. The AT screen frame mounts across the top of the sub cabinets or to a simple header spanning between them. No separate false wall framing required. The stage platform spans between the front sub cabinets.

---

## 2. Projector — JVC DLA-NZ500

| Parameter | Value |
|-----------|-------|
| Model | JVC DLA-NZ500 |
| Technology | Native 4K D-ILA, laser |
| Contrast ratio | 40,000:1 native |
| Brightness | 1,900 lumens |
| Throw ratio | 1.4:1 to 2.8:1 (zoom lens) |
| Mount | Rear wall ceiling mount |
| Cost | $5,999 |

### Throw Distance Calculation

**Screen width:** 148.2" = 12.35 ft

**Minimum throw (1.4:1):** 12.35 x 1.4 = **17.3 ft**
**Maximum throw (2.8:1):** 12.35 x 2.8 = **34.6 ft**

**Available distance (rear wall to screen):**
- Room depth: 23 ft
- Screen setback from north wall: ~2 ft (stage depth behind screen surface)
- Projector setback from south wall: ~1 ft (mount offset)
- **Available throw: ~20 ft**

20 ft is within the 17.3-34.6 ft range. **Throw ratio at 20 ft: 20 / 12.35 = 1.62:1** — well within the 1.4-2.8:1 zoom range, with room to zoom for lens shift and keystoning.

### Screen Bottom Height Verification

Screen bottom at 30" AFF. Center screen height = 30 + 83.3/2 = 71.7" AFF.
JVC NZ500 has +/- 80% vertical lens shift. At 1.62:1 throw ratio, the projector can project from ceiling height (10 ft = 120") to a screen centered at 71.7" — the 48.3" offset is well within 80% shift range.

### AT Screen Brightness Impact

AT screens typically lose 1-1.5 stops (~3-4.5 dB) vs solid white screens. With 1,900 lumens, effective brightness is ~950-1,200 lumens on the AT screen. On a 170" 16:9 screen (74 sq ft), this yields approximately 12-16 fL — adequate for SDR content in a fully dark room. HDR peak brightness will be limited but acceptable for a dedicated dark room theater.

---

## 3. Seating Geometry

### Row Positions

| Row | From North Wall | From Screen Surface | Seats | Couch Width | Couch Depth |
|-----|----------------|--------------------|----|-------------|-------------|
| Row 1 (MLP) | 14.0 ft | 10.5 ft | 4 | 8 ft | 3 ft |
| Row 2 | 18.5 ft | 15.0 ft | 4 | 8 ft | 3 ft |

### Viewing Angles

**Formula:** Viewing angle = 2 x arctan((screen_width / 2) / distance)

**Row 1:**
2 x arctan((12.35 / 2) / 10.5) = 2 x arctan(0.588) = 2 x 30.4 = **60.9 degrees**

- Assessment: IMAX-class immersion (IMAX spec is ~58-65 degrees)
- THX minimum: 36 degrees — exceeds by 25 degrees

**Row 2:**
2 x arctan((12.35 / 2) / 15.0) = 2 x arctan(0.412) = 2 x 22.4 = **44.8 degrees**

- Assessment: THX Ideal+ (THX ideal range: 36-40 degrees)
- Excellent viewing angle for second row

### Vertical Viewing Angle

Screen center at 71.7" AFF. Seated eye height ~44" AFF (standard couch + cushion).
Vertical look-up angle = arctan((71.7 - 44) / (distance_ft x 12))

**Row 1:** arctan(27.7 / 126) = arctan(0.22) = **12.4 degrees** up — comfortable
**Row 2:** arctan(27.7 / 180) = arctan(0.154) = **8.8 degrees** up — very comfortable

Both are within the 15-degree comfort limit for sustained viewing.

---

## 4. Riser

| Parameter | Value |
|-----------|-------|
| Front edge | 15.5 ft from north wall |
| Depth | 5.5 ft |
| Rear edge | 21.0 ft from north wall (2 ft from south wall) |
| Width | 15 ft (1 ft inset from each side wall) |
| Height | 12" (one step) |
| Construction | Lumber frame, CLD decking, carpeted |
| Row 2 position | 1 ft from rear edge of riser |
| Notes | Construction sequence: place corner subs BEFORE riser |

### Row 2 Sight Line

Riser height: 12". Row 1 seated head height: ~44" AFF. Row 2 seated head height: ~56" AFF (44 + 12).
Screen bottom: 30" AFF.
From Row 2, the bottom of the screen is 30" AFF. Row 1 heads at 44". Row 2 eyes at ~56".
Line from Row 2 eyes to screen bottom clears Row 1 heads by 56 - 44 = 12" — adequate for unobstructed viewing over Row 1.

---

## 5. Stage

| Parameter | Value |
|-----------|-------|
| Depth | 3 ft (from north wall) |
| Height | 8" |
| Width | Full room width (17 ft) |
| Construction | Lumber frame, plywood deck |
| Contents | LCR speakers on Sorbothane pucks, behind AT screen |
| Sub cabinet depth | 24" (cabinets sit on stage, flanking screen) |

---

## 6. Rear Clearance

| Parameter | Value |
|-----------|-------|
| Room depth | 23 ft |
| South wall to rear riser edge | 2 ft |
| Rear riser edge to Row 2 couch back | ~0.5 ft |
| Row 2 couch back to south wall | **~1.0 ft** |
| Assessment | Tight — minimal space for rear wall treatment |

**Mitigation options (not yet decided):**
1. Accept 1' and install thin (1") absorption panels on south wall
2. Reduce stage depth to 2.5' (gain 6")
3. Reduce row spacing from 4.5' to 4' (gain 6")
4. Some combination of the above

---

## Critical Assessment

**Strengths:**
- 170" 16:9 AT at Row 1 (61 degrees) provides IMAX-class immersion
- JVC NZ500 throw works perfectly at 20 ft (1.62:1 within 1.4-2.8:1 range)
- Vertical viewing angle under 13 degrees at both rows — comfortable
- 12" riser provides clear sight line over Row 1 heads
- Front sub cabinets double as screen wall structure

**Concerns:**
- AT screen loses 1-1.5 stops of projector brightness — HDR peak performance limited
- 1' rear clearance behind Row 2 is tight for treatment and passage
- Screen bottom at 30" means LCR speakers must fit below screen height on 8" stage
- Titan-815LX is 42.5" tall on 8" stage = top at 50.5" — fits below 30" screen bottom? **NO.** 8" + 42.5" = 50.5" AFF, but screen bottom is at 30". The speaker tops at 50.5" extend 20.5" above screen bottom. **This is fine — speakers are behind the AT screen, which extends from 30" to 113.3". The speakers are fully within the screen area.**

---

**Document Version:** 1.0
