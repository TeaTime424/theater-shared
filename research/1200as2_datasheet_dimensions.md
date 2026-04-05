# ICEpower 1200AS2 Mechanical Dimensions — Datasheet v1.7

**Status:** RESEARCH — Reference data extracted from official datasheet
**Date:** 2026-03-26
**Source:** ICEpower1200AS1-2-Datasheet_1_7.pdf (official, downloaded directly from shop.icepoweraudio.com)

---

## Executive Summary

All mechanical dimensions extracted directly from the official ICEpower datasheet v1.7 (section 8, page 17). The 1200AS1 and 1200AS2 share an identical PCB and base plate — the only difference is that 1200AS1 omits channel 2 components and the P108 speaker output connector. The mechanical drawing (Figure 3) provides all mounting hole X/Y coordinates with full tolerance callouts.

---

## Section 8.1 — Overall Dimensions (Table 14)

| Parameter | Symbol | Min | Typ | Max | Unit |
|-----------|--------|-----|-----|-----|------|
| Module length | L | — | 300 | — | mm |
| Module width | W | — | 100 | — | mm |
| Module height | H | — | 63 | — | mm |
| Weight (1200AS1) | Mass | — | 1150 | — | g |
| Weight (1200AS2) | Mass | — | 1250 | — | g |
| Base plate thickness | H_Base | 2.85 | — | 3.15 | mm |
| Mounting hole thread depth | H_M3 | — | — | 5.0 | mm |
| Mounting torque | T | — | — | 0.5 | Nm |

**Length axis** = 300 mm (long axis, width of module as installed)
**Width axis** = 100 mm (depth front-to-back)
**Height** = 63 mm (tallest point, includes all components above base plate)

---

## Section 8.2 — Mounting Hole Pattern (Figure 3)

Figure 3 caption: "ICEpower1200AS baseplate mechanical dimensions in mm seen from top side"

### Corner radii
- 4× corner radii: R5.00 mm (PCB corners)
- 12× edge recesses (top-mount method): R1.75 mm

### X-axis coordinates (along 300 mm length)
Positions read from drawing:

| Group | X positions (mm) |
|-------|-----------------|
| Left cluster | 0.00, 5.00, 13.00 |
| Second cluster | 59.00, 65.00, 71.00 |
| Third cluster | 105.00, 112.50, 123.50, 125.00 |
| Center | 153.50 |
| Fifth cluster | 183.00, 191.50, 200.80 |
| Sixth cluster | 239.80, 248.00 |
| Right cluster | 287.00, 295.00, 300.00 |

### Y-axis coordinates (along 100 mm width)
| Position (mm) | Description |
|---------------|-------------|
| 0.00 | Bottom edge |
| 3.45 | Row 1 (bottom M3 row) |
| 5.00 | |
| 8.50 | |
| 15.00 | |
| 20.40 | |
| 35.50 | |
| 44.10 | |
| 46.50 | |
| 64.50 | |
| 65.80 | |
| 67.80 | |
| 91.50 | |
| 95.00 | |
| 96.55 | |
| 100.00 | Top edge |

### Mounting methods (Section 13)
- **Bottom mounting:** 18× M3 threaded holes, 5.0 mm thread depth, max torque 0.5 Nm
  - These are standoffs that also mount the PCB to the base plate; free thread extends below base plate for chassis attachment
- **Top mounting:** 12× recesses along the two long (300 mm) edges
  - Standard M3 (3 mm) or 1/8" non-countersunk screws
  - R1.75 mm recesses

---

## Connector Locations (Figure 2)

All connectors are on the bottom edge (0 mm Y side) or the right-hand end of the board. From Figure 2 (connector overview diagram), connector positions along the 300 mm axis:

| Connector | Function | Position |
|-----------|----------|---------|
| P100 | AC Mains (JST B2P3-VH, 3-pin) | Left end, bottom edge |
| P103 | Hanger Control (JST B8B-PHDSS, 8-pin) | Bottom edge, left of center |
| P101 | Basic Control (JST B14B-PHDSS, 14-pin) | Bottom edge, center-left |
| P102 | Advanced Control (JST B22B-PHDSS, 22-pin) | Bottom edge, center |
| P104 | Hanger Rail Supply (JST B03P-NV, 3-pin) | Bottom edge, center-right |
| P105 | Audio Input (JST B6B-PH-K-S, 6-pin) | Right end, bottom area |
| P106 | V/I Monitor Output (JST B8B-PH-K-S, 8-pin) | Right end |
| P107 | Ch1 Speaker Output (JST B4P-VH, 4-pin) | Right end |
| P108 | Ch2 Speaker Output (JST B4P-VH, 4-pin) | Right end (not populated on 1200AS1) |

