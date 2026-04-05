# Investigation Notes — Consolidated Reference
# Generated for team_test_11 by W0-B agent
# Date: 2026-03-21

---

## INVESTIGATIONS SUMMARY

### 1. NX6000D vs ICEpower 1200AS2 + ADAU1452
- **File:** `investigations/nx6000d-vs-icepower-1200as2/`
- **Date:** 2026-03-13
- **Verdict:** ADOPT WITH MODIFICATIONS (confidence: MEDIUM-HIGH)
- **Topic:** Replace 5× Behringer NX6000D sub amps with ICEpower 1200AS2 modules + ADAU1452 DSP on 240V
- **Actionable conclusions:**
  - ADOPT ICEpower 1200AS2. At infrasonic frequencies (10-20Hz), 1200AS2 equals or exceeds NX6000D (no derating below 30Hz). NX6000D's 850W vs 620W advantage only exists above 30Hz where boundary loading already gives 17+ dB headroom.
  - Zero modification burden: fanless, no internal DSP to bypass, 240V native. NX6000D requires fan swap (12 fans), custom trigger box, DSP bypass — significant mod burden.
  - Electrical: 5× 1200AS2 = 175W idle on single 20A/240V circuit. 5× NX6000D = 300-375W idle on 2× 20A/120V circuits.
  - Rack-mount in equipment closet (NOT plate-mount in sub enclosures).
  - ADOPT ADAU1452 as sub DSP regardless — replaces DSP-408 + miniDSP combo.
  - Buy 5 modules total: 4 active + 1 spare at $373 each ($1,865 total).
  - Budget savings: ~$1,769 vs NX6000D path.
  - Power table at 8Ω: 40Hz+ NX6000D 850W vs 1200AS2 620W; 15Hz 1200AS2 wins (no derating); 10Hz 1200AS2 +24%.

### 2. Bass Plan Overkill?
- **File:** `investigations/bass-plan-overkill/`
- **Date:** 2026-03-13
- **Verdict:** ADOPT WITH MODIFICATIONS (confidence: MEDIUM)
- **Topic:** Is 12× UMII18-22 + 16× shakers overkill for 3,910 cu ft room at -10 dB Reference target?
- **Actionable conclusions:**
  - KEEP 8 corner subs in 4 locations. 8-corner array achieves ~113 dB at 20Hz at MLP = +8 dB above -10 dB Reference target. Config A (4 subs) fails at 15Hz with no headroom.
  - REDUCE shakers 16→8 (1 per seat). $560 savings, zero performance cost. 1/seat is community standard.
  - DEFER nearfield subs (4× UMII18-22 behind Row 1). Do not eliminate — reserve space behind Row 1, build corners + shakers first, add nearfield later if chest-compression is missed. Nearfield value is real but unquantified.
  - Immediate savings: $560. Deferred savings: $1,600 (4 drivers + cabinet).
  - UMII18-22 Xmax (28mm) is binding constraint below ~13Hz regardless of driver count.
  - More drivers = lower distortion per driver at target SPL (valid physics; supports keeping 8 corners).
  - 2 drivers already owned ($700 sunk cost).

### 3. Theater HVAC Setup
- **File:** `investigations/hvac-theater-setup/`
- **Date:** 2026-03-13
- **Verdict:** ADOPT WITH MODIFICATIONS (confidence: MEDIUM-HIGH)
- **Topic:** MrCool DIY 12K BTU behind AT screen with fake-wall venting for Option D theater

#### Main Verdict (05_verdict.md)
- **Actionable conclusions:**
  - ADOPT MrCool DIY 12K at 230V. Correctly sized, uniquely DIY-friendly (Quick Connect), 23.5 dB(A) silent mode.
  - Behind-screen mounting above AT screen is physically viable: 18" clear wall above screen across 13.7' width between corner sub cabinets.
  - AT screen provides negligible noise attenuation (~0.5-2 dB), not 3-5 dB.
  - Pre-cool protocol (run hard before movie, silent/off during viewing) largely neutralizes noise concern.
  - Budget gap: Option D allocates $1,800 ($1,000 condenser + $800 head); actual MrCool system ~$2,550 → $750 gap.
  - Required engineering: size vent openings for <300 FPM air velocity, line with acoustic foam; plan condensate routing (gravity drain through lineset penetration).
  - Warranty: $234/yr for MrCool Care Program (lifetime compressor).

#### Supplement: Noise Assessment (06_noise_assessment.md)
- 2 dB(A) difference between Pioneer 21.5 dB(A) and MrCool 23.5 dB(A) is NOT a meaningful differentiator.
- Both units are at or below room ambient (NC-15 to NC-20 = ~21-25 dB(A)) in a well-sealed theater.
- Both far exceed THX NC-30 commercial standard.
- Pre-cool protocol makes noise spec largely irrelevant during viewing.
- Choose based on cost, install method, warranty — not noise.

