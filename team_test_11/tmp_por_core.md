# POR Core Extraction — Task 1 Output

Sources: CLAUDE.md (Option D), Garage_Conversion_Option1.md, 01_Project_Overview_and_Room.md, 03_Subwoofer_System.md, 05_Speaker_System.md, 06_Electronics_and_Control.md

---

## Room Dimensions & Partition Layout

### Option D (ACTIVE — supersedes POR Rev 7.0)

| Parameter | Option D | POR (14'×25') | Ref Design (16'×26') |
|-----------|----------|---------------|----------------------|
| Width | **17 feet** | 14 feet | 16 feet |
| Depth | **23 feet** | 25 feet | 26 feet |
| Height | 10 feet | 10 feet | 10 feet |
| Volume | **3,910 cu ft** | 3,500 cu ft | 4,160 cu ft |
| Room ratio (H:W:D) | 1:1.7:2.3 | 1:1.4:2.5 | 1:1.6:2.6 |

Source: Garage_Conversion_Option1.md, v3.7 section (line ~900)

### Building Partition (Option D N-S layout)

| Zone | Dimensions | Notes |
|------|-----------|-------|
| Theater (east) | 17'W × 23'D × 10'H | Screen on north wall |
| Gym (west) | 12'W × 23'D | HVAC, natural light from south |
| Equipment closet | 4'×4' | NE corner of gym, access from gym side |
| Partition wall | N-S orientation | Theater east, gym west |

Source: CLAUDE.md line 120-122; Garage_Conversion_Option1.md line ~1000-1015

**CONFLICT:** CLAUDE.md says equipment closet is 4'×4'. Garage_Conversion_Option1.md main body (v3.2–3.4 sections) says 4'×6'. Line 1005 (Option D section) says 4'×4'.

### Seating Geometry (Option D)