---

## Height Profile Notes

The datasheet states module height = 63 mm. This is the overall height including the tallest component above the base plate. The base plate itself is 2.85–3.15 mm thick. Effective component height above base plate = approximately 60 mm.

**No separate heatsink is integrated into the 63 mm envelope.** The aluminum base plate IS the thermal interface — it conducts heat to whatever chassis/heatsink the module mounts to. The 63 mm height includes the tallest capacitors and inductors on the PCB. A separate heatsink is added externally under the base plate.

**Reference heatsink** (used for all datasheet power specs): Fisher Elektronik SK198-100mm or Aavid Thermalloy 0S489-100mm, Rth = 0.8 K/W.

---

## Thermal / Mounting Requirements

- Module must be mounted with base plate against aluminum chassis/heatsink
- Base plate must contact chassis (isolated mounting increases HF radiation per EMC guidelines)
- Thermal compound may be used at the interface
- Surface flatness of chassis/heatsink must be controlled to prevent PCB bending
- Passive cooling (no fan) rated to 40°C ambient max; active fan cooling rated to 60°C ambient

---

## 1200AS1 vs 1200AS2 Differences

| Item | 1200AS1 | 1200AS2 |
|------|---------|---------|
| PCB | Identical | Identical |
| Base plate | Identical | Identical |
| All mounting holes | Identical | Identical |
| Weight | 1150 g | 1250 g (100 g more components) |
| P108 speaker output | Not populated | Populated |
| Clip2 output | Not connected | Active |
| Ilim2 output | Not connected | Active |
| Vmon2/Imon2 | Not connected | Active |

**For mechanical chassis design purposes, 1200AS1 and 1200AS2 are interchangeable.**

---

## Key Specs for Cabinet Design

For the theater project (5× 1200AS2 in equipment closet), per-module clearance:

| Dimension | Value | Notes |
|-----------|-------|-------|
| Footprint | 300 × 100 mm | L × W |
| Height above mounting surface | ~60 mm | PCB + components (base plate ~3 mm below) |
| Total module height | 63 mm | Including base plate |
| Mounting screw spacing | See Figure 3 grid | 18 bottom M3 or 12 top-edge recesses |
| Minimum heatsink Rth | 0.8 K/W | For full rated power spec |
| Connector protrusion | Not specified in datasheet | JST connectors; allow ~15–20 mm above PCB for cable dressing |
| Long-axis clearance | 300 mm minimum | No protrusion beyond PCB outline per datasheet |

**Note on connector clearance:** The datasheet does not specify connector protrusion height above the PCB surface. JST VH-series connectors (P107/P108 speaker outputs) are typically 10–12 mm tall above PCB; JST PH-series (control/audio) are 5–7 mm. The 63 mm total height likely captures the tallest capacitors, not the connectors which are on the short edge. Plan for ~20 mm cable dressing space beyond the right-hand end of the board.

---

## Bidirectional Search

- **Searched FOR:** ICEpower 1200AS2 datasheet PDF dimensions, mounting holes, mechanical drawing, heatsink specs, chassis dimensions, community build threads
- **Searched AGAINST:** Conflicting dimension claims from resellers, forum posts with different measurements, alternative mounting configurations that contradict datasheet
- **Contradicting evidence found:** No contradictions found. Multiple resellers (Parts Express, SoundImports) quote identical 300×100×63 mm. Forum search confirmed 18× M3 mounting description matches datasheet exactly. The "2x600W" label on some resellers is misleading (it's 1200W/ch burst, 700W/ch continuous both driven at 230V) but that is a power spec issue, not dimensional.

---

## Recommendations

These dimensions are from the official ICEpower datasheet v1.7 (June 2023) and are authoritative. Use these for all enclosure/chassis design:

- **Chassis floor space per module:** 300 × 100 mm minimum footprint
- **Chassis internal height:** 63 mm module + heatsink thickness below + cable clearance above
- **For 5× 1200AS2:** If mounted side-by-side along 100 mm axis: 5 × 100 = 500 mm total width, 300 mm depth
- **For 5× 1200AS2:** If mounted end-to-end along 300 mm axis: 5 × 300 = 1500 mm total length, 100 mm depth
- **Heatsink:** Mount modules against a common aluminum plate; thermal compound at interface; no fan required if ambient ≤ 40°C

---

## Sources

1. ICEpower1200AS1-2 Datasheet v1.7 (official) — https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf
2. Parts Express product page — https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117
3. SoundImports product page — https://www.soundimports.eu/en/icepower-1200as2.html
4. ICEpower shop product page — https://shop.icepoweraudio.com/product/1200as2/
