# Claude Code: MCP, Slash Commands, and IDE Integration

**Status:** RESEARCH — Reference documentation
**Date:** 2026-03-28
**Sources:** docs.anthropic.com (redirects to code.claude.com)

## Executive Summary

Official Claude Code documentation has moved to `code.claude.com/docs/`. The docs cover full MCP server configuration (HTTP, SSE, stdio), a comprehensive built-in command reference, VS Code extension with graphical panel integration, and JetBrains plugin support. Custom "slash commands" have been merged into the "Skills" system.

---

## 1. MCP (Model Context Protocol)

**Source:** https://code.claude.com/docs/en/mcp

### What MCP enables
- Connect Claude Code to external tools, databases, APIs
- Use cases: JIRA/GitHub issue implementation, Sentry error analysis, PostgreSQL queries, Figma design integration, Gmail drafts, external event channels (Telegram, Discord, webhooks)

### Transport types

| Transport | Status | Command syntax |
|-----------|--------|---------------|
| HTTP (streamable) | Recommended | `claude mcp add --transport http <name> <url>` |
| SSE | Deprecated | `claude mcp add --transport sse <name> <url>` |
| stdio (local process) | Supported | `claude mcp add --transport stdio <name> -- <command>` |

### CLI commands

```bash
# Add HTTP server
claude mcp add --transport http notion https://mcp.notion.com/mcp

# Add with auth header
claude mcp add --transport http secure-api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"

# Add stdio server with env var
claude mcp add --transport stdio --env AIRTABLE_API_KEY=YOUR_KEY airtable \
  -- npx -y airtable-mcp-server

# Windows: requires cmd /c wrapper for npx
claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package

# Add from JSON config
claude mcp add-json <name> '<json>'

# Import from Claude Desktop (macOS/WSL only)
claude mcp add-from-claude-desktop

# Manage
claude mcp list
claude mcp get <name>
claude mcp remove <name>
/mcp   # (inside Claude Code) check status, manage OAuth
```

### Scope levels

| Scope | Storage | Availability |
|-------|---------|-------------|
| `local` (default) | `~/.claude.json` under project path | You, current project only |
| `project` | `.mcp.json` in project root | Shared via version control |
| `user` | `~/.claude.json` | You, all projects |

- Precedence: local > project > user
- Project-scoped servers require approval before use; reset with `claude mcp reset-project-choices`

### Environment variable expansion in `.mcp.json`

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

Supported in: `command`, `args`, `env`, `url`, `headers`

### OAuth authentication
- Supported for HTTP/SSE transports
- Use `/mcp` inside Claude Code to trigger browser OAuth flow
- Fixed callback port: `--callback-port 8080`
- Pre-configured credentials: `--client-id <id> --client-secret`
- Override metadata discovery: set `authServerMetadataUrl` in `.mcp.json` oauth object
- Dynamic headers (Kerberos, short-lived tokens): use `headersHelper` field

### Dynamic tool updates
- Claude Code supports MCP `list_changed` notifications — tools update without reconnecting

### Claude Code as MCP server

```bash
claude mcp serve
```

Config for Claude Desktop:
```json
{
  "mcpServers": {
    "claude-code": {
      "type": "stdio",
      "command": "claude",
      "args": ["mcp", "serve"],
      "env": {}
    }
  }
}
```

### Output limits
- Warning at 10,000 tokens; default max 25,000 tokens
- Override: `MAX_MCP_OUTPUT_TOKENS=50000`
- Startup timeout: `MCP_TIMEOUT=10000 claude`

### Claude.ai connector sync
- MCP servers added at `claude.ai/settings/connectors` automatically appear in Claude Code
- Disable: `ENABLE_CLAUDEAI_MCP_SERVERS=false claude`

### Plugin-provided MCP servers
- Plugins can bundle MCP servers in `.mcp.json` or inline in `plugin.json`
- Variables: `${CLAUDE_PLUGIN_ROOT}`, `${CLAUDE_PLUGIN_DATA}`
- Auto-start when plugin enabled; reload with `/reload-plugins`

### MCP prompts as commands
- MCP servers can expose prompts that appear as commands: `/mcp__<server>__<prompt>`

