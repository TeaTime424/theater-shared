# Verification: Rack Chassis Candidates for ICEpower 1200AS2 Modules

Status: RESEARCH — Not adopted
Date: 2026-03-25
Agent: verify

---

## Verdict Table

| # | Claim | Verdict | Confidence | Key Issue |
|---|-------|---------|------------|-----------|
| 1a | Bud CH-14404: 406mm internal depth | TRUE | HIGH | Confirmed 405mm internal depth |
| 1b | Bud CH-14404: 429mm internal width | TRUE | HIGH | Confirmed 429.3mm internal width |
| 1c | Bud CH-14404: $88–110 price | TRUE | HIGH | $88–93 at multiple distributors |
| 1d | Bud CH-14404: rear panel is separate removable plate | UNVERIFIED | LOW | No source addresses rear panel construction |
| 2a | Hammond RM2U1918SBK: 457mm internal depth | PARTIAL | MEDIUM | 457mm is external depth; internal ~450mm after rear panel thickness |
| 2b | Hammond RM2U1918SBK: 422mm internal width | FALSE | HIGH | 422mm is external; internal ~415mm (422 − 2× 3.2mm side panels) |
| 2c | Hammond RM2U1918SBK: $261–276 price | PARTIAL | HIGH | $256–294 range; DigiKey $256, Amazon $294 |
| 2d | Hammond RM2U1918SBK: all panels removable | TRUE | HIGH | Knockdown design, front/rear interchangeable, confirmed multiple sources |
| 3a | HiFi2000 Dissipante 2U 400mm: ~€185 price | FALSE | HIGH | Current price €208–224 (inc. VAT) |
| 3b | HiFi2000 Dissipante 2U 400mm: integral heatsink fins | TRUE | HIGH | Vertical external side sinks confirmed |
| 3c | HiFi2000 Dissipante 2U 400mm: fits 2× 1200AS2 | TRUE | MEDIUM | Internal usable width 360mm; 2× 100mm = 200mm, fits with margin |
| 3d | HiFi2000 Dissipante 2U 400mm: purchasable and shippable to US | PARTIAL | MEDIUM | Ships to US; 25–50% aluminum tariff risk under current Section 232 rules |
| 4 | ICEpower 1200AS2 PCB footprint 300mm × 100mm × 63mm | TRUE | HIGH | Confirmed from Parts Express, Audiophonics, SoundImports — 3 independent sources |
| 5 | 4× 1200AS2 modules (4 × 100mm = 400mm) fit in 19" chassis | TRUE with caveats | MEDIUM | Math works (400mm vs 415–429mm usable); wiring gap is 15–29mm; no flange overhang data |

---

## Detailed Evidence

### Claim 1: Bud Industries CH-14404

