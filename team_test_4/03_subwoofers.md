# Subwoofer System

## Corner Sub Array

### Driver Specification

| Parameter | Value |
|-----------|-------|
| Model | Dayton UMII18-22 |
| Quantity | 8 (2 owned, 6 to buy) |
| Fs | 22 Hz |
| Qts | 0.53 |
| Qes | 0.67 |
| Qms | 2.53 |
| Vas | 248.2 L (8.77 cu ft) |
| Xmax | 28 mm (Klippel verified @ 70% BL) |
| Sd | 1,184 cm^2 |
| Vd | 3,315 cm^3 |
| Re | 4.2 ohm (VCs in series) |
| VC config | Dual 2 ohm in series = 4 ohm |
| Sensitivity | 90.7 dB @ 2.83V/1m |
| RMS power | 1,200W |
| Weight | 35 lb |
| Unit cost | $349.98 |

### Cabinet Design

4 rectangular sealed cabinets, one per corner (NW, NE, SW, SE). Each cabinet holds 2 drivers in a vertical stack with internal partition.

| Parameter | Value |
|-----------|-------|
| External dimensions | 20" W x 20" D x 72" H |
| Panel thickness | 0.75" (3/4" MDF/plywood) |
| Bracing | One horizontal brace per chamber |

### Enclosure Volume Calculations

```
Internal dimensions:
  Width:  20 - 2(0.75) = 18.5"
  Depth:  20 - 2(0.75) = 18.5"
  Height: 72 - 2(0.75) = 70.5"

Internal partition at 36" height (0.75" thick):
  Chamber height = (70.5 - 0.75) / 2 = 34.875"

Gross volume per chamber:
  V = 18.5 x 18.5 x 34.875 = 11,934 cu in
  V = 11,934 / 1,728 = 6.91 cu ft

Displacement deductions:
  Driver displacement: ~0.25 cu ft (motor + basket + cone)
  Bracing displacement: ~0.26 cu ft (one horizontal brace)
  Total displacement:   ~0.51 cu ft

Net volume per driver:
  Vb = 6.91 - 0.51 = 6.40 cu ft

Virtual volume with moderate polyfill:
  Polyfill factor: ~1.3x (moderate fill)
  Vb_virtual = 6.40 x 1.3 = 8.32 cu ft (round to 8.3)
```

### Sealed Alignment Calculations

```
Fc = Fs x sqrt(1 + Vas/Vb)
   = 22 x sqrt(1 + 8.77/8.3)
   = 22 x sqrt(1 + 1.057)
   = 22 x sqrt(2.057)
   = 22 x 1.434
   = 31.6 Hz

Qtc = Qts x sqrt(1 + Vas/Vb)
    = 0.53 x sqrt(2.057)
    = 0.53 x 1.434
    = 0.76

F3 (solve from transfer function):
  For Qtc = 0.76:
  H(f) = (f/Fc)^2 / sqrt((1 - (f/Fc)^2)^2 + (f/(Fc*Qtc))^2) = 1/sqrt(2)

  Let x = (f/Fc)^2:
  x^2 / ((1-x)^2 + x/Qtc^2) = 0.5
  2x^2 = (1-x)^2 + x/0.76^2
  2x^2 = 1 - 2x + x^2 + 1.733x
  x^2 + 0.267x - 1 = 0
  x = (-0.267 + sqrt(0.0713 + 4)) / 2
  x = (-0.267 + 2.018) / 2
  x = 0.876
  f/Fc = sqrt(0.876) = 0.936
  F3 = 0.936 x 31.6 = 29.5 Hz

F3 with room gain:
  Room pressurization below ~40 Hz adds ~6-8 dB
  Effective F3 ~ 23 Hz
```

### SPL at MLP

```
Single driver SPL @ 1m, full power:
  SPL = 90.7 + 10*log10(620) = 90.7 + 27.9 = 118.6 dB (@ 1m, free-field)

Corner loading (quarter-space: floor + 2 walls):
  +6 dB boundary gain

4-corner coherent summation at LF:
  +6 dB (4 sources, coherent below room modes)

Distance loss (corner to MLP ~12 ft = 3.66 m):
  -20*log10(3.66) = -11.3 dB
  (reduced in practice -- room pressurization dominates below ~40 Hz)

Per-cabinet (2 drivers series @ 8 ohm, 620W):
  Each driver gets half voltage, but series wiring means
  same current through both = 620W total cabinet power
  SPL contribution per cabinet at 40 Hz (above Fc):
    90.7 + 10*log10(620) + 3 (2 drivers) + 6 (boundary) = 128.5 dB @ 1m

At MLP, 40 Hz (above Fc, minimal rolloff):
  128.5 - 11.3 + 6 (4-corner sum) = ~123 dB per corner pair
  4 corners summed: not additional -- already counted
  Effective SPL @ MLP, 40 Hz: ~119 dB

At MLP, 20 Hz (below Fc, with rolloff + room gain):
  Rolloff below Fc ~ -12 dB/oct for sealed (below F3)
  20 Hz is ~0.5 octave below F3 (29.5 Hz)
  Rolloff at 20 Hz: ~-6 dB from Fc response
  Room gain at 20 Hz: +6-8 dB
  Net SPL @ 20 Hz: ~113 dB

Summary:
  20 Hz @ MLP: ~113 dB
  40 Hz @ MLP: ~119 dB
  Headroom vs 105 dB THX bass reference: +8 to +14 dB
```

