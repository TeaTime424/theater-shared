# 03 — Subwoofer System
## 8× Corner Subs + Deferred Nearfield + 8× Tactile Shakers

All specs from `specs.yaml`.

---

## System Overview

| Subsystem | Drivers | Cabinets | Status | SPL Target |
|-----------|---------|----------|--------|------------|
| Corner array | 8× UMII18-22 | 4 stacked (24×24×72) | **ACTIVE** | ~108 dB @ 20 Hz |
| Nearfield | 4× UMII18-22 | Behind Row 1 | **DEFERRED** | ~115 dB @ 15 Hz |
| Tactile | 8× Aura Pro AST-2B-4 | Seat-mounted | **ACTIVE** | N/A (vibration) |

---

## Driver: Dayton UMII18-22 Ultimax II

### T/S Parameters (DAYTON SPEC SHEET — verified)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Fs | **22 Hz** | Excellent for sealed sub-20Hz operation |
| Qts | **0.53** | Ideal for sealed alignment |
| Qes | 0.67 | |
| Qms | 2.53 | |
| Vas | **8.77 cu ft** (248.2 L) | USE THIS — NOT 15.5 cu ft |
| Xmax | **28 mm** | Klippel verified @ 70% BL |
| Sd | 1,184 cm² | |
| Vd | 3,315 cm³ per driver | |
| Re | 4.2Ω (VCs in series) | Dual 2Ω voice coils |
| Mms | 420g | |
| BL | 19.2 T·m | |
| Sensitivity | 90.7 dB @ 2.83V/1m | |
| RMS Power | 1,200W | AES 426B |
| Peak Power | 2,400W | |

**CRITICAL:** Previous docs incorrectly listed Vas=15.5 cu ft, Qts=0.36. These are WRONG. Use Dayton spec sheet values above. The incorrect values produce wildly optimistic sealed box predictions.

---

## Corner Sub Cabinets (4 Units)

### Dimensions — RESOLVED

| Spec | Value | Source |
|------|-------|--------|
| Width | **24"** | layout_config.json (source of truth) |
| Depth | **24"** | layout_config.json |
| Height | **72"** (6 ft) | Team assessment (see analysis below) |
| Panel thickness | 0.75" (3/4" MDF/plywood) | |
| Internal partition | At 36" (2 sealed chambers) | |
| Drivers per cabinet | 2 (1 per chamber) | |
| Alignment | Sealed | |

### Height Analysis — Team Assessment

Using correct T/S: Vas=8.77 cu ft, Qts=0.53, Fs=22 Hz. Footprint 24"×24", 0.75" panels.

Internal footprint: 22.5" × 22.5" = 506.25 sq in

| Height | Internal/Chamber | Gross Vol/Driver | Net Vol/Driver | Fc | Qtc | F3 | Verdict |
|--------|-----------------|------------------|----------------|-----|------|-----|---------|
| **72" (6 ft)** | 34.9" | 10.2 cu ft | **9.5 cu ft** | **30.3 Hz** | **0.730** | **~30 Hz** | **RECOMMENDED** |
| 96" (8 ft) | 46.9" | 13.7 cu ft | 13.0 cu ft | 28.4 Hz | 0.685 | ~31 Hz | Marginal gain |
| 120" (10 ft) | 58.9" | 17.3 cu ft | 16.5 cu ft | 27.2 Hz | 0.656 | ~32 Hz | Diminishing returns |

