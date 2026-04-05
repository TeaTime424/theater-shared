---
name: design-package
description: Generate a comprehensive, team-vetted design package for the Option D home theater
---

# Design Package Generation — Option D Home Theater

Generate a comprehensive, well-documented design package for the Option D home theater (garage conversion, N-S partition, 17'x23' theater). Output to `theater/team_test_<N>/` where N is the next available increment (check existing `team_test*` folders).

**Audience:** Owner (terse, technical, no hand-holding). Function over form.

## CRITICAL: Source Restrictions

**DO NOT read, reference, or copy from any `team_test*/` folder.** These are prior outputs and must not be used as input. Generate everything fresh from the primary source documents listed below. This ensures each run is an independent test of the generation pipeline.

## What to read first

Read ALL of these before generating anything:
- `D:\Projects\Claude\theater\CLAUDE.md` — project overview, current specs
- `D:\Projects\Claude\theater\POR\Garage_Conversion_Option1.md` — primary design document (Option D sections)
- `D:\Projects\Claude\theater\POR\00_Master_Index.md` — POR document map
- All numbered POR docs (01-16) — skim for specs, note which are stale
- `D:\Projects\Claude\investigations\` — all completed investigation verdicts
- `D:\Projects\Claude\theater\POR\skills\obj-model-generation\SKILL.md` — 3D model conventions
- `D:\Projects\Claude\theater\screenshots\layout_config.json` — spatial layout source of truth

## Phase 1: Audit (Parallel — Architect + Analyst)

Run the `/team` framework (`.claude/commands/team.md`). Both agents include ALL advisory voices: New Grad, Senior, Acton (data-oriented BS detector), Bass Head (low-freq advocate), Cost Cutter (value engineering). Read all `agent-*.md` skill files before prompting agents.

**Architect:** Design the document tree, diagram list, 3D model scope. Flag inconsistencies between POR docs and Option D. Propose what needs critical assessment vs what's settled.

**Analyst:** Establish baseline — every budget line item, every performance spec, every gap. Verify calculations (SPL, throw distance, gain staging, room modes). Flag anything that doesn't add up.

## Phase 2: Critique (Sequential)

Critic reviews both outputs. Required checks:
- Do the Architect's and Analyst's findings conflict? Resolve.
- Are budget totals arithmetically correct? Verify sums.
- Are claimed specs backed by calculations or just asserted?
- Is the scope right for the deliverable? Not over/under-scoped.
- Which New Grad vs Senior positions should win?

## Phase 3: Decision Gate

Present summary to user. Include:
- Plan overview (bullets)
- Budget baseline
- Critic verdict + required changes
- New Grad vs Senior scorecard
- Ask: proceed / adjust / stop?

## Phase 4: Build

Generate all deliverables. The output structure:

```
team_test_<N>/
  specs.yaml                  # SINGLE SOURCE OF TRUTH — all numbers live here
  00_index.md                 # Master index, system summary, doc status, corrections log
  01_room_electrical_hvac.md  # Room dims, partition, closet, circuits, HVAC, ventilation
  02_speakers.md              # All 13 channels: model, sensitivity, impedance, amp, SPL at MLP, headroom
  03_subwoofers.md            # Corner (8 drivers), nearfield (deferred), tactile, enclosure calcs
  04_amplification_dsp.md     # ICEpower, ATI, X6800H, DSP platform, signal flow, gain staging
  05_screen_seating.md        # Screen spec, projector throw calc, viewing angles, riser, clearances
  06_budget.md                # Phase 1 + Phase 2 line items, owned inventory, deferrals
  diagrams/
    config.py                 # Shared config loaded from specs.yaml
    generate_all.py           # Master runner: `python generate_all.py`
    d01_floor_plan.py         # Top-down: walls, partition, door, stage, riser, seats, speakers, subs, closet
    d02_signal_flow.py        # Full signal path: sources → processor → amps → drivers (all channels)
    d03_front_elevation.py    # Screen wall: screen, LCR, front corner subs, front heights
    d04_wiring.py             # Sub system wiring: processor → DSP → amps → drivers + power
  models/
    generate_room.py          # Low-poly OBJ: room shell with walls, door, correct speaker dims
    generate_room_hires.py    # Hi-res OBJ: embeds detailed speaker/driver models from POR/
    generate_sub_cabinet.py   # Detailed sub cabinet OBJ: rectangular stacked 20"x20"x72", 2 driver cutouts
