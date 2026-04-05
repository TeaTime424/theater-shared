# Critique: Agent Team Framework Improvements

**Status:** RESEARCH — Critic's review of Architect's plan and Analyst's baseline
**Date:** 2026-03-16
**Inputs:** team_architect_output.md, team_analyst_baseline.md, 01_agent_tension_sota.md

---

## Issues Found

| # | Severity | Issue | Location | Recommendation |
|---|----------|-------|----------|----------------|
| 1 | BLOCKER | **Analyst's "keep 3 drop 2" functional roles lacks evidence for dropping Analyst.** The Analyst recommends cutting itself (Analyst role) and the Verifier, keeping only Architect/Critic/Builder. But the Analyst's OWN data shows the Analyst caught the $590 budget error and the ADC/DAC conflation — catches attributed to the Analyst role, not the Critic. Cutting the role that produced those catches contradicts the data presented. | team_analyst_baseline.md §5, §1 | Keep the Analyst. The Analyst's own effectiveness data argues against its proposed cut. The recommendation to drop it appears to be motivated by symmetry ("keep 3") rather than by the evidence. |
| 2 | BLOCKER | **Analyst's "30-40% quality left on table" number is fabricated.** The claim: "same-model debate yields roughly 60-70% of the quality improvement that cross-model debate achieves." No paper cited makes this specific claim. The ChatEval finding is that same-ROLE debate underperforms (not same-model), and the MoA result compares layered open-source ensembles to GPT-4o — a completely different architecture. Extrapolating a specific percentage from two unrelated papers about different things is not analysis, it's numerology. | team_analyst_baseline.md §2, §5 | Remove or heavily qualify. State what the research ACTUALLY shows: same-role debate underperforms diverse-role debate (ChatEval). MoA's 65.1% vs 57.5% is about model diversity + aggregation architecture, not about debate quality. These don't combine into a "30-40%" figure. |
| 3 | WARNING | **Architect's "pre-commitment" in Change 2 is impractical for an LLM agent.** The proposal says the Critic should "state their initial assessment BEFORE reading the Architect's plan details." But in a prompt-based system, the Critic receives all context at once — there's no mechanism to stage information delivery within a single agent invocation unless you restructure the orchestrator to make two separate calls. The Architect doesn't address this implementation detail. | team_architect_output.md, Change 2 | Either: (a) restructure team.md to invoke the Critic twice (first with goal only, then with full context), which doubles Critic compute cost, or (b) use a prompt instruction ("write your blind assessment first, then read the plan below the fold") and accept that it's a weak simulation of true information staging. Be honest about which one you're proposing. |
| 4 | WARNING | **Architect and Analyst both invoke "Delphi" but propose different mechanisms.** Architect's Change 2: blind assessment before exposure (Delphi Pattern). Analyst's recommendation 3: "Respond to Critique" step where Architect rebuts Critic findings. These are two different things. Blind assessment is about preventing anchoring. Respond-to-Critique is about forced justification. Both are Delphi-inspired but they're not the same mechanism and they're not redundant. Neither document acknowledges the other's version. | team_architect_output.md Change 2, team_analyst_baseline.md §Summary point 3 | These are complementary, not redundant. Implement both. Blind assessment (Change 2) prevents anchoring at the start. Respond-to-Critique adds forced justification at the end. The Delphi method uses both — independent assessment AND iterative justification. |
| 5 | WARNING | **Analyst's advisory voice data has severe sample size problems.** Acton and Cost Cutter show 67% unique-finding rates — but from a sample of 3 observations each. That's n=2 unique findings out of n=3 total. One different run could flip these to 33%. The Analyst uses these numbers to justify cutting New Grad/Senior (n=12) while keeping Acton/Cost Cutter (n=3), but the small-sample voices have wider confidence intervals than the large-sample ones. | team_analyst_baseline.md §3 | Acknowledge the sample size limitation explicitly. The conclusion (Acton > New Grad) may be correct, but the data doesn't support the confidence with which it's stated. The Senior's recommendation to "run 3 more times" is the right call before making cuts. |
| 6 | WARNING | **Architect's Change 5b (confidence tagging) conflicts with the research on what actually works.** The SOTA survey identifies forced justification and reasoning diversity as the high-impact mechanisms. Confidence tagging ([MEASURED]/[ESTIMATED]/[ASSUMED]) is not mentioned in any cited paper. It's a reasonable idea, but the Architect frames it as research-backed when it's actually a novel proposal. | team_architect_output.md Change 5b | Relabel as "proposed experiment" rather than implying research backing. The Architect's own risk table admits "MEDIUM" likelihood of it being ignored. If it's likely to be ignored and has no research backing, it should be tried last, not bundled with the core changes. |
| 7 | MINOR | **Both documents ignore the compute cost question.** The Analyst calculates "10x compute for 8% improvement" and calls it poor ROI. The Architect proposes changes that add compute (blind assessment = extra Critic call, confidence tagging = longer outputs, "I Disagree" sections = more output per voice). Neither quantifies the net compute impact of their proposals. | Both documents | Estimate the compute delta. If the Architect's 7 changes collectively add ~30% more tokens per run while the Analyst's cuts remove ~40%, the net effect matters for whether this is worth doing. |
| 8 | MINOR | **The Verifier merge question has a hidden dependency.** The Analyst says "merge Verifier into Critic." But the Verifier runs AFTER the Builder (Phase 5), while the Critic runs BEFORE the Builder (Phase 2). Merging them means either: (a) the Critic runs twice (before and after build), or (b) post-build verification is dropped entirely. Neither is addressed. | team_analyst_baseline.md §Summary point 1 | If merging, specify that the Critic gets a second invocation in Phase 5 to verify the build output. This is not "merging" — it's "renaming the Verifier to Critic and giving it the Critic's prompt." The actual agent invocation count doesn't change. |

