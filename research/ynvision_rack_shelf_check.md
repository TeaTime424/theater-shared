# Verification: ynVISION.DESIGN Sonos AMP Rack Shelf — ICEpower 1200AS2 Compatibility

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-25
**Agent:** verify
**Task:** #12

---

## Claims Assessed

| # | Claim | Verdict | Confidence | Sources |
|---|-------|---------|------------|---------|
| 1 | ynVISION shelf is a standard 19" rack-mount unit | TRUE | HIGH | [1][2][3] |
| 2 | ynVISION shelf is 2U in height | TRUE | HIGH | [1][2][3] |
| 3 | ynVISION shelf depth is sufficient for 1200AS2 (≥376mm) | FALSE | HIGH | [2][3][4] |
| 4 | ynVISION shelf is a flat generic platform (not form-fitted to Sonos AMP) | PARTIAL | MEDIUM | [1][2][3] |
| 5 | ynVISION shelf has a rear panel or backplate | FALSE — has back bar only | HIGH | [2][3] |
| 6 | ynVISION shelf weight capacity is sufficient for 4–5 × 1200AS2 | TRUE | HIGH | [2][3] |
| 7 | ynVISION shelf material is metal (steel or aluminum) | TRUE (steel) | MEDIUM | [2][3] |
| 8 | ynVISION shelf is competitive with NavePoint 2U or Bud CH-14404 for this use | FALSE | HIGH | this report |

---

## Detailed Evidence

### Claim 1–2: 19" rack mount, 2U

Confirmed across Amazon listings, manufacturer website, and eBay. Both ASINs (B0D9HV9VGR single-pack and B0GJGD21LF "11 inch deep with back bar") state: fits standard 19" wide racks, requires 2U (88.9mm) of rack space.

Sources: [1] Amazon B0D9HV9VGR, [2] Amazon B0GJGD21LF, [3] ynvision.design/yn-rack-amp

---

### Claim 3: Depth (CRITICAL — FAIL)

**This is the disqualifying issue.**

The ynVISION shelf measures **11 inches (279mm) of usable shelf depth.** This is stated explicitly in the ASIN B0GJGD21LF title: "11 inch Deep Shelf with Back Bar." The original ASIN B0D9HV9VGR does not state a depth in the title; however, cross-referencing with the manufacturer page (ynvision.design/yn-rack-amp) and third-party listings confirms the same 11" dimension for all variants.

