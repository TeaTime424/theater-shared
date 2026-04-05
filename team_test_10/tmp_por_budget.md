# POR Budget & Spec Extract
**Source docs read:** 00_Master_Index, 01_Project_Overview_and_Room, 02_Front_Stage_System, 05_Speaker_System, 06_Electronics_and_Control, 11_Budget_Summary, 14_Quick_Reference, 15_DSP_Subwoofer_Processing, 16_HVAC_Plan_Theater, Garage_Conversion_Option1

---

## Budget — Rev 7.0 POR (as stated in 11_Budget_Summary.md)

### Grand Total Range
| Estimate | Amount |
|----------|--------|
| Low | ~$65,000 |
| Mid (Recommended) | ~$72,000 |
| High | ~$82,000 |

### Category Breakdown (Mid ~$72K)
| Category | Amount | Notes |
|----------|--------|-------|
| Projector | $30,000 | 2027 flagship, model TBD |
| LF System (complete) | $12,327 | 16× UMII18-22, triangular columns, NX6000D amps, shakers |
| Speakers (LCR/Surr/Atmos) | $7,304 | DIYSG Titan-815LX (3) + Volt-10 (10) + Sorbothane |
| Electronics | $7,549 | AVR-A1H + Dirac + DSP-408 |
| Seating | $6,000 | 2× 11-foot couches |
| Acoustic Treatment | $5,500 | DIY absorption/diffusion/bass traps |
| Screen | $3,000 | 170" 2.35:1 AT |
| Infrastructure | $3,300 | Riser, stage, rack, rear wall |
| **TOTAL** | **~$72,000** | |

### LF System Detail (11_Budget_Summary.md)
| Item | Qty | Unit | Total |
|------|-----|------|-------|
| UMII18-22 drivers | 16 | $349.98 | $5,600 |
| Triangular corner enclosures | 8 | $122 | $978 |
| Front nearfield (riser) | 1 | $450 | $450 |
| Rear nearfield (floor console) | 1 | $550 | $550 |
| NX6000D amps | 6 | $519 | $3,114 |
| Noctua NF-R8 fan mod | 12 | $15 | $180 |
| Aura Pro AST-2B-4 shakers | 16 | $70 | $1,120 |
| Wiring | — | — | $335 |
| **LF TOTAL** | | | **$12,327** |

### Speaker Detail (05_Speaker_System.md / 11_Budget_Summary.md)
| Item | Qty | Unit | Total |
|------|-----|------|-------|
| Titan-815LX | 3 | ~$1,600 | $4,800 |
| Volt-10 (surrounds) | 4 | $242 | $968 |
| Volt-10 (Atmos) | 6 | $242 | $1,452 |
| Sorbothane isolation | 12 pucks | $7 | $84 |
| **TOTAL** | | | **$7,304** |

### Electronics Detail — Rev 7.0 POR (11_Budget_Summary.md)
| Item | Cost | Notes |
|------|------|-------|
| Denon AVR-A1H | $6,500 | |
| Dirac Live bundle (Full + Bass Control + ART) | $799 | |
| Dayton DSP-408 | $250 | Sub DSP per Rev 7.0 budget doc |
| **TOTAL** | **$7,549** | |

### Electronics Detail — Option D (06_Electronics_and_Control.md)
| Item | Cost | Notes |
|------|------|-------|
| Denon AVR-X6800H | $3,700 | Replaces AVR-A1H |
| ATI AT525NC | $0 | Owned |
| Dirac Live bundle | $799 | |
| ICEpower 1200AS2 (5 units + chassis) | $2,065 | 5× $373 module + 5× $40 chassis |
| ADAU1701 DSP + balanced output | $215 | Option A (DIY THAT1646) |
| **TOTAL** | **$6,779** | |

### Infrastructure (11_Budget_Summary.md)
| Item | Cost |
|------|------|
| Riser platform (CLD) | $1,700 |
| Stage platform | $540 |
| Equipment rack (42U) | $690 |
| Rear wall system | $370 |
| **Total** | **$3,300** |

### Acoustic Treatment (11_Budget_Summary.md)
| Item | Cost |
|------|------|
| Absorption (DIY panels) | $2,500 |
| Diffusion (DIY) | $1,500 |
| Bass traps (DIY) | $1,000 |
| Fabric/hardware | $500 |
| **Total** | **$5,500** |

**Note:** 11_Budget_Summary.md explicitly excludes HVAC from total. HVAC cost documented separately in 16_HVAC_Plan_Theater.md.

---

## Phase 2 Notes
No formal "Phase 1 / Phase 2" budget split in POR docs. The 15_DSP_Subwoofer_Processing.md uses Phase 1/2/3/4 for implementation phases (bench validation → balanced output validation → full build → install), not budget phases. Option D defers nearfield subs and reduces shakers 16→8 as a post-build addition.

---

## Electrical Feed Spec

### Theater Electronics (06_Electronics_and_Control.md)
| Parameter | Value |
|-----------|-------|
| Subpanel | Dedicated 100A |
| Circuit A (Sub amps) | 20A / 240V — all 5× ICEpower 1200AS2 |
| Circuit C (Processor/amps/DSP) | 20A / 120V — AVR + ATI + APM2 + sources |
| Projector | Dedicated circuit (not included in above) |
| ICEpower native voltage | 240V (PFC, single circuit) |

### HVAC Circuit (16_HVAC_Plan_Theater.md)
| Parameter | Value |
|-----------|-------|
| Voltage | 230V (208–230V acceptable) |
| Breaker | 20A double-pole |
| Wire gauge | 12 AWG 3-conductor (2 hot + ground) |
| Run length | ~15–30 ft (panel on theater side) |
| Disconnect | Non-fused AC-rated 240V, within 6 ft of outdoor condenser |
| Panel | Square D 100A |
| Current load pre-HVAC | ~20A |
| Post-HVAC load | ~30A |