---

## 2. Built-in Slash Commands

**Source:** https://code.claude.com/docs/en/commands

Type `/` in Claude Code to see all commands. Some depend on platform, plan, or environment.

**Full command reference:**

| Command | Purpose |
|---------|---------|
| `/add-dir <path>` | Add working directory to current session |
| `/agents` | Manage agent configurations |
| `/btw <question>` | Side question without adding to conversation |
| `/chrome` | Configure Claude in Chrome settings |
| `/clear` | Clear conversation history. Aliases: `/reset`, `/new` |
| `/color [color\|default]` | Set prompt bar color (red/blue/green/yellow/purple/orange/pink/cyan) |
| `/compact [instructions]` | Compact conversation with optional focus |
| `/config` | Open Settings interface. Alias: `/settings` |
| `/context` | Visualize context usage as colored grid |
| `/copy [N]` | Copy last (or Nth) response to clipboard |
| `/cost` | Show token usage statistics |
| `/desktop` | Continue session in Desktop app (macOS/Windows). Alias: `/app` |
| `/diff` | Interactive diff viewer for uncommitted changes |
| `/doctor` | Diagnose Claude Code installation |
| `/effort [low\|medium\|high\|max\|auto]` | Set model effort level |
| `/exit` | Exit CLI. Alias: `/quit` |
| `/export [filename]` | Export conversation as plain text |
| `/extra-usage` | Configure extra usage when rate limited |
| `/fast [on\|off]` | Toggle fast mode |
| `/feedback [report]` | Submit feedback. Alias: `/bug` |
| `/branch [name]` | Create conversation branch. Alias: `/fork` |
| `/help` | Show help and available commands |
| `/hooks` | View hook configurations |
| `/ide` | Manage IDE integrations and show status |
| `/init` | Initialize project with CLAUDE.md |
| `/insights` | Generate session analysis report |
| `/install-github-app` | Set up Claude GitHub Actions app |
| `/install-slack-app` | Install Claude Slack app |
| `/keybindings` | Open/create keybindings config |
| `/login` | Sign in to Anthropic account |
| `/logout` | Sign out |
| `/mcp` | Manage MCP server connections and OAuth |
| `/memory` | Edit CLAUDE.md files, manage auto-memory |
| `/mobile` | Show QR code for mobile app. Aliases: `/ios`, `/android` |
| `/model [model]` | Select/change AI model |
| `/passes` | Share free week of Claude Code (if eligible) |
| `/permissions` | View/update permissions. Alias: `/allowed-tools` |
| `/plan [description]` | Enter plan mode |
| `/plugin` | Manage plugins |
| `/pr-comments [PR]` | Fetch GitHub PR comments |
| `/privacy-settings` | Privacy settings (Pro/Max only) |
| `/release-notes` | View full changelog |
| `/reload-plugins` | Reload all active plugins |
| `/remote-control` | Make session available for remote control. Alias: `/rc` |
| `/remote-env` | Configure default remote environment |
| `/rename [name]` | Rename current session |
| `/resume [session]` | Resume conversation by ID/name. Alias: `/continue` |
| `/review` | DEPRECATED — use code-review plugin instead |
| `/rewind` | Rewind conversation/code to previous point. Alias: `/checkpoint` |
| `/sandbox` | Toggle sandbox mode |
| `/schedule [description]` | Create/manage Cloud scheduled tasks |
| `/security-review` | Analyze pending changes for security vulnerabilities |
| `/skills` | List available skills |
| `/stats` | Visualize daily usage, session history, streaks |
| `/status` | Open Settings Status tab |
| `/statusline` | Configure status line |
| `/stickers` | Order Claude Code stickers |
| `/tasks` | List and manage background tasks |
| `/terminal-setup` | Configure terminal keybindings |
| `/theme` | Change color theme |
| `/upgrade` | Open upgrade page (Pro/Max only) |
| `/usage` | Show plan usage limits and rate limit status |
| `/vim` | Toggle Vim/Normal editing modes |
| `/voice` | Toggle push-to-talk voice dictation |

**Bundled skills** (appear alongside built-in commands):

