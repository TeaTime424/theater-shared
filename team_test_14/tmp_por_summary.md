# POR Consolidated Summary
_Generated from snapshot_por.md — agent task W0-A_

---

## Room Dimensions & Layout

| Parameter | Option D (ACTIVE) | POR Rev 7.0 (ref) | POR Rev 5.x (old) |
|-----------|-------------------|-------------------|-------------------|
| Width | **17'** | 14' | 16' |
| Depth | **23'** | 25' | 26' |
| Height | 10' | 10' | 10' |
| Volume | **3,910 cu ft** | 3,500 cu ft | 4,160 cu ft |

**Partition layout:** N-S partition at ~12' from west wall
**Theater (east):** 17'×23'×10' — screen on north wall, entry via 36" door on east wall
**Gym (west):** 12'×23' — both garage door openings converted
**Equipment closet:** 4'×4' in NE corner of gym, backed against partition + north wall

---

## Speakers

| Channel | Model | Qty | Sensitivity | Impedance |
|---------|-------|-----|-------------|-----------|
| LCR | DIYSG Titan-815LX | 3 | 99 dB | 6Ω nominal, 4.2Ω min |
| Surrounds | DIYSG Volt-10 | 4 | 95 dB | 8Ω |
| Atmos | DIYSG Volt-10 | 6 | 95 dB | 8Ω |
| **Total** | | **13** | | |

**Note:** Earlier docs (Rev 5.0) stated Volt-10 sensitivity as 98 dB — corrected to 95 dB in Rev 7.0.

Speaker positions (Option D):
- LCR: on stage deck behind 170" AT screen
- Front Wides (FWL/FWR): partition wall and east wall, between screen and MLP (~55°)
- Side Surrounds (SL/SR): beside MLP (~90°)
- Surround Backs (SBL/SBR): south wall (~145°)
- Atmos: ceiling, front and rear pairs

---

## Sub Driver Specs (as stated in docs)

| Parameter | Value (03_Subwoofer_System.md, Rev 5.9) |
|-----------|------------------------------------------|
| Model | Dayton UMII18-22 |
| Fs | 22 Hz |
| Qts | **0.53** |
| Qes | 0.67 |
| Qms | 2.53 |
| Vas | 248.2 L (8.77 ft³) |
| Xmax | 28 mm (Klippel verified @ 70% BL) |
| Sd | 1,184 cm² |
| Vd | 3,315 cm³ per driver |
| Re | 4.2Ω |
| Mms | 420g |
| BL | 19.2 T·m |
| Sensitivity | 90.7 dB @ 2.83V/1m |
| Voice coil | Dual 2Ω (series = 4Ω per driver; 8Ω with 2 in series) |
| RMS Power | 1,200W |
| Peak Power | 2,400W |

**FLAG — Qts=0.36:** Not present in this snapshot. Docs state Qts=0.53.
**FLAG — Vas=15.5:** Not present in this snapshot. Docs state Vas=248.2 L.
_These values would be wrong if found elsewhere — the datasheet values in the snapshot (Qts=0.53, Vas=248.2L) are the correct Dayton figures._

---

## Sub Cabinet Dimensions — Conflicts Between Docs

| Doc | Cabinet Description | Dimensions |
|-----|---------------------|------------|
| CLAUDE.md (Option D, active) | 4 stacked rectangular, 2 drivers each, sealed | **24"×24"×72"** |
| Garage_Conversion/Option D section | Stacked cabinets, same per-corner | **~20"W × 20"D × 72"H** (per corner) |
| 03_Subwoofer_System.md (Rev 5.9, old) | 8× triangular corner columns | Triangular (not rectangular) |
| 04_Seating_and_Riser.md (Rev 5.8, old) | Front nearfield built into riser | **~46"W × 22"H × 34"D** per enclosure (16 ft³) |
| 04_Seating_and_Riser.md (Rev 5.8, old) | Rear nearfield console tower | ~25 cu ft each |

**CONFLICT:** CLAUDE.md states 24"×24"×72"; Option D section of Garage_Conversion states ~20"W × 20"D × 72"H. Same cabinets, different quoted widths/depths.
**CONFLICT:** Rev 5.9 sub doc describes triangular corner columns — superseded by Option D rectangular stacked cabinets (not yet updated in 03_Subwoofer_System.md).

---

## Amplifiers

