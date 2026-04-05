# Skill: Structured Adversarial Investigation

## Description
Runs a rigorous 4-agent adversarial investigation to evaluate a design decision, tradeoff, or alternative. All outputs are saved to `D:\Projects\Claude\investigations/<slug>/` and committed to the root git repo.

## When to Use

Use this skill when the user asks to **investigate**, **evaluate**, or **compare** a design decision, tradeoff, or alternative. Typical triggers:

- "investigate whether..."
- "should we use X instead of Y?"
- "evaluate the case for..."
- "compare Option A vs Option B"
- "is it worth switching to..."
- `/investigate [premise]`

## Example Invocations

- `/investigate whether Option D (N-S partition, 17x23 theater) should replace the POR layout`
- `/investigate whether we should use a 170" 16:9 screen instead of 170" 2.35:1`
- `/investigate whether forward-facing nearfield subs are better than dual-opposed`
- `/investigate whether we should replace the AVR-A1H with a Marantz AV10 + separate amps`
- `/investigate whether sealed corner subs are better than ported for this room`

## Output Directory

All investigation artifacts are saved to `D:\Projects\Claude\investigations/<slug>/` where `<slug>` is a short kebab-case title derived from the premise (e.g., `option-d-vs-por`, `16x9-vs-scope-screen`).

The directory contains:

```
D:\Projects\Claude\investigations/<slug>/
├── 00_premise.md          # Framing: premise, status quo, evaluation axes, constraints
├── 01_pro_researcher.md   # Agent 1 output: case FOR the premise
├── 02_con_researcher.md   # Agent 2 output: case AGAINST the premise
├── 03_pro_adversary.md    # Agent 3 output: stress test of Con case
├── 04_con_adversary.md    # Agent 4 output: stress test of Pro case
├── 05_verdict.md          # Synthesis: findings, contested points, recommendation
├── README.md              # One-paragraph summary + verdict for quick reference
└── 06+_*.md               # Optional follow-up assessments (numbered sequentially)
```

After writing all files, commit the entire directory to the ROOT git repo:
```
cd D:\Projects\Claude && git add investigations/<slug>/ && git commit -m "Add investigation: <short premise summary>"
```

## Procedure

### Step -1: Check for Prior Investigations

**BEFORE starting a new investigation**, check if a relevant prior investigation exists:

1. List all directories in `D:\Projects\Claude\investigations/`
2. Read the `README.md` of any investigation whose slug relates to the current premise
3. If a prior investigation covers the same or very similar premise:
   - Read its `05_verdict.md` to understand the prior conclusion
   - Assess whether **meaningful new information** has emerged since that investigation:
     - New specs, pricing, or product availability?
     - Design changes that alter the premise (e.g., room dimensions changed, budget changed)?
     - User feedback that shifts priorities?
     - New research or documents added to the project?
   - If NO meaningful change: **Do not re-investigate.** Tell the user the prior investigation still applies, cite the verdict, and ask if they want to override.
   - If YES meaningful change: Proceed with the investigation but note in `00_premise.md` that this is a **re-investigation** with a link to the prior investigation and a summary of what changed.

### Step 0: Frame the Premise

Before launching agents, clearly state and WRITE to `D:\Projects\Claude\investigations/<slug>/00_premise.md`:

1. **The premise under investigation** — a single declarative proposition (e.g., "Option D is a better layout than the POR")
2. **The status quo** — what the POR currently specifies (the default "no change" position)
3. **Key dimensions to evaluate** — identify 3-6 evaluation axes relevant to this question (e.g., acoustic performance, cost, build complexity, room utility, aesthetics, WAF, future-proofing)
4. **Known constraints** — budget, room dimensions, equipment already purchased, build timeline, etc.

### Step 1: Launch Pro Researcher and Con Researcher (Parallel)

Launch **two agents in parallel** using `subagent_type: general-purpose`:

---

**Agent 1 — Pro Researcher**

Prompt the agent with:

