# Claude Agent SDK — Raw Documentation Capture

**Status:** RESEARCH — Reference only
**Date:** 2026-03-28
**Task:** 4 — Research Claude Agent SDK and API documentation

---

## IMPORTANT: SDK Rename

> The Claude Code SDK has been renamed to the **Claude Agent SDK**.
> - npm package: `@anthropic-ai/claude-agent-sdk`
> - pip package: `claude-agent-sdk`
> - Migration guide: https://platform.claude.com/docs/en/agent-sdk/migration-guide

---

## URL MAP (Canonical Locations)

All docs.anthropic.com/en/docs/claude-code/sdk/* URLs now redirect through:
- `docs.anthropic.com` → `code.claude.com` (301) → `docs.claude.com` (301) → `platform.claude.com` (302)

**Canonical base:** `https://platform.claude.com/docs/en/agent-sdk/`

Key pages:
- Overview: https://platform.claude.com/docs/en/agent-sdk/overview
- Quickstart: https://platform.claude.com/docs/en/agent-sdk/quickstart
- TypeScript ref: https://platform.claude.com/docs/en/agent-sdk/typescript
- Python ref: https://platform.claude.com/docs/en/agent-sdk/python
- Custom tools: https://platform.claude.com/docs/en/agent-sdk/custom-tools
- Subagents: https://platform.claude.com/docs/en/agent-sdk/subagents
- Slash commands: https://platform.claude.com/docs/en/agent-sdk/slash-commands

**Claude Code docs base:** `https://code.claude.com/docs/en/`

Key pages:
- Overview: https://code.claude.com/docs (redirects to overview)
- Sub-agents (file-based): https://code.claude.com/docs/en/sub-agents
- Claude Code overview: https://code.claude.com/docs (content captured below)

**Anthropic API tool-use:** https://platform.claude.com/docs/en/docs/build-with-claude/tool-use (captures below)

---

## SOURCE 1: Agent SDK Overview

**URL:** https://platform.claude.com/docs/en/agent-sdk/overview

### Agent SDK overview

Build production AI agents with Claude Code as a library

---

The Claude Code SDK has been renamed to the Claude Agent SDK.

Build AI agents that autonomously read files, run commands, search the web, edit code, and more. The Agent SDK gives you the same tools, agent loop, and context management that power Claude Code, programmable in Python and TypeScript.

```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

async def main():
    async for message in query(
        prompt="Find and fix the bug in auth.py",
        options=ClaudeAgentOptions(allowed_tools=["Read", "Edit", "Bash"]),
    ):
        print(message)

asyncio.run(main())
```

```typescript
import { query } from "@anthropic-ai/claude-agent-sdk";

for await (const message of query({
  prompt: "Find and fix the bug in auth.py",
  options: { allowedTools: ["Read", "Edit", "Bash"] }
})) {
  console.log(message);
}
```

### Installation

TypeScript: `npm install @anthropic-ai/claude-agent-sdk`
Python: `pip install claude-agent-sdk`

### Authentication

```bash
export ANTHROPIC_API_KEY=your-api-key
```

Third-party providers:
- Amazon Bedrock: set `CLAUDE_CODE_USE_BEDROCK=1`
- Google Vertex AI: set `CLAUDE_CODE_USE_VERTEX=1`
- Microsoft Azure: set `CLAUDE_CODE_USE_FOUNDRY=1`

### Built-in Tools

| Tool | What it does |
|------|--------------|
| Read | Read any file in the working directory |
| Write | Create new files |
| Edit | Make precise edits to existing files |
| Bash | Run terminal commands, scripts, git operations |
| Glob | Find files by pattern (`**/*.ts`, `src/**/*.py`) |
| Grep | Search file contents with regex |
| WebSearch | Search the web for current information |
| WebFetch | Fetch and parse web page content |
| AskUserQuestion | Ask the user clarifying questions with multiple choice options |

### Capabilities Summary

- **Built-in tools**: Read, Write, Edit, Bash, Glob, Grep, WebSearch, WebFetch, AskUserQuestion
- **Hooks**: PreToolUse, PostToolUse, Stop, SessionStart, SessionEnd, UserPromptSubmit
- **Subagents**: Spawn specialized agents via `agents` parameter + `Agent` in `allowedTools`
- **MCP**: Connect external systems via Model Context Protocol
- **Permissions**: allowedTools, disallowedTools, permissionMode, canUseTool callback
- **Sessions**: Resume sessions via `resume: sessionId`, fork sessions

### Agent SDK vs Client SDK Comparison

```python
# Client SDK: You implement the tool loop
response = client.messages.create(...)
while response.stop_reason == "tool_use":
    result = your_tool_executor(response.tool_use)
    response = client.messages.create(tool_result=result, **params)

