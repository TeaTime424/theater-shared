# Hollow Profile Leanfuser Construction Guide
## Lightweight "Rib and Skin" Build Method

**Version:** 1.0  
**Date:** December 2024  
**Location:** Rear wall above backrest (60" - 96" from floor)

---

## Design Summary

| Parameter | Value |
|-----------|-------|
| Panel dimensions | 17.5" W × 48" H × 2.5" D |
| Construction method | Hollow profile (rib and skin) |
| Material | 1/2" plywood throughout |
| Weight per panel | ~6-8 lbs |
| Array configuration | 5 panels with profiled modulation |
| Total coverage | 87.5" W × 48" H (7.3' × 4') |

---

## Why Hollow Construction

### Advantages Over Solid Stack

| Aspect | Solid Stack | Hollow Profile |
|--------|-------------|----------------|
| Weight | ~18 lbs/panel | ~6-8 lbs/panel |
| Material cost | ~$285 (5 panels) | ~$110 (5 panels) |
| Material waste | Higher | Lower |
| Assembly complexity | Many layers to align | Simple box construction |
| Acoustic performance | Excellent | Identical |
| Mounting ease | Heavy, needs robust cleats | Light, easy to hang |

### Why No Fill Material

The diffuser works by **surface reflection**, not internal properties. The stepped profile creates path length differences that scatter sound waves.

| Fill Option | Effect | Recommendation |
|-------------|--------|----------------|
| Empty (air) | Full reflection/diffusion | ✓ **Use this** |
| Insulation | Absorbs energy, reduces diffusion | ✗ Don't use |
| Foam | Adds weight, no benefit | ✗ Don't use |
| Rigid material | Unnecessary, adds weight/cost | ✗ Don't use |

**Rule:** If you want absorption, build an absorber. If you want diffusion, build a diffuser. Don't compromise both in one panel when you have space for dedicated treatment.

---

## Profile Template

### Dimensions

The profile shape is cut from 1/2" plywood. You need 2 identical profiles per panel (left and right edges), plus optional center ribs for panels over 36" tall.

**Profile Dimensions (in inches):**

```
                    PROFILE TEMPLATE - CUT FROM 1/2" PLYWOOD
                    
        ←───────────────────── 17.5" ─────────────────────→
        
        ←─2.5"─→←─2.5"─→←─2.5"─→←─2.5"─→←─2.5"─→←─2.5"─→←─2.5"─→
        
        ┌──────┐                                        ┌──────┐  ─┬─
        │ STEP │                                        │ STEP │   │
        │  1   │                                        │  7   │   │
        │      │┌──────┐                        ┌──────┐│      │   │
        │ 0"   ││ STEP │                        │ STEP ││  0"  │   │
        │      ││  2   │┌──────┐        ┌──────┐│  6   ││      │   │
        │      ││      ││ STEP │┌──────┐│ STEP ││      ││      │   │ 2.5"
        │      ││ 1.5" ││  3   ││ STEP ││  5   ││ 1.5" ││      │   │ max
        │      ││      ││      ││  4   ││      ││      ││      │   │ height
        │      ││      ││ 2.0" ││      ││ 2.0" ││      ││      │   │
        │      ││      ││      ││ 1.5" ││      ││      ││      │   │
────────┴──────┴┴──────┴┴──────┴┴──────┴┴──────┴┴──────┴┴──────┴───┴─
        
        STEP:    1       2       3       4       5       6       7
        HEIGHT:  0"     1.5"    2.0"    1.5"    2.0"    1.5"     0"
```

### Step-by-Step Profile Coordinates

