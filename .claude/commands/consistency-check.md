---
description: Scan POR documents for spec inconsistencies across files
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob
---

# POR Consistency Check

Scan all Plan of Record documents for inconsistencies in shared specifications.

## Arguments
- `$ARGUMENTS` — optional: specific spec to check, or empty for full scan
  - Examples: `budget`, `Volt-10 sensitivity`, `amp model`, `sub count`, `driver impedance`
  - If empty, run full scan across all known shared specs

## Shared Specs to Verify

These values appear across multiple POR documents and must be consistent:

### Equipment & Config
- **Processor:** Denon AVR-A1H (not Marantz AV10)
- **LCR:** 3× Titan-815LX, 99 dB, 6Ω nominal, 4.2Ω min
- **Surrounds:** 4× Volt-10, 95 dB, 8Ω (not HT-12, not 98 dB)
- **Atmos:** 6× Volt-10, 95 dB, 8Ω (not HT-12, not 98 dB)
- **Sub drivers:** 16× Dayton UMII18-22 (8 corner + 8 nearfield)
- **Sub amps:** 6× Behringer NX6000D (5 active + 1 spare)
- **Tactile:** 16× Aura Pro AST-2B-4 (8 per couch)
- **Sub DSP:** Dayton DSP-408 + miniDSP 2×4 HD
- **Reference level:** -10 dB (95 dB all channels), not full THX 105 dB

### Numbers
- **Budget:** ~$72,000 (not $76K, not $75K-95K)
- **Room:** 16' × 26' × 10', 4,160 cu ft
- **Screen:** 170" 2.35:1
- **Channel config:** 9.4.6 Dolby Atmos
- **Subpanel:** 100A dedicated

### Technical
- **Volt-10 sensitivity:** 95 dB (not 98 dB — this was a common error)
- **UMII18-22 impedance:** 8Ω series wiring (dual 2Ω VCs)
- **Titan-815LX impedance:** 6Ω nominal (not 8Ω)
- **DSP-408 HPF minimum:** 20 Hz (not 10 Hz)
- **NX6000D:** auto-sensing PFC, Noctua fan mod

## Steps

1. **Glob** all markdown files in POR/ (including subdirectories)
2. **Grep** each file for the relevant spec terms
3. For each spec, collect every mention across all files
4. **Compare** values — flag any that don't match the canonical values above
5. Also scan `.claude/commands/` for stale references

## Output

Return a concise report:

```
CONSISTENT:
  - Budget: $72K ✓ (found in 00, 01, 11, 14)
  - Processor: AVR-A1H ✓ (found in 00, 06, 14)

INCONSISTENT:
  - Volt-10 sensitivity: "98 dB" in POR/05 line 42 (should be 95 dB)
  - Budget: "$76K" in .claude/commands/compare.md line 22

NOT FOUND:
  - NX6000D fan mod: not mentioned in POR/06 (expected)
```

Keep it actionable — file, line, what's wrong, what it should be.
