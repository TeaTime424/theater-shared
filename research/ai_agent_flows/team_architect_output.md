# Architecture: Agent Team Framework Improvements Based on Tension Research

**Status:** RESEARCH — Architect's proposal, not adopted
**Date:** 2026-03-16
**Scope:** Improvements to `/team` (team.md) and `/investigate` frameworks to incorporate findings from `01_agent_tension_sota.md`

---

## Current State

### What exists
- **`/team` framework** (`.claude/commands/team.md`): 6-phase pipeline (Plan → Critique → Decision Gate → Build → Verify → Report) with 5 functional roles (Architect, Critic, Builder, Verifier, Analyst) and 5 advisory voices (New Grad, Senior, Acton, Bass Head, Cost Cutter)
- **`/investigate` framework**: 4-agent adversarial (Pro/Con researchers + adversaries)
- **10 agent skill files** in `.claude/skills/agent-*.md`
- All agents are the same underlying model (Claude), making groupthink the dominant failure mode

### Key research findings that apply to us
1. Debate itself adds marginal value vs. majority voting (NeurIPS 2025)
2. Role diversity is critical — identical agents debating underperforms diverse-persona agents (ChatEval, ICLR 2024)
3. Groupthink is the #1 failure mode — agents converge on wrong answers via social pressure
4. 2-3 rounds optimal — beyond that, correct answers get corrupted ("Talk Isn't Always Cheap")
5. Devil's advocate needs **explicit contrary instructions**, not just "be critical"
6. Forced justification with evidence prevents lazy agreement (Delphi method)
7. Diversity of *reasoning approach* > diversity of *answer* (ICLR 2025 DMAD paper)

---

## Proposed Changes

### Change 1: Critic gets explicit contrary instructions (not just "find problems")

**Current:** Critic says "find problems, question assumptions." This is too passive — same-model agents will generate soft, deferential criticism.

**Proposed:** Rewrite `agent-critic.md` to include:
- **Mandatory contrary position:** "Before reviewing the plan, generate the strongest possible argument for an entirely different approach. Write it out. Then evaluate the plan against that alternative."
- **Steel-man opposition:** "For every PROCEED recommendation, articulate what the plan would need to fail at for you to say RETHINK. Be specific — name the threshold."
- **Pre-commitment:** Critic must state their initial assessment BEFORE reading the Architect's plan details. This prevents anchoring.

**Acceptance criteria:** Critic output includes a "Strongest Alternative" section and explicit failure thresholds.

### Change 2: Independent assessment before exposure (Delphi Pattern)

**Current:** Phase 1 runs Architect and Analyst in parallel (good — independent), but Phase 2 Critic sees both outputs simultaneously. This enables anchoring to the Architect's framing.

**Proposed:** Add a "blind assessment" step to the Critic phase:
1. Critic receives ONLY the goal statement first
2. Critic writes their own 3-sentence approach (before seeing any plan)
3. THEN Critic receives the Architect's plan and Analyst's baseline
4. Critic must explicitly note where their blind approach differs from the Architect's

This is the Delphi method's core insight: forced independent assessment before peer exposure prevents convergence bias.

**Acceptance criteria:** Critic output includes "My Blind Assessment" section written before plan review.

### Change 3: Reasoning diversity enforcement

**Current:** Advisory voices (New Grad, Senior, Acton) provide perspective diversity, which is good. But they all operate within the same reasoning paradigm (evaluate the plan that was proposed).

**Proposed:** Assign explicit reasoning modes to different agents:
- **Architect:** First-principles reasoning — "What does the goal require? Work forward from constraints."
- **Critic:** Inversion reasoning — "What would make this fail? Work backward from failure modes."
- **Analyst:** Empirical reasoning — "What does the data say? What comparable projects show?"
- **Acton advisory:** Data-transform reasoning — "What's the input? What's the output? What's the transform?" (already does this)

Add a one-line reasoning mode instruction to each agent skill file. This is the DMAD (Diverse Multi-Agent Debate) pattern — diversity of approach, not just diversity of answer.

