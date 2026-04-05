# Claude Code: Hooks, Permissions, and Security — Raw Documentation

**Status:** RESEARCH — Reference only
**Date:** 2026-03-28
**Sources:** code.claude.com/docs (redirected from docs.anthropic.com/en/docs/claude-code)

---

## Executive Summary

Claude Code docs have migrated from docs.anthropic.com to code.claude.com. All four target URLs (hooks, permissions, security, settings) redirect 301 to code.claude.com equivalents. Full content captured below from five pages: hooks reference, hooks guide, permissions, security, and settings.

---

## Bidirectional Search

- **Searched FOR:** docs.anthropic.com hooks, permissions, security, settings — official Anthropic Claude Code documentation
- **Searched AGAINST:** N/A — this is a raw documentation capture, not a claim verification task
- **Contradicting evidence found:** No — content is from primary Anthropic sources; no contradictions applicable

---

## Source URLs

| Page | Original URL | Redirected URL |
|------|-------------|----------------|
| Hooks Reference | https://docs.anthropic.com/en/docs/claude-code/hooks | https://code.claude.com/docs/en/hooks |
| Permissions | https://docs.anthropic.com/en/docs/claude-code/permissions | https://code.claude.com/docs/en/permissions |
| Security | https://docs.anthropic.com/en/docs/claude-code/security | https://code.claude.com/docs/en/security |
| Settings | https://docs.anthropic.com/en/docs/claude-code/settings | https://code.claude.com/docs/en/settings |
| Permission Modes | (additional) | https://code.claude.com/docs/en/permission-modes |
| Hooks Guide | (additional) | https://code.claude.com/docs/en/hooks-guide |

---

# PAGE 1: Hooks Reference
**URL:** https://code.claude.com/docs/en/hooks

## Overview

Hooks are user-defined shell commands, HTTP endpoints, LLM prompts, or agents that execute automatically at specific points in Claude Code's lifecycle. This reference covers event schemas, configuration options, JSON input/output formats, exit codes, async hooks, HTTP hooks, prompt hooks, and MCP tool hooks.

## Hook Lifecycle

Hooks fire at specific points during a Claude Code session. When an event fires and a matcher matches, Claude Code passes JSON context to your hook handler. Some events fire once per session, others fire repeatedly in the agentic loop.

**Key events in order:**
- `SessionStart` → `UserPromptSubmit` → `PreToolUse` → `PermissionRequest` → `PostToolUse`/`PostToolUseFailure` → `Stop`/`StopFailure` → `SessionEnd`

Async events: `WorktreeCreate`, `WorktreeRemove`, `Notification`, `ConfigChange`, `InstructionsLoaded`, `CwdChanged`, `FileChanged`

## Configuration

### Hook Locations & Scope

| Location | Scope | Shareable |
|----------|-------|-----------|
| `~/.claude/settings.json` | All projects | No |
| `.claude/settings.json` | Single project | Yes |
| `.claude/settings.local.json` | Single project | No |
| Managed policy settings | Organization-wide | Yes |
| Plugin `hooks/hooks.json` | When enabled | Yes |
| Skill/agent frontmatter | While active | Yes |

### Configuration Hierarchy

```json
{
  "hooks": {
    "EVENT_NAME": [
      {
        "matcher": "regex_pattern",
        "hooks": [
          {
            "type": "command|http|prompt|agent",
            "if": "Tool(pattern)",
            "timeout": 600,
            "statusMessage": "Custom message"
          }
        ]
      }
    ]
  }
}
```

### Matcher Patterns

The `matcher` field filters when hooks fire (regex string):

| Event | Matches on | Example |
|-------|-----------|---------|
| `PreToolUse`, `PostToolUse`, etc. | tool name | `Bash`, `Edit\|Write`, `mcp__.*` |
| `SessionStart` | session type | `startup`, `resume`, `clear`, `compact` |
| `Notification` | notification type | `permission_prompt`, `idle_prompt` |
| `SubagentStart`/`SubagentStop` | agent type | `Bash`, `Explore`, custom names |
| `FileChanged` | filename (basename) | `.envrc`, `.env`, any filename |
| `ConfigChange` | config source | `user_settings`, `project_settings`, `policy_settings` |

Use `"*"`, `""`, or omit to match all occurrences.

### Hook Handler Types

#### Common Fields (All Types)

```json
{
  "type": "command|http|prompt|agent",
  "if": "Bash(git *)",
  "timeout": 600,
  "statusMessage": "Running validation...",
  "once": false
}
```

#### Command Hooks

```json
{
  "type": "command",
  "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/script.sh",
  "async": false,
  "shell": "bash"
}
```

**Environment variables:**
- `$CLAUDE_PROJECT_DIR` - project root
- `${CLAUDE_PLUGIN_ROOT}` - plugin directory
- `${CLAUDE_PLUGIN_DATA}` - plugin persistent data
- `$CLAUDE_ENV_FILE` - for SessionStart/CwdChanged/FileChanged to persist environment variables

#### HTTP Hooks

```json
{
  "type": "http",
  "url": "http://localhost:8080/hooks/pre-tool-use",
  "timeout": 30,
  "headers": {
    "Authorization": "Bearer $MY_TOKEN"
  },
  "allowedEnvVars": ["MY_TOKEN"]
}
```

#### Prompt & Agent Hooks

```json
{
  "type": "prompt|agent",
  "prompt": "Should this action be allowed? $ARGUMENTS",
  "model": "fast-model"
}
```

## Hook Input and Output

### Common Input Fields

All hooks receive:

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/working/dir",
  "permission_mode": "default|plan|acceptEdits|auto|dontAsk|bypassPermissions",
  "hook_event_name": "EventName"
}
```

Subagent hooks also include:
```json
{
  "agent_id": "unique-id",
  "agent_type": "AgentName"
}
```

### Exit Codes

- **Exit 0**: Success. JSON output parsed from stdout only on exit 0
- **Exit 2**: Blocking error. stderr fed back to Claude, action blocked
- **Other**: Non-blocking error. stderr shown in verbose mode

#### Exit Code 2 Per Event

| Event | Behavior |
|-------|----------|
| `PreToolUse`, `PermissionRequest`, `UserPromptSubmit` | Blocks action |
| `Stop`, `SubagentStop`, `TeammateIdle`, `TaskCreated`, `TaskCompleted` | Prevents action |
| `ConfigChange`, `Elicitation`, `ElicitationResult` | Blocks change/response |
| `PostToolUse`, `PostToolUseFailure`, `Notification`, etc. | Shows stderr only |

### JSON Output

Exit 0 with JSON output for structured control:

```json
{
  "continue": true,
  "stopReason": "Optional stop message",
  "suppressOutput": false,
  "systemMessage": "Optional warning",
  "decision": "block",
  "reason": "Why blocked",
  "hookSpecificOutput": {
    "hookEventName": "EventName",
    "additionalContext": "Extra context for Claude"
  }
}
```

## Hook Events Reference

### SessionStart
**When:** New session, resume, clear, or after compaction
**Matcher values:** `startup`, `resume`, `clear`, `compact`
**Type support:** Command only

**Input:**
```json
{
  "source": "startup|resume|clear|compact",
  "model": "claude-sonnet-4-6"
}
```

**Output options:**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "Extra context"
  }
}
```

