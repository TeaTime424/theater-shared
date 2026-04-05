# Claude Code Auto Permissions Features — Complete Reference

**Status:** RESEARCH — Reference documentation
**Date:** 2026-03-28
**Source:** Official Anthropic docs at code.claude.com (fetched live)

## Executive Summary

Claude Code has a comprehensive, layered permission system covering settings files, CLI flags, permission modes, hooks, sandboxing, and environment variables. The system is hierarchical (managed > CLI > local > project > user). The `--dangerously-skip-permissions` flag is an alias for `bypassPermissions` mode and is the nuclear option for CI/CD; the newer `auto` mode is a safer alternative that uses a background classifier. `allowedTools` in settings or as a CLI flag is the primary mechanism for pre-approving specific tools without full bypass.

---

## 1. Settings File Structure

### File Locations and Precedence

Precedence order (highest to lowest — a deny at any level cannot be overridden by a lower level):

| Priority | Scope | Location | Shared? |
|----------|-------|----------|---------|
| 1 (highest) | Managed | Server-managed, MDM/registry, or `managed-settings.json` in system dir | Yes — IT enforced |
| 2 | CLI flags | `--allowedTools`, `--permission-mode`, etc. | Session only |
| 3 | Local | `.claude/settings.local.json` | No — gitignored |
| 4 | Project | `.claude/settings.json` | Yes — committed to git |
| 5 (lowest) | User | `~/.claude/settings.json` | No — personal |

**Key rule:** If a tool is denied at ANY level, no other level can allow it. Deny wins always.

### Managed Settings File Locations

- **macOS:** `/Library/Application Support/ClaudeCode/managed-settings.json`
- **Linux/WSL:** `/etc/claude-code/managed-settings.json`
- **Windows:** `C:\Program Files\ClaudeCode\managed-settings.json`
- **Windows MDM:** `HKLM\SOFTWARE\Policies\ClaudeCode` registry key (JSON in `Settings` REG_SZ value)
- **macOS MDM:** `com.anthropic.claudecode` managed preferences domain

Drop-in directory support: `managed-settings.d/*.json` files are merged alphabetically on top of `managed-settings.json`.

### Other Config Files

- `~/.claude.json` — OAuth session, MCP server configs, per-project allowed tool state, preferences (theme, etc.)
- `.mcp.json` — Project-scoped MCP server definitions
- JSON schema for validation/autocomplete: `https://json.schemastore.org/claude-code-settings.json`

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
    ],
    "defaultMode": "acceptEdits"
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1"
  }
}
```

---

## 2. allowedTools — Full Syntax Reference

### Settings File Syntax (permissions object)

```json
{
  "permissions": {
    "allow": ["Bash(npm run *)", "Read", "Edit(/src/**)"],
    "ask":   ["Bash(git push *)"],
    "deny":  ["WebFetch", "Bash(rm -rf *)"]
  }
}
```

Rule evaluation order: **deny → ask → allow**. First match wins.

### CLI Flag Syntax

```bash
# Space-separated, quoted
claude -p "task" --allowedTools "Bash(git log *)" "Bash(git diff *)" "Read"

