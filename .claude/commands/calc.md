---
description: Acoustic and electrical calculations — SPL, impedance, enclosure volume, power, boundary gain
allowed-tools: Bash, Read
---

# Acoustic / Electrical Calculator

Run common home theater engineering calculations.

## Arguments
- `$ARGUMENTS` — calculation type and parameters (see types below)
  - If empty, list available calculation types

## Calculation Types

### `spl` — SPL from sensitivity + power + distance
- Inputs: sensitivity (dB @ 1W/1m), power (W), distance (m or ft)
- Formula: `SPL = sensitivity + 10*log10(power) - 20*log10(distance/1m)`
- Example: `calc spl 99dB 150W 12ft`

### `impedance` — Series/parallel voice coil wiring
- Inputs: VC impedance (Ω), VC count, wiring (series/parallel/series-parallel)
- Example: `calc impedance 2ohm 2vc series` → 4Ω
- Example: `calc impedance 2ohm 4vc` → show all combinations
- Note: UMII18-22 has dual 2Ω VCs; only 2Ω (parallel) and 8Ω (series) are practical with 4 VCs across 2 drivers

### `volume` — Enclosure internal volume from dimensions
- Inputs: W×H×D (external, inches), MDF thickness, baffle thickness, recess depth
- Outputs: gross volume (ft³), net volume after bracing estimate
- Example: `calc volume 30x48x22 mdf=0.75 baffle=1.5 recess=3`

### `power` — Amplifier power per driver for a given load
- Inputs: amp model, load impedance, number of drivers
- Uses known amp specs: NX6000D (1600W@4Ω bridged, derated below 20Hz), AVR-A1H (150W@8Ω)
- Example: `calc power NX6000D 8ohm 2drivers`

### `boundary` — Boundary gain estimate
- Inputs: number of boundaries (0-3), distance from boundaries
- Half-space (+3dB), quarter-space (+6dB), eighth-space (+9dB) plus corner loading
- Our corner columns: +11 dB boundary gain typical
- Example: `calc boundary 3 corner`

### `headroom` — Can a channel hit target SPL?
- Inputs: speaker model, amp power, distance, target SPL
- Combines SPL calc with known speaker specs from POR
- Example: `calc headroom Volt-10 150W 10ft 95dB`

### `xmax` — Driver excursion at frequency and power
- Inputs: driver model, frequency, power
- Uses Sd and BL from known driver specs
- Flags if excursion exceeds Xmax (UMII18-22: 28mm)
- Example: `calc xmax UMII18-22 15Hz 500W`

## Steps

1. **Parse** the calculation type and parameters from $ARGUMENTS
2. **Look up** any needed specs from POR documents if referencing known equipment
3. **Compute** using standard acoustics/electrical formulas
4. **Show** the formula used, intermediate values, and final result
5. **Flag** any concerns (exceeds Xmax, insufficient headroom, impedance mismatch)

## Known Equipment Specs (for quick reference)

```
Titan-815LX:  99 dB/W/m, 6Ω nom, 4.2Ω min, ported
Volt-10:      95 dB/W/m, 8Ω nom
UMII18-22:    dual 2Ω VC, Xmax 28mm, Sd=1220cm², BL=18.9
NX6000D:      1600W/ch@4Ω bridge, 1100W/ch@8Ω bridge, ~500-700W@15Hz derated
AVR-A1H:      150W/ch@8Ω, all 15 channels driven
```

## Output

Show the calculation clearly:
```
SPL Calculation:
  Sensitivity: 99 dB/W/m (Titan-815LX)
  Power: 150 W (AVR-A1H @ 8Ω)
  Distance: 3.66 m (12 ft)

  SPL = 99 + 10×log10(150) - 20×log10(3.66)
      = 99 + 21.8 - 11.3
      = 109.5 dB

  ✓ Exceeds -10 dB reference target (95 dB) by 14.5 dB
```