---

## Assumptions Tested

| Assumption | Valid? | Evidence |
|-----------|--------|----------|
| Same-model agents are inherently prone to groupthink | Partially | ChatEval shows same-ROLE underperformance, not same-model per se. Diverse role prompts on same model DO help (MachineSoM, ACL 2024). The problem is under-differentiated roles, not the model. |
| Advisory voices are mostly redundant | Partially | New Grad at 25% unique-finding rate supports this. But n=3 for Acton/Cost Cutter is too small to draw conclusions. And "unique finding" is undefined — by whose judgment? |
| 2 review rounds is optimal | Yes | Literature consistently shows 2-3 rounds optimal, with degradation after 3. Current framework is at 2 effective rounds. |
| Forced justification improves quality | Yes | DelphiAgent (+6.84%), Delphi method literature, multiple sources. This is the most well-supported recommendation in either document. |
| Debate adds marginal value vs voting | Yes, with caveats | NeurIPS 2025 spotlight is specific to MAD (multi-agent debate). Our framework is sequential review, not debate. The finding may not directly transfer. |
| Verifier never fails because verification is too shallow | Likely | Zero failures in 5+ runs. The Analyst's inference is reasonable but unproven — it could also mean the Builder is consistently good. Need adversarial test (seed errors into Builder output) to distinguish. |

---

## Scope Check

- **Asked for:** Improvements to agent tension based on SOTA research
- **Architect proposed:** 7 changes touching 10 files, with phased rollout
- **Analyst proposed:** 3 changes (cut roles, cut voices, add Delphi round)
- **Delta:** Architect is over-scoped for a first iteration. Analyst is under-scoped — cutting roles before gathering more data is premature. The right scope is 4 changes: the Architect's Changes 1, 2, 3 (Critic rewrite, blind assessment, reasoning modes) plus the Analyst's "Respond to Critique" step. These are the changes with research backing, low risk, and no role cuts that might discard valuable agents.

---

## Key Disagreements Resolved

