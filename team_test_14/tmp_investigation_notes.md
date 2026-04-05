# Investigation Notes — Consolidated Reference

Generated for design package use. Covers all investigations in `D:/Projects/Claude/investigations/`
plus OBJ skill and layout configuration.

---

## Investigations Summary

### 1. NX6000D vs ICEpower 1200AS2 + ADAU1452

**Date:** 2026-03-13
**Verdict:** ADOPT ICEpower 1200AS2 — MEDIUM-HIGH confidence
**Location:** `investigations/nx6000d-vs-icepower-1200as2/`

**Topic:** Replace 5× Behringer NX6000D sub amplifiers with ICEpower 1200AS2 plate amp modules on 240V.

**Actionable conclusions:**
- Use 5× ICEpower 1200AS2 (4 active + 1 spare), rack-mounted in equipment closet
- Run on single 20A/240V circuit (vs 2× 120V for NX6000D)
- ADAU1452 replaces DSP-408 + miniDSP combo for sub DSP — adopt regardless of amp choice
- NX6000D advantage (850W continuous) only exists above 30Hz; at 15-20Hz the 1200AS2 equals or exceeds it due to zero infrasonic derating
- NX6000D requires 3 mods (12× fan swaps, custom trigger box, DSP bypass); 1200AS2 requires zero
- Idle power: 175W (1200AS2 × 5) vs ~300-375W (NX6000D × 5)
- Budget: ICEpower path ~$2,125 vs NX6000D path ~$3,894 — savings of ~$1,769
- Build chassis for 4× 1200AS2 modules with heatsinks; Protocase if DIY stalls
- Ensure closet ventilation for 175W idle heat

**Power summary at infrasonic frequencies:**

| Frequency | NX6000D (8Ω) | 1200AS2 (8Ω, 240V) |
|-----------|-------------|---------------------|
| 40Hz+ | 850W | 620W (NX6000D +37%) |
| 20Hz | ~750W (88%) | 620W (no derating) |
| 15Hz | ~600W (71%) | 620W (1200AS2 wins) |
| 10Hz | ~500W (est.) | 620W (1200AS2 +24%) |

---

### 2. Is the Bass Plan Overkill?

**Date:** 2026-03-13
**Verdict:** PARTIALLY — ADOPT WITH MODIFICATIONS — MEDIUM confidence
**Location:** `investigations/bass-plan-overkill/`

**Topic:** Is 12× UMII18-22 + 16× Aura Pro shakers overkill for 3,910 cu ft targeting -10 dB Reference?

**Actionable conclusions:**
- Keep 8 corner subs (4 cabinets × 2 drivers) — 4-corner array is well-justified per Welti/Harman; provides uniformity and headroom
- 8 corner subs achieve ~113 dB at 20Hz at MLP — +8 dB above -10 dB Reference target
- Reduce shakers 16 → 8 (1 per seat) — saves $560, zero performance loss; 1/seat is community standard
- Defer nearfield sub build — do not eliminate, install corners + shakers first, add nearfield later if chest-compression is missed
- Nearfield cabinet space behind Row 1 is reserved in the layout
- Immediate savings: $560. Deferred savings: $1,600 (4 drivers + cabinet)
- UMII18-22 Xmax (28mm) is binding constraint below ~13Hz regardless of driver count
- Keep 5 amp modules: 4 active for corners + shakers, 1 spare; nearfield repurposes spare when added

---

### 3. Theater HVAC Setup

**Date:** 2026-03-13
**Verdict:** ADOPT WITH MODIFICATIONS — MEDIUM-HIGH confidence
**Location:** `investigations/hvac-theater-setup/`

**Topic:** MrCool DIY 12K BTU with fake-wall venting behind AT screen — reasonable approach?

**Actionable conclusions:**
- MrCool DIY 12K at 230V is correctly sized; unique DIY Quick Connect (no EPA 608 cert needed)
- Noise: 23.5 dB(A) silent mode — both MrCool (23.5) and Pioneer WYS (21.5) are at/below room ambient; 2 dB difference is not a meaningful selection criterion
- Pre-cool protocol (run hard before movie, silent/off during) makes noise largely academic
- Both units beat THX NC-30 commercial standard (~35 dB(A)) by 8-14 dB

**Partition wall mount vs behind-screen mount:**
Partition wall (west wall) wins on 6 of 10 factors:
- Airflow: better — side wall mount across 17' short dimension is textbook placement
- Serviceability: much better — open wall, step-ladder filter access vs confined space
- Condensate safety: better — gravity drain to gym, visible; behind-screen has hidden leak risk near $7K of speakers
- Installation: simpler — no vent engineering needed
- Lineset: shorter (~10-14' vs ~15-20')
- Noise penalty: minimal (1-3 dB at silent mode — not perceptible during content)
- Recommended position: 7-8' high on partition wall, 2-4' from north wall (north of FWL)

**Budget gap:** Option D allocates $1,800 for HVAC; actual MrCool system ~$2,550 — $750 gap needs addressing.

