# Subwoofer System — Corner Array + Nearfield (Deferred) + Tactile

**Source of Truth:** `specs.yaml`
**Target SPL:** 95 dB at MLP (-10 dB Reference)
**Estimated sub SPL at 20 Hz:** ~113 dB at MLP

---

## Driver Specifications — Dayton UMII18-22

| Parameter | Value |
|---|---|
| Model | Dayton Audio UMII18-22 |
| Fs | 22 Hz |
| Qts | 0.53 |
| Qes | 0.67 |
| Qms | 2.53 |
| Vas | 248.2 L (8.77 cu ft) |
| Xmax | 28 mm |
| Sd | 1,184 sq cm |
| Vd | 3,315 cm3 |
| Re | 4.2 ohm |
| Mms | 420 g |
| BL | 19.2 T-m |
| Sensitivity | 90.7 dB (1W/1m) |
| Voice coil | Dual 2 ohm |
| RMS power | 1,200W |
| Unit price | $349.98 |

---

## Corner Sub Array

| Parameter | Value |
|---|---|
| Total drivers | 8 |
| Drivers per corner | 2 (stacked vertically, horizontal partition) |
| Corners | NW, NE, SW, SE (all 4 theater corners) |
| Cabinet type | Sealed rectangular |
| Cabinet dimensions | 24" W x 24" D x 96" H |
| Wall thickness | 3/4" (MDF or plywood) |
| Internal partition | Horizontal at 48" — isolates upper/lower chambers |
| Bracing | 1 horizontal brace per chamber + partition |
| Net volume per driver | 12.4 cu ft |
| Fc | 28.8 Hz |
| Qtc | 0.69 |
| F3 (in-box) | 32.5 Hz |
| Drivers owned | 2 |
| Drivers to buy | 6 |

### Corner Positions (Coordinates)

| Corner | X (in) | Z (in) | Y (in) | Adjacent Walls |
|---|---|---|---|---|
| NW | 144-168 | 252-276 | 0-96 | Partition + north |
| NE | 324-348 | 252-276 | 0-96 | East + north |
| SW | 144-168 | 0-24 | 0-96 | Partition + south |
| SE | 324-348 | 0-24 | 0-96 | East + south |

Front pair (NW, NE) frames the screen wall and doubles as structural elements for the stage.

---

## Sub Cabinet Height Assessment

### Sealed Enclosure Formulas

```
Fc = Fs * sqrt(1 + Vas/Vb)
Qtc = Qts * sqrt(1 + Vas/Vb)
```

Where:
- Fs = 22 Hz
- Qts = 0.53
- Vas = 8.77 cu ft
- Footprint = 24" x 24" (from layout_config.json — spatial source of truth)
- Wall thickness = 0.75"

### Option Comparison

| Height (in) | Vol/Driver (cu ft) | Vas/Vb | sqrt(1+Vas/Vb) | Fc (Hz) | Qtc | Notes |
|---|---|---|---|---|---|---|
| 72 | 9.2 | 0.953 | 1.397 | 30.7 | 0.74 | Near-Butterworth (0.707). 4ft gap to ceiling. |
| **96** | **12.4** | **0.707** | **1.307** | **28.8** | **0.69** | **SELECTED. Slightly below Butterworth. 2ft gap. 8ft lumber.** |
| 120 | 15.5 | 0.566 | 1.251 | 27.5 | 0.66 | Floor-to-ceiling. Overdamped. Diminishing returns. |

### Calculation Work — 96" (Selected)

```
Internal height per chamber = (96 - 0.75 - 0.75 - 0.75) / 2 = 46.875"
Internal width = 24 - 2*0.75 = 22.5"
Internal depth = 24 - 2*0.75 = 22.5"
Volume per chamber = 22.5 * 22.5 * 46.875 = 23,730 cu in = 13.73 cu ft
After bracing/driver displacement (~10%): ~12.4 cu ft

Vas/Vb = 8.77 / 12.4 = 0.707
sqrt(1 + 0.707) = sqrt(1.707) = 1.307

Fc = 22 * 1.307 = 28.8 Hz
Qtc = 0.53 * 1.307 = 0.69
```

### Decision Rationale

96" selected because:

1. **Qtc = 0.69** — slightly below Butterworth (0.707), giving smooth transient response without ringing
2. **2 ft gap to ceiling** — allows acoustic treatment above cabinets (absorbers or diffusers)
3. **8 ft = standard lumber** — plywood comes in 4x8 sheets; 96" height uses full sheets with minimal waste
4. **Good corner fill** — 8 ft columns fill corners convincingly without looking like afterthoughts (72") or being impossibly heavy (120")
5. **Diminishing returns** — going from 72" to 96" drops Fc by 1.9 Hz; 96" to 120" drops only 1.3 Hz

---

## Footprint Resolution: 24" x 24"

Early designs considered 20" x 20" footprint. Resolved to 24" x 24" per `layout_config.json` (spatial source of truth).

