# Screen, Projector & Seating

## Screen: 170" 16:9 Acoustically Transparent

### Dimension Calculations

```
Diagonal = 170"
Aspect ratio = 16:9

Hypotenuse factor = sqrt(16^2 + 9^2) = sqrt(256 + 81) = sqrt(337) = 18.358

Width  = 170 x 16 / 18.358 = 170 x 0.8716 = 148.2"  = 12.35 ft
Height = 170 x 9  / 18.358 = 170 x 0.4903 = 83.4"   = 6.95 ft

Area = 148.2 x 83.4 = 12,360 sq in = 85.8 sq ft
```

### Screen Placement

| Parameter | Value |
|-----------|-------|
| Bottom edge from floor | **30"** |
| Top edge from floor | 30 + 83.4 = **113.4"** |
| Clearance to ceiling | 120 - 113.4 = **6.6"** |
| Offset from north wall | 26" (screen surface) |
| Side clearance | (204 - 148.2) / 2 = **27.9"** per side |

**CORRECTION (C1):** Screen bottom was 51" in early documents. At 51", the top would be at 51 + 83.4 = 134.4" -- **14.4" above the 120" ceiling**. Corrected to 30" bottom, which places the top at 113.4" with 6.6" ceiling clearance.

### Cost

| Item | Cost |
|------|------|
| AT screen (170" 16:9) | $1,000 |
| Shipping + mount hardware | $500 |
| **Total** | **$1,500** |

## Projector: JVC DLA-NZ500

| Parameter | Value |
|-----------|-------|
| Model | JVC DLA-NZ500 |
| Type | Native 4K D-ILA, laser |
| Contrast ratio | 40,000:1 |
| Throw ratio | 1.4 - 2.8:1 (zoom lens) |
| Cost | $5,999 |
| Mount | $100 |

### Throw Distance Verification

```
Min throw = screen_width x throw_ratio_min / 12
         = 148.2 x 1.4 / 12
         = 17.3 ft

Max throw = 148.2 x 2.8 / 12
          = 34.6 ft

Available throw distance:
  Room depth:        23.0 ft
  Stage depth:       -2.17 ft
  Projector setback: -2.83 ft (from rear wall)
  Available:         ~18.0 ft

Verification: 18.0 ft > 17.3 ft minimum -- PASS
Margin: 0.7 ft (8.4") -- tight but workable with zoom adjustment
```

## Viewing Angles

Formula: theta = 2 x arctan(screen_width / (2 x distance))

### Row 1

```
Distance from screen = 10.5 ft = 126"
theta = 2 x arctan(148.2 / (2 x 126))
      = 2 x arctan(148.2 / 252)
      = 2 x arctan(0.588)
      = 2 x 30.4°
      = 60.9° -- round to 61°

Classification: IMAX-class (IMAX targets 58-70°)
```

### Row 2

```
Distance from screen = 15.0 ft = 180"
theta = 2 x arctan(148.2 / (2 x 180))
      = 2 x arctan(148.2 / 360)
      = 2 x arctan(0.412)
      = 2 x 22.4°
      = 44.7° -- round to 45°

Classification: THX ideal (THX recommends 36-46°)
```

### Viewing Angle Summary

| Row | Distance | Angle | Classification |
|-----|----------|-------|----------------|
| Row 1 | 10.5 ft | 61° | IMAX class |
| Row 2 | 15.0 ft | 45° | THX ideal |

Both rows exceed the 36° THX minimum. Row 1 delivers true IMAX immersion. Row 2 is at THX sweet spot.

### Vertical Viewing Angle

```
Screen center height = 30 + 83.4/2 = 71.7" from floor
Seated eye height (floor): ~42" (standard seated)
Seated eye height (riser, +12"): ~54"

Row 1 (floor level):
  Vertical offset = 71.7 - 42 = 29.7"
  Horizontal distance = 126"
  Vertical angle = arctan(29.7/126) = 13.3° up

Row 2 (on 12" riser):
  Vertical offset = 71.7 - 54 = 17.7"
  Horizontal distance = 180"
  Vertical angle = arctan(17.7/180) = 5.6° up

Both under 15° -- comfortable for extended viewing.
```

## Seating

| Parameter | Row 1 | Row 2 |
|-----------|-------|-------|
| Seats | 4 | 4 |
| Couch width | 8 ft | 8 ft |
| Couch depth | 3 ft | 3 ft |
| Distance from screen | 10.5 ft | 15.0 ft |
| Distance from north wall | 12.67 ft | 17.17 ft |
| Elevation | Floor level (0") | Riser (+12") |
| Cost | $1,000 | $1,000 |

## Stage

| Parameter | Value |
|-----------|-------|
| Depth | 26" (24" sub cabinet + 2" screen) |
| Height | 8" platform |
| Width | Full 17' wall |
| Construction | Lumber frame + CLD deck |
| Purpose | Houses front sub pair (NW/NE corners), supports screen |
| Cost | $540 |

## Riser

| Parameter | Value |
|-----------|-------|
| Front edge from north wall | 15.5 ft |
| Depth | 5.5 ft |
| Height | 12" |
| Inset from side walls | 1.0 ft each side |
| Width | 15.0 ft |
| Construction | Lumber frame + CLD deck + carpet |
| Cost breakdown | Frame $800 + CLD $500 + Carpet $200 = $1,500 |

## Critical Assessment: Why 16:9 Not 2.35:1?

| Factor | 16:9 (chosen) | 2.35:1 |
|--------|---------------|--------|
| Diagonal for same width | 170" | ~143" |
| Content coverage | Native for TV, streaming, gaming, most films | Optimal for scope films only |
| Scope film display | Letterboxed (132" effective diagonal) | Native (no bars) |
| 16:9 content display | Full screen, no waste | Pillarboxed (massive waste) |
| Vertical resolution | Full 2160 lines for 16:9 | Full 2160 lines for scope, but 16:9 uses ~1640 lines |
| Cost | Lower (standard format) | CIH lens or masking = +$2,000-5,000 |
| Complexity | Simple | Requires CIH lens or motorized masking |

**Verdict:** This is a home theater, not a cinema. 70%+ of content consumed is 16:9 or 1.85:1 (streaming, TV, gaming). A 2.35:1 screen wastes the room's height on the majority of content. The 170" 16:9 delivers 61° viewing angle at Row 1 -- already IMAX class. Scope films at 2.35:1 letterboxed still show at ~132" diagonal equivalent, which exceeds most dedicated home theaters. CIH adds cost and complexity for a minority of content.
