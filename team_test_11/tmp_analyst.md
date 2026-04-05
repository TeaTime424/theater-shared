# Analyst Report — Option D Home Theater
Generated: 2026-03-21 | Source docs: tmp_por_core.md, tmp_por_budget.md, tmp_investigation_notes.md, ts_params.json

---

## 1. BUDGET BASELINE

### 1a. LF System — Re-Sum

Source: tmp_por_budget.md (citing 11_Budget_Summary.md Rev 7.0)

| Item | Qty | Unit $ | Stated Total | Computed Total | Flag |
|------|-----|--------|-------------|----------------|------|
| UMII18-22 drivers | 16 | $349.98 | $5,600 | 16 × 349.98 = **$5,599.68** | Rounding — negligible |
| Triangular enclosures | 8 | $122.00 | $978 | 8 × 122 = **$976** | **$2 DISCREPANCY** |
| Front nearfield riser | 1 | — | $450 | $450 | OK (lump estimate) |
| Rear nearfield console | 1 | — | $550 | $550 | OK (lump estimate) |
| NX6000D amplifiers | 6 | $519.00 | $3,114 | 6 × 519 = **$3,114** | OK |
| Noctua NF-R8 fan mod | 12 | $15.00 | $180 | 12 × 15 = **$180** | OK |
| Aura Pro AST-2B-4 shakers | 16 | $70.00 | $1,120 | 16 × 70 = **$1,120** | OK |
| Wiring | — | — | $335 | $335 | OK (lump estimate) |
| **Stated LF TOTAL** | | | **$12,327** | | |
| **Computed LF TOTAL** | | | | **$12,324.68** | **$2.32 discrepancy** |

Verdict: The $2 difference on enclosures (8 × $122 = $976, not $978) and driver rounding create a $2.32 gap. Functionally irrelevant. More important: this entire LF budget is STALE — it reflects 16 drivers + NX6000D + 12 fan mods + triangular enclosures, none of which match Option D.

**COST CHALLENGE — LF line items over $500:**
- **UMII18-22 $5,600 (16 drivers):** Option D uses 8 corner drivers only (nearfield deferred). Cost at 8 drivers: 8 × $349.98 = **$2,799.84**. Two owned ($700 sunk). Net new: 6 × $349.98 = **$2,099.88**. Savings vs stated total: ~$3,500. Shipping: Parts Express typically ~$0 free shipping threshold — verify at checkout.
- **NX6000D $3,114:** Superseded by ICEpower 1200AS2. Option D budget shows $2,065 for 5× ICEpower + chassis. Savings: $1,049. Is $2,065 sourced? Investigation notes: 5 modules at ~$373 each = $1,865 + chassis (~$200 estimated). Chassis price NOT verified from a specific source — [UNVERIFIED].

### 1b. Electronics — Option D Re-Sum

Source: tmp_por_budget.md (citing 06_Electronics_and_Control.md)

| Item | Stated Cost | Notes | Challenge |
|------|-------------|-------|-----------|
| Denon AVR-X6800H | $3,700 | Replaces AVR-A1H ($6,500) | Street price ~$3,400-3,700 — top of range used. Shipping: most retailers free. Reasonable. |
| ATI AT525NC | $0 | Owned | OK — already owned |
| Dirac Live bundle | $799 | Full + Bass Control + ART | Dirac pricing: Full $199 + Bass Control $99 + ART $99 = $397 direct from Dirac. $799 is 2× actual. **PRICE FLAG — verify bundle pricing.** |
| ICEpower 1200AS2 ×5 + chassis | $2,065 | 5 modules | 5 × $373 = $1,865 modules. $200 chassis. Sourcing for $373/unit — investigation notes state this but sourcing chain not cited. **[UNVERIFIED] per-unit price.** |
| ADAU1701 DSP + balanced output | $215 | Replaces DSP-408 | APM2 board ~$60-80 + PCM5102 DAC ~$15-20 + 898B balanced output module ~$100-120 = ~$175-220. $215 plausible. |
| **Option D Electronics TOTAL** | **$6,779** | | |

Computed check: 3,700 + 0 + 799 + 2,065 + 215 = **$6,779**. Stated total matches.

**COST CHALLENGE — Dirac:** If bundle is actually $397 (vs $799 stated), savings = $402. Needs verification.

