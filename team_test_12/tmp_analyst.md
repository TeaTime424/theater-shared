# Analyst Report — Option D Home Theater
**Date:** 2026-03-21
**Sources:** tmp_por_core.md, tmp_por_budget.md, tmp_investigation_notes.md, ts_params.json
**T/S values used:** Qts=0.53, Vas=8.77 cuft, Fs=22 Hz (ts_params.json / Dayton datasheet)

---

## 1. BUDGET BASELINE

### 1A. Rev 7.0 Budget Line-Item Verification (11_Budget_Summary.md)

The Rev 7.0 budget is stale (superseded by Option D). Verified for completeness; Option D rebuild in 1B.

Sub-category checks:
- LF: 5,600+1,978+3,114+180+1,120+335 = **$12,327** — matches stated.
- Speakers: 4,800+2,420+84 = **$7,304** — matches stated.
- Electronics: 6,500+799+250 = **$7,549** — matches stated.
- Acoustic Treatment: 2,500+1,500+1,000+500 = **$5,500** — matches stated.
- Infrastructure: 1,700+540+690+370 = **$3,300** — matches stated.

**Rev 7.0 Grand Total Check:**

Sum of all categories: 30,000+12,327+7,304+7,549+6,000+5,500+3,000+3,300 = **$74,980**

**FLAG: Stated mid total is ~$72,000; computed sum is $74,980 — delta +$2,980. Source doc arithmetic error.**

Note: 11_Budget_Summary.md excludes HVAC, electrical, tools.

---

### 1B. Option D Budget Rebuild

Rev 7.0 budget is stale. The following rebuilds Option D from confirmed sources.

**Electronics (06_Electronics_and_Control.md):**

| Item | Stated | Verified | Notes |
|------|--------|----------|-------|
| Denon AVR-X6800H | $3,700 | $3,700 | Replaces AVR-A1H |
| ATI AT525NC | $0 | $0 | Already owned |
| Dirac Live bundle | $799 | $799 | |
| 5× ICEpower 1200AS2 + chassis | $2,065 | Check: 5×$373=$1,865 modules + chassis delta | See note |
| DSP Option B (898B path) | $525 | $525 | APM2 $80 + 898B $389 + cables $56 |
| **Electronics subtotal (Option B)** | **$7,089** | **$7,089** | |

ICEpower note: investigation file states $373/unit × 5 = $1,865 modules; $2,065 stated implies $200 chassis/hardware. Source (tmp_investigation_notes.md §1.1) says "~$2,125 total" for NX6000D comparison baseline. The $2,065 figure in budget doc is close but not reconciled to a per-unit price. **FLAG: ICEpower line item needs itemized BOM (module cost + chassis + connectors).**

Sum check: 3,700 + 0 + 799 + 2,065 + 525 = **$7,089** — consistent with "Option B" path.

**LF System (Option D):**

| Item | Qty | Unit | Extended | Notes |
|------|-----|------|----------|-------|
| UMII18-22 drivers | 8 | $350 | $2,800 | Corner array only; nearfield deferred |
| Enclosures (materials) | 4 | ~$300 | ~$1,200 | Estimate — no line-item in Option D docs |
| Aura Pro AST-2B-4 shakers | 8 | $140 | $1,120 | Reduced from 16× |
| Wiring/hardware | — | — | ~$300 | Estimate |
| **LF subtotal** | | | **~$5,420** | Partial — enclosures/wiring are estimates |

**FLAG: No Option D enclosure cost is provided in any source doc. Rev 7.0 showed $1,978 for 16-driver enclosures; Option D 8-driver cost is unspecified.**

**Speakers (unchanged from Rev 7.0):**

| Item | Qty | Unit | Extended |
|------|-----|------|----------|
| Titan-815LX | 3 | $1,600 | $4,800 |
| Volt-10 V2 | 12 | $242 | $2,904 |
| Isolation | — | — | $84 |
| **Speaker subtotal** | | | **$7,788** |