### Speaker Amplification (Option D)
| Channel | Amplifier | Power |
|---------|-----------|-------|
| LCR | ATI AT525NC | Not specified in snapshot |
| Front Wides | ATI AT525NC | Not specified in snapshot |
| Surrounds (4) | Denon AVR-X6800H internal | ~105–150W @ 8Ω |
| Atmos (6) | Denon AVR-X6800H internal | ~105–150W @ 8Ω |

**Note:** CLAUDE.md states "Denon AVR-X6800H — 11.4ch processing + internal amplification" and "ATI AT525NC for LCR + front wides." Doc 06_Electronics_and_Control.md (Rev 7.0) describes the **Denon AVR-A1H** instead (15ch, 150W×15 @ 8Ω).
**CONFLICT:** CLAUDE.md lists AVR-X6800H; 06_Electronics_and_Control.md and 05_Speaker_System.md list AVR-A1H. Option D CLAUDE.md also shows ATI AT525NC for LCR, but Doc 05/06 show AVR-A1H internal for all channels.

### Sub Amplification (Option D)
| Unit | Channels | Load | Power/Ch |
|------|----------|------|----------|
| ICEpower 1200AS2 #1 | 2 | 8Ω (corner FL + FR) | 620W |
| ICEpower 1200AS2 #2 | 2 | 8Ω (corner RL + RR) | 620W |
| ICEpower 1200AS2 #3 | 2 | varies (tactile) | 620W |
| ICEpower 1200AS2 #4 | 2 | spare/nearfield | — |
| ICEpower 1200AS2 #5 | — | spare | — |
| **Total** | **5 modules** | | |

Cost: 5× $373 = $1,865 + $200 chassis = **$2,065**

---

## SPL Targets

| Target | Level | Notes |
|--------|-------|-------|
| Primary | **95 dB at MLP** | -10 dB Reference |
| LCR headroom | +7 to +11 dB above 95 dB | At Row 1 and Row 2 |
| Surround/Atmos headroom | +11 to +12 dB above 95 dB | |
| Old target (Rev 5.x) | 115 dB (THX Reference) | Superseded |

---

## Budget — Option D (~$36,600)

The snapshot does not contain a full itemized Option D budget table. The figure appears only as a headline in CLAUDE.md:

> Budget: ~$36,600 out-of-pocket (with bass deferral)

Option D revision history entry: "~$36.6K"

**No Phase 1 / Phase 2 breakdown found in snapshot.** The Rev 7.0 budget doc (11_Budget_Summary.md) uses the old room/amp config and totals ~$72,000 — this is NOT the Option D budget.

### Rev 7.0 Budget (reference, NOT Option D)
| Category | Amount |
|----------|--------|
| Projector | $30,000 |
| LF System | $12,327 |
| Speakers | $7,304 |
| Electronics | $7,549 |
| Seating | $6,000 |
| Acoustic Treatment | $5,500 |
| Screen | $3,000 |
| Infrastructure | $3,300 |
| **Total** | **~$72,000** |

Electronics breakdown (Rev 7.0):
- Denon AVR-A1H: $6,500
- Dirac Live bundle: $799
- DSP-408 (sub DSP): $250
- **Total: $7,549**

LF System breakdown (Rev 7.0, triangular columns, 16 drivers):
- 16× UMII18-22: $5,600
- 8× triangular enclosures: $978
- Front nearfield: $450
- Rear nearfield: $550
- 6× NX6000D amps: $3,114
- Fan mods: $180
- 16× Aura Pro shakers: $1,120
- Wiring: $335
- **Total: $12,327**

---

## Electrical Feed Spec

| Parameter | Value |
|-----------|-------|
| Subpanel | Dedicated 100A, 240V (CLAUDE.md) |
| ICEpower circuits | Single 20A/240V circuit for all 5 modules |
| HVAC circuit | 20A double-pole (20A 230V) |
| Sub feed wire gauge | **Not found in snapshot** — "#2 Al, 60A breaker" not present in truncated electrical section |

**NOTE:** The task spec states "correct: #2 Al, 240V, 60A breaker at main panel." This specific value was NOT found in the snapshot text (electrical section was truncated). The snapshot shows "100A subpanel" but the wire gauge/breaker feeding the subpanel was in the truncated portion of 16_HVAC_Plan_Theater.md section 5.

---

## HVAC

