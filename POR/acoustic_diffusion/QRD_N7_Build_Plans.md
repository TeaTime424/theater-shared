# QRD N7 Diffuser Array - Detailed Build Plans
## 6-Panel Array for Rear Wall (8' × 3')

**Version:** 1.0  
**Date:** December 2024

---

## Design Summary

| Parameter | Value |
|-----------|-------|
| Configuration | 6 panels in a row |
| Panel size | 15.75" W × 36" H × 5.25" D |
| Total array | 94.5" W × 36" H |
| Design frequency | 600 Hz |
| Effective range | ~425 Hz - 3,400 Hz |
| Weight per panel | ~15-18 lbs |
| Total weight | ~100 lbs |

---

## QRD N7 Theory Quick Reference

**Well Depth Sequence:** 0, 1, 4, 2, 2, 4, 1

This sequence is derived from: n² mod 7, where n = 0 to 6
- 0² mod 7 = 0
- 1² mod 7 = 1
- 2² mod 7 = 4
- 3² mod 7 = 2
- 4² mod 7 = 2
- 5² mod 7 = 4
- 6² mod 7 = 1

**Scaling:** Multiply sequence values by "unit depth" to get actual well depths.
- Unit depth = 1.125" (chosen for construction convenience)
- Maximum well depth = 4 × 1.125" = 4.5" (sequence value 4)

---

## Panel Dimensions Detail

```
            ┌─────────────────────────────────────────┐
            │              15.75" total               │
            │  ┌───┬───┬───┬───┬───┬───┬───┬───┐     │
            │  │fin│ W │fin│ W │fin│ W │fin│ W │     │
            │  │.25│ 2 │.25│ 2 │.25│ 2 │.25│ 2 │ ... │
            │  └───┴───┴───┴───┴───┴───┴───┴───┘     │
            └─────────────────────────────────────────┘
            
                    CROSS-SECTION VIEW
    ┌─────────────────────────────────────────────────────┐
    │                                                     │
    │  ┌──┬──────┬──┬──────┬──┬──────┬──┬──────┬──┬──────┤
    │  │  │██████│  │      │  │      │  │      │  │██████│ 5.25"
    │  │  │██████│  │██████│  │      │  │██████│  │██████│ total
    │  │  │██████│  │██████│  │██████│  │██████│  │██████│ depth
    │  └──┴──────┴──┴──────┴──┴──────┴──┴──────┴──┴──────┤
    │  ═══════════════════════════════════════════════════│ 0.75" back
    └─────────────────────────────────────────────────────┘
       W1   W2     W3   W4     W5   W6     W7
      4.5" 3.375" 0"  2.25"  2.25" 0"   3.375" 4.5"
                  ↑deepest        ↑deepest
```

### Well Configuration (per panel)

| Well # | Position | Sequence | Block Height | Well Depth |
|--------|----------|----------|--------------|------------|
| 1 | Left edge | 0 | 4.50" | 0.00" (shallowest) |
| 2 | | 1 | 3.375" | 1.125" |
| 3 | | 4 | 0.00" | 4.50" (deepest) |
| 4 | Center | 2 | 2.25" | 2.25" |
| 5 | | 2 | 2.25" | 2.25" |
| 6 | | 4 | 0.00" | 4.50" (deepest) |
| 7 | Right edge | 1 | 3.375" | 1.125" |

Note: Block height + Well depth = 4.50" (constant)

---

## COMPLETE CUT LIST

### Material 1: 3/4" MDF (0.75" thick)

**Sheet Yield Planning:**
- Sheet size: 48" × 96" = 32 sq ft per sheet
- Need approximately 3 sheets

#### Part A: Backboards (6 required)
| Qty | Width | Length | Thickness | Notes |
|-----|-------|--------|-----------|-------|
| 6 | 15.75" | 36" | 0.75" | One per panel |

*Cutting from 4×8 sheet:*
- Rip sheet to 36" width (leaves 12" waste strip)
- Crosscut into 15.75" pieces
- Yield: 6 pieces from one sheet

#### Part B: Side Rails (12 required)
| Qty | Width | Length | Thickness | Notes |
|-----|-------|--------|-----------|-------|
| 12 | 5.25" | 36" | 0.75" | 2 per panel, vertical |

*Cutting from 4×8 sheet:*
- Rip to 5.25" strips
- Crosscut to 36"
- Yield: 9 strips × 2.67 pieces = 24 pieces from one sheet

#### Part C: Top/Bottom Rails (12 required)
| Qty | Width | Length | Thickness | Notes |
|-----|-------|--------|-----------|-------|
| 12 | 5.25" | 14.25" | 0.75" | 2 per panel, horizontal |

*Cut from waste/remnants of rail cuts*

#### Part D: Well Blocks (fill blocks to set well depths)

