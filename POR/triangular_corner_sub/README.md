# Triangular Corner Subwoofer Project

## Overview

This folder contains the design files for the triangular corner-loaded subwoofer columns used in the main subwoofer array. Each corner has a column containing two 8.4 cu ft sealed cabinets with Dayton UMII18-22 drivers.

**Configuration:** 4 corners × 2 drivers = 8 drivers total (main array)

---

## Key Documents

### Analysis & Reference
- **[Linkwitz_Transform_Analysis.md](Linkwitz_Transform_Analysis.md)** - Complete LT extension analysis
  - THX reference level verification (115 dB LFE)
  - Attenuation + LT strategy for 14 Hz extension
  - Xmax/Xmech research and safety margins

### Plot Generation Scripts
| Script | Purpose | Output |
|--------|---------|--------|
| `plot_spl_xmax.py` | Baseline SPL/excursion curves | SPL and excursion vs frequency |
| `plot_spl_115db_target.py` | Attenuation EQ to THX LFE | Before/after comparison |
| `plot_lt_extended.py` | LT extension comparison | Multiple LT target comparison |

**Usage:**
```bash
cd C:\Claude\HT\triangular_corner_sub
python plot_spl_xmax.py
python plot_spl_115db_target.py  
python plot_lt_extended.py
```

---

## 3D Model Generation

### Directory Structure
```
triangular_corner_sub/
├── intermediates/          # Python source files
│   ├── config.py          # Shared configuration
│   ├── obj_writer.py      # OBJ file utilities
│   ├── generate_all.py    # Master generator
│   ├── generate_front_*.py # Front column generators
│   └── generate_rear_*.py  # Rear column generators
└── models/                 # OBJ output files
```

### Running Model Generation
```bash
cd C:\Claude\HT\triangular_corner_sub\intermediates
python generate_all.py
```

---

## Cabinet Specifications

### Per Cabinet (Single Driver)
| Parameter | Value |
|-----------|-------|
| Internal Volume | 238 L / 8.4 cu ft (effective) |
| Configuration | Sealed with polyfill |
| Fc | 31.4 Hz |
| Qtc | 0.758 |
| F3 (no EQ) | ~31 Hz |
| F3 (with LT) | **14 Hz** |

### Column Layout
| Column | Height | Cabinets | Driver Heights |
|--------|--------|----------|----------------|
| Front | 120" | 2 × 60" | 11" and 32" from bottom |
| Rear | 120" | 72" + 48" | 35" and 56" from bottom |

### Boundary Loading
- Corner placement provides +12 dB gain (three-wall loading)
- This naturally compensates for sealed box rolloff
- Combined with LT, achieves flat response to 14 Hz

---

## EQ Configuration Summary

### Recommended: LT to 14 Hz

| Stage | Setting |
|-------|---------|
| Passband Attenuation | -14 dB |
| Linkwitz Transform | Fc: 31.4→14 Hz, Qtc: 0.76→0.71 |
| Subsonic HPF | 11 Hz, 24 dB/oct |

### Result
- Flat 115 dB from 14 Hz to 80+ Hz
- Max excursion: 21 mm (75% Xmax)
- 25% headroom remaining

---

## Related Documents

- **[../03_Subwoofer_System.md](../03_Subwoofer_System.md)** - Main subwoofer system documentation
- **[../UMII18-22_Excursion_Limits_Reference.md](../UMII18-22_Excursion_Limits_Reference.md)** - Driver excursion research
- **[../12_Technical_Appendix_Subwoofers.md](../12_Technical_Appendix_Subwoofers.md)** - Technical calculations

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-12-28 | Initial README with LT analysis integration |