# Comma-separated (also valid)
claude -p "task" --allowedTools "Bash,Read,Edit"
```

`--disallowedTools` removes tools from the model's context entirely (stronger than deny):

```bash
claude --disallowedTools "WebFetch" "Bash(curl *)"
```

`--tools` restricts which built-in tools are available at all:

```bash
claude --tools "Bash,Edit,Read"   # only these three
claude --tools ""                  # disable all tools
claude --tools "default"           # all tools (explicit default)
```

### Available Tool Names

Built-in tools that appear in permission rules:

| Tool Name | Description |
|-----------|-------------|
| `Bash` | Shell command execution |
| `Read` | File reading (also applies to Grep, Glob internally) |
| `Edit` | File editing — applies to all built-in file-edit tools |
| `Write` | File writing |
| `WebFetch` | HTTP/HTTPS fetch requests |
| `Agent(AgentName)` | Subagent delegation |
| `mcp__<server>` | All tools from an MCP server |
| `mcp__<server>__<tool>` | Specific tool from an MCP server |
| `ExitPlanMode` | Claude's action when exiting plan mode |

**Note:** `Edit` rules apply to ALL built-in file-editing tools. `Read` rules apply to Grep, Glob, and file reads. These only block Claude's built-in tools — Bash subprocesses (e.g., `cat .env`) are not blocked by Read/Edit rules. Use sandboxing for OS-level enforcement.

### Wildcard Pattern Rules

Bash rules support glob `*`:

| Pattern | Matches | Does NOT match |
|---------|---------|----------------|
| `Bash(npm run *)` | `npm run build`, `npm run test --watch` | `npm install` |
| `Bash(ls *)` | `ls -la` | `lsof` (word boundary from space before `*`) |
| `Bash(ls*)` | `ls -la`, `lsof` | (no word boundary) |
| `Bash(* install)` | `npm install`, `pip install` | `npm install -g` |
| `Bash(git * main)` | `git checkout main`, `git merge main` | |

**Critical:** Space before `*` enforces word boundary. `Bash(ls *)` ≠ `Bash(ls*)`.

**Legacy syntax:** `:*` suffix (e.g., `Bash(npm run:*)`) is equivalent but deprecated. Use ` *` instead.

**Shell operators:** Claude Code is shell-operator-aware. `Bash(safe-cmd *)` does NOT grant permission for `safe-cmd && dangerous-cmd`.

**Compound commands:** Approving `git status && npm test` with "don't ask again" saves separate rules for each subcommand (up to 5 rules per compound).

### Read/Edit Path Patterns (gitignore spec)

| Prefix | Meaning | Example |
|--------|---------|---------|
| `//path` | Absolute from filesystem root | `Read(//Users/alice/secrets/**)` |
| `~/path` | Relative to home directory | `Read(~/.zshrc)` |
| `/path` | Relative to PROJECT root | `Edit(/src/**/*.ts)` |
| `path` or `./path` | Relative to current directory | `Read(*.env)` |

**Windows:** Paths normalized to POSIX. `C:\Users\alice` → `/c/Users/alice`. Use `//c/**/.env` for drive-relative, `//**/.env` for all drives.

**Gotcha:** `/Users/alice/file` is NOT absolute — it means `<project_root>/Users/alice/file`. Use `//Users/alice/file` for absolute.

`*` = single directory. `**` = recursive. To allow all file access: use just `Read` or `Edit` without parens.

### WebFetch Domain Filtering

```json
"allow": ["WebFetch(domain:example.com)"]
```

Note: Allowing WebFetch by domain does NOT prevent Bash-based network tools (curl, wget). Combine with Bash deny rules or use sandboxing for full network control.

### MCP Tool Rules

```
mcp__puppeteer                    # all tools from puppeteer server
mcp__puppeteer__*                 # same (wildcard form)
mcp__puppeteer__puppeteer_navigate  # specific tool
```

### Agent (Subagent) Rules

```json
{
  "permissions": {
    "deny": ["Agent(Explore)", "Agent(Plan)"]
  }
}
```

Or via CLI: `--disallowedTools "Agent(Explore)"`

---

## 3. Permission Modes

### All Modes

| Mode | `defaultMode` key | What Claude can do without asking | Best for |
|------|-------------------|-----------------------------------|----------|
| `default` | `"default"` | Read files only | Starting point, sensitive work |
| `acceptEdits` | `"acceptEdits"` | Read + edit files | Iterating on code under review |
| `plan` | `"plan"` | Read files (analyze, propose, no edits) | Codebase exploration, planning |
| `auto` | `"auto"` | All actions via background classifier | Long tasks, reducing interruptions |
| `dontAsk` | `"dontAsk"` | Only pre-approved tools from allow rules | Locked-down CI environments |
| `bypassPermissions` | `"bypassPermissions"` | Everything (no checks) | Isolated containers/VMs only |

