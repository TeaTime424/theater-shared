# Claude Code Auto-Permissions Best Practices

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-28
**Related:** `.claude/settings.local.json` (current project config)

---

## Executive Summary

Claude Code has a mature, well-documented permission system as of early 2026. The official guidance from Anthropic centers on three complementary defense layers: declarative allow/deny rules, hook-based guardrails, and OS-level sandboxing. The current theater project settings use `"Bash(*)"` which grants full bash permission — this is the broadest possible allow rule and appropriate for a trusted local development environment, but it should be paired with deny rules for the most dangerous operations and/or hooks as a second line of defense.

---

## Key Findings

### 1. Permission System Architecture

Claude Code uses a tiered permission hierarchy. Rules are evaluated in strict order:

```
deny → ask → allow → canUseTool callback
```

The first matching rule wins. A deny at any settings level cannot be overridden by any other level, including CLI flags.

**Settings precedence (highest to lowest):**
1. Managed settings (org-level, cannot be overridden)
2. CLI arguments (`--allowedTools`, `--disallowedTools`)
3. Local project settings (`.claude/settings.local.json`)
4. Shared project settings (`.claude/settings.json`)
5. User settings (`~/.claude/settings.json`)

If a tool is denied at any level, no lower level can un-deny it. This means a deny in `.claude/settings.json` beats an allow in `~/.claude/settings.json`.

### 2. Permission Modes

| Mode | Behavior | Use When |
|------|----------|----------|
| `default` | Prompts on first use of each tool | Initial sessions, unfamiliar codebases |
| `acceptEdits` | Auto-approves file edits; prompts for Bash | Trusted code but still want bash review |
| `plan` | Read-only, no execution | Auditing, planning, code review |
| `auto` | Classifier model approves/blocks dynamically | Long autonomous runs with broad scope |
| `dontAsk` | Denies anything not pre-approved | Headless agents with fixed tool surface |
| `bypassPermissions` | Skips all prompts (except protected dirs) | Containers/VMs only — never on bare metal |

**`bypassPermissions` warning:** Still prompts for writes to `.git`, `.claude`, `.vscode`, `.idea`. Do NOT use on a real workstation. Administrators can lock this out with `disableBypassPermissionsMode: "disable"` in managed settings.

### 3. Permission Rule Syntax

**Match everything:**
```json
"Bash"          // all bash commands
"Read"          // all file reads
"WebFetch"      // all web requests
```

**Match with specifier:**
```json
"Bash(npm run *)"           // any npm run subcommand
"Bash(git commit *)"        // any git commit
"Bash(git push *)"          // any git push (useful in deny)
"Read(./.env)"              // reading .env specifically
"WebFetch(domain:github.com)"  // fetches to github only
"Agent(my-agent)"           // specific subagent
```

**Wildcard behavior:** Space before `*` enforces word boundary. `"Bash(ls *)"` matches `ls -la` but NOT `lsof`. `"Bash(ls*)"` matches both.

**Shell operator awareness:** `"Bash(safe-cmd *)"` does NOT grant permission to run `safe-cmd && other-cmd`. Compound commands require each subcommand to be independently allowed.

### 4. Recommended allowedTools Lists

**Minimal safe list for a research/analysis agent (read-only):**
```json
{
  "permissions": {
    "allow": ["Read", "Glob", "Grep", "WebFetch", "WebSearch"],
    "defaultMode": "dontAsk"
  }
}
```

**Standard development allow list (community-recommended):**
```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(npx prettier *)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Bash(git add *)",
      "Bash(git commit *)",
      "Bash(git checkout *)",
      "Edit",
      "Write",
      "Read",
      "Glob",
      "Grep"
    ]
  }
}
```

**For the theater project (current state + improvement):** The current `"Bash(*)"` is intentionally broad for a local trusted-dev environment. If tightening is desired, a targeted deny list (section 6) is more practical than replacing `Bash(*)` with an allowlist.

