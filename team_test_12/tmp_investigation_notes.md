# Investigation Notes — Consolidated Reference
**Date:** 2026-03-21
**Source:** Build agent, Task 11

---

## 1. Investigations Index

### 1.1 NX6000D vs ICEpower 1200AS2
**File:** `D:/Projects/Claude/investigations/nx6000d-vs-icepower-1200as2/05_verdict.md`
**Date:** 2026-03-13 (revised same day)
**Verdict:** ADOPT WITH MODIFICATIONS — Confidence: MEDIUM-HIGH

**Key findings:**
- At infrasonic frequencies (15-20 Hz), 1200AS2 equals or exceeds NX6000D (no derating vs NX6000D at 71-88% below 20 Hz)
- NX6000D headline 850W advantage exists only above 30 Hz, where the system already has massive boundary gain headroom
- NX6000D requires 3 mods: fan swap (12 fans), custom trigger box, DSP bypass — 1200AS2 requires zero
- 1200AS2 idle: 175W for 5 units; NX6000D: 300-375W — runs on single 240V circuit vs 2× 120V circuits
- Budget: NX6000D total ~$3,894; ICEpower total ~$2,125 — **delta: -$1,769**

**Actionable:**
- 5× 1200AS2 modules rack-mounted in equipment closet (not plate-mounted in subs)
- ADAU1452 as sub DSP (replaces DSP-408 + miniDSP chain)
- Single 20A/240V circuit for sub amps
- Ensure closet ventilation (175W idle heat)
- Buy 5 modules (4 active + 1 spare) at $373 each

---

### 1.2 Bass Plan Overkill
**File:** `D:/Projects/Claude/investigations/bass-plan-overkill/05_verdict.md`
**Date:** 2026-03-13
**Verdict:** ADOPT WITH MODIFICATIONS — Confidence: MEDIUM

**Key findings:**
- 8-corner-sub array achieves ~113 dB at 20 Hz at MLP — +8 dB above -10 dB Reference target
- 16 shakers → 8 shakers: clear $560 savings, zero performance cost (1/seat is community standard)
- Nearfield value is qualitative and unquantified; nearfield layer is the "overkill" portion
- UMII18-22 Xmax (28 mm) is binding constraint below ~13 Hz — driver count, not amp power

**Actionable (adopted):**
- Shakers reduced 16 → 8 (1 per seat) — immediate $560 savings
- Nearfield deferred — space reserved behind Row 1, build last after validating need
- Keep 8 corner subs in 4 cabinets (2 per corner) — uniformity + headroom justified

---

### 1.3 HVAC Theater Setup
**File:** `D:/Projects/Claude/investigations/hvac-theater-setup/05_verdict.md`
**Date:** 2026-03-13
**Verdict:** ADOPT WITH MODIFICATIONS — Confidence: MEDIUM-HIGH

**Key findings:**
- MrCool DIY 12K at 230V is correctly sized; 9K has short-cycling risk for $30 savings
- 23.5 dB(A) silent mode — AT screen provides ~0.5-2 dB attenuation (not 3-5 dB as claimed)
- Pre-cool protocol dominates noise mitigation regardless of placement
- Fake-wall vent openings require engineering: <300 FPM, acoustic foam lining
- MrCool reliability is a step below Mitsubishi/Fujitsu; $234/yr Care Program (lifetime warranty)
- Budget gap: POR allocates $1,800, actual MrCool system is ~$2,550 (**$750 gap**)

**Supplement — Partition Wall Assessment (08_partition_wall_assessment.md, 2026-03-13):**
- **Partition wall wins 6/10 factors** over behind-screen placement
- Wins: airflow distribution, lineset length, serviceability, condensate safety, installation simplicity, no vent engineering needed
- Behind-screen marginal wins: noise at MLP (~1-3 dB), visual concealment, no speaker wall conflict
- **Recommended:** Mount on partition (west) wall at 7-8' high, 2-4' from north wall (north of FWL)
- Route lineset through gym to partition wall (~10-14' run, within 25' Quick Connect)
- Gravity drain condensate through partition wall to gym side
- Paint unit flat black

**Actionable:**
- Mount MrCool on partition wall (not behind AT screen)
- Update POR/16_HVAC_Plan_Theater.md — remove fake-wall vent engineering requirement
- Budget $2,550 for HVAC (update from $1,800)