| Skill | Purpose |
|-------|---------|
| `/batch <instruction>` | Large-scale parallel codebase changes via git worktrees |
| `/claude-api` | Load Claude API reference material |
| `/debug [description]` | Enable debug logging + troubleshoot |
| `/loop [interval] <prompt>` | Run prompt repeatedly on interval |
| `/simplify [focus]` | Review/fix code quality in parallel agents |

---

## 3. Custom Slash Commands / Skills

**Source:** https://code.claude.com/docs/en/slash-commands (redirects to `/en/skills`)

**Key point:** Custom slash commands and skills are unified. A file at `.claude/commands/deploy.md` and `.claude/skills/deploy/SKILL.md` both create `/deploy` and work identically. Skills are recommended going forward.

### Skill locations (priority order)

| Location | Path | Applies to |
|----------|------|-----------|
| Enterprise | Managed settings | All org users |
| Personal | `~/.claude/skills/<skill-name>/SKILL.md` | All your projects |
| Project | `.claude/skills/<skill-name>/SKILL.md` | This project only |
| Plugin | `<plugin>/skills/<skill-name>/SKILL.md` | Where plugin enabled |

Also: `.claude/commands/<name>.md` still works (same as skill).

### SKILL.md frontmatter reference

```yaml
---
name: my-skill
description: What this skill does and when to use it
argument-hint: "[issue-number]"
disable-model-invocation: true   # prevent Claude from auto-invoking
user-invocable: false            # hide from / menu (Claude can still use)
allowed-tools: Read, Grep, Glob
model: claude-sonnet-4-6
effort: high                     # low/medium/high/max (max = Opus 4.6 only)
context: fork                    # run in isolated subagent
agent: Explore                   # which agent type (Explore, Plan, general-purpose, custom)
hooks:                           # lifecycle hooks scoped to this skill
paths: "src/**/*.ts"             # only activate for matching files
shell: bash                      # or powershell (requires CLAUDE_CODE_USE_POWERSHELL_TOOL=1)
---

Skill instructions here...
```

### String substitutions in skills

| Variable | Description |
|----------|-------------|
| `$ARGUMENTS` | All arguments passed when invoking |
| `$ARGUMENTS[N]` or `$N` | Specific argument by 0-based index |
| `${CLAUDE_SESSION_ID}` | Current session ID |
| `${CLAUDE_SKILL_DIR}` | Directory containing the skill's SKILL.md |

### Dynamic context injection

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

`` !`command` `` syntax executes shell commands before skill content is sent to Claude — output replaces the placeholder.

### Invocation control

| Frontmatter | You can invoke | Claude can invoke | Context loading |
|-------------|----------------|-------------------|-----------------|
| (default) | Yes | Yes | Description always in context |
| `disable-model-invocation: true` | Yes | No | Not in context |
| `user-invocable: false` | No | Yes | Description in context |

### Context budget
- Skill descriptions truncated at 250 chars in listing
- Total budget: 1% of context window, fallback 8,000 chars
- Override: `SLASH_COMMAND_TOOL_CHAR_BUDGET` env var

### Skill permissions

```text
# Deny all skills
Skill

# Allow specific
Skill(commit)
Skill(review-pr *)

# Deny specific
Skill(deploy *)
```

---

## 4. VS Code Extension

**Source:** https://code.claude.com/docs/en/vs-code (also served as `/en/ide-integrations`)

### Requirements
- VS Code 1.98.0 or higher (also works with Cursor)
- Anthropic account (or third-party provider config)

### Installation
- [Install for VS Code](vscode:extension/anthropic.claude-code)
- [Install for Cursor](cursor:extension/anthropic.claude-code)
- Or: Extensions view → search "Claude Code"

### Opening Claude
- **Editor Toolbar**: Spark icon (top-right, requires file open)
- **Activity Bar**: Spark icon in left sidebar → sessions list
- **Status Bar**: "✱ Claude Code" in bottom-right (works without file)
- **Command Palette**: Ctrl+Shift+P → "Claude Code"

### Key features

**Permission modes** (set default in `claudeCode.initialPermissionMode`):
- Normal: Claude asks permission before each action
- Plan: Claude describes plan, waits for approval before changes (opens as markdown doc with inline commenting)
- Auto-accept: Claude makes edits without asking