---

## HVAC — MrCool (16_HVAC_Plan_Theater.md)

| Item | Value |
|------|-------|
| Model | MrCool DIY 5th Gen 12K BTU 230V Single Zone |
| Model # | DIY-12-HP-WM-230D25-O (E-Star) or DIYHH-12-HP-WM-230D25-O (Hyper Heat) |
| SEER2 | 23.5 |
| Silent mode noise | 23.5 dB(A) |
| Placement | Partition wall (west wall of theater), 7–8 ft high |
| System package price | ~$2,359 |
| Additional required items | ~$175–280 |
| **Total (DIY)** | **~$2,550–2,650** |
| Refrigerant | R-454B (pre-charged, no vacuum) |

---

## Projector

| Parameter | Value | Source |
|-----------|-------|--------|
| Budget | $30,000 | 11_Budget_Summary.md, 06_Electronics_and_Control.md |
| Type | 4K/8K Laser | 06_Electronics_and_Control.md |
| Model | TBD — deferred to 2027 | 06_Electronics_and_Control.md |
| Power | ~450W typical | 06_Electronics_and_Control.md |
| Throw distance | Not stated in any doc reviewed | — |

---

## Screen Specs

| Parameter | Value | Source |
|-----------|-------|--------|
| Size | 170" diagonal | 02_Front_Stage_System.md, 14_Quick_Reference.md |
| Aspect ratio | 2.35:1 (02_Front_Stage_System.md) / 16:9 (CLAUDE.md) | **CONFLICT — see flags** |
| Type | Acoustically transparent fabric | 02_Front_Stage_System.md |
| Bottom height | ~51" from floor (2' above 27" stage deck) | 02_Front_Stage_System.md |
| Top height | ~108" from floor | 02_Front_Stage_System.md |
| Budget (11_Budget_Summary.md) | $3,000 | 11_Budget_Summary.md |

---

## DSP Platform — Per Document

| Document | States DSP As | Date |
|----------|---------------|------|
| 00_Master_Index.md | DSP-408 + miniDSP 2×4 HD | Updated Mar 13, 2026 |
| 06_Electronics_and_Control.md | 2× ADAU1701 (APM2) + balanced output stage (Option D) | Updated Mar 19, 2026 |
| 11_Budget_Summary.md (Electronics line) | Dayton DSP-408 ($250) | Updated Mar 10, 2026 |
| 14_Quick_Reference.md | DSP-408 + miniDSP 2×4 HD | Updated Mar 10, 2026 |
| 15_DSP_Subwoofer_Processing.md | 2× ADAU1701 (APM2) | Updated Mar 19, 2026 |

---

## Contradiction / Stale Flags

| Flag | Detail | Docs Involved |
|------|--------|---------------|
| **STALE** | 00_Master_Index references NX6000D amps (6 units) for sub amplification | 00_Master_Index vs 06_Electronics (ICEpower 1200AS2) |
| **STALE** | 00_Master_Index system overview table still shows NX6000D for all sub channels | 00_Master_Index |
| **STALE** | 11_Budget_Summary Electronics lists "Dayton DSP-408 $250" — Option D replaced this with ADAU1701 | 11_Budget_Summary vs 15_DSP |
| **STALE** | 11_Budget_Summary LF section lists NX6000D (6× $519 = $3,114) — Option D uses ICEpower 1200AS2 | 11_Budget_Summary vs 06_Electronics |
| **STALE** | 14_Quick_Reference DSP section shows DSP-408 + miniDSP 2×4 HD | 14_Quick_Reference vs 15_DSP |
| **STALE** | 14_Quick_Reference sub amplification shows NX6000D (6 units) | 14_Quick_Reference vs 06_Electronics |
| **STALE** | 02_Front_Stage_System rack layout shows Marantz AV10 + PURIFI monoblocks + Buckeye amps — all superseded | 02_Front_Stage_System (Rev 5.2, never updated) |
| **CONFLICT** | Screen aspect ratio: 02_Front_Stage_System.md says 2.35:1 / CLAUDE.md says 16:9 / 00_Master_Index says 170" without ratio | 02_Front_Stage_System vs CLAUDE.md |
| **CONFLICT** | 06_Electronics signal flow diagram names "AVR-X6800H" but processor table at top says "AVR-A1H" — Option D uses X6800H, Rev 7.0 POR uses A1H | 06_Electronics (doc is mixed) |
| **CONFLICT** | 06_Electronics cost summary labels columns "Rev 7.0 (POR)" and "Option D" but leaves Rev 7.0 column blank — unclear which is current POR | 06_Electronics |
| **CONFLICT** | Room dimensions: 01_Project_Overview says 16'×26'×10' (4,160 cu ft), 16_HVAC says 17'×23'×10' (3,910 cu ft), CLAUDE.md says 17'×23'×10' | 01_Project_Overview vs 16_HVAC/CLAUDE.md |
| **STALE** | 01_Project_Overview (Rev 5.2, Nov 2024) — never updated; references old room, budget $75K-95K, THX Reference 115 dB target | 01_Project_Overview |
| **STALE** | 11_Budget_Summary total ~$72K does not include HVAC (~$2,600) or electrical work | 11_Budget_Summary (noted in doc) |
| **NOTE** | Option D total out-of-pocket ~$36,600 (from CLAUDE.md) is NOT documented in any POR file reviewed — no Option D budget summary doc exists | — |
