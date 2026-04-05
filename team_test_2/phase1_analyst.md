# Baseline Analysis: Option D Home Theater Design

**Date:** 2026-03-14
**Analyst Role** | Sources: 13 documents across POR/, investigations/, CLAUDE.md

---

## A. BUDGET BASELINE

Option D is the active design: 17'x23'x10' theater (east side) + 12'x23' gym (west side), N-S partition, 9.4.4 Dolby Atmos.

### Phase 1 — Building Prep ($11,059)

| # | Item | Cost | Source |
|---|------|------|--------|
| 1 | Right garage door removal + seal exterior | $800 | GC_Option1.md:1063 |
| 2 | N-S partition wall framing (2x6, 23' run) | $400 | GC_Option1.md:1064 |
| 3 | Partition insulation (R-19) + vapor barrier | $500 | GC_Option1.md:1065 |
| 4 | Partition drywall + finish (both sides) | $600 | GC_Option1.md:1066 |
| 5 | Equipment closet framing + door (4x4) | $400 | GC_Option1.md:1067 |
| 6 | Equipment closet finish + cable pass-throughs | $300 | GC_Option1.md:1068 |
| 7 | MrCool DIY 12K system | $2,359 | GC_Option1.md:1069, 16_HVAC:154 |
| 8 | HVAC hardware (disconnect, breaker, wire, etc.) | $200 | GC_Option1.md:1070 |
| 9 | 240V circuit for condenser | $600 | GC_Option1.md:1071 |
| 10 | Circuit A — sub amps (20A/240V) | $400 | GC_Option1.md:1072 |
| 11 | Circuit C — processor/amps/DSP (20A/120V) | $400 | GC_Option1.md:1073 |
| 12 | Circuit D — projector (20A/120V) | $400 | GC_Option1.md:1074 |
| 13 | Circuit F — gym (20A/120V) | $400 | GC_Option1.md:1075 |
| 14 | Theater carpet + pad (391 sq ft) | $1,000 | GC_Option1.md:1076 |
| 15 | Paint (theater + equip closet) | $200 | GC_Option1.md:1077 |
| 16 | Trim + baseboards (theater only) | $200 | GC_Option1.md:1078 |
| 17 | Interior door (equipment closet) | $200 | GC_Option1.md:1079 |
| 18 | Lighting (theater + gym) | $700 | GC_Option1.md:1080 |
| 19 | Permits (building + electrical + HVAC) | $800 | GC_Option1.md:1081 |
| 20 | Plans (simplified scope) | $400 | GC_Option1.md:1082 |
| | **Phase 1 Total** | **$11,059** | GC_Option1.md:1083 |

### Phase 2 — Home Theater ($25,565 remaining spend)

| Category | Cost | Source |
|----------|------|--------|
| Projector & screen (JVC NZ500 + 170" AT) | $7,599 | GC_Option1.md:582 |
| Processor & DSP (X6800H + Dirac + ADAU1452) | $4,707 | GC_Option1.md:594 |
| Speakers (10x Volt-10 + isolation) | $2,504 | GC_Option1.md:606 |
| Sub drivers (6x UMII18-22, 4 NF deferred) | $2,100 | GC_Option1.md:613 |
| Sub amps (5x ICEpower 1200AS2 + chassis) | $2,065 | GC_Option1.md:627 |
| Sub enclosures (4 columns, NF deferred) | $1,400 | GC_Option1.md:639 |
| Bass shakers (8x Aura Pro + wiring) | $660 | GC_Option1.md:650 |
| Seating (2 couches) | $2,000 | GC_Option1.md:660 |
| Theater construction (stage + riser) | $2,040 | GC_Option1.md:671 |
| Infrastructure & wiring | $1,080 | GC_Option1.md:683 |
| **Phase 2 Remaining Spend** | **$25,565** | GC_Option1.md:699 |
| **Phase 2 Already Owned** | **$13,450** | GC_Option1.md:700 |
| **Phase 2 Total System Value** | **$39,015** | GC_Option1.md:701 |

### Grand Total

| | Remaining Spend | Already Owned | Total Value |
|---|----------------|---------------|-------------|
| Phase 1 | $11,059 | -- | $11,059 |
| Phase 2 | $25,565 | $13,450 | $39,015 |
| **Grand Total** | **$36,624** | **$13,450** | **$50,074** |

Source: GC_Option1.md:1094-1098

### Already-Owned Equipment

| Item | Value | Source |
|------|-------|--------|
| 3x DIYSG Titan-815LX (LCR) | $4,800 | GC_Option1.md:567 |
| ATI AT525NC (5ch x 200W NCore) | $2,500 | GC_Option1.md:568 |
| 2x Dayton UMII18-22 (sub drivers) | $700 | GC_Option1.md:569 |
| Acoustic treatment materials | $4,250 | GC_Option1.md:570 |
| Denon X4700 (spare, 9x125W) | $1,200 | GC_Option1.md:571 |
| **Total** | **$13,450** | |

### Bass Deferral Savings

| Deferred Item | Cost Deferred | Source |
|---------------|---------------|--------|
| 4x UMII18-22 nearfield drivers | $1,400 | GC_Option1.md:615 |
| 2 nearfield enclosures | $400 | GC_Option1.md:641 |
| 8 shakers (16->8 reduction) | $560 | bass-plan-overkill verdict:78 |
| **Total Deferred** | **$2,360** | |

These items are excluded from the $36,624 out-of-pocket. They can be added post-build if validated.

### Budget Flags (Issues Found)

**FLAG 1: Document Conflicts — Multiple Budget Systems**

The Rev 7.0 reference budget (11_Budget_Summary.md) shows $72K total with a $30K projector and NX6000D amps + DSP-408. Option D (GC_Option1.md) shows $50K total with a $6K projector, ICEpower 1200AS2 amps, ADAU1452, and X6800H. These are two different designs sharing the same POR folder. The reference docs (03_Subwoofer_System.md, 05_Speaker_System.md, 06_Electronics_and_Control.md, 11_Budget_Summary.md, 14_Quick_Reference.md) all describe the **Rev 7.0 reference** design (A1H, NX6000D, 9.4.6), NOT the Option D design. Option D has diverged significantly but the reference POR docs have not been updated to reflect Option D's choices.

Specific conflicts:
- 06_Electronics_and_Control.md: NX6000D platform, AVR-A1H, DSP-408. Option D uses ICEpower 1200AS2, X6800H, ADAU1452.
- 11_Budget_Summary.md: $72K with $30K projector. Option D is $50K with $6K projector.
- 14_Quick_Reference.md: 9.4.6 with A1H. Option D is 9.4.4 with X6800H.
- 03_Subwoofer_System.md: 16 drivers, 6x NX6000D, 16 shakers. Option D initial build: 8 drivers, 5x 1200AS2, 8 shakers.
- 05_Speaker_System.md: A1H internal amps for all channels. Option D uses ATI AT525NC for LCR+FW.

**FLAG 2: Electrical Circuits Don't Match**

GC_Option1.md Phase 1 (Option D budget, lines 1072-1075) lists:
- Circuit A: 20A/240V (sub amps)
- Circuit C: 20A/120V (processor)
- Circuit D: 20A/120V (projector)
- Circuit F: 20A/120V (gym)

But the POR Phase 1 (lines 517-522) lists:
- Circuit A: 20A/120V (sub amps 1)
- Circuit B: 20A/120V (sub amps 2)
- Circuit C: 20A/120V (processor)
- Circuit D: 20A/120V (projector)
- Circuit F: 20A/120V (WC + gym)

The POR budget still has Circuit B ($400) and 120V sub amp circuits reflecting the NX6000D design, not the ICEpower 240V single-circuit design. Option D correctly uses a single 240V circuit but dropped Circuit B — saving $400 — yet total is still $11,059.

**FLAG 3: HVAC Condenser Circuit Overlap**

Option D line 9 ($600) is "240V circuit for condenser." But line 8 ($200) is "HVAC hardware (disconnect, breaker, wire, raceway, condensate)" — the disconnect and breaker ARE the electrical components of the circuit. The $600 for "240V circuit" appears to be labor+materials for the wire run from panel to condenser, but this seems high for a 15-30 ft run at DIY. Combined $800 for a short 240V circuit + disconnect is generous. Comparable to the $400 budgeted for each 120V circuit, plus disconnect hardware.

**FLAG 4: Option D Phase 2 Total Doesn't Match Line Items**

Phase 2 line items sum: $7,599 + $4,707 + $2,504 + $2,100 + $2,065 + $1,400 + $660 + $2,000 + $2,040 + $1,080 = **$26,155**. But GC_Option1.md:1097 states Phase 2 remaining spend = **$25,565**. That's a **$590 discrepancy**. The Phase 2 line items appear to be the POR's Phase 2 (which totals $26,155 at line 699), while Option D's grand total references $25,565. The Option D sub enclosures use stacked rectangular boxes ($350 each x4 = $1,400) — same as the POR. The $590 gap is unexplained; likely a stale number from a prior version.

**FLAG 5: Seating Budget May Be Low**

Two 4-seat couches at $1,000 each ($2,000 total, GC_Option1.md:658-660). For 8 seats total, that's $250/seat. Used couches or budget options can hit this, but it's tight for anything that supports bass shaker mounting (rigid frame needed). Worth flagging as a potential underspend.

**FLAG 6: 170" Screen Spec Change**

The reference design uses a 170" 2.35:1 AT screen ($3,000 budget in 11_Budget_Summary.md:76). Option D uses a 170" 16:9 AT screen ($1,000 + $500 shipping, GC_Option1.md:578-579). These are different aspect ratios and significantly different prices. The 16:9 screen is physically larger (more fabric, bigger frame) — $1,000 for a 170" 16:9 AT screen seems aggressively low.

---

## B. PERFORMANCE BASELINE (Per Subsystem)

### LCR: Titan-815LX (3 speakers)

| Metric | Value | Source |
|--------|-------|--------|
| Sensitivity | 99 dB @ 2.83V/1m | 05_Speaker_System.md:28 |
| Impedance | 6 ohm nominal, 4.2 ohm minimum | 05_Speaker_System.md:29-30 |
| Power handling | 400W (with 80 Hz crossover) | 05_Speaker_System.md:31 |
| Amplifier | ATI AT525NC, ~300W @ 6 ohm | GC_Option1.md:209 |
| SPL @ 1m | ~124 dB | GC_Option1.md:211 |
| SPL @ Row 1 (10.5 ft from screen) | ~108 dB | GC_Option1.md:212 |
| SPL @ Row 2 (15 ft from screen) | ~104 dB | GC_Option1.md:213 |
| Headroom over 95 dB target | +9 to +13 dB | GC_Option1.md:214 |
| Crossover | 60-80 Hz | 05_Speaker_System.md:33 |
| Cabinet tuning | 40 Hz (ported) | 05_Speaker_System.md:32 |

**Assessment:** Excellent. NCore amplification into 99 dB speakers provides massive headroom. Even at full reference (105 dB), Row 1 would have +3 dB headroom.

### Surrounds + Atmos + Front Wides: Volt-10 (10 speakers)

| Metric | Value | Source |
|--------|-------|--------|
| Sensitivity | 95 dB @ 2.83V/1m | 05_Speaker_System.md:70 |
| Impedance | 8 ohm | 05_Speaker_System.md:71 |
| Power range | 10-450W | 05_Speaker_System.md:72 |
| FW amplifier | ATI AT525NC, ~200W @ 8 ohm | GC_Option1.md:208 |
| Surr/Atmos amplifier | X6800H internal, ~100-140W @ 8 ohm | GC_Option1.md:220-221 |
| SPL @ ~7 ft (surrounds, 17' room) | ~110 dB | GC_Option1.md:224 |
| Headroom over 95 dB target | +13 to +15 dB | GC_Option1.md:225 |

**Assessment:** Strong. The narrower room (17' vs reference 16') places surrounds closer to MLP (~8.5 ft vs 8 ft), slightly increasing headroom. Timbral matching across all 10 surround/Atmos channels is excellent (identical model).

### Subwoofer System (Initial: 8 drivers)

| Metric | Value | Source |
|--------|-------|--------|
| Driver | Dayton UMII18-22 | 03_Subwoofer_System.md:41-42 |
| Fs | 22 Hz | 03_Subwoofer_System.md:51 |
| Xmax | 28 mm (Klippel verified) | 03_Subwoofer_System.md:56 |
| Xmech (estimated) | ~35-40 mm | 03_Subwoofer_System.md:87 |
| Configuration | 4 stacked rectangular cabinets, 2 drivers each, all 4 corners | GC_Option1.md:963-970 |
| Volume per driver | ~8.5 cu ft | GC_Option1.md:972 |
| Wiring | 8 ohm series per cabinet | GC_Option1.md:972 |
| Boundary loading | +11 dB corner gain + ~6 dB acoustic summing | GC_Option1.md:263 |
| SPL @ 20 Hz @ MLP | ~113 dB | GC_Option1.md:277 |
| Headroom over THX 105 dB | +8 dB @ 20 Hz | GC_Option1.md:280 |
| Bass extension (-3 dB) | ~15 Hz | GC_Option1.md:279 |

**Key constraint:** Xmax (28 mm) is the binding limit below ~13 Hz, not amplifier power (03_Subwoofer_System.md, CLAUDE.md). No amount of additional amplification extends infrasonic output below the Xmax wall.

**Room mode analysis (17' x 23' x 10'):**
- Axial modes: 33.0 Hz (width), 24.6 Hz (length), 56.5 Hz (height)
- First tangential: ~41.2 Hz
- Bolt ratio (1 : 1.7 : 2.3): Good distribution. No dimension is a simple multiple of another. The 1.7:2.3 width:length ratio avoids degenerate mode stacking.

### Amplification (Sub System)

| Metric | Value | Source |
|--------|-------|--------|
| Platform | ICEpower 1200AS2 | GC_Option1.md:621-627 |
| Modules | 5 total (3 active corner+shaker + 2 spare) | GC_Option1.md:343-348 |
| Power @ 8 ohm (240V burst) | ~620W/ch | nx6000d-vs-icepower verdict:28 |
| Power @ 8 ohm @ 15 Hz | 620W (no derating) | nx6000d-vs-icepower verdict:28 |
| Power @ 8 ohm @ 20 Hz | 620W (no derating) | nx6000d-vs-icepower verdict:27 |
| Idle power (5 units) | ~175W | nx6000d-vs-icepower verdict:49 |
| Electrical | 1x 20A/240V circuit | nx6000d-vs-icepower verdict:51, GC_Option1.md:431 |
| Modifications required | Zero (fanless, no DSP bypass, 240V native) | nx6000d-vs-icepower verdict:36-43 |

**Watts available vs watts needed (corner subs):**
- Available: 620W/ch x 4 channels = 2,480W total to 8 drivers
- Per driver: ~310W
- Driver rating: 1,200W RMS
- Utilization: 26%
- At -10 dB target, utilization drops further. Thermal headroom is massive.

**Assessment:** Clean match. No infrasonic derating means rated output all the way to DC (limited by ADAU1452 HPF setting, not amp). The 2 spare modules provide redundancy and a ready nearfield expansion path.

### DSP

| Metric | Value | Source |
|--------|-------|--------|
| Sub DSP | ADAU1452 | GC_Option1.md:356-358 |
| Bit depth | 8.24 fixed-point | CLAUDE.md (DSP notes) |
| Filter floor | DC (no 20 Hz HPF limit) | GC_Option1.md:358 |
| Channels | 8 in / 8 out (using ~10% instruction budget) | GC_Option1.md:358 |
| Biquad format | [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy | CLAUDE.md |
| Transport | PC -> SigmaStudio COM -> USBi/ICP5 -> I2C/SPI -> DSP | CLAUDE.md |
| Room correction | Dirac Live Full + Bass Control + ART | GC_Option1.md:311-313 |
| Processor DSP | X6800H internal (13.4ch processing) | GC_Option1.md:307-308 |

**Assessment:** The ADAU1452 eliminates the DSP-408's 20 Hz HPF floor and the need for a separate miniDSP, consolidating sub processing into a single board at $60. This is a significant simplification over the Rev 7.0 reference stack (DSP-408 $250 + miniDSP $200).

### Room Acoustics

| Metric | Value | Source |
|--------|-------|--------|
| Room dimensions | 17' x 23' x 10' | GC_Option1.md:897-900 |
| Volume | 3,910 cu ft | GC_Option1.md:902 |
| Room ratio | 1 : 1.7 : 2.3 | GC_Option1.md:903 |
| RT60 target | Not specified | -- |
| Acoustic treatment (owned) | $4,250 in materials | GC_Option1.md:570 |
| Corner sub treatment | OC 703 on sub cabinet faces | 03_Subwoofer_System.md:576-585 |
| First reflection management | Not explicitly designed | -- |
| Soundproofing | Not required (detached building) | GC_Option1.md:44 |
| Partition wall STC | ~45-50 (2x6 + R-19 + drywall both sides) | 16_HVAC:227, GC_Option1.md:1145 |

**Note:** RT60 target is not stated anywhere in the POR documents. For a dedicated theater of this size, typical target is 0.3-0.4 seconds (mid-frequencies). The $4,250 in owned treatment materials should achieve this, but no RT60 calculation or target is documented.

---

## C. TRADEOFF ANALYSIS

### What Was Chosen vs Rejected

| Decision | Chosen | Rejected | Why | Source |
|----------|--------|----------|-----|--------|
| Processor | X6800H ($3,700) | AVR-A1H ($6,500) | -$2,800, ATI covers LCR better than A1H internal | GC_Option1.md:326-337 |
| LCR amp | ATI AT525NC (NCore 200W, owned) | A1H internal (150W) | Better amp, already owned ($0) | GC_Option1.md:207-214 |
| Atmos config | 9.4.4 | 9.4.6 | Dropped middle heights, adequate at 25' depth, saves $484 + $2,800 | GC_Option1.md:329-337 |
| Sub amps | ICEpower 1200AS2 | NX6000D | No derating below 30Hz, fanless, zero mods, -$1,769 | nx6000d-vs-icepower verdict |
| Sub DSP | ADAU1452 ($60) | DSP-408 + miniDSP ($450) | Filters to DC, single board, -$390 | GC_Option1.md:356-358 |
| Nearfield subs | Deferred | Build immediately | Qualitative value unproven, add post-build if missed | bass-plan-overkill verdict |
| Shakers | 8 (1/seat) | 16 (2/seat) | 1/seat is community standard, -$560 | bass-plan-overkill verdict |
| HVAC | MrCool DIY 12K, partition wall mount | Pioneer WYS / behind-screen / ducted | DIY install (no contractor), 23.5 dB(A), Quick Connect | hvac-theater-setup verdict |
| HVAC placement | Partition wall, 7-8' high | Behind AT screen | Better airflow, serviceability, no vent engineering | 16_HVAC:199-211 |
| 9K vs 12K HVAC | 12K | 9K | $30 delta, short-cycling risk on nighttime loads | 16_HVAC:43-68 |
| Room layout | N-S partition (17'x23') | E-W partition (14'x25') | Larger theater, better ratio, functional gym, -$12K | GC_Option1.md:1100-1117 |
| Projector | JVC NZ500 ($6K) | $30K flagship (deferred) | Best native 4K D-ILA in class, 40K:1 CR | GC_Option1.md:578 |
| Screen AR | 170" 16:9 | 170" 2.35:1 | Full-size for TV/gaming, scope letterboxes within | GC_Option1.md:910-915 |

### Current Known Weaknesses / Compromises

1. **Rear clearance behind Row 2:** Only ~1 ft behind Row 2 to south exterior wall (GC_Option1.md:933). Tight for rear treatment and seat recline. Reducible by shrinking stage (3' -> 2.5') or row spacing (4.5' -> 4').

2. **No light-lock vestibule:** 36" door opens directly into theater (GC_Option1.md:1131). Light bleed during entry is managed by "door closed during use" but not architecturally prevented.

3. **No WC:** Walk to house. Can add to gym side later (~$3,500, GC_Option1.md:1149-1152).

4. **Partition wall as theater side wall:** FWL and SL speakers mount on the partition wall that separates from gym. Gym noise (weights dropping) could transmit. STC 45-50 should handle it but is not acoustically tested. (GC_Option1.md:1135, 1141)

5. **Stacked rectangular sub cabinets vs triangular columns:** Option D uses simpler boxes (GC_Option1.md:978-983) but loses the integrated acoustic treatment (~88 sq ft OC 703) that the triangular columns provided (03_Subwoofer_System.md:584). This treatment must come from the separately-owned treatment materials.

6. **4 height channels vs 6:** Dropped middle heights (TML/TMR). At 23' depth this is a real compromise for overhead effects that pan front-to-rear — 6 heights would provide better granularity. The $484 savings is small relative to the experiential loss.

7. **ICEpower 1200AS2 thermal management:** Modules in a 4'x4' closet need ventilation. 175W idle + burst heat needs a path to gym space (nx6000d-vs-icepower verdict:116-119). No specific ventilation design is documented.

8. **ADAU1452 requires SigmaStudio + USBi:** Programming and calibration requires a Windows PC running SigmaStudio 4.7 with a USBi programmer. This is a specialized tool chain, not a consumer-friendly DSP like the DSP-408's web interface.

### Post-Build Adjustable vs Locked at Construction

| Locked at Construction | Adjustable Post-Build |
|------------------------|----------------------|
| Room dimensions (17'x23'x10') | Nearfield sub addition (space reserved) |
| Partition wall location and construction | Shaker count (8->16) |
| Electrical circuits (must be roughed in) | Projector upgrade (ceiling mount is standard) |
| HVAC lineset route and wall penetrations | External LCR amps via X6800H pre-outs |
| Screen wall width (17') | DSP tuning (ADAU1452 reprogrammable) |
| Corner sub placement (defines boundary loading) | Dirac calibration |
| Carpet (under riser, hard to replace) | Acoustic treatment placement |
| Equipment closet location | Seating |
| Stage/riser dimensions | WC addition (gym side, plumbing rough-in later) |

---

## D. SPECIFICATION GAPS

### Specs Stated But Not Verified With Calculations

1. **"~113 dB @ 20 Hz @ MLP"** (GC_Option1.md:277) — This number is inherited from the reference design's triangular corner columns. Option D uses stacked rectangular cabinets with ~8.5 cu ft/driver (GC_Option1.md:972) vs 10.25 cu ft/driver in triangular columns (03_Subwoofer_System.md:402). Lower volume means higher Fc and less output at 20 Hz. The 113 dB figure needs recalculation for the Option D enclosure geometry.

2. **Room gain "+0.3 dB vs reference"** (GC_Option1.md:904) — Stated without showing the calculation. Room gain is frequency-dependent. At 3,910 cu ft vs 4,160 cu ft, the difference at 20 Hz is:
   - Delta = 10 * log10(4160/3910) = +0.27 dB. This checks out.

3. **ATI AT525NC "~300W @ 6 ohm"** (GC_Option1.md:209) — The ATI is rated 200W @ 8 ohm. 300W @ 6 ohm assumes linear impedance scaling (200W * 8/6 = 267W) plus some current headroom. Actual NCore output into 6 ohm is typically ~250-280W. The 300W figure is optimistic. Impact: ~0.5 dB less headroom than claimed. Not material.

4. **SPL @ Row 1 "~108 dB"** for LCR (GC_Option1.md:212) — Calculation: 99 dB + 10*log10(300) = 99 + 24.8 = 123.8 dB @ 1m. Distance to Row 1: 10.5 ft = 3.2 m. Distance loss: 20*log10(3.2) = -10.1 dB. Room gain at mid frequencies: ~+3 dB (typical). Result: 123.8 - 10.1 + 3 = ~116.7 dB. The claimed ~108 dB appears conservative by ~8 dB. Either the room gain assumption is very pessimistic, or the power assumption is lower than stated. At 200W (not 300W): 99 + 23 - 10.1 + 3 = ~114.9 dB. Still higher than 108 dB. This number may assume all-channels-driven power (~100W into 6 ohm) rather than single-channel, which would give: 99 + 20 - 10.1 + 0 = ~108.9 dB. If so, **the headroom figure assumes worst-case power with no room gain** — a conservative but inconsistent methodology (room gain is real and measured).

5. **Partition wall STC "45-50"** (GC_Option1.md:1145, 16_HVAC:227) — Stated as approximate for "2x6 with R-19 + drywall both sides." Standard STC for this assembly is ~45 (without decoupling). With resilient channel or double-stud, 50+ is achievable. The range is reasonable but the gym-side use case (free weights dropping at ~100+ dB peak) means the actual acoustic isolation should be calculated for impact noise (IIC), not just airborne (STC).

### Claims Referencing "Datasheet" Without Specific Numbers

1. **NX6000D ULF derating table** (03_Subwoofer_System.md:260-270) — The power-vs-frequency table shows precise percentages (88% at 20 Hz, 71% at 15 Hz) but cites no source. These appear to be estimates from forum data, not Behringer specifications. However, this is largely academic since Option D uses ICEpower, not NX6000D.

2. **Volt-10 "95 dB sensitivity"** — Cited as "DIYSG official spec" (05_Speaker_System.md:70). DIYSG product pages are the source. No independent measurement is available.

### Missing Specifications

| Missing Spec | Impact | Notes |
|-------------|--------|-------|
| **Wire gauge for speaker runs** | Low | POR Phase 2 lists "12 AWG" speaker wire (GC_Option1.md:680) but no cable run lengths are calculated. At 17' x 23', longest run (rear Atmos to equipment closet) is ~30 ft. 12 AWG is adequate. |
| **Cable run lengths (per channel)** | Low | Not documented. Needed for wire purchase quantities and voltage drop verification. |
| **Rack depth** | Low | "Open frame" rack at $550 (GC_Option1.md:677). No depth spec. ATI AT525NC is 16" deep; X6800H is ~17" deep. Standard 42U open frame handles both. |
| **RT60 target** | Medium | No RT60 target documented anywhere. Critical for treatment design. |
| **Equipment closet ventilation design** | Medium | Heat load stated as "~750W idle" (GC_Option1.md:390) but ventilation is "grille to theater" or "dedicated exhaust" — no specific design. |
| **Condensate routing plan** | Low | "Gravity drain through partition wall to gym side" (GC_Option1.md:1053) — no specific design. |
| **Sub cabinet internal bracing** | Low | Option D stacked rectangular cabinets — no bracing spec. The triangular columns had detailed bracing documentation. |
| **HDMI cable spec/length** | Low | "HDMI cables (source -> AVR, AVR -> projector)" at $80 (GC_Option1.md:681). For 4K/120Hz over 15+ ft, fiber HDMI may be needed. $80 may be insufficient. |
| **Projector throw distance verification** | Medium | JVC NZ500 at 10.5' from 170" 16:9 screen. Throw ratio for NZ500 is ~1.4-2.8:1. Screen width = 12.3 ft. At 10.5' throw: ratio = 10.5/12.3 = 0.85 — this is BELOW the minimum throw ratio. Projector likely mounts further back (Row 1 area, ~14 ft from screen). At 14': 14/12.3 = 1.14 — still below 1.4 minimum. **This needs verification. The NZ500 may not fill a 170" 16:9 screen at this room depth without an anamorphic lens.** |
| **UPS sizing for equipment closet** | Low | "UPS" listed in closet contents (GC_Option1.md:388) but no VA rating, no line item in budget. |
| **Network switch spec** | Low | Listed in closet (GC_Option1.md:388) but no budget line item. |

---

## New Grad's Take

### What I'd Change

- **Dirac Live licensing model ($799 extra):** This is a 2020s-era shakedown. StormAudio, Trinnov, and even JBL Synthesis include room correction in the processor price. The X6800H already ships with Audyssey MultEQ XT32 — which is good enough for 90% of use cases. Dirac ART is genuinely better for bass management, but $799 for software on a $3,700 receiver is a 22% tax. Consider running Audyssey first, buying only Bass Control ($299) if needed, and skipping Full + ART unless measurement shows clear deficiency. **Potential savings: $500.**

- **ADAU1452 via SigmaStudio is a niche toolchain.** The miniDSP SHD or DDRC-24 provides similar sub-20Hz DSP capability with a web UI, OTA updates, and Dirac integration. The ADAU1452 is cheaper ($60 vs ~$600) but the SigmaStudio + USBi dependency is a maintenance and knowledge burden. If this system needs to work for 10+ years, the person maintaining it needs to be comfortable with SigmaStudio COM scripting. There's a reason the consumer market moved to app-controlled DSP.

- **JVC NZ500 at $6K in 2027:** By the time this builds, the NZ500 will be 2+ years old. The NZ700/NZ800 successor line (or equivalent) will likely offer better HDR tone mapping, frame interpolation, and laser engine improvements. Budget $6K but don't buy the projector until construction is 90% complete. Also look at Hisense/Formovie UST laser TV — the 150" Hisense PX3-PRO is $4K and eliminates the throw distance problem entirely.

- **$1,000 for a 170" 16:9 AT screen is unrealistic.** The cheapest name-brand 170" AT screens (Silver Ticket, Elite Screens) start at $1,500-2,000 for 16:9. DIY stretch-frame with AT fabric is possible at $1,000 but requires sourcing Seymour or XY Screens fabric and building a frame. Budget should be $1,500-2,000 unless DIY frame is the plan.

### What's Outdated Here

- **SpeakON connectors for sub cabling ($100):** These are pro audio connectors that require soldering or crimp tools. Modern installs use banana plugs or push terminals for DIY. SpeakON is only relevant if using NX6000D (which has SpeakON outputs). The ICEpower 1200AS2 uses screw terminals. Remove this line item or reallocate.

### Risk I'm Willing to Take

- **Drop the spare ICEpower module ($373).** If a module fails, Parts Express ships one in 3 days. The $373 sitting on a shelf earns 0% return. You're not running a concert venue — downtime is "no movies for 3 days." Buy a replacement if/when needed.

### I'll Concede

- The DIYSG speaker platform (Titan + Volt) is genuinely the best value in home theater speakers. No commercial brand comes close to 99 dB sensitivity at $1,600/speaker or 95 dB coaxials at $242. The DIY build adds labor but the performance/$$ ratio is unmatched. This is NOT an area where "newer" means "better."

---

## Senior's Take

### Keep It Simple

- **The document sprawl is the biggest risk.** There are 5+ POR documents describing a Rev 7.0 reference design that is NOT what's being built. Option D has diverged significantly (different processor, different amps, different DSP, different channel count, different room) but lives as a section inside `Garage_Conversion_Option1.md` rather than as its own clean specification. When construction starts, the builder needs ONE document with ONE set of numbers. Reconcile the POR docs to Option D or clearly mark them as superseded. Otherwise someone (Andy, in 6 months) will wire for NX6000D because that's what `06_Electronics_and_Control.md` says.

- **The Phase 2 budget discrepancy ($590) is a symptom.** Multiple budget tables exist across multiple files with different totals. A single source-of-truth budget spreadsheet (even a CSV) that all documents reference would prevent this drift.

### Contracts & Interfaces

- **Equipment closet to theater cable interface:** The partition wall is the contract boundary between equipment and theater. Document every penetration: how many holes, what gauge conduit, what cables pass through, and where they terminate on each side. This is the kind of thing that's trivial to plan and painful to fix after drywall.

- **Sub amp to ADAU1452 signal routing:** The ADAU1452 sits between the X6800H sub pre-outs and the ICEpower modules. What are the input/output voltage levels? The X6800H sub pre-outs are 2V RMS nominal. The ADAU1452 operates at line level. The 1200AS2 input sensitivity is ~1V for full output. There may be a gain staging issue — if the ADAU1452 outputs 2V and the 1200AS2 clips at 1V input, you need an attenuator or gain trim. **This interface is not documented.**

### Test First

- **Before buying ICEpower modules:** Verify the 1200AS2 input sensitivity spec. If it's truly 1V for full output, the X6800H's 2V pre-out + ADAU1452 passthrough will overdrive it. A $10 resistive attenuator fixes this, but only if you know about it before first power-on.

- **Before finalizing room layout:** Mock up the rear clearance. Place chairs 1 ft from a wall and sit for 2 hours. If it's claustrophobic, adjust stage depth or row spacing BEFORE pouring concrete anchors.

- **Before committing to 170" 16:9:** Verify the JVC NZ500 throw distance. My napkin math (see Gap section) suggests the NZ500 cannot fill 170" 16:9 at this room's working distances without modification. This is a show-stopper if true.

### Data Design

- The budget should be a structured data file (JSON, CSV, or YAML) with categories, line items, unit costs, quantities, and status (owned/to-buy/deferred). All documents should reference this single source. The current approach — budget tables embedded in multiple markdown files — guarantees drift. This isn't over-engineering; it's data hygiene.

### I'll Concede

- The ICEpower 1200AS2 decision is well-reasoned. The investigation was rigorous, the revised weighting for infrasonic performance is correct, and the zero-mod advantage is real. Fanless, no DSP bypass, native 240V, single circuit — this is exactly the kind of "simpler, fewer moving parts" solution I advocate. The NX6000D would have required 12 fan swaps + a custom trigger box + DSP bypass configuration across 6 units. The investigation process (adversarial, quantified, revised) is a good model for future decisions.

---

**Analysis complete.** Key finding: Option D is a well-optimized design at $36,624 out-of-pocket, but the POR documentation suite has not been updated to reflect Option D's divergent choices, creating significant confusion risk at build time. The projector throw distance gap (Section D) should be investigated immediately as it may force a screen size or aspect ratio change.
