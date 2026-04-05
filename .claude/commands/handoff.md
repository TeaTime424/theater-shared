---
name: handoff
description: Generate a handoff document so a new session can continue this conversation
---

Generate a handoff document for the current conversation following the procedure in `.claude/skills/handoff.md`.

Write the handoff to `D:\Projects\Claude\handoffs/` with filename format `<YYYY-MM-DD>-<slug>.md`.

Include everything the next session needs: what was done, current state, pending work, key decisions, important files to read, and the exact resume command to paste.

Commit the handoff to the root git repo.