---

### 1.4 Bidirectional Verification Enforcement
**File:** `D:/Projects/Claude/investigations/bidirectional-verification-enforcement/05_verdict.md`
**Date:** 2026-03-20
**Verdict:** ADOPT WITH MODIFICATIONS — Confidence: MEDIUM

**Key findings:**
- System addresses real, documented failure mode (one-sided confirmation bias)
- Hook fires structurally on every response — cannot be forgotten
- Multi-turn context poisoning is the strongest surviving objection: unverified specs from exempt turns can propagate as "facts"
- Quality of adversarial search is unchecked by the hook — format checked, not substance
- [UNVERIFIED] tag dilution risk: "when in doubt tag" leads to noise

**Actionable (already merged to CLAUDE.md):**
- Multi-turn re-verification rule added: specs from exempt turns must be re-verified at point of purchase/design use
- [UNVERIFIED] changed from "when in doubt, tag" to "when in doubt, verify — tag only when impractical"
- Edge case examples to be added to Stop hook prompt

---

## 2. DSP Platform Verdict

**DSP Platform: Wondom APM2 (ADAU1701) — NOT ADAU1452 for sub chain**

Note: The investigation verdict (§1.1) adopted ADAU1452 for sub processing. However, subsequent research established the following revised signal chain using the APM2 (ADAU1701) platform with PCM5102 DAC fix:

### Signal Chain
```
X6800H (pre-out, 0.9 Vrms) → APM2 ADC → ADAU1701 DSP → I2S out → PCM5102 DAC → Sonic Imagery 898B → ICEpower 1200AS2
```

**Problem with ADAU1701 internal DAC:**
- Internal DAC max output: **0.9 Vrms** (2.54 Vpp)
- ICEpower 1200AS2 needs 3.61 Vrms for full power (620W @ 8Ω)
- Without fix: amp operates at 6.2% capacity (~38.5W/ch)

**PCM5102 DAC fix:**
- ADAU1701 I2S output feeds PCM5102 external DAC
- PCM5102 output: **2.0 Vrms**
- With 898B gain (+11.79 dB): 2.0 Vrms → ~7.1 Vrms — too high (clips)
- With 898B on 0.9 Vrms input: 0.9 Vrms → **3.5 Vrms** — correct (see §3)

**Note:** The PCM5102 path provides the correct signal level for a gain stage other than the 898B (e.g., DRV134). When using the 898B, the input is the DAC output (0.9 Vrms nominal from internal DAC, or controlled attenuation from PCM5102).

---

## 3. Sonic Imagery 898B — Committed Component

**Status: PURCHASED — Committed component**
**File:** `D:/Projects/Claude/theater/research/verify_sonic_imagery_898b.md`
**Investigation:** `D:/Projects/Claude/theater/research/investigate_sonic_imagery_898b_forums.md`
**Community research:** `D:/Projects/Claude/theater/research/sonic_imagery_898b_community_research.md`

### What It Is
- 8-channel active unbalanced-to-balanced converter (simultaneously bidirectional: also 8-ch bal-to-unbal)
- RCA input (unbalanced), XLR output (balanced)
- 1U rack: 19"W × 1.75"H × 4.8"D
- Active circuitry — no transformers
- 100-240 VAC universal power supply
- Price: $389 direct from manufacturer
- 3-year warranty

### Gain — Creator Confirmed (2026-03-21)
- At 0.9 gain setting: **11.79 dB gain**
- Input: 0.9 Vrms (Denon X6800H pre-out level)
- Output: **3.5 Vrms balanced** (to ICEpower 1200AS2)
- Math: 0.9 × 10^(11.79/20) = 0.9 × 3.88 = 3.50 Vrms ✓
- Manufacturer product page says "approximately 14 dB" — this is imprecise; 11.79 dB is the correct figure for the standard -10 dBV → +4 dBu conversion at 0.9 Vrms input

### Signal Chain with 898B (Updated)
```
X6800H pre-out (0.9 Vrms, RCA unbalanced)
  → 898B unbal-to-bal (+11.79 dB gain)
  → 3.5 Vrms XLR balanced
  → ICEpower 1200AS2 balanced input (JST 6-pin)
  → 620W/ch @ 8Ω
```

