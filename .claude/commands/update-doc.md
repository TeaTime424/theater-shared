---
name: update-doc
description: Read a POR or research document, apply changes, write back
context: fork
---

Update the following document: $ARGUMENTS

## Instructions

1. Read the specified file from POR/ or research/
2. Understand the requested changes
3. Apply changes while preserving:
   - Document structure and formatting
   - Existing content not affected by the change
   - Revision history (add new entry)
   - Cross-references to other documents
4. Write the updated file back to its original location
5. Return ONLY a brief summary of what was changed (3-5 sentences)

## Rules
- Never remove content without explicit instruction
- Update revision history with date and change summary
- If the change conflicts with other POR documents, note the conflict
- Preserve all tables, code blocks, and formatting
