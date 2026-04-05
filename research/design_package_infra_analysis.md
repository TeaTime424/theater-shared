# Design Package DAG Infrastructure Analysis

**Status:** RESEARCH — Internal planning document
**Date:** 2026-03-20
**Task:** #6 — Study existing DAG infrastructure and agent dispatch patterns
**Purpose:** Feed into Task #7 (design-package2 command specification)

---

## Executive Summary

The existing DAG infrastructure covers research/verification workflows well but has structural gaps for the design-package pipeline. Key missing pieces: no `model-builder` or `validate` agent type, no formal decision gate mechanism, no pattern for mid-pipeline investigation spawning, and the 5-agent cap will create wave bottlenecks at the Phase 4 build stage. The dispatcher agent is opus-class and suitable for sub-DAG management, but the design-package pipeline is complex enough that it should manage its own sub-DAG directly rather than delegating to a dispatcher agent.

---

## 1. Task Metadata Schema

### Documented Fields (from CLAUDE.md)

```json
{
  "agent_type": "verify|investigate|research|compare|build|edit",
  "priority":   "high|medium|low",
  "source_task": "ID of spawning task (if follow-up)",
  "product":    "product name (if applicable)",
  "claim":      "specific claim text (if verification)"
}
```

### Agent_type → Dispatch Mapping

| agent_type  | Agent file           | Model  | Has web access | Writes research/ |
|-------------|----------------------|--------|----------------|------------------|
| verify      | agents/verify.md     | sonnet | Yes            | Yes              |
| investigate | agents/investigate.md| sonnet | Yes            | Yes              |
| research    | agents/research.md   | sonnet | Yes            | Yes              |
| compare     | agents/compare.md    | sonnet | Yes            | Yes              |
| build       | agents/build.md      | sonnet | No             | No (writes code) |
| edit        | agents/edit.md       | sonnet | No             | No (edits files) |
| dispatcher  | agents/dispatcher.md | opus   | No             | No               |

The `dispatcher` type appears in the CLAUDE.md agent table but is NOT listed in the metadata schema's `agent_type` enum. This is an inconsistency — dispatcher is a meta-agent, not a task worker.

---

## 2. Blocking / Dependency Mechanics

Tasks use two directional dependency fields:

- `addBlockedBy: [taskId, ...]` — "I cannot start until these finish"
- `addBlocks: [taskId, ...]` — "when I complete, these become unblocked"

The dispatcher loop checks:
1. `status: pending`
2. `blockedBy: []` (all resolved)

If a task's `blockedBy` list contains any non-completed task, it stays pending. The dispatcher does not infer partial unblocking — all dependencies must be complete.

**No conditional blocking exists.** There is no concept of "block on user input" or "block until external condition." This is a gap for decision gates (see Section 5).

---

## 3. Concurrency Constraints

**Hard limit: 5 concurrent agents.**

This is enforced by convention in the dispatcher's rules ("Launch maximum 5 agents in parallel"). There is no technical enforcement in the task system — it is a behavioral rule only.

### Design Package Peak Concurrency Map

Mapping the existing design-package phases to parallel agent loads:

| Phase | Agents Running Simultaneously | Count | Notes |
|-------|-------------------------------|-------|-------|
| Phase 1 (Audit) | Architect + Analyst | 2 | Under limit |
| Phase 2 (Critique) | Critic | 1 | Sequential by design |
| Phase 3 (Decision Gate) | (user wait) | 0 | No agents |
| Phase 4 (Build) | specs.yaml + 6 docs + 4 diagrams + 3 models | 14 | 3× over limit |
| Phase 5 (Verify) | Verifier + Analyst | 2 | Under limit |
| Phase 6 (Report) | (main conv) | 0 | No agents |

**Phase 4 is the problem.** 14 artifacts need to be generated. At 5 concurrent agents max, this requires 3 dispatch waves:
- Wave 1: specs.yaml, 00_index.md, 01_room.md, 02_speakers.md, 03_subs.md (5 agents)
- Wave 2: 04_amplification.md, 05_screen.md, 06_budget.md, diagrams/config.py, d01_floor_plan.py (5 agents)
- Wave 3: d02_signal_flow.py, d03_front_elevation.py, d04_wiring.py, generate_room.py, generate_room_hires.py (5 agents)
- Wave 4: generate_sub_cabinet.py (1 agent)

But there are also hard ordering constraints within Phase 4:
- specs.yaml must complete before any doc or diagram starts (all depend on it)
- diagrams/config.py must complete before any diagram script starts
- generate_room.py before generate_room_hires.py (hires embeds from low-poly)

So the realistic wave structure is:
- Wave 4a: specs.yaml only
- Wave 4b (unblocked): 6 docs + diagrams/config.py (7 total → 2 sub-waves of 5+2)
- Wave 4c (unblocked): 4 diagram scripts + generate_room.py (5 total)
- Wave 4d (unblocked): generate_room_hires.py + generate_sub_cabinet.py (2 total)

**Minimum 5 dispatch rounds for Phase 4 alone.** Under the 5-agent cap, this is manageable but sequential.

