# Claude Code Parallel Agent Dispatch

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-21
**Related:** research/design_package_agent_analysis.md, research/design_package_failure_analysis.md

---

## Executive Summary

Claude Code's Agent tool (formerly Task tool, renamed in v2.1.63) dispatches subagents sequentially by default — the SDK harness executes tool_use blocks one at a time even when the model generates multiple in a single message. This is an **intentional design decision** by Anthropic, not a model limitation. The model itself *can* generate multiple Agent tool_use blocks in one assistant turn, but the harness serializes their execution. True parallelism requires either background subagents (Ctrl+B), explicit prompting to trigger background dispatch, or the experimental Agent Teams feature (disabled by default).

---

## Key Findings

### 1. Model vs. Harness: Who Is Responsible for Sequential Behavior?

The sequential behavior is a **harness-level design decision**, not a model-level limitation.

- The Claude model *can* generate multiple tool_use blocks in a single assistant message — this is supported by the API and is how "parallel tool use" works across all Anthropic products.
- The Claude Code SDK harness (the loop that processes tool_use blocks) **executes them sequentially** by default: one block completes, its result feeds back into the conversation, then the next begins.
- Anthropic confirmed this via a developer response on Discord (captured in GitHub issue #438 on the claude-agent-sdk-python repo): *"When Claude generates a response with multiple tool calls, from its perspective those tool requests are simultaneous... The SDK prioritizes safety and control over latency."*

Per the Agent SDK Python issue #438, Anthropic's stated rationale for sequential execution:
- Tool A's results can inform whether Tool B should even run
- Errors in Tool A can halt the chain before Tool B causes additional issues
- State changes are atomic and predictable
- Debugging is linear and traceable

### 2. The `disable_parallel_tool_use` Parameter (API Layer)

At the raw API level, parallel tool use is **enabled by default** but can be disabled:
- `disable_parallel_tool_use: false` (default) — model may emit multiple tool_use blocks per turn
- `disable_parallel_tool_use: true` — forces model to emit at most one tool_use block per turn

Model-specific behavior matters here:
- **Claude 4 models** (Opus 4.6, Sonnet 4.6, etc.) have high success rates at parallel tool calling without prompting
- **Claude Sonnet 3.7** was less likely to make parallel tool calls even without the disable flag
- **Claude 4 models** with minor prompting achieve ~100% parallel tool use success rate [per Anthropic prompt engineering docs]

The key nuance: even when the model emits multiple tool_use blocks in one turn, the **Claude Code harness** may still serialize execution of those blocks. These are two separate layers.

### 3. How Background Subagents Achieve Parallelism

The Claude Code harness supports **background subagents** as a first-class mechanism for parallelism:
- **Foreground subagents** block the main conversation until complete
- **Background subagents** run concurrently while the main agent continues

Background dispatch can be triggered by:
- The model deciding a task suits background execution (research/analysis tasks, not file modifications)
- The user pressing **Ctrl+B** while a subagent is actively running
- Explicitly asking Claude to "run this in the background" in the prompt

Observed parallelism cap: **10 simultaneous subagents**. When this limit is exceeded, additional tasks are queued and dispatched as slots open.

When no explicit parallelism level is specified, Claude Code can achieve dynamic scheduling — pulling from the queue as soon as a slot opens. When a specific batch size is set, it waits for the full batch to complete before starting the next.

### 4. Model Behavior When Instructed to Batch Agent Calls

The key failure mode in the project's DAG approach: instructing Claude (in its system prompt or user message) to "launch multiple Agent calls in a single message" does not guarantee parallel execution because:

1. The model may still generate Agent tool_use blocks one at a time (sequential generation)
2. Even if multiple blocks are generated in one turn, the harness may serialize execution
3. Without `background: true` on the subagent definition or explicit user request for background execution, agents default to foreground (blocking) mode

From claudefa.st's sub-agent best practices, the conditions for parallel dispatch:
- 3+ unrelated tasks or independent domains
- No shared state between tasks
- Clear file boundaries with no overlap

Sequential dispatch is triggered by: task dependencies, shared files/state, or unclear scope.

### 5. Agent Teams (Experimental — True Parallelism)

For genuine parallelism, Anthropic provides **Agent Teams** (Claude Code v2.1.32+, disabled by default):
- Enable with: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in settings.json or environment
- Each teammate is a **fully independent Claude Code session** with its own context window
- Teammates can communicate directly with each other (not just reporting to lead)
- Coordination via shared task list + mailbox messaging system

Agent Teams vs. Subagents comparison:

| Feature | Subagents | Agent Teams |
|---|---|---|
| Context | Own window; results return to caller | Fully independent |
| Communication | Report to main agent only | Direct inter-agent messaging |
| Coordination | Main agent manages all work | Shared task list, self-coordinating |
| Parallelism | Background only, harness-serialized by default | True parallel, separate processes |
| Token cost | Lower (results summarized) | Higher (each is a full session) |
| Status | GA | Experimental |

Known Agent Teams limitations:
- No session resumption with in-process teammates (no `/resume` or `/rewind`)
- Task status can lag — teammates sometimes fail to mark tasks completed
- One team per session
- No nested teams (teammates cannot spawn their own teams)
- Split-pane mode requires tmux or iTerm2 (not VS Code integrated terminal, Windows Terminal, or Ghostty)

### 6. GitHub Issues and Community Evidence

- **anthropics/claude-code#3013** — "Parallel Agent Execution Mode" (CLOSED, NOT_PLANNED): Community request for automatic recursive parallel dispatch. Closed without an Anthropic response. A workaround tool (claude-launcher, a Rust CLI) was mentioned.
- **anthropics/claude-agent-sdk-python#438** — "Parallel tool execution support" (OPEN, Enhancement): Confirms sequential execution is intentional. The `readOnlyHint: true` flag on MCP tools was noted as enabling concurrent execution for read-only tools (March 2026 comment).
- **kortix-ai/suna#460** — "Optimize parallel tool calling with Claude 4" (CLOSED, COMPLETED): Referenced Anthropic's prompt engineering docs on Claude 4 parallel tool use.

### 7. The `readOnlyHint` Workaround (MCP Tools)

Per a March 2026 comment in SDK issue #438, MCP tools with `readOnlyHint: true` can execute concurrently in the SDK. This is the only officially documented mechanism for SDK-level parallel execution (outside of Agent Teams and background subagents). This applies to **MCP tools**, not to the Agent/Task tool itself.

---

## Comparison Table

| Dispatch Method | True Parallel? | Requires Config | Harness Support | Notes |
|---|---|---|---|---|
| Default Agent tool calls | No | None | Serialized | One at a time |
| Background subagents | Yes | "run in background" prompt or Ctrl+B | Concurrent | Up to 10 simultaneous |
| Agent Teams | Yes | `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` | Full parallel processes | Experimental, higher cost |
| Multiple tool_use blocks (API) | Partially | `disable_parallel_tool_use: false` | SDK serializes by default | Model generates them; harness may not parallelize |
| MCP tools with readOnlyHint | Yes (concurrent) | `readOnlyHint: true` | Concurrent for read-only | MCP only, not Agent tool |

---

## Implications for the Theater Project DAG

The project's task DAG execution model instructs the main conversation to "launch independent tasks in PARALLEL (single message, multiple Agent calls)." Based on this research:

1. **The instruction is sound in principle** — the model can generate multiple Agent tool_use blocks in one turn when instructed clearly.

2. **Parallel execution is not guaranteed** — the Claude Code harness may still serialize those blocks unless background dispatch is triggered.

3. **System prompt wording matters** — explicitly instructing "launch all independent agents in the background simultaneously" is more likely to trigger background dispatch than "launch in parallel."

4. **Agent Teams is the right long-term solution** — but it's experimental, has known bugs around task status and session resumption, and has Windows terminal limitations (no split-pane in Windows Terminal).

5. **Practical reality** — the model (Sonnet 4.6) running the DAG dispatcher is a Claude 4 model, which has high parallel tool use success rates. Explicit prompting likely achieves batch dispatch most of the time, though harness-level true parallelism is not guaranteed without background mode.

---

## Workarounds (Ranked by Reliability)

1. **Background subagent prompting** — Include "run each agent in the background" in the dispatcher instructions. Claude will pre-approve permissions and dispatch concurrently. Most reliable without experimental features.

2. **Explicit @-mention with background** — `@agent-name` mention + "run in background" guarantee specific subagent + background dispatch.

3. **Agent Teams** (experimental) — Enable `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`. True independent parallel sessions. Note: Windows Terminal and Ghostty don't support split-pane mode; in-process mode works.

4. **Manual parallel sessions via git worktrees** — Run separate Claude Code instances in separate worktrees. Most reliable parallelism but requires manual coordination.

5. **claude-launcher** (community tool) — Rust CLI at crates.io/crates/claude-launcher that implements basic parallel task execution.

---

## Bidirectional Search

- **Searched FOR:** "Claude Code parallel agent dispatch", "multiple Agent calls single message", "parallel tool_use blocks concurrent", "background subagents parallel", "agent teams parallel execution"
- **Searched AGAINST:** "Claude Code sequential limitation agent tool", "model generates one tool_use at a time", "harness serializes tool calls", "disable_parallel_tool_use sequential", "parallel tool execution not supported"
- **Contradicting evidence found:** Yes — partial. Some community sources claim Claude Code dispatches agents in parallel based on observable behavior (multiple subagents appearing active simultaneously). This is consistent with background subagents executing in parallel, not contradiction of the finding that the default harness behavior is sequential. The model-level parallel tool generation is real; the harness-level serialization is the key distinction.

---

## Recommendations

**Confidence: High** that the harness serializes Agent tool calls by default.

**Confidence: Medium** that explicit "run in background" prompting reliably triggers concurrent dispatch in practice.

**Confidence: High** that Agent Teams provides true parallelism but is experimental with known bugs.

**For the project's DAG dispatcher:**
- Add "run each agent in the background" to the dispatch instruction in the system prompt
- Avoid relying on multiple Agent tool_use blocks in one turn as the parallelism mechanism — it may or may not execute concurrently
- Consider enabling Agent Teams (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`) once its session resumption limitations are fixed; note Windows Terminal split-pane is not supported (in-process mode still works on Windows)
- The 5-agent concurrency limit in the project's CLAUDE.md is well within the observed 10-agent cap

---

## Sources

1. [Create custom subagents — Claude Code Docs](https://code.claude.com/docs/en/sub-agents) — Official subagent documentation; foreground/background behavior, Agent tool mechanics
2. [Orchestrate agent teams — Claude Code Docs](https://code.claude.com/docs/en/agent-teams) — Agent Teams architecture, limitations, experimental status
3. [Subagents in the SDK — Claude API Docs](https://platform.claude.com/docs/en/agent-sdk/subagents) — SDK-level subagent dispatch; confirmation that Agent tool is the invocation mechanism
4. [Parallel tool execution support · Issue #438 · anthropics/claude-agent-sdk-python](https://github.com/anthropics/claude-agent-sdk-python/issues/438) — Anthropic confirmation that sequential execution is intentional; readOnlyHint workaround
5. [Feature Request: Parallel Agent Execution Mode · Issue #3013 · anthropics/claude-code](https://github.com/anthropics/claude-code/issues/3013) — Community discussion; CLOSED NOT_PLANNED; claude-launcher workaround mentioned
6. [Tool use with Claude — Claude API Docs](https://platform.claude.com/docs/en/agents-and-tools/tool-use/overview) — `disable_parallel_tool_use` parameter; model-level parallel tool use
7. [Claude Code Sub-Agents: Parallel vs Sequential Patterns](https://claudefa.st/blog/guide/agents/sub-agent-best-practices) — Conditions triggering parallel vs sequential dispatch
8. [Claude Code: Behind-the-scenes of the master agent loop](https://blog.promptlayer.com/claude-code-behind-the-scenes-of-the-master-agent-loop/) — Single-threaded master loop architecture; "at most one sub-agent branch at a time"
9. [Claude Code Subagent Deep Dive](https://cuong.io/blog/2025/06/24-claude-code-subagent-deep-dive) — Observed 10-agent parallelism cap; batch vs dynamic scheduling behavior
10. [Parallel Tool Execution with Claude 4 — Medium](https://medium.com/@gor17v/parallel-tool-execution-with-claude-4-building-high-performing-agents-with-bedrock-converse-api-433da0efab60) — Claude 4 model behavior for parallel tool calls; ~100% parallel success with minor prompting
11. [Optimize parallel tool calling with Claude 4 · Issue #460 · kortix-ai/suna](https://github.com/kortix-ai/suna/issues/460) — Anthropic docs cited: Claude 4 models excel at parallel tool execution
12. [How to Use Claude Code Subagents to Parallelize Development](https://zachwills.net/how-to-use-claude-code-subagents-to-parallelize-development/) — Practical parallel subagent usage; evidence of simultaneous dispatch observable behavior