**Persist environment variables via $CLAUDE_ENV_FILE:**
```bash
#!/bin/bash
if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo 'export NODE_ENV=production' >> "$CLAUDE_ENV_FILE"
fi
exit 0
```

### InstructionsLoaded
**When:** CLAUDE.md or `.claude/rules/*.md` file loaded
**Matcher:** `load_reason` - `session_start`, `nested_traversal`, `path_glob_match`, `include`, `compact`
**Decision control:** None (observability only)

**Input:**
```json
{
  "file_path": "/path/to/file.md",
  "memory_type": "User|Project|Local|Managed",
  "load_reason": "session_start",
  "globs": ["path/patterns"],
  "trigger_file_path": "/path/that/triggered/load",
  "parent_file_path": "/parent/instruction/file"
}
```

### UserPromptSubmit
**When:** User submits prompt before Claude processes it
**Matcher:** None (always fires)
**Decision control:** Can block, add context

**Input:**
```json
{
  "prompt": "User's prompt text"
}
```

**Output options:**
```json
{
  "decision": "block",
  "reason": "Why blocked",
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "Added context"
  }
}
```

Or simply print text to stdout for context.

### PreToolUse
**When:** Before tool execution
**Matcher:** Tool name - `Bash`, `Edit`, `Write`, `Read`, `Glob`, `Grep`, `Agent`, `WebFetch`, `WebSearch`, `AskUserQuestion`, `mcp__*`
**Decision control:** Allow/deny/ask, modify input, add context

**Input:**
```json
{
  "tool_name": "Bash|Edit|Write|Read|...",
  "tool_input": {
    "command": "...",
    "file_path": "...",
    // tool-specific fields
  },
  "tool_use_id": "toolu_..."
}
```

**Bash tool input:**
```json
{
  "command": "npm test",
  "description": "optional description",
  "timeout": 120000,
  "run_in_background": false
}
```

**Write tool input:**
```json
{
  "file_path": "/path/to/file.txt",
  "content": "file content"
}
```

**Edit tool input:**
```json
{
  "file_path": "/path/to/file.txt",
  "old_string": "original",
  "new_string": "replacement",
  "replace_all": false
}
```

**Output options:**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow|deny|ask",
    "permissionDecisionReason": "Reason shown to user",
    "updatedInput": {
      "command": "modified command"
    },
    "additionalContext": "Context for Claude"
  }
}
```

### PermissionRequest
**When:** Permission dialog about to show
**Matcher:** Tool name
**Decision control:** Allow/deny with optional input modification and permission rules

**Input:**
```json
{
  "tool_name": "Bash",
  "tool_input": { "command": "..." },
  "permission_suggestions": [
    {
      "type": "addRules",
      "rules": [{"toolName": "Bash", "ruleContent": "pattern"}],
      "behavior": "allow|deny|ask",
      "destination": "localSettings|projectSettings|userSettings|session"
    }
  ]
}
```

**Output options:**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow|deny",
      "updatedInput": { "command": "..." },
      "updatedPermissions": [
        {
          "type": "addRules|replaceRules|removeRules|setMode|addDirectories|removeDirectories",
          "rules": [],
          "mode": "default|acceptEdits|dontAsk|bypassPermissions|plan",
          "directories": [],
          "destination": "localSettings|projectSettings|userSettings|session"
        }
      ],
      "message": "Why denied (deny only)"
    }
  }
}
```

### PostToolUse
**When:** After tool executes successfully
**Matcher:** Tool name
**Decision control:** Block (provide feedback), add context, modify MCP output

**Input:**
```json
{
  "tool_name": "Write",
  "tool_input": { "file_path": "...", "content": "..." },
  "tool_response": { "filePath": "...", "success": true },
  "tool_use_id": "toolu_..."
}
```

**Output:**
```json
{
  "decision": "block",
  "reason": "Why blocked",
  "hookSpecificOutput": {
    "hookEventName": "PostToolUse",
    "additionalContext": "Context for Claude",
    "updatedMCPToolOutput": "Replacement output (MCP tools only)"
  }
}
```

### PostToolUseFailure
**When:** Tool execution fails
**Matcher:** Tool name
**Decision control:** Add context only

**Input:**
```json
{
  "tool_name": "Bash",
  "tool_input": { "command": "..." },
  "tool_use_id": "toolu_...",
  "error": "Error message",
  "is_interrupt": false
}
```

**Output:**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "PostToolUseFailure",
    "additionalContext": "Context about failure"
  }
}
```

### Notification
**When:** Claude Code sends notifications
**Matcher:** `permission_prompt`, `idle_prompt`, `auth_success`, `elicitation_dialog`
**Decision control:** None

**Input:**
```json
{
  "message": "Notification text",
  "title": "Optional title",
  "notification_type": "permission_prompt"
}
```

### SubagentStart
**When:** Subagent spawned via Agent tool
**Matcher:** Agent type - `Bash`, `Explore`, `Plan`, custom names
**Decision control:** Add context only

**Input:**
```json
{
  "agent_id": "agent-abc123",
  "agent_type": "Explore"
}
```

**Output:**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "SubagentStart",
    "additionalContext": "Context for subagent"
  }
}
```

### SubagentStop
**When:** Subagent finishes responding
**Matcher:** Agent type
**Decision control:** Block subagent from stopping, continue it

**Input:**
```json
{
  "stop_hook_active": false,
  "agent_id": "agent-def456",
  "agent_type": "Explore",
  "agent_transcript_path": "...subagents/agent-def456.jsonl",
  "last_assistant_message": "Final response text"
}
```

**Output:**
```json
{
  "decision": "block",
  "reason": "Why continue"
}
```

### TaskCreated
**When:** Task created via TaskCreate tool
**Matcher:** None (always fires)
**Decision control:** Block with feedback or stop teammate

**Input:**
```json
{
  "task_id": "task-001",
  "task_subject": "Task title",
  "task_description": "Optional description",
  "teammate_name": "teammate",
  "team_name": "team"
}
```

**Output:**
- Exit 2: Block with stderr feedback
- `{"continue": false, "stopReason": "..."}`: Stop teammate entirely

### TaskCompleted
**When:** Task marked as completed
**Matcher:** None (always fires)
**Decision control:** Block with feedback or stop teammate

**Input:**
```json
{
  "task_id": "task-001",
  "task_subject": "Task title",
  "task_description": "Optional description",
  "teammate_name": "teammate",
  "team_name": "team"
}
```

**Output:** Same as TaskCreated

### Stop
**When:** Main Claude agent finishes responding
**Matcher:** None (always fires)
**Decision control:** Block, preventing Claude from stopping

**Input:**
```json
{
  "stop_hook_active": true,
  "last_assistant_message": "Claude's final response"
}
```

**Output:**
```json
{
  "decision": "block",
  "reason": "Why continue"
}
```

### StopFailure
**When:** Turn ends due to API error
**Matcher:** Error type - `rate_limit`, `authentication_failed`, `billing_error`, `invalid_request`, `server_error`, `max_output_tokens`, `unknown`
**Decision control:** None (logging/notification only)

