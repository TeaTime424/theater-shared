# Arqen Leanfuser Build Plans
## Simplest DIY Diffuser Option

**Version:** 1.0  
**Date:** December 2024  
**Source:** Based on Tim Perry's open-source Leanfuser design (arqen.com)

---

## Why Leanfuser?

The Leanfuser is **significantly easier to build than QRD** because:
- **No fins/dividers** - just stepped blocks
- **No enclosed wells** - simpler assembly
- **Only 7 cut lengths** per panel
- **Optimized performance** - designed using computer simulation
- **Free open-source design** - Creative Commons licensed

### Performance Comparison

| Metric | Leanfuser | QRD N7 |
|--------|-----------|--------|
| Effective range | ~500 Hz - 4,000 Hz | ~425 Hz - 3,400 Hz |
| Build depth | 2" (50mm) | 5.25" |
| Build complexity | Easy | Medium |
| Parts count | 7 strips per panel | 15+ parts per panel |
| Assembly time | 30 min/panel | 90 min/panel |

---

## Design Specifications

### Single Panel Dimensions

| Parameter | Metric | Imperial |
|-----------|--------|----------|
| Width | 420mm | 16.54" |
| Height | 600mm or 1200mm | 23.6" or 47.2" |
| Max depth | 50mm | 1.97" (~2") |
| Step width | 60mm | 2.36" |
| Number of steps | 7 | 7 |

### Step Height Sequence

```
    Step #:    1      2      3      4      5      6      7
    Height:    0mm   40mm   50mm   30mm   50mm   40mm    0mm
              (0")  (1.57") (2")  (1.18") (2")  (1.57")  (0")
```

**Visual Cross-Section:**
```
                 ┌─────┐      ┌─────┐
                 │█████│      │█████│
          ┌─────┐│█████│┌────┐│█████│┌─────┐
          │█████││█████││████││█████││█████│
          │█████││█████││████││█████││█████│
    ──────┴─────┴┴─────┴┴────┴┴─────┴┴─────┴──────
    Step:   1      2      3     4      5      6      7
    Ht:     0"   1.57"   2"   1.18"   2"   1.57"    0"
```

---

## Imperial Conversion (Practical Build)

For easier construction with standard lumber, use these dimensions:

### Converted Dimensions (using 12mm ≈ 0.5" depth unit)

| Step # | Original (mm) | Practical (inches) | Achieved With |
|--------|---------------|-------------------|---------------|
| 1 | 0mm | 0" | No strip |
| 2 | 40mm | 1.5" | 3 × 1/2" strips |
| 3 | 50mm | 2.0" | 4 × 1/2" strips |
| 4 | 30mm | 1.5" | 3 × 1/2" strips |
| 5 | 50mm | 2.0" | 4 × 1/2" strips |
| 6 | 40mm | 1.5" | 3 × 1/2" strips |
| 7 | 0mm | 0" | No strip |

### Panel Dimensions (Imperial)

| Parameter | Value |
|-----------|-------|
| Strip width | 2.5" (allows for some kerf) |
| Panel width | 7 × 2.5" = 17.5" |
| Panel height | 48" (4 feet) |
| Max depth | 2" |
| Backing board | 17.5" × 48" |

---

## 5-Panel Array with Profiled Modulation

**Recommended Configuration:** Mount 5 panels with varying offsets

```
FRONT VIEW:
┌─────────┬─────────┬─────────┬─────────┬─────────┐
│ Panel 1 │ Panel 2 │ Panel 3 │ Panel 4 │ Panel 5 │
└─────────┴─────────┴─────────┴─────────┴─────────┘

SIDE VIEW (exaggerated):
                    ┌───┐
              ┌───┐ │ 3 │ ┌───┐
        ┌───┐ │ 2 │ │   │ │ 4 │ ┌───┐
        │ 1 │ │   │ │   │ │   │ │ 5 │
════════╧═══╧═╧═══╧═╧═══╧═╧═══╧═╧═══╧════════
        0"   2"    2.5"   2"    0"
              ↑ offset from wall
```

