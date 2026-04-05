# Skill: Conversation Handoff

## Description
Generates a structured handoff document that captures the current conversation's context, decisions, and pending work so a new Claude Code session can continue seamlessly. The handoff file is written to `D:\Projects\Claude\handoffs/` and committed to git.

## When to Use

Use when:
- The conversation is running long and context compression is degrading quality
- The user needs to restart Claude Code (e.g., MCP config change, update, battery)
- The user wants to continue on a different machine
- The session is about to hit context limits
- The user says "handoff", "continue later", "wrap up for now", "save state"
- `/handoff` is invoked

## Procedure

### Step 1: Generate the Handoff Document

Analyze the full conversation and write `D:\Projects\Claude\handoffs/<date>-<slug>.md` with this structure:

```markdown
# Handoff: <short title>

**Date:** YYYY-MM-DD HH:MM
**Session:** <session slug if available>
**Project:** <which project(s) were being worked on>
**Model:** <model used>

## What Was Done This Session

Bulleted list of everything accomplished — commits made, files changed, decisions taken, investigations run. Include commit hashes where available.

## Current State

### Files Modified (uncommitted)
- List any uncommitted changes and their purpose

### Key Decisions Made
- Decision 1 — rationale
- Decision 2 — rationale

### Investigations Run
- List any /investigate results with verdicts

## What Was In Progress When Session Ended

Describe any incomplete work — what was being done, what step it was on, what remains.

## Pending Work (from TODO.md)

Pull the current TODO.md contents or summarize the outstanding items.

## Context the Next Session Needs

### Key Numbers
- Budget: $X
- Room: dimensions
- Any critical specs that were being actively discussed

### Important Constraints or Preferences Expressed
- Things the user said that shaped decisions (e.g., "functional not pretty", "the derating is a big deal")

### Files to Read First
- List the 3-5 most important files for the next session to read to get up to speed

## How to Resume

Paste this into the new session:
```
I'm continuing from a previous session. Read the handoff document at D:\Projects\Claude\handoffs/<filename>.md and pick up where we left off.
```
```

### Step 2: Commit

```bash
cd D:\Projects\Claude && git add handoffs/<filename>.md && git commit -m "Add handoff: <short description>"
```

### Step 3: Tell the User

Print the resume command they should paste into the new session.

## Important Notes

- **Be thorough but concise.** The handoff replaces the entire prior conversation context. Miss something important and the next session won't know about it.
- **Include commit hashes.** The next session can `git log` to verify state.
- **Include the user's exact words** for preferences and constraints that shaped decisions — don't paraphrase into something weaker.
- **List files to read** in priority order — the next session should not need to explore the entire codebase.
- **Pull from TODO.md** — the handoff should be consistent with the task list.
