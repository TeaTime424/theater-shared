# Claude Code Core Documentation — Raw Research

**Status:** RESEARCH — Reference only
**Date:** 2026-03-28
**Sources:** https://code.claude.com/docs/en/ (official documentation — docs.anthropic.com redirects here)

---

## Executive Summary

Claude Code documentation has migrated from docs.anthropic.com/en/docs/claude-code/* to code.claude.com/docs/en/*. All old URLs do 301 redirects. The docs cover installation (native installer, Homebrew, WinGet, npm-deprecated), CLI reference (70+ flags), a 4-scope settings system, CLAUDE.md memory files, auto memory, and multiple auth methods. The settings.json schema is published at https://json.schemastore.org/claude-code-settings.json.

---

## 1. Overview

**Source:** https://code.claude.com/docs/en/overview

Claude Code is an AI-powered coding assistant available in Terminal (CLI), VS Code, JetBrains, Desktop app, and Web. Key capabilities:
- Reads codebase, edits files, runs commands, integrates with dev tools
- Sub-agents: spawn multiple Claude Code agents working simultaneously
- MCP (Model Context Protocol) for external tool connections
- CLAUDE.md for persistent project instructions
- Auto memory: Claude writes notes across sessions
- Hooks: shell commands before/after Claude Code actions
- Scheduled tasks (cloud or desktop)
- Remote Control, Channels, Slack, GitHub Actions, GitLab CI/CD integrations

**Install commands:**
- macOS/Linux/WSL: `curl -fsSL https://claude.ai/install.sh | bash`
- Windows PowerShell: `irm https://claude.ai/install.ps1 | iex`
- Windows CMD: `curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd`
- Homebrew: `brew install --cask claude-code`
- WinGet: `winget install Anthropic.ClaudeCode`

**Start:** `cd your-project && claude`

---

## 2. Advanced Setup

**Source:** https://code.claude.com/docs/en/setup

### System Requirements
- OS: macOS 13.0+, Windows 10 1809+ / Server 2019+, Ubuntu 20.04+, Debian 10+, Alpine 3.19+
- Hardware: 4 GB+ RAM
- Network: internet required
- Shell: Bash, Zsh, PowerShell, or CMD
- Windows: Git for Windows required

### Windows Setup
Option 1: Native Windows with Git Bash — install Git for Windows, then use PowerShell/CMD install.
If Claude can't find Git Bash, set in settings.json:
```json
{
  "env": {
    "CLAUDE_CODE_GIT_BASH_PATH": "C:\\Program Files\\Git\\bin\\bash.exe"
  }
}
```
Option 2: WSL (1 or 2). WSL2 supports sandboxing; WSL1 does not.

### Alpine Linux
Requires `libgcc`, `libstdc++`, `ripgrep` packages plus `USE_BUILTIN_RIPGREP=0` in settings.json.

### Verify Installation
```bash
claude --version
claude doctor
```

### Authentication
Requires Pro, Max, Teams, Enterprise, or Console account. Free plan does NOT include Claude Code. Third-party: Amazon Bedrock, Google Vertex AI, Microsoft Foundry.

### Auto-Updates
Native installs auto-update in background. Homebrew/WinGet require manual: `brew upgrade claude-code` or `winget upgrade Anthropic.ClaudeCode`.

**Release channels** (in settings.json):
```json
{ "autoUpdatesChannel": "stable" }
```
- `"latest"` (default) — newest release
- `"stable"` — ~1 week old, skips major regressions

**Disable auto-updates:**
```json
{ "env": { "DISABLE_AUTOUPDATER": "1" } }
```

**Manual update:** `claude update`

### Install Specific Version
```bash
curl -fsSL https://claude.ai/install.sh | bash -s 1.0.58
```

### Uninstall (Native)
```bash
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
# Remove config:
rm -rf ~/.claude
rm ~/.claude.json
```

---

## 3. CLI Reference

**Source:** https://code.claude.com/docs/en/cli-reference

### CLI Commands

| Command | Description |
|---------|-------------|
| `claude` | Start interactive session |
| `claude "query"` | Start interactive session with initial prompt |
| `claude -p "query"` | Query via SDK, then exit (print mode) |
| `cat file \| claude -p "query"` | Process piped content |
| `claude -c` | Continue most recent conversation in current directory |
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

### CLI Flags (selected)

| Flag | Description |
|------|-------------|
| `--add-dir` | Add additional working directories |
| `--agent` | Specify agent for current session |
| `--agents` | Define custom subagents dynamically via JSON |
| `--allow-dangerously-skip-permissions` | Enable permission bypassing as option |
| `--allowedTools` | Tools that execute without prompting |
| `--append-system-prompt` | Append text to default system prompt |
| `--append-system-prompt-file` | Append file to default system prompt |
| `--bare` | Minimal mode — skip hooks, skills, plugins, MCP, CLAUDE.md |
| `--betas` | Beta headers for API requests (API key users only) |
| `--chrome` | Enable Chrome browser integration |
| `--continue`, `-c` | Load most recent conversation |
| `--dangerously-skip-permissions` | Skip all permission prompts |
| `--debug` | Enable debug mode with optional category filtering |
| `--disable-slash-commands` | Disable all skills and commands |
| `--disallowedTools` | Tools removed from model context |
| `--effort` | Set effort level: low/medium/high/max (Opus 4.6 only) |
| `--fallback-model` | Fallback model when default is overloaded (print mode) |
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
| `--no-chrome` | Disable Chrome browser integration |
| `--no-session-persistence` | Don't save session to disk (print mode) |
| `--output-format` | Output format: text, json, stream-json |
| `--enable-auto-mode` | Unlock auto mode in Shift+Tab cycle |
| `--permission-mode` | Begin in specified permission mode |
| `--permission-prompt-tool` | MCP tool for permission prompts (non-interactive) |
| `--plugin-dir` | Load plugins from directory for this session |
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

| Flag | Behavior |
|------|----------|
| `--system-prompt` | Replaces entire default prompt |
| `--system-prompt-file` | Replaces with file contents |
| `--append-system-prompt` | Appends to default prompt |
| `--append-system-prompt-file` | Appends file contents to default prompt |

`--system-prompt` and `--system-prompt-file` are mutually exclusive. Append flags can combine with either replacement flag.

---

## 4. Settings

**Source:** https://code.claude.com/docs/en/settings

### Configuration Scopes

| Scope | Location | Who it affects | Shared with team? |
|-------|----------|----------------|-------------------|
| **Managed** | Server-managed, plist/registry, or `managed-settings.json` | All users on machine | Yes (deployed by IT) |
| **User** | `~/.claude/` directory | You, across all projects | No |
| **Project** | `.claude/` in repository | All collaborators | Yes (committed to git) |
| **Local** | `.claude/settings.local.json` | You, in this repo only | No (gitignored) |

**Precedence (highest to lowest):**
1. Managed (cannot be overridden)
2. Command line arguments
3. Local (`.claude/settings.local.json`)
4. Project (`.claude/settings.json`)
5. User (`~/.claude/settings.json`)

**Array settings merge across scopes** — they concatenate and deduplicate, not replace.

### Settings Files Locations

| Feature | User | Project | Local |
|---------|------|---------|-------|
| Settings | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` |
| Subagents | `~/.claude/agents/` | `.claude/agents/` | None |
| MCP servers | `~/.claude.json` | `.mcp.json` | `~/.claude.json` (per-project) |
| Plugins | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` |
| CLAUDE.md | `~/.claude/CLAUDE.md` | `CLAUDE.md` or `.claude/CLAUDE.md` | None |

**Other config:** `~/.claude.json` stores preferences, OAuth session, MCP configs, per-project state.

### Example settings.json
```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test *)",
      "Read(~/.zshrc)"
    ],
    "deny": [
      "Bash(curl *)",
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)"
    ]
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_METRICS_EXPORTER": "otlp"
  }
}
```

### Available Settings (Key Subset)

| Key | Description | Example |
|-----|-------------|---------|
| `apiKeyHelper` | Script to generate auth value | `/bin/generate_temp_api_key.sh` |
| `autoMemoryDirectory` | Custom directory for auto memory | `"~/my-memory-dir"` |
| `cleanupPeriodDays` | Delete sessions older than N days (0 = disable persistence) | `20` |
| `companyAnnouncements` | Startup announcements (cycled randomly) | `["Welcome..."]` |
| `env` | Environment variables for every session | `{"FOO": "bar"}` |
| `attribution` | Customize git commit/PR attribution | `{"commit": "...", "pr": ""}` |
| `includeGitInstructions` | Include git instructions in system prompt (default: true) | `false` |
| `permissions` | Allow/ask/deny rules (see Permission Settings) | |
| `autoMode` | Configure auto mode classifier | `{"environment": [...]}` |
| `disableAutoMode` | Prevent auto mode activation | `"disable"` |
| `hooks` | Custom commands at lifecycle events | see hooks docs |
| `defaultShell` | Default shell for `!` commands: `"bash"` or `"powershell"` | `"powershell"` |
| `disableAllHooks` | Disable all hooks and custom status line | `true` |
| `model` | Override default model | `"claude-sonnet-4-6"` |
| `availableModels` | Restrict model selection | `["sonnet", "haiku"]` |
| `effortLevel` | Persist effort level: low/medium/high | `"medium"` |
| `statusLine` | Custom status line script | `{"type": "command", ...}` |
| `language` | Claude's preferred response language | `"japanese"` |
| `autoUpdatesChannel` | Release channel: latest or stable | `"stable"` |
| `forceLoginMethod` | Restrict login: claudeai or console | `claudeai` |
| `enableAllProjectMcpServers` | Auto-approve all MCP servers in .mcp.json | `true` |

### Global Config Settings (stored in ~/.claude.json, NOT settings.json)

| Key | Description |
|-----|-------------|
| `autoConnectIde` | Auto-connect to IDE on startup |
| `autoInstallIdeExtension` | Auto-install Claude Code IDE extension |
| `editorMode` | Key binding: "normal" or "vim" |
| `showTurnDuration` | Show turn duration messages after responses |
| `terminalProgressBarEnabled` | Show terminal progress bar |
| `teammateMode` | Agent team display mode |

### Permission Settings

| Key | Description |
|-----|-------------|
| `allow` | Rules to allow tool use without prompting |
| `ask` | Rules requiring confirmation |
| `deny` | Rules to block tool use |
| `additionalDirectories` | Extra working directories Claude can access |
| `defaultMode` | Default permission mode |
| `disableBypassPermissionsMode` | Prevent --dangerously-skip-permissions |

**Permission rule syntax:** `Tool` or `Tool(specifier)`

| Rule | Effect |
|------|--------|
| `Bash` | All Bash commands |
| `Bash(npm run *)` | Commands starting with `npm run` |
| `Read(./.env)` | Reading the .env file |
| `WebFetch(domain:example.com)` | Fetch requests to example.com |

Rules evaluated in order: deny first, then ask, then allow. First matching rule wins.

### Sandbox Settings (under `sandbox` key)

| Key | Description |
|-----|-------------|
| `enabled` | Enable bash sandboxing (macOS, Linux, WSL2). Default: false |
| `failIfUnavailable` | Error if sandbox can't start (managed settings gate) |
| `autoAllowBashIfSandboxed` | Auto-approve bash when sandboxed. Default: true |
| `excludedCommands` | Commands run outside sandbox |
| `filesystem.allowWrite` | Paths where sandboxed commands can write |
| `filesystem.denyWrite` | Paths blocked from writing |
| `filesystem.denyRead` | Paths blocked from reading |
| `network.allowedDomains` | Allowed outbound domains (supports wildcards) |
| `network.allowLocalBinding` | Allow binding to localhost (macOS only) |

### Managed Settings Locations

- **macOS:** `/Library/Application Support/ClaudeCode/managed-settings.json`
- **Linux/WSL:** `/etc/claude-code/managed-settings.json`
- **Windows:** `C:\Program Files\ClaudeCode\managed-settings.json`

Drop-in directory supported: `managed-settings.d/*.json` — merged alphabetically on top of base file.

### Verify Active Settings

Run `/status` inside Claude Code to see which settings sources are active and their origin.

---

## 5. CLAUDE.md and Memory

**Source:** https://code.claude.com/docs/en/memory

### Two Memory Systems

| | CLAUDE.md files | Auto memory |
|--|-----------------|-------------|
| **Who writes it** | You | Claude |
| **What it contains** | Instructions and rules | Learnings and patterns |
| **Scope** | Project, user, or org | Per working tree |
| **Loaded into** | Every session | Every session (first 200 lines or 25KB) |
| **Use for** | Coding standards, workflows, architecture | Build commands, debugging insights, preferences |

### CLAUDE.md Locations

| Scope | Location | Purpose |
|-------|----------|---------|
| **Managed policy** | macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`; Linux/WSL: `/etc/claude-code/CLAUDE.md`; Windows: `C:\Program Files\ClaudeCode\CLAUDE.md` | Org-wide instructions |
| **Project instructions** | `./CLAUDE.md` or `./.claude/CLAUDE.md` | Team-shared project instructions |
| **User instructions** | `~/.claude/CLAUDE.md` | Personal preferences for all projects |

Files in ancestor directories are loaded in full at launch. Files in subdirectories load on demand when Claude reads files there.

### Writing Effective CLAUDE.md

- Target under 200 lines per file
- Use markdown headers and bullets
- Be specific and concrete ("Use 2-space indentation" not "Format code properly")
- Avoid conflicting instructions across files

### Import Syntax

```text
See @README for project overview and @package.json for npm commands.

# Additional Instructions
- git workflow @docs/git-instructions.md
- @~/.claude/my-project-instructions.md
```

Imports expand and load into context at launch. Recursive imports supported (max depth 5).

### .claude/rules/ Directory

Organize instructions into multiple files. Each file covers one topic.

```
your-project/
├── .claude/
│   ├── CLAUDE.md
│   └── rules/
│       ├── code-style.md
│       ├── testing.md
│       └── security.md
```

**Path-specific rules** (YAML frontmatter):
```markdown
---
paths:
  - "src/api/**/*.ts"