**Profiled Modulation 1 (5 panels):**

| Panel | Offset from Wall |
|-------|------------------|
| 1 | 0" (flush) |
| 2 | 2" |
| 3 | 2.5" (center, most offset) |
| 4 | 2" |
| 5 | 0" (flush) |

**Total Array Dimensions:**
- Width: 5 × 17.5" = 87.5" (7.3 feet)
- Height: 48" (4 feet)
- Depth: 2" + 2.5" offset = 4.5" max from wall

---

## COMPLETE BUILD INSTRUCTIONS

### Materials Needed (5-Panel Array)

**Option A: MDF Construction**
| Material | Size | Qty | Price | Total |
|----------|------|-----|-------|-------|
| MDF | 1/2" × 4' × 8' | 2 | $32 | $64 |
| MDF | 3/4" × 4' × 8' | 1 | $45 | $45 |
| Wood glue | 32 oz | 1 | $14 | $14 |
| Brad nails | 1" box | 1 | $8 | $8 |
| Polyurethane | Quart | 1 | $18 | $18 |
| French cleats | Pair | 5 | $8 | $40 |
| **Total** | | | | **$189** |

**Option B: Solid Wood Construction**
| Material | Size | Qty | Price | Total |
|----------|------|-----|-------|-------|
| 1×3 pine boards | 8' | 30 | $4 | $120 |
| Plywood backing | 1/2" × 4' × 8' | 1 | $35 | $35 |
| Wood glue | 32 oz | 1 | $14 | $14 |
| Brad nails | 1" box | 1 | $8 | $8 |
| Polyurethane | Quart | 1 | $18 | $18 |
| French cleats | Pair | 5 | $8 | $40 |
| **Total** | | | | **$235** |

### Cut List (5 Panels)

**Using 1/2" MDF for step strips:**

| Height | Strips Per Panel | Total (5 panels) | Length |
|--------|-----------------|------------------|--------|
| 2.0" | 2 strips (steps 3, 5) | 10 | 48" |
| 1.5" | 2 strips (steps 2, 6) | 10 | 48" |

Wait - let me recalculate. The Leanfuser builds steps by **stacking** strips:

**Per Panel Step Construction:**
- Step 1: 0" (backing board only)
- Step 2: Stack to 1.5" (3 layers of 1/2")
- Step 3: Stack to 2.0" (4 layers of 1/2")
- Step 4: Stack to 1.5" (3 layers of 1/2")  
- Step 5: Stack to 2.0" (4 layers of 1/2")
- Step 6: Stack to 1.5" (3 layers of 1/2")
- Step 7: 0" (backing board only)

**Strips needed per panel:** (3+4+3+4+3) = 17 strips @ 2.5" × 48"

**Total strips for 5 panels:** 85 strips @ 2.5" × 48"

