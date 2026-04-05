# StarTech 4POSTRACK25U - 3D OBJ Model

## Product: StarTech.com 4-Post 25U Mobile Open Frame Server Rack
**Model Number:** 4POSTRACK25U

## Model Specifications

Based on official StarTech specifications:
- **Height with casters:** 50.7" (128.8 cm)
- **Height without casters:** 48" (122 cm)
- **Width:** 23.6" (60 cm)
- **Depth:** 36" modeled (adjustable 22-40" on real unit)
- **Rack Units:** 25U
- **Rack Width:** 19" (standard equipment mount)
- **Weight Capacity:** 1200 lbs (544 kg) stationary

## Model Details

| Property | Value |
|----------|-------|
| Vertices | 736 |
| Faces | 828 |
| Scale | ×2.54 (inches displayed as cm) |
| Materials | 3 (black_steel, dark_gray, rubber) |

## Components Modeled

1. **Four Vertical Posts** - Square tube construction with L-shaped mounting rails
2. **Top Frame** - Connecting structure at rack top
3. **Base Frame** - Lower support structure with bracing
4. **Cable Management Hooks** - 6 hooks per side (12 total)
5. **Four Casters** - Swivel casters with rubber wheels

## Files

- `startech_4postrack25u.obj` - 3D model geometry
- `startech_4postrack25u.mtl` - Material definitions
- `generate_rack.py` - Python script to regenerate/modify model

## Usage

Import the OBJ file into your preferred 3D software:
- Blender: File → Import → Wavefront (.obj)
- 3ds Max: File → Import
- SketchUp: File → Import (with OBJ importer)

The model is centered at origin with Y-axis up (floor at Y=0).

## Regenerating the Model

To modify or regenerate the model:

```bash
cd C:\Claude\HT\startech_4postrack25u
python generate_rack.py
```

Key configuration variables in `generate_rack.py`:
- `RACK_WIDTH` - Overall frame width
- `RACK_DEPTH` - Frame depth (adjustable 22-40")
- `RACK_HEIGHT` - Height without casters
- `NUM_U` - Number of rack units
- `CIRCLE_SEGMENTS` - Resolution for circular geometry

## Standards Compliance

The real StarTech rack complies with:
- EIA/ECA-310-E
- IEC 60297
- DIN 41494

## Application Notes

This rack model is suitable for home theater equipment room visualization,
showing the server rack that would house:
- AV receivers/processors
- Amplifiers
- Network equipment
- UPS systems
- Media servers
