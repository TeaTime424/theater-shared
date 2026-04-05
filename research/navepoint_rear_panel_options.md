# NavePoint 2U Cantilever Shelf — Rear Panel Attachment Options for ICEpower 1200AS2

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-25
**Related:** None

---

## Executive Summary

The NavePoint 2U 18"-deep cantilever shelf is a flat steel tray with no integrated rear panel — just a small bent lip of unknown height on three edges (front, sides, and/or rear depending on variant). Mounting the ICEpower 1200AS2's connector face (IEC inlet, binding posts, signal inputs) through a rear panel requires either (a) a separate aluminum panel attached via angle brackets, (b) a custom-cut aluminum sheet, or (c) an alternate shelf that has an integrated rear wall. The cleanest and lowest-cost approach is Option A: a 2U Penn Elcom blank rack panel (R1275/2UK, ~$15) mounted vertically at the rear shelf edge using two short lengths of 1"×1"×1/8" 6061 aluminum angle, drilled and pop-riveted to both the shelf floor and the panel.

---

## Key Findings

### 1. NavePoint Shelf Construction

Two SKUs exist for the 2U 18"-deep NavePoint shelf:

| SKU | ASIN | Lip? | Notes |
|-----|------|------|-------|
| "Fixed" (no lip) | B08546KZ36 | No | Flat edges, vent slots in floor |
| "With Lip" | B0060RUUUC | Yes | Upturned edges on 3 sides (front, sides, rear) |

**Construction:** Heavy gauge cold rolled steel, electro-static powder coat, black. Usable surface 17.5"W × 18"D.

