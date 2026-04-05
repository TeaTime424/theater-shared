# POR Consolidated Summary
## Source: All POR docs + CLAUDE.md, read 2026-03-20

**Active design:** Option D (N-S partition, 17'×23' theater) — supersedes POR Rev 7.0 reference design
**Build target:** 2027

---

## 1. Room & Layout

### Option D (ACTIVE)
| Parameter | Value | Source |
|-----------|-------|--------|
| Building | 29'×23'×10' detached garage | Garage_Conversion_Option1.md |
| Theater zone | 17'×23'×10' (3,910 cu ft) | Option D section |
| Gym zone | 12'×23' (276 sq ft) | Option D section |
| Equipment closet | 4'×4' in NE corner of gym | Option D section |
| Partition | N-S wall at ~12' from west wall, 2×6 stud, R-19, drywall both sides | Option D section |
| Screen wall | North wall (17' wide) | Option D section |
| Seating faces | North | Option D section |
| Room ratio H:W:D | 1 : 1.7 : 2.3 | Option D section |

### Seating Geometry (Option D)
| Row | From North Wall | From Screen | Viewing Angle (170" 16:9) |
|-----|----------------|-------------|--------------------------|
| Row 1 (MLP) | 14.0' | 10.5' | 61° (IMAX-class) |
| Row 2 | 18.5' | 15.0' | 45° (THX Ideal+) |

| Dimension | Value |
|-----------|-------|
| Stage depth | 3' |
| Screen surface | 3.5' from north wall |
| Row spacing | 4.5' |
| Riser front edge | 16.0' from north wall |
| Riser depth | 4.5' |
| Space behind Row 2 | ~1.0' (tight — rear exterior wall) |

### POR Reference Room (Rev 7.0 — superseded but referenced)
- 16'×26'×10' (4,160 cu ft) — from 01_Project_Overview_and_Room.md (Rev 5.2 extract, states 16'×26')
- NOTE: 00_Master_Index.md states "16' × 26' × 10'" for the reference design; 01_Project_Overview_and_Room.md confirms same
- CONTRADICTION FLAG: CLAUDE.md states reference room as 17'×23'×10' (3,910 cu ft) — this is the Option D room, not the Rev 7.0 reference. The Rev 7.0 reference POR room is 16'×26'.

---

## 2. Screen & Projector

### Screen
| Parameter | POR (Rev 7.0) | Option D |
|-----------|--------------|----------|
| Size | 170" 2.35:1 AT | 170" 16:9 AT |
| Width | ~148" (12.3') | 148" (12.3') — same width, different AR |
| Height | ~63" | 83" |
| Frame + fabric cost | $3,000 (11_Budget) | $1,000 (Garage_Conversion) |
| Source | 05_Speaker_System, 11_Budget | Garage_Conversion_Option1 |

### Projector
| Parameter | Value | Source |
|-----------|-------|--------|
| POR reference budget | $30,000 (2027 flagship, model TBD) | 06_Electronics, 11_Budget |
| Option D selection | JVC DLA-NZ500 (native 4K D-ILA, laser, 40,000:1 CR) | Garage_Conversion_Option1 |
| Option D cost | $5,999 | Garage_Conversion_Option1 |
| Throw distance | **NOT DOCUMENTED** — projector deferred to 2027 | All POR docs |
| Power | ~400–450W | 06_Electronics, electrical_load_analysis |

---

## 3. Speakers

### Speaker Matrix (applies to both POR and Option D)
| Channel Group | Model | Qty | Sensitivity | Impedance | Unit Cost | Total |
|---------------|-------|-----|-------------|-----------|-----------|-------|
| LCR | DIYSG Titan-815LX | 3 | 99 dB @ 2.83V/1m | 6Ω nominal (4.2Ω min) | ~$1,600 | $4,800 |
| Surrounds | DIYSG Volt-10 V2 | 4 | 95 dB @ 2.83V/1m | 8Ω | $242 | $968 |
| Atmos (Rev 7.0) | DIYSG Volt-10 V2 | 6 | 95 dB | 8Ω | $242 | $1,452 |
| Atmos (Option D) | DIYSG Volt-10 V2 | 6 (same) | 95 dB | 8Ω | $242 | $1,452 |
| Sorbothane pucks | 50 duro hemispheres | 12 | — | — | $7 | $84 |
| **Total speakers** | | **13** | | | | **$7,304** |

**STALE FLAG:** Volt-10 sensitivity was previously listed as 98 dB in v1 docs. Correct value is **95 dB** per DIYSG official spec. All Rev 7.0+ docs and Option D use 95 dB.

### Titan-815LX Key Specs
| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 99 dB @ 2.83V/1m | Matt Grant, HiFi Circuit forum Aug 2023 |
| Impedance | 6Ω nominal | Matt Grant |
| Minimum impedance | 4.2Ω @ 110 Hz | Matt Grant |
| Power handling | 400W (with 80 Hz crossover) | Matt Grant |
| Cabinet tuning | 40 Hz (ported) | Matt Grant |
| Recommended crossover | 60–80 Hz | Matt Grant |
| CRITICAL NOTE | Ported — do NOT stuff line panels | CLAUDE.md |

### Configuration
- **Rev 7.0 POR:** 9.4.6 — AVR-A1H drives all 15 channels internally
- **Option D:** 9.4.4 — AVR-X6800H (8ch internal) + ATI AT525NC (LCR + FWL + FWR via pre-outs), drops TML/TMR middle heights

---

## 4. Processor & Speaker Amplification

### Option D (ACTIVE)
| Component | Spec | Cost |
|-----------|------|------|
| Denon AVR-X6800H | 13.4ch processing, 11ch × 140W @ 8Ω, 4 independent sub outputs, 13.4ch pre-outs | $3,700 |
| ATI AT525NC | 5ch × 200W NCore (LCR + FWL + FWR) | $0 (owned) |
| Dirac Live Full Bandwidth | Full-range room correction | $349 |
| Dirac Live Bass Control | Multi-sub optimization | $299 |
| Dirac Live ART | Active Room Treatment | $299 |
| **Dirac bundle** | | **$799** |
| Denon X4700 | 9×125W backup (owned) | $0 (owned) |

### Rev 7.0 POR (reference, superseded by Option D)
- Denon AVR-A1H: 15.4ch, 150W × 15 @ 8Ω, MSRP ~$6,500
- All 15 channels internal — no external speaker amps
- Total with Dirac: ~$7,300

### SPL Headroom (Option D)
| System | Config | Power | SPL @ 1m | SPL @ Row 1 | SPL @ Row 2 | vs 95 dB Target |
|--------|--------|-------|-----------|-------------|-------------|-----------------|
| LCR (ATI NCore) | 6Ω | ~300W | ~124 dB | ~108 dB | ~104 dB | +9 to +13 dB |
| Surr/Atmos (X6800H) | 8Ω | ~100–140W | ~117 dB | ~110 dB | — | +13 to +15 dB |

---

## 5. Subwoofer System

### Driver: Dayton Audio UMII18-22

#### Thiele-Small Parameters (VERIFIED from spec sheet)
| Parameter | Value | Notes |
|-----------|-------|-------|
| Fs | 22 Hz | Free air resonance |
| Qts | **0.53** | Total Q — VERIFIED |
| Qes | 0.67 | Electrical Q |
| Qms | 2.53 | Mechanical Q |
| Vas | **248.2 L (8.77 ft³)** | Equivalent compliance volume — VERIFIED |
| Xmax | 28 mm | One-way, Klippel @ 70% BL |
| Sd | 1,184 cm² (183.5 sq in) | Effective radiating area |
| Vd | 3,315 cm³ | Peak-to-peak displacement volume |
| Re | 4.2Ω | DC resistance, coils in series |
| Mms | 420 g | Moving mass |
| BL | 19.2 T·m | Motor strength |
| Sensitivity | 90.7 dB @ 2.83V/1m | Manufacturer measured |
| Voice coil config | Dual 2Ω VCs | Series = 4Ω/driver; practical loads: 2Ω or 8Ω only |
| RMS power | 1,200W | AES 426B |
| Peak power | 2,400W | |
| Le @ 1 kHz | 1.15 mH | |
| VC diameter | 76 mm (3") | |

**STALE FLAG:** Any doc referencing Vas = 15.5 L or Qts = 0.36 is WRONG and stale. The correct values are Vas = 248.2 L and Qts = 0.53 from the official Dayton Audio spec sheet (Part #295-718).

### Corner Sub Configuration

#### Option D (ACTIVE) — Stacked Rectangular Cabinets
| Position | Drivers | Cabinet | Dimensions | Volume/driver |
|----------|---------|---------|------------|---------------|
| Screen left (NW corner) | 2× UMII18-22 stacked | Sealed | ~20"W × 20"D × 72"H | ~8.5 cu ft |
| Screen right (NE corner) | 2× UMII18-22 stacked | Sealed | same | ~8.5 cu ft |
| Rear left (SW corner) | 2× UMII18-22 stacked | Sealed | same | ~8.5 cu ft |
| Rear right (SE corner) | 2× UMII18-22 stacked | Sealed | same | ~8.5 cu ft |
| **Total corner drivers** | **8** | **4 cabinets** | | |

CONTRADICTION: CLAUDE.md states "24"×24"×72"" for cabinet dimensions; Option D section in Garage_Conversion_Option1.md states "~20"W × 20"D × 72"H". These are inconsistent.

Front pair doubles as screen wall structure. Stage deck spans between front cabinets. Wiring: 8Ω series (each VC series = 4Ω/driver; 2 drivers series = 8Ω/cabinet).

#### POR Rev 7.0 / Garage_Conversion POR section (superseded)
- 4× triangular floor-to-ceiling corner columns, 2 drivers per column
- 10.25 cu ft per driver, 96" height (floor-to-ceiling)
- Described in 03_Subwoofer_System.md (Rev 5.9 — STALE: still references NX6000D amps, 16 total drivers, triangular columns)

STALE FLAG: **03_Subwoofer_System.md is Rev 5.9, last updated December 2025.** It documents the old configuration: 16 drivers (not 8), 6× NX6000D (not ICEpower), triangular columns (not rectangular), 16× bass shakers (not 8). This doc contradicts Option D on nearly every sub system parameter.

### Nearfield Subs — DEFERRED
- 4× UMII18-22, forward-facing behind Row 1, full-width cabinet (8' wide × 12.5" deep × ~20" tall)
- Add post-build if needed ($1,400 drivers + $200 cabinet + repurpose spare amp)

### System Quantities
| Phase | Corner | Nearfield | Total |
|-------|--------|-----------|-------|
| Initial build (Option D) | 8 drivers | 0 (deferred) | **8** |
| With deferred nearfield | 8 drivers | 4 drivers | **12** |
| Already owned | 2 drivers | — | 2 |
| To purchase | 6 drivers | 0 (deferred) | **6** |

### Sub Performance (Option D)
| Metric | Value |
|--------|-------|
| Corner array @ 20 Hz @ MLP | ~113 dB |
| Nearfield @ 15 Hz @ 15" (deferred) | ~115+ dB |
| Bass extension (-3 dB) | ~15 Hz |
| Boundary loading | +11 dB corner gain + ~6 dB acoustic summing |
| System headroom vs reference (105 dB) | +8 dB @ 20 Hz at MLP |

---

## 6. Sub Amplification

### Option D (ACTIVE): 5× ICEpower 1200AS2
| Unit | Assignment | Load | Power/Ch |
|------|-----------|------|----------|
| #1 | Corner subs FL + FR | 8Ω series | ~620W |
| #2 | Corner subs RL + RR | 8Ω series | ~620W |
| #3 | Tactile (bass shakers) | varies | ~620W |
| #4 | Spare (nearfield if added) | — | — |
| #5 | Spare | — | — |

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| ICEpower 1200AS2 | 5 | $373 | $1,865 |
| Chassis + connectors | 5 | $40 | $200 |
| **Total** | | | **$2,065** |

Key specs: 240V native, fanless, 620W/ch @ 8Ω, no infrasonic derating (unlike NX6000D which drops to ~500–700W at 15 Hz).

### STALE: 03_Subwoofer_System.md still references 6× Behringer NX6000D
This is superseded. NX6000D is not the active amp platform.

---

## 7. Sub DSP

### Active: 2× ADAU1701 (Wondom APM2)
| Spec | Value |
|------|-------|
| DSP chip | ADAU1701 (5.23 fixed-point) |
| Board | Wondom APM2 (AA-AP23122), 2-in/4-out each |
| Total I/O | 4-in / 8-out (2 boards) |
| Sample rate | 48 kHz |
| Word length | 28-bit (5.23 fixed-point) |
| Instructions | 1,024 per board; design uses ~304 (30%) |
| Functions | HPF to 5 Hz, PEQ ×10/ch, gain, mono summing |
| Biquad convention | [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy |
| Self-boot | EEPROM (I2C) — no PC required after calibration |
| Calibration | Automated: Python + SigmaStudio COM + REW |

### Balanced Output Stage (Required — ADAU1701 internal DAC = 0.9 Vrms, ICEpower needs 3.54 Vrms)

**Option B (Preferred): Sonic Imagery Labs 898B**
- 8-ch unbalanced→balanced converter, RCA in / XLR out, +12 dB fixed gain, 1RU
- Output: ~3.6 Vrms differential → ~599W from ICEpower (99.7% of rated)
- Cost: $389 (898B) + ~$30 (XLR-to-JST cables) = **~$419**
- Build: Zero custom analog

**Option A (Fallback): DIY PCM5102 + THAT1646**
- I2S from ADAU1701 → PCM5102 external DAC (2.1 Vrms) → THAT1646 balanced drivers → 3.54 Vrms → 620W
- Cost: **$155**
- Build: ~15 hours, 4 perfboards, 8 DIP-8 ICs

**Total DSP BOM (Option B preferred):** $80 (2× APM2) + $445 (898B + cables) = **$525**
**Total DSP BOM (Option A fallback):** $80 + $135 = **$215**

CONTRADICTION: 06_Electronics_and_Control.md cost table shows ADAU1701 DSP + balanced output = $215 (Option A cost), while 15_DSP_Subwoofer_Processing.md shows Option B preferred at $525 and notes the BOM as $525 in the POR. The Option D Phase 2 budget (Garage_Conversion) uses $525 (line item 45: "2× ADAU1701 (APM2) + Sonic Imagery 898B balanced output = $525"). **Use $525 as the correct figure.**

STALE FLAG: Earlier docs reference DSP-408 + miniDSP 2×4 HD. These are fully replaced by the ADAU1701 platform. 06_Electronics_and_Control.md shows DSP-408 = $215 in the "Option D" cost column — this appears to be a transcription error in the doc (actually shows Option A DIY cost). 15_DSP doc is the authoritative source.

STALE FLAG: Version 1.0 of 15_DSP_Subwoofer_Processing.md specified a single ADAU1452. Version 2.0 replaced it with 2× ADAU1701. The ADAU1452 appears in Option D equipment closet contents list (line in Option D section of Garage_Conversion) — this is a stale reference from before v2.0 of POR/15.

### Channel Map (ADAU1701 system)
**APM2 #1 (Front):** Corner FL → Corner FR → NF Front (deferred) → Front tactile
**APM2 #2 (Rear):** Corner RL → Corner RR → NF Rear (deferred) → Rear tactile
HPF corners: 5 Hz BW2 | HPF tactile: 10 Hz BW2 | LPF nearfield/tactile: 80 Hz LR4

---

## 8. Tactile (Bass Shakers)

| Parameter | Option D | Source |
|-----------|---------|--------|
| Model | Aura Pro AST-2B-4 | Garage_Conversion_Option1 |
| Quantity | 8 (1/seat, 4 seats × 2 couches) | Option D — reduced from 16 |
| Amplifier | 1× ICEpower 1200AS2 (#3) | Option D |
| Bandwidth | 20–80 Hz (Fs = 40 Hz) | Garage_Conversion_Option1 |
| Unit cost | $70 | Garage_Conversion_Option1 |
| Total cost (shakers) | $560 | Garage_Conversion_Option1 |
| Wiring + connectors | $100 | Garage_Conversion_Option1 |
| **Shaker subtotal** | **$660** | Garage_Conversion_Option1 |
| Deferred upgrade | Double to 16 total (+$560 + $100 wiring) | Optional post-build |

STALE: 03_Subwoofer_System.md (Rev 5.9) and 04_Seating_and_Riser.md list 16× bass shakers. Option D reduced to 8. 04_Seating_and_Riser.md also still documents NX6000D amplification — stale.

---

## 9. HVAC

| Parameter | Value | Source |
|-----------|-------|--------|
| System | MrCool DIY 5th Gen 12K BTU, 230V single-zone | 16_HVAC_Plan_Theater.md |
| Model | DIY-12-HP-WM-230D25-O (E-Star) or DIYHH variant (Hyper Heat) | 16_HVAC |
| Refrigerant | R-454B (pre-charged, Quick Connect) | 16_HVAC |
| SEER2 | 23.5 | 16_HVAC |
| Voltage | 208–230V / 60Hz / 1-phase | 16_HVAC |
| Silent mode noise | 23.5 dB(A) | 16_HVAC |
| System package cost | ~$2,359 | 16_HVAC, Garage_Conversion Option D budget |
| Additional hardware | ~$175–280 | 16_HVAC |
| Total DIY installed | ~$2,550–2,650 | 16_HVAC |
| Garage_Conversion Option D line item | $2,359 (system) + $200 (hardware) = $2,559 | Garage_Conversion_Option1 Phase 1 |
| Head placement | Partition wall (west/theater side), 7–8' high, 2–4' south of screen wall, painted flat black | 16_HVAC |
| Outdoor condenser | North exterior wall | 16_HVAC |
| Lineset run | ~10–14 ft via gym (well within 25' Quick Connect limit) | 16_HVAC |
| Gym HVAC | Deferred — garage door ventilation now; add independent MrCool 12K (~$2,550) later | 16_HVAC, Option D budget |

CONTRADICTION: The task specification says "HVAC: MrCool system at $1,359." No POR doc contains this figure. All docs consistently cite ~$2,359 for the system package and ~$2,559 total with hardware. Flag: $1,359 does not appear anywhere in POR docs.

---

## 10. Electrical

### Option D Electrical Feed (from 06_Electronics, 16_HVAC, Garage_Conversion_Option1)
| Spec | Value | Source |
|------|-------|--------|
| Existing panel | 100A subpanel (Square D) already in detached building | Garage_Conversion_Option1 |
| Main feed to subpanel | #2 Al wire spec NOT stated in Option D docs | Rev6.0 consolidated states "#3 copper or #1 aluminum feeder" for 100A subpanel from main panel |
| Sub amps circuit | Circuit A: 20A / 240V (single circuit for all 5× ICEpower 1200AS2) | 06_Electronics, Garage_Conversion |
| Processor/amps/DSP | Circuit C: 20A / 120V | 06_Electronics, Garage_Conversion |
| Projector | Circuit D: 20A / 120V (dedicated ceiling run) | Garage_Conversion |
| HVAC | Circuit E: 20A double-pole / 240V (condenser) | 16_HVAC |
| Gym/GFI | Circuit F: 20A / 120V | Garage_Conversion |
| Panel headroom | ~70A after theater HVAC; ~75–80A after all electronics | 16_HVAC |

NOTE: The task spec mentions "#2 Al, 240V, 60A breaker at main panel" as the electrical feed spec. This does not appear verbatim in any active Option D POR doc. The Rev6.0 consolidated doc mentions "#3 copper or #1 aluminum" for the 100A feeder. The 16_HVAC doc specifies 20A double-pole for the HVAC circuit with 12 AWG wire. No POR document states "#2 Al at 60A" — this may refer to the main panel feed to the detached building's 100A subpanel, which is not specified in active docs.

### ICEpower 1200AS2 Power Budget
| Circuit | Idle total | Peak total |
|---------|-----------|-----------|
| Circuit A (5× ICEpower @ 240V) | ~140W | ~2,600W |
| Circuit C (AVR + ATI + DSP + sources) | ~154W | ~1,306W |

---

## 11. Budget

### Option D Budget (ACTIVE) — From Garage_Conversion_Option1.md

#### Phase 1 — Option D Building Prep
| Category | Cost |
|----------|------|
| Right garage door removal + seal | $800 |
| N-S partition wall framing (2×6, 23') | $400 |
| Partition insulation (R-19) + vapor barrier | $500 |
| Partition drywall + finish (both sides) | $600 |
| Equipment closet framing + door (4×4) | $400 |
| Equipment closet finish + cable pass-throughs | $300 |
| MrCool DIY 12K system | $2,359 |
| HVAC hardware (disconnect, breaker, wire, condensate) | $200 |
| 240V circuit for condenser | $600 |
| Circuit A — sub amps (20A/240V) | $400 |
| Circuit C — processor/amps/DSP (20A/120V) | $400 |
| Circuit D — projector ceiling run (20A/120V) | $400 |
| Circuit F — gym (20A/120V) | $400 |
| Theater carpet + pad (391 sq ft) | $1,000 |
| Paint (theater + equip closet) | $200 |
| Trim + baseboards (theater only) | $200 |
| Interior door (equipment closet) | $200 |
| Lighting (theater + gym) | $700 |
| Permits (building + electrical + HVAC) | $800 |
| Plans (simplified scope) | $400 |
| **Phase 1 — Option D Total** | **$11,059** |

#### Phase 2 — Option D Home Theater
| Category | Cost |
|----------|------|
| Projector & screen (JVC NZ500 + 170" 16:9 AT screen + mount) | $7,599 |
| Processor & DSP (X6800H $3,700 + Dirac $799 + ADAU1701+898B $525) | $5,172 (but note: Dirac bundle separately adds to $5,172 — see breakdown) |
| Speakers (10× Volt-10 + isolation pucks) | $2,504 |
| Sub drivers (6× UMII18-22 @ $350) | $2,100 |
| Sub amps (5× ICEpower 1200AS2 + chassis) | $2,065 |
| Sub enclosures (4 rectangular columns, nearfield deferred) | $1,400 |
| Bass shakers (8× Aura Pro + wiring) | $660 |
| Seating (2 couches) | $2,000 |
| Theater construction (stage + riser) | $2,040 |
| Infrastructure & wiring | $1,080 |
| **Phase 2 — Option D Remaining Spend** | **$25,565** (doc shows $26,620 in one table, $25,565 in grand total — see note) |

NOTE: The Phase 2 summary table in Garage_Conversion_Option1.md shows $26,620 as the Phase 2 line total (line 702), but the grand total table (line 1100) shows $25,565. The $26,620 figure includes $1,055 of detail not summed consistently in line 702. Use the grand total table as authoritative: Phase 2 remaining spend = **$25,565**.

#### Option D Grand Total
| Phase | Remaining Spend | Already Owned | Total Value |
|-------|----------------|---------------|-------------|
| Phase 1 — Building Prep | $11,059 | — | $11,059 |
| Phase 2 — Home Theater | $25,565 | $13,450 | $39,015 |
| **Grand Total** | **$36,624** | **$13,450** | **$50,074** |

Out-of-pocket: **~$36,600** (CLAUDE.md rounds to ~$36,600; Garage_Conversion shows $36,624)

#### Already Owned Inventory ($13,450)
| Item | Value |
|------|-------|
| 3× DIYSG Titan-815LX (LCR) | $4,800 |
| ATI AT525NC (5ch × 200W NCore) | $2,500 |
| 2× Dayton UMII18-22 (sub drivers) | $700 |
| Acoustic treatment materials | $4,250 |
| Denon X4700 (backup amp) | $1,200 |

---

### POR Rev 7.0 Budget (Reference Design — Superseded)
| Category | Cost |
|----------|------|
| Projector | $30,000 |
| LF System (16× UMII + NX6000D + shakers) | $12,327 |
| Speakers (LCR + Volt-10 surrounds/Atmos) | $7,304 |
| Electronics (AVR-A1H + Dirac + DSP-408) | $7,549 |
| Seating | $6,000 |
| Acoustic Treatment | $5,500 |
| Screen | $3,000 |
| Infrastructure | $3,300 |
| **Total Rev 7.0** | **~$72,000** |

STALE FLAG: 11_Budget_Summary.md lists "Sub DSP: Dayton DSP-408 = $250" in the Electronics line. DSP-408 is replaced by ADAU1701. The electronics cost figure of $7,549 includes stale components and does not reflect Option D costs.

STALE FLAG: 11_Budget_Summary.md also lists amplifiers as NX6000D in the LF System. This is superseded by ICEpower 1200AS2.

---

### POR (E-W Partition) Budget — Also Superseded
| Phase | Remaining Spend | Total Out-of-Pocket |
|-------|----------------|---------------------|
| Phase 1 (E-W partition, full build w/ WC) | $22,559 | |
| Phase 2 | $26,155 (doc) / $26,620 (table) | |
| **Grand Total** | **$48,714** | |

---

## 12. Performance Targets

| Metric | Target |
|--------|--------|
| Reference level | -10 dB Reference (95 dB at MLP) |
| LCR headroom | +9 to +13 dB above 95 dB target |
| Surround/Atmos headroom | +13 to +15 dB above target |
| Bass extension (-3 dB) | ~15 Hz |
| Bass headroom @ 20 Hz | +8 dB above 105 dB reference |
| Row 1 viewing angle | 61° (IMAX-class) |
| Row 2 viewing angle | 45° (THX Ideal+) |

---

## 13. Document Stale Flags (Contradictions & Outdated Content)

| Document | Issue |
|----------|-------|
| **03_Subwoofer_System.md** (Rev 5.9) | Describes old config: 16 drivers, 6× NX6000D, triangular columns, 16 bass shakers. Contradicts Option D on every major sub system parameter. |
| **04_Seating_and_Riser.md** (Rev 5.8) | References 16× bass shakers, NX6000D amp, triangular platform-penetrating columns, 16'×8' riser for 16' room. Does not reflect Option D room or sub config. |
| **00_Master_Index.md** | Lists 16× UMII18-22, 6× NX6000D, Denon AVR-A1H (not X6800H), DSP-408 + miniDSP. Points to old sub system. |
| **11_Budget_Summary.md** | Electronics includes DSP-408 ($250) and AVR-A1H ($6,500). LF system references NX6000D. Total $72,000 for reference design not Option D. |
| **06_Electronics_and_Control.md** | Signal flow diagram still shows AVR-X6800H (correct for Option D) but cost summary shows $215 for ADAU1701 (Option A DIY cost) — should be $525 for Option B (898B). Also mentions ADAU1452 in one signal flow reference (stale from DSP v1.0). |
| **02_Front_Stage_System.md** | Rev 5.2 extract — describes old room (16'×26'), Marantz AV10, PURIFI monoblocks, Buckeye amps, miniDSP Flex HT. Fully superseded. |
| **01_Project_Overview_and_Room.md** | Rev 5.2 extract — 16'×26' reference room, $75K–95K budget, THX Reference (115 dB) target. Superseded. |
| **05_Speaker_System.md** | Describes AVR-A1H driving all 15 channels (9.4.6). Option D uses X6800H + ATI (9.4.4). Speaker models and specs are correct. |
| **Garage_Conversion_Option1.md** — equipment closet (Option D section) | References "ADAU1452" in the closet contents list (line ~1007). Should be ADAU1701 (2× APM2). Stale from DSP v1.0. |
| **Garage_Conversion_Option1.md** — Phase 2 budget inconsistency | Phase 2 total shown as $26,620 in category table (line 702) but $25,565 in grand total table (line 1100). $1,055 discrepancy. Use $25,565 / $36,624 as authoritative. |
| **CLAUDE.md** room dimensions | States reference room as "17' × 23' × 10' (3,910 cu ft)" — this is Option D room dimensions, not the Rev 7.0 reference room (which is 16'×26'). CLAUDE.md context is Option D specific. |
| **HVAC $1,359** | The task prompt references "$1,359" for the MrCool system. This figure does not appear in any POR document. All docs show $2,359 for the system package. |

---

## 14. Key Technical Notes (Cross-Doc)

- **Sealed enclosures:** Room gain compensates natural rolloff; easier to EQ without sacrificing headroom
- **Corner loading:** +11 dB boundary gain + ~6 dB acoustic summing from 4 corners
- **UMII18-22 impedance:** Only 2Ω and 8Ω practical with dual 2Ω VCs; 4Ω impossible with 4 VCs in series
- **ICEpower 1200AS2:** No infrasonic derating at 15–20 Hz; fanless; 240V native
- **DSP biquad order:** [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy (ADAU1701 and ADAU1452 both)
- **ADAU1701 unity:** b0 = 0x00800000; 5.23 fixed-point
- **Driver excursion:** Xmax (28 mm) is binding constraint below ~13 Hz, not amplifier power
- **Dirac ART:** Requires Denon AVR-X6800H pre-out → ADAU1701 sub processing preserves 4-corner independence for Dirac Bass Control
- **ATI AT525NC NCore:** ~300W into 6Ω (LCR); ~200W into 8Ω (FW)
- **APM3 ditched:** Significant crosstalk; audio I/O via APM2 header pins directly
- **ICP5 programmer:** With Option B (898B), ICP5 can remain connected (no I2S conflict). With Option A, must be disconnected for audio (BCLK conflict) — use jumper switch.

---

*Summary generated from: CLAUDE.md, POR/Garage_Conversion_Option1.md (all sections including Option D), POR/00_Master_Index.md, POR/01_Project_Overview_and_Room.md, POR/02_Front_Stage_System.md, POR/03_Subwoofer_System.md, POR/04_Seating_and_Riser.md, POR/05_Speaker_System.md, POR/06_Electronics_and_Control.md, POR/11_Budget_Summary.md, POR/15_DSP_Subwoofer_Processing.md, POR/16_HVAC_Plan_Theater.md, POR/12_Technical_Appendix_Subwoofers.md, POR/electrical_load_analysis.md*
