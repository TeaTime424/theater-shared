# Comparison: Multi-Session Orchestration for Claude Code — psmux vs Agent SDK vs Terminus

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-28
**Use case:** Parallel Claude Code agent dispatch on Windows 11, unattended long sessions, task DAG execution model with specialist workers

---

## Requirements

| Parameter | Value |
|-----------|-------|
| Platform | Windows 11 native (mandatory) |
| Dispatch model | Programmatic, scripted from orchestrator |
| Parallelism | 3–8 concurrent workers |
| Session persistence | Must survive orchestrator crash or restart |
| Error handling | Per-worker capture and retry |
| Integration | Existing task DAG (TaskCreate/TaskUpdate), research/ output pattern |
| Overhead preference | Low — reliability over features |
| Sessions already running | Yes — 3+ theater workers active |

---

## Executive Summary

Three approaches were evaluated for orchestrating parallel Claude Code sessions on Windows: the current psmux hub-and-spoke architecture, the Claude Agent SDK (formerly Claude Code SDK, now `claude-agent-sdk`), and Terminus (a name shared by four unrelated projects).

**Terminus is not a viable option.** The name resolves to a terminal emulator (Tabby, 70K stars, no programmatic dispatch), a tmux-backed LLM benchmark harness (Terminus-2/KIRA, Linux-only, unrelated purpose), and two other unrelated projects. None provide session orchestration for Claude Code on Windows.

**psmux is the right tool for the current phase.** It is already working, Windows-native, production-tested, and directly supports the task DAG dispatch model. The 10 identified limitations are real but manageable — none are blockers for the current workflow.

**Agent SDK is the right long-term direction, not today.** It eliminates the terminal multiplexing layer entirely and replaces idle-polling with native async streaming. It handles session persistence, error propagation, and token cost transparency natively. The migration path is non-trivial: the existing psmux/Python orchestrator must be rewritten, and the Agent SDK's subagent model has a one-level nesting limit that constrains deep hierarchies. The right trigger for migration is when a psmux limitation actually blocks a task — not before.

The two systems are not mutually exclusive. The current architecture already uses Agent tool internally (subagents within a Claude Code session) and psmux externally (separate CLI sessions). That boundary can remain: psmux for session isolation and Windows compatibility, Agent SDK for structured programmatic dispatch when a new orchestrator is warranted.

---

## Architecture Comparison

### psmux Hub-and-Spoke

```
Orchestrator (Python script)
    |
    |-- psmux send-keys "claude -p '...'" --> Session "1-theater" (Worker A)
    |-- psmux send-keys "claude -p '...'" --> Session "2-research" (Worker B)
    |-- psmux send-keys "claude -p '...'" --> Session "3-verify" (Worker C)
    |
    |-- poll loop: psmux capture-pane + regex(❯) --> idle detection
    |-- on idle: psmux capture-pane --> read output text
    |-- write JSON to tools/psmux_output/<session>/result.json
    |-- PostToolUse hook: validate_dispatch.py
```

Dispatch is side-channel: the orchestrator sends keystrokes to a terminal pane and reads back
raw text. Workers run as full CLI processes. Sessions persist independently of the orchestrator.
Each worker writes its own research/ files. Structured output is opt-in (JSON in known path).

### Claude Agent SDK (query-based)

```
Orchestrator (async Python)
    |
    |-- query(prompt, options=ClaudeAgentOptions(agents={...}))
    |       |
    |       |-- async generator yields: AssistantMessage, ToolUseBlock, ResultMessage
    |       |
    |       |-- Agent tool invocations (subagents):
    |               "verify": AgentDefinition(tools=["Read","Grep","Glob"])
    |               "research": AgentDefinition(tools=["Read","WebSearch","Write"])
    |               "compare": AgentDefinition(tools=["Read","WebSearch","Write"])
    |
    |-- session resume: query(..., options=ClaudeAgentOptions(resume=session_id))
    |-- hooks: PostToolUse=[HookMatcher(matcher="Write", hooks=[callback])]
```

Dispatch is in-process: the orchestrator calls an async function; subagents run inside the
same process. No terminal multiplexer needed. Result streaming is native (async generator).
Session state stored in ~/.claude/projects/. Subagents cannot spawn further subagents.

### Terminus (all variants)