Note: Option D has 12× Volt-10 (4 surrounds + 6 Atmos + 2 front wide = 12), vs Rev 7.0's 10×. Extended = 12 × $242 = $2,904. Rev 7.0 used 10 × $242 = $2,420.

**HVAC:**

| Item | Stated | Source |
|------|--------|--------|
| MrCool DIY 12K system | $2,359 | 16_HVAC_Plan_Theater.md |
| Additional hardware | $175–$280 | 16_HVAC_Plan_Theater.md |
| **HVAC total** | **$2,550–$2,639** | |

POR Rev 7.0 allocated $1,800 (per investigation). Actual: $2,550–$2,639. **FLAG: $750–$839 budget gap vs original HVAC allocation.**

**Option D Summary (partial — items with confirmed costs only):**

| Category | Amount | Confidence |
|----------|--------|------------|
| Electronics (Option B DSP) | $7,089 | High — sourced |
| LF System (drivers + shakers) | $3,920 | High for drivers/shakers; enclosures TBD |
| Speakers (12× Volt-10 + 3× Titan) | $7,788 | High |
| Seating | $6,000 | Carryover estimate |
| Acoustic Treatment | $5,500 | Carryover estimate |
| Screen | $3,000 | Carryover estimate |
| Infrastructure (riser/stage/rack) | $3,300 | Carryover estimate |
| HVAC | $2,600 | High |
| Projector | $30,000 | Budget placeholder |
| Enclosures (LF) | TBD | **GAP** |
| Electrical (subpanel/wiring) | TBD | **GAP** |
| **Partial confirmed total** | **~$69,197** | Excludes enclosures + electrical |

CLAUDE.md states "~$36,600 out-of-pocket (with bass deferral)." This appears to exclude projector ($30,000) and seating ($6,000), implying a ~$33,000 A/V+construction budget. **FLAG: The basis for the $36,600 figure is not reconstructible from available line items. A full Option D BOM with sources is needed.**

---

## 2. SPL CALCULATIONS

Formula: SPL_MLP = Sensitivity + 10·log10(Power) - 20·log10(distance_m)

Note: sensitivity is specified at 2.83V/1m. At 1m, 2.83V into 8Ω = 1W. Into 6Ω, 2.83V = 1.33W. The sensitivity spec therefore already accounts for the reference voltage, not 1W — this matters for LCR (6Ω).

For consistent comparison, convert sensitivity to 1W/1m basis:
- 8Ω speaker: 2.83V/1m = 1W. Sensitivity(1W) = Sensitivity(2.83V) — same.
- 6Ω speaker: 2.83V/1m = (2.83²/6) = 1.334W. Sensitivity(1W) = Sensitivity(2.83V) - 10·log10(1.334) = Sensitivity - 1.25 dB.

### 2A. LCR — Titan-815LX

- Sensitivity: 99 dB/2.83V/1m (tmp_por_core.md, 05_Speaker_System.md)
- Sensitivity (1W/1m, 6Ω): 99 - 10·log10(2.83²/6) = 99 - 10·log10(1.334) = 99 - 1.25 = **97.75 dB**
- Amp: ATI AT525NC, ~300W/ch @ 6Ω (tmp_por_core.md)
- Distance: 12 ft = 12 × 0.3048 = **3.658 m**

SPL = 97.75 + 10·log10(300) - 20·log10(3.658)
    = 97.75 + 24.77 - 20·log10(3.658)
    = 97.75 + 24.77 - 20·(0.5632)
    = 97.75 + 24.77 - 11.26
    = **111.3 dB**

Headroom above 95 dB target: 111.3 - 95 = **+16.3 dB**

The POR claims "+9 to +13 dB headroom." Computed result is +16.3 dB. **FLAG: POR headroom for LCR understates by ~3-7 dB.** The discrepancy may reflect a different assumed power or distance.

### 2B. Surrounds / Atmos — Volt-10 V2

