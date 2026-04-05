# Diagram Generation Scripts

These Python scripts generate all build diagrams for the 8 cu ft dual-opposed subwoofer.

## Scripts

| Script | Output | Description |
|--------|--------|-------------|
| `cut_list_diagram.py` | `8cf_01_cut_list.png` | Panel layout on plywood sheets |
| `panel_dimensions.py` | `8cf_02_panel_dimensions.png` | Individual panel dimensions |
| `cross_sections.py` | `8cf_03-05_*.png` | Front, top, and side cross-sections |
| `build_steps.py` | `8cf_06-15_*.png` | 10 build step diagrams |
| `external_views.py` | `8cf_16-17_*.png` | 3D view and orthographic views |

## Requirements

- Python 3.x
- matplotlib
- numpy

## Usage

```bash
cd intermediates
python3 cut_list_diagram.py
python3 panel_dimensions.py
python3 cross_sections.py
python3 build_steps.py
python3 external_views.py
```

## Output Location

Scripts output to `/mnt/user-data/outputs/` by default. Modify the `savefig()` path to change output location.

## Customization

To adjust dimensions, edit the constants at the top of each script:
- `EXT_W`, `EXT_D`, `EXT_H` - External cabinet dimensions
- `INT_W`, `INT_H` - Internal dimensions
- `PANEL` - Panel thickness
- `DRIVER_CUTOUT` - Driver hole diameter

---

*Intermediates README — 8 cu ft Dual-Opposed Subwoofer*