### 5. Project-Scoped vs Global Settings

| File | Scope | Committed to git? | Use for |
|------|-------|-------------------|---------|
| `~/.claude/settings.json` | All projects on machine | No | Personal defaults, trusted infrastructure |
| `.claude/settings.json` | Single project, all contributors | Yes | Team rules, project-specific tool allows |
| `.claude/settings.local.json` | Single project, current user | No (gitignored) | Personal overrides, sensitive paths |
| Managed settings | All machines in org | Via MDM/policy | Org-wide locks, can't be overridden |

**Best practice:** Use shared `.claude/settings.json` for project-level tool allows that all contributors should have. Use `.claude/settings.local.json` for personal credentials, paths, and experimental allow rules. Use `~/.claude/settings.json` for global defaults that apply to all your projects.

**Auto mode config exception:** `autoMode` settings are intentionally NOT read from `.claude/settings.json` (shared project) — only from user and local settings. This prevents a checked-in repo from injecting its own allow rules for the auto classifier.

### 6. Deny Lists — Dangerous Operations to Block

**Anthropic official example (from docs):**
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

**Community-recommended additions to deny list:**

Git destructive operations:
```json
"Bash(git push --force *)"
"Bash(git push -f *)"
"Bash(git reset --hard *)"
"Bash(git reset --merge *)"
"Bash(git clean -f *)"
"Bash(git branch -D *)"
"Bash(git stash drop *)"
"Bash(git stash clear)"
"Bash(git restore --worktree *)"
```

Filesystem destructive:
```json
"Bash(rm -rf /)"
"Bash(rm -rf ~)"
"Bash(rm -rf $HOME)"
```

Note: `rm -rf` targeting paths OUTSIDE cwd is better handled by hooks (section 7) since deny rule glob matching is unreliable for variable paths.

**Backslash Security's conservative baseline:**
```json
{
  "permissions": {
    "deny": [
      "WebFetch",
      "Bash(curl *)",
      "Read(./secrets/**)"
    ],
    "defaultMode": "ask"
  }
}
```

This is the most restrictive practical starting point for untrusted or production environments.

### 7. Hook-Based Guardrails

Hooks are the second line of defense — they intercept tool calls at runtime and can block based on logic that deny rules cannot express (variable paths, compound commands, runtime state).

**Hook exit codes:**
- `exit 0` — allow the action
- `exit 2` — block the action (stderr message sent to Claude as feedback)
- Any other non-zero — action proceeds but error is logged

**Hook for blocking destructive git operations (PreToolUse):**
```bash
#!/bin/bash
# .claude/hooks/git-safe.sh
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

BLOCKED_PATTERNS=(
  "git push --force"
  "git push -f "
  "git reset --hard"
  "git reset --merge"
  "git clean -f"
  "git branch -D"
  "git stash drop"
  "git stash clear"
  "git restore --worktree"
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qF "$pattern"; then
    echo "Blocked: '$pattern' is a destructive git operation. Use with manual approval." >&2
    exit 2
  fi
done

exit 0
```

Register in `.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "if": "Bash(git *)",
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/git-safe.sh"
      }]
    }]
  }
}
```

**Hook for protecting sensitive files from Edit/Write:**
```bash
#!/bin/bash
# .claude/hooks/protect-files.sh
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

PROTECTED_PATTERNS=(".env" "secrets/" ".git/" "*.pem" "*.key" "id_rsa")

for pattern in "${PROTECTED_PATTERNS[@]}"; do
  if [[ "$FILE_PATH" == *"$pattern"* ]]; then
    echo "Blocked: $FILE_PATH matches protected pattern '$pattern'" >&2
    exit 2
  fi
done

exit 0
```

