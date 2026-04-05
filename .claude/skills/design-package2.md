---
name: design-package2-skill
description: Reference skill for agents executing the design-package2 DAG — deliverable specs, coordinate table, validation rules, agent instructions
---

# Design Package 2 — Agent Reference Skill

**Purpose:** This skill is reference material for agents executing tasks in the design-package2 DAG. The command file (`.claude/commands/design-package2.md`) controls WHEN and in what order tasks run. This file documents WHAT each agent needs to know.

**Source restriction (mandatory):** Never read any `team_test*/` folder. Those are prior run outputs. Read only: POR/, investigations/, CLAUDE.md, theater/CLAUDE.md, screenshots/layout_config.json.

---

## Deliverable Structure

All output goes to `theater/team_test_<N>/` (OUT_DIR).

```
team_test_<N>/
  coordinates.json            # LOCKED — only coordinate source for model generators
  ts_params.json              # LOCKED — only T/S source for sub calculations
  specs.yaml                  # SINGLE SOURCE OF TRUTH for docs and diagrams
  validate_geometry.py        # Assertion script — runs post-model-generation
  validate_budget.py          # Arithmetic assertion script
  snapshot_por.md             # Pre-generated POR snapshot (input, not agent output)
  tmp_por_summary.md          # W0-A output (internal — consolidated POR extract)
  tmp_investigation_notes.md  # W0-B output (internal)
  tmp_architect.md            # W1-A output (internal)
  tmp_analyst.md              # W1-B output (internal)
  tmp_critic.md               # W2 output (internal)
  tmp_verifier.md             # W6-VC output (internal)
  00_index.md                 # Master index, corrections log, team decisions
  00_final_report.md          # W7 output — final build summary
  01_room_electrical_hvac.md
  02_speakers.md
  03_subwoofers.md
  04_amplification_dsp.md
  05_screen_seating.md
  06_budget.md
  diagrams/
    config.py
    generate_all.py
    d01_floor_plan.py
    d02_signal_flow.py
    d03_front_elevation.py
    d04_wiring.py
    diagrams_output/           # PNG outputs go here
  models/
    generate_room.py           # Run to produce room_model.obj
    generate_room_hires.py     # Run to produce room_model_hires.obj
    generate_sub_cabinet.py    # Run to produce sub_cabinet.obj
    room_model.obj
    room_model_hires.obj
    sub_cabinet.obj
```

---

## Coordinate Table (Authoritative — for W0-C agent)

All values in INCHES. Scale × 2.54 for cm OBJ output.

Coordinate system:
- X = West → East (0 = west exterior wall)
- Y = Floor → Ceiling (0 = floor)
- Z = South → North (0 = south exterior wall)

```
ELEMENT                    X1    X2    Z1    Z2    Y1    Y2    NOTES
─────────────────────────────────────────────────────────────────────
Building floor              0    348     0   276     0     0    29'×23'
North wall (screen wall)    0    348   270   276     0   120    6" thick
South wall (rear)           0    348     0     6     0   120    NO door here
East wall (exterior)      342    348     0   276     0   120    HAS DOOR HOLE
Partition wall            138    144     0   276     0   120    gym side face X=138

Theater space             144    348     0   276     —     —    17'×23'
Gym space                   0    138     0   276     —     —    12'×23'

Equipment closet           90    138   228   276     0   120    GYM side (LOW X)
  └ west wall              90     96   228   276     0   120
  └ south wall             90    138   228   234     0   120

Door opening              342    348   198   234     0    80    EAST wall (HIGH X), 5' from north
Power panel               342    348   226   234    36    60    EAST wall, 50" from NE corner

Stage deck                144    348   250   276     0    27    full theater width
Screen (thin)             172    320   248   249    30   113    170" 16:9 AT, centered

Corner sub NW             144    168   252   276     0    72    LEFT-front
Corner sub NE             324    348   252   276     0    72    RIGHT-front
Corner sub SW             144    168     0    24     0    72    LEFT-rear
Corner sub SE             324    348     0    24     0    72    RIGHT-rear

Riser                     156    336    90   156     0    24
Row 1 seating             198    294   132   168     0    18    floor level
Row 2 seating             198    294    96   132    24    42    on riser

Projector                 236    256    60   276   110   120    ceiling mount
Equipment rack            102    126   240   270     0    78    42U, in closet
```

**Orientation rules (these fail on every bad model run):**

