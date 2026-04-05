# Viewing Angle & Screen Geometry Calculator

## When to Use
Activate this skill when the user asks about:
- Viewing angles from seating positions
- Screen size fitting on a wall
- MLP (main listening position) distance calculations
- THX / IMAX / SMPTE viewing angle compliance
- Seating geometry, row distances, leg room
- Room ratios (H:W:D)
- Speaker angles from MLP
- Screen width/height from diagonal + aspect ratio
- "Will a ___ screen fit on a ___ wall?"

## Calculator Location
`tools/viewing_calc.py` — run from project root.

## How to Use

**Always use the calculator instead of doing manual trig.** Run it via CLI and report the output.

### Basic usage
```bash
python tools/viewing_calc.py --screen 170 --aspect 2.35:1 --wall 16 --rows 13,18 --room 16x26x10
```

### All flags
| Flag | Required | Default | Description |
|------|----------|---------|-------------|
| `--screen` | Yes | — | Screen diagonal in inches |
| `--aspect` | No | `2.35:1` | Aspect ratio (e.g., `2.35:1`, `16:9`, `4:3`) |
| `--wall` | No | — | Wall width in feet (enables clearance check) |
| `--rows` | Yes | — | Comma-separated couch-front distances from screen in feet |
| `--couch-depth` | No | `3.0` | Couch depth in feet |
| `--mlp-pct` | No | `75` | MLP position as % from back of couch (75 = head is 25% behind front edge) |
| `--room` | No | — | Room dims `WxDxH` in feet (enables ratio calc) |
| `--speaker-angles` | No | — | Comma-separated speaker angles in degrees |
| `--min-clearance` | No | `6.0` | Minimum acceptable wall clearance per side in inches |
| `--json` | No | — | Output JSON instead of formatted text |

### Examples
```bash
# Main theater room
python tools/viewing_calc.py --screen 170 --aspect 2.35:1 --wall 16 --rows 13,18 --couch-depth 3 --room 16x26x10

# Garage conversion
python tools/viewing_calc.py --screen 120 --aspect 16:9 --wall 17 --rows 9.6,14.75 --couch-depth 3 --mlp-pct 75

# Quick single-row check
python tools/viewing_calc.py --screen 170 --aspect 2.35:1 --rows 12

# JSON output for programmatic use
python tools/viewing_calc.py --screen 170 --aspect 2.35:1 --rows 13,18 --json
```

## Key Formulas (reference — use the calculator, don't compute manually)

- **Screen width:** `diagonal / sqrt(ratio^2 + 1) * ratio`
- **Viewing angle:** `2 * arctan(screen_width / 2 / distance)`
- **MLP position:** Head is at `couch_front_distance + couch_depth * (1 - mlp_pct/100)`. With 75% from back, the head sits 25% of couch depth behind the front edge.
- **Wall clearance:** `(wall_width - screen_width) / 2`

## Standards Reference
| Standard | Angle | Notes |
|----------|-------|-------|
| SMPTE EG-18 minimum | 30 deg | Minimum for acceptable cinema experience |
| THX Reference | 36 deg | THX certified theater minimum |
| SMPTE EG-18 maximum | 40 deg | Upper comfort limit per SMPTE |
| IMAX sweet spot | 58-70 deg | Immersive IMAX-class experience |

## Programmatic Import
The calculator can also be imported as a Python module:
```python
from tools.viewing_calc import calculate, screen_dimensions, viewing_angle
result = calculate(screen_diag=170, aspect="2.35:1", wall_width_ft=16, row_distances_ft=[13, 18])
```
