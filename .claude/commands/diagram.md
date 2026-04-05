---
description: Regenerate technical diagrams for a subsystem (runs generate_all.py)
allowed-tools: Bash, Read, Glob
---

# Diagram Generation

Regenerate technical construction diagrams for a subsystem.

## Arguments
- `$ARGUMENTS` — subsystem name or `all`
  - Valid names: `titan_815lx`, `triangular_corner_sub`, `volt10`, `nearfield_front_18`, `NearFieldv3`, `dual_opposed_sofa_table`, `front_firing_sub_8cf`, `nearfield_cabinet`, `amp_plate`
  - If empty, list available subsystems and ask user to pick

## Locating the Generator

Each subsystem has a `generate_all.py` in one of these patterns:
- `POR/<subsystem>/intermediates/generate_all.py`
- `POR/<subsystem>/scripts/generate_all.py`
- `experiments/<subsystem>/intermediates/generate_all.py`
- `experiments/<subsystem>/amp_plate/intermediates/generate_all.py` (amp_plate special case)

Use Glob to find the right path:
```
Glob: **/generate_all.py
```

## Steps

1. **Locate** the `generate_all.py` for the requested subsystem
2. **Read** `config.py` in the same directory to understand current parameters
3. **Run** the generator:
   ```bash
   cd <intermediates_dir> && python generate_all.py
   ```
   Or for specific diagrams only:
   ```bash
   cd <intermediates_dir> && python generate_all.py ff_01 ff_04
   ```
4. **List** the output in the `diagrams/` directory (sibling to `intermediates/`)
5. **Report** which diagrams were generated/updated

## If `all` is requested

Find every `generate_all.py` in the project and run each one sequentially. Report results per subsystem.

## Troubleshooting

- **ModuleNotFoundError**: Generator imports `from config import *` — must `cd` into the intermediates directory first
- **Missing diagrams/ dir**: Create it — `mkdir -p ../diagrams` (relative to intermediates)
- **matplotlib errors**: Ensure `Agg` backend for headless rendering (should be default on Windows CLI)
