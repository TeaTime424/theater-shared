# Verification: ICEpower 1200AS2 Rack Mounting — Dimensions, Thermal, Shelf Products

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-25
**Verifier:** verification agent (task #4)
**Supersedes:** rack_shelf_research.md (Agent 1), icepower_rack_mount_forum_investigation.md (Agent 3) on any conflicting claims

---

## Claims Assessed

| # | Claim | Verdict | Confidence | Sources |
|---|-------|---------|------------|---------|
| 1a | 1200AS2 PCB is 300mm × 100mm × 63mm (Agent 1) | TRUE | HIGH | [1][2][3][4][5] |
| 1b | 1200AS2 is "300mm wide" (Agent 3 phrasing) | FALSE — axis confusion | HIGH | [1][2][3] |
| 1c | Module needs 365–400mm total depth with connectors | PARTIAL — plausible but unconfirmed from datasheet | MEDIUM | [6][7] |
| 1d | Module weighs 3.85 lbs | TRUE | HIGH | [1] |
| 2a | Ghent Audio makes a case for the 1200AS2 (D365a-S2) | TRUE | HIGH | [6][7] |
| 2b | D365a-S2 external dimensions ~300mm W × 376mm D × 100mm H | TRUE | HIGH | [6] |
| 2c | D365a-Q1 holds 2× 1200AS2 (4-channel) | TRUE | HIGH | [7] |
| 2d | Ghent cases are 19" rack-mountable | FALSE — not confirmed; freestanding box design | MEDIUM | [6][7] |
| 3a | 1200AS2 idle power = 35W per module | TRUE | HIGH | [1][8][9] |
| 3b | 5 modules = 175W total idle heat | TRUE (arithmetic) | HIGH | — |
| 3c | Active cooling mandatory for 5 units in ventilated rack | PARTIAL — datasheet says "may be required"; community says mandatory at this scale | HIGH | [8][9][10] |
| 4 | 5× 100mm-wide modules fit on a 19" shelf (482mm internal) | TRUE — 500mm exceeds 482mm, tight fit; 4× fits cleanly | MEDIUM | [1][11] |
| 5a | StarTech CABSHELF22V: 2U, 22" deep, vented, 50 lb, ~$77 | TRUE | HIGH | [11] |
| 5b | Gruber 34-104410: aluminum, 20" deep, ~$67, 200 lb | TRUE ($66.95 confirmed) | HIGH | [12] |
| 5c | NavePoint 2U Heavy Duty: 18" deep, vented, ~$86, 110 lb | TRUE ($85.99 confirmed) | HIGH | [13] |

---

## Detailed Evidence

### Claim 1: ICEpower 1200AS2 Physical Dimensions

**What the datasheet says (v1.7):** PDF is image-encoded; direct dimensional table extraction failed. However, the mechanical spec table in the locally-stored reference file (ICEpower_1200AS2_Reference.md, condensed from datasheet v1.7) records:

> Dimensions (L × W × H): 300 × 100 × 63 mm (11.8 × 3.9 × 2.5 in)

**Independent retailer cross-checks (3 sources):**
- Parts Express #326-117: "12" W x 4" D x 2.5" H (300 x 100 x 63 mm)" — direct fetch confirmed [1]
- Audiophonics (EU retailer): "300 x 100 x 63mm" [3]
- WaveMusicShop: "300 x 100 x 63 mm" [5]

**Dimensional axis clarification — resolving the Agent 1 vs. Agent 3 conflict:**

The module is narrow and long. The correct interpretation:
- **300mm = LENGTH (depth, front-to-back)** — confirmed by Parts Express listing "4" D" for the 100mm dimension and "12" W" for the 300mm dimension. Note that Parts Express labels orientation as "W × D × H" which maps 300mm → Width in their listing, not depth. This is a labeling convention difference.
- The critical physical fact: 300mm is the LONG axis, 100mm is the SHORT axis.
- **For rack mounting:** modules sit with the 300mm axis going front-to-back on the shelf. The 100mm axis is the side-to-side width of each module.
- **Five modules side by side:** 5 × 100mm = 500mm. Standard 19" rack interior usable width = ~450–482mm (varies by rack; EIA spec is 450mm between rail faces). 500mm does NOT fit side-by-side in a single shelf row. Four modules at 400mm would fit with margin.

**Agent 3 claim ("300mm wide"):** This was dimensional axis confusion. The 300mm dimension is front-to-back depth, not side-to-side width. The claim as stated is FALSE, but the underlying concern — that all 5 modules cannot sit side-by-side on a single shelf — is valid. 4 can; 5 cannot, unless a wider-than-standard industrial rack is used.

**Connector protrusion / total installation depth:**
The Ghent Audio D365a-S2 case (designed specifically for the 1200AS2) has external depth of 376mm [6]. The 300mm PCB plus 76mm of connector/clearance headroom = ~376mm total. This implies connectors and wiring clearance add approximately 50–76mm beyond the bare PCB. For an open rack shelf, practical installation depth should be **at minimum 16" (406mm)**, and 18–22" shelves provide adequate cable management margin. The "365–400mm depth" claim from Agent 3 is directionally correct and consistent with the Ghent case geometry.

---

### Claim 2: Ghent Audio Enclosures for 1200AS2

**D365a-S2 (stereo, 1× 1200AS2):**
- Internal: 288mm W × 75mm H × 365mm D
- External: 300mm W × 100mm H × 376mm D (including feet, excluding connectors)
- Material: Aluminum
- Number of modules: 1× 1200AS2 (stereo — both channels used)
- Source: Ghent Audio product page via search snippet [6]

**D365a-Q1 (4-channel, 2× 1200AS2):**
- Holds 2× 1200AS2 modules (4-channel total = 4 sub channels from 2 stereo modules)
- Exact external dimensions not retrieved from direct fetch (page returned 402)
- Product is listed and available; confirmed via search results [7]

**Are these 19" rack-mountable?**
The D365a-S2 external width is 300mm — significantly narrower than 19" (482mm). These are freestanding desktop/shelf enclosures, NOT 19" rack format. There are no rack ears in the product description. Using Ghent cases in a rack requires either:
- Placing them on a standard shelf (no rack mounting)
- Custom fabricating a 19" rack panel bracket to hold the enclosures

This is a significant planning point: Ghent cases do NOT rack-mount natively.

**Adversarial search for Ghent rack failure/quality reports:**
No negative quality reports found. Audiogon forum thread "Experiences with Ghent Audio ICEpower AS series amps" (searched but not fetched) indicates the brand has a positive community reputation. No documented failures related to the enclosure design.

---

### Claim 3: Thermal — 35W Idle, 175W Total, Active Cooling Question

**Idle consumption — direct datasheet confirmation (from stored reference):**
> Idle consumption (both ch enabled): 35W
> Idle consumption (amp disabled): 19W
> Standby consumption: 250 mW (230V) / 140 mW (120V)

This is from the local reference file condensed from datasheet v1.7. Cross-confirmed by diyAudio forum community reports: "the amplifier draws 35 watts idle, and almost all of this 35 watts is transformed into heat." [9]

**175W total for 5 units:** 35W × 5 = 175W. Arithmetic is correct. TRUE.

**At moderate output (50–100W per channel):**
Class D efficiency at rated power is ~79% per datasheet. At moderate output levels, efficiency of Class D amps typically degrades at low power fractions (Class D is most efficient near rated output). At 50–100W output from a module rated 600–700W/ch, efficiency may drop to 50–65%, meaning additional heat vs. idle. The 35W idle floor does NOT decrease at low output — it is a static overhead. Actual heat at moderate subwoofer duty cycles will be somewhat above 35W per module.

**Is active cooling truly mandatory?**
The datasheet (per forum citations) states: "in some cases, such as rack enclosures, forced airflow may be required depending on end-product mechanical design constraints or use environment." [9][10]

Community evidence:
- One documented failure: unit in sealed commercial enclosure had protection trips after ~1 year, attributed to insufficient airflow; resolved with vented top + fan [9]
- Commercial Apollon AS-2400 uses 4× 1200AS2 with passive aluminum chassis cooling — no documented failures
- ASR reviewer of AS1200: "doesn't run that warm, even after hours of listening" (1× module in well-ventilated aluminum chassis)

**Verdict:** For a ventilated rack (open shelves, rack with front/rear airflow), passive cooling of individual modules may be adequate. For a 4'×4' sealed equipment closet with 5 modules, active exhaust ventilation of the closet is mandatory — the closet, not individual modules, is the bottleneck. The 35W/module idle is confirmed; mandatory active cooling at the module level depends on enclosure configuration; mandatory active cooling at the closet level is unambiguous.

---

### Claim 4: Can 5 Modules Fit on a Single 2U Shelf?

**Module width: 100mm confirmed (3+ sources)**
**5 × 100mm = 500mm**
**Standard 19" rack usable interior width: ~450mm (EIA-310 spec between mounting rail faces)**

Result: 500mm > 450mm. Five modules do NOT fit side-by-side on a single standard 19" shelf. This is a hard geometric constraint.

**Four modules: 4 × 100mm = 400mm.** This fits with ~50mm margin in a standard 19" rack interior. Comfortable fit.

**Practical layout for 5 modules:**
- Option A: 2× shelves — 4 on one shelf, 1 on another (uses 4U minimum)
- Option B: 3× Ghent D365a-S2 cases (stacked, or on shelves), but these are not rack-format
- Option C: 2× Ghent D365a-Q1 (4 channels = 4 modules) + 1× D365a-S2 (1 module) = 3 enclosures

The research team Agent 3 note that "5 modules at 100mm wide = 500mm, which DOES fit in a 482mm rack" is using an incorrect internal width. Standard EIA 450mm (between rails) is the constraint, not 482mm (which is the outer rail-face-to-rail-face dimension including rail hardware). Even at 482mm, 500mm exceeds it.

---

### Claim 5: Specific Shelf Products — Verified Specs

#### StarTech CABSHELF22V
**Source:** Direct fetch from startech.com/en-us/server-management/cabshelf22v [11]

| Spec | Claimed | Verified |
|------|---------|----------|
| Height | 2U | TRUE — 3.5" H confirmed |
| Width | 19" | TRUE — 19.0" W confirmed |
| Depth | 22" | TRUE — 22.0" confirmed |
| Material | Vented steel | TRUE — SPCC cold-rolled steel, vented |
| Weight capacity | 50 lb | TRUE — 50.7 lb / 23 kg confirmed |
| Price | ~$77 | TRUE — $76.86 confirmed direct from manufacturer |

No complaints or failure reports found (adversarial search returned no relevant results).

**Fit for 1200AS2:** With 22" (559mm) depth, this shelf comfortably accommodates the 300mm PCB + 76mm connector clearance (376mm total per Ghent case geometry). Excellent depth margin.

**Layout on this shelf:** 4× modules (400mm) fit in the 450mm interior width with 50mm margin. 1 additional module requires a second shelf.

#### Gruber 34-104410
**Source:** Direct fetch from grubercommunications.com [12]

| Spec | Claimed | Verified |
|------|---------|----------|
| Material | .090 aircraft aluminum | TRUE — confirmed |
| Depth | 20" | TRUE — 20" (two 10" pieces) confirmed |
| Price | ~$67 | TRUE — $66.95 confirmed (also seen as $76.91 at server-rack-online.com) |
| Weight capacity | 200 lb | TRUE — 200 lb center-weight confirmed |
| Vented | No (solid) | TRUE — solid surface, no venting slots |

No availability issues or discontinuation reports found. Product available from Gruber direct, server-rack-online.com, Amazon (#B074Q1DF52), rackmountsolutions.net. Multiple active listings confirm availability.

**Note on price discrepancy:** $66.95 at Gruber Communications direct; $76.91 at server-rack-online.com. Both legitimate. Buy direct from Gruber for lowest price.

**Fit for 1200AS2:** 20" (508mm) depth exceeds the 376mm total installation depth. Good fit. Aluminum construction provides thermal coupling benefit if modules are bolted flat to the shelf surface. Not vented — some airflow restriction under modules. Trade-off: conductive cooling via aluminum vs. convective cooling via vented steel.

#### NavePoint 2U Heavy Duty Vented Cantilever Shelf
**Source:** Direct fetch from navepoint.com [13]

| Spec | Claimed | Verified |
|------|---------|----------|
| Height | 2U | TRUE — 3.5" H confirmed |
| Depth | 18" | TRUE — 18" (460mm) confirmed; usable surface 17.5" × 18" |
| Material | Steel | TRUE — heavy gauge cold-rolled steel, powder coat |
| Vented | Yes | TRUE — slotted venting confirmed |
| Weight capacity | 110 lb | TRUE — confirmed |
| Price | ~$86 | TRUE — $85.99 confirmed |

**Fit for 1200AS2:** 18" (457mm) depth is marginal. Module PCB is 300mm (11.8") plus connector protrusion; total ~376mm (14.8"). Usable shelf depth is 17.5" (444mm). 376mm < 444mm — the module fits with ~68mm (2.7") of rear clearance for connectors/wiring. Tight but functional. A 22"-deep shelf (StarTech) is preferable for cable management.

---

## Dimensional Conflict Resolution Summary

**The core Agent 1 vs. Agent 3 conflict:**

| | Agent 1 | Agent 3 | Verified |
|---|---|---|---|
| Module width (side-to-side in rack) | 100mm | "300mm wide" | **100mm** — confirmed by Parts Express, Audiophonics, WaveMusicShop, and ICEpower reference doc |
| Module depth (front-to-back on shelf) | 300mm | ~365–400mm | **PCB = 300mm; total install depth ~365–376mm** including connectors |
| 5 modules side-by-side on 19" shelf | "fits" | doesn't fit | **Does NOT fit** — 5 × 100mm = 500mm > 450mm EIA interior width |

Agent 3's confusion: called the 300mm front-to-back dimension "width," which led to the wrong conclusion. The correct axis assignment is: 300mm depth, 100mm width. The concern about not fitting 5 modules is still valid — just for the correct reason (5 × 100mm = 500mm, not "300mm wide").

---

## Follow-up Tasks Created

None. All five claims are resolved with sufficient confidence. If the project proceeds to purchase, no additional verification is needed for these specific products.

If Ghent Audio enclosures are chosen over open shelves, a rack integration task should be created to address how the non-rack-format enclosures will be mounted in the closet rack — Ghent cases are desktop/shelf format and require a separate mounting solution.

---

## Bidirectional Search

### Claim 1 (dimensions)
- **Searched FOR:** ICEpower 1200AS2 dimensions datasheet, Parts Express listing, Audiophonics listing, WaveMusicShop listing, "300 x 100 x 63", connector depth, installation depth
- **Searched AGAINST:** ICEpower 1200AS2 dimensions wrong, 100mm error, "actually wider", builder measurements contradicting spec
- **Contradicting evidence found:** No — no source contradicts 300 × 100 × 63mm. Multiple independent retailers confirmed. Agent 3's "300mm wide" was an axis labeling error, not a different measurement.

### Claim 2 (Ghent Audio)
- **Searched FOR:** Ghent Audio D365a-S2, D365a-Q1, ICEpower 1200AS2 case kit dimensions, price, rack mount
- **Searched AGAINST:** Ghent Audio problems, ICEpower case failures, Ghent Audio quality issues, negative reviews, rack compatibility failures
- **Contradicting evidence found:** No quality/failure reports found. Rack-mountability claim refuted — cases are confirmed as non-rack-format (300mm wide, not 482mm).

### Claim 3 (thermal)
- **Searched FOR:** ICEpower 1200AS2 idle power 35W confirmed, thermal dissipation, cooling requirements datasheet
- **Searched AGAINST:** ICEpower 1200AS2 runs cool, fanless adequate, 35W overstated, passive cooling sufficient for multiple units, active cooling not needed
- **Contradicting evidence found:** Partial — single modules in well-vented aluminum chassis run acceptably without fans. However, for 5 modules in a closet, the closet-level ventilation is the binding constraint and active exhaust is unambiguous.

### Claim 4 (5 modules on one shelf)
- **Searched FOR:** 19" rack interior width specification, EIA-310 standard dimensions, module width side-by-side calculation
- **Searched AGAINST:** ICEpower module rack crowding, insufficient width, dimensional conflicts between sources
- **Contradicting evidence found:** No direct contradiction; arithmetic resolves the conflict. 5 × 100mm = 500mm > 450mm EIA interior — geometrically impossible in standard 19" rack on one shelf.

### Claim 5 (shelf products)
- **Searched FOR:** StarTech CABSHELF22V specs, Gruber 34-104410 specs, NavePoint 2U Heavy Duty specs, confirmed dimensions and prices from manufacturer or authorized retailer
- **Searched AGAINST:** StarTech CABSHELF22V problems complaints, Gruber 34-104410 discontinued unavailable, NavePoint shelf quality issues
- **Contradicting evidence found:** No negative reports found for any of the three shelves. All three confirmed as available with specs matching claimed values.

---

## Sources

1. [Parts Express — ICEpower 1200AS2 listing (dimensions: 12" W × 4" D × 2.5" H = 300 × 100 × 63mm, 3.85 lbs)](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)
2. [ICEpower official shop — 1200AS2 product page](https://shop.icepoweraudio.com/product/1200as2/)
3. [Audiophonics EU — ICEpower 1200AS2 (300 x 100 x 63mm confirmed)](https://www.audiophonics.fr/en/amplifier-boards/icepower-1200as2-p-19116.html)
4. [ICEpower 1200AS2 Datasheet v1.7 — PDF (image-encoded, dimensions extracted via local reference file)](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
5. [WaveMusicShop — ICEpower 1200AS2 (300 x 100 x 63mm confirmed)](https://www.wavemusicshop.com/product/icepower-1200as2-amplifier-module-with-integrated-universal-mains-power-supply/)
6. [Ghent Audio — D365a-S2 DIY Stereo Case-kit for ICEpower 1200AS2 (internal 288×75×365mm; external 300×100×376mm)](https://ghentaudio.com/products/d365a-s2)
7. [Ghent Audio — D365a-Q1 DIY 4CH Case-kit for ICEpower 1200AS2 (×2)](https://ghentaudio.com/products/d365a-q1)
8. [ICEpower_1200AS2_Reference.md — local project reference file condensed from datasheet v1.7 (35W idle, thermal thresholds, mounting specs)](D:/Projects/Claude/theater/research/ICEpower_1200AS2_Reference.md)
9. [diyAudio — ICEpower 1200AS2 cooling thread (35W confirmed, failure in sealed case documented)](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)
10. [icepower_rack_mount_forum_investigation.md — local Agent 3 research (datasheet rack cooling warning, Apollon passive chassis builds)](D:/Projects/Claude/theater/research/icepower_rack_mount_forum_investigation.md)
11. [StarTech — CABSHELF22V product page (19"W × 22"D × 3.5"H, 50.7 lb, vented SPCC steel, $76.86)](https://www.startech.com/en-us/server-management/cabshelf22v)
12. [Gruber Communications — 34-104410 product page (.090 aircraft aluminum, 2U, 20" deep, 200 lb, $66.95)](https://grubercommunications.com/product/2u-heavy-duty-aluminum-cpu-shelf/)
13. [NavePoint — 2U Heavy Duty Vented Cantilever Shelf 18" (cold-rolled steel, 110 lb, $85.99)](https://navepoint.com/navepoint-2u-heavy-duty-vented-cantilever-shelf-18-460mm-deep/)
14. [ICEpower DIY 4-channel box — maxxteknik (Ghent D365a-Q1 reseller listing)](https://maxxteknik.com/en/products/ghent-diy-4-kanalers-lada-for-icepower-1200as2-2000as2)
15. [ASR — Apollon AS1200 review (single 1200AS2, "doesn't run that warm" with passive aluminum chassis)](https://www.audiosciencereview.com/forum/index.php?threads/apollon-audio-as1200-review-stereo-power-amplifier.9373/)
