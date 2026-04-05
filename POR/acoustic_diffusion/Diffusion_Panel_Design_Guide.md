# Acoustic Diffusion Panel Design Guide
## Home Theater - 16' × 26' × 10' Room

**Version:** 1.0  
**Date:** December 2024  
**Related Documents:** Home_Theater_System_Complete_Design_Rev5_2.md

---

## Table of Contents

1. [Theory: Diffusion vs Absorption](#theory)
2. [Placement Strategy for Your Room](#placement)
3. [Design Option A: QRD N7 Diffuser](#qrd-design)
4. [Design Option B: Skyline Diffuser](#skyline-design)
5. [Construction Methods](#construction)
6. [Materials & Cost Estimates](#materials)
7. [Resources & Calculators](#resources)

---

## 1. Theory: Diffusion vs Absorption {#theory}

### What Diffusion Does

**Absorption** removes acoustic energy from the room - sound hits it and doesn't return. Essential for:
- First reflection points (prevents comb filtering)
- Bass traps (modal control)
- Reducing overall RT60

**Diffusion** preserves energy but scatters it in time and space. Sound hits the surface and returns, but spread out rather than as a coherent reflection. Benefits:
- Maintains room "liveness" without flutter echoes
- Creates spacious, enveloping sound field
- Preserves high-frequency energy (absorption tends to over-damp HF)
- Helps surround channels feel more immersive

### Why Your Room Needs Diffusion

Your design already includes significant absorption:
- Bass traps in corners (superchunk or equivalent)
- Absorption at first reflection points
- AT fabric panels (some absorption)
- Riser backrest (acoustic panel with Roxul infill)

Without diffusion, the room risks becoming "dead" - unnaturally dry, lacking ambiance. Diffusion on the **rear wall** and potentially **upper rear side walls** preserves spaciousness while preventing problematic reflections.

### Minimum Listening Distance

**Critical Rule:** Diffusers require minimum distance from listener to work properly.

**Formula:** Minimum distance = 3 × wavelength of lowest diffusion frequency

| Design Frequency | Wavelength | Min Distance |
|-----------------|------------|--------------|
| 400 Hz | 2.8 ft | 8.4 ft |
| 500 Hz | 2.3 ft | 6.9 ft |
| 600 Hz | 1.9 ft | 5.7 ft |
| 800 Hz | 1.4 ft | 4.2 ft |

**Your Room:** Row 2 at 18' from screen, rear wall at ~26'. Distance from Row 2 to rear wall ≈ 8'.
- Safe design frequency: ~430 Hz or higher
- Recommendation: Target 500-600 Hz minimum diffusion frequency

---

## 2. Placement Strategy for Your Room {#placement}

### Room Layout Reference
```
                    SCREEN (170" AT)
    ┌─────────────────────────────────────────┐
    │           FRONT STAGE (27" H)           │
    │    [LCR SPEAKERS]  [SUBS IN CORNERS]    │
    │                                          │
    │                                          │
    │        ═══════════════════════           │ ← Row 1 (13' from screen)
    │              [COUCH 1]                   │
    │                                          │
    │                                          │
    │    ┌─────────────────────────────┐      │
    │    │      RISER (24" H)          │      │
    │    │   ═══════════════════════   │      │ ← Row 2 (18' from screen)
    │    │        [COUCH 2]            │      │
    │    │                             │      │
    │    │  [BACKREST - ABSORPTION]    │      │
    │    └─────────────────────────────┘      │
    │                                          │
    │         ████ DIFFUSION ZONE ████         │ ← Above backrest, on rear wall
    │                                          │
    └─────────────────────────────────────────┘
                    REAR WALL (26')
```

### Recommended Diffusion Placement

**Primary Location: Rear Wall (Above Backrest)**
- Height: 60" from floor (top of backrest) to ~96" from floor
- Width: Center 8-10 feet (covers both listening positions)
- This is where rear-wall reflections would cause the most damage to imaging

**Secondary Location: Upper Rear Side Walls (Optional)**
- Height: Above seated ear level (48"+ from floor)
- Area: Rear third of room (behind Row 1)
- Purpose: Enhances surround envelopment

**Where NOT to Put Diffusion:**
- First reflection points (sides at ear level) - use absorption
- Ceiling above seats - use absorption
- Front wall behind speakers - not needed (AT screen)
- Low on walls where bass traps are more beneficial

### Integration with Existing Treatment

Your current design includes:
- **Riser backrest:** 12' wide × 36" tall absorption panel (Roxul-filled)
- **Removable AT panels:** 30" × 40" each (left/right of backrest)

**Diffusion goes ABOVE the backrest**, on the actual rear wall:
- Backrest top: 60" from floor (36" above 24" riser)
- Diffusion zone: 60" to 96" from floor (3 feet tall)
- Coverage width: Match or slightly exceed backrest width

---

## 3. Design Option A: QRD N7 Diffuser {#qrd-design}

### Why QRD N7?

The N7 (7-well) QRD is the most practical choice for DIY:
- Shallowest build depth relative to diffusion frequency
- Only 7 different well depths to cut
- Symmetrical pattern (wells 1-3-2-6-2-3-1 or similar)
- Well-documented, proven performance
- Build depth = 4/7 of design depth (best ratio of any standard QRD)

### Design Specifications

**Target Performance:**
- Design frequency: 600 Hz
- Effective diffusion range: ~425 Hz to 3,400+ Hz
- High-frequency cutoff determined by well width

**Calculated Dimensions (QRD N7, 600 Hz design):**

Using the formula: Max well depth = c / (2 × f × N)
- c = 1130 ft/s (speed of sound)
- f = 600 Hz (design frequency)
- N = 7 (prime number)

**Max depth = 1130 / (2 × 600 × 7) = 0.135 ft = 1.62"**

But actual build depth for N7 = 4/7 × max sequence value × unit depth

**Practical Design (using QRDude-style optimization):**

| Parameter | Value | Notes |
|-----------|-------|-------|
| Design frequency | 600 Hz | ~500 Hz effective LF diffusion |
| Well width | 2.0" | Sets HF cutoff ~3,400 Hz |
| Number of wells | 7 | One period |
| Fin thickness | 0.25" | 1/4" plywood or MDF |
| Panel width | 15.75" | (7 × 2") + (8 × 0.25") |
| Max well depth | 4.5" | Deepest well |
| Overall depth | 5.25" | Including backboard |

**Well Depth Sequence (N7):**

The QRD N7 sequence is: 0, 1, 4, 2, 2, 4, 1

Scaled for 4.5" max depth (multiplier = 4.5/4 = 1.125"):

| Well # | Sequence Value | Depth (inches) |
|--------|---------------|----------------|
| 1 | 0 | 0.00" |
| 2 | 1 | 1.125" |
| 3 | 4 | 4.50" |
| 4 | 2 | 2.25" |
| 5 | 2 | 2.25" |
| 6 | 4 | 4.50" |
| 7 | 1 | 1.125" |

Note: Pattern is symmetrical around center well.

### QRD N7 Panel Construction

**Single Panel (15.75" W × 36" H × 5.25" D):**

**Cut List - One Panel:**

*Fins (vertical dividers):*
| Qty | Dimension | Material | Notes |
|-----|-----------|----------|-------|
| 8 | 0.25" × 4.5" × 36" | 1/4" plywood | Full height fins |

*Well bottoms (if using block method):*
| Well # | Qty | Block Height | Dimension | Material |
|--------|-----|--------------|-----------|----------|
| 1, 7 | 2 | 4.50" | 2" × 4.5" × 36" | 3/4" MDF stacked |
| 2, 6 | 2 | 3.375" | 2" × 3.375" × 36" | 3/4" MDF stacked |
| 4, 5 | 2 | 2.25" | 2" × 2.25" × 36" | 3/4" MDF stacked |
| 3 | 1 | 0" | (empty - deepest) | n/a |

*Frame:*
| Qty | Dimension | Material | Notes |
|-----|-----------|----------|-------|
| 1 | 15.75" × 36" × 0.75" | 3/4" MDF | Backboard |
| 2 | 0.75" × 5.25" × 36" | 3/4" MDF | Side rails |
| 2 | 0.75" × 5.25" × 14.25" | 3/4" MDF | Top/bottom rails |

### Full Array Design (8' Wide × 3' Tall)

**Array Configuration:** 6 panels side-by-side
- Total width: 6 × 15.75" = 94.5" (7.875')
- Height: 36"
- Depth: 5.25"

**Barker Modulation (reduces lobing from periodic arrays):**

Mount panels at varying depths using this pattern:
- Panel sequence: + + + - + (for 5 panels) or + + - + + - (for 6 panels)
- "+" = flush to wall
- "-" = offset 1-2" forward

Alternative: Use profiled modulation from Arqen research:
- 6-panel depth offsets: 0", 2", 3", 3", 2", 0" (from wall)

### Complete Cut List - 6-Panel QRD Array

**3/4" MDF (4×8 sheets):**
- Backboards: 6 @ 15.75" × 36" = 23.6 sq ft
- Side rails: 12 @ 0.75" × 5.25" × 36"
- Top/bottom rails: 12 @ 0.75" × 5.25" × 14.25"
- Well blocks (various heights): ~35 sq ft equivalent
- **Total: ~3 sheets of 3/4" MDF**

**1/4" Plywood:**
- Fins: 48 @ 0.25" × 4.5" × 36"
- Can rip from 4×8 sheet: 8 strips @ 4.5" × 96"
- Cut each strip into 2.67 fins (36" each)
- **Total: ~2 sheets of 1/4" plywood**

---

## 4. Design Option B: Skyline Diffuser {#skyline-design}

### Why Skyline?

Skyline (Primitive Root Diffuser / PRD) offers:
- Visual appeal (looks like a cityscape)
- 2D diffusion (scatters in horizontal AND vertical planes)
- Easier assembly (just blocks on a grid)
- More forgiving construction tolerance
- Good for ceiling applications too

**Trade-offs:**
- More cuts required (but simpler cuts)
- Slightly less predictable than QRD
- Calculation is more complex (use online calculator)

### Design Specifications

**Target Performance:**
- Design frequency: ~700 Hz (based on deepest block)
- Effective range: ~500 Hz to 5,000+ Hz
- Block width determines HF cutoff

**Using N7 PRD sequence for 2D pattern:**

| Parameter | Value |
|-----------|-------|
| Block width | 1.5" × 1.5" | 
| Grid size | 7 × 7 blocks |
| Panel dimensions | 10.5" × 10.5" |
| Max block height | 6.0" |
| Height unit | 1.0" |

**2D Skyline Height Map (N7 × N7):**

Each number is block height in inches:

```
Column:  1    2    3    4    5    6    7
       ┌────┬────┬────┬────┬────┬────┬────┐
Row 1  │ 0  │ 1  │ 4  │ 2  │ 2  │ 4  │ 1  │
       ├────┼────┼────┼────┼────┼────┼────┤
Row 2  │ 1  │ 2  │ 5  │ 3  │ 3  │ 5  │ 2  │
       ├────┼────┼────┼────┼────┼────┼────┤
Row 3  │ 4  │ 5  │ 1  │ 6  │ 6  │ 1  │ 5  │
       ├────┼────┼────┼────┼────┼────┼────┤
Row 4  │ 2  │ 3  │ 6  │ 4  │ 4  │ 6  │ 3  │
       ├────┼────┼────┼────┼────┼────┼────┤
Row 5  │ 2  │ 3  │ 6  │ 4  │ 4  │ 6  │ 3  │
       ├────┼────┼────┼────┼────┼────┼────┤
Row 6  │ 4  │ 5  │ 1  │ 6  │ 6  │ 1  │ 5  │
       ├────┼────┼────┼────┼────┼────┼────┤
Row 7  │ 1  │ 2  │ 5  │ 3  │ 3  │ 5  │ 2  │
       └────┴────┴────┴────┴────┴────┴────┘
```

**Block Count by Height (per 7×7 panel):**

| Height | Count | Notes |
|--------|-------|-------|
| 0" | 1 | No block (leave empty) |
| 1" | 8 | Shortest blocks |
| 2" | 8 | |
| 3" | 8 | |
| 4" | 8 | |
| 5" | 8 | |
| 6" | 8 | Tallest blocks |
| **Total** | **49** | Per panel |

### Full Array Design (8' Wide × 3' Tall)

**Array Configuration:**
- Panels across: 9 panels (9 × 10.5" = 94.5")
- Panels high: 3 panels (3 × 10.5" = 31.5")
- Total panels: 27 panels
- Total blocks: 27 × 49 = 1,323 blocks

### Simplified Skyline Alternative

Instead of true PRD calculation, use quasi-random heights:

**Simplified 18" × 18" Panel (using 1.5" × 1.5" blocks):**
- Grid: 12 × 12 = 144 blocks per panel
- Heights: Random selection from 1", 2", 3", 4", 5", 6"
- Panels needed: ~15 panels for 8' × 3' coverage

**Cut List - Simplified Skyline (1.5" × 1.5" blocks):**

Rip 2×2 lumber (actual 1.5" × 1.5") to lengths:

| Height | Qty Needed | Linear Feet |
|--------|------------|-------------|
| 1" | ~360 | 30 ft |
| 2" | ~360 | 60 ft |
| 3" | ~360 | 90 ft |
| 4" | ~360 | 120 ft |
| 5" | ~360 | 150 ft |
| 6" | ~360 | 180 ft |
| **Total** | **~2,160** | **630 ft** |

Material: ~80 pieces of 8' 2×2 lumber

---

## 5. Construction Methods {#construction}

### Method A: Block-and-Fin (QRD)

**Tools Required:**
- Table saw (for ripping fins and blocks)
- Miter saw (for cutting to length)
- Brad nailer or finish nailer
- Wood glue
- Clamps
- Sandpaper (120, 220 grit)

**Assembly Sequence:**

1. **Cut all fins** to 4.5" × 36" from 1/4" plywood
2. **Cut backboard** to 15.75" × 36" from 3/4" MDF
3. **Mark fin positions** on backboard at 2.25" intervals
4. **Build well blocks:**
   - Stack and glue 3/4" MDF strips to achieve target heights
   - Heights: 4.5", 3.375", 2.25", 0" (7 total per panel)
5. **Attach blocks** to backboard with glue and brads
6. **Insert fins** between blocks, glue to backboard
7. **Add frame rails** around perimeter
8. **Sand and finish** (polyurethane or paint)

**Pro Tip - Dado Method:**
Instead of separate blocks, dado grooves into the fins at the correct depths and insert well bottom pieces into the dadoes. More precision required but cleaner result.

### Method B: Block Grid (Skyline)

**Tools Required:**
- Miter saw or chop saw (for cutting blocks)
- Wood glue
- Backing board (3/4" MDF or plywood)
- Optional: Pneumatic brad nailer

**Assembly Sequence:**

1. **Cut backing board** to panel size (e.g., 18" × 18")
2. **Draw grid** on backing board (1.5" squares)
3. **Number each square** according to height map
4. **Cut all blocks** to required heights
   - Set up stop blocks on miter saw for each height
   - Cut all blocks of one height before moving to next
5. **Sort blocks** into bins by height
6. **Glue blocks** to backing board following pattern
   - Work row by row
   - Apply glue to bottom of block only
   - Press firmly into position
7. **Let cure** 24 hours
8. **Finish** with clear coat or paint

### Finishing Options

**Appearance Considerations:**
- **Natural wood:** Clear polyurethane (2-3 coats)
- **Painted:** Latex paint in room color (maintains acoustic properties)
- **Stained:** Wood stain + polyurethane

**Acoustic Note:** Varnish/seal the wood to maximize reflection. Unsealed wood absorbs slightly more high-frequency energy.

---

## 6. Materials & Cost Estimates {#materials}

### QRD N7 Array (6 panels, 8' × 3')

| Material | Quantity | Unit Price | Total |
|----------|----------|------------|-------|
| 3/4" MDF (4×8) | 3 sheets | $45 | $135 |
| 1/4" Plywood (4×8) | 2 sheets | $25 | $50 |
| Wood glue (32oz) | 2 bottles | $12 | $24 |
| Brad nails (1.5") | 1 box | $8 | $8 |
| Sandpaper (assorted) | 1 pack | $15 | $15 |
| Polyurethane (qt) | 1 | $18 | $18 |
| Mounting hardware | - | - | $30 |
| **Total** | | | **$280** |

### Skyline Array (15 panels, 8' × 3')

| Material | Quantity | Unit Price | Total |
|----------|----------|------------|-------|
| 2×2×8 lumber | 80 pieces | $3 | $240 |
| 3/4" MDF (4×8) backing | 2 sheets | $45 | $90 |
| Wood glue (32oz) | 4 bottles | $12 | $48 |
| Sandpaper | 1 pack | $15 | $15 |
| Polyurethane (qt) | 2 | $18 | $36 |
| Mounting hardware | - | - | $40 |
| **Total** | | | **$469** |

### Budget Comparison

| Option | Material Cost | Labor Hours | Complexity |
|--------|--------------|-------------|------------|
| QRD N7 | ~$280 | 20-30 hrs | Medium |
| Skyline | ~$470 | 30-40 hrs | Easy |
| Commercial equivalent | $1,500-3,000 | 0 | N/A |

---

## 7. Resources & Calculators {#resources}

### Online Calculators

**QRDude (Windows application):**
- Download: https://www.subwoofer-builder.com/qrdude.htm
- Features: Advanced QRD design, depth optimization, imperial/metric
- User guide: https://www.subwoofer-builder.com/qrd.htm

**Web-based QRD Calculator:**
- http://www.mh-audio.nl/Acoustics/diffusor.asp
- Simple, quick calculations

**Skyline/PRD Calculator:**
- https://www.acousticmodelling.com/prd.php
- Generates 2D height maps

### Design References

**Arqen "Leanfuser" (Free Open Source):**
- http://arqen.com/sound-diffusers/
- Optimized stepped diffuser design
- Download includes fabrication drawings
- Creative Commons licensed for personal use

**Master Handbook of Acoustics (F. Alton Everest):**
- Chapter on diffusers with well depth ratio charts
- Essential reference for QRD theory

**Acoustic Absorbers and Diffusers (Cox & D'Antonio):**
- The definitive technical reference
- Available at university libraries

### Video Tutorials

- "How to Build a QRD Diffuser" - Sound Proof Your Studio (YouTube)
- QRD build time-lapse videos on various woodworking channels
- Search: "DIY acoustic diffuser build"

---

## Appendix A: Alternative - Arqen Leanfuser

The **Leanfuser** is an optimized stepped diffuser that's simpler than QRD:
- Only 7 different step heights (like QRD N7)
- No fins/dividers required
- Can be made from simple wood strips
- Excellent performance when multiple panels use "profiled modulation"

**Leanfuser Dimensions:**
- Panel width: 420mm (16.5")
- Panel height: 600mm (23.6") or 1200mm (47.2")
- Step widths: 60mm (2.36") each
- Step depths: 0, 40, 50, 30, 50, 40, 0 mm
- Max depth: 50mm (2")

**5-Panel Profiled Modulation:**
Mount 5 panels at these offsets from wall:
- Panels 1, 5: 0mm (flush)
- Panels 2, 4: 50mm offset
- Panel 3: 60mm offset (center)

This is an excellent option if you want simpler construction than QRD.

---

## Appendix B: Room Mode Analysis

Your room dimensions (16' × 26' × 10') produce these axial modes:

| Mode | Frequency | Direction |
|------|-----------|-----------|
| 1,0,0 | 22 Hz | Length (26') |
| 0,1,0 | 35 Hz | Width (16') |
| 2,0,0 | 44 Hz | Length |
| 0,0,1 | 56 Hz | Height (10') |
| 1,1,0 | 41 Hz | Diagonal |
| 3,0,0 | 66 Hz | Length |
| 0,2,0 | 71 Hz | Width |

**Note:** Diffusion doesn't address bass modes - that's what your corner-loaded sealed subwoofers and bass traps are for. Diffusion targets mid and high frequencies where imaging and ambiance are affected.

---

*Document created for Home Theater Project*
*See also: Home_Theater_System_Complete_Design_Rev5_2.md*
