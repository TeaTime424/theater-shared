# Architecture: Bidirectional Verification Enforcement — 3 Targeted Fixes

## Current State

Three files need modification, based on the investigation verdict at `D:\Projects\Claude\investigations\bidirectional-verification-enforcement\05_verdict.md`:

| File | Section | Current Issue |
|------|---------|---------------|
| `D:\Projects\Claude\CLAUDE.md` | "Bidirectional Verification" (lines 21-38) | No multi-turn re-verification rule; "when in doubt, tag [UNVERIFIED]" encourages dilution |
| `C:\Users\andys\.claude\settings.json` | Stop hook prompt (line 6) | No edge case examples — Haiku guesses on gray-zone statements |
| `D:\Projects\Claude\.claude\commands\verify.md` | N/A | No changes needed — already has full bidirectional search protocol |

## Proposed Changes

### Fix 1: Multi-turn contamination rule

**File:** `D:\Projects\Claude\CLAUDE.md`
**Location:** End of the "Bidirectional Verification" section, after the current last paragraph (line 38)
**Action:** Append new paragraph

**Exact text to add (after line 38):**

```
**Multi-turn Re-verification Rule:** When a conversation transitions from casual discussion/brainstorming to a purchase or design decision, any specs or claims referenced from earlier exempt turns must be re-verified at the point of use. A spec mentioned casually 10 messages ago is not "already verified" — it was exempt from verification at the time. The Stop hook checks individual responses, not conversation history, so this rule must be followed behaviorally.
```

### Fix 2: Reduce [UNVERIFIED] dilution

**File:** `D:\Projects\Claude\CLAUDE.md`
**Location:** Line 38, the sentence `When in doubt, tag it \`[UNVERIFIED]\`.`
**Action:** Replace that sentence

**Old text:**
```
When in doubt, tag it `[UNVERIFIED]`.
```

**New text:**
```
When in doubt, run `/verify` — use `[UNVERIFIED]` only when verification is impractical in the current context (e.g., no web access, user explicitly wants a quick brainstorm, claim is peripheral to the decision).
```

### Fix 3: Add edge case examples to the Stop hook prompt

**File:** `C:\Users\andys\.claude\settings.json`
**Location:** Line 6, the `"prompt"` value in the Stop hook
**Action:** Replace the prompt string with an expanded version that includes edge case examples

**Old prompt (abbreviated for clarity — full text in the file):**
```
Review the assistant's final response (in $ARGUMENTS). Check if it contains any of these: (1) a specific product recommendation...
```

**New prompt (complete replacement):**
```
Review the assistant's final response (in $ARGUMENTS). Check if it contains any of these: (1) a specific product recommendation for purchase (e.g., 'buy X', 'order X', 'the X costs $Y', naming a specific product to use in a build), (2) a component specification for a build/design (e.g., 'use X for the output stage', 'replace Y with Z'), (3) a technical spec claim that would influence spending money or committing to a design choice (e.g., 'the output voltage is X Vrms'). EXEMPT from this check: casual discussion, brainstorming, answering questions about how things work, listing options without recommending one, and responses that are clearly continuing an already-verified discussion. EDGE CASE EXAMPLES — use these to calibrate your classification: (a) 'The Volt-10 has 95 dB sensitivity' in a general discussion about speaker specs → EXEMPT (educational, no decision being made). (b) 'Use the Volt-10 (95 dB sensitivity) for the surround channels' in a design recommendation → NEEDS VERIFICATION (component spec in a design decision). (c) 'The ICEpower 1200AS2 doesn't derate at 15 Hz unlike the NX6000D' as part of explaining why the design chose ICEpower → EXEMPT (explaining existing verified decision, not making a new one). (d) 'Switch from the NX6000D to the ICEpower 1200AS2 because it doesn't derate at 15 Hz' → NEEDS VERIFICATION (new recommendation with a spec claim driving a design change). If a purchase/design recommendation or influential spec claim is present, check whether the response ALSO contains EITHER (a) a 'Bidirectional Search' section with 'Searched FOR' and 'Searched AGAINST' entries, OR (b) an '[UNVERIFIED]' tag near the claim. If a non-exempt recommendation exists WITHOUT either marker, respond: 'UNVERIFIED_CLAIM: Response recommends [brief description] without bidirectional verification or [UNVERIFIED] tag.' Otherwise respond: 'OK'
```

## Dependencies

No ordering constraints between the 3 fixes — they are independent and can be applied in any order. All three should be applied as a set.

## Interfaces

- Fix 1 and Fix 2 modify the same file (`CLAUDE.md`) but different sections — no conflict.
- Fix 3 modifies a JSON file — the prompt string must remain valid JSON (no unescaped quotes or newlines within the string value).
- The `/verify` command referenced in Fix 2 already exists at `D:\Projects\Claude\.claude\commands\verify.md` — no new tooling needed.

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Fix 3 prompt length exceeds Haiku's effective attention window | LOW | MEDIUM | The prompt grows from ~130 words to ~220 words — well within Haiku's capacity. Monitor for timeout increases. |
| Fix 2 causes excessive /verify invocations, slowing conversations | LOW | LOW | The "impractical" escape clause provides a relief valve. User can always say "skip verification" for brainstorming. |
| Fix 1 behavioral rule is unenforceable by the hook | MEDIUM | LOW | Acknowledged by design — this is a known gap. The rule provides the behavioral norm even though it can't be mechanically enforced. It's the best available mitigation for a cross-turn problem. |
| Fix 3 JSON escaping error breaks settings.json | LOW | HIGH | Test by validating JSON after edit. Keep a backup of settings.json before modification. |