- NORTH WALL = high Z (Z=270-276). Screen is on the NORTH wall. Screen Z must be near 248.
- EAST WALL = high X (X=342-348). Door is on the EAST wall. Door X must be near 342-348.
- EQUIPMENT CLOSET is on the GYM SIDE (low X, X=90-138). It is WEST of the partition. Closet X2 must be less than 144.
- When FACING THE SCREEN (facing north, toward high Z): LEFT = low X (gym/partition side), RIGHT = high X (east exterior wall side).

---

## Validation Rules (Encoded as Assertions)

These rules replace prose warnings. Each is machine-checkable.

### Geometry Assertions (validate_geometry.py)

| Check | Test | Pass Condition | Fail Means |
|-------|------|---------------|------------|
| Door on east wall | Any vertex with X ∈ [342*2.54, 348*2.54] cm and Y ∈ [0, 80*2.54] | Vertices found | Door is on wrong wall |
| Closet on gym side | Any vertex with X < 144*2.54 cm and Z > 228*2.54 cm | >10 vertices | Closet on theater side |
| Screen on north wall | Any vertex with Z ∈ [248*2.54, 276*2.54] cm and Y ∈ [0, 113*2.54] | Vertices found | Screen on wrong wall |
| Screen bottom | Screen vertices with Y1 near 30*2.54 cm (not 51*2.54) | Y_min < 35*2.54 | Wrong height in source doc copied |

### Arithmetic Assertion (validate_budget.py)

| Check | Method | Pass Condition |
|-------|--------|---------------|
| Phase 1 total | sum(all Phase 1 line items) | Equals stated Phase 1 total exactly |
| Phase 2 total | sum(all Phase 2 line items) | Equals stated Phase 2 total exactly |

### specs.yaml Cross-Reference Checks (W6-VC Verifier)

| Field | Correct Value | Wrong Value (in source docs) | Source |
|-------|--------------|------------------------------|--------|
| Volt-10 sensitivity | 95 dB | 98 dB (some POR docs) | DIYSG spec sheet |
| Titan-815LX impedance | 6Ω nominal | 8Ω (wrong) | DIYSG spec |
| UMII18-22 Qts | 0.53 | 0.36 (stale POR docs) | Dayton datasheet |
| UMII18-22 Vas | 8.77 cu ft | 15.5 cu ft (stale POR docs) | Dayton datasheet |
| Screen bottom height | 30" | 51" (source doc error) | Corrections list |
| Electrical feed | #2 Al, 60A at main panel | 100A (source doc error) | NEC 310.16 + corrections |
| DSP platform | 2× APM2 (ADAU1701) | ADAU1452 (wrong) | Investigation verdict |
| DAC in signal chain | PCM5102 external | ADAU1701 internal DAC (wrong, 0.9V limit) | Investigation verdict |
| Sub footprint | 24"×24" | 20"×20" (specs.yaml error) | layout_config.json |
| MrCool price | $2,359 | varies | POR doc |

---

## T/S Parameters (Authoritative)

Source: Dayton Audio UMII18-22 datasheet, Parts Express SKU 295-487.

**Do NOT use values from POR docs — they contain incorrect values (Vas=15.5 cu ft, Qts=0.36).**

| Parameter | Correct Value | Wrong Value in POR | Units |
|-----------|--------------|-------------------|-------|
| Fs | 22.0 | 22.0 (same) | Hz |
| Qts | 0.53 | 0.36 | — |
| Qes | 0.58 | — | — |
| Qms | 6.22 | — | — |
| Vas | 8.77 | 15.5 | cu ft |
| Xmax | 28 | — | mm |
| Re | 5.8 | — | Ω |
| BL | 21.5 | — | T·m |
| Sd | 1026 | — | cm² |
| Le | 3.66 | — | mH |
| Sensitivity | 95.7 | — | dB/W/m |

### Sealed Box Formulas

```
alpha = Vas / Vb          (Vas and Vb in same units — cu ft)
Qtc   = Qts * sqrt(alpha + 1)
Fc    = Fs  * sqrt(alpha + 1)   [in Hz]
F3    = Fc  * sqrt((1/Qtc^2 - 2 + sqrt((1/Qtc^2 - 2)^2 + 4)) / 2)
```