### 1c. Grand Total — Category-Level Re-Sum

Source: tmp_por_budget.md (11_Budget_Summary.md "Mid" column)

| Category | Stated Mid | Computed | Flag |
|----------|-----------|----------|------|
| Projector | $30,000 | $30,000 | Lump — no line items to verify |
| LF System | $12,327 | $12,324.68 | $2.32 off (stale anyway) |
| Speakers (LCR/Surr/Atmos) | $7,304 | Not itemized in source docs | Cannot verify — no line items provided |
| Electronics | $7,549 | $7,549 (Rev 7.0) / $6,779 (Option D) | Rev 7.0 budget not updated to Option D |
| Seating | $6,000 | $6,000 | Lump estimate |
| Acoustic Treatment | $5,500 | $5,500 | Lump estimate |
| Screen | $3,000 | $3,000 | Lump estimate |
| Infrastructure | $3,300 | $3,300 | Lump estimate |
| **TOTAL** | **~$72,000** | | |

Re-sum: 30,000 + 12,327 + 7,304 + 7,549 + 6,000 + 5,500 + 3,000 + 3,300 = **$74,980**
Stated total is "~$72,000". Computed: $74,980. **$2,980 DISCREPANCY** — stated total understates by ~$3K.

Note: HVAC explicitly excluded from $72K total. MrCool DIY at $2,550–2,650 is additive. Task brief's $1,359 figure does not appear anywhere in source docs — that value is wrong. Unit package alone is ~$2,359.

**Option D adjustments not yet reflected in grand total:**
- Electronics: $7,549 → $6,779 (saves $770)
- LF: $12,327 → needs full Option D recount (8 drivers + ICEpower + rect enclosures)
- Grand total after these adjustments would decrease, but insufficient line items in source docs to recompute full Option D LF cost.

---

## 2. SPL CALCULATIONS

### Formula
SPL at MLP = sensitivity + 10·log10(power) - 20·log10(distance_ft × 0.3048)

Note: sensitivity is rated at 1m. Distance in meters = distance_ft × 0.3048.

### 2a. LCR — Titan-815LX + ATI AT525NC

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 99 dB / 2.83V / 1m | tmp_por_core.md |
| Load | 6Ω nominal (4.2Ω min) | tmp_por_core.md |
| ATI AT525NC power @ 6Ω | ~300W | tmp_por_core.md |
| Distance to MLP (Row 1) | ~12 ft = 3.66 m | Seating geometry: screen at north wall, Row 1 at ~10.5' from screen; center channel ~2' setback = ~12.5' total. Using 12 ft. |

Sensitivity correction for 2.83V into 6Ω vs 1W/1m:
- 2.83V into 6Ω = 2.83²/6 = 8.0089/6 = 1.335W
- Sensitivity at 1W = 99 - 10·log10(1.335) = 99 - 1.25 = **97.75 dB/W/m** (1W into 6Ω)

SPL at MLP (300W, 12 ft):
- 20·log10(3.66) = 20 × 0.5635 = **11.27 dB**
- SPL = 97.75 + 10·log10(300) - 11.27
- 10·log10(300) = 10 × 2.4771 = **24.77 dB**
- SPL = 97.75 + 24.77 - 11.27 = **111.25 dB**

Headroom above 95 dB target: 111.25 - 95 = **+16.25 dB**

### 2b. Front Wide — Volt-10 + ATI AT525NC

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 95 dB / 2.83V / 1m | tmp_por_core.md |
| Load | 8Ω | tmp_por_core.md |
| ATI AT525NC power @ 8Ω | ~200W | tmp_por_core.md |
| Distance to MLP | ~10 ft = 3.05 m | Front wide at ~midpoint between screen and Row 1 |

Sensitivity at 1W/8Ω: 2.83V into 8Ω = 2.83²/8 = 8.0089/8 = 1.001W ≈ 1W → sensitivity = **95 dB/W/m** (no correction needed)

SPL at MLP (200W, 10 ft):
- 20·log10(3.05) = 20 × 0.4843 = **9.69 dB**
- 10·log10(200) = 10 × 2.3010 = **23.01 dB**
- SPL = 95 + 23.01 - 9.69 = **108.32 dB**

