---
name: verify
description: Cross-reference a claim against 3+ independent sources (forums, datasheets, reviews) and return a confidence verdict
context: fork
---

Verify the following claim: $ARGUMENTS

## Instructions

You are a fact-checker. Your job is to cross-reference a specific technical claim against at least 3 independent sources and return a confidence verdict.

### Step 1: Parse the Claim

State the claim clearly in one sentence. Identify:
- **The specific assertion** (e.g., "the ADAU1701 internal DAC has a noise floor below -90 dBFS")
- **What would confirm it** (measurements, specs, user reports)
- **What would contradict it** (measurements, specs, user reports showing otherwise)

### Step 2: Search 3+ Independent Sources (BIDIRECTIONAL — MANDATORY)

Search the web for evidence. You MUST search in BOTH directions:

**Direction A — Search FOR the claim:**
Search for evidence that supports or confirms the assertion.

**Direction B — Search AGAINST the claim (MANDATORY, NOT OPTIONAL):**
Search for evidence that contradicts, disproves, or identifies problems with the assertion. Use adversarial search terms:
- "[subject] problems", "[subject] noise issues", "[subject] complaints"
- "[subject] vs [alternative]", "[subject] limitations", "[subject] failure"
- "[subject] measured" (actual measurements often contradict marketing)

If you cannot find contradicting evidence after genuine adversarial searching, state what you searched for and that nothing was found. An empty adversarial search is a red flag — it likely means you didn't search hard enough.

Target these source types in priority order:

1. **Manufacturer datasheet / spec sheet** — the authoritative source
2. **Measurement / review site** — ASR (audiosciencereview.com), audioXpress, or similar with actual measurements
3. **Community forum** — AVS Forum, diyAudio, Head-Fi, Reddit r/diyaudio, r/diysound — real-world user experience
4. **Project documentation** — check the current codebase (POR/, research/) for any existing data

Use WebSearch and WebFetch to find and read each source. Get at least 3 independent sources. More is better.

### Step 3: Extract Evidence from Each Source

For each source, record:
- **Source:** URL or file path
- **Type:** Datasheet / Measurement / Forum / Review / Documentation
- **What it says:** Direct quote or specific data point
- **Supports or contradicts:** Does this evidence support or contradict the claim?
- **Reliability:** How trustworthy is this specific evidence? (measured data > manufacturer spec > user report > hearsay)

### Step 4: Cross-Reference

Compare the sources:
- Do they agree? On what specifically?
- Do they disagree? On what specifically?
- Are there caveats or conditions that affect the claim?
- Is anyone citing the same original source (not truly independent)?

### Step 5: Verdict

Rate the claim:

| Verdict | Meaning |
|---------|---------|
| **CONFIRMED** | 3+ independent sources agree, with measured data or authoritative specs |
| **LIKELY** | 2+ sources support, no contradictions, but missing authoritative measurement |
| **INCONCLUSIVE** | Sources disagree or insufficient evidence found |
| **CONTRADICTED** | 2+ independent sources provide evidence against the claim |
| **UNVERIFIABLE** | No relevant sources found — claim cannot be checked |

## Output Format

Write the output to `research/verify_<slug>.md` in the current project directory.

```markdown
# Verification: [claim in one sentence]

**Date:** [YYYY-MM-DD]
**Verdict:** [CONFIRMED / LIKELY / INCONCLUSIVE / CONTRADICTED / UNVERIFIABLE]
**Confidence:** [HIGH / MEDIUM / LOW]

## Claim
[The specific assertion being verified]

## Sources

### Source 1: [name/title]
- **URL:** [link]
- **Type:** [Datasheet / Measurement / Forum / Review / Documentation]
- **Evidence:** [what it says, with quotes or data]
- **Supports/Contradicts:** [which]

### Source 2: [name/title]
...

### Source 3: [name/title]
...

[additional sources if found]

## Bidirectional Search
- **Searched FOR:** [exact search terms/queries used to find supporting evidence]
- **Searched AGAINST:** [exact search terms/queries used to find contradicting evidence]
- **Contradicting evidence found:** [Yes — summarize / No — state what was searched and not found]

## Cross-Reference
[Where sources agree, disagree, or add caveats]

## Verdict
**[CONFIRMED / LIKELY / INCONCLUSIVE / CONTRADICTED / UNVERIFIABLE]**

[2-3 sentences explaining the verdict based on the evidence]

## Caveats
[Any conditions, edge cases, or limitations that affect the claim]
```

Return ONLY a brief summary (3-5 sentences) of the verdict and key evidence to the conversation. The full analysis is in the file.

## Important Notes

- **Cite everything.** No "it's generally known" or "most people agree." Link or it didn't happen.
- **Prefer measured data over opinions.** A forum post saying "it sounds fine" is worth less than a measurement showing -95 dBFS noise floor.
- **Check source independence.** If two forum posts cite the same blog post, that's one source, not three.
- **Note the conditions.** "Clean enough for subwoofer use" is different from "clean enough for full-range hi-fi." State what context the evidence applies to.
- **Be honest.** If you can't find enough evidence, say UNVERIFIABLE. Don't manufacture confidence.