| Footprint | Vol/Driver (cu ft) | Fc (Hz) | Qtc | Verdict |
|---|---|---|---|---|
| 20" x 20" | ~8.5 | 31.0 | 0.75 | Tight fit, marginal volume |
| **24" x 24"** | **12.4** | **28.8** | **0.69** | **Selected — better alignment, easier build** |

24" matches standard lumber dimensions and provides room for internal bracing without compromising volume.

---

## Wiring

| Level | Configuration | Result |
|---|---|---|
| Voice coil | Dual 2 ohm VCs in series | 4 ohm per driver |
| Cabinet | 2 drivers in series | 8 ohm per cabinet |
| Amp load | 1 cabinet per amp channel | 8 ohm to ICEpower |

**Why 8 ohm:** ICEpower 1200AS2 delivers 620W into 8 ohm. Stable, cool, no protection triggers. 4 ohm is possible (2 VCs parallel = 2 ohm, 2 drivers series = 4 ohm) but gains little power and runs hotter.

**Why not 4 ohm per driver with 4 VCs:** UMII18-22 has dual 2 ohm VCs (2 coils total, not 4). Only practical impedances: 2 ohm (parallel) or 4 ohm (series) per driver. With 2 drivers series: 4 ohm or 8 ohm per cabinet.

---

## Boundary Loading and Acoustic Summing

| Effect | Gain (dB) | Basis |
|---|---|---|
| Corner loading (3 boundaries) | +11 | 2pi -> pi/4 radiation space |
| Acoustic summing (4 corners) | +6 | 10*log10(4) = 6 dB coherent summing at low frequencies |
| Room gain (3,910 cu ft) | +0.3 | Small room pressurization below room modes |
| **Total boundary advantage** | **+17.3** | At frequencies below ~80 Hz |

### Estimated SPL at MLP at 20 Hz

```
Per-driver SPL at 1m:
  90.7 + 10*log10(620) = 90.7 + 27.9 = 118.6 dB (free-field, at Fc)

Sealed rolloff at 20 Hz (below Fc=28.8):
  -12 dB/octave below Fc, but 20 Hz is only 0.53 octaves below 28.8 Hz
  Attenuation ~= 20*log10(20^2 / (20^2 + 28.8^2 * (1/Qtc^2 - 2) + 28.8^4/20^2))
  Simplified: ~-6 dB at 20 Hz relative to passband

Per-driver at 20 Hz: 118.6 - 6 = ~112.6 dB at 1m

Per-cabinet (2 drivers): 112.6 + 3 = 115.6 dB at 1m

At MLP (~10 ft = 3.05 m): 115.6 - 20*log10(3.05) = 115.6 - 9.7 = 105.9 dB per cabinet

4 cabinets summing: 105.9 + 6 = 111.9 dB
Boundary loading: 111.9 + 11 = 122.9 dB (theoretical max)

Conservative estimate accounting for room effects: ~113 dB at MLP at 20 Hz
```

This exceeds the 95 dB target by 18 dB — headroom for EQ cuts and Dirac correction.

---

## Sub Amplification

| Parameter | Value |
|---|---|
| Model | ICEpower 1200AS2 |
| Quantity | 5 (3 active + 2 spare) |
| Power @ 8 ohm | 620W (no infrasonic derating) |
| Voltage | 240V native |
| Cooling | Fanless |
| Modifications required | None |
| AUX 5V output | Yes — powers APM2 DSP boards |
| Unit price | $373 |
| Chassis/rack cost | $200 |

### Amp Assignments

| Unit | Channels | Load | Status |
|---|---|---|---|
| 1 | NW corner, NE corner | 8 ohm each | Active |
| 2 | SW corner, SE corner | 8 ohm each | Active |
| 3 | Tactile (bass shakers) | Varies | Active |
| 4 | Nearfield (if added) | - | Spare |
| 5 | Backup | - | Spare |

### Why ICEpower 1200AS2 (Not NX6000D, Not Hypex)

- 240V native — no step-down transformer
- No infrasonic derating: full 620W at 15 Hz (NX6000D drops to ~500-700W below 20 Hz)
- Fanless — zero mechanical noise
- AUX 5V powers APM2 DSP boards — no separate PSU needed
- No modifications required — ready to use
- $373/unit — competitive with pro amps that need mods

---

## Sub DSP