Headroom above 95 dB target: 108.32 - 95 = **+13.32 dB**

### 2c. Surrounds/Atmos — Volt-10 + X6800H internal

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 95 dB / 2.83V / 1m | tmp_por_core.md |
| Load | 8Ω | tmp_por_core.md |
| X6800H power @ 8Ω | 140W (2ch driven); ~100W all-ch | tmp_por_core.md |
| Distance to MLP (surrounds) | ~9 ft = 2.74 m | Side surrounds at row1/MLP position |
| Distance to MLP (Atmos) | ~10 ft = 3.05 m | Ceiling channels; 10 ft ceiling height adds slant |

**Surrounds (9 ft, 140W 2ch driven):**
- 20·log10(2.74) = 20 × 0.4378 = **8.76 dB**
- 10·log10(140) = 10 × 2.1461 = **21.46 dB**
- SPL = 95 + 21.46 - 8.76 = **107.70 dB**
- Headroom: +12.70 dB

**Surrounds conservative (9 ft, 100W all-ch driven):**
- 10·log10(100) = **20.00 dB**
- SPL = 95 + 20.00 - 8.76 = **106.24 dB**
- Headroom: +11.24 dB

**Atmos (10 ft, 100W all-ch driven):**
- 20·log10(3.05) = **9.69 dB**
- SPL = 95 + 20.00 - 9.69 = **105.31 dB**
- Headroom: +10.31 dB

### SPL Summary Table

| Channel | Sensitivity (1W/m) | Power (W) | Distance (ft/m) | SPL @ MLP (dB) | Headroom vs 95 dB |
|---------|-------------------|-----------|-----------------|----------------|-------------------|
| LCR (Titan-815LX) | 97.75 dB/W/m | 300W @ 6Ω | 12 ft / 3.66 m | 111.3 dB | **+16.3 dB** |
| Front Wide (Volt-10) | 95.0 dB/W/m | 200W @ 8Ω | 10 ft / 3.05 m | 108.3 dB | **+13.3 dB** |
| Surrounds (Volt-10) | 95.0 dB/W/m | 140W @ 8Ω | 9 ft / 2.74 m | 107.7 dB | **+12.7 dB** |
| Surrounds (all-ch) | 95.0 dB/W/m | 100W @ 8Ω | 9 ft / 2.74 m | 106.2 dB | **+11.2 dB** |
| Atmos (all-ch) | 95.0 dB/W/m | 100W @ 8Ω | 10 ft / 3.05 m | 105.3 dB | **+10.3 dB** |

All channels clear 95 dB target by >10 dB. Atmos at all-channel drive is the tightest headroom at +10.3 dB — still well above target.

---

## 3. SUB CABINET HEIGHT ASSESSMENT

T/S parameters used: Qts=0.53, Vas=8.77 cuft, Fs=22 Hz (from ts_params.json — Dayton datasheet values).

### 3a. Verify Fc/Qtc/F3 for 72" Cabinet

From ts_params.json height_72in:
- w_net = 24 - 1.5 = 22.5 in; d_net = 22.5 in
- h_per_driver = 72/2 - 0.75 = 35.25 in
- gross = 22.5 × 22.5 × 35.25 = 506.25 × 35.25 = **17,845.3 in³**
- gross_ft³ = 17,845.3 / 1728 = **10.327 ft³**
- net_ft³ = 10.327 × 0.85 = **8.778 ft³** = Vb

Verify alpha: Vas / Vb = 8.77 / 8.778 = **0.9991** ✓ (ts_params says 0.99908)
Verify Qtc: 0.53 × sqrt(0.9991 + 1) = 0.53 × sqrt(1.9991) = 0.53 × 1.4139 = **0.7494** ✓ (ts_params says 0.74936)
Verify Fc: 22 × 1.4139 = **31.11 Hz** ✓ (ts_params says 31.105)

F3 verification:
- x = 1/Qtc² - 2 = 1/0.7494² - 2 = 1/0.56160 - 2 = 1.7808 - 2 = **-0.2192**
- x² + 4 = 0.04804 + 4 = 4.0480; sqrt(4.0480) = **2.0120**
- numerator = (-0.2192 + 2.0120) / 2 = 1.7928 / 2 = **0.8964**
- F3_mult = sqrt(0.8964) = **0.9468**
- F3 = 31.11 × 0.9468 = **29.45 Hz** ✓ (ts_params says 29.45)