**ICEpower 1200AS2 depth requirement:**
- PCB footprint: 300mm (11.8") deep
- Total depth with connectors (IEC inlet, speaker terminals, signal connections): ~376mm (~14.8")

The shelf is **97mm (3.8") shorter than the connector-extended module length.** Even the bare PCB (300mm) exceeds the shelf depth (279mm) by 21mm. The IEC inlet and speaker terminals that extend from the rear of the 1200AS2 would overhang the shelf completely. There is no rear panel to mount against; the "back bar" is a light retention bar designed to keep Sonos AMP units from sliding backward when their front buttons are pressed — not a structural mounting surface.

**Depth comparison table:**

| Shelf | Usable Depth | vs. 1200AS2 bare PCB (300mm) | vs. 1200AS2 with connectors (376mm) |
|---|---|---|---|
| ynVISION SONOS shelf | 279mm (11") | -21mm — PCB overhang | -97mm — significant overhang |
| NavePoint 2U (standard) | 457mm (18") | +157mm clearance | +81mm clearance |
| StarTech CABSHELF22V | 559mm (22") | +259mm clearance | +183mm clearance |
| Bud CH-14404 (chassis) | 405mm internal | +105mm clearance | +29mm clearance |

---

### Claim 4: Flat generic platform vs. form-fitted

The shelf is not a cradle or clip-in receptacle shaped to the Sonos AMP body. It is a flat perforated metal shelf with sidewalls and a back bar. "Compatible with SONOS AMP" means the shelf dimensions are tuned to fit two Sonos AMP units side by side (each Sonos AMP is 8.54" × 8.54" × 2.52") within a 2U space.

The Sonos AMP is 8.54" (217mm) deep. The shelf depth of 11" leaves ~2.5" behind the Sonos AMP for cable management — that is the design intent.

Implication: a flat box that is 217mm deep and weighs 4.6 lb fits; the 1200AS2 at 300mm+ does not. This is not a general-purpose rack shelf — it is sized specifically for the shallow Sonos AMP form factor. While it would technically accept any flat object shorter than 279mm and lighter than 44 lb, the 1200AS2 fails the depth criterion conclusively.

---

### Claim 5: Rear panel

There is no rear panel. The product has:
- A flat perforated shelf surface
- Perforated sidewalls (left and right)
- A "back bar" — a horizontal retention bar that spans the rear, designed to prevent units from sliding back
- No solid rear wall

The back bar is not structural and is not suitable for mounting IEC inlets or speaker terminals. The 1200AS2 is a plate-mount module that depends on a rear panel for its connector interface — an open back bar cannot serve this function.

---

### Claim 6: Weight capacity

The shelf is rated to 44 lb (20 kg). Five ICEpower 1200AS2 modules at 3.85 lb each = 19.25 lb. Weight capacity is adequate. However, depth failure makes this irrelevant.

---

### Claim 7: Material

Product descriptions reference "precision-formed metal construction" with no explicit mention of steel vs. aluminum alloy. Packaging weight is 2.04 kg for the shelf itself. Given the construction style (perforated sheet, powder-coat black finish), this is almost certainly cold-rolled steel — consistent with every other Sonos AMP rack shelf product in this category (Penn Elcom, Middle Atlantic). No aluminum claim is made by the manufacturer.

Confidence MEDIUM only because the manufacturer does not specify the alloy.

---

### Claim 8: Competitiveness with NavePoint or Bud CH-14404 for this use

This shelf is NOT a competitor to NavePoint 2U or Bud CH-14404 for 1200AS2 mounting. It is a consumer AV product designed to clean up a Sonos AMP installation. The NavePoint 2U at 18" depth and $45–55 comfortably fits the 1200AS2. The Bud CH-14404 at 405mm internal depth is also marginally sufficient. The ynVISION shelf at 11" fails the basic depth requirement.

---

## Product Listing Summary

| Field | Value |
|---|---|
| Product name | ynVISION.DESIGN Custom Rack Shelf Compatible with SONOS AMP |
| Amazon ASIN (single, standard) | B0D9HV9VGR |
| Amazon ASIN (single, with back bar callout) | B0GJGD21LF |
| Amazon ASIN (2-pack) | B0DK299584 |
| Manufacturer site | ynvision.design/yn-rack-amp |
| Price (approx, single) | ~$30–45 (Amazon pricing varies) |
| Rack height | 2U |
| Rack width | 19" standard |
| Shelf depth | 11" (279mm) |
| Weight capacity | 44 lb (20 kg) |
| Material | Precision-formed metal (likely steel, unspecified) |
| Back panel | None — has a back bar only |
| Form fit | Sized for Sonos AMP (8.54" / 217mm deep units) |

---

## Other ynVISION Rack Shelves

ynVISION also makes:
- **15U Open Frame AV Rack** (ASIN B0D9HRJ1WD) — a full rack, not a shelf
- **Speaker stands compatible with Sonos** (ASIN B0GFGM1QKC) — unrelated

No ynVISION universal/generic rack shelf with deeper dimensions was found. The brand's product focus is Sonos-ecosystem AV furniture. They do not make a 14"+ deep general-purpose rack shelf.

---

## Compatibility Assessment: ynVISION vs. 1200AS2

**Verdict: INCOMPATIBLE**

Three independent failure modes:

1. **Depth fail (hard):** 11" shelf cannot contain a 14.8" module with connectors. The bare PCB at 11.8" also overhangs by 0.8". There is no margin for connector clearance.

2. **No rear panel (hard):** The 1200AS2 is a plate-mount module. Its IEC inlet, speaker terminals, and signal connectors exit through a rear panel. Without a solid rear mounting surface, the module cannot be mechanically secured or wired in any normal configuration.

3. **Form-fit mismatch:** The shelf is optimized for two 217mm-deep, 2.52"-tall Sonos AMP units. The 1200AS2 is taller (63mm vs 64mm — barely fits height-wise), wider in aggregate (5 × 100mm = 500mm > two Sonos AMPs side by side ~435mm usable), and far deeper.

**No variant of the ynVISION Sonos AMP shelf is usable for 1200AS2 mounting.**

---

## Comparison to Already-Researched Options

| Option | Depth (usable) | Rear Panel | 1200AS2 Fit | Price (each) | Verdict |
|---|---|---|---|---|---|
| **ynVISION SONOS shelf** | 279mm (11") | No (back bar only) | FAIL — 97mm short | ~$35–45 | Incompatible |
| **NavePoint 2U 18"** | 457mm (18") | Add-on (blank panel + L-brackets) | YES with panel work | ~$50 + $15 panel | Compatible |
| **StarTech CABSHELF22V** | 559mm (22") | Add-on | YES, ample clearance | ~$77 | Compatible |
| **Bud CH-14404** | 405mm internal | Open chassis, panels add | YES, 29mm margin | $88–93 | Compatible (margins tight) |
| **Hammond RM2U1918SBK** | ~450mm internal | Removable aluminum panels | YES | $256–294 | Best for finished install |

---

## Follow-up Tasks Created

None. This is a standalone verification. The ynVISION shelf is eliminated from consideration. Existing research (NavePoint, Bud, Hammond) remains the relevant comparison set.

---

## Bidirectional Search

**Searched FOR:**
- "ynVISION SONOS AMP rack shelf B0D9HV9VGR dimensions depth inches internal"
- "ynVISION rack shelf 19 inch 1U 2U dimensions depth weight capacity steel aluminum"
- "ynVISION SONOS AMP rack shelf review steel aluminum dimensions back bar depth"
- Amazon listing B0D9HV9VGR and B0GJGD21LF direct fetches
- Manufacturer page ynvision.design/yn-rack-amp and product-page URL

**Searched AGAINST:**
- "ynVISION SONOS AMP rack shelf not compatible OR too shallow OR wrong size problems"
- "ynVISION rack shelf ICEpower plate amp DIY compatible use case alternative"
- Amazon customer reviews for complaints about depth or fit issues
- Sought any variant of ynVISION shelf with deeper (14"+) dimensions

**Contradicting evidence found:**
No contradicting evidence was found suggesting the shelf would work for non-Sonos equipment. All sources confirm the 11" (279mm) depth, which is the disqualifying constraint. No customer reports of using the shelf for DIY amp modules were found. No ynVISION variant with depth ≥14" exists in the product line. The adversarial search returned only further confirmation that this product is Sonos-specific and shallow.

---

## Sources

1. [Amazon B0D9HV9VGR — ynVISION Rack Shelf (single pack)](https://www.amazon.com/ynVISION-DESIGN-Custom-Shelf-Compatible-Mountable/dp/B0D9HV9VGR)
2. [Amazon B0GJGD21LF — ynVISION "11 inch Deep Shelf with Back Bar"](https://www.amazon.com/ynVISION-DESIGN-Custom-Shelf-Compatible-Mountable/dp/B0GJGD21LF)
3. [ynVISION manufacturer product page](https://www.ynvision.design/yn-rack-amp)
4. [ynVISION product-page (Wix store)](https://www.ynvision.design/product-page/ynvision-sonos-amp-server-rack-avshelf)
5. [Amazon B0DK299584 — ynVISION 2-pack](https://www.amazon.com/ynVISION-DESIGN-Custom-Shelf-Compatible-Mountable/dp/B0DK299584)
6. [eBay listing 266949791282](https://www.ebay.com/itm/266949791282)
7. [Sonos AMP dimensions spec (speakerdecision.com)](https://speakerdecision.com/amplifiers/Sonos-Amp)
8. [electroeshop.com ynVISION 2-pack listing](https://electroeshop.com/products/ynvision-design-custom-rack-shelf-compatible-with-sonos-amp-rack-mountable-pack-of-2)
