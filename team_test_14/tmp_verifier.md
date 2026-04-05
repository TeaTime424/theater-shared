# Verifier Report — team_test_14
Generated: 2026-03-21

---

## 1. Diagram Scripts

**Method:** `python generate_all.py` from diagrams/ directory

**Result:** All 4 scripts FAILED via `generate_all.py` due to import naming mismatch. The scripts are named `d01_floor_plan.py`, `d02_signal_flow.py`, etc., but `generate_all.py` tries to import them as `d01`, `d02`, etc. — the suffix `_floor_plan` / `_signal_flow` is not stripped.

**Individual script execution** (running each .py directly) — all 4 PASS:
- `d01_floor_plan.py` → `diagrams_output/d01_floor_plan.png` OK
- `d02_signal_flow.py` → `diagrams_output/d02_signal_flow.png` OK
- `d03_front_elevation.py` → `diagrams_output/d03_front_elevation.png` OK
- `d04_wiring.py` → `diagrams_output/d04_wiring.png` OK

**BUG:** `generate_all.py` SCRIPTS list must use full module names (`d01_floor_plan`, `d02_signal_flow`, `d03_front_elevation`, `d04_wiring`) not short names (`d01`, `d02`, `d03`, `d04`).

---

## 2. specs.yaml Cross-Check

| # | Field | Expected | Actual | Result |
|---|-------|----------|--------|--------|
| 1 | room.theater_zone | 17'x23'x10' | "17'x23'x10' (204\"x276\"x120\", X=144 to 348)" | PASS |
| 2 | speakers.surrounds.sensitivity_dB | 95 (NOT 98) | 95 — note says "95 dB NOT 98 dB" | PASS |
| 3 | speakers.lcr.impedance_ohm | 6 (NOT 8) | 6 — note says "6 ohm nominal NOT 8 ohm" | PASS |
| 4 | amplification.sub_amps.model | ICEpower 1200AS2, 240V, no derating | "ICEpower 1200AS2", voltage: "240V", note: "fanless, no infrasonic derating" | PASS |
| 5 | subwoofers T/S Qts | 0.53 (NOT 0.36) | ts_params.json: Qts = 0.53 | PASS |
| 6 | subwoofers T/S Vas | 8.77 cuft (NOT 15.5) | ts_params.json: Vas_cuft = 8.77 | PASS |
| 7 | screen.bottom_height_in | 30 (NOT 51) | 30 — note says "bottom at 30 inches, NOT 51" | PASS |
| 8 | electrical.feed | #2 Al, 60A (NOT 100A) | "#2 Al, 240V, 60A breaker at main panel" — note says "NOT 100A" | PASS |
| 9 | hvac.price | 2359 | 2359 | PASS |
| 10 | dsp.platform | ADAU1452 (NOT ADAU1701 for production) | "ADAU1452 (production)" | PASS |
| 11 | dsp.dac | PCM5102 (NOT internal DAC) | "PCM5102 external DAC module (NOT internal DAC)" | PASS |
| 12 | subwoofers.corner_cabinet.footprint_in | 24x24 (NOT 20x20) | "24x24" | PASS |

**All 12 specs: PASS**

---

## 3. Signal Chain Verification

`dsp.signal_chain`: "X6800H → ADAU1452 → I2S → PCM5102 (2.0V) → 898B (3.5V) → ICEpower 1200AS2"

- Contains ADAU1452: PASS
- Contains PCM5102: PASS
- Contains 898B: PASS

**Signal chain check: PASS**

---

## 4. Required Documents Exist

| File | Exists |
|------|--------|
| 00_index.md | PASS |
| 01_room_electrical_hvac.md | PASS |
| 02_speakers.md | PASS |
| 03_subwoofers.md | PASS |
| 04_amplification_dsp.md | PASS |
| 05_screen_seating.md | PASS |
| 06_budget.md | PASS |
| specs.yaml | PASS |
| coordinates.json | PASS |
| ts_params.json | PASS |

**All 10 documents: PASS**

---

## 5. Diagram PNGs Exist

Location: `diagrams/diagrams_output/`

| File | Exists |
|------|--------|
| d01_floor_plan.png | PASS |
| d02_signal_flow.png | PASS |
| d03_front_elevation.png | PASS |
| d04_wiring.png | PASS |

**All 4 PNGs: PASS**

---

## 6. OBJ Model Files Exist

Location: `models/`

| File | Exists |
|------|--------|
| room_model.obj | PASS |
| room_model_hires.obj | PASS |
| sub_cabinet.obj | PASS |

**All 3 OBJ files: PASS**

---

## Summary

| Check | Status |
|-------|--------|
| Diagram scripts (via generate_all.py) | FAIL — module naming bug |
| Diagram scripts (individual execution) | PASS — all 4 produce correct PNGs |
| specs.yaml 12 key values | PASS — 12/12 |
| Signal chain verification | PASS |
| Required documents | PASS — 10/10 |
| Diagram PNGs exist | PASS |
| OBJ model files | PASS |

**Critical bug found:** `generate_all.py` imports `d01`, `d02`, `d03`, `d04` but scripts are `d01_floor_plan.py`, `d02_signal_flow.py`, `d03_front_elevation.py`, `d04_wiring.py`. The SCRIPTS list in generate_all.py must be updated to use full module names. PNGs already exist from prior individual runs so downstream consumers are not blocked.