The APM2/ADAU1701 DSP chain sits upstream of the X6800H or processes the sub signal before reaching the X6800H pre-out — the 898B is the gain and level-conversion stage directly feeding the power amplifiers.

**Full chain:** X6800H → APM2 ADC → ADAU1701 → I2S → PCM5102 → [signal to X6800H or direct] → 898B → ICEpower 1200AS2

### Key Specs (from datasheet, 898B Rev 0, 2013)
| Parameter | Value |
|-----------|-------|
| Unbal input nominal | -10 dBV (0.316 Vrms) |
| THD+N @ 1 kHz, 600Ω | 0.0006% |
| Noise floor (22 Hz–20 kHz) | better than -101 dBu |
| Headroom (<1% THD+N) | +22.3 dBu (10.1 Vrms) |
| Max output | +23 dBu |
| Bandwidth | DC–165 kHz ±0.2 dB |
| Input impedance | 10 kΩ |
| Output impedance | 50Ω (bal-out), 100Ω (unbal-out) |
| CMRR | >90 dB @ 60 Hz |
| DC offset | ±4 mV typical (unbal→bal) |
| Block diagram | RCA → Low Noise Preamp (+5.8 dB) → Balanced Line Driver (+6 dB) → XLR |

### Noise Budget
- 898B noise floor: -101 dBu = 6.9 µVrms
- ICEpower 1200AS2 output noise: 30 µVrms A-weighted
- 898B noise is ~13 dB below amp's own noise floor — 898B is not the dominant noise source

### Verification Status
- Channel count, I/O types, price: CONFIRMED (manufacturer + ordering page)
- Gain (11.79 dB at 0.9 Vrms input): CONFIRMED by creator communication
- Performance specs: manufacturer claims only — **no independent measurements exist**
- Community coverage: zero forum discussions, zero independent reviews

### Risk
- Functional risk: LOW (simple analog level shifting)
- Performance risk: LOW-MEDIUM (sub duty <120 Hz, far below spec limits)
- Validation risk: HIGH (no independent measurements anywhere)

---

## 4. OBJ Model Generation Skill

**File:** `D:/Projects/Claude/theater/POR/skills/obj-model-generation/SKILL.md`

### Coordinate System
| Axis | Direction |
|------|-----------|
| X | Left → Right (Width) |
| Y | Bottom → Top (Height) |
| Z | Front → Back (0 at back, positive toward front) |

### Winding Convention (CRITICAL)
- Faces viewed from outside: **counter-clockwise (CCW) winding**
- Face normal (right-hand rule) points outward
- To flip winding: `[a, b, c, d]` → `[a, d, c, b]`

| Face | Winding Order |
|------|---------------|
| Front donut | `outer[i], outer[ni], inner[ni], inner[i]` |
| Back donut | `outer[i], inner[i], inner[ni], outer[ni]` (reversed) |
| Front fan tri | `corner, ring[i+1], ring[i]` |
| Back fan tri | `corner, ring[i], ring[i+1]` (reversed) |
| Cylinder wall | `front[i], front[ni], back[ni], back[i]` |

### Circular Cutout Method — Corner Fan (PROVEN WORKING)
- Split baffle at midpoints between holes; each hole gets a rectangular region
- Fan triangles from 4 region corners to the outer ring (SEG=32 segments)
- Cardinal indices (SEG=32): R=0, T=8, L=16, B=24
- `OUTER_R = CUTOUT_R + 2"` — buffer between cutout and fan origin
- Do NOT use: Delaunay triangulation, fan from edge midpoints, grid stitching

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
Round to 4 decimal places; scale by 2.54 for cm import.

### Debugging
| Symptom | Fix |
|---------|-----|
| Black circles (donut) | Swap inner↔outer in quad |
| Black triangles in fan | Swap ring[i]↔ring[i+1] |
| Gaps at edges | Add edge triangles at cardinals |
| Overlapping faces | Check quadrant ranges don't overlap |

---

## 5. Layout Config (layout_config.json)

**File:** `D:/Projects/Claude/theater/screenshots/layout_config.json`

### Room Dimensions
- Width: 17.0 ft (E-W)
- Depth: 23.0 ft (N-S)
- Height: 10.0 ft
- North wall: screen wall; South wall: rear; West wall: partition to gym; East wall: exterior