**Input:**
```json
{
  "error": "rate_limit",
  "error_details": "429 Too Many Requests",
  "last_assistant_message": "API Error: Rate limit reached"
}
```

### TeammateIdle
**When:** Agent team teammate about to go idle
**Matcher:** None (always fires)
**Decision control:** Block with feedback or stop teammate

**Input:**
```json
{
  "teammate_name": "researcher",
  "team_name": "my-project"
}
```

**Output:** Same as TaskCreated (exit 2 or `continue: false`)

### ConfigChange
**When:** Configuration file changes during session
**Matcher:** `user_settings`, `project_settings`, `local_settings`, `policy_settings`, `skills`
**Decision control:** Block configuration change

**Input:**
```json
{
  "source": "project_settings",
  "file_path": "/path/to/.claude/settings.json"
}
```

**Output:**
```json
{
  "decision": "block",
  "reason": "Why blocked"
}
```

### CwdChanged
**When:** Working directory changes
**Matcher:** None (always fires)
**Decision control:** None

Uses `$CLAUDE_ENV_FILE` for environment variable persistence.

### FileChanged
**When:** Watched file changes on disk
**Matcher:** Filename (basename)
**Decision control:** None

**Input:**
```json
{
  "file_path": "/path/to/changed/file",
  "change_type": "modified|created|deleted"
}
```

Uses `$CLAUDE_ENV_FILE` for environment variable persistence.

### WorktreeCreate
**When:** Worktree being created via `--worktree` or `isolation: "worktree"`
**Matcher:** None (always fires)
**Decision control:** Return path or fail creation

**Output (command hook):**
- Print worktree path to stdout on exit 0
- Exit non-zero to fail creation

**Output (HTTP hook):**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "WorktreeCreate",
    "worktreePath": "/path/to/worktree"
  }
}
```

### WorktreeRemove
**When:** Worktree being removed at session exit
**Matcher:** None (always fires)
**Decision control:** None (failures logged only)

### PreCompact
**When:** Before context compaction
**Matcher:** `manual`, `auto`
**Decision control:** None

### PostCompact
**When:** After context compaction completes
**Matcher:** `manual`, `auto`
**Decision control:** None

### Elicitation
**When:** MCP server requests user input during tool call
**Matcher:** MCP server name
**Decision control:** Accept/decline/cancel, provide values

**Output:**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "Elicitation",
    "action": "accept|decline|cancel",
    "content": {
      "field_name": "field_value"
    }
  }
}
```

### ElicitationResult
**When:** User responds to MCP elicitation before sending to server
**Matcher:** MCP server name
**Decision control:** Accept/decline/cancel, override values

**Output:** Same as Elicitation

### SessionEnd
**When:** Session terminates
**Matcher:** `clear`, `resume`, `logout`, `prompt_input_exit`, `bypass_permissions_disabled`, `other`
**Decision control:** None

## Practical Example: Block Destructive Commands

```bash
#!/bin/bash
# .claude/hooks/block-rm.sh

COMMAND=$(jq -r '.tool_input.command' < /dev/stdin)

if echo "$COMMAND" | grep -q 'rm -rf'; then
  jq -n '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "Destructive command blocked by hook"
    }
  }'
else
  exit 0  # allow the command
fi
```

**Configuration:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "if": "Bash(rm *)",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-rm.sh"
          }
        ]
      }
    ]
  }
}
```

## Advanced Features

### Run Hooks in Background

```json
{
  "type": "command",
  "command": "/path/to/script.sh",
  "async": true
}
```

### Disable All Hooks

```json
{
  "disableAllHooks": true
}
```

### View Configured Hooks

Type `/hooks` in Claude Code for read-only menu of all configured hooks.

---

# PAGE 2: Permissions
**URL:** https://code.claude.com/docs/en/permissions

## Permission System

Claude Code uses a tiered permission system to balance power and safety:

| Tool type | Example | Approval required | "Yes, don't ask again" behavior |
|:----------|:--------|:------------------|:---------------------------------|
| Read-only | File reads, Grep | No | N/A |
| Bash commands | Shell execution | Yes | Permanently per project directory and command |
| File modification | Edit/write files | Yes | Until session end |

## Manage Permissions

View and manage permissions with `/permissions`. This UI lists all permission rules and the settings.json file they are sourced from.

- **Allow** rules: let Claude Code use the specified tool without manual approval
- **Ask** rules: prompt for confirmation whenever Claude Code tries to use the specified tool
- **Deny** rules: prevent Claude Code from using the specified tool

Rules are evaluated in order: **deny -> ask -> allow**. The first matching rule wins, so deny rules always take precedence.

## Permission Modes

Set the `defaultMode` in your settings files:

| Mode | Description |
|:-----|:------------|
| `default` | Standard behavior: prompts for permission on first use of each tool |
| `acceptEdits` | Automatically accepts file edit permissions for the session |
| `plan` | Plan Mode: Claude can analyze but not modify files or execute commands |
| `auto` | Auto-approves tool calls with background safety checks that verify actions align with your request. Currently a research preview |
| `dontAsk` | Auto-denies tools unless pre-approved via `/permissions` or `permissions.allow` rules |
| `bypassPermissions` | Skips permission prompts except for writes to protected directories |

**WARNING:** `bypassPermissions` mode skips permission prompts. Writes to `.git`, `.claude`, `.vscode`, and `.idea` directories still prompt for confirmation. Writes to `.claude/commands`, `.claude/agents`, and `.claude/skills` are exempt. Only use in isolated environments like containers or VMs.

To prevent `bypassPermissions` or `auto` mode: set `permissions.disableBypassPermissionsMode` or `disableAutoMode` to `"disable"` in any settings file.

## Permission Rule Syntax

Permission rules follow the format `Tool` or `Tool(specifier)`.

### Match all uses of a tool

| Rule | Effect |
|:-----|:-------|
| `Bash` | Matches all Bash commands |
| `WebFetch` | Matches all web fetch requests |
| `Read` | Matches all file reads |

`Bash(*)` is equivalent to `Bash` and matches all Bash commands.

### Use specifiers for fine-grained control

| Rule | Effect |
|:-----|:-------|
| `Bash(npm run build)` | Matches the exact command `npm run build` |
| `Read(./.env)` | Matches reading the `.env` file in the current directory |
| `WebFetch(domain:example.com)` | Matches fetch requests to example.com |

### Wildcard patterns

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(git commit *)",
      "Bash(git * main)",
      "Bash(* --version)",
      "Bash(* --help *)"
    ],
    "deny": [
      "Bash(git push *)"
    ]
  }
}
```

The space before `*` matters: `Bash(ls *)` matches `ls -la` but not `lsof`, while `Bash(ls*)` matches both. The legacy `:*` suffix syntax is equivalent to ` *` but is deprecated.

### Tool-Specific Permission Rules

**Bash:** Wildcards at any position. Claude Code is aware of shell operators (`&&`) so `Bash(safe-cmd *)` won't authorize `safe-cmd && other-cmd`. When approving a compound command with "Yes, don't ask again", separate rules saved for each subcommand (up to 5 rules).

