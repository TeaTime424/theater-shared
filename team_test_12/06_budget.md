# Option D Budget — Home Theater Design Package
*Source: specs.yaml (2026-03-21). All values traceable to specs.yaml citations. [UNVERIFIED] per specs.yaml verification_status fields.*

---

## Phase 1: Build Budget

### Speakers

| Line Item | Model | Qty | Unit Cost | Total | Vendor Source |
|-----------|-------|-----|-----------|-------|---------------|
| LCR speakers | DIYSG Titan-815LX | 3 | $1,600 | $4,800 | DIYSG |
| Surround / Atmos / Front Wide | DIYSG Volt-10 V2 | 12 | $242 | $2,904 | DIYSG |
| Isolation hardware | — | — | — | $84 | — |
| **Speaker Subtotal** | | | | **$7,788** | |

*Calc: $4,800 + $2,904 + $84 = $7,788. Matches specs.yaml `speaker_subtotal_usd`.*

---

### Processor & Amplification

| Line Item | Model | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------|-----|-----------|-------|---------------|-------|
| AV Processor / Receiver | Denon AVR-X6800H | 1 | $3,700 | $3,700 | Denon / dealers | [UNVERIFIED] — budget figure from POR docs only |
| LCR Amplifier | ATI AT525NC | 1 | $0 | $0 | — | Already owned |
| Dirac Live Full + Bass Control + ART | Software bundle | 1 | $799 | $799 | Dirac | [UNVERIFIED] — budget figure from POR docs only |
| Sub amplifier modules | ICEpower 1200AS2 | 5 | $373 | $1,865 | ICEpower / distributors | [UNVERIFIED] — vendor pricing not confirmed |
| Sub amp chassis / connectors | Hardware | — | — | $200 | TBD | Unitemized — $200 delta between $2,065 stated and $1,865 module sum (Gap G4) |
| **Amplification Subtotal** | | | | **$6,564** | | |

*Specs.yaml `electronics_subtotal_usd` = $7,089. Calc: $3,700 + $0 + $799 + $1,865 + $200 + $525 (DSP Option B, see DSP section) = $7,089. The $525 DSP Option B figure is embedded in `electronics_subtotal_calc` but split out below.*

---

### DSP & Signal Conversion

| Line Item | Model | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------|-----|-----------|-------|---------------|-------|
| Sub DSP boards | Wondom APM2 (ADAU1701) | 2 | $40 | $80 | Wondom / Amazon | |
| External DAC module | PCM5102 module | — | — | TBD | Amazon | Cost not listed in specs.yaml — included in $525 DSP Option B estimate |
| Unbal-to-bal converter | Sonic Imagery 898B | 1 | $389 | $389 | Sonic Imagery Labs | [UNVERIFIED] — gain creator-confirmed only; zero independent measurements. **Already purchased (2026-03-21)** |
| DSP Option B subtotal (APM2 x2 + PCM5102 + cabling) | — | — | — | $525 | — | From `electronics_subtotal_calc`; PCM5102 and cabling not individually itemized |
| **DSP & Signal Subtotal** | | | | **$525** | | Includes 898B ($389) + APM2 x2 ($80) + PCM5102 + cabling; $136 unitemized within Option B |

*Note: 898B is already purchased. Its $389 cost is included in the $525 DSP Option B figure per `electronics_subtotal_calc`.*

---

### Subwoofers

| Line Item | Model | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------|-----|-----------|-------|---------------|-------|
| Corner sub drivers | Dayton UMII18-22 (PE SKU 295-487) | 8 | $350 | $2,800 | Parts Express | [UNVERIFIED] — datasheet values not independently cross-referenced |
| Tactile bass shakers | Aura Pro AST-2B-4 | 8 | $140 | $1,120 | Parts Express / Amazon | |
| Sub enclosure materials (4 cabinets, 24×24×72 in) | MDF / hardware | — | TBD | TBD | TBD | **Gap G3: no Option D BOM. Estimate $800–$1,200.** Flag: over $500, no vendor source. |
| **Subwoofer Subtotal (excl. enclosures)** | | | | **$3,920** | | |
| **Subwoofer Subtotal (incl. enclosure estimate midpoint)** | | | | **$4,920** | | Uses $1,000 midpoint estimate |

