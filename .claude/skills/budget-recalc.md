# Skill: Budget Recalculation for Garage Conversion Documents

## When to Use

Use this skill whenever a component changes in `POR/Garage_Conversion_Option1.md` that affects cost — including adding, removing, or repricing a line item, changing sub enclosure types, stage depth, nearfield configuration, or any other budgeted element.

## Critical Rule: POR and Option D Are Separate Budgets

The document contains TWO independent budget structures. They must NEVER cross-contaminate.

### POR Budget (lines ~459-706)
- **Phase 1 — Building Prep** (~line 459): Openings, Partition, WC, HVAC, Electrical, Flooring, Finish & Permits
- **Phase 2 — Home Theater** (~line 556): Projector & Screen, Processor & DSP, Speakers, Sub Drivers, Sub Amps, Sub Enclosures, Bass Shakers, Seating, Theater Construction, Infrastructure & Wiring
- **Already Owned Inventory** (~line 560): separate from remaining spend
- **Phase 1 Total** (~line 541): sum of Phase 1 subtotals
- **Phase 2 Summary** (~line 679): sum of Phase 2 subtotals = "Remaining Spend"; plus Already Owned = "Total System Value"
- **Total Project Budget** (~line 699): Phase 1 + Phase 2

### Option D Budget (~lines 1042-1101)
- **Option D Phase 1 — Building Prep** (~line 1042): Its own line-item table (different from POR Phase 1 — no WC, N-S partition, different costs)
- **Option D Phase 2**: Does NOT have its own Phase 2 line-item table. It shares POR Phase 2 line items BUT with different costs for sub enclosures and theater construction (rectangular cabinets vs triangular columns, different stage build). The Phase 2 total for Option D ($29,095 at time of writing) differs from POR Phase 2 ($29,685).
- **Option D Grand Total** (~line 1076): Option D Phase 1 + Option D Phase 2
- **Option D vs POR comparison table** (~line 1084): compares dimensions, costs, features

### What This Means in Practice

- If you change a POR Phase 1 line item (e.g., WC cost): update POR Phase 1 only. Option D Phase 1 has its own separate table — it has NO WC line items so nothing changes there.
- If you change a POR Phase 2 line item that is shared identically (e.g., projector, processor, speakers, sub amps, bass shakers, seating, infrastructure): update POR Phase 2 AND recalculate Option D Phase 2 total (both use the same unit costs).
- If you change a line item that differs between POR and Option D (sub enclosures, theater construction/stage): update the correct section(s). POR has triangular corner columns + dual-opposed nearfield cabinets; Option D has rectangular stacked cabinets + forward-firing nearfield. Different materials, different costs.
- If you change the Already Owned Inventory: both POR and Option D reference the same owned inventory total ($13,450). Update both grand total tables.
- NEVER accidentally change POR Phase 1 totals when editing Option D, or vice versa.

## Recalculation Procedure

When a line item changes, follow this exact sequence:

### Step 1: Identify Scope
Determine which budget section(s) the change affects:
- POR Phase 1 only?
- POR Phase 2 only?
- Option D Phase 1 only?
- Option D Phase 2 (implicit, derived from POR Phase 2 with modifications)?
- Both POR and Option D?
- Already Owned Inventory (affects both)?

### Step 2: Update Line Items
Change the individual line item cost(s) in the relevant table(s).

### Step 3: Recalculate Subtotals (Bottom-Up)
Sum line items within each category to get the category subtotal. Example:
- Corner column #1 ($350) + #2 ($350) + #3 ($350) + #4 ($350) + nearfield riser ($200) + nearfield sofa table ($200) = Sub enclosures subtotal ($1,800)