**File references via @-mentions:**
```text
@auth             # fuzzy matches auth.js, AuthService.ts, etc.
@src/components/  # trailing slash for folders
```

- `Option+K` (Mac) / `Alt+K` (Win/Linux): insert `@file.ts#5-10` for current selection
- Drag files with Shift held to add as attachments
- PDF pages: ask Claude to read specific pages/ranges

**Checkpoints / Rewind** (hover any message):
- Fork conversation from here
- Rewind code to here
- Fork conversation and rewind code

**Multiple conversations:** "Open in New Tab" or "Open in New Window"

**Terminal mode:** `claudeCode.useTerminal: true` or checkbox in settings

**Git worktrees:** `claude --worktree feature-auth`

### VS Code keyboard shortcuts

| Command | Shortcut |
|---------|---------|
| Focus Input (toggle editor ↔ Claude) | Cmd+Esc / Ctrl+Esc |
| Open in New Tab | Cmd+Shift+Esc / Ctrl+Shift+Esc |
| New Conversation | Cmd+N / Ctrl+N (Claude must be focused) |
| Insert @-Mention Reference | Option+K / Alt+K (editor must be focused) |

### URI handler for external tools
```
vscode://anthropic.claude-code/open?prompt=review%20my%20changes
vscode://anthropic.claude-code/open?session=<session-id>
```

### Extension settings

| Setting | Default | Description |
|---------|---------|-------------|
| `selectedModel` | `default` | Model for new conversations |
| `useTerminal` | `false` | Launch in terminal mode |
| `initialPermissionMode` | `default` | Approval prompts: default/plan/acceptEdits/auto/bypassPermissions |
| `preferredLocation` | `panel` | Where Claude opens: sidebar or panel |
| `autosave` | `true` | Auto-save files before Claude reads/writes |
| `useCtrlEnterToSend` | `false` | Use Ctrl+Enter instead of Enter |
| `enableNewConversationShortcut` | `true` | Cmd/Ctrl+N for new conversation |
| `respectGitIgnore` | `true` | Exclude .gitignore patterns |
| `allowDangerouslySkipPermissions` | `false` | Add Auto/Bypass to mode selector |

Schema for autocomplete: `"$schema": "https://json.schemastore.org/claude-code-settings.json"`

### Built-in IDE MCP server
- Extension runs a local MCP server named `ide` on 127.0.0.1:random port
- Auth token written to `~/.claude/ide/` (0600 perms)
- Hidden from `/mcp` — nothing to configure

**Two model-visible tools:**

| Tool | What it does | Writes? |
|------|-------------|---------|
| `mcp__ide__getDiagnostics` | Returns language-server errors/warnings from Problems panel | No |
| `mcp__ide__executeCode` | Runs Python in active Jupyter notebook kernel | Yes (with confirmation) |

Jupyter execution always shows Quick Pick confirmation in VS Code — cannot run silently.

### CLI vs Extension feature parity

| Feature | CLI | VS Code Extension |
|---------|-----|------------------|
| All commands | Yes | Subset (type / to see) |
| MCP server config | Yes | Partial (add via CLI, manage existing via /mcp) |
| Checkpoints | Yes | Yes |
| ! bash shortcut | Yes | No |
| Tab completion | Yes | No |

---

## 5. JetBrains Extension

**Source:** https://code.claude.com/docs/en/jetbrains

### Supported IDEs
IntelliJ IDEA, PyCharm, Android Studio, WebStorm, PhpStorm, GoLand

### Installation
Plugin: https://plugins.jetbrains.com/plugin/27310-claude-code-beta-
Requires IDE restart after install.

### Features
- **Quick launch**: Cmd+Esc (Mac) / Ctrl+Esc (Win/Linux), or Claude Code button in UI
- **Diff viewing**: Code changes shown in IDE diff viewer (not terminal)
- **Selection context**: Current selection/tab auto-shared with Claude Code
- **File references**: Cmd+Option+K (Mac) / Alt+Ctrl+K (Win/Linux) → insert `@File#L1-99`
- **Diagnostic sharing**: Lint/syntax errors automatically shared with Claude