**Important hook limitations:**
- `PostToolUse` hooks cannot undo actions already executed
- `PermissionRequest` hooks do NOT fire in non-interactive mode (`-p`). Use `PreToolUse` instead for automated flows
- Shell profile `echo` statements contaminate hook JSON output — wrap them in `if [[ $- == *i* ]]` guard
- Hook output must be valid JSON when using structured responses; don't mix `exit 2` with JSON output

**Useful hook events table (security-relevant subset):**

| Event | Fires When | Can Block? |
|-------|-----------|------------|
| `PreToolUse` | Before any tool call | Yes (exit 2) |
| `PostToolUse` | After tool succeeds | Yes (but too late to undo) |
| `PermissionRequest` | Before permission dialog | Yes, can approve/deny |
| `UserPromptSubmit` | Before prompt processed | Can inject context |
| `ConfigChange` | Settings file modified | Yes (exit 2) |
| `Stop` | Claude finishes turn | Can force continuation |

**The `if` field (requires v2.1.85+):** Filters hook execution by tool+argument pattern before spawning the hook process. More efficient than spawning and then checking inside the script:
```json
{
  "type": "command",
  "if": "Bash(git *)",
  "command": "path/to/git-hook.sh"
}
```

### 8. Git Safety Specifics

**What is protected by default:** Writes to `.git/`, `.claude/`, `.vscode/`, `.idea/` always prompt for confirmation even in `bypassPermissions` mode — except `.claude/commands/`, `.claude/agents/`, `.claude/skills/` which are exempt.

**What is NOT protected by default:**
- `git push --force` (rewrites remote history)
- `git reset --hard` (destroys uncommitted work)
- `git clean -f` (removes untracked files)
- `git branch -D` (force deletes branches)

**Recommended deny rules for git safety:**
```json
{
  "permissions": {
    "deny": [
      "Bash(git push --force *)",
      "Bash(git push -f *)",
      "Bash(git reset --hard *)",
      "Bash(git clean -f *)",
      "Bash(git branch -D *)"
    ]
  }
}
```

**Community plugin alternative:** `kenryu42/claude-code-safety-net` is a marketplace plugin that covers all destructive git and filesystem operations via PreToolUse hooks. Install with `/plugin install safety-net@cc-marketplace`. Covers `git checkout --`, `git stash clear/drop`, `rm -rf` outside cwd, `find ... -delete`, `xargs rm -rf`.

### 9. Environment Isolation — Sandboxing

**Native sandboxing (built-in, recommended):** Claude Code has OS-level sandboxing via `/sandbox` command.

| OS | Implementation |
|----|---------------|
| macOS | Seatbelt |
| Linux / WSL2 | bubblewrap + socat |
| WSL1 | NOT supported |
| Windows native | Planned, not available |

**Enable:** Run `/sandbox` in Claude Code, or add to settings:
```json
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "allowUnsandboxedCommands": false,
    "filesystem": {
      "allowWrite": ["~/.kube", "/tmp/build"],
      "denyRead": ["~/"],
      "allowRead": ["."]
    },
    "network": {
      "allowedDomains": ["github.com", "npmjs.com", "api.anthropic.com"]
    }
  }
}
```

**Effect:** 84% reduction in permission prompts in Anthropic's internal testing while maintaining security. All subprocess commands (including `kubectl`, `terraform`, `npm`) inherit the sandbox restrictions.

**Worktree isolation:** Use `claude --worktree` to have Claude create isolated git worktrees automatically. Each worktree maps cleanly to one PR/branch. Best for parallel sessions on risky refactors.

**Container-based isolation:** For maximum isolation (untrusted code review, security audits), run Claude in Docker:
- `trailofbits/claude-code-devcontainer` — security audit devcontainer with `bypassPermissions` safely
- `textcortex/claude-code-sandbox` — Docker container wrapper (archived, use Spritz continuation)
- Docker Sandboxes (Docker Desktop feature) — run Claude headless in isolated containers

