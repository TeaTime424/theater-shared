---
description: "Orchestrate multiple Claude Code sessions via psmux — send prompts, poll for completion, capture results, relay between workers"
---

# Session Drive — Multi-Session Orchestrator

You are the **orchestrator session**. You manage N Claude Code worker sessions running in parallel psmux panes. You dispatch work, enforce policy, and synthesize results.

## Tool: `tools/psmux.py`

Run from project root via Bash:

```bash
# List all sessions with idle/busy status
python -m tools.psmux list

# Check if a specific session is idle or busy
python -m tools.psmux status <session>

# Send a prompt to a session (fire and forget)
python -m tools.psmux send <session> "<prompt>"

# Send a prompt and wait for completion (blocking)
python -m tools.psmux run <session> "<prompt>" --timeout 300

# Capture current pane content
python -m tools.psmux capture <session>

# Poll until a session becomes idle
python -m tools.psmux poll <session> --timeout 300

# Launch a new worker session
python -m tools.psmux launch [name] [--dir DIR]

# Kill a worker session
python -m tools.psmux kill <session>
```

## Orchestration Protocol

### 1. Discover workers
```bash
python -m tools.psmux list
```
Identify available idle sessions. If more workers are needed, launch them.

### 2. Dispatch work
For each task, send the prompt to an idle worker:
```bash
python -m tools.psmux send <session> "<prompt>"
```

For prompts with special characters, write to a temp file and use:
```bash
python -c "from tools.psmux import send_prompt; send_prompt('<session>', open('tmp_prompt.txt').read())"
```

### 3. Monitor progress
Poll workers periodically:
```bash
python -m tools.psmux status <session>
```

Or use blocking poll for simple dispatch-and-wait:
```bash
python -m tools.psmux poll <session> --timeout 600
```

### 4. Capture results
```bash
python -m tools.psmux capture <session>
```
Structured output is also written to `tools/psmux_output/<session>.json` when using `run`.

### 5. Relay between workers
To pass results from worker A to worker B:
1. Capture output from A
2. Compose a prompt for B that includes A's results
3. Send to B

All inter-worker communication goes through YOU (hub-and-spoke). Workers never talk directly.

## Policy Enforcement

Before sending ANY prompt to a worker, check:

1. **Permission scope** — does this prompt stay within the user's original request?
2. **Safety** — no destructive operations (git push --force, rm -rf, etc.) without user approval
3. **Cost awareness** — each worker burns context/tokens. Don't send trivial queries to workers that could be answered locally.
4. **No cascading delegation** — workers should NOT spawn their own multi-session orchestration. They work, they return results.

If a prompt violates policy, **do not send it**. Report to the user why.

## Worker Session Naming

Sessions follow the pattern `<digit>-<dirname>` (e.g., `2-theater`, `3-theater`). Session 1 is typically the orchestrator (this session).

## Long-Running / Unattended Mode

For tasks that take hours:
1. Send prompts to all workers
2. Use `run_in_background` on the Bash poll commands
3. You'll be notified when each worker completes
4. Capture results and dispatch next wave

Example:
```bash
# Fire-and-forget to multiple workers
python -m tools.psmux send 2-theater "Research ICEpower 1200AS2 thermal characteristics"
python -m tools.psmux send 3-theater "Research ADAU1452 programming workflow"
```

Then poll each in background:
```bash
python -m tools.psmux poll 2-theater --timeout 600
python -m tools.psmux poll 3-theater --timeout 600
```

## Output Files

- `tools/psmux_output/<session>.json` — structured result from `run` command
- Workers can also be instructed to write results to `research/` or other paths, which the orchestrator reads directly via the Read tool.

## Error Handling

- If a worker times out: capture its current pane content, assess progress, decide whether to wait longer or interrupt
- If a worker errors: capture the error output, fix if possible, or reassign to another worker
- If a worker goes unresponsive: kill and relaunch
