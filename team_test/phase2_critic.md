# Phase 2: Critic Review — Option D Design Package

**Date:** 2026-03-14
**Inputs:** phase1_architect.md, phase1_analyst.md
**Source verification:** Garage_Conversion_Option1.md, ICEpower_1200AS2_Reference.md, ADAU1452_Signal_Chain_Design.md, CLAUDE.md

---

## Critique: Option D Comprehensive Design Package

### Issues Found

| # | Severity | Issue | Location | Recommendation |
|---|----------|-------|----------|----------------|
| 1 | **BLOCKER** | **Projector throw distance fails.** JVC NZ500 throw ratio is 1.4-2.8:1. Screen width = 148" (12.34 ft). Minimum throw = 17.3 ft from screen. Room depth is 23 ft; screen surface is ~3.5 ft from north wall, leaving max projector position at ~19.5 ft from screen. At 19.5 ft: ratio = 1.58 — this WORKS at wide zoom. At Row 2 (~15 ft): ratio = 1.22 — FAILS. Projector must mount behind Row 2, near the rear wall. | Analyst:334, Architect:254 | The Analyst's napkin math was wrong in one direction (claimed it can't fill 170" at all) but RIGHT that it needs verification. At max zoom (1.4:1), minimum throw is 17.3 ft. The projector CAN fill the screen — but only if mounted ~17-19 ft from screen, which means at or behind Row 2 (~18.5 ft from north wall = 15 ft from screen surface). A ceiling mount at 18+ ft from screen surface works. This is tight but feasible. Document the exact mounting position. |
| 2 | **BLOCKER** | **Phase 2 budget: $590 discrepancy confirmed.** GC_Option1.md line 699 shows Phase 2 = $26,155 (sum of line items). Line 1097 shows Option D Phase 2 = $25,565. Delta = $590. The $25,565 figure appears stale — probably from a pre-v3.0 revision before a price change. | GC_Option1.md:699 vs 1097 | The correct Phase 2 total is $26,155 (line items add up). Grand total should be $37,214, not $36,624. Update GC_Option1.md:1097. The Analyst correctly identified this. |
| 3 | **WARNING** | **Analyst's gain staging concern is based on WRONG input sensitivity.** Analyst claims 1200AS2 input sensitivity is "~1V for full output." Actual spec: 5.0 Vp (3.54 Vrms) for full power at 1200W/4 ohm (ICEpower_1200AS2_Reference.md:52). X6800H sub pre-outs are ~2 Vrms. CS42448 DAC output is ~2 Vrms (2.83 Vp). At 8 ohm sub loads, output power scales down but gain is fixed at 25.8 dB. **There is no overdrive risk.** The ADAU1452 can attenuate digitally if needed. | Analyst:378-382, ICEpower_1200AS2_Reference.md:52 | Remove the gain staging BLOCKER flag. The interface is actually well-matched. The real interface concern is balanced vs unbalanced (ADAU1452_Signal_Chain_Design.md:163) — the CS42448 outputs unbalanced, the 1200AS2 expects balanced. This is already documented in research/ with three solutions. |
| 4 | **WARNING** | **170" 16:9 AT screen at $1,000 is unrealistic.** Both the Architect and Analyst flagged this. The cheapest commercially available 170" 16:9 AT screens are $1,500-2,000. A DIY stretch frame with XY Screens or Seymour fabric could hit $1,000 for materials but requires frame fabrication. | GC_Option1.md:579, Analyst:350-351 | Budget should be $1,500-2,000 for the screen itself, plus the existing $500 for shipping/mounting. Total screen line: $2,000-2,500 instead of $1,500. Add $500-1,000 to Phase 2 budget. |
| 5 | **WARNING** | **Architect's document count is excessive for a test exercise.** 14 documents + 10 diagram scripts + 4 Blender models = 28 deliverables. This is a TEST of the team framework, not a production documentation effort. The Senior's suggestion to cut to 11 docs and 4 diagrams is closer to right. | Architect:66-99 | For the test: deliver 6-8 core documents (index, room+electrical, speakers+subs, amps+DSP+signal flow, screen+seating, budget, build sequence). Expand to full tree only if this framework proves useful. |
| 6 | **WARNING** | **Architect found 12 document inconsistencies** between POR docs and Option D. All 12 are real (I spot-checked against GC_Option1.md). But the proposed solution — create 14 new docs — doesn't fix the stale POR docs. Someone finding `06_Electronics_and_Control.md` in POR/ will still see NX6000D and A1H. | Architect:48-59, Analyst:91-99 | The team_test/ package needs a clear "THIS IS THE ACTIVE DESIGN" header. But more importantly, a one-line status note should be added to each stale POR doc: "Superseded by Option D — see team_test/00_index.md." |
| 7 | **MINOR** | **ICEpower module count: Architect says "5 total (3 active + 2 spare)" but budget shows 5 modules with specific assignments.** GC_Option1.md:621-625 lists: #1 corners FL/FR, #2 corners RL/RR, #3 tactile, #4 spare/nearfield, #5 spare. That's 3 active + 2 spare. But 4 corner cabinets at 8 ohm each need 4 amp channels. Two stereo modules (#1 and #2) provide exactly 4 channels. Module #3 drives 8 shakers. This checks out: 3 modules active, 2 spare. | GC_Option1.md:621-625 | Correct as-is. The Analyst's table (line 197) correctly states "5 total." |
| 8 | **MINOR** | **Architect's config.py SCREEN_BOTTOM = 51"** (stage height 27" + ~24" offset). But this isn't documented in GC_Option1.md. The screen bottom height affects viewing geometry and sightline calculations for Row 2. | Architect:349 | Calculate screen bottom from stage height (27") + screen center height preference. For 83" tall screen, bottom at 51" puts top at 134" = 11.2 ft. In a 10 ft (120") room, this doesn't fit. Screen bottom should be ~27" (stage surface) to ~36" (9" above stage). Top at 36+83 = 119" — just fits. Architect's 51" is wrong. |
| 9 | **MINOR** | **Architect states "10x Volt-10 (95 dB, 8 ohm)" for Surr+Atmos+FW** but configuration is 9.4.4 = 9 bed + 4 height = 13 channels. LCR = 3 Titan, remaining = 10 Volt-10. This is correct: 2 FW + 4 surround + 4 height = 10 Volt-10. | Architect:26 | Confirmed correct. |
| 10 | **MINOR** | **Analyst's LCR SPL calculation (item 4) finds "108 dB appears conservative by ~8 dB."** The 108 dB figure at GC_Option1.md:212 likely assumes worst-case all-channels-driven power with no room gain, as the Analyst suspects. This is a conservative methodology, not an error. Conservative SPL estimates are fine for headroom analysis — they set a floor, not a ceiling. | Analyst:312 | Not a real issue. The headroom claim of "+9 to +13 dB" is conservative and safe. |

### Assumptions Tested

| Assumption | Valid? | Evidence |
|-----------|--------|----------|
| JVC NZ500 can fill 170" 16:9 at available throw | YES (barely) | Throw ratio 1.4:1, screen width 12.34 ft, need 17.3 ft minimum. Room allows ~19.5 ft max. Mount must be behind Row 2. |
| 1200AS2 input sensitivity causes overdrive | NO | Actual sensitivity is 5.0 Vp, not 1V. CS42448 outputs ~2.83 Vp. No clipping risk. |
| Phase 2 budget adds to $25,565 | NO | Line items sum to $26,155. $590 discrepancy in GC_Option1.md. |
| $1,000 buys a 170" 16:9 AT screen | UNLIKELY | Market pricing is $1,500-2,000 for this size AT screen unless full DIY frame. |
| Rectangular subs fit in 28" corner clearance | YES | 20" width fits in 28" clearance. Triangular (34" hypotenuse) does not. Architect correctly identified this constraint. |
| Room gain delta (+0.3 dB vs reference) | YES | 10*log10(4160/3910) = 0.27 dB. Analyst verified. |
| Partition wall STC 45-50 | REASONABLE | Standard 2x6 + R-19 + drywall = STC ~45. No resilient channel = no 50. Call it 45. |
| 5 ICEpower modules on 1 20A/240V circuit | YES | 5 modules × 35W idle = 175W. Peak draw is burst, not sustained. 20A × 240V = 4,800W capacity. |

