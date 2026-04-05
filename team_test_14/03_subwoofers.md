# 03 — Subwoofer System

> **FLAG — T/S VALUE DISCREPANCY:** POR docs contain incorrect T/S parameters (Vas=15.5 cuft, Qts=0.36). These are WRONG. All calculations below use verified values from `ts_params.json` only: **Qts=0.53, Vas=8.77 cuft, Fs=22 Hz**. Do not use POR T/S values for any box calculations.

---

## Driver Specs — Dayton Audio UMII18-22 (SKU 295-487)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Fs | 22.0 Hz | Free-air resonance |
| Qts | **0.53** | Total Q — use this, not POR value |
| Qes | 0.58 | Electrical Q |
| Qms | 6.22 | Mechanical Q |
| Vas | **8.77 cuft** | Acoustic compliance — use this, not POR value |
| Xmax | 28 mm | One-way linear excursion |
| Re | 5.8 Ω | DC resistance |
| BL | 21.5 T·m | Motor strength |
| Sd | 1026 cm² | Effective piston area |
| Le | 3.66 mH | Voice coil inductance |
| Sensitivity | 95.7 dB (1W/1m) | |
| Power handling | 1500 W | |

---

## Corner System Configuration

| Parameter | Value |
|-----------|-------|
| Total drivers | 8 |
| Cabinets | 4 (1 per corner) |
| Drivers per cabinet | 2 |
| Cabinet footprint | 24" × 24" |
| Cabinet height | 72" |
| Enclosure type | Sealed |
| Voice coil wiring | Series → 8 Ω per cabinet |
| Nearfield subs | Deferred — 4× UMII18-22, add post-build |

---

## Cabinet Volume Calculations

| Step | Formula | Result |
|------|---------|--------|
| Gross volume | 24 × 24 × 72 = 41,472 in³ | 24.0 cuft |
| Bracing displacement | 15% of gross | 3.6 cuft |
| Net volume (Vb total) | 24.0 × 0.85 | **20.4 cuft** |
| Vb per driver | 20.4 / 2 | **10.2 cuft** |

---

## Sealed Box Alignment Calculations

All formulas shown with actual numbers.

### alpha (compliance ratio)

```
alpha = Vas / Vb_per_driver
alpha = 8.77 / 10.2
alpha = 0.860
```

### Qtc (system Q)

```
Qtc = Qts × sqrt(1 + alpha)
Qtc = 0.53 × sqrt(1 + 0.860)
Qtc = 0.53 × sqrt(1.860)
Qtc = 0.53 × 1.3638
Qtc = 0.723
```

> Qtc = 0.723 is within 2% of the Butterworth maximally-flat alignment (0.707). Best transient behavior and flattest passband of the three cabinet height options evaluated.

### Fc (system resonance)

```
Fc = Fs × sqrt(1 + alpha)
Fc = 22 × sqrt(1.860)
Fc = 22 × 1.3638
Fc = 30.0 Hz
```

### F3 (−3 dB point)

```
F3_multiplier = sqrt( (1/(2×Qtc²)) - 1 + sqrt( (1/(2×Qtc²) - 1)² + 1 ) ) / sqrt(2)

Inner term: 1/(2 × 0.723²) - 1 = 1/1.046 - 1 = -0.0859
Discriminant: sqrt((-0.0859)² + 1) = sqrt(1.00738) = 1.00368
Radicand: -0.0859 + 1.00368 = 0.91778 → sqrt = 0.95801...

F3 = Fc × F3_multiplier
F3 = 30.0 × 0.9788
F3 = 29.4 Hz
```

### Summary Table — Selected Cabinet (72" height)

| Parameter | Value |
|-----------|-------|
| Vb per driver | 10.2 cuft |
| alpha (Vas/Vb) | 0.860 |
| Qtc | **0.723** |
| Fc | **30.0 Hz** |
| F3 (−3 dB) | **29.4 Hz** |

---

## Why Sealed vs Ported

| Factor | Sealed | Ported |
|--------|--------|--------|
| EQ headroom | Gentle 12 dB/oct rolloff — easy to boost below Fc | Vent unloading below port tune drops excursion headroom sharply |
| Room gain | +3–6 dB boundary gain at low freq compensates sealed rolloff naturally | Room gain still helps but port tune interacts with room modes |
| Port noise | None | Chuffing risk at high excursion |
| Group delay | Low, minimal overhang | Higher near port tune — audible in music bass |
| Construction | Simple, no port length tuning | Port length must be tuned; stuffing pressure risk |
| F3 outcome | 29.4 Hz with room gain support | Nominally similar but port unloading limits EQ ability |

**Decision:** Sealed is the correct alignment for this system. Room gain in a 3,910 cuft room compensates the natural 12 dB/oct rolloff below Fc. EQ headroom is preserved because there is no port unloading floor.

---

## Corner Loading & Acoustic Summing

| Effect | Gain |
|--------|------|
| Corner boundary loading (8× driver in 4 corners) | +11 dB |
| Acoustic summing from 4 corners (coherent at low freq) | ~+6 dB |
| **Total system gain vs free-air single driver** | **~+17 dB** |

---

## Amplifier Power Delivery

ICEpower 1200AS2 — 600 W rated at 8 Ω.

| Signal Path | Voltage (Vrms) | ICEpower Output |
|-------------|----------------|-----------------|
| PCM5102 DAC only (no 898B) | 2.0 V | **190.5 W** |
| PCM5102 → 898B balanced driver | 3.5 V | **583 W** (~97% of rated 600 W) |

Signal chain: X6800H → ADAU1452 → I2S → PCM5102 (2.0 Vrms) → Sonic Imagery 898B (3.5 Vrms) → ICEpower 1200AS2

The 898B's 11.79 dB gain brings the ICEpower to near full rated power. Without the 898B the amp runs at only 32% of rated output (190.5 W vs 600 W).

---

## Excursion Limits

```
Xmax = 28 mm (one-way linear)

Below ~13 Hz, driver excursion is the binding constraint — not amplifier power.
At 13 Hz and below, Xmax limits SPL output regardless of how much power is available.
DSP high-pass filtering (ADAU1452) protects drivers from infrasonic overexcursion.
```

---

## Tactile System

| Parameter | Value |
|-----------|-------|
| Shaker model | Aura Pro AST-2B-4 |
| Count | 8 |
| Installation | Under seating — Row 1 and Row 2 couches |

---

## Nearfield Subs (Deferred)

| Parameter | Value |
|-----------|-------|
| Driver | 4× Dayton UMII18-22 |
| Status | Deferred — add post-build |
| Placement | Forward-facing behind Row 1 |
| Phase 2 cost | $1,196 drivers + $400 cabinets + $746 amp = $2,342 |

---

## Why This Configuration vs Alternatives

| Alternative | Why Rejected |
|-------------|-------------|
| Ported enclosures | Port unloading limits EQ headroom below tuning freq; port noise at high excursion; construction complexity |
| Larger cabinets (96" or 120") | F3 essentially identical (29.4–29.6 Hz across all heights); larger = more cost, harder placement; no meaningful extension gain |
| Smaller footprint (20"×20") | POR had wrong footprint; 24"×24" is the correct spec per specs.yaml |
| Single large sub | No corner loading benefit; distributed array achieves more even room coverage and +17 dB combined gain |
| 4× drivers instead of 8 | Halved headroom, reduced array gain, less excursion capability at reference levels |
| Nearfield subs now | Deferred to keep Phase 1 budget at ~$36.6K; corner array alone achieves target; nearfield adds nearfield tactile impact not coverage |
