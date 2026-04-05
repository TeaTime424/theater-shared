# Rack-Mount Chassis Options for ICEpower 1200AS2 Modules

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-25
**Related:** POR/15_DSP_Subwoofer_Processing.md

---

## Executive Summary

Multiple viable rack-mount chassis options exist for housing ICEpower 1200AS2 modules (300mm deep × 100mm wide × 63mm tall, needing ≥350mm internal depth to clear connectors). The constraint is primarily depth: standard 2U racks are often only 300mm or less. Options range from purpose-built DIY kits (Ghent Audio, TCR) sized for 1–2 modules, to raw chassis (Hammond RM2U1922, Bud CH-14404, Modushop Slim Line 02/350) that can fit 2–4 modules per unit side-by-side. With 5 modules needed total, the practical options are: 3× 2-module chassis (6 bays, 1 spare), 2× 3-module chassis, or 1× large custom/modified chassis. No off-the-shelf single 5-module rack solution was found.

---

## Key Requirements

| Requirement | Value |
|-------------|-------|
| Module footprint | 300mm deep × 100mm wide × 63mm tall |
| Minimum internal depth | ≥350mm (connector clearance) |
| Modules needed | 5× ICEpower 1200AS2 |
| Rack format | 19-inch rack preferred |
| Rear panel | Must be removable or cuttable (connector access) |

---

## Key Findings

### Module Layout Logic

Each 1200AS2 is 100mm wide. A standard 19" chassis has ~430mm usable interior width, meaning **4 modules fit side-by-side** in one 19" chassis. Five modules require either:
- Option A: One 2-module chassis + one 3-module chassis (2 units total in rack)
- Option B: Three 2-module chassis (3 units, 1 module spare bay — flexible for future expansion)
- Option C: One wide/deep chassis with all 5 side-by-side (would need ~550mm internal width — no standard 19" chassis supports this; would require 2U+ non-rack format)

Rack format (19") is recommended for cable management, serviceability in the equipment closet, and future expansion.

### Depth is the Binding Constraint

The 1200AS2 is 300mm deep plus its connectors (IEC inlet, output terminals, signal input) exit the 100mm rear face. Real-world connector depth adds ~30–50mm, so **350mm minimum internal depth** is required. Many 2U chassis are only 200–300mm deep, eliminating them.

---

## Comparison Table

| Product | Format | Int. Depth | Int. Width | Height | Material | Mods/Fit | Price | Source |
|---------|--------|-----------|-----------|--------|----------|----------|-------|--------|
| **Ghent Audio D365a-S2** | Desktop/shelf (not rack) | ~365mm | ~300mm | ~84mm | Aluminum | 1× module (stereo) | ~$150–180 | ghentaudio.com |
| **Ghent Audio D365a-Q1** | Desktop/shelf (not rack) | ~365mm | ~300mm | ~84mm | Aluminum | 2× modules (4-ch) | ~$200–250 | ghentaudio.com |
| **TCR1200S Pro Kit** | Desktop/shelf (not rack) | Unknown | Unknown | ~2U equiv | Steel/Al | 1× module | 259 EUR (excl board) | tcrastrs.com |
| **Modushop Slim Line 02/350** | 19" rack, 2U | **350mm** | 415mm | 80mm (2U) | Aluminum | 4× modules (tight) | 84–98 EUR | modushop.biz |
| **Modushop Dissipante 2U 400mm** | 19" rack, 2U | **400mm** | 360mm (usable) | 80mm (2U) | Al + heatsinks | 3–4× modules | 208 EUR | modushop.biz |
| **Bud Industries CH-14404** | 19" rack, 2U | **406mm (16")** | ~430mm | 88.9mm (2U) | Aluminum | 4× modules | $88–110 | budind.com / DigiKey |
| **Hammond RM2U1918SBK** | 19" rack, 2U | **457mm (18")** | ~422mm | 88.9mm (2U) | Aluminum | 4× modules | $261–276 | hammfg.com |
| **Hammond RM2U1922SBK** | 19" rack, 2U | **559mm (22")** | ~422mm | 88.9mm (2U) | Aluminum | 4× modules | $300–305 | hammfg.com |
| **Hammond RM3U1918SBK** | 19" rack, 3U | **457mm (18")** | ~422mm | 133mm (3U) | Aluminum | 4× modules + clearance | ~$320–350 | hammfg.com / DigiKey |
| **Circuit Specialists ET2-35B** | 19" rack, 2U | **300mm (11.8")** | 435mm | 83mm (2U) | Steel + Al face | FAILS depth req | $79.95 | circuitspecialists.com |
| **Yongu Case 4U** | 19" rack, 4U | **200–250mm max** | 482mm | 177mm (4U) | Aluminum | FAILS depth req | $108 | yongucase.com |
| **Apollon Audio AS4800** | Desktop (not rack) | ~420mm | ~450mm | ~180mm | Aluminum | 4× modules (built unit) | ~$2,500+ assembled | apollonaudio.com |

