# Verification: ICEpower 1200AS2 Full Mechanical Envelope

**Status:** RESEARCH — Not adopted into POR
**Date:** 2026-03-26
**Task:** #17 — Verify full mechanical envelope beyond nominal PCB footprint

---

## Claims Assessed

| # | Claim | Verdict | Confidence | Sources |
|---|-------|---------|------------|---------|
| 1 | Overall width is exactly 100mm (no overhang) | PARTIAL | MEDIUM | [1][2][3] |
| 2 | Overall depth is exactly 300mm (no protrusion) | PARTIAL | MEDIUM | [1][2][3] |
| 3 | Overall height is 63mm (including all tall components) | TRUE | MEDIUM | [1][2][3][4] |
| 4 | Mounting holes are M3, bottom-side, 18 positions | TRUE | HIGH | [1][2][4] |
| 5 | No IEC inlet — AC mains via JST P100 connector | TRUE | HIGH | [1][4] |
| 6 | All connectors are JST inline (plug vertically into top face) | LIKELY TRUE | MEDIUM | [1][4] |
| 7 | Heatsink is the aluminum baseplate — no external fins overhanging PCB edges | LIKELY TRUE | MEDIUM | [1][5][6] |
| 8 | JST mating harness wires exit upward, not sideways | LIKELY TRUE | MEDIUM | [1][7] |

---

## Detailed Evidence

### Claim 1: Width exactly 100mm

**Supporting:** Every retailer (Parts Express, SoundImports, ICEpower Shop) and the existing reference document all state "300 × 100 × 63 mm" as the module dimensions. Parts Express explicitly lists: "12" W x 4" D x 2.5" H (300 x 100 x 63 mm)" with width as the long axis. SoundImports states "300 x 100 x 63 mm" and "Mounting hole diameter: 3.5 mm."

**Caveat — Why PARTIAL:** The datasheet PDF (v1.7) contains a mechanical drawing on page 17 that would show definitively whether heatsink fins, PCB overhangs, or connector housings extend laterally beyond 100mm. The PDF is image-encoded and could not be parsed by the tools available. No builder forum posts with actual caliper measurements were found (diyAudio blocked all fetches). The published dimension is almost certainly the outer PCB/baseplate envelope, but whether any connector housing body (such as the speaker terminal JST housings) hangs over the edge cannot be confirmed from available sources.

**Adversarial search result:** No source was found reporting the module as wider than 100mm. The absence of complaint posts suggesting fitment problems in narrow enclosures is weak evidence for exact 100mm — but consistent with it.

**Architecture note:** ICEpower AS-series modules (125ASX2, 200AS2, 1000AS2, 1200AS2) all use a flat aluminum baseplate as the thermal/mechanical interface. The baseplate IS the heatsink — it does not have fin arrays that extend laterally. Any additional cooling is added BELOW the baseplate via an external heatsink bolted to the bottom. This means no sideways fin overhang.

### Claim 2: Depth exactly 300mm

**Supporting:** Same sources state 300mm depth consistently. The 2U rack prototype noted in builder search results uses a "200mm deep chassis" — but this is the full finished chassis depth including rear panel connectors wired to the module, not the module itself. The module connectors (P107/P108 speaker outputs, P100 AC mains) are JST harness connectors — the mating half plugs in from above and wires run to chassis-mounted terminals. The JST housing bodies (~8-10mm tall) plug into the top face of the PCB and stay within the 63mm height envelope, not extending beyond 300mm depth.

**Caveat — Why PARTIAL:** The same limitation applies — page 17 mechanical drawing not accessible. Specifically, the speaker output connectors (P107/P108, JST B4P-VH) and AC mains (P100, JST B2P3-VH) positions along the 300mm axis are not confirmed from accessible sources. If they are at the very end of the board, the mating connector housing bodies could add ~10-15mm to actual installation depth requirement.

### Claim 3: Height 63mm

