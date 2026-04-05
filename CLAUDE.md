# Home Theater Project — Reference System Design

## Execution Model: Task DAG (MANDATORY)

**Every user prompt MUST be executed as a task DAG. There are no exceptions.**

The main conversation is a **planner + dispatcher**. It NEVER performs research, verification, investigation, comparison, or code implementation directly. All work is done by specialist agents pulling from the task DAG.

### Prompt Handling Protocol

When a user prompt arrives:

1. **Decompose** — break the prompt into discrete tasks. Each task must be:
   - Atomic (one clear deliverable)
   - Tagged with `metadata.agent_type` (verify | investigate | research | compare | build | edit)
   - Wired with `addBlocks`/`addBlockedBy` if there are dependencies
   - Assigned `metadata.priority` (high | medium | low)

2. **Create the DAG** — use TaskCreate for every task. Present the DAG to the user as a table:
   ```
   | ID | Task | Agent | Blocked By | Priority |
   ```

3. **Dispatch** — for all unblocked tasks, spawn the matching agent from `.claude/agents/`:
   - Launch independent tasks in PARALLEL (single message, multiple Agent calls)
   - Maximum 5 concurrent agents
   - Each agent gets: task ID, full description, instruction to call TaskGet/TaskUpdate

4. **Drain** — when agents return:
   - Check TaskList for new tasks created by agents (follow-up work)
   - Check for newly unblocked tasks (dependencies resolved)
   - Dispatch the next wave
   - Repeat until DAG is fully drained

5. **Synthesize** — when all tasks are completed:
   - Summarize results to the user
   - Report any tasks that were blocked or failed
   - List research files written

### What the main conversation MUST NOT do:
- WebSearch or WebFetch directly
- Write to `research/` directly
- Verify claims directly
- Investigate forums directly
- Compare products directly
- Skip the DAG for "simple" questions (decompose them anyway — a 1-task DAG is fine)

### What the main conversation DOES:
- Plan and decompose prompts into tasks
- Create and wire the task DAG
- Dispatch agents
- Read agent results and synthesize for the user
- Answer direct questions about existing project state (reading files is OK)
- Edit files when instructed (code changes, doc updates)

### Dispatcher-Level Operations (no agent required)

The following are meta-operations that maintain the orchestration system itself. They execute directly in the main conversation without a task or agent, because they are planner/dispatcher housekeeping — not project work.

- **Memory management** — writing/updating `MEMORY.md` and memory files in `~/.claude/projects/*/memory/`
- **Session debugging** — reading other sessions' task DAGs, conversation logs, subagent output
- **CLAUDE.md edits** — updating the execution model, agent definitions, or project config
- **Settings changes** — editing `.claude/settings.local.json`, hooks, permissions
- **Git operations** — committing, pushing (when user asks)
- **Task DAG maintenance** — creating/wiring/updating tasks, checking TaskList between dispatch waves
- **Quick file reads** — reading existing files to answer direct questions or inform planning

**Decision rationale (2026-03-20):** Routing 10-second housekeeping operations through the full agent pipeline adds overhead without value. The DAG exists to enforce rigor on substantive work (research, verification, investigation, comparison, building). Dispatcher-level ops are the planner maintaining its own state — they don't benefit from specialist agents or bidirectional search.

### Agent Types (`.claude/agents/`)

| Agent | Role | Creates follow-up tasks for |
|-------|------|-----------------------------|
| `verify` | Cross-reference claims, 3+ sources, bidirectional search | investigate, compare, research |
| `investigate` | Forum deep-dive, adversarial Pro/Con | verify, compare |
| `research` | Broad web research + synthesis | verify, investigate, compare |
| `compare` | Product/option head-to-head | verify, investigate |
| `dispatcher` | DAG scheduler (used for complex multi-wave workflows) | all types |

### Task Metadata Schema

```json
{
  "agent_type": "verify|investigate|research|compare|build|edit",
  "priority": "high|medium|low",
  "source_task": "ID of task that spawned this one (if follow-up)",
  "product": "product name (if applicable)",
  "claim": "specific claim text (if verification)"
}
```