| Parameter | Value |
|---|---|
| Model | 2x Wondom APM2 (ADAU1701) |
| Fixed-point | 5.23 |
| Biquad order | [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy |
| Power | 5V from ICEpower 1200AS2 AUX5V |
| Capabilities | HPF to DC, PEQ, delay, level, crossover |
| Unit price | $40 |
| Total | $80 |

**Note:** Earlier designs specified ADAU1452+CS42448. CORRECTED to APM2 (ADAU1701). Different fixed-point format (5.23 vs 8.24).

---

## Dirac ART MIMO Integration

| Requirement | Implementation |
|---|---|
| Independent sub channels | X6800H has 4 sub outputs |
| Per-channel DSP | APM2 boards maintain channel separation |
| Corner independence | Each corner cabinet on its own amp channel |
| ART optimization | Dirac sends unique MIMO test signals per sub output for room mode correction |

**Critical:** Corner subs must NOT be paralleled. Each corner must receive its own signal from the X6800H sub outputs for Dirac ART to perform MIMO room mode optimization. The 4 sub outputs map 1:1 to 4 corners.

---

## Nearfield Subs — DEFERRED

| Parameter | Value |
|---|---|
| Status | DEFERRED — add post-build if chest-compression effect is missed |
| Drivers | 4x UMII18-22 |
| Position | Forward-facing behind Row 1 |
| Cabinet | Single shared enclosure behind Row 1 back |
| Estimated cost | $1,600 (4 drivers @ $350 + $200 cabinet) |
| Amp | ICEpower 1200AS2 Unit 4 (spare, already purchased) |

### Deferral Rationale

- 8 corner subs with boundary loading produce estimated 113 dB at 20 Hz — already exceeds reference by 18 dB
- Nearfield effect (chest compression) is subjective preference, not a reference standard requirement
- Space behind Row 1 is reserved — can add post-build without construction changes
- Spare amp already in the system
- If corner array proves insufficient for tactile impact at Row 1, nearfield subs are a $1,600 add

---

## Tactile — Aura Pro AST-2B-4

| Parameter | Value |
|---|---|
| Model | Aura Pro AST-2B-4 |
| Quantity | 8 (reduced from 16) |
| Configuration | 1 per seat (was 2 per seat) |
| Fs | 40 Hz |
| Bandwidth | 20-80 Hz |
| Unit price | $70 |
| Shaker total | $560 |
| Wiring + connectors | $100 |
| **Total** | **$660** |
| Amp | ICEpower 1200AS2 Unit 3 |

### Reduction Rationale (16 to 8)

- 1 shaker per seat provides adequate tactile feedback for most content
- 8 shakers on a single ICEpower channel is simpler wiring
- Can double to 2/seat ($660 additional) post-build if desired — deferred item

---

## Cost Tables

### Corner Sub Array

| Item | Qty | Unit Price | Total | Status |
|---|---|---|---|---|
| UMII18-22 (owned) | 2 | $350 | $700 | Owned |
| UMII18-22 (to buy) | 6 | $350 | $2,100 | To buy |
| Enclosure materials (4 cabinets) | 4 | $125 | $500 | To buy |
| **Corner sub total (to buy)** | | | **$2,600** | |

### Sub Amplification

| Item | Qty | Unit Price | Total |
|---|---|---|---|
| ICEpower 1200AS2 | 5 | $373 | $1,865 |
| Chassis / rack shelf | 1 | $200 | $200 |
| **Amp total** | | | **$2,065** |

### Sub DSP

| Item | Qty | Unit Price | Total |
|---|---|---|---|
| Wondom APM2 (ADAU1701) | 2 | $40 | $80 |

### Tactile

| Item | Qty | Unit Price | Total |
|---|---|---|---|
| Aura Pro AST-2B-4 | 8 | $70 | $560 |
| Wiring + connectors | - | - | $100 |
| **Tactile total** | | | **$660** |

### Subwoofer System Grand Total

| Category | To Buy | Owned |
|---|---|---|
| Corner drivers | $2,100 | $700 |
| Enclosures | $500 | - |
| Amplification | $2,065 | - |
| DSP | $80 | - |
| Tactile | $660 | - |
| **Total** | **$5,405** | **$700** |

---

## Critical Assessments

### Why Sealed (Not Ported)

- Sealed rolloff is 12 dB/octave — gentler than ported's 24 dB/octave cliff below tuning
- Room gain in 3,910 cu ft room compensates sealed rolloff naturally
- Corner boundary loading (+11 dB) extends usable response well below Fc
- Sealed is easier to EQ — monotonic rolloff, no port resonances, no chuffing
- Sealed cabinets are simpler to build — no port tuning, no port noise at high excursion
- With 28mm Xmax, excursion is the binding constraint below ~13 Hz, not amplifier power — ported would hit the same limit

### Why 96" Height (Not 72" or 120")

- See height assessment table above
- 72": Qtc = 0.74 (good alignment) but wastes 4 ft of corner space, poor visual integration
- 96": Qtc = 0.69 (near-Butterworth), 2 ft ceiling gap for treatment, standard lumber, best compromise
- 120": Qtc = 0.66 (overdamped), only 1.3 Hz lower Fc than 96", floor-to-ceiling is harder to build and blocks ceiling treatment

### Why Defer Nearfield

- Corner array already provides ~113 dB at 20 Hz — 18 dB above target
- Nearfield is a subjective preference (chest compression), not a measured deficiency
- Space is reserved, spare amp is purchased — zero construction penalty to add later
- Saves $1,600 in Phase 2 budget
- If corner array feels insufficient at Row 1 after room correction, nearfield is a bolt-on upgrade
