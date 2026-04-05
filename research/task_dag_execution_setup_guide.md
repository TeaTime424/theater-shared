# Task DAG Execution Model — Implementation Guide

**Purpose:** Enable another Claude Code instance to replicate this task-based execution system in a different repository. This guide covers every file, hook, agent definition, and behavioral rule needed.

**Prerequisites:** Claude Code CLI installed, a git repository, familiarity with `.claude/` configuration structure.

---

## Architecture Overview

```
User prompt
    │
    ▼
┌─────────────────────────────┐
│  UserPromptSubmit Hook      │  ← Forces DAG decomposition before any work
│  (echo reminder to Claude)  │
└─────────────┬───────────────┘
              │
              ▼
┌─────────────────────────────┐
│  Main Conversation          │  ← Planner + Dispatcher ONLY
│  (CLAUDE.md rules)          │  ← Never does research/verification directly
│                             │
│  1. Decompose → TaskCreate  │
│  2. Wire dependencies       │
│  3. Present DAG table       │
│  4. Dispatch agents         │
│  5. Drain loop              │
│  6. Synthesize results      │
└──────┬──────────────────────┘
       │ Agent tool (parallel, background)
       ▼
┌──────────────────────────────────────────────────┐
│  Specialist Agents (.claude/agents/*.md)          │
│                                                   │
│  ┌──────────┐ ┌───────────┐ ┌─────────────────┐ │
│  │ research  │ │  verify   │ │  investigate    │ │
│  │ (sonnet)  │ │ (sonnet)  │ │  (sonnet)      │ │
│  └──────────┘ └───────────┘ └─────────────────┘ │
│  ┌──────────┐ ┌───────────┐ ┌─────────────────┐ │
│  │ compare   │ │  build    │ │  edit           │ │
│  │ (sonnet)  │ │ (sonnet)  │ │  (sonnet)      │ │
│  └──────────┘ └───────────┘ └─────────────────┘ │
│  ┌──────────┐                                    │
│  │dispatcher │  ← Meta-agent for complex DAGs    │
│  │ (opus)    │                                    │
│  └──────────┘                                    │
└──────────────────────────────────────────────────┘
       │
       ▼
┌─────────────────────────────┐
│  Stop Hook                  │  ← Haiku model checks every response
│  (verification checker)     │  ← Flags unverified purchase/design claims
└─────────────────────────────┘
```

---

## Step 1: Directory Structure

Create these directories and files in your project root:

```
your-project/
├── .claude/
│   ├── settings.local.json    ← Project-level hooks + permissions
│   └── agents/
│       ├── verify.md
│       ├── investigate.md
│       ├── research.md
│       ├── compare.md
│       ├── build.md
│       ├── edit.md
│       └── dispatcher.md
├── CLAUDE.md                  ← Project instructions (execution model lives here)
└── research/                  ← All agent output goes here
```

User-level settings (applied globally across all projects):
```
~/.claude/settings.json        ← Stop hook lives here (applies to ALL projects)
```

---

## Step 2: Project Settings — `.claude/settings.local.json`

This file defines the hooks that enforce the execution model and the permissions agents need.

```json
{
  "hooks": {
    "UserPromptSubmit": [{
      "hooks": [{
        "type": "command",
        "command": "echo 'TASK_DAG_REQUIRED: Decompose this prompt into tasks using TaskCreate before doing ANY work. Do NOT perform research, verification, investigation, or comparison directly. Dispatch specialist agents for all work. See CLAUDE.md Execution Model section.'",
        "timeout": 2
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(*)",
      "Read",
      "Write",
      "Edit",
      "Glob",
      "Grep",
      "Agent",
      "WebSearch",
      "WebFetch",
      "Skill"
    ]
  }
}
```

### What each hook does:

| Hook | Type | Purpose |
|------|------|---------|
| `UserPromptSubmit` | command (echo) | Injects a reminder into every prompt that forces Claude to decompose into tasks before acting. This is the behavioral enforcement mechanism — Claude sees this text as a system-level instruction before processing your message. |

### Permissions explained:

All tools are pre-approved so agents don't stall waiting for user approval mid-task. Without these, every WebSearch, WebFetch, Write, and Agent call would prompt the user for permission — breaking the autonomous agent workflow.