### Single-task prompts

Even simple prompts get a 1-task DAG. Example: "what's the sub amp budget?" becomes:
- TaskCreate: "Calculate sub amplifier budget from POR docs" → agent_type: research → dispatch → return

This is not overhead — it's consistency. The DAG is the execution model. Period.

---

## Project Overview
- **Configuration:** 9.4.6 Dolby Atmos + 8× corner subwoofer array + tactile (nearfield deferred)
- **Room:** 17' × 23' × 10' (3,910 cu ft) — Option D N-S partition layout
- **Screen:** 170" 16:9 AT screen on 17' north wall
- **Budget:** ~$36,600 out-of-pocket (with bass deferral)
- **Build:** 2027
- **Goal:** -10 dB Reference (95 dB all channels) with weapons-grade bass

## File Structure
- `POR/` — Plan of Record design documents (the current accepted design, Rev 7.0)
- `research/` — Research assessments, comparisons, alternatives (not yet adopted)
- `experiments/` — Experimental designs and prototypes
- `tools/` — Audio test pipeline, DSP control pipeline

## Current Design: Option D (March 2026)

Option D is the active design direction. POR Rev 7.0 docs remain as reference but Option D supersedes.

### Room Layout (Option D)
- **N-S partition:** 17'×23' theater (east) + 12'×23' gym (west)
- **Equipment closet:** 4'×4' in NE corner of gym, cables through partition
- **HVAC:** MrCool DIY 12K on partition wall, painted flat black (~23 dB(A))

### Speakers
- **LCR:** 3× DIYSG Titan-815LX (99 dB, 6Ω nominal, 4.2Ω min) — ported, line panels don't stuff
- **Surrounds:** 4× DIYSG Volt-10 (95 dB, 8Ω) — coaxial point source
- **Atmos:** 6× DIYSG Volt-10 (95 dB, 8Ω) — coaxial point source
- All 10 surround/Atmos are identical Volt-10 for timbral matching

### Processor & Speaker Amplification
- **Denon AVR-X6800H** — 11.4ch processing + internal amplification
- ATI AT525NC for LCR + front wides
- Dirac Live Full + Bass Control + ART
- All channels hit 95 dB target with headroom

