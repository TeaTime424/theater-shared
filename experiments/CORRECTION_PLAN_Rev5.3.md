# Home Theater Documentation Correction Plan
## Revision 5.2 → 5.3 Updates

**Date Created:** November 23, 2024  
**Purpose:** Document all required corrections to achieve proper 9.4.6 system specification  
**Target:** Home_Theater_System_Complete_Design_Rev5_3.md (and all extracted files)

---

## Critical Issues Identified

### Issue #1: Incorrect Surround Speaker Count ❌ CRITICAL

**Problem:**
- Current documentation shows **4× surround speakers**
- Describes only 2 side surrounds + 2 rear surrounds
- This creates an **incorrect 7.4.6 system**, not 9.4.6

**Root Cause:**
- 9.4.6 format was misunderstood
- 9 = 3 LCR + **6 surrounds** (not 4)
- 4 = subwoofers
- 6 = Atmos height channels

**Required Fix:**
Change from 4 surrounds to **6 surrounds**:
- Keep: 2× side surrounds (positions 4-5)
- Update: 4× rear surrounds (positions 6-9), not 2

**Impact:**
- Speaker count: +2 HT-12 speakers
- Budget impact: +$578-1,200 (2 additional HT-12)
- Amplification: Already adequate (NC252MP has sufficient channels)
- Wiring: Additional 2 speaker runs to rear wall

---

### Issue #2: Encoding Corruption Throughout Documents ❌

**Problem:**
Multiple instances of UTF-8 character corruption:

| Corrupted | Should Be | Frequency |
|-----------|-----------|-----------|
| `3'` | `3×` | ~50 instances |
| `4'` | `4×` | ~60 instances |
| `6ƒ"` | `6×` | ~30 instances |
| `8'` | `8×` | ~20 instances |
| `'` | `×` | ~100 instances |
| `ft'³³` | `ft³` | ~15 instances |
| `Ã—` | `×` | ~50 instances |
| `ƒ×š¬³` | `—` | ~10 instances |

**Required Fix:**
- Run encoding cleanup on all files
- Replace all corrupted multiplication signs
- Replace all corrupted em-dashes
- Replace all corrupted superscripts
- Verify no data loss during replacement

---

## Detailed Correction Specifications

### Section 1: Speaker System Configuration

#### Current (INCORRECT):
```markdown
**Configuration:** 9.4.6 Dolby Atmos
- 3× LCR (DIYSG Titan-815LX)
- 4× Surrounds (DIYSG HT-12)  ← WRONG
- 6× Atmos (DIYSG Volt-10)
- 4× Subwoofers (Dual UM18-22 sealed)
```

#### Corrected (v5.3):
```markdown
**Configuration:** 9.4.6 Dolby Atmos
- 3× LCR (DIYSG Titan-815LX)
- 6× Surrounds (DIYSG HT-12)  ← CORRECTED
  - 2× Side surrounds (positions 4-5)
  - 4× Rear surrounds (positions 6-9)
- 6× Atmos (DIYSG Volt-10)
  - 4× Front Atmos (above/between LCR)
  - 2× Rear Atmos (ceiling, above Row 2)
- 4× Subwoofers (Dual UM18-22 sealed)
  - 2× Front (floor, corner pockets)
  - 2× Rear (floor, rear corners)
```

---

### Section 2: Surround Speaker Specifications (05_Speaker_System.md)

#### Current (INCORRECT):
```markdown
**Side Surrounds (9.4.6 positions 4-5):**
- Model: DIY Sound Group HT-12
- Sensitivity: 96 dB (2.83V/1m)
- Placement: Side walls at seating height
- Quantity: 2 (left and right)

**Rear Surrounds (9.4.6 positions 6-7):**  ← WRONG (should be 6-9)
- Model: DIY Sound Group HT-12
- Sensitivity: 96 dB (2.83V/1m)
- Placement: Rear wall, mounted above backrest wall
- Height: 66-72 inches from floor (6-12" above backrest)
- Spacing: 10 feet apart (left and right)  ← INCOMPLETE
- Quantity: 2 (implied, but should be 4)  ← WRONG
```