| Row | From North Wall | From Screen | Viewing Angle (170" 16:9) |
|-----|----------------|-------------|---------------------------|
| Row 1 (MLP) | 14.0' | 10.5' | 61° |
| Row 2 | 18.5' | 15.0' | 45° |
| Space behind Row 2 | — | — | 1.0' (tight) |

---

## Speakers — Model, Sensitivity, Impedance per Channel

### Option D: 9.4.4 Dolby Atmos (13 channels)

| Channel | Model | Qty | Sensitivity | Impedance | Amp | Notes |
|---------|-------|-----|-------------|-----------|-----|-------|
| L, C, R | DIYSG Titan-815LX | 3 | 99 dB | 6Ω nom (4.2Ω min) | ATI AT525NC | Ported; don't stuff line panels |
| FWL, FWR | DIYSG Volt-10 | 2 | 95 dB | 8Ω | ATI AT525NC | Front wide |
| SL, SR | DIYSG Volt-10 | 2 | 95 dB | 8Ω | X6800H internal | Side surrounds |
| SBL, SBR | DIYSG Volt-10 | 2 | 95 dB | 8Ω | X6800H internal | Rear surrounds |
| TFL, TFR, TRL, TRR | DIYSG Volt-10 | 4 | 95 dB | 8Ω | X6800H internal | Atmos ceiling |

Note: 05_Speaker_System.md (Rev 7.0) shows 9.4.6 with AVR-A1H driving all 15 channels internally (6 Atmos, no FW). Option D (Garage_Conversion_Option1.md) uses 9.4.4 with FW, ATI AT525NC for LCR+FW, X6800H internal for 8 surround/Atmos channels.

**WARNING:** 05_Speaker_System.md still references Denon AVR-A1H as amplifier. Garage_Conversion_Option1.md and CLAUDE.md specify Denon AVR-X6800H + ATI AT525NC. Option D supersedes.

**Volt-10 sensitivity:** 95 dB is correct per DIYSG spec. Earlier docs (Rev 5.0) incorrectly stated 98 dB — flag any doc using 98 dB as stale.

---

## Sub Driver Specs (UMII18-22)

Source: 03_Subwoofer_System.md (Rev 5.9), verified from Parts Express / Klippel data

| Parameter | Value | Flag |
|-----------|-------|------|
| Fs | 22 Hz | OK |
| Qts | **0.53** | OK — NOT 0.36 (0.36 would be WRONG) |
| Qes | 0.67 | OK |
| Qms | 2.53 | OK |
| Vas | **248.2 L (8.77 ft³)** | OK — NOT 15.5 L (15.5 would be WRONG) |
| Xmax | 28 mm (Klippel @ 70% BL) | OK |
| Sd | 1,184 cm² (183.5 sq in) | OK |
| Re | 4.2Ω (coils in series) | Voice coils: dual 2Ω |
| Sensitivity | 90.7 dB @ 2.83V/1m | OK |
| RMS Power | 1,200W (AES 426B) | OK |
| Peak Power | 2,400W | OK |
| Mms | 420g | OK |
| BL | 19.2 T·m | OK |

**Flags:** Qts=0.36 would indicate a vented alignment driver (too low Q for sealed). Vas=15.5 L would be impossibly small for an 18" driver (actual = 248.2 L). Neither wrong value appears in the POR source docs — they would be errors if found elsewhere.

---

## Sub Cabinet Dimensions

### Option D (ACTIVE): Stacked Rectangular Cabinets

| Position | Drivers | Cabinet Dims | Volume | Wiring |
|----------|---------|--------------|--------|--------|
| NW corner (screen left) | 2× UMII18-22 stacked | ~20"W × 20"D × 72"H | ~8.5 cu ft/driver (17 cu ft total) | 8Ω series |
| NE corner (screen right) | 2× UMII18-22 stacked | same | same | 8Ω series |
| SW corner (rear left) | 2× UMII18-22 stacked | same | same | 8Ω series |
| SE corner (rear right) | 2× UMII18-22 stacked | same | same | 8Ω series |

Source: Garage_Conversion_Option1.md line ~970
CLAUDE.md states: "24"×24"×72"" — slight conflict with Garage_Conversion_Option1.md which says "~20"W × 20"D × 72"H"

### POR Rev 7.0 (superseded): Triangular Corner Columns

| Design | Enclosure | Volume/driver | Notes |
|--------|-----------|---------------|-------|
| Rev 5.9 (03_Subwoofer_System.md) | Triangular floor-to-ceiling columns | 8–9 cu ft/driver | 2 drivers/column, 4 columns |
| 03_Subwoofer_System.md also references | Rear nearfield: 25 cu ft dual-driver sealed | 12.5 cu ft/driver | Superseded |
| Front nearfield (deferred in Option D) | Full-width cabinet 8'W × 12.5"D × ~20"H | — | Forward-facing, not dual-opposed |

### CONFLICT SUMMARY — Cabinet Dimensions

| Source | Corner Sub Dims | Status |
|--------|----------------|--------|
| CLAUDE.md | 24"×24"×72" | Option D active ref |
| Garage_Conversion_Option1.md line ~970 | ~20"W × 20"D × 72"H | Option D detailed spec |
| 03_Subwoofer_System.md (Rev 5.9) | Triangular columns | Superseded by Option D |

The 20" vs 24" discrepancy needs resolution. Height (72") is consistent across Option D references.

---

## Amplifier Specs per Channel

### Speaker Amplification (Option D)

| Amplifier | Channels | Rated Power | Load | Assignment |
|-----------|----------|-------------|------|------------|
| ATI AT525NC | 5 | ~200W @ 8Ω; ~300W @ 6Ω | 6Ω (LCR), 8Ω (FW) | L, C, R, FWL, FWR |
| Denon X6800H internal | 8 of 11 | 140W @ 8Ω (2ch driven); ~100-140W all-ch | 8Ω | SL, SR, SBL, SBR, TFL, TFR, TRL, TRR |
| Denon X4700 | backup | 125W × 9 @ 8Ω | — | Spare (already owned) |

Note: 05_Speaker_System.md (stale Rev 7.0) specifies AVR-A1H at 150W × 15 @ 8Ω for all channels. Option D replaces this with X6800H + ATI combination.

### Subwoofer Amplification (Option D)

| Unit | Assignment | Load | Power/Ch |
|------|-----------|------|----------|
| ICEpower 1200AS2 #1 | Corner subs FL + FR (2 series pairs) | 8Ω | ~620W |
| ICEpower 1200AS2 #2 | Corner subs RL + RR (2 series pairs) | 8Ω | ~620W |
| ICEpower 1200AS2 #3 | Tactile (bass shakers) | varies | ~620W |
| ICEpower 1200AS2 #4 | Spare (nearfield if deferred added) | — | — |
| ICEpower 1200AS2 #5 | Spare | — | — |

Power: 620W/ch @ 8Ω, 240V native, fanless, no infrasonic derating.
Source: 06_Electronics_and_Control.md line ~76-92; CLAUDE.md line 140

### Sub DSP

| Source | DSP Specified | Notes |
|--------|--------------|-------|
| CLAUDE.md | ADAU1452 (8.24 fixed-point) | Listed in project overview |
| 06_Electronics_and_Control.md (current) | 2× ADAU1701 (APM2, Wondom) | Rev 7.0 / Option D current POR |
| 15_DSP_Subwoofer_Processing.md | 2× ADAU1701 (APM2) — replaced ADAU1452 | Rev 2.0 dated 2026-03-18 |
| Garage_Conversion_Option1.md (stale section) | ADAU1452 | Stale — pre-Rev 2.0 |

**CONFLICT:** CLAUDE.md says "ADAU1452" but POR docs (15_DSP, 06_Electronics) were updated 2026-03-18 to 2× ADAU1701. CLAUDE.md is stale on this point. Current correct DSP = 2× ADAU1701 (APM2).

---

## SPL Targets

| Target | Value | Source |
|--------|-------|--------|
| Design target | -10 dB Reference = **95 dB at MLP** | CLAUDE.md, 05_Speaker_System.md, 06_Electronics_and_Control.md |
| Full THX Reference | 105 dB | Not targeted; pre-outs enable future upgrade |
| Sub array @ 20Hz @ MLP | ~113 dB | 03_Subwoofer_System.md (main array) |
| Nearfield @ 15Hz @ 15" | ~115+ dB | Garage_Conversion_Option1.md (deferred) |
| Corner array @ 20Hz (Option D) | ~113 dB | Garage_Conversion_Option1.md |

### Per-Channel SPL Headroom vs 95 dB Target (Option D)

| Channel Group | SPL @ Seat | Headroom |
|---------------|-----------|----------|
| LCR (Titan-815LX + ATI) | ~104-108 dB | +9 to +13 dB |
| Surrounds/Heights (Volt-10 + X6800H) | ~107-110 dB | +12 to +15 dB |

---

## Key Conflicts / Flags Summary

| Item | Conflict | Authoritative Source |
|------|----------|---------------------|
| Sub DSP chip | CLAUDE.md says ADAU1452; POR docs say 2× ADAU1701 (APM2) | 15_DSP_Subwoofer_Processing.md Rev 2.0 (2026-03-18) = ADAU1701 |
| Speaker amp | 05_Speaker_System.md says AVR-A1H (all internal) | Option D = X6800H + ATI AT525NC |
| Corner sub dims | CLAUDE.md: 24"×24"×72"; Garage_Conversion: ~20"W×20"D×72"H | Unresolved — 20" vs 24" |
| Equipment closet size | Main body of Garage_Conversion: 4'×6'; Option D section: 4'×4' | Option D section (4'×4') |
| Volt-10 sensitivity | Pre-Rev 5.0 docs may say 98 dB | Correct = 95 dB |
| Room layout | Garage_Conversion main body shows 14'×25' (E-W partition); Option D section shows 17'×23' (N-S partition) | Option D = 17'×23', N-S partition |
| Qts / Vas flags | Qts=0.36 WRONG (actual 0.53); Vas=15.5L WRONG (actual 248.2L) | 03_Subwoofer_System.md (Klippel verified) |