### Wiring

```
Per driver: Dual 2-ohm voice coils in series = 4 ohm
Per cabinet: 2 drivers in series = 4 + 4 = 8 ohm
Per ICEpower channel: 1 cabinet = 8 ohm load

ICEpower 1200AS2 @ 8 ohm = 620W per channel
Each unit has 2 channels:
  Unit 1: FL corner (ch1) + FR corner (ch2)
  Unit 2: RL corner (ch1) + RR corner (ch2)
```

**NOTE:** 4 ohm per driver is the only practical impedance. With dual 2-ohm VCs, parallel = 1 ohm (too low), series = 4 ohm. Two drivers series = 8 ohm. Two drivers parallel = 2 ohm. 8 ohm is ideal for ICEpower.

### Enclosure Cost

| Item | Qty | Unit Cost | Total |
|------|-----|-----------|-------|
| Plywood/MDF per cabinet | 4 | $250 | $1,000 |
| Bracing, sealant, polyfill | 4 | $50 | $200 |
| Terminal cups, gaskets | 4 | $25 | $100 |
| Misc hardware | -- | -- | $100 |
| **Total enclosures** | | | **$1,400** |

### Driver Cost

| Item | Qty | Unit Cost | Total |
|------|-----|-----------|-------|
| UMII18-22 (to buy) | 6 | $350 | $2,100 |
| UMII18-22 (owned) | 2 | -- | $0 |
| **Total drivers** | 8 | | **$2,100** |

## Nearfield Subwoofers (DEFERRED)

| Parameter | Value |
|-----------|-------|
| Status | **DEFERRED -- add post-build if chest-compression effect is missed** |
| Drivers | 4x UMII18-22 |
| Position | Behind Row 1, riser face, forward-firing |
| Deferred cost | $1,600 (4 drivers $1,400 + cabinet $200) |
| Decision point | After corner array is tuned and evaluated |

Rationale: corner array at 113+ dB @ 20 Hz may deliver sufficient tactile impact. Nearfield adds chest-compression at lower power but requires additional drivers and enclosure work. Defer to avoid sunk cost on uncertain benefit.

## Tactile (Bass Shakers)

| Parameter | Value |
|-----------|-------|
| Model | Aura Pro AST-2B-4 |
| Quantity | 8 (1 per seat) |
| Fs | 40 Hz |
| Bandwidth | 20-80 Hz |
| Unit cost | $70 |
| Shaker cost | $560 |
| Wiring | $100 |
| **Subtotal** | **$660** |
| Amplifier | ICEpower 1200AS2 #3 |

**CORRECTION (C6):** Reduced from 16 to 8. Community standard is 1 shaker per seat. 2 per seat is unproven and adds $660 for marginal benefit. Additional 8 can be added later if desired.

### Dirac ART Requirement

Dirac ART sends unique MIMO correction signals per sub output channel. The sub DSP chain **must preserve per-channel independence** -- no mixing or summing of sub channels before the power amps. Each ICEpower channel receives its own unique signal path:

```
X6800H Sub Out 1 → APM2 #1 Ch1 → ICEpower #1 Ch1 → Corner FL
X6800H Sub Out 2 → APM2 #1 Ch2 → ICEpower #1 Ch2 → Corner FR
X6800H Sub Out 3 → APM2 #2 Ch1 → ICEpower #2 Ch1 → Corner RL
X6800H Sub Out 4 → APM2 #2 Ch2 → ICEpower #2 Ch2 → Corner RR
```

APM2 #1 also feeds shaker signal to ICEpower #3 (derived from sub outs 1+2, summed in APM2).

## Critical Assessment

### Why 8 subs not 4 or 12?

**vs 4 subs (one per corner):**
- 4 subs = 4 ohm load per ICEpower channel (parallel wiring) or reduced SPL (single driver)
- 8 drivers in 4 corners provides +3 dB per corner vs single driver
- Better Xmax utilization -- each driver works less hard for same output
- Cost delta: +$1,400 drivers + $700 enclosure material = +$2,100 for +3 dB and 2x excursion headroom

**vs 12+ subs:**
- Diminishing returns: 12 vs 8 = +1.8 dB for +$2,100
- Room already has 113+ dB at 20 Hz with 8 -- exceeds reference by 8 dB
- Physical space: 4 corners are natural locations; adding mid-wall subs adds complexity
- Budget: $2,100 better spent on acoustic treatment or deferred items

### Why sealed not ported?

| Factor | Sealed | Ported |
|--------|--------|--------|
| F3 (free-field) | 29.5 Hz | ~18 Hz |
| F3 (in-room) | ~23 Hz | ~15 Hz |
| Group delay | Lower | Higher (port resonance) |
| Transient response | Better | Worse below tuning |
| EQ headroom | More (gentle rolloff) | Less (steep rolloff below port) |
| Room gain benefit | Full (12 dB/oct rolloff + room gain = flat) | Partial (already extended) |
| Cabinet complexity | Simple | Port tuning critical, larger cabinet |
| Excursion below tuning | Controlled | Unloaded -- risk of over-excursion |

**Verdict:** In a 3,910 cu ft room, room pressurization below 40 Hz provides 6-8 dB of gain that naturally compensates sealed rolloff. Ported extension is wasted in-room and comes with worse transient behavior and EQ limitations. Sealed + room gain + EQ = flat to ~20 Hz with superior impulse response.