**Specifications confirmed:**
- External: 88.9mm H × 482.6mm W (19") × 406.4mm D
- Internal: 88.9mm H × 429.3mm W × 405.1mm D
- Material: 0.05" (1.27mm) aluminum, natural, unfinished ("open chassis" classification)
- 2U rack mount, adaptable for slide mounting
- Source: budind.com (manufacturer), DigiKey, americancableassemblies.com, Newark

**Price confirmed:**
- americancableassemblies.com: $88.16
- DigiKey: $92.80
- Amazon: unavailable/inconsistent (2.7/5 stars, only 2 ratings)
- Range $88–93, well within alleged $88–110 range

**Rear panel construction — NOT CONFIRMED:**
- The CH-14404 is classified as "open chassis" / "unfinished" throughout all listings
- No source explicitly describes whether the rear is open (no panel), a formed integral U-shape, or a removable flat plate
- The series name "Small Rack Mount Chassis Box" implies it is a box, but "open chassis" classification and "unfinished" suggest the builder adds panels
- Bud's series page shows other CH-series models as U-shape extrusions with separate top/bottom/rear panels, but no photo or diagram of CH-14404 construction was accessible
- CRITICAL QUESTION UNANSWERED: Cannot confirm rear panel is a "separate removable flat plate" vs. formed into the frame

**Contradicting evidence:** No complaints about shallow depth found. 2.7/5 star rating on Amazon with only 2 reviews — too few to draw conclusions. No forum complaints found.

---

### Claim 2: Hammond RM2U1918SBK

**Specifications — with important correction:**
- External depth: 457mm (18.0") — confirmed across all sources
- External width: 422mm (16.6") — confirmed across all sources
- Height: 88.9mm (3.5", 2U) — confirmed
- Side panel material: extruded aluminum, 0.125" (3.175mm) thick — confirmed from Hammond RM series datasheet
- **Internal width = 422mm − (2 × 3.175mm) = ~415.6mm** — the claimed "422mm internal width" is actually the EXTERNAL dimension
- Internal depth: 457mm − front panel (3.175mm) − rear panel (3.175mm) = ~450mm usable

**Panel construction — confirmed:**
- Knockdown design, ships unassembled
- Front and rear panels are interchangeable (solid, extruded aluminum)
- Top, bottom, side panels all removable with included hardware
- Source: multiple retailer listings + Hammond RM series catalog description

**Price confirmed:**
- DigiKey: $256.37 (lowest confirmed)
- Amazon: $276.21–$294.89
- Claimed $261–276 is in-range but misses the DigiKey low of $256

**Contradicting evidence:**
- No fit complaints or negative reviews found
- The internal width discrepancy (422 external vs ~415 internal) is a real spec error in the original claim
- Depth 457mm claimed as "internal" is actually the external measurement

---

### Claim 3: HiFi2000 Dissipante 2U 400mm (Modushop)

**CRITICAL DIMENSION FINDING — Claim "fits 2× 1200AS2 modules" is technically true but the geometry is NOT what the claim implies:**

The Dissipante 2U 400mm has:
- External: 86mm H × 440mm W × 413mm D
- Faceplate: 90mm H × 450mm W × 10mm thick
- **Internal usable width BETWEEN the two side heatsink assemblies: 360mm**
- Internal depth: 400mm (matches product name)
- Source: Modushop catalog data extracted from search engine snippet

The side heatsink fins consume 40mm each side internally, leaving only 360mm of usable mounting space. This is NOT a full-width 19" chassis for mounting — it is a heatsink chassis.

2× 1200AS2 modules (2× 100mm = 200mm) fit in 360mm with 160mm clearance. TRUE.
4× 1200AS2 modules would be 400mm — does NOT fit in 360mm. The "fits 2×" claim was for 2 modules (one stereo module = 1200AS2), not 4.

**Price — FALSE:**
- Alleged: ~€185
- Actual: Dissipante 2U 400mm Silver: €224.48 inc. VAT; Black: €208+ inc. VAT; Mini Dissipante 2U 400mm: €208.62 inc. VAT
- The €185 figure appears to be a stale 2012-era price found in a forum post

**US Shipping — PARTIAL:**
- Modushop does ship to the US
- Orders arrive in ~10 days (user reports)
- Tariff risk: Section 232 aluminum tariffs are active; 25% as of March 12, 2025; 50% as of June 4, 2025 (EU rate may vary under trade negotiations)
- A user reported $96.20 tariff charge on a chassis order (~10% rate under earlier rules; current rate higher)
- The €185 chassis at 25% tariff adds ~$50 USD in duties, bringing total landed cost significantly above the listed price

**Contradicting evidence:**
- Forum thread specifically discussing Modushop chassis and US aluminum tariffs (2025) confirms tariff exposure
- Internal width of 360mm is a critical constraint not mentioned in the original claim — this chassis is NOT a general-purpose full-width rack chassis, it is a heatsink chassis with reduced usable interior

---

### Claim 4: ICEpower 1200AS2 Dimensions

**Confirmed from 3 independent sources:**
- Parts Express: "12" W x 4" D x 2.5" H (300 x 100 x 63 mm)" — direct product listing
- Audiophonics (FR): "300 x 100 x 63mm"
- SoundImports (NL): "Dimensions (L x W x H): 300 x 100 x 63 mm"

**Interpretation note:**
All retailer listings describe this as Length × Width × Height = 300 × 100 × 63mm. The convention used by Parts Express ("12" W" as the long dimension) suggests the 300mm is the depth (front-to-back), 100mm is the width (side-to-side), and 63mm is height.

**Baseplate/flange overhang — NOT CONFIRMED:**
The official datasheet PDF is image-based and non-parseable. No source explicitly states whether the 100mm width includes mounting flanges, connectors, or any protrusion. The module has 18× M3 mounting holes in the base plate and 12 recesses along the long sides — connectors may extend beyond the 100mm footprint.

**Community datapoint:** A purpose-built 4-channel DIY enclosure (Ghent/Maxxteknik) is designed for 2× 1200AS2 with external width ~300mm — consistent with 2× 100mm + side walls.

---

### Claim 5: 4 Modules Fit in 19" Chassis

**Math:**
- 4× 1200AS2 at 100mm wide = 400mm minimum footprint
- Bud CH-14404 internal width: 429mm → 29mm clearance for 4 modules
- Hammond RM2U1918SBK internal width: ~415mm → 15mm clearance for 4 modules
- EIA-310 standard: 450mm between rack rails (front panel), chassis internal typically 415–430mm

**Assessment — TRUE with caveats (MEDIUM confidence):**
- The 400mm aggregate fits in both Bud and Hammond by 15–29mm
- However, 15mm across 4 modules is only 3.75mm/gap — tight but plausible
- If connector bodies or mounting flanges extend beyond 100mm, fit is compromised
- Wiring (mains input, speaker outputs) requires more than 3mm per side
- Practical minimum clearance between modules for wiring harness routing: 10–15mm per gap = 30–45mm overhead needed total for 3 gaps
- **At 29mm total overhead (Bud), 4 modules side by side with no inter-module gap leaves zero wiring clearance**
- **Recommendation: Treat 4 modules in a standard 2U chassis as borderline; thermal stacking in 2U also needs verification**

**Supporting evidence:** Ghent/Maxxteknik DIY 4-channel case fits 2× 1200AS2 (not 4). Apollon Audio AS4800 fits 8× 1200AS2 in what appears to be a larger custom chassis. No confirmed example of 4× 1200AS2 in a standard 19" 2U chassis found.

---

## Follow-up Tasks Created

None created — the open questions (Bud rear panel construction, 1200AS2 flange overhang, 4-module thermal stacking) are flagged in this report for human decision. If formal follow-up needed, create tasks for:
- Confirming Bud CH-14404 rear panel type (photo/drawing needed; contact budind.com)
- Getting 1200AS2 mechanical drawing from ICEpower shop (3D Drawing download on product page)
- Verifying 4-module thermal stacking feasibility in 2U

---

## Bidirectional Search

**Searched FOR:**
- "Bud Industries CH-14404 specifications internal dimensions" — budind.com, DigiKey, Newark, Amazon, americancableassemblies
- "Hammond RM2U1918SBK specifications internal dimensions" — hammfg.com, DigiKey, Mouser, Amazon, RS-Online, TrustedParts
- "HiFi2000 Dissipante 2U 400mm specifications modushop" — modushop.biz product pages, HiFi2000 catalog
- "ICEpower 1200AS2 datasheet dimensions" — ICEpower shop PDF, Parts Express, Audiophonics, SoundImports, Audiostatus
- "4 modules 100mm 19 inch chassis fit" — EIA-310 standard, Ghent audio DIY cases, Apollon Audio multichannel builds

**Searched AGAINST:**
- "Bud CH-14404 problems shallow depth complaints review" — no complaints found; 2.7/5 Amazon with 2 reviews only
- "Hammond RM chassis issues actual vs claimed dimensions" — no fit complaints found; confirmed 422mm is external not internal
- "HiFi2000 Dissipante too narrow ICEpower 1200AS2" — no results, but internal width of 360mm is confirmed limiting factor
- "Modushop dissipante US shipping tariff import duty 2025" — confirmed tariff risk, $96+ duty on prior orders
- "ICEpower 1200AS2 heatsink overhang baseplate width actual" — no community measurements found; 100mm stated but flange not confirmed

**Contradicting evidence found:**
- Yes — Hammond 422mm dimension is the EXTERNAL width, not internal as claimed (internal is ~415mm)
- Yes — Dissipante 2U internal usable width is only 360mm between heatsinks, not full rack width; price is €208–224 not €185
- Yes — Modushop US import tariffs (25–50% on aluminum) materially increase landed cost
- Partial — 4-module fit in 2U chassis is mathematically feasible but wiring clearance is borderline

---

## Sources

1. [Bud Industries CH-14404 — budind.com manufacturer page](https://www.budind.com/product/chassis-box/small-rack-mount-chassis-box-series/ch-14404/)
2. [CH-14404 — DigiKey ($92.80)](https://www.digikey.com/en/products/detail/bud-industries/CH-14404/428959)
3. [CH-14404 — Newark](https://www.newark.com/bud-industries/ch-14404/chassis-rack-mount-16in-aluminium/dp/06M4501)
4. [CH-14404 — americancableassemblies ($88.16)](https://americancableassemblies.com/bud-industries-ch-14404-chassis-unfinished-2u-aluminum-rack-mount-88-9-mm-432-mm-406-mm/)
5. [Hammond RM2U1918SBK — Amazon listing 1](https://www.amazon.com/HAMMOND-Enclosure-Boxes-Cases-RM2U1918SBK/dp/B01MSAD7MM)
6. [Hammond RM2U1918SBK — Amazon listing 2](https://www.amazon.com/Hammond-Manufacturing-RM2U1918SBK-2UX19X18-Enclosure/dp/B005T8VQV0)
7. [RM2U1918SBK — DigiKey ($256.37)](https://www.digikey.com/en/products/detail/hammond-manufacturing/RM2U1918SBK/2094737)
8. [RM2U1918SBK — Mouser](https://www.mouser.com/ProductDetail/Hammond-Manufacturing/RM2U1918SBK?qs=fnYUjNMxfVAC9i4cdhabxQ%3D%3D)
9. [RM2U1918SBK — Hawk Electronics](https://www.hawkusa.com/manufacturers/hammond-mfg/enclosures/rm2u1918sbk)
10. [Hammond RM Series product page — hammfg.com](https://www.hammfg.com/electronics/small-case/rack-mount/rm)
11. [Dissipante 2U 400mm Silver — modushop.biz product_id=195](https://modushop.biz/site/index.php?route=product/product&product_id=195)
12. [Dissipante 2U 400mm Black — modushop.biz product_id=196](https://modushop.biz/site/index.php?route=product/product&product_id=196)
13. [Mini Dissipante 2U 400mm Black — modushop.biz product_id=723](https://modushop.biz/site/index.php?route=product/product&product_id=723)
14. [Dissipante category — HiFi2000 shop](https://hifi2000.shop/site/en/catalog/dissipante)
15. [ICEpower 1200AS2 — Parts Express (300x100x63mm confirmed)](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)
16. [ICEpower 1200AS2 — Audiophonics](https://www.audiophonics.fr/en/amplifier-boards/icepower-1200as2-p-19116.html)
17. [ICEpower 1200AS2 — SoundImports](https://www.soundimports.eu/en/icepower-1200as2.html)
18. [ICEpower 1200AS2 datasheet v1.7 PDF — ICEpower shop](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
19. [19-inch rack standard — Wikipedia (450mm between rails)](https://en.wikipedia.org/wiki/19-inch_rack)
20. [Ghent/Maxxteknik DIY 4-channel case for 1200AS2](https://maxxteknik.com/en/products/ghent-diy-4-kanalers-lada-for-icepower-1200as2-2000as2)
21. [Modushop tariff thread — diyAudio](https://www.diyaudio.com/community/threads/modushop-chassis-shipped-to-us-are-they-getting-tariffed-as-aluminum-and-steel-imports.429739/)
22. [ICEpower 1200AS2 cooling thread — diyAudio](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)
23. [Apollon Audio AS4800 8-channel 1200AS2 amplifier](https://apollonaudio.com/product/as4800-icepower-based-class-d-8-channel-amplifier/)