```
You are the PRO RESEARCHER in an adversarial investigation framework.

PREMISE UNDER INVESTIGATION: [state the premise]

STATUS QUO (POR): [brief summary of current POR position]

YOUR ROLE: Build the strongest possible case FOR the premise. You are an advocate, not a neutral party. Find every legitimate argument, data point, calculation, and reference that supports adopting the premise.

INSTRUCTIONS:
1. Search the codebase thoroughly — POR/ documents, research/ documents, experiments/, tools/, and any relevant files. Cite specific files with absolute paths and line numbers.
2. For technical claims, show calculations or reference specs with numbers (dB, watts, Hz, dollars, dimensions).
3. Identify 5-10 distinct arguments supporting the premise, ranked by strength.
4. For each argument, provide: the claim, the evidence, and the source.
5. Acknowledge the 1-2 weakest points in your own case (intellectual honesty makes your strong points more credible).
6. If web research would strengthen the case, use WebSearch/WebFetch for manufacturer specs, acoustic research, or expert opinions.

OUTPUT FORMAT:
## Case FOR: [premise]

### Argument 1: [strongest argument]
**Claim:** ...
**Evidence:** ...
**Source:** [file path, line number, URL, or calculation]

### Argument 2: [next strongest]
...
[continue for all arguments]

### Acknowledged Weaknesses in the Pro Case
- ...

### Summary
[2-3 sentence summary of the strongest reasons to adopt the premise]

IMPORTANT: Write your complete output to the file: [D:\Projects\Claude\investigations/<slug>/01_pro_researcher.md]
```

---

**Agent 2 — Con Researcher**

Prompt the agent with:

```
You are the CON RESEARCHER in an adversarial investigation framework.

PREMISE UNDER INVESTIGATION: [state the premise]

STATUS QUO (POR): [brief summary of current POR position]

YOUR ROLE: Build the strongest possible case AGAINST the premise (i.e., in favor of the status quo or an alternative). You are an advocate for NOT adopting the premise. Find every legitimate argument, data point, calculation, and reference that supports rejecting it.

INSTRUCTIONS:
1. Search the codebase thoroughly — POR/ documents, research/ documents, experiments/, tools/, and any relevant files. Cite specific files with absolute paths and line numbers.
2. For technical claims, show calculations or reference specs with numbers (dB, watts, Hz, dollars, dimensions).
3. Identify 5-10 distinct arguments against the premise, ranked by strength.
4. For each argument, provide: the claim, the evidence, and the source.
5. Consider: costs, risks, integration complexity, things that break, hidden assumptions in the premise, opportunity costs, and what the premise's advocates might be overlooking.
6. Acknowledge the 1-2 weakest points in your own case.
7. If web research would strengthen the case, use WebSearch/WebFetch for manufacturer specs, acoustic research, or expert opinions.

OUTPUT FORMAT:
## Case AGAINST: [premise]

### Argument 1: [strongest argument]
**Claim:** ...
**Evidence:** ...
**Source:** [file path, line number, URL, or calculation]

### Argument 2: [next strongest]
...
[continue for all arguments]

### Acknowledged Weaknesses in the Con Case
- ...

### Summary
[2-3 sentence summary of the strongest reasons to reject the premise]

IMPORTANT: Write your complete output to the file: [D:\Projects\Claude\investigations/<slug>/02_con_researcher.md]
```

---

### Step 2: Wait for Agents 1 & 2 to Complete

Collect both outputs. Read the files they wrote. Do not proceed until both are finished.

### Step 3: Launch Pro Adversary and Con Adversary (Parallel)

Launch **two more agents in parallel** using `subagent_type: general-purpose`, passing the outputs from Step 1:

---

**Agent 3 — Pro Adversary (Attacks the Con Case)**

Prompt the agent with:

