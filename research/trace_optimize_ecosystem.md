# Claude Code Agent Observability & Optimization Ecosystem

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-21
**Related:** research/design_package_dag_analysis.md, research/design_package_infra_analysis.md

---

## Executive Summary

A significant ecosystem of tracing and observability tools has emerged around Claude Code in 2025-2026. The dominant pattern is hook-based JSONL capture feeding dashboards or external platforms. No tool provides native DAG visualization or prompt-scope analysis — those remain gaps. The closest candidates for this project are **agentprof** (lightweight local profiler), **claudewatch** (MCP-native multi-agent metrics), and **Dev-Agent-Lens/Phoenix** (free OSS OpenTelemetry stack). Commercial platforms (LangSmith, Langfuse, Laminar) integrate well but require cloud accounts.

---

## Key Findings

### 1. Claude Code Hook Architecture (Foundation for All Tools)

Claude Code exposes 12 lifecycle events via `.claude/settings.json` hooks:

| Hook | Purpose |
|------|---------|
| PreToolUse / PostToolUse | Wrap every tool call |
| PostToolUseFailure | Error tracking |
| UserPromptSubmit | Capture inbound prompts |
| SubagentStart / SubagentStop | Agent lifecycle boundaries |
| SessionStart / SessionEnd | Session bookends |
| Stop | Post-response trigger |
| PreCompact, PermissionRequest, Notifications | Misc lifecycle |

All observability tools use some subset of these hooks. The `Stop` hook is the standard trigger for post-response logging (LangSmith uses it). PreToolUse/PostToolUse capture per-tool latency.

Claude Code also natively emits OpenTelemetry when `CLAUDE_CODE_ENABLE_TELEMETRY=1` is set, routing to any OTEL collector.

### 2. Local / Lightweight Profilers

**agentprof** (GitHub: kitaisreal/agentprof)
- Captures timestamps, tool names, input/output payloads, token estimates, latency
- Three output modes: live web dashboard, terminal report, raw JSONL
- Installs via `install` command that writes PreToolUse/PostToolUse hooks to `.claude/settings.json`
- Web dashboard shows summary cards, per-method percentile latencies, visual timelines, slowest call rankings
- Status: v0.1.0, February 2026, single contributor, early-stage but functional [UNVERIFIED: stability]

**ccusage** (GitHub: ryoppippi/ccusage)
- Analyzes existing Claude Code JSONL logs for token/cost tracking
- Read-only — no hook installation, just reads `~/.claude/` logs
- Outputs daily/monthly/session usage tables
- Does not capture latency or per-tool timing

**claude-code-log** (GitHub: daaain/claude-code-log)
- Converts JSONL transcripts to readable HTML or Markdown
- Chronological view of user prompts + assistant responses
- Session replay (read-only, retrospective) — no performance metrics

**Claudex** (from awesome-claude-code list)
- Browser for exploring Claude Code conversation history across projects
- Full-text search, local analytics, no telemetry
- Retrospective only — not a live monitor

**ccflare** (from awesome-claude-code list)
- Comprehensive usage metrics via web UI
- Detailed logging with "thoroughly comprehensive metrics"
- Extent of multi-agent specificity is [UNVERIFIED]

### 3. Multi-Agent Observability (Closest to DAG Monitoring)

**claudewatch** (GitHub: blackwell-systems/claudewatch + NirDiamant/claude-watch)
- Reads `~/.claude/` JSONL session files — no API proxy needed
- Exposes **29 MCP tools** callable from within Claude Code itself (self-reflection during sessions)
- Key tools:
  - `get_project_health` — friction rate, agent success
  - `get_drift_signal` — exploring vs implementing ratio
  - `get_agent_performance` — success rates by agent type
  - `get_blockers` — known unresolved blockers
  - `get_session_dashboard` — all live metrics
- Detects error loops, cost spikes, cross-session task history
- Computes parallelization ratios, kill patterns, cost-per-task, duration/token breakdown
- No DAG graph visualization — tabular metrics only
- Architecture is exactly what this project's DAG system would benefit from

**claude-code-hooks-multi-agent-observability** (GitHub: disler)
- Vue 3 dashboard with live event timeline, color-coded by session
- Tracks all 12 hook events with real-time display
- "Live pulse chart" showing activity bars by session + event type
- Filters by app, session, event type
- Chat transcript viewer with syntax highlighting
- No DAG dependency visualization — event sequence only
- Install: copy `.claude/` directory, run local Bun server, dashboard at localhost:5173

### 4. Commercial / Platform Observability

**LangSmith** (LangChain)
- Integrates via `Stop` hook reading conversation transcripts
- Groups all turns from same session using `thread_id` (Threads tab)
- Does NOT capture system prompts (not in transcripts)
- Visualizes user messages, tool calls, assistant responses
- Currently macOS-only setup
- No multi-agent DAG tracing documented for Claude Code integration
- Free tier available; requires LangSmith account

