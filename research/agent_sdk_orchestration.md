# Claude Agent SDK — Multi-Session Orchestration Alternative to tmux/psmux

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-28
**Related:** None (new research thread)

---

## Executive Summary

The Claude Agent SDK (`claude-agent-sdk` on PyPI, `@anthropic-ai/claude-agent-sdk` on npm) is a programmatic interface to Claude Code that replaces terminal multiplexing with structured async streams. It eliminates idle detection hacking, pane scraping, and input bleed — the core fragility issues of the current psmux approach. However, it requires **separate API credits** (not Claude Max subscription, though an undocumented OAuth workaround exists), is in **Alpha** status with known Windows crash bugs, and the built-in multi-agent (Agent Teams) feature is **experimental and not yet functional on Windows**. For the specific psmux orchestration use case, the SDK is architecturally superior but operationally risky until the Windows crash bug (issue #36905) is resolved.

---

## Key Findings

### 1. Architecture and Subprocess Model

The SDK wraps the Claude Code CLI process internally. When you call `query()` or `ClaudeSDKClient`, the SDK spawns a Claude Code CLI subprocess, communicates over a JSON-lines protocol (stdin/stdout), and exposes an async iterator of typed message objects. No tmux, no pane rendering, no terminal emulation.

- **Python package:** `claude-agent-sdk` v0.1.55 (as of 2026-04-03)
- **npm package:** `@anthropic-ai/claude-agent-sdk`
- **Status:** "3 - Alpha" on PyPI; marked experimental in several subsystems
- **Python requirement:** 3.10+
- **The Claude Code CLI is bundled** — no separate install required
- **Release cadence:** 1–2 releases/day during active sprints; 20+ releases in March 2026 alone. Responsive bug fix cycle but indicates active churn.

Message types are fully structured Python dataclasses, not string scraping:
- `AssistantMessage` — Claude's reasoning and tool invocations
- `ToolUseBlock` / `ToolResultBlock` — tool call + result pairs
- `SystemMessage` — session init, metadata
- `ResultMessage` — final result with `total_cost_usd`, token counts, `session_id`
- `RateLimitEvent` — rate limit status with `resets_at` timestamp

### 2. Session Model

Sessions are persisted to disk as JSONL files under `~/.claude/projects/<encoded-cwd>/`. The path encoding replaces non-alphanumeric chars with `-`.

**Three session continuation modes:**
- `continue_conversation=True` — resumes the most recent session in cwd (no ID tracking needed)
- `resume=session_id` — resumes a specific session by ID
- `fork_session=True` (with `resume=`) — branches the conversation history without modifying the original

**`ClaudeSDKClient`** is the stateful multi-turn interface; it tracks session IDs internally so you don't handle them manually between calls.

**Cross-host limitation:** Sessions are local to the machine that created them. Moving to a different host requires manually shipping the JSONL file to the same path with the same working directory encoding.

### 3. Multi-Instance Orchestration (N Concurrent Agents)

**Yes, you can run N concurrent Claude Code agents from one Python script.** The documented pattern is:

```python
# Each ClaudeSDKClient instance maintains its own independent session
client1 = ClaudeSDKClient()
client2 = ClaudeSDKClient()

await asyncio.gather(
    process_with_client(client1, "task1"),
    process_with_client(client2, "task2"),
)
```

Each call to `query()` also creates an independent session; multiple concurrent `query()` calls are independent. There is **no built-in dispatch/poll/capture scheduler** — you manage concurrency yourself with `asyncio.gather()` or task groups.

**What replaces idle detection:** The `async for` loop over `query()` or `client.receive_response()` terminates naturally when the agent finishes. `ResultMessage` is the terminal message with `subtype` of `"success"` or `"error_max_turns"` or `"error_max_budget_usd"`. No polling, no regex-on-pane-output.

**Budget controls:** `max_budget_usd: float` on `ClaudeAgentOptions` stops execution hard when cost exceeds the limit. `max_turns: int` caps turn count. Both produce a `ResultMessage` with the appropriate error subtype.

### 4. Subagent Model (Built-in Dispatch)

Subagents are spawned **within a single `query()` call** via the `Agent` tool. The parent agent decides (based on `AgentDefinition.description`) when to delegate. Subagents run sequentially or in parallel at Claude's discretion (the docs claim parallel is possible but the mechanism is Claude-decided, not Python-controlled).

```python
AgentDefinition(
    description="When to invoke this agent",  # Claude reads this to decide
    prompt="System prompt for the subagent",
    tools=["Read", "Grep", "Glob"],           # Tool subset (optional)
    model="sonnet"                            # Model override (optional)
)
```

**Critical constraint:** Subagents cannot spawn their own subagents. Max depth is 2 (parent → subagent). No nested teams.

**Context isolation:** Subagents get a fresh context window. Only the Agent tool's prompt string passes information from parent to subagent — the parent's conversation history does not carry over.

**Parent receives:** Only the subagent's final message verbatim as the Agent tool result. Intermediate tool calls stay inside the subagent's context, which keeps the parent's context window smaller.

### 5. Agent Teams (Experimental)

Agent Teams is a separate feature from the SDK's programmatic subagent model. It coordinates multiple full Claude Code CLI instances with a shared task list and inter-agent messaging:

```
Team lead (one Claude Code session)
  └─ Shared task list (file-based, with file locking)
  └─ Mailbox (async message delivery)
  └─ Teammate 1 (separate Claude Code instance, own context)
  └─ Teammate 2 (separate Claude Code instance, own context)
  └─ Teammate N...
```

**This is the closest equivalent to the current psmux DAG orchestration model.**

Enabled via `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in settings.json or environment.

**Agent Teams on Windows: Not functional.**
- Requires tmux or iTerm2 for split-pane mode
- In-process mode falls back used when `isTTY` is `undefined` (which happens on Windows)
- psmux (the Windows tmux replacement) is **not yet officially supported** — GitHub issue #34150 is an open feature request
- Per the limitations doc: "Split panes require tmux or iTerm2: not supported in VS Code's integrated terminal, Windows Terminal, or Ghostty"

### 6. Permission Handling

No more "do you want to proceed?" terminal prompts blocking automation. Permission is controlled via `permission_mode` on `ClaudeAgentOptions`:

| Mode | Behavior |
|------|----------|
| `acceptEdits` | Auto-approves all file edits; other tools still ask |
| `dontAsk` | Denies anything not in `allowed_tools` — no prompts |
| `bypassPermissions` | Auto-approves everything (use in sandboxed CI only) |
| `plan` | No execution; planning only |
| `default` | Custom `canUseTool` callback decides per-tool |

For headless orchestration: `dontAsk` with an explicit `allowed_tools` list is the clean pattern. `bypassPermissions` is for fully trusted environments.

**Hooks** provide fine-grained interception:
- `PreToolUse` — can block or modify tool calls before execution
- `PostToolUse` — audit logging, side effects after tool runs
- `Stop` — intercept session completion
- `TeammateIdle` (Agent Teams only) — keep teammates working by returning exit code 2

Hooks are Python async functions, not shell scripts — no subprocess spawning for hook logic.

### 7. Dispatch-Poll-Capture Patterns

**Streaming (default):** `async for message in query(...)` yields messages as Claude produces them. Live output visible in real time. No polling required.

**Non-streaming (batch):** Collect all messages into a list:
```python
messages = [msg async for msg in query(prompt=..., options=...)]
result = next(m for m in messages if isinstance(m, ResultMessage))
```

**Fire-and-forget then check:** Not natively supported. The SDK is strictly async streaming — you must await the iterator to completion to get `ResultMessage`. For background execution, wrap in `asyncio.create_task()`:
```python
tasks = [asyncio.create_task(run_agent(prompt)) for prompt in prompts]
results = await asyncio.gather(*tasks)
```

**Interrupt mid-stream:** `await client.interrupt()` on `ClaudeSDKClient`.

**`persistSession: false` (TypeScript only):** Python always writes session to disk. No in-memory-only mode in Python.

### 8. Billing: API Credits vs. Claude Max Subscription

**Official stance:** The SDK requires `ANTHROPIC_API_KEY` (pay-per-token API credits). Claude Max subscription is for interactive use only.

**Practical workaround (community-confirmed, Feb 2026):**
```bash
claude setup-token          # one-time
export CLAUDE_CODE_OAUTH_TOKEN=<token from claude setup-token>
```
This authenticates the SDK through the Max plan OAuth token, using subscription billing instead of API pay-per-token. Issue #559 on the Python SDK repo was closed as "COMPLETED" after this was confirmed working.

**Anthropic's official documentation does not mention this path.** It's undocumented and could change.

**Cost at API rates for heavy orchestration:** Users running multi-agent workflows with Opus have reported consuming $1,000–$5,000/month API-equivalent. At Max subscription rates, the same workload costs $100–$200/month. The billing gap is significant for the theater project's orchestration use case.

**Known billing bug (as of March 2026):** A prompt cache invalidation bug causes full 200K-token rebilling on every turn in long sessions. This most impacts large codebases with long system prompts and multi-turn tool use — exactly the task DAG pattern in use.

### 9. Known Bugs and Limitations

**Windows crash (OPEN, issue #36905, as of 2026-03-21):**
```
Error: All fibers interrupted without error
    at streamInput (@anthropic-ai/claude-agent-sdk/sdk.mjs:22:1905)
```
Affects SDK v0.2.77 and v0.2.81 on Windows 11. The backend crashes and restarts in a loop when starting a Claude turn. Status: **unresolved/open** as of the research date.

**Note:** The npm version numbers (0.2.x) differ from the PyPI version numbers (0.1.x). The npm bug may not map directly to Python SDK behavior, but the underlying Claude Code CLI is shared.

**Other known bugs:**
- `break` inside `async for` on `receive_response()` causes asyncio cleanup issues — must let iteration complete or use flags
- `connect(prompt="...")` silently dropped the string prompt in some versions, causing `receive_messages()` to hang (fixed)
- Fine-grained tool streaming regression (v0.1.36–0.1.47, fixed in v0.1.48)
- Unbounded memory growth in long sessions from UUID tracking (fixed)
- Prompt cache invalidation billing bug (not yet confirmed fixed as of research date)

**Subagent prompt length limit on Windows:** Subagents with very long prompts may fail on Windows due to the 8191-character command line length limit. Relevant to the theater project's detailed agent definitions in `.claude/agents/`.

**Agent Teams session resumption:** `/resume` and `/rewind` do not restore in-process teammates after a session restart. After resuming, the lead tries to message teammates that no longer exist.

**No nested teams:** Maximum agent hierarchy depth is 2 (lead + teammates, or parent + subagents). Cannot nest a team inside a teammate.

### 10. Real-World Community Examples

- **claude_code_agent_farm** (GitHub: Dicklesworthstone): 20–50 parallel Claude Code agents via Python + tmux. Uses adaptive idle timeout, lock-based file coordination, git commit tracking, heartbeat monitoring. Explicitly chose tmux over the SDK — SDK is not used. Represents the current state-of-the-art in tmux-based orchestration.
- **Multiclaude** (Dan Lorenc): Brownian ratchet philosophy; singleplayer/multiplayer modes; better for team review workflows.
- **Gas Town** (Steve Yegge): Hierarchical "mayor" agent; Kubernetes-for-agents metaphor; better for solo developer hobby projects.
- **Microsoft Agent Framework:** Claude Agent SDK agents composable with Azure OpenAI agents in sequential/concurrent/group-chat workflows.

Community consensus: "Multi-agent orchestration makes sense for only 5% of tasks" — best reserved for projects where single-session context limits are genuinely binding.

---

## Comparison Table

| Dimension | Claude Agent SDK | Current psmux/tmux approach |
|-----------|------------------|-----------------------------|
| **Output capture** | Structured typed Python objects (`AssistantMessage`, `ResultMessage`, etc.) | Regex on pane-rendered terminal text |
| **Idle detection** | Iterator terminates on `ResultMessage`; no polling needed | Regex pattern matching on pane output; fragile |
| **Input injection** | `await client.query("prompt")` — direct Python call | `sendkeys` + timing delays; can bleed between sessions |
| **Permission handling** | Declarative `permission_mode` + hooks; no interactive prompts | TTY prompt handling required; can block automation |
| **Concurrency** | `asyncio.gather()` on N `query()` calls or `ClaudeSDKClient` instances | N psmux panes; managed by Python via sendkeys |
| **Cost model** | API pay-per-token (or OAuth workaround for Max) | Claude Max subscription via OAuth |
| **Windows support** | Python SDK: functional but crash bug in npm SDK; Agent Teams: blocked | Working (psmux is primary use case) |
| **Session resume** | `resume=session_id` or `continue_conversation=True` | Manual pane re-creation; no structured session state |
| **Synthesis** | Parse `ResultMessage.result` — structured string | Scrape pane content after idle detection |
| **Subagent dispatch** | Native `AgentDefinition` + `Agent` tool; Claude decides when to spawn | External Python orchestrator decides; sends prompts manually |
| **Agent-to-agent comms** | Agent Teams only (experimental, not on Windows) | Not available |
| **Maturity** | Alpha (PyPI status); active bug fixes daily | Stable for existing use case; no active maintenance needed |
| **Cross-machine** | Session files local; must ship JSONL manually | Not applicable (local only) |
| **Max context** | Inherits Claude Code's context window; same limits | Same limits |
| **Token cost at scale** | High: each agent instance has its own context window | High: same |
| **Hooks/callbacks** | Python async functions; `PreToolUse`, `PostToolUse`, `Stop`, etc. | Not available |
| **Breaking change risk** | High: 1–2 releases/day, multiple regressions documented | Low: stable existing implementation |

---

## Follow-up Tasks Created

None — this is a standalone research topic. If the decision is made to pilot the SDK, recommend creating a verify task to confirm the Windows crash bug status before investing in migration.

---

## Bidirectional Search

- **Searched FOR:** claude agent sdk features, quickstart, session management, subagents, permissions, multi-instance orchestration, async streaming, AgentDefinition, ClaudeSDKClient, Python API reference, billing/cost model, official docs
- **Searched AGAINST:** claude agent sdk bugs, problems, limitations, Windows issues, crashes, broken features, billing concerns, community complaints, rate limiting issues, tmux replacement alternatives
- **Contradicting evidence found:** Yes — multiple issues found:
  1. Open Windows crash bug (#36905, npm SDK, March 2026 — unresolved)
  2. Billing model explicitly requires API credits, not Max subscription (though undocumented OAuth workaround exists and was confirmed working)
  3. Agent Teams on Windows is non-functional (feature request open, not implemented)
  4. PyPI status is "Alpha" — not production-grade
  5. Prompt cache invalidation billing bug causes 200K-token rebilling per turn in long sessions
  6. Multiple regressions (streaming, deadlocks, prompt dropping) in recent versions
  7. Subagent prompt length cap on Windows (8191 chars) would affect current detailed agent definitions

---

## Recommendations

**Short answer: The SDK is architecturally the right direction but is not ready for this use case today.**

**Adopt for:** Clean programmatic control, no idle detection, structured output, hook-based permission handling. These are genuine improvements over psmux scraping.

**Block on:**
1. **Windows crash bug (#36905)** — if this affects the Python SDK (not just the npm package), the SDK is non-functional on Windows 11 today. Verify which SDK package is actually crashing before investing in migration.
2. **Billing model** — the OAuth workaround is community-discovered and undocumented. Relying on it is fragile. If Anthropic closes the workaround, all SDK usage reverts to pay-per-token API billing at potentially 10x the cost. This is a real financial risk for heavy orchestration use.
3. **Alpha stability** — daily releases with documented regressions mean a migration could break between Claude Code updates.

**Recommended path:**
1. Create a minimal test harness: one `query()` call on Windows with `dontAsk` permission mode. If it completes without the fiber crash, the npm-specific crash does not affect the Python SDK.
2. If test passes, pilot with a single non-critical agent task (e.g., a research agent) using the OAuth token auth path.
3. Watch the billing model — if Anthropic formalizes Max subscription support for the SDK (there's user demand), the financial blocker disappears.
4. Agent Teams on Windows is not viable until issue #34150 is resolved. The current psmux DAG remains the better option for Windows multi-session orchestration.

**Confidence:** Medium-high on architecture analysis; Low on Windows crash status (Python SDK vs npm SDK distinction needs direct testing).

---

## Sources

1. [Claude Agent SDK Overview — platform.claude.com](https://platform.claude.com/docs/en/agent-sdk/overview)
2. [Claude Agent SDK Quickstart — platform.claude.com](https://platform.claude.com/docs/en/agent-sdk/quickstart)
3. [Claude Agent SDK Sessions — platform.claude.com](https://platform.claude.com/docs/en/agent-sdk/sessions)
4. [Claude Agent SDK Subagents — platform.claude.com](https://platform.claude.com/docs/en/agent-sdk/subagents)
5. [Claude Agent SDK Permissions — platform.claude.com](https://platform.claude.com/docs/en/agent-sdk/permissions)
6. [Python SDK API Reference — platform.claude.com](https://platform.claude.com/docs/en/agent-sdk/python)
7. [claude-agent-sdk on PyPI](https://pypi.org/project/claude-agent-sdk/)
8. [@anthropic-ai/claude-agent-sdk on npm](https://www.npmjs.com/package/@anthropic-ai/claude-agent-sdk)
9. [GitHub: anthropics/claude-agent-sdk-python](https://github.com/anthropics/claude-agent-sdk-python)
10. [GitHub: anthropics/claude-agent-sdk-python Releases](https://github.com/anthropics/claude-agent-sdk-python/releases)
11. [Orchestrate teams of Claude Code sessions — code.claude.com](https://code.claude.com/docs/en/agent-teams)
12. [Bug: Claude Agent SDK crashes on Windows — issue #36905](https://github.com/anthropics/claude-code/issues/36905)
13. [Agent SDK should support Max plan billing — issue #559](https://github.com/anthropics/claude-agent-sdk-python/issues/559)
14. [Support tmux agent teams on Windows via psmux — issue #34150](https://github.com/anthropics/claude-code/issues/34150)
15. [Multi-agent orchestration for Claude Code in 2026 — shipyard.build](https://shipyard.build/blog/claude-code-multi-agent/)
16. [GitHub: claude_code_agent_farm (Dicklesworthstone)](https://github.com/Dicklesworthstone/claude_code_agent_farm)
17. [Claude Code Pricing 2026 — ssdnodes.com](https://www.ssdnodes.com/blog/claude-code-pricing-in-2026-every-plan-explained-pro-max-api-teams/)
18. [Using Claude Code with Pro or Max plan — support.claude.com](https://support.claude.com/en/articles/11145838-using-claude-code-with-your-pro-or-max-plan)
19. [Claude Agent SDK demos — GitHub](https://github.com/anthropics/claude-agent-sdk-demos)
20. [Build AI Agents with Claude Agent SDK and Microsoft Agent Framework — devblogs.microsoft.com](https://devblogs.microsoft.com/agent-framework/build-ai-agents-with-claude-agent-sdk-and-microsoft-agent-framework/)
