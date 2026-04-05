# Screen, Projector & Seating
## Option D — 170" 16:9 AT + JVC NZ500

**Source of truth:** `specs.yaml` | **Date:** 2026-03-14

---

## 1. Screen

| Spec | Value |
|------|-------|
| Diagonal | 170" |
| Aspect ratio | 16:9 |
| Width | 148.1" (12.34 ft) |
| Height | 83.3" (6.94 ft) |
| Type | Acoustically transparent (AT) |
| Budget | $1,500 + $500 shipping/mounting = $2,000 |

### Why 16:9 (not 2.35:1)

- TV, gaming, and 16:9 content uses the full 170" screen
- 2.35:1 scope content letterboxes within the 16:9 frame (~161" diagonal image)
- No masking system needed — black bars are handled by the projector
- AT screen allows LCR placement directly behind screen surface

### Screen Position

| Parameter | Value |
|-----------|-------|
| Bottom edge above floor | **~30"** (stage height 27" + 3" offset) |
| Top edge above floor | **~113"** (30 + 83.3) |
| Clearance to ceiling (120") | **7"** |
| Screen surface from north wall | ~3.5 ft (behind false wall / screen frame) |
| Wall clearance per side | 28" (204" wall - 148" screen = 56" / 2) |

**Correction from Architect plan:** The Architect proposed SCREEN_BOTTOM = 51", which would put the top at 134" — above the 120" ceiling. The correct position is ~30" above floor (on stage deck + small offset), with the top at ~113" — 7" below the ceiling.

### Screen Wall Structure

The front sub cabinets (20"W x 20"D x 72"H) serve as structural bookends. The AT screen frame mounts across the top of the cabinets (or to a simple header spanning between them). No separate false wall framing required. Stage deck spans between front cabinets.

### Price Correction

The source document (GC_Option1.md) budgets $1,000 for the screen. Commercial 170" 16:9 AT screens (Silver Ticket, Elite Screens) start at $1,500-2,000. Budget corrected to $1,500. If DIY frame + XY Screens fabric, $1,000 may be achievable but requires frame fabrication.

---

## 2. Projector

| Spec | Value |
|------|-------|
| Model | JVC DLA-NZ500 |
| Cost | $5,999 |
| Resolution | Native 4K D-ILA |
| Light source | Laser |
| Contrast ratio | 40,000:1 native |
| Throw ratio | 1.4:1 to 2.8:1 (zoom lens) |

### Throw Distance Calculation

| Parameter | Value |
|-----------|-------|
| Screen width | 148.1" = 12.34 ft |
| Minimum throw (1.4:1) | 12.34 x 1.4 = **17.3 ft** from screen surface |
| Maximum throw (2.8:1) | 12.34 x 2.8 = 34.6 ft |
| Screen surface from north wall | ~3.5 ft |
| Room depth | 23 ft |
| Max projector distance from screen | 23 - 3.5 = **19.5 ft** |

**At 19.5 ft from screen surface:** throw ratio = 19.5 / 12.34 = **1.58** — within the 1.4-2.8 range. Works at wide zoom.

**Mounting position:** Ceiling mount on south wall (rear), ~19 ft from screen surface. This places the projector behind Row 2 (~18.5 ft from north wall = ~15 ft from screen surface + lens offset). At exactly 17.3 ft from screen surface, the projector is at the minimum zoom setting.

**Recommended mount position:** 17.5-19 ft from screen surface (ceiling mount, rear wall area). This provides 1.42-1.54 throw ratio — solidly within the zoom range without being at the absolute minimum.

### Projector Notes

- **Selection deferred to 2027.** The NZ500 may be succeeded by improved models. Budget $6,000 for projector; buy last.
- Dedicated 20A/120V ceiling circuit (Circuit D).
- $100 ceiling mount.
- Fiber HDMI cable for 4K/120Hz over 15+ ft run ($80 budgeted — may need $120-150 for quality fiber HDMI).

---

## 3. Seating Geometry

```
North wall (screen)
    ↓
[3.5 ft] Screen surface
[3.0 ft] Stage depth
[7.5 ft] Floor space to Row 1
    ↓
Row 1 (MLP) — 14.0 ft from north wall, 10.5 ft from screen
[4.5 ft] Row spacing
    ↓
Row 2 — 18.5 ft from north wall, 15.0 ft from screen, on 24" riser
[4.5 ft] Riser depth
    ↓
[1.0 ft] Rear clearance to south wall
    = 23.0 ft total
```

### Row Details

| | Row 1 (MLP) | Row 2 |
|---|------------|-------|
| Distance from screen surface | 10.5 ft | 15.0 ft |
| Distance from north wall | 14.0 ft | 18.5 ft |
| Elevation | Floor level | 24" riser |
| Seats | 4 | 4 |
| Viewing angle (170" 16:9) | **61 deg** | **45 deg** |

### Viewing Angle Assessment

| Standard | Recommended | Row 1 | Row 2 |
|----------|-------------|-------|-------|
| THX Reference | 36 deg | Exceeds | Exceeds |
| SMPTE Minimum | 30 deg | Exceeds | Exceeds |
| THX Ideal | 40-46 deg | Exceeds | **Meets** |
| IMAX | 55-70 deg | **Meets** | Below |

Row 1 at 61 deg is deliberately IMAX-class immersive. Row 2 at 45 deg is THX ideal — the sweet spot for most viewers.

### Riser Spec

| Parameter | Value |
|-----------|-------|
| Width | 16 ft (room width minus margins) |
| Depth | 4.5 ft |
| Height | 24" |
| Construction | CLD (constrained layer damping) deck |
| Front edge | 16 ft from north wall |
| Carpet | Over riser deck |
| Cost | $800 (frame) + $500 (CLD deck) + $200 (carpet) = $1,500 |

### Sightline Verification

| Parameter | Row 1 | Row 2 |
|-----------|-------|-------|
| Seat height (cushion top) | ~18" | 18" + 24" riser = 42" |
| Eye height (seated) | ~44" | ~68" |
| Head top | ~48" | ~72" |
| Screen bottom | 30" | 30" |

Row 2 eye height (68") is well above Row 1 head top (48"). Sightline to screen bottom (30") is clear — Row 2 viewers look down at ~5 deg angle to screen bottom over Row 1 heads. No obstruction.

### Rear Clearance

1 ft behind Row 2 to south exterior wall. This is tight.

**Mitigations:**
- Non-reclining seats (or limited recline)
- Rear wall treatment mounts flat (1" absorption panels, not 4" bass traps)
- SBL/SBR speakers mount above head height on rear wall
- If unacceptable: reduce stage depth 3' → 2.5' to gain 0.5 ft, or reduce row spacing 4.5' → 4' to gain 0.5 ft

---

## Critical Assessment

**Screen size is correct for this room.** 170" 16:9 at 10.5 ft (Row 1) gives an IMAX-class 61 deg viewing angle. This is the owner's explicit goal. Row 2 at 45 deg is the standard reference position. The 16:9 aspect ratio is correct — scope content letterboxes, while TV/gaming uses the full screen.

**Projector throw is verified.** The NZ500 can fill 170" 16:9 at 17.3+ ft throw distance. The room allows up to 19.5 ft. The Analyst's initial concern ("can't fill 170" at this distance") was based on incorrect math — the throw works, but only at wide zoom. Mounting position must be behind Row 2, near the rear wall ceiling.

**Rear clearance is the weakest point** in the layout. 1 ft is usable but not comfortable. If this proves claustrophobic in practice, stage depth or row spacing can be adjusted before permanent installation — but after the riser is built, it's harder to change.

**Seating at $250/seat is tight.** Solid wood frame required for bass shaker mounting. Used/surplus theater seating or Costco-type couches with rigid frames are the target. This line item may need to increase by $500-1,000.
