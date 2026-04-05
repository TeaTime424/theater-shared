# Terminus as Alternative to tmux/psmux for Claude Code Session Management

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-28
**Related:** N/A

---

## Executive Summary

"Terminus" does not refer to a single tool in the Claude Code ecosystem — it is the name of at least four distinct projects. The most relevant candidates for replacing tmux+psmux are: (1) **Tabby** (formerly named "Terminus"), a cross-platform Electron terminal emulator with ~70K GitHub stars; and (2) **Terminus-2 / Terminus-KIRA**, a research-grade LLM agent harness built on top of tmux for terminal benchmark evaluation, not session orchestration. Neither directly replaces tmux+psmux for dispatching parallel Claude Code CLI sessions. For Windows-native session management, **psmux** itself (941 stars, MIT, v3.3.1) is the closest production-ready tmux replacement and already supports Claude Code agent teams natively.

---

## Key Findings

### 1. What "Terminus" Actually Refers To

There are four distinct projects using the "Terminus" name:

**A. Tabby (formerly Terminus) — Eugeny/tabby**
- Cross-platform Electron terminal emulator for Windows, macOS, Linux
- ~70,000 GitHub stars, actively maintained
- Features: tabs, split panes, SSH client, serial console, SFTP, plugin system
- AI integration: MCP server plugin exists but is third-party; no native Claude Code orchestration
- This is a terminal *emulator*, not an orchestrator. It runs shells — it doesn't dispatch agents.
- Relevant URL: https://github.com/Eugeny/tabby

**B. Terminus-2 (Harbor / laude-institute) — terminal-bench agent harness**
- An LLM agent that interacts with a tmux-backed shell environment for running terminal benchmarks
- Part of the "Harbor" framework for agent evals; wraps tmux for session persistence
- Architecture: LLM reasoning loop → command parsing → tmux `send-keys` → read pane buffer → repeat
- Supports context summarization at token limits, asciinema recording
- Not a session manager. It IS an agent that uses a terminal, not a tool for managing agents.
- Stars: ~1,900 (terminal-bench repo)
- URL: https://github.com/laude-institute/terminal-bench

**C. Terminus-KIRA (Krafton / krafton-ai/KIRA)**
- A harness built on top of Terminus-2 for Terminal-Bench; adds native tool calling, multimodal support, prompt caching
- 775 stars, Apache-2.0, last commit January 12, 2026
- Uses Anthropic API (Claude models) under the hood as the LLM backend
- Purpose: benchmark evaluation, not session multiplexing
- Not relevant to orchestrating parallel claude CLI sessions
- URL: https://github.com/krafton-ai/KIRA

**D. Pantheon Terminus (pantheon-systems/terminus)**
- CLI tool for Pantheon hosting platform management
- Completely unrelated to AI or terminal sessions
- URL: https://github.com/pantheon-systems/terminus

### 2. How These Projects Work

**Tabby/Terminus (terminal emulator):**
- Electron app. Opens terminals, supports tabs and split panes.
- Can run multiple `claude` CLI sessions in separate tabs/panes, but this requires manual user action — there is no programmatic dispatch API.
- No concept of "send a command to pane X" from an orchestrator script.
- SSH client means you can connect to a remote server running claude, but management is manual.
- Does not replace tmux functionality for scripted orchestration.

**Terminus-2 (agent harness):**
- Wraps tmux internally. Requires tmux to be installed.
- The "terminus" in `tb run --agent terminus` means "use this LLM agent to solve the benchmark task inside a terminal" — not "use Terminus to manage your terminals."
- Architecture is a Python agent class (Terminus2) + TmuxSession wrapper + LiteLLM backend.
- Fixed terminal size (default 160×40), token-limit summarization loses detail.
- Not designed for multi-session orchestration of external agents.

### 3. Claude Code Integration

None of the above Terminus variants have specific integration with Claude Code for parallel session dispatch. The Claude Code ecosystem's actual multi-session tools are:

| Tool | Approach | Platform | Stars | Claude Code Support |
|------|----------|----------|-------|---------------------|
| psmux | tmux-compatible, native Windows Rust | Windows | 941 | Native agent teams |
| claude-squad | tmux + git worktrees, Go | Linux/macOS | — | Yes |
| amux | tmux, Python, browser UI | Linux/macOS | — | Yes |
| cmux | Native macOS terminal, libghostty | macOS only | — | Yes |
| Tabby/Terminus | Electron terminal emulator | Cross-platform | 70K | Manual only |
| Terminus-2 | Benchmark agent harness, tmux-backed | Linux | ~1.9K | No (unrelated) |

**psmux is the directly relevant tool for the user's Windows setup.** It:
- Implements 76 tmux commands with flag-level compatibility
- Sets `TMUX`, `TMUX_PANE`, and `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` automatically
- Supports Claude Code's `TmuxBackend` without code changes (pending issue #34150)
- Available via winget, single binary, no WSL required
- v3.3.1 released March 26, 2026; 418 commits; MIT license

### 4. Comparison to tmux+psmux

