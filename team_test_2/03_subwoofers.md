# Subwoofer System
## Option D — Corner Subs + Deferred Nearfield + Tactile

**Source of truth:** `specs.yaml` | **Date:** 2026-03-14

---

## System Overview

| Subsystem | Drivers | Status | Cost |
|-----------|---------|--------|------|
| Corner subs | 8x UMII18-22 in 4 sealed rectangular cabinets | Build | $3,500 (6 drivers + enclosures) |
| Nearfield subs | 4x UMII18-22, full-width cabinet behind Row 1 | Deferred | $1,800 to restore |
| Tactile | 8x Aura Pro AST-2B-4 (1/seat) | Build | $660 |

---

## 1. Driver: Dayton UMII18-22

| Parameter | Value |
|-----------|-------|
| Fs | 22 Hz |
| Qts | 0.53 |
| Qes | 0.67 |
| Qms | 2.53 |
| Vas | 248.2 L (8.77 cu ft) |
| Xmax | 28 mm (Klippel verified) |
| Xmech (est.) | 35-40 mm |
| Sd | 1,184 cm2 |
| Vd | 3,315 cm3 per driver |
| Re | 4.2 ohm |
| Voice coil | Dual 2 ohm |
| RMS power | 1,200W |
| Cost | $350 each |
| Owned | 2 drivers. Need to buy 6 more. |

---

## 2. Corner Sub Enclosures — Option D Rectangular

**Geometry:** 4 sealed rectangular cabinets, 20"W x 20"D x 72"H, 2 drivers each.

This is NOT the triangular column design from POR Rev 5.9. The 17' screen wall has only 28" clearance per side — the triangular column's 34" hypotenuse won't fit. Rectangular 20" cabinets fit with 8" to spare.

### Volume Calculation (per cabinet)