### Setting the Default Mode

```json
{
  "permissions": {
    "defaultMode": "acceptEdits"
  }
}
```

### Switching Modes

- **Interactive CLI:** `Shift+Tab` cycles through `default → acceptEdits → plan → auto` (auto requires `--enable-auto-mode` flag and Team plan)
- **At startup:** `claude --permission-mode plan`
- **Non-interactive:** `claude -p "task" --permission-mode acceptEdits`
- **VS Code:** Mode selector at bottom of prompt box

`dontAsk` is never in the `Shift+Tab` cycle. `bypassPermissions` appears in the cycle only if session started with `--permission-mode bypassPermissions`, `--dangerously-skip-permissions`, or `--allow-dangerously-skip-permissions`.

### Plan Mode Details

- Claude reads files, runs shell exploration commands, asks clarifying questions, writes a plan file
- Does NOT edit source code
- Bash commands still require normal permission prompts
- Entry: prefix prompt with `/plan` OR press `Shift+Tab` to cycle into it OR `claude --permission-mode plan`
- Exit: Claude presents plan and offers options (approve + auto, approve + acceptEdits, approve + default review, continue planning)

### Auto Mode Details

- Requires: Team plan (Enterprise/API rolling out), Claude Sonnet 4.6 or Opus 4.6
- Admin must enable in Claude Code admin settings before users can activate
- Background classifier reviews each action before executing
- Classifier runs on Claude Sonnet 4.6 even if main session uses different model
- Classifier costs tokens (extra round-trips for Bash and network ops; read-only and local edits skip it)
- On entering auto mode, blanket rules like `Bash(*)`, `Bash(python*)`, `Bash(node*)` are temporarily dropped (restored on exit); narrow rules like `Bash(npm test)` are preserved

**Blocked by default in auto mode:**
- `curl | bash`, scripts from cloned repos
- Sending sensitive data to external endpoints
- Production deploys and migrations
- Mass deletion on cloud storage
- Granting IAM or repo permissions
- Force push, push directly to main
- Irreversibly destroying pre-session files

**Allowed by default:**
- Local file operations in working directory
- Installing declared dependencies
- Reading `.env` and sending credentials to matching API
- Read-only HTTP requests
- Pushing to branch you started on

**Fallback:** Auto mode pauses and resumes prompting after 3 consecutive blocks OR 20 total blocks in a session (not configurable).

**Configuring the auto mode classifier:**

```json
{
  "autoMode": {
    "environment": [
      "Organization: Acme Corp. Primary use: software development",
      "Source control: github.example.com/acme-corp",
      "Trusted cloud buckets: s3://acme-builds",
      "Trusted internal domains: *.internal.example.com"
    ],
    "allow": [
      "Deploying to staging is allowed: isolated, resets nightly"
    ],
    "soft_deny": [
      "Never run DB migrations outside the migrations CLI"
    ]
  }
}
```

**Warning:** Setting `allow` or `soft_deny` replaces the ENTIRE default list for that section. Run `claude auto-mode defaults` first, copy defaults, then edit.

Auto mode config is read from: user settings, `.claude/settings.local.json`, and managed settings. It is NOT read from shared `.claude/settings.json` (to prevent repo injection).

CLI tools: `claude auto-mode defaults`, `claude auto-mode config`, `claude auto-mode critique`

### dontAsk Mode Details

- Auto-denies every tool not in `permissions.allow` rules
- Explicit `ask` rules are also denied (no prompting — fully non-interactive)
- Use for CI where you pre-define exactly what's allowed

### bypassPermissions Mode

- Skips ALL permission prompts and safety checks
- Exception: writes to `.git`, `.claude`, `.vscode`, `.idea` still prompt (to prevent corruption)
- Exception to the exception: `.claude/commands`, `.claude/agents`, `.claude/skills` do NOT prompt
- Only use in isolated containers/VMs