```
Tabby: Human opens tabs manually. No scripting API. Not relevant.

Terminus-2:
    LLM (via LiteLLM) --> reasoning loop --> tmux send-keys --> read pane buffer --> repeat
    Purpose: solve terminal benchmark tasks. Uses tmux internally. Not an orchestrator.

Terminus-KIRA:
    Extends Terminus-2 with native tool calling and multimodal support.
    Benchmark eval only. Linux/tmux dependency. Not relevant to Windows session dispatch.
```

---

## Feature Matrix

| Feature | psmux (current) | Agent SDK | Tabby/Terminus | Terminus-2/KIRA |
|---------|----------------|-----------|----------------|-----------------|
| **Platform** | Windows native | Windows (Python process) | Windows (Electron) | Linux only |
| **Programmatic dispatch** | Yes — send-keys + regex poll | Yes — async query() | No | Internal only |
| **Parallel workers** | Yes — N sessions | Yes — N subagents | No | No (single agent) |
| **Result streaming** | No — poll-on-complete | Yes — async generator | N/A | Internal buffer |
| **Session persistence** | Yes — survives orchestrator crash | Partial — resume by session_id | No | Via tmux |
| **Worker isolation** | Full process isolation | In-process (shared memory) | N/A | Shared process |
| **Error handling** | None — raw text, no validation | `is_error` flag, retry in loop | N/A | None documented |
| **Idle detection** | Regex on prompt (brittle) | Not needed — generator completes | N/A | Not applicable |
| **Token cost visibility** | Opaque — CLI sessions | Native — usage in ResultMessage | N/A | LiteLLM pricing |
| **Session resume** | Manual (re-send to named session) | Native — resume=session_id | N/A | Via tmux reattach |
| **Custom hooks** | PostToolUse via settings.json | PostToolUse via ClaudeAgentOptions | N/A | None |
| **Subagent depth** | Unlimited (separate CLI sessions) | 1 level only (cannot nest) | N/A | N/A |
| **Windows UTF-8** | Fragile (chcp 65001 required) | Transparent (Python handles) | N/A | N/A |
| **Timeout control** | Global 300s default (inflexible) | max_turns per query | N/A | N/A |
| **Rollback on error** | None | None (must implement in orchestrator) | N/A | N/A |
| **Task DAG integration** | Direct — workers call TaskCreate/TaskUpdate | Orchestrator drives DAG | N/A | N/A |
| **Existing infra reuse** | Zero migration | Full rewrite of dispatch layer | N/A | N/A |
| **Maturity** | v3.3.1, 418 commits, MIT | Production SDK, active Anthropic maintenance | Production (unrelated) | Research/beta |
| **Binary/install size** | Single binary, ~5MB | pip install, ~50KB SDK | Electron ~200MB | Python + tmux |
| **Source types** | community measurement (psmux docs) | manufacturer (Anthropic official docs) | community measurement | community measurement |

---

## Strengths and Weaknesses

### psmux

**Strengths:**
- Already working. 3+ workers active in this project. Zero migration cost.
- Full process isolation: each worker has its own memory, context window, file handles.
- Workers can be inspected manually (attach to session, watch live output).
- Subagent depth is unlimited — a worker session can itself spawn sub-sessions.
- Survives orchestrator crashes: sessions keep running, results written to disk.
- Compatible with all Claude Code CLI features (hooks, slash commands, CLAUDE.md, agents/).
- The task DAG model (TaskCreate/TaskUpdate) works natively — workers are just Claude Code sessions.

**Weaknesses:**
- Idle detection is regex-brittle. If the prompt format changes or a spinner pattern isn't caught, polls loop forever or declare completion prematurely.
- No intermediate streaming. Orchestrator is blind until the session goes idle.
- UTF-8 issues on Windows require `chcp 65001` before psmux commands; non-ASCII in prompts can corrupt.
- Fixed 300s global timeout. A 30-minute research task uses the same timeout as a 30-second verify task unless the orchestrator overrides per-session.
- Result capture reads raw pane text. Errors look identical to success unless the worker writes structured output explicitly.
- No session rollback. If a worker errors mid-task and writes partial research/, that partial file is live.
- Session naming (`<digit>-<dirname>`) can collide at scale (>9 workers per directory).
- Cascading dispatch prevention in validate_dispatch.py is warn-only, not enforced.

### Claude Agent SDK

