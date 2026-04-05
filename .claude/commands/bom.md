---
description: Extract bill of materials / shopping list from POR documents
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob
---

# Bill of Materials / Shopping List

Extract a structured, actionable purchasing list from POR documents.

## Arguments
- `$ARGUMENTS` — optional filter
  - `all` — complete BOM (default)
  - Category filter: `speakers`, `subs`, `amps`, `electronics`, `dsp`, `tactile`, `construction`, `electrical`, `acoustic`
  - Phase filter: `phase1`, `phase2`, `phase3` (maps to construction timeline)
  - If empty, default to `all`

## Source Documents

Read these POR files to build the BOM:
- `POR/10_Materials_and_Equipment.md` — primary specs and quantities
- `POR/11_Budget_Summary.md` — pricing and totals
- `POR/05_Speaker_System.md` — speaker details
- `POR/03_Subwoofer_System.md` — sub driver and enclosure details
- `POR/06_Electronics_and_Control.md` — processor, amps, DSP
- `POR/08_Construction_Timeline.md` — phase assignments (if filtering by phase)

## Steps

1. **Read** the source documents listed above
2. **Extract** every purchasable item with:
   - Item name and model
   - Quantity needed
   - Unit price (from budget doc)
   - Extended price (qty × unit)
   - Category (speakers, subs, amps, electronics, DSP, tactile, construction, electrical, acoustic treatment)
   - Vendor/source (if noted)
3. **Group** by the requested filter (category or phase)
4. **Sort** each group by extended price descending
5. **Total** each group and the grand total

## Output Format

```
## Speakers ($X,XXX)
| Qty | Item                    | Unit    | Extended | Source       |
|-----|-------------------------|---------|----------|--------------|
| 3   | DIYSG Titan-815LX kit   | $X,XXX  | $X,XXX   | DIYSG        |
| 10  | DIYSG Volt-10 kit       | $XXX    | $X,XXX   | DIYSG        |

## Subwoofers ($X,XXX)
| Qty | Item                    | Unit    | Extended | Source       |
|-----|-------------------------|---------|----------|--------------|
| 16  | Dayton UMII18-22        | $XXX    | $X,XXX   | Parts Express|

...

## GRAND TOTAL: $XX,XXX
```

Keep the output clean and copy-pasteable. If a price is not specified in the POR docs, mark it as "TBD" rather than guessing.