**Lip details:** Exact lip height is NOT published in any spec sheet or product page. Customer reviews describe it as "a small lip" — consistent with typical industry practice of 3/4" to 1" bent flanges. Photos on Amazon and NavePoint.com show the upturned edge runs along the rear and both sides on the "with lip" variant. The lip is NOT tall enough to function as a connector panel for the 1200AS2 (module is 63mm / 2.5" tall).

**Critical constraint:** The "without lip" variant (B08546KZ36) — which is the one in the user's task context — has no rear flange whatsoever. The rear edge is a raw cut steel edge (or at most a very small safety bend). There is nothing structural at the rear to attach a panel to directly.

**NavePoint's manual PDF** exists at `navepoint.com/content/manuals/select-rack-shelf.pdf` but is image-only (non-searchable), dimensions not extractable.

### 2. ICEpower 1200AS2 Module Dimensions (Verified via Parts Express)

- **Width:** 300mm (12.0")
- **Depth:** 100mm (3.9")
- **Height:** 63mm (2.5")
- **Connector face:** The short 100mm face — connectors (IEC power inlet, speaker binding posts, signal input) all exit one short end.

The 18"-deep shelf comfortably accommodates five 1200AS2 modules side-by-side: 5 × 100mm depth = 500mm = 19.7" — actually too deep. In practice, the modules will be oriented with their 300mm (12") dimension as the depth into the shelf, and the connector face at the rear. The 300mm depth leaves 18" - 11.8" = 6.2" of clearance between the module connector face and the rear of the shelf — so the rear panel must sit at approximately 300mm / 11.8" from the front mounting ears.

**Wait — re-reading the task brief:** The modules are 300mm deep × 100mm wide × 63mm tall. With their connector face at the rear, each module occupies 300mm front-to-back on the shelf, and 100mm side-to-side. Five modules (500mm) fit within the ~457mm usable interior width of the shelf. The rear panel would be at the 300mm / ~12" depth position, leaving ~6" of unused shelf behind the panel (or the panel sits flush at the rear edge of the shelf).

### 3. Rear Panel Options — Compared

#### Option A: Aluminum Angle + 2U Blank Rack Panel (RECOMMENDED)

**Concept:** Attach two short (~75mm / 3") lengths of 1"×1"×1/8" 6061-T6 aluminum angle to the rear edge of the shelf floor, one at each end of the shelf width, so that one leg lies flat on the shelf and the other stands vertical. Bolt a 2U Penn Elcom blank rack panel (19"W × 88.1mm H, 3mm aluminum) to the vertical legs of the angle brackets. Cut/drill holes in the panel for IEC inlet, binding posts, and signal inputs.

**Sizing check:**
- 2U panel height = 88.1mm — this exceeds the 1200AS2 module height of 63mm, so the panel clears the top of the module. However, the 2U shelf height is only 88.9mm (2U = 3.5"). The panel at 88.1mm fits snugly within that 3.5" envelope when mounted vertically. The angle bracket mounts on the shelf floor, standing 88.1mm tall — this fits within the 2U rack space.
- Panel width: 19" (482.6mm), matching the shelf. You can cut it down if needed, but 19" is fine as the shelf is 19" between rack ears.

**Parts list:**

| Item | Source | Approx. Cost |
|------|--------|-------------|
| Penn Elcom R1275/2UK — 2U Black Aluminum Flat Rack Panel (19"W × 88.1mm H × 3mm thick) | Amazon / Penn Elcom US | ~$15 |
| 1"×1"×1/8" 6061-T6 aluminum angle, 24" length (cut two 3" pieces) | OnlineMetals.com, Amazon, Remington Industries | ~$8–12/ft |
| #8-32 or M4 machine screws + hex nuts for panel-to-angle attachment | McMaster, Amazon | ~$5 |
| 3/16" or 1/4" pop rivets (or M4 rivnuts + screws) for angle-to-shelf attachment | Amazon | ~$5 |
| Step drill + chassis punch set for IEC cutout (47mm × 27mm), binding posts, XLR | Amazon / hardware store | one-time tool cost |

**Total incremental material cost:** ~$30–35

**Procedure:**
1. Measure and mark rear panel position on shelf floor at 300mm from front ear mounting tabs.
2. Cut two 75mm lengths of 1"×1"×1/8" aluminum angle.
3. Drill two 3/16" holes through the horizontal leg of each angle into the shelf floor. Pop-rivet (or use M4 machine screws through existing vent slots if they line up).
4. Drill matching holes through the vertical leg of each angle and through the panel ends. Bolt panel to brackets.
5. Drill/punch connector holes in panel before final assembly: IEC inlet (47mm × 27mm rectangular punch or step-drill + file), speaker binding posts (1/4" or 3/8" round), XLR (24mm punch).
6. Panel stands vertical at the 300mm depth mark, forming a clean rear wall.

**Pros:**
- Penn Elcom panels are pre-finished aluminum, 3mm thick — rigid enough for IEC inlets and binding posts without flexing
- Standardized 19" width — no custom cutting required
- Re-drillable, rebuildable, replaceable
- Blank panel is flat/clean — no derating of rack space

**Cons:**
- Requires drilling into the shelf floor (rivets or screws through vent slots)
- Panel is only held at two points (ends) — center sag possible if connectors are heavy. Add a center angle bracket if needed.
- 2U panel height (88.1mm) slightly exceeds module height (63mm). The extra 25mm of panel extends above the module top — fine aesthetically, and useful for airflow labeling.

#### Option B: Custom Aluminum Sheet via SendCutSend

**Concept:** Upload a DXF with exact hole patterns to SendCutSend. Get a custom-cut 3mm 6061 aluminum panel, exact width, exact height (can match 63mm or any height), pre-cut connector holes.

**Parts:**
- Custom panel: 457mm × ~80mm × 3mm 6061 aluminum — roughly $20–40 depending on hole count
- Same angle brackets to mount it

**Pros:** Exact fit, professional holes, any finish (anodized option)
**Cons:** 3–5 day lead time, requires CAD file, higher cost for one-off

**When to use:** If you want a custom height or want the IEC cutout pre-done precisely.

#### Option C: Full DIY Steel/Aluminum Sheet

**Concept:** Buy aluminum sheet stock (0.090" / ~2.3mm 5052-H32 or 0.125" / 3.2mm 6061) from OnlineMetals.com, cut to size, drill manually.

**Parts:**
- 5052-H32 aluminum sheet, 0.090" × 19" × 3.5" — cut from 12"×24" sheet (~$15)
- Aluminum angle to mount it (same as Option A)

**Pros:** Cheapest raw material (~$15 total)
**Cons:** Requires cutting (sheet metal shears or jigsaw with metal blade), more fabrication work than buying a pre-finished blank panel. Penn Elcom panel (Option A) is easier and only slightly more expensive.

#### Option D: NavePoint "With Lip" Variant (B0060RUUUC)

**Concept:** Buy the "with lip" version of the same shelf and see if the rear lip can serve as a connector panel.

**Reality:** The rear lip is documented as "small" — likely 3/4"–1" (19–25mm). This is far shorter than the 63mm module height. The lip cannot serve as a connector panel on its own. It would need to be extended, or the approach reverts to Options A–C.

**Verdict:** Not useful for this application.

#### Option E: Middle Atlantic U317 (3U, 17.75" deep)

**Concept:** The Middle Atlantic U317 has a "rear slotted flange for horizontal cable management." This is a rear lip, not a full rear panel.

- Height: 5.25" (3U)
- Depth: 17.75"
- Rear flange: present, but slotted and low-profile — not a connector-mounting surface
- Price: ~$80–100

**Verdict:** Heavier, 3U (wastes an extra rack space), more expensive, rear flange still not a proper connector panel. Not recommended over Option A.

#### Option F: Shelves with Integrated Rear Panels

No commercially available cantilever rack shelf was found with a full-height integrated rear panel designed for connector mounting. Custom A/V enclosure manufacturers (Ghent Audio, TCR1200) offer fully enclosed amp chassis but these are standalone boxes, not shelf-mount solutions.

Penn Elcom offers the R1297 shelf with a vertical divider system — this is a vertical partition for organizing multiple units side-by-side on a shelf, not a rear panel.

### 4. Bracket/Angle Solutions

**1"×1"×1/8" 6061-T6 aluminum angle** is the standard DIY approach:
- Available from OnlineMetals.com (cut to length), Amazon (Remington Industries), Industrial Metal Supply
- 6061-T6 machines easily with standard drill bits, files cleanly, accepts rivnuts
- 1/8" thickness is rigid enough for mounting a panel with IEC and binding post loads
- 1.5"×1.5"×1/8" angle gives more bolt pattern flexibility if preferred

**Rivnuts vs. pop rivets:**
- Pop rivets are permanent and sufficient for non-removable panel
- M4 or #8-32 rivnuts (threaded inserts) in the shelf allow bolt-on/bolt-off panel for servicing modules — recommended for this application since modules may need to be swapped

**McMaster-Carr** is the canonical source for rivnut installation tools (part #97516A310 for standard rivnut tool, ~$40) and M4 steel rivnuts (~$12/50-pack).

---

## Comparison Table

| Option | Panel Source | Cost (materials) | Fabrication Effort | Removable | Notes |
|--------|-------------|-----------------|-------------------|-----------|-------|
| A: Angle + Penn Elcom 2U blank | Penn Elcom R1275/2UK + angle | ~$30 | Low (drill 6–8 holes, punch/drill cutouts) | Yes (with rivnuts) | Best balance of cost, quality, ease |
| B: SendCutSend custom panel | Custom DXF online | ~$40–60 | Very low (pre-cut) | Yes | Best if you want precision cutouts, 3-5 day lead |
| C: DIY sheet + angle | OnlineMetals sheet stock | ~$20 | Medium (must cut sheet) | Yes | Cheapest but most work |
| D: NavePoint with-lip variant | NavePoint B0060RUUUC | $0 (shelf switch) | None | No | Lip too short — does not solve problem |
| E: Middle Atlantic U317 | Middle Atlantic | ~$80–100 | Medium | Partial | 3U shelf, more expensive, rear flange still not usable as connector panel |
| F: Enclosed chassis (Ghent) | Ghent D365a-Q1 (4-ch) | ~$200–300 per chassis | Medium | Yes | Full enclosure replaces shelf entirely — overkill |

---

## Adversarial Search / Contradicting Evidence

### Checked: Does the NavePoint without-lip shelf have any rear-edge feature?

A review on Walmart noted: "a millimeter from contacting the wall" when mounted near a wall — implying the shelf back edge has no significant flange. One Amazon reviewer explicitly noted a "discrepancy with product photos" — the shelf received did not have side slots shown in listing photos. This suggests some variation between production batches. No reviewer reports a tall rear flange.

### Checked: Could the 2U blank panel (88.1mm H) fit inside a 2U rack space?

2U rack space = 88.9mm. Panel = 88.1mm. Yes — 0.8mm clearance. This is fine; the panel mounts to the shelf floor via angle brackets, not to the rack ears, so the 2U panel height doesn't need to match rack space height exactly. The panel sits within the shelf, attached at the rear floor.

### Checked: Are there any off-the-shelf rear panel kits for cantilever shelves?

No products found from NavePoint, StarTech, Middle Atlantic, Penn Elcom, Raising Electronics, or RackSolutions specifically marketed as "rear panel kits for cantilever shelves." RackSolutions sells rear brackets for 4-post shelves (not cantilever).

---

## Bidirectional Search

- **Searched FOR:** NavePoint rear lip dimensions, rack shelf rear panel products, Penn Elcom 2U panel dimensions, aluminum angle bracket rack mounting, cantilever shelf with integrated rear panel, Middle Atlantic shelf rear flange, ICEpower 1200AS2 dimensions
- **Searched AGAINST:** Any product that eliminates the need for fabrication (integrated rear panel shelf), evidence that the NavePoint lip is tall enough to use directly, alternatives to angle bracket mounting
- **Contradicting evidence found:** No — no off-the-shelf solution found that eliminates fabrication. The NavePoint lip is confirmed to be "small" and insufficient for connector mounting. Option A (angle + blank panel) remains the clear winner.

---

## Recommendations

**Adopt Option A (Penn Elcom R1275/2UK + 6061 aluminum angle brackets).**

Rationale:
- Penn Elcom 2U blank aluminum panels are purpose-built for rack equipment use — pre-finished, correct width, rigid, drill/punch-ready
- 3mm aluminum handles IEC inlet, binding post, and XLR loads without flex
- Total material cost under $35
- Reversible: use rivnuts (M4) in the shelf floor for bolt-on/bolt-off panel
- If connector positions change or modules are swapped, a new panel can be fabricated cheaply

**If custom cutout precision is required** (e.g., rectangular IEC punch without hand-filing), use Option B (SendCutSend) for the panel itself, keep the same angle bracket attachment method.

**The "with lip" NavePoint shelf (B0060RUUUC) is not a useful shortcut** — the lip is cosmetic, not structural, and too short for connectors.

**Confidence: High** — this is straightforward fabrication with well-understood materials. No exotic tools required beyond a step drill, a 47mm chassis punch (for IEC), and a pop-rivet or rivnut tool.

---

## Follow-up Tasks Created

None created — this research is self-contained. If the IEC inlet cutout method needs specification (punch vs. step drill vs. laser), that can be addressed during the build phase.

---

## Sources

1. [NavePoint 2U Vented Cantilever Shelf 18" (460mm) Deep with Lip — NavePoint.com](https://navepoint.com/navepoint-2u-vented-cantilever-shelf-18-460mm-deep/)
2. [NavePoint 2U Without Lip — Amazon B08546KZ36](https://www.amazon.com/NavePoint-19-Inch-Universal-Cantilever-18-Inches/dp/B08546KZ36)
3. [NavePoint 2U With Lip — Amazon B0060RUUUC](https://www.amazon.com/NavePoint-19-Inch-Universal-Cantilever-18-Inches/dp/B0060RUUUC)
4. [NavePoint 2U With Lip Customer Reviews — Amazon](https://www.amazon.com/Navepoint-19-Inch-Universal-Cantilever-18-Inches/product-reviews/B0060RUUUC)
5. [Penn Elcom R1275/2UK — 2U Black Aluminum Flat Rack Panel — Amazon](https://www.amazon.com/Penn-Elcom-Panel-Aluminium-Black/dp/B01M1V5V7F)
6. [Penn Elcom R1275/2UK — Penn Elcom US](https://www.penn-elcom.com/us/2u-black-aluminum-flat-rack-panel-r1275-2uk)
7. [ICEpower 1200AS2 Dimensions — Parts Express](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)
8. [ICEpower 1200AS2 Datasheet — ICEpower Shop (PDF)](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
9. [1"×1"×1/8" 6061-T6 Aluminum Angle — OnlineMetals.com](https://www.onlinemetals.com/en/buy/aluminum/1-x-1-x-0-125-aluminum-angle-6061-t6-extruded-structural/pid/971)
10. [Aluminum Angle 6061-T6 1"×1"×1/8" — Remington Industries / Amazon](https://www.remingtonindustries.com/raw-metals/aluminum-angle-1-x-1-x-1-8-thick-6061-general-purpose-t6-mill-stock-10-lengths-available/)
11. [Aluminum Rivnuts 1/4-20 — Amazon](https://www.amazon.com/Aluminium-Rivnut-Insert-Nutsert-Super-Deals-Shop/dp/B0764FHXV6)
12. [SendCutSend — Custom Sheet Metal Fabrication](https://sendcutsend.com/)
13. [Middle Atlantic U317 — Performance Audio](https://www.performanceaudio.com/products/middle-atlantic-u317-17-deep-rack-shelf-3u)
14. [How To Rackmount Non-Rackmount Equipment — Bunker of Doom](https://bunkerofdoom.com/rackmount1/index.html)
15. [Build Log: Class D Amp in 1U Rack Enclosure — diyAudio](https://www.diyaudio.com/community/threads/build-log-class-d-amplifier-in-1u-rack-mount-enclosure.359968/)
16. [Ghent Audio D365a-Q1 DIY 4CH Case-kit for ICEpower 1200AS2×2](https://www.ghentaudio.com/products/d365a-q1)
