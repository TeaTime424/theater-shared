# Home Theater Documentation Correction Script - Usage Guide

## Overview

The `apply_corrections_v5.3.py` script automatically applies all corrections from Rev 5.2 → Rev 5.3:

- ✅ Fixes surround speaker count (4→6 for proper 9.4.6)
- ✅ Corrects UTF-8 encoding corruption
- ✅ Updates budget figures (+$578-600)
- ✅ Updates amplification specs (10→12 channels)
- ✅ Updates version info and revision history

## Quick Start

### Windows Users (Easiest)

1. Double-click `RUN_CORRECTIONS.bat`
2. Choose an option from the menu
3. Done!

### Command Line Users

**Process single file:**
```bash
python apply_corrections_v5.3.py -s "Home_Theater_System_Complete_Design_Rev5_2.md" -o "Rev5_3.md" -v
```

**Process all files in directory (in-place with backup):**
```bash
python apply_corrections_v5.3.py -d "C:\Claude\HT" --in-place -v
```

**Process all files (create new _v5.3 versions):**
```bash
python apply_corrections_v5.3.py -d "C:\Claude\HT" -v
```

## Usage Examples

### Example 1: Single Master Document
```bash
# Process the main Rev5_2.md file to create Rev5_3.md
python apply_corrections_v5.3.py \
    --source "Home_Theater_System_Complete_Design_Rev5_2.md" \
    --output "Home_Theater_System_Complete_Design_Rev5_3.md" \
    --verbose
```

### Example 2: All Modular Files (In-Place)
```bash
# Process all .md files in the HT directory
# Files are modified in-place with .backup copies created
cd C:\Claude\HT
python apply_corrections_v5.3.py -d . --in-place -v
```

### Example 3: All Files (New Versions)
```bash
# Process all .md files, creating new _v5.3 versions
# Original files remain untouched
python apply_corrections_v5.3.py -d "C:\Claude\HT" -v
```

### Example 4: Specific Pattern
```bash
# Only process files starting with "05" or "06"
python apply_corrections_v5.3.py -d "C:\Claude\HT" -p "0[56]*.md" --in-place -v
```

## Command Line Options

```
-s, --source FILE       Source file to process
-o, --output FILE       Output file path
-d, --directory DIR     Process all .md files in directory
-p, --pattern PATTERN   File pattern for directory mode (default: *.md)
--in-place              Modify files in-place
-v, --verbose           Show detailed progress
--no-backup             Skip backup creation (not recommended)
-h, --help              Show help message
```

## What Gets Fixed

### 1. Encoding Corrections
- `3'` → `3×`
- `4'` → `4×`
- `6ƒ"` → `6×`
- `ft'³³` → `ft³`
- `cm²` corruptions
- Em-dash corruptions
- ~100+ instances throughout

### 2. Speaker Count Corrections

**Before (Rev 5.2):**
```markdown
- 4× Surrounds (DIYSG HT-12)
```

**After (Rev 5.3):**
```markdown
- 6× Surrounds (DIYSG HT-12)
  - 2× Side surrounds (positions 4-5)
  - 4× Rear surrounds (positions 6-9)
```

### 3. Budget Updates

| Item | Rev 5.2 | Rev 5.3 | Change |
|------|---------|---------|--------|
| Surrounds | $1,156-1,200 | $1,734-1,800 | +$578-600 |
| Speaker Total | $8,270-10,870 | $8,848-11,470 | +$578-600 |
| Grand Total | ~$68,676-85,044 | ~$69,254-85,644 | +$578-600 |

### 4. Amplification Updates

**Before:**
```markdown
Channels needed: 10 total (2 side + 2 rear + 6 Atmos)
```

**After:**
```markdown
Channels needed: 12 total (2 side + 4 rear + 6 Atmos)
Configuration: Two NC252MP 6-channel units
```

### 5. Version Updates
- Version: 5.2 → 5.3
- Last Updated: Current date
- Revision History: New entry added

## Output Report

The script generates a detailed report showing all changes:

```
======================================================================
CORRECTION REPORT
======================================================================

ENCODING:
----------------------------------------------------------------------
  • Fixed 45 instances of '(\d+)'' -> '\1×'
  • Fixed 12 instances of 'ft'³³' -> 'ft³'
  • Encoding cleanup completed

SPEAKER_COUNT:
----------------------------------------------------------------------
  • Updated main system configuration (4→6 surrounds)
  • Updated rear surround specifications (positions 6-9, qty 4)
  • Updated quick reference configuration

AMPLIFICATION:
----------------------------------------------------------------------
  • Updated channel count (10→12 total)
  • Added NC252MP configuration note

BUDGET:
----------------------------------------------------------------------
  • Updated surround speaker budget ($1,156-1,200 → $1,734-1,800)
  • Updated speaker total ($8,270-10,870 → $8,848-11,470)
  • Updated grand total budget

VERSION:
----------------------------------------------------------------------
  • Updated to Rev 5.3 with history entry

======================================================================
Total changes: 47
======================================================================
```

## Safety Features

1. **Automatic Backups**: In-place edits create `.backup` files
2. **Validation**: Script checks file existence before processing
3. **Error Handling**: Graceful error messages if issues occur
4. **Dry-run Available**: Use `--verbose` to see what would change

## Workflow Recommendation

### For Master Document
```bash
# Step 1: Process master document
python apply_corrections_v5.3.py \
    -s "Home_Theater_System_Complete_Design_Rev5_2.md" \
    -o "Home_Theater_System_Complete_Design_Rev5_3.md" \
    -v

# Step 2: Review the output
# Check that all corrections were applied correctly

# Step 3: Use corrected master to re-extract modular files
# (Manual step or future script)
```

### For Modular Files
```bash
# Process all modular files in the HT directory
cd C:\Claude\HT
python apply_corrections_v5.3.py -d . --in-place -v

# Review .backup files if needed to verify changes
```

## Verification Checklist

After running the script, verify:

- [ ] All `×` symbols render correctly (not `'` or `ƒ"`)
- [ ] Surround count shows 6 (not 4) throughout
- [ ] Rear surrounds show positions 6-9 (not 6-7)
- [ ] Budget shows $1,734-1,800 for surrounds
- [ ] Amplification shows 12 channels needed
- [ ] Version shows 5.3
- [ ] Revision history has new entry

## Troubleshooting

### "Python not found"
Install Python 3.7+ from python.org

### "No changes were made"
- Check that input file is actually Rev 5.2
- Ensure file has the patterns that need fixing
- Use `--verbose` to see detailed progress

### "Permission denied"
- Close file if open in editor
- Check file isn't read-only
- Run with administrator privileges if needed

### Encoding looks wrong after running
- Ensure your text editor supports UTF-8
- Try VS Code, Notepad++, or Sublime Text
- Re-save with UTF-8 encoding if needed

## Requirements

- Python 3.7 or higher
- No additional packages needed (uses standard library only)

## Files Included

1. `apply_corrections_v5.3.py` - Main correction script
2. `RUN_CORRECTIONS.bat` - Windows launcher (optional)
3. `CORRECTION_SCRIPT_USAGE.md` - This guide
4. `CORRECTION_PLAN_Rev5.3.md` - Detailed correction specifications

## Support

If you encounter issues:

1. Check the correction plan: `CORRECTION_PLAN_Rev5.3.md`
2. Run with `--verbose` to see detailed progress
3. Check `.backup` files to compare before/after
4. Review the output report for what was changed

---

**Last Updated:** November 23, 2024  
**Script Version:** 1.0  
**Target:** Rev 5.2 → Rev 5.3