**Read and Edit:** Follow gitignore specification:

| Pattern | Meaning | Example |
|---------|---------|---------|
| `//path` | Absolute path from filesystem root | `Read(//Users/alice/secrets/**)` |
| `~/path` | Path from home directory | `Read(~/Documents/*.pdf)` |
| `/path` | Path relative to project root | `Edit(/src/**/*.ts)` |
| `path` or `./path` | Path relative to current directory | `Read(*.env)` |

On Windows, paths normalized to POSIX: `C:\Users\alice` becomes `/c/Users/alice`, use `//c/**/.env`.

NOTE: `Edit` rules apply to all built-in tools that edit files. `Read` deny rules apply to built-in file tools, NOT to Bash subprocesses. A `Read(./.env)` deny rule blocks the Read tool but does not prevent `cat .env` in Bash.

**WebFetch:** `WebFetch(domain:example.com)` matches fetch requests to example.com

**MCP:**
- `mcp__puppeteer` matches any tool from the `puppeteer` server
- `mcp__puppeteer__*` wildcard matching all tools from the server
- `mcp__puppeteer__puppeteer_navigate` matches a specific tool

**Agent (subagents):**
- `Agent(Explore)` matches the Explore subagent
- `Agent(Plan)` matches the Plan subagent
- `Agent(my-custom-agent)` matches a custom named subagent

```json
{
  "permissions": {
    "deny": ["Agent(Explore)"]
  }
}
```

## Extend Permissions with Hooks

Hooks provide a way to register custom shell commands for permission evaluation at runtime. When Claude Code makes a tool call, PreToolUse hooks run before the permission prompt.

- A hook returning `"allow"` skips the interactive prompt but does NOT override deny/ask rules
- A hook exiting with code 2 stops the tool call before permission rules are evaluated

## Working Directories

By default, Claude has access to files in the directory where it was launched. Extend this access:
- **During startup**: use `--add-dir <path>` CLI argument
- **During session**: use `/add-dir` command
- **Persistent configuration**: add to `additionalDirectories` in settings files

## How Permissions Interact with Sandboxing

- **Permissions** control which tools Claude Code can use and which files or domains it can access
- **Sandboxing** provides OS-level enforcement that restricts the Bash tool's filesystem and network access

## Managed Settings

For organizations needing centralized control:

### Managed-Only Settings

| Setting | Description |
|:--------|:------------|
| `allowManagedPermissionRulesOnly` | When `true`, prevents user and project settings from defining `allow`, `ask`, or `deny` rules. Only rules in managed settings apply |
| `allowManagedHooksOnly` | When `true`, prevents loading of user, project, and plugin hooks. Only managed hooks and SDK hooks are allowed |
| `allowManagedMcpServersOnly` | When `true`, only `allowedMcpServers` from managed settings are respected. `deniedMcpServers` still merges from all sources |
| `allowedChannelPlugins` | Allowlist of channel plugins that may push messages |
| `blockedMarketplaces` | Blocklist of marketplace sources |
| `sandbox.network.allowManagedDomainsOnly` | When `true`, only `allowedDomains` and `WebFetch(domain:...)` allow rules from managed settings are respected |
| `sandbox.filesystem.allowManagedReadPathsOnly` | When `true`, only `allowRead` paths from managed settings are respected |
| `strictKnownMarketplaces` | Controls which plugin marketplaces users can add |

## Configure the Auto Mode Classifier

Auto mode uses a classifier model to decide whether each action is safe to run without prompting. The `autoMode` settings block lets you tell the classifier which infrastructure your organization trusts.

The classifier reads `autoMode` from user settings, `.claude/settings.local.json`, and managed settings. It does NOT read from shared project settings in `.claude/settings.json`.

### Define trusted infrastructure

```json
{
  "autoMode": {
    "environment": [
      "Source control: github.example.com/acme-corp and all repos under it",
      "Trusted cloud buckets: s3://acme-build-artifacts, gs://acme-ml-datasets",
      "Trusted internal domains: *.corp.example.com, api.internal.example.com",
      "Key internal services: Jenkins at ci.example.com, Artifactory at artifacts.example.com"
    ]
  }
}
```

Entries are prose, not regex or tool patterns. The classifier reads them as natural-language rules.

### Override block and allow rules

Two additional fields: `autoMode.soft_deny` controls what gets blocked, and `autoMode.allow` controls which exceptions apply. Each is an array of prose descriptions.

DANGER: Setting `allow` or `soft_deny` replaces the entire default list for that section. To customize safely, run `claude auto-mode defaults` to print the built-in rules, copy them, then edit.

### Inspect defaults and effective config

```bash
claude auto-mode defaults  # the built-in environment, allow, and soft_deny rules
claude auto-mode config    # what the classifier actually uses
claude auto-mode critique  # get AI feedback on your custom allow and soft_deny rules
```

## Settings Precedence

1. **Managed settings**: cannot be overridden by any other level
2. **Command line arguments**: temporary session overrides
3. **Local project settings** (`.claude/settings.local.json`)
4. **Shared project settings** (`.claude/settings.json`)
5. **User settings** (`~/.claude/settings.json`)

If a tool is denied at any level, no other level can allow it.

---

# PAGE 3: Security
**URL:** https://code.claude.com/docs/en/security

## How We Approach Security

### Security Foundation

Claude Code is built with security at its core, developed according to Anthropic's comprehensive security program. Resources (SOC 2 Type 2 report, ISO 27001 certificate, etc.) at Anthropic Trust Center (https://trust.anthropic.com).

### Permission-Based Architecture

Claude Code uses strict read-only permissions by default. When additional actions are needed (editing files, running tests, executing commands), Claude Code requests explicit permission.

### Built-In Protections

- **Sandboxed bash tool**: Sandbox bash commands with filesystem and network isolation. Enable with `/sandbox`
- **Write access restriction**: Claude Code can only write to the folder where it was started and its subfolders—it cannot modify files in parent directories without explicit permission. While Claude Code can read files outside the working directory, write operations are strictly confined to the project scope
- **Prompt fatigue mitigation**: Support for allowlisting frequently used safe commands per-user, per-codebase, or per-organization
- **Accept Edits mode**: Batch accept multiple edits while maintaining permission prompts for commands with side effects

## Protect Against Prompt Injection

### Core Protections

- **Permission system**: Sensitive operations require explicit approval
- **Context-aware analysis**: Detects potentially harmful instructions by analyzing the full request
- **Input sanitization**: Prevents command injection by processing user inputs
- **Command blocklist**: Blocks risky commands that fetch arbitrary content from the web like `curl` and `wget` by default

### Privacy Safeguards

- Limited retention periods for sensitive information
- Restricted access to user session data
- User control over data training preferences

### Additional Safeguards

- **Network request approval**: Tools that make network requests require user approval by default
- **Isolated context windows**: Web fetch uses a separate context window to avoid injecting potentially malicious prompts
- **Trust verification**: First-time codebase runs and new MCP servers require trust verification. NOTE: Trust verification is disabled when running non-interactively with the `-p` flag
- **Command injection detection**: Suspicious bash commands require manual approval even if previously allowlisted
- **Fail-closed matching**: Unmatched commands default to requiring manual approval
- **Natural language descriptions**: Complex bash commands include explanations for user understanding
- **Secure credential storage**: API keys and tokens are encrypted