**Langfuse** (OSS + cloud)
- Integrates via OpenTelemetry instrumentation from LangChain's Claude Agent SDK library
- Captures every tool call and model completion as OTel spans
- Nested spans: outer application calls → inner LLM calls (proper hierarchy)
- Has a free tier; self-hostable
- No specific DAG visualization for task DAGs

**Laminar**
- Rust proxy (~1.5MB) that wraps the Claude Agent SDK subprocess
- Bridges the black-box subprocess boundary — captures prompts, tool inputs/outputs, latency
- Traces properly nest outer application spans around inner Claude calls
- Pricing not documented; likely commercial

**Dev-Agent-Lens** (Arize)
- Proxy-based layer routing requests through LiteLLM
- Emits OpenTelemetry + OpenInference spans
- Captures: raw model requests, prompt construction, tool calls (success/failure), final output assembly
- Sends to Arize AX (commercial) OR Phoenix (OSS, local)
- Phoenix is free and runs locally — viable for home lab
- No DAG visualization; focuses on latency + token + failure metrics

**claude-code-otel** (GitHub: ColeMurray)
- Full OSS stack: OTel Collector + Prometheus + Loki + Grafana
- Tracks cost by model, token breakdown, API latency, success rates, productivity (LOC, commits)
- Requires `CLAUDE_CODE_ENABLE_TELEMETRY=1` environment variable
- Pre-built Grafana dashboards
- No DAG visualization; cost/usage focus
- Install: `make up` (Docker Compose)

### 5. Claude Agent SDK — Built-in Observability

The Claude Agent SDK Python package (anthropics/claude-agent-sdk-python) has **no built-in observability**. It provides:
- A hooks system (`PreToolUse`, `PostToolUse` matchers) for intercepting tool calls
- Hooks are designed for deterministic processing/feedback, not logging/tracing
- No native DAG tracing, session replay, or performance visualization
- Anthropic's reference demos (claude-agent-sdk-demos) show multi-turn conversation patterns but no tracing examples

For observability with the SDK, you must implement custom hooks or use a third-party proxy (Laminar, LiteLLM).

### 6. Prompt Optimization — No Dedicated Tools Found

No tool was found that specifically analyzes agent prompts for:
- Verbosity / token waste
- Scope violations (agent doing work outside its designated role)
- Instruction conflict detection
- Prompt coverage gaps

The closest is the Anthropic Console's built-in prompt improver, which is for API prompts, not Claude Code system prompts. The nexus-labs agent-observability plugin has "7 Anti-Pattern Hooks" for detecting scope creep and verbosity, but it guides instrumentation rather than auto-analyzing prompts.

**agentwise** claims 15-30% token reduction via context sharing (SharedContextServer) and smart caching for shared context, but applies only to parallel multi-agent scenarios and does not analyze individual prompts.

### 7. MCP Servers for Session Analysis

**claudewatch MCP** — 29 tools, reads `~/.claude/` JSONL directly (see section 3 above)

**session-logs skill** (FastMCP) — provides jq/bash templates for querying `~/.openclaw/agents/<agentId>/sessions/` JSONL. Covers keyword search, cost calculation, tool usage breakdown. No performance analysis. Appears to target a different agent runtime (`openclaw`, not Claude Code).

---

## Comparison Table

| Tool | Type | DAG Viz | Multi-Agent | Latency | Cost/Token | Local/OSS | Install Effort |
|------|------|---------|-------------|---------|-----------|-----------|---------------|
| agentprof | Hook-based profiler | No | Basic | Yes | Estimated | OSS, local | Low (1 command) |
| ccusage | JSONL reader | No | No | No | Yes | OSS, local | Low (CLI) |
| claude-code-log | JSONL → HTML | No | No | No | No | OSS, local | Low |
| claudewatch | MCP + JSONL | No | Yes | No | Yes | OSS, local | Medium |
| hooks-multi-agent-observability | Hook + Vue dashboard | No | Yes | Partial | No | OSS, local | Medium (Bun server) |
| claude-code-otel | OTel + Grafana | No | No | Yes | Yes | OSS, Docker | Medium-High |
| Dev-Agent-Lens + Phoenix | Proxy + OTel | No | Partial | Yes | Yes | OSS (Phoenix) | Medium |
| LangSmith | Cloud trace | No | Thread-level | No | No | Commercial | Low-Medium |
| Langfuse | Cloud/OSS trace | No | Span hierarchy | Yes | No | OSS (self-host) | Medium |
| Laminar | Rust proxy | No | Yes | Yes | No | Commercial? | Medium |

**Gap identified:** No tool provides DAG dependency graph visualization (task → task → blocked-by relationships). This is a genuine hole in the ecosystem.

---

## Follow-up Tasks Created

None created — this is a self-contained research pass. The research task was standalone.

If the team wants to act on these findings, suggested next steps are in Recommendations below.

---

## Bidirectional Search