---

# API Development Rules
- All API endpoints must include input validation
```

Rules without `paths` load at launch unconditionally. Path-scoped rules trigger when Claude reads matching files.

### How CLAUDE.md Files Load

Claude Code reads CLAUDE.md files by walking up the directory tree from the current working directory. If you run in `foo/bar/`, it loads from both `foo/bar/CLAUDE.md` and `foo/CLAUDE.md`.

Block-level HTML comments (`<!-- notes -->`) are stripped from context but visible when you open the file with Read.

### AGENTS.md Compatibility

Claude Code reads `CLAUDE.md`, not `AGENTS.md`. Create a `CLAUDE.md` that imports `AGENTS.md` for compatibility:
```markdown
@AGENTS.md

## Claude Code specific instructions
...
```

### Auto Memory

Requires Claude Code v2.1.59+.

**Storage location:** `~/.claude/projects/<project>/memory/`
- `MEMORY.md` — concise index, first 200 lines/25KB loaded every session
- Topic files (e.g., `debugging.md`) — loaded on demand

**Enable/disable:**
```json
{ "autoMemoryEnabled": false }
```
Or env var: `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`

**Custom directory:**
```json
{ "autoMemoryDirectory": "~/my-custom-memory-dir" }
```
(Not accepted in project settings.json — only user/local/managed settings)

**The `/memory` command** — lists all CLAUDE.md and rules files loaded in current session, toggles auto memory, links to auto memory folder.

### Troubleshooting Memory

- CLAUDE.md content is delivered as a user message after system prompt, not AS the system prompt — Claude reads and tries to follow it but no strict compliance guarantee
- Run `/memory` to verify files are being loaded
- Instructions survive `/compact` — CLAUDE.md is re-injected fresh after compaction
- For system-prompt-level enforcement, use `--append-system-prompt` flag

### Excluding CLAUDE.md Files (claudeMdExcludes)

```json
{
  "claudeMdExcludes": [
    "**/monorepo/CLAUDE.md",
    "/home/user/monorepo/other-team/.claude/rules/**"
  ]
}
```

Managed policy CLAUDE.md files cannot be excluded.

---

## 6. Authentication

**Source:** https://code.claude.com/docs/en/authentication

### Account Types

- **Claude Pro or Max subscription** — log in with Claude.ai account
- **Claude for Teams or Enterprise** — log in with team-invited Claude.ai account
- **Claude Console** — log in with Console credentials (admin must invite first)
- **Cloud providers** — Amazon Bedrock, Google Vertex AI, Microsoft Foundry (set env vars, no browser login)

To log out: `/logout` at Claude Code prompt.

### Team Authentication Options

1. **Claude for Teams** — self-service, centralized billing, admin tools
2. **Claude for Enterprise** — adds SSO, domain capture, RBAC, compliance API, managed policy settings
3. **Claude Console** — API-based billing, bulk invite or SSO, assign "Claude Code" or "Developer" roles
4. **Cloud providers** — distribute env vars and credential instructions to users

### Credential Storage

- **macOS:** encrypted macOS Keychain
- **Linux/Windows:** `~/.claude/.credentials.json` (Linux: mode 0600)

### Authentication Precedence (highest to lowest)

1. Cloud provider env vars (`CLAUDE_CODE_USE_BEDROCK`, `CLAUDE_CODE_USE_VERTEX`, `CLAUDE_CODE_USE_FOUNDRY`)
2. `ANTHROPIC_AUTH_TOKEN` — sent as `Authorization: Bearer` header (for LLM gateways)
3. `ANTHROPIC_API_KEY` — sent as `X-Api-Key` header (direct Anthropic API)
4. `apiKeyHelper` script output
5. Subscription OAuth credentials from `/login`

**Note:** `apiKeyHelper`, `ANTHROPIC_API_KEY`, and `ANTHROPIC_AUTH_TOKEN` apply to terminal CLI sessions only. Desktop and remote sessions use OAuth exclusively.

### apiKeyHelper

```json
{ "apiKeyHelper": "/bin/generate_temp_api_key.sh" }
```
Called after 5 minutes or on HTTP 401. Custom interval: `CLAUDE_CODE_API_KEY_HELPER_TTL_MS` env var. If takes >10s, shows warning in prompt bar.

---

## 7. Quickstart

**Source:** https://code.claude.com/docs/en/quickstart

### Steps

1. Install Claude Code (native installer recommended)
2. Log in: run `claude`, follow browser prompts on first launch
3. Start session: `cd /path/to/project && claude`
4. Ask first question: "what does this project do?"
5. Make first code change: "add a hello world function to the main file"
6. Use git: "commit my changes with a descriptive message"
7. Fix bugs/add features in natural language

### Essential Commands

| Command | What it does |
|---------|-------------|
| `claude` | Start interactive mode |
| `claude "task"` | Run a one-time task |
| `claude -p "query"` | Run one-off query, then exit |
| `claude -c` | Continue most recent conversation |
| `claude -r` | Resume a previous conversation |
| `claude commit` | Create a Git commit |
| `/clear` | Clear conversation history |
| `/help` | Show available commands |
| `exit` or Ctrl+C | Exit Claude Code |

---

## 8. Documentation Index (all pages)

**Source:** https://code.claude.com/docs/llms.txt

Full list of documentation sections and pages:

### Core Documentation
- Overview & Getting Started: overview, quickstart, desktop-quickstart, how-claude-code-works
- Platforms: web, desktop, vs-code, jetbrains, chrome, slack
- Configuration: setup, authentication, environment variables, settings, model-config, llm-gateway, network-config, server-managed-settings

### Extending Claude Code
- Plugins, plugin marketplaces, skills, sub-agents, MCP

### Advanced Features
- Agent teams, channels, checkpointing, fast mode, headless/programmatic use, remote control, scheduled tasks

### Workflow
- Common workflows, best practices, hooks, keyboard shortcuts, terminal setup, status line, code review

### Security & Permissions
- Permission modes, permissions, security, sandboxing, legal/compliance

### Data & Analytics
- Analytics, data usage, zero data retention, cost management

### Platform-Specific
- Amazon Bedrock, Google Vertex AI, Microsoft Foundry, dev containers

### CI/CD
- GitHub Actions, GitLab CI/CD

### Reference
- CLI reference, built-in commands, tools reference, `.claude` directory, context window, interactive mode, output styles, voice dictation

### Support
- Changelog, troubleshooting, monitoring, enterprise deployment

---

## Bidirectional Search

- **Searched FOR:** docs.anthropic.com/en/docs/claude-code, code.claude.com/docs/en/overview, code.claude.com/docs/en/setup, code.claude.com/docs/en/cli-reference, code.claude.com/docs/en/settings, code.claude.com/docs/en/memory, code.claude.com/docs/en/authentication, code.claude.com/docs/en/quickstart, code.claude.com/docs/llms.txt
- **Searched AGAINST:** N/A — this is a raw documentation capture, not a claim verification
- **Contradicting evidence found:** N/A

---

## Sources

1. Claude Code Overview — https://code.claude.com/docs/en/overview
2. Advanced Setup — https://code.claude.com/docs/en/setup
3. CLI Reference — https://code.claude.com/docs/en/cli-reference
4. Settings — https://code.claude.com/docs/en/settings
5. Memory (CLAUDE.md + auto memory) — https://code.claude.com/docs/en/memory
6. Authentication — https://code.claude.com/docs/en/authentication
7. Quickstart — https://code.claude.com/docs/en/quickstart
8. Documentation Index — https://code.claude.com/docs/llms.txt
9. Redirect source: docs.anthropic.com/en/docs/claude-code/* → code.claude.com/docs/en/* (301)
10. JSON Schema for settings.json — https://json.schemastore.org/claude-code-settings.json