**WARNING (Windows):** When running Claude Code on Windows, avoid enabling WebDAV or allowing Claude Code to access paths like `\\*` that may contain WebDAV subdirectories. WebDAV has been deprecated by Microsoft due to security risks.

**Best practices for working with untrusted content:**
1. Review suggested commands before approval
2. Avoid piping untrusted content directly to Claude
3. Verify proposed changes to critical files
4. Use virtual machines (VMs) to run scripts and make tool calls, especially when interacting with external web services
5. Report suspicious behavior with `/feedback`

## MCP Security

Claude Code allows users to configure Model Context Protocol (MCP) servers. The list of allowed MCP servers is configured in your source code, as part of Claude Code settings engineers check into source control. Anthropic does not manage or audit any MCP servers.

## Cloud Execution Security

When using Claude Code on the web, additional security controls are in place:

- **Isolated virtual machines**: Each cloud session runs in an isolated, Anthropic-managed VM
- **Network access controls**: Network access is limited by default and can be configured to be disabled or allow only specific domains
- **Credential protection**: Authentication handled through a secure proxy with scoped credentials
- **Branch restrictions**: Git push operations are restricted to the current working branch
- **Audit logging**: All operations in cloud environments are logged for compliance and audit purposes
- **Automatic cleanup**: Cloud environments are automatically terminated after session completion

## Security Best Practices

### Working with Sensitive Code

- Review all suggested changes before approval
- Use project-specific permission settings for sensitive repositories
- Consider using devcontainers for additional isolation
- Regularly audit your permission settings with `/permissions`

### Team Security

- Use managed settings to enforce organizational standards
- Share approved permission configurations through version control
- Monitor Claude Code usage through OpenTelemetry metrics
- Audit or block settings changes during sessions with `ConfigChange` hooks

### Reporting Security Issues