- **Searched FOR:** "claude code session trace", "claude code agent profiler", "claude code plugin observability", "claude code JSONL analyzer", "claude agent SDK tracing", "multi-agent DAG optimizer", "agentic workflow profiler", "claude code DAG visualization", "claude code prompt optimization verbosity"
- **Searched AGAINST:** "claude code DAG task execution optimizer bottleneck detection" (no dedicated DAG optimizer found), "claude code prompt scope analysis tool" (no such tool found), "claude agent SDK built-in tracing" (confirmed: no built-in tracing), "claude code session replay DAG" (confirmed: no replay with DAG structure)
- **Contradicting evidence found:** No — the gap in DAG visualization and prompt optimization is consistent across all sources. Several tools claim multi-agent observability but all deliver event timelines or tabular metrics, not dependency graph rendering. The Claude Agent SDK has no native tracing (confirmed by SDK docs).

---

## Recommendations

### Immediate Adoption Candidates

1. **agentprof** (confidence: medium) — Lowest friction for latency profiling. Single install command hooks into existing `.claude/settings.json`. Web dashboard shows which tools and agent types are slowest. Caveat: v0.1.0, single contributor — treat as experimental.

2. **claudewatch** (confidence: medium-high) — MCP-native, reads existing JSONL without any modification to hooks. The `get_agent_performance` and `get_parallelization_ratio` tools are directly applicable to evaluating this project's task DAG efficiency. Can be called mid-session for self-diagnostic. OSS, local, no cloud dependency.

3. **claude-code-otel + Grafana** (confidence: medium) — If Docker is acceptable, this is the most complete local stack. Pre-built dashboards, no cloud account needed. Good for long-term cost tracking across the build project.

### Not Recommended (for this project)

- **LangSmith** — macOS-only setup; project runs on Windows 11.
- **Dev-Agent-Lens / Arize AX** — Commercial platform; Phoenix is viable but adds infrastructure complexity vs. simpler alternatives.
- **Laminar** — Pricing unclear; proxy-based approach adds latency risk.
- **agentwise** — Phase-based synchronization model conflicts with this project's task DAG model; token savings claims are [UNVERIFIED].

### Gaps With No Current Solution

- **DAG dependency graph visualization** — No existing tool renders task → blocked-by relationships as a graph. Would require building custom visualization on top of claudewatch MCP output or the existing `tools/session_monitor.py`.
- **Prompt scope analysis** — No tool analyzes whether agent prompts are producing scope violations or verbosity waste. Would require custom evaluation harness.
- **Windows-native tooling** — Most tools assume macOS/Linux. Hook scripts are bash-based (compatible via Git Bash on this project), but setup documentation rarely covers Windows paths.

---

## Sources

1. [agentprof — GitHub: kitaisreal/agentprof](https://github.com/kitaisreal/agentprof)
2. [ccusage — GitHub: ryoppippi/ccusage](https://github.com/ryoppippi/ccusage)
3. [claude-code-log — GitHub: daaain/claude-code-log](https://github.com/daaain/claude-code-log)
4. [claudewatch MCP docs — GitHub: blackwell-systems/claudewatch](https://github.com/blackwell-systems/claudewatch/blob/main/docs/mcp.md)
5. [Claude Code Observability — Dev-Agent-Lens (Arize)](https://arize.com/blog/claude-code-observability-and-tracing-introducing-dev-agent-lens/)
6. [claude-code-hooks-multi-agent-observability — GitHub: disler](https://github.com/disler/claude-code-hooks-multi-agent-observability)
7. [claude-code-otel — GitHub: ColeMurray](https://github.com/ColeMurray/claude-code-otel)
8. [Trace Claude Code — LangSmith Docs](https://docs.langchain.com/langsmith/trace-claude-code)
9. [Claude Agent SDK tracing — Langfuse](https://langfuse.com/integrations/frameworks/claude-agent-sdk)
10. [Laminar: Instrumenting Claude Agent SDK via Rust proxy](https://laminar.sh/blog/2025-12-03-claude-agent-sdk-instrumentation)
11. [Claude Agent SDK Python — GitHub: anthropics](https://github.com/anthropics/claude-agent-sdk-python)
12. [agentwise — GitHub: VibeCodingWithPhil/agentwise](https://github.com/VibeCodingWithPhil/agentwise)
13. [Awesome Claude Code — GitHub: hesreallyhim](https://github.com/hesreallyhim/awesome-claude-code)
14. [nexus-labs agent-observability plugin — GitHub](https://github.com/nexus-labs-automation/agent-observability)
15. [session-logs MCP skill — FastMCP](https://fastmcp.me/skills/details/618/session-logs)
16. [Best LLM Observability Tools 2026 — Firecrawl](https://www.firecrawl.dev/blog/best-llm-observability-tools)
17. [Claude Code official monitoring docs](https://code.claude.com/docs/en/monitoring-usage)
18. [Claude Code Plugins Official — GitHub: anthropics](https://github.com/anthropics/claude-plugins-official)
19. [Braintrust: Best LLM Tracing Tools 2026](https://www.braintrust.dev/articles/best-llm-tracing-tools-2026)
20. [Claude Code system prompts reference — GitHub: Piebald-AI](https://github.com/Piebald-AI/claude-code-system-prompts)