**Method: Stack 3/4" MDF strips**

For 4.50" blocks (wells 1 & 7):
- Stack 6 layers of 0.75" = 4.50"
- Need: 12 blocks total (2 per panel × 6 panels)
- Each block: 2" W × 36" L × 4.50" H (stacked)

For 3.375" blocks (wells 2 & 6):
- Stack 4.5 layers (round to 5 layers, trim 0.375")
- Alternative: Use 4 layers (3.0") + 3/8" hardboard shim
- Need: 12 blocks total
- Each block: 2" W × 36" L × 3.375" H

For 2.25" blocks (wells 4 & 5):
- Stack 3 layers of 0.75" = 2.25"
- Need: 12 blocks total
- Each block: 2" W × 36" L × 2.25" H

**Wells 3 & 6 have NO blocks (deepest wells)**

#### Well Block Cut List Summary

| Block Height | Layers | Qty Blocks | Strips Needed | Strip Size |
|--------------|--------|------------|---------------|------------|
| 4.50" | 6 | 12 | 72 | 2" × 36" |
| 3.375" | 4 + shim | 12 | 48 + shims | 2" × 36" |
| 2.25" | 3 | 12 | 36 | 2" × 36" |
| **Total strips** | | | **156** | |

*From 4×8 MDF sheet:*
- Rip to 2" strips: 24 strips per sheet
- Cut strips to 36": 2 pieces per strip = 48 pieces per sheet
- Need: 156 pieces ÷ 48/sheet = **3.25 sheets for blocks**

### Material 2: 1/4" Plywood (0.25" thick)

**Fins/Dividers (48 required total)**
| Qty | Width | Length | Thickness | Notes |
|-----|-------|--------|-----------|-------|
| 48 | 4.50" | 36" | 0.25" | 8 per panel |

*Cutting from 4×8 sheet:*
- Rip to 4.5" strips: 10 strips per sheet
- Crosscut to 36": 2.67 pieces per strip
- Yield per sheet: ~26 fins
- **Need: 2 sheets**

---

## MATERIALS SHOPPING LIST

### Lumber/Sheet Goods

| Item | Size | Qty | Est. Price | Subtotal |
|------|------|-----|------------|----------|
| MDF | 3/4" × 4' × 8' | 4 | $45 | $180 |
| Plywood (birch/maple) | 1/4" × 4' × 8' | 2 | $28 | $56 |
| **Subtotal** | | | | **$236** |

### Hardware & Consumables

| Item | Qty | Est. Price | Subtotal |
|------|-----|------------|----------|
| Wood glue (Titebond II), 32oz | 2 | $14 | $28 |
| Brad nails, 1-1/4" | 1 box | $8 | $8 |
| Brad nails, 1" | 1 box | $8 | $8 |
| Sandpaper, 120 grit | 10 sheets | $1 | $10 |
| Sandpaper, 220 grit | 10 sheets | $1 | $10 |
| Polyurethane, satin (qt) | 1 | $18 | $18 |
| Wood filler | 1 | $6 | $6 |
| French cleats or Z-clips | 6 sets | $5 | $30 |
| **Subtotal** | | | **$118** |

### TOTAL PROJECT COST: ~$354

---

## ASSEMBLY INSTRUCTIONS

### Phase 1: Cutting (4-6 hours)

**Safety:** Wear dust mask and eye protection when cutting MDF.

1. **Cut backboards (6 pieces)**
   - Set table saw fence to 15.75"
   - Rip full sheet to 36" width first
   - Crosscut into 15.75" pieces

2. **Cut side rails (12 pieces)**
   - Set fence to 5.25"
   - Rip strips from sheet
   - Crosscut to 36" lengths

3. **Cut top/bottom rails (12 pieces)**
   - From 5.25" strips, cut 14.25" pieces

4. **Cut well block strips (156 pieces)**
   - Set fence to 2"
   - Rip strips from sheet
   - Crosscut to 36" lengths
   - Sort into groups of 6, 4, and 3 for stacking

5. **Cut fins (48 pieces)**
   - Set fence to 4.5"
   - Rip 1/4" plywood into strips
   - Crosscut to 36" lengths

### Phase 2: Block Assembly (3-4 hours)

**Build well blocks by laminating MDF strips:**

1. **4.50" blocks (12 needed):**
   - Stack 6 strips of 2" × 36" × 0.75"
   - Apply glue between each layer
   - Clamp and let dry 1 hour
   - Final size: 2" × 36" × 4.5"

2. **3.375" blocks (12 needed):**
   - Stack 4 strips (= 3.0")
   - After dry, add 3/8" hardboard strip on top
   - Or: Stack 5 strips and plane/sand to 3.375"
   - Final size: 2" × 36" × 3.375"

3. **2.25" blocks (12 needed):**
   - Stack 3 strips
   - Glue, clamp, dry
   - Final size: 2" × 36" × 2.25"

**Tip:** Build all blocks the day before panel assembly. Use cauls (flat boards) on top of stacks for even pressure.

### Phase 3: Panel Assembly (1-1.5 hours per panel)

**Per panel:**

1. **Lay out backboard** (15.75" × 36") on flat surface

2. **Mark fin positions** on backboard:
   - Starting from left edge: 0", 2.25", 4.5", 6.75", 9.0", 11.25", 13.5", 15.75"
   - These marks are CENTER lines for fins

3. **Install well blocks in sequence:**
   ```
   Position:  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |
   Block Ht:  |4.50"|3.375"| 0" |2.25"|2.25"| 0" |3.375"|
   ```
   - Apply glue to bottom of block
   - Press block into position against backboard
   - Use brad nailer through back of backboard into blocks (optional for reinforcement)
   - Wells 3 and 6: NO BLOCK (deepest wells, just bare backboard)

4. **Install fins between blocks:**
   - Apply glue to bottom edge of fin
   - Slide fin into position between blocks
   - Fin should touch backboard and be flush with top of tallest blocks (4.5")
   - Secure with brads from side if needed

5. **Install side rails:**
   - Apply glue to mating surfaces
   - Attach 5.25" × 36" rails to left and right edges
   - These should be flush with back of backboard
   - Secure with brads

6. **Install top/bottom rails:**
   - Apply glue
   - Attach 5.25" × 14.25" rails to top and bottom
   - Creates complete frame around diffuser
   - Secure with brads

7. **Fill and sand:**
   - Fill any gaps with wood filler
   - Let dry, sand smooth
   - Sand entire exterior with 120 grit, then 220 grit

### Phase 4: Finishing (2-3 hours total)

1. **Seal all surfaces** with polyurethane:
   - Apply thin coat to interior wells (important for acoustic reflection)
   - Apply 2-3 coats to exterior surfaces
   - Sand lightly with 320 grit between coats
   - Let cure fully before mounting (24 hours)

2. **Alternative: Paint**
   - Prime with shellac-based primer (seals MDF)
   - Apply 2 coats latex paint
   - Dark colors work well in theater setting

### Phase 5: Mounting

**French Cleat Method (Recommended):**
- Cut 45° beveled strips from 3/4" material
- Mount lower half of cleat to wall studs
- Mount upper half of cleat to back of diffuser
- Hang diffuser on wall cleat

**Profiled Modulation Mounting:**
If mounting all 6 panels with depth offsets:

| Panel # | Offset from Wall |
|---------|------------------|
| 1 (left) | 0" (flush) |
| 2 | 1.5" offset |
| 3 | 2.5" offset |
| 4 | 2.5" offset |
| 5 | 1.5" offset |
| 6 (right) | 0" (flush) |

Use spacer blocks behind French cleats to achieve offsets.

---

## QUALITY CHECKS

### During Assembly
- [ ] All well blocks are flush with backboard edge
- [ ] Fins are perpendicular to backboard (use square)
- [ ] No gaps between fins and blocks
- [ ] Frame is square (measure diagonals)

### After Finishing
- [ ] All interior surfaces sealed (knock on wood - should sound solid)
- [ ] No rough edges that could snag
- [ ] Mounting hardware secure

### After Installation
- [ ] Panels are level
- [ ] Panels are securely mounted (test with firm push)
- [ ] Array is centered on listening position

---

## TOOLS REQUIRED

### Essential
- Table saw (for ripping sheet goods)
- Miter saw or circular saw (for crosscuts)
- Brad nailer (pneumatic or electric) + compressor if pneumatic
- Tape measure
- Square (framing square or speed square)
- Clamps (4-6 bar clamps minimum)
- Safety glasses
- Dust mask (P100 for MDF)

### Recommended
- Dado blade set (for cleaner joints)
- Random orbit sander
- Paint brushes or foam rollers
- Workbench or sawhorses with plywood top

### Optional
- Biscuit joiner (for stronger glue joints)
- Router with flush trim bit (for cleanup)
- Thickness planer (for precise block heights)

---

## APPENDIX: Alternative Block Heights

If you can't achieve exact heights, here are acceptable substitutions:

| Target | Acceptable Range | Achieved With |
|--------|-----------------|---------------|
| 4.50" | 4.25" - 4.75" | 6 × 3/4" MDF = 4.5" ✓ |
| 3.375" | 3.0" - 3.5" | 4 × 3/4" + 3/8" hardboard |
| 2.25" | 2.0" - 2.5" | 3 × 3/4" MDF = 2.25" ✓ |

The diffuser will work well as long as the *ratios* between well depths are approximately maintained.
