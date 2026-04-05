# Claude Code — Comprehensive Documentation Reference

**Status:** RESEARCH — Reference only
**Date:** 2026-03-28
**Canonical Docs:** https://code.claude.com/docs/en/ (docs.anthropic.com redirects here via 301)
**Agent SDK Docs:** https://platform.claude.com/docs/en/agent-sdk/
**Settings JSON Schema:** https://json.schemastore.org/claude-code-settings.json

---

## Table of Contents

1. [Overview & Getting Started](#1-overview--getting-started)
2. [Installation & Setup](#2-installation--setup)
3. [Authentication](#3-authentication)
4. [CLI Reference](#4-cli-reference)
5. [Configuration & Settings](#5-configuration--settings)
6. [CLAUDE.md — Project Instructions](#6-claudemd--project-instructions)
7. [Auto Memory System](#7-auto-memory-system)
8. [Permissions & Security](#8-permissions--security)
9. [Permission Modes](#9-permission-modes)
10. [Hooks System](#10-hooks-system)
11. [MCP Servers](#11-mcp-servers)
12. [Custom Commands & Skills](#12-custom-commands--skills)
13. [Built-in Slash Commands](#13-built-in-slash-commands)
14. [IDE Integrations — VS Code](#14-ide-integrations--vs-code)
15. [IDE Integrations — JetBrains](#15-ide-integrations--jetbrains)
16. [Subagents & Multi-Agent Patterns](#16-subagents--multi-agent-patterns)
17. [Claude Agent SDK (Python & TypeScript)](#17-claude-agent-sdk-python--typescript)
18. [GitHub Integration & CI/CD](#18-github-integration--cicd)
19. [Headless / Non-Interactive Mode](#19-headless--non-interactive-mode)
20. [Extended Thinking & Model Selection](#20-extended-thinking--model-selection)
21. [Telemetry & Analytics](#21-telemetry--analytics)
22. [Cost Management](#22-cost-management)
23. [Context Window Management](#23-context-window-management)
24. [Keyboard Shortcuts](#24-keyboard-shortcuts)
25. [Teams & Enterprise Features](#25-teams--enterprise-features)
26. [Sandboxing](#26-sandboxing)
27. [Troubleshooting](#27-troubleshooting)
28. [Documentation Index](#28-documentation-index)

---

## 1. Overview & Getting Started

**Source:** https://code.claude.com/docs/en/overview, https://code.claude.com/docs/en/quickstart

Claude Code is an AI-powered coding assistant available in Terminal (CLI), VS Code, JetBrains, Desktop app (macOS/Windows), Web (browser), GitHub Actions, GitLab CI/CD, and Slack.

Key capabilities:
- Reads codebase, edits files, runs commands, integrates with dev tools
- Sub-agents: spawn multiple Claude Code agents working simultaneously
- MCP (Model Context Protocol) for external tool connections
- CLAUDE.md for persistent project instructions
- Auto memory: Claude writes notes across sessions
- Hooks: shell commands before/after Claude Code actions
- Scheduled tasks (cloud or desktop)
- Remote Control, Channels, Slack, GitHub Actions, GitLab CI/CD integrations

### Quick Start

```bash
# Install
curl -fsSL https://claude.ai/install.sh | bash   # macOS/Linux/WSL
irm https://claude.ai/install.ps1 | iex           # Windows PowerShell

# Start
cd your-project && claude

# Essential commands
claude                    # Start interactive mode
claude "task"             # Run a one-time task
claude -p "query"         # Run one-off query, then exit
claude -c                 # Continue most recent conversation
claude -r                 # Resume a previous conversation
```

---

## 2. Installation & Setup

**Source:** https://code.claude.com/docs/en/setup

### System Requirements
- OS: macOS 13.0+, Windows 10 1809+ / Server 2019+, Ubuntu 20.04+, Debian 10+, Alpine 3.19+
- Hardware: 4 GB+ RAM
- Network: internet required
- Shell: Bash, Zsh, PowerShell, or CMD
- Windows: Git for Windows required

### Install Methods

| Method | Command |
|--------|---------|
| macOS/Linux/WSL | `curl -fsSL https://claude.ai/install.sh \| bash` |
| Windows PowerShell | `irm https://claude.ai/install.ps1 \| iex` |
| Windows CMD | `curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd` |
| Homebrew | `brew install --cask claude-code` |
| WinGet | `winget install Anthropic.ClaudeCode` |
| Specific version | `curl -fsSL https://claude.ai/install.sh \| bash -s 1.0.58` |

### Windows Setup

Option 1: Native Windows with Git Bash — install Git for Windows, then use PowerShell/CMD install.
If Claude can't find Git Bash, set in settings.json:
```json
{ "env": { "CLAUDE_CODE_GIT_BASH_PATH": "C:\\Program Files\\Git\\bin\\bash.exe" } }
```
Option 2: WSL (1 or 2). WSL2 supports sandboxing; WSL1 does not.

### Auto-Updates

Native installs auto-update in background. Homebrew/WinGet require manual: `brew upgrade claude-code` or `winget upgrade Anthropic.ClaudeCode`.

Release channels (in settings.json):
- `"latest"` (default) — newest release
- `"stable"` — ~1 week old, skips major regressions

Disable auto-updates: `{ "env": { "DISABLE_AUTOUPDATER": "1" } }`
Manual update: `claude update`

### Verify / Uninstall

```bash
claude --version
claude doctor

# Uninstall (native)
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
rm -rf ~/.claude
rm ~/.claude.json
```

---

## 3. Authentication

**Source:** https://code.claude.com/docs/en/authentication

### Account Types
- Claude Pro or Max subscription
- Claude for Teams or Enterprise
- Claude Console (API-based)
- Cloud providers: Amazon Bedrock, Google Vertex AI, Microsoft Foundry

Free plan does NOT include Claude Code.

### Authentication Precedence (highest to lowest)
1. Cloud provider env vars (`CLAUDE_CODE_USE_BEDROCK`, `CLAUDE_CODE_USE_VERTEX`, `CLAUDE_CODE_USE_FOUNDRY`)
2. `ANTHROPIC_AUTH_TOKEN` — sent as `Authorization: Bearer` header (for LLM gateways)
3. `ANTHROPIC_API_KEY` — sent as `X-Api-Key` header (direct Anthropic API)
4. `apiKeyHelper` script output
5. Subscription OAuth credentials from `/login`

Note: `apiKeyHelper`, `ANTHROPIC_API_KEY`, and `ANTHROPIC_AUTH_TOKEN` apply to terminal CLI sessions only. Desktop and remote sessions use OAuth exclusively.

### Credential Storage
- macOS: encrypted macOS Keychain
- Linux/Windows: `~/.claude/.credentials.json` (Linux: mode 0600)

### apiKeyHelper
```json
{ "apiKeyHelper": "/bin/generate_temp_api_key.sh" }
```
Called after 5 minutes or on HTTP 401. Custom interval: `CLAUDE_CODE_API_KEY_HELPER_TTL_MS` env var.

---

## 4. CLI Reference

**Source:** https://code.claude.com/docs/en/cli-reference

### Commands

| Command | Description |
|---------|-------------|
| `claude` | Start interactive session |
| `claude "query"` | Start with initial prompt |
| `claude -p "query"` | Non-interactive, then exit |
| `cat file \| claude -p "query"` | Process piped content |
| `claude -c` | Continue most recent conversation |
| `claude -c -p "query"` | Continue via SDK |
| `claude -r "<session>" "query"` | Resume session by ID or name |
| `claude update` | Update to latest version |
| `claude auth login` | Sign in (flags: --email, --sso, --console) |
| `claude auth logout` | Log out |
| `claude auth status` | Show auth status as JSON (--text for human-readable) |
| `claude agents` | List configured subagents |
| `claude auto-mode defaults` | Print auto mode classifier rules as JSON |
| `claude mcp` | Configure MCP servers |
| `claude plugin` | Manage plugins |
| `claude remote-control` | Start Remote Control server |

### CLI Flags

| Flag | Description |
|------|-------------|
| `--add-dir` | Add additional working directories |
| `--agent` | Specify agent for current session |
| `--agents` | Define custom subagents dynamically via JSON |
| `--allowedTools` | Tools that execute without prompting |
| `--append-system-prompt` | Append text to default system prompt |
| `--append-system-prompt-file` | Append file to default system prompt |
| `--bare` | Minimal mode — skip hooks, skills, plugins, MCP, CLAUDE.md |
| `--chrome` | Enable Chrome browser integration |
| `--continue`, `-c` | Load most recent conversation |
| `--dangerously-skip-permissions` | Skip all permission prompts |
| `--debug` | Enable debug mode with optional category filtering |
| `--disable-slash-commands` | Disable all skills and commands |
| `--disallowedTools` | Tools removed from model context |
| `--effort` | Set effort level: low/medium/high/max (Opus 4.6 only for max) |
| `--fallback-model` | Fallback model when default overloaded (print mode) |
| `--fork-session` | Create new session ID when resuming |
| `--from-pr` | Resume sessions linked to a GitHub PR |
| `--ide` | Auto-connect to IDE on startup |
| `--init` | Run initialization hooks and start interactive mode |
| `--init-only` | Run initialization hooks and exit |
| `--input-format` | Input format for print mode (text, stream-json) |
| `--json-schema` | Get validated JSON output matching schema (print mode) |
| `--max-budget-usd` | Maximum spend on API calls (print mode) |
| `--max-turns` | Limit number of agentic turns (print mode) |
| `--mcp-config` | Load MCP servers from JSON files/strings |
| `--model` | Set model (alias: sonnet, opus, or full ID) |
| `--name`, `-n` | Set display name for session |
| `--no-session-persistence` | Don't save session to disk (print mode) |
| `--output-format` | Output format: text, json, stream-json |
| `--enable-auto-mode` | Unlock auto mode in Shift+Tab cycle |
| `--permission-mode` | Begin in specified permission mode |
| `--permission-prompt-tool` | MCP tool for permission prompts (non-interactive) |
| `--print`, `-p` | Print response without interactive mode |
| `--remote` | Create new web session on claude.ai |
| `--remote-control`, `--rc` | Start interactive session with Remote Control enabled |
| `--resume`, `-r` | Resume specific session by ID or name |
| `--session-id` | Use specific session ID (must be valid UUID) |
| `--setting-sources` | Comma-separated list of setting sources (user, project, local) |
| `--settings` | Path to settings JSON file or JSON string |
| `--strict-mcp-config` | Only use MCP servers from --mcp-config |
| `--system-prompt` | Replace entire system prompt |
| `--system-prompt-file` | Load system prompt from file |
| `--teleport` | Resume a web session in local terminal |
| `--teammate-mode` | Agent team display: auto, in-process, tmux |
| `--tools` | Restrict which built-in tools Claude can use |
| `--verbose` | Enable verbose logging |
| `--version`, `-v` | Output version number |
| `--worktree`, `-w` | Start in isolated git worktree |
| `--tmux` | Create tmux session for worktree (requires --worktree) |

### System Prompt Flags

`--system-prompt` and `--system-prompt-file` are mutually exclusive (replace entire prompt). `--append-system-prompt` and `--append-system-prompt-file` can combine with either.

---

## 5. Configuration & Settings

**Source:** https://code.claude.com/docs/en/settings

### Configuration Scopes

| Scope | Location | Who it affects | Shared? |
|-------|----------|----------------|---------|
| **Managed** | Server-managed, plist/registry, or `managed-settings.json` | All users on machine | Yes (IT) |
| **User** | `~/.claude/` directory | You, all projects | No |
| **Project** | `.claude/` in repository | All collaborators | Yes (git) |
| **Local** | `.claude/settings.local.json` | You, this repo only | No |

**Precedence (highest to lowest):**
1. Managed (cannot be overridden)
2. Command line arguments
3. Local (`.claude/settings.local.json`)
4. Project (`.claude/settings.json`)
5. User (`~/.claude/settings.json`)

Array settings merge across scopes (concatenate and deduplicate, not replace).

### Settings Files Locations

| Feature | User | Project | Local |
|---------|------|---------|-------|
| Settings | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` |
| Subagents | `~/.claude/agents/` | `.claude/agents/` | None |
| MCP servers | `~/.claude.json` | `.mcp.json` | `~/.claude.json` (per-project) |
| CLAUDE.md | `~/.claude/CLAUDE.md` | `CLAUDE.md` or `.claude/CLAUDE.md` | None |

Other config: `~/.claude.json` stores preferences, OAuth session, MCP configs, per-project state.

### Available Settings (settings.json)

| Key | Description | Example |
|-----|-------------|---------|
| `apiKeyHelper` | Script to generate auth value | `/bin/generate_temp_api_key.sh` |
| `autoMemoryEnabled` | Enable/disable auto memory | `false` |
| `autoMemoryDirectory` | Custom memory dir (not in project settings) | `"~/my-memory-dir"` |
| `cleanupPeriodDays` | Session cleanup period (0 = disable) | `20` |
| `companyAnnouncements` | Startup announcements | `["Welcome..."]` |
| `env` | Environment variables for every session | `{"FOO": "bar"}` |
| `attribution` | Git commit/PR attribution | `{"commit": "...", "pr": ""}` |
| `includeGitInstructions` | Include git instructions (default: true) | `false` |
| `permissions` | Allow/ask/deny rules | See permissions section |
| `autoMode` | Auto mode classifier config | `{"environment": [...]}` |
| `disableAutoMode` | Prevent auto mode | `"disable"` |
| `hooks` | Lifecycle hooks | See hooks section |
| `defaultShell` | Shell for `!` commands | `"powershell"` |
| `disableAllHooks` | Disable all hooks | `true` |
| `model` | Default model override | `"claude-sonnet-4-6"` |
| `availableModels` | Restrict model selection | `["sonnet", "haiku"]` |
| `modelOverrides` | Map model IDs to provider IDs | `{"claude-opus-4-6": "arn:..."}` |
| `effortLevel` | Persist effort level | `"medium"` |
| `statusLine` | Custom status line | `{"type": "command", ...}` |
| `alwaysThinkingEnabled` | Always-on extended thinking | `true` |
| `language` | Response language | `"japanese"` |
| `voiceEnabled` | Push-to-talk dictation | `true` |
| `autoUpdatesChannel` | Release channel | `"stable"` |
| `forceLoginMethod` | Restrict login method | `"claudeai"` |
| `enableAllProjectMcpServers` | Auto-approve all .mcp.json servers | `true` |
| `agent` | Run main thread as named subagent | `"code-reviewer"` |
| `outputStyle` | Output style adjustment | `"Explanatory"` |
| `sandbox.enabled` | Enable bash sandboxing | `true` |
| `worktree.symlinkDirectories` | Dirs to symlink in worktrees | `[...]` |
| `plansDirectory` | Custom plan storage | `"./plans"` |
| `fastModePerSessionOptIn` | Require per-session fast opt-in | `true` |

### Global Config (in ~/.claude.json, NOT settings.json)

| Key | Description |
|-----|-------------|
| `autoConnectIde` | Auto-connect to IDE on startup |
| `autoInstallIdeExtension` | Auto-install VS Code extension |
| `editorMode` | `"normal"` or `"vim"` |
| `showTurnDuration` | Show "Cooked for 1m 6s" |
| `terminalProgressBarEnabled` | Progress bar |
| `teammateMode` | `auto`, `in-process`, or `tmux` |

### Managed Settings Locations

- macOS: `/Library/Application Support/ClaudeCode/managed-settings.json`
- Linux/WSL: `/etc/claude-code/managed-settings.json`
- Windows: `C:\Program Files\ClaudeCode\managed-settings.json`
- macOS MDM: `com.anthropic.claudecode` managed preferences
- Windows registry: `HKLM\SOFTWARE\Policies\ClaudeCode`

Drop-in directory: `managed-settings.d/*.json` merged alphabetically.

---

## 6. CLAUDE.md — Project Instructions

**Source:** https://code.claude.com/docs/en/memory

### CLAUDE.md Locations

| Scope | Location | Purpose |
|-------|----------|---------|
| Managed policy | macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`; Linux/WSL: `/etc/claude-code/CLAUDE.md`; Windows: `C:\Program Files\ClaudeCode\CLAUDE.md` | Org-wide |
| Project | `./CLAUDE.md` or `./.claude/CLAUDE.md` | Team-shared |
| User | `~/.claude/CLAUDE.md` | Personal, all projects |

Files in ancestor directories load in full at launch. Subdirectory CLAUDE.md files load on demand when Claude reads files there. Delivered as user message, not system prompt.

### Writing Effective CLAUDE.md

- Target under 200 lines per file
- Use markdown headers and bullets
- Be specific ("Use 2-space indentation" not "Format code properly")
- Avoid conflicting instructions across files

### Import Syntax

```text
See @README for project overview and @package.json for npm commands.
@~/.claude/my-project-instructions.md
```
Recursive imports supported (max depth 5). Block-level HTML comments stripped.

### .claude/rules/ Directory

```
.claude/
├── CLAUDE.md
└── rules/
    ├── code-style.md
    ├── testing.md
    └── security.md
```

Path-specific rules (YAML frontmatter):
```markdown
---
paths:
  - "src/api/**/*.ts"
---
# API Development Rules
- All API endpoints must include input validation
```

Rules without `paths` load at launch unconditionally.

### AGENTS.md Compatibility

```markdown
@AGENTS.md

## Claude Code specific instructions
...
```

### Excluding CLAUDE.md Files

```json
{ "claudeMdExcludes": ["**/monorepo/CLAUDE.md", "/home/user/other-team/.claude/rules/**"] }
```

---

## 7. Auto Memory System

**Source:** https://code.claude.com/docs/en/memory

Requires Claude Code v2.1.59+.

| | CLAUDE.md files | Auto memory |
|--|-----------------|-------------|
| Who writes it | You | Claude |
| What it contains | Instructions and rules | Learnings and patterns |
| Loaded into | Every session | Every session (first 200 lines or 25KB) |
| Use for | Coding standards, workflows | Build commands, debugging insights |

### Storage

- Per-project: `~/.claude/projects/<project>/memory/`
- `MEMORY.md` — concise index, first 200 lines/25KB loaded at session start
- Topic files loaded on demand
- Custom directory: `autoMemoryDirectory` in user/local settings

### Enable/Disable

```json
{ "autoMemoryEnabled": false }
```
Or env var: `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`

`/memory` command — lists loaded files, toggles auto memory, links to memory folder.

---

## 8. Permissions & Security

**Source:** https://code.claude.com/docs/en/permissions, https://code.claude.com/docs/en/security

### Permission Tiers

| Tool type | Example | Approval required |
|-----------|---------|-------------------|
| Read-only | File reads, Grep | No |
| Bash commands | Shell execution | Yes |
| File modification | Edit/write files | Yes |

Rules evaluated in order: **deny -> ask -> allow**. First match wins.

### Permission Rule Syntax

Format: `Tool` or `Tool(specifier)`

| Rule | Effect |
|------|--------|
| `Bash` | All Bash commands |
| `Bash(npm run *)` | Commands starting with `npm run` |
| `Bash(npm run build)` | Exact command match |
| `Read(./.env)` | Reading .env file |
| `Read(~/.zshrc)` | Home directory path |
| `Read(/src/**/*.ts)` | Relative to project root |
| `WebFetch(domain:example.com)` | Fetch to example.com |
| `mcp__puppeteer__*` | All tools from puppeteer server |
| `Agent(Explore)` | Specific subagent |

Wildcard space matters: `Bash(ls *)` matches `ls -la` but not `lsof`.

Windows paths normalized to POSIX: `C:\Users\alice` → `/c/Users/alice`.

### Example settings.json

```json
{
  "permissions": {
    "allow": ["Bash(npm run lint)", "Bash(npm run test *)", "Read(~/.zshrc)"],
    "deny": ["Bash(curl *)", "Read(./.env)", "Read(./secrets/**)"]
  }
}
```

### Security Protections

- Sandboxed bash tool (enable with `/sandbox`)
- Write access restricted to working directory and subfolders
- Command blocklist: `curl`, `wget` blocked by default
- Isolated context windows for web fetch
- Command injection detection
- Secure credential storage

### MCP Security

MCP server list configured in source code. Anthropic does not manage or audit any MCP servers.

### Cloud Execution Security

Isolated VMs, network access controls, credential protection, branch restrictions, audit logging, automatic cleanup.

---

## 9. Permission Modes

**Source:** https://code.claude.com/docs/en/permission-modes

### Available Modes

| Mode | What Claude can do without asking | Best for |
|------|-----------------------------------|----------|
| `default` | Read files | Getting started, sensitive work |
| `acceptEdits` | Read and edit files | Iterating on code you're reviewing |
| `plan` | Read files | Exploring, planning a refactor |
| `auto` | All actions, with classifier checks | Long-running tasks |
| `dontAsk` | Only pre-approved tools | Locked-down environments |
| `bypassPermissions` | All actions, no checks | Isolated containers/VMs only |

### Switching Modes

- **During session:** `Shift+Tab` cycles `default` → `acceptEdits` → `plan` → `auto`
- **At startup:** `claude --permission-mode plan`
- **As default:** `{ "permissions": { "defaultMode": "acceptEdits" } }`
- **Non-interactively:** `claude -p "refactor auth" --permission-mode acceptEdits`

### Auto Mode

Available on Team plans. Uses Claude Sonnet 4.6 as classifier. Classifier evaluates each action before execution.

Decision order: allow/deny rules → read-only auto-approved → classifier → fallback to prompting.

On entering auto mode, blanket shell access rules like `Bash(*)` are dropped. Narrow rules like `Bash(npm test)` carry over.

Classifier blocked by default: `curl | bash`, sending sensitive data, production deploys, mass deletion, granting permissions, force push.

Fallback: 3 consecutive blocks or 20 total blocks → pauses auto mode, resumes prompting.

### Plan Mode

Research and propose without modifying. Claude reads files, runs exploratory commands, writes a plan. On plan approval: execute in auto, acceptEdits, or manual review mode.

### dontAsk Mode

Auto-denies every tool not explicitly in `permissions.allow`. Fully non-interactive — suitable for CI pipelines.

---

## 10. Hooks System

**Source:** https://code.claude.com/docs/en/hooks, https://code.claude.com/docs/en/hooks-guide

### Overview

Hooks are user-defined shell commands, HTTP endpoints, LLM prompts, or agents that execute at lifecycle points.

### Hook Lifecycle (event order)

`SessionStart` → `UserPromptSubmit` → `PreToolUse` → `PermissionRequest` → `PostToolUse`/`PostToolUseFailure` → `Stop`/`StopFailure` → `SessionEnd`

Async events: `WorktreeCreate`, `WorktreeRemove`, `Notification`, `ConfigChange`, `InstructionsLoaded`, `CwdChanged`, `FileChanged`

### Configuration

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "if": "Bash(git *)",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/check-git.sh",
            "timeout": 600
          }
        ]
      }
    ]
  }
}
```

### Hook Handler Types

| Type | Description |
|------|-------------|
| `command` | Shell command, receives JSON on stdin |
| `http` | HTTP endpoint, receives same JSON as POST body |
| `prompt` | LLM prompt for judgment-based decisions |
| `agent` | Full agent with tool access for verification |

### Exit Codes

- **Exit 0**: Success. JSON output parsed from stdout
- **Exit 2**: Blocking error. stderr fed to Claude, action blocked
- **Other**: Non-blocking. stderr in verbose mode only

### Hook Events Reference

| Event | Matcher | Decision Control |
|-------|---------|-----------------|
| `SessionStart` | startup/resume/clear/compact | Add context |
| `UserPromptSubmit` | None (always fires) | Block, add context |
| `PreToolUse` | Tool name | Allow/deny/ask, modify input |
| `PermissionRequest` | Tool name | Allow/deny, modify input, update permissions |
| `PostToolUse` | Tool name | Block (feedback), add context |
| `PostToolUseFailure` | Tool name | Add context only |
| `Stop` | None | Block (prevent stopping) |
| `StopFailure` | Error type | Logging only |
| `SubagentStart` | Agent type | Add context |
| `SubagentStop` | Agent type | Block (continue subagent) |
| `TaskCreated` | None | Block, stop teammate |
| `TaskCompleted` | None | Block, stop teammate |
| `TeammateIdle` | None | Block, stop teammate |
| `ConfigChange` | Config source | Block change |
| `CwdChanged` | None | Env persistence |
| `FileChanged` | Filename | Env persistence |
| `WorktreeCreate` | None | Return path or fail |
| `WorktreeRemove` | None | Logging only |
| `PreCompact` | manual/auto | None |
| `PostCompact` | manual/auto | None |
| `Elicitation` | MCP server name | Accept/decline/cancel |
| `SessionEnd` | Exit reason | None |

### Common Input Fields (all hooks)

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/working/dir",
  "permission_mode": "default|plan|acceptEdits|auto|dontAsk|bypassPermissions",
  "hook_event_name": "EventName"
}
```

### PreToolUse Output

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow|deny|ask",
    "permissionDecisionReason": "Reason shown to user",
    "updatedInput": { "command": "modified command" },
    "additionalContext": "Context for Claude"
  }
}
```

### Practical Examples

**Block destructive commands:**
```bash
#!/bin/bash
COMMAND=$(jq -r '.tool_input.command' < /dev/stdin)
if echo "$COMMAND" | grep -q 'rm -rf'; then
  jq -n '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "deny", permissionDecisionReason: "Destructive command blocked"}}'
else
  exit 0
fi
```

**Auto-format after edits:**
```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Edit|Write",
      "hooks": [{"type": "command", "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write"}]
    }]
  }
}
```

**Notifications (Windows):**
```json
{
  "hooks": {
    "Notification": [{
      "matcher": "",
      "hooks": [{"type": "command", "command": "powershell.exe -Command \"[System.Windows.Forms.MessageBox]::Show('Claude needs input')\""}]
    }]
  }
}
```

### `if` Field (v2.1.85+)

Argument-level filtering without spawning process on every call:
```json
{ "type": "command", "if": "Bash(git *)", "command": "script.sh" }
```

### Limitations

- `PermissionRequest` hooks do NOT fire in `-p` mode — use `PreToolUse`
- `PostToolUse` hooks cannot undo actions
- `permissionDecision: "allow"` does NOT override deny rules
- Stop hooks fire on every response, not just task completion
- Hook timeout default: 10 minutes, configurable per hook

### Troubleshooting

**Stop hook infinite loop:** Check `stop_hook_active` field:
```bash
if [ "$(echo "$INPUT" | jq -r '.stop_hook_active')" = "true" ]; then exit 0; fi
```

**JSON validation failed:** Shell profile `echo` statements pollute stdout. Wrap in `if [[ $- == *i* ]]; then`.

---

## 11. MCP Servers

**Source:** https://code.claude.com/docs/en/mcp

### Transport Types

| Transport | Status | Command |
|-----------|--------|---------|
| HTTP (streamable) | Recommended | `claude mcp add --transport http <name> <url>` |
| SSE | Deprecated | `claude mcp add --transport sse <name> <url>` |
| stdio (local process) | Supported | `claude mcp add --transport stdio <name> -- <command>` |

### CLI Commands

```bash
# Add HTTP server
claude mcp add --transport http notion https://mcp.notion.com/mcp

# Add with auth
claude mcp add --transport http secure-api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"

# Add stdio with env var
claude mcp add --transport stdio --env AIRTABLE_API_KEY=YOUR_KEY airtable \
  -- npx -y airtable-mcp-server

# Windows: requires cmd /c wrapper for npx
claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package

# Manage
claude mcp list
claude mcp get <name>
claude mcp remove <name>
/mcp   # inside Claude Code
```

### Scope Levels

| Scope | Storage | Availability |
|-------|---------|-------------|
| `local` (default) | `~/.claude.json` under project path | You, current project |
| `project` | `.mcp.json` in project root | Shared via git |
| `user` | `~/.claude.json` | You, all projects |

Precedence: local > project > user. Project-scoped servers require approval.

### Environment Variable Expansion in .mcp.json

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": { "Authorization": "Bearer ${API_KEY}" }
    }
  }
}
```

### OAuth Authentication

Supported for HTTP/SSE. Use `/mcp` to trigger browser OAuth flow. Fixed callback port: `--callback-port 8080`. Dynamic headers via `headersHelper` field.

### Claude Code as MCP Server

```bash
claude mcp serve
```

### Output Limits

Warning at 10,000 tokens. Default max: 25,000 tokens. Override: `MAX_MCP_OUTPUT_TOKENS=50000`. Startup timeout: `MCP_TIMEOUT=10000 claude`.

### Claude.ai Connector Sync

MCP servers from `claude.ai/settings/connectors` auto-appear in Claude Code. Disable: `ENABLE_CLAUDEAI_MCP_SERVERS=false`.

---

## 12. Custom Commands & Skills

**Source:** https://code.claude.com/docs/en/skills

Custom slash commands and skills are **unified**. `.claude/commands/` still works; `.claude/skills/` is the new standard.

### Skill Locations (priority order)

| Location | Path | Applies to |
|----------|------|-----------|
| Enterprise | Managed settings | All org users |
| Personal | `~/.claude/skills/<skill-name>/SKILL.md` | All your projects |
| Project | `.claude/skills/<skill-name>/SKILL.md` | This project only |
| Plugin | `<plugin>/skills/<skill-name>/SKILL.md` | Where enabled |

### SKILL.md Frontmatter

```yaml
---
name: my-skill
description: What this skill does and when to use it
argument-hint: "[issue-number]"
disable-model-invocation: true   # prevent auto-invoke
user-invocable: false            # hide from / menu
allowed-tools: Read, Grep, Glob
model: claude-sonnet-4-6
effort: high
context: fork                    # run in isolated subagent
agent: Explore                   # which agent type
hooks:                           # lifecycle hooks
paths: "src/**/*.ts"             # only for matching files
shell: bash
---
Skill instructions here...
```

### String Substitutions

| Variable | Description |
|----------|-------------|
| `$ARGUMENTS` | All arguments |
| `$ARGUMENTS[N]` or `$N` | Specific argument (0-based) |
| `${CLAUDE_SESSION_ID}` | Session ID |
| `${CLAUDE_SKILL_DIR}` | Skill directory |

### Dynamic Context Injection

```yaml
---
name: pr-summary
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---
- PR diff: !`gh pr diff`
- PR comments: !`gh pr view --comments`
```

`` !`command` `` executes before skill content is sent to Claude.

### Invocation Control

| Frontmatter | You invoke | Claude invokes |
|-------------|------------|----------------|
| (default) | Yes | Yes |
| `disable-model-invocation: true` | Yes | No |
| `user-invocable: false` | No | Yes |

### Skill Permissions

```text
Skill                    # Deny all skills
Skill(commit)            # Allow specific
Skill(deploy *)          # Deny specific
```

---

## 13. Built-in Slash Commands

**Source:** https://code.claude.com/docs/en/commands

| Command | Purpose |
|---------|---------|
| `/add-dir <path>` | Add working directory |
| `/agents` | Manage agents |
| `/btw <question>` | Side question |
| `/chrome` | Chrome settings |
| `/clear` | Clear history (aliases: `/reset`, `/new`) |
| `/color [color]` | Set prompt bar color |
| `/compact [instructions]` | Compact conversation |
| `/config` | Settings (alias: `/settings`) |
| `/context` | Visualize context usage |
| `/copy [N]` | Copy response to clipboard |
| `/cost` | Token usage stats |
| `/desktop` | Continue in Desktop app (alias: `/app`) |
| `/diff` | Interactive diff viewer |
| `/doctor` | Diagnose installation |
| `/effort [level]` | Set effort level |
| `/exit` | Exit (alias: `/quit`) |
| `/export [filename]` | Export as plain text |
| `/fast [on\|off]` | Toggle fast mode |
| `/feedback [report]` | Submit feedback (alias: `/bug`) |
| `/branch [name]` | Create branch (alias: `/fork`) |
| `/help` | Show help |
| `/hooks` | View hook configs |
| `/ide` | Manage IDE integrations |
| `/init` | Initialize with CLAUDE.md |
| `/insights` | Session analysis report |
| `/install-github-app` | Setup GitHub app |
| `/keybindings` | Open keybindings config |
| `/login` / `/logout` | Auth |
| `/mcp` | Manage MCP |
| `/memory` | Edit CLAUDE.md, manage auto-memory |
| `/model [model]` | Select model |
| `/permissions` | View/update permissions |
| `/plan [description]` | Enter plan mode |
| `/plugin` | Manage plugins |
| `/pr-comments [PR]` | Fetch PR comments |
| `/release-notes` | Changelog |
| `/remote-control` | Remote control (alias: `/rc`) |
| `/rename [name]` | Rename session |
| `/resume [session]` | Resume conversation |
| `/rewind` | Rewind to checkpoint (alias: `/checkpoint`) |
| `/sandbox` | Toggle sandbox |
| `/schedule` | Cloud scheduled tasks |
| `/security-review` | Security analysis |
| `/skills` | List skills |
| `/stats` | Daily usage, streaks |
| `/status` | Settings status tab |
| `/statusline` | Configure status line |
| `/tasks` | Background tasks |
| `/terminal-setup` | Terminal keybindings |
| `/theme` | Color theme |
| `/usage` | Plan limits, rate status |
| `/vim` | Toggle vim mode |
| `/voice` | Push-to-talk |

**Bundled skills:** `/batch`, `/claude-api`, `/debug`, `/loop`, `/simplify`

---

## 14. IDE Integrations — VS Code

**Source:** https://code.claude.com/docs/en/vs-code

### Requirements
- VS Code 1.98.0+ (also works with Cursor)
- Anthropic account

### Installation
- Extensions view → search "Claude Code"
- Or: `vscode:extension/anthropic.claude-code`

### Opening Claude
- Editor Toolbar: Spark icon (top-right)
- Activity Bar: Spark icon in sidebar
- Status Bar: "✱ Claude Code" in bottom-right
- Command Palette: Ctrl+Shift+P → "Claude Code"

### Key Features

- **Permission modes:** Normal / Plan / Auto-accept
- **@-mentions:** `@auth`, `@src/components/` (trailing slash for folders)
- **Selection reference:** `Alt+K` inserts `@file.ts#5-10`
- **Checkpoints/Rewind:** hover any message → fork/rewind
- **Multiple conversations:** "Open in New Tab"/"New Window"
- **Terminal mode:** `claudeCode.useTerminal: true`
- **Git worktrees:** `claude --worktree feature-auth`

### VS Code Shortcuts

| Command | Shortcut |
|---------|---------|
| Focus Input (toggle) | Cmd+Esc / Ctrl+Esc |
| Open in New Tab | Cmd+Shift+Esc / Ctrl+Shift+Esc |
| New Conversation | Cmd+N / Ctrl+N (when focused) |
| Insert @-Mention | Option+K / Alt+K |

### Built-in IDE MCP Server

Extension runs a hidden MCP server on localhost:
- `mcp__ide__getDiagnostics` — language-server errors/warnings
- `mcp__ide__executeCode` — runs Python in Jupyter kernel (with confirmation)

### Extension Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `selectedModel` | `default` | Model for new conversations |
| `useTerminal` | `false` | Terminal mode |
| `initialPermissionMode` | `default` | Permission mode |
| `preferredLocation` | `panel` | Sidebar or panel |
| `autosave` | `true` | Auto-save before reads/writes |
| `useCtrlEnterToSend` | `false` | Ctrl+Enter to send |
| `respectGitIgnore` | `true` | Exclude .gitignore patterns |

---

## 15. IDE Integrations — JetBrains

**Source:** https://code.claude.com/docs/en/jetbrains

### Supported IDEs

IntelliJ IDEA, PyCharm, Android Studio, WebStorm, PhpStorm, GoLand

### Installation

Plugin: https://plugins.jetbrains.com/plugin/27310-claude-code-beta- (restart required)

### Features

- Quick launch: Cmd+Esc / Ctrl+Esc
- Diff viewing in IDE diff viewer
- Selection context auto-shared
- File references: Cmd+Option+K / Alt+Ctrl+K → `@File#L1-99`
- Diagnostic sharing

### Configuration

Settings → Tools → Claude Code [Beta]:
- Custom command path
- WSL: `wsl -d Ubuntu -- bash -lic "claude"`
- Option+Enter for multi-line (macOS)

Remote Development: plugin must be on remote host, not local client.

---

## 16. Subagents & Multi-Agent Patterns

**Source:** https://code.claude.com/docs/en/sub-agents

### Built-in Subagents

| Agent | Model | When Used |
|-------|-------|-----------|
| Explore | Haiku (read-only) | Searching/analyzing |
| Plan | Inherits (read-only) | Plan mode research |
| General-purpose | Inherits (all tools) | Complex tasks |
| Bash | Inherits | Terminal commands |
| statusline-setup | Sonnet | /statusline |
| Claude Code Guide | Haiku | Feature questions |

### Creating Custom Subagents

Markdown files with YAML frontmatter:

```markdown
---
name: code-reviewer
description: Reviews code for quality and best practices
tools: Read, Glob, Grep
model: sonnet
---
You are a code reviewer...
```

### Storage Locations (priority)

1. `--agents` CLI flag (session only, JSON)
2. `.claude/agents/` (project)
3. `~/.claude/agents/` (user)
4. Plugin `agents/` directory

### Supported Frontmatter

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique ID (lowercase, hyphens) |
| `description` | Yes | When to delegate |
| `tools` | No | Allowlist (inherits all if omitted) |
| `disallowedTools` | No | Denylist |
| `model` | No | sonnet/opus/haiku/inherit |
| `permissionMode` | No | default/acceptEdits/dontAsk/bypassPermissions/plan |
| `maxTurns` | No | Max turns |
| `skills` | No | Skills to preload |
| `mcpServers` | No | MCP servers |
| `hooks` | No | Lifecycle hooks |
| `memory` | No | user/project/local |
| `background` | No | Always background |
| `effort` | No | low/medium/high/max |
| `isolation` | No | `worktree` for git worktree |
| `initialPrompt` | No | Auto-submitted first turn |

### Model Resolution Order

1. `CLAUDE_CODE_SUBAGENT_MODEL` env var
2. Per-invocation `model` parameter
3. Subagent definition's `model` frontmatter
4. Main conversation's model

### Invoking

- Natural language: "Use the code-reviewer subagent to..."
- @-mention: `@"code-reviewer (agent)"`
- Session-wide: `claude --agent code-reviewer`
- Default: `agent` in settings.json

### Foreground vs Background

- Foreground: blocks main, permissions pass through
- Background: concurrent, pre-approved, `Ctrl+B` to background
- Disable: `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1`

### Persistent Memory

- `memory: user` → `~/.claude/agent-memory/<name>/`
- `memory: project` → `.claude/agent-memory/<name>/`
- `memory: local` → `.claude/agent-memory-local/<name>/`

### Critical Notes

- Subagents CANNOT spawn their own subagents
- Only the final message returns to parent
- Subagents do NOT receive parent's conversation history

---

## 17. Claude Agent SDK (Python & TypeScript)

**Source:** https://platform.claude.com/docs/en/agent-sdk/overview, /quickstart, /typescript, /python, /custom-tools, /subagents

### SDK Rename

The Claude Code SDK is now the **Claude Agent SDK**.
- npm: `@anthropic-ai/claude-agent-sdk`
- pip: `claude-agent-sdk`
- GitHub: [TypeScript](https://github.com/anthropics/claude-agent-sdk-typescript), [Python](https://github.com/anthropics/claude-agent-sdk-python)

### Installation

```bash
npm install @anthropic-ai/claude-agent-sdk    # TypeScript
pip install claude-agent-sdk                   # Python
export ANTHROPIC_API_KEY=your-api-key
```

### Basic Usage

```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

async def main():
    async for message in query(
        prompt="Find and fix the bug in auth.py",
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Edit", "Bash"],
            permission_mode="acceptEdits",
        ),
    ):
        print(message)

asyncio.run(main())
```

```typescript
import { query } from "@anthropic-ai/claude-agent-sdk";

for await (const message of query({
  prompt: "Find and fix the bug in auth.py",
  options: { allowedTools: ["Read", "Edit", "Bash"], permissionMode: "acceptEdits" }
})) {
  console.log(message);
}
```

### Built-in Tools

Read, Write, Edit, Bash, Glob, Grep, WebSearch, WebFetch, AskUserQuestion

### ClaudeAgentOptions Key Fields

```python
ClaudeAgentOptions(
    allowed_tools=["Read", "Edit", "Bash"],
    permission_mode="acceptEdits",
    system_prompt="...",
    cwd="/path/to/project",
    mcp_servers={"server_name": server_instance},
    agents={"agent-name": AgentDefinition(...)},
    resume="session-id",
    max_turns=10,
    model="claude-sonnet-4-6",
    setting_sources=["project"],
)
```

### Custom Tools

```python
from claude_agent_sdk import tool, create_sdk_mcp_server

@tool("get_temperature", "Get temp at location", {"latitude": float, "longitude": float})
async def get_temperature(args):
    # ... fetch data ...
    return {"content": [{"type": "text", "text": f"Temperature: {temp}°F"}]}

server = create_sdk_mcp_server(name="weather", tools=[get_temperature])
```

Tool name format: `mcp__{server_name}__{tool_name}`

### Programmatic Subagents

```python
agents={
    "code-reviewer": AgentDefinition(
        description="Expert code review specialist",
        prompt="You are a code reviewer...",
        tools=["Read", "Grep", "Glob"],
        model="sonnet",
    ),
}
```

**Critical:** Include `Agent` in `allowedTools` for the parent. Subagents cannot nest.

### Permission Modes

| Mode | Behavior |
|------|----------|
| `acceptEdits` | Auto-approves file edits |
| `dontAsk` | Denies anything not in allowedTools |
| `bypassPermissions` | All tools without prompts |
| `default` | Requires `canUseTool` callback |

### `tools` vs `allowedTools`

| Option | Effect |
|--------|--------|
| `tools` | Availability — only listed tools in context |
| `allowedTools` | Permission — listed tools run without prompt |
| `disallowedTools` | Denied but still visible (wastes a turn) |

---

## 18. GitHub Integration & CI/CD

**Source:** https://code.claude.com/docs/en/github-actions, https://code.claude.com/docs/en/gitlab-ci-cd

### GitHub Actions

Quick setup: `/install-github-app` from Claude Code (requires repo admin).

```yaml
name: Claude Code
on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
jobs:
  claude:
    runs-on: ubuntu-latest
    steps:
      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
```

Trigger: `@claude` in PR/issue comments. Use `prompt` parameter for automated runs.

Key `claude_args`: `--max-turns 5 --model claude-sonnet-4-6 --allowedTools "Read,Edit,Bash"`

Supports AWS Bedrock and Google Vertex AI via OIDC (no static keys).

### GitLab CI/CD (Beta)

```yaml
claude:
  stage: ai
  image: node:24-alpine3.21
  before_script:
    - apk add --no-cache git curl bash
    - curl -fsSL https://claude.ai/install.sh | bash
  script:
    - claude -p "${AI_FLOW_INPUT:-'Review this MR'}" --permission-mode acceptEdits
```

---

## 19. Headless / Non-Interactive Mode

**Source:** https://code.claude.com/docs/en/headless

### Basic Usage

```bash
claude -p "Find and fix the bug" --allowedTools "Read,Edit,Bash"
```

### Bare Mode

```bash
claude --bare -p "Summarize this file" --allowedTools "Read"
```

Skips: hooks, skills, plugins, MCP, auto memory, CLAUDE.md. Auth from env vars only.

### Structured Output

```bash
claude -p "Extract functions" --output-format json --json-schema '{"type":"object",...}'
```

Formats: `text` (default), `json`, `stream-json`

### Continue/Resume

```bash
session_id=$(claude -p "Start review" --output-format json | jq -r '.session_id')
claude -p "Continue" --resume "$session_id"
```

---

## 20. Extended Thinking & Model Selection

**Source:** https://code.claude.com/docs/en/model-config

### Model Aliases

| Alias | Model |
|-------|-------|
| `default` | Based on account type |
| `sonnet` | Sonnet 4.6 |
| `opus` | Opus 4.6 |
| `haiku` | Haiku 4.5 |
| `sonnet[1m]` | Sonnet + 1M context |
| `opus[1m]` | Opus + 1M context |
| `opusplan` | Opus plan → Sonnet execution |

### Setting Model (priority order)
1. `/model <alias>` during session
2. `claude --model <alias>` at startup
3. `ANTHROPIC_MODEL=<alias>` env var
4. `model` in settings.json

### Effort Levels

| Level | Behavior |
|-------|----------|
| `low` | Fast, minimal thinking |
| `medium` | Default, balanced |
| `high` | Deeper reasoning |
| `max` | Deepest, Opus 4.6 only |

Set via: `/effort`, `--effort`, `CLAUDE_CODE_EFFORT_LEVEL`, `effortLevel` in settings.json, skill frontmatter.

Include "ultrathink" in prompt for one-turn high effort.

### Extended Thinking Toggle

- `/config` → toggle
- `alwaysThinkingEnabled: true` in settings
- `Option+T` / `Alt+T` shortcut
- `MAX_THINKING_TOKENS=8000` to limit budget
- `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1` for fixed budget

### Enterprise Model Config

```bash
export ANTHROPIC_DEFAULT_OPUS_MODEL='us.anthropic.claude-opus-4-6-v1'
export ANTHROPIC_CUSTOM_MODEL_OPTION="my-gateway/claude-opus-4-6"
```

Prompt caching auto-enabled. Disable: `DISABLE_PROMPT_CACHING=1`.

---

## 21. Telemetry & Analytics

**Source:** https://code.claude.com/docs/en/monitoring-usage, https://code.claude.com/docs/en/analytics

### OpenTelemetry Setup

```bash
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
```

### Metrics

| Metric | Unit |
|--------|------|
| `claude_code.session.count` | count |
| `claude_code.lines_of_code.count` | count |
| `claude_code.pull_request.count` | count |
| `claude_code.commit.count` | count |
| `claude_code.cost.usage` | USD |
| `claude_code.token.usage` | tokens |
| `claude_code.code_edit_tool.decision` | count |
| `claude_code.active_time.total` | seconds |

### Events

- `claude_code.user_prompt` — prompt submitted
- `claude_code.tool_result` — tool completed
- `claude_code.api_request` — API call
- `claude_code.api_error` — failed API
- `claude_code.tool_decision` — permission decisions

### Analytics Dashboards

| Plan | URL | Features |
|------|-----|----------|
| Teams/Enterprise | claude.ai/analytics/claude-code | Usage, contribution, leaderboard, CSV |
| API (Console) | platform.claude.com/claude-code | Usage, spend, team insights |

---

## 22. Cost Management

**Source:** https://code.claude.com/docs/en/costs

### Average Costs
- Average: ~$6/developer/day
- 90% under $12/day
- Team: ~$100-200/developer/month with Sonnet 4.6

### `/cost` Command (API users)
Shows session token stats. Subscribers use `/stats`.

### Cost Reduction Strategies

- `/clear` between unrelated tasks
- `/compact Focus on code samples` for custom compaction
- `/model` to switch mid-session (Sonnet for most, Opus for complex)
- Use `model: haiku` in subagent frontmatter
- Prefer CLI tools over MCP servers (zero context overhead)
- Move workflow instructions from CLAUDE.md to skills (on-demand loading)
- `/effort low` for simple work
- Agent teams ~7x more tokens — keep small and focused

---

## 23. Context Window Management

**Source:** https://code.claude.com/docs/en/context-window

### Startup Load Order

1. System prompt (~4200 tokens, hidden)
2. Auto memory/MEMORY.md (~680 tokens)
3. Environment info (~280 tokens)
4. MCP tool names (deferred, names only)
5. CLAUDE.md files (user → project → parent dirs)
6. Skills (on-demand only)

### Commands

- `/compact [focus]` — reduce context, CLAUDE.md survives
- `/clear` — fresh context, previous session preserved
- `/context` — visualize context usage as colored grid

### Auto-Compaction

Triggers at ~95% capacity. Override: `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50`.

---

## 24. Keyboard Shortcuts

**Source:** https://code.claude.com/docs/en/interactive-mode

### General Controls

| Shortcut | Description |
|----------|-------------|
| `Ctrl+C` | Cancel current input or generation |
| `Ctrl+X Ctrl+K` | Kill all background agents (press twice in 3s) |
| `Ctrl+D` | Exit session |
| `Ctrl+G` / `Ctrl+X Ctrl+E` | Open in text editor |
| `Ctrl+L` | Clear terminal screen |
| `Ctrl+O` | Toggle verbose output |
| `Ctrl+R` | Reverse search history |
| `Ctrl+V` / `Cmd+V` | Paste image from clipboard |
| `Ctrl+B` | Background running tasks |
| `Ctrl+T` | Toggle task list |
| `Esc Esc` | Rewind/summarize |
| `Shift+Tab` / `Alt+M` | Cycle permission modes |
| `Alt+P` | Switch model |
| `Alt+T` | Toggle extended thinking |
| `Alt+O` | Toggle fast mode |
| `?` | Show available shortcuts |

### Text Editing

| Shortcut | Description |
|----------|-------------|
| `Ctrl+K` | Delete to end of line |
| `Ctrl+U` | Delete to line start |
| `Ctrl+Y` | Paste deleted text |
| `Alt+B` / `Alt+F` | Move back/forward one word |

### Multiline Input

| Method | Shortcut |
|--------|---------|
| Quick escape | `\` + Enter |
| macOS | `Option+Enter` |
| Shift+Enter | iTerm2, WezTerm, Ghostty, Kitty |
| Control sequence | `Ctrl+J` |

### Quick Prefixes

| Prefix | Action |
|--------|--------|
| `/` | Command or skill |
| `!` | Bash mode (Tab autocomplete) |
| `@` | File path mention |

### Vim Mode

Enable with `/vim`. Full h/j/k/l navigation, w/e/b word movement, text objects (iw, i", i(), etc.).

### macOS Option Key Note

Option/Alt shortcuts require terminal config: iTerm2 → Profiles → Keys → Left/Right Option = "Esc+".

---

## 25. Teams & Enterprise Features

**Source:** https://code.claude.com/docs/en/analytics, settings, monitoring pages

### Server-Managed Settings

Organizations deploy via:
- Server-managed from Claude.ai admin console
- MDM/OS-level policies (macOS, Windows registry)
- File-based `managed-settings.json`

Key managed-only settings: `forceLoginMethod`, `forceLoginOrgUUID`, `disableBypassPermissionsMode`, `allowManagedPermissionRulesOnly`, `allowManagedMcpServersOnly`, `allowManagedHooksOnly`, `channelsEnabled`, `allowedMcpServers`, `deniedMcpServers`, `companyAnnouncements`.

### Rate Limits

| Team size | TPM per user | RPM per user |
|-----------|-------------|-------------|
| 1-5 | 200k-300k | 5-7 |
| 5-20 | 100k-150k | 2.5-3.5 |
| 20-50 | 50k-75k | 1.25-1.75 |
| 50-100 | 25k-35k | 0.62-0.87 |
| 100-500 | 15k-20k | 0.37-0.47 |
| 500+ | 10k-15k | 0.25-0.35 |

Limits at org level, not per user — individuals can burst when others idle.

---

## 26. Sandboxing

**Source:** https://code.claude.com/docs/en/settings (sandbox section)

```json
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "excludedCommands": ["docker"],
    "filesystem": {
      "allowWrite": ["/tmp/build", "~/.kube"],
      "denyRead": ["~/.aws/credentials"]
    },
    "network": {
      "allowedDomains": ["github.com", "*.npmjs.org"],
      "allowUnixSockets": ["/var/run/docker.sock"],
      "allowLocalBinding": true
    }
  }
}
```

Supported on macOS, Linux, WSL2. Windows native not supported.

---

## 27. Troubleshooting

**Source:** https://code.claude.com/docs/en/troubleshooting

### /doctor Command

Checks: installation, version, search, auto-updates, settings validation, MCP config, keybindings, context usage warnings, plugin/agent loading.

### Common Issues

**`command not found: claude`** — PATH issue. Add `~/.local/bin` (macOS/Linux) or `%USERPROFILE%\.local\bin` (Windows).

**Authentication issues** — `/logout`, restart, re-auth. Check `ANTHROPIC_API_KEY` not overriding subscription.

**Performance** — `/compact` regularly. Close/restart between major tasks. Add build dirs to `.gitignore`.

**Search not working** — Install system ripgrep; `USE_BUILTIN_RIPGREP=0`.

**WSL** — Work on `/home/` not `/mnt/c/`. Firewall rules for JetBrains. nvm PATH priority.

### Reset Configuration

```bash
rm ~/.claude.json
rm -rf ~/.claude/
rm -rf .claude/
rm .mcp.json
```

---

## 28. Documentation Index

**Source:** https://code.claude.com/docs/llms.txt

All 80+ documentation pages organized by category:

### Core
overview, quickstart, desktop-quickstart, how-claude-code-works

### Platforms
web, desktop, vs-code, jetbrains, chrome, slack

### Configuration
setup, authentication, environment-variables, settings, model-config, llm-gateway, network-config, server-managed-settings

### Extending
plugins, plugin-marketplaces, skills, sub-agents, mcp

### Advanced
agent-teams, channels, checkpointing, fast-mode, headless, remote-control, scheduled-tasks

### Workflow
common-workflows, best-practices, hooks, keyboard-shortcuts, terminal-setup, status-line, code-review

### Security & Permissions
permission-modes, permissions, security, sandboxing, legal-compliance

### Data & Analytics
analytics, data-usage, zero-data-retention, cost-management

### Platform-Specific
amazon-bedrock, google-vertex-ai, microsoft-foundry, dev-containers

### CI/CD
github-actions, gitlab-ci-cd

### Reference
cli-reference, commands, tools-reference, .claude-directory, context-window, interactive-mode, output-styles, voice-dictation

### Support
changelog, troubleshooting, monitoring, enterprise-deployment

---

## Source URLs

| Topic | URL |
|-------|-----|
| Overview | https://code.claude.com/docs/en/overview |
| Quickstart | https://code.claude.com/docs/en/quickstart |
| Setup | https://code.claude.com/docs/en/setup |
| Authentication | https://code.claude.com/docs/en/authentication |
| CLI Reference | https://code.claude.com/docs/en/cli-reference |
| Settings | https://code.claude.com/docs/en/settings |
| Memory | https://code.claude.com/docs/en/memory |
| Permissions | https://code.claude.com/docs/en/permissions |
| Permission Modes | https://code.claude.com/docs/en/permission-modes |
| Security | https://code.claude.com/docs/en/security |
| Hooks Reference | https://code.claude.com/docs/en/hooks |
| Hooks Guide | https://code.claude.com/docs/en/hooks-guide |
| MCP | https://code.claude.com/docs/en/mcp |
| Skills | https://code.claude.com/docs/en/skills |
| Commands | https://code.claude.com/docs/en/commands |
| VS Code | https://code.claude.com/docs/en/vs-code |
| JetBrains | https://code.claude.com/docs/en/jetbrains |
| Sub-agents | https://code.claude.com/docs/en/sub-agents |
| Agent SDK Overview | https://platform.claude.com/docs/en/agent-sdk/overview |
| Agent SDK Quickstart | https://platform.claude.com/docs/en/agent-sdk/quickstart |
| Agent SDK TypeScript | https://platform.claude.com/docs/en/agent-sdk/typescript |
| Agent SDK Python | https://platform.claude.com/docs/en/agent-sdk/python |
| Agent SDK Custom Tools | https://platform.claude.com/docs/en/agent-sdk/custom-tools |
| Agent SDK Subagents | https://platform.claude.com/docs/en/agent-sdk/subagents |
| GitHub Actions | https://code.claude.com/docs/en/github-actions |
| GitLab CI/CD | https://code.claude.com/docs/en/gitlab-ci-cd |
| Headless Mode | https://code.claude.com/docs/en/headless |
| Model Config | https://code.claude.com/docs/en/model-config |
| Analytics | https://code.claude.com/docs/en/analytics |
| Monitoring/OTel | https://code.claude.com/docs/en/monitoring-usage |
| Cost Management | https://code.claude.com/docs/en/costs |
| Context Window | https://code.claude.com/docs/en/context-window |
| Interactive Mode | https://code.claude.com/docs/en/interactive-mode |
| Troubleshooting | https://code.claude.com/docs/en/troubleshooting |
| Tool Use API | https://platform.claude.com/docs/en/docs/build-with-claude/tool-use |
| Docs Index | https://code.claude.com/docs/llms.txt |
| Settings Schema | https://json.schemastore.org/claude-code-settings.json |
