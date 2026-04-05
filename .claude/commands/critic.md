---
name: critic
description: Run the Critic agent to review a plan or implementation
---

Run the Critic agent to review: $ARGUMENTS

Read the role definition at `.claude/skills/agent-critic.md` and follow it exactly.

Launch a single `subagent_type: general-purpose` agent with the Critic role. It should:
1. Read the plan, implementation, or proposal being reviewed
2. Find issues, gaps, conflicts, and scope problems
3. Present a severity-ranked issue table and verdict (PROCEED / PROCEED WITH CHANGES / RETHINK)
