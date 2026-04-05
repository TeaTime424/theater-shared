---
name: team
description: Run the full agent team (Architect, Critic, Builder, Verifier, Analyst + New Grad & Senior advisors) on a goal
---

Run the full agent team on the following goal: $ARGUMENTS

Follow this procedure exactly. All agent role definitions are in `.claude/skills/agent-*.md` — read each before prompting that agent.

## The Team

**Functional roles** (one per phase):
- **Architect** — designs the plan
- **Critic** — finds problems in the plan
- **Builder** — implements the plan
- **Verifier** — confirms the implementation works
- **Analyst** — quantifies cost/performance/tradeoff impact

**Advisory voices** (present in EVERY phase):
- **New Grad** — pushes for modern approaches, challenges old patterns, takes risks
- **Senior** — pushes for simplicity, clear contracts, test-first, data-oriented design
- **Acton** (Mike Acton) — data-oriented BS detector. "What is the data? What is the problem? Show me the transform." Kills abstraction for abstraction's sake.
- **Bass Head** — low-frequency advocate. Pushes for more extension, more headroom, more Xmax. Measures in dB below 20 Hz.
- **Cost Cutter** — value engineering voice. Challenges every line item. Knows what matters and what's vanity spend.

All advisory voices are not separate agents — they are **additional perspectives baked into every phase agent's prompt**. Each phase agent must produce the functional output AND include all advisory sections.

## Phase 1: Plan (Parallel)

Launch **Architect** and **Analyst** in parallel as `subagent_type: general-purpose`:

**Architect Agent:**
```
Read these role definitions and follow all of them:
- D:\Projects\Claude\.claude\skills\agent-architect.md (your PRIMARY role)
- D:\Projects\Claude\.claude\skills\agent-newgrad.md (advisory voice — include their perspective)
- D:\Projects\Claude\.claude\skills\agent-senior.md (advisory voice — include their perspective)

GOAL: [the user's goal]

Read all relevant existing files (CLAUDE.md, POR docs, code, specs) before designing.

Produce your Architect plan as defined in agent-architect.md. Then, at the end, add TWO additional sections:

1. "## New Grad's Take" — following the format in agent-newgrad.md, contribute the New Grad's perspective on your plan. What modern alternatives exist? What's outdated? What risk is worth taking?

2. "## Senior's Take" — following the format in agent-senior.md, contribute the Senior's perspective on your plan. What should be simpler? What contracts need to be explicit? What tests should exist before code? How should the data be structured?

These two perspectives should genuinely tension-test your plan. They may agree with each other, disagree with each other, or both disagree with you. Let them be honest.

Write your complete output to a temporary file: /tmp/team_architect_output.md
```

**Analyst Agent:**
```
Read these role definitions and follow all of them:
- D:\Projects\Claude\.claude\skills\agent-analyst.md (your PRIMARY role)
- D:\Projects\Claude\.claude\skills\agent-newgrad.md (advisory voice)
- D:\Projects\Claude\.claude\skills\agent-senior.md (advisory voice)

GOAL: [the user's goal]

Analyze the current state — read budget docs, specs, relevant POR files.
Provide a baseline analysis of current costs/performance that the goal would affect.

After your Analyst output, add:
1. "## New Grad's Take" — are there cheaper/faster modern alternatives? Is legacy tooling adding hidden cost?
2. "## Senior's Take" — are migration costs being underestimated? What's the real total cost of ownership?

Write your analysis to a temporary file: /tmp/team_analyst_baseline.md
```

## Phase 2: Critique (Sequential)

After Phase 1 completes, read both outputs. Then launch the **Critic** as `subagent_type: general-purpose`:

```
Read these role definitions and follow all of them:
- D:\Projects\Claude\.claude\skills\agent-critic.md (your PRIMARY role)
- D:\Projects\Claude\.claude\skills\agent-newgrad.md (advisory voice)
- D:\Projects\Claude\.claude\skills\agent-senior.md (advisory voice)

GOAL: [the user's goal]

ARCHITECT'S PLAN (including New Grad and Senior perspectives):
[include or reference the Architect's output]

ANALYST'S BASELINE (including New Grad and Senior perspectives):
[include or reference the Analyst's baseline]

Review the plan for issues, gaps, conflicts, and scope problems. Pay attention to the tensions between the New Grad and Senior perspectives from Phase 1 — these often reveal real tradeoffs.

After your Critic output, add:
1. "## New Grad's Take" — is the plan too conservative? Are we missing an opportunity to modernize?
2. "## Senior's Take" — is the plan too ambitious? Are we adding complexity we'll regret?

Write your critique to a temporary file: /tmp/team_critic_output.md
```

## Phase 3: Decision Gate

Read the Critic's output. Present a summary to the user:

```
## Team Plan Summary

### Architect's Plan
[3-5 bullet summary of proposed approach]

### Analyst's Baseline
[Key numbers — current cost, performance metrics]

### Critic's Assessment
[Verdict: PROCEED / PROCEED WITH CHANGES / RETHINK]
[Key issues found, if any]

### New Grad vs Senior
[Where they agreed, where they diverged, and which perspective won on each point]
```

