# POR Core Extract — Task #9
Source docs: CLAUDE.md (Option D), Garage_Conversion_Option1.md, 01_Project_Overview_and_Room.md, 02_Front_Stage_System.md (no 02_Speakers.md/03_Sub.md/04_Amp.md — actual files are 05_Speaker_System.md, 03_Subwoofer_System.md, 06_Electronics_and_Control.md)

---

## Room Dimensions & Partition Layout

| Parameter | Value | Source |
|-----------|-------|--------|
| Theater dims | 17' × 23' × 10' | CLAUDE.md / Garage_Conversion_Option1.md |
| Theater volume | 3,910 cu ft | Garage_Conversion_Option1.md |
| Room ratio H:W:D | 1 : 1.7 : 2.3 | Garage_Conversion_Option1.md |
| Partition orientation | N-S, at ~12' from west wall | Garage_Conversion_Option1.md |
| Partition construction | 2×6 stud, floor-to-ceiling, 23' run | Garage_Conversion_Option1.md |
| Partition insulation | R-19 batts + 6-mil poly vapor barrier (theater side) | Garage_Conversion_Option1.md |
| Gym dims | 12' × 23' (276 sq ft usable) | Garage_Conversion_Option1.md |
| Equipment closet | 4' × 4', NE corner of gym | CLAUDE.md / Garage_Conversion_Option1.md |
| Theater entry | 36" personnel door, east wall | Garage_Conversion_Option1.md |
| Screen wall | North wall, 17' wide | Garage_Conversion_Option1.md |
| Stage depth | 3' | Garage_Conversion_Option1.md |
| Screen surface from north wall | 3.5' | Garage_Conversion_Option1.md |
| Row 1 (MLP) from north wall | 14.0' (10.5' from screen) | Garage_Conversion_Option1.md |
| Row 2 from north wall | 18.5' (15.0' from screen) | Garage_Conversion_Option1.md |
| Riser front edge | 16.0' from north wall | Garage_Conversion_Option1.md |
| Riser depth | 4.5' | Garage_Conversion_Option1.md |
| Rear clearance (Row 2) | ~1.0' | Garage_Conversion_Option1.md |
| HVAC | MrCool DIY 12K BTU 230V on partition wall, 7-8' high, painted flat black, ~23.5 dB(A) | Garage_Conversion_Option1.md |
| Screen | 170" 16:9 AT, width 12.3' (148"), height 6.9' (83") | Garage_Conversion_Option1.md |