Starting from back edge (0") and measuring height of each step:

| Step | Width | Height | X Start | X End |
|------|-------|--------|---------|-------|
| 1 | 2.5" | 0.0" | 0.0" | 2.5" |
| 2 | 2.5" | 1.5" | 2.5" | 5.0" |
| 3 | 2.5" | 2.0" | 5.0" | 7.5" |
| 4 | 2.5" | 1.5" | 7.5" | 10.0" |
| 5 | 2.5" | 2.0" | 10.0" | 12.5" |
| 6 | 2.5" | 1.5" | 12.5" | 15.0" |
| 7 | 2.5" | 0.0" | 15.0" | 17.5" |

### Profile Drawing for CNC or Manual Cutting

```
PROFILE OUTLINE (plot these points, connect with straight lines):

Point    X        Y (height)
─────    ─────    ──────────
A        0.0"     0.0"       ← Start (back corner, step 1)
B        2.5"     0.0"       ← End of step 1
C        2.5"     1.5"       ← Rise to step 2
D        5.0"     1.5"       ← End of step 2
E        5.0"     2.0"       ← Rise to step 3
F        7.5"     2.0"       ← End of step 3
G        7.5"     1.5"       ← Drop to step 4
H        10.0"    1.5"       ← End of step 4
I        10.0"    2.0"       ← Rise to step 5
J        12.5"    2.0"       ← End of step 5
K        12.5"    1.5"       ← Drop to step 6
L        15.0"    1.5"       ← End of step 6
M        15.0"    0.0"       ← Drop to step 7
N        17.5"    0.0"       ← End of step 7 (front corner)

Connect: A→B→C→D→E→F→G→H→I→J→K→L→M→N

Then close the shape by connecting N back to A along the bottom.
```

### Making a Template

1. Cut one **perfect profile** from 1/2" MDF or hardboard
2. Sand edges smooth
3. Use this template to trace onto plywood for all profile pieces
4. Template can be reused indefinitely

**Template material:** 1/2" MDF (stable, easy to sand smooth)
**Template size:** 17.5" × 2.5" with stepped profile on one long edge

---

## Exploded View - Panel Assembly

```
                    EXPLODED VIEW - SINGLE PANEL
                    
                              ┌─── Face Plank (Step 3) - 2.0" from back
                              │    ┌─── Face Plank (Step 5) - 2.0" from back
                              │    │
                              ▼    ▼
                         ┌────────────┐
                         │   ┌────┐   │
                    ┌────┤   │    │   ├────┐
                    │    │   │    │   │    │
                    │    │   │    │   │    │  ← Face Planks (Step 2,4,6) - 1.5"
                    │    │   │    │   │    │
                    │    │   │    │   │    │
                    │    │   │    │   │    │
                    │    └───┴────┴───┘    │
                    │                      │
     Left Profile ──┤                      ├── Right Profile
                    │                      │
                    │    ┌────────────┐    │
                    │    │            │    │
                    │    │   BACK     │    │
                    │    │   PANEL    │    │
                    │    │            │    │
                    │    │  17.5" ×   │    │
                    │    │   48"      │    │
                    │    │            │    │
                    │    └────────────┘    │
                    │                      │
                    └──────────────────────┘
                    
                    Face Planks (Steps 1,7) attach flush with back
```

---

## Complete Cut List - Single Panel

### From 1/2" Plywood

| Part | Qty | Dimensions | Notes |
|------|-----|------------|-------|
| Back panel | 1 | 17.5" × 48" | Full rectangle |
| Left profile | 1 | 17.5" × 2.5" (stepped) | Cut stepped profile on one edge |
| Right profile | 1 | 17.5" × 2.5" (stepped) | Mirror of left profile |
| Center rib | 1 | 17.5" × 2.5" (stepped) | Optional - for panels >36" tall |
| Face plank - Steps 1,7 | 2 | 2.5" × 48" | Mount flush with back |
| Face plank - Steps 2,6 | 2 | 2.5" × 48" | Mount at 1.5" height |
| Face plank - Step 4 | 1 | 2.5" × 48" | Mount at 1.5" height |
| Face plank - Steps 3,5 | 2 | 2.5" × 48" | Mount at 2.0" height (tallest) |

**Total per panel:** ~8.5 sq ft of 1/2" plywood

---

## Complete Cut List - 5 Panel Array

### Sheet Yield Analysis

**1/2" Plywood sheet:** 4' × 8' = 32 sq ft

**Per panel material:**
- Back panel: 17.5" × 48" = 5.83 sq ft
- Profiles (2): 17.5" × 2.5" × 2 = 0.61 sq ft
- Face planks (7): 2.5" × 48" × 7 = 5.83 sq ft
- **Total per panel: ~12.3 sq ft**

**For 5 panels:** 12.3 × 5 = 61.5 sq ft = **2 sheets** (with some waste)

### Optimized Cutting Layout

**Sheet 1 (4' × 8'):**
```
┌────────────────────────────────────────────────────┐
│                                                    │
│    BACK PANEL 1        BACK PANEL 2        BACK   │
│    17.5" × 48"         17.5" × 48"         PANEL  │
│                                            3      │
│                                            17.5"  │
│                                            × 48"  │
│                                                   │
├────────────────────────────────────────────┬──────┤
│         FACE PLANKS (rip to 2.5" strips)   │WASTE │
│         Cut 19 strips @ 2.5" × 48"         │      │
└────────────────────────────────────────────┴──────┘
```

**Sheet 2 (4' × 8'):**
```
┌────────────────────────────────────────────────────┐
│                                                    │
│    BACK PANEL 4        BACK PANEL 5        WASTE  │
│    17.5" × 48"         17.5" × 48"                │
│                                                    │
│                                                    │
│                                                    │
│                                                    │
├────────────────────────────────────────────────────┤
│         FACE PLANKS (rip to 2.5" strips)          │
│         Cut remaining strips + PROFILES           │
│         Profiles: 10 pieces @ 17.5" × 2.5"        │
└────────────────────────────────────────────────────┘
```

### Shopping List - 5 Panel Array

| Material | Qty | Unit Price | Total |
|----------|-----|------------|-------|
| 1/2" plywood (4×8 sanded BC or cabinet grade) | 2 sheets | $35 | $70 |
| Wood glue (Titebond II or III) | 1 bottle (16oz) | $10 | $10 |
| 1-1/4" brad nails (18 gauge) | 1 box | $8 | $8 |
| 120 grit sandpaper | 5 sheets | $1 | $5 |
| 220 grit sandpaper | 5 sheets | $1 | $5 |
| Polyurethane (satin or semi-gloss) | 1 quart | $18 | $18 |
| French cleat hardware or Z-clips | 5 pairs | $6 | $30 |
| **TOTAL** | | | **$146** |

---

## Assembly Instructions

### Tools Required

- Table saw (for ripping strips and cutting panels)
- Jigsaw or bandsaw (for cutting profiles)
- Brad nailer (18 gauge) + compressor
- Tape measure
- Square
- Pencil
- Sandpaper or random orbit sander
- Clamps (optional but helpful)
- Safety glasses
- Dust mask

### Step 1: Cut All Back Panels (30 min)

1. Set table saw fence to 17.5"
2. Rip plywood to 17.5" width
3. Crosscut to 48" lengths
4. Result: 5 back panels @ 17.5" × 48"

### Step 2: Cut All Face Plank Strips (30 min)

1. Set table saw fence to 2.5"
2. Rip remaining plywood into 2.5" strips
3. Crosscut to 48" lengths
4. Result: 35 strips @ 2.5" × 48" (7 per panel × 5 panels)

### Step 3: Cut Profile Pieces (1 hour)

**Make template first:**
1. Cut a piece of 1/2" MDF to 17.5" × 2.5"
2. Mark step heights on one long edge (see coordinates above)
3. Cut stepped profile with jigsaw
4. Sand edges smooth - this is your master template

**Cut profiles from plywood:**
1. Trace template onto plywood (need 10 profiles for 5 panels)
2. Cut with jigsaw, staying slightly outside line
3. Sand to line for clean edges
4. **Tip:** Stack 2 pieces and cut both at once to save time

### Step 4: Assemble Panels (20-30 min each)

**For each panel:**

**4a. Attach profiles to back panel**
```
        ┌───────────────────────┐
        │                       │
Profile │                       │ Profile
   ↓    │      BACK PANEL       │    ↓
  ┌┐    │                       │   ┌┐
  ││    │       17.5" × 48"     │   ││
  ││    │                       │   ││
  └┘    │                       │   └┘
        │                       │
        └───────────────────────┘
```
- Apply glue to bottom edge of profile (the straight edge)
- Position profile flush with edge of back panel
- Stepped profile faces inward
- Nail through back panel into profile edge (3-4 brads)
- Repeat for opposite side

**4b. Add center rib (for 48" tall panels)**
- Position center rib at 24" height (middle)
- Glue and nail same as edge profiles

**4c. Attach face planks - START WITH TALLEST (Steps 3 & 5)**
```
ASSEMBLY ORDER:

1. Steps 3 & 5 first (2.0" height) - these register against the top of the profile
2. Steps 2, 4, 6 next (1.5" height)  
3. Steps 1 & 7 last (0" height - flush with back)
```

For each face plank:
- Apply glue to the step edge of both profiles
- Position plank on the step
- Nail through face of plank into profile edge (2 brads per end)
- Ensure plank is flush with profile at that step height

### Step 5: Sand and Finish (2-3 hours total for 5 panels)

1. Fill any gaps with wood filler, let dry
2. Sand all exterior surfaces with 120 grit
3. Round over sharp edges slightly (prevents splinters)
4. Sand with 220 grit
5. Apply first coat of polyurethane
6. Let dry 4 hours, sand lightly with 320 grit
7. Apply second coat
8. Let cure 24 hours before mounting

### Step 6: Mount French Cleats

**On each panel (back side):**
1. Attach 12" French cleat strip, 6" from top edge
2. Cleat beveled edge faces down and out

**On wall:**
1. Locate studs
2. Mount mating cleat strips at correct heights for profiled modulation
3. Beveled edge faces up and out

---

## Profiled Modulation Mounting

### Why Offset Mounting?

Mounting all panels at the same depth creates periodicity, which causes acoustic lobing (uneven scattering). Offsetting panels at varying depths breaks the pattern and dramatically improves diffusion.

### 5-Panel Profiled Modulation 1

```
FRONT VIEW:
┌─────────┬─────────┬─────────┬─────────┬─────────┐
│ Panel 1 │ Panel 2 │ Panel 3 │ Panel 4 │ Panel 5 │
│         │         │(center) │         │         │
└─────────┴─────────┴─────────┴─────────┴─────────┘

SIDE VIEW (looking from left):

                         ┌───────┐
                   ┌─────┤ Panel │
             ┌─────┤Panel│   3   │┌─────┐
       ┌─────┤Panel│  2  │       ││Panel├─────┐
       │Panel│  2  │     │ 2.5"  ││  4  │Panel│
       │  1  │     │ 2"  │offset ││     │  5  │
       │     │ 2"  │offset       ││ 2"  │     │
       │flush│offset│            ││offset│flush│
═══════╧═════╧═════╧═════════════╧╧═════╧═════╧═══════ WALL
       0"    2"    2"    2.5"    2"    2"    0"
```

**Mounting Offsets from Wall:**

| Panel | Position | Offset | Implementation |
|-------|----------|--------|----------------|
| 1 | Left | 0" | Mount cleat directly on wall |
| 2 | | 2" | Add 2" spacer block behind cleat |
| 3 | Center | 2.5" | Add 2.5" spacer block behind cleat |
| 4 | | 2" | Add 2" spacer block behind cleat |
| 5 | Right | 0" | Mount cleat directly on wall |

**Spacer blocks:** Cut from scrap 2× lumber or stack plywood

---

## Quality Checklist

### During Assembly
- [ ] Profiles are mirror images (stepped edges face each other)
- [ ] Back panel is flat (no warping)
- [ ] All face planks are same length (48")
- [ ] Face planks align with correct step heights
- [ ] No gaps between face planks and profiles

### After Finishing
- [ ] All surfaces sealed with poly (including edges)
- [ ] No rough spots or splinters
- [ ] Panel is rigid - no flex when pressed

### After Mounting
- [ ] Panels are level
- [ ] Profiled modulation offsets are correct
- [ ] Array is centered on listening position
- [ ] Secure mounting - no wobble

---

## Rigidity Test

After building, perform the "knock test":

1. Knock on each face plank with your knuckle
2. Listen for the sound:
   - **Solid "tock"** = Good - rigid, will reflect sound ✓
   - **Hollow "boom"** = Too flexible - add center rib
   - **Rattle** = Loose joint - re-glue

With 1/2" plywood at these dimensions, you should get solid "tock" on all surfaces.

---

## Placement Summary

```
REAR WALL ELEVATION:

    ┌─────────────────────────────────────────────────────────┐
    │                                                         │
    │                        CEILING                          │
    │                                                         │
    ├─────────────────────────────────────────────────────────┤ 96" (8')
    │                                                         │
    │         ┌─────────────────────────────────┐             │
    │         │                                 │             │
    │         │      5-PANEL DIFFUSER ARRAY     │             │ 
    │         │         87.5" × 48"             │             │
    │         │                                 │             │
    │         │    (centered on room width)     │             │
    │         │                                 │             │
    │         └─────────────────────────────────┘             │
    │                                                         │
    ├─────────────────────────────────────────────────────────┤ 60" (5')
    │                                                         │
    │    ┌───────────────────────────────────────────────┐    │
    │    │                                               │    │
    │    │         BACKREST ABSORPTION PANEL             │    │
    │    │            (existing - Roxul filled)          │    │
    │    │                 144" × 36"                    │    │
    │    │                                               │    │
    │    └───────────────────────────────────────────────┘    │
    │                                                         │
    ├─────────────────────────────────────────────────────────┤ 24" (riser deck)
    │                      RISER                              │
    └─────────────────────────────────────────────────────────┘ 0" (floor)
    
    ←────────────────────── 16' (192") ──────────────────────→
```

**Key Dimensions:**
- Diffuser array bottom edge: 60" from floor (top of backrest)
- Diffuser array top edge: 108" from floor (48" panel height)
- Horizontal centering: (192" - 87.5") ÷ 2 = 52.25" from each side wall
- Diffuser depth from wall: 0" to 2.5" (with profiled modulation)

---

## Document References

- Diffusion_Panel_Design_Guide.md - Theory and placement strategy
- QRD_N7_Build_Plans.md - Alternative QRD design (more complex)
- Leanfuser_Build_Plans.md - Original solid-stack method
- Home_Theater_System_Complete_Design_Rev5_2.md - Main system design

---

*Based on Tim Perry's Leanfuser design (arqen.com) - Creative Commons BY-NC-SA 3.0*
*Hollow profile construction method adapted for simplified DIY build*