**Acceptance criteria:** Each functional agent's skill file includes an explicit reasoning mode instruction.

### Change 4: Structured scoring replaces verdict prose

**Current:** Critic gives a verdict (PROCEED / PROCEED WITH CHANGES / RETHINK) with prose rationale. This is vulnerable to the "confident wrong answer" problem — the model writes convincing prose regardless of actual quality.

**Proposed:** Replace prose verdict with structured rubric:
```
### Scoring
| Criterion | Score (1-5) | Evidence |
|-----------|-------------|----------|
| Addresses stated goal | _ | [specific reference] |
| No spec conflicts | _ | [files checked] |
| Reversibility | _ | [what's hard to undo] |
| Complexity proportional to problem | _ | [comparison] |
| All numbers verified | _ | [calculations checked] |

Total: __/25
Threshold: >=18 = PROCEED, 12-17 = PROCEED WITH CHANGES, <12 = RETHINK
```

This forces point-by-point evaluation instead of gestalt judgment. Research shows structured scoring reduces bias.

**Acceptance criteria:** Critic output uses rubric. Verifier output uses similar rubric for implementation quality.

### Change 5: Anti-groupthink mechanisms for same-model agents

**Current:** Nothing explicitly prevents Claude-talking-to-Claude convergence.

**Proposed:** Three mechanisms:

**5a. Dissent obligation:** Each advisory voice must state at least one genuine disagreement with the functional agent's conclusion. "I'll Concede" already exists but is about conceding to the OTHER advisory voice. Add "I Disagree" as mandatory — a point where the advisory voice believes the main agent is wrong.

**5b. Confidence calibration:** Every claim in any agent output must be tagged:
- `[MEASURED]` — backed by a specific number from a spec sheet, calculation, or measurement
- `[ESTIMATED]` — reasonable inference but not directly verified
- `[ASSUMED]` — no direct evidence; could be wrong

This forces agents to distinguish what they know from what they're pattern-matching. Same-model groupthink thrives on shared assumptions that feel like knowledge.

**5c. Red team prompt injection:** Add to the Critic's prompt: "You are evaluated on the quality of issues you find, not on agreement with the plan. A Critic who says PROCEED on a flawed plan has failed. A Critic who finds a real issue in a good plan has succeeded." This directly counteracts the sycophancy bias in language models.

**Acceptance criteria:** Advisory voices include "I Disagree" section. All factual claims tagged with confidence level. Critic prompt includes anti-sycophancy instruction.

### Change 6: Cap debate rounds at 2

**Current:** Escalation loop allows max 2 loops (Build → Verify → Critic → Build → Verify). Good — this matches the research.

**Proposed:** Make the 2-round cap explicit and add a rule: "If the second round doesn't resolve the issue, surface it to the user as an unresolved disagreement with both positions stated. Do NOT attempt a third round — research shows correct answers degrade after round 2-3."

**Acceptance criteria:** team.md Escalation section updated with explicit rationale and no-third-round rule.

### Change 7: Post-decision audit trail

**Current:** Phase 6 Report includes a New Grad vs Senior scorecard (good).

**Proposed:** Expand to include ALL advisory voices and add a "Dissent Record" — any point where an advisory voice disagreed with the final decision. This creates accountability and makes it easy to revisit decisions if assumptions prove wrong.

```
### Dissent Record
| Phase | Voice | Dissent | Resolution | Revisit If... |
|-------|-------|---------|------------|----------------|
```

**Acceptance criteria:** Report phase includes dissent record table.

---

## What to Explicitly AVOID

These are patterns the research shows don't work or actively harm output quality:

### AVOID 1: More debate rounds
Adding rounds 4, 5, 6 does not improve quality. After round 2-3, correct answers start getting corrupted as agents converge on compromise positions. Our current 2-loop max is correct. Do not increase it.