**Ask the user:** "Proceed with implementation, adjust the plan, or stop?"

- If **stop**: end here.
- If **adjust**: revise the plan based on user feedback, re-run Critic if needed.
- If **proceed**: continue to Phase 4.

## Phase 4: Build

Launch the **Builder** as `subagent_type: general-purpose`:

```
Read these role definitions and follow all of them:
- D:\Projects\Claude\.claude\skills\agent-builder.md (your PRIMARY role)
- D:\Projects\Claude\.claude\skills\agent-newgrad.md (advisory voice)
- D:\Projects\Claude\.claude\skills\agent-senior.md (advisory voice)

GOAL: [the user's goal]

ARCHITECT'S PLAN (possibly revised after critique):
[include the plan, incorporating any Critic-driven adjustments]

RESOLVED TENSIONS (from Decision Gate):
[include which New Grad vs Senior positions were adopted]

Implement the plan. Make all changes to the actual project files.

The Senior's voice should influence HOW you build: test-first, clear contracts, simple code, explicit over implicit.
The New Grad's voice should influence WHAT tools and patterns you use: modern idioms, less boilerplate, better automation.

After your build report, add:
1. "## New Grad's Take" — what would I have done differently? What's still outdated in the implementation?
2. "## Senior's Take" — is this testable? Is it simple enough? Can I debug it at 2 AM?

Write your build report to a temporary file: /tmp/team_builder_output.md
```

## Phase 5: Verify and Analyze (Parallel)

After the Builder finishes, launch **Verifier** and **Analyst** in parallel:

**Verifier Agent:**
```
Read these role definitions and follow all of them:
- D:\Projects\Claude\.claude\skills\agent-verifier.md (your PRIMARY role)
- D:\Projects\Claude\.claude\skills\agent-newgrad.md (advisory voice)
- D:\Projects\Claude\.claude\skills\agent-senior.md (advisory voice)

GOAL: [the user's goal]

ARCHITECT'S PLAN (acceptance criteria):
[include the plan]

BUILDER'S REPORT (what changed):
[include the build report]

Verify the implementation. Run tests, check consistency, validate output.

After your verification report, add:
1. "## New Grad's Take" — could these tests be better automated? Are we testing the right things?
2. "## Senior's Take" — is the critical path covered? Are error cases tested? Can components be tested in isolation?

Write your verification report to a temporary file: /tmp/team_verifier_output.md
```

**Analyst Agent (Final):**
```
Read these role definitions and follow all of them:
- D:\Projects\Claude\.claude\skills\agent-analyst.md (your PRIMARY role)
- D:\Projects\Claude\.claude\skills\agent-newgrad.md (advisory voice)
- D:\Projects\Claude\.claude\skills\agent-senior.md (advisory voice)

GOAL: [the user's goal]

BASELINE (before):
[include the baseline analysis from Phase 1]

BUILDER'S REPORT (what changed):
[include the build report]

Calculate the final impact — cost delta, performance delta, tradeoffs.

After your analysis, add:
1. "## New Grad's Take" — long-term velocity gains from modernization?
2. "## Senior's Take" — real maintenance cost? Bus factor impact?

Write your final analysis to a temporary file: /tmp/team_analyst_final.md
```

## Phase 6: Report

Read all outputs. Present the final summary to the user:

```
## Team Report: [goal]

### What Was Done
[Builder's summary — files changed, key actions]

### Verification
[Verifier's verdict — VERIFIED / PARTIAL / FAILED]
[Key test results]

### Impact
[Analyst's deltas — cost, performance, schedule]

### Issues
[Any unresolved Critic or Verifier findings]

### New Grad vs Senior — Final Scorecard
| Decision Point | New Grad Said | Senior Said | What We Did | Right Call? |
|---------------|---------------|-------------|-------------|-------------|
[Fill from all phases — track where each voice influenced the outcome]
```

## Configuration

### When to Skip Phases
- **Trivial changes** (typo fix, single file edit): Skip to Builder, then Verifier. No Architect/Critic/Analyst needed. New Grad and Senior still advise.
- **Research/analysis only** (no implementation): Run Architect + Analyst + Critic. Skip Builder and Verifier.
- **User says "just do it"**: Run Builder + Verifier. Skip the planning phases.

### Agent Selection
Not every goal needs all 5 functional agents. Use judgment:
- Pure software task → Architect, Builder, Verifier (skip Analyst unless budget-relevant)
- Hardware/design decision → Architect, Critic, Analyst (skip Builder/Verifier if no code changes)
- Document update → Builder, Verifier (skip Architect/Critic/Analyst)

**New Grad and Senior are ALWAYS included** regardless of which functional agents run. They are the constant advisory tension that keeps every decision honest.

### Escalation
If the Verifier reports FAILED, loop back: Critic reviews the failures → Builder fixes → Verifier re-checks. Max 2 loops before escalating to the user.