**Sandbox + permissions = defense-in-depth:** These are not mutually exclusive:
- Permissions control which TOOLS Claude can attempt to use
- Sandboxing restricts what Bash subprocesses can ACCESS at OS level
- A prompt-injected Claude that bypasses permission decisions still can't reach outside the sandbox filesystem/network boundaries

**Limitations:**
- Sandboxing only applies to Bash tool, not Read/Edit/Write (those use permission system)
- `allowUnixSockets` can grant docker.sock access — be careful
- `enableWeakerNestedSandbox` (for Docker-in-Docker) significantly weakens security

### 10. Anthropic Official Example Configs

**settings-lax.json** (minimal safety, for personal use):
```json
{
  "permissions": {
    "disableBypassPermissionsMode": "disable"
  },
  "strictKnownMarketplaces": []
}
```

**settings-strict.json** (maximum restriction, for org/managed deployment):
```json
{
  "permissions": {
    "disableBypassPermissionsMode": "disable",
    "ask": ["Bash"],
    "deny": ["WebSearch", "WebFetch"]
  },
  "allowManagedPermissionRulesOnly": true,
  "allowManagedHooksOnly": true,
  "strictKnownMarketplaces": [],
  "sandbox": {
    "autoAllowBashIfSandboxed": false,
    "excludedCommands": [],
    "network": {
      "allowUnixSockets": [],
      "allowAllUnixSockets": false,
      "allowLocalBinding": false,
      "allowedDomains": [],
      "httpProxyPort": null,
      "socksProxyPort": null
    },
    "enableWeakerNestedSandbox": false
  }
}
```

**settings-bash-sandbox.json** (sandboxed execution, managed rules only):
```json
{
  "allowManagedPermissionRulesOnly": true,
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": false,
    "allowUnsandboxedCommands": false,
    "excludedCommands": [],
    "network": {
      "allowUnixSockets": [],
      "allowAllUnixSockets": false,
      "allowLocalBinding": false,
      "allowedDomains": [],
      "httpProxyPort": null,
      "socksProxyPort": null
    },
    "enableWeakerNestedSandbox": false
  }
}
```

### 11. Graduated Trust Model

Anthropic's recommended approach (both in docs and community practice):

1. **Start with `default` mode** — prompts every sensitive operation. Review what Claude actually needs for a few sessions.
2. **Promote frequently-approved commands** to the allow list via `/permissions` UI.
3. **Add deny rules** for the operations that should never happen automatically.
4. **Switch to `acceptEdits`** once you trust Claude's file edits in this project.
5. **Enable sandbox** when you want to reduce Bash prompts without losing safety.
6. **Enable `auto` mode** for long autonomous runs once sandbox is configured and you have deny rules for truly dangerous operations.

**Never use `bypassPermissions` on bare metal.** Use it only in containers/VMs. Administrators should set `"disableBypassPermissionsMode": "disable"` in managed settings to prevent developers from enabling it.

---

## Comparison Table

| Approach | Safety | Friction | Best For |
|----------|--------|----------|----------|
| `default` mode, no rules | Baseline | High (prompts everything) | Initial sessions |
| `acceptEdits` + targeted deny | Good | Low | Daily dev on trusted projects |
| `Bash(*)` allow + deny list | Good | Very Low | Experienced users, trusted local env |
| `auto` mode + sandbox | Very Good | Near-zero | Long autonomous runs |
| Sandbox + `dontAsk` + allowlist | High | Low | Headless agents, CI |
| `bypassPermissions` in container | High (containerized) | Zero | Security audits, untrusted code |
| `settings-strict.json` | Maximum | High | Org managed, untrusted users |

---

## Current Project Assessment

The theater project `.claude/settings.local.json` uses:
```json
"permissions": {
  "allow": ["Bash(*)", "Read", "Write", "Edit", "Glob", "Grep", "Agent", "WebSearch", "WebFetch", ...]
}
```

