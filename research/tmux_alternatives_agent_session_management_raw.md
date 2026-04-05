# tmux Alternatives for AI Agent Session Management — Raw Research Notes

**Status:** RESEARCH — Raw findings (Task 8)
**Date:** 2026-03-28
**Task:** 8 — Research alternatives to tmux for AI agent session management

---

## Executive Summary

The ecosystem around multi-Claude-Code session management exploded in late 2025/early 2026. tmux remains the only officially supported terminal multiplexer for Claude Code Agent Teams split-pane mode, but an enormous third-party tooling layer has emerged. The critical constraint on Windows is that native tmux doesn't exist; psmux (a Rust-native tmux-protocol implementation for Windows ConPTY) is the most promising path to closing that gap. For Linux/macOS, the real question is whether higher-level tools (dmux, Claude Squad, initech, amux) add enough value over raw tmux to be worth adopting.

---

## Category 1: Claude Code Native Features

### Claude Code Agent Teams (Built-in)
- **URL:** https://code.claude.com/docs/en/agent-teams
- **Status:** Experimental (CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1), v2.1.32+
- **Description:** Coordinate multiple Claude Code instances from a single session. One lead + N teammates. Shared task list, peer-to-peer messaging, tmux split panes OR in-process mode.
- **Relationship to tmux:** Split-pane mode requires tmux (or iTerm2 on macOS). In-process mode works in ANY terminal, no tmux needed. Default = auto (uses tmux if already in a tmux session).
- **Windows status:** BROKEN for split-pane. `process.stdout.isTTY` is undefined in Bun SFE binary on Windows, forcing in-process mode even if tmux/psmux available. Feature request #34150 tracks this.
- **Limitations:** Experimental. No session resumption with in-process teammates. Task status can lag. No nested teams. Token costs scale linearly with teammates.
- **Key insight:** In-process mode is a legitimate tmux-free option for running agent teams. Split panes are visual convenience, not functional requirement.

### Claude Code Subagents (Built-in)
- **URL:** https://code.claude.com/docs/en/sub-agents
- **Description:** Lightweight workers spawned within a single session. No tmux required at all. Report results back to the main agent only (no peer communication).
- **Relationship to tmux:** None — fully in-process.
- **Windows status:** Works natively.
- **Key insight:** For the task DAG workflow used in this project (dispatcher spawning specialist workers), subagents may be sufficient without any external session management.

---

## Category 2: Terminal Multiplexers

### tmux (incumbent)
- **URL:** https://github.com/tmux/tmux
- **Description:** Standard Unix terminal multiplexer. Only officially supported backend for Claude Code Agent Teams split-pane mode on Linux/macOS.
- **Windows status:** Not natively available. Requires WSL or Cygwin. Claude Code on Windows can't use tmux.
- **AI-specific features:** None native. Claude Code uses it as a dumb pane manager.
- **Maturity:** Extremely mature, decades of development.

