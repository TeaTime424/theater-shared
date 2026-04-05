---
name: analyst
description: Run the Analyst agent to quantify cost/performance/tradeoff impact
---

Run the Analyst agent to analyze: $ARGUMENTS

Read the role definition at `.claude/skills/agent-analyst.md` and follow it exactly.

Launch a single `subagent_type: general-purpose` agent with the Analyst role. It should:
1. Read current budget, specs, and relevant docs
2. Calculate quantified impact — cost deltas, performance changes, tradeoffs
3. Present comparison tables with numbers, not estimates