### Step 4: Recalculate Phase Totals
Sum all category subtotals to get the phase total.
- **POR Phase 1 Total**: Openings + Partition + WC + HVAC + Electrical + Flooring + Finish & Permits
- **POR Phase 2 Remaining Spend**: sum of all Phase 2 subtotals (projector/screen + processor/DSP + speakers + sub drivers + sub amps + sub enclosures + bass shakers + seating + theater construction + infrastructure)
- **POR Phase 2 Total System Value**: Phase 2 Remaining Spend + Already Owned
- **Option D Phase 1 Total**: sum of all Option D Phase 1 line items
- **Option D Phase 2**: derived total (POR Phase 2 remaining spend, adjusted for differing sub enclosure and theater construction costs)

### Step 5: Recalculate Grand Totals
- **POR Grand Total** (Total Project Budget table ~line 699):
  - Remaining Spend = Phase 1 Total + Phase 2 Remaining Spend
  - Already Owned = Phase 2 Already Owned
  - Total Value = Remaining Spend + Already Owned
- **Option D Grand Total** (~line 1076):
  - Remaining Spend = Option D Phase 1 + Option D Phase 2
  - Already Owned = same as POR ($13,450)
  - Total Value = Remaining Spend + Already Owned

### Step 6: Update Comparison Tables and Prose
These downstream references must all be updated:
- **Comparison to Reference Design** table (~line 711): "A/V full value", "A/V remaining spend", "Room construction", "Total out-of-pocket" rows
- **Property Value Analysis** table (~line 752): "Phase 1", "Phase 2", "Total" out-of-pocket figures
- **Option D vs POR** comparison table (~line 1084): "Building prep cost" and "Total out-of-pocket" rows
- **"What You Gain Over POR"** prose (~line 1103): dollar difference callout (e.g., "$7,300 less out-of-pocket")
- **Prose references** scattered in the document: any sentence mentioning ~$53,700 (POR OOP), ~$46,400 (Option D OOP), ~$29,700 (Phase 2 spend), etc. Search for all dollar amounts that match the old values.
- **Key Differences Across Versions** table (~line 1142): "Budget (out-of-pocket)" and "Budget (Phase 2 spend)" rows

### Step 7: Update Changelog
Add a `**Changes vX.X:**` line at the bottom of the document (~line 1183) describing what changed and the new totals.

## Verification Checklist

After recalculation, verify:
- [ ] Each category subtotal = sum of its line items
- [ ] POR Phase 1 Total = sum of POR Phase 1 subtotals
- [ ] POR Phase 2 Remaining Spend = sum of POR Phase 2 subtotals
- [ ] POR Phase 2 Total System Value = Remaining Spend + Already Owned
- [ ] POR Grand Total Remaining Spend = Phase 1 + Phase 2 Remaining Spend
- [ ] POR Grand Total Value = Grand Total Remaining Spend + Already Owned
- [ ] Option D Phase 1 Total = sum of Option D Phase 1 line items
- [ ] Option D Grand Total = Option D Phase 1 + Option D Phase 2
- [ ] Comparison tables match computed totals
- [ ] Prose dollar references match computed totals
- [ ] POR totals were NOT changed if only Option D was modified (and vice versa)
- [ ] Already Owned total is consistent across both sections

## Common Pitfalls

1. **Changing POR subtotals when only Option D changed.** The two budgets are independent. If you modify Option D's sub enclosure design, POR's sub enclosure subtotal must NOT change.
2. **Forgetting the Option D vs POR delta.** Option D Phase 2 differs from POR Phase 2 in sub enclosures and theater construction costs. When POR Phase 2 shared items change, Option D Phase 2 changes by the same amount. When POR-specific items change (e.g., POR's triangular columns), Option D is unaffected.
3. **Stale prose references.** Dollar figures appear in narrative paragraphs, not just tables. Search the entire document for the old dollar amount before finishing.
4. **Rounding in prose.** Tables use exact figures ($53,685). Prose uses rounded figures (~$53,700). Keep both conventions consistent — update the rounded prose to match the new exact total.
5. **Already Owned is shared.** Both POR and Option D reference the same $13,450 in owned equipment. If this changes, update both grand total tables.