#### Corrected (v5.3):
```markdown
**Side Surrounds (9.4.6 positions 4-5):**
- Model: DIY Sound Group HT-12
- Sensitivity: 96 dB (2.83V/1m)
- Placement: Side walls at seating height
- Quantity: 2 (left and right)
- Distance from screen: 13-18 feet (between rows)
- Height: Ear level for Row 1 (42-48" from floor)

**Rear Surrounds (9.4.6 positions 6-9):**  ← CORRECTED
- Model: DIY Sound Group HT-12
- Sensitivity: 96 dB (2.83V/1m)
- Placement: Rear wall, mounted above backrest wall
- Height: 66-72 inches from floor (6-12" above backrest)
- **Quantity: 4 total** ← ADDED
  - 2× Rear left (positions 6-7)
  - 2× Rear right (positions 8-9)
- **Layout:** Two-row configuration for dual-row seating
  - Rear surrounds positioned to cover both Row 1 and Row 2
  - Dolby guidelines: 135-150° from center for each row
- Acoustic path: Clear (above backrest, no occlusion)
- Mounting: To actual rear room wall
- Spacing: Optimized for 16' room width and dual-row coverage

**Total Surround Count: 6 speakers** (2 side + 4 rear)
- This creates proper 9.4.6 configuration
- 9 ear-level channels = 3 LCR + 6 surrounds
```

---

### Section 3: Amplification (06_Electronics_and_Control.md)

#### Current:
```markdown
**Surround & Atmos Channels:**
- Amplifier: Buckeye Hypex NC252MP (rack-mounted, multi-channel)
- Power: 200W @ 4Ω per channel
- Channels needed: 2 (side surrounds) + 2 (rear surrounds) + 6 (Atmos) = 10 total
```

#### Corrected (v5.3):
```markdown
**Surround & Atmos Channels:**
- Amplifier: Buckeye Hypex NC252MP (rack-mounted, multi-channel)
- Power: 200W @ 4Ω per channel (adequate for 96dB sensitivity HT-12s)
- **Channels needed: 2 (side surrounds) + 4 (rear surrounds) + 6 (Atmos) = 12 total** ← UPDATED
- **Configuration:** Two NC252MP 6-channel units required (or single 12+ channel unit if available)
- Location: Equipment rack on front stage

**Note:** NC252MP available in 2, 4, 6, and 8-channel configurations. System requires:
- Option A: 2× NC252MP-6 (two 6-channel units = 12 channels)
- Option B: 1× NC252MP-8 + 1× NC252MP-4 (8+4 = 12 channels)
```

---

### Section 4: Budget Impact (10_Materials_and_Equipment.md & 11_Budget_Summary.md)

#### Current (INCORRECT):
```markdown
**Surrounds:**
- 4× DIYSG HT-12 @ $289-300 = $1,156-1,200
```

#### Corrected (v5.3):
```markdown
**Surrounds:**
- 6× DIYSG HT-12 @ $289-300 = $1,734-1,800  ← UPDATED (+$578-600)

**Breakdown:**
- Side surrounds: 2× HT-12 = $578-600
- Rear surrounds: 4× HT-12 = $1,156-1,200
- Total: 6× HT-12 = $1,734-1,800
```

#### Total Speaker Budget Update:
```markdown
**Current (v5.2 - INCORRECT):**
- LCR: 3× Titan-815LX = $4,500-6,000
- Surrounds: 4× HT-12 = $1,156-1,200
- Atmos: 6× Volt-10 = $1,452-2,400
- LCR isolation: $72-96
- **Total: $7,180-9,696**

**Corrected (v5.3):**
- LCR: 3× Titan-815LX = $4,500-6,000
- Surrounds: 6× HT-12 = $1,734-1,800  ← +$578-600
- Atmos: 6× Volt-10 = $1,452-2,400
- LCR isolation: $72-96
- **Total: $7,758-10,296**  ← +$578-600
```

#### Grand Total Update:
```markdown
**Current (v5.2 - INCORRECT):**
Total: ~$68,676-85,044

**Corrected (v5.3):**
Total: ~$69,254-85,644  ← +$578-600

**Recommended Budget (with 10% contingency):**
$80,000-90,000 (unchanged, already included adequate contingency)
```

---

### Section 5: Equipment Rack Layout (02_Front_Stage_System.md)

#### Current:
```markdown
**Equipment layout in rack:**
- Buckeye NC252MP (surrounds): 2U
- Buckeye NC252MP (Atmos): 2U
```

#### Corrected (v5.3):
```markdown
**Equipment layout in rack:**
- Buckeye NC252MP (surrounds): 2U  ← 6-channel unit for 6 surrounds
- Buckeye NC252MP (Atmos): 2U  ← 6-channel unit for 6 Atmos
**OR:**
- Buckeye NC252MP #1 (6-channel): 2U  ← Handles 6 surrounds
- Buckeye NC252MP #2 (6-channel): 2U  ← Handles 6 Atmos

**Note:** Two 6-channel NC252MP units provide 12 total channels (6 surrounds + 6 Atmos)
```

---

### Section 6: Quick Reference (14_Quick_Reference.md)

#### Current (INCORRECT):
```markdown
**Configuration:** 9.4.6 Dolby Atmos
- 3× LCR (DIYSG Titan-815LX) - on stage deck
- 4× Surrounds (DIYSG HT-12)  ← WRONG
- 6× Atmos (DIYSG Volt-10)
```

