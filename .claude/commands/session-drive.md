---
description: "Orchestrate multiple Claude Code sessions — dispatch work to psmux workers, poll, capture results"
---

Load the session-drive skill from `.claude/skills/session-drive.md` and follow its orchestration protocol.

**Immediate steps:**
1. Run `python -m tools.psmux list` to discover available workers
2. Show the user which sessions are available and their status
3. Ask what work to dispatch (or use the argument provided: $ARGUMENTS)
4. Follow the policy enforcement rules before sending any prompt
5. Dispatch, poll, capture, synthesize