### AVOID 2: More agents doing the same thing
Adding a second Critic or a "Meta-Critic" that reviews the Critic is waste. The Acton insight from our own experience applies: "three out of five roles produced no unique findings" is a real risk. Each agent must have a unique reasoning mode or it's overhead.

### AVOID 3: Free-form debate between agents
Unstructured back-and-forth between agents (the MAD pattern) is the worst-performing approach per the NeurIPS 2025 spotlight. Our current pipeline structure (plan → critique → build → verify) is better because each agent has a specific deliverable, not just "discuss."

### AVOID 4: Expecting the Critic to genuinely oppose without explicit instructions
"Be critical" is not enough for same-model agents. The devil's advocate MUST have explicit contrary instructions: "generate the strongest alternative," "find the failure threshold," "assume the plan is wrong and prove it." Without this, the Critic will produce superficially critical prose that ultimately agrees.

### AVOID 5: Consensus as a goal
The Delphi method works because it forces justification, not because it achieves consensus. If agents agree, fine. If they disagree, surface the disagreement to the user. Forcing consensus destroys the minority position that might be right.

### AVOID 6: Cross-model diversity as a solution
The research shows cross-model helps, but we're on Claude Code — single model is a constraint, not a choice. Don't try to simulate model diversity by making agents "pretend" to be GPT-4 or Gemini. Instead, enforce reasoning diversity (Change 3) and structural independence (Change 2).

---

## Dependencies

1. Change 1 (Critic rewrite) and Change 2 (blind assessment) should be implemented together — they're both about making criticism genuine
2. Change 3 (reasoning modes) can be done independently per skill file
3. Change 4 (structured scoring) depends on Change 1 (Critic rewrite)
4. Change 5a-5c (anti-groupthink) can be added incrementally to skill files
5. Changes 6-7 are team.md-only changes, no skill file dependencies

**Implementation order:** 1+2 → 3 → 4 → 5a → 5b → 5c → 6 → 7

---

## Interfaces

### Files that change
| File | Change |
|------|--------|
| `.claude/skills/agent-critic.md` | Contrary instructions, anti-sycophancy prompt, blind assessment step, scoring rubric |
| `.claude/skills/agent-architect.md` | Add reasoning mode (first-principles) |
| `.claude/skills/agent-analyst.md` | Add reasoning mode (empirical) |
| `.claude/skills/agent-verifier.md` | Add scoring rubric parallel to Critic's |
| `.claude/skills/agent-newgrad.md` | Add "I Disagree" mandatory section |
| `.claude/skills/agent-senior.md` | Add "I Disagree" mandatory section |
| `.claude/skills/agent-acton.md` | Add "I Disagree" mandatory section (BS Detection already partially serves this) |
| `.claude/skills/agent-basshead.md` | Add "I Disagree" mandatory section |
| `.claude/skills/agent-costcutter.md` | Add "I Disagree" mandatory section |
| `.claude/commands/team.md` | Blind assessment in Phase 2, round cap rationale, dissent record in Phase 6, confidence tags |

### No new files needed
All changes are edits to existing files.

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Blind assessment adds latency to Phase 2 | HIGH | LOW | It's one extra paragraph, not a full analysis |
| Confidence tags feel bureaucratic and get ignored | MEDIUM | MEDIUM | Start with Critic and Analyst only; expand if useful |
| Scoring rubric becomes checkbox exercise | MEDIUM | MEDIUM | Review rubric results periodically; adjust criteria |
| "I Disagree" sections become formulaic | HIGH | LOW | Acton's BS Detection can call out fake dissent |
| Over-engineering the process (ironic) | MEDIUM | HIGH | Implement changes 1-3 first, evaluate, then decide on 4-7 |

---

## Open Questions

1. Should the `/investigate` framework adopt the same changes? The 4-agent adversarial structure already has more explicit tension — but the blind assessment and confidence tagging could help there too.
2. Should we add Acton as a mandatory advisory voice (currently only included when domain-relevant)? His BS Detection function is essentially the anti-groupthink mechanism the research says we need.
3. The research suggests structured scoring may matter more than the debate itself. Should we experiment with a "score-only" mode where agents independently score a plan without seeing each other's critiques?