*Specs.yaml `lf_drivers_shakers_usd` = $3,920 (drivers + shakers only, enclosures excluded).*

---

### Screen

| Line Item | Model | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------|-----|-----------|-------|---------------|-------|
| Acoustically transparent screen | 170" 16:9 AT | 1 | $3,000 | $3,000 | TBD | Carryover estimate from Rev 7.0. **Over $500, no vendor source.** [UNVERIFIED] |

---

### HVAC

| Line Item | Model | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------|-----|-----------|-------|---------------|-------|
| Mini-split system package | MrCool DIY 5th Gen 12K (DIY-12-HP-WM-230D25-O) | 1 | $2,359 | $2,359 | MrCool / Amazon | [UNVERIFIED] — POR doc only, not vendor-confirmed |
| Additional hardware (line set, mounting, etc.) | — | — | $241 midpoint | $241 | TBD | Range $175–$280 |
| **HVAC Subtotal** | | | | **$2,600** | | POR Rev 7.0 allocated $1,800; **gap = ~$800 (Gap: HVAC)** |

---

### Electrical

| Line Item | Description | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------------|-----|-----------|-------|---------------|-------|
| 100A dedicated subpanel | Square D or equivalent | 1 | TBD | TBD | Electrical supply | **Gap G6: no line item in Option D source docs. Estimate $1,500–$3,000.** Over $500, no vendor source. |
| Sub amp circuit | 20A double-pole / 240V / 12 AWG | 1 | — | — | — | Bundled in subpanel installation |
| A/V circuit | 20A / 120V | 1 | — | — | — | Bundled in subpanel installation |
| HVAC circuit | 20A double-pole / 230V / 12 AWG 3-cond | 1 | — | — | — | Bundled in subpanel installation |
| **Electrical Subtotal** | | | | **TBD** | | Estimate $1,500–$3,000. Midpoint $2,250 used in totals. |

---

### Seating

| Line Item | Description | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------------|-----|-----------|-------|---------------|-------|
| Seating | Row 1 + Row 2 seating | — | — | $6,000 | TBD | Carryover estimate from Rev 7.0. **Over $500, no vendor source.** [UNVERIFIED] |

---

### Acoustic Treatment

| Line Item | Description | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------------|-----|-----------|-------|---------------|-------|
| Acoustic treatment | Panels, bass traps, diffusion | — | — | $5,500 | TBD | Carryover estimate from Rev 7.0. **Over $500, no vendor source.** [UNVERIFIED] |

---

### Infrastructure (Misc.)

| Line Item | Description | Qty | Unit Cost | Total | Vendor Source | Notes |
|-----------|-------------|-----|-----------|-------|---------------|-------|
| Infrastructure / cabling / rack / misc | Signal cabling, cable management, equipment rack | — | — | $3,300 | TBD | Carryover estimate from Rev 7.0. [UNVERIFIED] |

---

## Phase 1 Totals

| Category | Amount | Confidence |
|----------|--------|------------|
| Speakers | $7,788 | High |
| Processor / Amplification (ex-DSP) | $6,564 | High for sourced items |
| DSP & Signal Conversion | $525 | Medium — PCM5102 not individually itemized |
| Subwoofers (drivers + shakers) | $3,920 | High |
| Sub Enclosures (estimate midpoint) | $1,000 | Low — TBD (Gap G3) |
| Screen | $3,000 | Low — carryover estimate |
| HVAC | $2,600 | High |
| Electrical (estimate midpoint) | $2,250 | Low — TBD (Gap G6) |
| Seating | $6,000 | Low — carryover estimate |
| Acoustic Treatment | $5,500 | Low — carryover estimate |
| Infrastructure / Misc | $3,300 | Low — carryover estimate |
| **Phase 1 Computed Total** | **$42,447** | |

*This computed total includes midpoint estimates for TBD items (enclosures $1,000, electrical $2,250).*