**Required engineering (if behind-screen):**
- Vent openings sized for <300 FPM, acoustic-lined
- Condensate routing through wall penetration
- Resolve doc contradiction (wall-mount vs ceiling cassette)

---

### 4. Bidirectional Verification Enforcement

**Date:** 2026-03-20
**Verdict:** ADOPT WITH MODIFICATIONS — MEDIUM confidence
**Location:** `investigations/bidirectional-verification-enforcement/`

**Topic:** Does the two-layer verification system (CLAUDE.md rule + Haiku Stop hook) work robustly?

**Actionable conclusions:**
- System solves the right problem — forces adversarial search before product/design recommendations
- Hook fires structurally on every response; [UNVERIFIED] escape prevents fabricated verification
- Three gaps survived adversarial testing:
  1. Multi-turn context poisoning: specs from exempt early turns contaminate later decisions — fix with CLAUDE.md re-verification rule at point of use
  2. Checkbox compliance: superficial search passes format check — add quality-check prompt to /verify
  3. [UNVERIFIED] tag dilution from "when in doubt, tag it" — change to "when in doubt, verify; tag only when verification is impractical"
- Multi-turn re-verification rule was added to CLAUDE.md as a result

---

## DSP Platform Verdict

**Platform: APM2 (ADAU1701), NOT ADAU1452**

The ADAU1452 is the planned sub DSP for the full theater build (8.24 fixed-point, full sub-20Hz capability). However, the **development and learning platform** is:

- **Board:** Wondom APM2 (AA-AP23122) — ADAU1701 DSP, 2-in/4-out
- **I/O:** Wondom APM3 (AA-AA11428) — RCA + 3.5mm
- **Programmer:** ICP5 (DB-DP11226) — SigmaStudio interface

**ADAU1701 key specs:**
- 5.23 fixed-point
- 2 inputs, 4 outputs
- 48 kHz sample rate, 28-bit/56-bit processing
- Internal DAC output: **0.9 Vrms** (too low for full power)
- Dynamic range: 98.5 dB; ADC THD: -83 dB; DAC THD: -90 dB
- 1024 program RAM instructions, 1024 parameter RAM words

