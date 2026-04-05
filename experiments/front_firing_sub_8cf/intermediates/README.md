# Intermediates - Python Diagram Generators

This folder contains individual Python scripts for generating each build diagram.

## Design

**One Python file per diagram** - Each diagram has its own dedicated script for:
- Easier maintenance and debugging
- Independent regeneration of single diagrams
- Avoiding context/length issues in large combined files

All scripts share a common configuration module (`config.py`) to ensure consistency.

## Files

### Configuration
- `config.py` - Shared configuration values for all diagrams

### Diagram Scripts (ff_01 through ff_14)

| Script | Output | Description |
|--------|--------|-------------|
| `ff_01_cut_list.py` | ff_01_cut_list.png | 2-sheet plywood layout |
| `ff_02_panel_dimensions.py` | ff_02_panel_dimensions.png | Individual panel dimensions |
| `ff_03_cross_section_front.py` | ff_03_cross_section_front.png | Front cross-section |
| `ff_04_cross_section_side.py` | ff_04_cross_section_side.png | Side cross-section (shows recess) |
| `ff_05_cross_section_top.py` | ff_05_cross_section_top.png | Top cross-section (bracing layout) |
| `ff_06_3d_view.py` | ff_06_3d_view.png | Isometric 3D view |
| `ff_07_ortho_views.py` | ff_07_ortho_views.png | All orthographic views |
| `ff_08_step_panels.py` | ff_08_step_panels.png | Step 1: Cut panels |
| `ff_09_step_driver_holes.py` | ff_09_step_driver_holes.png | Step 2: Driver holes |
| `ff_10_step_laminate.py` | ff_10_step_laminate.png | Step 3: Laminate baffle |
| `ff_10b_step_baffle_mount.py` | ff_10_step_baffle_mount.png | Baffle mount detail |
| `ff_11_step_assemble.py` | ff_11_step_assemble.png | Steps 4-6: Assemble frame |
| `ff_12_step_baffle.py` | ff_12_step_baffle.png | Step 7: Attach baffle |
| `ff_13_step_drivers.py` | ff_13_step_drivers.png | Step 8: Mount drivers |
| `ff_14_bracing_details.py` | ff_14_bracing_details.png | Bracing component details |

### Master Script
- `generate_all.py` - Runs all diagram generators in sequence

## Usage

### Generate All Diagrams
```bash
cd intermediates
python generate_all.py
```

### Generate Specific Diagrams
```bash
python generate_all.py ff_01           # Single diagram
python generate_all.py ff_01 ff_02     # Multiple diagrams
python generate_all.py 14              # Partial match (runs ff_14)
```

### Generate Individual Diagram
```bash
python ff_01_cut_list.py
python ff_14_bracing_details.py
```

## Output Location

All PNG files are saved to: `../diagrams/`

## Key Design Values (from config.py)

| Parameter | Value | Notes |
|-----------|-------|-------|
| External Size | 23.5" × 18.5" × 44.0" | W × D × H |
| Baffle Thickness | 1.5" | 2 layers laminated |
| Recess Depth | 3.0" | Open space at front |
| Cleat Position | 4.5" | From front edge |
| Driver Centers | 31.0" / 10.0" | From baffle bottom |
| Cross-Braces | 14" / 28" | From cabinet bottom |

## Corrected Design (v2.0+)

This version implements the **2-layer laminated baffle on cleats** design:
- ✅ 2 baffle layers (NOT 4-layer inset frame)
- ✅ 1.5" total baffle thickness
- ✅ Cleats at 4.5" from front edge
- ✅ 3" recess at cabinet FRONT
- ✅ 2 sheets of plywood (NOT 3)
