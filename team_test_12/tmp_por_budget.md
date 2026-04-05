# POR Budget & Specs Extraction
**Source docs:** POR/ numbered files (Rev 7.0 baseline, Option D supersedes)
**Extracted:** 2026-03-21

---

## Budget — Rev 7.0 (11_Budget_Summary.md, dated Mar 10 2026)

| Category | Line Items | Total |
|----------|-----------|-------|
| Projector | 4K/8K Laser, model TBD | $30,000 |
| LF System | 16× UMII18-22 $5,600 + enclosures $1,978 + 6× NX6000D $3,114 + fan mods $180 + shakers $1,120 + wiring $335 | $12,327 |
| Speakers | 3× Titan-815LX $4,800 + 10× Volt-10 $2,420 + isolation $84 | $7,304 |
| Electronics | AVR-A1H $6,500 + Dirac bundle $799 + DSP-408 $250 | $7,549 |
| Seating | 2× 11-ft couches | $6,000 |
| Acoustic Treatment | Absorption $2,500 + diffusion $1,500 + bass traps $1,000 + fabric $500 | $5,500 |
| Screen | 170" 2.35:1 AT | $3,000 |
| Infrastructure | Riser $1,700 + stage $540 + rack $690 + rear wall $370 | $3,300 |
| **TOTAL (Mid)** | | **~$72,000** |
| Low | | ~$65,000 |
| High | | ~$82,000 |

**Note:** 11_Budget_Summary.md excludes HVAC, electrical work, tools, consumables.

---

## Budget — Option D (06_Electronics_and_Control.md, dated Mar 19 2026)

Option D replaces NX6000D with ICEpower + AVR-X6800H replaces AVR-A1H.

| Item | Option D Cost | Notes |
|------|--------------|-------|
| Denon AVR-X6800H | $3,700 | Replaces AVR-A1H |
| ATI AT525NC | $0 | Owned |
| Dirac Live bundle | $799 | |
| 5× ICEpower 1200AS2 + chassis | $2,065 | Replaces NX6000D |
| ADAU1701 DSP + balanced output | $215–$525 | Option A (DIY) / Option B (898B) |
| **Total Electronics (Option D)** | **$6,779** | Using Option A |

---

## DSP BOM — Option B Preferred (15_DSP_Subwoofer_Processing.md, v2.1 Mar 19 2026)

| Path | DSP Cost | Balanced Output Cost | Total |
|------|---------|---------------------|-------|
| Option B (898B) — preferred | $80 (2× APM2) | $445 (898B $389 + cables $56) | **$525** |
| Option A (DIY THAT1646) — fallback | $80 (2× APM2) | $135 (THAT1646 + PCM5102 + passives) | **$215** |

---

## Electrical Feed Spec

### Sub Amp Circuit — Option D (06_Electronics_and_Control.md)

| Parameter | Value |
|-----------|-------|
| Breaker | 20A double-pole |
| Voltage | 240V |
| Load | 5× ICEpower 1200AS2 (idle 140W, peak 2,600W) |
| Notes | Single circuit, native 240V PFC |

### Theater A/V Circuit — Option D

| Parameter | Value |
|-----------|-------|
| Breaker | 20A |
| Voltage | 120V |
| Load | AVR-X6800H + ATI AT525NC + DSP + sources (idle 154W, peak 1,306W) |

### Subpanel

| Parameter | Value |
|-----------|-------|
| Rating | 100A dedicated subpanel |
| Current load (pre-build) | ~20A (minor lighting) |
| Post-theater-HVAC | ~30A |
| Notes | 200A panel upgrade worth monitoring if total approaches 90A |

---

## HVAC (16_HVAC_Plan_Theater.md, v1.2 Mar 13 2026)

| Parameter | Value |
|-----------|-------|
| Model | MrCool DIY 5th Gen 12K BTU — 230V single zone |
| Model numbers | DIY-12-HP-WM-230D25-O (E-Star) or DIYHH-12-HP-WM-230D25-O (Hyper Heat) |
| BTU | 12,000 |
| Voltage | 208–230V / 60Hz / 1-phase |
| SEER2 | 23.5 |
| Silent mode noise | 23.5 dB(A) |
| Refrigerant | R-454B (pre-charged, no vacuum) |
| Breaker | 20A double-pole Square D |
| Wire gauge | 12 AWG 3-conductor |
| System package price | ~$2,359 |
| Additional hardware | ~$175–$280 |
| **Total DIY installed** | **~$2,550–$2,650** |
| Placement | Partition wall (west wall of theater), 7–8 ft high |

---

## Projector

