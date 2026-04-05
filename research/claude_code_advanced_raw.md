# Claude Code Advanced Features — Raw Documentation

**Status:** RESEARCH — Reference only
**Date:** 2026-03-28
**Sources:** code.claude.com/docs (canonical, docs.anthropic.com redirects here)

---

## Executive Summary

Claude Code documentation has migrated from docs.anthropic.com to code.claude.com. The docs cover 80+ pages. Key advanced features include: a two-tier memory system (CLAUDE.md + auto memory), full GitHub/GitLab CI/CD integration, OpenTelemetry telemetry, extensive model selection with effort levels, headless/programmatic mode via Agent SDK, analytics dashboards for teams, and a comprehensive settings/permissions system. Teams/multi-user features exist via Claude for Teams plan and server-managed settings.

---

## Documentation Index

Source: https://code.claude.com/docs/llms.txt

80+ pages covering:
- Core Concepts: Overview, Quickstart, Desktop quickstart, How Claude Code works
- Configuration: Authentication, Environment variables, Settings, Advanced setup, Terminal config, Keyboard shortcuts
- Extending: Skills, Subagents, Agent teams, Plugins, MCP Integration, Hooks
- Development Features: Code review automation, Common workflows, Interactive mode, Fast mode (Opus 4.6)
- Enterprise: Amazon Bedrock, Google Vertex AI, Microsoft Foundry, GitHub Actions, GitLab CI/CD, Headless/Programmatic (Agent SDK), Analytics, Zero Data Retention (ZDR)
- Advanced: Checkpointing, Memory management, Context window optimization, Cost management, Sandboxing, Remote control, Scheduled tasks, Monitoring/OpenTelemetry, Channels, Slack integration
- Reference: CLI reference, Commands, Tools reference, Hooks reference, Plugins reference, Changelog, Troubleshooting

---

## 1. Memory System

Source: https://code.claude.com/docs/en/memory

### Overview

Two mechanisms carry knowledge across sessions:
1. **CLAUDE.md files** — instructions you write
2. **Auto memory** — notes Claude writes itself

### CLAUDE.md Files

#### Scope / Priority (highest to lowest)

| Scope | Location | Purpose |
|---|---|---|
| Managed policy | macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`; Linux/WSL: `/etc/claude-code/CLAUDE.md`; Windows: `C:\Program Files\ClaudeCode\CLAUDE.md` | Org-wide IT-managed, cannot be excluded |
| Project | `./CLAUDE.md` or `./.claude/CLAUDE.md` | Team-shared via source control |
| User | `~/.claude/CLAUDE.md` | Personal, all projects |

#### Loading Behavior
- Files in directory hierarchy above CWD load in full at launch
- Subdirectory CLAUDE.md files load on demand when Claude reads files there
- Block-level HTML comments stripped before injection (saves tokens)
- `@path/to/file` imports supported — expanded at launch, max 5 hops deep
- `claudeMdExcludes` setting lets you skip specific files by path/glob

#### AGENTS.md Interop
Claude Code reads `CLAUDE.md`, not `AGENTS.md`. To use both:
```markdown
@AGENTS.md

## Claude Code
Use plan mode for changes under `src/billing/`.
```

#### Rules in `.claude/rules/`
- Place `.md` files in `.claude/rules/` for modular topic-specific rules
- Supports path-specific rules via YAML frontmatter:
```markdown
---
paths:
  - "src/api/**/*.ts"
