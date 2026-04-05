# Nearfield Tactile Cabinet Specifications
## 8× UMII10-22 Back-of-Couch Subwoofer

**Document Version:** 1.0  
**Phase:** 1 - Dimensional Analysis (Complete)  
**Date:** December 2024

---

## Design Summary

| Parameter | Value | Notes |
|-----------|-------|-------|
| **Purpose** | Tactile bass behind couch | Furniture-grade appearance |
| **Drivers** | 8× Dayton UMII10-22 | 4 across × 2 high |
| **Configuration** | Sealed | Qtc ~1.0 per driver |
| **Baffle** | 2.5" recessed, 1.5" thick | Double-layer, driver protection |
| **Top Surface** | Functional | Supports drinks, remotes |

---

## External Dimensions

| Dimension | Value | Notes |
|-----------|-------|-------|
| **Width** | 48.0" | Spans behind standard couch |
| **Height** | 24.0" | Furniture-appropriate, sofa table height |
| **Depth** | 16.0" | Fits behind couch without protruding |

**Note:** Original specification was 48" × 18" × 14". Revised to:
- Increase height (18" → 24") for driver clearance (2 rows of 10.5" frames)
- Increase depth (14" → 16") for adequate internal volume

---

## Internal Dimensions

| Dimension | Value | Derivation |
|-----------|-------|------------|
| **Internal Width** | 46.5" | 48.0" - 2×0.75" panels |
| **Internal Height** | 22.5" | 24.0" - 2×0.75" panels |
| **Depth Behind Baffle** | 11.25" | 16.0" - 0.75" back - 4.0" recess/baffle |

---

## Volume Analysis

| Parameter | Value | Notes |
|-----------|-------|-------|
| **Gross Internal Volume** | 11,789 in³ | 46.5" × 22.5" × 11.25" |
| **Gross Volume (ft³)** | 6.82 ft³ | Before bracing/drivers |
| **Est. Net Volume** | ~6.1 ft³ | After ~10% displacement |
| **Target Volume** | 6.0 ft³ | 0.75 ft³ × 8 drivers |
| **Per Driver** | ~0.76 ft³ | Meets target ✓ |

**Volume Status:** ✓ SUFFICIENT (6.82 ft³ gross > 6.67 ft³ needed)

---

## Driver Specifications (UMII10-22)

### Physical Dimensions

| Parameter | Value | Source |
|-----------|-------|--------|
| **Model** | UMII10-22 | Dayton Audio Ultimax II |
| **Nominal Diameter** | 10" | - |
| **Frame Diameter** | 10.5" | Overall outside diameter |
| **Cutout Diameter** | 9.32" | Parts Express spec |
| **Bolt Circle Diameter** | 9.92" | Parts Express spec |
| **Mounting Holes** | 8 | Standard pattern |
| **Mounting Depth** | 5.98" | Frame to magnet back |
| **Total Depth** | 6.5" | Including terminals |
| **Weight** | 14.9 lbs | Per driver |

### Electrical (Voice Coils in Series)

| Parameter | Value |
|-----------|-------|
| **Impedance** | 4Ω (2+2Ω series) |
| **Power Handling (RMS)** | 600W |
| **Power Handling (Peak)** | 1200W |
| **Sensitivity** | 87.3 dB @ 2.83V/1m |

### Thiele-Small Parameters

| Parameter | Value |
|-----------|-------|
| **Fs** | 39 Hz |
| **Qts** | 0.57 |
| **Qes** | 0.73 |
| **Qms** | 2.67 |
| **Vas** | 0.75 ft³ |
| **Xmax** | ±20 mm |
| **BL** | 13.4 T·m |
| **Mms** | 134 g |
| **Sd** | 345 cm² |

---

## Driver Array Layout

### Configuration: 4 × 2 (4 across, 2 high)

```
    ┌────────────────────────────────────────────────────┐
    │                                                    │
    │    ●           ●           ●           ●          │  Row 2
    │   D5          D6          D7          D8          │
    │                                                    │
    │    ●           ●           ●           ●          │  Row 1
    │   D1          D2          D3          D4          │
    │                                                    │
    └────────────────────────────────────────────────────┘
         ↑           ↑           ↑           ↑
       5.81"      17.44"      29.06"      40.69"
       
    (Dimensions are X positions from left edge of baffle)
```

### Driver Center Positions

| Driver | Row | Col | X (from left) | Y (from bottom) |
|--------|-----|-----|---------------|-----------------|
| D1 | 1 | 1 | 5.813" | 5.625" |
| D2 | 1 | 2 | 17.438" | 5.625" |
| D3 | 1 | 3 | 29.063" | 5.625" |
| D4 | 1 | 4 | 40.688" | 5.625" |
| D5 | 2 | 1 | 5.813" | 16.875" |
| D6 | 2 | 2 | 17.438" | 16.875" |
| D7 | 2 | 3 | 29.063" | 16.875" |
| D8 | 2 | 4 | 40.688" | 16.875" |

### Spacing & Clearances

| Parameter | Value | Status |
|-----------|-------|--------|
| **Horizontal Center Spacing** | 11.625" | - |
| **Vertical Center Spacing** | 11.25" | - |
| **Horizontal Edge Clearance** | 0.563" | ⚠️ Tight but acceptable |
| **Vertical Edge Clearance** | 0.375" | ⚠️ Tight but acceptable |
| **Gap Between H Frames** | 1.125" | ✓ Good |
| **Gap Between V Frames** | 0.75" | ✓ Acceptable |

---

## Baffle Design

### Configuration

| Parameter | Value | Notes |
|-----------|-------|-------|
| **Thickness** | 1.5" | Two 0.75" layers laminated |
| **Recess Depth** | 2.5" | From cabinet front face |
| **Cleat Position** | 4.0" | From front (recess + baffle) |
| **Baffle Width** | 46.5" | Fits between side panels |
| **Baffle Height** | 22.5" | Fits between top/bottom |

### Recess Analysis

| Parameter | UMII18-22 (reference) | UMII10-22 (this design) |
|-----------|----------------------|-------------------------|
| **Driver Depth** | 10.2" | 6.5" |
| **Recess Used** | 3.0" | 2.5" |
| **Ratio** | 0.29 | 0.38 |

**Rationale for 2.5" Recess:**
- Driver is 6.5" deep vs 10.2" for 18" driver (64% of depth)
- 2.5" provides proportionally similar protection
- Allows for optional fabric grille
- Furniture context warrants protection from accidental contact
- Leaves 0.5" for grille frame if desired

### Cutout Layout (per driver)

| Feature | Diameter | Notes |
|---------|----------|-------|
| Main Cutout | 9.32" | Router with 4.66" radius jig |
| Bolt Holes | ~0.28" | For #8 or M6 screws |
| Bolt Circle | 9.92" | 8 holes evenly spaced |

---

## Panel Dimensions (Cut List Preview)

### Major Panels

| Panel | Qty | Width | Height | Thickness | Notes |
|-------|-----|-------|--------|-----------|-------|
| Back | 1 | 48.0" | 24.0" | 0.75" | Full external size |
| Side | 2 | 15.25" | 24.0" | 0.75" | Depth minus back panel |
| Top | 1 | 46.5" | 15.25" | 0.75" | Between sides, furniture grade |
| Bottom | 1 | 46.5" | 15.25" | 0.75" | Between sides |
| Baffle Layer 1 | 1 | 46.5" | 22.5" | 0.75" | 8× driver cutouts |
| Baffle Layer 2 | 1 | 46.5" | 22.5" | 0.75" | 8× driver cutouts |

### Cleats

| Cleat | Qty | Length | Width | Thickness |
|-------|-----|--------|-------|-----------|
| Side Cleats | 2 | 22.5" | 0.75" | 0.75" |
| Top Cleat | 1 | 45.0" | 0.75" | 0.75" |
| Bottom Cleat | 1 | 45.0" | 0.75" | 0.75" |

### Bracing (Preliminary)

| Brace | Qty | Dimensions | Notes |
|-------|-----|------------|-------|
| Window Braces | 3 | 21.0" × 3.0" × 0.75" | Between driver columns |
| Cross Brace | 1 | 45.0" × 3.0" × 0.75" | Horizontal, between rows |

---

## Depth Clearance Analysis

```
Front Face
    │
    ├─ 2.5" ─┤ Recess (open)
    │        │
    │        ├─ 1.5" ─┤ Baffle (double layer)
    │        │        │
    │        │        ├───── 11.25" ─────┤ Internal depth
    │        │        │                   │
    │        │        │     [DRIVERS]     │ 6.5" driver depth
    │        │        │                   │
    │        │        │    [CLEARANCE]    │ 4.75" remaining
    │        │        │                   │
    └────────┴────────┴───────────────────┤ Back Panel (0.75")
                                          │
                                    16.0" Total Depth
```

**Driver Clearance:** 11.25" - 6.5" = 4.75" behind drivers ✓ (Excellent)

---

## Weight Estimate

| Component | Weight |
|-----------|--------|
| 8× UMII10-22 drivers | 119.2 lbs |
| Cabinet (plywood, est.) | ~50 lbs |
| Bracing & hardware | ~10 lbs |
| **Total Estimated** | **~180 lbs** |

**Note:** Heavy! Consider:
- Floor protection (felt pads)
- Moving assistance (handles or dolly)
- Structural support if elevated

---

## Comparison to Original Specification

| Parameter | Original | Revised | Change |
|-----------|----------|---------|--------|
| Width | 48" | 48" | No change |
| Height | 18" | 24" | +6" (driver clearance) |
| Depth | 14" | 16" | +2" (volume) |
| Gross Volume | ~5.0 ft³ | 6.82 ft³ | +1.82 ft³ |
| Net Volume | ~4.5 ft³ | ~6.1 ft³ | +1.6 ft³ |

**Why Changes Were Needed:**
1. **Height:** 2 rows of 10.5" drivers require >21" internal height
2. **Depth:** Original depth with recess left insufficient volume
3. **Result:** Proper clearances and target volume achieved

---

## Open Items for Future Phases

### Phase 2: Cut List
- [ ] Optimize sheet layout for minimal waste
- [ ] Determine edge banding for top panel
- [ ] Finalize bracing dimensions

### Phase 3: Baffle Layout
- [ ] Create driver hole drilling template
- [ ] Specify router jig dimensions
- [ ] Verify bolt hole positions

### Phase 4: Bracing
- [ ] Finalize window brace cutout dimensions
- [ ] Design wire routing paths
- [ ] Add corner reinforcement if needed

### Phase 7: Furniture Finish
- [ ] Select top surface finish
- [ ] Design optional grille frame
- [ ] Determine edge treatment

---

## Files Created (Phase 1)

| File | Purpose |
|------|---------|
| `intermediates/config.py` | Shared configuration values |
| `specifications.md` | This document |

---

## Validation Summary

| Check | Status | Notes |
|-------|--------|-------|
| Volume ≥ 6.0 ft³ net | ✓ Pass | 6.82 ft³ gross, ~6.1 ft³ net |
| Driver clearance (H) | ✓ Pass | 0.56" edge, 1.13" between |
| Driver clearance (V) | ⚠️ Tight | 0.38" edge, 0.75" between |
| Depth for drivers | ✓ Pass | 4.75" clearance behind |
| Recess proportional | ✓ Pass | 2.5" appropriate for 6.5" driver |
| All dims in config.py | ✓ Pass | Complete |

**Phase 1 Status: ✅ COMPLETE**

---

*Next Phase: Panel Design & Cut List*
