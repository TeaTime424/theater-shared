# Terminus: AI Agent for Terminal-Bench Evaluation

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-28
**Related:** None

---

## Executive Summary

Terminus is an open-source, autonomy-first AI agent built specifically as the reference/neutral test-bed agent for the Terminal-Bench benchmark suite. It was created by Mike Merrill and Alex Shaw (Laude Institute / Stanford) and released May 19, 2025. It is NOT a commercial product or competitor to Claude Code in the consumer sense — it is a research harness agent designed to evaluate LLM capabilities in terminal environments without vendor lock-in. An enhanced variant called Terminus-KIRA (by Krafton AI) achieved 74.8% on Terminal-Bench by improving upon the base agent.

---

## Key Findings

### What Terminus Is

Terminus is a research-preview autonomous agent that serves as the vendor-neutral reference agent for Terminal-Bench, a benchmark for evaluating how well AI models can operate as autonomous agents in command-line/terminal environments. At its release (May 19, 2025), it was the second-highest performing agent on Terminal-Bench, behind only Claude Code.

It is NOT:
- A commercial product or SaaS tool
- A competitor to Claude Code for end-user use
- A multi-agent orchestration framework
- A coding assistant for day-to-day development

### Architecture

**Mono-tool / tmux-only design.** Terminus provides the LLM with exactly one capability: an interactive tmux session running inside a Docker container. The agent sends keystrokes into the tmux session to accomplish tasks. There are no specialized file-editing tools, no bash execution tools, no web browsing — just raw terminal interaction.

**Remote execution model.** Terminus runs as an independent Python process outside the Docker container it controls, connecting remotely via the tmux session. This allows it to operate even when the container environment is broken or has dependency issues.

**Autonomy-first.** Terminus never requests user approval. Within its sandboxed environment, it will comply with directives without artificial limitations — contrasting with production agents like Claude Code that have built-in safety guardrails.

**Model-agnostic via LiteLLM.** Supports virtually any API or locally-hosted model (Anthropic, OpenAI, Google, Ollama, etc.). This was an intentional design choice — Claude Code only works with Anthropic models, making neutral cross-model benchmarking impossible with it.

### Origin and Context