**From 4×8 MDF sheet (1/2"):**
- Rip into 2.5" strips: 19 strips per sheet
- Each strip yields one 48" piece
- Need: 85 strips ÷ 19/sheet = **4.5 sheets of 1/2" MDF**

**Revised materials:**
| Material | Qty | Price | Total |
|----------|-----|-------|-------|
| MDF 1/2" × 4' × 8' | 5 | $32 | $160 |
| MDF 3/4" × 4' × 8' (backing) | 1 | $45 | $45 |
| Other supplies | | | $80 |
| **Total** | | | **$285** |

---

### Simplified Method: Pre-Cut Blocks

Instead of stacking strips, cut solid blocks to height:

**From 2" thick lumber or stacked 3/4" MDF:**

| Step Height | Block Size | Per Panel | Total (5) |
|-------------|-----------|-----------|-----------|
| 2.0" | 2.5" × 48" × 2.0" | 2 | 10 |
| 1.5" | 2.5" × 48" × 1.5" | 3 | 15 |
| 0" | (no block) | 2 | 10 |

**Using 2×3 lumber (actual 1.5" × 2.5"):**
- Rip to 2.5" width ✓ (already correct)
- For 2" steps: Stack 1.5" board + 1/2" strip
- For 1.5" steps: Use as-is

---

## ASSEMBLY STEPS

### Step 1: Cut Backing Boards (30 min)

Cut 5 backing boards from 3/4" MDF:
- Size: 17.5" × 48" each
- Sand edges smooth

### Step 2: Mark Step Positions (15 min)

On each backing board, draw vertical lines at:
- 0", 2.5", 5.0", 7.5", 10.0", 12.5", 15.0", 17.5"

Label steps 1-7 between lines.

### Step 3: Cut Step Pieces (2 hours)

**If using strip stacking method:**
- Cut 85 strips: 2.5" × 48" from 1/2" MDF
- Stack and glue to create step heights

**If using solid block method:**
- Cut 2" high blocks: 10 pieces
- Cut 1.5" high blocks: 15 pieces

### Step 4: Assemble Panels (2 hours for all 5)

For each panel:
1. Apply glue to bottom of step block
2. Position block in correct step location
3. Press firmly, use clamps or weights
4. Repeat for all steps (skip steps 1 and 7 - these are just backing board)

```
Assembly Order:
1. Place Step 3 block (2" high) at position 3
2. Place Step 5 block (2" high) at position 5
3. Place Step 2 block (1.5" high) at position 2
4. Place Step 4 block (1.5" high) at position 4
5. Place Step 6 block (1.5" high) at position 6
6. Let glue dry 1 hour before handling
```

### Step 5: Sand and Finish (2 hours)

1. Sand all surfaces with 120 grit
2. Round over sharp edges slightly
3. Apply 2 coats polyurethane
4. Let cure 24 hours

### Step 6: Mount Hardware (30 min)

1. Attach French cleat strips to back of each panel
2. Position cleats to achieve profiled modulation offsets
3. Mount wall cleats at correct heights

### Step 7: Install (1 hour)

1. Mount wall cleats to studs
2. Hang panels 1 and 5 flush to wall
3. Add spacers behind panels 2 and 4 (2" offset)
4. Add spacers behind panel 3 (2.5" offset)
5. Verify all panels are level

---

## ALTERNATIVE: 7-Panel Fractal Modulation

For wider coverage (10.2 feet), use 7 panels with fractal depth modulation:

**Depth Offsets (based on step sequence):**

| Panel | Offset from Wall |
|-------|------------------|
| 1 | 0" |
| 2 | 1.5" |
| 3 | 2.0" |
| 4 | 1.25" |
| 5 | 2.0" |
| 6 | 1.5" |
| 7 | 0" |

This creates a "fractal" effect where the macro mounting pattern mirrors the micro step pattern.

---

## QUALITY TIPS

### For Best Acoustic Performance:
1. **Seal all surfaces** - Use polyurethane or paint to make surfaces reflective
2. **No gaps** - Fill any gaps between steps with wood filler
3. **Square edges** - Keep step edges crisp, not rounded
4. **Consistent spacing** - Maintain equal step widths

### Common Mistakes to Avoid:
- ❌ Leaving steps unsealed (absorbs HF energy)
- ❌ Uneven step heights (disrupts diffusion pattern)
- ❌ Placing panels too close to listeners
- ❌ Mounting all panels at same depth (creates lobing)

---

## RESOURCES

**Original Leanfuser Documentation:**
- Website: http://arqen.com/sound-diffusers/
- Download: http://arqen.com/downloads/acoustics/diffusers/
- License: Creative Commons BY-NC-SA 3.0

**Fabrication Drawings:**
The original includes detailed metric drawings. Key dimensions:
- Module width: 420mm (60mm × 7 steps)
- Module height: 600mm or 1200mm
- Step depths: 0, 40, 50, 30, 50, 40, 0 mm

**Note:** The Leanfuser is optimized through computer simulation. Changing the proportions will affect performance. If building in imperial, try to maintain the same ratios.