All ts_params.json values for 72" cabinet verified.

### 3b. Verify 96" Cabinet

From ts_params.json height_96in:
- h_per_driver = 96/2 - 0.75 = 47.25 in
- gross = 22.5 × 22.5 × 47.25 = 506.25 × 47.25 = **23,920.3 in³**
- gross_ft³ = 23,920.3 / 1728 = **13.843 ft³**
- net_ft³ = 13.843 × 0.85 = **11.766 ft³**

alpha = 8.77 / 11.766 = **0.7454** ✓
Qtc = 0.53 × sqrt(1.7454) = 0.53 × 1.3211 = **0.7002** ✓ (ts_params says 0.700)
Fc = 22 × 1.3211 = **29.06 Hz** ✓

F3 verification:
- x = 1/0.7002² - 2 = 1/0.4903 - 2 = 2.0396 - 2 = **0.0396**
- x² + 4 = 0.001568 + 4 = 4.001568; sqrt = **2.000392**
- numerator = (0.0396 + 2.000392) / 2 = **1.020**
- F3_mult = sqrt(1.020) = **1.0100**
- F3 = 29.06 × 1.010 = **29.35 Hz** ✓

All 96" values verified.

### 3c. Height Comparison Table

| Height | Vb (ft³) | alpha | Qtc | Fc (Hz) | F3 (Hz) | Assessment |
|--------|----------|-------|-----|---------|---------|-----------|
| 72" | 8.778 | 0.999 | **0.749** | 31.1 | 29.45 | Near-maximally-flat, acceptable |
| 96" | 11.766 | 0.745 | **0.700** | 29.1 | 29.35 | Butterworth optimum — textbook flat |
| 120" | 14.755 | 0.594 | **0.669** | 27.8 | 29.44 | Overdamped; potential mid-bass sag |

All three heights produce F3 ≈ 29.4 Hz — F3 is insensitive to Qtc near the 0.7 optimum.

**BASS HEAD ADVISORY — Best height:**

The 96" cabinet (Qtc=0.700, Butterworth) is the analytical optimum for sealed alignment. It provides the flattest response before room gain takes over below ~30 Hz.

Room gain estimate for 3,910 ft³: Room gain onset ~80 Hz, +6 dB/octave below room modal frequency. At 20 Hz, rule-of-thumb room gain ≈ +10 to +12 dB in a well-sealed room of this size. This means the F3 = 29.4 Hz free-air becomes effectively well below 20 Hz in-room — all three heights are acoustically equivalent once room gain is included.

Practical constraint: 96" = 8 ft cabinet height. Room is 10 ft. Viable. 120" = 10 ft — full ceiling height, clearance issues. **96" is preferred.**

72" is the lowest-risk build (shorter, easier to handle) and acoustically near-identical in-room. If construction complexity is a concern, 72" is acceptable with Qtc=0.749.

---

## 4. PROJECTOR THROW VERIFICATION

### Parameters

| Parameter | Value | Source/Method |
|-----------|-------|--------------|
| Room depth | 23 ft | tmp_por_core.md Option D |
| Stage depth (sub + screen) | 26" = 2.17 ft | layout_config: sub 24" + screen 2" |
| Available throw | 23.0 - 2.17 = **20.83 ft** | Room depth minus stage |
| Screen diagonal | 170" | tmp_por_core.md |

### Screen Width by Aspect Ratio

**16:9 (CLAUDE.md / layout_config):**
- Width = 170 × (16/√(16²+9²)) = 170 × (16/18.358) = 170 × 0.8715 = **148.2"** = **12.35 ft**
- Height = 170 × (9/18.358) = 170 × 0.4902 = **83.3"**

**2.35:1 (02_Front_Stage_System.md / 14_Quick_Reference.md):**
- Width = 170 × (2.35/√(2.35²+1²)) = 170 × (2.35/2.553) = 170 × 0.9205 = **156.5"** = **13.04 ft**
- Height = 170 × (1/2.553) = 170 × 0.3917 = **66.6"**

### Throw Ratio