#### Supplement: Pioneer WYS Assessment (07_pioneer_assessment.md)
- **Verdict: NOT RECOMMENDED** — retain MrCool.
- WYS line (R-410A) is end-of-life/discontinued per EPA AIM Act (R-410A phaseout January 2026).
- WYT replacement line (R-454B) is unproven, limited availability.
- Pioneer requires flare connections + vacuum pump + EPA 608 — not DIY Quick Connect.
- Tooling cost for DIY Pioneer install: $350-700 (narrows the price advantage).
- Pioneer customer support severely criticized (Trustpilot).
- Pioneer warranty: 5-year compressor (vs MrCool lifetime with Care Program).
- Noise: Pioneer WYS 22.5 dB(A) low vs MrCool 23.5 dB(A) — 1 dB difference, imperceptible.

#### Supplement: Partition Wall Mount Assessment (08_partition_wall_assessment.md)
- **Verdict: PARTITION WALL MOUNTING IS BETTER THAN BEHIND-SCREEN (confidence: HIGH)**
- Mount head unit on N-S partition (west) wall, 7-8' high, 2-4' from north wall (north of FWL speaker).
- Wins on: airflow distribution, lineset length (10-14' vs 15-20'), serviceability, condensate safety, no vent engineering needed.
- Behind-screen wins (marginally): noise at MLP (~1-3 dB), visual hiding.
- Score: partition wall wins 6 factors, behind-screen wins 3 (all marginal).
- Lineset routes: outdoor condenser (north exterior) → gym space ceiling → partition wall penetration.
- POR update required: change HVAC mounting from behind-screen to partition wall.

#### Supplement: Ducted Mini-Split Assessment (09_ducted_assessment.md)
- **Verdict: REJECT — Stick with two independent wall-mount units (confidence: HIGH)**
- Ducted mid-range (Fujitsu 18K): $4,700-$6,080 — same cost or more than two wall-mounts at $5,100.
- All ducted options require professional refrigerant work (no Quick Connect). DIY advantage lost.
- Zoning two rooms with different use patterns adds $500-900 in dampers/controllers.
- Ducted noise benefit is 2-5 dB quieter at MLP — real but practically irrelevant given pre-cool protocol.
- Attic air handler maintenance is harder than accessible wall-mount.
- Fujitsu 18K Slim Duct: 27 dB(A) quiet mode is the best candidate if ducted were adopted — not adopted.

### 4. Bidirectional Verification Enforcement
- **File:** `investigations/bidirectional-verification-enforcement/`
- **Date:** 2026-03-20
- **Verdict:** ADOPT WITH MODIFICATIONS (confidence: MEDIUM)
- **Topic:** Does the two-layer verification system (CLAUDE.md rule + Haiku Stop hook) work robustly?
- **Actionable conclusions:**
  - System solves real problem: forces adversarial search before product/design recommendations.
  - Three gaps survived adversarial testing:
    1. Multi-turn context poisoning: unverified specs from exempt early turns contaminate later decisions. Fix: re-verify at point of use when conversation transitions to purchase/design decision.
    2. Checkbox compliance: superficial adversarial search passes format check. Fix: human audit of search terms; quality-check prompt in /verify.
    3. [UNVERIFIED] tag dilution from "when in doubt, tag it." Fix: change to "when in doubt, verify it — use [UNVERIFIED] only when verification is impractical."
  - Hook is structurally unavoidable (fires on every response). [UNVERIFIED] escape is well-designed.
  - Modifications to CLAUDE.md have been applied (multi-turn re-verification rule, [UNVERIFIED] guidance).
  - No budget impact, no dependencies.

---

## DSP PLATFORM VERDICT

**CRITICAL NOTE:** Based on investigation context and task instructions, the DSP platform for this project is:

- **Platform:** ADAU1701 on APM2 board (NOT ADAU1452)
- **APM2 internal DAC limit:** 0.9 Vrms — too low for adequate drive level
- **Fix:** PCM5102 external DAC path → 2.0 Vrms output → 190W/ch into ICEpower

### Signal Chain
```
X6800H (analog out) → APM2 ADC → ADAU1701 DSP → I2S → PCM5102 DAC → ICEpower 1200AS2
```