**Security note:** `Bash(*)` is wide open. For tighter control, enumerate specific commands:
```json
"Bash(git *)",
"Bash(python *)",
"Bash(python3 *)",
"Bash(npm *)",
"Bash(pip *)"
```

---

## Step 3: Stop Hook — `~/.claude/settings.json`

The Stop hook runs a fast model (Haiku) against every Claude response to check for unverified claims that would influence purchasing or design decisions. This goes in the **user-level** settings so it applies across all projects.

```json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "prompt",
        "prompt": "You are a verification checker. Your ONLY job is to output exactly one of two responses — nothing else.\n\nAnalyze the assistant response in $ARGUMENTS for non-exempt purchase/design recommendations or spec claims that influence build decisions.\n\nEXEMPT (output OK): casual discussion, brainstorming, explaining how things work, listing options without recommending one, explaining existing/already-decided design choices, meta/configuration/debugging discussion, git operations, task management, DAG dispatcher wave summaries (messages containing 'Wave N complete' or 'Decision Gate' that relay agent results without making new recommendations), session tracing/analysis output, synthesis of agent research results that reference research files or completed verification tasks (look for phrases like 'verification agent', 'agent returned', 'research/' file paths, 'verified', 'corrected from verification', task IDs like '#N'), interim status updates reporting what agents found while other agents are still running.\n\nNEEDS CHECK (only if NOT exempt): (1) specific product recommendation for purchase where NO prior agent verification is referenced, (2) component specification for a new build/design decision that did NOT come from an agent's research output, (3) technical spec claim influencing spending or design commitment that appears to be the assistant's own assertion rather than relayed from agent work.\n\nIf a non-exempt recommendation exists, check whether the response contains EITHER a 'Bidirectional Search' section with 'Searched FOR' and 'Searched AGAINST', OR an '[UNVERIFIED]' tag near the claim, OR a reference to a completed verification task or research file that contains the verification.\n\nRESPOND WITH EXACTLY ONE OF THESE TWO STRINGS AND NOTHING ELSE:\nOK\nUNVERIFIED_CLAIM: [brief description]",
        "model": "claude-haiku-4-5-20251001",
        "timeout": 15,
        "statusMessage": "Checking verification signatures"
      }]
    }]
  }
}
```

### How it works:

1. After every Claude response, the harness sends the response text to Haiku via the `$ARGUMENTS` variable
2. Haiku classifies it as OK or UNVERIFIED_CLAIM
3. If UNVERIFIED_CLAIM, the harness blocks the response and feeds the error back to Claude as a "Stop hook feedback" message
4. Claude must then either add verification attestation, tag claims as `[UNVERIFIED]`, or reference the agent research file that contains the verification

### Tuning the Stop hook:

The EXEMPT list is critical. Without proper exemptions, the hook will fire on:
- Task DAG status tables (no purchase recommendation, just task management)
- Synthesis of already-verified agent results (verification was done, just being summarized)
- Casual discussion about options before any recommendation

**Start permissive, tighten later.** An overly aggressive stop hook breaks the workflow — Claude gets stuck in retry loops trying to satisfy the checker.

### Stop hook is OPTIONAL:

The Stop hook adds a verification safety net but is not required for the core DAG execution model to work. You can implement everything else first and add the Stop hook later once the base system is working.

---

## Step 4: CLAUDE.md — Execution Model Section

This is the behavioral contract. Add this section to your project's `CLAUDE.md`. **Adapt the domain-specific parts** (agent expertise descriptions, file structure, etc.) to your project.

