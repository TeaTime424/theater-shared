# Home Theater System - Master Index & Navigation
## Rev 7.0 Documentation Suite

**Last Updated:** March 10, 2026
**Total Documents:** 15+ files
**Current Revision:** 7.0 — Denon AVR-A1H, all Volt-10 surrounds/Atmos, -10 dB reference target

---

## Quick Navigation

### Core System Documents
1. **[Project Overview & Room Configuration](01_Project_Overview_and_Room.md)**
   - Project goals and timeline (2027 construction)
   - Room dimensions (16' × 26' × 10')
   - Acoustic treatment philosophy

2. **[Front Stage System](02_Front_Stage_System.md)**
   - Three-zone stage platform
   - Equipment rack placement
   - 170" acoustically transparent screen

3. **[Subwoofer System](03_Subwoofer_System.md)**
   - **16× Dayton UMII18-22** (all 18-inch)
   - 8× main array (4 triangular corner columns)
   - 8× nearfield (riser + console table)
   - **6× Behringer NX6000D** (5 active + 1 spare)
   - Performance: **~113 dB @ 20Hz main, ~120+ dB @ 15Hz nearfield**

4. **[Seating & Riser Platform](04_Seating_and_Riser.md)**
   - Nearfield integration (riser face + console table)
   - 16× Aura Pro bass shakers
   - Couch requirements

### Speaker & Electronics
5. **[Speaker System](05_Speaker_System.md)** ⭐ *Updated Rev 7.0*
   - LCR: 3× DIYSG Titan-815LX (99 dB, 6Ω)
   - Surrounds: 4× DIYSG Volt-10 (95 dB, 8Ω)
   - Atmos: 6× DIYSG Volt-10 (95 dB, 8Ω)
   - All driven by AVR-A1H internal amplification

6. **[Electronics & Control](06_Electronics_and_Control.md)** ⭐ *Major Update Rev 7.0*
   - **Denon AVR-A1H** (processor + 15ch amplification)
   - Dirac Live + Bass Control + ART ($799 bundle)
   - NX6000D sub/shaker amplification (unchanged)
   - DSP-408 + miniDSP 2×4 HD configuration

### Infrastructure & Design
7. **[Lighting & HVAC Systems](07_Lighting_and_HVAC.md)**
   - Lighting philosophy (zero ambient, work lights, safety)
   - HVAC placeholder superseded by doc 16 below

16. **[HVAC Plan — Theater Side](16_HVAC_Plan_Theater.md)** ⭐ *New*
    - **POR scope: Theater only** — gym HVAC separate future doc
    - MrCool DIY 5th Gen 12K 230V single-zone wall-mount
    - Complete parts list with costs (~$2,550–2,650 DIY)
    - Electrical requirements (20A double-pole, short panel run)
    - Noise analysis (23.5 dB silent mode — theater-appropriate)
    - Installation overview and head unit placement guidance
8. **[Construction Timeline](08_Construction_Timeline.md)**
9. **[Design Decisions & Rationale](09_Design_Decisions_Rationale.md)**

### Budget & Materials
10. **[Materials & Equipment Lists](10_Materials_and_Equipment.md)**
11. **[Budget Summary & Analysis](11_Budget_Summary.md)** ⭐ *Updated Rev 7.0*
    - Total system: **~$65,000-82,000**
    - Recommended: **~$72,000**
    - Electronics savings: **-$3,200** vs Rev 6.0

### Technical Reference
12. **[Technical Appendix - Subwoofers](12_Technical_Appendix_Subwoofers.md)**
13. **[Safety, Code & Maintenance](13_Safety_Code_Maintenance.md)**
14. **[Quick Reference & Change History](14_Quick_Reference.md)** ⭐ *Updated Rev 7.0*
15. **[UMII18-22 Excursion Limits Reference](UMII18-22_Excursion_Limits_Reference.md)**
    - Xmax vs Xmech definitions
    - Forum research (AVS, diyAudio, Data-bass)
    - Safe operating guidelines

### Subwoofer Design Files
- **[triangular_corner_sub/Linkwitz_Transform_Analysis.md](triangular_corner_sub/Linkwitz_Transform_Analysis.md)**
  - LT extension to 14 Hz (flat 115 dB to infrasonic)
  - Attenuation + EQ strategy
  - Excursion safety analysis
- **Plot Scripts:**
  - `triangular_corner_sub/plot_spl_xmax.py` - SPL/excursion baseline
  - `triangular_corner_sub/plot_spl_115db_target.py` - THX LFE target
  - `triangular_corner_sub/plot_lt_extended.py` - LT comparison

### Supplementary Documents
- **[Tactile_Bass_Shaker_System.md](Tactile_Bass_Shaker_System.md)**
  - 16× Aura Pro bass shakers
  - 1× NX6000D bridged @ 4Ω

### Reference Documents
- **[ICEpower_1200AS2_Reference.md](../ICEpower_1200AS2_Reference.md)** — Nearfield sub plate amp reference
- **[Behringer_NX6000_Reference.md](Behringer_NX6000_Reference.md)** — Sub/shaker amp reference
- **[Garage_Conversion_Option1.md](Garage_Conversion_Option1.md)** — Separate scaled-down theater option

---

## System Overview (Rev 7.0)

**Configuration:** 9.4.6 Dolby Atmos + Weapons-Grade Bass
**Target:** -10 dB Reference (95 dB at MLP)

| Subsystem | Components | Amplification |
|-----------|-----------|---------------|
| LCR | 3× Titan-815LX | Denon AVR-A1H (internal) |
| Surrounds | 4× Volt-10 | Denon AVR-A1H (internal) |
| Atmos | 6× Volt-10 | Denon AVR-A1H (internal) |
| Main subs | 8× UMII18-22 (4 corners) | 2× NX6000D |
| Nearfield subs | 8× UMII18-22 (riser + console) | 2× NX6000D |
| Bass shakers | 16× Aura Pro | 1× NX6000D |
| Spare | — | 1× NX6000D |

---

## Budget Overview (Rev 7.0)

| Category | Cost | % |
|----------|------|---|
| Projector | $30,000 | 41.7% |
| LF System | $12,327 | 17.1% |
| Speakers | $7,304 | 10.1% |
| Electronics | $7,549 | 10.5% |
| Seating | $6,000 | 8.3% |
| Acoustic Treatment | $5,500 | 7.6% |
| Screen + Infrastructure | $6,300 | 8.8% |
| **Total** | **~$72,000** | 100% |

---

## Revision History

| Rev | Date | Major Changes |
|-----|------|---------------|
| 5.0 | Nov 2024 | Upgraded Atmos to Volt-10 |
| 5.5 | Dec 2024 | PURIFI → NX6000D; Crowsons removed |
| 5.8 | Dec 2024 | "Weapons-Grade Bass": 16× UMII18-22 |
| 5.9 | Dec 2024 | Triangular corner columns |
| 6.0 | Feb 2025 | ICEpower 1200AS2 platform, 240V subpanel |
| **7.0** | **Mar 2026** | **AVR-A1H replaces AV10 + Buckeye; all Volt-10; -10 dB target; -$3,200** |

---

**Master Index Version:** 4.0 (Rev 7.0)
**Created:** November 22, 2025
**Updated:** March 13, 2026
