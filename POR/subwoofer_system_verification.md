# Subwoofer System Technical Summary — Verification Report

**Source:** `subwoofer_system_technical_summary.md`
**Verified against:** SubCabLab Thiele-Small model (UMII18-22 preset)
**Date:** 2026-02-20

---

## 1. Enclosure Alignments — ALL CORRECT

### Main Array (10.25 cu ft / 290 L per driver)

- Qtc = Qts × sqrt(1 + Vas/Vb) = 0.53 × sqrt(1 + 248.2/290) = 0.53 × 1.362 = **0.722**
- Fc = Fs × sqrt(1 + Vas/Vb) = 22 × 1.362 = **29.96 Hz**
- Doc claims: Fc 30 Hz, Qtc 0.72 — **MATCH**

### Front Nearfield (16 cu ft physical, ~22 cu ft virtual)

- Stuffing: 16 × 1.35 = 21.6 cu ft ≈ 22 — **MATCH**
- Per driver virtual: 311 L
- Qtc = 0.53 × sqrt(1 + 248.2/311) = 0.53 × 1.341 = **0.711**
- Fc = 22 × 1.341 = **29.5 Hz ≈ 30 Hz**
- Doc claims: Fc ~30 Hz — **MATCH**

### Rear Nearfield (25 cu ft physical, ~34 cu ft virtual)

- Stuffing: 25 × 1.35 = 33.75 ≈ 34 — **MATCH**
- Per driver virtual: 481 L
- Qtc = 0.53 × sqrt(1 + 248.2/481) = 0.53 × 1.231 = **0.652**
- Fc = 22 × 1.231 = **27.1 Hz**
- Doc claims: Fc ~27 Hz — **MATCH**

---

## 2. Total Displacement — INCONSISTENCY

Doc claims **3.24 cu ft** total displacement per stroke (16 drivers).

Using **28mm Klippel Xmax** (as stated in doc header):

- Vd per driver (peak-to-peak) = 1184 cm² × 5.6 cm = 6,630 cm³
- 16 drivers: 106,080 cm³ = **3.75 cu ft**

But 3.24 cu ft back-calculates to **Xmax = 24.1mm** — the manufacturer's published value, not the Klippel 28mm.

**Resolution needed:** Either the displacement should be 3.75 cu ft (using the Klippel value), or the header should reference 24.1mm instead of 28mm. Both values are defensible — Klippel is measured, manufacturer spec is conservative.

### Total Cone Area

- 16 × 1184 cm² = 18,944 cm² = 20.39 sq ft
- Doc claims 20.4 sq ft — **MATCH**

---

## 3. SPL Targets

**Note:** 90.7 dB @ 2.83V/1m into 4Ω is a 2W reference. Corrected 1W/1m sensitivity = **87.7 dB.**

### Main Array — 113+ dB @ 20 Hz at MLP (13 ft)

| Factor | Contribution |
|--------|-------------|
| Sensitivity (1W/1m) | 87.7 dB |
| 8 drivers (2³) | +9.0 dB |
| Power (700W/driver) | +28.5 dB |
| Sealed box rolloff at 20 Hz (Fc=30, Qtc=0.72) | -7.7 dB |
| Corner boundary gain (floor + 2 walls) | +10.0 dB |
| Room distance loss at 13 ft (λ >> room at 20 Hz, room pressurizes) | -4.0 dB |
| **Estimated SPL** | **~123.5 dB** |

**PASS — 10+ dB headroom over 113 dB target.** Main array is conservatively specified.

### Front Nearfield — ~121 dB @ 15 Hz @ 15"

| Factor | Contribution |
|--------|-------------|
| Sensitivity (1W/1m) | 87.7 dB |
| 2 drivers | +3.0 dB |
| Power (700W/driver) | +28.5 dB |
| Sealed box rolloff at 15 Hz (Fc=30, Qtc=0.71) | -12.2 dB |
| Near-field gain (1m → 0.38m) | +8.4 dB |
| Floor loading (partial boundary) | +3.0 dB |
| **Estimated SPL** | **~118.4 dB** |

**SHORT by ~2.5 dB.** Achievable with DSP boost at 15 Hz, but costs excursion headroom. At 15 Hz the driver is already deep below Fc and 700W approaches Xmax power. This target is tight and depends on DSP boost + careful limiter management.

### Rear Nearfield — ~123 dB @ 15 Hz @ 15"

| Factor | Contribution |
|--------|-------------|
| Sensitivity (1W/1m) | 87.7 dB |
| 2 drivers | +3.0 dB |
| Power (700W/driver) | +28.5 dB |
| Sealed box rolloff at 15 Hz (Fc=27, Qtc=0.65) | -11.0 dB |
| Near-field gain (1m → 0.38m) | +8.4 dB |
| Floor loading (partial boundary) | +3.0 dB |
| **Estimated SPL** | **~119.6 dB** |