Report through the HackerOne program (https://hackerone.com/anthropic-vdp/reports/new?type=team&report_type=vulnerability). Include detailed reproduction steps. Allow time for Anthropic to address the issue before public disclosure.

---

# PAGE 4: Settings (Complete)
**URL:** https://code.claude.com/docs/en/settings

## Configuration Scopes

| Scope | Location | Who it affects | Shared with team? |
|:------|:---------|:---------------|:------------------|
| **Managed** | Server-managed settings, plist / registry, or system-level `managed-settings.json` | All users on the machine | Yes (deployed by IT) |
| **User** | `~/.claude/` directory | You, across all projects | No |
| **Project** | `.claude/` in repository | All collaborators | Yes (committed to git) |
| **Local** | `.claude/settings.local.json` | You, in this repository only | No (gitignored) |

### Settings Hierarchy (highest to lowest)
1. Managed (cannot be overridden)
2. Command line arguments (temporary session overrides)
3. Local (`.claude/settings.local.json`)
4. Project (`.claude/settings.json`)
5. User (`~/.claude/settings.json`)

### Scope Locations by Feature

| Feature | User location | Project location | Local location |
|:--------|:-------------|:----------------|:---------------|
| **Settings** | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` |
| **Subagents** | `~/.claude/agents/` | `.claude/agents/` | None |
| **MCP servers** | `~/.claude.json` | `.mcp.json` | `~/.claude.json` (per-project) |
| **Plugins** | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` |
| **CLAUDE.md** | `~/.claude/CLAUDE.md` | `CLAUDE.md` or `.claude/CLAUDE.md` | None |

## Settings Files

The `settings.json` file is the official configuration mechanism:

- **User settings**: `~/.claude/settings.json` — applies to all projects
- **Project settings**: `.claude/settings.json` — checked into source control, shared with team
- **Local settings**: `.claude/settings.local.json` — not checked in, gitignored automatically
- **Managed settings** delivery mechanisms:
  - Server-managed: delivered from Anthropic's servers via the Claude.ai admin console
  - MDM/OS-level policies:
    - macOS: `com.anthropic.claudecode` managed preferences domain (via Jamf, Kandji, etc.)
    - Windows: `HKLM\SOFTWARE\Policies\ClaudeCode` registry key with a `Settings` value (via Group Policy or Intune)
    - Windows (user-level): `HKCU\SOFTWARE\Policies\ClaudeCode` (lowest policy priority)
  - File-based: `managed-settings.json` and `managed-mcp.json` in system directories:
    - macOS: `/Library/Application Support/ClaudeCode/`
    - Linux and WSL: `/etc/claude-code/`
    - Windows: `C:\Program Files\ClaudeCode\`
  - Drop-in directory: `managed-settings.d/` (JSON files merged alphabetically, numeric prefixes for order, e.g. `10-telemetry.json`)

**Other configuration:** `~/.claude.json` — preferences, OAuth session, MCP server configurations, per-project state (allowed tools, trust settings), various caches.

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
  },
  "companyAnnouncements": [
    "Welcome to Acme Corp! Review our code guidelines at docs.acme.com"
  ]
}
```

### Available Settings (Full Table)

| Key | Description | Example |
|:----|:------------|:--------|
| `apiKeyHelper` | Custom script to generate an auth value (sent as `X-Api-Key` and `Authorization: Bearer` headers) | `/bin/generate_temp_api_key.sh` |
| `autoMemoryDirectory` | Custom directory for auto memory storage. Not accepted in project settings | `"~/my-memory-dir"` |
| `cleanupPeriodDays` | Sessions inactive for longer than this period are deleted at startup (default: 30 days). Setting to `0` deletes all transcripts at startup | `20` |
| `companyAnnouncements` | Announcement to display to users at startup | `["Welcome to Acme Corp!"]` |
| `env` | Environment variables applied to every session | `{"FOO": "bar"}` |
| `attribution` | Customize attribution for git commits and pull requests | `{"commit": "Generated with AI", "pr": ""}` |
| `includeCoAuthoredBy` | **Deprecated**: Use `attribution` instead | `false` |
| `includeGitInstructions` | Include built-in commit and PR workflow instructions (default: `true`) | `false` |
| `permissions` | See permission settings table below | |
| `autoMode` | Customize what the auto mode classifier blocks and allows. Contains `environment`, `allow`, and `soft_deny` arrays | `{"environment": ["..."]}` |
| `disableAutoMode` | Set to `"disable"` to prevent auto mode from being activated | `"disable"` |
| `useAutoModeDuringPlan` | Whether plan mode uses auto mode semantics (default: `true`). Not read from shared project settings | `false` |
| `disableDeepLinkRegistration` | Set to `"disable"` to prevent `claude-cli://` protocol handler registration | `"disable"` |
| `hooks` | Configure custom commands to run at lifecycle events | |
| `defaultShell` | Default shell for input-box `!` commands. Accepts `"bash"` or `"powershell"` | `"powershell"` |
| `disableAllHooks` | Disable all hooks and any custom status line | `true` |
| `allowManagedHooksOnly` | (Managed only) Prevent loading of user, project, and plugin hooks | `true` |
| `allowedHttpHookUrls` | Allowlist of URL patterns that HTTP hooks may target. Supports `*` as wildcard | `["https://hooks.example.com/*"]` |
| `httpHookAllowedEnvVars` | Allowlist of env vars HTTP hooks may interpolate into headers | `["MY_TOKEN", "HOOK_SECRET"]` |
| `allowManagedPermissionRulesOnly` | (Managed only) Prevent user and project settings from defining `allow`, `ask`, or `deny` permission rules | `true` |
| `allowManagedMcpServersOnly` | (Managed only) Only `allowedMcpServers` from managed settings are respected | `true` |
| `model` | Override the default model | `"claude-sonnet-4-6"` |
| `availableModels` | Restrict which models users can select | `["sonnet", "haiku"]` |
| `modelOverrides` | Map Anthropic model IDs to provider-specific model IDs | `{"claude-opus-4-6": "arn:aws:bedrock:..."}` |
| `effortLevel` | Persist effort level across sessions. Accepts `"low"`, `"medium"`, or `"high"` | `"medium"` |
| `otelHeadersHelper` | Script to generate dynamic OpenTelemetry headers | `/bin/generate_otel_headers.sh` |
| `statusLine` | Configure a custom status line | `{"type": "command", "command": "~/.claude/statusline.sh"}` |
| `fileSuggestion` | Configure a custom script for `@` file autocomplete | `{"type": "command", "command": "~/.claude/file-suggestion.sh"}` |
| `respectGitignore` | Control whether `@` file picker respects `.gitignore` patterns (default: `true`) | `false` |
| `outputStyle` | Configure an output style to adjust the system prompt | `"Explanatory"` |
| `agent` | Run the main thread as a named subagent | `"code-reviewer"` |
| `forceLoginMethod` | Use `claudeai` to restrict login to Claude.ai accounts, `console` for Console accounts | `claudeai` |
| `forceLoginOrgUUID` | UUID of an organization to automatically select during login | `"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"` |
| `enableAllProjectMcpServers` | Automatically approve all MCP servers defined in project `.mcp.json` files | `true` |
| `enabledMcpjsonServers` | List of specific MCP servers from `.mcp.json` files to approve | `["memory", "github"]` |
| `disabledMcpjsonServers` | List of specific MCP servers from `.mcp.json` files to reject | `["filesystem"]` |
| `channelsEnabled` | (Managed only) Allow channels for Team and Enterprise users | `true` |
| `allowedChannelPlugins` | (Managed only) Allowlist of channel plugins that may push messages | `[{"marketplace": "...", "plugin": "telegram"}]` |
| `allowedMcpServers` | (Managed only) Allowlist of MCP servers users can configure | `[{"serverName": "github"}]` |
| `deniedMcpServers` | (Managed only) Denylist of MCP servers that are explicitly blocked | `[{"serverName": "filesystem"}]` |
| `strictKnownMarketplaces` | (Managed only) Allowlist of plugin marketplaces users can add | `[{"source": "github", "repo": "acme-corp/plugins"}]` |
| `blockedMarketplaces` | (Managed only) Blocklist of marketplace sources | `[{"source": "github", "repo": "untrusted/plugins"}]` |
| `pluginTrustMessage` | (Managed only) Custom message appended to the plugin trust warning | `"All plugins from our marketplace are approved by IT"` |
| `awsAuthRefresh` | Custom script that modifies the `.aws` directory | `aws sso login --profile myprofile` |
| `awsCredentialExport` | Custom script that outputs JSON with AWS credentials | `/bin/generate_aws_grant.sh` |
| `alwaysThinkingEnabled` | Enable extended thinking by default for all sessions | `true` |
| `plansDirectory` | Customize where plan files are stored (relative to project root, default: `~/.claude/plans`) | `"./plans"` |
| `showClearContextOnPlanAccept` | Show the "clear context" option on the plan accept screen (default: `false`) | `true` |
| `spinnerVerbs` | Customize action verbs shown in the spinner and turn duration messages | `{"mode": "append", "verbs": ["Pondering", "Crafting"]}` |
| `language` | Configure Claude's preferred response language | `"japanese"` |
| `voiceEnabled` | Enable push-to-talk voice dictation | `true` |
| `autoUpdatesChannel` | Release channel: `"stable"` (1 week old, skips regressions) or `"latest"` (default, most recent) | `"stable"` |
| `spinnerTipsEnabled` | Show tips in the spinner while Claude is working (default: `true`) | `false` |
| `spinnerTipsOverride` | Override spinner tips with custom strings | `{"excludeDefault": true, "tips": ["Use our internal tool X"]}` |
| `prefersReducedMotion` | Reduce or disable UI animations for accessibility | `true` |
| `fastModePerSessionOptIn` | When `true`, fast mode does not persist across sessions | `true` |
| `feedbackSurveyRate` | Probability (0-1) that the session quality survey appears. Set to `0` to suppress entirely | `0.05` |

### Global Config Settings (in `~/.claude.json`)

These are stored in `~/.claude.json`, NOT `settings.json`. Adding to `settings.json` triggers schema validation error.

| Key | Description | Example |
|:----|:------------|:--------|
| `autoConnectIde` | Auto-connect to IDE when Claude Code starts from external terminal (default: `false`) | `true` |
| `autoInstallIdeExtension` | Auto-install Claude Code IDE extension when running from VS Code terminal (default: `true`) | `false` |
| `editorMode` | Key binding mode: `"normal"` or `"vim"` (default: `"normal"`) | `"vim"` |
| `showTurnDuration` | Show turn duration messages after responses (default: `true`) | `false` |
| `terminalProgressBarEnabled` | Show terminal progress bar in supported terminals (default: `true`) | `false` |
| `teammateMode` | Agent team display mode: `auto`, `in-process`, or `tmux` | `"in-process"` |

### Permission Settings (under `permissions` key)

| Key | Description | Example |
|:----|:------------|:--------|
| `allow` | Array of permission rules to allow tool use | `["Bash(git diff *)"]` |
| `ask` | Array of permission rules to ask for confirmation | `["Bash(git push *)"]` |
| `deny` | Array of permission rules to deny tool use | `["WebFetch", "Bash(curl *)", "Read(./.env)"]` |
| `additionalDirectories` | Additional working directories Claude has access to | `["../docs/"]` |
| `defaultMode` | Default permission mode | `"acceptEdits"` |
| `disableBypassPermissionsMode` | Set to `"disable"` to prevent `bypassPermissions` mode | `"disable"` |

### Sandbox Settings (under `sandbox` key)

| Key | Description | Example |
|:----|:------------|:--------|
| `enabled` | Enable bash sandboxing (macOS, Linux, and WSL2). Default: false | `true` |
| `failIfUnavailable` | Exit with error at startup if sandbox cannot start | `true` |
| `autoAllowBashIfSandboxed` | Auto-approve bash commands when sandboxed (default: true) | `true` |
| `excludedCommands` | Commands that should run outside of the sandbox | `["git", "docker"]` |
| `allowUnsandboxedCommands` | Allow commands to run outside the sandbox. Set `false` for strict sandboxing (default: true) | `false` |
| `filesystem.allowWrite` | Additional paths where sandboxed commands can write | `["/tmp/build", "~/.kube"]` |
| `filesystem.denyWrite` | Paths where sandboxed commands cannot write | `["/etc", "/usr/local/bin"]` |
| `filesystem.denyRead` | Paths where sandboxed commands cannot read | `["~/.aws/credentials"]` |
| `filesystem.allowRead` | Paths to re-allow reading within `denyRead` regions | `["."]` |
| `filesystem.allowManagedReadPathsOnly` | (Managed only) Only `allowRead` paths from managed settings respected | `true` |
| `network.allowUnixSockets` | Unix socket paths accessible in sandbox | `["~/.ssh/agent-socket"]` |
| `network.allowAllUnixSockets` | Allow all Unix socket connections (default: false) | `true` |
| `network.allowLocalBinding` | Allow binding to localhost ports (macOS only, default: false) | `true` |
| `network.allowedDomains` | Array of domains to allow for outbound network traffic. Supports wildcards | `["github.com", "*.npmjs.org"]` |
| `network.allowManagedDomainsOnly` | (Managed only) Only `allowedDomains` from managed settings respected | `true` |
| `network.httpProxyPort` | HTTP proxy port | `8080` |
| `network.socksProxyPort` | SOCKS5 proxy port | `8081` |
| `enableWeakerNestedSandbox` | Enable weaker sandbox for unprivileged Docker environments. **Reduces security.** | `true` |
| `enableWeakerNetworkIsolation` | (macOS only) Allow access to system TLS trust service. **Reduces security.** | `true` |

**Sandbox configuration example:**
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
      "allowedDomains": ["github.com", "*.npmjs.org", "registry.yarnpkg.com"],
      "allowUnixSockets": ["/var/run/docker.sock"],
      "allowLocalBinding": true
    }
  }
}
```

---

# PAGE 5: Permission Modes
**URL:** https://code.claude.com/docs/en/permission-modes

## Switch Permission Modes

**During session (CLI):** Press `Shift+Tab` to cycle through `default` → `acceptEdits` → `plan` → `auto`
- `auto` does not appear in the cycle until you pass `--enable-auto-mode` at startup
- `dontAsk` is never in the `Shift+Tab` cycle
- `bypassPermissions` appears in the cycle only if you started the session with `--permission-mode bypassPermissions`, `--dangerously-skip-permissions`, or `--allow-dangerously-skip-permissions`

**At startup:**
```bash
claude --permission-mode plan
```

**As a default (settings file):**
```json
{
  "permissions": {
    "defaultMode": "acceptEdits"
  }
}
```

**Non-interactively:**
```bash
claude -p "refactor auth" --permission-mode acceptEdits
```

## Available Modes

| Mode | What Claude can do without asking | Best for |
|:-----|:----------------------------------|:---------|
| `default` | Read files | Getting started, sensitive work |
| `acceptEdits` | Read and edit files | Iterating on code you're reviewing |
| `plan` | Read files | Exploring a codebase, planning a refactor |
| `auto` | All actions, with background safety checks | Long-running tasks, reducing prompt fatigue |
| `bypassPermissions` | All actions, no checks | Isolated containers and VMs only |
| `dontAsk` | Only pre-approved tools | Locked-down environments |

## Plan Mode

Plan mode tells Claude to research and propose changes without making them. Claude reads files, runs shell commands to explore, asks clarifying questions, and writes a plan file, but does not edit your source code.

Enter plan mode for a single request by prefixing your prompt with `/plan`, or switch the whole session with `Shift+Tab`.

When the plan is ready, Claude presents it and asks how to proceed. Options:
- Approve and start in auto mode
- Approve and accept edits
- Approve and manually review each edit
- Keep planning (send feedback back to Claude)

## Auto Mode

Auto mode is available on Team plans (Enterprise and API rolling out). Requires Claude Sonnet 4.6 or Claude Opus 4.6. Not available on Haiku, claude-3 models, or third-party providers (Bedrock, Vertex, Foundry).

Before each action runs, a separate classifier model reviews the conversation and decides whether the action matches what you asked for.

**Model:** The classifier runs on Claude Sonnet 4.6 even if your main session uses a different model.

**Cost:** Classifier calls count toward your token usage. Each checked action sends a portion of the conversation transcript plus the pending action to the classifier.

### How Actions Are Evaluated

Each action goes through a fixed decision order (first matching step wins):
1. Actions matching your allow or deny rules resolve immediately
2. Read-only actions and file edits in your working directory are auto-approved
3. Everything else goes to the classifier
4. If the classifier blocks, Claude receives the reason and attempts an alternative approach

On entering auto mode, Claude Code drops any allow rule that grants arbitrary code execution: blanket shell access like `Bash(*)`, wildcarded script interpreters like `Bash(python*)`, package-manager run commands, and any `Agent` allow rule. Narrow rules like `Bash(npm test)` carry over.

The classifier receives user messages and tool calls as input, with Claude's own text and tool results stripped out. It also receives your CLAUDE.md content. Because tool results never reach the classifier, hostile content in a file or web page cannot manipulate it directly.

### How Auto Mode Handles Subagents

- When Claude spawns a subagent, the classifier evaluates the delegated task before the subagent starts
- Inside the subagent, auto mode runs with the same block and allow rules as the parent session
- Any `permissionMode` the subagent defines in its own frontmatter is ignored
- When the subagent finishes, the classifier reviews its full action history

### What the Classifier Blocks by Default

**Blocked by default:**
- Downloading and executing code, like `curl | bash` or scripts from cloned repos
- Sending sensitive data to external endpoints
- Production deploys and migrations
- Mass deletion on cloud storage
- Granting IAM or repo permissions
- Modifying shared infrastructure
- Irreversibly destroying files that existed before the session started
- Destructive source control operations like force push or pushing directly to `main`

**Allowed by default:**
- Local file operations in your working directory
- Installing dependencies already declared in your lock files or manifests
- Reading `.env` and sending credentials to their matching API
- Read-only HTTP requests
- Pushing to the branch you started on or one Claude created

Run `claude auto-mode defaults` to see the full default rule lists.

### When Auto Mode Falls Back

If the classifier blocks an action 3 times in a row or 20 times total in one session, auto mode pauses and Claude Code resumes prompting for each action. Approving the prompted action resets the denial counters.

Non-interactive mode with the `-p` flag: aborts the session if fallback triggers.

## dontAsk Mode

`dontAsk` mode auto-denies every tool that is not explicitly allowed. Only actions matching your `/permissions` allow rules or `permissions.allow` settings can execute. If a tool has an explicit `ask` rule, the action is also denied rather than prompting. Fully non-interactive — suitable for CI pipelines.

```bash
claude --permission-mode dontAsk
```

## bypassPermissions Mode

`bypassPermissions` mode disables all permission prompts and safety checks. Every tool call executes immediately without any verification. Only use in isolated environments.

```bash
claude --permission-mode bypassPermissions
```

The `--dangerously-skip-permissions` flag is equivalent:
```bash
claude -p "refactor the auth module" --dangerously-skip-permissions
```

Administrators can block this mode by setting `permissions.disableBypassPermissionsMode` to `"disable"` in managed settings.

## Permission Mode Comparison

| | `default` | `acceptEdits` | `auto` | `dontAsk` | `bypassPermissions` |
|:-|:----------|:--------------|:-------|:----------|:--------------------|
| Permission prompts | File edits and commands | Commands only | None unless fallback triggers | None, blocked unless pre-allowed | None |
| Safety checks | You review each action | You review commands | Classifier reviews commands | Your pre-approved rules only | None |
| Token usage | Standard | Standard | Higher, from classifier calls | Standard | Standard |

---

# PAGE 6: Hooks Guide (Practical)
**URL:** https://code.claude.com/docs/en/hooks-guide

## What You Can Automate

Hooks let you run code at key points in Claude Code's lifecycle: format files after edits, block commands before they execute, send notifications when Claude needs input, inject context at session start, and more.

## Example: Get Notified When Claude Needs Input (Windows)

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -Command \"[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('Claude Code needs your attention', 'Claude Code')\""
          }
        ]
      }
    ]
  }
}
```

