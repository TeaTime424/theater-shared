# Nearfield Tactile Cabinet Design Plan
## 8× UMII10-22 Back-of-Couch Subwoofer Cabinet

**Created:** December 2024  
**Status:** PLAN ONLY - Not yet executed  
**Reference:** front_firing_sub_8cf folder structure

---

## Project Overview

Design a furniture-grade cabinet for 8× UMII10-22 drivers that:
1. Sits behind the couch as a functional shelf/table
2. Provides tactile bass impact at 12-18" from listener
3. Supports drinks, remotes, etc. on top surface
4. Has inset baffle with protective cover capability
5. Achieves required internal volume (~6.0 ft³ net)

---

## Key Driver Specifications (UMII10-22)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Cutout Diameter | 9.125" (232 mm) | Hole size in baffle |
| Overall Diameter | 10.5" (267 mm) | Frame size |
| Mounting Depth | 5.98" (152 mm) | **Critical for recess** |
| Bolt Circle | ~10.0" (est.) | Verify from spec sheet |
| Bolt Holes | 8 | Standard pattern |
| Weight | 14.9 lbs each | 119 lbs total for 8 |

---

## Recess Depth Analysis

### Comparison: UMII18-22 vs UMII10-22

| Parameter | UMII18-22 | UMII10-22 | Ratio |
|-----------|-----------|-----------|-------|
| Mounting Depth | 10.2" | 5.98" | 0.59× |
| Recess Used | 3.0" | **TBD** | - |
| Xmax | 17.5mm | 20mm | 1.14× |

### Recess Options for UMII10-22

| Recess | Pros | Cons | Recommendation |
|--------|------|------|----------------|
| **1.5"** | Shallower cabinet, more volume | Minimal protection | ❌ Too shallow |
| **2.0"** | Good protection, reasonable depth | Moderate margin | ⚠️ Acceptable |
| **2.5"** | Excellent protection, covers possible | Slightly less volume | ✓ **RECOMMENDED** |
| **3.0"** | Maximum protection, matches 18" design | Unnecessary depth | ❌ Overkill |

### Recommended: 2.5" Recess Depth

**Rationale:**
- Driver depth 5.98" + Xmax 0.79" = 6.77" total excursion
- 2.5" recess provides protection from accidental contact
- Allows for fabric/grille cover if desired
- Furniture context (drinks) warrants extra margin
- Still less than 3" used for much deeper 18" driver

---

## Cabinet External Dimensions

### Current Specification (from UMII10-22_Nearfield_System_Specification.md)

| Dimension | Value | Purpose |
|-----------|-------|---------|
| Width | 48" | Spans couch width, 4 drivers across |
| Height | 18" | Low profile, furniture-like |
| Depth | 14" | Fits behind standard couch |

### Volume Verification

```
Gross External: 48" × 18" × 14" = 12,096 in³ = 6.99 ft³

Subtract panels (3/4" = 0.75"):
- Internal: 46.5" × 16.5" × 12.5" = 9,586 in³ = 5.55 ft³

Subtract bracing/drivers (estimated 10%):
- Net: ~5.0 ft³

Required: 6.0 ft³ net (0.75 ft³ × 8 drivers)
```

**⚠️ ISSUE: Current dimensions may be ~1.0 ft³ short**

### Revised Dimensions (Phase 1 deliverable)

Need to recalculate for:
- 2.5" recess depth
- 1.5" double-layer baffle
- Bracing requirements
- Target 6.0+ ft³ net volume

---

## Folder Structure

