# Option D Home Theater — Master Index

**Revision:** Design Package v1.0
**Date:** 2026-03-15
**Source of Truth:** `specs.yaml`

---

## System Overview

| Parameter | Value |
|---|---|
| Configuration | 9.4.4 Dolby Atmos + 8x corner sub array + tactile |
| Room | 17' x 23' x 10' (3,910 cu ft) — Option D N-S partition |
| Building | 29' x 23' detached garage, partitioned into theater (east) + gym (west) |
| Screen | 170" 16:9 AT screen on north wall |
| Projector | JVC DLA-NZ500, native 4K D-ILA laser |
| Processor | Denon AVR-X6800H (13.4ch processing, 11ch internal amp) |
| LCR Amp | ATI AT525NC (5ch NCore, owned) |
| Sub Amps | 5x ICEpower 1200AS2 (240V, fanless) |
| Sub DSP | 2x Wondom APM2 (ADAU1701, 5.23 fixed-point) |
| Room Correction | Dirac Live Full + Bass Control + ART |
| Target SPL | 95 dB all channels (-10 dB Reference) |
| Corner Subs | 8x Dayton UMII18-22 in 4 sealed 24"x24"x96" cabinets |
| Nearfield Subs | DEFERRED (4x UMII18-22, add post-build) |
| Tactile | 8x Aura Pro AST-2B-4 (1 per seat) |
| Phase 1 (building) | $14,909 |
| Phase 2 (AV) | $25,275 |
| Total Out-of-Pocket | $40,184 |
| Already Owned Value | $13,450 |
| Total System Value | $53,634 |

---

## Document Index

| Doc | Title | Status |
|---|---|---|
| `00_index.md` | Master index and system summary | Current |
| `01_room_electrical_hvac.md` | Room, electrical, and HVAC specifications | Current |
| `02_speakers.md` | Speaker channels, amplification, SPL calculations | Current |
| `03_subwoofers.md` | Corner subs, nearfield (deferred), tactile, DSP | Current |
| `specs.yaml` | Single source of truth — all numbers | Current |

---

## Corrections Log

All corrections applied during design review, now baked into `specs.yaml`:

| # | Correction |
|---|---|
| 1 | Screen bottom: 30" (not 51") — 51" puts top above ceiling |
| 2 | Projector: NZ500 at 1.4:1 throw ratio needs 17.3 ft for 148" width — available depth ~18 ft — TIGHT FIT |
| 3 | Sub enclosures: rectangular 24x24x96, Fc=28.8 Hz, Qtc=0.69 (not triangular column numbers) |
| 4 | DSP: 2x Wondom APM2 (ADAU1701), NOT ADAU1452+CS42448 |
| 5 | APM2 power: 5V from ICEpower 1200AS2 AUX5V |
| 6 | Dirac ART MIMO: corner subs preserve per-channel independence |
| 7 | MrCool system: $2,359 — Phase 1 HVAC reflects this |
| 8 | UST projectors: OFF the table (incompatible with AT screen) |
| 9 | Electrical feed: #2 Al 240V, 60A breaker at house (NOT 100A) |
| 10 | Pool pump: Pentair IntelliFlow VSF, ~5A @ 240V; NEC load 39.6A within 60A |
| 11 | Equipment closet: NW corner of BUILDING (gym side) |
| 12 | Door: EAST WALL, 62" from NE corner |
| 13 | Power panel: EAST WALL, near door |
| 14 | Sub cabinet footprint: 24x24 (from layout_config.json, not 20x20) |
| 15 | Sub cabinet height: 96" (team assessment — Qtc=0.69, 2ft ceiling gap) |
| 16 | Volt-10 sensitivity: 95 dB (not 98 dB) |
| 17 | Option D removes WC from Phase 1 (deferred) |
| 18 | Option D removes vestibule/light-lock (direct entry via east wall door) |
| 19 | Budget Phase 1 total: $14,909 (corrected for no WC, no vestibule, sealed right door) |
| 20 | Gain staging: X6800H pre-out to ATI AT525NC input — standard consumer line level, no issues |

---

## New Grad vs Senior Scorecard

Design review used two adversarial perspectives. Summary of who got it right:

### Senior Wins

| Decision | Senior Position | Why Correct |
|---|---|---|
| ICEpower 1200AS2 platform | 240V native, fanless, no infrasonic derating, AUX5V for DSP boards | Proven Class D module. No mods. No derating at 15 Hz unlike NX6000D. |
| Rectangular sealed subs | 24"x24"x96" simple MDF boxes, horizontal partition | Dramatically easier to build than triangular columns. Same acoustic result. Standard lumber dimensions. |
| Partition wall HVAC mount | MrCool on partition wall, 7-8 ft high, painted black | Avoids screen wall conflicts, keeps condenser lines short, no ceiling ductwork needed |
| 96" cabinet height | Qtc=0.69, 2ft ceiling gap, standard 8ft lumber | Better than 72" (wastes corner fill) or 120" (diminishing returns, blocks ceiling treatment) |
| 60A feed identification | Correctly identified house breaker as 60A, not 100A | #2 Al wire is rated 90A but house breaker limits to 60A. Critical for NEC load calc. |
| Sealed right garage door | Seal and finish, not patio doors | Eliminates light leak, cheaper, better sound isolation |

### New Grad Wins

| Decision | New Grad Position | Why Correct |
|---|---|---|
| Dirac ART MIMO awareness | Flagged that ART requires independent sub channels — can't parallel corner subs | X6800H has 4 sub outputs. Each corner pair must be independently addressable for MIMO optimization. |
| UST rejection | Identified UST projectors as incompatible with AT screen (LCR behind screen) | UST throws upward from below screen — physically blocked by AT screen frame and LCR speakers. |
| Volt-10 95 dB correction | Caught sensitivity listed as 98 dB, corrected to 95 dB per DIYSG spec | 3 dB error would have caused under-powering. 95 dB with 140W X6800H still hits target with 14 dB headroom. |
| APM2 identification | Identified actual DSP boards as Wondom APM2 (ADAU1701), not bare ADAU1452 | APM2 is the actual product being used. Gets 5V from ICEpower AUX5V. Different fixed-point format (5.23 vs 8.24). |

### Assessment

Senior approach dominated on construction and infrastructure decisions where experience with real-world builds matters. New Grad caught spec errors and integration issues that require careful datasheet reading. Both perspectives were necessary — the Senior would have built with wrong Volt-10 sensitivity; the New Grad would have spec'd triangular columns.
