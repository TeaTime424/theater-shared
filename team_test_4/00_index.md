# Option D Home Theater — Master Index

## System Summary

| Parameter | Value |
|-----------|-------|
| Configuration | 9.4.4 Dolby Atmos |
| Room | 17' x 23' x 10' (3,910 cu ft) |
| Layout | N-S partition: 17'x23' theater (east) + 12'x23' gym (west) |
| Screen | 170" 16:9 AT on north wall |
| Target Level | -10 dB Reference (95 dB all channels at MLP) |
| Subwoofers | 8x UMII18-22 in 4 corner stacks, sealed |
| Processor | Denon AVR-X6800H + Dirac Live Full/Bass Control/ART |
| Sub DSP | 2x Wondom APM2 (ADAU1701) |
| Sub Amps | 5x ICEpower 1200AS2 (240V, fanless) |
| LCR Amp | ATI AT525NC (owned) |
| Budget | $48,704 out-of-pocket |
| Build | 2027 |

## Document Index

| Doc | Title | Status |
|-----|-------|--------|
| 00_index.md | Master index & corrections | CURRENT |
| 01_room_electrical_hvac.md | Room, electrical, HVAC | CURRENT |
| 02_speakers.md | 13 speaker channels | CURRENT |
| 03_subwoofers.md | Corner subs, nearfield, tactile | CURRENT |
| 04_amplification_dsp.md | Amps, DSP, signal flow, gain staging | CURRENT |
| 05_screen_seating.md | Screen, projector, viewing angles | CURRENT |
| 06_budget.md | Budget, phases, deferrals | CURRENT |
| specs.yaml | Single source of truth for all values | CURRENT |

## Corrections Log

All corrections applied in specs.yaml and propagated to documents.

| ID | Field | Was | Now | Reason |
|----|-------|-----|-----|--------|
| C1 | screen.bottom_from_floor_in | 51" | 30" | 51" puts 170" screen top at 134" -- above 120" ceiling |
| C2 | sub_dsp.platform | ADAU1452+CS42448 | 2x Wondom APM2 (ADAU1701) | Use proven APM2 hardware |
| C3 | sub_dsp.power_source | Dedicated PSU | ICEpower AUX5V | 1200AS2 provides regulated 5V -- no separate PSU |
| C4 | corner_array.cabinet | Triangular columns, ~10.25 cu ft | Rectangular stacked 20x20x72", ~6.4 cu ft net | Option D uses rectangular cabinets |
| C5 | corner_array.performance | Fc=30 Hz, Qtc=0.72 | Fc=31.6 Hz, Qtc=0.76 | Recalculated for actual volume |
| C6 | tactile.qty | 16 | 8 | 1/seat is community standard, 2/seat unproven |
| C7 | hvac.system_cost | ~$1,800 | $2,359 | Actual MrCool DIY 12K price verified |
| C8 | processor_dsp.subtotal | $4,707 | $4,697 | APM2 ($50) replaces ADAU1452 ($60) |
| C9 | signal_flow.sub_independence | Mixed/summed OK | Per-channel independence REQUIRED | Dirac ART MIMO signals |
| C10 | surrounds.sensitivity_db | 98 dB | 95 dB | DIYSG official spec |

## New Grad vs Senior Scorecard

| Dimension | New Grad Position | Senior Position | Verdict |
|-----------|-------------------|-----------------|---------|
| Sub DSP | ADAU1452 -- modern, 8.24 fixed, more headroom | APM2 (ADAU1701) -- proven, owned tooling, 5V from ICEpower | **Senior wins** -- proven > theoretical |
| Sub amplification | Class D modules with DSP built in | ICEpower 1200AS2 -- discrete, fanless, no derating | **Senior wins** -- no infrasonic derating is critical |
| Speaker count | 9.4.6 (6 Atmos) -- more immersive | 9.4.4 -- sufficient for 17'x23', simpler wiring | **Senior wins** -- diminishing returns in this room size |
| Processing | Separate pre-pro + multichannel amp | X6800H + ATI hybrid -- fewer boxes, same result | **Senior wins** -- simpler signal chain |
| Sub topology | Ported for max output | Sealed -- easier EQ, room gain compensates | **Senior wins** -- room pressurization favors sealed |
| Sub count | 4 (enough for most rooms) | 8 corner-loaded -- smoother mode distribution | **Senior wins** -- seat-to-seat variance matters |
| Architecture | Feature-rich, integrated | Minimal, testable, modular | **Senior wins** -- test-first, keep it simple |
| Budget approach | Buy best components | Buy proven, defer uncertain items | **Senior wins** -- bass deferral saves $2,260 risk |

**Summary:** Senior approach dominates on every axis. New grad impulse to over-spec DSP and add channels is counterproductive in a room this size. Proven hardware, test-first methodology, and strategic deferral reduce both cost and risk.
