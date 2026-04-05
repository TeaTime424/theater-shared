# 03 — Subwoofer System

**Source authority:** `specs.yaml` and `ts_params.json` — not POR Rev 7.0 docs.

---

## Driver: Dayton Audio UMII18-22

**WARNING — POR docs have INCORRECT T/S values.** POR Rev 7.0 lists Vas = 15.5 cu ft and Qts = 0.36. These are wrong. Correct values are from the Dayton datasheet (Parts Express SKU 295-487) as captured in `ts_params.json`.

[UNVERIFIED — values hardcoded from Dayton datasheet prompt, not independently fetched]

| Parameter | Value | Notes |
|-----------|-------|-------|
| Fs | 22.0 Hz | Free-air resonance |
| Qts | 0.53 | **POR value (0.36) is wrong — do not use** |
| Qes | 0.58 | |
| Qms | 6.22 | |
| Vas | 8.77 cu ft | **POR value (15.5 cu ft) is wrong — do not use** |
| Xmax | 28 mm | One-way, linear excursion |
| Re | 5.8 Ω | DC voice coil resistance |
| BL | 21.5 T·m | Force factor |
| Sd | 1026 cm² | Effective piston area |
| Le | 3.66 mH | Voice coil inductance |
| Sensitivity | 95.7 dB (1W/1m) | |
| Power handling | 1500 W | |

Source: `ts_params.json`, `specs.yaml` subwoofers.driver

---

## Corner Sub Array: System Overview

- 8× UMII18-22 drivers
- 4 stacked rectangular sealed cabinets, one per corner
- 2 drivers per cabinet, series wiring → 8 Ω per cabinet
- Cabinets in the NW, NE, SW, SE corners of the 17' × 23' theater

---

## Cabinet Design: 24" × 24" × 72"

Each cabinet houses 2 drivers in **separate sealed chambers** divided by an internal partition at the midpoint.

### Dimensions

