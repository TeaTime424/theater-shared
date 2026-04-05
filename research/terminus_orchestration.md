# Terminus & Alternatives for Multi-Session Claude Code Orchestration

**Status:** RESEARCH — Not adopted
**Date:** 2026-04-02

---

## Executive Summary

**Terminus** is the reference autonomous AI agent for [Terminal-Bench](https://www.tbench.ai/) — the standard benchmark for evaluating LLM terminal capabilities. It's a research harness (not a coding assistant or orchestration tool) that gives an LLM a single tmux session and measures what it can accomplish autonomously. It does not replace tmux+psmux for multi-session orchestration. However, research uncovered a rich ecosystem of alternatives. The most relevant findings for a Windows 11 + psmux workflow:

1. **psmux is already the right tool** for Windows-native tmux replacement (941 stars, 76 tmux commands, Rust native)
2. **Claude Code Agent Teams in-process mode** works without tmux in any terminal — split panes are visual convenience only
3. **initech** is the most technically interesting tmux-free alternative (PTY daemon + IPC, no send-keys)
4. **claude-squad** (6.8k stars), **dmux** (1.3k stars), **amux** all require tmux — not Windows-native
5. **The bottleneck is task decomposition, not session management** — the existing task DAG workflow already handles this

---

## 1. What Terminus Actually Is

**Terminus is the reference autonomous AI agent for Terminal-Bench** — the standard benchmark for evaluating LLM terminal capabilities. Created by Mike Merrill & Alex Shaw (Laude Institute / Stanford), released May 19, 2025.

| Item | Detail |
|------|--------|
| Type | Benchmark harness agent (not a coding assistant or orchestration tool) |
| Repo | [laude-institute/terminal-bench](https://github.com/laude-institute/terminal-bench) |
| Install | `pip install terminal-bench` → `tb run --agent terminus --model <model>` |
| Paper | [ArXiv 2601.11868](https://arxiv.org/abs/2601.11868) |
| License | Open source |

### Architecture

- **Mono-tool / tmux-only design.** The LLM gets exactly one capability: an interactive tmux session in a Docker container. No specialized Read/Edit/Bash tools — just raw keystrokes into tmux.
- **Model-agnostic via LiteLLM.** Any API or local model (Anthropic, OpenAI, Google, Ollama). Exists because Claude Code can't benchmark other models.
- **Autonomy-first.** Never requests user approval. Fully sandboxed.
- **Remote execution.** Python process outside the Docker container, controlling it via tmux.

### Terminal-Bench 2.0 Leaderboard (as of March 2026)

| Agent | Model | Score |
|-------|-------|-------|
| ForgeCode | GPT-5.4 / Claude Opus 4.6 | ~81.8% |
| TongAgents | Gemini 3.1 Pro | 80.2% |
| SageAgent | GPT-5.3-Codex | 78.4% |
| Terminus-KIRA | Frontier models | 74.8% |
| Terminus-2 | GPT-5.3-Codex | ~64.7% |
| Terminus-2 | Claude Opus 4.6 | ~62.9% |

### Terminus-KIRA (Enhanced Variant)

Krafton AI's extension (+10pp over base): explicit autonomous prompting, mandatory self-evaluation, pull-based tmux mechanism, adaptive replanning. GitHub: [krafton-ai/KIRA](https://github.com/krafton-ai/KIRA)

### Other "Terminus" Names (Unrelated)

| Project | What It Is | Relevant? |
|---------|-----------|-----------|
| Tabby (formerly Terminus) | Electron terminal emulator, ~70K stars | No |
| Pantheon Terminus | Hosting platform CLI | No |

---

## 2. Actual Alternatives Landscape

### Category A: Claude Code Built-in (No External Tool Needed)

**Agent Teams — In-Process Mode**
- Source: https://code.claude.com/docs/en/agent-teams
- Experimental (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`)
- Works in ANY terminal, no tmux/psmux needed
- One lead + N teammates, shared task list, peer messaging
- Windows: in-process works; split-pane broken (isTTY gate bug #26244)
- Limitation: no session resumption for in-process teammates

**Subagents (Current Project Approach)**
- Source: https://code.claude.com/docs/en/sub-agents
- Fully in-process, no terminal multiplexer needed
- Results return to parent agent only (no peer communication)
- Windows: works natively — this is what the task DAG uses today

### Category B: tmux Replacements (Don't Require tmux)

| Tool | Approach | Windows | Stars | Maturity |
|------|----------|---------|-------|----------|
| **psmux** | Native Windows tmux protocol (Rust, ConPTY) | Yes (native) | 941 | Production (v3.3.1, Mar 2026) |
| **initech** | PTY daemon + IPC sockets (no send-keys) | Unknown | 464 commits, 161 releases | Production (v0.26.5) |
| **KILD** | tmux shim → PTY daemon | Unknown | Prototype | Proposal stage |
| **Zellij** | Modern Rust multiplexer | Better than tmux | Active | Mature, but no Claude Code backend yet (#31901) |
| **WezTerm** | GPU terminal + built-in multiplexing | Yes (native) | Active | Mature, proposed in #26572 |

**psmux** (https://github.com/psmux/psmux) — 25,600 lines of Rust. 76 tmux commands with flag-level compatibility. Reads .tmux.conf. Sets TMUX/TMUX_PANE env vars correctly. <100ms session creation, <80ms pane splits. Would unlock Claude Code split-pane agent teams on Windows pending 2-3 upstream fixes (issue #34150).

**initech** (https://github.com/nmelo/initech) — The most technically interesting alternative. Purpose-built for AI agent orchestration. Key differentiators:
- PTY emulation + IPC sockets instead of tmux send-keys (reliable delivery)
- Agent activity state detection (active/idle/stalled) — tmux can't distinguish
- Claude session log parsing for bead events
- 13 role templates (engineer, PM, architect, etc.)
- Cross-machine support
- 71.5% test coverage, Homebrew distribution

### Category C: tmux-Dependent Tools (Linux/macOS Only)

| Tool | Description | Stars | Windows |
|------|-------------|-------|---------|
| **claude-squad** | TUI managing multiple agents in tmux + worktrees | 6.8K | No |
| **dmux** | Dev agent multiplexer, auto worktree+branch per pane | 1.3K | No |
| **amux** | Python+tmux, web dashboard, mobile PWA, self-healing | 107 | No |
| **Gastown** | Multi-agent orchestration, persistent work tracking | Active | No |
| **Multiclaude** | Singleplayer/multiplayer modes, auto-merge | Active | No |
| **Citadel** | 4-tier routing, campaign persistence, circuit breaker | Active | No |
| **Agent Farm** | 20+ parallel agents, lock-based coordination | Active | No |

All build ON TOP of tmux — inherit its Windows limitation.

### Category D: Framework/Desktop (Above Terminal Layer)

| Tool | Description | Windows |
|------|-------------|---------|
| **claude-flow/ruflo** | Multi-agent swarms, enterprise architecture | Framework-level |
| **ccswarm** | Task delegation + worktree isolation | Uses tmux |
| **parallel-code** | Desktop app, side-by-side agents + diff viewer | Desktop (cross-platform) |
| **crystal/Nimbalyst** | Electron app, kanban board, mobile monitoring | Desktop (cross-platform) |

### Category E: Proposed Protocol Changes

**CustomPaneBackend Protocol** (Claude Code issue #26572) — Would decouple agent teams from tmux CLI entirely. Any terminal/multiplexer could serve as backend: Ghostty, WezTerm, Zellij, KILD, remote deployments. KILD offered as reference implementation. Not yet merged.

---

## 3. Comparison for Windows + psmux Workflow

| Dimension | psmux (current) | initech | In-process Agent Teams | claude-squad | Subagents (current) |
|-----------|----------------|---------|----------------------|--------------|-------------------|
| tmux dependency | Replaces | None | None | Required | None |
| Windows native | Yes | Unknown | Yes | No | Yes |
| Scripting API | Full tmux command set | IPC sockets | Claude Code CLI | TUI only | Claude Code Agent tool |
| Session persistence | Yes (detach/reattach) | Yes | No (in-process) | Yes (tmux) | No (in-process) |
| Agent activity detection | No | Yes (active/idle/stalled) | No | No | No |
| Visual monitoring | Split panes | TUI dashboard | None (logs only) | TUI dashboard | None |
| Delivery guarantee | send-keys (no guarantee) | IPC (guaranteed) | In-process (guaranteed) | send-keys | In-process (guaranteed) |
| Overhead | Low (single Rust binary) | Medium (Node.js) | Zero | Medium (Go + tmux) | Zero |
| Maturity | Production | Production | Experimental | Production | Stable |

---

## 4. Recommendations

### For the current project (Windows 11, task DAG workflow):

1. **Keep psmux + subagents** — already the right architecture. Subagents handle all dispatch; psmux provides visual monitoring when desired.

2. **Investigate initech** if you want better activity awareness and reliable delivery. Needs Windows compatibility verification first.

3. **Try in-process Agent Teams** (`--teammate-mode in-process`) for peer-to-peer agent communication without any terminal multiplexer. Currently experimental.

4. **Monitor issue #34150** — when merged, psmux will unlock split-pane agent teams on Windows natively.

5. **Don't adopt Terminus** — none of the 4 projects by that name solve this problem.

### Key insight from research:

> "The bottleneck isn't the tooling, it's the task decomposition." — sdd.sh

The current project's task DAG approach (dispatcher → specialist agents) is already more sophisticated than most tools in the ecosystem. The orchestration layer (TaskCreate/TaskUpdate/Agent tool) handles the hard part. The terminal multiplexer is just a viewport.

---

## Bidirectional Search

- **Searched FOR:** "Terminus claude code", "terminus AI terminal multiplexer", "tabby terminus AI integration", "terminus KIRA claude code", "claude code multiple sessions orchestration", "tmux alternative AI agent", "parallel claude code sessions", "initech claude agent", "dmux amux claude-squad review", "claude SDK programmatic multi-agent"
- **Searched AGAINST:** "terminus limitations bugs", "tabby terminus problems", "terminus not suitable tmux replacement", "tmux still best option claude code agents no alternative", "initech limitations bugs issues", "claude code agent teams broken Windows"
- **Contradicting evidence found:** Yes —
  - tmux send-keys has no delivery guarantee (initech built a replacement specifically for this)
  - tmux split-pane is completely broken for Claude Code on Windows (isTTY gate bug #26244)
  - In-process mode makes tmux functionally unnecessary for orchestration (visual only)
  - Ecosystem is extremely fragmented — 70+ tools in awesome-agent-orchestrators, most <6 months old, low signal/noise

---

## Sources

1. https://github.com/Eugeny/tabby — Tabby (formerly Terminus)
2. https://github.com/krafton-ai/KIRA — Terminus-KIRA
3. https://github.com/laude-institute/terminal-bench — Terminus-2 / Harbor
4. https://github.com/psmux/psmux — psmux
5. https://github.com/nmelo/initech — initech
6. https://github.com/smtg-ai/claude-squad — Claude Squad
7. https://github.com/standardagents/dmux — dmux
8. https://github.com/mixpeek/amux — amux
9. https://github.com/dlorenc/multiclaude — Multiclaude
10. https://github.com/steveyegge/gastown — Gastown
11. https://github.com/SethGammon/Citadel — Citadel
12. https://github.com/Dicklesworthstone/claude_code_agent_farm — Agent Farm
13. https://github.com/johannesjo/parallel-code — parallel-code
14. https://github.com/stravu/crystal — Crystal/Nimbalyst
15. https://github.com/nwiizo/ccswarm — ccswarm
16. https://github.com/raine/workmux — workmux
17. https://github.com/andyrewlee/awesome-agent-orchestrators — awesome-agent-orchestrators
18. https://code.claude.com/docs/en/agent-teams — Agent Teams docs
19. https://code.claude.com/docs/en/sub-agents — Subagents docs
20. https://github.com/anthropics/claude-code/issues/34150 — psmux Windows support
21. https://github.com/anthropics/claude-code/issues/26572 — CustomPaneBackend proposal
22. https://github.com/anthropics/claude-code/issues/31901 — Zellij support request
23. https://github.com/anthropics/claude-code/issues/26244 — Windows isTTY gate bug
24. https://sdd.sh/2026/03/parallel-ai-agents-the-tools-that-let-you-run-ten-claudes-at-once/ — Parallel AI Agents overview
