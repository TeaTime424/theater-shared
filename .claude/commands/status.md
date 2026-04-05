---
name: status
description: Quick project overview from POR documents
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob
---

Generate a brief project status summary:

1. Read POR/00_Master_Index.md (or list POR/ directory)
2. Read POR/11_Budget_Summary.md for current budget state
3. Scan research/ for any documents marked as pending decisions
4. Return a concise status:
   - Current revision
   - Budget summary (total, major categories)
   - Pending decisions (list any DECISION PENDING items)
   - Recent changes (from revision history)
   - Open research items (files in research/ not yet adopted)

Keep response under 500 words.