## Open Questions

None — all three fixes are fully specified and ready to implement.

---

## New Grad's Take

### What I'd Change
- Instead of a behavioral rule for Fix 1 (unenforceable), I'd build a lightweight context tracker — a small script or MCP tool that maintains a running list of unverified claims across turns, and surfaces them when the conversation shifts to decision mode. Something like a `conversation_claims.json` that the hook or a pre-response check reads. The technology exists — it's just a state machine.

### What's Outdated Here
- The Stop hook is doing NLP classification in a single prompt pass. Modern approach: use a structured output schema (tool_use or JSON mode) so Haiku returns `{"classification": "exempt"|"needs_verification", "reason": "..."}` instead of free-text "OK" or "UNVERIFIED_CLAIM:...". Structured output reduces parsing ambiguity and gives you a log you can analyze.

### Risk I'm Willing to Take
- Ship the context tracker as an MCP tool even though it adds a dependency. The multi-turn contamination gap is the highest-risk finding, and a behavioral rule is the weakest possible mitigation. Worth the added complexity.

### I'll Concede
- The edge case examples approach (Fix 3) is pragmatically correct. Few-shot prompting in classification tasks is well-established and doesn't require new infrastructure. It's the right fix for the hook.

---

## Senior's Take

### Keep It Simple
- All three fixes are text edits to existing files. No new tools, no new dependencies, no new infrastructure. That's exactly right. The investigation identified three gaps, and the plan patches three files. Nothing more.

### Contracts & Interfaces
- Fix 3's edge case examples are effectively a contract between the main model and the Haiku classifier — "here is what I consider exempt vs non-exempt." Making that contract explicit with examples instead of leaving it to interpretation is sound engineering. The examples should be drawn from actual observed ambiguities, which they are (Volt-10 sensitivity, ICEpower derating — both real project specs that have appeared in conversations).

### Test First
- Before applying Fix 3, validate the current settings.json is parseable JSON. After applying, validate again. A broken settings.json silently disables all hooks and permissions.
- For Fix 1 and Fix 2, there's no automated test — but the next conversation that hits a purchase decision will exercise them. Watch for it.

### Data Design
- The data model here is simple: a prompt string (Fix 3), a markdown paragraph (Fix 1), and a sentence replacement (Fix 2). No structural changes to any data format. That's appropriate — the investigation didn't find structural problems, it found calibration problems.

### I'll Concede
- The New Grad's point about structured output for the hook is genuinely better than free-text classification. If Haiku supports tool_use in the Stop hook context, switching to JSON output would reduce ambiguity. Worth investigating — but not in this change set.

---

## Acton's Take

### Show Me the Data
Three fixes, three text edits. The total diff is about 15 lines of text across 2 files. The investigation that produced these recommendations was 5 phases and 4 agents. The ratio of investigation to fix is approximately 50:1 by word count. That's fine — the investigation's job was to determine *which* fixes matter. These three are the ones that survived adversarial testing. Ship them.

### The Hardware Is the Platform
The "hardware" here is the Haiku classifier running in a 15-second timeout window. Fix 3 adds ~90 words to its prompt. Haiku processes roughly 100 tokens/second on classification tasks. The additional 90 words (~120 tokens) add about 1 second to processing time. The 15-second timeout is not at risk. If it were, the fix would be wrong — but it isn't, so move on.

### Solve the Problem You Actually Have
Fix 1 is the weakest of the three because it's unenforceable. The investigation correctly identified multi-turn contamination as the highest-risk gap, and the best mitigation available is a behavioral rule. That's honest — it's saying "we can't fix this mechanically, so we document it and rely on the model's instruction-following." The New Grad wants to build a context tracker. That's solving a problem you don't have yet — you haven't measured how often multi-turn contamination actually causes a bad purchase decision. If you measure it and it's frequent, build the tracker then. Until then, the behavioral rule is the correct minimal response.

### BS Detection
The investigation verdict says "MEDIUM confidence." That's honest. The system catches format violations reliably. It cannot catch quality violations (superficial adversarial search that technically has "Searched AGAINST" but didn't try hard). None of these three fixes address quality — they address classification accuracy and dilution. The quality gap remains open. Don't pretend these fixes close it.

### I'll Concede
Fine — the edge case examples in Fix 3 are a legitimate improvement. Few-shot prompting measurably improves classification accuracy in small models, and Haiku is a small model doing a classification task. The specific examples chosen (Volt-10 sensitivity in discussion vs design, ICEpower comparison vs recommendation) are drawn from real project specs that have caused actual ambiguity. That's not theoretical — that's data-driven prompt engineering. Credit where it's due.