### Key DSP Facts (ADAU1701)
- Fixed-point format: 5.23
- Biquad order: [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy
- Direct register writes OK (no safeload required unlike ADAU1452)
- Unity b0 = 0x00800000
- SigmaStudio COM: register with 64-bit RegAsm; values ≥ 0x80000000 convert to signed

---

## OBJ MODEL GENERATION SKILL

**File:** `D:/Projects/Claude/theater/POR/skills/obj-model-generation/SKILL.md`

### Coordinate System
| Axis | Direction |
|------|-----------|
| X | Left → Right (Width) |
| Y | Bottom → Top (Height) |
| Z | Front → Back (0 at back, positive toward front) |

### Face Winding Convention (CCW viewed from outside = outward normal)
| Face | Winding Order |
|------|--------------|
| Front donut | `outer[i], outer[ni], inner[ni], inner[i]` |
| Back donut | `outer[i], inner[i], inner[ni], outer[ni]` (reversed) |
| Front fan tri | `corner, ring[i+1], ring[i]` |
| Back fan tri | `corner, ring[i], ring[i+1]` (reversed) |
| Cylinder wall | `front[i], front[ni], back[ni], back[i]` |
| Box back | `[0,3,2,1]` |
| Box front | `[4,5,6,7]` |

### Circular Cutout Method: Corner Fan (PROVEN WORKING)
- Split baffle at midpoints between holes — each hole gets its own rectangular region
- Fan triangles from 4 region corners to the outer ring quadrants (R=0, T=8, L=16, B=24 for SEG=32)
- OUTER_R = CUTOUT_R + 2" minimum buffer

### What NOT to Use
- Delaunay triangulation — creates spikes/starbursts across holes
- Fan from edge midpoints — overlapping triangles, gaps
- Grid stitching — complex, inconsistent winding

### Vertex Caching
```python
vcache = {}
def v(x, y, z):
    key = (round(x, 4), round(y, 4), round(z, 4))
    if key in vcache:
        return vcache[key]
    verts.append((x * 2.54, y * 2.54, z * 2.54))  # inches to cm
    idx = len(verts)
    vcache[key] = idx
    return idx
```

### Unit Scaling
- OBJ has no inherent units. Scale factor: `x * 2.54` to store in cm for cm-unit importers.

### Materials
- plywood: `Kd 0.55 0.45 0.35`
- baffle: `Kd 0.4 0.35 0.25`
- dark: `Kd 0.1 0.1 0.1`
- grille (transparent): `d 0.30` (30% opaque)

### Debugging
| Symptom | Fix |
|---------|-----|
| Black circles (donut) | Swap inner↔outer in quad |
| Black triangles in fan | Swap ring[i]↔ring[i+1] |
| Gaps at edges | Add edge triangle(corner1, corner2, ring[cardinal]) |
| Overlapping faces | Check quadrant ranges don't overlap |

---

## LAYOUT CONFIG (screenshots/layout_config.json)

### Room
- Width: 17.0 ft (E-W)
- Depth: 23.0 ft (N-S)
- Height: 10.0 ft
- North wall = screen wall; West wall = partition to gym; East wall = exterior

### Screen
- Width: 170 inches (16:9 AT screen)
- Aspect: 16:9
- Offset from north wall: 26 inches

### Sub Cabinet Footprint
- **Width: 24 inches**
- **Depth: 24 inches**
- Drivers per cabinet: 2
- Driver size: 18 inches
- Corners: NW, NE, SW, SE (4 stacked cabinets, 2 per stack = 8 drivers total)

### Stage
- Depth mode: sub_plus_screen
- Sub depth: 24 inches
- Screen depth: 2 inches
- Total stage depth: 26 inches

### Riser
- Front from north: 15.5 ft
- Depth: 5.5 ft
- Inset from walls: 1.0 ft

### Seating
- Couch width: 8.0 ft
- Couch depth: 3.0 ft
- MLP position: 0.75 (of couch depth from front)
- Row 1: in front of nearfield subs
- Row 2: on riser, 1.0 ft setback from riser back

### Nearfield Subs
- Enabled: true (layout shows position; deferred per bass plan decision)
- Depth: 12.5 inches
- Drivers: 4 × 18-inch
- Position: riser_front, facing forward

### LCR (Titan-815LX)
- Width: 19.5 inches
- Depth: 21.5 inches
- Center X offset: 0.0 (centered)
- L/R spread: ±4.9 ft from center
- Setback from north: 0.1 ft

### Surrounds (Volt-10)
- Width: 14.0 inches
- Depth: 9.25 inches
- Front wides: y_mode = midpoint_screen_row1
- Side surrounds: y_mode = row1_mlp
- Surround backs: south wall, x_offset 3.0 ft from walls

### Atmos (Volt-10)
- Size: 14.0 inches
- Spread: ±4.0 ft
- Top front: y_mode = front_wides
- Top rear: y_mode = row2_mlp
- Top middle: disabled

### Equipment Closet
- Size: 4.0 ft × 4.0 ft
- Position: west_outside_NW (gym side, behind NW corner of theater)

### Door
- Wall: east
- Width: 36 inches
- From NE corner: 62 inches
- Swing: into room

### Power Panel
- Wall: east
- From NE corner: 50 inches
- Height: 2.0 ft
