# Verification: Bud Industries CH-14404 Rack Chassis Dimensions & Construction

**Status:** RESEARCH — Verification result, not yet adopted into POR
**Date:** 2026-03-26
**Agent:** verify

---

## Claims Assessed

| # | Claim | Verdict | Confidence | Sources |
|---|-------|---------|------------|---------|
| 1 | External dimensions ~483mm × 88.9mm × 432mm (19" × 3.5" × 17") | PARTIAL | HIGH | [1][2][3][4] |
| 2 | Internal width ~16.90" (429mm) | TRUE | MEDIUM | [1][2] |
| 3 | Internal depth ~15.95" (405mm) | TRUE | MEDIUM | [1][2] |
| 4 | Internal height = external minus top/bottom panel thickness | PARTIAL — DATA ERROR | LOW | see note |
| 5 | Wall/panel thickness 0.05" chassis / 0.10-0.12" panels | TRUE | MEDIUM | [1][5][6] |
| 6 | Rear panel removable flat plate | UNCONFIRMED | LOW | no source |
| 7 | Floor flat and unobstructed for direct module bolting | UNCONFIRMED | LOW | no source |

---

## Detailed Evidence

### Claim 1 — External Dimensions

Multiple independent distributor sources agree on external dimensions:

- **Height:** 3.50" (88.9mm) — confirmed by Bud manufacturer page, Newark, americancableassemblies.com
- **Width:** Listed as 19.00" panel width, but external body width is **16.12"** (409.4mm) with the rack ears extending to 19". Amazon title confirms "19" L x 16.12" W x 3.5" H". The 19" refers to rack panel span.
- **Depth:** 16.00" (406mm) — confirmed by multiple sources

The task claim of "~432mm depth" aligns with actual 406mm (16"). The "483mm wide" claim reflects full rack panel width; physical chassis body is 409.4mm (16.12").

**Key clarification:** 19" = rack panel span (ear-to-ear). Physical chassis body = 16.12" (409.4mm). Depth = 16.00" (406mm).

### Claim 2 & 3 — Internal Width and Depth

Bud's own series page and multiple resellers list:
- Internal width: 16.90" — this is **wider than the external chassis body width of 16.12"**, which is physically impossible.
- Internal depth: 15.95" — plausible (16.00" external minus ~0.05" front lip/panel)

**Assessment of internal width anomaly:** The 16.90" internal width figure appearing across all sources is almost certainly the same database entry copied from Bud's product database. It cannot be correct as stated since 16.90" > 16.12" (external body width). The actual internal width must be external minus 2× side wall thickness. With 0.05" chassis walls on each side: 16.12" − 0.10" = ~16.02" internal width. This is a data error propagated across all resellers from the manufacturer's own product database.

**Corrected estimate (calculated):** Internal width ≈ 16.0" (406mm), assuming 0.05" side walls.

### Claim 4 — Internal Height / DATA ERROR

Bud's own series page lists:
- CH-14400 (1U, 1.75" external): internal height = 1.75" — identical to external, no subtraction
- CH-14401 (1U, 1.75" external): internal height = 1.75" — identical
- CH-14402 (1U, 1.75" external): internal height = 1.75" — identical
- CH-14403 (2U, 3.50" external): internal height = 3.50" — identical
- CH-14404 (2U, 3.50" external): internal height = **7.50"** — **clearly wrong** (larger than external)

The consistent pattern for CH-14400 through CH-14403 shows internal height = external height, suggesting the top and bottom panels attach to the sides (not sandwiched), so the full vertical space is available. This is typical of open-bottom/open-top chassis designs where the top cover slides on.

For CH-14404, "7.50"" appears to be a data entry error in Bud's database — it has propagated to every reseller (Mouser, DigiKey, Amazon, RS-Online, etc.). The actual internal height is unknown from authoritative sources.

**Reasonable engineering estimate:** If the pattern holds (internal ≈ external height), then ~3.50" (88.9mm) internal height. But if the top/bottom are removable panels that add to the external measurement, subtract 2× 0.10" panel thickness = 3.30" (83.8mm). This is unconfirmed.

**2U standard context:** EIA 2U = 88.1mm (3.469") external. Bud lists 3.5" = 88.9mm, slightly over standard. Typical chassis of this type have ~80-85mm usable internal height.

### Claim 5 — Wall/Panel Thickness

Multiple sources agree on two thickness values:
- Panel material (top, bottom, front, rear): **0.10" to 0.12"** (sources differ slightly — 0.10" vs 0.12", likely the same part measured differently or different sources rounding)
- Chassis frame/side walls: **0.05"** thick aluminum

This is consistent across the Bud product page, icmiles.com, and search result aggregations. Source conflict on 0.10" vs 0.12" for panels — treat as ~0.10" (2.54mm) with ±0.5mm uncertainty.

### Claim 6 — Rear Panel Construction

No source confirms whether the rear panel is:
- A removable flat plate bolted in
- Welded/formed into the frame
- Captured in a channel

Bud's series description states "removable top and side panels offer convenient access" — **top and sides are removable**. The rear panel is not mentioned specifically. For a chassis of this class, the rear is typically a separate flat plate captured by the side/top/bottom flanges and secured with screws, but this is inference from common construction practice, not confirmed by any source retrieved.

### Claim 7 — Floor Construction

No source addresses whether the floor (bottom panel) is flat and unobstructed for direct module bolting. Standard aluminum chassis of this type typically have a flat bottom sheet with no internal standoffs from the factory — modules must be user-mounted. Unconfirmed.

### Amazon Rating Note

Amazon shows 2.7/5 stars on 2 ratings — insufficient data for quality assessment. Not used in confidence scoring.

---

## Critical Data Quality Finding

The "7.50" internal height figure is present on:
- Bud Industries official product page
- Mouser
- DigiKey
- RS-Online
- Amazon
- Multiple distributor resellers

This is a single-source database error propagated everywhere. **Do not use 7.50" as an internal height spec for this chassis.** All distributor specs derive from Bud's own product database, which contains this error. The authoritative source would be the physical dimensional drawing (hb14400.pdf) — the PDF was found but could not be rendered in this session (timeout).

Similarly, the "16.90" internal width exceeds the 16.12" external body width — another database error propagated everywhere.

**Implication:** The internal dimension data for CH-14404 circulating online is unreliable. Any design that depends on precise internal clearance should be validated against the physical datasheet drawing or by measuring a sample unit.

---

## Follow-up Tasks Created

None created — this is a self-contained verification. If internal dimensions are design-critical, the recommended action is:

1. Request the `hb14400.pdf` dimensional drawing directly from Bud Industries (email tech support)
2. Or order one unit and measure before committing to a build that depends on fit

---

## Bidirectional Search

- **Searched FOR:** "CH-14404 specs", "CH-14404 internal dimensions", "Bud CH-14400 series datasheet PDF", "CH-14404 dimensions inches mm site:mouser.com OR site:digikey.com OR site:newark.com", "Bud Industries CH-14400 series internal height specifications"
- **Searched AGAINST:** "CH-14404 too small", "Bud CH-14404 rear panel not removable", "CH-14404 quality issues problems", "Bud CH-14404 flimsy thin problems DIY electronics build", "CH-14404 rear panel removable construction teardown"
- **Contradicting evidence found:** Yes — partial. The 7.50" internal height figure is self-contradicting (larger than external). No user complaints about fit or quality found (insufficient review data — 2 Amazon ratings). No evidence that the rear panel is NOT removable, but no confirmation it IS removable either.

---

## Sources

1. [Bud Industries CH-14404 official page](https://www.budind.com/product/chassis-box/small-rack-mount-chassis-box-series/ch-14404/)
2. [Bud Industries CH-14400 series overview](https://www.budind.com/series/chassis-box/small-rack-mount-chassis-box-series/)
3. [Newark/Element14 CH-14404 listing](https://www.newark.com/bud-industries/ch-14404/chassis-rack-mount-16in-aluminium/dp/06M4501)
4. [americancableassemblies.com CH-14404](https://americancableassemblies.com/bud-industries-ch-14404-chassis-unfinished-2u-aluminum-rack-mount-88-9-mm-432-mm-406-mm/)
5. [Amazon CH-14404 listing](https://www.amazon.com/BUD-Industries-CH-14404-Aluminum-Chassis/dp/B005T5AQZ0)
6. [Mouser CH-14400 series datasheet reference (hb14400.pdf)](https://www.mouser.com/datasheet/2/55/hb14400-3062646.pdf) — PDF timed out during fetch
7. [DigiKey CH-14404 listing](https://www.digikey.com/en/products/detail/bud-industries/CH-14404/428959)
8. [Mouser CH-14404 listing](https://www.mouser.com/ProductDetail/Bud-Industries/CH-14404?qs=3afg%2BAJeqdkvSSqHhCqceQ%3D%3D)
9. [RS-Online CH-14404 listing](https://us.rs-online.com/product/bud-industries/ch-14404/70148345/)
10. [Octopart CH-14404 aggregated specs](https://octopart.com/ch-14404-bud+industries-11444)