```
C:\Claude\HT\NearField\nearfield_cabinet\
├── CONTEXT_FOR_NEW_CHAT.md      # Session recovery document
├── specifications.md             # Final cabinet specifications
├── cut_list.md                   # Panel cutting guide
├── bracing_details.md            # Bracing design
├── build_guide.md                # Assembly instructions
├── cabinet_model.obj             # 3D model
├── cabinet_model.mtl             # Materials file
│
├── diagrams\                     # PNG output files
│   ├── nf_01_cut_list.png
│   ├── nf_02_panel_dimensions.png
│   ├── nf_03_cross_section_front.png
│   ├── nf_04_cross_section_side.png
│   ├── nf_05_cross_section_top.png
│   ├── nf_06_3d_view.png
│   ├── nf_07_ortho_views.png
│   ├── nf_08_step_panels.png
│   ├── nf_09_step_driver_holes.png
│   ├── nf_10_step_laminate.png
│   ├── nf_11_step_assemble.png
│   ├── nf_12_step_baffle.png
│   ├── nf_13_step_drivers.png
│   ├── nf_14_bracing_details.png
│   └── nf_15_furniture_finish.png
│   
└── intermediates\                # Python source files
    ├── config.py                 # Shared configuration
    ├── generate_all.py           # Master generation script
    ├── generate_cabinet_obj.py   # OBJ model generator
    ├── nf_01_cut_list.py
    ├── nf_02_panel_dimensions.py
    ├── ... (one .py per diagram)
    └── README.md
```

---

## Phased Implementation Plan

### Phase 1: Dimensional Analysis & Specifications
**Deliverables:**
- `specifications.md` - Final dimensions, verified volume
- `config.py` - All shared constants

**Tasks:**
1. Verify UMII10-22 bolt circle diameter (web search if needed)
2. Calculate internal volume with 2.5" recess
3. Adjust external dimensions if needed for 6.0+ ft³
4. Document driver layout (4×2 array spacing)
5. Define all panel dimensions
6. Create config.py with all constants

**Acceptance Criteria:**
- [ ] Net internal volume ≥ 6.0 ft³
- [ ] Driver spacing allows 10.5" frame clearance
- [ ] Furniture-appropriate proportions maintained
- [ ] All dimensions in config.py

---

### Phase 2: Panel Design & Cut List
**Deliverables:**
- `cut_list.md` - Complete cutting guide
- `nf_01_cut_list.py` + PNG
- `nf_02_panel_dimensions.py` + PNG

**Tasks:**
1. Design all panel pieces:
   - Top (furniture-grade, may need edge treatment)
   - Bottom
   - Sides (×2)
   - Back
   - Front baffle (double-layer, 8× driver cutouts)
2. Create cut list from 4×8 plywood sheets
3. Optimize sheet layout for minimum waste
4. Document edge treatments for top surface

**Acceptance Criteria:**
- [ ] All panels fit on standard 4×8 sheets
- [ ] Cut list includes quantity, dimensions, notes
- [ ] Diagrams show sheet layout
- [ ] Panel dimensions diagram complete

---

### Phase 3: Baffle & Driver Layout
**Deliverables:**
- `nf_03_cross_section_front.py` + PNG
- `nf_09_step_driver_holes.py` + PNG

**Tasks:**
1. Design 4×2 driver array layout
   - Horizontal spacing for 4 drivers
   - Vertical spacing for 2 rows
   - Edge margins
2. Calculate cutout positions (center coordinates)
3. Design double-layer baffle lamination
4. Define cleat positions for baffle support
5. Document driver mounting hardware

**Driver Array Considerations:**
```
┌────────────────────────────────────────────────┐
│    ○         ○         ○         ○            │  ← Row 1
│                                                │
│    ○         ○         ○         ○            │  ← Row 2
└────────────────────────────────────────────────┘
     ↑ ~11" spacing between centers (verify)
```

**Acceptance Criteria:**
- [ ] All 8 drivers fit with proper clearance
- [ ] Cutout centers documented
- [ ] Baffle dimensions match cabinet internal
- [ ] Cross-section shows recess depth clearly

---

### Phase 4: Cross-Sections & Internal Design
**Deliverables:**
- `nf_04_cross_section_side.py` + PNG
- `nf_05_cross_section_top.py` + PNG
- `bracing_details.md`
- `nf_14_bracing_details.py` + PNG

