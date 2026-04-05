# Investigation Notes — Consolidated Reference
# Generated for: Option D Design Package (task #2)
# Date: 2026-03-20

---

## INVESTIGATIONS SUMMARY

### 1. NX6000D vs ICEpower 1200AS2 + ADAU1452
- **Date:** 2026-03-13
- **Verdict:** ADOPT WITH MODIFICATIONS — Confidence: MEDIUM-HIGH
- **File:** `investigations/nx6000d-vs-icepower-1200as2/05_verdict.md`

**Actionable conclusions:**
- Replace 5× NX6000D with 5× ICEpower 1200AS2 (4 active + 1 spare) at $373 each = $1,865
- NX6000D advantage exists only above 30Hz. Below 20Hz, 1200AS2 equals or exceeds due to no infrasonic derating.
  - At 15Hz: NX6000D ~600W vs 1200AS2 620W — 1200AS2 wins
  - At 10Hz: NX6000D ~500W vs 1200AS2 620W — 1200AS2 +24%
- 1200AS2 requires zero modifications (no fan swap, no trigger mod, no DSP bypass)
- NX6000D requires: 12 fan swaps (Noctua), custom 12V trigger box, DSP bypass configuration
- 1200AS2 draws 175W idle vs NX6000D ~300-375W idle (5 units); runs on single 240V circuit
- Total savings: ~$1,769 vs NX6000D plan
- Rack-mount in equipment closet, NOT plate-mounted in sub enclosures
- ADAU1452 adopted as sub DSP regardless of amp choice; replaces DSP-408 + miniDSP combo
- Budget: 5× $373 = $1,865 + ~$200 chassis = ~$2,065 (vs $3,894 for NX6000D path)

---

### 2. Bass Plan Overkill?
- **Date:** 2026-03-13
- **Verdict:** ADOPT WITH MODIFICATIONS — Confidence: MEDIUM
- **File:** `investigations/bass-plan-overkill/05_verdict.md`

**Actionable conclusions:**
- Keep 8 corner subs (4 cabinets × 2 drivers) — achieves 113 dB at 20Hz (+8 dB above -10 dB ref target)
- Reduce shakers from 16 to 8 (1 per seat) — saves $560, zero performance cost; this is community standard
- Defer nearfield subs (4× UMII18-22 behind Row 1) — do NOT eliminate; build LAST after evaluating corners
  - Nearfield space behind Row 1 is reserved in layout
  - 4 drivers + cabinet = ~$1,600 deferred
- Keep 5 amp modules (4 active corners + shakers, 1 spare)
- 4-corner array (Welti/Harman data) is the foundation — reducing below 4 locations hurts uniformity
- 2 UMII18-22 drivers already owned ($700 sunk cost) — biases toward using them
- Xmax (28mm) is binding constraint below ~13Hz, not amplifier power

---

### 3. Theater HVAC Setup
- **Date:** 2026-03-13
- **Verdict:** ADOPT WITH MODIFICATIONS — Confidence: MEDIUM-HIGH
- **File:** `investigations/hvac-theater-setup/05_verdict.md`

**Actionable conclusions:**
- MrCool DIY 5th Gen 12K 230V is the correct unit — retained as POR selection
- ADOPTED: Partition wall (west wall) mount at 7-8' high, 2-4' from north (screen) wall
  - Wins on: airflow distribution, serviceability, condensate safety, lineset length, installation simplicity
  - Noise penalty vs behind-screen: only 1-3 dB(A) at silent mode — irrelevant with pre-cool protocol
  - Paint flat black to match theater walls
