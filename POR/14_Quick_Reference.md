# Quick Reference & Change History
## Home Theater System - Rev 7.0

**Document Purpose:** System specifications summary and revision history.

**Last Updated:** March 10, 2026 — Rev 7.0: Denon AVR-A1H, all Volt-10, -10 dB reference target

---

## Quick Reference Specifications

### System at a Glance

```
SYSTEM: 9.4.6 Dolby Atmos + Weapons-Grade Bass
TARGET: -10 dB Reference (95 dB at MLP)
ROOM: 16' × 26' × 10' (4,160 cu ft)
SCREEN: 170" 2.35:1 AT
BUILD: 2027

PROCESSOR/AMPLIFIER:
└── Denon AVR-A1H (15ch internal, 150W×15 @ 8Ω)
    ├── Dirac Live Full Bandwidth + Bass Control + ART ($799 bundle)
    ├── 4 independent sub outputs
    └── 17.4ch pre-outs (growth path for external amps)

SPEAKERS:
├── LCR: 3× DIYSG Titan-815LX (99 dB, 6Ω)
├── Surrounds: 4× DIYSG Volt-10 (95 dB, 8Ω)
└── Atmos: 6× DIYSG Volt-10 (95 dB, 8Ω)

SUBWOOFERS:
├── Main: 8× Dayton UMII18-22 (4 triangular corner columns)
├── Nearfield: 8× Dayton UMII18-22 (riser + console)
├── Tactile: 16× Aura Pro bass shakers
├── Amplification: 6× Behringer NX6000D (5 active + 1 spare)
│   ├── 2 units → 8 corner sub drivers (8Ω series pairs)
│   ├── 2 units → 8 nearfield sub drivers (8Ω series pairs)
│   ├── 1 unit → bass shakers (bridged @ 4Ω)
│   └── 1 unit → spare
└── Total Displacement: 3.24 cu ft per stroke

DSP:
├── Dayton DSP-408 (sub management, 20Hz HPF minimum)
└── miniDSP 2×4 HD (sub-20Hz nearfield processing)

ELECTRICAL: Dedicated 100A subpanel
├── Circuit A: 20A (NX6000D #1-2, main subs)
├── Circuit B: 20A (NX6000D #3-5, nearfield + shakers)
├── Circuit C: 20A (AVR-A1H + DSP + sources)
└── Additional circuits for projector, convenience, spare

BUDGET: ~$72,000 recommended
```

---

## Performance Summary (at -10 dB Target: 95 dB)

| Channel | SPL @ Seat | Headroom over 95 dB |
|---------|------------|---------------------|
| LCR @ Row 1 | ~106 dB | +11 dB |
| LCR @ Row 2 | ~102 dB | +7 dB |
| Surrounds | ~105-107 dB | +10-12 dB |
| Atmos | ~104-107 dB | +9-12 dB |
| Main subs @ 20Hz | ~113 dB | +18 dB |
| Nearfield @ 15Hz @ 15" | ~120+ dB | Chest compression |

**All channels exceed target with substantial margin.**

---

## Revision History

| Rev | Date | Key Changes |
|-----|------|-------------|
| 5.0 | Nov 2024 | Upgraded Atmos to Volt-10 |
| 5.5 | Dec 2024 | PURIFI → NX6000D amplifiers; Crowsons replaced by nearfield subs |
| 5.8 | Dec 2024 | "Weapons-Grade": 16× UMII18-22, unified driver platform |
| 5.9 | Dec 2024 | Triangular corner columns, split-build design |
| 6.0 | Feb 2025 | ICEpower 1200AS2 platform (16 individual channels), 240V subpanel |
| **7.0** | **Mar 2026** | **Denon AVR-A1H replaces Marantz AV10 + Buckeye separates; all surrounds Volt-10; target -10 dB reference (95 dB); ~$3,200 savings** |

### Rev 7.0 Changes in Detail

**Processor/Amplifier:**
- Removed: Marantz AV10 (~$7,000) + Buckeye NC502MP 8-ch (~$2,200) + Buckeye NC252MP 6-ch (~$1,300)
- Added: Denon AVR-A1H (~$6,500) + Dirac Live bundle ($799)
- Net savings: ~$3,200

**Speakers:**
- Surrounds changed from HT-12 to Volt-10 (all 10 surround/Atmos channels now identical)
- Speaker cost reduced from ~$9,500 to ~$7,304

**Target Level:**
- Changed from THX Reference (105 dB) to -10 dB Reference (95 dB)
- Validated by owner's current system reaching uncomfortable levels at -10 dB dial position
- AVR-A1H provides 7+ dB headroom on all channels at this target

**Subwoofer Chain:**
- Unchanged: NX6000D platform, DSP-408, miniDSP 2×4 HD

---

**Document Version:** 3.0 (Rev 7.0)
**Created:** November 22, 2025
**Updated:** March 10, 2026