### Scope Check

- **Asked for:** Comprehensive Option D design package in team_test/ (test of team framework)
- **Planned:** 14 documents + 10 diagram scripts + 4 Blender models + dependency graph + open questions
- **Delta:** OVER-SCOPED. The Architect built a production documentation system for a framework test. The deliverable should be 6-8 documents that prove the framework works, with placeholders for expansion.

### Verdict

**PROCEED WITH CHANGES**

The Architect's plan is thorough and the Analyst's baseline is largely accurate with one significant error (gain staging) and one confirmed budget discrepancy. The design itself is sound — the BLOCKER items are documentation/verification issues, not fundamental design flaws.

Required changes before build:
1. Verify projector mounting position (17.3+ ft from screen surface) — this works but must be documented
2. Fix Phase 2 budget to $26,155 (correct the $590 discrepancy)
3. Increase screen budget to $1,500-2,000
4. Fix Architect's config.py SCREEN_BOTTOM (51" puts screen top above ceiling)
5. Reduce scope to 6-8 core documents for the test exercise
6. Remove the gain staging concern — input sensitivity is 5.0 Vp, not 1V

---

### Conflict Resolution: Architect vs Analyst

| Topic | Architect Says | Analyst Says | Verdict |
|-------|---------------|-------------|---------|
| Gain staging | Not flagged as issue | BLOCKER: 1V input sensitivity causes overdrive | **Architect wins (by omission).** Analyst's 1V figure is wrong. Actual is 5.0 Vp. No issue. |
| Screen price | Noted as $1,000 per source | Flagged as "aggressively low" | **Analyst wins.** $1,000 is unrealistic for commercial 170" AT. Budget $1,500-2,000. |
| Phase 2 $590 gap | Not flagged | Flagged as unexplained discrepancy | **Analyst wins.** Line items sum to $26,155, not $25,565. |
| Projector throw | Listed as "needs calculation" | Called potential show-stopper | **Both partially wrong.** It works at 17.3+ ft throw, which is achievable. Neither did the actual math correctly. |
| Document scope | 14 docs + 10 diagrams + 4 models | N/A (Analyst doesn't scope docs) | **Senior's advice wins.** Cut to essentials. |
| ATI power at 6 ohm | States ~300W | Flags as optimistic (~250-280W actual) | **Analyst wins on accuracy.** 300W is marketing math. ~270W is realistic. Impact: ~0.5 dB, immaterial. |

---

## New Grad's Take

### What I'd Change
- **The Architect's Blender model deliverables are scope creep for a test.** But the underlying idea is right — this project needs spatial visualization. Instead of 4 Blender files, use a single Python script that generates a 3D HTML visualization with Plotly. Interactive, zero-install, shareable, done in 2 hours instead of 2 days. The room is boxes. The speakers are spheres. The subs are boxes. That's all you need for spatial reasoning.
- **The Analyst's suggestion to test Audyssey before buying Dirac ($799) is smart.** The build date is 2027. Dirac pricing will change. Audyssey XT32 is already included. Test it. Buy Dirac only if Audyssey measurably fails. Save $500-799 potentially.
- **CamillaDSP on a Pi 5 is still the better long-term play for sub DSP.** The Architect's ADAU1452 plan works, the Senior is right that it's proven, but the SigmaStudio COM dependency is a single-person bus factor. If Andy gets hit by a bus, nobody else can recalibrate the subs. CamillaDSP configs are text files. ADAU1452 configs are binary blobs locked behind a proprietary IDE. For a system that should last 10+ years, portability matters.

### What's Outdated Here
- **The entire discussion of SpeakON connectors ($100 line item).** The ICEpower 1200AS2 uses screw terminals (ICEpower_1200AS2_Reference.md). The NX6000D had SpeakON. This line item is from the old design. Replace with "speaker terminal hardware" or remove.

### Risk I'm Willing to Take
- **Skip the spare ICEpower module.** $373 for shelf insurance when Parts Express ships in 3 days. The money is better spent increasing the screen budget to realistic levels.

### I'll Concede
- The Architect's dependency graph (Phase 0-4 build order) is genuinely useful. Knowing what blocks what prevents wasted effort. This should survive the scope reduction — it's a planning tool, not a deliverable.

---

## Senior's Take

### Keep It Simple
- **The Architect produced a plan for 28 deliverables. This is a test of whether 3 agents can coordinate on a design package.** Ship 6 documents that are correct, cross-referenced, and internally consistent. That proves the framework. 28 deliverables with errors proves nothing except that volume doesn't equal quality.
- **The single most important output is a corrected budget with correct line item totals.** The current GC_Option1.md has two Phase 2 totals that disagree by $590. Fix that one number and you've done more for buildability than 14 new documents.
- **The Analyst's gain staging concern shows why you verify specs before flagging blockers.** "~1V for full output" was pulled from... nowhere in the source docs. The actual spec (5.0 Vp) was sitting in `research/ICEpower_1200AS2_Reference.md:52` and `research/ADAU1452_Signal_Chain_Design.md:171`. The Analyst read 13 documents but missed the one that mattered for the claim being made. Lesson: cite the datasheet, not your memory.

### Contracts & Interfaces
- **The Architect's config.py has SCREEN_BOTTOM = 51" which puts screen top at 134" in a 120" room.** This is the kind of error that cascades — every diagram that references config.py would be wrong. The data structure is right (centralized config), but the initial values need verification. Every dimension in config.py should have a source citation comment.
- **The partition wall cable pass-through spec is the contract that matters most.** How many holes, what size, what height, which cables. Get this wrong and you're drilling through a finished, insulated, drywalled wall. The Analyst flagged this (line 376-377). The Architect included it in 12_wiring_signal_flow.md. Make sure it's specified BEFORE the partition wall goes up — which means it belongs in 01_room_construction.md, not a Phase 3 document.

### Test First
- **Before any new documents are written:** Fix the $590 budget discrepancy in GC_Option1.md. This takes 30 seconds and eliminates the most concrete error found by the Analyst.
- **Before projector is purchased:** Mock the throw distance. Ceiling mount a cardboard box with a laser pointer at 17.5 ft from the screen wall. Verify the image fills the screen width. This is a $0 test that validates a $6,000 purchase.
- **Before the 28-deliverable plan proceeds:** Write ONE complete document (budget or signal flow) end-to-end. Time it. Multiply by 14. If the total exceeds 40 hours, the plan is too ambitious for a framework test.

### Data Design
- **The Architect's `specs.yaml` concept (mentioned by the Senior voice in phase1_architect.md) is the right idea.** A single structured data file that every document references. But don't over-engineer it — a simple JSON with component name, cost, quantity, power draw, and dimensions is sufficient. 50 lines, not 500.

### I'll Concede
- The New Grad's Plotly visualization idea is actually good for this use case. A 3D interactive HTML file of the room layout would be more useful than static 2D diagrams for verifying speaker placement and sub clearances. I wouldn't normally advocate for fancy visualization, but spatial reasoning about a 3D room from 2D floor plans is genuinely error-prone. The config.py SCREEN_BOTTOM error is exhibit A.