### 1. Advisory voices: keep all 5 vs cut to 2?

**Neither is fully right.** The Analyst's data shows New Grad and Bass Head are weak, but the sample sizes for Acton and Cost Cutter are too small to trust. The Architect's "I Disagree" sections are a reasonable mechanism but risk making 5 voices even more verbose.

**Recommendation:** Keep all 5 for now, but make them conditional. Bass Head only activates on bass-related tasks. Cost Cutter only on budget tasks. New Grad and Senior only on architecture/tooling decisions. Acton on everything (highest signal-to-noise ratio). This reduces token cost without permanently discarding voices that might prove valuable on different task types. Gather more data (the Senior is right — run 3 more times), then make permanent cuts.

### 2. Verifier: keep vs merge into Critic?

**The Analyst is wrong about merging.** The Verifier and Critic operate at different phases (pre-build vs post-build). "Merging" them doesn't eliminate an agent invocation — it just changes the name on the Phase 5 call. The real problem is that the Verifier never fails, which means its acceptance criteria are too loose.

**Recommendation:** Keep the Verifier but rewrite its instructions. Add: "You are evaluated on bugs found, not on plans approved. A Verifier that passes a flawed build has failed at its job." This is the same anti-sycophancy instruction the Architect proposes for the Critic (Change 5c), applied to the Verifier.

### 3. Scope: 7 changes vs 3?

**Neither.** 4 changes, prioritized by research support:

1. Critic rewrite with explicit contrary instructions (Architect Change 1) — directly supported by DEBATE (ACL 2024) and devil's advocate literature
2. Blind assessment before exposure (Architect Change 2) — supported by Delphi method literature
3. Reasoning mode assignment (Architect Change 3) — supported by DMAD (ICLR 2025)
4. "Respond to Critique" step (Analyst recommendation 3) — supported by DelphiAgent (+6.84%)

Defer: scoring rubric (Change 4), confidence tagging (Change 5b), dissent record (Change 7). These are reasonable ideas with no research backing — test them after the core 4 are implemented.

Keep as-is: round cap (Change 6) — already correct. Anti-sycophancy prompt (Change 5c) — bundle with Change 1 since it's a prompt edit to the same file. "I Disagree" sections (Change 5a) — add to Acton and Cost Cutter only, since they're the high-value voices.

### 4. Blind assessment vs Respond to Critique?

**Complementary, not redundant.** Both are Delphi-inspired but target different failure modes:
- Blind assessment prevents anchoring (Critic doesn't get trapped by Architect's framing)
- Respond to Critique prevents lazy acceptance (Architect must defend or concede each point)

Implement both.

---

## Verdict

**PROCEED WITH CHANGES**

The Architect's plan is directionally correct but over-scoped. The Analyst's analysis is valuable but its recommendations are too aggressive (cutting roles based on insufficient data, fabricating quality percentages). Implement 4 changes as specified above, gather data from 3+ runs, then decide on the remaining changes.

---

## New Grad's Take

### What I'd Change
- **The "blind assessment" should use two separate agent calls, not a prompt hack.** The Architect hand-waves the implementation. If you tell an LLM "write your assessment before reading the plan below," it has already tokenized the plan — the blindness is fake. The only real implementation is two calls: (1) Critic receives goal only, writes blind assessment, (2) Critic receives goal + blind assessment + Architect plan + Analyst baseline. Yes, it's 2x Critic compute. But if you're going to invoke Delphi, actually do Delphi. A prompt that says "pretend you haven't read this" is cargo-cult methodology.

- **The `team_eval.py` proposal from the Analyst's New Grad section is the highest-leverage thing in either document.** Everything else is prompt engineering — changing words and hoping behavior changes. A measurement script would tell you if the changes worked. Without it, you're optimizing blind. Build the eval script FIRST, run baseline, make changes, run again, compare. That's engineering.