| Parameter | Value |
|-----------|-------|
| Unit | MrCool DIY 5th Generation 12K BTU, 230V single-zone |
| Price (12K) | **~$2,359** (complete system) |
| Price (9K, rejected) | ~$2,329 |
| Delta | +$30 for 12K — 9K not a viable cost reduction |
| Silent mode noise | 23.5 dB(A) |
| Mounting | Partition wall (theater side) |
| Circuit | 20A double-pole |

**Note:** Task spec cites MrCool at $1,359. The snapshot consistently shows ~$2,359 for the 12K complete system and ~$2,329 for the 9K. $1,359 does NOT appear in the snapshot.
**FLAG — PRICE CONFLICT:** $1,359 (task spec reference) vs ~$2,359 (snapshot doc) for MrCool DIY 12K.

---

## Projector

| Parameter | Value |
|-----------|-------|
| Model | Not specified — "2027 flagship model" placeholder |
| Budget | $30,000 (Rev 7.0 budget) |
| Throw distance | Not specified in snapshot |
| Type | Laser (implied by thermal load calc noting "laser projector") |

---

## Screen

| Parameter | Value |
|-----------|-------|
| Size | 170" diagonal |
| Aspect ratio | **16:9** (Option D); 2.35:1 in Rev 5.x/7.0 docs |
| Type | Acoustically transparent (AT) |
| Width | 12.3' (148") |
| Height | 6.9' (83") |
| Bottom height from floor | Not stated in snapshot |
| Screen surface depth from north wall | ~3.5' |
| Screen offset in layout_config.json | 26" from north wall |

**CONFLICT:** CLAUDE.md and Option D docs state 170" **16:9**. Rev 5.x docs (01_Project_Overview, layout diagrams) and Rev 7.0 budget state 170" **2.35:1**. Option D explicitly uses 16:9.

---

## DSP Platform

| Doc | States |
|-----|--------|
| CLAUDE.md (Option D) | **ADAU1452** — "8.24 fixed-point, full sub-20Hz capability" |
| Garage_Conversion Option D equipment closet | **ADAU1452** |
| 06_Electronics_and_Control.md (Option D section) | **2× ADAU1701** (APM2 boards, Wondom APM2) |
| 15_DSP_Subwoofer_Processing.md | **2× ADAU1701** (APM2 boards) |

**CONFLICT:** CLAUDE.md/Garage_Conversion reference ADAU1452; Electronics doc and DSP processing doc describe ADAU1701 (APM2 = Wondom ADAU1701 board). These are different chips. ADAU1452 is 8.24 fixed-point; ADAU1701 is 5.23 fixed-point.

---

## Cross-Doc Conflicts Summary

| # | Conflict | Doc A | Doc B |
|---|----------|-------|-------|
| 1 | AVR model | CLAUDE.md: AVR-X6800H + ATI AT525NC | 05/06_Electronics: AVR-A1H (internal amps, no ATI) |
| 2 | DSP chip | CLAUDE.md + Garage_Conversion: ADAU1452 | 06_Electronics + 15_DSP: ADAU1701 (APM2) |
| 3 | Sub cabinet width/depth | CLAUDE.md: 24"×24"×72" | Garage_Conversion table: ~20"W × 20"D × 72"H |
| 4 | Sub cabinet type | 03_Subwoofer_System (Rev 5.9): triangular | CLAUDE.md + Option D: rectangular stacked |
| 5 | Screen aspect ratio | CLAUDE.md + Option D: 16:9 | Rev 5.x + Rev 7.0 budget: 2.35:1 |
| 6 | Volt-10 sensitivity | Rev 5.0 docs: 98 dB | Rev 7.0 + Option D: 95 dB (corrected) |
| 7 | Sub amp platform | 00_Master_Index (Rev 7.0): 6× NX6000D | Option D (CLAUDE.md + 06_Electronics): 5× ICEpower 1200AS2 |
| 8 | MrCool price | Task spec: $1,359 | Snapshot (16_HVAC_Plan): ~$2,359 for 12K unit |
| 9 | Tactile count | CLAUDE.md: 8× Aura Pro (reduced from 16) | 03/04 sub docs + Rev 7.0 budget: 16× Aura Pro |
| 10 | Number of ICEpower amps | CLAUDE.md: 5× ICEpower | 06_Electronics closet list: 4× ICEpower (+ 1 spare) |