#### Corrected (v5.3):
```markdown
**Configuration:** 9.4.6 Dolby Atmos
- 3× LCR (DIYSG Titan-815LX) - on stage deck
- 6× Surrounds (DIYSG HT-12)  ← CORRECTED
  - 2× Side (positions 4-5)
  - 4× Rear (positions 6-9)
- 6× Atmos (DIYSG Volt-10)
  - 4× Front height
  - 2× Rear height
- 4× Subwoofers (Dual UM18-22 sealed)
- 6× Crowson transducers
- Equipment rack: 42U, on stage deck beside LCR

**Total Speaker Count: 19 speakers**
- 3 LCR + 6 surrounds + 6 Atmos + 4 subs = 19 speakers
- Plus: 6 Crowson tactile transducers (embedded in couches)
```

---

## File-by-File Correction Checklist

### Files Requiring Speaker Count Updates:

| File | Section | Current | Corrected | Priority |
|------|---------|---------|-----------|----------|
| **00_Master_Index.md** | Quick Nav | "4× Surrounds" | "6× Surrounds (2 side + 4 rear)" | HIGH |
| **05_Speaker_System.md** | Surround Speakers | Positions 6-7, qty 2 | Positions 6-9, qty 4 | CRITICAL |
| **05_Speaker_System.md** | Speaker Count | 4× HT-12 | 6× HT-12 | CRITICAL |
| **06_Electronics_and_Control.md** | Amplification | 10 channels needed | 12 channels needed | HIGH |
| **06_Electronics_and_Control.md** | Amp Config | 1× NC252MP or split | 2× NC252MP-6 or 1×NC252MP-12 | HIGH |
| **10_Materials_and_Equipment.md** | Surrounds | $1,156-1,200 | $1,734-1,800 | HIGH |
| **10_Materials_and_Equipment.md** | Speaker Total | $7,180-9,696 | $7,758-10,296 | HIGH |
| **11_Budget_Summary.md** | Speakers Line | $7,180-9,696 | $7,758-10,296 | HIGH |
| **11_Budget_Summary.md** | Grand Total | $68,676-85,044 | $69,254-85,644 | HIGH |
| **14_Quick_Reference.md** | Config Summary | "4× Surrounds" | "6× Surrounds" | CRITICAL |
| **14_Quick_Reference.md** | Speaker Detail | No breakdown | "2 side + 4 rear" | HIGH |

### Files Requiring Encoding Cleanup:

| File | Issue Type | Instances | Priority |
|------|-----------|-----------|----------|
| **ALL .md files** | `'` → `×` | ~100 | HIGH |
| **ALL .md files** | `ft'³³` → `ft³` | ~15 | MEDIUM |
| **ALL .md files** | `ƒ×š¬³` → `—` | ~10 | MEDIUM |
| **03_Subwoofer_System.md** | Multiple encoding | ~50 | HIGH |
| **12_Technical_Appendix.md** | Superscripts | ~20 | HIGH |

---

## Implementation Steps

### Phase 1: Create Corrected Master Document (Rev 5.3)

**Step 1:** Load Home_Theater_System_Complete_Design_Rev5_2.md

**Step 2:** Execute speaker count corrections:
- [ ] Update system configuration (3+6+6+4)
- [ ] Expand surround speaker section (positions 6-9)
- [ ] Add 4× rear surround specifications
- [ ] Update amplification requirements (12 channels)
- [ ] Update all budget figures (+$578-600)

**Step 3:** Execute encoding cleanup:
- [ ] Replace all `'` with `×`
- [ ] Replace all `ft'³³` with `ft³`
- [ ] Replace all `ƒ×š¬³` with `—`
- [ ] Verify no data loss

**Step 4:** Update version control:
- [ ] Change version to 5.3
- [ ] Update "Last Updated" date
- [ ] Add revision history entry
- [ ] Document cost impact

**Step 5:** Verify consistency:
- [ ] All speaker counts match (15 speakers: 3+6+6)
- [ ] All budget figures updated
- [ ] All amplification specs correct
- [ ] All encoding clean

---

### Phase 2: Re-Extract Modular Files

**Process:**
1. Extract each section from corrected Rev5_3.md
2. Verify speaker counts in each file
3. Verify encoding cleanliness
4. Update cross-references between files

