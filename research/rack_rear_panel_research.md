# Rack-Mount Rear Panels / Back Plates for ICEpower 1200AS2 Modules

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-25
**Related:** POR/15_DSP_Subwoofer_Processing.md, POR/06_Electronics_and_Control.md

---

## Executive Summary

The ICEpower 1200AS2 is NOT a traditional plate amplifier — it is a flat PCB/module (300×100×63mm) that mounts bottom-down to a chassis floor via 18× M3 screws. Its connectors (mains IEC, speaker terminals, signal input) face outward from one short end of the board, not through a rear panel cutout. The correct integration approach is a rack chassis enclosure where the module sits on a shelf/chassis floor and connectors protrude through a drilled/machined rear or end panel. Several commercial options exist: Bud Industries RM-series aluminum chassis, Hammond RM-series, and custom-cut panels from Penn Elcom or SURFIX offer the most viable paths. The "218×148mm plate cutout" description in the task brief does not match known 1200AS2 datasheet geometry and should be treated as [UNVERIFIED] — the module footprint is 300×100mm, making a 218×148mm cutout physically implausible for a module of those dimensions.

---

## Key Findings

### 1. ICEpower 1200AS2 — Not a Plate Amp

The 1200AS2 is a self-contained amplifier module, not a plate amplifier in the subwoofer-cabinet sense:

- **Footprint:** 300mm (L) × 100mm (W) × 63mm (H) [12" × 4" × 2.5"]
- **Mounting:** Bottom-mounted via 18× M3 threaded holes into chassis floor; alternatively via 12 recesses along the two long sides
- **Connector location:** One short end of the board (100mm face) — mains IEC inlet, signal input (JST headers, wired by builder), speaker terminals
- **Cooling:** Aluminum base plate is both heatsink and mechanical interface; thermal contact with chassis floor is part of the cooling path

The "plate amp" framing in the task brief does not match the physical form factor. This module does NOT slot through a panel cutout like a subwoofer plate amplifier. Instead, it lies flat and requires connectors to be routed through an end/rear panel of an enclosure.

**Implication:** The integration challenge is different from what the task brief describes. You need:
1. A shelf/floor for the module to bolt to (5× units need separate floor space — see sizing below)
2. A rear panel (or end cap) with cutouts for IEC mains, speaker terminals, and signal input per unit

### 2. Sizing Reality Check

Five 1200AS2 modules at 300mm each = 1500mm of linear floor space if laid end-to-end, or arranged differently depending on rack footprint. In a 19" rack chassis (483mm wide, ~400mm usable interior):

- **Side-by-side, landscape:** Not possible — 300mm length exceeds 400mm only if stacked laterally; 100mm width × 5 = 500mm — too wide for a single 19" chassis interior
- **End-to-end in depth:** 300mm deep chassis accommodates 1 module per U; 5 modules require 5 separate chassis tiers, or a deeper chassis
- **Most practical approach:** One 1200AS2 per 2U chassis, stacked 5 high = 10U total rack height, OR 2 per 3U-4U chassis if a wide/deep format allows

The Bud Industries RM series goes up to 26" depth, which could house two 1200AS2 modules nose-to-tail (2×300=600mm > 660mm available) — marginal. One module per chassis is the clean solution.

### 3. Commercial Rack Chassis Options

| Manufacturer | Series | Heights | Depth Range | Rear Panel | Notes |
|---|---|---|---|---|---|
| **Bud Industries** | RM-14xxx | 1U–6U | 17"–26" | Adjustable, removable | Fully adjustable rear panel position; M3 side panel holes on 0.87" grid; aluminum; ~$40–$120 per unit |
| **Hammond Mfg.** | RM Series | 1U–5U | 4.25"–28" | Removable rear panel | Panel pairs removable and interchangeable; aluminum; available via Mouser/DigiKey |
| **Hammond Mfg.** | RMC Series | 2U–6U | Multiple | Included | Similar to RM but with different depth options |
| **Takachi** | Various | 1U–6U | Various | Custom optional | Japan-based, available via distributors; custom CNC available |
| **Yongu Case** | 19" chassis | 1U–6U | Various | Custom CNC | China manufacturer, low cost, custom cutouts per order |

**Best fit for 1200AS2:** A 2U chassis at 300mm+ depth, one module per chassis. Bud RM-14222 (3U, 437mm deep) or similar gives room for the module plus wiring clearance.

### 4. Rear Panel Fabrication Options

Since the 1200AS2 connectors are on a 100mm-wide face (short end), the rear panel cutout needs to expose:
- IEC C14/C20 mains inlet
- 2× speaker binding post pairs (high-current)
- Signal input connector(s)

These are all small cutouts (not one large hole). Any of these approaches work:

#### Option A: Drill-and-punch existing blank panel
- Buy Hammond PBPA (aluminum) or Bud Industries rear panel blank
- Drill/punch IEC cutout (~55×30mm), speaker terminal holes, signal holes
- Cost: ~$10–$25/panel, requires minimal tooling
- **Best for:** DIY builder with drill press; lowest cost

#### Option B: Penn Elcom Panel Designer — custom order
- Free online tool: design cutouts graphically, upload DXF for custom shapes
- Minimum order ~1–2 panels; pricing ~$20–$60/panel depending on size and complexity
- 1U–6U heights available; aluminum, anodized finish
- Ships ready-to-install
- **Best for:** Professional finish, no metalworking required

#### Option C: SURFIX Custom Panels
- .125" (3mm) 6061 aluminum, painted or bare
- Order with custom cutouts per their online configurator
- **Best for:** Heavier-duty construction

#### Option D: DIY aluminum sheet stock
- 1/8" (3mm) 6061 aluminum sheet, cut to 19" width, bent flanges for rack attachment
- Cut IEC/terminal holes with hole saw, step drill, or nibbler
- Attach to rack rail using angle aluminum or rack strip
- Cost: ~$5–$15/panel for material
- **Best for:** Maximum flexibility, minimal cost; requires basic metalworking

#### Option E: Ghent Audio / TCR kits (single-unit enclosures)
- Ghent Audio sells pre-built enclosures sized for 1200AS2 (2-channel, 4-channel variants)
- These are standalone boxes, not rack-mount — would require rack ears or shelf mounting
- [UNVERIFIED] — specific rack-mount compatibility not confirmed; Ghent/Maxxteknik pages were inaccessible

### 5. Shelf + Rear Panel Combinations

Standard cantilever rack shelves (StarTech, Odyssey, Middle Atlantic, Penn Elcom) do NOT include a rear panel — they are open shelves. To get a rear panel, you need one of:

1. **Full rack chassis enclosure** (Bud, Hammond, Takachi) — includes top, bottom, sides, and rear panel as a unit
2. **Shelf + custom-fabricated rear panel** — bolt or rivet an aluminum sheet behind a standard shelf
3. **Middle Atlantic or Penn Elcom rack drawers** — enclosed pull-out drawer with front panel; can add rear panel

The cleanest integration is a full rack chassis per module (Bud RM-series or similar), stacked in a 19" open-frame rack or enclosed rack cabinet.

### 6. Adversarial Findings

- **The 218×148mm plate cutout dimension is inconsistent** with the 1200AS2's actual module geometry (300×100mm board). A 218×148mm cutout through a rear panel would be larger than the module's short face (100mm wide × 63mm tall). This dimension may refer to a different amplifier model or product specification. [UNVERIFIED — task brief may reference a companion module or earlier research artifact]
- Standard rack shelves have no rear panel; treating them as equivalent to a plate-amp panel mount is incorrect
- The 1200AS2 requires chassis floor contact for thermal management — floating it on a rear panel without base contact is not recommended per ICEpower application guidelines

---

## Comparison Table

| Option | Cost/Unit | Rear Panel? | Cutout Needed | Difficulty | Finish |
|---|---|---|---|---|---|
| Bud Industries RM-14222 (3U chassis) | ~$90 | Yes, included | Drill IEC + terminals | Easy | Natural aluminum |
| Hammond RM Series 2U | ~$60–$80 | Yes, removable | Drill IEC + terminals | Easy | Natural/grey aluminum |
| Penn Elcom custom panel + standard shelf | ~$40 panel + $30 shelf | Custom ordered | Pre-ordered | None | Anodized black/silver |
| SURFIX custom panel + shelf | ~$30–$50 panel | Custom ordered | Pre-ordered | None | Powder coat available |
| DIY 1/8" aluminum sheet | ~$10 | DIY fabricated | Drill/nibbler | Medium | Raw; requires finishing |
| Ghent/Maxxteknik 1200AS2 box + rack ears | ~$150–$200 [UNVERIFIED] | Yes, included | None | None | Finished |

---

## Follow-up Tasks Created

None — this research resolves the primary question. If the 218×148mm cutout dimension needs sourcing/verification (it may reference a companion product specification), that warrants a verify task.

---

## Bidirectional Search

- **Searched FOR:** "19 inch rack rear panel", "plate amplifier rack mount enclosure", "ICEpower 1200AS2 rack mount", "rack chassis rear panel options", "Penn Elcom custom panel", "Hammond rack chassis", "Bud Industries rack chassis", "custom rack panel CNC cutout"
- **Searched AGAINST:** "ICEpower 1200AS2 plate amp cutout panel mount", "218mm 148mm cutout 1200AS2", "plate amplifier through-panel installation 1200AS2"
- **Contradicting evidence found:** Yes — the 1200AS2 is NOT a plate amplifier in the traditional sense. It does not mount through a rear panel cutout. The 218×148mm cutout dimension described in the task brief does not correspond to known 1200AS2 datasheet geometry (300×100×63mm module, connectors on 100mm short face). This is a significant finding that changes the integration approach.

---

## Recommendations

1. **Clarify the "plate cutout" assumption.** The 1200AS2 is a flat board that bolts to a chassis floor, not a plate amp that inserts through a panel opening. The integration strategy should be: full rack chassis enclosure (one per module), where the module lies flat on the chassis floor and connectors protrude through a drilled rear/end panel.

2. **For 5× modules, plan 5× 2U chassis** stacked in a 10U rack section. Bud Industries RM-14222 (3U, 437mm deep) or Hammond RM-series 2U (at least 300mm deep) are direct fits. Cost per chassis: $60–$100.

3. **Rear panel connectors** (IEC mains + speaker + signal per unit) are small holes, not large cutouts. A drill press and step drill can handle all cutouts with a $10–$25 blank panel. Penn Elcom Panel Designer is the no-metalwork option at ~$40–$60/panel.

4. **Verify the 218×148mm cutout dimension** before purchasing hardware — it may be sourced from an earlier task or a different product specification. If this was based on a different amp module, a verify task should be created.

**Confidence:** High for integration approach (module is a flat board, not a plate amp). Medium for specific chassis model recommendations (pricing and availability should be confirmed at time of purchase). Low confidence on the 218×148mm cutout figure — this needs verification.

---

## Sources

1. [ICEpower 1200AS2 — ICEpower Shop](https://shop.icepoweraudio.com/product/1200as2/)
2. [ICEpower 1200AS2 — Parts Express](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)
3. [ICEpower 1200AS2 Datasheet v1.7 (PDF)](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
4. [Bud Industries Rack Mount Aluminum Chassis Series](https://www.budind.com/series/general-use-boxes/rack-mount-aluminum-chassis-series/)
5. [Hammond Mfg. RM Series Rack Mount Enclosures](https://www.hammfg.com/electronics/small-case/rack-mount/rm)
6. [Hammond Mfg. Aluminum Rack Panels (PBPA Series)](https://www.hammfg.com/dci/products/accessories/pbpa)
7. [Penn Elcom Custom 19 Inch Rack Panels](https://www.penn-elcom.com/us/custom-rack-panels)
8. [Penn Elcom Panel Designer](https://www.penn-elcom.com/penn-elcom-panel-designer)
9. [SURFIX Custom 19" Rack Panels](https://www.surfixinc.com/surfix_customfaceplate.html)
10. [Rack247 Custom Rack Panel](https://www.rack247.com/custom-rack-panel)
11. [ICEpower DIY 2-channel box — Maxxteknik/Ghent Audio](https://maxxteknik.com/en/products/ghent-diy-2-kanalers-lada-for-icepower-1200as2-2000as2)
12. [ICEpower 1200AS2 Cooling — diyAudio thread](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)
13. [Harness Kit for ICEpower 1200AS2 — Ghent Audio](https://ghentaudio.com/products/harness-1200as2)
14. [AC Infinity 3U Rack Panel Blank — Amazon](https://www.amazon.com/AC-Infinity-Accessory-Rackmount-Aluminum/dp/B06Y1ZBGH2)
15. [Dayton Audio SA1000 Subwoofer Amplifier Rack Mountable](https://www.daytonaudio.com/product/782/sa1000-subwoofer-amplifier-rack-mountable)
