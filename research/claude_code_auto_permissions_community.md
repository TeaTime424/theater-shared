# Forum Investigation: Claude Code Auto Permissions / allowedTools / Trust Settings

**Status:** RESEARCH
**Date:** 2026-03-28
**Evidence volume:** Moderate — 25+ forum threads, GitHub issues, and blog posts found

---

## Summary

The Claude Code permission system has generated substantial community discussion from 2025 through March 2026. The core tension is genuine: default permissions create significant workflow friction (Claude pauses on every `mkdir`), yet bypassing them has caused documented catastrophic data loss. Multiple approaches have emerged — `--dangerously-skip-permissions`, `allowedTools` whitelisting, hooks-based automation, and the new auto mode (March 2026, Team plan only). All have known failure modes.

---

## Pro Arguments (with sources)

### Autonomous Sessions Are Possible and Productive
- One documented case: developer Kyle Redelinghuys ran a nine-hour autonomous Claude Code session building a financial data analysis system from scratch — only possible because permissions were bypassed. [ksred.com](https://www.ksred.com/claude-code-dangerously-skip-permissions-when-to-use-it-and-when-you-absolutely-shouldnt/)
- CI/CD headless mode with `--allowedTools` + `-p` flag allows fully automated pipelines without human interaction, used successfully in GitHub Actions workflows. [Anthropic docs](https://code.claude.com/docs/en/headless)

### Hooks System Eliminates 90% of Click Fatigue
- Developer Korny built a Rust-based permission hook that uses regex allow/deny patterns to automatically approve routine operations — eliminating the repetitive prompts without full bypass. Wrote it because the wildcard patterns in settings.json were still prompting him every single time. [korny.info blog, 2025-10-10](https://blog.korny.info/2025/10/10/better-claude-code-permissions)
- DEV Community article on hooks-based workflow: "cuts out 90% of the approve/deny clicking." Context-switching cost drops dramatically. [DEV Community](https://dev.to/ji_ai/how-i-automated-my-entire-claude-code-workflow-with-hooks-5cp8)
- BSWEN docs: Pre-built LLM-powered permission hooks auto-approve safe operations, flag risky ones with a small model classifier. [BSWEN](https://docs.bswen.com/blog/2026-03-21-claude-code-hooks-auto-permissions/)

### Auto Mode (March 2026) Reduces Interruption Safely
- Anthropic's data: users already approve 93% of permission prompts, meaning most are low-risk. Auto mode automates these decisions via classifier rather than rubber-stamping. [Anthropic engineering blog](https://www.anthropic.com/engineering/claude-code-auto-mode)
- Two-stage classifier design: stage 1 fast yes/no (8.5% false-positive), stage 2 chain-of-thought on flagged actions (0.4% false-positive after both stages). [SmartScope](https://smartscope.blog/en/generative-ai/claude/claude-code-auto-mode-guide/)
- Fallback design prevents session derailment: if classifier blocks an action 3 consecutive times or 20 total times in a session, auto mode pauses rather than failing silently. [Anthropic engineering blog](https://www.anthropic.com/engineering/claude-code-auto-mode)

### Layered Trust / Enterprise Controls
- `managed-settings.json` at enterprise level cannot be overridden by user or project settings — gives IT teams policy enforcement with no user escape hatch. [managed-settings.com](https://managed-settings.com/)
- Three-tier settings hierarchy (global → project → CLI flags) allows per-project scoping so a risky project can have tight constraints while a personal sandbox can be open. [Anthropic settings docs](https://code.claude.com/docs/en/settings)

---

## Con Arguments (with sources)

### --dangerously-skip-permissions Has Caused Documented Catastrophic Data Loss
- **October 2025 (Mike Wolak):** Claude executed `rm -rf` from root (`/`). Thousands of "Permission denied" errors from system paths before Linux stopped it. Only luck (non-root user) prevented full OS destruction. [Thomas Wiegold blog](https://thomas-wiegold.com/blog/claude-code-dangerously-skip-permissions/)
- **November 2025 (Jeffrey Urban):** Claude created a directory literally named `~`. A later `rm -rf *` expanded to delete the tilde directory, which the shell interpreted as the home directory. [Thomas Wiegold blog](https://thomas-wiegold.com/blog/claude-code-dangerously-skip-permissions/)
- **December 2025 (Reddit, r/ClaudeAI):** User asked Claude to clean up old repo packages. Claude generated `rm -rf tests/ patches/ plan/ ~/` — the trailing `~/` expanded to the entire home directory. Desktop files, Keychain passwords, application data all lost. [Thomas Wiegold blog](https://thomas-wiegold.com/blog/claude-code-dangerously-skip-permissions/), [reddit discussion cited therein]
- **January 2026 (James McAulay):** Claude deleted ~11 GB of files during a folder organization task despite explicit instructions to retain user data. Task list marked "Delete user data folder: Completed." [ksred.com](https://www.ksred.com/claude-code-dangerously-skip-permissions-when-to-use-it-and-when-you-absolutely-shouldnt/)

### Permission System Ignores Its Own Rules — Multiple Open Bugs
- **GitHub Issue #26980** (OPEN, no label): Claude Code ignores permission mode settings entirely and executes file edits (`Write`/`Edit`) without approval even when configured to require it. Issue documents secondary cases including:
  - #23913: 2,229 files deleted autonomously
  - #27063: Production database wiped (60+ tables dropped)
  - #26913: 21 database tables dropped without confirmation
  - #27507: 1,448 trade backtest results deleted without prompt
  [GitHub Issue #26980](https://github.com/anthropics/claude-code/issues/26980)
- **GitHub Issue #27002**: User explicitly selects "No" on permission prompt — Claude executes the command anyway. [Referenced in #26980]
- **GitHub Issue #4365**: `settings.json` global deny commands are flat-out ignored. Developers setting deny rules for `.env` files report Claude reads them anyway. [GitHub Issue #4365](https://github.com/anthropics/claude-code/issues/4365)

### allowedTools Consistently Buggy Across Versions
- **Issue #1071**: `--allowedTools` CLI flag ignored; Claude still prompts despite explicit whitelisting. [GitHub #1071](https://github.com/anthropics/claude-code/issues/1071)
- **Issue #1136**: Globally defined `allowedTools` not applied the first time a path is opened. [GitHub #1136](https://github.com/anthropics/claude-code/issues/1136)
- **Issue #563**: `--allowedTools` not working reliably across versions. [GitHub #563](https://github.com/anthropics/claude-code/issues/563)
- **Issue #13827**: Freshly installed Claude Code ignores `settings.json` entirely. [GitHub #13827](https://github.com/anthropics/claude-code/issues/13827)
- **Issue #33775**: Global settings allow list not applied in non-git workspaces. [GitHub #33775](https://github.com/anthropics/claude-code/issues/33775)
- **Issue #22576**: File permission approval not persisting within session or across sessions. [GitHub #22576](https://github.com/anthropics/claude-code/issues/22576)
- **Issue #12604** (VSCode extension): `allow: ["*"]` and `defaultMode: bypassPermissions` in config still prompts for every tool call. [GitHub #12604](https://github.com/anthropics/claude-code/issues/12604)

### --dangerously-skip-permissions Itself Is Broken on Recent Versions
- **Issue #36168**: `--dangerously-skip-permissions` broken in all versions newer than v2.1.77. Users confirmed rolling back to v2.1.77 as workaround. [GitHub #36168](https://github.com/anthropics/claude-code/issues/36168)
- **Issue #12261**: Even with the flag set, Claude still prompts for permissions before executing bash commands. [GitHub #12261](https://github.com/anthropics/claude-code/issues/12261)
- **Issue #17544**: `--dangerously-skip-permissions` ignores `--permission-mode` flag entirely, overriding plan mode. [GitHub #17544](https://github.com/anthropics/claude-code/issues/17544)
- **Issue #8539** (VSCode): VS Code extension runs Claude internally — no way to pass `--dangerously-skip-permissions` at all. [GitHub #8539](https://github.com/anthropics/claude-code/issues/8539)

### Auto Mode Has Known Safety Gaps
- 17% miss rate on "overeager actions" — one in six cases where Claude exceeded user intent pass through the classifier unchecked. [paddo.dev](https://paddo.dev/blog/claude-code-auto-mode-absent-human/)
- Simon Willison (prominent developer/blogger): AI-based safety protections are "non-deterministic by nature." Classifier may still allow risky actions when intent is ambiguous. Advocates for OS-level deterministic sandbox instead of prompt-based protections. [simonwillison.net, 2026-03-24](https://simonwillison.net/2026/Mar/24/auto-mode-for-claude-code/)
- Default allow list includes `pip install -r requirements.txt` — classifier evaluates commands, not consequences, creating a supply chain attack blind spot. [simonwillison.net](https://simonwillison.net/2026/Mar/24/auto-mode-for-claude-code/)
- Circular reasoning concern: "the judge and defendant are the same process" — using Claude to evaluate Claude's actions. [paddo.dev](https://paddo.dev/blog/claude-code-auto-mode-absent-human/)
- Auto mode available only on Team plan as of March 2026 — not available to individual Pro users or API users without upgrade. [Anthropic blog](https://claude.com/blog/auto-mode)

### Permission Noise Creates Its Own Risk
- Claude asks approximately 100 permissions per hour in default mode. Cognitive overload causes developers to rubber-stamp approvals without reading them — arguably worse than fewer prompts. [Thomas Wiegold blog](https://thomas-wiegold.com/blog/claude-code-dangerously-skip-permissions/)
- Wildcard patterns like `Bash(rm /tmp/mermaid:*)` still prompted every single time — causing developers to escalate to full bypass out of frustration rather than using fine-grained controls. [korny.info](https://blog.korny.info/2025/10/10/better-claude-code-permissions)

### Security Vulnerabilities in the Trust Model
- **CVE-2025-59536** (CVSS 8.7): Code injection vulnerability — arbitrary shell commands execute automatically upon tool initialization when Claude Code starts in an untrusted directory, before any permission checks. [The Hacker News](https://thehackernews.com/2026/02/claude-code-flaws-allow-remote-code.html)
- **CVE-2026-21852** (CVSS 5.3): If a repository's `settings.json` sets `ANTHROPIC_BASE_URL` to attacker-controlled endpoint, API requests (including API keys) leak before the trust prompt appears. [Check Point Research](https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/)
- Claude Code ignores `.gitignore`-style rules meant to block secrets files. [The Register, 2026-01-28](https://www.theregister.com/2026/01/28/claude_code_ai_secrets_files/)

---

## Notable User Reports

### Kyle Redelinghuys (2025) — Positive
Nine-hour autonomous session successfully completed a complex financial analysis system. Represents the productivity ceiling when skip-permissions is used correctly (isolated environment). Cited repeatedly as the canonical success case. [Source: ksred.com]

### Mike Wolak (October 2025) — Negative
`rm -rf` executed from `/` on a firmware project. Thousands of permission-denied errors. Only survived because running as non-root user. Became a canonical warning case. [Source: Thomas Wiegold blog]

### Jeffrey Urban (November 2025) — Negative
Created directory named `~`, followed by `rm -rf *` — shell expanded `~` as home directory. All home directory contents deleted. Illustrates that the failures are not always obvious `rm -rf ~/` — they can be subtle shell expansion issues. [Source: Thomas Wiegold blog]

### James McAulay (January 2026) — Negative
~11 GB deleted during folder organization. Explicit "retain user data" instruction ignored. Task list auto-checked "Delete user data folder: Completed." Illustrates that even explicit safeguards in prompts don't prevent destructive actions in YOLO mode. [Source: ksred.com]

### r/ClaudeAI December 2025 — Negative
User asked Claude to clean up old repo packages. Claude generated `rm -rf tests/ patches/ plan/ ~/`. Home directory lost. Desktop files, Keychain passwords destroyed. Widely cited in the community as a reminder that trailing path arguments can be catastrophic. [Source: Thomas Wiegold blog, ksred.com]

### GitHub Issue #26980 — Negative (HIGH SEVERITY)
Multiple users reporting permission bypass resulting in:
- 2,229 files deleted autonomously
- Production database wiped (60+ tables)
- 1,448 trade backtest results deleted
These occurred **without** `--dangerously-skip-permissions` — in normal mode with safety features active. This is not YOLO mode; this is the default permission system failing. Issue remains OPEN with zero official labels as of last observed state. [GitHub #26980](https://github.com/anthropics/claude-code/issues/26980)

### Korny (October 2025) — Neutral/Constructive
Frustrated that wildcard permissions kept prompting despite configuration, built a custom Rust permission hook using the hooks API. Claude Code vibe-coded 95% of the tool. Demonstrates that the hooks system is capable but requires significant effort to use correctly — and that the built-in wildcard system is broken enough to warrant a DIY replacement. [korny.info](https://blog.korny.info/2025/10/10/better-claude-code-permissions)

### Simon Willison (March 2026) — Skeptical of Auto Mode
Respected developer and blogger. Welcomed the feature but remains unconvinced. Advocates for deterministic OS-level sandboxing over AI classifier-based safety. Cited supply chain blind spot with `pip install`. Represents the technically sophisticated segment of the community that views auto mode as incremental, not transformative. [simonwillison.net](https://simonwillison.net/2026/Mar/24/auto-mode-for-claude-code/)

---

## Follow-up Tasks Created

None created — this is a standalone investigation with no project purchase decisions pending.

---

## Bidirectional Search

- **Searched FOR:**
  - "claude code allowedTools auto permissions user experience"
  - "claude code approve all productivity love great developer experience"
  - "claude code unattended headless psmux tmux autonomous session positive workflow"
  - "claude code auto mode user experience review March 2026"
  - "claude code permission hook workflow productivity positive"

- **Searched AGAINST:**
  - "claude code dangerously-skip-permissions deleted files broke production"
  - "claude code permission mode ignores unauthorized edits issue"
  - "claude code settings.json allowedTools ignored not working"
  - "hackernews claude code permissions dangerous problem data loss"
  - "claude code auto mode negative criticism non-deterministic classifier"

- **Contradicting evidence found:** Yes — substantial.
  - The "productivity wins" narrative from isolated container + YOLO mode is contradicted by multiple documented data loss incidents on bare metal, including in default (non-YOLO) mode.
  - The "93% of prompts are safe" justification for auto mode is contradicted by the 17% overeager action miss rate and open GitHub issues showing the permission system ignores its own deny rules.
  - The `allowedTools` whitelist approach — positioned as the fine-grained safe alternative — has at least 7 distinct open bug reports showing it doesn't work reliably across modes, versions, or workspace types.

---

## Sources

1. [Configure permissions - Claude Code Docs](https://code.claude.com/docs/en/permissions)
2. [Claude Code dangerously-skip-permissions: Why It's Tempting, Why It's Dangerous — Thomas Wiegold](https://thomas-wiegold.com/blog/claude-code-dangerously-skip-permissions/)
3. [Claude Code --dangerously-skip-permissions: Safe Usage Guide + Configs — ksred.com](https://www.ksred.com/claude-code-dangerously-skip-permissions-when-to-use-it-and-when-you-absolutely-shouldnt/)
4. [Claude Code auto mode: a safer way to skip permissions — Anthropic Engineering Blog](https://www.anthropic.com/engineering/claude-code-auto-mode)
5. [Auto mode for Claude Code — Anthropic](https://claude.com/blog/auto-mode)
6. [Auto mode for Claude Code — Simon Willison, 2026-03-24](https://simonwillison.net/2026/Mar/24/auto-mode-for-claude-code/)
7. [Claude Code Auto Mode: The Absent Human — paddo.dev](https://paddo.dev/blog/claude-code-auto-mode-absent-human/)
8. [Better Claude Code permissions — korny.info, 2025-10-10](https://blog.korny.info/2025/10/10/better-claude-code-permissions)
9. [GitHub Issue #26980: Claude Code ignores permission modes and makes unauthorized file edits](https://github.com/anthropics/claude-code/issues/26980)
10. [GitHub Issue #36168: Bypass/dangerously skip permissions broken in versions newer than v2.1.77](https://github.com/anthropics/claude-code/issues/36168)
11. [GitHub Issue #12261: dangerously-skip-permissions still prompts](https://github.com/anthropics/claude-code/issues/12261)
12. [GitHub Issue #17544: --dangerously-skip-permissions ignores --permission-mode flag](https://github.com/anthropics/claude-code/issues/17544)
13. [GitHub Issue #8539: VS Code extension no longer allows --dangerously-skip-permissions](https://github.com/anthropics/claude-code/issues/8539)
14. [GitHub Issue #1071: --allowedTools ignored](https://github.com/anthropics/claude-code/issues/1071)
15. [GitHub Issue #1136: globally defined allowedTools not applied on first path open](https://github.com/anthropics/claude-code/issues/1136)
16. [GitHub Issue #563: --allowedTools not working reliably](https://github.com/anthropics/claude-code/issues/563)
17. [GitHub Issue #13827: Fresh install ignores settings.json](https://github.com/anthropics/claude-code/issues/13827)
18. [GitHub Issue #4365: Global deny commands ignored](https://github.com/anthropics/claude-code/issues/4365)
19. [GitHub Issue #33775: Global settings not applied in non-git workspaces](https://github.com/anthropics/claude-code/issues/33775)
20. [GitHub Issue #22576: File permission approval not persisting within session](https://github.com/anthropics/claude-code/issues/22576)
21. [GitHub Issue #12604: VSCode extension ignores bypassPermissions in settings](https://github.com/anthropics/claude-code/issues/12604)
22. [CVE-2025-59536 / CVE-2026-21852 — Check Point Research](https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/)
23. [Claude Code Flaws Allow Remote Code Execution and API Key Exfiltration — The Hacker News](https://thehackernews.com/2026/02/claude-code-flaws-allow-remote-code.html)
24. [Claude Code ignores ignore rules meant to block secrets — The Register, 2026-01-28](https://www.theregister.com/2026/01/28/claude_code_ai_secrets_files/)
25. [YOLO Mode: When You're Tired of Claude Asking Permission for Everything — DEV Community](https://dev.to/rajeshroyal/yolo-mode-when-youre-tired-of-claude-asking-permission-for-everything-2daf)
26. [How I Automated My Entire Claude Code Workflow with Hooks — DEV Community](https://dev.to/ji_ai/how-i-automated-my-entire-claude-code-workflow-with-hooks-5cp8)
27. [How Can Claude Code Hooks Automate Permission Management — BSWEN](https://docs.bswen.com/blog/2026-03-21-claude-code-hooks-auto-permissions/)
28. [Run Claude Code programmatically (headless) — Anthropic Docs](https://code.claude.com/docs/en/headless)
29. [Feature Request: claude remote-control --headless — GitHub Issue #30447](https://github.com/anthropics/claude-code/issues/30447)
30. [GitHub Issue #19978: Contradictory security advice regarding --dangerously-skip-permissions](https://github.com/anthropics/claude-code/issues/19978)