| Parameter | Value | Source |
|-----------|-------|--------|
| Budget | $30,000 | 11_Budget_Summary.md, 06_Electronics_and_Control.md |
| Model | TBD — 4K/8K Laser | 06_Electronics_and_Control.md |
| Selection timing | Deferred to 2027 | 06_Electronics_and_Control.md |
| Power | ~450W typical | 06_Electronics_and_Control.md |
| Throw distance | Not specified in POR | — |

---

## Screen

| Parameter | Value | Source |
|-----------|-------|--------|
| Size | 170" diagonal | Multiple docs |
| Aspect ratio | **CONFLICT — see below** | |
| Type | Acoustically Transparent fabric | Multiple docs |
| Bottom height | ~51" from floor | 02_Front_Stage_System.md |
| Top height | ~108" from floor | 02_Front_Stage_System.md |
| Budget | $3,000 (mid) / $2,500–$4,000 (range) | 11_Budget_Summary.md |

---

## DSP Platform — Per Doc

| Doc | DSP Stated | Last Updated |
|-----|-----------|-------------|
| 14_Quick_Reference.md | Dayton DSP-408 + miniDSP 2×4 HD | Mar 10 2026 (Rev 7.0) |
| 11_Budget_Summary.md | Dayton DSP-408 $250 | Mar 10 2026 (Rev 7.0) |
| 06_Electronics_and_Control.md | 2× ADAU1701 (APM2) + balanced output stage | Mar 19 2026 (Option D) |
| 15_DSP_Subwoofer_Processing.md | 2× ADAU1701 (APM2) — replaces DSP-408 | Mar 19 2026 (v2.1) |
| 00_Master_Index.md | DSP-408 + miniDSP 2×4 HD (per Rev 7.0 entry) | Mar 13 2026 |

---

## Contradiction Flags

| # | Conflict | Docs Involved |
|---|---------|--------------|
| 1 | **Screen aspect ratio:** 02_Front_Stage_System.md and 14_Quick_Reference.md say **2.35:1**; 00_Master_Index.md says **170" 16:9** (in project CLAUDE.md/overview section) | 02, 14 vs CLAUDE.md |
| 2 | **DSP platform:** 11_Budget_Summary.md and 14_Quick_Reference.md still list DSP-408 + miniDSP; 06 and 15 (both Mar 19) replace those with ADAU1701. Budget doc was NOT updated for Option D. | 11, 14 vs 06, 15 |
| 3 | **Sub amplifiers:** 14_Quick_Reference.md lists 6× NX6000D; 06_Electronics_and_Control.md (Option D) replaces with 5× ICEpower 1200AS2. Budget doc (11) still shows NX6000D $3,114. | 11, 14 vs 06 |
| 4 | **AVR model:** Signal flow diagram in 06_Electronics_and_Control.md still references AVR-X6800H but header says "Option D: AVR-X6800H"; doc title says "Rev 7.0: AVR-A1H." Both co-exist in the same doc (Option D replaced A1H with X6800H). | Within 06 |
| 5 | **Room dimensions:** 01_Project_Overview_and_Room.md says 16'×26'×10' (Rev 5.2, outdated); 16_HVAC_Plan_Theater.md says 17'×23'×10'; CLAUDE.md confirms 17'×23'. 01 is stale. | 01 vs 16 + CLAUDE.md |
| 6 | **Bass shaker count:** 11_Budget_Summary.md and 03_Subwoofer_System.md list 16× Aura Pro; CLAUDE.md Option D says 8× (reduced post bass-plan decision). Budget not updated. | 11, 03 vs CLAUDE.md |
| 7 | **Option B DSP BOM total:** 15_DSP_Subwoofer_Processing.md BOM table footer says $525 for Option B but itemized sum = $80+$389+$24+$32 = $525 — consistent. Option A table footer says $215, sum = $80+$55+$15+$20+$45 = $215 — consistent. | Internal check OK |

---

## Stale Doc Flags

| Doc | Status | Issue |
|-----|--------|-------|
| 01_Project_Overview_and_Room.md | **STALE** Rev 5.2 (Nov 2024) | Room dims 16'×26' (wrong); budget $75K–$95K (wrong) |
| 02_Front_Stage_System.md | **STALE** Rev 5.2 | Stage design pre-Option D; triangular corner subs referenced but old stage geometry |
| 03_Subwoofer_System.md | **STALE** Rev 5.9 (Dec 2025) | NX6000D amps; nearfield not deferred; 16 shakers |
| 11_Budget_Summary.md | **STALE** Rev 7.0 (Mar 10) | DSP-408 in electronics line; NX6000D in LF line; no HVAC; shakers 16× |
| 14_Quick_Reference.md | **STALE** Rev 7.0 (Mar 10) | NX6000D, DSP-408 + miniDSP — not updated for Option D (Mar 19) |
| 00_Master_Index.md | **PARTIAL** Mar 13 2026 | References both Rev 7.0 and doc 16 (HVAC) correctly; budget table still shows NX6000D-era LF |
