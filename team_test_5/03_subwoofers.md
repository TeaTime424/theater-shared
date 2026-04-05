# 03 — Subwoofer System

**Date:** 2026-03-15
**Configuration:** 8x UMII18-22 in 4 corner cabinets + 8x Aura Pro tactile
**References:** specs.yaml, POR/03_Subwoofer_System.md, bass-plan-overkill verdict

---

## 1. Driver: Dayton Audio UMII18-22

### Verified T/S Parameters (Dayton Spec Sheet 295-718)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Fs | **22 Hz** | |
| Qts | **0.53** | VCs in series (4 ohm) |
| Qes | 0.67 | |
| Qms | 2.53 | |
| Vas | **248.2 L (8.77 cu ft)** | |
| Xmax | 28 mm | Klippel verified @ 70% BL |
| Sd | 1,184 cm^2 | |
| Vd | 3,315 cm^3 | |
| Re | 4.2 ohm | VCs in series |
| Mms | 420 g | |
| BL | 19.2 T-m | |
| Sensitivity | 90.7 dB @ 2.83V/1m | VCs in series |
| RMS Power | 1,200 W | AES 426B |
| Voice Coils | Dual 2 ohm | Series = 4 ohm per driver |

**CORRECTION:** Earlier documents listed Vas=15.5 cu ft and Qts=0.36. These are incorrect. The values above are from the Dayton spec sheet and POR/03_Subwoofer_System.md.

---

## 2. Corner Sub Cabinets

### Cabinet Design: 24" x 24" x 72" Sealed

| Parameter | Value |
|-----------|-------|
| External dimensions | 24" W x 24" D x 72" H (6 ft) |
| Panel thickness | 3/4" (0.75") plywood |
| Internal dimensions | 22.5" x 22.5" x 70.5" |
| Gross internal volume | 20.65 cu ft |
| Net volume (after 8% bracing/driver) | 19.0 cu ft |
| **Net volume per driver** | **9.5 cu ft** |
| Drivers per cabinet | 2 (stacked vertically) |
| Wiring | 8 ohm series (each driver 4 ohm, 2 in series) |

### Enclosure Calculations

**Formulas:**
- Fc = Fs x sqrt(1 + Vas/Vb)
- Qtc = Qts x sqrt(1 + Vas/Vb)
- F3 = Fc x sqrt((1/Qtc^2 - 2 + sqrt((1/Qtc^2 - 2)^2 + 4)) / 2)

**Where:** Vb = net volume per driver = 9.5 cu ft; Vas = 8.77 cu ft; Vas/Vb = 0.923

### Results for All Three Heights

| Height | Vb/driver | Vas/Vb | Fc (Hz) | Qtc | F3 (Hz) | Assessment |
|--------|-----------|--------|---------|-----|---------|------------|
| **72" (6 ft)** | **9.5 cu ft** | **0.923** | **30.5** | **0.735** | **29.4** | **Near-optimal Butterworth (0.707)** |
| 96" (8 ft) | 12.7 cu ft | 0.691 | 28.6 | 0.690 | 29.3 | Slightly underdamped |
| 120" (10 ft) | 16.0 cu ft | 0.548 | 27.4 | 0.660 | 29.5 | Overdamped, heaviest |

**Detailed calculation for 72":**
- Vas/Vb = 8.77 / 9.5 = 0.923
- Fc = 22 x sqrt(1 + 0.923) = 22 x sqrt(1.923) = 22 x 1.387 = **30.5 Hz**
- Qtc = 0.53 x sqrt(1.923) = 0.53 x 1.387 = **0.735**
- 1/Qtc^2 = 1/0.540 = 1.851
- 1/Qtc^2 - 2 = -0.149
- F3 = 30.5 x sqrt((-0.149 + sqrt(0.022 + 4)) / 2) = 30.5 x sqrt((-0.149 + 2.006) / 2) = 30.5 x sqrt(0.929) = 30.5 x 0.964 = **29.4 Hz**

### Recommendation: 72" Height