| Dimension | tmux+psmux (current) | Tabby/Terminus | Terminus-2 |
|-----------|---------------------|----------------|------------|
| Purpose | Terminal multiplexer + Windows tmux compat | Terminal emulator | LLM benchmark harness |
| Claude Code dispatch | Programmatic via send-keys | Manual tab/pane | Not applicable |
| Windows support | Native (psmux is the Windows solution) | Yes (Electron) | Requires Linux/tmux |
| Scripting API | Full tmux command set | None for external scripts | Python API (internal) |
| Session persistence | Yes (detach/reattach) | No (app-bound) | Yes (tmux-backed) |
| Agent orchestration | Yes (with psmux+Claude Code #34150) | No | No (single agent only) |
| Overhead | Low (single binary) | High (Electron, ~100MB+) | Medium (Python + tmux) |
| Maturity | Production (v3.3.1) | Production (v1.x) | Research/beta |

### 5. Maturity Assessment

**Tabby (formerly Terminus):**
- ~70K stars, active maintenance, large community
- Production-grade as a terminal emulator
- Known issues: Electron resource overhead, some cryptography dependency CVEs (reported Sept 2025 HN discussion), keybinding conflicts
- No relevance to Claude Code session orchestration

**Terminus-2/KIRA:**
- Research-grade, ~775–1,900 stars depending on repo
- Actively maintained as of Jan 2026
- Designed for controlled benchmark evaluation, not production orchestration
- Incomplete rollout data if token-limit summarization triggers
- Not a session manager

**psmux:**
- 941 stars, MIT, 418 commits, v3.3.1 (March 26, 2026)
- Stress-tested to 15+ windows, 18+ panes, 5 concurrent sessions
- <100ms session creation, <80ms pane splits
- Issue #34150 (filed March 2026) tracks official Claude Code recognition — currently open/stale

---

## Comparison Table (Summary)

| Project | Is it a tmux replacement? | Claude Code orchestration? | Windows? | Verdict |
|---------|--------------------------|---------------------------|----------|---------|
| Tabby (formerly Terminus) | No — terminal emulator only | Manual only | Yes | Not relevant |
| Terminus-2 / Harbor | No — wraps tmux internally | No — benchmark tool | Linux only | Not relevant |
| Terminus-KIRA | No — extends Terminus-2 | No — benchmark eval | Linux only | Not relevant |
| psmux | Yes — tmux-compatible | Yes (native, pending #34150) | Windows native | Relevant |

---

## Follow-up Tasks Created

None. This research is conclusive: no project called "Terminus" is a viable replacement for tmux+psmux in the context of dispatching parallel Claude Code CLI sessions. psmux is already the correct Windows-native tool.

---

## Bidirectional Search

- **Searched FOR:** "Terminus claude code", "terminus terminal multiplexer AI agent", "terminus AI terminal GitHub 2025 2026", "tabby terminus AI integration", "terminus KIRA claude code integration", "Termius SSH claude code parallel sessions"
- **Searched AGAINST:** "terminus limitations bugs", "tabby terminus problems 2025 2026", "terminus not suitable tmux replacement", "Termius SSH Claude Code limitations problems"
- **Contradicting evidence found:** No — no evidence found of a "Terminus" product that functions as a tmux/psmux alternative for Claude Code session orchestration. The name resolves to four unrelated projects. Tabby (the most mature "Terminus"-named tool) explicitly lacks programmatic session dispatch. Terminus-2 requires tmux internally, making it a consumer of tmux rather than a replacement.

---

## Recommendations

**Terminus is not a viable alternative to tmux+psmux for orchestrating parallel Claude Code sessions on Windows.** Confidence: High.

The name "Terminus" does not map to any single coherent tool in the Claude Code tooling ecosystem. The most mature project with that name is Tabby (an Electron terminal emulator — useful for human-driven multi-tab sessions, not agent dispatch). The research-grade agent harnesses (Terminus-2, KIRA) use tmux internally and are for benchmark evaluation, not production session management.

For the user's actual use case (dispatching multiple Claude Code CLI sessions programmatically on Windows):

1. **psmux** is the correct tool — it is already in use and is the most relevant Windows-native tmux replacement. Monitor issue #34150 for official Claude Code recognition.
2. **claude-squad** or **amux** are worth investigating if Linux/macOS workflows are relevant.
3. **Tabby** could replace Windows Terminal as the human-facing terminal app, but adds nothing to psmux-based orchestration.

---

## Sources

1. [GitHub - Eugeny/tabby: A terminal for a more modern age](https://github.com/Eugeny/tabby)
2. [GitHub - krafton-ai/KIRA](https://github.com/krafton-ai/KIRA)
3. [GitHub - laude-institute/terminal-bench](https://github.com/laude-institute/terminal-bench)
4. [Terminus-2 Agent — DeepWiki](https://deepwiki.com/laude-institute/harbor/5.3-terminus-2-agent)
5. [GitHub - psmux/psmux](https://github.com/psmux/psmux)
6. [Claude Code issue #34150 — Support tmux agent teams on Windows via psmux](https://github.com/anthropics/claude-code/issues/34150)
7. [Terminus KIRA: Krafton's Open-Source AI Agent](https://pawanpatra.com/inside-terminus-kira-kraftons-new-open-source-ai-agent-for-game-development-workflows/)
8. [How We Reached 74.8% on terminal-bench with Terminus-KIRA — Krafton AI Blog](https://krafton-ai.github.io/blog/terminus_kira_en/)
9. [Termius + tmux + Claude Code workflow — X/Threads post](https://x.com/DeeperThrill/post/2011294669712331082)
10. [Run Claude Code From Your iPhone With Tailscale, Termius, and tmux — Medium](https://petesena.medium.com/how-to-run-claude-code-from-your-iphone-using-tailscale-termius-and-tmux-2e16d0e5f68b)
11. [Claude Code issue #31901 — Zellij support as alternative to tmux](https://github.com/anthropics/claude-code/issues/31901)
12. [Tabby — Hacker News discussion](https://news.ycombinator.com/item?id=45272692)
13. [GitHub - smtg-ai/claude-squad](https://github.com/smtg-ai/claude-squad)
14. [GitHub - mixpeek/amux](https://github.com/mixpeek/amux)
