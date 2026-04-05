# Option D Comprehensive Baseline Analysis

**Date:** 2026-03-15
**Analyst Role:** Primary analysis with New Grad and Senior advisory voices
**Scope:** Complete baseline of Option D — budget, performance, sub enclosures, electrical, gain staging, gaps, tradeoffs
**Sources:** All POR documents, investigation verdicts, layout config, research docs. No team_test folders referenced.

---

## A. BUDGET BASELINE

### Phase 1: Building Prep (Option D)

| # | Item | Stated Cost |
|---|------|------------|
| 1 | Right garage door removal + panel/brick to match exterior | $800 |
| 2 | N-S partition wall framing (2x6, 23' run) | $400 |
| 3 | Partition wall insulation (R-19) + vapor barrier | $500 |
| 4 | Partition wall drywall + finish (both sides) | $600 |
| 5 | Equipment closet framing + door (4x4, gym NE corner) | $400 |
| 6 | Equipment closet finish + cable pass-throughs | $300 |
| 7 | MrCool DIY 12K system (condenser + head + lineset + Quick Connect) | $2,359 |
| 8 | HVAC hardware (disconnect, breaker, wire, raceway, condensate) | $200 |
| 9 | 240V circuit for condenser | $600 |
| 10 | Circuit A -- sub amps (20A/240V, single circuit) | $400 |
| 11 | Circuit C -- processor/amps/DSP (20A/120V) | $400 |
| 12 | Circuit D -- projector ceiling run (20A/120V) | $400 |
| 13 | Circuit F -- gym (20A/120V) | $400 |
| 14 | Theater carpet + pad (391 sq ft) | $1,000 |
| 15 | Paint (theater + equip closet) | $200 |
| 16 | Trim + baseboards (theater only) | $200 |
| 17 | Interior door (equipment closet) | $200 |
| 18 | Lighting (theater + gym) | $700 |
| 19 | Permits (building + electrical + HVAC) | $800 |
| 20 | Plans (simplified scope) | $400 |

**My sum:** $800 + $400 + $500 + $600 + $400 + $300 + $2,359 + $200 + $600 + $400 + $400 + $400 + $400 + $1,000 + $200 + $200 + $200 + $700 + $800 + $400 = **$11,059**

**Stated total:** $11,059

**Verdict: Phase 1 arithmetic is CORRECT.**

### Phase 2: Home Theater (Option D)

| Category | Stated Subtotal | My Sum of Line Items |
|----------|----------------|---------------------|
| Projector & screen | $7,599 | $5,999 + $1,000 + $500 + $100 = **$7,599** |
| Processor & DSP | $4,707 | $3,700 + $349 + $299 + $299 + $60 + $0 = **$4,707** |
| Speakers (10x Volt-10 + isolation) | $2,504 | $484 x5 + $84 = $2,420 + $84 = **$2,504** |
| Sub drivers (6x UMII18-22) | $2,100 | 6 x $350 = **$2,100** |
| Sub amps (5x ICEpower + chassis) | $2,065 | 5 x $373 + $200 = $1,865 + $200 = **$2,065** |
| Sub enclosures (4 columns) | $1,400 | 4 x $350 = **$1,400** |
| Bass shakers (8x Aura Pro + wiring) | $660 | $280 + $280 + $100 = **$660** |
| Seating (2 couches) | $2,000 | $1,000 + $1,000 = **$2,000** |
| Theater construction (stage + riser) | $2,040 | $540 + $800 + $500 + $200 + $0 = **$2,040** |
| Infrastructure & wiring | $1,080 | $550 + $150 + $100 + $100 + $80 + $100 = **$1,080** |

**My Phase 2 remaining spend sum:** $7,599 + $4,707 + $2,504 + $2,100 + $2,065 + $1,400 + $660 + $2,000 + $2,040 + $1,080 = **$26,155**

**Stated Phase 2 remaining spend:** $26,155

**Verdict: Phase 2 arithmetic is CORRECT.**

### Grand Total Verification

| Phase | Remaining Spend | Already Owned | Total Value |
|-------|----------------|---------------|-------------|
| Phase 1 | $11,059 | -- | $11,059 |
| Phase 2 | $26,155 | $13,450 | $39,605 |
| **Grand Total** | **$37,214** | **$13,450** | **$50,664** |

**Stated grand total remaining spend:** $36,624

**FLAG: ARITHMETIC ERROR.** $11,059 + $26,155 = $37,214, NOT $36,624. The stated total is $590 LOW. Similarly, stated total value is $50,074 but should be $11,059 + $39,605 = $50,664 -- $590 difference.

**Root cause:** The Option D grand total table in `Garage_Conversion_Option1.md` states Phase 2 remaining spend as $25,565, but the Phase 2 line items sum to $26,155. The $590 discrepancy suggests the grand total was computed from an earlier draft's Phase 2 total and not updated when line items changed.

### Known Corrections Not Yet Applied

| Item | Current Value | Corrected Value | Delta |
|------|--------------|----------------|-------|
| DSP board | ADAU1452 ($60) | 2x Wondom APM2 ($45 each = $90) | +$30 |
| Electrical feed | 100A (stated in some docs) | 60A feed (actual) | N/A to cost |
| Screen price | $1,000 | $1,500 (realistic for 170" 16:9 AT) | +$500 |

**Corrected Phase 2 remaining spend:** $26,155 - $60 + $90 + $500 = **$26,685**
**Corrected Grand Total OOP:** $11,059 + $26,685 = **$37,744**

### HVAC Budget Discrepancy

The HVAC investigation verdict (05_verdict.md) flags that the original Option D HVAC budget was $1,800 ($1,000 condenser + $800 head), but the actual MrCool system is ~$2,550 -- a $750 gap. The current v3.7 document has already corrected this to $2,359 + $200 = $2,559, so **the gap has been resolved** in the current document version.

---

## B. PERFORMANCE BASELINE

### SPL at MLP -- Speaker Channels

Target: 95 dB at MLP (-10 dB Reference)

**LCR (Titan-815LX, 99 dB sensitivity, 6 ohm)**

ATI AT525NC: ~300W into 6 ohm (NCore).

SPL @ 1m = 99 + 10*log10(300/1) = 99 + 24.8 = **123.8 dB**

Distance to Row 1 MLP: 10.5 ft (3.2 m). Distance loss: -20*log10(3.2) = -10.1 dB.
Room gain (typical +3 dB for enclosed room): +3 dB.

SPL @ Row 1 = 123.8 - 10.1 + 3 = **116.7 dB**
SPL @ Row 2 (15 ft / 4.57m) = 123.8 - 13.2 + 3 = **113.6 dB**

Headroom over 95 dB: **+21.7 dB (Row 1), +18.6 dB (Row 2)**

**NOTE:** The document claims ~108 dB at Row 1 and ~104 dB at Row 2 (+9 to +13 dB headroom). My calculation shows significantly more. The discrepancy arises because the document appears to use a higher effective distance attenuation or lower assumed amplifier power. Using the document's numbers (+9 to +13 dB headroom) is more conservative and accounts for real-world losses (crossover losses, crest factor, power compression) that the simple formula ignores. Either way, headroom is abundant.

**Surrounds/Atmos (Volt-10, 95 dB sensitivity, 8 ohm)**

X6800H internal: ~100-140W into 8 ohm.

SPL @ 1m (at 140W) = 95 + 10*log10(140) = 95 + 21.5 = **116.5 dB**

Side surrounds at 17' width room: ~8.5 ft (2.6 m) from MLP. Distance loss: -8.3 dB.

SPL @ MLP = 116.5 - 8.3 + 3 = **111.2 dB**

Headroom over 95 dB: **+16.2 dB** (vs document claim of +13 to +15 dB -- close)

Height channels at ~10-12 ft: distance loss -10 to -11.6 dB.

SPL @ MLP = 116.5 - 11 + 3 = **108.5 dB**

Headroom: **+13.5 dB**

**All channels exceed 95 dB target with minimum +13 dB headroom. Confirmed.**

### Subwoofer System Output

**Configuration:** 8x UMII18-22 in 4 corner columns (2 drivers per corner), sealed, 8 ohm series wiring.

Per corner (2 drivers at 8 ohm series): ICEpower 1200AS2 delivers 620W/ch @ 8 ohm.

Per driver: 310W (620W / 2 drivers in series).

Driver sensitivity: 90.7 dB @ 2.83V/1m (spec sheet uses 2.83V, which is 1W into 8 ohm for one coil -- but spec sheet says "VCs in series" = 4 ohm per driver). Need to be careful here.

UMII18-22 sensitivity at 4 ohm (VCs in series): 90.7 dB @ 2.83V/1m. At 4 ohm, 2.83V = 2W. Sensitivity referenced to 1W = 90.7 - 3 = 87.7 dB/W/m.

But our wiring puts 2 drivers in series = 8 ohm total. Each driver sees half the voltage = 1/4 the power.

**SPL per corner pair (simplified):**
- 620W into 8 ohm load
- 2 drivers in series: each gets 310W equivalent
- Per driver at 310W into 4 ohm: SPL = 87.7 + 10*log10(310) = 87.7 + 24.9 = 112.6 dB @ 1m
- Two drivers: +3 dB = 115.6 dB @ 1m (per corner, free-field)

**Corner boundary loading:** +11 dB (three-boundary)

**SPL per corner in room:** 115.6 + 11 = **126.6 dB @ 1m**

**4-corner acoustic summing:** +6 dB (coherent addition from 4 identical sources)

**Total at room center:** 126.6 + 6 = **132.6 dB** (this is the theoretical maximum at passband)

**Distance / room effects:** MLP is not at 1m. But at low frequencies (<80 Hz), room pressurization dominates -- inverse-square law doesn't apply in the traditional sense. The room acts as a pressure zone. The document's claim of ~113 dB @ 20 Hz accounts for the sealed enclosure rolloff below Fc.

**At 20 Hz (below sealed Fc ~31 Hz):**
The sealed response rolls off at 12 dB/oct below Fc. At 20 Hz relative to 31 Hz Fc:
- Rolloff = 20*log10((20/31)^2) = 20*log10(0.416) = -7.6 dB (for Q=0.72 sealed alignment, rolloff is gentler)
- More precisely for a 2nd-order HP with Qtc=0.72 at f/Fc=0.645: response = -5 to -6 dB

So ~113 dB at 20 Hz = ~119 dB passband - 6 dB rolloff. The document's numbers are plausible and conservative.

**Headroom vs 105 dB THX LFE reference @ 20 Hz:** +8 dB. Confirmed.

### Room Modes (17' x 23' x 10')

Axial modes:

| Mode | Dimension | Frequency |
|------|-----------|-----------|
| Length (1,0,0) | 23 ft | 1130/(2*23) = **24.6 Hz** |
| Width (0,1,0) | 17 ft | 1130/(2*17) = **33.2 Hz** |
| Height (0,0,1) | 10 ft | 1130/(2*10) = **56.5 Hz** |
| Length (2,0,0) | 23 ft | **49.1 Hz** |
| Width (2,0,0) | 17 ft | **66.5 Hz** |
| Length (3,0,0) | 23 ft | **73.7 Hz** |

The first three axial modes at 24.6, 33.2, and 56.5 Hz are well-separated. Room ratio H:W:D = 1:1.7:2.3 avoids degenerate mode overlaps. This is a good room ratio per Bolt Area analysis.

**Schroeder frequency** (transition to diffuse field): Fs ~ 2000 * sqrt(RT60/V) where V in m^3.
Room volume = 3,910 cu ft = 110.7 m^3. Estimating RT60 ~ 0.4s for treated room:
Fs ~ 2000 * sqrt(0.4/110.7) = 2000 * 0.060 = **120 Hz**

Below 120 Hz, room modes dominate. The 4-corner sub array addresses this directly per Welti/Harman research.

---

## C. SUB ENCLOSURE ANALYSIS

### UMII18-22 T/S Parameters (as given)

| Parameter | Value |
|-----------|-------|
| Vas | 15.5 cu ft (per task instruction -- note: POR doc says 8.77 cu ft = 248.2L) |
| Qts | 0.36 (per task -- POR doc says 0.53) |
| Fs | 22 Hz |

**CRITICAL DISCREPANCY:** The task specifies Vas=15.5 cu ft, Qts=0.36, Fs=22 Hz. The POR subwoofer document (03_Subwoofer_System.md) lists Vas=8.77 cu ft (248.2L), Qts=0.53, Fs=22 Hz. These are substantially different T/S parameters. I will calculate with BOTH sets and note which is correct.

**The POR values (Vas=248.2L, Qts=0.53) match the Dayton UMII18-22 spec sheet.** The task's Vas=15.5 cu ft = 439L is nearly double the spec. The task's Qts=0.36 is also different. I will use the spec sheet values as the verified baseline, and note what the task-supplied values would yield.

### Cabinet Dimensions -- 24"x24" Footprint

Panel thickness: 0.75" (3/4" plywood).

Internal dimensions for 24"x24" footprint: 24 - 2(0.75) = 22.5" x 22.5"

Bracing + driver displacement deduction: ~8% of gross volume.

| External Height | Internal Height | Gross Internal Vol (cu ft) | Net Vol (after 8%) | Net Vol per driver (2/cab) |
|----------------|----------------|---------------------------|-------------------|----|
| **72"** (6 ft) | 70.5" | 22.5 x 22.5 x 70.5 / 1728 = **20.65 cu ft** | **19.0 cu ft** | **9.5 cu ft** |
| **96"** (8 ft) | 94.5" | 22.5 x 22.5 x 94.5 / 1728 = **27.68 cu ft** | **25.5 cu ft** | **12.7 cu ft** |
| **120"** (10 ft) | 118.5" | 22.5 x 22.5 x 118.5 / 1728 = **34.72 cu ft** | **31.9 cu ft** | **16.0 cu ft** |

### Sealed Enclosure Calculations (Using POR T/S: Vas=248.2L=8.77 cu ft, Qts=0.53, Fs=22 Hz)

Formula: Fc = Fs * sqrt(1 + Vas/Vb), Qtc = Qts * sqrt(1 + Vas/Vb)

Where Vb = net volume per driver.

| Height | Vb/driver (cu ft) | Vas/Vb | Fc (Hz) | Qtc | F3 (Hz) |
|--------|----|--------|---------|-----|---------|
| **72"** | 9.5 | 0.923 | 22 * sqrt(1.923) = **30.5** | 0.53 * sqrt(1.923) = **0.735** | Fc * sqrt((1/(Qtc^2) - 2 + sqrt((1/(Qtc^2)-2)^2 + 4))/2) -- see below |
| **96"** | 12.7 | 0.691 | 22 * sqrt(1.691) = **28.6** | 0.53 * sqrt(1.691) = **0.690** | see below |
| **120"** | 16.0 | 0.548 | 22 * sqrt(1.548) = **27.4** | 0.53 * sqrt(1.548) = **0.660** | see below |

**F3 calculation** for a sealed 2nd-order HP:
F3 = Fc * sqrt(1 - 2*Qtc^2 + sqrt(4*Qtc^4 - 4*Qtc^2 + 2))...

Simpler formula: F3 = Fc/Qtc * sqrt((Qtc^2 - 0.5) + sqrt(Qtc^4 - Qtc^2 + 0.25))

Actually, for a 2nd-order Butterworth-ish alignment, F3 ~ Fc * sqrt(1/(2*Qtc^2) * (2*Qtc^2 - 1 + sqrt((2*Qtc^2-1)^2 + 4)))... Let me just use the standard formula:

For a sealed box, F3 = Fc * sqrt((1/Qtc^2 - 2 + sqrt((1/Qtc^2 - 2)^2 + 4)) / 2)

| Height | Fc | Qtc | 1/Qtc^2 | 1/Qtc^2 - 2 | F3 |
|--------|-----|------|---------|-------------|-----|
| 72" | 30.5 | 0.735 | 1.851 | -0.149 | 30.5 * sqrt((-0.149 + sqrt(0.022 + 4))/2) = 30.5 * sqrt((-0.149 + 2.006)/2) = 30.5 * sqrt(0.929) = 30.5 * 0.964 = **29.4 Hz** |
| 96" | 28.6 | 0.690 | 2.101 | 0.101 | 28.6 * sqrt((0.101 + sqrt(0.010 + 4))/2) = 28.6 * sqrt((0.101 + 2.003)/2) = 28.6 * sqrt(1.052) = 28.6 * 1.026 = **29.3 Hz** |
| 120" | 27.4 | 0.660 | 2.296 | 0.296 | 27.4 * sqrt((0.296 + sqrt(0.088 + 4))/2) = 27.4 * sqrt((0.296 + 2.022)/2) = 27.4 * sqrt(1.159) = 27.4 * 1.077 = **29.5 Hz** |

### Summary Table

| Cabinet Height | Vb/driver | Fc | Qtc | F3 (free-field) | Assessment |
|---------------|-----------|-----|------|-----------------|------------|
| **72" (6 ft)** | 9.5 cu ft | 30.5 Hz | 0.735 | 29.4 Hz | Near-optimal Butterworth (0.707). Compact. Manageable weight. |
| **96" (8 ft)** | 12.7 cu ft | 28.6 Hz | 0.690 | 29.3 Hz | Slightly underdamped. Flatter response. More room gain benefit. |
| **120" (10 ft)** | 16.0 cu ft | 27.4 Hz | 0.660 | 29.5 Hz | Floor-to-ceiling. Overdamped -- earlier rolloff per octave but lower Fc. Heaviest. |

**Key observation:** F3 is nearly identical across all three heights (~29.3-29.5 Hz free-field) because the lower Fc with larger volumes is offset by the lower Qtc producing earlier rolloff slope. The practical difference is in the shape of the rolloff -- higher Qtc (72") has a slight shelf bump near Fc that helps, while lower Qtc (120") rolls off more gradually.

**With room gain:** The room's first length mode at 24.6 Hz and width mode at 33.2 Hz will provide significant reinforcement. Sealed sub + room gain typically extends effective F3 by 5-8 Hz in a well-pressurized room. Effective in-room F3 would be approximately 22-24 Hz for all three heights.

### Recommendation

**72" (6 ft) is the recommended height.** Rationale:
1. Qtc of 0.735 is closest to the ideal 0.707 Butterworth alignment -- flattest passband response.
2. F3 is essentially identical to larger cabinets.
3. Manageable size: 24"x24"x72" weighs ~220 lbs loaded (vs ~310 lbs for 96", ~400+ lbs for 120").
4. Fits through standard doorways without tilting.
5. 6 ft height leaves 4 ft of open wall above for treatment or aesthetics.
6. Less floor area impact -- same 24"x24" footprint regardless.
7. The POR triangular columns were spec'd at 96" but used polyfill to create virtual volume. With rectangular 24x24 cabinets, the 72" natural volume already provides near-optimal alignment without relying on polyfill tricks.

**Note:** The POR document (03_Subwoofer_System.md) claims Fc=30 Hz, Qtc=0.72 with 10.25 cu ft/driver using polyfill in the triangular columns. Our 72" rectangular cabinet gives 9.5 cu ft/driver -- close to the same, yielding very similar Fc=30.5 and Qtc=0.735. This confirms alignment.

### Cross-check with Task-Supplied T/S (Vas=15.5 cu ft, Qts=0.36)

If these values were correct:

| Height | Vb/driver | Vas/Vb | Fc | Qtc |
|--------|-----------|--------|-----|------|
| 72" | 9.5 | 1.632 | 22*sqrt(2.632) = 35.7 | 0.36*sqrt(2.632) = 0.584 |
| 96" | 12.7 | 1.220 | 22*sqrt(2.220) = 32.8 | 0.36*sqrt(2.220) = 0.537 |
| 120" | 16.0 | 0.969 | 22*sqrt(1.969) = 30.9 | 0.36*sqrt(1.969) = 0.505 |

These would all be significantly overdamped (Qtc ~0.5-0.58), yielding early, gentle rolloff with poor bass extension. This doesn't match the POR's performance claims and confirms the **task-supplied T/S parameters appear incorrect** -- the spec sheet values (Vas=8.77 cu ft, Qts=0.53) should be used.

---

## D. ELECTRICAL LOAD ANALYSIS

### Panel Specification

**Correction applied:** The actual feed is 60A, NOT 100A. The existing building has a 100A subpanel, but the feed from the house is limited (the task says 60A). The existing pool is on 30A/240V.

**NEC calculation cited in task:** 39.6A for theater loads.

### Load Schedule (60A feed)

| Circuit | Rating | Voltage | Load (Continuous) | Load (Peak) | NEC Continuous (80%) |
|---------|--------|---------|-------------------|-------------|---------------------|
| **Existing pool** | 30A | 240V | ~15A (typical pool pump) | ~25A (startup) | 24A |
| **Circuit A -- sub amps** | 20A | 240V | ~0.7A (175W idle / 240V) | ~10.4A (2,500W burst / 240V) | 16A |
| **Circuit HVAC** | 20A | 240V | ~3A (~720W typical) | ~10A (~2,400W startup) | 16A |
| **Circuit C -- AVR/ATI/DSP** | 20A | 120V | ~4A (~480W idle) | ~10A (~1,200W peak) | 16A |
| **Circuit D -- projector** | 20A | 120V | ~3.8A (~450W) | ~3.8A | 16A |
| **Circuit F -- gym** | 20A | 120V | ~2A | ~5A | 16A |

### NEC Load Calculation (240V circuits on 60A feed)

The 60A feed is 240V single-phase, so both 120V and 240V circuits draw from it.

**Peak demand scenario** (simultaneous worst-case):

| Load | Amps @ 240V equivalent |
|------|----------------------|
| Pool pump (running) | 15A |
| Sub amps (burst) | 10.4A |
| HVAC (startup -- worst case overlap) | 10A |
| AVR + ATI + DSP (peak, 120V = half @ 240V) | 5A |
| Projector (120V = half @ 240V) | 1.9A |
| Gym (120V = half @ 240V) | 1A |
| **Total peak** | **43.3A** |

**NEC continuous load (80% rule):**
Continuous loads at 80% of breaker: pool (24A x 240V) + sub amps idle + HVAC running + AVR/ATI running.
Pool: 15A + HVAC: 3A + Sub amps: 0.7A + AVR/ATI: 2.5A + projector: 1.9A + gym: 1A = **24.1A continuous**
80% of 60A = 48A. 24.1A continuous < 48A. **PASSES.**

**Peak demand:** 43.3A < 60A. **PASSES** -- but with only 16.7A margin, and the pool pump + HVAC startup overlap is the worst case. In practice, pool pump runs on a timer and HVAC startup is brief (< 1 sec inrush).

### FLAG: Pool + Theater Startup Conflict

If the pool pump starts simultaneously with the HVAC condenser (both have motor inrush):
- Pool inrush: ~75A LRA (typical for 1.5 HP pool pump, 240V)
- HVAC inrush: ~25-30A LRA (MrCool 12K inverter-driven -- lower than fixed-speed)
- Combined: could momentarily exceed 60A feed

**Mitigation:** Pool pump is on a timer. Schedule pool to not overlap with typical theater use (evening hours). HVAC inrush is brief and inverter-driven (soft start). In practice, this is a non-issue -- but worth noting.

### FLAG: 100A Panel vs 60A Feed

Multiple documents (CLAUDE.md, 06_Electronics_and_Control.md, 14_Quick_Reference.md) say "100A subpanel." The task instruction says "60A feed." These need reconciliation:
- If the PANEL is 100A but the FEEDER from the house is 60A, the panel has capacity but the feed limits total draw.
- If 100A is the correct feed, then all margin calculations above are trivially satisfied.
- **This must be verified at the panel.** The nameplate on the main breaker feeding the subpanel (at the house's main panel) determines the actual limit.

---

## E. GAIN STAGING

### Signal Path: X6800H Sub Pre-Out -> Wondom APM2 -> ADAU1701 -> ICEpower 1200AS2

**Correction applied per task:** DSP is 2x Wondom APM2 (with ADAU1701), NOT ADAU1452 board. The APM2 is powered from ICEpower AUX5V (DVDD 5V rail).

#### Stage 1: X6800H Sub Pre-Out

| Parameter | Value | Source |
|-----------|-------|--------|
| Output voltage (typical) | 2.0 Vrms | Denon X6800H spec sheet |
| Output impedance | ~470 ohm (typical Denon AVR) | Denon specs |
| Maximum output | ~6.5 Vrms (at 0 dB volume, some channels) | Typical for current Denon |

At typical listening levels (~-15 to -20 dB on volume), sub pre-out is approximately **0.5-1.5 Vrms**.

#### Stage 2: Wondom APM2 (ADAU1701) ADC Input

| Parameter | Value | Source |
|-----------|-------|--------|
| ADC input range | 1.0 Vrms (2.83 Vpp) max -- ADAU1701 spec | Analog Devices ADAU1701 datasheet |
| ADC resolution | 24-bit (5.23 fixed-point internal) | ADAU1701 datasheet |
| Input impedance | ~10 kohm (typical for ADAU1701 reference design) | Wondom schematic |
| Full-scale | 0.9 Vrms = 0 dBFS | ADAU1701 datasheet |

**FLAG: POTENTIAL CLIPPING.** The X6800H sub pre-out delivers 2.0 Vrms nominal. The ADAU1701 ADC clips at ~0.9-1.0 Vrms (0 dBFS). At full volume, the AVR will drive **2x the ADAU1701 ADC input range**, causing hard digital clipping.

**Mitigation options:**
1. **Resistive voltage divider** at APM2 input (e.g., 10k/10k = -6 dB, bringing 2V down to 1V). Simple, cheap, but adds noise.
2. **Reduce X6800H sub output level** in the AVR menu (-6 to -10 dB). Loses dynamic range.
3. **Use the APM2 J3 header** per the known correction -- the APM3 has an analog bypass flaw, so connecting RCA directly to APM2 J3 pins is recommended. However, this doesn't solve the voltage mismatch.
4. **External attenuator** (passive line-level pad). Clean, ~$20.

**This is a CRITICAL gap that must be resolved before installation.** Without attenuation, the system will clip on any moderately loud bass content.

#### Stage 3: ADAU1701 DSP Internal

| Parameter | Value |
|-----------|-------|
| Word length | 28-bit (5.23 fixed-point) |
| Dynamic range | ~144 dB (theoretical) |
| Processing | HPF, PEQ, gain, routing |
| Digital headroom | 5 bits integer = +24 dBFS above 0 dBFS (but ADC limits input) |

No gain issues internal to DSP -- digital domain has ample headroom.

#### Stage 4: ADAU1701 DAC Output

| Parameter | Value | Source |
|-----------|-------|--------|
| DAC output range | 1.0 Vrms (2.83 Vpp) max | ADAU1701 datasheet |
| Output impedance | ~100 ohm | ADAU1701 reference design |

At 0 dBFS: ~0.9 Vrms output.

#### Stage 5: ICEpower 1200AS2 Input

| Parameter | Value | Source |
|-----------|-------|--------|
| Input sensitivity | 5.0 Vp (3.54 Vrms) for full power (1200W @ 4 ohm) | ICEpower datasheet |
| Input impedance | 38 kohm per leg (balanced) | ICEpower datasheet |
| Voltage gain | 25.8 dB (19.5x) | ICEpower datasheet |

**Full power into 8 ohm (620W):** Requires output voltage of sqrt(620 * 8) = 70.4 Vrms. At 25.8 dB gain (19.5x), input needed = 70.4 / 19.5 = **3.61 Vrms**.

**ADAU1701 DAC output:** 0.9 Vrms max.

**Maximum amplifier output from DAC-limited input:** 0.9 * 19.5 = 17.55 Vrms. Power into 8 ohm = 17.55^2 / 8 = **38.5W**.

**FLAG: SEVERE GAIN STAGING MISMATCH.** The ADAU1701 DAC can only deliver 0.9 Vrms, but the ICEpower 1200AS2 needs 3.61 Vrms for full power at 8 ohm. This means the amplifier can only deliver **38.5W per channel** -- roughly 6% of its rated output. The system loses approximately **12 dB of potential output**.

**This is a SHOW-STOPPING issue with the Wondom APM2/ADAU1701 as the sub DSP.** The ADAU1452 + CS42448 combo (from POR doc 15) solves this because the CS42448 DAC has higher output (per the research doc, it can swing 2+ Vrms). But with 2x APM2 as specified in the corrections, the voltage is too low.

**Resolution options:**
1. **Use ADAU1452 + CS42448 board** (original POR) -- CS42448 DAC has higher output. Output specs: ~2 Vrms differential, ~1.4 Vrms single-ended. Still short of 3.61 Vrms needed.
2. **Add DRV134 balanced line drivers** (as designed in the research doc) powered by ICEpower AVDD/AVSS. DRV134 can output up to ~10 Vrms balanced. This solves the voltage mismatch.
3. **Reduce 1200AS2 input sensitivity** -- not adjustable on the module.
4. **Accept reduced headroom** -- 38.5W into 8 ohm with 8 drivers + boundary gain may still be sufficient for 95 dB target.

Let me check option 4: 38.5W per channel into 8 ohm (2 drivers in series). Per driver: 19.25W.
SPL per driver: 87.7 + 10*log10(19.25) = 87.7 + 12.8 = 100.5 dB @ 1m.
Per corner (2 drivers): 103.5 dB.
+ corner loading (+11 dB): 114.5 dB.
+ 4-corner summing (+6 dB): 120.5 dB at passband.
After sealed rolloff at 20 Hz (~-6 dB): ~114.5 dB.

Still +9.5 dB above 105 dB THX reference. **The system works even at 38.5W/ch, but with reduced headroom.** The "weapons-grade" margin is gone.

**Verdict:** The APM2 gain staging is workable but suboptimal. The DRV134 balanced driver stage (powered by ICEpower AVSS/AVDD, as designed in the research doc) is needed for full headroom. **The original POR's ADAU1452 + CS42448 + DRV134 architecture solves both issues -- the "correction" to 2x APM2 introduces a gain staging problem that didn't exist in the original design.**

---

## F. SPECIFICATION GAPS

### Asserted But Not Calculated

| Assertion | Location | Status |
|-----------|----------|--------|
| "Corner loading: +11 dB boundary gain" | CLAUDE.md, 03_Subwoofer_System.md | **Plausible but unverified for this room.** Three-boundary loading (floor + 2 walls) theoretically gives +9 dB (3 dB per boundary). +11 dB implies additional gain from room pressurization. Measurement needed. |
| "~+6 dB acoustic summing from 4 corners" | CLAUDE.md | **Correct for coherent addition of 4 identical sources at wavelengths >> room dimensions.** Below ~25 Hz (wavelength > 45 ft > 23 ft room), summation is pressure-zone, yielding +12 dB (4 sources). Above ~50 Hz, summation drops toward +6 dB. The +6 dB figure is conservative. |
| "113 dB @ 20 Hz at MLP" | Multiple docs | **Not independently calculated with full rigor.** Depends on room gain, boundary loading, sealed rolloff, and amplifier output -- all estimated. Directionally correct. |
| "+0.3 dB room gain vs reference" | Garage Conversion, Option D | **Formula unclear.** Room gain difference between 3,910 cu ft and 4,160 cu ft rooms is 10*log10(4160/3910) = 0.27 dB. Close enough to +0.3 dB. |
| "STC 45-50 for partition wall" | 16_HVAC_Plan_Theater.md | **Plausible.** 2x6 wall with R-19 + drywall both sides typically achieves STC 45-50. Not a measurement, but industry standard. |

### Missing Entirely

| Gap | Impact | Notes |
|-----|--------|-------|
| **Gain staging analysis** | CRITICAL | No document traces signal voltage through the chain. The APM2 -> 1200AS2 mismatch is unaddressed. |
| **Sub cabinet height decision** | HIGH | 72", 96", and 120" all listed as options. No calculation or decision. |
| **ADAU1701 vs ADAU1452 for Option D** | HIGH | POR doc 15 designs for ADAU1452. Task correction says 2x APM2 (ADAU1701). These are fundamentally different boards with different I/O counts, voltage levels, and capabilities. |
| **Chassis design for 1200AS2 modules** | MEDIUM | Budget includes $200 for chassis, but no design, thermal analysis, or heatsink specification. |
| **Condensate routing plan** | MEDIUM | HVAC doc mentions gravity drain through partition wall, but no specific routing or condensate pump decision. |
| **Cable schedule** | MEDIUM | No document lists specific cable runs, lengths, or routing for the equipment closet -> theater path. |
| **Projector throw distance** | MEDIUM | 170" 16:9 screen at 10.5 ft Row 1 and 15 ft Row 2, but projector position and throw ratio for JVC NZ500 not verified. |
| **JVC NZ500 throw ratio check** | MEDIUM | NZ500 has 1.4:1-2.8:1 throw ratio. For 170" 16:9 (148" width = 12.3 ft), throw distance = 12.3 * 1.4 to 12.3 * 2.8 = 17.2 to 34.4 ft. Room depth is 23 ft. Projector needs to mount at ~17-23 ft from screen. This works if mounted at rear wall or slightly forward. |
| **Equipment closet thermal analysis** | LOW | 750W idle in a 4'x4'x10' closet (160 cu ft) will raise temperature significantly. Ventilation strategy mentioned ("ventilation to gym space") but not designed. |
| **Bass shaker wiring topology** | LOW | 8 shakers on 1 ICEpower channel -- wiring configuration (series/parallel/series-parallel) and resulting impedance not specified. |
| **APM2 power from ICEpower 5V** | LOW | Stated correction, but ADAU1701 power consumption vs DVDD 5V @ 1A capacity not verified. ADAU1701 draws ~100-150 mA @ 3.3V (internal LDO). Board total may be ~300 mA @ 5V. Fits within 1A limit. |

---

## G. TRADEOFF ANALYSIS

### Decisions Made and Rejected Alternatives

#### 1. Processor: X6800H vs A1H

**Decision:** X6800H ($3,700) + ATI AT525NC (owned) over A1H ($6,500).

**What was rejected:** AVR-A1H as unified processor/amplifier.

**Why:** Saves $2,800. ATI NCore provides better LCR amplification (200W NCore vs 150W internal). Trade: loses 2 middle height channels (9.4.4 vs 9.4.6). At 23' depth, middle heights have more value than in shorter rooms, but 4 heights are still adequate.

**Assessment:** Sound decision. The ATI is already owned (sunk cost), and NCore amplification is genuinely superior for LCR. The channel count reduction is the weakest point -- at 23' depth, the middle height pair would meaningfully improve overhead coverage.

#### 2. Sub Amps: ICEpower 1200AS2 vs NX6000D

**Decision:** 5x ICEpower 1200AS2 ($1,865 + $200 chassis) over 5x NX6000D ($2,595 + $180 fans + ~$150 trigger mod).

**What was rejected:** NX6000D platform (6 units in POR Rev 7.0).

**Why (per investigation verdict):**
- No infrasonic derating (1200AS2 maintains 620W to 20 Hz; NX6000D drops to ~750W at 20 Hz, ~600W at 15 Hz)
- Zero modifications (fanless, no DSP bypass, 240V native)
- Half idle power (175W vs 300-375W)
- Single 240V circuit vs two 120V circuits
- ~$800-1,000 cost savings

**Assessment:** Well-supported by the investigation. The NX6000D's power advantage above 30 Hz is irrelevant due to massive boundary gain headroom. Below 20 Hz, 1200AS2 equals or exceeds NX6000D. The zero-mod aspect is underappreciated -- 12 fan swaps + custom trigger box + DSP bypass is significant real work.

**Risk:** 1200AS2 continuous power is 280W combined (both channels). Movie content crest factor means sustained power rarely exceeds this, but extended test tones could trigger thermal protection. The investigation acknowledges this and prescribes proper heatsinking + ventilated closet.

#### 3. Sub DSP: ADAU1452 vs DSP-408 + miniDSP

**Decision:** ADAU1452 as unified sub DSP (POR doc 15).
**Correction (task):** 2x Wondom APM2 (ADAU1701).

**What was rejected:** Dayton DSP-408 ($250) + miniDSP 2x4 HD ($200).

**Why:** DSP-408 has 20 Hz minimum HPF -- can't do 5 Hz subsonic protection or 10 Hz tactile HPF. ADAU1452 filters to DC. Eliminates two boxes with one. Cost savings: $450 -> $60 (ADAU1452) or $90 (2x APM2).

**Assessment:** The ADAU1452 is clearly the right chip. The APM2 correction introduces problems (see gain staging section). If APM2 is used, the 2-in/4-out limitation means 2 boards are needed for 4-in/8-out, and the gain staging requires external attenuation/amplification.

#### 4. Room Layout: N-S Partition (Option D) vs E-W Partition (POR)

**Decision:** N-S partition giving 17'x23' theater + 12'x23' gym.

**What was rejected:** E-W partition giving 14'x25' theater + 8'x26' gym.

**Why:**
- Larger theater closer to reference design (17' width vs 14')
- Better room ratio (1:1.7:2.3 vs 1:1.4:2.5)
- Functional gym (12' depth fits power rack properly)
- $12,100 less out-of-pocket (no WC, no vestibule, simpler construction)
- Equipment closet better isolated from theater (behind partition wall on gym side)

**Trade-offs:**
- No WC (walk to house; can add later)
- 2' less depth (23' vs 25'), tight rear clearance
- No light-lock vestibule
- Less property value add

**Assessment:** Strong decision. The 17' width is a significant improvement for screen size (170" 16:9 fits with 28" per side clearance vs 17.4" in 14' room) and speaker placement. The $12K savings is substantial. The WC deferral is pragmatic -- it can be added to the gym side later without touching the theater.

#### 5. Bass Plan: Defer Nearfield, Reduce Shakers

**Decision:** Defer 4 nearfield UMII18-22 drivers + enclosures. Reduce shakers from 16 to 8.

**What was rejected:** Full 12-driver sub system + 16 shakers.

**Why (per investigation verdict):**
- 8 corner subs deliver 113 dB @ 20 Hz -- +8 dB over reference target
- Nearfield value is qualitative, not quantified
- 1 shaker per seat is community standard; 2/seat marginal benefit unproven
- Space reserved for nearfield -- add post-build if chest-compression effect is missed

**Assessment:** Prudent. The immediate savings are $560 (shakers) + $1,600 deferred (nearfield drivers + cabinets). The nearfield deferral is reversible -- space is reserved, spare amp module available.

#### 6. HVAC: MrCool DIY 12K on Partition Wall

**Decision:** MrCool DIY 12K BTU, 230V, wall-mount on partition wall (west wall of theater), painted flat black.

**What was rejected:**
- Pioneer WYS 12K (R-410A end-of-life, not DIY, 1 dB noise difference is imperceptible)
- Ducted mini-split ($4,700-6,100, no DIY, lose room independence)
- Behind-screen installation (overcrowded, condensate risk, poor serviceability)
- Ceiling cassette (not available in Quick Connect)
- 9K unit ($30 savings, short-cycling risk)

**Assessment:** Well-investigated decision. The MrCool DIY Quick Connect is uniquely suited to a homeowner build -- no EPA 608 certification, no vacuum pump, no brazing. The 23.5 dB(A) silent mode is excellent. The partition wall placement is superior to behind-screen (better airflow, simpler condensate, easier service access). The $234/yr warranty maintenance cost is a real ongoing expense that should be budgeted.

#### 7. Screen: 170" 16:9 vs 170" 2.35:1

**Decision (Option D):** 170" 16:9 AT screen.

**What changed from POR:** POR Rev 7.0 specified 170" 2.35:1. Option D switches to 16:9 because:
- 17' screen wall accommodates full 170" 16:9 (12.3 ft width, 28" clearance per side)
- 16:9 content (TV, gaming) uses full screen area
- 2.35:1 scope movies letterbox within 16:9 frame

**Assessment:** Reasonable for a multi-use theater. Pure cinema enthusiasts would prefer 2.35:1 with masking for 16:9 content, but for a system that will see significant TV and gaming use, 16:9 is more practical. The $1,500 corrected price (up from $1,000) is still reasonable for a 170" AT screen.

#### 8. Projector: JVC NZ500 vs High-End ($25-30K)

**Decision:** JVC DLA-NZ500 at $5,999.

**What was rejected:** $25-30K projector budget (POR Rev 7.0).

**Why:** Native 4K D-ILA, laser, 40,000:1 native contrast ratio. In a fully dark dedicated theater, native contrast matters more than brightness. The NZ500 represents the sweet spot for dark-room performance. The $24K savings vs a $30K projector is reinvested elsewhere or saved.

**Assessment:** Excellent value decision. The NZ500 is widely regarded as best-in-class for dedicated dark rooms under $10K. For 170" screen at 15 ft throw, it has adequate brightness (~1,900 lumens) on an AT screen (which loses ~1-1.5 stops vs solid screen). Worth noting that AT screen brightness loss means a brighter projector might be preferred for HDR content.

---

## New Grad's Take

This system is impressive in its thoroughness, but I'd flag a few things that make me nervous:

**The gain staging gap is the scariest thing here.** Nobody documented the actual voltages at each point in the chain, and depending on whether APM2 or ADAU1452 is the real DSP, you could be either clipping the input or starving the amplifier. This is the kind of thing that "works on the bench" with test tones and then distorts badly on the first explosion in a movie. I'd want this fully prototyped and measured before committing to a build.

**The T/S parameter confusion worries me.** Two different sets of T/S parameters floating around (Vas=8.77 vs 15.5 cu ft, Qts=0.53 vs 0.36) could lead to building enclosures that perform very differently than expected. I'd verify against the actual Dayton spec sheet and, ideally, measure the two owned drivers with a DATS or similar impedance jig.

**The 60A vs 100A feed needs to be physically verified.** Reading a breaker label takes 30 seconds. If it's really 60A and the pool pump is on the same feed, the margin is thin enough that a future addition (gym HVAC, more outlets) could require an expensive panel/feeder upgrade.

**One thing I love:** the deferral strategy. Building the 8-corner system first, living with it, then deciding on nearfield subs is exactly the right approach. You can't un-build, but you can always add.

---

## Senior's Take

Three things matter here, and only three:

**1. The DSP architecture must be settled before anything else.** The POR says ADAU1452 + CS42448. The task correction says 2x Wondom APM2 (ADAU1701). These are fundamentally different architectures with different I/O counts, voltage levels, and DSP capacity. The ADAU1701 is a learning/prototype platform (2-in/4-out, 1024 instructions, 1V output). The ADAU1452 + CS42448 is the production platform (4-in/8-out, 6144 instructions, higher output voltage). Using APM2 boards in production forces you to daisy-chain two boards, add external attenuation at the input, and accept voltage-limited output -- creating three new integration problems to save $30. Unless there's a specific reason to avoid the ADAU1452, the POR's original architecture is correct and the "correction" should be reversed.

**2. The budget arithmetic error ($590 discrepancy) is not financially material but signals document drift.** When Phase 2 subtotals don't match the grand total, it means the document was edited in pieces without a final reconciliation pass. In a project with 20+ source documents, this kind of drift compounds. Recommend a single reconciliation pass across all Option D numbers -- a spreadsheet, not prose tables.

**3. The 72" cabinet height is the right call, but the real question is build sequence.** These are 220-lb boxes that need to be built in a workshop and transported to the theater. The 24"x24" footprint fits through a 36" door. The 72" height is manageable for two people. But the sequence matters: sub cabinets should be placed BEFORE the riser platform goes in, BEFORE carpet, and BEFORE the partition wall gets its theater-side finishing. Get the heavy stuff in first. This isn't a spec issue -- it's a construction sequencing issue that no document addresses.

Everything else -- the HVAC choice, the projector choice, the bass deferral strategy, the amplifier platform -- is well-supported by the investigation framework. The adversarial investigation process works. The system will be excellent. Just settle the DSP question and verify the feeder breaker.