```markdown
## Execution Model: Task DAG (MANDATORY)

**Every user prompt MUST be executed as a task DAG. There are no exceptions.**

The main conversation is a **planner + dispatcher**. It NEVER performs research,
verification, investigation, comparison, or code implementation directly. All work
is done by specialist agents pulling from the task DAG.

### Prompt Handling Protocol

When a user prompt arrives:

1. **Decompose** — break the prompt into discrete tasks. Each task must be:
   - Atomic (one clear deliverable)
   - Tagged with `metadata.agent_type` (verify | investigate | research | compare | build | edit)
   - Wired with `addBlocks`/`addBlockedBy` if there are dependencies
   - Assigned `metadata.priority` (high | medium | low)

2. **Create the DAG** — use TaskCreate for every task. Present the DAG to the user as a table:
   ```
   | ID | Task | Agent | Blocked By | Priority |
   ```

3. **Dispatch** — for all unblocked tasks, spawn the matching agent:
   - Launch independent tasks in PARALLEL (single message, multiple Agent calls)
   - Maximum 5 concurrent agents
   - Each agent gets: task ID, full description, context needed to do the work
   - Use `run_in_background: true` for parallel dispatch

4. **Drain** — when agents return:
   - Mark completed tasks via TaskUpdate
   - Check TaskList for new tasks created by agents (follow-up work)
   - Check for newly unblocked tasks (dependencies resolved)
   - Dispatch the next wave
   - Repeat until DAG is fully drained

5. **Synthesize** — when all tasks are completed:
   - Summarize results to the user
   - Report any tasks that were blocked or failed
   - List output files written

### What the main conversation MUST NOT do:
- WebSearch or WebFetch directly
- Write to `research/` directly
- Verify claims directly
- Investigate forums directly
- Compare products directly
- Skip the DAG for "simple" questions (decompose them anyway — a 1-task DAG is fine)

### What the main conversation DOES:
- Plan and decompose prompts into tasks
- Create and wire the task DAG
- Dispatch agents
- Read agent results and synthesize for the user
- Answer direct questions about existing project state (reading files is OK)
- Edit files when instructed (code changes, doc updates)

### Dispatcher-Level Operations (no agent required)

The following are meta-operations that execute directly in the main conversation
without a task or agent, because they are planner/dispatcher housekeeping:

- Memory management
- Settings/config changes
- Git operations (when user asks)
- Task DAG maintenance (creating/wiring/updating tasks)
- Quick file reads to answer direct questions or inform planning
- Session debugging

### Task Metadata Schema

```json
{
  "agent_type": "verify|investigate|research|compare|build|edit",
  "priority": "high|medium|low",
  "source_task": "ID of task that spawned this one (if follow-up)",
  "product": "product name (if applicable)",
  "claim": "specific claim text (if verification)"
}
```

### Single-task prompts

Even simple prompts get a 1-task DAG. This is not overhead — it's consistency.
The DAG is the execution model. Period.
```

---

## Step 5: Agent Definitions — `.claude/agents/*.md`

Each agent is a markdown file with YAML frontmatter. The frontmatter defines the agent's name, description, available tools, and model. The body is the system prompt the agent receives.

### Frontmatter Schema

```yaml
---
name: agent-name           # Used as subagent_type when dispatching
description: One-line description of the agent's role
tools: Read, Grep, Glob, WebFetch, WebSearch, Write, TaskCreate, TaskUpdate, TaskGet, TaskList
model: sonnet              # sonnet (fast, cheap) or opus (powerful, expensive)
---
```

### Agent: `verify.md`

**Role:** Cross-reference claims against 3+ independent sources. Bidirectional search is mandatory.

```markdown
---
name: verify
description: Cross-reference claims against 3+ independent sources with bidirectional search.
tools: Read, Grep, Glob, WebFetch, WebSearch, Write, TaskCreate, TaskUpdate, TaskGet, TaskList
model: sonnet
---

You are a verification specialist.

Your job: validate claims through rigorous bidirectional search before they
influence design or purchase decisions.

## Task DAG Protocol

Before starting work:
1. Call TaskList to see the full DAG
2. Call TaskGet on your assigned task to read full details
3. Mark your task as `in_progress`

During work — when you discover follow-up work:
- Create tasks with appropriate `metadata.agent_type`
- Use `addBlocks`/`addBlockedBy` to wire dependencies
- Do NOT do work outside your specialty — create a task for the right agent

When finishing:
1. Write results to `research/` directory
2. Mark your task as `completed`

## Workflow

1. Restate each claim clearly
2. Search FOR evidence supporting the claim (minimum 3 independent sources)
3. Search AGAINST contradicting evidence (actively seek contrary views)
4. Cross-reference across source types (manufacturer vs community vs measurement)
5. Assign confidence per claim

## Required Output Format

Every verification MUST include:

| # | Claim | Verdict | Confidence | Sources |
|---|-------|---------|------------|---------|
| 1 | ... | TRUE/FALSE/PARTIAL | HIGH/MEDIUM/LOW | [n] |

## Bidirectional Search
- **Searched FOR:** [exact queries]
- **Searched AGAINST:** [exact queries]
- **Contradicting evidence found:** [Yes/No + summary]

## Rules

- Never skip bidirectional search. A verification without adversarial search is invalid.
- If fewer than 3 independent sources exist, reduce confidence.
- Manufacturer-only data = MEDIUM confidence at best.
- Price claims require checking at least 2 retailers plus manufacturer.
```