---
# API Development Rules
...
```
- Rules without `paths` load unconditionally
- Supports symlinks for cross-project sharing
- User-level rules: `~/.claude/rules/` (loaded before project rules)

#### Writing Effective Instructions
- Target under 200 lines per CLAUDE.md file
- Use markdown headers/bullets
- Write concise, specific, verifiable instructions
- Avoid conflicting rules across files
- Use `claudeMdExcludes` in `.claude/settings.local.json` for monorepo

#### Organization-wide Deployment
Deploy via MDM, Group Policy, Ansible to managed policy location. Managed CLAUDE.md cannot be excluded.

### Auto Memory

**Requirement:** Claude Code v2.1.59+

Auto memory lets Claude accumulate knowledge without manual writing.

#### Storage
- Per-project: `~/.claude/projects/<project>/memory/`
- Project path derived from git root; all worktrees share one directory
- Custom location: `autoMemoryDirectory` in user/local settings (not project settings)
- Structure:
  ```
  ~/.claude/projects/<project>/memory/
  ├── MEMORY.md          # concise index, loaded first 200 lines/25KB at session start
  ├── debugging.md       # topic files, loaded on demand
  └── api-conventions.md
  ```

#### Behavior
- First 200 lines or 25KB of MEMORY.md loaded at every session start
- Topic files loaded on demand, not at startup
- Enabled by default; toggle with `/memory` or `autoMemoryEnabled: false` in settings
- Disable via env: `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`
- Subagents can have own persistent memory (see sub-agents section)

#### Viewing/Editing
- `/memory` command: lists all CLAUDE.md and rules files loaded, shows auto memory toggle, link to memory folder
- All files are plain markdown — editable/deletable at any time

### Troubleshooting Memory
- CLAUDE.md content delivered as user message after system prompt, not as system prompt
- Run `/memory` to verify files are loaded
- Use `InstructionsLoaded` hook to debug which files loaded and when
- `/compact` — CLAUDE.md fully survives; conversation-only instructions do not
- Use `--append-system-prompt` for system-prompt-level instructions (must pass every invocation)

---

## 2. GitHub Integration

Source: https://code.claude.com/docs/en/github-actions

### Claude Code GitHub Actions

Triggered by `@claude` mentions in PR/issue comments.

#### Quick Setup
1. Run `/install-github-app` from Claude Code terminal (requires repo admin)
2. GitHub app installed, ANTHROPIC_API_KEY added as secret, workflow file copied

OR manual:
1. Install app from https://github.com/apps/claude
2. Add `ANTHROPIC_API_KEY` to repo secrets
3. Copy workflow from `examples/claude.yml` to `.github/workflows/`

#### Basic Workflow
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

#### Action Parameters (v1)
| Parameter | Description | Required |
|---|---|---|
| `prompt` | Instructions for Claude | No* |
| `claude_args` | CLI arguments passed to Claude Code | No |
| `anthropic_api_key` | Claude API key | Yes** |
| `github_token` | GitHub token for API access | No |
| `trigger_phrase` | Custom trigger (default: "@claude") | No |
| `use_bedrock` | Use AWS Bedrock | No |
| `use_vertex` | Use Google Vertex AI | No |

#### Common claude_args
```yaml
claude_args: "--max-turns 5 --model claude-sonnet-4-6 --mcp-config /path/to/config.json"
```

- `--max-turns`: limit conversation turns (default 10)
- `--model`: model to use
- `--allowedTools`: comma-separated allowed tools
- `--debug`: enable debug output
- `--append-system-prompt`: custom instructions

#### Example Use Cases
In issue/PR comments:
```
@claude implement this feature based on the issue description
@claude fix the TypeError in the user dashboard component
@claude review this PR for security vulnerabilities
```

#### Automatic PR review on every PR (no @claude trigger needed)
See GitHub Code Review page: https://code.claude.com/docs/en/code-review

#### AWS Bedrock / Google Vertex AI
Full OIDC-based setup documented — no static keys needed. Separate workflow files for each provider. See source page for complete YAML examples.

#### v1 Breaking Changes (from beta)
| Old Beta Input | New v1.0 Input |
|---|---|
| `mode` | Removed (auto-detected) |
| `direct_prompt` | `prompt` |
| `custom_instructions` | `claude_args: --append-system-prompt` |
| `max_turns` | `claude_args: --max-turns` |
| `model` | `claude_args: --model` |
| `allowed_tools` | `claude_args: --allowedTools` |

### GitLab CI/CD

Source: https://code.claude.com/docs/en/gitlab-ci-cd (beta, maintained by GitLab)

Trigger via `@claude` in MR/issue comments through CI pipeline job.

Basic setup — add to `.gitlab-ci.yml`:
```yaml
stages:
  - ai

claude:
  stage: ai
  image: node:24-alpine3.21
  rules:
    - if: '$CI_PIPELINE_SOURCE == "web"'
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
  before_script:
    - apk add --no-cache git curl bash
    - curl -fsSL https://claude.ai/install.sh | bash
  script:
    - >
      claude
      -p "${AI_FLOW_INPUT:-'Review this MR and implement the requested changes'}"
      --permission-mode acceptEdits
      --allowedTools "Bash Read Edit Write mcp__gitlab"
```

Also supports AWS Bedrock and Google Vertex AI via OIDC (no static credentials).

---

## 3. Teams and Multi-User Features

Source: Inferred from settings, analytics, and monitoring pages

### Analytics Dashboard

Source: https://code.claude.com/docs/en/analytics

| Plan | Dashboard URL | Features |
|---|---|---|
| Teams/Enterprise | claude.ai/analytics/claude-code | Usage metrics, contribution metrics (GitHub integration), leaderboard, CSV export |
| API (Console) | platform.claude.com/claude-code | Usage metrics, spend tracking, team insights |

#### Teams/Enterprise Dashboard Metrics
- Lines of code accepted, suggestion accept rate, daily active users/sessions
- PRs with Claude Code assistance (requires GitHub app)
- Leaderboard: top contributors by usage
- Data export as CSV

#### GitHub Integration for Contribution Metrics
Requires: Owner role + GitHub admin
1. Install Claude GitHub app at github.com/apps/claude
2. Enable Claude Code analytics at claude.ai/admin-settings/claude-code
3. Enable GitHub analytics toggle
4. Complete GitHub auth flow

PRs tagged with `claude-code-assisted` label in GitHub when attribution matches.

Attribution window: 21 days before to 2 days after PR merge. Conservative matching — only high-confidence lines counted.

#### Console (API) Dashboard
- Lines of code accepted, suggestion accept rate, activity chart, spend
- Team insights: per-user spend and lines per month
- Note: spend figures are estimates; billing page for actual costs

### Server-Managed Settings (Teams/Enterprise)

Organizations can deploy centralized settings via:
- **Server-managed**: from Anthropic's servers via Claude.ai admin console
- **MDM/OS-level policies**: macOS managed preferences / Windows registry key
- **File-based**: `managed-settings.json` in system directories
- Drop-in directory at `managed-settings.d/` for multi-team fragments (numeric prefix = merge order)

Managed settings precedence: cannot be overridden by user or project settings.

Key managed-only settings:
- `forceLoginMethod`: restrict to `claudeai` or `console`
- `forceLoginOrgUUID`: auto-select org during login
- `disableBypassPermissionsMode`: block `--dangerously-skip-permissions`
- `allowManagedPermissionRulesOnly`: block user/project permission rules
- `allowManagedMcpServersOnly`: only admin-defined MCP servers apply
- `allowManagedHooksOnly`: block user/project hooks
- `channelsEnabled`: enable channels for Team/Enterprise
- `allowedMcpServers` / `deniedMcpServers`: MCP server allowlist/denylist
- `strictKnownMarketplaces` / `blockedMarketplaces`: plugin marketplace control
- `companyAnnouncements`: startup announcements array

### Rate Limits for Teams

| Team size | TPM per user | RPM per user |
|---|---|---|
| 1-5 | 200k-300k | 5-7 |
| 5-20 | 100k-150k | 2.5-3.5 |
| 20-50 | 50k-75k | 1.25-1.75 |
| 50-100 | 25k-35k | 0.62-0.87 |
| 100-500 | 15k-20k | 0.37-0.47 |
| 500+ | 10k-15k | 0.25-0.35 |

Limits apply at org level, not per user — individuals can burst when others idle.

---

## 4. Headless / Non-Interactive Mode (Agent SDK)

Source: https://code.claude.com/docs/en/headless

### Basic Usage
```bash
claude -p "Find and fix the bug in auth.py" --allowedTools "Read,Edit,Bash"
```

`-p` (or `--print`) = non-interactive mode. All CLI options work.

### Bare Mode
```bash
claude --bare -p "Summarize this file" --allowedTools "Read"
```
- Skips: hooks, skills, plugins, MCP servers, auto memory, CLAUDE.md
- No OAuth/keychain reads — auth must come from `ANTHROPIC_API_KEY` or `apiKeyHelper`
- Recommended for CI/scripts — will become default for `-p` in future release

Bare mode context injection options:
| To load | Use |
|---|---|
| System prompt additions | `--append-system-prompt`, `--append-system-prompt-file` |
| Settings | `--settings <file-or-json>` |
| MCP servers | `--mcp-config <file-or-json>` |
| Custom agents | `--agents <json>` |
| Plugin directory | `--plugin-dir <path>` |

### Structured Output
```bash
claude -p "Summarize this project" --output-format json
```
Output formats: `text` (default), `json`, `stream-json`

With JSON schema:
```bash
claude -p "Extract function names from auth.py" \
  --output-format json \
  --json-schema '{"type":"object","properties":{"functions":{"type":"array","items":{"type":"string"}}},"required":["functions"]}'