*Phase 1 without TBD/estimate line items (enclosures, electrical): **$39,197***

---

## Phase 2 / Deferred Items

| Line Item | Model | Qty | Unit Cost | Total | Notes |
|-----------|-------|-----|-----------|-------|-------|
| Nearfield sub drivers | Dayton UMII18-22 | 4 | $350 | $1,400 | Deferred post-build. Space reserved behind Row 1. [UNVERIFIED] |
| Nearfield sub enclosures | TBD | — | TBD | TBD | Not estimated in specs.yaml. Likely $400–$600. |
| Nearfield sub amp | ICEpower 1200AS2 (spare unit 4) | 1 | $0 | $0 | Spare already in Phase 1 count |
| Projector | JVC NZ500 or 2027 successor | 1 | $30,000 | $30,000 | Deferred to 2027. Model TBD. Placeholder only. [UNVERIFIED] |
| **Phase 2 Subtotal** | | | | **$31,400+** | Projector placeholder dominates |

---

## Owned Inventory

| Item | Status | Value |
|------|--------|-------|
| ATI AT525NC (LCR amplifier) | Already owned | $0 cost — excluded from budget |
| Sonic Imagery 898B | Purchased 2026-03-21 | $389 — included in DSP line item |

---

## Grand Totals

| Scenario | Amount | Notes |
|----------|--------|-------|
| Phase 1 (incl. TBD midpoint estimates) | $42,447 | Enclosures $1,000, electrical $2,250 as midpoints |
| Phase 1 (excl. TBD items) | $39,197 | Hard costs only, no estimates for gaps G3/G6 |
| Phase 1 + Phase 2 (deferred, incl. projector) | $73,847 | With TBD midpoints + $30K projector placeholder |
| Phase 1 + Phase 2 (no projector) | $43,847 | With TBD midpoints, without projector |

---

## Discrepancy Notes

| Issue | Detail |
|-------|--------|
| $36,600 out-of-pocket claim | Not reconstructible from available line items (Gap G5). specs.yaml `option_d_out_of_pocket_claimed_usd` = $36,600; computed Phase 1 (excl. TBD) = $39,197. Discrepancy of ~$2,597 unexplained. |
| Rev 7.0 stated vs computed | Rev 7.0 stated $72,000; actual arithmetic sum = $74,980 (Gap G8). $2,980 error in 11_Budget_Summary.md. |
| specs.yaml `option_d_confirmed_costs_usd` | States $69,197 — includes $30K projector and all estimates. Phase 1-only total per this doc = $42,447 (with estimates) or $39,197 (without). |
| HVAC budget gap | $2,600 actual vs $1,800 POR allocation = ~$800 over (specs.yaml: "~$839 gap"). |
| ICEpower chassis delta | $2,065 stated total; $1,865 modules (5 × $373); $200 unitemized chassis/connectors (Gap G4). |
| DSP Option B internal breakdown | $525 stated for APM2 × 2 ($80) + PCM5102 + 898B ($389) + cabling. Implied residual $56 for PCM5102 module + cabling — plausible but not confirmed. |

---

## Flags: Line Items Over $500 Without Vendor Source

| Line Item | Amount | Status |
|-----------|--------|--------|
| Denon AVR-X6800H | $3,700 | [UNVERIFIED] — figure from POR docs, vendor price not confirmed |
| Screen (170" 16:9 AT) | $3,000 | [UNVERIFIED] — carryover estimate, no vendor or model |
| Sub enclosure materials | ~$1,000 estimate | TBD — no BOM exists (Gap G3) |
| Electrical subpanel installation | ~$2,250 estimate | TBD — no line item in Option D docs (Gap G6) |
| Seating | $6,000 | [UNVERIFIED] — carryover estimate, no vendor |
| Acoustic treatment | $5,500 | [UNVERIFIED] — carryover estimate, no vendor |
| Infrastructure / misc | $3,300 | [UNVERIFIED] — carryover estimate |
| Projector (Phase 2) | $30,000 | [UNVERIFIED] — placeholder, model deferred to 2027 |