### Usage
- Run `claude` from IDE's integrated terminal — all integration features active
- From external terminals: run `/ide` inside Claude Code to connect

### Plugin configuration
Settings → Tools → Claude Code [Beta]:
- **Claude command**: custom path (e.g., `claude`, `/usr/local/bin/claude`, `npx @anthropic/claude`)
- **WSL command format**: `wsl -d Ubuntu -- bash -lic "claude"`
- **Enable automatic updates**: auto-check/install plugin updates
- **Option+Enter for multi-line** (macOS): Option+Enter inserts newlines in prompts

### Diff tool config
- In Claude Code: `/config` → set diff tool to `auto` for automatic IDE detection

### Special configurations

**Remote Development:** Plugin must be installed in remote host (Settings → Plugin (Host)), not local client.

**WSL:** May need terminal config, networking mode adjustments, firewall settings.

**ESC key fix** (if ESC doesn't interrupt operations):
Settings → Tools → Terminal → uncheck "Move focus to editor with Escape"

### Security note
With auto-edit permissions, Claude can modify IDE configuration files that JetBrains may auto-execute. Use manual approval mode with untrusted prompts.

---

## 6. Documentation Index (all 72 pages)

**Source:** https://code.claude.com/docs/llms.txt

Key pages relevant to this project:

- MCP: https://code.claude.com/docs/en/mcp
- Skills (custom commands): https://code.claude.com/docs/en/skills
- Built-in commands: https://code.claude.com/docs/en/commands
- VS Code: https://code.claude.com/docs/en/vs-code
- JetBrains: https://code.claude.com/docs/en/jetbrains
- Sub-agents: https://code.claude.com/docs/en/sub-agents
- Hooks: https://code.claude.com/docs/en/hooks
- Settings: https://code.claude.com/docs/en/settings
- CLI reference: https://code.claude.com/docs/en/cli-reference
- Permissions: https://code.claude.com/docs/en/permissions
- Memory: https://code.claude.com/docs/en/memory
- Plugins: https://code.claude.com/docs/en/plugins
- Common workflows: https://code.claude.com/docs/en/common-workflows
- GitHub Actions: https://code.claude.com/docs/en/github-actions
- Headless/programmatic: https://code.claude.com/docs/en/headless

---

## Bidirectional Search

- **Searched FOR:** docs.anthropic.com/claude-code/mcp, slash-commands, ide, vscode, jetbrains, commands; code.claude.com/docs redirects; llms.txt index
- **Searched AGAINST:** No dedicated adversarial search required — this is raw documentation extraction, not a claim verification
- **Contradicting evidence found:** N/A — all URLs resolved (one 404 for /en/ide which does not exist; VS Code page is at /en/vs-code and /en/ide-integrations)

---

## Key Notes for This Project

1. **docs.anthropic.com redirects to code.claude.com** — update any bookmarks
2. **Custom commands = Skills** — `.claude/commands/` files still work; `.claude/skills/` is the new standard with more features
3. **MCP on Windows**: `npx` requires `cmd /c` wrapper for stdio servers
4. **VS Code MCP config**: Add via CLI, then manage with `/mcp` in panel (partial support only)
5. **ADAU1452 / DSP work**: No specialized MCP server exists for SigmaStudio — would need custom stdio server
6. **IDE MCP server** (`mcp__ide__getDiagnostics`, `mcp__ide__executeCode`): If using PreToolUse hooks to allowlist MCP tools, these tool names must be included

---

## Sources

1. https://code.claude.com/docs/en/mcp — MCP configuration (full page)
2. https://code.claude.com/docs/en/commands — Built-in commands reference
3. https://code.claude.com/docs/en/slash-commands → redirects to https://code.claude.com/docs/en/skills — Custom skills/commands
4. https://code.claude.com/docs/en/vs-code — VS Code extension
5. https://code.claude.com/docs/en/ide-integrations — VS Code (alternate URL, same content)
6. https://code.claude.com/docs/en/jetbrains — JetBrains IDEs
7. https://code.claude.com/docs/llms.txt — Documentation index (72 pages)