---

## 4. --dangerously-skip-permissions Flag

### What it does

Equivalent to `--permission-mode bypassPermissions`. All tool calls execute immediately with no verification. Named "dangerously" intentionally.

```bash
# These are identical:
claude --dangerously-skip-permissions
claude --permission-mode bypassPermissions
```

### Related flags

```bash
# Unlock bypass mode in Shift+Tab cycle WITHOUT activating it immediately
# Lets you start in plan mode but have bypass available if needed
claude --permission-mode plan --allow-dangerously-skip-permissions

# Disable the flag organization-wide (managed settings only)
# "disableBypassPermissionsMode": "disable"
```

### CI/CD Usage Pattern

```bash
# Standard CI pattern
claude -p "refactor the auth module" \
  --dangerously-skip-permissions \
  --output-format stream-json

# Better CI pattern (more surgical — use dontAsk + explicit allowedTools)
claude -p "run tests and fix failures" \
  --permission-mode dontAsk \
  --allowedTools "Bash(npm test *)" "Bash(npm run *)" "Read" "Edit" \
  --output-format json

# Bare mode for clean CI (no local hooks/plugins/MCP interference)
claude --bare -p "task" \
  --allowedTools "Read,Edit,Bash" \
  --output-format json
```

### Security Requirements Before Using bypassPermissions

- Run in a locked-down container or VM
- Preferably offline or network-restricted
- Never on a host system with access to sensitive data
- Consider `auto` mode as a safer alternative for most cases

### Known Issues

- `--allowedTools` may be ignored when combined with `--permission-mode bypassPermissions` [GitHub issue #12232 — reported behavior, check current status]
- `--dangerously-skip-permissions` does NOT bypass prompts for `~/.claude/` config file writes [GitHub issue #35718]

---

## 5. Hooks

Hooks are shell commands (or HTTP calls, prompt calls, agent calls) that execute at lifecycle events. They interact with permissions via `PreToolUse` and `PermissionRequest` events.

### Hook Event Reference

| Event | When it fires | Permission relevance |
|-------|---------------|---------------------|
| `PreToolUse` | Before tool executes | Can allow, deny, or ask |
| `PermissionRequest` | When permission dialog would appear | Can auto-approve or set permission mode |
| `PostToolUse` | After tool succeeds | Cannot undo; use for formatting, logging |
| `SessionStart` | Session begins/resumes | Inject context |
| `UserPromptSubmit` | Prompt submitted, before Claude processes | Inject context |
| `Stop` | Claude finishes responding | Continue work if tasks remain |
| `Notification` | Claude needs input | Desktop notifications |
| `SubagentStart/Stop` | Subagent spawns/finishes | Monitor subagent activity |
| `ConfigChange` | Config file changes mid-session | Audit logging |
| `CwdChanged` | Working directory changes | Reload env vars (direnv) |
| `FileChanged` | Watched file changes on disk | Reactive env management |
| `PreCompact/PostCompact` | Context compaction | Re-inject context |
| `WorktreeCreate/Remove` | Worktree lifecycle | Custom worktree behavior |

### Hook Location (scope)

| File | Scope |
|------|-------|
| `~/.claude/settings.json` | All projects, not shared |
| `.claude/settings.json` | Project, committed to git |
| `.claude/settings.local.json` | Project, gitignored |
| Managed policy settings | Organization-wide |

### Hook Types

| Type | Description |
|------|-------------|
| `"command"` | Shell command. stdin=JSON input, stdout=JSON output or text, exit code controls behavior |
| `"http"` | POST event JSON to an HTTP endpoint |
| `"prompt"` | Single-turn LLM evaluation (Haiku by default) returning `{"ok": true/false, "reason": "..."}` |
| `"agent"` | Multi-turn verification with tool access; up to 50 tool turns, 60s default timeout |

### PreToolUse Hook — Permission Control

Exit codes:
- `exit 0` → proceed (no change to permission decision)
- `exit 2` → block the action; stderr becomes Claude's feedback
- Other non-zero → proceed; stderr logged but not shown to Claude

Structured JSON output (exit 0 + JSON on stdout):

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Use rg instead of grep"
  }
}
```

`permissionDecision` options: `"allow"` (skip interactive prompt), `"deny"` (cancel + reason), `"ask"` (show prompt normally).

**Important:** Hook `"allow"` skips the interactive prompt but does NOT override deny rules from settings files. Managed settings deny rules always win.

**Important:** Hook `exit 2` (block) takes precedence even over allow rules in settings files.

### PermissionRequest Hook — Auto-Approve Pattern

```json
{
  "hooks": {
    "PermissionRequest": [
      {
        "matcher": "ExitPlanMode",
        "hooks": [
          {
            "type": "command",
            "command": "echo '{\"hookSpecificOutput\": {\"hookEventName\": \"PermissionRequest\", \"decision\": {\"behavior\": \"allow\"}}}'"
          }
        ]
      }
    ]
  }
}
```

Can also set permission mode from hook output:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow",
      "updatedPermissions": [
        { "type": "setMode", "mode": "acceptEdits", "destination": "session" }
      ]
    }
  }
}
```