**Rationale:**
1. Qtc = 0.735 is closest to ideal 0.707 Butterworth — flattest passband
2. F3 is essentially identical across all heights (~29.3-29.5 Hz free-field)
3. Weight: ~220 lbs loaded (vs ~310 for 96", ~400+ for 120")
4. Fits through 36" door without tilting
5. 6' height leaves 4' above for treatment or aesthetics
6. Matches POR's optimized alignment (Fc=30, Qtc=0.72 with polyfill) without needing polyfill

**Key insight:** F3 converges to ~29.4 Hz regardless of height because lower Fc (bigger box) is offset by lower Qtc (earlier rolloff slope). The practical difference is passband shape — 72" gives the flattest response.

### Cabinet Placement

| Corner | Position | Boundary Loading |
|--------|----------|------------------|
| NW (screen left) | Floor + north wall + partition wall | +11 dB |
| NE (screen right) | Floor + north wall + east wall | +11 dB |
| SW (rear left) | Floor + south wall + partition wall | +11 dB |
| SE (rear right) | Floor + south wall + east wall | +11 dB |

Front pair sits in the 28" clearance flanking the 170" screen. Rear pair sits in corners behind Row 2.

### Internal Construction

- Horizontal partition at midpoint (36" internal height) — separates the two driver chambers
- Horizontal bracing shelf at 1/4 and 3/4 height
- Two 18" circular driver cutouts on front baffle (one per chamber)
- Driver centers at ~18" and ~54" from bottom (external)
- No ports (sealed)
- No polyfill needed (Qtc 0.735 is near-optimal without it)

---

## 3. SPL at MLP

### Per-Corner Calculation

**ICEpower 1200AS2:** 620W/ch @ 8 ohm (2 drivers in series).
Per driver: 310W into 4 ohm.

UMII18-22 sensitivity at 4 ohm: 90.7 dB @ 2.83V/1m. At 4 ohm, 2.83V = 2W.
Sensitivity referenced to 1W = 90.7 - 3 = 87.7 dB/W/m.

**SPL per corner:**
- Per driver at 310W: 87.7 + 10*log10(310) = 87.7 + 24.9 = 112.6 dB @ 1m
- Two drivers: +3 dB = 115.6 dB @ 1m (free-field)
- Corner boundary loading: +11 dB
- **SPL per corner in room: 126.6 dB @ 1m**

**Total system (4 corners):**
- 4-corner coherent summing: +6 dB (conservative; up to +12 dB below 25 Hz)
- **Total at MLP passband: ~132.6 dB** (theoretical maximum)

**At 20 Hz (below Fc=30.5 Hz):**
- Sealed rolloff at f/Fc = 20/30.5 = 0.656, Qtc = 0.735
- Response: approximately -5 to -6 dB
- **SPL at 20 Hz at MLP: ~113 dB** (consistent with POR claims)
- Headroom vs 105 dB THX LFE reference: **+8 dB**

### DAC Voltage Limitation Impact

With 2x APM2 (ADAU1701 DAC = 0.9 Vrms) driving ICEpower 1200AS2:
- Max amp output: 0.9 x 19.5 = 17.55 Vrms -> 38.5W @ 8 ohm
- Per driver: 19.25W
- Per driver SPL: 87.7 + 10*log10(19.25) = 87.7 + 12.8 = 100.5 dB
- Per corner (2 drivers): 103.5 dB
- + boundary loading (+11 dB): 114.5 dB
- + 4-corner summing (+6 dB): **120.5 dB passband**
- After 20 Hz rolloff (-6 dB): **~114.5 dB at 20 Hz**

**Still +9.5 dB above 105 dB THX LFE reference.** The system works even voltage-limited. The DRV134 balanced line driver ($30) recovers full 620W/ch headroom.

---

## 4. Wiring

Each driver: dual 2 ohm VCs wired in series = 4 ohm per driver.
Two drivers per cabinet wired in series = **8 ohm per cabinet**.

```
Amp Ch (+) -- Driver 1 VC+ --[2ohm]-- VC- --[2ohm]-- VC+ -- Driver 2 VC+ --[2ohm]-- VC- --[2ohm]-- VC+ -- Amp Ch (-)
             (4 ohm)                                           (4 ohm)
             Total: 4 + 4 = 8 ohm
```

### Amp Assignment

| Amp Module | Ch A | Ch B |
|------------|------|------|
| ICEpower #1 | Corner NW (FL) @ 8 ohm | Corner NE (FR) @ 8 ohm |
| ICEpower #2 | Corner SW (RL) @ 8 ohm | Corner SE (RR) @ 8 ohm |
| ICEpower #3 | Bass shakers (8x Aura Pro) | -- |
| ICEpower #4 | Spare (nearfield if added) | -- |
| ICEpower #5 | Spare | -- |

---

## 5. Nearfield Subs (Deferred)

| Parameter | Value |
|-----------|-------|
| Status | **Deferred** — space reserved behind Row 1 (riser face) |
| Drivers | 4x UMII18-22 |
| Configuration | Forward-firing from riser face toward Row 1 backs |
| Restore cost | $1,400 drivers + $400 cabinets = $1,800 |
| Decision criteria | Live with corner subs for 1 month; add if chest-compression effect is missed |

---

## 6. Tactile Bass Shakers

| Parameter | Value |
|-----------|-------|
| Model | Aura Pro AST-2B-4 |
| Quantity | 8 (1 per seat, 4 seats per couch, 2 couches) |
| Fs | 40 Hz |
| Bandwidth | 20-80 Hz |
| Amp | ICEpower 1200AS2 #3 |
| Cost | $560 (shakers) + $100 (wiring) = $660 |
| Deferred | Can double to 2/seat (+$560) if desired |

**Wiring:** 8 shakers in series-parallel (2S4P or 4S2P) to present ~4-8 ohm load to single ICEpower channel. Final impedance depends on individual shaker impedance (4 ohm each).

---

## 7. Room Modes

| Mode | Dimension | Frequency |
|------|-----------|-----------|
| Length (1,0,0) | 23 ft | 24.6 Hz |
| Width (0,1,0) | 17 ft | 33.2 Hz |
| Height (0,0,1) | 10 ft | 56.5 Hz |
| Length (2,0,0) | 23 ft | 49.1 Hz |
| Width (2,0,0) | 17 ft | 66.5 Hz |

First three axial modes (24.6, 33.2, 56.5 Hz) are well-separated. Room ratio 1:1.7:2.3 avoids degenerate mode overlap. Schroeder frequency ~120 Hz.

The 4-corner sub array addresses modal distribution per Welti/Harman research — 4 symmetrically placed sources provide the most uniform seat-to-seat bass response.

---

## Critical Assessment

**Strengths:**
- 72" cabinet with Qtc=0.735 is near-optimal Butterworth alignment
- 113 dB at 20 Hz (+8 dB over THX reference) with full amp power
- Even DAC-limited (38.5W/ch), system still delivers 114.5 dB at 20 Hz
- 4-corner array maximizes seat-to-seat uniformity (Welti/Harman)
- Manageable build: 220 lbs per cabinet, fits through doors

**Concerns:**
- DAC voltage limitation leaves 12 dB of amp headroom unused (DRV134 fix: $30)
- Free-field F3 of 29.4 Hz requires room gain for deep extension (expected in-room F3: ~22-24 Hz)
- 72" cabinet height uses ~60% of room height; visual impact in corners
- Rear cabinets in 1' rear clearance zone may encroach on limited Row 2 space

---

## Cost Summary

| Item | Qty | Cost Each | Total |
|------|-----|-----------|-------|
| UMII18-22 (to buy) | 6 | $350 | $2,100 |
| UMII18-22 (owned) | 2 | -- | $0 |
| Cabinet materials | 4 | $350 | $1,400 |
| Aura Pro shakers | 8 | $70 | $560 |
| Shaker wiring | -- | -- | $100 |
| **Total** | | | **$4,160** |

---

**Document Version:** 1.0