Sub cabinet volume calculation (24"×24"×H" footprint, 2 drivers per cabinet):
```
gross_cuft   = (24/12) * (24/12) * (H/12)    # H in inches
net_cuft     = gross_cuft * 0.85              # 15% displacement for bracing, panels, drivers
per_driver   = net_cuft / 2                   # 2 drivers per cabinet
```

Target Qtc for sealed subs: 0.7 (maximally flat) to 1.0 (acceptable with room gain at 3,910 cu ft).

---

## Signal Chain (Authoritative)

```
Denon AVR-X6800H
  Sub pre-out: 2.0V RMS
    ↓
  2× Wondom APM2 (ADAU1701)
    ADC input: 2.0V full-scale (no clipping)
    DSP: ADAU1701 (5.23 fixed-point)
    Output: I2S digital
      ↓
    2× PCM5102 external DAC module ($5-8 each, 2.0V RMS output)
    [NOT the internal ADAU1701 DAC — internal = 0.9V → limits ICEpower to 38.5W/ch]
      ↓
    5× ICEpower 1200AS2 (stereo, 240V, fanless)
    Sensitivity for full 600W @ 8Ω: 3.55V RMS
    Output at 2.0V RMS input: (2.0/3.55)^2 × 600 = ~190W/ch
      ↓
    Corner subs: 2× UMII18-22 per cabinet, series wired (8Ω load)
```

APM2 power: from ICEpower 1200AS2 AUX5V output (not external supply).

Dirac ART requirement: sub pre-outs must remain per-channel (no summing). X6800H maintains per-channel sub outputs for MIMO processing.

---

## Known Corrections (Apply and Document in Output)

Every correction must appear in 00_index.md corrections log.

| # | Item | Wrong (in source) | Correct | Source of correction |
|---|------|-------------------|---------|----------------------|
| C1 | Screen bottom height | 51" | 30" | Physics: top at 113", if bottom=51, height=62" which is fine, but 51" is inconsistent with POR stated ~30" — use 30" |
| C2 | Sub T/S: Qts | 0.36 | 0.53 | Dayton UMII18-22 datasheet |
| C3 | Sub T/S: Vas | 15.5 cu ft | 8.77 cu ft | Dayton UMII18-22 datasheet |
| C4 | Sub footprint | 20"×20" | 24"×24" | layout_config.json overrides specs.yaml |
| C5 | DSP platform | ADAU1452 | 2× APM2 (ADAU1701) | Investigation verdict |
| C6 | Signal chain DAC | ADAU1701 internal DAC | PCM5102 external DAC | Investigation verdict (0.9V vs 2.0V) |
| C7 | Electrical feed | 100A | #2 Al, 60A at main panel | NEC 310.16 + corrections |
| C8 | Volt-10 sensitivity | 98 dB (some docs) | 95 dB | DIYSG spec sheet |
| C9 | Titan-815LX impedance | 8Ω (some docs) | 6Ω nominal | DIYSG spec |
| C10 | MrCool price | varies | $2,359 | POR doc |
| C11 | UST projectors | considered | OFF TABLE — incompatible with AT screen (LCR behind screen) | Design constraint |
| C12 | Budget arithmetic | stated totals | must re-sum line items (prior runs had errors) | Arithmetic check |
| C13 | Sub enclosure calcs | triangular column numbers | recalculate for rectangular cabinet using correct T/S | Geometry change |
| C14 | Sub cabinet height | no decision | team assessment required: 72"/96"/120" with Fc/Qtc/F3 | Open design decision |

---

## OBJ Model Generation — Key Rules

Reference: `D:/Projects/Claude/theater/POR/skills/obj-model-generation/SKILL.md` (read before every model task).

### Coordinate enforcement pattern (mandatory)

```python
import json, pathlib

# ONLY permitted coordinate source — do not hardcode or re-derive from English
COORDS = json.loads(pathlib.Path("../coordinates.json").read_text())

# Usage:
door = COORDS["door"]
# door["X1"] = 342, door["X2"] = 348 — east wall
wall_east_with_door_hole(
    x1=door["X1"] * 2.54,  # to cm
    x2=door["X2"] * 2.54,
    z1=door["Z1"] * 2.54,
    z2=door["Z2"] * 2.54,
    hole_z1=door["Z1"] * 2.54,
    hole_z2=door["Z2"] * 2.54,
    hole_y1=door["Y1"] * 2.54,
    hole_y2=door["Y2"] * 2.54
)
```

### Speaker orientation rules

| Speaker | Model Source | Units | Orientation |
|---------|-------------|-------|-------------|
| Titan-815LX (L/C/R) | POR/titan_815lx/diagrams/titan_815lx.obj | inches → ×2.54 | Baffle faces south (toward audience, low Z). Rotate 180° Y if default faces north. |
| Volt-10 FWL | POR/volt10/models/volt10_standard.obj | cm (no conversion) | Faces east (into room from west wall) |
| Volt-10 FWR | same | cm | Faces west (into room from east wall) |
| Volt-10 SL | same | cm | Faces east |
| Volt-10 SR | same | cm | Faces west |
| Volt-10 SBL/SBR | same | cm | Faces north |
| Volt-10 TFL/TFR/TRL/TRR | same | cm | Baffle faces DOWN (-Y). These hang from ceiling. |
| UMII18-22 | POR/umii18_22/diagrams/umii18_22.obj | cm (no conversion) | Baffle faces south (low Z, toward audience) |

### Circular cutout method (from SKILL.md)

For 18" driver cutouts in sub cabinet front baffle:
- Corner-fan method with 32-segment rings
- Ring center at baffle face (Z of front panel)
- Radius: 9" × 2.54 = 22.86 cm
- Build a fan of triangles from center to ring perimeter
- Use Centroid-based hole filtering to cleanly exclude interior from panel mesh
- Verify winding (normals point outward) using cross-product check

---

## Advisory Voice Matrix (Optimized for Each Phase)

| Phase / Task | Active Advisories | Dropped |
|---|---|---|
| W1-A Architect | Senior (scope check), Acton (sourcing) | New Grad, Bass Head, Cost Cutter |
| W1-B Analyst | Acton (T/S sourcing), Cost Cutter (budget discipline) | New Grad, Senior, Bass Head |
| W2 Critic | Acton (data check), Senior (scope), Cost Cutter (arithmetic), Bass Head (sub height only) | New Grad |
| W4-0 specs.yaml | None — mechanical extraction | All |
| W4-B1 00_index.md | None | All |
| W4-B2 01_room.md | Acton (code citations) | All others |
| W4-B3 02_speakers.md | Acton (sensitivity sourcing) | All others |
| W4-B4 03_subs.md | Acton (T/S citations), Bass Head (LF extension) | New Grad, Senior, Cost Cutter |
| W4-B5 04_amp_dsp.md | Acton (voltage calculations) | All others |
| W4-B6 05_screen.md | None — geometric calculations only | All |
| W4-B7 06_budget.md | Cost Cutter (line item discipline) | All others |
| W4-C0 config.py | None — mechanical code generation | All |
| W5-C1 through C4 | None — mechanical code generation | All |
| W5-D1 through D3 | None — coordinate enforcement replaces advisory voices | All |
| W6-VA validate_geometry | None — assertion script | All |
| W6-VB validate_budget | None — arithmetic script | All |
| W6-VC Verifier | Senior (critical path coverage), Acton (source citations) | New Grad, Bass Head, Cost Cutter |
| W7 Final analyst | None — reporting only | All |

**Why advisory voices are dropped on build phases:**
- Diagram scripts and OBJ models: correctness is determined by whether the script runs and produces correct output. Advisory voices generate output that is read and discarded without changing the artifact.
- Coordinate placement errors are structural (agents re-deriving from English). The fix is coordinates.json, not prose advisories.
- For mechanical phases, the Verifier catches errors; advisories don't prevent them.

---

## Document Writing Rules (for W4-B1 through W4-B7 agents)

1. **Read specs.yaml only.** Do not re-read POR docs. specs.yaml is the sole input.
2. **Every number cites specs.yaml.** Format: `[value] (specs.yaml: section.field)`
3. **Every major decision includes critical assessment:**
   - WHY the current choice is correct
   - Known weaknesses
   - What would change the answer
4. **All calculations show work:**
   - SPL: `SPL = sensitivity + 10*log10(power) - 20*log10(distance)`
   - Throw: `throw_ratio = throw_distance_ft / screen_width_ft`
   - Room modes: `f = c / (2*L)` where c=1125 ft/s
5. **Tables over prose.** No headers like "In this document we will cover..."
6. **Terse.** Owner audience: senior technical, DIY builder. No hand-holding.
7. **Do NOT modify any file outside OUT_DIR.**

---

## Budget Document Rules (for W4-B7 agent specifically)

The source docs have known budget arithmetic errors (Phase 1 and Phase 2 stated totals don't match sum of line items). The agent must:

1. Extract all line items from specs.yaml budget section
2. Sum them in Python (not mental math):
   ```python
   phase1_items = [item["cost"] for item in specs["budget"]["phase1_items"]]
   phase1_computed = sum(phase1_items)
   phase1_stated = specs["budget"]["phase1_total"]
   print(f"Phase 1: computed={phase1_computed}, stated={phase1_stated}, match={phase1_computed==phase1_stated}")
   ```
3. Use the computed sum as the correct total (not the stated total if they differ)
4. Document the discrepancy if any in the corrections log

---

## Diagram Script Rules (for W5-C1 through W5-C4 agents)

1. Import from config.py: `from config import *` — no hardcoded values
2. All constants via config, which loads from specs.yaml
3. Output PNGs to `diagrams_output/` directory (create if needed)
4. Use matplotlib only — no plotly, bokeh, or web-server-dependent libraries
5. Run without errors: `cd diagrams && python d0X_name.py`
6. Labels on all elements. Units in labels where ambiguous (ft, inches, dB).
7. Title on each PNG with: diagram name + version from specs.yaml

---

## Projector Throw Verification

Screen: 170" diagonal, 16:9 → width = 170 × (16/√(16²+9²)) = 148.2" = 12.35 ft

Available throw distance: room depth (23 ft) - stage depth (26/12 = 2.17 ft) - projector offset from screen ≈ 20.8 ft

JVC NZ500 throw ratio: verify against current spec (approximately 1.34:1 to 2.79:1).
At 12.35 ft wide screen: min throw = 12.35 × 1.34 = 16.5 ft, max = 12.35 × 2.79 = 34.5 ft.
Available: ~20.8 ft → within range. Verify with actual NZ500 spec.

**UST projectors are incompatible with AT screen** — LCR speakers are behind the screen. UST projectors aim at the screen base from a few inches away; they cannot coexist with behind-screen LCR at the screen base. This is a hard constraint, not a preference.

---

## Electrical Verification Data

| Parameter | Correct Value | Common Error in Source Docs |
|-----------|--------------|---------------------------|
| Service feed | #2 Al, 240V, 60A breaker at main panel | "100A" appears in some POR docs |
| Wire rating | #2 Al rated 90A @ 75°C per NEC 310.16 | — |
| NEC calculated load | 39.6A total (full theater + pool) | — |
| Headroom on 60A | 34% | — |
| Upgrade path | Replace 60A breaker with 90A QO290 ($30) — no rewire | — |
| Pool pump | Pentair IntelliFlow VSF, ~5A typical @ 240V | — |
| Pool pump breaker | 30A / 240V (oversized for actual draw) | — |
| Gas heater | ~100W on 30A/240V (well within rating) | — |
| Pool pump mitigation | Schedule low RPM during theater hours, $0 cost | — |

---

## Investigation Trigger Protocol

If any agent in W1-A, W1-B, or W2 identifies an open question requiring web research:

1. Create a task with `agent_type: "research"` or `agent_type: "verify"`
2. In the task description, list exactly which specs.yaml fields and which output docs depend on the answer
3. Wire the task to block ONLY those specific docs, not all of Phase 4
4. All other docs that don't depend on the uncertain value proceed immediately

Example: if the JVC NZ500 throw ratio is uncertain:
- Create: "Verify JVC NZ500 throw ratio range" (agent_type: verify)
- Block: W4-B6 (05_screen_seating.md) only
- All other docs (01, 02, 03, 04, 06) are NOT blocked

Do not stall the entire pipeline for a single uncertain value.

---

## Sub Cabinet Height Decision

This decision MUST be made in W2 (Critic phase), not deferred to W4. The Critic must produce a specific height recommendation with Fc/Qtc/F3 calculations using correct T/S parameters.

Decision criteria:
- Use Qts=0.53, Vas=8.77 cu ft, Fs=22 Hz (from ts_params.json)
- Footprint: 24"×24" (resolved from layout_config.json)
- Target Qtc: 0.7–1.0 (room gain at 3,910 cu ft compensates for Qtc up to ~1.0)
- Height options: 72" (6 ft), 96" (8 ft), 120" (10 ft floor-to-ceiling)
- Consider: visual impact, 2-ft ceiling clearance at 96", structural role of front pair (support screen wall)
- Front pair doubles as screen wall structure — height affects architectural integration

Once the Critic decides, that height propagates to ts_params.json (W0-D writes the options, Critic writes the decision to tmp_critic.md, W4-0 reads it and writes chosen height to specs.yaml).