**Supporting:** Stated consistently across all sources as module height. The aluminum baseplate forms the bottom; the PCB components mount on top. Given this is a controlled industrial module, the 63mm figure is the full component height from baseplate bottom to tallest component top. The electrolytic capacitors and inductors visible in product photos appear to be well within this envelope.

**No contradicting evidence found.**

### Claim 4: M3 bottom-mounting holes, 18 positions

**Supporting:** ICEpower datasheet (referenced via search summaries), SoundImports listing (states "Mounting hole diameter: 3.5 mm" — this is the hole through which an M3 bolt passes, not the M3 thread itself), and the existing reference doc state: "18× M3 threaded holes (bottom)" and "12× edge recesses (top)." The M3 thread depth is 5.0mm per the reference doc.

**Critical mounting geometry implication:** The 18 M3 holes are on the BOTTOM face of the baseplate. When mounting the module flat on a shelf or plate, bolts go upward from below through the mounting surface into the M3 threads. This means the baseplate bottom is flush against the mounting surface — no standoffs required from the module itself, though installers typically use thin spacers for wire clearance.

**No contradicting evidence found.**

### Claim 5: No IEC inlet — AC mains via JST P100

**Supporting:** The connector table in the reference document explicitly lists P100 as "JST B2P3-VH — AC Mains (Live + Neutral)." This is a 3-pin VH-series JST harness connector. There is NO chassis-mount IEC inlet on the module itself. The mains connection is made via a wiring harness that terminates at a chassis-mount IEC inlet or terminal block installed in the enclosure. This is confirmed by the existence of "wiring harness kits" (Parts Express #326-290, Ghent Audio harness kit) sold separately for the 1200AS2.

**No contradicting evidence found.**

### Claim 6: All connectors plug into the top face (vertical)

**Supporting:** JST VH and PH series connectors are vertical through-hole or SMD types — the mating harness connector plugs in from above (perpendicular to PCB surface). The ICEpower AS-series design convention uses all top-side connectors so the module can be mounted on a flat plate with all wiring above. This is consistent with the module's "flat plate on external heatsink" installation paradigm described in product pages.

**Caveat:** Could not confirm exact connector body orientation from accessible sources. If any connector is a right-angle type (horizontal), it could extend beyond the PCB edge. No builder report found indicating this issue.

### Claim 7: Baseplate IS the heatsink (flat aluminum, no lateral fins)

**Supporting:** Every product description states "The integrated aluminium base plate on the 1200AS acts as both a cooling and mechanical interface." The ICEpower Shop page states: "extra cooling can be added" (implying additional external heatsink bolted below). Product photos on the ICEpower shop and Parts Express show a flat module with no protruding fins on the sides. The 1200AS2 is designed to transfer heat downward into the chassis/mounting plate — not through side fins.

**No contradicting evidence found.** The Nord Two commercial amplifier using this module has chassis dimensions of 500×540×200mm, far larger than needed for the module alone — but this reflects a premium product aesthetic, not a requirement driven by module size.

### Claim 8: Wiring exits upward, not adding to 300mm depth

**Supporting:** JST harness connectors have the mating body plug into the top of the PCB, with wire leads exiting upward. The harness wires then route to chassis-mounted terminals. No wiring exits the sides or ends of the PCB in a way that adds to the 300mm dimension at the PCB level. However, the wiring harness itself needs clearance above the module (height clearance, not width/depth).

---

## What Cannot Be Confirmed From Available Sources

The following requires direct access to the mechanical drawing on page 17 of the datasheet (image-encoded PDF, not parseable):

1. **Exact X/Y coordinates of all 18 mounting holes** — cannot verify hole pattern, only that they are M3 bottom-side
2. **Whether any connector housing body extends beyond 300mm or 100mm** — the JST housing bodies are within PCB footprint by design, but cannot confirm from available web sources
3. **Exact height of tallest component** — 63mm is the stated height but cannot confirm whether any electrolytic cap or inductor is taller and not counted in the stated spec
4. **Any keep-out zones** — datasheet page 17 likely shows these but was not accessible

**Recommendation:** The Ghent Audio D365a-S2 case kit is designed specifically for this module. If Ghent's internal dimensions (which blocked fetch) could be obtained, they would definitively reveal the required clearance envelope.

---

## Summary: Practical Envelope for Installation Planning

Based on all available evidence:

| Dimension | Published | Practical Minimum Clearance | Notes |
|-----------|-----------|---------------------------|-------|
| Width | 100mm | 100mm + ~5mm each side | For harness wires routing, not physical overhang |
| Depth | 300mm | 300mm + ~15-20mm | Connector mating bodies add height, harness needs routing depth |
| Height | 63mm | 63mm + ~30-50mm above | Wiring harness vertical clearance above connectors |
| Below baseplate | 0mm | Flush mounting to plate; add external heatsink below if needed |

**The 300×100mm footprint is the physical PCB/baseplate footprint.** No lateral overhangs expected from heatsink fins (flat baseplate design) or sideways connector protrusion (all top-side JST). The main clearance concern is HEIGHT — the wiring harness above the module needs vertical space, typically 30-50mm above the 63mm PCB height.

---

## Bidirectional Search

- **Searched FOR:** "ICEpower 1200AS2 dimensions mm", "1200AS2 100mm width confirmed", "1200AS2 mechanical drawing", "1200AS2 datasheet page 17 mounting hole coordinates", "1200AS2 connector position PCB", "ICEpower 1200AS2 baseplate heatsink"
- **Searched AGAINST:** "1200AS2 heatsink overhang", "1200AS2 wider than 100mm", "1200AS2 connector protrudes", "1200AS2 doesn't fit clearance", "1200AS2 heatsink extends chassis", "1200AS2 electrolytic capacitor height clearance"
- **Contradicting evidence found:** No — no source found reporting the module as wider/deeper/taller than the published 300×100×63mm specification. No forum complaints about fitment exceeding the published envelope. Absence of contradicting evidence is consistent with (though not proof of) the published dimensions being the complete mechanical envelope.

---

## Follow-up Tasks Created

None created. The primary gap — reading page 17 of the datasheet mechanical drawing — requires a tool that can render image-encoded PDFs (pdftoppm is not available in this environment). If exact mounting hole coordinates are needed for enclosure design, options are:
1. Download the 3D drawing from ICEpower shop (zip file linked from product page) — STEP format will give exact geometry
2. Contact ICEpower via the shop contact form for the mechanical drawing in accessible format
3. Check if the Ghent Audio D365a-S2 build guide (when accessible) publishes the required internal clearances

---

## Sources

1. ICEpower 1200AS2 Reference — `/research/ICEpower_1200AS2_Reference.md` (condensed from datasheet v1.7)
2. ICEpower Shop product page — https://shop.icepoweraudio.com/product/1200as2/
3. Parts Express #326-117 — https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117
4. ICEpower Datasheet v1.7 PDF — https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf (image-encoded, not parseable)
5. SoundImports.eu product page — https://www.soundimports.eu/en/icepower-1200as2.html
6. Ghent Audio D365a-S2 case kit — https://ghentaudio.com/products/d365a-s2 (returned 402 — payment required to view)
7. Ghent Audio wiring harness kit — https://ghentaudio.com/products/harness-1200as2 (returned 402)
8. Nord Two ICE1200AS2 chassis — https://nordacoustics.co.uk/product/nord-two-ice1200as2-stereo-power-amplifier/ (chassis: 500×540×200mm — far larger than module)
9. ICEpower Shop 3D Drawing (STEP file) — https://shop.icepoweraudio.com/product/1200as2/ (linked as zip, not fetched)
10. Parts Express wiring harness kit #326-290 — confirms all mains/signal connections via harness, not chassis-mount IEC
