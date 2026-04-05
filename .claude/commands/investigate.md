---
name: investigate
description: Run a 4-agent adversarial investigation on a design decision
---

Run a structured adversarial investigation on the following premise: $ARGUMENTS

Follow the procedure documented in `.claude/skills/investigate.md` exactly:

1. **Check for prior investigations** in `D:\Projects\Claude\investigations/` — if a related one exists and no meaningful info has changed, cite it and skip
2. **Frame the premise** — write `D:\Projects\Claude\investigations/<slug>/00_premise.md`
3. **Launch Pro + Con researchers in parallel** — each writes to `D:\Projects\Claude\investigations/<slug>/01_pro_researcher.md` and `02_con_researcher.md`
4. **Wait for both to complete**
5. **Launch Pro + Con adversaries in parallel** — each writes to `D:\Projects\Claude\investigations/<slug>/03_pro_adversary.md` and `04_con_adversary.md`
6. **Wait for both to complete**
7. **Synthesize verdict** — write `D:\Projects\Claude\investigations/<slug>/05_verdict.md` and `README.md`
8. **Commit** to the ROOT repo: `cd D:\Projects\Claude && git add investigations/<slug>/ && git commit`

The slug should be a short kebab-case name derived from the premise (e.g., `nx6000d-vs-icepower-1200as2`).

All agents must cite specific files, line numbers, specs, and calculations. The full agent prompt templates are in the `investigate.md` skill file (check `.claude/skills/` in the current project or any parent directory).