| Dimension | Value |
|-----------|-------|
| Footprint (nominal) | 24" × 24" |
| Panel thickness | 0.75" |
| Internal width | 22.5" |
| Internal depth | 22.5" |
| Total height | 72" |
| Partition location | Height / 2 (36") |
| Per-driver chamber height | (72 / 2) − 0.75 = **35.25 in** |

Source: `ts_params.json` cabinet_geometry, `specs.yaml` subwoofers.corner_cabinet

### Volume Calculation (per driver chamber)

All math from `ts_params.json` sealed_cabinet_options.height_72in:

```
Gross volume = internal_width × internal_depth × chamber_height
             = 22.5 × 22.5 × 35.25
             = 17,864.06 in³

Convert to cubic feet:
  17,864.06 / 1728 = 10.338 ft³

Net volume (15% bracing deduction, factor = 0.85):
  10.338 × 0.85 = 8.787 ft³  ≈  8.79 ft³ net per driver
```

---

## Sealed Box Alignment Calculations

Using `ts_params.json` values: Fs = 22.0 Hz, Qts = 0.53, Vas = 8.77 ft³, Vb = 8.787 ft³

### Step 1 — Alpha (box tuning ratio)

```
α = Vas / Vb = 8.77 / 8.787 = 0.9980
```

### Step 2 — Frequency multiplier

```
√(α + 1) = √(0.9980 + 1) = √1.9980 = 1.4135
```

### Step 3 — System Q (Qtc)

```
Qtc = Qts × √(α + 1)
    = 0.53 × 1.4135
    = 0.749
```

### Step 4 — System resonance (Fc)

```
Fc = Fs × √(α + 1)
   = 22.0 × 1.4135
   = 31.1 Hz
```

### Step 5 — F3 (−3 dB point)

F3 formula for a 2nd-order sealed box:

```
F3 = Fc × √[ (1/Qtc² − 2)/2 + √( ((1/Qtc² − 2)/2)² + 1 ) ]

Step 5a:  1 / Qtc²    = 1 / 0.749²   = 1 / 0.5613  = 1.7820
Step 5b:  term        = 1.7820 − 2   = −0.2180
Step 5c:  inner sqrt  = √(0.2180² + 4) = √(0.0475 + 4) = √4.0475 = 2.0118
Step 5d:  numerator   = −0.2180 + 2.0118 = 1.7938
Step 5e:  half        = 1.7938 / 2   = 0.8969
Step 5f:  outer sqrt  = √0.8969      = 0.9471
Step 5g:  F3          = 31.1 × 0.9471 = 29.5 Hz
```

### Summary

| Parameter | Value |
|-----------|-------|
| Vb net (per driver) | 8.79 ft³ |
| α | 0.998 |
| Qtc | 0.749 |
| Fc | 31.1 Hz |
| F3 (−3 dB) | 29.5 Hz |

---

## Why Sealed

- **Easier EQ.** Sealed rolloff is 2nd-order (12 dB/oct), monotonic, and predictable. Ported boxes require port tuning to the cabinet, and a notch filter at port resonance is needed for protection — more variables to manage.
- **No port noise.** At 1500 W per driver there is no port or vent to chuff or resonate.
- **Room gain compensates natural rolloff.** The 3,910 cu ft room provides significant sub-30 Hz lift. At low frequencies the room behaves as a pressure chamber that loads all corner drivers simultaneously. The sealed rolloff below Fc is offset by room gain, yielding a substantially flatter in-room response than the anechoic curve suggests.

---

## Corner Loading

- **Boundary gain: +11 dB** — each driver placed in a tri-corner (floor + two walls) multiplies acoustic output by ×8 in pressure (3 boundaries, 2× per boundary = 8×, = +18 dB theoretical; practical measured value is +11 dB).
- **Acoustic summing from 4 corners: +~6 dB** — four widely spaced subwoofers summing at the main listening position (MLP) provides ~+6 dB relative to a single corner sub. At low frequencies (below ~80 Hz) the room dimensions are larger than the wavelength, so summing is incoherent and averages +6 dB rather than +12 dB coherent.

Source: `specs.yaml` subwoofers.corner_loading

---

## Power Delivery: ICEpower 1200AS2 into 8 Ω

Each cabinet is wired 2 drivers in series = 8 Ω. Two ICEpower 1200AS2 modules drive the array (units 1 and 2 per `specs.yaml` amplification.sub_amps.assignment):

| Parameter | Value |
|-----------|-------|
| ICEpower 1200AS2 into 8 Ω | **620 W** |
| Input sensitivity | 3.55 Vrms |
| Infrasonic derating | None |
| Voltage | 240 V native |

No derating at 15–20 Hz. The NX6000D drops to ~500–700 W at 15 Hz; the ICEpower 1200AS2 does not.

Source: `specs.yaml` amplification.sub_amps

---

## Excursion Limit

**Xmax = 28 mm is the binding constraint below ~13 Hz**, not amplifier power.

Above ~13 Hz, the drivers are in their linear range and the 620 W amp is the limiting factor. Below ~13 Hz, long-wavelength excursions grow rapidly and the driver runs out of linear travel before the amplifier clips. DSP high-pass filtering (ADAU1701, 5.23 fixed-point) is applied to protect drivers in this region.

---

## Nearfield Subs: Deferred

- **Plan:** 4× UMII18-22, forward-facing behind Row 1
- **Status:** Deferred — add post-build
- **Space:** Reserved behind Row 1 seating
- **Cost when added:** ~$1,400 (4 × $350)

Source: `specs.yaml` subwoofers.driver.nearfield_note

---

## Tactile System

| Parameter | Value |
|-----------|-------|
| Model | Aura Pro AST-2B-4 |
| Count | 8 (1 per seat) |
| Impedance | 4 Ω |
| Unit cost | $140 |
| Total cost | $1,120 |
| Amplifier | ICEpower 1200AS2 unit 3 |

Count reduced from 16 to 8 per bass plan decision (2026-03-13). Shakers are under-seat tactile only; the corner sub array handles all acoustic bass.

Source: `specs.yaml` subwoofers.tactile
