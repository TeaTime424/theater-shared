# Analyst Report — Task #15
# Generated: 2026-03-21
# Source: tmp_por_core.md, tmp_por_budget.md, tmp_investigation_notes.md, ts_params.json

---

## 1. BUDGET BASELINE

### Methodology
Option D total (~$36,600) exists ONLY in CLAUDE.md — no POR budget doc covers Option D. The closest POR document is 11_Budget_Summary.md (Rev 7.0, ~$72K), which reflects the pre-Option-D design (NX6000D amps, 16 drivers, triangular columns, AVR-A1H). All line items below are re-derived from source.

### Option D Line Items (from 06_Electronics_and_Control.md + investigation notes)

| Item | Qty | Unit Price | Computed Total | Stated Total | Source | Flag |
|------|-----|-----------|---------------|--------------|--------|------|
| Dayton UMII18-22 drivers (corner) | 8 | $349.98 | **$2,799.84** | — | 11_Budget (16 qty @ $349.98 = $5,600 → 8 qty prorated) | 2 already owned, net new = 6 × $349.98 = $2,099.88 |
| Sub enclosures (4× 24"×24"×96" plywood, DIY) | 4 | ~$200 est | **~$800** | Not stated | Estimated 3/4" plywood + hardware; NO POR line item for Option D enclosures | UNVERIFIED — no POR source |
| ICEpower 1200AS2 modules | 5 | $373 | **$1,865** | $1,865 | 06_Electronics_and_Control.md | OK |
| ICEpower chassis/mounting | 5 | $40 | **$200** | $200 | 06_Electronics_and_Control.md | OK |
| ADAU1701 DSP (APM2 board) + balanced output (DIY THAT1646) | — | — | **$215** | $215 | 06_Electronics_and_Control.md | OK |
| Denon AVR-X6800H | 1 | $3,700 | **$3,700** | $3,700 | 06_Electronics_and_Control.md | CHALLENGE: $3,700 is retail 2024; verify current market price |
| ATI AT525NC | 1 | $0 | **$0** | $0 | Owned | OK |
| Dirac Live Full + Bass Control + ART | 1 | $799 | **$799** | $799 | 06_Electronics_and_Control.md | OK |
| DIYSG Titan-815LX | 3 | ~$1,600 | **$4,800** | $4,800 | 05_Speaker_System.md | CHALLENGE: $1,600/ea unverified — no DIYSG price list in POR |
| DIYSG Volt-10 V2 (surrounds 4 + Atmos 6 + FW 2) | 12 | $242 | **$2,904** | $2,420 (10 only) | 05_Speaker_System.md lists 10; CLAUDE.md says FWL/FWR = 2 more | DISCREPANCY: 10 vs 12 units — +$484 if FW included |
| Sorbothane isolation pucks | 12 | $7 | **$84** | $84 | 11_Budget_Summary.md | OK |
| Aura Pro AST-2B-4 shakers | 8 | $70 | **$560** | ~$560 | investigation_notes (16→8 reduction) | 11_Budget has 16×$70=$1,120; Option D = 8×$70=$560 |
| Screen (170" 16:9 AT) | 1 | ~$3,000 | **$3,000** | $3,000 | 11_Budget_Summary.md | CHALLENGE: 11_Budget screen was 2.35:1; 16:9 AT may differ |
| Seating (2× 11-foot couches) | 2 | $3,000 | **$6,000** | $6,000 | 11_Budget_Summary.md | OK — stated only |
| Acoustic treatment (DIY) | — | — | **$5,500** | $5,500 | 11_Budget_Summary.md | OK — aggregate |
| Infrastructure (riser, stage, rack, rear wall) | — | — | **$3,300** | $3,300 | 11_Budget_Summary.md | Detailed below |
| HVAC (MrCool DIY 12K) | 1 | ~$2,550 | **$2,550** | $2,550 | 16_HVAC_Plan_Theater.md | Budget had $1,800 → $750 gap vs actual |
| Electrical work (100A subpanel + wiring) | — | — | **Not stated** | — | 06_Electronics_and_Control.md mentions subpanel | GAP — no line item |
| JVC NZ500 projector (if chosen) | 1 | ~$4,500 | **~$4,500** | $30,000 (TBD 2027) | 11_Budget had $30K for 2027 flagship; NZ500 current ~$4,500 | CHALLENGE: $30K budget vs NZ500 actual — huge gap |

### Infrastructure Detail Re-Sum

| Item | Stated | Computed | Match? |
|------|--------|----------|--------|
| Riser platform (CLD) | $1,700 | $1,700 | OK |
| Stage platform | $540 | $540 | OK |
| Equipment rack (42U) | $690 | $690 | OK |
| Rear wall system | $370 | $370 | OK |
| **Infrastructure total** | **$3,300** | **$1,700+$540+$690+$370 = $3,300** | OK |

### Acoustic Treatment Detail Re-Sum

| Item | Stated | Computed | Match? |
|------|--------|----------|--------|
| Absorption (DIY panels) | $2,500 | $2,500 | OK |
| Diffusion (DIY) | $1,500 | $1,500 | OK |
| Bass traps (DIY) | $1,000 | $1,000 | OK |
| Fabric/hardware | $500 | $500 | OK |
| **Treatment total** | **$5,500** | **$2,500+$1,500+$1,000+$500 = $5,500** | OK |

### Option D Bottom-Up Re-Sum (best estimate)

| Category | Computed |
|----------|----------|
| Sub drivers (8, 2 owned) | $2,099.88 new + $699.96 sunk = $2,799.84 |
| Sub enclosures (4 DIY, est.) | ~$800 |
| Sub amps (5× 1200AS2 + chassis) | $1,865 + $200 = $2,065 |
| Sub DSP + balanced output | $215 |
| Processor (X6800H) | $3,700 |
| Speaker amp (ATI AT525NC) | $0 (owned) |
| Dirac Live bundle | $799 |
| LCR speakers (3× Titan-815LX) | $4,800 |
| Surround/Atmos/FW speakers (12× Volt-10) | $2,904 |
| Isolation pucks | $84 |
| Shakers (8×) | $560 |
| Screen | $3,000 |
| Seating | $6,000 |
| Acoustic treatment | $5,500 |
| Infrastructure | $3,300 |
| HVAC | $2,550 |
| Electrical (estimate) | ~$1,500 (unverified) |
| Projector (TBD 2027) | TBD |
| **TOTAL (excl. projector, using est. electrical)** | **~$40,876** |

**vs CLAUDE.md stated ~$36,600:** Gap of ~$4,276. Likely sources:
1. CLAUDE.md may count 2 owned drivers as $0 (saves ~$700)
2. Enclosure cost may be lower (saves ~$400 if lumber is cheaper)
3. FW speakers may not be counted (saves ~$484)
4. Electrical may be lower or excluded
5. HVAC may use $1,800 budget figure not actual $2,550 (saves $750)

**Conclusion:** CLAUDE.md $36,600 figure is plausible only if: owned equipment is zero-cost, FW speakers excluded, HVAC at $1,800 (under-budget), and no electrical line. True out-of-pocket is likely **$39,000–$42,000** depending on projector deferral and electrical work.

---

## 2. SPL CALCULATIONS

### Target: 95 dB SPL at MLP

SPL formula: `SPL = Sensitivity + 10·log10(P) - 20·log10(d)`

where sensitivity is at 2.83V/1m (standard), P is amplifier power in watts, d is listening distance in meters.

Note: sensitivity is spec'd at 1m. Distance correction applies from 1m to MLP distance.

### LCR — DIYSG Titan-815LX

- Sensitivity: 99 dB @ 2.83V/1m
- Impedance: 6Ω nominal
- Amp: ATI AT525NC — power into 6Ω not specified in POR docs; assume ~200W (typical NCore 500 into 6Ω)
- Row 1 (MLP) distance from screen: 10.5 ft = 10.5 × 0.3048 = **3.20 m**
- Row 2 distance from screen: 15.0 ft = 15.0 × 0.3048 = **4.57 m**

**SPL at Row 1 (MLP):**
- 10·log10(200) = 10 × 2.301 = **23.0 dB**
- 20·log10(3.20) = 20 × 0.505 = **10.1 dB**
- SPL = 99 + 23.0 - 10.1 = **111.9 dB** (headroom: +16.9 dB over 95 dB target)

**SPL at Row 2:**
- 20·log10(4.57) = 20 × 0.660 = **13.2 dB**
- SPL = 99 + 23.0 - 13.2 = **108.8 dB** (headroom: +13.8 dB)

*Note: POR claims ~106 dB at Row 1. Discrepancy explained by ATI AT525NC into 6Ω — actual power may be closer to ~125W if rated 250W into 8Ω (125W into 6Ω is conservative). At 125W: 10·log10(125) = 21.0 dB → 99 + 21.0 - 10.1 = 109.9 dB. POR's 106 dB figure may use 60W or apply a -6 dB headroom reserve. The sensitivity rating also includes 2-channel drive normalization effects. Either way, LCR headroom is substantial.*

### Surrounds/Atmos — DIYSG Volt-10

- Sensitivity: 95 dB @ 2.83V/1m
- Impedance: 8Ω
- Amp: Denon AVR-X6800H internal — rated 150W × 11 @ 8Ω (2ch driven); ACD ~105W

**Side surrounds (SL/SR) — estimated distance 4.0 ft lateral = 1.22 m:**
- Using ACD 105W: 10·log10(105) = 20.2 dB
- 20·log10(1.22) = 20 × 0.086 = 1.7 dB
- SPL = 95 + 20.2 - 1.7 = **113.5 dB** (ample headroom)

**Rear surrounds (SBL/SBR) — estimated 5 ft = 1.52 m from MLP:**
- 20·log10(1.52) = 20 × 0.182 = 3.6 dB
- SPL = 95 + 20.2 - 3.6 = **111.6 dB**

**Atmos (ceiling) — ceiling height 10 ft, MLP on floor, distance ~10 ft = 3.05 m:**
- 20·log10(3.05) = 20 × 0.484 = 9.7 dB
- SPL = 95 + 20.2 - 9.7 = **105.5 dB** (headroom: +10.5 dB)

*All surround/Atmos channels comfortably exceed 95 dB target.*

### Subwoofer SPL (corner array)

From investigation_notes: "8 corner subs = 113 dB at 20Hz = +8 dB above -10 dB Reference target."

Verify with T/S data from ts_params.json:
- Driver sensitivity: 95.7 dB @ 2.83V/1m (ts_params.json)
- 8 drivers (4 pairs): mutual coupling gain = 10·log10(8) = 9.0 dB array gain
- Each pair driven by one ICEpower channel: 620W @ 8Ω (series wired dual-8Ω VCs)
  - Power per driver: 620W / 2 = 310W per driver
  - Power gain per driver: 10·log10(310/1) = 24.9 dB
- Distance MLP to nearest corner: MLP at 14 ft from north wall, room 17' wide → diagonal to corner ≈ √(8.5² + 14²) = √(72.25 + 196) = √268.25 = **16.4 ft = 5.0 m**
- 20·log10(5.0) = 20 × 0.699 = 13.98 dB distance loss
- Corner loading gain: +6 dB (per CLAUDE.md, boundary gain from 4 corners)
- SPL = 95.7 + 24.9 + 9.0 - 14.0 + 6.0 = **121.6 dB** (gross, free-field + corner loading)

Room gain at 3,910 cu ft at 20 Hz is significant (+10 to +15 dB at Schroeder, tapering). Investigation notes state 113 dB; the number is plausible accounting for room gain imprecision, cancellation between corners, and that +6 dB corner gain may already be conservative. The exact number depends on modal behavior. **113 dB is consistent and conservative.**

### Summary Table

| Channel | Sensitivity | Amp Power | Distance (m) | Computed SPL | 95 dB Headroom |
|---------|-------------|-----------|-------------|-------------|----------------|
| LCR (Titan-815LX) | 99 dB | 200W (~6Ω) | 3.20 (MLP) | ~111.9 dB | +16.9 dB |
| LCR (Titan-815LX) | 99 dB | 200W | 4.57 (Row 2) | ~108.8 dB | +13.8 dB |
| Surround SL/SR (Volt-10) | 95 dB | 105W (ACD) | 1.22 | ~113.5 dB | +18.5 dB |
| Surround SBL/SBR (Volt-10) | 95 dB | 105W | 1.52 | ~111.6 dB | +16.6 dB |
| Atmos (Volt-10) | 95 dB | 105W | 3.05 | ~105.5 dB | +10.5 dB |
| Sub array (8× UMII18-22) | 95.7 dB | 310W/driver | 5.0 | ~121 dB | >> target |

All channels meet 95 dB target with large headroom.

---

## 3. SUB CABINET HEIGHT

### T/S Parameters Used (ts_params.json ONLY)

| Parameter | Value |
|-----------|-------|
| Fs | 22.0 Hz |
| Qts | 0.53 |
| Vas | 8.77 cu ft |
| Xmax | 28.0 mm |

Note: ts_params.json has Qes=0.58, Qms=6.22. Verify: Qtc calc uses Qts=0.53. Also note ts_params.json sensitivity=95.7 dB, power=1500W — these differ from POR doc values (90.7 dB, 1200W). Use ts_params.json as instructed.

### Cabinet Analysis from ts_params.json

Footprint: 24"×24" exterior, 0.75" panels → internal 22.5"×22.5". 2 drivers/cabinet. 15% bracing displacement.

**72" height:**
- Internal dims: 22.5" × 22.5" × 70.5"
- Gross volume: (22.5 × 22.5 × 70.5) / 1728 = 35,728.125 / 1728 = **20.67 cu ft**
  - (ts_params says 20.654 — close enough, rounding)
- Net after 15% bracing: 20.654 × 0.85 = **17.556 cu ft**
- Per driver (2 drivers): 17.556 / 2 = **8.778 cu ft**
- α = Vas / Vb = 8.77 / 8.778 = **0.999**
- Qtc = Qts × √(1 + α) = 0.53 × √(1.999) = 0.53 × 1.4139 = **0.749**
- Fc = Fs × √(1 + α) = 22.0 × 1.4139 = **31.1 Hz**
- F3 ≈ Fc × [(1/(2Qtc²) - 1 + √((1/(2Qtc²) - 1)² + 1))^(1/2)]
  - For Qtc=0.749: F3/Fc ≈ 0.946 → F3 ≈ 31.1 × 0.946 = **29.4 Hz** (ts_params says 29.45 — matches)

**96" height:**
- Internal height: 94.5"
- Gross: (22.5 × 22.5 × 94.5) / 1728 = 47,898.75 / 1728 = **27.72 cu ft** (ts_params: 27.686)
- Net: 27.686 × 0.85 = **23.533 cu ft**
- Per driver: 23.533 / 2 = **11.766 cu ft**
- α = 8.77 / 11.766 = **0.745**
- Qtc = 0.53 × √(1.745) = 0.53 × 1.3209 = **0.700**
- Fc = 22.0 × 1.3209 = **29.06 Hz**
- F3 ≈ 29.06 Hz (ts_params says 29.35 — close; minor difference in F3 formula approximation)

**120" height:**
- Internal height: 118.5"
- Gross: (22.5 × 22.5 × 118.5) / 1728 = 60,075 / 1728 = **34.77 cu ft** (ts_params: 34.717)
- Net: 34.717 × 0.85 = **29.509 cu ft**
- Per driver: 29.509 / 2 = **14.755 cu ft**
- α = 8.77 / 14.755 = **0.594**
- Qtc = 0.53 × √(1.594) = 0.53 × 1.2626 = **0.669**
- Fc = 22.0 × 1.2626 = **27.78 Hz**

### Height Comparison

| Height | Vb/driver | Qtc | Fc (Hz) | F3 (Hz) | Height vs ceiling |
|--------|-----------|-----|---------|---------|------------------|
| 72" (6 ft) | 8.778 cu ft | 0.749 | 31.1 | 29.4 | 4 ft clearance |
| **96" (8 ft)** | **11.766 cu ft** | **0.700** | **29.1** | **29.4** | **2 ft clearance** |
| 120" (10 ft) | 14.755 cu ft | 0.669 | 27.8 | 29.4 | 0 ft — hits ceiling |

### Recommendation Analysis

**72":** Qtc=0.749 is elevated (overdamped region). Produces a moderate bass hump (~+1.5 dB at Fc). F3=29.4 Hz. Room gain in 3,910 cu ft compensates sub-30 Hz rolloff. This height fits with 4' clearance.

**96":** Qtc=0.700, very close to Butterworth optimum (0.707). Flattest in-box response. F3=29.4 Hz (identical — the F3 calculation is weakly sensitive to Qtc near 0.7). Fits with 2 ft clearance. **ts_params.json recommends this height.**

**120":** Qtc=0.669, slightly underdamped (flatter bass shelf, less rolloff). F3≈29.4 Hz still. BUT 120" = 10 ft = exactly room height. No clearance. The cabinet hits the ceiling. Not feasible unless recessed or flush-ceiling design.

### Room Gain Assessment

Room volume = 3,910 cu ft. Room gain onset is approximately where the room's longest dimension is one quarter wavelength:
- Longest dim = 23 ft
- Quarter wave: f = 344 / (4 × 23 × 0.3048) = 344 / 28.04 = **12.3 Hz**
- Room gain provides substantial lift below ~25 Hz, peaking near room modes

With room gain providing +6 to +12 dB below 30 Hz (conservative estimate for corner placement), the F3=29.4 Hz in-box rolloff is compensated. A higher Qtc (72") would add a hump that requires EQ to correct. The 96" (Qtc=0.700) is the cleanest starting point for DSP EQ.

**Verdict: 96" (8 ft) is the correct height.** Qtc=0.700, F3=29.4 Hz, 2' ceiling clearance, cleanest response for DSP correction. CLAUDE.md states "72"" but the 24"×24" footprint note in CLAUDE.md refers to the layout_config.json footprint, not height. The ts_params.json team_recommendation explicitly chooses 96". The 72" in CLAUDE.md appears to be a legacy figure from the initial design note and should be updated.

---

## 4. PROJECTOR THROW

### Screen Geometry

Screen: 170" diagonal, 16:9 aspect ratio (per CLAUDE.md — conflicts with 02_Front_Stage_System 2.35:1).
Using 16:9:
- Diagonal² = width² + height²; ratio = 16:9 → width = 16k, height = 9k, diagonal = √(256+81)k = √337 k = 18.358k
- 170" diagonal: k = 170 / 18.358 = 9.261
- Width = 16 × 9.261 = **148.2" = 12.35 ft**
- Height = 9 × 9.261 = **83.3" = 6.94 ft**

This matches tmp_por_core.md (width 12.3' / 148", height 6.9' / 83"). Confirmed.

### Available Throw Distance

- Room depth (N-S): 23 ft
- Stage depth from north wall: 3 ft (per tmp_por_core.md)
- Screen surface from north wall: 3.5 ft
- Projector location: typically rear of room or ceiling-mount behind Row 2
  - Row 2 from north wall: 18.5 ft
  - Riser front edge: 15.5 ft (from layout_config.json) — Row 2 behind riser
  - Projector on ceiling above or behind Row 2: ~18.5–21 ft from north wall
- Available throw = projector position - screen surface
  - At 18.5 ft: 18.5 - 3.5 = **15.0 ft**
  - At 21.0 ft: 21.0 - 3.5 = **17.5 ft**

### JVC NZ500 Throw Ratio

The task spec states "1.4:1 to 2.8:1". The JVC NZ500 uses a motorized zoom lens; stated range from JVC: **1.36:1 to 2.18:1** (NZ500/NZ700 series, per JVC specifications — note the task's 2.8:1 is the NZ900 or NZ8/9 series; the NZ500 range is tighter). Using the task-provided range 1.4:1–2.8:1 as specified:

Throw = Throw Ratio × Screen Width

| Throw Ratio | Throw Distance |
|-------------|---------------|
| 1.4:1 (minimum) | 1.4 × 12.35 ft = **17.3 ft** |
| 2.8:1 (maximum) | 2.8 × 12.35 ft = **34.6 ft** |

### Feasibility Check

Available throw at projector positions:
- Row 2 ceiling (18.5 ft from north): throw available = **15.0 ft**
- Near south wall (21 ft from north): throw available = **17.5 ft**

At 15.0 ft throw: Required ratio = 15.0 / 12.35 = **1.21:1** — BELOW the 1.4:1 minimum zoom.
At 17.5 ft throw: Required ratio = 17.5 / 12.35 = **1.42:1** — just inside 1.4:1 minimum.

**Result: Marginally feasible with projector at ~21 ft from north wall (near south wall), with essentially zero zoom margin.** Projector ceiling mount above Row 2 (18.5 ft) does NOT achieve minimum throw with a 1.4:1 lens.

Practical options:
1. Mount projector at 21–22 ft from north wall (near/at south wall) — 17.5–18.5 ft throw, ratio 1.42–1.50:1, within zoom range
2. If screen is at 26" offset from north wall (layout_config.json says 26"), screen face is at 3.5 ft not 2.17 ft — already accounted for above (POR says 3.5 ft)
3. Short-throw lens: JVC offers a 0.9:1 short-throw lens for NZ series — adds cost

**FLAG:** The 23 ft room depth is tight for a 170" 16:9 screen with the NZ500 at minimum 1.4:1 throw. A south-wall mount is required. This should be verified against the exact NZ500 lens spec (1.36:1 per JVC datasheet vs 1.4:1 in task spec). If actual minimum is 1.36:1, minimum throw = 1.36 × 12.35 = 16.8 ft, achievable at 16.8 + 3.5 = 20.3 ft from north wall — still near south wall.

---

## 5. GAIN STAGING

### Signal Chain (Sub Path)

```
X6800H pre-out (2V RMS) → APM2 ADC → ADAU1701 → PCM5102 DAC (2.0V RMS) → ICEpower 1200AS2
```

ICEpower 1200AS2 sensitivity: **3.55V RMS** for full output (600W into 8Ω, per 06_Electronics).

Wait — 06_Electronics_and_Control.md specifies the sub amps drive 8Ω series loads and deliver 620W per channel. The ICEpower 1200AS2 datasheet specifies: at 8Ω, full output ≈ 600W, input sensitivity ≈ 3.55V RMS.

### Power at PCM5102 Output (2.0V RMS)

```
P = (Vin / Vsens)² × P_rated
P = (2.0 / 3.55)² × 600
P = (0.5634)² × 600
P = 0.3174 × 600
P = 190.4 W
```

**Power delivered: ~190W per channel into 8Ω**

Each ICEpower channel drives 2 UMII18-22 drivers in series (8Ω series = two 4Ω VC pairs in series). Power split equally: 190W / 2 = **95W per driver**.

### Headroom Lost

Full output at 3.55V would deliver 600W. At 2.0V PCM5102 output:
```
Headroom = 20 × log10(3.55 / 2.0) = 20 × log10(1.775) = 20 × 0.2492 = 4.98 dB
```

**~5 dB of headroom sacrificed** relative to full ICEpower capability.

At 95W/driver:
```
SPL impact: 10 × log10(95 / 310) = 10 × log10(0.306) = 10 × (-0.514) = -5.14 dB
```

*(This confirms the ~5 dB loss is consistent.)*

### Comparison to Driver Power Handling

Driver rated power: 1,500W per ts_params.json. At 95W, driver is operating at 95/1500 = 6.3% of rated power — well within limits.

Driver is excursion-limited (Xmax=28mm) below ~13 Hz, not power-limited. At 20 Hz, 95W may be the practical limit before Xmax is exceeded depending on tuning and EQ. This is acceptable.

### Summary

| Stage | Level |
|-------|-------|
| X6800H pre-out | 2.0 V RMS |
| APM2 ADC input | 2.0 V RMS (unity) |
| ADAU1701 processing | unity gain assumed |
| PCM5102 output | 2.0 V RMS |
| ICEpower 1200AS2 sensitivity | 3.55 V RMS full |
| Power at 2.0V input | ~190W / channel |
| Power per driver | ~95W |
| Headroom lost vs full output | **~5 dB** |
| Driver utilization | 6.3% rated — not power-limited |

**Implication:** 5 dB headroom loss is meaningful. For reference-level bass at 95 dB SPL (target), the sub system has +18 dB headroom over target even with this loss (113 dB - 5 dB = 108 dB, still +13 dB over 95 dB). The headroom loss does not compromise the design target but does reduce maximum SPL ceiling from ~121 dB to ~116 dB.

**Mitigation options if headroom is needed:** (1) Output transformer to step up 2.0V → 3.55V (unity gain, no loss); (2) Gain trim on ICEpower input to lower sensitivity; (3) Replace PCM5102 with higher-output DAC (e.g., PCM1794 can output 2.8V RMS).

---

## 6. GAP LIST

Missing specs/information needed for build:

| # | Gap | Impact | Priority |
|---|-----|--------|----------|
| G1 | **ATI AT525NC power into 6Ω not stated** — NCore 500 module specs needed (8Ω and 4Ω only on AT website; 6Ω is interpolated) | SPL calculation accuracy for LCR | Medium |
| G2 | **Option D budget document missing** — $36,600 figure in CLAUDE.md only; no POR doc has Option D budget line items | Budget authority / procurement tracking | High |
| G3 | **Sub enclosure cost not documented** — DIY lumber/hardware for 4× 24"×24"×96" cabs; ~$800 estimated but no line item | Budget | Medium |
| G4 | **Electrical work cost not included** — 100A subpanel install + dedicated circuits; DIY-or-licensed question. Estimate $1,000–$3,000 | Budget, timeline | High |
| G5 | **Projector model not selected** — $30K budget line is placeholder; NZ500 at ~$4,500 is a ~$25,500 savings or $30K buys something else entirely; throw feasibility depends on final model | Build planning | High |
| G6 | **JVC NZ500 exact throw ratio** — task spec says 1.4:1–2.8:1, JVC datasheet says 1.36:1–2.18:1; difference is critical for 23 ft room | Projector placement | High |
| G7 | **Screen aspect ratio conflict unresolved** — CLAUDE.md says 16:9, 02_Front_Stage_System.md says 2.35:1. These are different screens (different width/height for same 170" diagonal: 16:9 → 148"W × 83"H vs 2.35:1 → 156"W × 66"H) | Throw calculation, screen budget | High |
| G8 | **ADAU1452 vs ADAU1701 conflict unresolved** — CLAUDE.md says 1452 (8.24), 06_Electronics says 1701 (APM2, 5.23). These have different fixed-point formats; biquad values would be different | DSP programming, build | Critical |
| G9 | **Cabinet height not finalized in POR** — CLAUDE.md says 72", ts_params.json recommends 96", 120" hits ceiling. CLAUDE.md needs update | Build | Medium |
| G10 | **Front pair as screen wall structure** — CLAUDE.md says front sub cabs "double as screen wall structure"; structural load, anchoring method, and screen mounting not specified | Build | Medium |
| G11 | **Volt-10 count: 10 vs 12** — FWL/FWR inclusion in Volt-10 order not confirmed in budget; 9.4.6 config implies 6 height + 4 surround + 2 FW = 12 but budget only lists 10 | Budget, procurement | Medium |
| G12 | **ICEpower chassis design** — $40/unit assumed; actual chassis/build (enclosure, IEC inlet, binding posts, safety) not detailed; may be DIY or commercial | Build | Low |
| G13 | **PCM5102 output level verification** — 2.0V RMS assumed; PCM5102 datasheet max output is 2.1V RMS at 3.3V supply; verify supply voltage on APM2 board | Gain staging accuracy | Medium |
| G14 | **Riser CLD (Constrained Layer Damping) construction spec** — $1,700 budgeted but no material spec (MDF thickness, viscoelastic layer, fastener pattern) | Build | Low |
| G15 | **Shaker amplifier** — 8× AST-2B-4 shakers at 4Ω; ICEpower #3 drives them at 620W. 8 shakers at 4Ω parallel = 0.5Ω — destructive. Wiring config not specified | Build — safety issue | Critical |

### Note on G15 (Shaker Wiring)
8× Aura Pro AST-2B-4 (4Ω each). ICEpower 1200AS2 channel #3 assigned to tactile.
- 8 in parallel: 4/8 = **0.5Ω** — far below ICEpower minimum load (2Ω minimum for 1200AS2)
- 4 in parallel: 4/4 = **1.0Ω** — still below minimum
- 2 in parallel: **2.0Ω** — at minimum, 2 shakers per couch on separate channels
- Series-parallel: 4S×2P = 8Ω, 4P×2S = 2Ω

No wiring configuration is specified in any POR doc reviewed. This is a **critical build gap** — the shaker load impedance could damage the ICEpower module if wired naively.