### Subwoofer System ("Weapons-Grade Bass")
- **Corner subs:** 8× Dayton UMII18-22 in 4 stacked rectangular cabinets (24"×24"×72"), sealed, 8Ω series wiring — front pair doubles as screen wall structure
- **Nearfield subs:** 4× UMII18-22 forward-facing behind Row 1 *(deferred — add post-build)*
- **Tactile:** 8× Aura Pro AST-2B-4 bass shakers, 8 per couch *(reduced from 16)*
- **Sub amps:** 5× ICEpower 1200AS2 (240V, fanless, no infrasonic derating)
- **Sub DSP:** ADAU1452 (8.24 fixed-point, full sub-20Hz capability)

### Electrical
- Dedicated 100A subpanel, 240V for sub amplification
- ICEpower 1200AS2 on single 240V circuit (fanless, no mods needed)

### Key Technical Notes
- **Titan-815LX:** 6Ω nominal (not 8Ω); ported enclosure — line panels, don't stuff
- **Volt-10 sensitivity:** 95 dB per DIYSG spec (earlier docs incorrectly stated 98 dB)
- **UMII18-22 impedance:** Only 2Ω and 8Ω practical with dual 2Ω VCs; 4Ω impossible with 4 VCs
- **ICEpower 1200AS2:** No infrasonic derating (unlike NX6000D which drops to ~500-700W at 15Hz)
- **ADAU1452:** Full sub-20Hz filtering capability; replaces DSP-408 + miniDSP chain
- **Sealed sub design:** Room gain compensates natural rolloff; easier to EQ without sacrificing headroom
- **Corner loading:** +11 dB boundary gain + ~+6 dB acoustic summing from 4 corners
- **Driver excursion limits:** Xmax (28mm) is binding constraint below ~13Hz, not amplifier power

## Revision History (Key Milestones)
| Rev | Date | Change |
|-----|------|--------|
| 5.0 | Nov 2024 | Atmos upgraded to Volt-10 |
| 5.5 | Dec 2024 | PURIFI → NX6000D; Crowsons removed |
| 5.8 | Dec 2024 | "Weapons-Grade": 16× UMII18-22 |
| 5.9 | Dec 2024 | Triangular corner columns |
| 6.0 | Feb 2025 | ICEpower 1200AS2 platform, 240V subpanel |
| 7.0 | Mar 2026 | AVR-A1H replaces AV10+Buckeye; all Volt-10 surrounds; -10 dB target |
| **Option D** | **Mar 2026** | **N-S partition 17'×23'; ICEpower+ADAU1452; stacked rect subs; 170" 16:9; bass deferral; ~$36.6K** |

## File Operations Rules
- When writing .md files: generate via Python script, write directly to disk
- When reading files: only load what's needed, summarize don't dump
- When researching: fetch/filter/synthesize, return summary only
- Prefer head/tail reads over full file loads for structure checks
- All research outputs go to `research/` with clear status (RESEARCH vs POR)
- POR files are the source of truth; consolidated docs may lag

## Diagram Generation System
Build diagrams use individual Python scripts, one per diagram:
- `intermediates/config.py` — shared configuration values
- `intermediates/generate_all.py` — master script to run all generators
- `intermediates/ff_XX_name.py` — individual diagram scripts
- Output: `diagrams/` directory (PNG files)
- Run: `python generate_all.py` (all) or `python generate_all.py ff_01 ff_04` (specific)
- Each script imports `from config import *` and defines a `create_*()` function

## 3D Modeling (OBJ Format)
- Python-generated OBJ files with Delaunay triangulation
- Centroid-based hole filtering for driver cutouts
- Automatic winding verification via cross-product normals
- Skill documented at `POR/skills/obj-model-generation/SKILL.md`

## Audio Test Pipeline (`tools/audio/`)
- **CLI:** `python -m tools.audio <command>` from project root
  - `devices` — list WASAPI audio devices
  - `test <profile>` — capture + analyze + dashboard
  - `analyze <file.wav>` — analyze existing WAV
  - `pattern <profile>` — print Strudel pattern
- **Config:** `tools/audio/config.json`
- **Output:** `tools/audio/output/` — WAV, PNG dashboards, JSON results

## DSP Control Pipeline (`tools/dsp/`)
- **Purpose:** Autonomous measurement & EQ correction for ADAU1701 and ADAU1452
- **Transport:** PC → COM → SigmaStudio → USBi/ICP5 → I2C/SPI → DSP
- **CLI:** `python -m tools.dsp [--config CONFIG] <command>` from project root
  - `ping` — check connectivity
  - `status` — show DSP config
  - `bypass <channel>` — flat response
  - `write-eq <channel> --freq F --gain G --q Q` — single PEQ filter
  - `correct <channel>` — autonomous correction loop
- **REW Integration:** REST API at `http://127.0.0.1:4735` (start REW with `-api` flag)

### Critical DSP Notes
- **Both ADAU1701 and ADAU1452:** Biquad order `[b0, b1, b2, -a1, -a2]` — a1/a2 NEGATED vs scipy
- **ADAU1452:** 8.24 fixed-point, safeload target = `actual_address - 1`, max 5 params per safeload write
- **ADAU1701:** 5.23 fixed-point, direct register writes OK, unity b0 = 0x00800000
- **SigmaStudio COM:** Must register with 64-bit RegAsm; values ≥ 0x80000000 convert to signed
- **Wondom APM3 analog bypass flaw:** Connect RCA directly to APM2 J3 header pins

## Document Conventions
- Research docs: status header (RESEARCH — Not adopted / ADOPTED — Merged to POR)
- POR docs: revision tracked, dated, with change summary
- Comparisons: always include cost, performance, integration, and trade-off analysis
- Use tables for specs, prose for rationale