```

### Build rules

1. **specs.yaml is the single source of truth.** Every document and diagram reads from it. No hardcoded numbers in docs — reference specs.yaml.

2. **Every document must include a critical assessment** for each major decision: WHY the current choice is correct, known weaknesses, what would change the answer.

3. **All calculations must show work.** SPL = sensitivity + 10*log10(power) - 20*log10(distance). Throw ratio = distance/screen_width. Room modes = c/(2*L). No hand-waving.

4. **Diagrams must be runnable:** `cd team_test_<N>/diagrams && python generate_all.py` with zero errors. All PNGs output to `diagrams_output/` (not the source directory).

5. **Spatial layout source of truth:** `theater/screenshots/layout_config.json` defines all speaker positions, sub positions, seating rows, stage, riser, screen, and room geometry. Read it for exact coordinates. All 3D models and floor plan diagrams must match these positions. The rendered PNG at `theater/option_d_topdown.png` is a visual reference.

6. **3D models — THREE outputs required:**

   **⚠ PLACEMENT GETS WRONG EVERY RUN. READ THIS FIRST. ⚠**
   The layout has three elements that agents consistently place incorrectly:
   - **Screen** → NORTH wall (high Z). The room faces north.
   - **Equipment closet** → WEST of screen, in the GYM (low X, X=90-138). LEFT when facing screen.
   - **Door** → EAST wall (high X, X=342-348), 5' south of NE corner. RIGHT when facing screen.
   Use the coordinate table below. Do NOT derive positions from English — use the numbers directly.
   After generating, VALIDATE: check that door X coordinates are near 348 (east wall), NOT near Z=0 (south wall). Check that closet X coordinates are below 144 (gym side), NOT above 144 (theater side).

   **Model A: Low-poly room (`generate_room.py` → `room_model.obj`)**
   - Full building shell: north, south, east walls + partition (west wall of theater). Walls 6" thick, semi-transparent (d=0.3 in MTL).
   - Stage deck, riser, 2 seating rows (boxes at correct positions from layout_config.json)
   - Screen rectangle at correct height (~30" bottom, fits under 120" ceiling)
   - Projector box at ceiling mount (~18 ft from north wall)
   - Equipment rack in closet (42U: 24"W×78"H×30"D)
   - Speakers as correctly-sized boxes (NOT 6" cubes):
     - Titan-815LX: 19.5"W × 42.5"H × 21.5"D (bounding box from POR/titan_815lx/diagrams/titan_815lx.obj)
     - Volt-10: 14"W × 14"H × 9.4"D (bounding box from POR/volt10/models/volt10_standard.obj, model is in cm)
   - 4 corner sub cabinets: 20"W × 20"D × 72"H
   - Coordinate system: X=width (W→E), Y=height, Z=depth (S→N). Inches × 2.54 for cm output.
   - Follow `POR/skills/obj-model-generation/SKILL.md` for winding and vertex caching.

   **CRITICAL: EXACT COORDINATES FOR OBJ MODEL**

   The 2D layout diagram (`theater/option_d_topdown.png`) is the definitive visual reference. The table below gives EXACT coordinates in the model's own system. Use these directly — do NOT re-derive from English descriptions.

   Model coordinate system: X = West→East (0=west exterior), Y = Floor→Ceiling (0=floor), Z = South→North (0=south exterior). All values in INCHES. Scale ×2.54 for cm output.

   **ORIENTATION (critical — gets flipped in every bad model):**
   - When FACING THE SCREEN (looking north, toward high Z):
     - LEFT = low X = west = partition/gym side
     - RIGHT = high X = east = exterior wall side
   - The equipment closet is on the LEFT (low X, gym side)
   - The door is on the RIGHT wall (high X, east exterior wall)

   ```
   ELEMENT                    X1    X2    Z1    Z2    Y1    Y2    NOTES
   ─────────────────────────────────────────────────────────────────────
   Building floor             0    348     0   276     0     0    29'×23'
   North wall (screen)        0    348   270   276     0   120    6" thick
   South wall (rear)          0    348     0     6     0   120    6" thick, NO door here
   East wall (exterior)     342    348     0   276     0   120    6" thick, HAS DOOR HOLE
   Partition wall           138    144     0   276     0   120    6" thick, gym side face at X=138
   Ceiling (transparent)      0    348     0   276   120   120    reference plane

   Theater space            144    348     0   276     —     —    17'×23' (east of partition)
   Theater center X=246     Z center varies by element

   Equipment closet          90    138   228   276     0   120    LEFT of stage (gym side, LOW X)
    └ Closet west wall       90     96   228   276     0   120
    └ Closet south wall      90    138   228   234     0   120

   Door opening             342    348   198   234     0    80    RIGHT wall (east, HIGH X), 5' from north
    └ center Z=216 = 60" (5 ft) south of north wall

   Power panel              342    348   226   234     36    60   RIGHT wall (east), 50" from NE corner

   Stage deck               144    348   250   276     0    27    full theater width
   Screen (thin)            172    320   248   249    30   113    170" 16:9 AT, centered on theater

   Corner sub NW            144    168   252   276     0    72    LEFT-front (partition + north)
   Corner sub NE            324    348   252   276     0    72    RIGHT-front (east + north)
   Corner sub SW            144    168     0    24     0    72    LEFT-rear (partition + south)
   Corner sub SE            324    348     0    24     0    72    RIGHT-rear (east + south)

   Riser                    156    336    90   156     0    24    inset 1' from walls
   Row 1 seating            198    294   132   168     0    18    floor level, 8' wide couch
   Row 2 seating            198    294    96   132    24    42    on riser, 8' wide couch

   Projector                236    256   276    60   110   120    ceiling mount, ~18' from north
   Equipment rack           102    126   240   270     0    78    42U rack in closet (LEFT side)
   ```

   **The door is a HOLE in the EAST wall (RIGHT side, high X), NOT the south wall.** It is 5 feet from the north/screen wall. Use wall_with_hole() or equivalent to cut the 36"×80" opening from the east wall geometry.

   **The equipment closet is on the LEFT side (low X, gym side of partition).** X=90 to 138 is WEST of the partition (X=138-144). It is NOT inside the theater. Cables pass through the partition wall to reach theater equipment.

   **Model B: Hi-res room (`generate_room_hires.py` → `room_model_hires.obj`)**
   - Same room geometry as low-poly (walls, door, stage, riser, seats, screen, projector, rack, sub cabinets)
   - REPLACE speaker/driver box placeholders with embedded detailed OBJ models from POR/:
     - 3× `POR/titan_815lx/diagrams/titan_815lx.obj` (LCR) — model is in INCHES, multiply by 2.54
     - 10× `POR/volt10/models/volt10_standard.obj` (surr/Atmos/FW) — model is in CM, no conversion
     - 8× `POR/umii18_22/diagrams/umii18_22.obj` (sub drivers, 2 per cabinet) — model is in CM, no conversion
   - When embedding: read the source OBJ, offset all vertex indices by current count, apply translation to correct room position, apply rotation per speaker type:
     - **LCR (Titan, on stage):** face south (toward audience). Rotate 180° around Y axis if model default faces north.
     - **Wall-mounted Volt-10 (FW, SL, SR, SBL, SBR):** face INTO the room. Each speaker rotates to point toward room center. FWL faces east, FWR faces west, SL faces east, SR faces west, SBL/SBR face north.
     - **Ceiling Atmos Volt-10 (TFL, TFR, TRL, TRR):** woofer points DOWN. Rotate so the baffle (front face with driver) faces the floor (-Y direction). These hang from the ceiling.
     - **Sub drivers (UMII18-22):** face forward into room (south, toward audience). Baffle faces low-Z.
   - Prefix material names per instance to avoid MTL collisions (e.g., titan_L_, titan_C_, volt_SL_)
   - Expected output: ~100K+ vertices, ~5MB OBJ

   **Model C: Sub cabinet detail (`generate_sub_cabinet.py` → `sub_cabinet.obj`)**
   - Standalone detailed model of one rectangular stacked corner sub cabinet (20"W × 20"D × 72"H)
   - Internal partition at 36" (separating upper and lower driver chambers)
   - Two 18" circular driver cutouts on the front baffle (using the proven corner-fan method from the skill doc)
   - Panel thickness: 0.75" (3/4" MDF/plywood)
   - Internal bracing: one horizontal brace per chamber
   - Port: none (sealed design)
   - Follow the circular cutout technique in `POR/skills/obj-model-generation/SKILL.md` exactly (corner-fan method with 32-segment rings)

7. **Do NOT modify any files outside the output folder.** This is a self-contained package.

8. **Terse, technical writing.** Tables over prose. No fluff. Cite file:line for source claims.

### Known corrections to apply (learned from prior runs)

These are documented errors in the source documents. Apply these corrections and document them in the output:
- Screen bottom: ~30" above floor (51" puts top above ceiling)
- Projector throw: verify NZ500 can fill 170" 16:9 at available room depth (min 17.3 ft)
- Budget: verify Phase 1 and Phase 2 line items sum to stated totals — source docs have arithmetic errors
- Sub enclosures: recalculate Fc/Qtc/F3 for actual rectangular cabinet volume, don't copy triangular column numbers
- Gain staging: verify interface voltages at every stage (DAC output → amp input sensitivity)
- DSP platform: 2x Wondom APM2 (ADAU1701), NOT ADAU1452+CS42448 board. See investigation verdicts.
- APM2 power: 5V from ICEpower 1200AS2 AUX5V output
- APM2 DAC output limit: internal DAC = 0.9 Vrms, too low for ICEpower 1200AS2 (needs 3.55 Vrms for 600W @ 8 ohm). FIX: use ADAU1701 I2S digital output → external PCM5102 DAC module ($5-8 each, 2.0 Vrms output, 112 dB SNR). Two PCM5102 boards = 4 stereo outputs (8 channels). This gives 190W/ch — not full rated but 5× better than internal DAC. Do NOT use the ADAU1701 internal DAC for the power amp path.
- Dirac ART sends unique MIMO signals per sub output — corner subs must preserve per-channel independence
- MrCool system price is $2,359 — verify Phase 1 total reflects this
- UST projectors are OFF the table — incompatible with AT screen (LCR behind screen). JVC NZ500 or 2027 successor only.
- Electrical feed: #2 Aluminum 240V with 60A breaker at main house panel (NOT 100A — source docs are wrong)
- Existing pool equipment on garage panel: Pentair IntelliFlow VSF (variable speed, ~5A typical @ 240V) + gas heater (~100W) on 30A/240V breaker. The 30A is oversized for actual draw.
- NEC calculated load with full theater + pool: 39.6A — well within 60A (34% headroom)
- #2 Al wire rated 90A @ 75°C per NEC 310.16. Upgrade path: swap to 90A breaker ($30 Square D QO290 or HOM290CP, no rewire) if future loads are added
- Pool pump scheduling (low RPM during theater hours) is the $0 mitigation for any load concern
- Equipment closet is LEFT of stage (low X, gym side, X=90-138). Every prior model run got this wrong by placing it on the theater side or at high X. Use the coordinate table.
- Theater door is on the EAST WALL (RIGHT side, high X=342-348), 5 feet from the north/screen wall (Z=198-234). NOT on the south wall. Every prior model run got this wrong.
- Electrical panel is on the EAST WALL, 50" from NE corner (Z=226-234), near the door.
- DSP signal chain is: X6800H sub pre-out (2V RMS) → APM2 ADC (2V full-scale, no clipping) → ADAU1701 DSP → I2S digital out → PCM5102 external DAC (2V RMS output) → ICEpower 1200AS2 input (3.55V for full power). Do NOT use the ADAU1701 internal DAC (0.9V, limits amp to 38.5W/ch). The PCM5102 path gives 190W/ch.
- T/S parameters for UMII18-22: USE DAYTON SPEC SHEET (Vas=8.77 cu ft, Qts=0.53, Fs=22 Hz). NOT the incorrect values (Vas=15.5, Qts=0.36) that appear in some project docs. Verify against Parts Express listing.
- Sub cabinet dimensions are UNRESOLVED — specs.yaml says 20"×20"×72", layout_config.json says 24"×24". Footprint is 24"×24" (2'×2'). Height needs team assessment:
  - 72" (6ft): ~9.5 cu ft/driver after bracing — good Qtc sweet spot
  - 96" (8ft): ~12.7 cu ft/driver — lower Fc, more extension, 2ft ceiling clearance
  - 120" (10ft): ~16.0 cu ft/driver — floor-to-ceiling, diminishing returns
  - The team MUST calculate Fc, Qtc, and F3 for each height option using UMII18-22 T/S parameters (Vas=15.5 cu ft, Qts=0.36, Fs=22Hz) and recommend a height. Consider: room gain at 3,910 cu ft, boundary loading, visual impact, structural role (front pair supports screen wall). Sealed only — no ports.
  - Resolve the 20" vs 24" footprint discrepancy and update specs.yaml + layout_config.json to match.

## Phase 5: Verify + Analyze (Parallel)

**Verifier:** Run all scripts. Cross-check 10+ specs.yaml values against source docs. Verify budget arithmetic programmatically (sum line items in Python, compare to stated totals). Confirm all Critic-required changes were implemented. Check no files outside output folder were touched.

**MANDATORY placement validation** (this fails every run — check it explicitly):
- Read the generated OBJ file. Search for the door geometry — verify its X coordinates are near 342-348 (east wall). If X is near 0-6 or Z is near 0-6, the door is on the WRONG WALL.
- Search for closet geometry — verify X coordinates are 90-138 (gym side). If X > 144, the closet is on the WRONG SIDE.
- Search for screen geometry — verify Z coordinates are near 248-276 (north wall). If Z is near 0, the screen is on the wrong wall.
- If ANY placement is wrong, flag as BLOCKER and require the Builder to fix before proceeding.

**Analyst (final):** Calculate budget delta vs source docs. List all spec corrections. Assess what new information was generated. Evaluate team framework performance.

## Phase 6: Report

Present final summary: what was built, verification verdict, budget impact, issues, New Grad vs Senior scorecard.

## Investigation triggers

If the Architect or Analyst flags a decision that needs deeper analysis (e.g., "should we use X instead of Y"), run it as a focused investigation within the package:
- Write findings to `team_test_<N>/investigation_<topic>.md`
- Use web research (WebSearch) for current pricing, community reports, datasheets
- Always check diyAudio, ASR, and manufacturer forums for real-world reports on specific products
- **Never recommend hardware based on chip specs alone** — evaluate the actual board/product
- Update specs.yaml and affected docs with the investigation's conclusions

$ARGUMENTS
