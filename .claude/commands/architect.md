---
name: architect
description: Run the Architect agent to design a plan for a goal
---

Run the Architect agent on the following goal: $ARGUMENTS

Read the role definition at `.claude/skills/agent-architect.md` and follow it exactly.

Launch a single `subagent_type: general-purpose` agent with the Architect role. It should:
1. Read all relevant existing files before designing
2. Produce a structured plan with dependencies, interfaces, and risks
3. Present the plan to the user for approval