- Sensitivity: 95 dB/2.83V/1m (tmp_por_core.md — corrected from erroneous 98 dB)
- Sensitivity (1W/1m, 8Ω): 95 dB (2.83V into 8Ω = 1W, so same)
- Amp: AVR-X6800H internal, ~140W/ch @ 8Ω rated; conservative all-channel: 100W
- Distance surrounds: ~2.5 m (8.2 ft)
- Distance Atmos: ~3 m (9.8 ft)

**Surrounds at 2.5 m, 100W:**
SPL = 95 + 10·log10(100) - 20·log10(2.5)
    = 95 + 20.00 - 20·(0.3979)
    = 95 + 20.00 - 7.96
    = **107.0 dB**

Headroom: 107.0 - 95 = **+12.0 dB**

**Atmos at 3.0 m, 100W:**
SPL = 95 + 10·log10(100) - 20·log10(3.0)
    = 95 + 20.00 - 20·(0.4771)
    = 95 + 20.00 - 9.54
    = **105.5 dB**

Headroom: 105.5 - 95 = **+10.5 dB**

POR claims "+13 to +15 dB headroom" for surrounds/Atmos. Computed: +10.5 to +12.0 dB. **FLAG: POR overstates surround/Atmos headroom by ~2-5 dB.** At rated 140W, headroom improves by 10·log10(140/100) = 1.46 dB, giving +12.0 to +13.4 dB — partially reconciles.

**Summary SPL Table:**

| Channel | Sensitivity | Power (W) | Distance (m) | SPL at MLP | Headroom vs 95dB |
|---------|------------|-----------|--------------|------------|-----------------|
| LCR (Titan-815LX, 6Ω) | 97.75 dB (1W) | 300 | 3.658 | 111.3 dB | +16.3 dB |
| Surround (Volt-10, 8Ω) | 95 dB (1W) | 100 | 2.5 | 107.0 dB | +12.0 dB |
| Atmos (Volt-10, 8Ω) | 95 dB (1W) | 100 | 3.0 | 105.5 dB | +10.5 dB |

All channels exceed 95 dB target. All meet -10 dB Reference with margin. **No concern.**

---

## 3. SUB CABINET HEIGHT ASSESSMENT

T/S parameters from ts_params.json (authoritative):
- Fs = 22.0 Hz, Qts = 0.53, Vas = 8.77 cuft

Cabinet geometry from ts_params.json:
- Footprint: 24"×24" nominal, panel 0.75", internal = 22.5"×22.5"
- Each driver gets its own chamber: height = (total_cabinet_height/2) - 0.75" partition
- Bracing factor: 0.85 (net volume = gross × 0.85)

### Verify ts_params.json calculations — my own arithmetic

Formula for each: chamber_h = (total/2) - 0.75 in; gross = 22.5²×h in³; ft³ = gross/1728; net = ft³×0.85; α = 8.77/net; Qtc = 0.53×sqrt(α+1); Fc = 22×sqrt(α+1); F3 from standard sealed-box formula.

**72-inch:** chamber = 35.25 in; gross = 17,845 in³ = 10.327 ft³; net = 8.778 ft³; α = 0.9991; sqrt(1.9991) = 1.4139; Qtc = **0.7494**; Fc = **31.11 Hz**; F3: (1/0.5616)-2 = -0.2192; sqrt(0.04805+4) = 2.0120; num = 1.7928; sqrt(0.8964) = 0.9469; F3 = 31.11×0.9469 = **29.47 Hz**. ts_params: 0.749/31.10/29.46 — **agrees.**

**96-inch:** chamber = 47.25 in; gross = 23,920 in³ = 13.843 ft³; net = 11.767 ft³; α = 0.7453; sqrt(1.7453) = 1.3211; Qtc = **0.7002**; Fc = **29.06 Hz**; F3: (1/0.4903)-2 = 0.0396; sqrt(0.00157+4) = 2.0004; num = 2.040; sqrt(1.020) = 1.0100; F3 = 29.06×1.010 = **29.35 Hz**. ts_params: 0.700/29.06/29.36 — **agrees.**