### Sub Cabinet Footprint
- **Width: 24 inches**
- **Depth: 24 inches**
- 2 drivers per cabinet (18" drivers)
- 4 corners: NW, NE, SW, SE

### Stage
- Depth mode: `sub_plus_screen`
- Sub depth: 24 inches
- Screen depth: 2 inches
- Stage depth = 24 + 2 = **26 inches total**

### Screen
- Width: 170 inches (16:9)
- Type: AT (acoustically transparent)
- Offset from north wall: 26 inches

### LCR (Titan-815LX)
- Width: 19.5 inches, Depth: 21.5 inches
- Center: on centerline (offset 0.0 ft)
- L/R spread: ±4.9 ft from center
- Setback from north wall: 0.1 ft

### Surrounds (Volt-10)
- Width: 14 inches, Depth: 9.25 inches
- Front wides: midpoint between screen and Row 1
- Side surrounds: at Row 1 / MLP height
- Surround backs: south wall, 3 ft inset from east/west

### Atmos (Volt-10)
- Size: 14 inches
- Spread: ±4.0 ft
- Top front: at front wides Y position
- Top rear: at Row 2 MLP Y position
- Top middle: disabled

### Seating
- Couch width: 8.0 ft
- Couch depth: 3.0 ft
- MLP position: 0.75 (75% back of couch)
- Row 1: in front of nearfield sub
- Row 2: on riser, 1.0 ft setback from riser back

### Riser
- Front edge: 15.5 ft from north wall
- Depth: 5.5 ft
- Inset from walls: 1.0 ft

### Nearfield Subs
- Enabled: true (but deferred per bass plan decision)
- Width: match couch (8.0 ft)
- Depth: 12.5 inches
- 4 drivers (18"), position: riser front, facing forward

### Equipment Closet
- Size: 4.0 ft × 4.0 ft
- Position: west side, outside NW corner (gym side)

### Door
- East wall, 36" wide, 62" from NE corner, swings into room

---

## 6. Research Files — Balanced Output / Signal Chain

**`research/Balanced_Output_Stage.md`** (2026-03-17)
- Documents PCM5102 + DRV134 solution for ADAU1701 DAC voltage limitation
- DRV134 alone (+6 dB): 0.9 Vrms → 1.8 Vrms differential → 154W/ch (not full power)
- PCM5102 path: ADAU1701 I2S → PCM5102 (2.0 Vrms) → DRV134 → 4.0 Vrms → 780W/ch (needs -0.9 dB DSP trim)
- **With 898B instead of DRV134:** 0.9 Vrms → 3.5 Vrms (+11.79 dB) → full 620W/ch @ 8Ω

**`research/verify_adau1701_dac_voltage.md`** — confirms ADAU1701 internal DAC output ~0.9 Vrms
**`research/verify_sonic_imagery_898b.md`** — verification of 898B specs (see §3)
**`research/investigate_sonic_imagery_898b_forums.md`** — forum investigation (see §3)
**`research/sonic_imagery_898b_community_research.md`** — community survey: zero independent measurements exist anywhere
**`research/sonic_imagery_labs_deep_investigation.md`** — deep investigation file (exists, not fully read)

---

## 7. Key Numbers Summary

| Parameter | Value |
|-----------|-------|
| Room | 17' × 23' × 10' |
| Sub cabinet footprint | 24" × 24" |
| Screen | 170" 16:9 AT, 26" from north wall |
| Stage depth | 26" (24" sub + 2" screen) |
| Riser front | 15.5 ft from north |
| X6800H pre-out | 0.9 Vrms |
| 898B gain | +11.79 dB |
| 898B output | 3.5 Vrms balanced |
| ICEpower 1200AS2 full power | 620W @ 8Ω (needs 3.61 Vrms) |
| DSP platform | APM2 (ADAU1701), 5.23 fixed-point |
| Biquad order | [b0, b1, b2, -a1, -a2] (a1/a2 negated) |
| Corner subs | 8 drivers / 4 corners (2 per cabinet) |
| Sub amps | 5× ICEpower 1200AS2 (4 active + 1 spare) |
| HVAC | MrCool DIY 12K, partition wall mount, ~23 dB(A) |