| Item | Detail |
|------|--------|
| Creators | Mike A. Merrill, Alex Shaw (+ 85+ contributors) |
| Institution | Laude Institute / Stanford University |
| Release date | May 19, 2025 |
| GitHub | [harbor-framework/terminal-bench](https://github.com/laude-institute/terminal-bench) |
| ArXiv paper | [2601.11868](https://arxiv.org/abs/2601.11868) (submitted January 17, 2026) |
| License | Open source |

### Terminal-Bench Context

Terminal-Bench 2.0 consists of 89 hand-crafted tasks in realistic terminal environments: compiling code, training models, setting up servers, system administration, security tasks, data science workflows. Each task has a unique Docker environment, human-written solution, and automated verification tests.

Frontier models and agents currently score below 65% on Terminal-Bench 2.0 with the base Terminus harness.

### Benchmark Leaderboard (Terminal-Bench 2.0, as of March 2026)

| Agent | Model | Score |
|-------|-------|-------|
| ForgeCode | GPT-5.4 / Claude Opus 4.6 | ~81.8% |
| TongAgents | Gemini 3.1 Pro | 80.2% |
| SageAgent | GPT-5.3-Codex | 78.4% |
| Droid | GPT-5.3-Codex | 77.3% |
| Terminus-KIRA | (frontier models) | 74.8% |
| Terminus-2 | GPT-5.3-Codex | ~64.7% |
| Terminus-2 | Claude Opus 4.6 | ~62.9% |
| Terminus-2 | Gemini 3 Pro | ~56.9% |
| Terminus-2 | GPT-5.2 | ~54.0% |

[Source: tbench.ai leaderboard]

### Terminus-KIRA Variant

Krafton AI built Terminus-KIRA on top of the base Terminus harness to address three failure categories:

1. **Task completion failures** — Base Terminus let models submit partial work (models trained to assist humans, not operate autonomously). KIRA adds explicit "no human interaction, one submission only" prompting and a multimedia file comprehension tool.
2. **Self-evaluation problems** — Models incorrectly believed they finished tasks. KIRA adds mandatory step-by-step self-evaluation.
3. **Technical infrastructure** — Replaced Terminus's "push and wait" tmux mechanism with a "pull" mechanism; increased tmux buffer size; added adaptive replanning prompts.

Result: +10 percentage points over base Terminus, reaching 74.8%.

GitHub: [krafton-ai/KIRA](https://github.com/krafton-ai/KIRA)

### How to Run Terminus

```bash
# Install Terminal-Bench
pip install terminal-bench

# Run Terminus agent against a model
tb run --agent terminus --model anthropic/claude-3-7-latest
```

Terminus is distributed as part of the `terminal-bench` Python package.

---

## Comparison Table

| | Terminus | Claude Code | Devin | Aider | OpenHands |
|--|----------|-------------|-------|-------|-----------|
| Type | Benchmark harness agent | Consumer coding agent | Autonomous SWE | Terminal coding agent | Open-source autonomous |
| Model support | Any (LiteLLM) | Anthropic only | Proprietary | Any | Any |
| User approval | Never (sandboxed only) | Configurable | Never | Configurable | Configurable |
| Interface | tmux only | Rich toolset | Full browser+shell | CLI | Full browser+shell |
| Use case | Benchmarking/research | Day-to-day coding | Task assignment | CLI coding | Open-source dev |
| Cost | Free/OSS | API cost | Paid SaaS | Free/OSS | Free/OSS |
| TB 2.0 score | 54-65% | N/A (proprietary) | N/A | N/A | N/A |

---

## Follow-up Tasks Created

None. This is a research-only finding — Terminus is not a candidate for adoption in the theater project or any adjacent tooling.

---

## Bidirectional Search

- **Searched FOR:** "Terminus AI agent coding autonomous", "terminus agent GitHub", "terminus tbench terminal-bench", "terminus autonomy-first tmux benchmark", "terminus agent product hunt launch"
- **Searched AGAINST:** "Terminus coding agent Devin Claude Code competitor", "Terminus agent Reddit ClaudeAI", "Terminus agent Hacker News", "terminus autonomous coding agent commercial"
- **Contradicting evidence found:** No — there is no commercial "Terminus" AI agent product competing with Claude Code, Devin, Aider, or OpenHands. All findings consistently point to Terminal-Bench's research harness agent. No Product Hunt listing, no VC-backed startup, no community discussion of a commercial Terminus agent was found.

---

## Recommendations

Terminus is a benchmark harness tool, not a user-facing AI agent. If the user's interest is:

- **Evaluating LLM performance on terminal tasks** — Terminus + Terminal-Bench is the right tool. Run `tb run --agent terminus --model <model>`.
- **A neutral multi-model coding agent** — Aider is a better fit (39K stars, production-ready, any model).
- **An enhanced Terminus variant** — Look at Terminus-KIRA (Krafton AI) which adds +10pp on the benchmark.
- **Multi-agent orchestration** — Claude Squad, Overstory, or ComposioHQ Agent Orchestrator are more relevant.

**Confidence:** High that Terminus = Terminal-Bench harness agent. Low probability that a separate commercial "Terminus" AI agent exists that wasn't found in this search.

---

## Sources

1. [Terminal-Bench official site](https://www.tbench.ai/)
2. [Terminus agent page - tbench.ai](https://www.tbench.ai/news/terminus)
3. [Terminal-Bench GitHub (harbor-framework)](https://github.com/laude-institute/terminal-bench)
4. [ArXiv paper 2601.11868](https://arxiv.org/abs/2601.11868)
5. [Terminus-KIRA GitHub](https://github.com/krafton-ai/KIRA)
6. [How We Reached 74.8% on terminal-bench with Terminus-KIRA](https://ahlikompie.com/7554-how-we-reached-74-8-on-terminal-bench-with-terminus-kira.html)
7. [Terminal-Bench 2.0 VentureBeat coverage](https://venturebeat.com/ai/terminal-bench-2-0-launches-alongside-harbor-a-new-framework-for-testing)
8. [Terminal-Bench leaderboard - Artificial Analysis](https://artificialanalysis.ai/evaluations/terminalbench-hard)
9. [Terminal-Bench about page](https://www.tbench.ai/about)
10. [TerminusAI GitHub (RobLinux) — separate unrelated project](https://github.com/RobLinux/TerminusAI)
