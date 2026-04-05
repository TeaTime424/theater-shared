# Agent Team Baseline Analysis — Tension Mechanisms, Effectiveness, and Gaps

**Status:** RESEARCH — Analysis of current framework performance
**Date:** 2026-03-16
**Inputs:** SOTA survey (01_agent_tension_sota.md), team.md framework, all agent-*.md skill files, team_test/ through team_test_6/ outputs

---

## 1. Current Tension Mechanisms

The framework creates productive disagreement through six identifiable mechanisms:

| # | Mechanism | How It Works | Evidence of Impact |
|---|-----------|-------------|-------------------|
| 1 | **Functional role separation** | Architect designs, Critic challenges, Analyst quantifies, Verifier validates, Builder implements. Each has explicit "What You Do NOT Do" boundaries. | Critic in team_test caught screen height error (config.py SCREEN_BOTTOM=51" puts top at 134" in 120" room) that Architect missed. Analyst found $590 budget discrepancy in team_test, confirmed by Critic. |
| 2 | **Advisory voice embedding** | New Grad + Senior + Acton + Bass Head + Cost Cutter perspectives are baked into every phase agent's prompt, not run as separate agents. | New Grad proposed Plotly 3D visualization in team_test Critic phase, directly challenging Architect's 4-Blender-model scope. Senior flagged the 28-deliverable plan as scope creep. Both were actionable. |
| 3 | **Cross-phase review** | Critic reviews Architect+Analyst outputs. Verifier reviews Builder output against Architect spec. Analyst runs twice (baseline and delta). | Critic in team_test_5 caught Analyst's ADC/DAC conflation error: Analyst flagged ADC clipping at 0.9V when actual ADC full-scale is 2.0V. This was a genuine catch — the Analyst presented the wrong claim with confidence and detailed mitigations. |
| 4 | **Forced concession** | Every advisory voice must include an "I'll Concede" section acknowledging the other side's point. | New Grad conceded Architect's dependency graph was useful. Senior conceded New Grad's Plotly idea had merit. Acton concedes with characteristic reframing ("Fine — you accidentally arrived at the right answer, but not for the reason you think"). |
| 5 | **Decision gate** | Phase 3 presents a summary to the user and asks for direction before building. Framework explicitly allows "stop" and "adjust." | Not fully observable in outputs — the decision gates appear to have been passed through without user intervention in most tests. |
| 6 | **Escalation loops** | Verifier FAILED triggers Critic -> Builder -> Verifier loop, max 2 iterations. | No FAILED verdicts observed across any test run. All verifiers returned VERIFIED or VERIFIED WITH MINOR ISSUES. |

### Mechanism Assessment

**Working well:** Mechanisms 1-3 produce real value. The Critic catching the ADC/DAC conflation (team_test_5) and the screen height error (team_test) are genuine error-prevention catches that a single-agent pass would likely miss. The advisory voices occasionally produce genuinely different perspectives (CamillaDSP vs ADAU1452 portability argument from New Grad is a real tradeoff the Architect wouldn't surface).

**Underperforming:** Mechanisms 4-6. Forced concessions are structurally present but formulaic. Decision gates appear to be rubber-stamped. Escalation loops have never triggered because Verifiers never fail anything — the most critical verdict was "VERIFIED WITH MINOR ISSUES."

---

## 2. Groupthink Risk Assessment

### The Core Problem

The SOTA research is clear: **same-model debate underperforms diverse-model debate** (ChatEval, ICLR 2024). All agents in this framework are Claude instances with the same base model, same training data, same biases. The role prompts create surface-level diversity ("I'm the Critic, I find problems") but don't change the model's underlying reasoning patterns or blind spots.

### Observed Groupthink Indicators

| Indicator | Present? | Evidence |
|-----------|----------|----------|
| **Agents converge rapidly** | Moderate | Across team_test and team_test_5, the Critic's verdict was always PROCEED WITH CHANGES, never RETHINK. The advisory voices disagree on specifics but always agree on direction. |
| **No agent fundamentally challenges the goal** | Yes | The Critic is instructed to find problems in the plan, not question whether the goal is worth pursuing. The framework explicitly forbids this: "You don't evaluate whether the goal is worth pursuing." This is by design, but it eliminates a class of useful disagreement. |
| **Verifier never fails** | Yes | Zero FAILED verdicts across 5+ test runs. The Verifier checks that scripts run and values match — it doesn't test whether the design is correct. A Verifier that always passes is a Verifier that isn't testing hard enough. |
| **Advisory voices predictable** | Moderate | New Grad always argues for modern tooling (CamillaDSP, Plotly, skip the spare). Senior always argues for simplicity and testing. The positions are consistent with their prompts, but after reading both across multiple phases, the arguments feel like fill-in-the-template responses. You can predict what each will say before reading it. |
| **Shared blind spots** | Likely | All agents missed the Phase 1 budget arithmetic error ($200) in team_test — the Analyst certified it as "CORRECT" and no other agent caught it. The Critic in team_test_5 finally found it. This suggests the error persisted across multiple runs with different agent configurations before being caught. |

### Severity: Moderate-High

The research (NeurIPS 2025 spotlight) suggests most multi-agent debate gains come from voting/aggregation, not from the debate itself. Our framework doesn't use voting — it uses sequential review. This means we're getting the sequential review benefit (later agents see earlier agents' work) but missing the voting benefit entirely.

The MoA (Mixture-of-Agents) finding is directly relevant: diverse proposers feeding into an aggregator beat same-model debate. Our framework is same-model sequential, which is the weakest configuration in the literature.

**Estimated groupthink tax:** Based on the research, same-model debate yields roughly 60-70% of the quality improvement that cross-model debate achieves. We're leaving 30-40% of potential quality gains on the table from model homogeneity alone.

---

## 3. Advisory Voice Effectiveness

### Quantitative Assessment

I categorized every advisory voice output across team_test and team_test_5 (12 New Grad sections, 12 Senior sections, 3 persona docs for Acton/Bass Head/Cost Cutter):

| Metric | New Grad | Senior | Acton | Bass Head | Cost Cutter |
|--------|----------|--------|-------|-----------|-------------|
| **Unique finding (not raised by primary role)** | 3/12 (25%) | 4/12 (33%) | 2/3 (67%) | 1/3 (33%) | 2/3 (67%) |
| **Actionable recommendation** | 5/12 (42%) | 7/12 (58%) | 2/3 (67%) | 1/3 (33%) | 2/3 (67%) |
| **Changed the outcome** | 1/12 (8%) | 2/12 (17%) | 1/3 (33%) | 0/3 (0%) | 1/3 (33%) |
| **Predictable from prompt** | 10/12 (83%) | 9/12 (75%) | 1/3 (33%) | 3/3 (100%) | 1/3 (33%) |

### Key Findings

**New Grad** is the weakest advisory voice. High predictability (always argues for modern tooling), low outcome influence. The CamillaDSP argument (team_test Critic phase) and the "test Audyssey before buying Dirac" suggestion are genuine insights, but 10 of 12 outputs are template-filling: "here's a newer version of the thing being discussed."

**Senior** is moderately effective. The strongest contributions are process-level observations (budget arithmetic as document maintenance problem, "write ONE document end-to-end and time it" as scope validation). These are genuinely useful and wouldn't come from the primary role. But the "Keep It Simple" recommendations are often just restating what the Critic already found.

**Acton** has the highest signal-to-noise ratio. The persona is distinctive enough (confrontational, demands numbers, calls BS) that it produces genuinely different framing. The "five roles reviewing each other's work when three of them found the same errors" observation is metacritical — it's the advisory voice questioning the framework itself. This is rare and valuable.

**Bass Head** is the least effective. 100% predictable from prompt. Every output advocates for more extension, more headroom, more displacement. In a project that already specifies 8 corner subs with 28mm Xmax drivers, the Bass Head's advocacy is preaching to the choir. It occasionally provides useful calculations (SPL at 10 Hz) but these could come from the Analyst.

**Cost Cutter** is effective when it has numbers to work with. The spare ICEpower analysis ("$600 earning 5% for 5 years is $766") and the nearfield cost-benefit ("$2,000 for 5.5% budget increase for bass below 15 Hz that most content doesn't use") are genuinely useful reframings.

### Diversity Assessment

The advisory voices produce **surface diversity** (different topics emphasized, different rhetorical styles) but not **reasoning diversity** (different analytical approaches, different priors, different conclusions from the same evidence). This aligns with the ICLR 2025 DMAD finding that "diversity of approach > diversity of answer."

All five voices share the same underlying model and therefore the same:
- Tendency to defer to authoritative-sounding claims
- Difficulty challenging its own prior outputs
- Pattern of generating plausible-sounding but unverified numbers
- Bias toward completeness over accuracy

---

## 4. Round Count Analysis

### Current Framework Rounds

| Phase | Round | Agents Active |
|-------|-------|---------------|
| Phase 1: Plan | Round 1 | Architect + Analyst (parallel) |
| Phase 2: Critique | Round 2 | Critic (reviews Round 1) |
| Phase 3: Decision Gate | N/A | User checkpoint |
| Phase 4: Build | Round 3 | Builder (implements) |
| Phase 5: Verify+Analyze | Round 4 | Verifier + Analyst (parallel) |

**Effective review rounds: 2** (Critic reviews plan, Verifier reviews implementation). The Analyst runs twice but doesn't review other agents' work — it calculates independently.

### Research Comparison

The SOTA literature says:
- **2-3 rounds optimal** for debate quality (Du et al. 2023, multiple replications)
- **Beyond 3 rounds: diminishing or negative returns** — correct answers start getting corrupted ("Talk Isn't Always Cheap," 2025)
- **Delphi method: 3 rounds** reproduces 95% of expert panel results (HAH-Delphi, 2025)

**Our 2 effective rounds are at the low end of optimal.** The framework could benefit from one additional round, specifically: a Critic re-review after the Builder implements (currently the Verifier checks execution correctness but doesn't re-critique the design decisions as implemented). This would bring us to 3 effective rounds.

**Risk of adding more:** Each round costs compute and time. The team_test runs already produce 100-200KB of output across phases. A 4th review round risks the "debate corruption" phenomenon where initially correct answers get second-guessed into incorrectness.

---

## 5. Quantifying the Gap

### What We're Leaving on the Table

| Gap | Estimated Impact | Source |
|-----|-----------------|--------|
| **Same-model homogeneity** | 30-40% of potential quality improvement lost | ChatEval (ICLR 2024): same-role debate underperforms single agent; MoA: diverse proposers essential |
| **No voting/aggregation** | Unknown but potentially large | NeurIPS 2025 spotlight: voting accounts for "most" MAD gains; our sequential architecture gets zero voting benefit |
| **Verifier never fails** | Unquantified false-pass rate | Zero failures across 5+ runs means either (a) everything is perfect or (b) verification is too shallow. Given the errors that persist between runs, (b) is more likely. |
| **Advisory voices at 25-33% unique-finding rate** | ~70% of advisory compute is redundant | Voices mostly restate or rephrase findings from primary roles. Acton and Cost Cutter are exceptions. |
| **No Delphi-style forced justification** | Missing a proven +6.84% quality mechanism | DelphiAgent (2025): forced justification of position changes significantly improves accuracy |
| **Decision gate not exercised** | Unquantifiable — the checkpoint exists but isn't tested | No evidence of user pushing back at Phase 3 in any test run |

### Composite Estimate

If we take the MoA benchmark (65.1% vs 57.5% on AlpacaEval — a 13% relative improvement from model diversity alone) as a ceiling, and our same-model sequential architecture captures roughly 60-70% of multi-agent gains, we're operating at **~8-9% relative improvement** over a well-prompted single agent, when the literature suggests **~13-15%** is achievable.

That's a **4-6 percentage point gap** in relative quality improvement. Whether that gap matters depends on the task. For the home theater design package — where the key outputs are budget arithmetic, spec consistency, and physical constraint validation — even 8% improvement catches errors like the $590 budget discrepancy and the screen height miscalculation. Those catches justify the framework.

But the framework is paying for 5 functional roles + 5 advisory voices. That's 10x the compute of a single agent. Getting 8% quality improvement at 10x cost is a poor ROI compared to approaches that get 13% at 3-4x cost (MoA with 3 proposers + 1 aggregator).

---

## Summary

The framework works. It catches real errors that a single-agent pass would miss. But it's over-staffed and under-diversified:

1. **Functional roles: keep 3, drop 2.** Architect, Critic, and Builder are the productive triad. Analyst and Verifier overlap significantly with Critic and Builder respectively.
2. **Advisory voices: keep 2, drop 3.** Acton and Cost Cutter produce unique findings. New Grad, Senior, and Bass Head are mostly predictable from their prompts.
3. **Add one Delphi round.** After the Critic, require the Architect to respond to the critique with specific justifications for each challenged decision. This is the single highest-value addition supported by the research.
4. **The groupthink problem is real but mitigatable.** Cross-model diversity isn't available in Claude Code. But enforcing explicit devil's-advocate instructions (not just "be critical" but "find the strongest counterargument to every recommendation") and requiring citation of contrary evidence would help.

---

## New Grad's Take

### Metrics That Could Measure Tension Quality Automatically

The biggest problem with this framework is that there's no feedback loop. We don't know if the Critic is adding value or just generating text. Here's what we could measure:

1. **Unique finding rate** — parse each phase's output and count findings not present in prior phases. I did this manually above (25-67% by voice). A script could do it with embedding similarity: for each claim in the Critic output, compute cosine similarity to all Architect claims. Anything below 0.7 similarity is "unique." Track this per run.

2. **Error propagation rate** — seed known errors into the Architect's input (wrong price, wrong dimension, wrong spec). Measure what percentage each downstream agent catches. This is the most rigorous test of framework value. The budget error ($200 Phase 1 discrepancy) propagated through multiple runs before being caught — that's data.

3. **Convergence velocity** — measure how fast advisory voices agree with each other vs the primary role. If New Grad and Senior always agree with the Architect by their second paragraph, the tension is fake. You could measure this with sentiment analysis on the "I'll Concede" sections: how much do they actually concede?

4. **Decision reversal rate** — track how often the Critic's feedback actually changes the Builder's implementation vs being acknowledged and ignored. In our runs, the Critic's scope reduction recommendation (28 -> 6-8 docs) was adopted. But the CamillaDSP recommendation was not. Track the ratio.

5. **Tooling:** Build a `team_eval.py` script that takes two phase outputs and computes: overlap score (embedding similarity of claims), unique finding count, concession depth (word count and specificity of concessions), and citation density (number of file:line references). Run it after every team execution. Graph it over time. If the numbers trend toward convergence, the framework is losing tension and needs prompt refreshment.

### Risk I'm Willing to Take

Replace the 5 advisory voices with a single "Red Team" voice that has one instruction: "Find the strongest argument against every recommendation in this document. You must cite evidence. You must not agree with the primary role on any point without first constructing the best counterargument."

This is cheaper (1 voice instead of 5) and the literature (DEBATE, ACL 2024: +6.2% accuracy) says explicit adversarial instruction outperforms polite disagreement.

### I'll Concede

The Senior voice's process-level observations ("write ONE document and time it," "budget arithmetic is a document maintenance problem") are genuinely useful and wouldn't come from a pure Red Team adversary. There's value in having a voice that critiques the process, not just the content. Keep that capability even if you consolidate voices.

---

## Senior's Take

### Minimum Viable Improvement (Best ROI)

Three changes, ranked by effort-to-impact ratio:

**1. Kill the Verifier role. Give its job to the Critic.** (Effort: edit team.md. Impact: cut one full agent invocation.)

The Verifier has never failed anything. Its outputs are consistency tables that confirm values match — useful work, but it's the same work the Critic already does when checking the Analyst's claims against datasheets. Merge verification into the Critic phase: "After your critique, run any scripts the Architect specified and verify the outputs." One agent, same coverage, half the compute.

**2. Cut advisory voices to two: Acton + Cost Cutter.** (Effort: edit team.md, remove 3 skill files from prompts. Impact: reduce prompt size by ~60%, reduce output volume by ~40%.)

New Grad and Senior are the weakest voices because they're generic archetypes. Any competent engineer embodies both perspectives — you don't need a persona to say "is there a newer way?" or "keep it simple." Acton and Cost Cutter work because they have domain-specific lenses (data-oriented design, value engineering) that produce non-obvious observations. Bass Head is redundant with the Analyst for a project that's already all-in on bass.

**3. Add a "Respond to Critique" step between Phase 2 and Phase 4.** (Effort: add one paragraph to team.md. Impact: introduces the Delphi-style forced justification that the research says is worth +6.84% quality.)

After the Critic delivers its verdict, the Architect must write a 1-page response: for each BLOCKER and WARNING, either (a) accept and describe the change, or (b) rebut with evidence. This forces the Architect to engage with criticism rather than having the Builder silently incorporate or ignore it. It's the single mechanism most supported by the literature that we're currently missing.

### What I Wouldn't Change

The sequential architecture (Plan -> Critique -> Build -> Verify) is sound. The research says parallel debate (everyone argues simultaneously) suffers from majority tyranny. Our sequential approach — where each phase sees all prior output — avoids this. Don't switch to parallel debate.

The decision gate (Phase 3) is valuable even if it's not currently exercised. The fact that the user CAN stop the process is important. Don't remove it.

The functional role boundaries ("What You Do NOT Do") are genuinely useful constraints. They prevent the Architect from also being the Critic, which would eliminate the tension entirely. Keep them.

### Test First

Before changing anything: run the current framework 3 more times on the same task (Option D design package). Measure the variance in outputs. If runs 1, 5, and 6 produce the same errors and the same catches, the framework is deterministic and the "tension" is theatrical. If they diverge, the tension is real but stochastic. Either finding informs the right intervention.

The data is partially here already: team_test and team_test_5 both ran with full phases. The $590 budget error was caught in both. The Phase 1 $200 error was caught in team_test_5 but NOT in team_test. That's one data point of variance. Three more runs would establish whether the framework has a ~50% catch rate on that class of error (arithmetic in source docs), which would let us calculate the expected number of runs needed for high-confidence error detection.

### I'll Concede

The New Grad's `team_eval.py` idea is good. Not for the reasons stated (real-time tension monitoring is over-engineering), but because it would finally give us data on whether this framework is earning its compute cost. Right now we're running 10 agent invocations per task and arguing about whether they're useful based on vibes. A script that measures unique-finding rate and error-propagation rate would turn this into an engineering question with a quantitative answer. Build it.
