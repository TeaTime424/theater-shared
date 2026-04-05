---
name: room-layout
description: "Generate top-down room layout diagrams for the home theater using matplotlib. Renders walls, screen, LCR/surround/Atmos speakers, subwoofer cabinets, nearfield subs, riser, seating, equipment closet, door, and power panel. Calculates viewing angles and leg room. Use when the user wants to visualize or update the theater floor plan."
---

# Room Layout Diagram Generation

## Overview

Renders a top-down matplotlib diagram of the theater room layout. The system is config-driven: a JSON file defines all room parameters, and the render script reads component dimensions from POR config files (Titan-815LX, Volt-10) at runtime.

## Files

| File | Purpose |
|------|---------|
| `screenshots/render_topdown.py` | Main render script (config-driven) |
| `screenshots/layout_config.json` | Default layout parameters |
| `screenshots/option_d_topdown.png` | Output diagram |
| `POR/titan_815lx/intermediates/config.py` | Titan-815LX dimensions (auto-imported) |
| `POR/volt10/intermediates/config.py` | Volt-10 dimensions (auto-imported) |

## How to Generate a Diagram

### Method 1: Default config (most common)

```bash
cd D:/Projects/Claude/theater
python screenshots/render_topdown.py
```

### Method 2: CLI overrides for quick parameter changes

```bash
python screenshots/render_topdown.py --room-width 16 --room-depth 26
python screenshots/render_topdown.py --screen-size 150 --screen-aspect "2.35:1"
python screenshots/render_topdown.py --title "Alt Layout" --output screenshots/alt_layout.png
```

### Method 3: Custom config file for a different layout

1. Copy `screenshots/layout_config.json` to a new file
2. Edit the parameters
3. Run: `python screenshots/render_topdown.py screenshots/my_config.json`

### Method 4: Programmatic (from Python)

```python
from screenshots.render_topdown import load_config, render
import matplotlib.pyplot as plt

cfg = load_config()
cfg['room']['width'] = 16.0
cfg['room']['depth'] = 26.0
fig, ax = render(cfg)
plt.savefig('screenshots/custom_layout.png', dpi=150, bbox_inches='tight')
plt.close()
```

## Config File Structure

The JSON config (`layout_config.json`) has these top-level sections:

### Room

```json
"room": {
    "width": 17.0,        // feet (E-W)
    "depth": 23.0,        // feet (N-S)
    "height": 10.0,       // feet (for reference only, not drawn)
    "north_label": "NORTH WALL (Screen Wall)",
    "south_label": "SOUTH WALL (Rear)",
    "west_label": "WEST WALL\n(Partition\nto Gym)",
    "east_label": "EAST WALL\n(Exterior)"
}
```

### Screen

```json
"screen": {
    "width_inches": 170,          // diagonal
    "aspect_ratio": [16, 9],      // or [2.35, 1] for scope
    "type": "AT",                 // acoustically transparent
    "offset_from_north_inches": 26 // distance from north wall to screen surface
}
```

### LCR Speakers (Titan-815LX)

Dimensions auto-imported from `POR/titan_815lx/intermediates/config.py` (EXT_W=19.5", EXT_D=21.5"). Config values are fallback only.

```json
"lcr": {
    "model": "Titan-815LX",
    "width_inches": 19.5,         // overridden by POR config
    "depth_inches": 21.5,         // overridden by POR config
    "lr_spread_ft": 4.9,          // L/R offset from center
    "setback_from_north_ft": 0.1  // gap from north wall
}
```

### Surrounds (Volt-10)

Dimensions auto-imported from `POR/volt10/intermediates/config.py` (CABINET_WIDTH=14", STANDARD_DEPTH=9.25"). All Volt-10 are 14"x14" face with 9.25" depth from wall.

```json
"surrounds": {
    "model": "Volt-10",
    "width_inches": 14.0,         // overridden by POR config
    "depth_inches": 9.25,         // overridden by POR config
    "front_wides": { "enabled": true },
    "side_surrounds": { "enabled": true },
    "surround_backs": { "enabled": true, "x_offset_ft": 3.0 }
}
```

### Atmos Heights (Ceiling-Mounted Volt-10)