This is `Bash(*)` — allows ALL bash commands without prompting. This is intentional for a trusted local dev environment with a single experienced user (Andy). It is NOT a security risk in context.

**However**, the following additions would add a meaningful second line of defense with zero friction cost:

```json
"deny": [
  "Bash(git push --force *)",
  "Bash(git push -f *)",
  "Bash(git reset --hard *)",
  "Bash(git clean -f *)"
]
```

These deny rules would fire before the `Bash(*)` allow rule and protect against the most consequential accidental-irreversible operations. Cost: zero friction. Benefit: prevents the one class of mistakes that can't be undone in <5 seconds.

---

## Bidirectional Search

- **Searched FOR:** "claude code permissions best practices", "claude code allowedTools recommended", "claude code hooks safety", "claude code denyTools", "claude code settings.json example", "claude code sandboxing containers worktree"
- **Searched AGAINST:** "claude code permissions too restrictive problems", "claude code hooks performance overhead", "claude code sandbox limitations failures", "claude code bypassPermissions risks"
- **Contradicting evidence found:** Yes — minor. Sandbox has real limitations: WSL1 not supported, Docker-incompatible tools need `excludedCommands`, `allowUnixSockets` can create docker.sock bypass, weaker nested sandbox mode significantly reduces security. These are documented by Anthropic, not contradictions — just tradeoffs to know.

---

## Recommendations

**For the theater project (personal trusted dev environment):**

1. Add targeted git deny rules to existing `settings.local.json` — zero friction, protects against irreversible mistakes [**high confidence**]
2. Add the `kenryu42/claude-code-safety-net` plugin for broader destructive-command coverage — low overhead [**medium confidence** — not yet forum-investigated]
3. No need to change `Bash(*)` allow rule — appropriate for this use case

**For general new projects:**

1. Start with `default` mode, no allow rules
2. Add `/permissions` approvals to build up allow list organically over first few sessions
3. Always add the git force-push/hard-reset deny rules from day one
4. Enable sandbox once bubblewrap is available (Linux/WSL2) or Seatbelt (macOS)
5. Use `auto` mode for long autonomous runs once trust is established

**For CI/headless agents:**
- Use `dontAsk` mode + explicit `allowedTools` list
- Enable sandbox with `allowUnsandboxedCommands: false`
- Use `disallowedTools` to explicitly block tools not in allowlist

---

## Sources

1. [Configure permissions — Claude Code Docs](https://code.claude.com/docs/en/permissions) — official Anthropic permission system documentation
2. [Configure permissions — Claude Agent SDK](https://platform.claude.com/docs/en/agent-sdk/permissions) — SDK-level permission configuration
3. [Best Practices for Claude Code](https://code.claude.com/docs/en/best-practices) — official Anthropic best practices guide
4. [Automate workflows with hooks](https://code.claude.com/docs/en/hooks-guide) — official hooks documentation
5. [Sandboxing](https://code.claude.com/docs/en/sandboxing) — official sandboxing documentation
6. [Making Claude Code more secure and autonomous](https://www.anthropic.com/engineering/claude-code-sandboxing) — Anthropic engineering blog on sandboxing
7. [Anthropic example settings files](https://github.com/anthropics/claude-code/tree/main/examples/settings) — official starter configs (lax, strict, bash-sandbox)
8. [Claude Code Safety Net plugin](https://github.com/kenryu42/claude-code-safety-net) — community destructive-command hook
9. [Claude Code Security Best Practices — Backslash](https://www.backslash.security/blog/claude-code-security-best-practices) — third-party security analysis
10. [Docker Sandboxes blog](https://www.docker.com/blog/docker-sandboxes-run-claude-code-and-other-coding-agents-unsupervised-but-safely/) — Docker-based isolation approach
11. [Trail of Bits devcontainer](https://github.com/trailofbits/claude-code-devcontainer) — security-focused Docker devcontainer for Claude Code in bypass mode
