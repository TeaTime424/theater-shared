# Investigation Notes — W0-B Consolidated

## Investigation Verdicts

### 1. NX6000D vs ICEpower 1200AS2
**Date:** 2026-03-13
**Verdict:** ADOPT WITH MODIFICATIONS (ICEpower 1200AS2) — MEDIUM-HIGH confidence
**Actionable conclusions:**
- At 10-20Hz (target range), 1200AS2 matches or beats NX6000D (no infrasonic derating vs 29% derating at 15Hz for NX6000D)
- NX6000D power advantage exists only above 30Hz where system already has 17+ dB boundary gain headroom
- 1200AS2: zero mods, fanless, 240V native, 175W idle (vs ~300-375W for NX6000D), single 240V circuit
- 5 modules (4 active + 1 spare) at $373 each; custom chassis required (rack-mount in equipment closet)
- Total cost: ~$2,125 vs ~$3,894 for NX6000D — saves ~$1,769
- ADAU1452 adopted as sub DSP regardless of amp choice; replaces DSP-408 + miniDSP

### 2. Bass Plan Overkill?
**Date:** 2026-03-13
**Verdict:** ADOPT WITH MODIFICATIONS — MEDIUM confidence
**Actionable conclusions:**
- 8 corner subs (4 locations × 2 drivers) KEPT — delivers ~113 dB at 20Hz, +8 dB over -10 dB target; 4-corner uniformity per Welti/Harman
- Nearfield subs (4 drivers) DEFERRED — value is qualitative/unquantified; space behind Row 1 reserved
- Shakers reduced 16 → 8 (1 per seat) — saves $560, zero performance cost; 1/seat is community standard
- 5 amp modules retained (4 active + 1 spare); add 6th if nearfield built later
- Xmax (28mm) is binding constraint below ~13Hz regardless of driver count

### 3. HVAC Theater Setup (MrCool DIY 12K)
**Date:** 2026-03-13
**Verdict:** ADOPT WITH MODIFICATIONS — MEDIUM-HIGH confidence
**Actionable conclusions:**
- MrCool DIY 5th Gen 12K 230V RETAINED — correct sizing, 23.5 dB(A) silent mode, Quick Connect DIY install
- Mounting location: PARTITION WALL (west wall, 7-8' high, 2-4' from north wall) — NOT behind AT screen
  - Partition wall wins on airflow, serviceability, condensate safety, installation simplicity, lineset length
  - Behind-screen wins only on visual concealment (marginal in functional build) and 1-3 dB noise (imperceptible)
- Pre-cool protocol eliminates noise concern during viewing
- Fake-wall vent engineering NOT required (dropped with partition wall mount)
- Pioneer WYS assessed and REJECTED: R-410A line dead (EPA AIM Act), WYT R-454B unproven, flare install not DIY, worse warranty (5yr vs lifetime)
- Budget gap: Option D allocates $1,800 for HVAC; actual MrCool system ~$2,550 — $750 gap needs update
- 2 dB noise difference between 21.5 and 23.5 dB(A) units is acoustically irrelevant for this theater

### 4. Bidirectional Verification Enforcement
**Date:** 2026-03-20
**Verdict:** ADOPT WITH MODIFICATIONS — MEDIUM confidence
**Actionable conclusions:**
- System addresses real failure mode (confirmation bias in product research) — structurally sound
- Stop hook fires mechanically; [UNVERIFIED] tag is honest degradation over fabricated verification
- Weaknesses: multi-turn context poisoning (unverified specs from exempt turns propagate forward), quality of adversarial search unchecked
- Fix 1: Re-verify any specs from earlier exempt turns at point of purchase/design decision
- Fix 2: Change "when in doubt, tag [UNVERIFIED]" to "when in doubt, run /verify"
- Fix 3: Add edge-case classification examples to Stop hook prompt
- Already implemented in CLAUDE.md (multi-turn re-verification rule, updated [UNVERIFIED] guidance)

---

## DSP Platform Notes