**Strengths:**
- Native async streaming: orchestrator sees each message/tool-use as it happens, not on completion.
- Token usage in ResultMessage: cost is observable and can be logged per task.
- `is_error` on tool results: errors propagate structurally, not as text that must be parsed.
- Session resume: `resume=session_id` continues a prior session without re-running setup.
- `ClaudeSDKClient` for continuous multi-turn sessions (not just one-shot query).
- `canUseTool` callback: programmatic permission control per invocation, not just allowedTools list.
- Eliminates terminal multiplexer entirely — pure Python, no process spawning, no regex polling.
- CLAUDE.md, .claude/agents/, skills, slash commands all load via `setting_sources=["project"]`.
- PostToolUse hooks register directly in options — no settings.json file needed.
- Windows: no UTF-8 issues (Python string handling), no terminal encoding dependencies.

**Weaknesses:**
- Subagents cannot nest. `AgentDefinition` cannot include `Agent` in its tools. A two-tier dispatch hierarchy (orchestrator → coordinator → workers) is not supported in one query() call. Would require multiple query() calls chained together.
- Full rewrite required. The existing psmux/Python orchestrator cannot be incrementally migrated. Every send-keys call becomes a query() call.
- In-process shared memory. All subagents run in the same Python process. A crash kills all concurrent workers.
- No live session visibility. There is no equivalent to `psmux attach-session` to watch a worker mid-run.
- Workers cannot independently call TaskCreate/TaskUpdate from within a subagent the way CLI workers can — the parent orchestrator handles DAG updates based on ResultMessage content.
- Subagent transcripts stored at `~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl` — accessible but not live-streamable without custom tooling.

### Terminus (all variants)

**Strengths:**
- Tabby: excellent human-facing terminal emulator, cross-platform, SSH client built in.
- Terminus-2/KIRA: sophisticated LLM reasoning loop for terminal benchmark tasks; interesting architecture reference.

**Weaknesses:**
- None are relevant to this use case. Tabby has no scripting API for agent dispatch. Terminus-2/KIRA requires Linux and tmux, serves benchmark evaluation, and cannot orchestrate external Claude Code sessions. These are not competitors to psmux or Agent SDK for this workload.

---

## Migration Path: psmux to Agent SDK

A complete migration requires replacing the dispatch layer while preserving the task DAG contract.

**Step 1: Define agents in Python (not .claude/agents/ markdown)**

Convert each markdown agent file to `AgentDefinition` objects in an orchestrator script:

```python
AGENT_DEFINITIONS = {
    "verify": AgentDefinition(
        description="Cross-reference claims, 3+ sources, bidirectional search",
        prompt=open(".claude/agents/verify.md").read(),
        tools=["Read", "Grep", "Glob", "WebSearch", "WebFetch", "Write"],
        model="sonnet",
    ),
    "research": AgentDefinition(
        description="Broad web research + synthesis to research/ directory",
        prompt=open(".claude/agents/research.md").read(),
        tools=["Read", "Write", "WebSearch", "WebFetch", "Glob"],
        model="sonnet",
    ),
    # ... compare, investigate, build, edit
}
```

**Step 2: Replace send-keys dispatch with query() calls**

```python
async def dispatch_task(task_id: str, task_description: str, agent_type: str):
    async for message in query(
        prompt=f"Task {task_id}: {task_description}",
        options=ClaudeAgentOptions(
            allowed_tools=["Read","Write","Grep","Glob","WebSearch","WebFetch","Agent"],
            agents=AGENT_DEFINITIONS,
            cwd="D:/Projects/Claude/theater",
            setting_sources=["project"],
            permission_mode="bypassPermissions",
        ),
    ):
        if isinstance(message, ResultMessage):
            # update task DAG
            pass
```

**Step 3: Run tasks in parallel**

```python
tasks = [dispatch_task(id, desc, agent) for id, desc, agent in wave]
results = await asyncio.gather(*tasks, return_exceptions=True)
```

Note: This creates N concurrent query() calls in one process. If one crashes the process, all die. For crash isolation, run each query() in a subprocess.

**Step 4: Preserve structured output contract**

Workers currently write to `research/<filename>.md`. Under Agent SDK, the subagent Write tool writes to the same paths. No change needed here — the file contract is tool-mediated, not session-mediated.

**Step 5: Replace TaskCreate/TaskUpdate calls in workers**

Under psmux, workers call TaskCreate/TaskUpdate directly because they run as full Claude Code sessions with access to the task management tools. Under Agent SDK, subagents run inside the parent's session. They can still call TaskCreate/TaskUpdate IF those are exposed as MCP tools or custom tools — otherwise the parent orchestrator must read ResultMessage content and drive DAG updates itself.