---

## 4. How Agents Create Follow-up Tasks

All agents share the same pattern:
1. Agent calls `TaskCreate` with `metadata.agent_type` set to the type needed
2. Agent calls `TaskUpdate` with `addBlocks`/`addBlockedBy` if the new task has ordering constraints relative to existing tasks
3. Agent does NOT dispatch the follow-up — it only creates it
4. The dispatcher or main conversation picks it up in the next drain cycle

**Important:** Follow-up tasks created by agents mid-run are not automatically dispatched. They enter the DAG as pending and wait for the next drain cycle. In a long-running pipeline like design-package, this means investigation triggers found during Phase 1 Audit might not be dispatched until after Phase 5 Verify — or may block Phase 4 Build if wired correctly.

The existing skill doc handles this with "investigation triggers" as inline work (agents do the research themselves inline, writing to `team_test_N/investigation_*.md`). This is NOT the DAG pattern — it is a workaround for the lack of mid-pipeline dispatch. The design-package2 command should replace this with proper DAG tasks.

---

## 5. Decision Gates (User Approval Points)

**There is no formal decision gate mechanism in the current DAG.** The design-package skill calls for a Phase 3 decision gate ("ask: proceed / adjust / stop?") but there is no task type or pattern to represent this.

### Current Gap

The dispatcher loop states: "If all pending tasks are blocked (circular dependency or external blocker), report the blockage clearly." This is close to a gate but not formalized.

### Recommended Pattern for Decision Gates

A decision gate can be represented as a sentinel task with `agent_type: "gate"` (new type) that:
1. Is created as pending, blocking all Phase 4+ tasks
2. The main conversation presents the Phase 3 summary to the user and marks the gate task `in_progress`
3. The main conversation waits for user input
4. On "proceed," marks the gate task `completed`, unblocking Phase 4
5. On "adjust," updates the DAG and loops back
6. On "stop," marks all downstream tasks `deleted`

**This is NOT implementable by an agent.** The main conversation must handle it directly, since agents cannot interact with the user. The gate task is a coordination artifact, not a work item.

For design-package2, Phase 3 should be:
- `agent_type: "gate"` — recognized by dispatcher as "pause, return to main conversation"
- Main conversation renders the summary and waits
- On user approval, dispatcher resumes from next unblocked wave

---

## 6. Agent Model Assignments

| Agent      | Model  | Rationale |
|------------|--------|-----------|
| dispatcher | opus   | DAG orchestration needs planning; opus has stronger multi-step reasoning |
| verify     | sonnet | Verification is structured — web search + table output, sonnet sufficient |
| investigate| sonnet | Forum search + structured output, sonnet sufficient |
| research   | sonnet | Web research + synthesis, sonnet sufficient |
| compare    | sonnet | Structured comparison, sonnet sufficient |
| build      | sonnet | Code generation, file writing — sonnet sufficient |
| edit       | sonnet | Document editing — sonnet sufficient |

**No agent uses haiku.** All production agents are sonnet or opus.

---

## 7. Identified Gaps for Design Package Needs

### Gap 1: No `model-builder` Agent Type

3D OBJ generation is qualitatively different from general `build` tasks:
- Requires reading the OBJ skill doc before every run
- Has mandatory post-generation validation (coordinate checks)
- Consistently produces wrong placement (documented in skill file)
- Needs a different prompt structure

**Recommendation:** Add `agent_type: "model-builder"` with its own agent file that:
- Always reads `POR/skills/obj-model-generation/SKILL.md` first
- Always reads `screenshots/layout_config.json` first
- Always validates door/closet/screen coordinates post-generation
- Flags placement errors as blockers before marking complete

### Gap 2: No `validate` Agent Type

Post-generation validation in Phase 5 is currently done by the "Verifier" within a build run — not a separate agent. The existing `verify` agent is for claim verification (web search), not artifact validation (script execution + coordinate checking).

**Recommendation:** Add `agent_type: "validate"` with its own agent file that:
- Runs Python scripts and captures output
- Reads generated OBJ files and checks coordinates
- Verifies specs.yaml values against source docs
- Reports pass/fail per check, not prose

### Gap 3: Mid-Pipeline Investigation Spawning

The current design-package runs investigations inline (agents doing web research inside the build run). This is fragile — it extends build time, mixes research + build concerns, and the findings are written to investigation_*.md files that aren't tracked in the DAG.

**Recommendation:** Architect and Analyst agents in Phase 1 should create `agent_type: "research"` or `agent_type: "investigate"` tasks for any open questions, and those tasks should block the specific Phase 4 artifacts that depend on their findings. Example: "PCM5102 DAC voltage question" → research task → blocks 04_amplification.md.

### Gap 4: Concurrency at Phase 4

As mapped above, Phase 4 has 14 artifacts across 5+ dispatch waves. This is within the 5-agent limit per wave but requires careful dependency wiring to prevent agents from starting before specs.yaml is complete.