**120-inch:** chamber = 59.25 in; gross = 29,995 in³ = 17.359 ft³; net = 14.755 ft³; α = 0.5943; sqrt(1.5943) = 1.2627; Qtc = **0.6692**; Fc = **27.78 Hz**; F3: (1/0.4478)-2 = 0.2330; sqrt(0.0543+4) = 2.0135; num = 2.2465; sqrt(1.1233) = 1.0598; F3 = 27.78×1.0598 = **29.44 Hz**. ts_params: 0.669/27.78/29.44 — **agrees.**

### Height Recommendation Table

| Height | Vb net (ft³) | α | Qtc | Fc (Hz) | F3 (Hz) | Assessment |
|--------|-------------|---|-----|---------|---------|------------|
| 72 in | 8.78 | 0.999 | 0.749 | 31.11 | 29.47 | Slight hump before rolloff |
| **96 in** | **11.77** | **0.745** | **0.700** | **29.06** | **29.35** | **Butterworth — recommended** |
| 120 in | 14.76 | 0.594 | 0.669 | 27.78 | 29.44 | Under-damped; 10-ft ceiling hard limit |

**Finding:** F3 is nearly identical across all three heights (29.35–29.47 Hz) because the F3 formula converges near Qtc=0.7. The 96" cabinet achieves the maximally-flat (Butterworth) alignment at Qtc=0.700. The 120" option offers only 0.09 Hz additional extension with an 8-foot cabinet — negligible benefit. The 72" option has Qtc=0.749, producing a mild +0.4 dB hump around Fc before rolloff.

**Best choice: 96 inches (8 ft).** Fits a 10-ft ceiling with 16" clearance. Qtc=0.700 is textbook Butterworth. Room gain from corner loading will dominate below 30 Hz regardless of alignment choice.

**Note:** ts_params.json recommendation also selects 96 inches. My independent calculation confirms this. Calculations verified.

---

## 4. PROJECTOR THROW VERIFICATION

### Screen geometry

**16:9 at 170" diagonal:**
- Diagonal = 170", aspect ratio = 16:9
- Width = 170 × 16 / sqrt(16² + 9²) = 170 × 16 / sqrt(256 + 81) = 170 × 16 / sqrt(337)
- sqrt(337) = 18.358
- Width = 170 × 16 / 18.358 = 2,720 / 18.358 = **148.2 in = 12.35 ft**
- Height = 170 × 9 / 18.358 = 1,530 / 18.358 = **83.3 in = 6.94 ft**

Screen height check (from tmp_por_budget.md citing 02_Front_Stage_System.md):
- Bottom at ~51 in (from floor); Top = 51 + 83.3 = **134.3 in = 11.2 ft**
- That exceeds a 10-ft (120 in) ceiling by 14.3 inches.

**FLAG: 16:9 at 170" with bottom at 51" puts top at 134" — DOES NOT fit in 10-ft ceiling.**

Using task description's numbers: bottom at 30", top = 30 + 83.4 = 113.4 in = 9.45 ft. That fits with 6.6" clearance. The 51" bottom height from the POR source doc is physically impossible. This is a layout conflict requiring resolution.

**2.35:1 at 170" diagonal:**
- Diagonal = 170", aspect ratio = 2.35:1
- Width = 170 × 2.35 / sqrt(2.35² + 1²) = 170 × 2.35 / sqrt(5.5225 + 1) = 170 × 2.35 / sqrt(6.5225)
- sqrt(6.5225) = 2.5539
- Width = 170 × 2.35 / 2.5539 = 399.5 / 2.5539 = **156.4 in = 13.03 ft**
- Height = 170 × 1 / 2.5539 = 170 / 2.5539 = **66.6 in = 5.55 ft**

The 2.35:1 screen is 7 inches narrower per side than the 17-ft room wall (width = 156.4 in vs 204 in wall) — fits horizontally. Height of 66.6 in fits easily.

### Throw ratio calculations

Available throw: Room depth 23 ft, minus ~2 ft stage depth = **21 ft = 252 in**

