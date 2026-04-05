# Context File for Continuing Front-Firing Subwoofer Diagram Work

## Current State (Updated)

All individual Python diagram scripts have been created in the `intermediates/` folder, following the "one Python file per diagram" rule.

## Corrected Design Specifications

### Key Design Values:
1. **Baffle**: 2 layers × 0.75" = **1.5" total** (NOT 4 layers / 3")
2. **Cleat position**: **4.5"** from front edge (NOT 3.75")
3. **Recess**: 3" deep at FRONT of cabinet
4. **Material**: **2 sheets** of plywood (NOT 3)
5. **No "inset frame"** - just a laminated baffle mounted on cleats

### Cabinet Dimensions:
- External: 44.0" H × 23.5" W × 18.5" D
- Baffle: 22.0" × 42.5" (×2 layers, laminated to 1.5")
- Back: 23.5" × 44.0"
- Sides: 17.75" × 44.0" (×2)
- Top/Bottom: 22.0" × 17.75"
- Cleats: 0.75" × 0.75" strips

### Driver Specs:
- 2× Dayton UMII18-22
- Cutout: 16.875" diameter
- Bolt circle: 17.75" diameter, 8 holes, 5/16" dia
- Top driver center: 31.0" from baffle bottom
- Bottom driver center: 10.0" from baffle bottom

## Files Structure

### Documentation (C:\Claude\HT\front_firing_sub_8cf\):
- `specifications.md` - v2.0, updated for 1.5" baffle
- `cut_list.md` - v2.2, shows 2 baffle layers, 2 sheets
- `build_guide.md` - v2.2, correct lamination/cleat steps
- `bracing_details.md` - Bracing component specifications

### Python Scripts (intermediates/):
- `config.py` - Shared configuration values
- `generate_all.py` - Master script to run all generators
- `ff_01_cut_list.py` through `ff_14_bracing_details.py` - Individual diagram scripts

### Diagram Outputs (diagrams/):
- 15 PNG files (ff_01 through ff_14, plus ff_10_step_baffle_mount)

## Individual Python Files Created

| # | Script | Output PNG | Description |
|---|--------|------------|-------------|
| 01 | ff_01_cut_list.py | ff_01_cut_list.png | 2-sheet plywood layout |
| 02 | ff_02_panel_dimensions.py | ff_02_panel_dimensions.png | Panel dimensions with 2-layer baffle |
| 03 | ff_03_cross_section_front.py | ff_03_cross_section_front.png | Front view cross-section |
| 04 | ff_04_cross_section_side.py | ff_04_cross_section_side.png | Side view showing 1.5" baffle, 3" recess |
| 05 | ff_05_cross_section_top.py | ff_05_cross_section_top.png | Top view bracing layout |
| 06 | ff_06_3d_view.py | ff_06_3d_view.png | 3D isometric view |
| 07 | ff_07_ortho_views.py | ff_07_ortho_views.png | All orthographic views |
| 08 | ff_08_step_panels.py | ff_08_step_panels.png | Step 1: Cut panels (2 sheets) |
| 09 | ff_09_step_driver_holes.py | ff_09_step_driver_holes.png | Step 2: Driver holes |
| 10 | ff_10_step_laminate.py | ff_10_step_laminate.png | Step 3: Laminate 2 layers |
| 10b | ff_10b_step_baffle_mount.py | ff_10_step_baffle_mount.png | Cleat/baffle mount detail |
| 11 | ff_11_step_assemble.py | ff_11_step_assemble.png | Steps 4-6: Assemble frame |
| 12 | ff_12_step_baffle.py | ff_12_step_baffle.png | Step 7: Attach baffle |
| 13 | ff_13_step_drivers.py | ff_13_step_drivers.png | Step 8: Mount drivers |
| 14 | ff_14_bracing_details.py | ff_14_bracing_details.png | **NEW** - Bracing component shapes |

## Configuration Values (config.py)

```python
# External dimensions (inches)
EXT_H = 44.0
EXT_W = 23.5
EXT_D = 18.5

# Panel thickness
PANEL = 0.75

# Baffle (2 layers laminated)
BAFFLE_THICK = 1.5  # 2 × 0.75"
BAFFLE_W = 22.0
BAFFLE_H = 42.5

# Recess depth (open to room)
RECESS_DEPTH = 3.0

# Cleat position from front edge
CLEAT_POSITION = 4.5  # Results in 3" recess (4.5 - 1.5 = 3)

# Driver specs
DRIVER_CUTOUT = 16.875
DRIVER_BOLT_CIRCLE = 17.75
TOP_DRIVER_CENTER = 31.0    # from baffle bottom
BOTTOM_DRIVER_CENTER = 10.0  # from baffle bottom

# Cross-brace positions
CROSS_BRACE_1 = 14.0  # from bottom
CROSS_BRACE_2 = 28.0  # from bottom

# Bracing dimensions
CROSS_BRACE_WIDTH_W = 20.5     # Width direction
CROSS_BRACE_DEPTH_W = 10.25    # Depth direction
CROSS_BRACE_HEIGHT = 4.0
RIB_BRACE_WIDTH = 1.5
RIB_BRACE_LENGTH = 30.0
CORNER_BRACE_WIDTH = 3.0
CORNER_BRACE_LENGTH = 42.5

# Material
SHEETS_REQUIRED = 2
```

## Usage

### To regenerate all diagrams:
```bash
cd C:\Claude\HT\front_firing_sub_8cf\intermediates
python generate_all.py
```

### To regenerate a specific diagram:
```bash
python ff_01_cut_list.py
python ff_14_bracing_details.py
```

### To regenerate multiple specific diagrams:
```bash
python generate_all.py ff_01 ff_04 ff_14
```

## Completed Tasks

- [x] Created shared configuration module (config.py)
- [x] Created 15 individual Python diagram scripts
- [x] Created master script (generate_all.py)
- [x] Added new bracing details diagram (ff_14)
- [x] Updated README.md with documentation
- [x] All scripts use corrected 2-layer baffle design

## Potential Future Tasks

1. **Run the scripts** to regenerate all PNG files
2. **Clean up old files** - Remove deprecated `cut_list_diagram.py` and `generate_all_diagrams.py`
3. **Test individual regeneration** - Verify each script works independently
4. **Package for distribution** - Create zip of diagrams folder