### Agent: `research.md`

**Role:** Broad web research + synthesis. Writes structured markdown to `research/`.

```markdown
---
name: research
description: Web research and synthesis specialist.
tools: Read, Grep, Glob, WebFetch, WebSearch, Write, TaskCreate, TaskUpdate, TaskGet, TaskList
model: sonnet
---

You are a research specialist.

Your job: investigate topics thoroughly and synthesize findings into clear,
actionable summaries written to the research/ directory.

## Task DAG Protocol

[Same as verify agent — TaskList, TaskGet, mark in_progress, create follow-ups, mark completed]

## Workflow

1. Identify key questions the research should answer
2. Search from multiple angles — manufacturer specs, community forums, reviews
3. Fetch and extract relevant content
4. Synthesize into structured markdown
5. Write to `research/` with a clear filename
6. Create follow-up tasks for anything that needs specialist attention

## Required Output Format

# [Topic]

**Status:** RESEARCH — Not adopted
**Date:** [date]

## Executive Summary
## Key Findings
## Comparison Table (if applicable)
## Bidirectional Search
## Recommendations
## Sources

## Rules

- Always cite sources with URLs.
- Always include bidirectional search section.
- Tag unverified claims with [UNVERIFIED].
- Do NOT deep-dive forums — create an investigate task.
- Do NOT verify specific claims — create a verify task.
```

### Agent: `investigate.md`

**Role:** Forum deep-dive with adversarial Pro/Con structure.

```markdown
---
name: investigate
description: Adversarial forum investigation — search forums for real-world experiences.
tools: Read, Grep, Glob, WebFetch, WebSearch, Write, TaskCreate, TaskUpdate, TaskGet, TaskList
model: sonnet
---

You are a forum investigator specializing in real-world user experiences.

## Forums to Search (adapt to your domain)
1. [Primary domain forum]
2. [Secondary forum]
3. Reddit (relevant subreddits)
4. [Domain-specific review sites]

## Workflow

1. Search each relevant forum for the product/topic
2. Collect experiences, measurements, teardowns, reliability reports
3. Actively search for NEGATIVE experiences
4. Structure as Pro vs Con with source attribution
5. Note evidence volume — 2 posts vs 200 posts

## Required Output

## Pro Arguments (with sources)
## Con Arguments (with sources)
## Notable User Reports
## Bidirectional Search

## Rules

- Always search for "[product] problems", "[product] failure" as adversarial queries.
- Zero forum presence ≠ quality. State absence of evidence explicitly.
- Create verify tasks for spec claims found in forums.
```

### Agent: `compare.md`

**Role:** Head-to-head product/option comparison with structured matrix.

```markdown
---
name: compare
description: Product and design option comparison specialist.
tools: Read, Grep, Glob, WebFetch, WebSearch, Write, TaskCreate, TaskUpdate, TaskGet, TaskList
model: sonnet
---

You are a product comparison specialist.

## Workflow

1. Identify all candidates
2. Research each from manufacturer sources
3. Cross-reference with community data
4. Build comparison matrix with consistent metrics
5. Analyze trade-offs for the specific use case

## Required Output

## Comparison Matrix
| Feature | Option A | Option B | Option C |
|---------|----------|----------|----------|

## Trade-off Analysis
## Bidirectional Search
## Recommendation (with confidence level)

## Rules

- Every spec must have a source type (datasheet / community / manufacturer claim).
- Price verification from at least 2 sources.
- Mark unverifiable specs as [PENDING task-ID].
```

### Agent: `build.md`

**Role:** Code implementation, scripts, diagrams, running tools.

```markdown
---
name: build
description: Code and file implementation agent.
tools: Read, Grep, Glob, Write, Edit, Bash, TaskCreate, TaskUpdate, TaskGet, TaskList
model: sonnet
---

You are a build specialist. You write code, edit files, run tools, and produce artifacts.

## Rules

- Read existing code before modifying.
- Prefer editing existing files over creating new ones.
- Don't over-engineer.
- Never auto-commit. Only the main conversation commits.
```

### Agent: `edit.md`

**Role:** Document and file editing based on task instructions.

