# DIYSG Volt-10 Speaker Cabinet Models

3D OBJ models for the DIYSG Volt-10 coaxial speaker in sealed enclosures.

## Models

| Model | Dimensions | Volume | F3 | Use Case |
|-------|------------|--------|----|----------|
| volt10_standard.obj | 14" × 14" × 9.25" | ~0.7 cu ft | ~70 Hz | Surrounds, mains with sub |
| volt10_atmos.obj | 14" × 14" × 7" | ~0.46 cu ft | ~75 Hz | Ceiling/Atmos speakers |
| volt10_angled.obj | 14" × 14" × 5.5"-10.25" | ~0.55 cu ft | ~70 Hz | Wall-mount surrounds |

### Angled Cabinet Details

The angled cabinet is a wedge shape designed for wall mounting above ear level:
- **Top depth:** 10.25" (deeper, at ceiling)
- **Bottom depth:** 5.5" (shallower, toward listener)
- **Angle:** ~18.8° downward tilt
- **Baffle:** 14" × 14.655" (slightly taller due to angle)

## Driver

**Denovo Audio CX-10** (custom Eminence Beta-10CX variant)
- 10" coaxial with Celestion compression driver
- Cutout: 9.05" diameter
- Bolt circle: 9.66" diameter (8 holes)
- Mounting depth: 3.98"

## Specifications

| Parameter | Value |
|-----------|-------|
| Sensitivity | 95 dB @ 2.83V/1m |
| Impedance | 8 Ω |
| Power | 10-450 W |
| Max SPL | 119 dB |
| Crossover | 2000 Hz |

## File Structure

```
volt10/
├── models/                 # Generated OBJ files
│   ├── volt10_standard.obj
│   ├── volt10_standard.mtl
│   ├── volt10_atmos.obj
│   ├── volt10_atmos.mtl
│   ├── volt10_angled.obj
│   └── volt10_angled.mtl
│
├── intermediates/          # Python generators
│   ├── config.py           # Shared configuration
│   ├── generate_standard.py
│   ├── generate_atmos.py
│   ├── generate_angled.py
│   └── generate_all.py     # Master script
│
└── README.md
```

## Generation

```bash
cd intermediates

# Generate all models
python generate_all.py

# Generate specific model
python generate_all.py standard
python generate_all.py atmos
python generate_all.py angled

# Run individual generator
python generate_standard.py
```

## Construction Notes

- Use 3/4" MDF throughout
- Driver centered on baffle
- Light polyfill recommended for sealed enclosures
- No bracing needed for these small sealed boxes
- Angled cabinet requires trapezoid side panels

## Sources

- DIYSG Product Page: https://www.diysoundgroup.com/volt-10-v2.html
- Eminence Beta-10CX specs for driver dimensions
- AVS Forum threads for angled flat pack dimensions