**Platform verdict: APM2 (ADAU1701) — NOT ADAU1452**
- Signal chain: X6800H → APM2 ADC → ADAU1701 → I2S → PCM5102 → ICEpower 1200AS2
- APM2 internal DAC limit: 0.9 Vrms — too low for ICEpower input sensitivity
- PCM5102 DAC path: 2.0 Vrms output → drives ICEpower to ~190W/ch
- ADAU1701: 5.23 fixed-point, biquad order [b0, b1, b2, -a1, -a2]
- Note: ADAU1452 was adopted for sub DSP (per NX6000D vs 1200AS2 investigation); ADAU1701/APM2 is the preamp DSP platform

---

## OBJ Model Generation Skill

**File:** `D:/Projects/Claude/theater/POR/skills/obj-model-generation/SKILL.md`

**Winding convention:**
- Coordinate system: X=width (left→right), Y=height (bottom→top), Z=depth (0 at back, positive toward front)
- CCW winding when viewed from outside; right-hand rule gives outward normal
- Flip winding: `[a,b,c,d]` → `[a,d,c,b]`

**Winding rules (tested/proven):**
| Face | Order |
|------|-------|
| Front donut | `outer[i], outer[ni], inner[ni], inner[i]` |
| Back donut | `outer[i], inner[i], inner[ni], outer[ni]` |
| Front fan tri | `corner, ring[i+1], ring[i]` |
| Back fan tri | `corner, ring[i], ring[i+1]` |
| Cylinder wall | `front[i], front[ni], back[ni], back[i]` |

**Circular cutout method: Corner Fan Method (proven)**
- Split baffle at midpoints between holes — each hole gets rectangular region with 4 corners
- Fan triangles from region corners to outer ring quadrants
- SEG=32 segments; cardinal indices R=0, T=8, L=16, B=24
- OUTER_R = CUTOUT_R + 2" (buffer between cutout and fan origin)
- REJECTED methods: Delaunay triangulation (spikes), fan from edge midpoints (overlaps), grid stitching, quad-strip

**Vertex caching:**
- Dict keyed on `(round(x,4), round(y,4), round(z,4))`
- Scale inches→cm: multiply by 2.54 on write

---

## layout_config.json Extracted Values

**File:** `D:/Projects/Claude/theater/screenshots/layout_config.json`

**Sub cabinet footprint:** 24" × 24" (width_inches: 24, depth_inches: 24), 2 drivers per cabinet, 4 corners (NW, NE, SW, SE)

**Stage dimensions:**
- `depth_mode: "sub_plus_screen"` — stage depth = sub depth (24") + screen depth (2") = 26" total
- Computed from sub_depth_inches: 24 and screen_depth_inches: 2

**Speaker positions:**
| Speaker | Config |
|---------|--------|
| LCR (Titan-815LX) | 19.5"W × 21.5"D, center at x=0, L/R spread ±4.9ft, 0.1ft from north wall |
| Surrounds (Volt-10) | 14"W × 9.25"D |
| — Front wides | y_mode: midpoint between screen and row 1 |
| — Side surrounds | y_mode: row1 to MLP |
| — Surround backs | x_offset 3ft from walls, south wall |
| Atmos (Volt-10) | 14" square |
| — Top front | y_mode: front_wides position |
| — Top rear | y_mode: row2/MLP |
| — Top middle | disabled |

**Seating:**
- Couch: 8.0ft wide × 3.0ft deep, MLP at 75% of couch depth
- Row 1: in front of nearfield subs, riser_front position
- Row 2: on riser, 1.0ft setback from riser back

**Riser:**
- Front edge: 15.5ft from north wall
- Depth: 5.5ft
- Inset 1.0ft from side walls

**Room:** 17.0ft × 23.0ft × 10.0ft
- North = screen wall, West = partition to gym, East = exterior
- Equipment closet: 4ft × 4ft, west/outside NW corner (gym side)
- Door: east wall, 36" wide, 62" from NE corner, swings into room

**Nearfield subs (deferred):**
- depth: 12.5", 4 drivers @ 18", forward-facing at riser front
- width_mode: match_couch (matches 8ft couch width)