```
You are the PRO ADVERSARY in an adversarial investigation framework. Your job is to ATTACK the Con Researcher's case — not to simply repeat the Pro case, but to find specific weaknesses, logical flaws, and unsupported claims in the arguments AGAINST the premise.

PREMISE UNDER INVESTIGATION: [state the premise]

CON RESEARCHER'S CASE (which you must attack):
[paste full output from Agent 2, or instruct agent to read D:\Projects\Claude\investigations/<slug>/02_con_researcher.md]

PRO RESEARCHER'S CASE (for reference only — do NOT simply repeat these points):
[paste full output from Agent 1, or instruct agent to read D:\Projects\Claude\investigations/<slug>/01_pro_researcher.md]

YOUR ROLE: Stress-test the Con case. For each Con argument, evaluate:
- Is the evidence actually cited, or is it assumed/hand-waved?
- Are the numbers correct? Do the calculations check out?
- Is there a false equivalence, straw man, or moved goalpost?
- Does the argument apply to the ACTUAL premise, or a different scenario?
- Is the risk cited realistic, or is it catastrophizing?
- Is there missing context that weakens this argument?
- Does the argument prove too much (i.e., would it also argue against the status quo)?

INSTRUCTIONS:
1. Address each Con argument individually. You may validate strong arguments — your credibility depends on not being blindly contrarian.
2. Search the codebase for evidence that contradicts or weakens the Con claims.
3. Show your work: calculations, spec lookups, file references.
4. Rank the Con arguments from "valid concern" to "weak/unsupported."

OUTPUT FORMAT:
## Stress Test of the Con Case

### Re: Con Argument 1 — [title]
**Verdict:** [Valid / Partially Valid / Weak / Unsupported]
**Critique:** ...
**Evidence:** ...

### Re: Con Argument 2 — [title]
...
[continue for all Con arguments]

### Overall Assessment
[Which Con arguments survive scrutiny? Which collapse? What is the Con case actually worth after stress-testing?]

IMPORTANT: Write your complete output to the file: [D:\Projects\Claude\investigations/<slug>/03_pro_adversary.md]
```

---

**Agent 4 — Con Adversary (Attacks the Pro Case)**

Prompt the agent with:

```
You are the CON ADVERSARY in an adversarial investigation framework. Your job is to ATTACK the Pro Researcher's case — not to simply repeat the Con case, but to find specific weaknesses, cherry-picked data, optimistic assumptions, and ignored risks in the arguments FOR the premise.

PREMISE UNDER INVESTIGATION: [state the premise]

PRO RESEARCHER'S CASE (which you must attack):
[paste full output from Agent 1, or instruct agent to read D:\Projects\Claude\investigations/<slug>/01_pro_researcher.md]

CON RESEARCHER'S CASE (for reference only — do NOT simply repeat these points):
[paste full output from Agent 2, or instruct agent to read D:\Projects\Claude\investigations/<slug>/02_con_researcher.md]

YOUR ROLE: Stress-test the Pro case. For each Pro argument, evaluate:
- Is the evidence actually cited, or is it assumed/hand-waved?
- Are the numbers correct? Do the calculations check out?
- Is there cherry-picked data or selective citation?
- Are the assumptions optimistic? What happens under pessimistic assumptions?
- Is there survivorship bias or best-case-only analysis?
- What second-order effects or integration issues are being ignored?
- Does the argument hold under the project's actual constraints (budget, room, timeline)?

INSTRUCTIONS:
1. Address each Pro argument individually. You may validate strong arguments — your credibility depends on not being blindly contrarian.
2. Search the codebase for evidence that contradicts or weakens the Pro claims.
3. Show your work: calculations, spec lookups, file references.
4. Rank the Pro arguments from "solid" to "weak/cherry-picked."

OUTPUT FORMAT:
## Stress Test of the Pro Case

### Re: Pro Argument 1 — [title]
**Verdict:** [Solid / Partially Valid / Weak / Cherry-Picked / Unsupported]
**Critique:** ...
**Evidence:** ...

### Re: Pro Argument 2 — [title]
...
[continue for all Pro arguments]

### Overall Assessment
[Which Pro arguments survive scrutiny? Which collapse? What is the Pro case actually worth after stress-testing?]

IMPORTANT: Write your complete output to the file: [D:\Projects\Claude\investigations/<slug>/04_con_adversary.md]
```

