# Agent Tension Research — What We Found & What We Changed

## The Question
How do you create productive tension between AI agents when they're all the same model?

## Key Findings from Literature (28 sources, 2024-2026)

**What works:**
- Role diversity is essential — same-role agents debating underperforms a single agent (ChatEval, ICLR 2024)
- Devil's advocate with explicit contrary instructions gives +6.2% accuracy (DEBATE, ACL 2024)
- Forced justification (Delphi method) reproduces 95% of expert panel results (HAH-Delphi, 2025)
- Mixture-of-Agents layered architecture beats GPT-4o using only open-source models (Together AI, 2024)
- Diversity of reasoning approach > diversity of answer (DMAD, ICLR 2025)

**What doesn't work:**
- Multi-agent debate adds marginal value over simple voting (NeurIPS 2025 spotlight)
- Beyond 2-3 rounds, correct answers get corrupted — agents debate good answers into bad ones
- "Be critical" is too vague — same-model agents produce soft, deferential criticism
- Forced consensus destroys the minority position that might be right
- More agents doing the same thing is waste, not rigor

**The groupthink problem:**
All our agents are Claude. Same model = same biases, same blind spots, same tendency to defer to confident-sounding claims. The research says same-model debate captures ~60-70% of potential quality gains vs cross-model. We can't fix the model constraint, but we can enforce structural diversity.

## What We Audited

Reviewed team_test through team_test_6 outputs. Found:
- Framework catches real errors: $590 budget discrepancy, screen height miscalculation (134" in 120" room), ADC/DAC spec conflation
- Verifier has NEVER returned FAILED across 5+ runs — either everything is perfect or verification is too shallow
- Advisory voice hit rates: Acton (67% unique findings), Cost Cutter (67%), Senior (33%), New Grad (25%), Bass Head (0% outcome influence)
- Forced concession sections ("I'll Concede") are formulaic — structurally present but not producing real tension

## What We Changed

### 1. Critic Rewrite (agent-critic.md)
**Before:** "Find problems, question assumptions."
**After:**
- Anti-sycophancy prompt: "You are evaluated on issues found, not on agreement"
- Must generate "Strongest Alternative" before evaluating the plan
- Must define "Failure Thresholds" — what would need to fail for PROCEED to become RETHINK
- Reasoning mode: Inversion ("work backward from failure")

### 2. Two-Call Blind Assessment (team.md Phase 2)
**Before:** Critic receives goal + Architect plan + Analyst baseline all at once. Anchors to Architect's framing.
**After:** Two separate calls:
- Call 1: Critic receives ONLY the goal. Writes 3-sentence blind assessment.
- Call 2: Critic receives everything + their own blind assessment. Must note where their blind approach differs.
This is real Delphi — independent assessment before peer exposure.

### 3. Reasoning Mode Diversity (3 skill files)
Each functional agent now has an explicit reasoning mode:
- Architect: First-principles — decompose from constraints, build up
- Analyst: Empirical — what does the data say? Cite measurements, not vibes
- Critic: Inversion — what would make this fail? Work backward

Same model, different analytical lens. Research (DMAD, ICLR 2025) shows this is the highest-leverage intervention for same-model setups.

### 4. Respond to Critique (team.md new Phase 2.5)
**Before:** Critic delivers verdict, Builder implements, Architect never responds to criticism.
**After:** Architect must address every BLOCKER and WARNING:
- ACCEPT: describe the specific change
- REBUT: provide specific evidence the Critic is wrong

No ignoring criticism. No silent incorporation. Forces the Architect to engage with objections on the record.

### Also
- Verifier anti-sycophancy prompt: "evaluated on bugs found, not builds approved"
- Dissent Record in final report: tracks every advisory voice disagreement + what condition would make it worth revisiting
- 2-round escalation cap with research rationale (correct answers degrade after round 3)
- `tools/team_eval.py` — measures 6 tension metrics per run, enables before/after comparison

## The Acton Bomb

The most important observation came from the Acton voice: both the Architect and Analyst proposed fixes for groupthink while exhibiting groupthink. No agent questioned whether multi-agent review is worth the compute cost at all. His proposed experiment:

1. Take 5 documents with known seeded errors
2. Run single-agent review (one Claude call, good prompt)
3. Run multi-agent review (current /team)
4. Run multi-agent review (improved /team)
5. Count errors caught in each condition

That experiment would answer the actual question. Everything else is theory.

## Sources Worth Reading

| Paper | Why It Matters |
|-------|---------------|
| [Debate or Vote? (NeurIPS 2025)](https://openreview.net/forum?id=iUjGNJzrF1) | Voting accounts for most multi-agent gains — debate itself is marginal |
| [Talk Isn't Always Cheap (2025)](https://arxiv.org/pdf/2509.05396) | Correct answers get corrupted after 2-3 debate rounds |
| [DEBATE framework (ACL 2024)](https://arxiv.org/html/2405.09935v1) | Devil's advocate with explicit contrary instructions: +6.2% |
| [Mixture-of-Agents (2024)](https://arxiv.org/abs/2406.04692) | Layered proposer/aggregator beats GPT-4o with open-source only |
| [MachineSoM (ACL 2024)](https://github.com/zjunlp/MachineSoM) | Same model + diverse role prompts works; same model + same role doesn't |
| [DMAD (ICLR 2025)](https://openreview.net/forum?id=t6QHYUOQL7) | Diversity of reasoning approach > diversity of answer |