## Example: Auto-Format Code After Edits

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write"
          }
        ]
      }
    ]
  }
}
```

## Example: Block Edits to Protected Files

Script `.claude/hooks/protect-files.sh`:
```bash
#!/bin/bash
# protect-files.sh

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

PROTECTED_PATTERNS=(".env" "package-lock.json" ".git/")

for pattern in "${PROTECTED_PATTERNS[@]}"; do
  if [[ "$FILE_PATH" == *"$pattern"* ]]; then
    echo "Blocked: $FILE_PATH matches protected pattern '$pattern'" >&2
    exit 2
  fi
done

exit 0
```

Configuration:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/protect-files.sh"
          }
        ]
      }
    ]
  }
}
```

## Example: Re-Inject Context After Compaction

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "compact",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Reminder: use Bun, not npm. Run bun test before committing. Current sprint: auth refactor.'"
          }
        ]
      }
    ]
  }
}
```

## Example: Audit Configuration Changes

```json
{
  "hooks": {
    "ConfigChange": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "jq -c '{timestamp: now | todate, source: .source, file: .file_path}' >> ~/claude-config-audit.log"
          }
        ]
      }
    ]
  }
}
```

## Example: Reload Environment When Directory Changes (direnv)

```json
{
  "hooks": {
    "CwdChanged": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "direnv export bash >> \"$CLAUDE_ENV_FILE\""
          }
        ]
      }
    ]
  }
}
```

## Example: Auto-Approve Specific Permission Prompts

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

To set a specific permission mode via hook:
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

## How Hooks Work

All matching hooks run in parallel, and identical hook commands are automatically deduplicated.

### `if` Field (Requires Claude Code v2.1.85+)

The `if` field uses permission rule syntax to filter hooks by tool name and arguments together:

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
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/check-git-policy.sh"
          }
        ]
      }
    ]
  }
}
```