# Agent SDK: Claude handles tools autonomously
async for message in query(prompt="Fix the bug in auth.py"):
    print(message)
```

### Agent SDK vs Claude Code CLI

| Use case | Best choice |
|----------|-------------|
| Interactive development | CLI |
| CI/CD pipelines | SDK |
| Custom applications | SDK |
| One-off tasks | CLI |
| Production automation | SDK |

### Claude Code Features Available in SDK

Set `setting_sources=["project"]` (Python) or `settingSources: ['project']` (TypeScript):

| Feature | Description | Location |
|---------|-------------|----------|
| Skills | Specialized capabilities defined in Markdown | `.claude/skills/*/SKILL.md` |
| Slash commands | Custom commands for common tasks | `.claude/commands/*.md` |
| Memory | Project context and instructions | `CLAUDE.md` or `.claude/CLAUDE.md` |
| Plugins | Extend with custom commands, agents, and MCP servers | Programmatic via `plugins` option |

### Branding Guidelines

Allowed:
- "Claude Agent" (preferred)
- "Claude" (within a menu already labeled "Agents")
- "{YourAgentName} Powered by Claude"

Not permitted:
- "Claude Code" or "Claude Code Agent"
- Claude Code-branded ASCII art

### GitHub Repos
- TypeScript SDK: https://github.com/anthropics/claude-agent-sdk-typescript
- Python SDK: https://github.com/anthropics/claude-agent-sdk-python
- Demo agents: https://github.com/anthropics/claude-agent-sdk-demos

---

## SOURCE 2: Agent SDK Quickstart

**URL:** https://platform.claude.com/docs/en/agent-sdk/quickstart

### Install

```bash
# TypeScript
npm install @anthropic-ai/claude-agent-sdk

# Python (uv)
uv init && uv add claude-agent-sdk

# Python (pip)
python3 -m venv .venv && source .venv/bin/activate
pip3 install claude-agent-sdk
```

### Minimal Bug-Fix Agent

```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions, AssistantMessage, ResultMessage

async def main():
    async for message in query(
        prompt="Review utils.py for bugs that would cause crashes. Fix any issues you find.",
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Edit", "Glob"],
            permission_mode="acceptEdits",
        ),
    ):
        if isinstance(message, AssistantMessage):
            for block in message.content:
                if hasattr(block, "text"):
                    print(block.text)
                elif hasattr(block, "name"):
                    print(f"Tool: {block.name}")
        elif isinstance(message, ResultMessage):
            print(f"Done: {message.subtype}")

asyncio.run(main())
```

```typescript
import { query } from "@anthropic-ai/claude-agent-sdk";

for await (const message of query({
  prompt: "Review utils.py for bugs that would cause crashes. Fix any issues you find.",
  options: {
    allowedTools: ["Read", "Edit", "Glob"],
    permissionMode: "acceptEdits"
  }
})) {
  if (message.type === "assistant" && message.message?.content) {
    for (const block of message.message.content) {
      if ("text" in block) console.log(block.text);
      else if ("name" in block) console.log(`Tool: ${block.name}`);
    }
  } else if (message.type === "result") {
    console.log(`Done: ${message.subtype}`);
  }
}
```

### Tool Combinations

| Tools | What the agent can do |
|-------|----------------------|
| `Read`, `Glob`, `Grep` | Read-only analysis |
| `Read`, `Edit`, `Glob` | Analyze and modify code |
| `Read`, `Edit`, `Bash`, `Glob`, `Grep` | Full automation |

### Permission Modes

| Mode | Behavior | Use case |
|------|----------|----------|
| `acceptEdits` | Auto-approves file edits, asks for other actions | Trusted development |
| `dontAsk` (TypeScript only) | Denies anything not in `allowedTools` | Locked-down headless |
| `bypassPermissions` | Runs every tool without prompts | Sandboxed CI |
| `default` | Requires a `canUseTool` callback | Custom approval flows |

---

## SOURCE 3: Agent SDK — TypeScript API Reference

**URL:** https://platform.claude.com/docs/en/agent-sdk/typescript

Note: Full reference is 71.4KB. Key content captured below.

Note: TypeScript V2 preview available with `send()` and `stream()` patterns. See https://platform.claude.com/docs/en/agent-sdk/typescript-v2-preview

### `query()` function

```typescript
function query({
  prompt,
  options
}: {
  prompt: string | AsyncIterable<SDKUserMessage>;
  options?: Options;
}): Query;
```

Returns a `Query` object extending `AsyncGenerator<SDKMessage, void>`.

### `tool()` function

```typescript
function tool<Schema extends AnyZodRawShape>(
  name: string,
  description: string,
  inputSchema: Schema,
  handler: (args: InferShape<Schema>, extra: unknown) => Promise<CallToolResult>,
  extras?: { annotations?: ToolAnnotations }
): SdkMcpToolDefinition<Schema>;
```

`ToolAnnotations` fields: `title`, `readOnlyHint` (default false), `destructiveHint` (default true), `idempotentHint` (default false), `openWorldHint` (default true).

### `createSdkMcpServer()`

```typescript
function createSdkMcpServer(options: {
  name: string;
  version?: string;
  tools?: Array<SdkMcpToolDefinition<any>>;
}): McpSdkServerConfigWithInstance;
```

### `listSessions()`

```typescript
function listSessions(options?: ListSessionsOptions): Promise<SDKSessionInfo[]>;
```

Options: `dir`, `limit`, `includeWorktrees`.

SDKSessionInfo: `sessionId`, `summary`, `lastModified`, `fileSize`, `customTitle`, `firstPrompt`, `gitBranch`, `cwd`, `tag`, `createdAt`.

### `getSessionMessages()`

```typescript
function getSessionMessages(
  sessionId: string,
  options?: GetSessionMessagesOptions
): Promise<SessionMessage[]>;
```

SessionMessage: `type` ("user"|"assistant"), `uuid`, `session_id`, `message`, `parent_tool_use_id`.

---

## SOURCE 4: Agent SDK — Python API Reference

**URL:** https://platform.claude.com/docs/en/agent-sdk/python

Note: Full reference is 98.4KB. Key content captured below.

### Two Interaction Patterns

| Feature | `query()` | `ClaudeSDKClient` |
|---------|-----------|-------------------|
| Session | New each time | Reuses same session |
| Conversation | Single exchange | Multiple exchanges |
| Connection | Auto managed | Manual control |
| Streaming Input | Yes | Yes |
| Interrupts | No | Yes |
| Continue Chat | No | Yes |
| Use case | One-off tasks | Continuous conversations |

### `query()` function

```python
async def query(
    *,
    prompt: str | AsyncIterable[dict[str, Any]],
    options: ClaudeAgentOptions | None = None,
    transport: Transport | None = None
) -> AsyncIterator[Message]
```

### `tool()` decorator

```python
def tool(
    name: str,
    description: str,
    input_schema: type | dict[str, Any],
    annotations: ToolAnnotations | None = None
) -> Callable
```

Input schema options:
1. Simple type mapping: `{"text": str, "count": int, "enabled": bool}`
2. JSON Schema format: `{"type": "object", "properties": {...}, "required": [...]}`

### `create_sdk_mcp_server()`

```python
def create_sdk_mcp_server(
    name: str,
    version: str = "1.0.0",
    tools: list[SdkMcpTool[Any]] | None = None
) -> McpSdkServerConfig
```

### `ClaudeAgentOptions` Key Fields

```python
ClaudeAgentOptions(
    allowed_tools=["Read", "Edit", "Bash"],
    permission_mode="acceptEdits",   # acceptEdits | bypassPermissions | dontAsk | default
    system_prompt="...",
    cwd="/path/to/project",
    mcp_servers={"server_name": server_instance},
    agents={"agent-name": AgentDefinition(...)},
    resume="session-id",             # resume a previous session
    max_turns=10,
    model="claude-sonnet-4-6",       # or alias: sonnet, opus, haiku
    setting_sources=["project"],     # load CLAUDE.md, skills, commands
    hooks={
        "PostToolUse": [HookMatcher(matcher="Edit|Write", hooks=[callback_fn])]
    },
)
```

### `AgentDefinition`

```python
AgentDefinition(
    description="When to use this agent",
    prompt="System prompt for the agent",
    tools=["Read", "Grep", "Glob"],
    model="sonnet",
    skills=["skill-name"],
    memory="user",  # user | project | local
    mcp_servers=[...],
)
```

---

## SOURCE 5: Custom Tools

**URL:** https://platform.claude.com/docs/en/agent-sdk/custom-tools

### Creating and Using a Custom Tool

```python
from typing import Any
import httpx
from claude_agent_sdk import tool, create_sdk_mcp_server

@tool(
    "get_temperature",
    "Get the current temperature at a location",
    {"latitude": float, "longitude": float},
)
async def get_temperature(args: dict[str, Any]) -> dict[str, Any]:
    async with httpx.AsyncClient() as client:
        response = await client.get(
            "https://api.open-meteo.com/v1/forecast",
            params={
                "latitude": args["latitude"],
                "longitude": args["longitude"],
                "current": "temperature_2m",
                "temperature_unit": "fahrenheit",
            },
        )
        data = response.json()
    return {
        "content": [
            {"type": "text", "text": f"Temperature: {data['current']['temperature_2m']}°F"}
        ]
    }

weather_server = create_sdk_mcp_server(
    name="weather",
    version="1.0.0",
    tools=[get_temperature],
)

# Usage:
options = ClaudeAgentOptions(
    mcp_servers={"weather": weather_server},
    allowed_tools=["mcp__weather__get_temperature"],
)
```

```typescript
import { tool, createSdkMcpServer } from "@anthropic-ai/claude-agent-sdk";
import { z } from "zod";

const getTemperature = tool(
  "get_temperature",
  "Get the current temperature at a location",
  {
    latitude: z.number().describe("Latitude coordinate"),
    longitude: z.number().describe("Longitude coordinate")
  },
  async (args) => {
    const response = await fetch(
      `https://api.open-meteo.com/v1/forecast?latitude=${args.latitude}&longitude=${args.longitude}&current=temperature_2m&temperature_unit=fahrenheit`
    );
    const data: any = await response.json();
    return {
      content: [{ type: "text", text: `Temperature: ${data.current.temperature_2m}°F` }]
    };
  }
);

const weatherServer = createSdkMcpServer({
  name: "weather",
  version: "1.0.0",
  tools: [getTemperature]
});

// Usage:
for await (const message of query({
  prompt: "What's the temperature in San Francisco?",
  options: {
    mcpServers: { weather: weatherServer },
    allowedTools: ["mcp__weather__get_temperature"]
  }
})) { ... }
```

### Tool Name Format

`mcp__{server_name}__{tool_name}`
Example: `mcp__weather__get_temperature`

Wildcard: `mcp__weather__*` (matches all tools on a server)

### `tools` vs `allowedTools` Distinction

| Option | Layer | Effect |
|:-------|:------|:-------|
| `tools: ["Read", "Grep"]` | Availability | Only listed built-ins in Claude's context. MCP tools unaffected. |
| `tools: []` | Availability | All built-ins removed. Claude can only use MCP tools. |
| `allowedTools` | Permission | Listed tools run without prompt. Unlisted go through permission flow. |
| `disallowedTools` | Permission | Calls denied; tool still visible in context (wastes a turn). |

### Error Handling in Tools

```python
# Return isError: True to let agent loop continue (not raise an exception)
return {
    "content": [{"type": "text", "text": f"API error: {response.status_code}"}],
    "is_error": True,
}
```

Uncaught exceptions stop the agent loop entirely. Caught errors returned as `is_error: True` let Claude retry.

### Return Types

Tool handlers can return:
- `text` blocks: `{"type": "text", "text": "..."}`
- `image` blocks: `{"type": "image", "data": "<base64>", "mimeType": "image/png"}`
- `resource` blocks: `{"type": "resource", "resource": {"uri": "...", "text": "...", "mimeType": "..."}}`

### Tool Annotations

```python
@tool("read_file", "...", {"path": str}, annotations=ToolAnnotations(readOnlyHint=True))
```

| Field | Default | Meaning |
|:------|:--------|:--------|
| `readOnlyHint` | False | Controls parallel batching of read-only calls |
| `destructiveHint` | True | Informational only |
| `idempotentHint` | False | Informational only |
| `openWorldHint` | True | Informational only |

---

## SOURCE 6: Subagents in the SDK

**URL:** https://platform.claude.com/docs/en/agent-sdk/subagents

### Three Ways to Create Subagents

1. **Programmatically**: `agents` parameter in `query()` options (recommended for SDK)
2. **Filesystem-based**: markdown files in `.claude/agents/` directories
3. **Built-in general-purpose**: Claude can invoke at any time if `Agent` is in `allowedTools`

### Defining Subagents Programmatically

```python
from claude_agent_sdk import query, ClaudeAgentOptions, AgentDefinition

async for message in query(
    prompt="Review the authentication module for security issues",
    options=ClaudeAgentOptions(
        allowed_tools=["Read", "Grep", "Glob", "Agent"],  # Agent tool REQUIRED
        agents={
            "code-reviewer": AgentDefinition(
                description="Expert code review specialist. Use for quality, security, and maintainability reviews.",
                prompt="""You are a code review specialist...""",
                tools=["Read", "Grep", "Glob"],
                model="sonnet",
            ),
            "test-runner": AgentDefinition(
                description="Runs and analyzes test suites. Use for test execution and coverage analysis.",
                prompt="""You are a test execution specialist...""",
                tools=["Bash", "Read", "Grep"],
            ),
        },
    ),
):
    if hasattr(message, "result"):
        print(message.result)
```

### AgentDefinition Fields

| Field | Required | Description |
|:------|:---------|:------------|
| `description` | Yes | Natural language description of when to use this agent |
| `prompt` | Yes | The agent's system prompt |
| `tools` | No | Array of allowed tool names. If omitted, inherits all tools |
| `model` | No | `sonnet`, `opus`, `haiku`, or `inherit` |
| `skills` | No | List of skill names |
| `memory` | No | `user`, `project`, or `local` |
| `mcpServers` | No | MCP servers available to this agent |

**Critical:** Subagents cannot spawn their own subagents. Do NOT include `Agent` in a subagent's `tools` array.

### What Subagents Inherit

| Receives | Does NOT receive |
|:---------|:-----------------|
| Its own system prompt + Agent tool's prompt | Parent's conversation history or tool results |
| Project CLAUDE.md (via `settingSources`) | Skills (must list explicitly in `AgentDefinition.skills`) |
| Tool definitions (subset from `tools`) | Parent's system prompt |

Only the subagent's **final message** returns to the parent.

### Invoking Subagents

**Automatic:** Claude decides based on task + `description` field.

**Explicit:** Name the subagent in your prompt:
```
"Use the code-reviewer agent to check the authentication module"
```

### Detecting Subagent Invocation

```python
for block in message.content:
    if getattr(block, "type", None) == "tool_use" and block.name in ("Task", "Agent"):
        print(f"Subagent invoked: {block.input.get('subagent_type')}")

if hasattr(message, "parent_tool_use_id") and message.parent_tool_use_id:
    print("  (running inside subagent)")
```

Note: Tool was renamed from `"Task"` to `"Agent"` in Claude Code v2.1.63. Check both names for compatibility.

### Resuming Subagents

```python
# Capture session_id and agent_id from first query
# Then resume:
options=ClaudeAgentOptions(
    allowed_tools=["Read", "Grep", "Glob", "Agent"],
    resume=session_id
)
# And include agent_id in the prompt: f"Resume agent {agent_id} and ..."
```

Subagent transcripts stored at: `~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl`

### Tool Restrictions for Subagents

| Use case | Tools |
|:---------|:------|
| Read-only analysis | `Read`, `Grep`, `Glob` |
| Test execution | `Bash`, `Read`, `Grep` |
| Code modification | `Read`, `Edit`, `Write`, `Grep`, `Glob` |
| Full access | Omit `tools` field (inherits all) |

### Common Issues

- If Claude isn't delegating: ensure `Agent` is in `allowedTools`; use explicit naming
- Filesystem-based agents only load at session start; restart to pick up new files
- Windows: keep subagent prompts concise (command line 8191 char limit)

---

## SOURCE 7: Sub-agents (Filesystem-Based) — Claude Code

**URL:** https://code.claude.com/docs/en/sub-agents

### Built-in Subagents

| Agent | Model | When Used |
|:------|:------|:----------|
| Explore | Haiku (read-only) | Searching/analyzing codebases |
| Plan | Inherits (read-only) | Codebase research in plan mode |
| General-purpose | Inherits (all tools) | Complex multi-step tasks |
| Bash | Inherits | Running terminal commands |
| statusline-setup | Sonnet | /statusline command |
| Claude Code Guide | Haiku | Questions about Claude Code |

### Subagent File Format

```markdown
---
name: code-reviewer
description: Reviews code for quality and best practices
tools: Read, Glob, Grep
model: sonnet
---

You are a code reviewer. When invoked, analyze the code and provide
specific, actionable feedback on quality, security, and best practices.
```

### Storage Locations (Priority Order)

| Location | Scope | Priority |
|:---------|:------|:---------|
| `--agents` CLI flag | Current session | 1 (highest) |
| `.claude/agents/` | Current project | 2 |
| `~/.claude/agents/` | All projects | 3 |
| Plugin's `agents/` | Where plugin enabled | 4 (lowest) |

### Supported Frontmatter Fields

| Field | Required | Description |
|:------|:---------|:------------|
| `name` | Yes | Unique identifier (lowercase + hyphens) |
| `description` | Yes | When Claude should delegate |
| `tools` | No | Allowed tools (inherits all if omitted) |
| `disallowedTools` | No | Tools to deny |
| `model` | No | `sonnet`, `opus`, `haiku`, full model ID, or `inherit` |
| `permissionMode` | No | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | No | Max agentic turns |
| `skills` | No | Skills to preload |
| `mcpServers` | No | MCP servers (inline or by name) |
| `hooks` | No | Lifecycle hooks |
| `memory` | No | `user`, `project`, or `local` |
| `background` | No | `true` to always run as background task |
| `effort` | No | `low`, `medium`, `high`, `max` (Opus 4.6 only) |
| `isolation` | No | `worktree` for git worktree isolation |
| `initialPrompt` | No | Auto-submitted first turn (main session mode only) |

### Model Resolution Order

1. `CLAUDE_CODE_SUBAGENT_MODEL` env var
2. Per-invocation `model` parameter
3. Subagent definition's `model` frontmatter
4. Main conversation's model

### CLI-Defined Subagents

```bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer. Use proactively after code changes.",
    "prompt": "You are a senior code reviewer...",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  }
}'
```

### Session-Wide Subagent

```bash
claude --agent code-reviewer
```

Or in `.claude/settings.json`:
```json
{ "agent": "code-reviewer" }
```

### Foreground vs Background

- **Foreground**: blocks main conversation; permission prompts passed through
- **Background**: concurrent; pre-approved permissions; `Ctrl+B` to background; fails silently on missing perms
- Disable all background: `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1`

### Restricting Which Subagents Can Be Spawned

```yaml
tools: Agent(worker, researcher), Read, Bash
```

To deny specific subagents:
```json
{
  "permissions": {
    "deny": ["Agent(Explore)", "Agent(my-custom-agent)"]
  }
}
```

### Persistent Memory

```yaml
memory: user   # ~/.claude/agent-memory/<name>/
```

Memory scope options:
- `user`: `~/.claude/agent-memory/<name-of-agent>/` — across all projects
- `project`: `.claude/agent-memory/<name-of-agent>/` — project-specific, shareable
- `local`: `.claude/agent-memory-local/<name-of-agent>/` — project-specific, not checked in

### Hooks in Subagents

In frontmatter (scoped to this subagent):
```yaml
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-command.sh $TOOL_INPUT"
  PostToolUse:
    - matcher: "Edit|Write"
      hooks:
        - type: command
          command: "./scripts/run-linter.sh"
```

In `settings.json` (responds to subagent lifecycle):
```json
{
  "hooks": {
    "SubagentStart": [{ "matcher": "db-agent", "hooks": [...] }],
    "SubagentStop": [{ "hooks": [...] }]
  }
}
```

### Auto-Compaction

Triggers at 95% capacity by default. Override: `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50`.

---

## SOURCE 8: Tool Use (Anthropic API)

**URL:** https://platform.claude.com/docs/en/docs/build-with-claude/tool-use

### Overview

Tool use lets Claude call functions you define. Two execution models:
- **Client tools**: your code executes; Claude returns `stop_reason: "tool_use"` + `tool_use` blocks, you execute and return `tool_result`
- **Server tools**: Anthropic executes (web_search, code_execution, web_fetch, tool_search)

### Server-Side Tool Example

```python
import anthropic

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    max_tokens=1024,
    tools=[{"type": "web_search_20260209", "name": "web_search"}],
    messages=[{"role": "user", "content": "What's the latest on the Mars rover?"}],
)
```

```typescript
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic();
const response = await client.messages.create({
  model: "claude-opus-4-6",
  max_tokens: 1024,
  tools: [{ type: "web_search_20260209", name: "web_search" }],
  messages: [{ role: "user", content: "What's the latest on the Mars rover?" }]
});
```

### Strict Tool Use

Add `strict: true` to tool definitions to guarantee schema conformance. See https://platform.claude.com/docs/en/agents-and-tools/tool-use/strict-tool-use

### Tool Use Pricing

| Model | Tool choice `auto`/`none` | Tool choice `any`/`tool` |
|-------|--------------------------|--------------------------|
| Claude Opus 4.6 | 346 tokens | 313 tokens |
| Claude Sonnet 4.6 | 346 tokens | 313 tokens |
| Claude Haiku 4.5 | 346 tokens | 313 tokens |
| Claude Haiku 3.5 | 264 tokens | 340 tokens |

These system prompt tokens add to normal input/output costs.

### Handling Missing Parameters

- Claude Opus: likely to ask for missing required params before calling
- Claude Sonnet: may infer/guess missing params (e.g., `"location": "New York, NY"`)

---

## SOURCE 9: Slash Commands in the SDK

**URL:** https://platform.claude.com/docs/en/agent-sdk/slash-commands

### Built-in Slash Commands

Available commands listed in system init message:
```python
if message.type == "system" and message.subtype == "init":
    print("Available commands:", message.slash_commands)
    # Example: ["/compact", "/clear", "/help"]
```

### Sending Slash Commands

```python
async for message in query(prompt="/compact", options={"max_turns": 1}):
    ...
```

### `/compact` — Reduces conversation history size

Returns `system:compact_boundary` event with `compact_metadata.pre_tokens`.

### `/clear` — Clears conversation history

Returns new `system:init` event with new `session_id`.

### Custom Slash Commands — File Format

Note: Legacy format is `.claude/commands/`. Preferred new format is `.claude/skills/<name>/SKILL.md`.

Locations:
- Project: `.claude/commands/` (legacy) or `.claude/skills/`
- Personal: `~/.claude/commands/` (legacy) or `~/.claude/skills/`

Example with frontmatter:
```markdown
---
allowed-tools: Read, Grep, Glob
description: Run security vulnerability scan
model: claude-opus-4-6
---

Analyze the codebase for security vulnerabilities including:
- SQL injection risks
- XSS vulnerabilities
- Exposed credentials
- Insecure configurations
```

### Custom Command Features

- `$1`, `$2`, `$ARGUMENTS` — positional arguments and full argument string
- `!`backtick`command`backtick — bash command execution (output embedded)
- `@filename` — include file contents
- Subdirectory namespacing: `.claude/commands/frontend/component.md` → `/component (project:frontend)`

---

## SOURCE 10: Claude Code Overview

**URL:** https://code.claude.com/docs (main landing page)

### What Claude Code Is

An AI-powered coding assistant available in:
- Terminal (CLI)
- VS Code / Cursor
- Desktop app (macOS/Windows)
- Web (browser)
- JetBrains IDEs
- GitHub Actions / GitLab CI/CD
- Slack

Install CLI:
```bash
# macOS/Linux/WSL
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex
```

Package managers:
```bash
brew install --cask claude-code
winget install Anthropic.ClaudeCode
```

### Key Integrations

| Scenario | Solution |
|----------|----------|
| CI/CD PR review | GitHub Actions / GitLab CI/CD |
| Automatic PR review on every PR | GitHub Code Review |
| Slack bug report → PR | Slack integration |
| Phone/mobile access | Remote Control / Web |
| Recurring scheduled tasks | Cloud or Desktop scheduled tasks |
| Custom agents | Agent SDK (platform.claude.com/docs/en/agent-sdk/overview) |

### Agent Teams

Spawn multiple Claude Code agents in parallel. Lead agent coordinates, assigns subtasks, merges results.

### Scripting/Piping

```bash
# Analyze recent log output
tail -200 app.log | claude -p "Slack me if you see any anomalies"

# Automate translations in CI
claude -p "translate new strings into French and raise a PR for review"

# Bulk operations
git diff main --name-only | claude -p "review these changed files for security issues"
```

---

## Bidirectional Search

- **Searched FOR:** "site:docs.anthropic.com claude code SDK 2026", Agent SDK overview, TypeScript reference, Python reference, subagents, custom tools, slash commands, tool use API, CI/CD integration
- **Searched AGAINST:** Did not find evidence that the SDK is deprecated, abandoned, or has major known issues. The GitHub issues pages were not fetched, but the SDK has active changelogs on GitHub.
- **Contradicting evidence found:** No — the SDK rename from "Claude Code SDK" to "Claude Agent SDK" is the only significant change. All redirect chains lead to the same canonical docs at platform.claude.com/docs/en/agent-sdk/.

---

## Recommendations

1. **Install:** `npm install @anthropic-ai/claude-agent-sdk` or `pip install claude-agent-sdk`
2. **Canonical docs:** https://platform.claude.com/docs/en/agent-sdk/overview
3. **For this project's task DAG agents:** Use `query()` with `agents` parameter + `Agent` in `allowedTools`
4. **For CI/CD pipeline use:** Use `permissionMode: "bypassPermissions"` or `acceptEdits`
5. **Subagents cannot nest:** Do not put `Agent` in a subagent's tool list
6. **Context7 MCP** can provide live docs — use `claude-agent-sdk` as the library name

---

## Sources

1. Agent SDK Overview: https://platform.claude.com/docs/en/agent-sdk/overview
2. Agent SDK Quickstart: https://platform.claude.com/docs/en/agent-sdk/quickstart
3. TypeScript SDK Reference: https://platform.claude.com/docs/en/agent-sdk/typescript
4. Python SDK Reference: https://platform.claude.com/docs/en/agent-sdk/python
5. Custom Tools: https://platform.claude.com/docs/en/agent-sdk/custom-tools
6. Subagents in SDK: https://platform.claude.com/docs/en/agent-sdk/subagents
7. Sub-agents (file-based): https://code.claude.com/docs/en/sub-agents
8. Tool Use API: https://platform.claude.com/docs/en/docs/build-with-claude/tool-use
9. Slash Commands: https://platform.claude.com/docs/en/agent-sdk/slash-commands
10. Claude Code Overview: https://code.claude.com/docs
11. Search: https://docs.anthropic.com/en/docs/claude-code/sdk/sdk-overview (redirects to platform.claude.com)
12. TypeScript SDK GitHub: https://github.com/anthropics/claude-agent-sdk-typescript
13. Python SDK GitHub: https://github.com/anthropics/claude-agent-sdk-python
14. Demo agents: https://github.com/anthropics/claude-agent-sdk-demos