---

## New Grad's Take

### What I'd Change
- **Agent Teams experimental feature.** Claude Code has `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` — real parallel agents that share findings via git, not sequential subagent calls pretending to be a team. The current `/team` is a sequential pipeline with parallel-subagent steps. True agent teams would let the Critic challenge the Architect in real-time, not after-the-fact. Worth enabling and testing, even if experimental.
- **Structured output with tool use.** Instead of free-text scoring rubrics that might get ignored, use a structured JSON schema for Critic output. Claude supports structured outputs — enforce the rubric at the schema level, not the prompt level. The model can't skip fields if the schema requires them.
- **MoA-inspired layered aggregation.** Run 3 independent Critic assessments with different reasoning modes (inversion, analogical, empirical), then aggregate. The research shows even weak independent assessments improve a strong aggregator. Yes it's 3x the compute for the Critic phase, but that's where errors are caught or missed.

### What's Outdated Here
- **Sequential pipeline is a 2024 pattern.** The Plan → Critique → Build → Verify waterfall is the AI equivalent of waterfall development. Modern agent frameworks (LangGraph, CrewAI) use graph-based flows where agents can loop, branch, and re-enter. The conditional "max 2 loops" in escalation is a patch on a fundamentally sequential design.
- **Advisory voices baked into every prompt** add token cost to every agent call. A cleaner approach: run advisory voices as separate lightweight assessments that get merged, rather than inflating every prompt with 5 persona descriptions.

### Risk I'm Willing to Take
- Enable `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` on one real task. Worst case: it's buggy and we fall back to the current pipeline. Best case: genuine parallel tension between agents that can challenge each other's work in real-time.

### I'll Concede
- The sequential pipeline has one genuine advantage: deterministic ordering means the user can follow what happened. Graph-based flows are harder to audit. For a build project where the user needs to trust every decision, that traceability matters.

---

## Senior's Take

### Keep It Simple
- The Architect proposes 7 changes. Implement 3 first (Changes 1, 2, 5c — the anti-sycophancy and blind assessment changes). These are the highest-impact, lowest-risk modifications. Everything else is optimization on top.
- Confidence tagging (`[MEASURED]`/`[ESTIMATED]`/`[ASSUMED]`) sounds good in theory. In practice, every agent will tag everything `[ESTIMATED]` to avoid being called out. Test it on 2-3 real tasks before committing to roll it out everywhere.
- The scoring rubric (Change 4) is the right idea but 5 criteria is enough. Don't let it grow to 15. The moment it becomes a checklist, people stop thinking.

### Contracts & Interfaces
- The Critic's "blind assessment" (Change 2) needs a clear contract: it's 3 sentences max, written BEFORE any plan is loaded. If the Critic writes a 500-word blind assessment, it's not blind anymore — it's a second architecture pass. Constrain it.
- "I Disagree" sections need a format: `[DISAGREE: specific claim] because [specific evidence]`. Without structure, dissent degrades to "I'm not sure about..." which is useless.

### Test First
- Before changing any skill files, run the current `/team` on a known task and save the output. Then make the changes and run the same task again. Compare. Without a baseline, you can't know if the changes helped.
- The research itself warns that prompt sensitivity can flip debate outcomes. Small changes to agent prompts may have unexpected effects. Test incrementally.

### Data Design
- The dissent record (Change 7) is the most important structural change. It creates a queryable history of where agents disagreed and what was decided. Over time, this becomes data about which advisory voices are most often right when they dissent. That's the data you need to tune the team.

### I'll Concede
- The New Grad's point about structured JSON output for the scoring rubric is better than my instinct to keep it as markdown tables. Schema enforcement genuinely prevents the "skip the hard fields" problem. I'd adopt that for the Critic's scoring, though not for free-text sections where the model needs room to reason.
