# Phase 1: Architect Plan — Option D Design Package

**Date:** 2026-03-14
**Scope:** Comprehensive Option D (N-S partition, 17'x23' theater) design package
**Output:** `theater/team_test/`
**Status:** PLAN — no implementation yet

---

## Current State

### What Exists

The project has 16+ POR documents built across Revs 5.0-7.0, a Garage Conversion doc at v3.7, three completed adversarial investigations, and working DSP/audio tool pipelines. Key facts:

**Room:** 29'x23' detached garage, N-S partition yields 17'x23'x10' theater (3,910 cu ft), 12'x23' gym.

**Configuration:** 9.4.4 Dolby Atmos (13 channels: 9 bed + 4 height)

**Speakers (decided):**
- LCR: 3x Titan-815LX (99 dB, 6 ohm) -- owned
- Surr+Atmos+FW: 10x Volt-10 (95 dB, 8 ohm)

**Amplification (decided):**
- Speaker: X6800H internal (8ch surr/height) + ATI AT525NC (5ch LCR+FW, owned)
- Sub: 5x ICEpower 1200AS2 (4 active + 1 spare), 240V, rack-mounted
- Processor: Denon AVR-X6800H ($3,700) + Dirac Live Full+BC+ART ($799)

**Subs (decided):**
- Corner: 8x UMII18-22 in 4 stacked rectangular cabinets (2/corner)
- Nearfield: 4x UMII18-22 deferred (space reserved behind Row 1)
- Tactile: 8x Aura Pro (1/seat), reducible from 16

**DSP (decided):**
- ADAU1452 + CS42448 (4in/8out), replaces DSP-408 + miniDSP
- Autonomous calibration via Python/REW/SigmaStudio COM pipeline

**Screen:** 170" 16:9 AT (scope content letterboxes within)

**Projector:** JVC DLA-NZ500 ($5,999)

**HVAC:** MrCool DIY 12K 230V, partition wall mount, ~$2,550

**Budget:** $36,624 out-of-pocket ($11,059 Phase 1 + $25,565 Phase 2), $13,450 already owned, ~$50,074 total value

### Key Document Issues Found