**Estimated effort:** 2–4 sessions. Non-trivial. Should not be done until a psmux limitation actually blocks a real task.

---

## Recommendation for This Project

**Keep psmux. Plan Agent SDK migration opportunistically.**

The current setup works. Workers are running. The task DAG model is functional. There is no active blocking failure. Migrating now would spend 2–4 sessions rewriting working infrastructure for theoretical gains.

The specific trade-offs for Andy's setup:

| Concern | psmux verdict | Agent SDK verdict |
|---------|--------------|-------------------|
| Windows 11 compatibility | Confirmed working, native binary | Works (Python), no terminal dependency |
| Long unattended sessions | Workers persist if orchestrator dies | Process crash kills all concurrent workers |
| 3+ active workers | Already running | Requires rewrite to start |
| Reliability | Known failure modes, all manageable | Unknown failure modes on this specific workload |
| Overhead | Low | Low (no Electron, no tmux) |
| Idle detection fragility | Real problem, documented | Eliminated — not needed |
| UTF-8 fragility | Real problem, workaroundable | Eliminated |
| Streaming visibility | Absent | Native |
| Cost tracking | Opaque | Native (ResultMessage usage) |

The one psmux limitation that has real operational impact is the timeout inflexibility. If a 30-minute research task hits the 300s default, the orchestrator incorrectly declares completion. This is worth fixing now by passing per-session timeout overrides rather than migrating to Agent SDK.

The Agent SDK becomes the right choice when:
- A new orchestrator is being written from scratch (greenfield), or
- The psmux idle detection false-fires frequently enough to corrupt task results, or
- Token cost visibility is needed for billing/optimization, or
- In-process streaming is required (monitoring task progress mid-run).

None of those conditions currently apply.

**For the task DAG specifically:** The psmux model, where workers are full Claude Code sessions that call TaskCreate/TaskUpdate directly, is architecturally cleaner than the Agent SDK model where the parent orchestrator must proxy all DAG mutations. Keep that boundary.

---

## Follow-up Tasks Created

None. This is a standalone comparison with no unverified specs requiring follow-up verification.

---

## Bidirectional Search

- **Searched FOR:** Claude Agent SDK capabilities, psmux Windows compatibility, session persistence in Agent SDK, subagent nesting limits, query() streaming behavior, ResultMessage structure, Agent SDK vs CLI tradeoffs, psmux idle detection mechanism, ClaudeSDKClient multi-turn sessions, bypassPermissions mode
- **Searched AGAINST:** Agent SDK Windows known issues, psmux crash reports or data loss incidents, subagent depth workarounds, Agent SDK in-process crash behavior, psmux UTF-8 failure modes, Agent SDK session resume reliability, Terminus Claude Code integration claims
- **Contradicting evidence found:** No — Agent SDK subagent 1-level nesting limit is confirmed in official docs ("Subagents cannot spawn their own subagents"). psmux Windows native status confirmed by terminus_claude_code_research.md (v3.3.1, winget, single binary). No evidence of Agent SDK Windows-specific failures found, but also no independent community reports confirming Windows long-session reliability. psmux UTF-8 fragility is documented in the psmux architecture summary (limitation #3) and is an acknowledged known issue, not a contradiction.

---

## Sources

1. psmux architecture — code analysis summary (provided by user, 2026-03-28)
2. Claude Agent SDK documentation — research/claude_code_sdk_raw.md (2026-03-28)
   - Agent SDK Overview: https://platform.claude.com/docs/en/agent-sdk/overview
   - Python reference: https://platform.claude.com/docs/en/agent-sdk/python
   - Subagents: https://platform.claude.com/docs/en/agent-sdk/subagents
   - Sub-agents (file-based): https://code.claude.com/docs/en/sub-agents
3. Terminus investigation — research/terminus_claude_code_research.md (2026-03-28)
   - GitHub - Eugeny/tabby: https://github.com/Eugeny/tabby
   - GitHub - laude-institute/terminal-bench: https://github.com/laude-institute/terminal-bench
   - GitHub - krafton-ai/KIRA: https://github.com/krafton-ai/KIRA
   - GitHub - psmux/psmux: https://github.com/psmux/psmux
   - Claude Code issue #34150: https://github.com/anthropics/claude-code/issues/34150
