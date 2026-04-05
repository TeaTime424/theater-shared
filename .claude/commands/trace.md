---
name: trace
description: Trace another Claude Code session — show agent dispatches, timing, errors, or watch live events
---

# Session Trace

Inspect another Claude Code session's JSONL transcript. Read-only.

## Usage

The user invokes `/trace` with optional arguments:

- `/trace` or `/trace status` → List recent sessions with line counts and sizes
- `/trace <session-id>` → Full summary (agents + timing + errors + output files)
- `/trace analyze <session-id>` → Deep analysis with optimization suggestions (dispatch patterns, bottlenecks, agent types, wave gaps, output sizes, error classification)
- `/trace agents <session-id>` → Agent dispatch table with types, background flag, prompt sizes
- `/trace timing <session-id>` → Dispatch/completion timeline
- `/trace errors <session-id>` → Scan for errors and hook failures
- `/trace watch <session-id>` → Poll every 15s, show new events (Ctrl+C to stop)

Session IDs can be partial (first 8 chars are enough).

## Execution

Run the appropriate command using the CLI tool:

```bash
cd D:/Projects/Claude/theater && python -m tools.session_trace <subcommand> [session-id]
```

If the user provides no arguments, run `status`. If they provide just a session ID, run `summary`.

Present the output directly — do not reformat or summarize it. The tool output is designed for terminal display.

## Notes

- This tool is READ-ONLY — it never modifies the traced session
- Session transcripts are at `~/.claude/projects/D--Projects-Claude-theater/*.jsonl`
- The tool auto-detects the project directory
- "JSON validation failed" errors in the output are typically harmless PostToolUse hook warnings
