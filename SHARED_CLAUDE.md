# Theater Project — Shared State Repo

## What This Is

This is a **satellite repo** synced from the main home theater design project. It exists so Claude Code sessions on phone (claude.ai/code cloud) and other devices can read and edit project files without the primary laptop being online.

**Primary repo:** Local on laptop (not public)
**This repo:** `TeaTime424/theater-shared` (public, read/write from any Claude session)
**Monorepo mirror:** `TeaTime424/claude-projects` (private, full project backup)

## Sync Model

```
Laptop (source of truth)
    ↓ export (PII-scrubbed)
theater-shared (this repo)
    ↓ phone/cloud Claude edits here
    ↓ import (PII-restored)
Laptop merges changes on return
```

- **Export:** Laptop pushes eligible files here after each commit
- **Import:** Laptop pulls changes made here and merges back
- **PII scrub:** Location references are genericized on export ("Central NC")
- **Conflicts:** Laptop is authoritative. Phone changes win only for files touched on phone.

## What's Included

- `POR/` — Plan of Record design documents (specs, budget, build plans)
- `research/` — Research outputs, verification reports, comparisons
- `experiments/` — Subwoofer build specs, cut lists, build guides
- `team_test*/` — Agent team design iteration outputs
- `.claude/commands/` and `.claude/skills/` — Skill and agent definitions
- `.claude/agents/` — Custom agent definitions
- `CLAUDE.md` — Project instructions
- `todo.md` — Task tracking

## What's NOT Here

- `tools/` — Local-only scripts (DSP control, audio test, session management)
- `.claude/settings.local.json` — API keys, MCP config
- `handoffs/` — Session handoff docs with local paths
- Python scripts, .env, credentials
- Binary files (images, audio, PDFs)

## For Phone/Cloud Claude Sessions

When working in this repo:
1. Read POR docs to understand current design state
2. Edit files as needed (research, POR updates, todo items)
3. Commit and push — changes will be imported to laptop on next sync
4. Keep the same file structure — don't reorganize
5. Note: "Central NC" in files = location reference (scrubbed for privacy)

## Project Overview

9.4.6 Dolby Atmos home theater, 17'x23'x10' room, Option D N-S partition layout, 8x corner subwoofer array, ~$36.6K budget, 2027 build target. See `POR/` docs for full details.