`if` only works on tool events: `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, and `PermissionRequest`.

## Hook Input and Output

All hooks receive event-specific data as JSON on stdin. Exit codes:
- **Exit 0**: action proceeds. On `UserPromptSubmit` and `SessionStart`, stdout added to Claude's context
- **Exit 2**: action blocked. Write a reason to stderr; Claude receives it as feedback
- **Any other exit code**: action proceeds. Stderr logged but not shown to Claude (visible in verbose mode with `Ctrl+O`)

For structured output instead of exit codes, exit 0 and print JSON to stdout:
```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Use rg instead of grep for better performance"
  }
}
```

NOTE: `permissionDecision: "allow"` skips the interactive prompt but does NOT override permission rules. If a deny rule matches the tool call, the call is blocked even when your hook returns `"allow"`.

## Prompt-Based Hooks

For decisions that require judgment rather than deterministic rules:
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Check if all tasks are complete. If not, respond with {\"ok\": false, \"reason\": \"what remains to be done\"}."
          }
        ]
      }
    ]
  }
}
```

Returns `{"ok": true}` or `{"ok": false, "reason": "..."}`.

## Agent-Based Hooks

When verification requires inspecting files or running commands:
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "agent",
            "prompt": "Verify that all unit tests pass. Run the test suite and check the results. $ARGUMENTS",
            "timeout": 120
          }
        ]
      }
    ]
  }
}
```

Default timeout: 60 seconds, up to 50 tool-use turns.

## HTTP Hooks

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "hooks": [
          {
            "type": "http",
            "url": "http://localhost:8080/hooks/tool-use",
            "headers": {
              "Authorization": "Bearer $MY_TOKEN"
            },
            "allowedEnvVars": ["MY_TOKEN"]
          }
        ]
      }
    ]
  }
}
```

The endpoint receives the same JSON that a command hook would receive on stdin. To block a tool call, return a 2xx response with the appropriate `hookSpecificOutput` fields. HTTP status codes alone cannot block actions.

## Limitations

- Command hooks communicate through stdout, stderr, and exit codes only. They cannot trigger tool calls directly
- Hook timeout is 10 minutes by default, configurable per hook with the `timeout` field (in seconds)
- `PostToolUse` hooks cannot undo actions since the tool has already executed
- `PermissionRequest` hooks do not fire in non-interactive mode (`-p`). Use `PreToolUse` hooks for automated permission decisions
- `Stop` hooks fire whenever Claude finishes responding, not only at task completion. They do not fire on user interrupts. API errors fire `StopFailure` instead

## Troubleshooting: Stop Hook Infinite Loop

Parse `stop_hook_active` field and exit early if `true`:
```bash
#!/bin/bash
INPUT=$(cat)
if [ "$(echo "$INPUT" | jq -r '.stop_hook_active')" = "true" ]; then
  exit 0  # Allow Claude to stop
fi
# ... rest of your hook logic
```

## Troubleshooting: JSON Validation Failed

If your shell profile (`.zshrc`/`.bashrc`) contains unconditional `echo` statements, that output gets prepended to your hook's JSON. Fix by wrapping echo in interactive-only check:
```bash
# In ~/.zshrc or ~/.bashrc
if [[ $- == *i* ]]; then
  echo "Shell ready"
fi
```

---

## Recommendations

This is a raw documentation capture for reference. The content is from primary Anthropic sources and is authoritative as of 2026-03-28.

Key notes for this project:
1. The `UserPromptSubmit` hook is the correct hook for enforcing task DAG protocol (fires before Claude processes any prompt)
2. The `Stop` hook with `stop_hook_active` check can enforce task completion validation
3. `SubagentStart`/`SubagentStop` hooks provide lifecycle control for agent teams
4. `TaskCreated`/`TaskCompleted` hooks can enforce DAG validation rules
5. The `if` field on hooks (requires v2.1.85+) allows fine-grained tool+argument matching without spawning a process for every call
6. `bypassPermissions` mode is used for agent pipelines — writes to `.claude/agents/`, `.claude/commands/`, `.claude/skills/` are automatically exempt from permission prompts in this mode
7. `ConfigChange` hook can audit or block changes to settings files during a session