---

### Step 4: Wait for Agents 3 & 4 to Complete

Collect both outputs. Read the files they wrote.

### Step 5: Synthesize the Verdict

Using ALL FOUR agent outputs (read all files in `D:\Projects\Claude\investigations/<slug>/`), produce a structured synthesis. Do NOT simply average the positions or pick a side based on word count. Weigh arguments by the strength of their evidence after adversarial testing.

Write the synthesis to `D:\Projects\Claude\investigations/<slug>/05_verdict.md`:

```
## Investigation: [premise]

### Key Findings (Agreed by All Sides)
- [Points that both Pro and Con researchers acknowledged, and that survived adversarial testing]

### Contested Points
| Point | Pro Position | Con Position | After Adversarial Testing |
|-------|-------------|-------------|--------------------------|
| ...   | ...         | ...         | [which side's argument survived?] |

### Arguments That Survived Scrutiny
**For the premise:**
- [Only Pro arguments that Agent 4 rated "Solid" or "Partially Valid"]

**Against the premise:**
- [Only Con arguments that Agent 3 rated "Valid" or "Partially Valid"]

### Arguments That Collapsed Under Scrutiny
- [Pro arguments that Agent 4 found cherry-picked or unsupported]
- [Con arguments that Agent 3 found weak or unsupported]

### Risk Assessment
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| ...  | ...       | ...    | ...        |

### Recommendation
**Verdict:** [ADOPT / REJECT / ADOPT WITH MODIFICATIONS / DEFER — NEEDS MORE DATA]
**Confidence:** [HIGH / MEDIUM / LOW] — [brief justification for confidence level]
**Rationale:** [3-5 sentences explaining the recommendation, grounded in the arguments that survived adversarial testing]

### If Adopted, Key Implementation Notes
- [Specific changes to POR documents]
- [Budget impact]
- [Dependencies or prerequisites]

### If Rejected, What Would Change the Answer
- [Conditions under which this should be revisited]
```

### Step 6: Write README and Commit

Write `D:\Projects\Claude\investigations/<slug>/README.md`:

```
# Investigation: [premise]

**Date:** [YYYY-MM-DD]
**Verdict:** [ADOPT / REJECT / ADOPT WITH MODIFICATIONS / DEFER]
**Confidence:** [HIGH / MEDIUM / LOW]

[One paragraph summary of the investigation and its conclusion]

## Files
- `00_premise.md` — Investigation framing
- `01_pro_researcher.md` — Case FOR the premise
- `02_con_researcher.md` — Case AGAINST the premise
- `03_pro_adversary.md` — Stress test of the Con case
- `04_con_adversary.md` — Stress test of the Pro case
- `05_verdict.md` — Synthesis and recommendation
```

Then commit the entire directory:
```
git add D:\Projects\Claude\investigations/<slug>/
git commit -m "Add investigation: <short premise summary>"
```

## Important Notes

- **This is a decision-support framework, not a decision-maker.** The user makes the final call. Present the analysis, not a directive.
- **Agents must cite sources.** Vague claims like "it's generally accepted that..." are worthless. File paths, line numbers, spec sheets, or calculations.
- **Adversaries must be specific.** "The Pro case is weak" is not useful. "Pro Argument 3 claims 11 dB boundary gain but cites no measurement — the actual gain depends on frequency and wall construction" is useful.
- **The synthesis must be honest.** If the evidence overwhelmingly favors one side, say so. If it's genuinely close, say that too. Do not manufacture false balance.
- **Web research is optional but encouraged** for claims about acoustic physics, driver specs, or industry best practices that aren't in the codebase.
- **Budget impacts must be calculated**, not hand-waved. If the premise changes costs, show the math.
- **All output goes to files.** Every agent writes its output to the investigation directory. The conversation shows summaries; the files have the full analysis.