**SHORT by ~3.4 dB.** Larger box (lower Fc) helps slightly but target is 2 dB higher than front. Needs meaningful DSP boost at 15 Hz, pushing excursion hard.

---

## 4. Channel Count vs Wiring — CONTRADICTION

The document states two conflicting things:

- **"16 discrete channels"** — implies 1 amp channel per driver, 4Ω load per channel
- **"2 drivers series per enclosure = 8Ω load to amp"** — implies 8 amp channels, 8Ω load per channel

These cannot both be true simultaneously:

| Interpretation | Channels | Load | Amps (stereo) | Power/driver |
|---------------|----------|------|---------------|-------------|
| **Option A:** Individual drivers | 16 | 4Ω | 8 | Full amp rating |
| **Option B:** Series pairs | 8 | 8Ω | 4 | Half of amp's 8Ω rating |

**This must be resolved before amp selection.** It fundamentally changes power delivery per driver.

---

## 5. Amp Power at Actual Load Impedance

### If Option A — 16 channels at 4Ω (individual drivers)

| Amp | Power/ch @ 4Ω | vs 700W Xmax | Headroom |
|-----|---------------|-------------|----------|
| Behringer NX6000D | 1,400W | 2.0× | Plenty |
| ICEpower 1200AS1 | 1,200W | 1.7× | Comfortable |
| ICEpower 1200AS2 | 600W/ch | 0.86× | **NOT ENOUGH** |

### If Option B — 8 channels at 8Ω (series pairs)

| Amp | Power/ch @ 8Ω | Per driver (÷2) | vs 700W Xmax |
|-----|---------------|----------------|-------------|
| Behringer NX6000D | ~800-1,000W (est.) | ~400-500W | **NOT ENOUGH** |
| NX6000D bridged | ~2,800W @ 8Ω | ~1,400W | Plenty, but halves channel count |

**If series wiring is used, NX6000D must be bridged** — meaning 8 amps for 8 bridged channels (16 drivers). Same amp count either way, but bridged operation is less efficient and generates more heat.

---

## 6. Additional Observations

### 700W Mechanical Limit at 20 Hz

Confirmed consistent with SubCabLab model. The app reports "Power at Xmax = 1,009W" but that is at 10 Hz (worst case). At 20 Hz, Xmax is reached at approximately 700W due to greater excursion efficiency closer to Fc. The document correctly distinguishes this.

### Boundary Gain Estimate (+10-12 dB)

Corner loading (floor + 2 walls) = quarter-space radiation = +9 dB theoretical. Additional room gain at frequencies where λ >> room dimensions adds +1-3 dB, supporting the +10-12 dB claim. Reasonable.

### Nearfield Chest Compression

The nearfield targets (121-123 dB @ 15 Hz @ 15") are designed for tactile effect, not SPL meter reference. The ~2.5-3.5 dB shortfall may be acceptable if supplemented by the 16× bass shakers mentioned in the doc, which cover the same 20-80 Hz band.

---

## Summary

| # | Item | Status | Notes |
|---|------|--------|-------|
| 1 | Enclosure alignments (Fc, Qtc) | **PASS** | All three groups verified |
| 2 | Total displacement (3.24 cu ft) | **INCONSISTENCY** | Uses 24.1mm Xmax, not 28mm Klippel. Should be 3.75 cu ft |
| 3 | Main array 113 dB @ 20 Hz | **PASS** | Model predicts ~123 dB — 10 dB headroom |
| 4 | Front nearfield 121 dB @ 15 Hz | **MARGINAL** | Model predicts ~118 dB — needs ~3 dB DSP boost |
| 5 | Rear nearfield 123 dB @ 15 Hz | **MARGINAL** | Model predicts ~120 dB — needs ~3.4 dB DSP boost |
| 6 | Channel count vs wiring | **CONTRADICTION** | "16 discrete channels" vs "series = 8Ω" — must resolve |
| 7 | 700W mechanical limit @ 20 Hz | **PASS** | Consistent with model |
| 8 | Amp power at actual impedance | **DEPENDS ON #6** | 4Ω individual: NX6000D fine. 8Ω series: must bridge |
| 9 | Cone area (20.4 sq ft) | **PASS** | Verified: 20.39 sq ft |
| 10 | Boundary gain (+10-12 dB) | **PASS** | Reasonable for full corner loading + room gain |

---

*Verified by SubCabLab model — Thiele-Small lumped parameter physics*
*Amplifier analysis based on manufacturer specifications and AVS Forum community data*