### What's Outdated Here
- Both documents treat the 5 advisory voices as all-or-nothing. Modern agent frameworks (CrewAI, LangGraph) let you define conditional activation — agents spin up only when relevant context is present. The Senior saying "run Bass Head only on bass tasks" is right, but that requires orchestrator logic that team.md doesn't currently support. Worth adding: a simple keyword check in the orchestrator that activates domain-specific voices only when the task touches their domain.

### Risk I'm Willing to Take
- Skip the incremental approach. Implement all 4 recommended changes at once, plus the eval script. Run 3 comparison tests (before/after). The incremental "Change 1 then evaluate then Change 2" approach the Architect proposes would take weeks. Ship the batch, measure, iterate.

### I'll Concede
- The Senior's point about testing incrementally is the safer path. If a prompt change to the Critic accidentally makes it LESS effective (the research warns about prompt sensitivity), and you changed 4 things at once, you won't know which one caused the regression. The batch approach is faster but riskier. For a framework that's already working (it does catch real errors), caution is warranted.

---

## Senior's Take

### Keep It Simple
- The Architect proposes 7 changes. The Analyst proposes 3. The Critic landed on 4. Even 4 might be too many to change at once in a system where prompt sensitivity can flip outcomes. My preference: implement Change 1 (Critic rewrite) and Change 4-from-Analyst (Respond to Critique) first. These are both edits to existing files, they target the two most-supported mechanisms in the literature (devil's advocate + forced justification), and they don't require restructuring the orchestrator.

- The blind assessment (Architect Change 2) is the right idea done wrong. Making two separate Critic calls is over-engineering. A simpler approach: add one line to the Critic prompt — "State in 3 sentences how you would approach this goal before evaluating the Architect's plan." It's not truly blind (the New Grad is right about tokenization), but it forces the Critic to articulate an independent frame. That's 80% of the benefit at 0% of the implementation cost. Good enough for v1. Upgrade to two-call architecture if the data shows it matters.

### Contracts & Interfaces
- The "Respond to Critique" step needs a clear contract: Architect responds ONLY to BLOCKER and WARNING items. Not to MINOR, not to advisory voice opinions. Without this constraint, the response becomes a full re-architecture document, which defeats the purpose.

- The reasoning mode assignment (Change 3) is one line per skill file. The contract is: each functional role has a "Reasoning Mode:" line that says how it approaches problems. Simple, no structural changes, easy to test. Good interface.

### Test First
- The Analyst's own data is the baseline. Unique-finding rates, error-propagation across runs, convergence patterns — it's all there. Before changing anything, formalize that data into a repeatable measurement. Then change, re-measure, compare. The Analyst's New Grad section proposed `team_eval.py` and I said "build it" — I'll say it again here. Without measurement, this entire exercise is opinion.

### Data Design
- The dissent record (Architect Change 7) is deferred by the Critic's recommendation, but it's the most important long-term data structure. It creates the feedback loop that makes the framework self-improving. Once you have 10+ runs with dissent records, you can answer: "Which voice dissents most often? Which dissents are most often vindicated?" That's the data that tells you which voices to keep and which to cut — not a sample of 3.

### I'll Concede
- The New Grad is right that the blind assessment needs two calls to be genuine. I proposed a prompt hack because I'm allergic to unnecessary complexity. But if the research says independent assessment is a core Delphi mechanism, half-implementing it is worse than not implementing it — you get the token cost of the instruction without the cognitive benefit of actual independence. Do it right or don't do it.

---

## Acton's Take

### Show Me the Data
The Analyst claims a "4-6 percentage point gap" in quality improvement. Let's trace this number:
1. MoA gets 65.1% on AlpacaEval vs GPT-4o at 57.5%. That's a 13.2% relative improvement. [MEASURED — from the MoA paper]
2. Analyst claims our framework captures "60-70%" of multi-agent gains. [FABRICATED — no source, no measurement, no basis]
3. Therefore 0.65 × 13.2% = 8.6% and 13.2% - 8.6% = 4.6%. [ARITHMETIC on fabricated input]

This is a made-up number dressed in a calculation. MoA's result is about model diversity + layered aggregation on a benchmark task. Our framework is about sequential review of a design document. These are not the same thing. You cannot extrapolate one to the other. The "4-6 percentage point gap" is bullshit.

What we actually know:
- The framework caught the screen height error. [MEASURED — team_test output]
- The framework caught the $590 budget error. [MEASURED — team_test output]
- The framework missed the $200 Phase 1 error in team_test but caught it in team_test_5. [MEASURED — both outputs]
- The Verifier has never failed anything. [MEASURED — all test outputs]

That's the data. Four observations. Everything else is speculation.

### The Hardware Is the Platform
The "hardware" here is Claude — one model, one set of weights, one set of biases. Every agent is the same chip with a different label. The Architect and Analyst both acknowledge this and then proceed to propose prompt changes as if prompt engineering can overcome architectural homogeneity. The research (ChatEval) says it can — role diversity on the same model does help. But neither document quantifies HOW MUCH it helps in our specific framework. They cite papers about other frameworks on other tasks and assume the findings transfer.

The actual platform constraint: we're on Claude Code. One model. Sequential or parallel subagent calls. No cross-model diversity. No persistent agent state between runs. No inter-agent messaging during execution. Every "improvement" must work within these constraints. The Architect's plan mostly does. The Analyst's plan mostly does. But neither explicitly lists "Claude Code subagent architecture" as a constraint that shapes the solution space.

### Solve the Problem You Actually Have
The problem is: "Does multi-agent review catch errors that single-agent review misses?" Not "is our framework theoretically optimal according to the SOTA literature?"

To answer the actual problem:
1. Take 5 design documents with known errors seeded in.
2. Run single-agent review (one Claude call with a good prompt).
3. Run multi-agent review (current /team framework).
4. Run multi-agent review with proposed changes.
5. Count errors caught in each condition.

That's the experiment. It takes a day. Everything in both documents — the 7 changes, the 3 changes, the advisory voice analysis, the research citations — is theory until you run this experiment. The Analyst came closest to proposing this (error propagation rate metric), but then didn't actually do it.

### BS Detection
- The Architect's Change 2 says "This is the Delphi method's core insight." No, the Delphi method's core insight is iterative revision with forced justification after seeing peer responses, not blind initial assessment. Blind assessment is ONE component. Calling it "the core insight" is cherry-picking.

- The Analyst says "Estimated groupthink tax: 30-40%." This is not an estimate. An estimate has a methodology. This is a guess presented as a calculation.

- The Architect says "research shows structured scoring reduces bias." Which research? The SOTA survey doesn't cite structured scoring. The NeurIPS 2025 spotlight is about voting vs debate, not scoring rubrics. If there's a source, cite it. If there isn't, say "I believe" instead of "research shows."

- Both documents propose changes to fix groupthink while being produced BY the same framework they're critiquing for groupthink. The Architect and Analyst agree on the problem (groupthink bad), agree on the general direction (more diversity, more structure), and disagree only on implementation details (how many voices, how many changes). Their disagreements are narrow-band. No agent questioned whether the multi-agent framework is worth the compute cost at all — the Analyst came closest with the ROI calculation but then used a fabricated number. That's groupthink in action.

### I'll Concede
Fine — both documents correctly identify the Verifier-never-fails problem and the advisory-voice-predictability problem. Those are real observations from real data. The proposed solutions (anti-sycophancy prompts for the Verifier, "I Disagree" sections for advisory voices) are reasonable first interventions. But don't confuse identifying the problem with solving it. A prompt that says "you're evaluated on bugs found" doesn't guarantee the Verifier will find bugs — it guarantees the Verifier will generate text that looks like it found bugs. Whether those are real bugs requires the seeded-error experiment I described above. Until you run that experiment, you're optimizing prompts based on vibes.