**Critical APM2 operational notes:**
- EEPROM write protect: must bridge GND + WP pins (screwdriver) during write
- ICP5 switches: SW4 = IIC, SW = PROGRAM
- SigmaStudio hardware config: USBi → ADAU1701 (IC 1) + E2Prom (IC 2)
- Biquad order: [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy
- COM server: REGISTER_WRITE (not REGISTER_WRITE_ARRAY from Python)
- Values ≥ 0x80000000 must be converted to signed (subtract 0x100000000)
- Config `sigmadsp.description` must be "IC 1"
- APM3 analog bypass flaw: connect RCA directly to APM2 J3 header pins

---

## PCM5102 DAC Fix — Internal DAC Limitation

**Problem:** ADAU1701 internal DAC outputs only **0.9 Vrms**. ICEpower 1200AS2 needs 3.61 Vrms for full 620W output. Without intervention: 38.5W/ch (6.2% utilization, -12.1 dB headroom loss).

**Fix: External PCM5102 DAC on I2S output**
- ADAU1701 → I2S → PCM5102 → 2.0-2.1 Vrms output
- PCM5102 has internal PLL — no MCLK needed, only 3 wires (BCK, LRCK, DIN)
- Each APM2 connects to 2× PCM5102 modules (4 analog outputs)

**APM2 J4 wiring to PCM5102:**

| APM2 Test Point | Signal | → PCM5102 Pin |
|-----------------|--------|----------------|
| MP11 | OUTPUT_BCLK | BCK |
| MP10 | OUTPUT_LRCLK | LRCK |
| MP6 | SDATA_OUT0 | DIN (Ch 1-2, module #1) |
| MP7 | SDATA_OUT1 | DIN (Ch 3-4, module #2) |

**PCM5102A module source:** Adafruit #6250 ($4.95 each) — preferred over cheap AliExpress clones which have inconsistent filtering and solder bridges.

**Performance improvement:**
- Internal DAC: 0.9 Vrms, -90 dB THD
- PCM5102: 2.0-2.1 Vrms, -93 dB THD+N (+10 dB improvement)
- Confirmed feasibility: ADAU1701 → PCM5102A path used in commercial Enovo-77 board

---

## Signal Chain

```
X6800H → APM2 ADC → ADAU1701 DSP → I2S → PCM5102 → [balanced driver] → ICEpower 1200AS2 → Subs
```

Full chain with balanced output stage:
```
X6800H (unbalanced RCA out)
  → APM2 (Wondom, ADAU1701) — ADC + DSP filtering
  → I2S (BCK, LRCK, DIN)
  → PCM5102 external DAC — 2.0 Vrms
  → DRV134 or THAT1646 balanced driver — 4.0-4.2 Vrms differential
  → ICEpower 1200AS2 balanced input (P105)
  → Subwoofer drivers (8Ω)
```

**Voltage at each stage:**
- X6800H output: ~2 Vrms (unbalanced)
- APM2 internal DAC: 0.9 Vrms — DO NOT USE as final output
- PCM5102 output: 2.0-2.1 Vrms
- DRV134/THAT1646 differential: ~4.0-4.2 Vrms
- ICEpower 1200AS2 at full power: 620W into 8Ω requires 3.61 Vrms input → 70.4 Vrms output

**Power chain:**
- With PCM5102 + balanced driver: ~190-620W/ch (depending on driver choice and gain trim)
- DRV134 alone (from 0.9 Vrms internal DAC): ~154W/ch — exceeds THX reference but wastes ICEpower headroom

---

## OBJ Model Generation Skill

**Location:** `D:/Projects/Claude/theater/POR/skills/obj-model-generation/SKILL.md`

**Coordinate system:**
- X: Left → Right (width)
- Y: Bottom → Top (height)
- Z: Front → Back (0 at back, positive toward front)

**Face winding convention:**
- Faces viewed from outside: Counter-clockwise (CCW) winding
- Normal points outward via right-hand rule
- To flip winding: [a, b, c, d] → [a, d, c, b]
- Debug: if face appears wireframe from front but solid from back → winding is inverted

**Circular cutouts — Corner Fan Method (PROVEN):**
- Split baffle at midpoints between holes — each hole gets its own rectangular region
- Fan triangles from 4 region corners to outer ring quadrants
- SEG=32 circle segments; R=0, T=8, L=16, B=24 (cardinal indices)
- OUTER_R = CUTOUT_R + 2" (buffer between cutout and fan origin)

**Winding rules (tested):**

| Face | Order | Notes |
|------|-------|-------|
| Front donut | outer[i], outer[ni], inner[ni], inner[i] | Normal +Z |
| Back donut | outer[i], inner[i], inner[ni], outer[ni] | Normal -Z |
| Front fan tri | corner, ring[i+1], ring[i] | CCW from front |
| Back fan tri | corner, ring[i], ring[i+1] | CCW from back |
| Cylinder wall | front[i], front[ni], back[ni], back[i] | Normal into hole |

**Failed approaches (do not use):**
- Delaunay triangulation — creates spikes/starbursts across holes
- Fan from edge midpoints — overlapping triangles, gaps
- Grid stitching — complex, inconsistent winding

**Vertex caching:** Use `round(x, 4)` key in dict to avoid duplicate vertices at shared points.

**Unit scaling:** OBJ files have no inherent units. For inch models viewed in cm: multiply by 2.54.

**Materials:** Use separate `.mtl` file with `plywood`, `baffle`, `dark` materials. Transparency via `d` (opaque fraction) + `Tr` (transparent fraction).

---

## Layout Configuration — layout_config.json

**File:** `D:/Projects/Claude/theater/screenshots/layout_config.json`
**Title:** Option D — Top-Down Layout — 17'×23' Theater

### Room Dimensions
- Width: 17.0 ft (E-W)
- Depth: 23.0 ft (N-S)
- Height: 10.0 ft
- North wall: Screen wall
- South wall: Rear
- West wall: Partition to Gym
- East wall: Exterior

### Sub Cabinet Footprint
- **Width: 24 inches**
- **Depth: 24 inches**
- Drivers per cabinet: 2
- Driver size: 18 inches
- Corners: NW, NE, SW, SE (all four)

Stage depth = sub_depth (24") + screen_depth (2") = 26" total

### Screen
- Width: 170 inches (16:9 AT screen)
- Offset from north wall: 26 inches

### LCR Positions (Titan-815LX)
- Width: 19.5 inches, Depth: 21.5 inches
- Center: 0.0 ft offset from room center
- L/R spread: ±4.9 ft from center
- Setback from north wall: 0.1 ft

### Surrounds (Volt-10, 14" × 9.25")
- Front wides: enabled, y_mode = midpoint between screen and Row 1
- Side surrounds: enabled, y_mode = between Row 1 and MLP
- Surround backs: enabled, x_offset = ±3.0 ft from east/west walls, south wall

### Atmos (Volt-10, 14" square)
- Spread: ±4.0 ft from center
- Top front: enabled, y_mode = front wides
- Top rear: enabled, y_mode = Row 2 / MLP
- Top middle: disabled

### Seating
- Couch width: 8.0 ft
- Couch depth: 3.0 ft
- MLP position: 0.75 (75% of way through couch depth from front)
- Row 1: in front of nearfield subs
- Row 2: on riser, 1.0 ft setback from riser back

### Riser
- Front from north wall: 15.5 ft
- Depth: 5.5 ft
- Inset from east/west walls: 1.0 ft

### Nearfield Subs (deferred)
- Depth: 12.5 inches
- 4 drivers, 18 inches
- Position: riser front, forward-facing
- Width: match couch width

### Equipment Closet
- Size: 4.0 ft × 4.0 ft
- Position: west side, outside NW corner (gym side)

### Door
- East wall, 36" wide
- 62 inches from NE corner
- Swings into room

### Power Panel
- East wall, 50 inches from NE corner, 2.0 ft height