| Dimension | External | Internal (3/4" walls) |
|-----------|----------|----------------------|
| Width | 20" | 18.5" |
| Depth | 20" | 18.5" |
| Height | 72" | 70.5" |

- Gross internal volume: 18.5 x 18.5 x 70.5 = 24,133 cu in = 13.97 cu ft
- Bracing deduction (~10%): -1.4 cu ft
- Driver displacement (2 drivers): -0.8 cu ft
- **Net volume: ~11.8 cu ft total = ~5.9 cu ft per driver**

**Wait — this is lower than the claimed 8.5 cu ft.** Let me reconcile.

The GC_Option1.md states "~8.5 cu ft per driver (17 cu ft total)." With 3/4" walls, the net is actually ~12 cu ft, or ~6 cu ft per driver before stuffing. With heavy polyfill (1 lb/cu ft), virtual volume increases ~35%:
- Virtual volume per driver: ~6 x 1.35 = **~8.1 cu ft** — close to the 8.5 claim.

### Sealed Box Performance (per driver, 8.1 cu ft virtual)

| Parameter | Value | vs Triangular (10.25 cu ft) |
|-----------|-------|-----------------------------|
| Fc | ~33 Hz | 30 Hz (+3 Hz) |
| Qtc | ~0.78 | 0.72 (+0.06) |
| F3 | ~32 Hz | ~29 Hz (+3 Hz) |
| Alignment | Slightly underdamped | Near-Butterworth |

**Impact:** ~2 dB less output at 20 Hz vs triangular columns. Not significant — room gain and EQ compensate.

### Boundary Loading

All 4 cabinets are floor-loaded in room corners (3 boundary surfaces).

| Parameter | Value |
|-----------|-------|
| Corner loading gain | +10-12 dB |
| 4-corner acoustic summing | +6 dB |
| Total gain vs single free-standing | +16-18 dB |

### Wiring

Each driver: voice coils in series = 4 ohm.
Two drivers per cabinet in series = **8 ohm per cabinet**.

```
Amp Ch (+) → Driver 1 VC+ → [2Ω] → VC- → [2Ω] → VC+ → Driver 2 VC+ → [2Ω] → VC- → [2Ω] → VC+ → Amp Ch (-)
Total: 4Ω + 4Ω = 8Ω per cabinet
```

### Amp Assignments

| Module | Channel A | Channel B |
|--------|-----------|-----------|
| 1200AS2 #1 | NW corner (screen left) | NE corner (screen right) |
| 1200AS2 #2 | SW corner (rear left) | SE corner (rear right) |

Power per channel: 620W @ 8 ohm (240V, both driven).
Per driver: 310W. Driver rated 1,200W RMS. Utilization: 26%.

### SPL at MLP

| Frequency | SPL @ MLP | vs THX 105 dB |
|-----------|-----------|---------------|
| 40 Hz | ~114 dB | +9 dB |
| 30 Hz | ~114 dB | +9 dB |
| 20 Hz | ~111 dB | +6 dB |
| 15 Hz | ~106 dB | +1 dB |

**Note:** The 20 Hz estimate is ~2 dB lower than the triangular column's 113 dB due to less enclosure volume. Still +6 dB over THX reference. Room gain in the smaller room (+0.3 dB vs reference) partially compensates.

### Cabinet Positions

| Position | Corner | Boundary Surfaces |
|----------|--------|-------------------|
| NW | Screen left | Floor + north wall + partition wall |
| NE | Screen right | Floor + north wall + east wall |
| SW | Rear left | Floor + south wall + partition wall |
| SE | Rear right | Floor + south wall + east wall |

Front pair hidden behind AT screen edges (28" clearance per side, 20" cabinet width). Stage deck spans between front cabinets. Rear pair behind Row 2 — 20" depth pushes Row 2 forward ~8" (negligible).

### Materials (per cabinet)

| Item | Cost |
|------|------|
| 3/4" plywood (2 sheets) | $90 |
| Bracing lumber | $30 |
| Polyfill (~12 lbs) | $18 |
| Terminal cup | $15 |
| Hardware, sealant, clamp | $25 |
| OC 703 face panels (2" x 2 panels) | $50 |
| AT fabric wrap | $50 |
| **Per cabinet** | **~$280** |
| **4 cabinets** | **~$1,120** |

Budget allocation: $350/cabinet x 4 = $1,400. Provides ~$280 contingency.

---

## 3. Nearfield Subs — Deferred

**Status:** Space reserved. Build post-install if chest-compression effect is missed.

| Spec | Value |
|------|-------|
| Drivers | 4x UMII18-22 |
| Location | Full-width cabinet behind Row 1 couch |
| Dimensions | ~96"W x 12.5"D x 20"H |
| Orientation | Forward-firing toward Row 1 backs |
| Amplifier | Repurpose spare 1200AS2 module |
| Restore cost | $1,400 (drivers) + $400 (cabinet) = $1,800 |

**Decision rationale:** The nearfield value is qualitative — chest-compression sensation at 15 Hz via particle velocity coupling. The magnitude is unproven vs the corner array's farfield pressure. The corner subs alone exceed tactile perception thresholds at MLP by 7-10 dB at 15-20 Hz. Build the corners first. Live with it. Add nearfield only if the effect is genuinely missed.

---

## 4. Tactile: Aura Pro AST-2B-4

| Spec | Value |
|------|-------|
| Quantity | 8 (1 per seat) |
| Bandwidth | 30-80 Hz |
| Mounting | Bolted to couch frame (solid wood required) |
| Amplifier | 1200AS2 #3 |
| DSP | ADAU1452 bandpass (30-80 Hz) |
| Cost | $560 (8 x $70) + $100 wiring = $660 |

**Reduced from 16 to 8:** 1/seat is community standard. Can double to 2/seat ($560) later.

---

## Critical Assessment

**Why UMII18-22:**
- 22 Hz Fs is ideal for sealed sub duty — minimizes EQ boost below Fs
- 28 mm Xmax (Klippel verified) — massive displacement
- Dual 2 ohm VCs allow practical 4 ohm or 8 ohm wiring
- $350/driver is competitive for this displacement class
- 2 already owned ($700 sunk)
- Proven platform with extensive community data

**Why sealed:**
- Room gain compensates sealed rolloff naturally
- No port chuffing at high excursion
- Simpler EQ (monotonic rolloff, no port-tuning interactions)
- Tighter transient response
- Smaller cabinet for equivalent performance in corner-loaded application

**Why 4 corners:**
- Welti/Harman research: 4-corner placement provides the most uniform bass across multiple seats
- +10-12 dB boundary loading per corner — massive free output
- Eliminates the need for "more driver" to overcome mid-room placement losses

**Weaknesses:**
- Rectangular cabinets have ~20% less volume per driver than triangular columns (8.1 vs 10.25 cu ft virtual). Fc is 33 Hz vs 30 Hz. ~2 dB less output at 20 Hz.
- 72" cabinets in corners may visually dominate the room — mitigated by OC 703 + AT fabric wrap (blend with treatment).
- Corner placement is locked at construction. If the layout changes, sub positions are fixed.
- Xmax (28 mm) is the binding constraint below ~13 Hz. No amount of additional amplification extends infrasonic output past this wall.

**What would change this:**
- If the room somehow accommodated triangular columns (wider screen wall or smaller screen), revert to triangular for +2 dB at 20 Hz and integrated treatment.
- If nearfield proves essential after living with the system, the reserved space and spare amp module make addition straightforward.