### psmux (Windows tmux replacement)
- **URL:** https://github.com/anthropics/claude-code/issues/34150 (primary reference); not yet findable as standalone repo
- **Description:** Native Windows terminal multiplexer written in Rust. 25,600 lines. Implements 76 tmux commands with flag-level compatibility. Built on Windows ConPTY (not a wrapper). Zero WSL/Cygwin dependency. Available via winget, scoop, chocolatey, cargo.
- **Relationship to tmux:** Drop-in replacement. Reads .tmux.conf. Sets TMUX env var. Sets TMUX_PANE env var. Passes Claude Code's version check.
- **Windows AI status:** Would unlock Claude Code Agent Teams split-pane mode on Windows IF Anthropic merges 2-3 small bug fixes (#34150). Maintainer actively collaborating.
- **Performance:** <100ms session creation, <80ms pane splits. Tested with 15+ windows, 18+ panes.
- **Maturity:** Production-ready feature set, but Claude Code integration blocked on upstream fixes.
- **NOTE for this project:** User already has a custom psmux script. This is likely the same tool or closely related. HIGH RELEVANCE.

### Zellij
- **URL:** https://zellij.dev
- **Description:** Modern terminal multiplexer written in Rust. Plugin ecosystem, more user-friendly than tmux.
- **AI-specific features:** Feature request for Claude Code native support open (#31901). Not yet supported.
- **Windows status:** Better cross-platform story than tmux, but not yet a Claude Code backend.
- **Maturity:** Active project, growing community.

### WezTerm
- **URL:** https://wezfurlong.org/wezterm/
- **Description:** GPU-accelerated terminal emulator with built-in multiplexing. Lua-scriptable.
- **AI-specific features:** Mentioned in workmux as supported multiplexer alternative. Mentioned in Claude Code proposal #26572 for CustomPaneBackend protocol.
- **Windows status:** Native Windows support.
- **Maturity:** Active.

### Kitty
- **URL:** https://sw.kovidgoyal.net/kitty/
- **Description:** Terminal emulator with kitty graphics protocol, multiplexing via kitty sessions.
- **AI-specific features:** Mentioned in workmux as supported multiplexer.
- **Windows status:** Limited Windows support.

---

## Category 3: Purpose-Built AI Agent Session Managers

### Claude Squad
- **URL:** https://github.com/smtg-ai/claude-squad
- **Description:** TUI that manages multiple AI coding agents (Claude Code, Codex, Gemini, Aider) in separate workspaces. Each agent gets its own tmux session + git worktree.
- **Relationship to tmux:** Built ON TOP of tmux — uses tmux as the underlying pane manager.
- **Features:** Background task running, auto-accept mode, review changes before applying, isolated git workspaces.
- **Multi-agent support:** Yes — unified dashboard over multiple agents in separate tmux sessions.
- **Maturity:** 6.8k stars, 210 commits, v1.0.17 (March 12, 2026), Go-based, AGPL-3.0, available via Homebrew.
- **Windows status:** Requires tmux = not natively Windows-friendly.

### initech
- **URL:** https://github.com/nmelo/initech
- **Description:** Terminal-based runtime orchestrating teams of AI coding agents. Purpose-built to address tmux limitations: no delivery guarantee on send-keys, no agent activity awareness.
- **Relationship to tmux:** Replaces tmux internals with PTY emulation + IPC sockets. NOT built on tmux.
- **Key differentiator:** Reliable message delivery (IPC vs tmux send-keys), activity state detection (active/idle/stalled), Claude session log parsing for bead events.
- **Cross-machine support:** Yes.
- **Role templates:** 13 roles (engineer, PM, architect, etc.)
- **Maturity:** 464 commits, 161 releases, v0.26.5 (April 2026 — at time of research), 71.5% test coverage, Homebrew distribution. Production-ready.
- **Windows status:** Unknown — needs verification.

### dmux
- **URL:** https://github.com/standardagents/dmux
- **Description:** Dev agent multiplexer — manages multiple AI coding agents in isolated git worktrees. Each pane = worktree + branch + agent.
- **Relationship to tmux:** Built ON TOP of tmux (requires tmux 3.0+). Automates worktree creation + branch management + agent launching.
- **Features:** Press 'n' to provision worktree/branch/agent, press 'm' to merge branches. Lifecycle hooks, macOS notifications. Supports Claude Code, Cline, Cursor, Copilot CLI.
- **Maturity:** 1.3k stars, 644 commits, v5.6.3 (March 21, 2026), MIT license, dmux.ai docs. Active.
- **Windows status:** Requires tmux = not natively Windows-friendly.

### amux
- **URL:** https://github.com/mixpeek/amux
- **Description:** Open-source Claude Code agent multiplexer. Run dozens of parallel AI agents unattended. Browser/phone management via PWA. Self-healing watchdog, kanban board, agent-to-agent REST API.
- **Relationship to tmux:** Built ON TOP of tmux. Parses terminal output to monitor status.
- **Architecture:** Python + tmux, ~23,000 lines Python with inline HTML/CSS/JS.
- **Features:** Overnight unattended sessions, auto-restart on crash, mobile PWA.
- **Maturity:** 813 commits, 107 stars. MIT + Commons Clause.
- **Windows status:** Python-based but requires tmux.

### agent-deck
- **URL:** https://github.com/asheshgoplani/agent-deck
- **Description:** Terminal session manager for AI coding agents. One TUI for Claude, Gemini, OpenCode, Codex, and more.
- **Relationship to tmux:** Unknown — needs investigation.
- **Maturity:** Listed in awesome-agent-orchestrators. Activity level unclear.

### KILD
- **URL:** Referenced in Claude Code issue #26572
- **Description:** Tool for running parallel AI agents in isolated git worktrees. Ships kild-tmux-shim — a drop-in tmux replacement that routes Claude Code's tmux calls to a native PTY daemon via IPC. File-based locking for pane registry.
- **Relationship to tmux:** Replaces tmux with a shim. Claude Code thinks it's talking to tmux; actually talking to KILD daemon.
- **Maturity:** Referenced as reference implementation for proposed CustomPaneBackend protocol. Production status unclear.
- **Windows status:** Unknown.

---

## Category 4: Orchestration Frameworks (SDK-level, not terminal-multiplexer-level)

### Gastown
- **URL:** https://github.com/steveyegge/gastown
- **Description:** Multi-agent orchestration system with persistent work tracking. Runs multiple Claude Code agents on shared codebase. Uses Go + tmux + git worktrees.
- **Relationship to tmux:** Uses tmux. Not a tmux replacement.
- **Comparison to Multiclaude:** Better for running more agents in parallel, better for solo devs on hobby projects.
- **Maturity:** Active, in awesome-agent-orchestrators list.

### Multiclaude
- **URL:** https://github.com/dlorenc/multiclaude
- **Description:** Multi-agent orchestrator. Spawns autonomous Claude Code instances per tmux window + git worktree. Singleplayer (auto-merge) or multiplayer (team review) modes.
- **Relationship to tmux:** Uses tmux. Not a replacement.
- **Maturity:** Active on GitHub.

### claude-flow / ruflo
- **URL:** https://github.com/ruvnet/claude-flow, https://github.com/ruvnet/ruflo
- **Description:** Deploy multi-agent swarms with coordinated workflows. Enterprise-grade architecture, distributed swarm intelligence, RAG integration, Claude Code integration.
- **Relationship to tmux:** Framework-level, above tmux.

### ccswarm
- **URL:** https://github.com/nwiizo/ccswarm
- **Description:** Multi-agent orchestration using Claude Code with git worktree isolation. Task delegation infrastructure, template-based scaffolding.
- **Relationship to tmux:** Git worktree + Claude Code CLI. Uses tmux.

### Citadel
- **URL:** https://github.com/SethGammon/Citadel
- **Description:** Agent orchestration harness for Claude Code. Four-tier routing (/do), campaign persistence across sessions, parallel agents in isolated worktrees, discovery relay, lifecycle hooks, circuit breaker, 6 skills.
- **Relationship to tmux:** Uses tmux for pane management.
- **Maturity:** Active development.

### Claude Code Agent Farm
- **URL:** https://github.com/Dicklesworthstone/claude_code_agent_farm
- **Description:** Framework for running 20+ Claude Code agents in parallel. Automated bug fixing, best-practices sweeps, lock-based coordination, real-time tmux monitoring.
- **Relationship to tmux:** Uses tmux for monitoring. Heavily tmux-dependent.

### parallel-code
- **URL:** https://github.com/johannesjo/parallel-code
- **Description:** Desktop app. Run Claude Code, Codex, Gemini side by side in own git worktrees. Built-in diff viewer + merge functionality.
- **Relationship to tmux:** Desktop app — abstracts away from tmux.
- **Maturity:** Active.

### crystal/Nimbalyst
- **URL:** https://github.com/stravu/crystal
- **Description:** Run multiple Codex and Claude Code sessions in parallel git worktrees. Desktop app (Electron-based). Kanban-style board with mobile monitoring. NOTE: Crystal deprecated, replaced by Nimbalyst.
- **Relationship to tmux:** Desktop GUI abstraction — not tmux-dependent.

### workmux
- **URL:** https://github.com/raine/workmux
- **Description:** Git worktrees + tmux windows for zero-friction parallel dev.
- **Relationship to tmux:** Requires a multiplexer (tmux, WezTerm, Kitty, or Zellij).

---

## Category 5: Proposed Protocol Changes

### CustomPaneBackend Protocol (Claude Code Issue #26572)
- **URL:** https://github.com/anthropics/claude-code/issues/26572
- **Description:** Proposal to decouple Claude Code agent teams from the tmux CLI. Would allow Ghostty, WezTerm, Zellij, KILD, and remote deployments to serve as pane backends. KILD offered as reference implementation.
- **Status:** Open proposal. Not yet implemented.
- **Impact:** If merged, would make tmux optional entirely for split-pane agent teams.

---

## Bidirectional Search

### Searched FOR (supporting alternatives):
- "claude code multiple sessions orchestration AI agent 2026"
- "tmux alternative AI agent terminal multiplexer zellij wezterm kitty 2025 2026"
- "parallel claude code sessions worktree orchestration tool github"
- "KILD agent terminal multiplexer PTY daemon parallel agents github"
- "multiclaude gasstown claude code multi-session tool 2026"
- "claude-squad smtg-ai agent-deck dmux amux initech review 2026"
- "claude SDK programmatic multi-agent orchestration replace tmux session management 2026"
- GitHub: anthropics/claude-code issues #34150, #26572, #31901, #24384, #26244

### Searched AGAINST (evidence that tmux is irreplaceable):
- "tmux still best option claude code agents 'no alternative' limitations 2026"
- "claude code agent teams windows tmux WSL support limitations 2026"
- Official Claude Code docs on agent-teams limitations section
- GitHub issues for Windows tmux failures

### Contradicting Evidence Found:
YES — significant.

1. **tmux is NOT functionally required.** Claude Code Agent Teams' in-process mode works in any terminal with zero tmux dependency. Split-pane is a visual nicety, not a functional requirement. The project's task DAG workflow already uses Claude Code subagents (in-process) — tmux is only needed for visual monitoring, not orchestration.

2. **tmux is broken on Windows for Claude Code.** The isTTY gate forces in-process mode on Windows regardless of settings. All tmux-dependent third-party tools (claude-squad, dmux, amux, gastown, multiclaude, agent farm) inherit this limitation.

3. **initech explicitly calls out tmux's failure modes.** send-keys has no delivery guarantee. A hung agent and productive one look identical in tmux. This is not a niche complaint — initech built a production replacement specifically because of these issues.

4. **The ecosystem is fragmented and largely pre-stable.** Most tools in the awesome-agent-orchestrators list are <6 months old, <200 stars, experimental quality. The signal/noise ratio is low.

---

## Key Metrics Table

| Tool | Approach | tmux dependency | Windows? | Stars/Maturity | Last update |
|------|----------|----------------|----------|----------------|-------------|
| Claude Code Agent Teams (in-process) | Built-in | None | Yes | Official/Stable | March 2026 |
| Claude Code Agent Teams (split-pane) | Built-in | Required | No (broken) | Official/Stable | March 2026 |
| psmux | tmux-protocol Windows native | Replaces | Yes (native) | Unknown stars, production-quality | Active 2026 |
| initech | PTY daemon (no tmux) | None | Unknown | 464 commits, 161 releases | April 2026 |
| claude-squad | TUI over tmux | Required | No | 6.8k stars, v1.0.17 | March 2026 |
| dmux | TUI over tmux | Required | No | 1.3k stars, v5.6.3 | March 2026 |
| amux | Python+tmux, web dashboard | Required | No | 813 commits | Active 2026 |
| KILD | tmux shim → PTY daemon | Replaces | Unknown | Prototype/proposal | 2026 |
| Gastown | orchestrator using tmux | Required | No | Active | 2026 |
| Multiclaude | orchestrator using tmux | Required | No | Active | 2026 |
| Citadel | orchestration harness | Required | No | Active | 2026 |
| Zellij | multiplexer (tmux alternative) | N/A | Better | Active | 2026 |
| WezTerm | terminal with multiplexing | N/A | Yes | Active | 2026 |

---

## Findings Relevant to This Project (Windows 11, psmux workflow)

1. **User already has psmux.** The git status shows `psmux` referenced in claude-code issue #34150 as a native Windows tmux replacement. If this is the user's existing tool, it is exactly what Anthropic would need to integrate to unlock split-pane agent teams on Windows.

2. **In-process mode is already working.** The task DAG workflow spawns agents via Claude Code's Agent tool (subagents / in-process agent teams). No tmux split panes are needed for this to function — panes are visual-only.

3. **dmux and claude-squad require tmux.** Not viable on Windows without WSL.

4. **initech is the most technically interesting alternative** — native PTY daemon, no tmux, cross-machine, activity awareness, production maturity. Needs Windows compatibility verification.

5. **The bottleneck is task decomposition, not session management.** Per the sdd.sh article: "the bottleneck isn't the tooling, it's the task decomposition." The current project already has sophisticated task DAG orchestration.

---

## Sources

1. https://code.claude.com/docs/en/agent-teams — Official Claude Code Agent Teams docs
2. https://github.com/anthropics/claude-code/issues/34150 — psmux Windows support issue
3. https://github.com/anthropics/claude-code/issues/26572 — CustomPaneBackend protocol proposal
4. https://github.com/anthropics/claude-code/issues/31901 — Zellij support request
5. https://github.com/anthropics/claude-code/issues/24384 — Windows Terminal support request
6. https://github.com/anthropics/claude-code/issues/26244 — Windows isTTY gate bug
7. https://github.com/smtg-ai/claude-squad — Claude Squad
8. https://github.com/nmelo/initech — initech
9. https://github.com/standardagents/dmux — dmux
10. https://github.com/mixpeek/amux — amux
11. https://github.com/andyrewlee/awesome-agent-orchestrators — awesome-agent-orchestrators list
12. https://github.com/dlorenc/multiclaude — Multiclaude
13. https://github.com/steveyegge/gastown — Gastown
14. https://github.com/stravu/crystal — Crystal/Nimbalyst
15. https://github.com/johannesjo/parallel-code — parallel-code
16. https://github.com/nwiizo/ccswarm — ccswarm
17. https://github.com/SethGammon/Citadel — Citadel
18. https://github.com/Dicklesworthstone/claude_code_agent_farm — Claude Code Agent Farm
19. https://sdd.sh/2026/03/parallel-ai-agents-the-tools-that-let-you-run-ten-claudes-at-once/ — Parallel AI Agents overview
20. https://shipyard.build/blog/claude-code-multi-agent/ — Shipyard multi-agent overview
21. https://github.com/raine/workmux — workmux