**Note:** `PermissionRequest` hooks do NOT fire in non-interactive (`-p`) mode. Use `PreToolUse` hooks for automated permission decisions in CI.

### Matcher Syntax

Matchers are regex patterns on the event-specific field:

```json
{
  "matcher": "Edit|Write",       // OR of tool names
  "matcher": "mcp__github__.*",  // regex for all github MCP tools
  "matcher": "Bash"              // exact tool name
}
```

Fine-grained `if` field (requires v2.1.85+) for argument-level filtering:

```json
{
  "matcher": "Bash",
  "hooks": [
    {
      "type": "command",
      "if": "Bash(git *)",
      "command": "./.claude/hooks/check-git-policy.sh"
    }
  ]
}
```

`if` uses full permission rule syntax. Only works on tool events (`PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PermissionRequest`).

### Disable All Hooks

```json
{ "disableAllHooks": true }
```

Or managed-settings-only: `"allowManagedHooksOnly": true` (prevents user/project hooks from loading).

### HTTP Hook Security

```json
{
  "allowedHttpHookUrls": ["https://hooks.example.com/*"],
  "httpHookAllowedEnvVars": ["MY_TOKEN", "HOOK_SECRET"]
}
```

---

## 6. Managed-Only Settings

These settings are only effective in `managed-settings.json` and cannot be set by users:

| Setting | Effect |
|---------|--------|
| `allowManagedPermissionRulesOnly` | Prevents user/project settings from defining allow/ask/deny rules |
| `allowManagedHooksOnly` | Prevents user/project/plugin hooks; only managed and SDK hooks run |
| `allowManagedMcpServersOnly` | Only managed `allowedMcpServers` list is respected |
| `permissions.disableBypassPermissionsMode: "disable"` | Blocks `bypassPermissions` mode and `--dangerously-skip-permissions` |
| `disableAutoMode: "disable"` | Blocks `auto` mode, removes it from Shift+Tab cycle |
| `sandbox.network.allowManagedDomainsOnly` | Only managed `allowedDomains` respected for network |
| `sandbox.filesystem.allowManagedReadPathsOnly` | Only managed `allowRead` paths respected |

---

## 7. CLI Flags — Permission-Related Complete List