| Aspect | Screen Width | Available Throw | Throw Ratio | JVC NZ500 Range (1.4–2.8) | Verdict |
|--------|-------------|-----------------|-------------|--------------------------|---------|
| 16:9 | 12.35 ft | 20.83 ft | 20.83/12.35 = **1.686** | 1.4–2.8 | FITS (mid-range) |
| 2.35:1 | 13.04 ft | 20.83 ft | 20.83/13.04 = **1.597** | 1.4–2.8 | FITS (lower-mid) |

Both aspect ratios are compatible with the JVC NZ500 throw range at the available 20.83 ft throw distance.

**Screen height check — 16:9:**
- Screen bottom at 51" (4.25 ft) per 02_Front_Stage_System.md
- Screen top = 51" + 83.3" = **134.3"** = 11.2 ft — exceeds 10 ft ceiling. **FLAG: 16:9 at 170" does not fit in 10 ft ceiling.**

**Screen height check — 2.35:1:**
- Screen bottom at 51"
- Screen top = 51" + 66.6" = **117.6"** = 9.8 ft — fits within 10 ft ceiling with ~2.4" clearance.

Critical finding: **170" 16:9 is physically impossible in a 10 ft ceiling.** Screen top would be at 11.2 ft. The 2.35:1 aspect ratio at 170" diagonal fits (just barely). Either the aspect ratio is 2.35:1 (not 16:9), or the diagonal must be reduced. At 16:9, the maximum diagonal for a 10 ft ceiling with 51" bottom = (120" - 51") / 0.4902 × 1.0 = 69" / 0.4902 = **140.8" max diagonal**.

This is a significant design conflict requiring resolution before screen purchase.

---

## 5. GAIN STAGING

### Signal Chain
```
X6800H sub pre-out (2V RMS)
  → APM2 ADC (full-scale 2V RMS — no clipping)
  → ADAU1701 DSP (5.23 fixed-point)
  → I2S → PCM5102 DAC (output 2.0V RMS)
  → ICEpower 1200AS2 (sensitivity: 3.55V for rated power)
```

### Power Delivered at 2.0V Input

ICEpower 1200AS2 sensitivity: 3.55V RMS for rated output.

Rated power: The ts_params investigation notes say "620W/ch @ 8Ω." Using P_rated = 620W @ 8Ω.

P = (V_in / V_sensitivity)² × P_rated
P = (2.0 / 3.55)² × 620
P = (0.5634)² × 620
P = 0.31742 × 620
P = **196.8W**

Headroom lost vs rated: 10·log10(620/196.8) = 10·log10(3.151) = 10 × 0.4985 = **4.98 dB ≈ 5.0 dB**

Task brief states 10·log10(600/190.5) = 5.0 dB — uses P_rated = 600W. At 620W: 4.98 dB. Difference is <0.1 dB; either value rounds to 5.0 dB.

### Gain Staging Summary Table

| Stage | In (V RMS) | Out (V RMS) | Gain (dB) | Notes |
|-------|-----------|------------|-----------|-------|
| X6800H pre-out | — | 2.0 | — | Stated spec |
| APM2 ADC | 2.0 | — | 0 | Full-scale 2V, no clipping |
| ADAU1701 DSP | — | — | 0 dB nominal | Unity pass-through before EQ |
| PCM5102 DAC | — | 2.0 | — | Output spec |
| ICEpower 1200AS2 | 2.0 | — | — | Sensitivity = 3.55V for rated |
| Power delivered | — | — | — | **196.8W** (vs 620W rated) |
| Headroom lost | — | — | **-5.0 dB** | Below rated power |

With 196.8W into 8Ω + sub sensitivity of 95.7 dB/2.83V/1m (ts_params.json):

Sub sensitivity at 1W/m: 2.83V into 8Ω = 2.83²/8 = 1.001W ≈ 1W, so **95.7 dB/W/m**

SPL at MLP from corner subs (8 drivers, boundary gain):
- Single driver at 1m: 95.7 + 10·log10(196.8) = 95.7 + 22.94 = **118.6 dB**
- 8 drivers summing: +10·log10(8) = +9.03 dB → **127.6 dB raw (anechoic, 1m)**
- At MLP (~12 ft = 3.66m): -20·log10(3.66) = -11.3 dB → **116.3 dB**
- Corner loading (+11 dB boundary gain): **127.3 dB**