- REJECTED: Behind AT screen mounting (engineering complexity, condensate risk, poor serviceability)
- REJECTED: Pioneer WYS (end-of-life R-410A; WYT R-454B unproven; not DIY-friendly; no Quick Connect)
- REJECTED: Ducted mini-split (costs same or more, requires contractor, marginal noise benefit negated by pre-cool)
- Pre-cool protocol: run hard before movie → silent/off during playback; unit is effectively inaudible at MLP
- Noise: 23.5 dB(A) silent mode; both MrCool and Pioneer are at/below NC-20 room floor; 2 dB diff irrelevant
- Budget gap: Option D allocates $1,800 for HVAC; actual system is ~$2,550 — $750 gap needs addressing
- Lineset route: outdoor condenser (north exterior wall) → through gym ceiling → penetrate partition wall → head unit; ~10-14' total, within 25' Quick Connect limit
- Seal partition wall penetration with acoustic putty + wall sleeve

---

### 4. Bidirectional Verification Enforcement
- **Date:** 2026-03-20
- **Verdict:** ADOPT WITH MODIFICATIONS — Confidence: MEDIUM
- **File:** `investigations/bidirectional-verification-enforcement/05_verdict.md`

**Actionable conclusions (applies to project process, not hardware):**
- System (CLAUDE.md rule + Haiku Stop hook) is structurally sound for its core purpose
- Gaps that survived adversarial testing:
  1. Multi-turn context poisoning — specs from exempt early turns contaminate later decisions
  2. Checkbox compliance — superficial adversarial search passes format check
  3. [UNVERIFIED] tag dilution from "when in doubt, tag it" guidance
- Fix #1: Added to CLAUDE.md — when referencing specs from earlier exempt turns for purchase/design decision, re-verify at point of use
- Fix #2: Change [UNVERIFIED] guidance to "when in doubt, verify — use [UNVERIFIED] only when impractical"
- Fix #3: Add edge case classification examples to Stop hook prompt
- No budget or hardware impact

---

## DSP PLATFORM — CRITICAL NOTE

**Platform: APM2 (ADAU1701) — NOT ADAU1452 for sub processing.**

**Signal chain:**
```
X6800H analog out → APM2 ADC (ADAU1701) → ADAU1701 processing → I2S → PCM5102 DAC → ICEpower 1200AS2
```

**Internal ADAU1701 DAC limitation:**
- ADAU1701 internal DAC: 0.9 Vrms max — too low to drive ICEpower 1200AS2 to rated output
- Fix: Use PCM5102 external DAC board (I2S output from ADAU1701 → PCM5102 → analog out)
- PCM5102 output: 2.0 Vrms → drives ICEpower 1200AS2 to ~190W/ch into 8Ω
- ADAU1701 fixed-point: 5.23 format
- Biquad order: [b0, b1, b2, -a1, -a2] — a1/a2 NEGATED vs scipy (both ADAU1701 and ADAU1452)

**Note:** Investigation verdict (Section 1 above) references ADAU1452 for sub DSP. The actual build uses ADAU1701 via APM2 platform with PCM5102 DAC fix. The ADAU1452 investigation verdict documents the rationale for the platform selection direction, but ADAU1701/APM2 is the implemented platform.

---

## OBJ MODEL GENERATION — SKILL SUMMARY

**Source:** `D:/Projects/Claude/theater/POR/skills/obj-model-generation/SKILL.md`

### Coordinate System
- X: Left → Right (Width)
- Y: Bottom → Top (Height)
- Z: Front → Back (0 at back, positive toward front)

### Face Winding Convention (CCW from outside = outward normal)
| Face | Winding Order |
|------|---------------|
| Front donut | `outer[i], outer[ni], inner[ni], inner[i]` |
| Back donut | `outer[i], inner[i], inner[ni], outer[ni]` (reversed) |
| Front fan tri | `corner, ring[i+1], ring[i]` |
| Back fan tri | `corner, ring[i], ring[i+1]` (reversed) |
| Cylinder wall | `front[i], front[ni], back[ni], back[i]` |

**To flip winding:** `[a, b, c, d]` → `[a, d, c, b]`