---

## Top Candidates in Detail

### 1. Bud Industries CH-14404 — Best Value Raw Chassis

- **External:** 19.00" W × 16.00" D × 3.50" H (482 × 406 × 89mm)
- **Internal:** ~16.9" W × 15.95" D × 3.5" H (~429 × 405 × 89mm)
- **Material:** 0.05" aluminum, natural (unfinished)
- **Rack ears:** Included (19" rack mount)
- **Rear panel:** Flat aluminum panel — cuttable/drillable for connectors
- **Module fit:** 4× 1200AS2 side-by-side (4× 100mm = 400mm, fits in 429mm width); depth clearance 405mm vs 350mm required — passes comfortably
- **Modules needed:** 5 total → 2× CH-14404 (one holds 4, one holds 1) or 2× CH-14404 with 2 each + one holding 1
- **Price:** ~$88–110 each (Newark, DigiKey, TRC Electronics)
- **Verdict:** Best bang-for-buck raw chassis. Requires drilling/cutting rear panel for IEC inlets, output terminals, and signal connections. No aesthetics — purely functional.

### 2. Hammond RM2U1918SBK — Premium Raw Chassis

- **External:** 19.00" W × 18.00" D × 3.50" H (482 × 457 × 89mm)
- **Internal:** ~16.6" W × 18.0" D × 3.5" H (~422 × 457 × 89mm)
- **Material:** Extruded 0.125" aluminum panels, 0.064" top/bottom, black powder coat
- **Rack ears:** Included
- **Rear panel:** Removable (4 screws) — easy to cut
- **Module fit:** 4× 1200AS2 (4× 100mm = 400mm in 422mm width); 457mm depth exceeds 350mm requirement with 107mm margin
- **Price:** $261–305 each depending on solid/vented
- **Verdict:** Higher quality construction than Bud; fully removable panels from all six sides simplifies fabrication. About 3× the price of the Bud.

### 3. Modushop Slim Line 02/350 — European Audiophile Option

- **External:** 435mm W × 363mm D × 86mm H
- **Internal:** 415mm W × 350mm D × 80mm H
- **Material:** All aluminum, multiple thickness options (4mm or 10mm front panel)
- **Rack ears:** Included (19" rack mount, standard)
- **Rear panel:** 3mm aluminum — cuttable
- **Module fit:** 4× 1200AS2 (400mm in 415mm width); internal depth 350mm exactly meets minimum requirement — no margin. Tight.
- **Price:** 84–98 EUR each (~$90–105 USD at current rates)
- **Verdict:** Elegant finish but depth is exactly at minimum with zero headroom. Any connector protrusion beyond the 1200AS2's body face will be a problem. Not recommended without confirming connector length.

### 4. Modushop Dissipante 2U 400mm — With Integrated Heatsinks

- **External:** 440mm W × 413mm D × 86mm H
- **Internal:** 360mm W × 400mm D × 80mm H (heatsinks consume ~80mm of width per side)
- **Material:** Aluminum + 4× heatsink fins (200mm deep, wave profile)
- **Rack ears:** Included
- **Rear panel:** 3mm aluminum — cuttable
- **Module fit:** Only 3× 1200AS2 fit (3× 100mm = 300mm in 360mm useful width); 400mm depth has 50mm margin
- **Price:** 208 EUR (~$225 USD)
- **Verdict:** Heatsinks are not needed for 1200AS2 (self-contained module with own thermal management). Paying premium for feature that doesn't benefit this use case. Usable width is narrower than the Slim Line. Skip unless active cooling becomes needed for a monoblock build.

### 5. Ghent Audio D365a-S2 / D365a-Q1 — Purpose-Built Kits

- **D365a-S2 (stereo, 1× module):** ~365mm depth, ~300mm width, fully assembled kit with XLR inputs, binding posts, IEC inlet, harness included
- **D365a-Q1 (quad, 2× modules):** ~365mm depth, wider chassis, 4-channel
- **Rack-mount:** NO — these are desktop/shelf format, not 19" rack
- **Price:** D365a-S2 ~$150–180; D365a-Q1 ~$200–250 (estimated — site returned 402 during scrape)
- **Verdict:** Best "plug and play" for a standalone stereo or 4-channel amp. For a rack-based system with 5 modules, you'd need 3 units and they won't rack-mount. Good for isolated mono/stereo blocks, not for rack integration.

### 6. TCR1200 PRO Kit — Functional with 240V Operation

- **Format:** Desktop/shelf, not 19" rack
- **Enclosure:** Steel, powder-coated, with harnessing pre-installed
- **Includes:** XLR balanced inputs, SpeakOn outputs, silent fan, 12V trigger, WUFS
- **Price:** 259 EUR (~$280) per unit, module sold separately at ~429 EUR
- **Verdict:** More complete kit than Ghent (includes fan, trigger, WUFS). 240V compatible (confirmed for 1200AS2). Not rack-mount — would need shelf or wall mount in equipment closet.

---

## Recommended Strategy

### Primary Recommendation: 2× Bud CH-14404

- Buy 2× Bud CH-14404 (~$175–220 total)
- Chassis 1: 4× ICEpower 1200AS2 (subwoofer channels — but see note below)
- Chassis 2: 1× ICEpower 1200AS2 (remaining sub channel)
- Both mount in 19" rack in equipment closet
- Cut rear panels for IEC inlets (5× per chassis), output terminals (binding posts or Speakon), XLR/RCA inputs
- Natural aluminum finish — functional, not cosmetic
- Total chassis cost: ~$200 vs $500+ for Hammond equivalent

**Note on 4-module density:** With 4× modules at 100mm each = 400mm width in 429mm interior, there is only 29mm of side clearance (14.5mm each side). Confirm modules can be mounted with adequate fastener clearance. The 1200AS2 mounts flat to the floor via 4× M4 screws — this should be fine.

### Alternative: 2× Hammond RM2U1918SBK

If build quality, panel removability, and aesthetic matter more than cost:
- $261 × 2 = $522 for chassis
- Superior panel construction, fully removable sides/top/bottom for easier fab work
- Same capacity as 2× Bud

### Not Recommended (for this build):
- **Ghent Audio / TCR kits:** Not rack-mount; designed for 1–2 modules max; 5 modules = 3+ separate desktop units
- **Modushop Slim Line 02/350:** Zero depth margin — too risky without measuring actual connector protrusion
- **Yongu Case:** Max depth 250mm, far below minimum
- **Circuit Specialists:** 300mm depth, fails requirement

---

## Follow-up Tasks Created

None. Chassis selection is a straightforward engineering fit check. No forum deep-dive or claim verification needed beyond confirming Bud CH-14404 rear panel is removable/cuttable (the standard aluminum construction makes this a safe assumption, but worth confirming with product photos before ordering).

**One open question [UNVERIFIED]:** Whether the Bud CH-14404 rear panel is a separate removable flat plate vs. bent into the chassis frame. If bent, cutting is harder. Hammond panels are confirmed removable.

---

## Bidirectional Search

- **Searched FOR:** rack mount amplifier chassis 19 inch, 2U deep chassis, ICEpower 1200AS2 enclosure, Ghent Audio 1200AS2, TCR1200 rack, Hammond RM series, Bud Industries CH series, Modushop rack chassis, Yongu rack chassis, Par-Metal rack chassis, AliExpress rack chassis, SoundImpress kit, Apollon Audio chassis dimensions
- **Searched AGAINST:** "ICEpower 1200AS2 chassis problems", "rack chassis too shallow 1200AS2", "module fit issues", depth failure cases, chassis vendors with known quality problems
- **Contradicting evidence found:** No strong contradicting evidence on chassis fit. One diyAudio reference confirmed 350mm is the minimum (community-derived, not manufacturer spec). The Modushop Slim Line at exactly 350mm was flagged as marginal by the same community discussion — this is the main caution found. Circuit Specialists and Yongu Case were eliminated on objective depth grounds.

---

## Recommendations

| Priority | Action | Confidence |
|----------|--------|-----------|
| High | Use 2× Bud CH-14404 as primary chassis for cost efficiency | High — dimensions confirmed, price confirmed |
| Medium | Measure actual 1200AS2 connector protrusion before ordering Modushop Slim Line | Medium — community suggests 350mm is borderline |
| Low | Consider Hammond RM2U1918SBK if chassis build quality matters or fab time is scarce | High — premium option with confirmed specs |
| Low | Verify Bud CH-14404 rear panel is a flat removable plate vs. formed into frame | Medium — cannot confirm from web |

---

## Sources

1. [Bud Industries CH-14404 Product Page](https://www.budind.com/product/chassis-box/small-rack-mount-chassis-box-series/ch-14404/) — dimensions confirmed
2. [Bud CH-14404 at Newark Electronics](https://www.newark.com/bud-industries/ch-14404/chassis-rack-mount-16in-aluminium/dp/06M4501) — $109.80 price
3. [Hammond RM2U1918SBK on Amazon](https://www.amazon.com/HAMMOND-Enclosure-Boxes-Cases-RM2U1918SBK/dp/B01MSAD7MM) — $294.89
4. [Hammond RM series at DigiKey](https://www.digikey.com/en/product-highlight/h/hammond/rm-series-rack-cases) — full model list with pricing
5. [Hammond RM3U1918SBK at RS Components](https://us.rs-online.com/product/hammond-manufacturing/rm3u1918sbk/70165926/) — 3U 18" deep, 457×422×133mm
6. [Modushop Slim Line 02/350 product page](https://modushop.biz/site/index.php?route=product/product&product_id=91) — 350mm depth, 84–98 EUR
7. [Modushop Dissipante 2U 400mm product page](https://modushop.biz/site/index.php?route=product/product&product_id=195) — 400mm depth, 208 EUR
8. [diyAudio Chassis Discussion thread (ICEpower 1200AS2 chassis section)](https://www.diyaudio.com/community/threads/chassis-discussion.221218/page-48) — community-sourced 350mm minimum requirement, Dissipante recommendation
9. [Ghent Audio ICEpower case list](https://www.ghentaudio.com/pages/icepower-case-list) — D365a-S2 and D365a-Q1 kits
10. [Ghent Audio D365a-Q1 at Maxxteknik](https://maxxteknik.com/en/products/ghent-diy-4-kanalers-lada-for-icepower-1200as2-2000as2) — 4CH kit, 4490 SEK
11. [TCR1200S Pro Kit](https://www.tcrastrs.com/product-page/tcr1200s-pro-kit) — 259 EUR, non-rack desktop format
12. [SoundImpress ICE1200 2CH kit at SoundImports](https://www.soundimports.eu/en/soundimpress-ice1200-2ch-kit.html) — €899.95 complete assembled kit
13. [Apollon Audio AS4800 (8CH, 4× 1200AS2)](https://apollonaudio.com/product/as4800-icepower-based-class-d-8-channel-amplifier/) — 450×180×420mm desktop chassis, not rack
14. [Circuit Specialists ET2-35B 2U rack chassis](https://www.circuitspecialists.com/rackmount-enclosure-37-2u) — 300mm depth, FAILS requirement, $79.95
15. [Yongu Case 4U rack chassis](https://yongucase.com/products/19-inch-equipment-rack-4u) — 200–250mm max depth, FAILS requirement, $108