**Tasks:**
1. Design side cross-section showing:
   - Panel thicknesses
   - Baffle recess (2.5")
   - Cleat positions
   - Driver profile
2. Design top cross-section showing:
   - Driver arrangement
   - Internal bracing
   - Wire routing paths
3. Design bracing system:
   - Window braces between driver pairs
   - Cross-braces for panel stiffness
   - Corner reinforcement

**Bracing Strategy:**
```
Top View (with bracing):
┌────────────────────────────────────────────────┐
│  ┌──┐    ┌──┐    ┌──┐    ┌──┐    ┌──┐         │
│  │  │    │  │    │  │    │  │    │  │         │
│  └──┘    └──┘    └──┘    └──┘    └──┘         │
│     BRACE   BRACE   BRACE   BRACE             │
│  ┌──┐    ┌──┐    ┌──┐    ┌──┐    ┌──┐         │
│  │  │    │  │    │  │    │  │    │  │         │
│  └──┘    └──┘    └──┘    └──┘    └──┘         │
└────────────────────────────────────────────────┘
```

**Acceptance Criteria:**
- [ ] All cross-sections accurate to dimensions
- [ ] Bracing provides panel support without blocking volume
- [ ] Wire routing path identified
- [ ] Bracing cut list complete

---

### Phase 5: 3D Visualization
**Deliverables:**
- `generate_cabinet_obj.py`
- `cabinet_model.obj`
- `cabinet_model.mtl`
- `nf_06_3d_view.py` + PNG
- `nf_07_ortho_views.py` + PNG

**Tasks:**
1. Create OBJ generator following skill guidelines:
   - Ring-based construction for driver cutouts
   - Overlay approach (not cut-through)
   - Proper face winding
   - ×2.54 scaling for units
2. Define materials:
   - Cabinet exterior (furniture finish)
   - Baffle (textured black)
   - Driver cones
3. Generate orthographic views from matplotlib
4. Generate 3D perspective view

**OBJ Components:**
- Main cabinet box
- Recessed baffle area
- 8× driver representations (simplified cones)
- Optional: furniture top detail

**Acceptance Criteria:**
- [ ] OBJ opens without errors in standard viewers
- [ ] Face normals correct (no inside-out faces)
- [ ] Dimensions accurate when imported
- [ ] Materials render appropriately

---

### Phase 6: Assembly Guide & Build Steps
**Deliverables:**
- `build_guide.md`
- `nf_08_step_panels.py` + PNG
- `nf_10_step_laminate.py` + PNG
- `nf_11_step_assemble.py` + PNG
- `nf_12_step_baffle.py` + PNG
- `nf_13_step_drivers.py` + PNG

**Tasks:**
1. Document assembly sequence:
   - Panel preparation
   - Baffle lamination
   - Driver hole cutting (router/jigsaw)
   - Box assembly
   - Baffle installation
   - Driver mounting
   - Wiring
2. Create step-by-step diagrams
3. Document tools required
4. Note critical measurements/tolerances

**Acceptance Criteria:**
- [ ] Assembly sequence is logical
- [ ] Each step has corresponding diagram
- [ ] Tool list complete
- [ ] Critical tolerances identified

---

### Phase 7: Furniture Finish & Aesthetics
**Deliverables:**
- `nf_15_furniture_finish.py` + PNG
- Updates to `specifications.md`

**Tasks:**
1. Design furniture-grade top surface:
   - Edge banding options
   - Finish options (veneer, laminate, paint)
   - Protective coating for drinks
2. Design optional grille/cover:
   - Fabric frame for driver protection
   - Magnetic or friction-fit attachment
3. Document finish specifications
4. Consider couch-matching aesthetics

**Acceptance Criteria:**
- [ ] Top surface suitable for drinks/items
- [ ] Finish options documented
- [ ] Grille design (if included) functional
- [ ] Overall aesthetic furniture-appropriate

---

### Phase 8: Documentation & Context
**Deliverables:**
- `CONTEXT_FOR_NEW_CHAT.md`
- `intermediates/README.md`
- Final review of all documents

**Tasks:**
1. Create session recovery document with:
   - Project summary
   - File locations
   - Current status
   - Key decisions made
   - Open issues
2. Create README for intermediates folder
3. Cross-reference with main nearfield spec document
4. Update journal.txt with completion status

**Acceptance Criteria:**
- [ ] New session can resume without confusion
- [ ] All files documented
- [ ] Cross-references accurate
- [ ] Journal updated

---

## Progress Tracking

### Phase Completion Checklist

| Phase | Description | Status | Files Created |
|-------|-------------|--------|---------------|
| 1 | Dimensional Analysis | ✅ Complete | specifications.md, config.py |
| 2 | Panel Design & Cut List | ⬜ Not Started | cut_list.md, nf_01, nf_02 |
| 3 | Baffle & Driver Layout | ⬜ Not Started | nf_03, nf_09 |
| 4 | Cross-Sections & Bracing | ⬜ Not Started | bracing_details.md, nf_04, nf_05, nf_14 |
| 5 | 3D Visualization | ⬜ Not Started | cabinet_model.obj/mtl, nf_06, nf_07 |
| 6 | Assembly Guide | ⬜ Not Started | build_guide.md, nf_08, nf_10-13 |
| 7 | Furniture Finish | ⬜ Not Started | nf_15, spec updates |
| 8 | Documentation | ⬜ Not Started | CONTEXT, README |

### Status Key
- ⬜ Not Started
- 🟡 In Progress
- ✅ Complete
- ⚠️ Blocked/Issue

---

## Key Decisions Log

| Decision | Choice | Rationale | Date |
|----------|--------|-----------|------|
| Recess Depth | 2.5" | Balance of protection vs volume; furniture context | TBD |
| Baffle Thickness | 1.5" (2×0.75") | Matches 18" sub design, proper rigidity | TBD |
| Driver Array | 4×2 | Fits 48" width, balanced output | Existing |
| Panel Material | 3/4" plywood | Standard, matches other subs | Existing |

