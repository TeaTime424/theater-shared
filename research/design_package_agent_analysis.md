# Design Package Agent Analysis

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-20
**Related:** D:/Projects/Claude/theater/.claude/skills/design-package.md, .claude/commands/team.md

## Executive Summary

The current design-package skill applies the full team framework (7 voices, 6 phases) uniformly across every stage. Analysis shows that roughly half the advisory voice invocations add genuine value and half are overhead. The pipeline is structurally sound but over-staffed for mechanical phases and under-specified on adversarial checks for the phases where bias risk is highest. Optimization target: reduce 5-voice advisory overhead on build phases, concentrate adversarial challenge on the 3 decision points where bias risk is highest (budget, T/S-based performance claims, cabinet height selection).

---

## Phase-by-Phase Agent Assessment

### Phase 1: Audit — Architect + Analyst (Parallel)

**What the work actually is:**
- Architect: read 16+ POR docs + investigation verdicts, identify what's settled vs contested, design the document tree and diagram list
- Analyst: extract every budget line item, calculate SPL/throw/room mode numbers, flag arithmetic errors

**Optimal agents:**
- Architect: YES — system decomposition and dependency identification is exactly the Architect's role
- Analyst: YES — quantitative baseline is genuinely useful before critique and speeds Phase 2
- Both in parallel: YES — no dependencies between them, parallelism is correct

**Advisory voices needed:**
- Senior: YES on Architect output. The Architect's natural failure mode is over-engineering the document tree (14 docs when 6 would do). Senior is the corrective force.
- Acton: YES on Analyst output. Acton's "show me the data" lens is exactly right for catching unsourced numbers and duplicate/stale specs. This is his primary value.
- Cost Cutter: YES on Analyst output. Catches optimism bias in budget line items — specifically the pattern of underestimating labor and shipping.
- New Grad: MARGINAL. Pushing for "modern tooling" during a document-tree design pass adds noise. The real decisions here are structural (which docs, what scope), not technical.
- Bass Head: NO for Phase 1. Sub performance numbers are Analyst territory. Bass Head's position on extension is known; having him re-litigate it in the planning phase delays consensus without new data.

**Bias risks in this phase:**
- Anchoring bias (Architect): will anchor on whatever structure the POR already has. Senior and Acton both push back on this.
- Optimism bias (Analyst): will underestimate budget by accepting stated totals without re-summing line items. Cost Cutter is the corrective.
- Confirmation bias: accepting the design-package "known corrections" list as complete without checking whether new contradictions exist in the POR docs.

**Verdict:** Run Architect + Analyst in parallel. Include Senior + Acton + Cost Cutter as advisories. Drop New Grad and Bass Head from Phase 1.

---

### Phase 2: Critique (Sequential)

**What the work actually is:**
- Critic reads both Phase 1 outputs and finds: conflicts between them, arithmetic errors, unsupported assertions, scope problems, irreversible decisions
- This is the primary adversarial gate before build

**Optimal agent:**
- Critic: YES — this phase exists specifically for adversarial review. No substitution.