| Flag | Description |
|------|-------------|
| `--allowedTools` | Pre-approve tools; accepts permission rule syntax |
| `--disallowedTools` | Remove tools from model context entirely |
| `--tools` | Restrict available built-in tools (`"Bash,Edit,Read"`, `""` for none, `"default"` for all) |
| `--permission-mode` | Start in specified mode: `default`, `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions` |
| `--dangerously-skip-permissions` | Alias for `--permission-mode bypassPermissions` |
| `--allow-dangerously-skip-permissions` | Add bypass mode to Shift+Tab cycle WITHOUT activating it |
| `--enable-auto-mode` | Unlock auto mode in Shift+Tab cycle (requires Team plan + Sonnet 4.6/Opus 4.6) |
| `--add-dir` | Add additional directories Claude can access |
| `--setting-sources` | Comma-separated sources to load: `user`, `project`, `local` |
| `--settings` | Path to settings JSON file or inline JSON string |
| `--permission-prompt-tool` | MCP tool to handle permission prompts in non-interactive mode |
| `--bare` | Skip auto-discovery of hooks, skills, plugins, MCP, CLAUDE.md (fast CI mode) |

### --permission-prompt-tool (Non-Interactive Permission Handling)

```bash
claude -p "task" --permission-prompt-tool mcp_auth_tool "query"
```

Allows an MCP tool to answer permission prompts programmatically in `-p` mode. This is the non-interactive alternative to `--dangerously-skip-permissions` when you want controlled (not blanket) approval.

---

## 8. Environment Variables (Permission-Relevant)

Set in shell before launching `claude`, or in `settings.json` under the `env` key:

| Variable | Purpose |
|----------|---------|
| `ANTHROPIC_API_KEY` | API key for Claude API access |
| `ANTHROPIC_AUTH_TOKEN` | Alternative auth token |
| `ANTHROPIC_BASE_URL` | Override API base URL (for proxies) |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` | Disables auto-updater, bug reporting, error reporting, telemetry |
| `CLAUDE_ENV_FILE` | Shell script sourced before each Bash tool invocation (for env var injection) |
| `CLAUDE_CODE_SIMPLE` | Set automatically by `--bare` flag |
| `BASH_DEFAULT_TIMEOUT_MS` | Default timeout for Bash commands |
| `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS` | Timeout for session-end hooks |
| `API_TIMEOUT_MS` | API request timeout |
| `CLAUDE_CODE_DEBUG_LOG_LEVEL` | Debug verbosity: `verbose`, `debug`, `info`, `warn`, `error` |
| `CLAUDE_CODE_DISABLE_1M_CONTEXT` | Disable 1M context window |
| `CLAUDE_CODE_IDE_SKIP_AUTO_INSTALL` | Skip auto-install of IDE extension |
| `CLAUDE_CODE_USE_POWERSHELL_TOOL` | Required when `defaultShell: "powershell"` is set |
| `DISABLE_TELEMETRY` | Disable usage telemetry |
| `DISABLE_ERROR_REPORTING` | Disable error reporting |
| `CLAUDE_CODE_ENABLE_TELEMETRY` | Enable OpenTelemetry export |
| `OTEL_METRICS_EXPORTER` | OpenTelemetry metrics exporter type |

**No `CLAUDE_SKIP_PERMISSIONS` variable exists** — permission bypass is CLI-flag and settings-only. The `CLAUDE_ENV_FILE` variable is the hook-adjacent env mechanism (writes env vars that apply before each Bash call).

---

## 9. Sandboxing (OS-Level Enforcement)

Sandboxing complements permissions — it provides OS-level isolation for Bash commands, preventing shell subprocesses from accessing restricted paths/network even if permission rules are bypassed:

```json
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "filesystem": {
      "allowWrite": ["/tmp/build", "~/.kube"],
      "denyWrite": ["/etc", "/usr/local/bin"],
      "denyRead": ["~/.aws/credentials"]
    },
    "network": {
      "allowedDomains": ["github.com", "*.npmjs.org"],
      "allowLocalBinding": false
    }
  }
}
```

Available on macOS, Linux, WSL2. Not on Windows native.

---

## 10. Working Directories

By default, Claude has access to the directory where it was launched.

```bash
# At startup
claude --add-dir ../apps ../lib