```
Structured output in `.structured_output` field of response.

### Streaming
```bash
claude -p "Explain recursion" --output-format stream-json --verbose --include-partial-messages
```
Each line is a JSON event. Filter with jq:
```bash
claude -p "Write a poem" --output-format stream-json --verbose --include-partial-messages | \
  jq -rj 'select(.type == "stream_event" and .event.delta.type? == "text_delta") | .event.delta.text'
```

API retry events emitted as `system/api_retry` events.

### Continue Conversations
```bash
# First request
claude -p "Review this codebase for performance issues"

# Continue most recent
claude -p "Now focus on the database queries" --continue

# Resume specific session
session_id=$(claude -p "Start a review" --output-format json | jq -r '.session_id')
claude -p "Continue that review" --resume "$session_id"
```

### Common Examples
```bash
# Auto-approve tools
claude -p "Run the test suite and fix any failures" --allowedTools "Bash,Read,Edit"

# Create a commit
claude -p "Look at my staged changes and create an appropriate commit" \
  --allowedTools "Bash(git diff *),Bash(git log *),Bash(git status *),Bash(git commit *)"

# Custom system prompt
gh pr diff "$1" | claude -p \
  --append-system-prompt "You are a security engineer. Review for vulnerabilities." \
  --output-format json
```

---

## 5. CI/CD Integration

Source: https://code.claude.com/docs/en/github-actions and https://code.claude.com/docs/en/gitlab-ci-cd

### GitHub Actions
See Section 2 above for full details.

Key patterns:
- `@claude` trigger in PR/issue comments for interactive use
- `prompt` parameter for automated runs (e.g., scheduled)
- `use_bedrock: "true"` or `use_vertex: "true"` for enterprise cloud providers
- OIDC authentication — no long-lived credentials needed

### GitLab CI/CD
See Section 2 above for full details.

Key env vars used in pipeline: `AI_FLOW_INPUT`, `AI_FLOW_CONTEXT`, `AI_FLOW_EVENT`

### General Programmatic Use (Agent SDK)
Full Python and TypeScript SDK packages available at platform.claude.com/docs/en/agent-sdk — provides structured outputs, tool approval callbacks, native message objects.

---

## 6. Telemetry and Analytics

Source: https://code.claude.com/docs/en/monitoring-usage

### OpenTelemetry (OTel) Setup
```bash
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_METRICS_EXPORTER=otlp       # or prometheus, console, none
export OTEL_LOGS_EXPORTER=otlp          # or console, none
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Bearer your-token"
```

Default intervals: 60s metrics, 5s logs.

### Key Environment Variables
| Variable | Description |
|---|---|
| `CLAUDE_CODE_ENABLE_TELEMETRY` | Enable telemetry (required, set to `1`) |
| `OTEL_METRICS_EXPORTER` | `otlp`, `prometheus`, `console`, `none` |
| `OTEL_LOGS_EXPORTER` | `otlp`, `console`, `none` |
| `OTEL_EXPORTER_OTLP_PROTOCOL` | `grpc`, `http/json`, `http/protobuf` |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | Collector endpoint |
| `OTEL_LOG_USER_PROMPTS` | Set `1` to include prompt content (default: off) |
| `OTEL_LOG_TOOL_DETAILS` | Set `1` to log Bash commands, tool inputs (default: off) |
| `OTEL_METRIC_EXPORT_INTERVAL` | ms, default 60000 |
| `OTEL_LOGS_EXPORT_INTERVAL` | ms, default 5000 |
| `OTEL_METRICS_INCLUDE_SESSION_ID` | Include session.id in metrics (default: true) |
| `OTEL_METRICS_INCLUDE_VERSION` | Include app.version (default: false) |
| `OTEL_METRICS_INCLUDE_ACCOUNT_UUID` | Include user account UUIDs (default: true) |
| `OTEL_RESOURCE_ATTRIBUTES` | `dept=eng,team=platform` — custom org attributes |

### Available Metrics
| Metric | Description | Unit |
|---|---|---|
| `claude_code.session.count` | Sessions started | count |
| `claude_code.lines_of_code.count` | Lines modified (type: added/removed) | count |
| `claude_code.pull_request.count` | PRs created | count |
| `claude_code.commit.count` | Git commits created | count |
| `claude_code.cost.usage` | Cost per session | USD |
| `claude_code.token.usage` | Tokens used (type: input/output/cacheRead/cacheCreation) | tokens |
| `claude_code.code_edit_tool.decision` | Edit tool accept/reject decisions | count |
| `claude_code.active_time.total` | Active time (type: user/cli) | s |

### Available Events (via `OTEL_LOGS_EXPORTER`)
- `claude_code.user_prompt` — when user submits prompt
- `claude_code.tool_result` — when tool completes (includes duration_ms, success, decision_source)
- `claude_code.api_request` — each API call to Claude (model, cost_usd, input/output tokens, speed)
- `claude_code.api_error` — failed API requests
- `claude_code.tool_decision` — permission accept/reject decisions

`prompt.id` UUID attribute correlates all events from a single prompt.

### Enterprise / Multi-Team Support
- Set custom attributes: `OTEL_RESOURCE_ATTRIBUTES="department=eng,team.id=platform"`
- Dynamic authentication headers via `otelHeadersHelper` script in settings
- Administrator can set all OTel config via managed settings file

### Backend Recommendations
- Metrics: Prometheus, ClickHouse, Honeycomb, Datadog
- Logs/Events: Elasticsearch, Loki, ClickHouse

### Analytics Dashboard (Teams)
Source: https://code.claude.com/docs/en/analytics

See Section 3 for full details.

---

## 7. Debugging and Troubleshooting

Source: https://code.claude.com/docs/en/troubleshooting

### /doctor Command
Checks:
- Installation type, version, search functionality
- Auto-update status
- Invalid settings files (malformed JSON, wrong types)
- MCP server configuration errors
- Keybinding configuration
- Context usage warnings (large CLAUDE.md, high MCP token usage, unreachable permission rules)
- Plugin and agent loading errors

### Configuration File Locations
| File | Purpose |
|---|---|
| `~/.claude/settings.json` | User settings (permissions, hooks, model) |
| `.claude/settings.json` | Project settings (source-controlled) |
| `.claude/settings.local.json` | Local project settings (not committed) |
| `~/.claude.json` | Global state (theme, OAuth, MCP servers) |
| `.mcp.json` | Project MCP servers |
| `managed-mcp.json` | Managed MCP servers |

### Common Issues

**command not found: claude** — PATH issue, install dir not in PATH
- macOS/Linux: add `~/.local/bin` to PATH
- Windows: add `%USERPROFILE%\.local\bin` to User PATH

**Authentication Issues**
- Run `/logout`, close, restart, re-authenticate
- `ANTHROPIC_API_KEY` set in environment overrides subscription OAuth credentials
- 403 Forbidden: check subscription active, correct role assigned
- "Organization has been disabled": old `ANTHROPIC_API_KEY` overriding subscription

**Performance**
- Use `/compact` regularly to reduce context
- Close/restart between major tasks
- Add build dirs to `.gitignore`

**Search not working** — install system ripgrep; set `USE_BUILTIN_RIPGREP=0`

**WSL-specific**
- Slow search: work on Linux filesystem `/home/` not `/mnt/c/`
- JetBrains IDE not detected: WSL networking issue (firewall rule or `networkingMode=mirrored`)
- nvm conflicts: ensure Linux node/npm takes PATH priority

**Resetting configuration**
```bash
rm ~/.claude.json
rm -rf ~/.claude/
rm -rf .claude/
rm .mcp.json
```

---

## 8. Extended Thinking / Thinking Mode

Source: https://code.claude.com/docs/en/model-config (effort level section)

### Effort Levels
Controls adaptive reasoning, dynamically allocating thinking based on task complexity.

| Level | Behavior | Notes |
|---|---|---|
| `low` | Fast, minimal thinking | Simple tasks |
| `medium` | Default — balanced | Recommended for most coding |
| `high` | Deeper reasoning | Hard debugging, architecture |
| `max` | Deepest, no token limit | Opus 4.6 only, does not persist |

Supported on Opus 4.6 and Sonnet 4.6. Default: medium.

### Setting Effort
- `/effort low|medium|high|max|auto` — change mid-session
- `--effort` flag at startup
- `CLAUDE_CODE_EFFORT_LEVEL=low|medium|high|max|auto` env var (highest priority)
- `effortLevel` in settings.json: `"low"`, `"medium"`, `"high"` (persists)
- In `/model` picker: left/right arrows to adjust slider
- In skill/subagent frontmatter: `effort:` field

Include "ultrathink" in prompt to trigger high effort for one turn without changing session setting.

### Extended Thinking Toggle
- `/config` → toggle extended thinking
- `alwaysThinkingEnabled: true` in settings
- `Option+T` (macOS) / `Alt+T` keyboard shortcut (requires `/terminal-setup`)
- `MAX_THINKING_TOKENS=8000` to lower thinking budget
- `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1` to revert to fixed budget

### `opusplan` Special Mode
Uses Opus during plan mode, switches to Sonnet for execution. Best of both worlds.

---

## 9. Model Selection and Configuration

Source: https://code.claude.com/docs/en/model-config

### Model Aliases
| Alias | Behavior |
|---|---|
| `default` | Recommended based on account type |
| `sonnet` | Latest Sonnet (currently 4.6) — daily coding |
| `opus` | Latest Opus (currently 4.6) — complex reasoning |
| `haiku` | Fast, efficient — simple tasks |
| `sonnet[1m]` | Sonnet with 1M token context |
| `opus[1m]` | Opus with 1M token context |
| `opusplan` | Opus in plan mode → Sonnet in execution |

### Setting the Model (priority order)
1. `/model <alias|name>` during session
2. `claude --model <alias|name>` at startup
3. `ANTHROPIC_MODEL=<alias|name>` env var
4. `model` field in settings.json

### Default Model by Plan
- Max/Team Premium: Opus 4.6
- Pro/Team Standard: Sonnet 4.6
- Enterprise: Opus 4.6 available but not default

### Extended Context (1M Token)
| Plan | Opus 4.6 1M | Sonnet 4.6 1M |
|---|---|---|
| Max, Team, Enterprise | Included | Extra usage |
| Pro | Extra usage | Extra usage |
| API/pay-as-you-go | Full access | Full access |

Use `opus[1m]`, `sonnet[1m]`, or append `[1m]` to full model name.

Disable: `CLAUDE_CODE_DISABLE_1M_CONTEXT=1`

### Enterprise Model Configuration

**Pin models for third-party providers (Bedrock/Vertex/Foundry):**
```bash
export ANTHROPIC_DEFAULT_OPUS_MODEL='us.anthropic.claude-opus-4-6-v1'
export ANTHROPIC_DEFAULT_SONNET_MODEL='us.anthropic.claude-sonnet-4-6'
export ANTHROPIC_DEFAULT_HAIKU_MODEL='us.anthropic.claude-haiku-4-5'
```

**Custom model option for gateway:**
```bash
export ANTHROPIC_CUSTOM_MODEL_OPTION="my-gateway/claude-opus-4-6"
export ANTHROPIC_CUSTOM_MODEL_OPTION_NAME="Opus via Gateway"
```

**Restrict available models (managed settings):**
```json
{
  "availableModels": ["sonnet", "haiku"]
}
```

**Model ID overrides per version:**
```json
{
  "modelOverrides": {
    "claude-opus-4-6": "arn:aws:bedrock:us-east-2:123456789012:application-inference-profile/opus-prod"
  }
}
```

**Declare capabilities for provider-specific IDs:**
```bash
export ANTHROPIC_DEFAULT_OPUS_MODEL_SUPPORTED_CAPABILITIES='effort,max_effort,thinking,adaptive_thinking,interleaved_thinking'
```
Capability values: `effort`, `max_effort`, `thinking`, `adaptive_thinking`, `interleaved_thinking`

### Prompt Caching
Auto-enabled. Disable globally or per model tier:
| Env Var | Effect |
|---|---|
| `DISABLE_PROMPT_CACHING=1` | Disable all caching |
| `DISABLE_PROMPT_CACHING_HAIKU=1` | Disable for Haiku only |
| `DISABLE_PROMPT_CACHING_SONNET=1` | Disable for Sonnet only |
| `DISABLE_PROMPT_CACHING_OPUS=1` | Disable for Opus only |

---

## 10. Keyboard Shortcuts and Keybindings

Source: https://code.claude.com/docs/en/interactive-mode

### macOS Option Key Note
Option/Alt shortcuts require configuring Option as Meta in terminal:
- iTerm2: settings → Profiles → Keys → Left/Right Option key = "Esc+"
- Terminal.app: settings → Profiles → Keyboard → "Use Option as Meta Key"

### General Controls
| Shortcut | Description |
|---|---|
| `Ctrl+C` | Cancel current input or generation |
| `Ctrl+X Ctrl+K` | Kill all background agents (press twice in 3s to confirm) |
| `Ctrl+D` | Exit session |
| `Ctrl+G` or `Ctrl+X Ctrl+E` | Open in default text editor |
| `Ctrl+L` | Clear terminal screen (keeps history) |
| `Ctrl+O` | Toggle verbose output |
| `Ctrl+R` | Reverse search command history |
| `Ctrl+V` / `Cmd+V` / `Alt+V` | Paste image from clipboard |
| `Ctrl+B` | Background running tasks (tmux: press twice) |
| `Ctrl+T` | Toggle task list |
| `Left/Right arrows` | Cycle dialog tabs |
| `Up/Down arrows` | Navigate command history |
| `Esc` + `Esc` | Rewind/summarize (restore to checkpoint or summarize) |
| `Shift+Tab` or `Alt+M` | Cycle permission modes (default → acceptEdits → plan → auto) |
| `Option+P` / `Alt+P` | Switch model (without clearing prompt) |
| `Option+T` / `Alt+T` | Toggle extended thinking |
| `Option+O` / `Alt+O` | Toggle fast mode |
| `?` | Show available shortcuts for environment |

### Text Editing
| Shortcut | Description |
|---|---|
| `Ctrl+K` | Delete to end of line |
| `Ctrl+U` | Delete from cursor to line start |
| `Ctrl+Y` | Paste deleted text |
| `Alt+Y` (after Ctrl+Y) | Cycle paste history |
| `Alt+B` | Move back one word |
| `Alt+F` | Move forward one word |

### Multiline Input
| Method | Shortcut |
|---|---|
| Quick escape | `\` + Enter (all terminals) |
| macOS default | `Option+Enter` |
| Shift+Enter | Works in iTerm2, WezTerm, Ghostty, Kitty |
| Other terminals | Run `/terminal-setup` to install binding |
| Control sequence | `Ctrl+J` |

### Quick Commands (Input Prefix)
| Prefix | Action |
|---|---|
| `/` | Command or skill |
| `!` | Bash mode (adds output to context, supports Tab autocomplete from history) |
| `@` | File path mention/autocomplete |

### Vim Mode
Enable with `/vim` or configure via `/config`.

Normal mode navigation: `h/j/k/l`, `w/e/b`, `0/$`, `gg/G`, `f{char}/F{char}/t{char}/T{char}`
Normal mode editing: `x`, `dd/D`, `cc/C`, `yy/Y`, `p/P`, `>>/<<`, `J`, `.`
Text objects: `iw/aw`, `i"/a"`, `i(/a(`, etc.
Mode switch: `Esc` → NORMAL, `i/I/a/A/o/O` → INSERT

### Transcript Viewer (when Ctrl+O active)
| Shortcut | Description |
|---|---|
| `Ctrl+E` | Toggle show all content |
| `q`, `Ctrl+C`, `Esc` | Exit transcript view |

---

## 11. Cost Tracking and Usage

Source: https://code.claude.com/docs/en/costs

### Average Costs
- Average: ~$6/developer/day
- 90% of users: under $12/day
- Team average: ~$100-200/developer/month with Sonnet 4.6

### `/cost` Command
Shows current session token stats:
```
Total cost:            $0.55
Total duration (API):  6m 19.7s
Total duration (wall): 6h 33m 10.2s
Total code changes:    0 lines added, 0 lines removed
```
Note: `/cost` is for API users. Claude Max/Pro subscribers use `/stats` for usage patterns.

### Team Spend Management
- Set workspace spend limits in Claude Console: platform.claude.com
- "Claude Code" workspace auto-created on first auth — centralized cost tracking
- Bedrock/Vertex/Foundry: use LiteLLM for spend tracking (open-source, unaffiliated)

### Cost Reduction Strategies

**Context management:**
- `/clear` between unrelated tasks
- `/compact Focus on code samples and API usage` for custom compaction
- Add compaction instructions to CLAUDE.md:
  ```markdown
  # Compact instructions
  When using compact, focus on test output and code changes
  ```

**Model selection:**
- `/model` to switch mid-session
- Use Sonnet for most tasks; reserve Opus for complex reasoning
- Use `model: haiku` in subagent frontmatter for simple tasks

**Reduce MCP overhead:**
- MCP tool definitions deferred by default (only names in context)
- `/context` to see context usage
- Prefer CLI tools (`gh`, `aws`, `gcloud`) over MCP servers — zero context overhead
- Disable unused MCP servers via `/mcp`

**Hooks for preprocessing:**
Filter test output example (PreToolUse hook):
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{"type": "command", "command": "~/.claude/hooks/filter-test-output.sh"}]
    }]
  }
}
```

**Skills vs CLAUDE.md:**
- Move specialized workflow instructions from CLAUDE.md to skills (load on-demand)
- Keep CLAUDE.md under ~500 lines

**Extended thinking:**
- Disable for simple tasks: `/config` → disable thinking, or `MAX_THINKING_TOKENS=8000`
- Use `/effort low` for simpler work

**Agent teams cost:**
- ~7x more tokens than standard sessions
- Use Sonnet for teammates
- Keep teams small, tasks focused
- Active teammates consume tokens even when idle
- Enabled via `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`

**Background token usage (idle):**
- Conversation summarization (for `--resume`)
- Some commands like `/cost` generate requests
- Typically under $0.04/session

---

## 12. Context Window Management

Source: https://code.claude.com/docs/en/context-window (interactive visualization), costs page

### Context Window Startup Load Order
1. System prompt (~4200 tokens, hidden)
2. Auto memory/MEMORY.md (~680 tokens)
3. Environment info (~280 tokens — working dir, platform, shell, git status)
4. MCP tool names (deferred by default — only names, not schemas)
5. CLAUDE.md files (user → project → parent dirs)
6. Skills (on-demand only)

### /compact Command
```
/compact                          # compact with auto summary
/compact Focus on code samples    # custom compaction focus
```
CLAUDE.md fully survives compaction — re-read from disk and re-injected. Conversation-only instructions do not survive.

### /clear Command
Start fresh context. Previous session preserved and resumable. `/rename` first to find session later.

### Context Visualization
Interactive visualization at: https://code.claude.com/docs/en/context-window
Shows where each component loads relative to 200K context window.

### Status Line Context Display
Configure `statusLine` in settings to display context usage continuously. See: https://code.claude.com/docs/en/statusline

### Auto-Compaction
- Triggers automatically at ~95% context capacity
- `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50` to trigger earlier (e.g., at 50%)
- Background conversation summarization for `--resume`
- Subagents support same auto-compaction logic

---

## 13. Settings System (Complete Reference)

Source: https://code.claude.com/docs/en/settings

### Scope Hierarchy (highest to lowest priority)
1. Managed (cannot be overridden)
2. Command line arguments (session-only)
3. Local (`.claude/settings.local.json`)
4. Project (`.claude/settings.json`)
5. User (`~/.claude/settings.json`)

### Settings Files
| File | Scope | Source-controlled |
|---|---|---|
| `~/.claude/settings.json` | User | No |
| `.claude/settings.json` | Project | Yes |
| `.claude/settings.local.json` | Local | No (gitignored) |
| `managed-settings.json` (system dir) | Managed | N/A |
| `~/.claude.json` | Global state | No |

JSON schema: `https://json.schemastore.org/claude-code-settings.json`

### Key Settings (in settings.json)
| Key | Description |
|---|---|
| `apiKeyHelper` | Script to generate API key dynamically |
| `autoMemoryEnabled` | Enable/disable auto memory |
| `autoMemoryDirectory` | Custom memory directory |
| `cleanupPeriodDays` | Session cleanup period (0 = disable persistence) |
| `companyAnnouncements` | Startup announcements array |
| `env` | Session environment variables |
| `attribution` | Git commit/PR attribution strings |
| `permissions` | allow/ask/deny/additionalDirectories/defaultMode rules |
| `autoMode` | Auto mode classifier config |
| `disableAutoMode` | Disable auto mode entirely |
| `hooks` | Lifecycle hooks config |
| `defaultShell` | `"bash"` or `"powershell"` |
| `disableAllHooks` | Disable all hooks |
| `model` | Default model override |
| `availableModels` | Restrict model selection |
| `modelOverrides` | Map model IDs to provider-specific IDs |
| `effortLevel` | Persist effort level (`low`/`medium`/`high`) |
| `otelHeadersHelper` | Script for dynamic OTel headers |
| `statusLine` | Custom status line config |
| `alwaysThinkingEnabled` | Always-on extended thinking |
| `plansDirectory` | Custom plan storage dir |
| `language` | Claude response language (e.g., `"japanese"`) |
| `voiceEnabled` | Enable push-to-talk dictation |
| `autoUpdatesChannel` | `"stable"` or `"latest"` (default) |
| `forceLoginMethod` | `claudeai` or `console` |
| `forceLoginOrgUUID` | Auto-select org UUID |
| `feedbackSurveyRate` | 0-1 probability for session quality survey |
| `spinnerTipsEnabled` | Show/hide tips during processing |
| `prefersReducedMotion` | Reduce UI animations |
| `fastModePerSessionOptIn` | Require per-session opt-in for fast mode |
| `sandbox.enabled` | Enable bash sandboxing |
| `worktree.symlinkDirectories` | Dirs to symlink in worktrees |
| `worktree.sparsePaths` | Sparse checkout paths for worktrees |

### Global Config (in ~/.claude.json, NOT settings.json)
| Key | Description |
|---|---|
| `autoConnectIde` | Auto-connect to IDE on startup |
| `autoInstallIdeExtension` | Auto-install VS Code extension |
| `editorMode` | `"normal"` or `"vim"` |
| `showTurnDuration` | Show "Cooked for 1m 6s" after responses |
| `terminalProgressBarEnabled` | Progress bar in supported terminals |
| `teammateMode` | `auto`, `in-process`, or `tmux` |

### Permission Rule Syntax
Format: `Tool` or `Tool(specifier)`
- `Bash` — all Bash commands
- `Bash(npm run *)` — commands starting with "npm run"
- `Read(./.env)` — reading .env file
- `WebFetch(domain:example.com)` — fetch to example.com
- `Agent(subagent-name)` — spawning specific subagent

Rules evaluated: deny → ask → allow (first match wins)

---

## 14. Subagents (Custom Agents)

Source: https://code.claude.com/docs/en/sub-agents

### Built-in Subagents
- **Explore** — Haiku, read-only, codebase search
- **Plan** — inherits model, read-only, plan mode research
- **General-purpose** — inherits model, all tools, complex multi-step
- **Bash** — runs terminal commands in separate context
- **statusline-setup** — Sonnet, for `/statusline` config
- **Claude Code Guide** — Haiku, answers Claude Code feature questions

### Creating Subagents
Markdown files with YAML frontmatter + system prompt body.

Locations (priority order):
1. `--agents` CLI flag (session only, JSON)
2. `.claude/agents/` (project scope)
3. `~/.claude/agents/` (user scope, all projects)
4. Plugin `agents/` directory

### Frontmatter Fields
| Field | Required | Description |
|---|---|---|
| `name` | Yes | Unique ID (lowercase, hyphens) |
| `description` | Yes | When Claude should delegate |
| `tools` | No | Allowlist of tools (inherits all if omitted) |
| `disallowedTools` | No | Denylist |
| `model` | No | `sonnet`, `opus`, `haiku`, full ID, or `inherit` |
| `permissionMode` | No | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | No | Max agentic turns |
| `skills` | No | Skills to preload into subagent context |
| `mcpServers` | No | MCP servers for this subagent (inline or by name) |
| `hooks` | No | Lifecycle hooks scoped to this subagent |
| `memory` | No | Persistent memory: `user`, `project`, `local` |
| `background` | No | Always run as background task |
| `effort` | No | Effort level override |
| `isolation` | No | `worktree` = isolated git worktree |
| `initialPrompt` | No | Auto-submitted first turn (when used as main agent) |

### Invoking Subagents
- Natural language: "Use the code-reviewer subagent to..."
- @-mention: `@"code-reviewer (agent)"` — guarantees that agent
- Session-wide: `claude --agent code-reviewer`
- Default: set `agent` in `.claude/settings.json`

### Background vs Foreground
- **Foreground**: blocks main conversation, permission prompts pass through
- **Background**: concurrent, pre-approves permissions, ignores clarifying questions
- `Ctrl+B` to background a running task
- Disable: `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1`

### Persistent Memory
- `memory: user` → `~/.claude/agent-memory/<name>/`
- `memory: project` → `.claude/agent-memory/<name>/` (recommended, version-controllable)
- `memory: local` → `.claude/agent-memory-local/<name>/`
- First 200 lines/25KB of MEMORY.md loaded at subagent start

### Disable Specific Subagents
```json
{
  "permissions": {
    "deny": ["Agent(Explore)", "Agent(my-custom-agent)"]
  }
}
```

---

## 15. CLI Reference (All Flags)

Source: https://code.claude.com/docs/en/cli-reference

### CLI Commands
| Command | Description |
|---|---|
| `claude` | Start interactive session |
| `claude "query"` | Start with initial prompt |
| `claude -p "query"` | Non-interactive, then exit |
| `cat file \| claude -p "query"` | Process piped content |
| `claude -c` | Continue most recent conversation |
| `claude -r "<session>" "query"` | Resume session by ID or name |
| `claude update` | Update to latest version |
| `claude auth login` | Sign in (flags: `--email`, `--sso`, `--console`) |
| `claude auth logout` | Log out |
| `claude auth status` | Show auth status (JSON; `--text` for human-readable) |
| `claude agents` | List all configured subagents |
| `claude auto-mode defaults` | Print auto mode classifier rules |
| `claude mcp` | Configure MCP servers |
| `claude plugin` | Manage plugins |
| `claude remote-control` | Start Remote Control server |

### CLI Flags (Selected Key Ones)
| Flag | Description |
|---|---|
| `--add-dir` | Additional working directories |
| `--agent` | Run session as named subagent |
| `--agents` | Define subagents inline as JSON |
| `--allowedTools` | Tools that execute without permission prompt |
| `--append-system-prompt` | Append to default system prompt |
| `--bare` | Minimal mode, skip all auto-discovery |
| `--betas` | Beta headers for API requests |
| `--chrome` | Enable Chrome browser integration |
| `--continue`, `-c` | Load most recent conversation |
| `--dangerously-skip-permissions` | Skip permission prompts |
| `--debug` | Debug mode with optional category filter |
| `--disable-slash-commands` | Disable all skills/commands |
| `--disallowedTools` | Remove tools from model context |
| `--effort` | Set effort level (`low/medium/high/max`) |
| `--fallback-model` | Fallback when default overloaded (print mode) |
| `--fork-session` | New session ID when resuming |
| `--from-pr` | Resume sessions linked to GitHub PR |
| `--include-partial-messages` | Include partial streaming events |
| `--json-schema` | Validated JSON output matching schema |
| `--max-budget-usd` | Max spend limit (print mode) |
| `--max-turns` | Limit agentic turns (print mode) |
| `--mcp-config` | Load MCP servers from JSON |
| `--model` | Set model for session |
| `--name`, `-n` | Set session display name |
| `--no-session-persistence` | Don't save session (print mode) |
| `--output-format` | `text`, `json`, `stream-json` |
| `--enable-auto-mode` | Unlock auto mode (Team plan) |
| `--permission-mode` | Start in specified permission mode |
| `--print`, `-p` | Non-interactive print mode |
| `--remote` | Create web session on claude.ai |
| `--remote-control`, `--rc` | Enable Remote Control |
| `--resume`, `-r` | Resume session by ID/name |
| `--session-id` | Use specific session UUID |
| `--settings` | Load settings from file or JSON string |
| `--strict-mcp-config` | Only use MCP from `--mcp-config` |
| `--system-prompt` | Replace entire system prompt |
| `--system-prompt-file` | Replace system prompt from file |
| `--teleport` | Resume web session in local terminal |
| `--tools` | Restrict available built-in tools |
| `--verbose` | Show full turn-by-turn output |
| `--version`, `-v` | Output version number |
| `--worktree`, `-w` | Start in isolated git worktree |
| `--tmux` | Create tmux session for worktree |

---

## 16. Subagent Memory (for Completeness)

Covered above in Section 14. Key point:
- Subagents can maintain their own `MEMORY.md` + topic files
- Loaded into subagent context at startup (first 200 lines/25KB)
- Scope: `user`, `project`, or `local`

---

## Bidirectional Search

- **Searched FOR:** Claude Code memory system docs, GitHub integration docs, teams features, headless mode, CI/CD, telemetry OTel, troubleshooting, extended thinking, model config, keyboard shortcuts, cost tracking, context window
- **Searched AGAINST:** Searched for page-not-found results (bedrock/vertex/teams pages 404'd — those topics covered in other pages), checked for contradictions in redirect chain (docs.anthropic.com → code.claude.com confirmed for all pages)
- **Contradicting evidence found:** No contradictions found. bedrock/vertex URLs 404'd but those provider features documented within model-config page and github-actions page. `teams` page 404'd — teams features distributed across analytics, settings, monitoring pages.

---

## Sources

1. https://code.claude.com/docs/llms.txt — documentation index
2. https://code.claude.com/docs/en/memory — memory system
3. https://code.claude.com/docs/en/github-actions — GitHub Actions integration
4. https://code.claude.com/docs/en/gitlab-ci-cd — GitLab CI/CD integration
5. https://code.claude.com/docs/en/headless — headless/programmatic mode
6. https://code.claude.com/docs/en/troubleshooting — troubleshooting
7. https://code.claude.com/docs/en/costs — cost tracking
8. https://code.claude.com/docs/en/settings — settings system
9. https://code.claude.com/docs/en/model-config — model configuration
10. https://code.claude.com/docs/en/analytics — analytics dashboard
11. https://code.claude.com/docs/en/monitoring-usage — OpenTelemetry monitoring
12. https://code.claude.com/docs/en/github-actions — GitHub Actions
13. https://code.claude.com/docs/en/cli-reference — CLI reference
14. https://code.claude.com/docs/en/interactive-mode — keyboard shortcuts
15. https://code.claude.com/docs/en/sub-agents — subagents
16. https://code.claude.com/docs/en/context-window — context window visualization

---

## Follow-up Tasks Created

None — this was a standalone research data-gathering task. Downstream synthesis handled by other tasks in DAG.