---

## Open Questions (Resolve in Phase 1)

1. **UMII10-22 Bolt Circle Diameter** - Need exact measurement for mounting holes
2. **Volume Shortfall** - Current dimensions may be ~1.0 ft³ short; options:
   - Increase depth from 14" to 15-16"
   - Increase height from 18" to 19-20"
   - Accept slightly lower volume per driver
3. **Top Surface Treatment** - Veneer vs laminate vs paint?
4. **Grille Design** - Fabric cover needed? Magnetic attachment?

---

## Reference Files

**Existing Documentation:**
- `C:\Claude\HT\NearField\UMII10-22_Nearfield_System_Specification.md`
- `C:\Claude\HT\NearField\Behringer_NX6000_Amplifier_Analysis.md`
- `C:\Claude\HT\NearField\nearfield_calculations.py`

**Template Reference:**
- `C:\Claude\HT\front_firing_sub_8cf\` (complete folder structure)
- `C:\Claude\HT\skills\obj-model-generation\SKILL.md`

**Project Documentation:**
- `C:\Claude\HT\journal.txt`
- `C:\Claude\HT\00_Master_Index.md`

---

## Session Recovery Instructions

When starting a new session to continue this project:

1. **Read this plan:** `C:\Claude\HT\NearField\CABINET_DESIGN_PLAN.md`
2. **Check progress:** Review "Phase Completion Checklist" above
3. **Read context:** `CONTEXT_FOR_NEW_CHAT.md` (when created)
4. **Continue from:** Next incomplete phase
5. **Update on completion:** Mark phases complete, update journal

---

*Plan Version: 1.0*  
*Created: December 2024*  
*Next Action: Execute Phase 1 - Dimensional Analysis*