# During session
/add-dir ../docs
```

Persistent:
```json
{
  "permissions": {
    "additionalDirectories": ["../docs/", "../shared/"]
  }
}
```

---

## 11. /permissions UI Command

Running `/permissions` in interactive mode opens a UI listing:
- All permission rules currently active
- Which settings file each rule is sourced from
- Ability to add/remove rules

Running `/hooks` opens the hooks browser (read-only — edit settings JSON to change hooks).

---

## Bidirectional Search

- **Searched FOR:** "claude code allowedTools settings.json", "claude code permissions configuration", "claude code --dangerously-skip-permissions documentation", "claude code permission modes auto acceptEdits plan", "claude code CLI flags allowedTools disallowedTools", "claude code hooks PreToolUse PermissionRequest", "claude code environment variables permissions CI mode"
- **Searched AGAINST:** "claude code allowedTools not working", "allowedTools ignored bypassPermissions bug", "claude code permission bypass security vulnerabilities", "claude dangerously-skip-permissions does not skip", "auto mode classifier false positives"
- **Contradicting evidence found:** Yes — two documented bugs: (1) `--allowedTools` may be ignored when combined with `bypassPermissions` mode [GitHub #12232]; (2) `--dangerously-skip-permissions` does NOT bypass prompts for `~/.claude/` config file writes [GitHub #35718]. Auto mode is a research preview — "reduces prompts but does not guarantee safety."

---

## Recommendations

**For this project's agent dispatch system:**

1. **Settings for agent tasks:** Use `.claude/settings.local.json` with `defaultMode: "acceptEdits"` plus specific `allow` rules for tools agents routinely need (Read, Write, Bash for git/python scripts). This avoids per-session flag noise.

2. **CI/headless agents:** Use `--bare --permission-mode dontAsk --allowedTools "Read,Write,Bash(python *),Bash(git *)"` rather than `--dangerously-skip-permissions`. More surgical, same no-interruption behavior.

3. **Avoid blanket bypass:** `--dangerously-skip-permissions` is appropriate only for throwaway containers. For the theater project's local agents, `dontAsk` + scoped `allowedTools` is the right pattern.

4. **Hook for Stop validation:** Current `Stop` hook in `.claude/settings.local.json` is correct pattern. The `stop_hook_active` field check prevents infinite loops.

5. **auto mode:** Not currently available without Team plan + Sonnet 4.6/Opus 4.6 requirement. Not applicable to local Claude Code sessions running on API keys without a Team plan.

---

## Sources

1. [Configure permissions — Claude Code Docs](https://code.claude.com/docs/en/permissions)
2. [Choose a permission mode — Claude Code Docs](https://code.claude.com/docs/en/permission-modes)
3. [Claude Code settings — Claude Code Docs](https://code.claude.com/docs/en/settings)
4. [Automate workflows with hooks — Claude Code Docs](https://code.claude.com/docs/en/hooks-guide)
5. [Run Claude Code programmatically — Claude Code Docs](https://code.claude.com/docs/en/headless)
6. [CLI reference — Claude Code Docs](https://code.claude.com/docs/en/cli-reference)
7. [Environment variables — Claude Code Docs](https://code.claude.com/docs/en/env-vars)
8. [GitHub issue #12232 — --allowedTools with --permission-mode bypassPermissions](https://github.com/anthropics/claude-code/issues/12232)
9. [GitHub issue #35718 — --dangerously-skip-permissions does not bypass ~/.claude/ writes](https://github.com/anthropics/claude-code/issues/35718)
10. [Claude Code auto mode announcement — Anthropic Engineering](https://www.anthropic.com/engineering/claude-code-auto-mode)
11. [Claude Code --dangerously-skip-permissions guide — ksred.com](https://www.ksred.com/claude-code-dangerously-skip-permissions-when-to-use-it-and-when-you-absolutely-shouldnt/)
12. [Claude Code permissions complete guide — eesel.ai](https://www.eesel.ai/blog/claude-code-permissions)