**Files to Re-Extract:**
- [ ] 00_Master_Index.md
- [ ] 01_Project_Overview_and_Room.md (minimal changes)
- [ ] 02_Front_Stage_System.md (rack layout update)
- [ ] 03_Subwoofer_System.md (encoding only)
- [ ] 04_Seating_and_Riser.md (minimal changes)
- [ ] 05_Speaker_System.md (CRITICAL - major updates)
- [ ] 06_Electronics_and_Control.md (amplification update)
- [ ] 07_Lighting_and_HVAC.md (minimal changes)
- [ ] 08_Construction_Timeline.md (minimal changes)
- [ ] 09_Design_Decisions_Rationale.md (add surround explanation)
- [ ] 10_Materials_and_Equipment.md (budget updates)
- [ ] 11_Budget_Summary.md (total updates)
- [ ] 12_Technical_Appendix_Subwoofers.md (encoding only)
- [ ] 13_Safety_Code_Maintenance.md (minimal changes)
- [ ] 14_Quick_Reference.md (CRITICAL - config summary)

---

### Phase 3: Validation & Verification

**Validation Checklist:**

**Speaker Count Validation:**
- [ ] Every mention of "9.4.6" includes breakdown (3+6+6+4)
- [ ] Surround count = 6 throughout all files
- [ ] Side surrounds = 2 (positions 4-5)
- [ ] Rear surrounds = 4 (positions 6-9)
- [ ] Atmos count = 6 (4 front + 2 rear)
- [ ] Total speakers = 15 (3 LCR + 6 surround + 6 Atmos)
- [ ] Plus 4 subs = 19 total speaker units

**Budget Validation:**
- [ ] Surround cost = $1,734-1,800 (6× HT-12)
- [ ] Speaker total = $7,758-10,296
- [ ] Grand total = $69,254-85,644
- [ ] All costs consistent across files

**Amplification Validation:**
- [ ] NC252MP channels = 12 total (6 surround + 6 Atmos)
- [ ] Configuration specified (2× 6-channel or 1× 12-channel)
- [ ] Rack space accurate (2U or 4U depending on config)

**Encoding Validation:**
- [ ] No `'` characters (except in possessives/contractions)
- [ ] All multiplication signs are `×`
- [ ] All superscripts render properly (ft³, cm², etc.)
- [ ] All em-dashes render properly (—)

---

## Progress Tracking

### Conversation 1 (Current):
- [X] Issue identification complete
- [X] Correction plan documented
- [ ] Master document correction (Rev 5.3)
- [ ] Modular file re-extraction
- [ ] Validation

### Future Conversations:
**Use this section to track progress across multiple sessions**

#### Conversation 2:
- [ ] Load this correction plan
- [ ] Execute Phase 1 corrections on master document
- [ ] Generate Rev 5.3 master file
- [ ] Initial validation

#### Conversation 3:
- [ ] Extract modular files from Rev 5.3
- [ ] Verify each file individually
- [ ] Update cross-references

#### Conversation 4:
- [ ] Final validation
- [ ] Generate verification report
- [ ] Mark project complete

---

## Key Reference Information

### Correct 9.4.6 System Breakdown:
- **9 ear-level channels:**
  - 3 LCR (Titan-815LX)
  - 2 side surrounds (HT-12)
  - 4 rear surrounds (HT-12)
- **4 subwoofers:**
  - 2 front (dual 18" sealed)
  - 2 rear (dual 18" sealed)
- **6 height channels:**
  - 4 front Atmos (Volt-10)
  - 2 rear Atmos (Volt-10)

### Total Speaker Count:
- 3 LCR + 6 surrounds + 6 Atmos = **15 speakers**
- Plus 4 subwoofers = **19 total speaker units**
- Plus 6 Crowson tactile = **25 total transducers**

### Budget Impact Summary:
- Additional 2× HT-12: +$578-600
- Updated speaker total: $7,758-10,296 (was $7,180-9,696)
- Updated grand total: $69,254-85,644 (was $68,676-85,044)
- Increase: +$578-600 (~0.7% of total budget)
- **Still within $80K-90K recommended budget range**

---

## Notes for Future Sessions

**When resuming work on this correction:**

1. **Load this file first:** `CORRECTION_PLAN_Rev5.3.md`
2. **Check Phase progress** in Progress Tracking section
3. **Reference Detailed Corrections** for specific text changes
4. **Use Validation Checklist** to verify completeness
5. **Update Progress Tracking** after each session

**Critical reminders:**
- 9.4.6 = 3 LCR + **6 surrounds** + 6 Atmos + 4 subs
- 6 surrounds = 2 side + 4 rear (not 2 side + 2 rear)
- Budget increases by ~$578-600 for additional 2× HT-12
- All encoding must be clean UTF-8 (× not ' for multiplication)

---

**Document Status:** PLANNING COMPLETE - READY FOR IMPLEMENTATION  
**Next Step:** Execute Phase 1 - Create Rev 5.3 master document  
**Estimated Time:** 2-3 conversation sessions to complete all phases

---

*This document should be preserved and referenced at the start of each work session until all corrections are complete.*