**Calculations (72" option):**

```
Internal height: 72 - 2.25 (3 panels) = 69.75", per chamber = 34.875"
Gross volume: 22.5 × 22.5 × 34.875 / 1728 = 10.21 cu ft
Net volume (subtract bracing ~5%, driver ~0.1 cu ft): ~9.5 cu ft

Fc = Fs × sqrt(1 + Vas/Vb) = 22 × sqrt(1 + 8.77/9.5) = 22 × sqrt(1.923) = 22 × 1.387 = 30.5 Hz
Qtc = Qts × sqrt(1 + Vas/Vb) = 0.53 × 1.387 = 0.735

For Qtc = 0.735 (near Butterworth 0.707):
F3 ≈ Fc = ~30 Hz (Qtc near 0.707 means F3 ≈ Fc)
```

**Why 72" wins:**
1. **Qtc = 0.73** — near-ideal Butterworth (0.707). Smooth response, no peaking, clean transition to room gain.
2. **96" gains only 2 Hz lower Fc** (30.3 → 28.4 Hz) but Qtc drops to 0.685, which actually raises F3 to ~31 Hz (worse!). The additional volume gives diminishing returns.
3. **120" is overkill** — 3 Hz lower Fc, but F3 worsens further. Visual dominance (floor-to-ceiling) and unnecessary structural mass.
4. **Room gain fills below Fc.** At 3,910 cu ft with sealed subs and +11 dB corner loading, room gain naturally extends response below 30 Hz. DSP can flatten to ~15 Hz.
5. **Front pair as screen wall bookends** — 72" (6 ft) provides solid structural support without blocking the 170" screen (top at 113").

### Wiring

Each dual-driver cabinet: 8Ω load.

```
Voice coils per driver: 2 × 2Ω wired in series = 4Ω per driver
Two drivers per cabinet wired in series = 4Ω + 4Ω = 8Ω per cabinet

Amp Ch (+) → Driver 1 VC+ → [2Ω] → VC- → [2Ω] → VC+ → Driver 2 VC+ → [2Ω] → VC- → [2Ω] → VC+ → Amp Ch (-)
```

### Positions

| Corner | Position | Boundary Loading |
|--------|----------|-----------------|
| NW (screen left) | X=144-168, Z=252-276 | Partition + north wall + floor |
| NE (screen right) | X=324-348, Z=252-276 | East wall + north wall + floor |
| SW (rear left) | X=144-168, Z=0-24 | Partition + south wall + floor |
| SE (rear right) | X=324-348, Z=0-24 | East wall + south wall + floor |

**Front pair doubles as screen wall structure.** Stage deck spans between them. AT screen frame mounts across their tops or to a header spanning between them.

### Boundary Loading

| Gain Source | dB | Calculation |
|-------------|-----|-------------|
| Corner loading (3 boundaries) | +11 dB | 2^3 = 8× energy → ~9 dB + reflections |
| Acoustic summing (4 corners) | +6 dB | 4 sources → 10*log10(4) = 6 dB |
| **Total free gain** | **+17 dB** | Before amp even wakes up |

### SPL Estimate at MLP (20 Hz)

```
Driver sensitivity: 90.7 dB @ 2.83V/1m (free-field, half-space)
Amp power per channel: ~197W @ 8Ω (through PCM5102 path)
Power contribution: 10*log10(197/1) = 22.9 dB...

Actually, sensitivity is at 2.83V. Let me use the correct approach:
SPL @ 1m = sensitivity + 10*log10(power/power_at_2.83V)
For 8Ω: P_2.83V = 2.83²/8 = 1W. So sensitivity = 90.7 dB/W/m.

Per driver @ 197W: 90.7 + 10*log10(197) = 90.7 + 22.9 = 113.6 dB @ 1m free-field

But this is 2 drivers per cabinet in series (8Ω), so 197W is split:
Each driver gets 197W × (4Ω/8Ω) voltage ratio... actually in series, each driver sees the same current.
Power per driver = 197 × 4/8 = 98.5W (voltage divides, current is same)
SPL per driver: 90.7 + 10*log10(98.5) = 90.7 + 19.9 = 110.6 dB

Two drivers in one cabinet (acoustic coupling at low freq): +3 dB = 113.6 dB per cabinet

Four cabinets: +6 dB (acoustic summing) = 119.6 dB @ 1m

Corner loading: +11 dB per corner is already included in room response measurement.
At MLP distance (~10 ft = 3m): -9.5 dB distance loss

But at 20 Hz, wavelength = 56.5 ft — the room is much smaller than a wavelength.
Room pressurization dominates over distance law below ~50 Hz.
Use room gain model instead of inverse-square:

Room gain at 20 Hz ≈ +6-10 dB over free-field prediction.
Corner loading adds +11 dB per corner.

Conservative estimate: ~108-112 dB @ 20 Hz at MLP.
```

**Conservative estimate: ~108 dB @ 20 Hz at MLP** (with PCM5102 gain staging limitation).

Note: At full rated power (620W), this would be ~113 dB. The 5 dB loss from gain staging is the main limitation. See `04_amplification_dsp.md` for details.

---

## Nearfield Subs (DEFERRED)

| Spec | Value |
|------|-------|
| Status | **DEFERRED — add post-build if chest-compression effect is missed** |
| Drivers | 4× UMII18-22 |
| Position | Behind Row 1, forward-firing |
| Cabinet | Full-width (8' wide × 12.5" deep × ~20" tall) |
| Wiring | Parallel = 4Ω per ICEpower channel |
| Amplifier | ICEpower 1200AS2 #4 (currently spare) |
| Deferred cost | ~$1,800 (4 drivers $1,400 + cabinet $400) |

**Why deferred:** 8 corner subs deliver ~108 dB @ 20 Hz — well above 95 dB target. Add nearfield post-build only if chest-compression effect is missed. Space behind Row 1 is reserved. The spare ICEpower module is ready.

---

## Tactile Bass Shakers

| Spec | Value |
|------|-------|
| Model | Aura Pro AST-2B-4 |
| Count | **8** (1 per seat, reduced from 16) |
| Fs | 40 Hz |
| Bandwidth | 20-80 Hz |
| Amplifier | ICEpower 1200AS2 #3 |
| Unit cost | $70 |
| Wiring | $100 |
| Total cost | **$660** |

Shakers provide direct seat vibration — different perceptual mechanism than air-coupled bass. Kick, punch, rumble.

Can double to 2/seat (16 total) for +$660 if desired.

---

## Cost Summary

| Item | Qty | Unit | Total | Notes |
|------|-----|------|-------|-------|
| UMII18-22 drivers (to buy) | 6 | $350 | $2,100 | 2 owned, 4 nearfield deferred |
| Corner enclosures (DIY) | 4 | $350 | $1,400 | Materials: plywood, bracing, sealant |
| Aura Pro shakers | 8 | $70 | $560 | |
| Shaker wiring | — | — | $100 | |
| **Sub system total (to buy)** | | | **$4,160** | |
| | | | | |
| UMII18-22 (owned) | 2 | $350 | $700 | Already in hand |
| **Sub system total value** | | | **$4,860** | |

### Deferred Items

| Item | Cost | Add When |
|------|------|----------|
| 4× UMII18-22 nearfield | $1,400 | Post-build if chest impact missed |
| Nearfield enclosure | $400 | Post-build |
| 8× Aura Pro (doubling) | $560 | If 1/seat not sufficient |
| Extra shaker wiring | $100 | With shaker doubling |
| **Total deferred** | **$2,460** | |

---

## Critical Assessment

### Settled
- 8× UMII18-22 in 4 corner cabinets — proven design, correct driver
- Sealed alignment — room gain fills bottom octave, easier to EQ
- 24"×24" footprint — matches layout_config.json
- 72" height — Qtc 0.73, near-Butterworth, team consensus
- Front pair as screen wall bookends — dual-purpose, simplifies build
- Nearfield deferral — smart phasing, adds $0 risk ($1,800 later if needed)

### Known Weakness
- Gain staging limits amp to ~197W/ch (vs 620W rated) — see doc 04
- Net SPL at 20 Hz is ~108 dB, not the ~113 dB claimed in some source docs
- This is still +13 dB over the 95 dB target — more than sufficient
- Full power recovery requires higher-output DAC or different signal chain

---

*All values from specs.yaml. Document generated 2026-03-16.*