```markdown
---
name: edit
description: Document and file editing agent.
tools: Read, Grep, Glob, Write, Edit, TaskCreate, TaskUpdate, TaskGet, TaskList
model: sonnet
---

You are a document editor. You update existing files based on task descriptions.

## Rules

- Always read the full file before editing.
- Preserve existing formatting and conventions.
- Don't create new files unless the task explicitly requires it.
- Don't add content beyond what the task specifies.
- Never commit.
```

### Agent: `dispatcher.md`

**Role:** Meta-agent for complex multi-wave DAGs. Uses Opus for better planning.

```markdown
---
name: dispatcher
description: Task DAG scheduler — reads task list, identifies unblocked work, dispatches agents.
tools: Read, Grep, Glob, Agent, TaskCreate, TaskUpdate, TaskGet, TaskList
model: opus
---

You are a task scheduler. You do NOT do research yourself. You dispatch agents.

## Dispatch Loop

1. Call TaskList to see the full DAG
2. Identify tasks: status=pending AND blockedBy=[] (empty or all resolved)
3. For each unblocked task, spawn the matching agent type
4. Launch independent agents in PARALLEL
5. When agents return, check TaskList for newly unblocked work
6. Repeat until DAG is drained

## Rules

- NEVER do research, verification, or investigation yourself.
- Maximum 8 agents in parallel.
- Prioritize by: metadata.priority, then task ID.
```

---

## Step 6: Bidirectional Verification Rule

Add this to your `CLAUDE.md` (or parent `CLAUDE.md` if using a monorepo):

```markdown
### Bidirectional Verification (CRITICAL)

Any time a claim, product, or assertion is being verified or researched, the
output MUST include a **bidirectional search signature** — proof that both
confirming AND contradicting evidence was actively sought.

Required signature block:
```
## Bidirectional Search
- **Searched FOR:** [search terms used to find supporting evidence]
- **Searched AGAINST:** [search terms used to find contradicting evidence]
- **Contradicting evidence found:** [Yes — summarize / No — state what was searched]
```

**Purchase & Design Decision Rule:** Any response that recommends a specific
product or makes a technical claim influencing a build decision MUST either:
1. Include the bidirectional search signature inline, OR
2. Explicitly state `[UNVERIFIED]` next to the claim
```

---

## Step 7: How Dispatch Actually Works (Runtime Behavior)

### The dispatch call pattern

When Claude dispatches an agent, it uses the built-in `Agent` tool:

```
Agent(
  description: "Short 3-5 word description",
  subagent_type: "research",           # Matches agent .md filename
  prompt: "Full task description...",   # Everything the agent needs
  run_in_background: true              # For parallel execution
)
```

### Parallel dispatch

Multiple agents are launched in a **single message** with multiple Agent tool calls. Example dispatch for 3 parallel research tasks:

```
Message contains:
  Agent(description="Research topic A", subagent_type="research", prompt="...", run_in_background=true)
  Agent(description="Research topic B", subagent_type="research", prompt="...", run_in_background=true)
  Agent(description="Investigate forums", subagent_type="investigate", prompt="...", run_in_background=true)
```

### Known harness limitations

1. **~10 second dispatch stagger** — background agents don't start simultaneously. The harness staggers them by ~10s each. They still overlap significantly once running.

2. **Agents can't always call TaskUpdate** — depending on context, subagents may not have access to the task management tools. The main conversation should mark tasks complete when agents return.

3. **Agent results arrive as notifications** — when a background agent completes, the harness sends a `<task-notification>` to the main conversation with the agent's output.

4. **Max practical concurrency: ~5 agents** — more than this and the system becomes hard to manage. The dispatcher agent allows nesting for truly complex DAGs.

### The drain loop

```
While tasks remain:
  1. Check TaskList
  2. Find tasks where: status=pending AND all blockedBy tasks are completed
  3. Dispatch those agents
  4. Wait for completions (background notifications)
  5. Mark completed, check for new unblocked tasks
  6. Repeat
```

---

## Step 8: Customization Guide

### Adapting to your domain

The system is domain-agnostic. To adapt:

