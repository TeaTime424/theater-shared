# Analyst Report — Home Theater Design Package
_Option D, 9.4.6 Atmos, 17'×23'×10', 3,910 cu ft_
_Sources: tmp_por_summary.md, tmp_investigation_notes.md, ts_params.json_

---

## 1. BUDGET BASELINE

**Context:** No itemized Option D budget exists. Headline only: ~$36,600. Rev 7.0 budget (~$72K) applies to a different room/amp config and is NOT used. Budget below is reconstructed from component specs across source docs. All estimates flagged.

### Option D Budget — Reconstructed

| # | Item | Qty | Unit Price | Extended | Price Source | Status |
|---|------|-----|-----------|----------|--------------|--------|
| 1 | Denon AVR-X6800H | 1 | $2,199 | $2,199 | MSRP (typical street) | ESTIMATE |
| 2 | ATI AT525NC (5ch) | 1 | $2,499 | $2,499 | MSRP (typical) | ESTIMATE |
| 3 | DIYSG Titan-815LX (kit) | 3 | $799 | $2,397 | DIYSG store est. | ESTIMATE |
| 4 | DIYSG Volt-10 (kit) | 10 | $249 | $2,490 | DIYSG store est. | ESTIMATE |
| 5 | Dayton UMII18-22 driver | 8 | $349 | $2,792 | Parts-Express est. | ESTIMATE |
| 6 | ICEpower 1200AS2 module | 5 | $373 | $1,865 | POR summary (stated) | CONFIRMED |
| 7 | ICEpower chassis/build | 1 | $200 | $200 | POR summary (stated) | CONFIRMED |
| 8 | Sub amp total (6+7) | — | — | $2,065 | POR: "5×$373=$1,865+$200=$2,065" | CONFIRMED |
| 9 | Wondom APM2 (ADAU1701 DSP) | 2 | $35 | $70 | Wondom store | ESTIMATE |
| 10 | Wondom APM3 (I/O board) | 2 | $20 | $40 | Wondom store | ESTIMATE |
| 11 | ICP5 programmer | 1 | $30 | $30 | Wondom store | ESTIMATE |
| 12 | PCM5102A DAC modules (Adafruit #6250) | 4 | $4.95 | $20 | investigation notes (stated) | CONFIRMED |
| 13 | Sonic Imagery 898B (Denon→ICEpower balanced) | 1 | ~$300 | $300 | MEMORY: purchased 2026-03-21 | CONFIRMED |
| 14 | Sub cabinets — lumber/materials (8 corner, 24"×24"×72") | — | — | $800 | DIY materials est. | ESTIMATE |
| 15 | 170" 16:9 AT screen | 1 | $1,200 | $1,200 | Mid-range AT screen est. | ESTIMATE |
| 16 | Projector (2027 flagship laser, placeholder) | 1 | $20,000 | $20,000 | Rev 7.0 had $30K; Option D reduced | ESTIMATE |
| 17 | Aura Pro AST-2B-4 bass shakers | 8 | $70 | $560 | Parts-Express est. | ESTIMATE |
| 18 | MrCool DIY 12K BTU HVAC | 1 | $2,359 | $2,359 | POR summary (stated ~$2,359) | CONFIRMED |
| 19 | Electrical — 100A subpanel, wiring, breakers | 1 | $1,500 | $1,500 | DIY electrical est. | ESTIMATE |
| 20 | Acoustic treatment (panels, bass traps) | — | — | $1,500 | est. (Rev 7.0 had $5,500) | ESTIMATE |
| 21 | Seating (2 couches, riser) | — | — | $3,000 | est. (Rev 7.0 had $6,000) | ESTIMATE |
| 22 | Stage/riser construction lumber | — | — | $500 | DIY est. | ESTIMATE |
| 23 | Cables, connectors, misc | — | — | $500 | est. | ESTIMATE |

**Computed total (sum of column):**

2,199 + 2,499 + 2,397 + 2,490 + 2,792 + 2,065 + 70 + 40 + 30 + 20 + 300 + 800 + 1,200 + 20,000 + 560 + 2,359 + 1,500 + 1,500 + 3,000 + 500 + 500 = **47,321**

| Stated Headline | Computed Sum | Delta | Flag |
|-----------------|-------------|-------|------|
| ~$36,600 | ~$47,321 | +$10,721 | FLAG — gap driven by projector estimate |

**Key driver of gap:** The projector is the largest uncertainty. Rev 7.0 budgeted $30,000; Option D headline ~$36,600 implies a much lower projector budget (~$19,000 or deferred). If projector is excluded entirely (deferred/not in scope), the remaining total is ~$27,321 — below the headline. If projector is ~$9,000 (entry-level laser), the total lands ~$36,000, matching the headline.

**Implied projector budget (back-solve):** $36,600 − $27,321 (ex-projector) = **$9,279** for projector. Headline is internally consistent only if projector is ~$9K range, not a 2027 flagship at $20K+.

**Confirmed line items from source docs:**

| Item | Stated in Source | Verified Sum |
|------|-----------------|-------------|
| ICEpower modules: 5 × $373 | $1,865 | 5 × 373 = **$1,865** MATCH |
| ICEpower chassis | $200 | stated $200 |
| ICEpower sub-total | $2,065 | 1,865 + 200 = **$2,065** MATCH |
| HVAC MrCool 12K | ~$2,359 | stated ~$2,359 |
| PCM5102A × 4 | 4 × $4.95 = $19.80 | **~$20** MATCH |

**FLAG — HVAC price conflict:** Task spec reference cites $1,359 for MrCool. Source doc (POR summary, HVAC investigation) consistently states ~$2,359 for the 12K complete system. The $1,359 figure does NOT appear in source docs. Using $2,359.

**FLAG — AVR model conflict:** CLAUDE.md states AVR-X6800H (~$2,199). Doc 06_Electronics states AVR-A1H (~$6,500 per Rev 7.0 budget). Option D CLAUDE.md is used as active design; AVR-X6800H + ATI AT525NC is the active spec.

---

## 2. SPL CALCULATIONS

### Coordinate Reference (from layout_config.json)

- Room: 17' wide (E-W) × 23' deep (N-S) × 10' high
- North wall = screen wall; south wall = rear
- Riser front from north wall: 15.5 ft
- Riser depth: 5.5 ft
- Row 2 setback from riser back: 1.0 ft → Row 2 front from north wall: 15.5 + 5.5 − 1.0 = **20.0 ft**
- MLP: 75% through 3.0 ft couch depth → 0.75 × 3.0 = 2.25 ft from Row 2 front → **MLP = 20.0 + 2.25 = ~20 ft from north wall**
- Wait — Row 2 is on the riser. Riser front = 15.5 ft from north; riser depth = 5.5 ft; Row 2 setback 1.0 ft from riser back = 15.5 + 4.5 = 20.0 ft from north. MLP at 75% of couch = 20.0 + (0.75 × 3.0) = 20.0 + 2.25 = **22.25 ft** from north wall.
- MLP height: ~44" (ear height seated) = ~3.67 ft

**Formula used throughout:** SPL = sensitivity + 10·log₁₀(power) − 20·log₁₀(distance_m)
where distance_m = distance in meters (1 ft = 0.3048 m)

---

### 2a. LCR — Titan-815LX via ATI AT525NC

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 99 dB (1W/1m) | tmp_por_summary.md |
| Impedance | 6Ω nominal | tmp_por_summary.md |
| Amplifier | ATI AT525NC | CLAUDE.md (Option D) |
| ATI AT525NC power @ 6Ω | ~180W (est.; spec is 125W @ 8Ω, ~180W @ 6Ω) | ESTIMATE |

**Distance — Center speaker to MLP:**
LCR setback from north wall: 0.1 ft (layout_config.json), stage depth ~2.17 ft (26")
Center speaker position from north wall: ~0.1 ft + 0.18 ft (half cabinet) ≈ **~2.6 ft**
MLP from north wall: ~22.25 ft
Horizontal distance = 22.25 − 2.6 = **19.65 ft = 5.99 m**

**SPL calculation (Center, 180W):**
```
SPL = 99 + 10·log₁₀(180) − 20·log₁₀(5.99)
    = 99 + 10·(2.2553) − 20·(0.7774)
    = 99 + 22.55 − 15.55
    = 106.0 dB
```

**L/R speakers — add horizontal offset:**
L/R spread: ±4.9 ft from center. L/R distance to MLP (center seat):
d = √(19.65² + 4.9²) = √(386.12 + 24.01) = √410.13 = **20.25 ft = 6.17 m**

```
SPL = 99 + 10·log₁₀(180) − 20·log₁₀(6.17)
    = 99 + 22.55 − 20·(0.7903)
    = 99 + 22.55 − 15.81
    = 105.7 dB
```

| Channel | Power (W) | Distance (m) | SPL (dB) | Headroom above 95 dB |
|---------|----------|-------------|---------|---------------------|
| Center | 180 | 5.99 | 106.0 | +11.0 dB |
| L/R | 180 | 6.17 | 105.7 | +10.7 dB |

Target of 95 dB met with ~11 dB headroom. PASS.

**NOTE — ATI AT525NC power spec:** Source docs do not state actual power at 6Ω. Value of ~180W is an estimate. If actual rating is lower (e.g., 125W at 6Ω same as 8Ω):
```
SPL = 99 + 10·log₁₀(125) − 20·log₁₀(5.99)
    = 99 + 20.97 − 15.55 = 104.4 dB
```
Still 9.4 dB above target. FLAG — ATI 6Ω power rating not confirmed in source docs.

---

### 2b. Surrounds & Atmos — Volt-10 via AVR-X6800H

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 95 dB (1W/1m) | tmp_por_summary.md (Rev 7.0 corrected) |
| Impedance | 8Ω | tmp_por_summary.md |
| Amplifier | Denon AVR-X6800H internal | CLAUDE.md (Option D) |
| AVR power @ 8Ω | 105–150W (snapshot states range) | tmp_por_summary.md |

Using conservative 105W for worst-case.

**Side surround distance (SL/SR):**
Side surrounds: beside MLP (~90°), on east/west walls.
MLP is 22.25 ft from north wall; room is 17 ft wide; center seat at 8.5 ft from each wall.
Distance from side wall speaker to MLP: ~8.5 ft = **2.59 m**

```
SPL = 95 + 10·log₁₀(105) − 20·log₁₀(2.59)
    = 95 + 20.21 − 20·(0.4133)
    = 95 + 20.21 − 8.27
    = 106.9 dB
```

**Surround back distance (SBL/SBR):**
South wall ~145°, x_offset ±3.0 ft from walls. Speakers near south wall (23 ft from north).
Distance from south wall to MLP: 23 − 22.25 = 0.75 ft + height component.
Actual distance (accounting for speaker height ~6 ft, ear at 3.67 ft): horizontal ~0.75 ft, vertical ~2.33 ft
d = √(0.75² + 3.0² + 2.33²) ≈ √(0.56 + 9.0 + 5.43) = √14.99 ≈ **3.87 ft = 1.18 m**

```
SPL = 95 + 10·log₁₀(105) − 20·log₁₀(1.18)
    = 95 + 20.21 − 20·(0.0719)
    = 95 + 20.21 − 1.44
    = 113.8 dB
```
Surround backs are very close — will need significant attenuation trim.

**Atmos ceiling speakers:**
Ceiling at 10 ft; MLP ear at 3.67 ft; vertical distance = 6.33 ft.
Atmos spread ±4.0 ft from center; assume nearest Atmos at 4.0 ft horizontal.
d = √(4.0² + 6.33²) = √(16 + 40.07) = √56.07 = **7.49 ft = 2.28 m**

```
SPL = 95 + 10·log₁₀(105) − 20·log₁₀(2.28)
    = 95 + 20.21 − 20·(0.3579)
    = 95 + 20.21 − 7.16
    = 108.1 dB
```

| Channel Type | Power (W) | Distance (m) | SPL (dB) | Above 95 dB Target |
|-------------|----------|-------------|---------|-------------------|
| Side Surrounds | 105 | 2.59 | 106.9 | +11.9 dB |
| Surround Backs | 105 | 1.18 | 113.8 | +18.8 dB (needs heavy trim) |
| Atmos | 105 | 2.28 | 108.1 | +13.1 dB |

All channels exceed 95 dB target. AVR trim will dial down to reference. PASS.

FLAG — Surround back SPL of 113.8 dB is 18.8 dB above target. AVR has ample attenuation range (~±12 dB standard). Ensure speaker level trim is within range.

---

### 2c. Subwoofer SPL Check

| Parameter | Value | Source |
|-----------|-------|--------|
| Driver sensitivity | 95.7 dB (2.83V/1m) | ts_params.json |
| Power per driver (PCM5102 path) | 190.5W | Section 5 calculation |
| Drivers per channel (corner pair) | 2 | tmp_por_summary.md |
| Distance to MLP from front corners | ~22 ft = 6.7 m | layout estimate |

**Single driver at 190.5W:**
```
SPL = 95.7 + 10·log₁₀(190.5) − 20·log₁₀(6.7)
    = 95.7 + 22.80 − 20·(0.8261)
    = 95.7 + 22.80 − 16.52
    = 101.98 dB
```

**2 drivers per cabinet (coherent sum = +6 dB):**
SPL_2 = 101.98 + 6.0 = **108.0 dB** per front corner cabinet

**4 corner cabinets (all 4 at same distance — approximation, +6 dB again):**
SPL_4 = 108.0 + 6.0 = **114.0 dB** (theoretical, coherent sum all corners)

**With boundary/corner loading (+11 dB stated in CLAUDE.md):**
Effective SPL at 20 Hz ≈ 114 + 11 = **125 dB** peak

Investigation notes state "8 corner subs achieve ~113 dB at 20Hz at MLP — +8 dB above -10 dB Reference." This is plausible given distance losses and real-world non-coherent summing. Target 95 dB at MLP is met with extreme headroom.

---

## 3. SUB CABINET HEIGHT ASSESSMENT

**T/S parameters from ts_params.json (Dayton datasheet — authoritative):**

| Parameter | Value | Source |
|-----------|-------|--------|
| Fs | 22.0 Hz | ts_params.json |
| Qts | 0.53 | ts_params.json |
| Vas | 8.77 cu ft | ts_params.json |

**WARNING:** POR docs contain WRONG values (Qts=0.36, Vas=15.5). All calculations below use ts_params.json exclusively.

**Formulas:**
- alpha = Vas / Vb (per driver)
- Qtc = Qts × √(alpha + 1)
- Fc = Fs × √(alpha + 1)
- F3: Qtc-dependent. For sealed box: F3 = Fc × √((1/Qtc² − 2) + √((1/Qtc² − 2)² + 4)) / √2

Note: ts_params.json _calculations already provide these values. I verify them below.

**Footprint:** 24" × 24" = 576 in²
**Drivers per cabinet:** 2
**Bracing displacement:** 15% of gross volume
**Net volume = gross × (1 − 0.15) = gross × 0.85**
**Vb per driver = net_volume / 2**

---

### Height 72" — Verification

**Gross volume:** 24 × 24 × 72 = 41,472 in³
Convert to cu ft: 41,472 / 1,728 = **24.0 cu ft** ✓ (matches ts_params.json: 24.0)

**Net volume:** 24.0 × 0.85 = **20.4 cu ft** ✓ (matches: 20.4)

**Vb per driver:** 20.4 / 2 = **10.2 cu ft** ✓ (matches: 10.2)

**alpha:** Vas / Vb = 8.77 / 10.2 = **0.8598** ✓ (matches: 0.8598)

**sqrt(alpha + 1):** √(0.8598 + 1) = √1.8598 = **1.3637** ✓ (matches: 1.3637)

**Qtc:** 0.53 × 1.3637 = **0.7228** ✓ (matches: 0.7228)

**Fc:** 22.0 × 1.3637 = **30.0 Hz** ✓ (matches: 30.0)

**F3 verification:**
F3 formula for sealed box: F3 = Fc × √[ (1/(2Qtc²) − 1) + √((1/(2Qtc²) − 1)² + 1) ]
1/(2 × 0.7228²) = 1/(2 × 0.5224) = 1/1.0449 = 0.9570
inner term = 0.9570 − 1 = −0.0430
Hmm — ts_params.json shows F3_inner_term = −0.0859. Let me check the formula variant:

Alternative: 1/Qtc² − 2 = 1/0.5224 − 2 = 1.9142 − 2 = **−0.0858** ✓ matches ts_params.json (−0.0859, rounding)

F3_sqrt_discriminant: √((-0.0858)² + 4) = √(0.00736 + 4) = √4.00736 = **2.00184** ✓

F3_radicand: (−0.0858 + 2.00184) / 2 = 1.91604 / 2 = **0.95802** ✓ (matches: 0.95797)

F3_multiplier: √0.95802 = **0.97882** ✓ (matches: 0.97880)

F3: 30.0 × 0.97882 = **29.36 Hz ≈ 29.4 Hz** ✓ (matches: 29.4)

---

### Height 96" — Verification

**Gross volume:** 24 × 24 × 96 = 55,296 in³ / 1,728 = **32.0 cu ft** ✓

**Net volume:** 32.0 × 0.85 = **27.2 cu ft** ✓

**Vb per driver:** 27.2 / 2 = **13.6 cu ft** ✓

**alpha:** 8.77 / 13.6 = **0.6449** ✓

**sqrt(alpha + 1):** √1.6449 = **1.2825** ✓

**Qtc:** 0.53 × 1.2825 = **0.6797** ✓

**Fc:** 22.0 × 1.2825 = **28.2 Hz** ✓

**F3_inner_term:** 1/0.6797² − 2 = 1/0.4620 − 2 = 2.1645 − 2 = **0.1645** ✓

**F3:** inner_term + discriminant → (0.1645 + 2.00676) / 2 = 1.08563; √1.08563 = 1.04190; 28.2 × 1.04190 = **29.4 Hz** ✓

---

### Height 120" — Verification

**Gross volume:** 24 × 24 × 120 = 69,120 in³ / 1,728 = **40.0 cu ft** ✓

**Net volume:** 40.0 × 0.85 = **34.0 cu ft** ✓

**Vb per driver:** 34.0 / 2 = **17.0 cu ft** ✓

**alpha:** 8.77 / 17.0 = **0.5159** ✓

**sqrt(alpha + 1):** √1.5159 = **1.2312** ✓

**Qtc:** 0.53 × 1.2312 = **0.6525** ✓

**Fc:** 22.0 × 1.2312 = **27.1 Hz** ✓

**F3_inner_term:** 1/0.6525² − 2 = 1/0.4258 − 2 = 2.3486 − 2 = **0.3486** ≈ 0.3488 ✓

**F3:** (0.3488 + 2.03020) / 2 = 1.18950; √1.18950 = 1.09065; 27.1 × 1.09065 = **29.6 Hz** ✓

---

### Summary Table

| Height | Gross (cu ft) | Net (cu ft) | Vb/driver | alpha | Qtc | Fc (Hz) | F3 (Hz) | Ceiling Fit (stacked pair) |
|--------|--------------|------------|-----------|-------|-----|---------|---------|--------------------------|
| 72" | 24.0 | 20.4 | 10.2 | 0.860 | 0.723 | 30.0 | 29.4 | 144" + 24" clearance = OK |
| 96" | 32.0 | 27.2 | 13.6 | 0.645 | 0.680 | 28.2 | 29.4 | 192" > 120" ceiling FAIL |
| 120" | 40.0 | 34.0 | 17.0 | 0.516 | 0.653 | 27.1 | 29.6 | 240" >> ceiling FAIL |

**Key finding:** F3 is essentially identical across all three heights (29.4–29.6 Hz). Increasing cabinet height beyond 72" provides negligible LF extension (<0.2 Hz). All three heights achieve identical room gain benefit.

**Room gain estimate (3,910 cu ft):**
Room gain = 3 dB/octave below room's quarter-wavelength frequency.
Room corner dimension ~10 ft → quarter-wave at ~28 Hz. Room gain adds approximately +3 to +6 dB at 20 Hz relative to anechoic response, compensating the sealed rolloff below Fc.

**Recommendation: 72" height confirmed optimal.**
- Qtc = 0.723 — closest to Butterworth (0.707) of the three; best transient response
- Stacked pair: 2 × 72" = 144" total, fits 10 ft (120") ceiling with NO room for stacking — **PROBLEM**

**FLAG — STACKING CONFLICT:** Two 72" (6 ft) cabinets stacked = 12 ft = 144 inches. Room ceiling height = 10 ft = 120 inches. 144" > 120" — stacked pair does NOT fit under a 10 ft ceiling. The ts_params.json team_recommendation claims "144\" total, fits comfortably under a 120\" (10') ceiling with 24\" clearance" — this is ARITHMETICALLY WRONG. 144 > 120; there is no 24" clearance. Either the cabinets are not stacked, or the height is not 72", or the stacking refers to something other than vertical stacking.

Possible resolution: "Stacked" may mean side-by-side (horizontal stack), or each corner has one 72" cabinet (not two). If each corner position has a single 72" cabinet (not stacked pair), then 72" fits under 120" ceiling with 48" clearance — that works.

FLAG — clarify "stacked pair" meaning. If single 72" per corner: no conflict. If vertically stacked: physically impossible under 10 ft ceiling.

---

## 4. PROJECTOR THROW VERIFICATION

**Screen:** 170" diagonal, 16:9 (from CLAUDE.md, Option D active)
**Screen width calculation:**
16:9 ratio; diagonal = 170"
Width = 170 × (16/√(16² + 9²)) = 170 × (16/√(256 + 81)) = 170 × (16/√337) = 170 × (16/18.358) = 170 × 0.8715 = **148.1"**
(Source docs state 148" — **MATCH**)
Height = 170 × (9/18.358) = 170 × 0.4902 = **83.3"**

**Available throw distance:**
Room depth: 23 ft = 276"
Stage depth: 26" (24" sub cabinet + 2" screen depth per layout_config.json)
Screen surface from north wall: 26"
Projector typically at rear or ceiling-mounted. Maximum throw = room depth − stage depth = 276 − 26 = **250"** (projector at south wall).
Practical ceiling-mount position: ~20 ft from north wall = 240" − 26" screen offset = **~214" throw**

**Projector spec (JVC NZ500 cited in task):**
Throw ratio range: 1.35:1 to 2.84:1

**Minimum throw required (at 1.35:1, maximum zoom):**
Throw = ratio × screen_width = 1.35 × 148.1 = **200" (16.7 ft)**

**Maximum throw required (at 2.84:1, minimum zoom):**
Throw = 2.84 × 148.1 = **420" (35 ft)**

**Check against available throw:**
- Available throw (rear-wall mount): ~250" (20.8 ft)
- Available throw (ceiling, ~20 ft from north): ~214" (17.8 ft)

At ceiling mount (~214" throw): 214 / 148.1 = throw ratio = **1.44:1**
Spec range is 1.35 to 2.84. 1.44 is within range. PASS.

At rear-wall mount (~250" throw): 250 / 148.1 = **1.69:1**
Also within range. PASS.

| Mount Position | Throw (in) | Throw Ratio | In Spec (1.35–2.84)? |
|---------------|-----------|------------|---------------------|
| South wall | 250 | 1.69:1 | YES — PASS |
| Ceiling ~20 ft | 214 | 1.44:1 | YES — PASS |
| Minimum usable (1.35:1) | 200 | 1.35:1 | Boundary — needs 200" minimum |

**Conclusion:** JVC NZ500 can fill a 170" 16:9 screen from any mounting position deeper than 200" (16.7 ft) from the screen. With 23 ft room depth and 26" stage, the minimum available throw is well above 200". PASS.

**NOTE:** Projector model is a placeholder ("2027 flagship"). JVC NZ500 is cited in task spec but not confirmed in source docs. Price and availability are estimates. FLAG — projector model unconfirmed in source docs.

---

## 5. GAIN STAGING

**Signal chain (from investigation notes):**
X6800H → APM2 ADC → ADAU1701 DSP → I2S → PCM5102 → [898B balanced] → ICEpower 1200AS2 → Subs

### Stage-by-Stage Voltages

| Stage | Signal Level | Notes |
|-------|-------------|-------|
| X6800H sub pre-out | 2.0 Vrms | Task spec / investigation notes |
| APM2 ADC input full-scale | 2.0 Vrms | Task spec — no clipping |
| ADAU1701 internal DAC | 0.9 Vrms | investigation notes (stated) — DO NOT USE |
| PCM5102 external DAC output | 2.0 Vrms | investigation notes (stated) |
| 898B balanced output | 3.5 Vrms | MEMORY: 11.79 dB gain, 0.9→3.5 Vrms |
| ICEpower 1200AS2 sensitivity | 3.55 Vrms for full rated power | task spec |
| ICEpower full rated power @ 8Ω | 620W | ts_params.json context (investigation notes) |

### Power Calculation at PCM5102 (2.0 Vrms, no 898B)

Task spec formula: P = (V_in / V_sensitivity)² × P_rated

```
P = (2.0 / 3.55)² × 600
  = (0.5634)² × 600
  = 0.3174 × 600
  = 190.5 W
```

Note: Task spec uses P_rated = 600W. ICEpower 1200AS2 is rated 620W @ 8Ω (1200W at 4Ω). Using 600W as stated in task spec.

**dB headroom below rated:**
```
10 × log₁₀(190.5 / 600) = 10 × log₁₀(0.3175) = 10 × (−0.4983) = −4.98 dB
```
**Result: −4.98 dB below rated power** (as stated in task spec — CONFIRMED)

### Power Calculation with 898B (3.5 Vrms output)

```
P = (3.5 / 3.55)² × 620
  = (0.9859)² × 620
  = 0.9720 × 620
  = 602.6 W
```

**dB below rated:**
```
10 × log₁₀(602.6 / 620) = 10 × log₁₀(0.9719) = 10 × (−0.01227) = −0.12 dB
```

With 898B in the chain, the ICEpower operates at **602.6W — effectively full rated power (−0.12 dB).**

### Without 898B (APM2 internal DAC, 0.9 Vrms — NOT recommended)

```
P = (0.9 / 3.55)² × 620
  = (0.2535)² × 620
  = 0.06426 × 620
  = 39.8 W
```

```
10 × log₁₀(39.8 / 620) = 10 × log₁₀(0.0642) = 10 × (−1.192) = −11.92 dB
```

**Summary Table:**

| Signal Path | V_in (Vrms) | Power (W) | dB vs Rated | Notes |
|-------------|------------|----------|------------|-------|
| Internal DAC only | 0.9 | 39.8 | −11.92 dB | DO NOT USE — 6% utilization |
| PCM5102, no 898B | 2.0 | 190.5 | −4.98 dB | Task spec value — CONFIRMED |
| PCM5102 + 898B | 3.5 | 602.6 | −0.12 dB | Near-full power — recommended path |

**Conclusion:** 898B is essential to unlock near-full ICEpower output. Without it, −4.98 dB headroom loss (from task spec). With it, essentially full rated power.

---

## 6. GAP LIST

| # | Gap | Impact | Severity |
|---|-----|--------|---------|
| 1 | ATI AT525NC power rating at 6Ω not stated in source docs | LCR SPL calc uses estimate (~180W) | MEDIUM |
| 2 | Cabinet stacking interpretation ambiguous — 2×72" = 144" exceeds 120" ceiling | Build feasibility — possible physical conflict | HIGH |
| 3 | Projector model unconfirmed — "2027 flagship" placeholder; JVC NZ500 cited in task but not in source docs | Budget and throw calc contingent on spec | HIGH |
| 4 | Projector budget not itemized — back-solve implies ~$9K; headline inconsistent with "flagship" | Budget baseline gap of ~$10K | HIGH |
| 5 | MrCool price discrepancy — source docs say ~$2,359; unresolved $1,000 gap vs some references | Budget baseline | MEDIUM |
| 6 | Sub feed wire gauge not in source docs (electrical section truncated) | Code compliance unknown | MEDIUM |
| 7 | AVR model conflict (X6800H vs A1H) — active design is X6800H per CLAUDE.md but POR docs say A1H | Power and channel count | HIGH |
| 8 | DSP chip conflict (ADAU1452 vs ADAU1701 APM2) — active build uses APM2 (ADAU1701) for development; ADAU1452 for production theater | No gap in plan, but docs are inconsistent — needs a single authoritative spec | MEDIUM |
| 9 | Screen bottom height from floor not specified | Sightline and mounting calculation cannot be completed | MEDIUM |
| 10 | Balanced output stage (DRV134 vs THAT1646) not finalized — investigation notes list both | Signal chain not fully specified | LOW |
| 11 | Sub cabinet footprint conflict — 24"×24" (CLAUDE.md + layout_config.json) vs 20"×20" (Garage_Conversion doc) | Cabinet volume and alignment calculations use 24"×24" | MEDIUM |
| 12 | Nearfield sub space reserved in layout — cabinet dimensions (12.5" depth) not verified against 18" driver Sd requirements | Deferred build feasibility | LOW |
| 13 | Volt-10 sensitivity correction (95 dB, not 98 dB) is confirmed; all SPL calcs use corrected value | No gap — resolved | RESOLVED |
| 14 | ICEpower count conflict — CLAUDE.md says 5×, doc 06_Electronics closet list says 4× + 1 spare (same thing, different framing) | No functional gap | RESOLVED |

---

## Conflicts Requiring Resolution (Priority Order)

| Priority | Conflict | Must Decide |
|----------|----------|------------|
| 1 | Cabinet stacking — 2×72" cabinets cannot fit under 10' ceiling if vertically stacked | Is "stacked pair" side-by-side? Single cabinet per corner? |
| 2 | AVR model — X6800H (CLAUDE.md) vs A1H (POR docs) | Which is the Option D spec? |
| 3 | Projector — "2027 flagship" placeholder needs a defined budget | $9K implied by headline vs $20K+ for flagship |
| 4 | Sub cabinet footprint — 24"×24" vs 20"×20" | Affects volume, alpha, Qtc (calculations above use 24"×24") |
| 5 | HVAC price — $2,359 vs unresolved lower figure | Budget +$559 if correct figure is used |