Drawn with dashed outlines to indicate ceiling mount.

```json
"atmos": {
    "model": "Volt-10",
    "size_inches": 14.0,    // overridden by POR config
    "spread_ft": 4.0,       // L/R offset from center
    "channels": {
        "top_front": { "enabled": true, "y_mode": "front_wides" },
        "top_rear": { "enabled": true, "y_mode": "row2_mlp" },
        "top_middle": { "enabled": false }
    }
}
```

### Corner Subs

```json
"corner_subs": {
    "width_inches": 24,
    "depth_inches": 24,
    "drivers_per_cabinet": 2,
    "driver_size_inches": 18,
    "corners": ["NW", "NE", "SW", "SE"]
}
```

### Nearfield Subs

```json
"nearfield_subs": {
    "enabled": true,
    "depth_inches": 12.5,
    "driver_count": 4,
    "driver_size_inches": 18,
    "position": "riser_front",
    "facing": "forward"
}
```

### Seating

`mlp_position` = 0.75 means the MLP (main listening position) ear location is 75% back from the front of the couch (25% from the back edge).

```json
"seating": {
    "couch_width_ft": 8.0,
    "couch_depth_ft": 3.0,
    "mlp_position": 0.75,
    "row1": { "enabled": true },
    "row2": { "enabled": true, "setback_from_riser_back_ft": 1.0 }
}
```

### Riser

```json
"riser": {
    "enabled": true,
    "front_from_north_ft": 15.5,
    "depth_ft": 5.5,
    "inset_from_walls_ft": 1.0
}
```

### Infrastructure

```json
"equipment_closet": { "enabled": true, "size_ft": 4.0, "position": "west_outside_NW" },
"door": { "enabled": true, "wall": "east", "width_inches": 36, "from_ne_corner_inches": 62 },
"power_panel": { "enabled": true, "wall": "east", "from_ne_corner_inches": 50 }
```

### Annotations

```json
"annotations": {
    "viewing_angles": true,   // sight lines + angle degrees from each row MLP
    "leg_room": true,         // Row 2 leg room in inches
    "room_dimensions": true,  // overall width/depth arrows
    "stage_depth": true       // stage depth callout
}
```

## Common Tasks

### Change room dimensions

Edit `room.width` and `room.depth` in the config, or use CLI:
```bash
python screenshots/render_topdown.py --room-width 16 --room-depth 26
```

### Switch screen aspect ratio

Change `screen.aspect_ratio` from `[16, 9]` to `[2.35, 1]` for a scope screen.

### Move seating

Adjust `riser.front_from_north_ft` to shift the riser (and Row 2 with it). Row 1 is positioned automatically in front of the nearfield subs, which sit at the riser front edge.

### Add/remove sub corners

Edit `corner_subs.corners` array: `["NW", "NE"]` for front-only, `["NW", "NE", "SW", "SE"]` for all four corners.

### Disable a component

Set `"enabled": false` on any section (nearfield_subs, equipment_closet, door, power_panel, stage, riser, individual surround groups, individual Atmos channels).

## Component Dimensions Reference (from POR configs)

| Component | Width | Height | Depth | Source |
|-----------|-------|--------|-------|--------|
| Titan-815LX | 19.5" | 42.5" | 21.5" | `POR/titan_815lx/intermediates/config.py` |
| Volt-10 | 14.0" | 14.0" | 9.25" | `POR/volt10/intermediates/config.py` |
| Corner sub cabinet | 24" | 72" | 24" | Config JSON |
| Nearfield sub | 96" (8') | -- | 12.5" | Config JSON (width matches couch) |

## Important Notes

- The render script auto-imports dimensions from POR config files at runtime. If those files exist, they override the JSON fallback values. This ensures the diagram stays in sync with any POR dimension changes.
- North = top of diagram (screen wall). South = bottom (rear wall). This matches the physical room orientation.
- Viewing angles are calculated as `2 * atan(half_screen_width / distance_to_screen)` from each row's MLP position.
- Output defaults to `screenshots/option_d_topdown.png` at 150 DPI.
- The `--output` flag or `output_file` config key can redirect to any path (relative paths resolve from project root).