**Note:** 01_Project_Overview_and_Room.md is a Rev 5.2 legacy doc (Nov 2024) with OLD room dims (16'×26'×10', 4,160 cu ft). Superseded by Option D.

---

## Speaker Models, Sensitivity, Impedance

| Channel | Model | Qty | Sensitivity | Impedance | Notes |
|---------|-------|-----|-------------|-----------|-------|
| L, C, R (LCR) | DIYSG Titan-815LX | 3 | 99 dB @ 2.83V/1m | 6Ω nominal, 4.2Ω min @ 110 Hz | Ported, 400W, XO 60-80 Hz |
| SL, SR, SBL, SBR (surrounds) | DIYSG Volt-10 V2 | 4 | 95 dB @ 2.83V/1m | 8Ω nominal | Coaxial, 70Hz-20kHz sealed |
| Atmos FL, FR, FC, RL, RR, RC | DIYSG Volt-10 V2 | 6 | 95 dB @ 2.83V/1m | 8Ω nominal | Coaxial, ceiling-mount |
| **Total** | | **13** | | | |
| FWL, FWR (front wides) | DIYSG Volt-10 V2 | 2 | 95 dB | 8Ω | Per Garage_Conversion doc / signal flow |

**CONFLICT:** 05_Speaker_System.md (Rev 7.0) lists 13 speakers (LCR + 4 surround + 6 Atmos). Garage_Conversion_Option1.md and 06_Electronics_and_Control.md signal flow mention FWL/FWR (front wides) and ATI AT525NC for 5ch (LCR + FW). CLAUDE.md says "9.4.6 Dolby Atmos" (9 bed + 4 sub + 6 height = 19 ch?). The speaker doc says 9.4.6 config with 13 speakers total — implies some channels driven internally.

**Previous error corrected:** Volt-10 sensitivity is 95 dB (not 98 dB). 05_Speaker_System.md flags this explicitly.

---

## Sub Driver Specs (Dayton UMII18-22)

| Parameter | Value per 03_Subwoofer_System.md | Flag |
|-----------|----------------------------------|------|
| Fs | 22 Hz | OK |
| Qts | 0.53 | OK — NOT 0.36 |
| Qes | 0.67 | OK |
| Qms | 2.53 | OK |
| Vas | 248.2 L (8.77 ft³) | OK — NOT 15.5 |
| Xmax | 28 mm (Klippel verified @ 70% BL) | OK |
| Sd | 1,184 cm² (183.5 sq in) | OK |
| Vd | 3,315 cm³ per driver | OK |
| Re (DC resistance) | 4.2Ω (coils in series) | OK |
| Mms | 420 g | OK |
| BL | 19.2 T·m | OK |
| Sensitivity | 90.7 dB @ 2.83V/1m | OK |
| Voice coil | Dual 2Ω | OK |
| RMS Power | 1,200W (AES 426B) | OK |
| Peak Power | 2,400W | OK |

**FLAG CHECK:** Vas=15.5 is NOT present in 03_Subwoofer_System.md (correct value is 248.2 L). Qts=0.36 is NOT present (correct value is 0.53). These erroneous values do not appear in the source doc.

**Note:** 03_Subwoofer_System.md is Rev 5.9 (Dec 2025) — legacy doc with 16-driver triangular column design. Option D uses 8 corner drivers (stacked rectangular cabs). Driver T/S parameters are unchanged.

---

## Sub Cabinet Dimensions — ALL DOCS, NOTE CONFLICTS

| Doc | Cabinet Description | Dimensions | Qty | Drivers per cab | Notes |
|-----|---------------------|------------|-----|-----------------|-------|
| CLAUDE.md (Option D, authoritative) | Stacked rectangular, corner-loaded, sealed | 24"W × 24"D × 72"H | 4 cabs | 2 per cab (8 total) | Front pair = screen wall structure |
| Garage_Conversion_Option1.md | Stacked rectangular, corner-loaded, sealed | ~20"W × 20"D × 72"H | 4 cabs | 2 per cab (8 total) | Each cab ~8.5 cu ft/driver (17 cu ft total) |
| 03_Subwoofer_System.md (Rev 5.9 — LEGACY) | Triangular corner columns, floor-to-ceiling | Not rectangular | 8 cabs | 1 per cab (8 main) | Superseded by Option D |
| 02_Front_Stage_System.md (Rev 5.2 — LEGACY) | Horizontal, in-stage corner pockets | 51"W × 27"H × 24"D | 2 front only | 2 per cab | Old design, triangular sub era |

**CONFLICT:** CLAUDE.md says 24"×24"×72"; Garage_Conversion_Option1.md says ~20"×20"×72". Width/depth differ by 4". CLAUDE.md is the higher-authority consolidated doc; Garage_Conversion_Option1.md is the detailed design doc. Neither is clearly more recent. Use ~20"×20"×72" from Garage_Conversion_Option1.md as it includes the volume calculation (17 cu ft = ~8.5 cu ft/driver, consistent with Vas=248.2 L, Qtc ~0.67 in ~8.5 cu ft sealed).

**Nearfield subs (deferred):** 4× UMII18-22 in single full-width cabinet, 8'W × 12.5"D × ~20"H, forward-facing behind Row 1 — per Garage_Conversion_Option1.md.

---

## Amplifier Specs per Channel

### Speaker Amplification — Denon AVR-X6800H (per 06_Electronics_and_Control.md signal flow) / AVR-A1H (per 05_Speaker_System.md Rev 7.0)

**CONFLICT:** 06_Electronics_and_Control.md signal flow block shows "Denon AVR-X6800H" and "ATI AT525NC (5ch NCore)". 05_Speaker_System.md Rev 7.0 (Mar 2026) says "Denon AVR-A1H" with all 15ch internal. CLAUDE.md (most authoritative) says "Denon AVR-X6800H" + "ATI AT525NC for LCR + front wides". 05_Speaker_System.md may reflect a later sub-revision of Rev 7.0 that differs from CLAUDE.md.

**Per CLAUDE.md (authoritative):**

| Channel Group | Amplifier | Notes |
|---------------|-----------|-------|
| LCR + FW (5ch) | ATI AT525NC | 5-ch NCore |
| Surrounds + Atmos (8-9ch) | Denon AVR-X6800H internal | 150W × 11 @ 8Ω rated |

**Per 05_Speaker_System.md Rev 7.0 (Mar 2026):**

| Parameter | Value |
|-----------|-------|
| Model | Denon AVR-A1H |
| Power | 150W × 15 @ 8Ω (2ch driven); ~105W ACD @ 8Ω |
| Into 4Ω | ~200W estimated |
| Channels | 15 internal (no external amps) |
| Pre-outs | 17.4ch XLR + RCA |
| Cost | ~$6,500 + $799 Dirac = ~$7,300 |

### Sub Amplification — ICEpower 1200AS2 (per 06_Electronics_and_Control.md)

| Unit | Assignment | Ch | Load | Power/Ch |
|------|------------|-----|------|----------|
| #1 | Corner subs FL + FR | 2 | 8Ω series | 620W |
| #2 | Corner subs RL + RR | 2 | 8Ω series | 620W |
| #3 | Tactile bass shakers | 2 | varies | 620W |
| #4 | Spare (nearfield if added) | 2 | — | — |
| #5 | Spare | — | — | — |

| Parameter | Value |
|-----------|-------|
| Model | ICEpower 1200AS2 |
| Supply | 240V, fanless |
| Infrasonic derating | None |
| Cost | $373/unit × 5 = $1,865 + chassis $200 = $2,065 |

### Sub DSP

| Parameter | Value | Source |
|-----------|-------|--------|
| DSP | 2× Wondom APM2 (ADAU1701) | 06_Electronics_and_Control.md |
| Fixed-point | 5.23 | CLAUDE.md |
| Inputs | 4 (from AVR sub outputs, RCA) | 06_Electronics_and_Control.md |
| Outputs | 8 balanced | 06_Electronics_and_Control.md |
| Balanced output stage | Sonic Imagery Labs 898B (preferred) or DIY THAT1646 | 06_Electronics_and_Control.md |
| CLAUDE.md says | ADAU1452 (8.24 fixed-point) | CONFLICT — see below |

**CONFLICT (CRITICAL):** CLAUDE.md says sub DSP is "ADAU1452 (8.24 fixed-point)". 06_Electronics_and_Control.md says "2× ADAU1701 (APM2)" with "5.23 fixed-point" (consistent with ADAU1701). POR/15_DSP_Subwoofer_Processing.md is the authoritative DSP doc — not read in this task. Downstream tasks should read 15_DSP_Subwoofer_Processing.md to resolve.

---

## SPL Targets

| Target | Value | Source |
|--------|-------|--------|
| Design target | -10 dB Reference = **95 dB at MLP** | CLAUDE.md, 05_Speaker_System.md, 06_Electronics_and_Control.md |
| Full THX Reference | 105 dB (not targeted, pre-outs available for upgrade) | 05_Speaker_System.md |
| LCR headroom @ Row 1 | ~106 dB (+11 dB over 95 dB target) | 05_Speaker_System.md |
| LCR headroom @ Row 2 | ~102 dB (+7 dB over target) | 05_Speaker_System.md |
| Surround/Atmos headroom | ~105-107 dB (+10-12 dB over target) | 05_Speaker_System.md |
| Sub target (legacy, pre-Option D) | 115 dB @ MLP @ 20 Hz (THX Reference) | 03_Subwoofer_System.md Rev 5.9 |

---

## Key Flags / Conflicts Summary

| # | Conflict | Docs | Severity |
|---|----------|------|----------|
| 1 | Sub cabinet width: 24"×24" vs ~20"×20" | CLAUDE.md vs Garage_Conversion | Medium |
| 2 | Sub DSP: ADAU1452 vs ADAU1701 (APM2) | CLAUDE.md vs 06_Electronics | HIGH — read 15_DSP doc |
| 3 | Speaker amp: AVR-X6800H+ATI vs AVR-A1H only | CLAUDE.md vs 05_Speaker Rev7.0 | Medium — Rev 7.0 likely correct |
| 4 | Volt-10 Atmos count: CLAUDE.md says 6, Garage_Conversion says 4 height ch | Various | Low — 9.4.6 = 6 height |
| 5 | Vas=15.5 / Qts=0.36 flag: NOT found in any source doc | N/A | CLEAR — not in POR |
| 6 | 01_Project_Overview_and_Room.md is legacy Rev 5.2 with old 16'×26' dims | 01_ vs CLAUDE.md | Low (known) |
