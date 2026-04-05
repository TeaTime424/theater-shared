# Phase 1: Architect Plan — Option D Design Package

**Date:** 2026-03-15
**Scope:** Comprehensive design package for Option D (N-S partition, 17'x23' theater)
**Output directory:** `D:\Projects\Claude\theater\team_test_5\`

---

## 1. Document Tree

### Core Documents (8 files + specs.yaml + index)

| # | File | Purpose | Depends On |
|---|------|---------|------------|
| 1 | `00_index.md` | Master index and navigation for the Option D package | All others (written last) |
| 2 | `01_building_and_room.md` | Building specs, partition wall, space plan, room acoustics, construction scope | specs.yaml |
| 3 | `02_speaker_system.md` | 9.4.4 config, all 13 channels, placement geometry, amplifier matching (X6800H + ATI AT525NC) | 01 |
| 4 | `03_subwoofer_system.md` | 8x corner UMII18-22, cabinet design (UNRESOLVED height), nearfield deferral, ICEpower 1200AS2 amps, ADAU1452 DSP, wiring | 01, specs.yaml |
| 5 | `04_electronics_and_signal.md` | X6800H, ATI AT525NC, Dirac licensing, ADAU1452, signal flow from source to driver, equipment closet | 02, 03 |
| 6 | `05_electrical_and_hvac.md` | 60A feed, circuit plan, MrCool DIY 12K on partition wall, panel load analysis | 01, 04 |
| 7 | `06_construction_and_budget.md` | Phase 1 (building prep) and Phase 2 (theater) budgets, construction sequence, permit plan | All |
| 8 | `07_performance_targets.md` | SPL targets per channel, bass extension, viewing angles, comparison to reference Rev 7.0 | 02, 03 |
| 9 | `specs.yaml` | Machine-readable specifications: room dims, driver T/S params, speaker positions, cable runs, circuit assignments | — (written first) |

### Writing Order (Dependencies)

```
specs.yaml ──→ 01_building_and_room ──→ 02_speaker_system ──→ 04_electronics_and_signal
                     │                                              │
                     └──→ 03_subwoofer_system ─────────────────────┘
                                                                    │
                     05_electrical_and_hvac ←───────────────────────┘
                     06_construction_and_budget ←── all above
                     07_performance_targets ←── 02, 03
                     00_index ←── all above (written last)