1. **Garage Conversion doc references both "Marantz AV10" and "Denon X6800H"** in DSP signal flow diagram (line 13 of section 2 in DSP doc still says "Marantz AV10" -- should be X6800H for Option D)
2. **POR doc 02_Front_Stage_System.md is stale at Rev 5.2** -- still shows Marantz AV10 + PURIFI monoblocks + Buckeye amps in rack diagram. Never updated for Rev 6.0 or 7.0.
3. **POR doc 01_Project_Overview_and_Room.md is stale at Rev 5.2** -- room dimensions still 16'x26', not updated for garage conversion
4. **Electrical load analysis (electrical_load_analysis.md) is stale** -- still references Buckeye amps and Marantz AV10, pre-Rev 7.0
5. **09_Design_Decisions_Rationale.md is stale at Rev 5.2** -- references Marantz AV10 vs StormAudio, PURIFI monoblocks
6. **Option D sub enclosures are rectangular stacked (20"x20"x72")** but POR sub docs describe triangular corner columns -- Option D section in Garage_Conversion_Option1.md correctly describes rectangular, but no standalone sub spec exists for the Option D geometry
7. **HVAC doc 16 says room is 17'x23'** but older docs still reference 16'x26' -- these are different rooms (reference vs garage conversion). The team_test package should be unambiguous about which room.
8. **Screen aspect ratio inconsistency:** CLAUDE.md says 170" 2.35:1, Option D says 170" 16:9. Option D explicitly chose 16:9 (scope content letterboxes). This needs clear documentation.
9. **Budget line items for HVAC** in Phase 1 of Option D are slightly inconsistent with the dedicated HVAC doc (doc 16 says ~$2,550, Option D Phase 1 lines 7+8 total $2,559 -- close enough but should match exactly)
10. **DSP doc (15_DSP_Subwoofer_Processing.md) references Marantz AV10** as the processor providing 4 sub outputs -- should be X6800H for Option D
11. **Option D nearfield design changed** from POR's riser-face + console-tower to a single full-width cabinet behind Row 1 + sofa table between rows. The POR nearfield docs (NearFieldv3/) don't apply to Option D.
12. **11_Budget_Summary.md and 06_Electronics_and_Control.md don't exist** at the paths listed in the master index (they use slightly different filenames: `11_Budget_Summary.md` vs `11_Budget_Analysis.md`)

---

## Proposed Document Tree

```
team_test/
  00_index.md                    # Master index with system summary
  01_room_construction.md        # Building spec, partition, openings, finishes
  02_electrical.md               # Panel, circuits, wiring, outlets
  03_hvac.md                     # MrCool spec, install, noise
  04_speaker_system.md           # LCR, surr, Atmos -- specs + critical assessment
  05_subwoofer_system.md         # Corner, nearfield (deferred), tactile -- specs + critical assessment
  06_amplification.md            # ICEpower 1200AS2, ATI AT525NC, X6800H internal -- critical assessment
  07_dsp_processing.md           # ADAU1452, X6800H Dirac, signal flow -- critical assessment
  08_screen_projector.md         # Screen spec, projector spec, throw/geometry
  09_seating_viewing.md          # Rows, riser, viewing angles, ergonomics
  10_equipment_room.md           # Closet spec, rack, cooling, cable routing
  11_acoustic_treatment.md       # Absorption, diffusion, bass traps, RT60 targets
  12_wiring_signal_flow.md       # Complete signal path, cable schedule, connector spec
  13_budget.md                   # Phase 1 + Phase 2, line items, owned inventory
  14_construction_sequence.md    # Phased build order with dependencies
  diagrams/
    config.py                    # Shared dimensions, positions, colors
    generate_all.py              # Master runner
    d01_floor_plan.py            # Top-down room layout with zones
    d02_front_elevation.py       # Screen wall elevation (subs, screen, LCR, HVAC head)
    d03_side_section.py          # Cross-section showing stage, rows, riser, clearances
    d04_speaker_layout.py        # 3D speaker positions (bed + height) with angles
    d05_sub_placement.py         # Corner sub positions with boundary loading diagram
    d06_signal_flow.py           # Full system signal flow (sources -> processor -> amps -> drivers)
    d07_electrical_panel.py      # Panel layout with circuit assignments
    d08_equipment_rack.py        # Rack elevation with unit assignments
    d09_wiring_runs.py           # Cable routing paths overlaid on floor plan
    d10_viewing_geometry.py      # Screen size vs viewing angles at Row 1 and Row 2
  models/
    room_layout.blend            # Empty room with partition, openings, dimensions
    full_room.blend              # Room + stage + riser + seating + screen + speakers + subs
    sub_cabinet.blend            # Rectangular stacked corner sub (20"x20"x72")
    speaker_enclosures.blend     # Titan-815LX + Volt-10 enclosure models
```

---

## Document Specifications

### 00_index.md — Master Index
- System summary table (config, target level, room, budget)
- Document list with one-line descriptions
- Diagram list
- Model list
- Revision history
- **Feeds from:** All other docs (written last or maintained as others are written)

### 01_room_construction.md — Room & Construction
Sections:
1. Existing structure (29'x23' garage, what's there now)
2. Partition wall spec (N-S, 2x6, R-19, STC rating)
3. Theater zone (17'x23'x10', north wall = screen wall)
4. Garage door disposition (right: seal, left: keep for gym)
5. Equipment closet (4'x4', NE corner of gym)
6. Flooring (carpet + pad, 391 sq ft)
7. Walls and ceiling finish
8. Door spec (equipment closet, theater entry from east)
9. Acoustic considerations for construction (mass, decoupling)

**Feeds from:** Garage_Conversion_Option1.md (Option D sections)
**Needs calculation:** STC estimate for partition wall, thermal bridging assessment

### 02_electrical.md — Electrical Plan
Sections:
1. Existing panel (100A Square D)
2. Circuit schedule (5 circuits: sub amps 240V, processor 120V, projector 120V, HVAC 240V, gym 120V)
3. Wire gauge and run lengths
4. Outlet placement map
5. Grounding strategy
6. Panel load analysis (idle, moderate, peak)
7. Projector ceiling outlet
8. Equipment closet power

**Feeds from:** electrical_load_analysis.md (stale -- needs recalc for ICEpower + X6800H), Garage_Conversion_Option1.md
**Needs calculation:** Updated load analysis for ICEpower 1200AS2 (5 units on single 240V 20A circuit) + X6800H + ATI AT525NC

### 03_hvac.md — HVAC Specification
Sections:
1. Thermal load (theater only, equipment isolated)
2. Unit selection (MrCool DIY 12K 230V)
3. Head unit placement (partition wall, 7-8' high)
4. Lineset routing (outdoor condenser on north wall, through gym, through partition)
5. Condensate management
6. Electrical (20A 240V double-pole)
7. Noise performance (silent mode 23.5 dB)
8. Pre-cool protocol
9. Parts list and cost
10. Gym HVAC (deferred, notes only)

**Feeds from:** 16_HVAC_Plan_Theater.md, hvac-theater-setup investigation
**Needs validation:** Lineset run length confirmation (must be <25' for Quick Connect)

### 04_speaker_system.md — Speaker System (Critical Assessment)
Sections:
1. System overview table (13 speakers, models, sensitivity, impedance)
2. LCR: Titan-815LX spec, placement, isolation (Sorbothane)
3. Front Wides: Volt-10 on partition wall (FWL) and east wall (FWR)
4. Surrounds: Volt-10 (SL on partition, SR on east wall, SBL/SBR on south wall)
5. Heights: Volt-10 ceiling (TFL, TFR, TRL, TRR)
6. Amplifier matching (power, SPL at seat, headroom)
7. **Critical assessment:**
   - WHY Titan-815LX is correct (99 dB sensitivity, proven DIYSG design, ported for extension, already owned)
   - WHY Volt-10 is correct (coaxial for off-axis, point source for Atmos/surround, 95 dB, timbral matching across 10 identical speakers)
   - WEAKNESS: 6 ohm LCR on AVR/ATI (ATI handles it fine at 300W, X6800H internal would be fine too but ATI is better)
   - WEAKNESS: Volt-10 95 dB sensitivity is moderate -- but at 7-8.5' surround distance in 17' room, headroom is +13-15 dB over 95 dB target
   - SUGGESTION: Consider Titan-615LX for surrounds if wider dispersion is desired (lower priority -- Volt-10 coaxial is better for this application)

**Feeds from:** 05_Speaker_System.md, Garage_Conversion_Option1.md
**Needs calculation:** Verify SPL at seat for 17'x23' geometry (different distances than reference room)

### 05_subwoofer_system.md — Subwoofer System (Critical Assessment)
Sections:
1. System overview (8 corner + 4 deferred nearfield + 8 shakers)
2. Corner subs: rectangular stacked cabinets (20"x20"x72"), 2 drivers/corner, sealed
3. Driver spec (UMII18-22, T/S parameters)
4. Wiring (series VCs = 4 ohm/driver, series pair = 8 ohm/cabinet)
5. Boundary loading analysis (+11 dB corner gain)
6. Performance estimates (SPL at MLP at 20Hz, 15Hz, 10Hz)
7. Nearfield subs: deferred design, space reservation, add-later plan
8. Tactile: 8x Aura Pro, mounting, bandwidth
9. Enclosure materials and construction
10. **Critical assessment:**
    - WHY UMII18-22 (22Hz Fs, 28mm Xmax, $350, proven platform, 2 already owned)
    - WHY sealed (room gain compensates rolloff, no port chuffing, simpler EQ, tighter transients)
    - WHY 4 corners (Welti/Harman uniformity research, +11 dB boundary gain)
    - WEAKNESS: Rectangular stacked cabinets have less volume per driver than triangular columns (~8.5 cu ft vs ~10.25 cu ft). Fc ~33 Hz vs ~30 Hz. Slightly less headroom at 15-20 Hz (~2 dB)
    - WEAKNESS: 72" tall cabinets in 17' room corners -- need to verify clearance for screen edges and LCR placement
    - SUGGESTION: Consider reverting to triangular columns if corner space permits -- they provide 20% more volume per driver and integrate acoustic treatment
    - SUGGESTION: Model whether 17' wall allows triangular columns (24"x24" footprint) while maintaining screen clearance (170" 16:9 = 148" image width, 17' wall = 204", clearance = 28" per side -- triangular column hypotenuse is ~34", won't fit)
    - FINDING: **Rectangular is correct for Option D.** 28" clearance per side won't accommodate 34" triangular hypotenuse. The 20"x20" rectangular footprint fits. This is a design constraint the POR doesn't highlight.

**Feeds from:** 03_Subwoofer_System.md, Garage_Conversion_Option1.md, bass-plan-overkill investigation
**Needs calculation:** Sealed box modeling for 8.5 cu ft/driver (Fc, Qtc, F3), SPL at MLP accounting for room gain in 3,910 cu ft room

### 06_amplification.md — Amplification (Critical Assessment)
Sections:
1. Sub amps: ICEpower 1200AS2 (5 units, rack-mounted, 240V)
2. LCR + FW amp: ATI AT525NC (5ch NCore, 200W, owned)
3. Surround/Height amp: X6800H internal (8ch, 100-140W)
4. Chassis design for ICEpower modules (heatsinking, ventilation)
5. Power specs at target frequencies (especially 15-20 Hz)
6. **Critical assessment:**
    - WHY ICEpower 1200AS2 (no derating below 30 Hz, fanless, 240V native, single circuit, zero mods, $373/unit)
    - WHY ATI AT525NC (NCore topology, 200-300W into 6 ohm, already owned, superior to X6800H internal for LCR)
    - WHY X6800H internal for surrounds (105-140W into 8 ohm, +13-15 dB headroom, no external amp needed)
    - WEAKNESS: ICEpower 1200AS2 continuous power is only 140W at 8 ohm (620W burst). Movie crest factor means this is fine, but sustained test tones at high level will trigger thermal protection.
    - WEAKNESS: Custom chassis required for rack-mounting ICEpower modules. Not commercially available. Must design and fabricate.
    - WEAKNESS: 1200AS2 thermal shutdown risk if closet ventilation is inadequate. 4'x4' closet with 175W idle + burst heat needs verified airflow.
    - SUGGESTION: Design closet ventilation as part of construction phase (passive vent to gym or small exhaust fan)
    - SUGGESTION: Buy spare module at build time ($373 insurance). Modules may become unavailable (ICEpower product cycles).

**Feeds from:** nx6000d-vs-icepower investigation, Garage_Conversion_Option1.md, ICEpower_1200AS2_Reference.md
**Needs calculation:** Thermal analysis for 4'x4' closet (total heat load, required CFM, vent sizing)

### 07_dsp_processing.md — DSP & Processing (Critical Assessment)
Sections:
1. X6800H as processor (13.4ch, Dirac Live Full+BC+ART)
2. ADAU1452 sub DSP (4in/8out, replaces DSP-408 + miniDSP)
3. Signal flow diagram (sources -> X6800H -> speakers + sub pre-outs -> ADAU1452 -> ICEpower -> drivers)
4. Dirac configuration (room correction, bass control for 4 subs)
5. ADAU1452 processing chain per output
6. Calibration pipeline (Python + REW + SigmaStudio COM)
7. **Critical assessment:**
    - WHY X6800H over A1H (saves $2,800, 13.4ch is sufficient for 9.4.4, pre-outs for ATI give better LCR amp)
    - WHY ADAU1452 over DSP-408 (HPF below 20 Hz, automated calibration, $60 vs $250+$200, unified with existing DSP tooling)
    - WEAKNESS: X6800H has 13.4ch processing vs A1H's 15.4ch. If future upgrade to 9.4.6 is desired, need new processor.
    - WEAKNESS: ADAU1452 Chinese dev board -- quality varies, no formal support. Must validate board before install.
    - WEAKNESS: Dirac Live license is tied to the processor. If X6800H fails, replacement X6800H needs new Dirac license (or transfer, which Dirac currently supports).
    - SUGGESTION: Validate ADAU1452 board on bench with test signals before committing to install. The existing ADAU1701 pipeline proves the tooling works, but the 1452 board itself needs verification.
    - SUGGESTION: Consider whether Audyssey MultEQ XT32 (included free) is sufficient before buying $799 Dirac bundle. Test first, buy if needed.

**Feeds from:** 15_DSP_Subwoofer_Processing.md, 06_Electronics_and_Control.md, Garage_Conversion_Option1.md
**Needs validation:** Confirm X6800H has 4 independent sub outputs (verified: yes, per Denon spec)

### 08_screen_projector.md — Screen & Projector
Sections:
1. Screen: 170" 16:9 AT fabric, frame-mounted
2. Why 16:9 over 2.35:1 (TV/gaming uses full screen, scope letterboxes within, no masking needed)
3. Screen wall clearance (28" per side in 17' room)
4. Projector: JVC DLA-NZ500 ($5,999)
5. Throw distance calculation (MLP at 14', projector at ~16-18' from screen)
6. Lens shift, keystone, mounting
7. Image quality specs (native 4K D-ILA, laser, 40,000:1 CR)
8. Power requirement (dedicated 20A circuit)
9. Projector selection deferred to 2027 -- market may shift

**Feeds from:** Garage_Conversion_Option1.md
**Needs calculation:** JVC NZ500 throw ratio vs 170" 16:9 screen at available ceiling positions

### 09_seating_viewing.md — Seating & Viewing Geometry
Sections:
1. Row 1 (MLP): 10.5' from screen surface, floor level, 61 deg viewing angle
2. Row 2: 15' from screen surface, 24" riser, 45 deg viewing angle
3. Riser spec (16'x4.5', 24" height, CLD deck)
4. Couch spec (4-seat, solid wood frame for shaker mounting, dark fabric)
5. Rear clearance (1' behind Row 2 -- tight, notes on mitigation)
6. Viewing angle analysis per THX/SMPTE/IMAX standards
7. Sightline verification (Row 2 eyes clear Row 1 heads with 24" riser + seat height)

**Feeds from:** Garage_Conversion_Option1.md, 04_Seating_and_Riser.md
**Needs calculation:** Sightline geometry (Row 2 eye height above screen bottom vs Row 1 head height)

### 10_equipment_room.md — Equipment Room
Sections:
1. Location: NE corner of gym, 4'x4'
2. Contents: X6800H, ATI AT525NC, 4x ICEpower 1200AS2 (+1 spare), ADAU1452, UPS, network switch
3. Rack spec (open-frame, standard 19")
4. Rack layout (unit assignments by RU)
5. Ventilation (passive vent to gym or exhaust fan)
6. Cable routing through partition wall to theater
7. Service access from gym side
8. Heat load and cooling

**Feeds from:** Garage_Conversion_Option1.md
**Needs calculation:** Total heat load in closet (idle + burst), required ventilation CFM

### 11_acoustic_treatment.md — Acoustic Treatment
Sections:
1. Treatment philosophy (modal control, early reflections, RT60)
2. Absorption panels (OC 703, Roxul Safe'n'Sound, Guilford of Maine fabric)
3. Diffusion (rear wall QRD or Leanfuser)
4. Bass trapping (corner subs double as broadband absorbers if wrapped in OC 703)
5. First reflection points (side walls, ceiling)
6. Rear wall treatment (behind Row 2)
7. Target RT60 (0.3-0.4s, per Dolby Atmos home theater recommendation)
8. Material quantities and placement
9. Cost: $0 additional (materials already owned, $4,250)

**Feeds from:** 01_Project_Overview_and_Room.md, acoustic_diffusion/ docs, owned inventory
**Needs calculation:** Sabine RT60 estimate for 3,910 cu ft room with planned treatment

### 12_wiring_signal_flow.md — Wiring & Signal Flow
Sections:
1. Complete signal flow (block diagram)
2. HDMI: sources -> X6800H -> projector
3. Speaker cable: X6800H speaker outputs (8ch) -> surrounds/heights, ATI -> LCR/FW
4. Sub signal: X6800H sub pre-outs (4x RCA) -> ADAU1452 -> ICEpower (8x RCA)
5. Sub power: ICEpower speaker outputs -> corner subs (SpeakON), nearfield, shakers
6. Cable schedule (type, gauge, length, connectors)
7. Wall penetration locations (partition wall pass-throughs)
8. Cable management in equipment closet

**Feeds from:** 15_DSP_Subwoofer_Processing.md, 06_Electronics_and_Control.md, Garage_Conversion_Option1.md

### 13_budget.md — Budget Summary
Sections:
1. Already owned inventory (3x Titan-815LX, ATI AT525NC, 2x UMII18-22, treatment materials, Denon X4700)
2. Phase 1: Building Prep ($11,059) -- line items
3. Phase 2: Home Theater ($25,565) -- line items
4. Grand total ($36,624 OOP, $50,074 total value)
5. Deferred items (nearfield subs, additional shakers, gym HVAC, WC)
6. Comparison to reference design

**Feeds from:** Garage_Conversion_Option1.md (Option D budget sections)
**Needs validation:** Cross-check all line items against component docs for current pricing

### 14_construction_sequence.md — Build Sequence
Sections:
1. Phase 1: Building Prep (permits -> demo -> partition -> electrical rough-in -> HVAC -> finish)
2. Phase 2: Theater Build (stage -> subs -> riser -> screen -> speakers -> equipment -> wiring -> shakers)
3. Phase 3: Calibration (Dirac -> ADAU1452 -> level matching -> subjective evaluation)
4. Critical path dependencies
5. Parallel work streams (workshop builds concurrent with room prep)
6. Timeline estimates

**Feeds from:** 08_Construction_Timeline.md, Garage_Conversion_Option1.md

---

## Diagram Specifications

### config.py — Shared Configuration
```python
# Room dimensions (inches)
ROOM_WIDTH = 17 * 12    # 204" (N-S, screen wall)
ROOM_DEPTH = 23 * 12    # 276" (E-W, seating axis)
ROOM_HEIGHT = 10 * 12   # 120"

# Screen
SCREEN_DIAGONAL = 170   # inches, 16:9
SCREEN_WIDTH = 148.1    # inches (calculated)
SCREEN_HEIGHT = 83.3    # inches (calculated)
SCREEN_BOTTOM = 51      # inches from floor (on stage deck + offset)

# Stage
STAGE_DEPTH = 36        # inches (3')
STAGE_HEIGHT = 27       # inches

# Riser
RISER_DEPTH = 54        # inches (4.5')
RISER_HEIGHT = 24       # inches
RISER_FRONT = 192       # inches from screen wall (16')

# Seating
ROW1_DISTANCE = 126     # inches from screen surface (10.5')
ROW2_DISTANCE = 180     # inches from screen surface (15')

# Sub cabinets
SUB_WIDTH = 20          # inches
SUB_DEPTH = 20          # inches
SUB_HEIGHT = 72         # inches (6')

# Equipment closet
CLOSET_WIDTH = 48       # inches (4')
CLOSET_DEPTH = 48       # inches (4')

# Colors, fonts, etc.
```

### d01_floor_plan.py — Room Layout (Top-Down)
- Shows: full 29'x23' building with N-S partition, theater zone, gym zone, equipment closet
- Key elements: partition wall, screen wall, stage footprint, Row 1, Row 2, riser, corner sub positions, entry door, equipment closet
- Labels: dimensions, zones, cardinal directions
- Dependencies: config.py

### d02_front_elevation.py — Screen Wall Elevation
- Shows: north wall from theater side
- Key elements: screen (148" wide, centered), LCR positions behind screen, corner subs flanking screen, HVAC head (on partition wall, not screen wall -- note: this is a SIDE view element, not front wall)
- Actually: Front elevation should show the screen wall with subs, screen, and LCR. HVAC is on the west (partition) wall.
- Labels: heights, clearances, driver positions

### d03_side_section.py — Cross-Section
- Shows: E-W cross-section through center of room
- Key elements: stage (27" height), screen, Row 1 (floor level), gap, riser (24" height), Row 2, rear wall, ceiling
- Labels: distances, heights, sightlines
- Dependencies: config.py

### d04_speaker_layout.py — Speaker Positions
- Shows: 3D wireframe or top-down + elevation views
- Key elements: all 13 speaker positions with angles from MLP
- Labels: speaker model, channel name, angle, distance
- Dependencies: config.py

### d05_sub_placement.py — Subwoofer Positions
- Shows: top-down with corner sub positions, boundary loading arrows
- Key elements: 4 corner cabinets, wall boundaries, driver positions
- Labels: dimensions, boundary gain indicators
- Dependencies: config.py

### d06_signal_flow.py — System Signal Flow
- Shows: block diagram from sources through processing to drivers
- Key elements: source devices, X6800H (processing + 8ch speaker amps), ATI AT525NC (5ch), ADAU1452 (sub DSP), ICEpower 1200AS2 (sub amps), all endpoints
- Labels: signal types (HDMI, speaker level, line level, SpeakON)

### d07_electrical_panel.py — Panel Layout
- Shows: 100A panel with circuit breaker assignments
- Key elements: each circuit, rating, load
- Labels: circuit name, amperage, 120V/240V

### d08_equipment_rack.py — Rack Elevation
- Shows: front view of equipment rack with unit positions
- Key elements: X6800H, ATI AT525NC, ICEpower modules (in chassis), ADAU1452, UPS, network switch, power distribution
- Labels: RU positions, unit names

### d09_wiring_runs.py — Cable Routing
- Shows: floor plan overlay with cable paths
- Key elements: speaker wire runs, signal cable runs, power cable runs, wall penetration points
- Labels: cable type, gauge, connector type

### d10_viewing_geometry.py — Viewing Angles
- Shows: side view with screen, Row 1, Row 2, viewing angle arcs
- Key elements: THX reference angle, SMPTE minimum, actual angles
- Labels: distances, angles, standards compliance

---

## 3D Model Specifications

### room_layout.blend — Empty Room
- 29'x23' building shell
- N-S partition wall at 12' from west wall
- Equipment closet (4'x4') in NE corner of gym
- Right garage door opening sealed
- Left garage door opening (gym side)
- 36" personnel door on east wall
- Dimensions annotated
- **Data:** All dimensions from config.py / Garage_Conversion_Option1.md

### full_room.blend — Complete Room
- Everything from room_layout.blend plus:
- Stage platform (3' deep, 27" tall)
- False wall / screen wall structure
- 170" 16:9 screen (positioned on north wall)
- 3x Titan-815LX behind screen
- 10x Volt-10 at specified positions (wall mounts + ceiling)
- 4 corner sub cabinets (20"x20"x72")
- Riser platform (16'x4.5', 24" tall)
- 2 couches (approximate, 4-seat, 11' wide)
- Equipment closet with rack
- HVAC head unit on partition wall
- **Data:** Speaker dimensions from DIYSG specs, sub dimensions from Option D

### sub_cabinet.blend — Corner Sub Cabinet
- Rectangular box: 20"W x 20"D x 72"H
- Two UMII18-22 cutouts (18" nominal, actual cutout TBD from driver spec)
- 3/4" wall thickness
- Internal bracing visible in cutaway
- Driver positions (lower ~15" from bottom, upper ~50" from bottom -- TBD exact)
- **Data:** UMII18-22 frame dimensions, cabinet volume requirement (8.5 cu ft/driver)

### speaker_enclosures.blend — Speaker Models
- Titan-815LX approximate dimensions (from DIYSG)
- Volt-10 approximate dimensions (from DIYSG)
- Both shown at correct relative scale
- **Data:** DIYSG product page dimensions

---

## Dependencies (Build Order)

```
Phase 0 (can start immediately, no dependencies):
  config.py                   # Foundation for all diagrams
  01_room_construction.md     # Foundation for everything
  13_budget.md                # Standalone compilation

Phase 1 (depends on Phase 0):
  02_electrical.md            # Needs room layout
  03_hvac.md                  # Needs room layout
  11_acoustic_treatment.md    # Needs room dimensions
  09_seating_viewing.md       # Needs room dimensions + stage spec
  d01_floor_plan.py           # Needs config.py
  d03_side_section.py         # Needs config.py
  d10_viewing_geometry.py     # Needs config.py + seating positions

Phase 2 (depends on Phase 1):
  04_speaker_system.md        # Needs room layout + seating positions
  05_subwoofer_system.md      # Needs room layout + corner clearances
  08_screen_projector.md      # Needs room layout + seating positions
  10_equipment_room.md        # Needs room layout
  d02_front_elevation.py      # Needs room + sub + screen dimensions
  d04_speaker_layout.py       # Needs room + speaker positions
  d05_sub_placement.py        # Needs room + sub positions

Phase 3 (depends on Phase 2):
  06_amplification.md         # Needs speaker + sub specs
  07_dsp_processing.md        # Needs amplification + speaker + sub specs
  12_wiring_signal_flow.md    # Needs all component specs + positions
  d06_signal_flow.py          # Needs all component specs
  d07_electrical_panel.py     # Needs electrical plan
  d08_equipment_rack.py       # Needs all equipment specs
  d09_wiring_runs.py          # Needs all positions + signal flow

Phase 4 (depends on everything):
  14_construction_sequence.md # Needs all specs
  00_index.md                 # Needs all docs
  room_layout.blend           # Needs all dimensions
  full_room.blend             # Needs everything
  sub_cabinet.blend           # Needs sub spec
  speaker_enclosures.blend    # Needs speaker specs
```

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Stale data in existing docs causes inconsistency in new package | High | Medium | Cross-reference every spec against source docs; flag discrepancies in this plan (done above, 12 issues found) |
| Option D rectangular sub cabinets have less headroom than triangular columns | Certain (+2 dB less) | Low | Room gain in smaller room partially compensates; 113 dB at 20 Hz is still +8 dB over reference target |
| 4'x4' equipment closet overheats | Low-Moderate | Medium | Model thermal load; design ventilation as part of construction |
| 1' rear clearance behind Row 2 insufficient for treatment + wiring | Moderate | Low | Reduce stage to 2.5' or row spacing to 4' to recover 0.5-1' |
| Blender models require significant effort for limited value | Moderate | Low | Start with simple box models, add detail only where it aids decision-making |
| 170" 16:9 screen at 10.5' is overwhelming (61 deg angle) | Low | Low | Owner explicitly chose IMAX-class immersion; Row 2 at 45 deg is standard reference |
| ICEpower 1200AS2 discontinued before build | Low | Medium | Buy 5 modules early ($1,865); they're the most supply-chain-vulnerable component |

---

## Open Questions

1. **Rear clearance:** Is 1' behind Row 2 acceptable, or should stage/row spacing be adjusted? (Owner decision)
2. **Sub cabinet dimensions:** The 20"x20"x72" dimensions from Option D are approximate. Need to verify against actual UMII18-22 frame dimensions and target Fc/Qtc.
3. **Projector model:** JVC NZ500 is the current POR at $5,999. Market may shift by 2027 build date. Flag as "selection deferred."
4. **Gym HVAC timeline:** Is it deferred to Phase 3 or indefinitely? Affects electrical panel planning.
5. **Entry door light control:** No vestibule means the 36" door opens directly into the theater. Is weatherstripping sufficient for light control? Consider a simple light baffle or curtain.

---

## New Grad's Take

### What I'd Change
- **Dirac Live over Audyssey is a no-brainer** -- but $799 for three licenses is 2024 pricing. By 2027 build date, Dirac may be bundled or there may be competing room correction (e.g., Trinnov trickle-down, open-source solutions like CamillaDSP with AutoEQ). Don't pre-buy the license until the processor is in hand.
- **ADAU1452 dev board is great engineering but it's 2015 tech.** Consider whether a Raspberry Pi + CamillaDSP (pure software DSP, 192kHz, unlimited FIR filters, Python scriptable) could replace the ADAU1452 entirely. It's more flexible, no SigmaStudio dependency, no COM server, no fixed-point biquad math. The Pi 5 handles 8-channel real-time DSP easily. The latency is ~5ms (vs ~0.5ms ADAU1452) -- irrelevant for subwoofers.
- **JVC NZ500 at $5,999 is solid** but by 2027, UST (ultra-short-throw) laser projectors may offer better value-per-dollar for AT screens. The Hisense PX3-Pro and similar are getting close. Worth monitoring.
- **Blender for 3D models is correct** but consider whether SketchUp Free or FreeCAD would be faster for architectural visualization. Blender is overkill for box models in a room.

### What's Outdated Here
- **SigmaStudio 4.7 + COM automation** is a Rube Goldberg machine. It works because you built it, but a new user would never reproduce it. CamillaDSP + ALSA loopback is the modern equivalent with zero proprietary dependencies.
- **DSP-408 is already obsoleted** by this plan (replaced by ADAU1452). Good call -- but go further: replace SigmaStudio COM entirely.

### Risk I'm Willing to Take
- **Pi 5 + CamillaDSP as sub DSP.** The latency penalty is 5ms (inaudible at 20Hz). The gain is: Python-native filter design, no COM server, no fixed-point math, hot-swappable configuration via text files, remote access via SSH. If it fails, the ADAU1452 is $60 and the existing pipeline works.

### I'll Concede
- The ADAU1452 runs standalone after calibration (EEPROM boot, no Pi needed). That's a genuine reliability advantage. A Pi needs an SD card, an OS, and a prayer.

---

## Senior's Take

### Keep It Simple
- **14 documents is too many.** Merge `02_electrical.md` into `01_room_construction.md` (electrical is part of construction). Merge `08_screen_projector.md` into `09_seating_viewing.md` (screen and viewing geometry are one topic). Merge `10_equipment_room.md` into `01_room_construction.md` (it's a closet in the building). That's 11 docs. Still a lot -- but each one should be SHORT. If a doc is over 200 lines, it's too long.
- **10 diagram scripts is too many.** You need exactly 4: floor plan, cross-section, signal flow, and speaker layout. Everything else is nice-to-have. Build those 4 first, then add more if they actually help decision-making.
- **Blender models are scope creep.** A Python-generated 2D floor plan with accurate dimensions is more useful than a 3D model nobody will rotate. Save Blender for the sub cabinet design where 3D actually matters (driver cutout placement, bracing layout). The room doesn't need 3D -- you have a tape measure and a floor plan.

### Contracts & Interfaces
- **Every document needs a version number and a "last verified against" date.** The existing POR has stale docs at Rev 5.2 mixed with Rev 7.0 docs. This package must not repeat that mistake.
- **The signal flow document (12_wiring_signal_flow.md) is the single most important document.** It defines every interface in the system. Write it as a table: Source -> Cable Type -> Connector -> Destination -> Notes. If that table is correct, everything else follows. If it's wrong, nothing else matters.
- **Budget document must be machine-parseable.** Use a consistent table format that a Python script can sum. The existing budget docs have subtotals that don't always add up (minor rounding, but sloppy).

### Test First
- **Before writing any document, define the acceptance criteria.** For example: "04_speaker_system.md is complete when it includes SPL at seat for all 13 channels with headroom calculation, and the minimum headroom exceeds 5 dB at the -10 dB reference target."
- **Validate the ADAU1452 board before writing the DSP doc.** Order the board NOW. Run the existing ADAU1701 pipeline against it. If it doesn't work, the DSP doc changes significantly. Don't design around hardware you haven't tested.
- **Model the closet thermal load before finalizing the equipment room spec.** If 175W idle in a 4'x4'x10' closet raises temperature above 95F without ventilation, the design needs a fan. Know this before you write the doc.

### Data Design
- **Create a single `specs.yaml` (or JSON) file** that contains every component's specifications: dimensions, weight, power draw, impedance, sensitivity, cost. Every document and every diagram script reads from this file. No duplicated specs, no inconsistencies, no stale numbers. When a spec changes, change it in one place.
- **The budget should be generated from specs.yaml + a quantity table**, not hand-maintained in a markdown file. This eliminates the rounding/addition errors in the current budget docs.

### I'll Concede
- The ADAU1452 + SigmaStudio pipeline is genuinely impressive engineering. It's not how I'd build it from scratch (I'd use a miniDSP SHD or DDRC-88A for its GUI and support), but it exists, it works, and the code is tested. Don't throw it away for a "cleaner" solution that isn't proven yet. The New Grad's CamillaDSP suggestion is interesting but it's a rewrite, not an improvement.