### Circular Cutout Method: Corner Fan (PROVEN)
- Split baffle at midpoints between holes — each hole gets rectangular region with 4 corners
- Fan triangles from region corners to outer ring quadrants
- Cardinal indices for SEG=32: R=0 (0°), T=8 (90°), L=16 (180°), B=24 (270°)
- OUTER_R = CUTOUT_R + 2" (buffer between cutout edge and fan origin)
- Donut: outer ring + inner ring, one quad per segment

### Failed approaches (do not use):
- Delaunay triangulation — creates spikes/starbursts
- Fan from edge midpoints — overlapping triangles, gaps
- Grid stitching — inconsistent winding

### Vertex Caching
```python
vcache = {}
def v(x, y, z):
    key = (round(x, 4), round(y, 4), round(z, 4))
    if key in vcache: return vcache[key]
    verts.append((x * 2.54, y * 2.54, z * 2.54))  # inches → cm
    idx = len(verts)
    vcache[key] = idx
    return idx
```

### Unit Scaling
- OBJ has no inherent units — scale by 2.54 for inch→cm import
- Write: `f"v {x*2.54:.4f} {y*2.54:.4f} {z*2.54:.4f}\n"`

### Materials
- `plywood`: Kd 0.55 0.45 0.35
- `baffle`: Kd 0.4 0.35 0.25
- `dark`: Kd 0.1 0.1 0.1
- `grille`: Kd 0.15 0.15 0.18, d 0.30, Tr 0.70

---

## LAYOUT CONFIG — KEY DIMENSIONS

**Source:** `D:/Projects/Claude/theater/screenshots/layout_config.json`

### Room
- Width: 17.0 ft (E-W)
- Depth: 23.0 ft (N-S)
- Height: 10.0 ft
- North wall = screen wall; South wall = rear; West wall = partition to gym; East wall = exterior

### Sub Cabinets (Corner Subs)
- **Width: 24 inches**
- **Depth: 24 inches**
- 2 drivers per cabinet (18" UMII18-22)
- Corners: NW, NE, SW, SE (all 4 corners)

### Stage
- Depth mode: sub_plus_screen
- Sub depth: 24 inches
- Screen depth: 2 inches
- Total stage depth: 26 inches (~2.17 ft) from north wall

### Screen
- Width: 170 inches (16:9 AT screen)
- Offset from north wall: 26 inches
- Type: AT (acoustically transparent)

### LCR Speakers (Titan-815LX)
- Cabinet: 19.5" wide × 21.5" deep
- Center X offset: 0.0 (centered on room)
- L/R spread: 4.9 ft from center
- Setback from north wall: 0.1 ft

### Surrounds (Volt-10, all)
- Cabinet: 14.0" wide × 9.25" deep
- Front wides: Y position = midpoint between screen and row 1
- Side surrounds: Y position = between row 1 and MLP
- Surround backs: on south wall, 3.0 ft from east/west walls

### Atmos (Volt-10)
- Size: 14.0 inches
- Spread: 4.0 ft from center
- Top front: Y aligned with front wides
- Top rear: Y aligned between row 2 and MLP

### Seating
- Couch width: 8.0 ft
- Couch depth: 3.0 ft
- MLP position: 0.75 (75% toward back of couch)
- Row 1: in front of nearfield sub position
- Row 2: on riser, 1.0 ft setback from riser back wall

### Riser
- Front from north wall: 15.5 ft
- Depth: 5.5 ft
- Inset from side walls: 1.0 ft

### Nearfield Subs (deferred per bass plan verdict)
- Depth: 12.5 inches
- 4 drivers (18"), facing forward
- Position: riser_front (in front of riser)
- Width: match_couch (8 ft)

### Equipment Closet
- Size: 4 ft × 4 ft
- Position: gym side, NW corner (outside partition wall)

### Door
- Wall: east
- Width: 36 inches
- Offset from NE corner: 62 inches
- Swing: into room

### Power Panel
- Wall: east
- Offset from NE corner: 50 inches
- Height: 2.0 ft
