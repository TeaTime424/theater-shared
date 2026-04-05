# Subwoofer System Technical Summary
## AI Modeling Input Reference

**Room:** 16' × 26' × 10' (4,160 cu ft), fully treated, dedicated construction

**Driver (all positions):** Dayton Audio UMII18-22 — Fs 22Hz, Qts 0.53, Vas 248.2L, Xmax 28mm (Klippel), Sd 1184cm², sensitivity 90.7 dB @ 2.83V/1m, dual 2Ω VC (wired series = 4Ω per driver), 1,200W thermal rating, ~700W mechanical limit at 20Hz

## Main Array — 8 drivers, 4 corners

- **Config:** 2× drivers per corner, 4 corners, floor-to-ceiling triangular columns
- **Enclosure:** Sealed, ~10.25 cu ft per driver (20.5 cu ft per corner column)
- **Alignment:** Fc 30Hz, Qtc 0.72 (Butterworth)
- **Boundary gain:** +10-12 dB from full corner loading (floor + wall + wall)
- **Target:** 113+ dB @ 20Hz at MLP (13 ft from screen, Row 1)
- **Verified:** Model predicts ~123 dB — 10 dB headroom over target
- **Headroom:** +8 dB over THX Reference (105 dB)

## Front Nearfield — 4 drivers, 2 enclosures

- **Config:** 2× drivers per enclosure, mounted in riser face
- **Enclosure:** Sealed, 16 cu ft physical (~22 cu ft virtual with stuffing)
- **Alignment:** Fc ~30Hz
- **Distance:** 15" from listener chest (Row 1)
- **Boundary gain:** Partial — floor loading only, no corner gain
- **Verified ceiling @ 15Hz:** ~118 dB @ 15" (excursion-limited, cannot DSP-boost past this — displacement is flat below Fc in sealed box, 700W already reaches Xmax)
- **Performance @ 20Hz:** ~124 dB @ 15" (well above Fc, no excursion concern)
- **Note:** Original 121 dB target at 15Hz exceeds mechanical capability by ~3 dB. 118 dB at 15Hz at 15" remains extremely high output. Bass shakers supplement tactile impact in the infrasonic band.

## Rear Nearfield — 4 drivers, 2 enclosures

- **Config:** 2× drivers per enclosure, console towers behind Row 2
- **Enclosure:** Sealed, 25 cu ft physical (~34 cu ft virtual with stuffing)
- **Alignment:** Fc ~27Hz
- **Distance:** 15" from listener chest (Row 2)
- **Boundary gain:** Partial — floor loading only
- **Verified ceiling @ 15Hz:** ~120 dB @ 15" (excursion-limited, same constraint as front)
- **Performance @ 20Hz:** ~125 dB @ 15" (larger box, lower Fc helps)
- **Note:** Original 123 dB target at 15Hz exceeds mechanical capability by ~3 dB. Lower Fc from larger enclosure provides slight advantage over front nearfield.

## Wiring & Amplification — Late-Binding Decision

Two viable configurations exist. This choice impacts amp selection, channel count, and cost:

### Option A: 16 discrete channels, 4Ω per channel (1 amp channel per driver)
- Each driver: voice coils in series (2Ω + 2Ω = 4Ω)
- Each driver on its own amp channel
- **16 amplifier channels required**
- Full individual driver control (level, delay, EQ per driver)
- Amp must deliver 600-700W @ 4Ω to reach mechanical ceiling

### Option B: 8 channels, 8Ω per channel (2 drivers series per enclosure)
- Each driver: voice coils in series (4Ω per driver)
- Two drivers per enclosure wired in series (4Ω + 4Ω = 8Ω)
- **8 amplifier channels required**
- Paired driver control only (per-enclosure, not per-driver)
- Amp must deliver 1,200-1,400W @ 8Ω to deliver 600-700W per driver

### Trade-offs

| Factor | Option A (16ch @ 4Ω) | Option B (8ch @ 8Ω) |
|--------|----------------------|---------------------|
| Driver control | Individual | Paired per enclosure |
| Amp channel count | 16 | 8 |
| Load per channel | 4Ω | 8Ω |
| Power per channel needed | 600-700W | 1,200-1,400W |
| Dirac ART granularity | Maximum | Per-enclosure only |
| Amp cost | Higher (more channels) | Lower (fewer channels) |
| Wiring complexity | Higher | Lower |

## Combined System

- **Total drivers:** 16× UMII18-22
- **Total displacement per stroke:** 3.75 cu ft (28mm Klippel Xmax × 16 × 1184cm² Sd)
- **Total cone area:** 20.4 sq ft
- **Amplification:** 8 or 16 channels (see wiring decision above), 600-700W usable per driver at 20Hz (excursion-limited)
- **Operating band:** 15-80Hz (crosses to mains at 80Hz, nearfield extends to infrasonic)
- **DSP:** Dayton DSP-408 or miniDSP Flex HT — HPF at 18-20Hz for mains, Dirac ART for room correction across 4 independent sub zones
- **Tactile supplement:** 16× Aura Pro AST-2B-4 bass shakers (8 per couch, 20-80Hz)

## Listening Positions

- **Row 1 (MLP):** 13 ft from screen, floor level — served by main array + front nearfield
- **Row 2:** 18 ft from screen, 24" riser — served by main array + rear nearfield
- **Design goal:** Both rows experience identical perceived bass impact through combination of farfield array (room-pressurizing) and nearfield (chest-coupled air displacement)

## Verified Performance Summary

| Subsystem | @ 20Hz | @ 15Hz | Limit |
|-----------|--------|--------|-------|
| Main array @ MLP (13 ft) | ~123 dB | — | Boundary gain dominant |
| Front nearfield @ 15" | ~124 dB | ~118 dB | Excursion at 15Hz |
| Rear nearfield @ 15" | ~125 dB | ~120 dB | Excursion at 15Hz |
| THX Reference | 105 dB | — | — |

---

*Generated: February 2025*
*Verified against: SubCabLab Thiele-Small model, February 2026*
*Source: Home Theater System Rev 5.9 + amplifier analysis sessions*