The design-package2 DAG must explicitly wire:
- All doc tasks: `addBlockedBy: [specs_yaml_task_id]`
- All diagram scripts: `addBlockedBy: [specs_yaml_task_id, config_py_task_id]`
- generate_room_hires.py: `addBlockedBy: [generate_room_task_id]`

### Gap 5: No Formal Gate for Phase 3

Described in Section 5. The design-package2 command must include a gate task that explicitly pauses dispatch and returns control to the main conversation.

---

## 8. Dispatcher Agent vs Main Conversation: Sub-DAG Management

### Option A: Dispatcher Agent Manages the Design Package Sub-DAG

The dispatcher agent (opus) is spawned once and manages the entire design-package pipeline:
- It reads the full DAG, dispatches waves, waits for returns, dispatches next wave
- Main conversation is free during the run

**Pros:**
- Main conversation is not blocked during a multi-hour pipeline
- Dispatcher can make sequencing decisions without returning to user
- Opus model is appropriate for complex orchestration

**Cons:**
- Dispatcher cannot interact with user — Phase 3 gate requires user input, which breaks the dispatcher loop
- Dispatcher has no way to pause and return control mid-run
- If the dispatcher hits an error or unexpected state, recovery is complex
- The dispatcher agent itself is a black box — user cannot see intermediate state

### Option B: Main Conversation Manages the Sub-DAG Directly

Main conversation creates all tasks, dispatches each wave, waits for completions, dispatches next wave, and handles Phase 3 gate inline.

**Pros:**
- Full visibility — user can see each wave's dispatch and completion
- Phase 3 gate is natural — main conversation presents summary, waits for user input, continues
- Error handling is transparent — main conversation can explain what failed and why
- Consistent with the CLAUDE.md "main conversation is the planner + dispatcher" principle

**Cons:**
- Main conversation is occupied for the full pipeline duration
- User cannot interrupt with other questions during the run
- Token pressure on main conversation context over a long pipeline

### Recommendation: Option B (Main Conversation) with Dispatcher for Research Sub-DAGs Only

The design-package pipeline has a mandatory user interaction point (Phase 3 gate) that makes full dispatcher delegation impossible without a workaround. The main conversation should manage the top-level phase sequencing.

However, the dispatcher agent is appropriate for managing the follow-up research sub-DAGs that Architect/Analyst spawn in Phase 1. If Phase 1 produces 3 investigation tasks, spawn a dispatcher agent to drain those tasks in parallel while the main conversation manages the top-level phase sequencing.

This hybrid gives:
- Main conversation: phase gate, user interaction, phase sequencing
- Dispatcher sub-agent: draining research/verify/investigate tasks within phases

---

## 9. Summary: What design-package2 Needs

| Need | Current State | Required Addition |
|------|--------------|-------------------|
| model-builder agent type | Not present | New agent file: `agents/model-builder.md` |
| validate agent type | Not present | New agent file: `agents/validate.md` |
| Gate task type | Not present | Convention: `agent_type: "gate"`, handled by main conv |
| Phase 4 dependency wiring | Manual, ad-hoc | Explicit addBlockedBy chains in task creation |
| Investigation triggers as DAG tasks | Inline (not in DAG) | Phase 1 agents create research/investigate tasks |
| Dispatcher for research sub-DAGs | Available | Use for Phase 1 follow-up research only |
| 5-agent concurrency | Enforced by convention | 5+ wave planning for Phase 4 |

---

## Bidirectional Search

- **Searched FOR:** Existing agent files, CLAUDE.md DAG section, design-package skill doc, dispatcher agent doc — all read directly from filesystem
- **Searched AGAINST:** Any hidden agent types not in the agents/ directory (checked via Glob), any dispatcher mechanism in commands/ that handles gates (read design-package.md command file)
- **Contradicting evidence found:** No — the gap analysis is consistent across all files read. The design-package.md command file confirms Phase 3 is described as a simple "ask the user" step with no DAG representation.

---

## Sources

All findings from direct file reads (no web search required — this is infrastructure analysis):

1. `D:/Projects/Claude/theater/CLAUDE.md` — Task DAG protocol, agent types, metadata schema
2. `D:/Projects/Claude/theater/.claude/agents/dispatcher.md` — Dispatcher loop, concurrency rules
3. `D:/Projects/Claude/theater/.claude/agents/verify.md` — Verify agent, follow-up task patterns
4. `D:/Projects/Claude/theater/.claude/agents/research.md` — Research agent, follow-up patterns
5. `D:/Projects/Claude/theater/.claude/agents/compare.md` — Compare agent, pending cell pattern
6. `D:/Projects/Claude/theater/.claude/agents/build.md` — Build agent, no-web constraint
7. `D:/Projects/Claude/theater/.claude/agents/edit.md` — Edit agent, doc-only constraint
8. `D:/Projects/Claude/theater/.claude/agents/investigate.md` — Investigate agent, forum list
9. `D:/Projects/Claude/theater/.claude/skills/design-package.md` — Full pipeline spec, phase structure, known gaps
10. `D:/Projects/Claude/theater/.claude/commands/design-package.md` — Command wrapper