| Screen | Width (in) | Throw ratio (252 in / width) | JVC NZ500 range (1.4–2.8:1) |
|--------|-----------|------------------------------|------------------------------|
| 170" 16:9 | 148.2 | 252 / 148.2 = **1.70:1** | Within range |
| 170" 2.35:1 | 156.4 | 252 / 156.4 = **1.61:1** | Within range |

Both screen aspect ratios produce throw ratios within JVC NZ500's 1.4–2.8:1 range. No projector concern from throw distance.

**Summary:**

| Aspect | Width | Height | Throw Ratio | Fits ceiling (bottom=30")? |
|--------|-------|--------|-------------|---------------------------|
| 16:9 | 148.2 in | 83.4 in | 1.70:1 | Yes (top = 113.4 in, 6.6" clearance) |
| 2.35:1 | 156.4 in | 66.6 in | 1.61:1 | Yes (top = 96.6 in with 23.4" clearance) |

**Screen aspect ratio remains CONTESTED** (see tmp_por_budget.md Contradiction Flag #1). Both fit physically. The 16:9 option requires mounting bottom at 30" (not 51" as POR states). Resolve screen aspect before finalizing stage height.

---

## 5. GAIN STAGING (898B signal chain)

Signal chain: X6800H sub pre-out → APM2 ADC → ADAU1701 → I2S → PCM5102 → 898B → ICEpower 1200AS2

Key parameters from source docs:
- X6800H pre-out: 0.9 Vrms (tmp_investigation_notes.md §7)
- 898B gain: +11.79 dB (tmp_investigation_notes.md §3)
- Voltage gain factor: 10^(11.79/20) = 10^(0.5895) = **3.886×**
- PCM5102 output: 2.0 Vrms (tmp_investigation_notes.md §2)
- ICEpower 1200AS2 sensitivity: 3.55 Vrms for full power
  (Note: tmp_investigation_notes.md §7 cites 3.61 Vrms; §3 cites 3.55 Vrms — minor discrepancy, using 3.55 Vrms as stated in task)
- ICEpower rated output: 620W @ 8Ω

### Two scenarios for task description

**Scenario A: PCM5102 (2.0 Vrms) feeds 898B directly**

| Stage | Voltage (Vrms) | Calculation |
|-------|---------------|-------------|
| PCM5102 output | 2.000 | Given |
| After 898B (+11.79 dB) | 7.77 | 2.000 × 3.886 = 7.772 |
| ICEpower clipping threshold | 3.55 | Spec |
| Ratio to clipping | 2.19× over | 7.772 / 3.55 = 2.189 |
| Excess in dB | +6.80 dB | 20·log10(2.189) = 6.80 dB |

With 2.0 Vrms into the 898B, the output (7.77 Vrms) would clip the ICEpower input. The DSP must attenuate to bring the ICEpower input to ≤3.55 Vrms.

Required DSP attenuation:
- Target at ICEpower: 3.55 Vrms
- DSP output needed: 3.55 / 3.886 = **0.914 Vrms** (before 898B)
- DSP attenuation from 2.0 Vrms: 0.914 / 2.000 = 0.457 = **-6.80 dB**

**Scenario B: X6800H direct (0.9 Vrms) feeds 898B (original chain per §3)**

| Stage | Voltage (Vrms) | Calculation |
|-------|---------------|-------------|
| X6800H pre-out | 0.900 | Given |
| After 898B (+11.79 dB) | 3.498 | 0.900 × 3.886 = 3.497 |
| ICEpower sensitivity | 3.55 | Spec |
| Ratio to full power | 0.985× | 3.497 / 3.55 = 0.985 |
| Power deficit | ~3% | (0.985)² = 0.970 = 97% of rated |

At 0.9 Vrms input, the 898B output (3.50 Vrms) is 1.5% below the ICEpower sensitivity spec — essentially full power (620W × 0.970 = **601W**). This is the correct chain and requires no DSP attenuation for level.

Note: §2 and §3 of investigation notes contradict on routing (PCM5102 path vs direct X6800H to 898B — see Gap G9). Task description uses PCM5102 path (Scenario A), analyzed fully below.

### Complete Gain Staging Table (Scenario A — PCM5102 path)

| Stage | Voltage In | Gain | Voltage Out | Notes |
|-------|-----------|------|-------------|-------|
| X6800H sub pre-out | — | — | 0.900 Vrms | Source |
| APM2 ADC input | 0.900 | 0 dB | 0.900 Vrms | 2V full-scale ADC |
| ADAU1701 (DSP, unity) | — | variable | — | DSP applies filter + attenuation |
| PCM5102 DAC output | — | — | 2.000 Vrms | Max output |
| Required DSP atten (Scenario A) | 2.000 | -6.80 dB | 0.914 Vrms | To keep ICEpower ≤3.55V |
| 898B input (attenuated) | 0.914 | — | — | |
| 898B output (+11.79 dB) | 0.914 | ×3.886 | 3.553 Vrms | ≈ ICEpower sensitivity |
| ICEpower 1200AS2 | 3.553 | — | 620W @ 8Ω | Full rated power |

### Headroom and operating power:

- DSP must be set to -6.80 dB as its nominal reference to avoid clipping ICEpower input. Any positive boost above this point clips.
- At nominal (-6.80 dB DSP): ICEpower at 3.55 Vrms → (3.55/3.55)²×620 = **620W**
- At -10 dBFS reference: V = 3.55×10^(-10/20) = 1.122 Vrms; P = (1.122/3.55)²×620 = **62W per driver**

---

## 6. GAP LIST

| # | Gap | Impact | Recommendation |
|---|-----|--------|----------------|
| G1 | **Screen aspect ratio unresolved** (16:9 vs 2.35:1) | Affects stage height, screen bottom position, projector specification | Decide before finalizing stage build |
| G2 | **Screen bottom height conflict** — 02_Front_Stage_System.md says 51", task spec says 30", 16:9 requires 30" max to fit ceiling | Layout/construction error risk | Lock bottom height; update POR |
| G3 | **Option D enclosure cost missing** — no BOM for 4 sub cabinets in any Option D doc | Budget gap ~$1,000–$1,500 estimated | Add materials BOM for 24"×24"×96" MDF cabinets |
| G4 | **ICEpower chassis/hardware cost not itemized** — $2,065 stated but per-unit math gives $1,865 for modules alone | $200 unaccounted | Produce chassis/connector BOM |
| G5 | **$36,600 "out-of-pocket" basis unclear** — cannot reconstruct from available line items | Budget baseline unreliable | Rebuild full Option D budget with sources |
| G6 | **Electrical subpanel/wiring cost missing** — no line item in Option D docs | Likely $1,500–$3,000 for 100A subpanel install | Obtain contractor quote |
| G7 | **Sub cabinet cross-section conflict unresolved** — 20" (Garage_Conversion) vs 24" (CLAUDE.md) | Affects room layout, corner fit, and volume calculations | All ts_params.json calculations use 24"; confirm and update POR |
| G8 | **Rev 7.0 grand total math error** — stated $72,000 mid but line items sum to $74,980 (+$2,980) | Source doc has arithmetic error | Correct 11_Budget_Summary.md |
| G9 | **PCM5102 vs direct chain ambiguity** — §2 and §3 of investigation notes contradict each other on DSP signal routing | Gain staging design depends on which path is active | Clarify: does PCM5102 output feed 898B, or does X6800H pre-out feed 898B directly? |
| G10 | **Volt-10 count** — CLAUDE.md says 10× Volt-10 (4+6), but Option D adds 2 front wide = 12× total | Budget speaker cost uses 10× in Rev 7.0; 12× correct for Option D | Update speaker subtotal to 12× $242 = $2,904 |
| G11 | **Projector model not selected** — $30,000 placeholder, JVC NZ500 cited as "typical" but not committed | Largest single line item unresolved | Defer to 2027 as stated, but confirm screen aspect ratio first |
| G12 | **Nearfield sub cost not in budget** — deferred but space reserved; 4× UMII18-22 = $1,400 drivers alone | Post-build cost not tracked | Note as future $2,500–$3,000 item |