This far exceeds any reasonable target. The gain chain is not a headroom problem for subs; the 5 dB loss vs rated is fully acceptable.

**APM2 internal DAC limitation noted:** APM2 internal DAC outputs 0.9V RMS — too low to drive ICEpower to adequate level. PCM5102 external DAC at 2.0V RMS is the correct path (confirmed in signal chain above).

---

## 6. GAP LIST

| # | Gap | Impact | Action Required |
|---|-----|--------|----------------|
| G1 | **Screen aspect ratio unresolved** (16:9 vs 2.35:1) | CRITICAL — 170" 16:9 does not fit in 10 ft ceiling (top at 11.2 ft). 2.35:1 fits (9.8 ft top). | Resolve before screen purchase. If 16:9 desired, max diagonal ≈ 141". |
| G2 | **Projector model not specified** | HIGH — budget shows $30K lump; no model, throw ratio, or lens confirmed | JVC NZ500 assumed for throw calc. Confirm model by 2026. |
| G3 | **Corner sub cabinet footprint unresolved** (20"×20" vs 24"×24") | HIGH — Qtc/Fc calcs in ts_params use 24"×24". At 20"×20": Vb changes materially | Confirm footprint. At 20"×20": net_in = 18.5", Vb per driver at 72" = (18.5×18.5×35.25)/1728×0.85 = 12,070/1728×0.85 = 5.94 ft³. alpha = 8.77/5.94 = 1.476. Qtc = 0.53×sqrt(2.476) = 0.53×1.573 = 0.834. Significantly higher Qtc. Need confirmed footprint. |
| G4 | **Dirac Live bundle price** | MEDIUM — $799 stated, ~$397 actual direct pricing | Verify current Dirac pricing before electronics budget is finalized. Potential $402 savings. |
| G5 | **ICEpower 1200AS2 per-unit price** | MEDIUM — $373/unit assumed in investigation notes; no purchase source cited | Verify current price (Parts Express, ICEpower direct, or eBay bulk). |
| G6 | **Speakers budget ($7,304) — no line items** | MEDIUM — cannot verify; no itemization in source docs | Itemize: 3× Titan-815LX + 10× Volt-10 + drivers/flat-packs. DIYSG prices needed. |
| G7 | **ATI AT525NC confirmed as owned** | LOW — listed as $0 / owned | Confirm unit is in hand and functional for 6Ω LCR load. |
| G8 | **ICEpower 1200AS2 chassis/rack design** | LOW — $200 estimated, no spec | Needs rack enclosure in equipment closet. 5 modules. Confirm chassis cost and ventilation plan (fanless modules still need enclosure airflow). |
| G9 | **Equipment closet size** (4'×4' vs 4'×6') | LOW — affects rack layout | Confirm from construction drawings. 4'×4' is tighter for 5× ICEpower + patch panel. |
| G10 | **Nearfield sub space reservation** | LOW — deferred but space must be reserved | Row 1 stage design must leave 12.5" depth behind Row 1 for future install. |

---

## FLAGS SUMMARY

| Flag | Severity | Description |
|------|----------|-------------|
| **F1** | CRITICAL | 170" 16:9 exceeds 10 ft ceiling by 14". Screen aspect ratio must be confirmed as 2.35:1 or diagonal reduced. |
| **F2** | HIGH | LF budget ($12,327) is entirely stale — reflects 16 drivers + NX6000D + fan mods + triangular cabs. Option D LF budget not computed in any source doc. |
| **F3** | HIGH | Grand total re-sum: $30K+$12,327+$7,304+$7,549+$6K+$5.5K+$3K+$3.3K = $74,980 vs stated ~$72K. $2,980 gap. |
| **F4** | HIGH | 20"×20" vs 24"×24" cabinet footprint changes Qtc from 0.749 to 0.834 at 72" height. All ts_params calcs assume 24"×24". |
| **F5** | MEDIUM | Dirac Live bundle stated at $799; direct pricing ~$397. $402 potential overstatement. |
| **F6** | MEDIUM | ICEpower 1200AS2 $373/unit is unverified from purchase source. |
| **F7** | LOW | ADAU1452 in CLAUDE.md is stale — current POR is 2× ADAU1701 (APM2). CLAUDE.md needs update. |
