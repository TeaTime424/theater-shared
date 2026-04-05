# Skill: Conversation Recovery

## Purpose
Recover context from stalled, crashed, or dead Claude Code conversations. When a previous conversation dies mid-task (context window exhaustion, crash, network drop), use this skill to figure out what it was doing and what remains unfinished.

## When to Use
- User says a previous conversation died/stalled/crashed
- User wants to resume or continue work from a dead session
- User asks "what was the last conversation doing?"
- User provides a conversation ID to inspect

## Step 1: Find Transcript Files

Transcripts live in `~/.claude/projects/`. The project directory name is the working directory path with path separators replaced by `--`. For this project:

```
~/.claude/projects/D--Projects-Claude-theater/
```

Each conversation has:
- `<uuid>.jsonl` — the main transcript (JSONL format)
- `<uuid>/subagents/` — subagent transcripts (if any)
- `<uuid>/tool-results/` — cached tool outputs

**To list recent conversations, use Python with pathlib** (handles Windows paths reliably):

```python
import json, os, pathlib
proj_dir = pathlib.Path(os.path.expanduser('~')) / '.claude' / 'projects' / 'D--Projects-Claude-theater'
transcripts = sorted(proj_dir.glob('*.jsonl'), key=lambda p: p.stat().st_mtime, reverse=True)
for t in transcripts[:10]:
    size_kb = t.stat().st_size / 1024
    print(f'{t.stem}  {size_kb:.0f}KB  modified={t.stat().st_mtime}')
```

IMPORTANT: Always use `pathlib.Path(os.path.expanduser('~'))` for the home directory on Windows. Never rely on `$HOME` shell expansion inside Python — it resolves to `/c/Users/...` in Git Bash which Python cannot open.

## Step 2: Parse the Transcript

JSONL format — one JSON object per line. Always open with `encoding='utf-8'`.

```python
import json, os, pathlib

def load_transcript(uuid):
    proj_dir = pathlib.Path(os.path.expanduser('~')) / '.claude' / 'projects' / 'D--Projects-Claude-theater'
    path = proj_dir / f'{uuid}.jsonl'
    entries = []
    with open(str(path), 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line:
                entries.append(json.loads(line))
    return entries
```

### Entry Types

| `type` field | Meaning |
|---|---|
| `user` | User message (may contain plain text or `tool_result` blocks) |
| `assistant` | Assistant response (may contain `text` and/or `tool_use` blocks) |
| `progress` | Progress updates (skip these for analysis) |
| `queue-operation` | Internal queue ops (skip) |
| `file-history-snapshot` | File state snapshots (skip) |

### Message Content Structure

**User messages** — `entry['message']['content']` is either:
- A plain string (user typed text)
- A list of blocks, each with `"type"` key:
  - `{"type": "text", "text": "..."}` — user text
  - `{"type": "tool_result", "tool_use_id": "...", "content": [...]}` — result from a tool call

**Assistant messages** — `entry['message']['content']` is a list of blocks:
- `{"type": "text", "text": "..."}` — assistant prose
- `{"type": "tool_use", "id": "...", "name": "tool_name", "input": {...}}` — tool invocation

**Assistant stop reasons** — `entry['message']['stop_reason']`:
- `"end_turn"` — normal completion
- `None` — stalled/crashed mid-generation
- `"max_tokens"` — hit token limit

## Step 3: Extract the Task Sequence

Pull out user messages to understand what the user asked for:

```python
def extract_user_tasks(entries):
    tasks = []
    for entry in entries:
        if entry.get('type') != 'user':
            continue
        msg = entry.get('message', {})
        content = msg.get('content', '')
        if isinstance(content, str) and content.strip():
            tasks.append(content.strip())
        elif isinstance(content, list):
            for block in content:
                if isinstance(block, dict) and block.get('type') == 'text':
                    text = block.get('text', '').strip()
                    if text:
                        tasks.append(text)
    return tasks
```

## Step 4: Determine Where It Stalled

Check the tail of the transcript to classify the death mode:

```python
def diagnose_stall(entries):
    # Filter to meaningful entries
    meaningful = [e for e in entries if e.get('type') in ('user', 'assistant')]
    if not meaningful:
        return "Empty transcript"

    last = meaningful[-1]

    if last.get('type') == 'assistant':
        msg = last.get('message', {})
        stop = msg.get('stop_reason')
        if stop == 'end_turn':
            return "Completed normally (end_turn)"
        elif stop is None:
            # Crashed mid-generation
            content = msg.get('content', [])
            last_blocks = [b.get('type') for b in content if isinstance(b, dict)]
            if 'tool_use' in last_blocks:
                tool_names = [b.get('name') for b in content if isinstance(b, dict) and b.get('type') == 'tool_use']
                return f"Stalled mid-tool-call: was invoking {tool_names[-1:]}"
            return "Stalled mid-text-generation"
        elif stop == 'max_tokens':
            return "Hit max tokens"

    elif last.get('type') == 'user':
        content = last.get('message', {}).get('content', [])
        if isinstance(content, list):
            block_types = [b.get('type') for b in content if isinstance(b, dict)]
            if 'tool_result' in block_types:
                return "Stalled after tool result returned (tool completed but assistant never responded)"
        return "Stalled waiting for assistant response"

    return f"Unknown state: last entry type={last.get('type')}"
```

### Stall Pattern Reference

| Last meaningful entry | `stop_reason` | Diagnosis |
|---|---|---|
| `assistant` | `end_turn` | Normal completion — not stalled |
| `assistant` | `None` | Crashed mid-generation (context window, network, OOM) |
| `assistant` | `max_tokens` | Hit output token limit |
| `user` with `tool_result` blocks | n/a | Tool finished but assistant never got to respond |
| `user` with plain text | n/a | User message was never answered |

## Step 5: Check for Subagents

Subagent transcripts live in `<uuid>/subagents/`. These are also JSONL files. A running subagent that was interrupted means its work may be incomplete.

```python
def check_subagents(uuid):
    proj_dir = pathlib.Path(os.path.expanduser('~')) / '.claude' / 'projects' / 'D--Projects-Claude-theater'
    subagent_dir = proj_dir / uuid / 'subagents'
    if not subagent_dir.exists():
        return []
    results = []
    for sa in subagent_dir.glob('*.jsonl'):
        entries = []
        with open(str(sa), 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line:
                    entries.append(json.loads(line))
        meaningful = [e for e in entries if e.get('type') in ('user', 'assistant')]
        status = "unknown"
        if meaningful:
            last = meaningful[-1]
            if last.get('type') == 'assistant':
                sr = last.get('message', {}).get('stop_reason')
                status = f"assistant(stop={sr})"
            else:
                status = "waiting_for_response"
        results.append({'file': sa.name, 'entries': len(entries), 'status': status})
    return results
```

## Step 6: Summarize and Identify Remaining Work

Combine the above to produce a recovery summary:

1. **What the user asked for** — extract all user text messages in order
2. **What the assistant was doing** — look at the last few assistant messages, especially tool calls
3. **Where it died** — use the stall diagnosis
4. **What tools were in flight** — check the last assistant tool_use blocks against following tool_results

Then check for uncommitted work that may relate to the stalled conversation:

```bash
git status
git diff --stat
git log --oneline -5
```

Compare modified files against tool calls in the transcript (look for `Edit`, `Write`, `Bash` tool uses that touched files).

## Step 7: Report to User

Present a concise summary:

```
## Recovery Summary for [uuid]

**Task sequence:**
1. User asked: "..."
2. User asked: "..."

**Stall diagnosis:** [from Step 4]

**Last actions before stall:**
- Called [tool_name] with [brief description]
- [tool result status]

**Subagents:** [N subagents, statuses]

**Uncommitted changes potentially related:**
- [file list from git status]

**Recommended next steps:**
- [what to do to finish the work]
```

## Complete Recovery Script

Run this as a single Python block to get the full picture. Pass the UUID of the conversation to inspect, or omit to scan the most recent one:

