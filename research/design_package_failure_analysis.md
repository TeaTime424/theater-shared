# Design Package Generation — Failure Mode Analysis

**Status:** RESEARCH — Structural recommendations, not yet adopted
**Date:** 2026-03-20
**Related:** `theater/.claude/skills/design-package.md`, `theater/.claude/commands/team.md`

---

## Executive Summary

The design-package skill documents nine systematic failures that occur on every run, three of which are spatial placement errors that corrupt the 3D model outputs regardless of written instructions. The root cause in all cases is the same: agents re-derive ground truth from English prose rather than consuming locked numeric artifacts. The structural fix is a two-stage DAG: a locked-coordinate artifact generation task that blocks all model generation tasks, paired with post-generation assertion tasks that block completion. Simple numeric assertions replace manual re-inspection.

---

## 1. Failure Taxonomy: Systematic vs One-Off

### 1.1 Systematic — Documented as "Every Run"

These are not bugs in any one agent. They are architectural failures: the pipeline lets agents re-derive facts that should be treated as immutable inputs.

| # | Failure | Skill Source | Root Cause |
|---|---------|-------------|------------|
| S1 | Door on south wall instead of east wall | lines 98, 217, 233 | Agent re-reads English description, mixes up wall name vs. axis direction |
| S2 | Equipment closet on theater side (high X) instead of gym side (low X) | lines 99, 216, 234 | Agent conflates "left of stage" with theater-relative coordinates |
| S3 | Screen on wrong wall (south instead of north) | lines 97, 235 | Agent re-derives Z polarity from English; north=high-Z is not intuitive |
| S4 | T/S parameters sourced from stale project docs (Vas=15.5, Qts=0.36) instead of Dayton datasheet (Vas=8.77, Qts=0.53) | lines 220 | No authoritative parameter file; agents pick from whichever doc loads first |
| S5 | Budget arithmetic errors (stated totals don't match sum of line items) | lines 40, 202, 231 | Budget is prose in markdown; no programmatic sum validation exists in the build path |

### 1.2 Systematic — Implicitly Every Run (Structural, Not Labeled)

These are not explicitly called "every run" but are structural — the pipeline cannot avoid them without a fix.

| # | Failure | Skill Source | Root Cause |
|---|---------|-------------|------------|
| S6 | Sub enclosure calcs copied from triangular column numbers, not recalculated for rectangular cabinet | line 203 | Old geometry's Fc/Qtc values exist in POR docs; agents copy rather than recalculate |
| S7 | APM2 internal DAC used in signal chain instead of PCM5102 external DAC | lines 207, 219 | Correction requires reading investigation verdicts AND overriding what the schematic says; agents miss the cascade |
| S8 | Screen bottom at 51" instead of ~30" | line 200 | Error is in POR source docs; agents faithfully reproduce the error |
| S9 | Gain staging not verified against actual interface voltages | lines 204, 219 | Multi-stage calculation that agents don't re-derive; they copy stated gain figures |

### 1.3 Unresolved (Requires Decision, Not Just Correction)

| # | Failure | Skill Source | Nature |
|---|---------|-------------|--------|
| U1 | Sub cabinet footprint: specs.yaml says 20"×20", layout_config.json says 24"×24" | lines 221–226 | Contradictory source documents; confirmed by reading layout_config.json line 73 (`"width_inches": 24`) |
| U2 | Sub cabinet height: 72", 96", or 120" — no team assessment has been done | lines 221–226 | Design decision, not a documentation error |

---

## 2. Root Cause Analysis

All systematic failures share a single root cause: **agents are given English descriptions and expected to derive numeric coordinates or parameter values, then re-derive them correctly every time.** This is a pipeline design flaw, not an agent capability issue.

The skill already recognizes this. Line 99: "Use the coordinate table below. Do NOT derive positions from English — use the numbers directly." The problem is that this instruction is embedded in a prose skill document that agents read alongside hundreds of other prose instructions. It competes for attention and does not enforce anything — the agent can read it and still re-derive.

The coordinate table on lines 128–164 is correct and complete. The issue is how it reaches the model generator: it is embedded in the skill document as a markdown code block, not as a machine-readable file that the generator reads and validates.

---

## 3. Structural Fix: Two-Stage DAG Architecture

### 3.1 Stage 1: Locked Artifact Generation (Blocks Everything Downstream)

Create a dedicated task that produces **validated JSON artifacts** before any model generation begins. These files become the only permitted source for coordinates, dimensions, and T/S parameters.

#### 3.1.1 `coordinates.json`

Generated once, validated, then passed read-only to all model generators.

```json
{
  "_source": "design-package.md lines 128-164 + layout_config.json",
  "_validated": "2026-03-20",
  "coordinate_system": {
    "X": "West→East, 0=west exterior",
    "Y": "Floor→Ceiling, 0=floor",
    "Z": "South→North, 0=south exterior",
    "units": "inches"
  },
  "walls": {
    "north": {"X1": 0, "X2": 348, "Z1": 270, "Z2": 276, "Y1": 0, "Y2": 120},
    "south": {"X1": 0, "X2": 348, "Z1": 0, "Z2": 6, "Y1": 0, "Y2": 120, "has_door": false},
    "east":  {"X1": 342, "X2": 348, "Z1": 0, "Z2": 276, "Y1": 0, "Y2": 120, "has_door": true},
    "partition": {"X1": 138, "X2": 144, "Z1": 0, "Z2": 276, "Y1": 0, "Y2": 120}
  },
  "door": {
    "wall": "east",
    "X1": 342, "X2": 348,
    "Z1": 198, "Z2": 234,
    "Y1": 0, "Y2": 80,
    "_assertion": "door_X_must_be_near_342_not_near_0_or_6"
  },
  "equipment_closet": {
    "side": "gym",
    "X1": 90, "X2": 138,
    "Z1": 228, "Z2": 276,
    "Y1": 0, "Y2": 120,
    "_assertion": "closet_X2_must_be_less_than_144"
  },
  "screen": {
    "wall": "north",
    "X1": 172, "X2": 320,
    "Z1": 248, "Z2": 249,
    "Y1": 30, "Y2": 113,
    "_assertion": "screen_Z_must_be_near_248_not_near_0"
  },
  "corner_subs": {
    "NW": {"X1": 144, "X2": 168, "Z1": 252, "Z2": 276, "Y1": 0, "Y2": 72},
    "NE": {"X1": 324, "X2": 348, "Z1": 252, "Z2": 276, "Y1": 0, "Y2": 72},
    "SW": {"X1": 144, "X2": 168, "Z1": 0,   "Z2": 24,  "Y1": 0, "Y2": 72},
    "SE": {"X1": 324, "X2": 348, "Z1": 0,   "Z2": 24,  "Y1": 0, "Y2": 72}
  }
}
```

#### 3.1.2 `ts_params.json`

Single authoritative T/S parameter file, sourced from Dayton datasheet only.

```json
{
  "_source": "Dayton Audio UMII18-22 datasheet (Parts Express SKU 295-487)",
  "_do_not_copy_from": "POR docs — contain incorrect values Vas=15.5, Qts=0.36",
  "UMII18-22": {
    "Fs_Hz": 22.0,
    "Qts": 0.53,
    "Qes": 0.58,
    "Qms": 6.22,
    "Vas_cuft": 8.77,
    "Xmax_mm": 28,
    "Re_ohm": 5.8,
    "BL_Tm": 21.5,
    "Sd_cm2": 1026,
    "Le_mH": 3.66
  }
}
```

#### 3.1.3 `sub_cabinet_resolved.json` (REQUIRES DECISION FIRST)

This file cannot be generated until U1 and U2 are resolved. It blocks sub-cabinet model generation specifically.

```json
{
  "_status": "UNRESOLVED — requires team Fc/Qtc/F3 calculation before this file can be written",
  "_options": [
    {"height_in": 72, "volume_cuft_per_driver": 9.5, "note": "good Qtc sweet spot"},
    {"height_in": 96, "volume_cuft_per_driver": 12.7, "note": "lower Fc, 2ft ceiling clearance"},
    {"height_in": 120, "volume_cuft_per_driver": 16.0, "note": "floor-to-ceiling, diminishing returns"}
  ],
  "_footprint_conflict": {
    "specs_yaml": "20x20 inches",
    "layout_config_json": "24x24 inches",
    "resolution_required": true
  }
}
```

### 3.2 Stage 2: Assertion Tasks That Block Completion

Post-generation validation should be a **separate DAG task with pass/fail output**, not a manual check by a Verifier agent reading OBJ files.

#### Assertion script: `validate_geometry.py`

```python
#!/usr/bin/env python3
"""Post-generation geometry assertion — runs after model generation, blocks completion on failure."""
import re, sys, pathlib

def extract_vertices(obj_text):
    verts = []
    for line in obj_text.splitlines():
        if line.startswith('v '):
            parts = line.split()
            verts.append((float(parts[1]), float(parts[2]), float(parts[3])))
    return verts

def assert_element(verts, label, axis, expected_min, expected_max, tolerance=6.0):
    """Fail if no vertex in the element's range exists on the expected axis."""
    # axis: 0=X, 1=Y, 2=Z
    in_range = [v for v in verts if expected_min - tolerance <= v[axis] <= expected_max + tolerance]
    if not in_range:
        print(f"FAIL: {label} — no vertices found near {axis}=[{expected_min},{expected_max}]")
        return False
    print(f"PASS: {label} — {len(in_range)} vertices in expected range")
    return True

def run(obj_path):
    text = pathlib.Path(obj_path).read_text()
    verts = extract_vertices(text)
    # Scale from cm back to inches if needed (OBJ is in cm: divide by 2.54)
    # Assume cm output: scale factor applied
    results = []
    # Door: must have vertices at X near 342-348 (east wall), NOT near X=0-6
    door_verts = [v for v in verts if 340/2.54 <= v[0] <= 350/2.54]
    wrong_wall_verts = [v for v in verts if v[0] < 10/2.54 and 195/2.54 <= v[2] <= 237/2.54]
    if wrong_wall_verts and not door_verts:
        print("FAIL: DOOR IS ON SOUTH/WEST WALL — must be on east wall (high X)")
        results.append(False)
    else:
        print("PASS: Door placement verified on east wall")
        results.append(True)
    return all(results)

if __name__ == "__main__":
    ok = run(sys.argv[1])
    sys.exit(0 if ok else 1)
```

The key insight: `sys.exit(1)` on failure means the DAG task fails, which blocks the downstream completion task. No human needs to read and interpret the OBJ file.

---

## 4. Per-Failure Fix Classification

| Failure | Fix Type | Agent vs Assertion | Notes |
|---------|----------|-------------------|-------|
| S1 Door placement | Locked coordinate artifact + numeric assertion | Assertion script (door_X > 340) | No agent judgment needed — pure geometry check |
| S2 Closet placement | Locked coordinate artifact + numeric assertion | Assertion script (closet_X < 144) | Same — pure geometry |
| S3 Screen placement | Locked coordinate artifact + numeric assertion | Assertion script (screen_Z > 240) | Same |
| S4 T/S parameters | Locked ts_params.json artifact | Verify agent cross-references against Parts Express datasheet | One-time verification creates the file; thereafter file is the authority |
| S5 Budget arithmetic | Python sum script in DAG | Assertion script — no agent | `sum(line_items) == stated_total` is arithmetic, not judgment |
| S6 Sub enclosure calcs | Dedicated calculation task using ts_params.json | Verify agent checks Fc/Qtc/F3 formula | Must use ts_params.json as input; result written to sub_cabinet_resolved.json |
| S7 APM2/PCM5102 signal chain | specs.yaml locks the correct chain | Verifier checks specs.yaml signal chain matches investigation verdict | Investigation verdict is ground truth |
| S8 Screen bottom height | specs.yaml correction entry | Assertion: screen_Y1 < 35 (not 51) | Simple numeric check |
| S9 Gain staging | Calculation task with explicit voltage table | Verify agent checks each stage | Cannot be automated without the actual voltage values |
| U1 Sub footprint conflict | Decision required first | N/A until resolved | Conflict between specs.yaml (20") and layout_config.json (24"); layout_config is more recent |
| U2 Sub cabinet height | Team calculation task required | N/A until U1 resolved | Must calculate Fc/Qtc/F3 for three height options |

---

## 5. DAG Gate Architecture

### Current (broken) pipeline

```
Read source docs
    ↓
Builder generates models (re-derives coordinates from English)
    ↓
Verifier reads OBJ, manually checks placements (human judgment, fails)
    ↓
Report
```

### Proposed DAG with gates

```
Task A: Generate coordinates.json from design-package.md coordinate table
    (one agent, reads only lines 128-164, writes locked JSON)

Task B: Generate ts_params.json from Dayton datasheet
    (verify agent, cross-references Parts Express listing)

Task C: Resolve sub cabinet dimensions [DECISION GATE — blocks on user input]
    → generates sub_cabinet_resolved.json

      ┌──────────────────────────────────────┐
      ↓ (A and B completed)                  ↓
Task D: Generate room_model.obj             Task E: Generate specs.yaml
    (reads coordinates.json as ONLY source)     (reads ts_params.json)

Task F: Assert door placement (assert_geometry.py door)  ← blocks on D
Task G: Assert closet placement (assert_geometry.py closet) ← blocks on D
Task H: Assert screen placement (assert_geometry.py screen) ← blocks on D
Task I: Assert budget arithmetic (sum_budget.py) ← blocks on E

      ↓ (F, G, H, I all pass)
Task J: Generate sub_cabinet.obj ← blocks on C (sub_cabinet_resolved.json)
Task K: Generate docs (spec markdown files) ← blocks on E
Task L: Final report
```

### Gate semantics

- Gates F, G, H, I are **blocking** — downstream tasks cannot start until they exit 0.
- Gate C is a **user decision gate** — the DAG pauses and presents the three height options with calculated Fc/Qtc/F3 before generating sub_cabinet.obj.
- Tasks A and B are **idempotent** — if the JSON files already exist and have a `_validated` timestamp, skip regeneration.

---

## 6. "Verify Before Proceeding" Gate Design: Separate Task vs Self-Verify

### Option A: Builder self-verifies

Builder generates the model, then checks its own output before marking the task complete.

**Problems:**
- Confirmation bias — builder reads what it wrote, not what is there
- Same re-derivation failure applies to verification ("I placed the door on the east wall, so it must be there")
- No structural enforcement — a busy agent skips the check

**When acceptable:** Trivial numeric checks where the builder is computing a value and comparing to a threshold (e.g., "verify screen width < room width").

### Option B: Separate assertion task that blocks downstream

A different task, with no memory of the build process, runs the assertion script on the output file.

**Benefits:**
- No shared state with the builder — genuinely independent
- Fails deterministically (exit code) — no judgment involved
- Can be reused across runs without modification
- Blockers are structural: downstream tasks literally cannot run until the assertion passes

**When to use:** Any spatial placement, any arithmetic total, any parameter value that is machine-checkable.

### Option C: Dedicated verify agent cross-references sources

A verify-type agent reads the output AND reads the original source, checking for agreement.

**When to use:** Claims that cannot be reduced to a numeric assertion — e.g., "does this signal chain description match the investigation verdict?" or "are the T/S parameters in the doc consistent with the datasheet?"

### Recommendation

Use Option B (assertion script) for all spatial and arithmetic checks. Use Option C (verify agent) for semantic/design-decision checks. Use Option A (self-verify) only for trivial in-line range checks during generation. Never use Option A for the three known placement failures — they require Option B.

**Cost:** One Python script (~100 lines) to write and maintain. **Benefit:** Eliminates three systematic failures that have occurred on every run.

---

## 7. Coordinate Table as Locked Input Artifact

The coordinate table at design-package.md lines 128–164 is correct. The problem is its format and location.

### Why embedding in the skill document fails

1. Agents read the skill document alongside many other documents. Attention dilutes.
2. The table is markdown, not machine-readable. Agents parse English column headers and may misread values.
3. The note "Use the coordinate table below. Do NOT derive positions from English" is itself English prose. Agents can read it and then immediately derive positions from English anyway.
4. No enforcement mechanism. The model generator has no way to know it violated the rule.

### Why a separate JSON file works

1. The model generator code reads `coordinates.json` at runtime — there is no English to re-derive from.
2. The JSON file has `_assertion` fields that document what the post-generation script checks.
3. If `coordinates.json` does not exist, model generation fails immediately (FileNotFoundError), not silently.
4. The file is generated once from the authoritative skill document, then treated as immutable for that run.
5. Updating the coordinates requires updating `coordinates.json` explicitly — it cannot drift silently.

### Implementation pattern

```python
# In generate_room.py — ONLY permitted coordinate source
import json, pathlib

COORDS = json.loads(pathlib.Path("coordinates.json").read_text())

door = COORDS["door"]
# door["X1"] = 342, door["X2"] = 348 — no English, no re-derivation
wall_with_hole(
    x1=door["X1"] * 2.54, x2=door["X2"] * 2.54,
    z1=door["Z1"] * 2.54, z2=door["Z2"] * 2.54,
    hole_z1=door["Z1"] * 2.54, hole_z2=door["Z2"] * 2.54,
    hole_y1=door["Y1"] * 2.54, hole_y2=door["Y2"] * 2.54
)
```

This makes the "do not derive from English" rule **structurally enforced**, not advisory.

---

## 8. Sub Cabinet Dimension Conflict — Resolution Path

The footprint conflict between specs.yaml (20"×20") and layout_config.json (24"×24") is confirmed:

- `layout_config.json` line 73: `"width_inches": 24` (read directly above)
- `layout_config.json` line 74: `"depth_inches": 24`
- design-package.md line 111: `20"W × 20"D × 72"H`
- design-package.md line 221: `specs.yaml says 20"×20"×72", layout_config.json says 24"×24"`

`layout_config.json` is the spatial layout source of truth (per design-package.md line 25 and 90). Therefore the 24"×24" footprint is correct and specs.yaml/design-package.md contain an error.

The height is unresolved by design — it requires a team calculation. The correct path:

1. Lock footprint: 24"×24" (from layout_config.json)
2. Run Fc/Qtc/F3 calculation for three heights using **corrected** T/S params (Qts=0.53, Vas=8.77 cuft)
3. Note: design-package.md line 225 still cites the incorrect T/S params (Vas=15.5, Qts=0.36) in the sub cabinet height options table — this is a documentation error in the skill itself
4. Present three height options with correct calculations to user for decision
5. Write decision to sub_cabinet_resolved.json, then unlock sub cabinet model generation

---

## 9. Summary of Structural Recommendations

| Priority | Action | Eliminates Failures |
|----------|--------|-------------------|
| High | Generate `coordinates.json` as first DAG task, block all model generators on it | S1, S2, S3 |
| High | Add `validate_geometry.py` assertion script, run as separate blocking DAG task after model generation | S1, S2, S3 (catches any residual errors) |
| High | Generate `ts_params.json` from verified Dayton datasheet, block all sub calculations on it | S4, S6 |
| High | Add `validate_budget.py` that programmatically sums specs.yaml line items | S5 |
| Medium | Fix design-package.md line 225: T/S params in sub height table are wrong (cites Vas=15.5 — should be 8.77) | S6 |
| Medium | Resolve footprint conflict: update specs.yaml and design-package.md to 24"×24" to match layout_config.json | U1 |
| Medium | Add user decision gate task for sub cabinet height before sub_cabinet.obj generation | U2 |
| Low | Fix screen bottom height in specs.yaml (30", not 51") and add Y1 < 35 assertion | S8 |

---

## Bidirectional Search

- **Searched FOR:** Systematic patterns documented as "every run" or "prior model run" in design-package.md; coordinate discrepancies between layout_config.json and design-package.md
- **Searched AGAINST:** Evidence that the current prose-instruction approach works (any passing runs documented); alternative interpretations of the coordinate system; cases where self-verification is sufficient
- **Contradicting evidence found:** No evidence of any run where the three placement failures (S1, S2, S3) were avoided without explicit post-hoc correction. The skill's own "MANDATORY placement validation" section (line 232) exists precisely because every prior run required it — confirming the systematic nature.

---

## Sources

All evidence sourced from local project files — no web search required for this analysis.

1. `D:/Projects/Claude/theater/.claude/skills/design-package.md` — primary skill document, all line references above
2. `D:/Projects/Claude/theater/screenshots/layout_config.json` — spatial layout source of truth, confirms 24"×24" sub footprint
3. `D:/Projects/Claude/theater/.claude/commands/team.md` — team framework structure
