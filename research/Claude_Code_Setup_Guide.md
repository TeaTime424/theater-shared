# Claude Code Setup for Home Theater Project
## Context-Efficient Research & File Management Workflows

**Date:** February 20, 2025  
**Purpose:** Replace in-chat file I/O and web research with Claude Code agentic workflows  
**Problem Solved:** Conversation context window fills up → forced compaction → lost continuity  
**Solution:** Route heavy I/O through subagents that run in their own context windows

---

## Why Claude Code for This Project

In Claude.ai chat, every file read, web fetch, and markdown write consumes conversation context.
A single research session (5 web fetches + 2 file reads + 1 file write) can consume 30,000+ tokens,
triggering compaction within 2-3 research tasks.

Claude Code solves this by:
- Running research in **forked subagents** with their own context windows
- Only returning **summaries** to the main conversation
- Writing files **directly to disk** without routing content through chat
- Loading project context from **CLAUDE.md** instead of re-reading files each session

---

## Installation (Windows Native)

### Prerequisites
- Git for Windows (includes Git Bash) — https://git-scm.com/download/win
- Claude Pro, Max, or API Console account

### Install Claude Code

Open PowerShell (no admin required):
```powershell
# Official native installer (no Node.js needed)
irm https://raw.githubusercontent.com/anthropics/claude-code/main/install.ps1 | iex
```

Close and reopen terminal, then verify:
```powershell
claude --version
```

### Authenticate
```powershell
cd D:\Projects\Claude\theater
claude
# Follow prompts to sign in with your Claude account
```

### Verify
```
/doctor
```
Should show green checkmarks for all items.

---

## Project Structure

```
D:\Projects\Claude\theater\
├── CLAUDE.md                    # Project context (auto-loaded every session)
├── .claude/
│   ├── commands/                # Custom slash commands
│   │   ├── research.md          # /research <topic> — web research agent
│   │   ├── update-doc.md        # /update-doc <file> — edit POR documents
│   │   ├── compare.md           # /compare <A> vs <B> — product comparison
│   │   └── status.md            # /status — project overview
│   └── agents/                  # Custom subagent definitions
│       └── web-researcher.md    # Researcher subagent config
├── POR/                         # Plan of Record (design docs)
├── research/                    # Research outputs
└── experiments/                 # Experimental designs
```

---

## CLAUDE.md (Project Root)

This file is loaded automatically at the start of every Claude Code session.
It replaces the memory system and project instructions from Claude.ai chat.

Place at: `D:\Projects\Claude\theater\CLAUDE.md`

See generated file: `CLAUDE.md`

---

## Custom Slash Commands

### /research <topic>

**Purpose:** Research a topic using web search, synthesize findings, write .md to research/  
**Context impact:** Runs in forked subagent — only summary returns to main session  
**Usage:** `/research ICEpower Conductor ICC5 update availability measurements`

See generated file: `.claude/commands/research.md`

### /update-doc <file> <instructions>

**Purpose:** Read a POR document, apply specified changes, write back  
**Context impact:** Runs in fork — file content stays in subagent  
**Usage:** `/update-doc 06_Electronics_and_Control.md update amplifier section with 700AS2 alternative`

See generated file: `.claude/commands/update-doc.md`

### /compare <topic>

**Purpose:** Research and compare two or more products/options  
**Context impact:** Spawns parallel subagents for each option  
**Usage:** `/compare Hypex nCore NC252MP vs ICEpower 700AS2 for full-range speakers`

See generated file: `.claude/commands/compare.md`

### /status

**Purpose:** Quick project overview — reads key docs, summarizes current state  
**Usage:** `/status`

See generated file: `.claude/commands/status.md`

---

## Workflow Examples

### Example 1: Research a Component

**In Claude.ai chat (old way):**
1. web_search → results enter context (~2,000 tokens)
2. web_fetch page 1 → full page enters context (~5,000 tokens)
3. web_fetch page 2 → full page enters context (~5,000 tokens)
4. Read local file for comparison (~3,000 tokens)
5. Write markdown output in conversation (~4,000 tokens)
6. Filesystem:write_file → done
**Total context consumed: ~19,000 tokens**

**In Claude Code (new way):**
1. `/research ICEpower 700AS2 Conductor update`
2. Subagent runs: searches, fetches, reads, synthesizes, writes .md
3. Summary returns: "Wrote research/ICEpower_700AS2_Conductor_Update.md — no independent measurements yet, expected Q3 2025"
**Total context consumed: ~200 tokens**

### Example 2: Update a Design Document

**Old way:** Read entire file into context, discuss changes, write entire file back  
**New way:** `/update-doc 03_Subwoofer_System.md add ICEpower 1200AS2 wiring diagram for 240V operation`

### Example 3: Product Comparison

**Old way:** Multiple searches, multiple fetches, multiple file reads = context explosion  
**New way:** `/compare StormAudio ISP Elite MK3 vs Marantz AV10 for 24-channel bass management`

---

## Tips

### Context Management
- Use `/compact` if a session gets long — summarizes history without losing state
- Use `claude --resume` to pick up where you left off after closing terminal
- Use `claude --continue` to continue the most recent session

### File Access
- Claude Code has direct filesystem access — no copy-to-Claude's-computer needed
- It can read/write anywhere you grant permission (your project directory by default)
- No need for Filesystem MCP tools — it uses native bash/file operations

### Parallel Research
- Subagents can run in parallel: research 3 amplifier options simultaneously
- Use the Task tool or Explore tool for delegation
- Main session stays clean while subagents do heavy lifting

### Version Control
- Consider `git init` in the theater directory for change tracking
- Claude Code has native git integration
- Can auto-commit after document updates

---

## Migration from Claude.ai Chat

| What | Claude.ai Chat | Claude Code |
|------|---------------|-------------|
| Project context | Memory system + project instructions | CLAUDE.md (auto-loaded) |
| File reads | Filesystem:read_file (enters context) | Direct read in subagent |
| File writes | Filesystem:write_file (content in context) | Direct write, no context cost |
| Web research | web_search + web_fetch (huge context) | /research command in fork |
| Document updates | Read + discuss + write (3x context) | /update-doc in fork |
| Skills | /mnt/skills/ on Claude's computer | .claude/skills/ in project |
| Reusable workflows | Memory rules (limited) | Slash commands (unlimited) |

**You can use both simultaneously.** Claude.ai chat for interactive discussion and decision-making.
Claude Code for heavy I/O operations (research, file updates, comparisons).

---

*Created: February 20, 2025*
*For: Home Theater Project — D:\Projects\Claude\theater\*