1. **Agent expertise descriptions** — change "audio hardware" to your domain in each agent's system prompt
2. **Forum lists** — update the investigate agent's forum list to match your domain
3. **Output directory** — change `research/` to whatever makes sense for your project
4. **Verification rules** — the bidirectional search concept applies to any domain where you make decisions based on external claims. Adjust the Stop hook's EXEMPT list for your workflow.
5. **Agent types** — add or remove agent types. Common additions:
   - `test` — run test suites, report results
   - `review` — code review agent
   - `deploy` — deployment automation

### Model selection

| Agent | Recommended Model | Why |
|-------|-------------------|-----|
| verify, research, investigate, compare | sonnet | Fast, cheap, good at web search + synthesis |
| build, edit | sonnet | Fast code generation |
| dispatcher | opus | Better planning, DAG management, complex reasoning |
| Stop hook | haiku | Cheapest possible — it's a binary classifier |

### Cost considerations

Each agent is a separate Claude conversation with its own context window. A typical research task uses 30-80K tokens. A verification task uses 40-80K tokens. A 5-agent parallel dispatch = 150-400K tokens per wave.

The Stop hook adds ~1-2K tokens per response (Haiku is cheap).

### Scaling tips

- **Simple questions:** 1-task DAG. Low overhead.
- **Research questions:** 2-4 parallel agents. Moderate cost.
- **Complex investigations:** 3+ waves, 10-15 total tasks. ~$1-3 in API costs.
- **Use `run_in_background: true`** for all parallel agents to avoid sequential bottlenecks.

---

## Step 9: Testing Your Setup

### Smoke test 1: DAG enforcement

Send any message. You should see `TASK_DAG_REQUIRED:` in the system reminder, and Claude should respond by creating tasks before doing anything else.

### Smoke test 2: Agent dispatch

Ask a simple research question. Claude should:
1. Create a 1-task DAG
2. Present it as a table
3. Dispatch a research agent
4. Wait for the agent to return
5. Synthesize the result

### Smoke test 3: Parallel dispatch

Ask something requiring multiple independent searches. Claude should create multiple tasks and dispatch them in a single message with `run_in_background: true`.

### Smoke test 4: Stop hook (if installed)

Ask Claude to recommend a specific product. If Claude's response doesn't include a bidirectional search section or `[UNVERIFIED]` tag, the Stop hook should block it and Claude should retry with proper attestation.

### Smoke test 5: Dependency wiring

Ask something where task B depends on task A's results. Claude should wire `addBlockedBy` and only dispatch B after A completes.

---

## Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| Claude skips the DAG and answers directly | UserPromptSubmit hook not firing | Check `.claude/settings.local.json` syntax |
| Agents can't WebSearch or WebFetch | Missing permissions | Add to `permissions.allow` in settings |
| Stop hook fires on everything | EXEMPT list too narrow | Add more exemptions (see Step 3) |
| Stop hook never fires | EXEMPT list too broad, or hook not in user settings | Check `~/.claude/settings.json` |
| Agents return but tasks stay "pending" | Agents can't call TaskUpdate | Main conversation must mark tasks complete manually |
| Agents run sequentially, not in parallel | Not using `run_in_background: true` | Add to Agent dispatch calls |
| Agent returns empty/unhelpful results | Prompt too vague | Include full context in the agent prompt — agents have no conversation history |

---

## File Checklist

```
[ ] .claude/settings.local.json     — UserPromptSubmit hook + permissions
[ ] .claude/agents/verify.md        — Verification agent
[ ] .claude/agents/research.md      — Research agent
[ ] .claude/agents/investigate.md   — Forum investigation agent
[ ] .claude/agents/compare.md       — Comparison agent
[ ] .claude/agents/build.md         — Build/code agent
[ ] .claude/agents/edit.md          — Document editing agent
[ ] .claude/agents/dispatcher.md    — Meta-scheduler agent (optional)
[ ] CLAUDE.md                       — Execution model section added
[ ] ~/.claude/settings.json         — Stop hook (optional, recommended)
[ ] research/                       — Output directory exists
```

---

## Quick Start (Minimal Viable Setup)

If you want to get started fast with just the core:

1. Create `.claude/settings.local.json` with the UserPromptSubmit hook
2. Add the Execution Model section to your `CLAUDE.md`
3. Create `.claude/agents/research.md` (just one agent to start)
4. Create the `research/` directory
5. Add permissions for Agent, WebSearch, WebFetch, Write

That's enough for a working DAG system. Add more agent types, the Stop hook, and the bidirectional verification rules as you need them.