```python
import json, os, pathlib, sys

proj_dir = pathlib.Path(os.path.expanduser('~')) / '.claude' / 'projects' / 'D--Projects-Claude-theater'

# Find most recent transcript or use provided UUID
uuid = None  # Set this to a specific UUID string, or leave None for most recent
if uuid is None:
    transcripts = sorted(proj_dir.glob('*.jsonl'), key=lambda p: p.stat().st_mtime, reverse=True)
    if not transcripts:
        print("No transcripts found"); sys.exit(1)
    target = transcripts[0]
    uuid = target.stem
else:
    target = proj_dir / f'{uuid}.jsonl'

print(f"Analyzing: {uuid}")
print(f"File: {target}")
print(f"Size: {target.stat().st_size / 1024:.0f} KB")
print()

# Load entries
entries = []
with open(str(target), 'r', encoding='utf-8') as f:
    for line in f:
        line = line.strip()
        if line:
            entries.append(json.loads(line))

# Extract user tasks
print("=== USER TASKS ===")
for entry in entries:
    if entry.get('type') != 'user':
        continue
    content = entry.get('message', {}).get('content', '')
    if isinstance(content, str) and content.strip():
        print(f"  - {content.strip()[:200]}")
    elif isinstance(content, list):
        for block in content:
            if isinstance(block, dict) and block.get('type') == 'text':
                text = block.get('text', '').strip()
                if text:
                    print(f"  - {text[:200]}")

# Diagnose stall
meaningful = [e for e in entries if e.get('type') in ('user', 'assistant')]
print(f"\n=== STALL DIAGNOSIS ===")
print(f"Total entries: {len(entries)}, meaningful: {len(meaningful)}")

if meaningful:
    last = meaningful[-1]
    if last.get('type') == 'assistant':
        msg = last.get('message', {})
        stop = msg.get('stop_reason')
        content = msg.get('content', [])
        print(f"Last: assistant, stop_reason={stop}")
        if isinstance(content, list):
            for b in content[-3:]:
                if isinstance(b, dict):
                    if b.get('type') == 'tool_use':
                        print(f"  Tool call: {b.get('name')} -> {str(b.get('input',{}))[:100]}")
                    elif b.get('type') == 'text':
                        print(f"  Text: {b.get('text','')[:150]}")
    elif last.get('type') == 'user':
        content = last.get('message', {}).get('content', [])
        if isinstance(content, list):
            btypes = [b.get('type') for b in content if isinstance(b, dict)]
            print(f"Last: user, block types={btypes[:5]}")
            if 'tool_result' in btypes:
                print("  -> Tool result returned but assistant never responded")
        else:
            print(f"Last: user text (never answered)")

# Check subagents
sa_dir = proj_dir / uuid / 'subagents'
if sa_dir.exists():
    print(f"\n=== SUBAGENTS ===")
    for sa in sa_dir.glob('*.jsonl'):
        sa_entries = []
        with open(str(sa), 'r', encoding='utf-8') as f:
            for line in f:
                l = line.strip()
                if l:
                    sa_entries.append(json.loads(l))
        sa_meaningful = [e for e in sa_entries if e.get('type') in ('user', 'assistant')]
        if sa_meaningful:
            sa_last = sa_meaningful[-1]
            sr = sa_last.get('message', {}).get('stop_reason') if sa_last.get('type') == 'assistant' else 'n/a'
            print(f"  {sa.name}: {len(sa_entries)} entries, last={sa_last.get('type')}(stop={sr})")
```

## Critical Reminders

- **Always use `pathlib.Path(os.path.expanduser('~'))`** — never `$HOME` in Python on Windows
- **Always use `encoding='utf-8'`** when opening JSONL files
- **Always use `str(path)`** when passing pathlib paths to `open()` for maximum compatibility
- **Skip `progress`, `queue-operation`, and `file-history-snapshot`** entries — they are noise
- **Content can be a string OR a list of blocks** — always check with `isinstance()`
- **A conversation ending with `user` type containing `tool_result` blocks** is the classic stall pattern — the tool finished but the assistant never generated a response