```

---

## 2. Diagram List (4 Python-Generated Diagrams)

All diagrams use the existing `intermediates/config.py` + `intermediates/generate_all.py` pattern from the POR diagram system.

| # | Script | Output | Content |
|---|--------|--------|---------|
| 1 | `ff_01_floor_plan.py` | `diagrams/optd_floor_plan.png` | Top-down floor plan: 29'x23' building, N-S partition at 12' from west wall, theater 17'x23' (east), gym 12'x23' (west), equipment closet 4'x4' NW of building (gym side), 36" door east wall 62" from NE corner, panel east wall 50" from NE corner. Screen on north wall, riser, two rows, 4 corner sub cabinets, MrCool head on partition wall. Based on `layout_config.json` positions. |
| 2 | `ff_02_signal_flow.py` | `diagrams/optd_signal_flow.png` | Full signal chain: Sources -> X6800H (Dirac) -> pre-outs (5ch to ATI AT525NC for LCR+FW) + speaker outs (8ch to surrounds/heights) + 4x sub pre-outs -> ADAU1452 (4in/8out) -> 5x ICEpower 1200AS2 -> corner subs / nearfield (deferred) / shakers. Show channel counts and impedances at each node. |
| 3 | `ff_03_sub_cabinet.py` | `diagrams/optd_sub_cabinet_section.png` | Cross-section of corner sub cabinet: 24"x24" footprint (per layout_config.json), show 3 height options (72"/96"/120") with driver positions, internal bracing, OC 703 wrap, sealed construction. Annotate Fc/Qtc/F3 for each height option (calculated from T/S params). |
| 4 | `ff_04_electrical.py` | `diagrams/optd_electrical.png` | Electrical panel one-line diagram: 60A feed (#2 Al 240V), circuits A through F with loads, MrCool 20A/240V, sub amps 20A/240V (single circuit, ICEpower), processor/amps 20A/120V, projector 20A/120V, gym 20A/120V. Show panel capacity and headroom. |

---

## 3. 3D Model Scope (3 OBJ Models)

All models use the proven OBJ generation approach from `POR/skills/obj-model-generation/SKILL.md`: corner-fan method for circular cutouts, vertex caching, 2.54 cm scaling.

| # | Script | Output | Content | Complexity |
|---|--------|--------|---------|------------|
| 1 | `models/room_lowpoly.py` | `models/room_lowpoly.obj` | Low-poly room shell: 17'x23'x10' box, partition wall (west), door opening (east wall), screen plane (north wall), riser box, stage box, 4 corner sub cabinet boxes (no driver detail). Simple box() calls. Materials: walls, floor, ceiling, screen, riser, sub_cabinet. | Low |
| 2 | `models/room_hires.py` | `models/room_hires.obj` | Hi-res room with embedded speakers: same shell as #1 plus 3x Titan-815LX boxes behind screen, 10x Volt-10 boxes at correct wall positions (from layout_config.json), 4x corner sub cabinets with circular driver cutouts (corner-fan method, 2 drivers per cabinet), MrCool head unit rectangle on partition wall. Materials per component type. | Medium |
| 3 | `models/sub_cabinet.py` | `models/sub_cabinet.obj` | Detailed single corner sub cabinet: 24"x24" footprint, parametric height (default 72"), 2x 18" driver cutouts on front face (corner-fan method), internal bracing (horizontal shelf at mid-height), OC 703 wrap layer (offset shell), terminal cup on rear face. Show wiring channel between cabinet halves for rear corner split-build variant. | High |

---

## 4. Inconsistencies Between POR Docs and Option D

### CRITICAL — Must Resolve Before Writing

| # | Issue | POR Says | Option D Says | Correct Value | Source |
|---|-------|----------|---------------|---------------|--------|
| 1 | **DSP board** | ADAU1452 + CS42448 (doc 15) | ADAU1452 (doc GC) | **2x Wondom APM2 (ADAU1701)** — KNOWN CORRECTION | Design-package skill |
| 2 | **Electrical feed** | 100A subpanel (docs 06, 14, 16) | 100A subpanel | **60A feed (#2 Al 240V)** — KNOWN CORRECTION | Design-package skill |
| 3 | **Screen aspect** | 170" 2.35:1 AT (docs 01, 14) | 170" 16:9 AT (Option D section) | **170" 16:9 AT** for Option D, bottom at ~30" AFF. UST projectors OFF the table. | Design-package skill, layout_config.json |
| 4 | **Projector** | $30K flagship TBD (doc 06) | JVC NZ500 $5,999 (Option D) | **JVC NZ500, rear wall ceiling mount at 17.3+ ft from screen** | Design-package skill |
| 5 | **Equipment closet location** | "Northeast corner" (Option D text says NE of gym) | Equipment closet NE of gym | **NW corner of BUILDING** (gym side, left of stage) — KNOWN CORRECTION | Design-package skill |
| 6 | **Theater door** | "East wall" (Option D) | East wall, 62" from NE corner (layout_config.json) | **EAST WALL, 62" from NE corner** — confirmed by layout_config.json | layout_config.json |
| 7 | **Electrical panel** | Not specified in Option D | — | **EAST WALL, 50" from NE corner** | layout_config.json |
| 8 | **Sub cabinet footprint** | Various — POR says 24"x24"x96" triangular | Option D says 20"x20"x72" rectangular | **24"x24" footprint** (layout_config.json). **Height UNRESOLVED** — 72", 96", or 120". | layout_config.json, design-package skill |
| 9 | **Sub amp platform** | NX6000D (docs 03, 06, 14) | ICEpower 1200AS2 (Option D v3.5+) | **ICEpower 1200AS2** for Option D. NX6000D remains POR Rev 7.0 reference. | Investigation verdict |
| 10 | **Sub DSP** | DSP-408 + miniDSP 2x4 HD (docs 06, 14) | ADAU1452 (Option D v3.5+) | **2x Wondom APM2 (ADAU1701)** — KNOWN CORRECTION overrides both | Design-package skill |
| 11 | **Bass shakers** | 16x Aura Pro (docs 03, 04) | 8x Aura Pro (Option D v3.7) | **8x Aura Pro** (1/seat) for Option D. Investigation verdict: reduce from 16. | Bass investigation |
| 12 | **Nearfield subs** | 8x UMII18-22 (doc 03) | Deferred (Option D v3.7) | **Deferred** for Option D. Space reserved. | Bass investigation |
| 13 | **Processor** | Denon AVR-A1H (docs 05, 06, 14) | Denon AVR-X6800H (Option D) | **X6800H** for Option D. A1H remains POR Rev 7.0 reference. | Option D doc |
| 14 | **Speaker config** | 9.4.6 (docs 05, 14) | 9.4.4 (Option D) | **9.4.4** for Option D. | Option D doc |
| 15 | **HVAC head placement** | Partition wall mount (doc 16) | Earlier Option D text says "ceiling cassette" | **Partition wall mount** — HVAC investigation resolved this. | HVAC investigation |
| 16 | **HVAC multi-zone** | Single-zone theater (doc 16) | Earlier Option D text says "2 zones, multi-zone condenser" | **Single-zone** theater only. Gym HVAC deferred. | HVAC investigation, doc 16 |
| 17 | **Room dimensions (Option D theater)** | — | 17'x23'x10' (3,910 cu ft) | Confirmed. HVAC doc 16 uses these dims. | Option D doc, doc 16 |
| 18 | **Marantz AV10 references in doc 15** | Doc 15 references "Marantz AV10" sub outputs | Option D uses X6800H | **X6800H sub outputs** for Option D. Doc 15 was written for Rev 6.0/7.0 reference. | Context |
| 19 | **ICEpower references in doc 15** | Doc 15 references "ICEpower 1200AS2" amp channels | Option D also uses ICEpower | Consistent, but DSP board must be corrected to APM2/ADAU1701. | See #1, #10 |
| 20 | **Pool equipment** | Not mentioned | Not mentioned | **Pentair IntelliFlow VSF on existing 30A/240V breaker** — KNOWN CORRECTION | Design-package skill |

### MODERATE — Document but Non-Blocking

| # | Issue | Notes |
|---|-------|-------|
| A | POR sub enclosure docs (03) describe triangular columns in detail. Option D uses rectangular. | Option D docs must fully specify rectangular cabinet design. Do not inherit triangular specs. |
| B | Budget doc (11) shows $72K reference. Option D is $36.6K OOP / $50K total value. | Separate budget universe. Option D docs must be self-contained. |
| C | POR Volt-10 sensitivity correction (95 dB not 98 dB) is noted in some docs but not all. | Apply 95 dB consistently in Option D package. |
| D | Doc 03 Qts is listed as 0.53. CLAUDE.md says 0.36. Vas listed as 8.77 cu ft in doc 03 vs 15.5 cu ft in CLAUDE.md. | **CRITICAL for sub cabinet calculations.** Must determine which T/S params are correct. See Open Questions #1. |

---

## 5. What Needs Critical Assessment vs What's Settled

### SETTLED — Carry Forward Without Debate

| Item | Status | Source |
|------|--------|--------|
| Room: 17'x23'x10', screen on north wall | Settled | Option D doc, layout_config.json |
| Partition: N-S at 12' from west wall | Settled | Option D doc |
| Speaker config: 9.4.4 with front wides | Settled | Option D doc |
| LCR: 3x Titan-815LX (99 dB, 6 ohm) | Settled | Owned |
| Surrounds/Atmos: 10x Volt-10 (95 dB, 8 ohm) | Settled | Option D doc |
| Processor: X6800H + Dirac bundle | Settled | Option D doc |
| LCR/FW amp: ATI AT525NC (owned, $0) | Settled | Option D doc |
| Sub driver: UMII18-22, 8 corner (2/column) | Settled | Option D doc, bass investigation |
| Sub amp: ICEpower 1200AS2, 5 modules | Settled | NX6000D vs ICEpower investigation |
| Sub wiring: 8 ohm series per column | Settled | Option D doc |
| Nearfield: deferred, space reserved | Settled | Bass investigation |
| Shakers: 8x Aura Pro (1/seat) | Settled | Bass investigation |
| HVAC: MrCool DIY 12K 230V, partition wall mount | Settled | HVAC investigation, doc 16 |
| Projector: JVC NZ500, rear wall ceiling mount | Settled | Option D doc, known correction |
| Screen: 170" 16:9 AT | Settled | Option D doc, layout_config.json |
| Electrical: 60A feed, existing 100A panel | Settled | Known correction |
| Equipment closet: NW corner of building (gym side) | Settled | Known correction |
| Door: east wall, 62" from NE corner | Settled | layout_config.json |
| Panel: east wall, 50" from NE corner | Settled | layout_config.json |

### NEEDS CRITICAL ASSESSMENT

| # | Item | Why | Blocking? |
|---|------|-----|-----------|
| 1 | **Sub cabinet height (72" vs 96" vs 120")** | Footprint is 24"x24" (settled). Height determines volume per driver, which determines Fc/Qtc/F3. Must calculate using correct T/S params. 72" = ~4.5 cu ft/driver, 96" = ~7 cu ft/driver, 120" = ~9.5 cu ft/driver. Trade-off: taller = lower Fc but harder to build/move. | **YES** — blocks doc 03, diagram ff_03, model #3 |
| 2 | **UMII18-22 T/S parameter discrepancy** | Doc 03 says Qts=0.53, Vas=8.77 cu ft. CLAUDE.md says Qts=0.36, Vas=15.5 cu ft. These yield very different cabinet tunings. Must resolve from manufacturer spec sheet before any Fc/Qtc calculation. | **YES** — blocks #1 above |
| 3 | **DSP board: APM2 (ADAU1701) vs ADAU1452** | Known correction says 2x Wondom APM2 (ADAU1701). But doc 15 has detailed ADAU1452 architecture with 4in/8out topology. ADAU1701 is 2in/4out — two boards needed for 4in/8out. Need to confirm which is correct and whether the ADAU1452 topology in doc 15 should be ported to dual ADAU1701. | **YES** — blocks doc 04 signal flow |
| 4 | **Screen bottom height** | Known correction says ~30" AFF. Need to verify this works with projector throw from rear wall ceiling mount at 17.3+ ft. Also affects LCR vertical placement behind screen. | Moderate — blocks diagram ff_01 vertical positioning |
| 5 | **Rear clearance behind Row 2** | Only ~1' behind Row 2 in Option D. Option D doc acknowledges this is tight. Need to decide: reduce stage to 2.5'? Reduce row spacing to 4'? Or accept 1'? | Moderate — affects doc 01 layout |
| 6 | **Equipment closet NW vs NE** | Known correction says NW of building. Option D doc says NE of gym (which IS NW of building since gym is on the west side). Need to confirm these are the same location. | Low — likely resolved by spatial reasoning |

---

## 6. Dependencies — What Must Be Written First

### Tier 1: Foundation (Write First, No Dependencies)

1. **specs.yaml** — All hard numbers: room dimensions, driver T/S params (RESOLVED), speaker positions from layout_config.json, circuit specs, cable runs. Everything else references this.

### Tier 2: Room + Systems (Depends on specs.yaml)

2. **01_building_and_room.md** — Room shell, partition, openings, construction scope
3. **03_subwoofer_system.md** — Cabinet design (BLOCKED until height resolved), amp platform, DSP, wiring

### Tier 3: Electronics (Depends on Tier 2)

4. **02_speaker_system.md** — Speaker placement (depends on room geometry from 01)
5. **04_electronics_and_signal.md** — Signal flow (depends on speaker and sub system definitions)

### Tier 4: Infrastructure (Depends on Tier 3)

6. **05_electrical_and_hvac.md** — Circuit plan (depends on equipment list from 04)

### Tier 5: Integration (Depends on All Above)

7. **06_construction_and_budget.md** — Budget and schedule (depends on all component docs)
8. **07_performance_targets.md** — SPL calculations (depends on speaker + sub specs)
9. **00_index.md** — Navigation (written last)

### Diagram Dependencies

| Diagram | Blocked By |
|---------|------------|
| ff_01_floor_plan | Nothing — can proceed with settled room dims |
| ff_02_signal_flow | DSP board resolution (#3 above) |
| ff_03_sub_cabinet | T/S params (#2) and height decision (#1) |
| ff_04_electrical | Nothing — circuit plan is settled |

### Model Dependencies

| Model | Blocked By |
|-------|------------|
| room_lowpoly | Nothing — room dims settled |
| room_hires | Nothing — speaker positions from layout_config.json |
| sub_cabinet | T/S params (#2) and height decision (#1) |

---

## 7. Open Questions for User

### BLOCKING — Must Answer Before Proceeding

1. **UMII18-22 T/S params: which source is correct?**
   - Doc 03: Qts=0.53, Vas=248.2L (8.77 cu ft), Fs=22Hz
   - CLAUDE.md: Qts=0.36, Vas=15.5 cu ft, Fs=22Hz
   - The Dayton spec sheet (295-718) is the authoritative source. Which values match it? This determines every cabinet calculation.

2. **DSP board: confirm 2x Wondom APM2 (ADAU1701) per known correction, or retain ADAU1452?**
   - The known correction says APM2/ADAU1701. But doc 15 has a full ADAU1452 4in/8out architecture.
   - ADAU1701 is 2in/4out. Two boards = 4in/8out but with separate processing domains.
   - Which is the actual plan? If ADAU1701, do we port the doc 15 topology to dual boards?

3. **Sub cabinet height preference?**
   - 72" (6 ft) — easier to build/move, ~4.5 cu ft/driver
   - 96" (8 ft, floor-to-ceiling with crown) — ~7 cu ft/driver, matches POR concept
   - 120" (10 ft, full floor-to-ceiling) — ~9.5 cu ft/driver, maximum volume
   - Or: should we calculate Fc/Qtc/F3 for all three and let the numbers decide?

### NON-BLOCKING — Can Proceed with Assumptions

4. **Rear clearance behind Row 2:** Accept 1', reduce stage to 2.5', or reduce row spacing to 4'? (Default assumption: accept 1', note as trade-off.)

5. **Equipment closet location confirmation:** "NE corner of gym" = "NW corner of building" — same spot? (Default assumption: yes, they're the same.)

6. **Screen bottom at 30" AFF — does this work with JVC NZ500 throw ratio at 17.3+ ft?** (Can calculate from NZ500 specs, non-blocking.)

---

## New Grad's Take

The document structure looks clean, but I'd flag three things that might bite us:

**First**, the T/S parameter discrepancy is more serious than it looks. Qts=0.53 vs Qts=0.36 is not a rounding difference — it fundamentally changes the sealed alignment. At 0.53, a 7 cu ft box gives Qtc~0.72 (Butterworth, nice). At 0.36, that same box gives Qtc~0.49 (massively overdamped, rolling off early). If the real Qts is 0.36, you need much smaller boxes to get a reasonable Qtc, which actually makes the 72" height more attractive. We absolutely cannot proceed with cabinet design until this is nailed down.

**Second**, I'm concerned about the DSP board correction. The ADAU1452 architecture in doc 15 is beautifully designed — 4in/8out with internal summing for nearfield and tactile derived channels. Splitting this across two ADAU1701 boards means we lose the ability to sum front L+R inside a single DSP for the front nearfield channel. We'd need external summing or a different topology. This isn't just a drop-in replacement.

**Third**, the 3D models might be premature. If the sub cabinet height is unresolved, model #3 (detailed sub cabinet) can't be finalized. I'd suggest making it parametric — take height as an input argument — so it can be regenerated once the decision is made. Same for model #2 (hi-res room) which embeds the sub cabinets.

## Senior's Take

The architect plan is solid. The document tree is appropriately scoped — 8 docs is right for this complexity level. More would be fragmentation, fewer would be walls of text. Good instinct on specs.yaml as the single source of truth; that eliminates the inconsistency plague that's already infected the POR docs.

Three concerns:

**The T/S parameter issue is a known problem.** Doc 03 lists Qts=0.53 which is the standard dual-voice-coil-in-series value from the Dayton spec sheet. The CLAUDE.md value of Qts=0.36 is likely Qes (the electrical Q), which is a common copy-paste error. Vas=15.5 cu ft in CLAUDE.md is also suspicious — the spec sheet says 248.2L which is 8.77 cu ft. I'd bet the doc 03 values are correct, but verify against the PDF before assuming.

**On the DSP correction:** The ADAU1701 (APM2) is what Andy currently has on his bench and has been testing with. The ADAU1452 is a future purchase that hasn't been ordered. The "known correction" likely reflects current reality (what's in hand) vs planned architecture (what's designed but not built). The design package should document both: current-hardware capability (2x ADAU1701) and target architecture (ADAU1452 when purchased). Don't force a choice — document the migration path.

**Budget accuracy matters.** The Option D doc has been through 7 versions and budget numbers have shifted significantly. The design package must freeze a single budget snapshot with every line item traceable to a specific product at a specific price. No ranges, no "~", no "estimated." If a price is unknown, say "TBD" with an estimated placeholder clearly marked. The current POR budget docs are a mess of overlapping revisions — don't inherit that pattern.

One more thing: the diagram list should include a 5th diagram — **speaker placement polar view** showing all 13 channels from the MLP with angular positions annotated. This is the single most useful diagram for validating the 9.4.4 layout against Dolby's placement recommendations, and it's cheap to generate.

---

**Document Version:** 1.0
**Author:** Architect Agent
**Date:** 2026-03-15