**Advisory voices needed:**
- Acton: YES. The Critic tends toward process critique ("the plan is missing X"). Acton redirects to data critique ("the plan asserts Y without a number — where's the datasheet?"). These are complementary and non-redundant.
- Senior: YES. Complexity check on the proposed document structure is legitimate here.
- Cost Cutter: YES. Budget arithmetic verification is a core Critic responsibility, and Cost Cutter provides the discipline lens. Together they catch what the other misses — Critic finds structural gaps, Cost Cutter finds arithmetic errors.
- Bass Head: YES but NARROWLY SCOPED. The one place Bass Head adds genuine value in Phase 2 is the sub cabinet height decision — this is an open unresolved question (72" vs 96" vs 120"), not a settled spec. Bass Head should provide the LF extension numbers for each option. Limit to that scope.
- New Grad: NO. Phase 2 is adversarial review of a plan. New Grad pushes for modern tooling alternatives. These are different activities. New Grad's input ("use a better diagramming library") doesn't improve the Critic's adversarial function.

**Bias risks in this phase:**
- The Critic can develop confirmation bias toward the Architect's framing (anchoring from reading the plan first). The "blind assessment" step in agent-critic.md is the mitigation — verify this step is actually enforced.
- The Critic can manufacture objections to justify its existence. Mitigated by: "if you find nothing wrong, say so."

**Verdict:** Critic + Acton + Senior + Cost Cutter + Bass Head (sub cabinet scope only). Drop New Grad.

---

### Phase 3: Decision Gate

**What the work actually is:**
- Synthesize Phase 1-2 outputs into a summary for the user
- Present verdict and ask proceed/adjust/stop
- This is a coordination step, not a research or analysis step

**Optimal agent:**
- This is the main conversation / dispatcher role — NOT a specialist agent
- No subagent should be launched here

**Advisory voices needed:**
- NONE. The decision gate presents what the agents found. It does not generate new analysis.
- Including advisory voices at this stage creates the appearance of additional deliberation without adding information content.

**Bias risks in this phase:**
- Framing bias: how the summary is presented influences the user's decision. Mitigation: present findings as found, not filtered. Show the Critic's exact verdict, not a softened interpretation.

**Verdict:** Main conversation synthesizes and presents. No advisory voices. No subagents.

---

### Phase 4: Build

**What the work actually is:**
This is the largest phase. It breaks into functionally distinct subtasks:

**4a. specs.yaml generation**
- Pure data extraction: read POR docs, extract every number, write structured YAML
- Mechanical with high-stakes correctness requirement (it's the single source of truth)
- Optimal: Builder only. No advisory voices — they add latency without improving a data extraction task.
- Quality gate: correctness, not cleverness. The Verifier catches errors; advisories don't.

**4b. Markdown document generation (01-06)**
- Technical writing with embedded calculations
- Each doc has judgment requirements: "show your math," "include critical assessment," "explain WHY the choice is correct"
- Optimal: Builder, but the calculation sections benefit from Analyst verification inline
- New Grad: NO. These are reference documents for a 2027 build. "Modern markup" doesn't matter.
- Senior: MARGINAL. The "terse, technical writing, tables over prose" directive already encodes Senior's preferences. Redundant advisory.
- Acton: YES but only for the critical assessment sections. The directive "every major decision must include WHY the current choice is correct and known weaknesses" is essentially Acton's BS Detection section applied per doc. Worth reinforcing.
- Cost Cutter: YES for 06_budget.md specifically. Arithmetic and line-item discipline matter here.
- Bass Head: YES for 03_subwoofers.md specifically. LF extension numbers and Qtc calculations require enthusiast-level precision.

**4c. Python diagram generation (d01-d04)**
- Pure code generation: produce runnable Python scripts that output PNGs
- Mechanical — correctness measured by "runs without error, output looks correct"
- Optimal: Builder only
- New Grad: MAYBE — if there's a genuine modern plotting library improvement. In practice, matplotlib is the right choice (stable, no external server dependencies, outputs static PNG). New Grad's advocacy here is noise.
- Senior: NO. The code is simple procedural plotting. No complex contracts to design.
- All others: NO.

**4d. OBJ model generation (3 models)**
- Code generation with precise coordinate requirements
- The coordinate placement errors are documented, specific, and recurring — this is a known failure mode
- Optimal: Builder + explicit validation step immediately after each model (not waiting for Phase 5 Verifier)
- Advisory voices: NONE for generation. The errors are placement errors from misreading coordinates, not conceptual errors an advisory voice catches. The fix is enforcing the coordinate table directly in the prompt.
- The current skill already documents the CRITICAL orientation notes — these need to be in the Builder prompt verbatim, not summarized.

**Overall Phase 4 verdict:** Builder for all subtasks. Advisory voices only where domain expertise materially changes output quality: Acton on critical assessment sections, Cost Cutter on budget doc, Bass Head on subwoofer doc. Zero advisories on code generation tasks.

---

### Phase 5: Verify + Analyze (Parallel)

**What the work actually is:**
- Verifier: run scripts, cross-check specs.yaml values, verify budget arithmetic, validate OBJ placements
- Analyst (final): calculate deltas vs source docs, list corrections, assess team performance

**Optimal agents:**
- Verifier: YES — this is exactly the Verifier's role. Script execution, consistency checks, arithmetic validation.
- Analyst: YES for final delta analysis. Useful for tracking what the team actually corrected vs what was already in source docs.

**Advisory voices needed:**
- Senior on Verifier: YES. "Is the critical path covered? Are error cases tested?" Senior forces verification of the placement validation (the documented recurring failure). This is the one check most likely to be skipped under time pressure.
- Acton on Verifier: YES. The mandatory placement validation section already reads like Acton's "show me the data" — coordinate X near 342-348 or not. Worth reinforcing that this check is not optional.
- New Grad: NO. "Could these tests be automated better?" is a valid question in a software project with CI. In a one-off document generation pipeline, it's noise.
- Bass Head: NO. Verification doesn't benefit from LF advocacy.
- Cost Cutter: MARGINAL on Analyst final. Only useful if the Analyst's delta analysis reveals new budget implications. Include conditionally.

**Verdict:** Verifier + Senior + Acton. Analyst + Cost Cutter (conditional). Drop New Grad and Bass Head from Phase 5.

---

### Phase 6: Report

**What the work actually is:**
- Synthesize all phase outputs into final summary
- Report files built, verification verdict, budget impact, unresolved issues

**Optimal agent:**
- Main conversation. No subagent.

**Advisory voices needed:**
- NONE. This is a reporting step. Advisory voices at the report stage generate content that has no downstream action.
- New Grad vs Senior scorecard (currently in team.md) is useful if there were actual contested decisions. Include conditionally — only if Phase 2 or Phase 4 produced real New Grad/Senior disagreements.

---

## Where Adversarial Challenge Is Genuinely Needed

These are the three phases where bias risk is highest and adversarial challenge changes outcomes:

### 1. Budget line items (Phase 1 Analyst + Phase 2 Critic)

**Bias:** Optimism bias. Source docs have documented arithmetic errors (Phase 1 and Phase 2 totals disagree). The known corrections list includes "verify budget arithmetic programmatically."

**Adversarial mechanism needed:** Programmatic re-sum of every line item (Python, not mental math). Cost Cutter challenges each line item. Critic flags any total that doesn't match.

**Current coverage:** Adequate if Cost Cutter advisory is kept on Analyst and budget arithmetic check is on Critic. The weak point is that "verify budgets" is listed as one bullet among many in the current skill — it needs to be a mandatory step with BLOCKER status if it fails.

### 2. Performance claims from T/S parameters (Phase 1 Analyst + Phase 2 Critic)

**Bias:** Confirmation bias. The design-package known corrections list explicitly notes that incorrect T/S parameters (Vas=15.5, Qts=0.36) appear in some project docs. An agent that reads the POR and accepts the numbers is wrong.

**Adversarial mechanism needed:** Every T/S-derived SPL or Fc calculation must cite a specific source (Dayton spec sheet, not project docs). The correct values (Vas=8.77 cu ft, Qts=0.53, Fs=22 Hz) must be sourced from the Parts Express listing, not copied from earlier documents.

**Current coverage:** The known corrections list documents this, but there's no explicit adversarial check in the Phase 2 Critic scope. Acton is the right voice to enforce "where's the datasheet page number?" on every T/S claim.

### 3. Sub cabinet height selection (Phase 2 Critic / open decision)

**Bias:** Anchoring bias. The first number in the docs (72") will tend to win by default unless the team is forced to calculate all three options. The current skill correctly identifies this as unresolved and demands team assessment.

**Adversarial mechanism needed:** Bass Head + Analyst must produce Fc/Qtc/F3 for all three height options (72", 96", 120") before Phase 2 concludes. Cost Cutter must calculate the material cost differential. The Critic must make an explicit recommendation with rationale, not leave it open.

**Current coverage:** The design-package skill documents the question correctly but doesn't assign a clear owner to resolve it. This needs an explicit task assignment in Phase 2.

---

## Where Advisory Voices Add Noise vs Signal

| Advisory Voice | Adds Signal In | Adds Noise In |
|----------------|----------------|---------------|
| New Grad | Code generation (rarely — modern libs sometimes win) | Document planning, adversarial review, verification |
| Senior | Document structure (Phase 1 Architect), verification critical path | Code generation, reporting |
| Acton | Budget validation, T/S claim sourcing, OBJ placement checks | Document writing, model generation |
| Bass Head | Sub cabinet height decision, subwoofer doc calculations | Room planning, speaker docs, reporting |
| Cost Cutter | Budget doc, Phase 1 Analyst baseline, Phase 2 arithmetic | Code generation, model generation |

**Overall finding:** Advisory voices are concentrated in the planning and critique phases, where they provide genuine challenge. They are noise in build phases unless the build task has domain-specific judgment requirements (budget doc needs Cost Cutter, sub doc needs Bass Head).

---

## Which Stages Are Mechanical vs Deliberative

| Stage | Type | Rationale |
|-------|------|-----------|
| specs.yaml extraction | Mechanical | Data extraction from sources — correctness only, no judgment |
| Diagram Python scripts (d01-d04) | Mechanical | Code generation from coordinates — correctness only |
| OBJ model generation | Mechanical + high-stakes placement | Code generation, but placement errors are documented failure mode |
| Room/electrical/speaker docs (01, 02, 04, 05) | Deliberative (moderate) | Requires calculation-showing and critical assessment sections |
| Subwoofer doc (03) | Deliberative (high) | T/S calculations, Qtc selection, open cabinet height decision |
| Budget doc (06) | Deliberative (high) | Arithmetic, line item discipline, correction logging |
| Phase 1 Architect planning | Deliberative | Document scope, dependency identification |
| Phase 1 Analyst baseline | Deliberative | Quantitative sourcing, arithmetic validation |
| Phase 2 Critique | Deliberative (adversarial) | Conflict resolution, blind assessment, failure thresholds |
| Phase 5 Verification | Mechanical + judgment | Script execution is mechanical; placement validation requires explicit checks |

---

## Current Over-Application of Team Dynamics

The current `/team` command specifies: "All advisory voices are not separate agents — they are additional perspectives baked into every phase agent's prompt. Each phase agent must produce the functional output AND include all advisory sections."

This means a Builder generating a diagram Python script produces:
- The script (the actual deliverable)
- New Grad's take on the script
- Senior's take on the script
- (If used in design-package) Acton's take, Bass Head's take, Cost Cutter's take

For a 50-line matplotlib script that draws a floor plan from known coordinates: this is pure overhead. The New Grad will suggest "use Plotly for interactivity." The Senior will say "test it first." Neither changes the output. The script either runs and produces the correct PNG or it doesn't. That's a Verifier question, not an advisory question.

**Estimated overhead reduction from targeted advisory application:**
- Phases 1-2 (planning + critique): Keep most advisories — they add genuine value
- Phase 4 (build): Drop to task-appropriate advisories only — estimate 40-50% reduction in advisory output with zero quality loss on mechanical tasks
- Phase 5 (verify): Keep Senior + Acton, drop others
- Phase 6 (report): Drop all advisories

---

## Recommended Advisory Voice Matrix (Optimized)

| Phase / Task | Architect | Analyst | Critic | Builder | Verifier | New Grad | Senior | Acton | Bass Head | Cost Cutter |
|---|---|---|---|---|---|---|---|---|---|---|
| Ph1: Architect planning | PRIMARY | — | — | — | — | — | ADV | ADV | — | — |
| Ph1: Analyst baseline | — | PRIMARY | — | — | — | — | — | ADV | — | ADV |
| Ph2: Critique | — | — | PRIMARY | — | — | — | ADV | ADV | SCOPED* | ADV |
| Ph4: specs.yaml | — | — | — | PRIMARY | — | — | — | — | — | — |
| Ph4: docs 01/02/04/05 | — | — | — | PRIMARY | — | — | — | ADV | — | — |
| Ph4: doc 03 (subs) | — | — | — | PRIMARY | — | — | — | ADV | ADV | — |
| Ph4: doc 06 (budget) | — | — | — | PRIMARY | — | — | — | — | — | ADV |
| Ph4: diagrams (code) | — | — | — | PRIMARY | — | — | — | — | — | — |
| Ph4: OBJ models (code) | — | — | — | PRIMARY | — | — | — | — | — | — |
| Ph5: Verification | — | — | — | — | PRIMARY | — | ADV | ADV | — | — |
| Ph5: Analyst final | — | PRIMARY | — | — | — | — | — | — | — | COND** |

*SCOPED: Bass Head limited to sub cabinet height decision calculation only
**COND: Cost Cutter on final Analyst only if new budget implications emerged

---

## Summary Recommendations

1. **Keep the 6-phase structure.** The Architect → Critic → Builder → Verifier sequence is sound. The decision gate at Phase 3 is valuable.

2. **Drop New Grad from all non-code phases.** New Grad's value is challenging tool choices in code generation contexts. For document planning, adversarial review, and verification, it adds zero unique signal.

3. **Drop Bass Head from all phases except Phase 2 (sub cabinet scoped) and Phase 4 doc 03.** Bass Head's position on extension and headroom is known and documented in the design. Re-stating it in every phase is redundant.

4. **Keep Acton in Phases 1, 2, and 5.** The "show me the data / where's the datasheet" pressure is high-value specifically where unsourced numbers flow through. This is the most consistently useful advisory voice in this pipeline.

5. **Keep Cost Cutter in Phases 1 (Analyst) and 2 (Critic) and 4 (budget doc).** Budget arithmetic discipline is a documented failure mode in the source documents.

6. **Make three adversarial checks mandatory with BLOCKER status:**
   - Budget arithmetic: re-sum every line item in Python, compare to stated totals. If they disagree, BLOCKER.
   - T/S parameter sourcing: every Fc/Qtc/F3 calculation must cite Dayton spec sheet, not project docs. If sourced from project docs, BLOCKER.
   - OBJ placement validation: door X near 342-348, closet X in 90-138, screen Z near 248-276. If wrong, BLOCKER.

7. **Resolve the cabinet height question in Phase 2, not Phase 4.** This is a design decision (Fc, Qtc, F3 for 72"/96"/120" with correct T/S parameters), not a build task. Leaving it open until Phase 4 means the Builder makes a design call under time pressure.

8. **Mechanical build phases (specs.yaml, diagram code, OBJ code) need no advisory voices.** The correctness check is: does the script run? Does the output match the coordinates? These are Verifier questions. Advisory voices on mechanical tasks produce output that is read and discarded.

---

## Bidirectional Search

This analysis is based on reading the actual skill files. No web research was conducted — the assessment is structural, based on comparing agent role definitions to the work each pipeline stage actually requires.

- **Searched FOR:** cases where advisory voices are uniquely capable (not redundant to primary agent)
- **Searched AGAINST:** cases where advisory voices duplicate findings the primary agent would reach independently, where advisory overhead exceeds advisory value, where removing a voice causes loss of a distinct perspective
- **Contradicting evidence found:** Yes — the team.md skill itself acknowledges skip conditions ("trivial changes: skip to Builder, then Verifier. New Grad and Senior still advise.") but then states "New Grad and Senior are ALWAYS included regardless." This internal contradiction is worth resolving: if skip conditions exist, advisory voices should also be scoped to the phase type.

---

## Sources

All sources are local project files:
1. `D:/Projects/Claude/theater/.claude/skills/agent-architect.md`
2. `D:/Projects/Claude/theater/.claude/skills/agent-critic.md`
3. `D:/Projects/Claude/theater/.claude/skills/agent-builder.md`
4. `D:/Projects/Claude/theater/.claude/skills/agent-verifier.md`
5. `D:/Projects/Claude/theater/.claude/skills/agent-analyst.md`
6. `D:/Projects/Claude/theater/.claude/skills/agent-newgrad.md`
7. `D:/Projects/Claude/theater/.claude/skills/agent-senior.md`
8. `D:/Projects/Claude/theater/.claude/skills/agent-acton.md`
9. `D:/Projects/Claude/theater/.claude/skills/agent-basshead.md`
10. `D:/Projects/Claude/theater/.claude/skills/agent-costcutter.md`
11. `D:/Projects/Claude/theater/.claude/commands/team.md`
12. `D:/Projects/Claude/theater/.claude/skills/design-package.md`
