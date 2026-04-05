# Apollon Audio AS4800 — Chassis Dimensions & Module Layout Analysis

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-25
**Related:** research/verify_adau1701_dac_voltage.md, POR/15_DSP_Subwoofer_Processing.md

---

## Executive Summary

The Apollon Audio AS4800 is an 8-channel desktop amplifier using 4× ICEpower 1200AS2 modules in a custom aluminum chassis measuring 450 × 180 × 420 mm (W×H×D), weighing 21 kg, priced at $3,200. It is NOT a 19" rack-mount format — at 450mm wide it exceeds the 482mm rack panel standard but has no rack ears and the 180mm height (4.2U equivalent) does not align with standard rack U increments. The internal module layout is most likely 2 columns × 2 rows stacked vertically (2 side-by-side, 2 high), with module long axis (300mm) running front-to-back — not a planar 2×2 grid. This resolves the apparent contradiction with the observed "rotated 90°" orientation.

---

## Key Findings

### 1. Chassis Dimensions and Format

| Parameter | Value | Source |
|-----------|-------|--------|
| Width | 450 mm | Apollon product page (via search engine extraction) |
| Height | 180 mm (189mm with feet) | Apollon product page |
| Depth | 420 mm | Apollon product page |
| Weight | 21 kg | Apollon product page |
| Price | $3,200 USD | Audio Science Review forum reference |
| Rack format | Desktop only — NOT rack-mountable | Geometry analysis (see below) |
| Rack ears | Not offered as accessory (no evidence found) | Web search |
| Chassis material | Aluminum, black finish | Apollon product description |

**Rack-mount assessment:** A 19" rack panel is 482.6mm wide. The AS4800 at 450mm is narrower than 482.6mm in absolute terms, but the chassis has no rack ears and the height (180mm) does not correspond to a standard rack increment:
- 4U = 177.8mm → close, but 180mm is 4.07U and Apollon does not market it as 4U
- No rack ear accessory or rack-mount variant found on apollonaudio.com/shop/

The AS4800 is a desktop-format chassis, not a rack product.

### 2. ICEpower 1200AS2 Module Physical Dimensions

| Dimension | Value | Source |
|-----------|-------|--------|
| Length (long axis) | 300 mm | Parts Express / SoundImports product pages |
| Width (short axis) | 100 mm | Parts Express / SoundImports product pages |
| Height | 63 mm | Parts Express product page |
| Mounting | 3.5mm holes, integrated aluminum base plate | SoundImports product description |

Source confirmation: Parts Express lists "12" W x 4" D x 2.5" H (300 x 100 x 63 mm)" and SoundImports confirms "300 x 100 x 63 mm."

### 3. Module Layout — Geometric Analysis

The AS4800 contains 4× 1200AS2 modules. Three possible 2×2 arrangements exist:

#### Layout A: 2 wide (long axis left-right) × 2 deep
- Width required: 2 × 300mm = 600mm
- **Exceeds chassis width (450mm) by 150mm — IMPOSSIBLE**

#### Layout B: 2 wide (short axis left-right) × 2 deep (long axis front-to-back)
- Width required: 2 × 100mm = 200mm (fits; 250mm margin for flanges, connectors, heatsink)
- Depth required: 2 × 300mm = 600mm
- **Exceeds chassis depth (420mm) by 180mm — IMPOSSIBLE**

#### Layout C: 2 wide (short axis left-right) × 2 tall (vertical stack) — ONLY VIABLE OPTION
- Width required: 2 × 100mm = 200mm → fits in 450mm (250mm margin)
- Depth required: 1 × 300mm = 300mm → fits in 420mm (120mm margin for connectors/mains board)
- Height required: 2 × 63mm = 126mm → fits in 180mm (54mm margin for PCB standoffs, inter-board clearance, bottom plate)
- **All three dimensions satisfied — this is the correct interpretation**

**Conclusion:** The 4 modules are arranged as 2 columns side-by-side (short axis = 100mm running left-to-right) with 2 modules stacked vertically in each column. The long axis (300mm) runs front-to-back in both rows.

#### Reconciling the "Rotated 90°" Photo Observation

If the unit is photographed from the front (looking toward the rear), modules with their 300mm axis running front-to-back would appear as 100mm-wide boards standing upright — they'd look "narrow" left-to-right.

If the observer expected the long axis to run left-to-right (as is common in 2-channel horizontal amps), seeing the narrow 100mm face at the front would appear as a 90° rotation from expected. The modules are not actually rotated — the chassis orientation is simply depth-dominant rather than width-dominant, which is unusual for a wide chassis.

Alternatively: if the photo is a top-down view of the open chassis, the 2×2 stacked-vertical layout would show only 2 modules side-by-side per layer, which could look like a 2×1 layout rather than 2×2 — the second layer beneath would not be visible.

### 4. Apollon Product Line Comparison

| Model | Modules | Channels | Dimensions (W×H×D) | Weight | Price |
|-------|---------|----------|---------------------|--------|-------|
| AS1200 | 1× 1200AS2 | 2ch | 450×305×185mm [UNVERIFIED — unusual H>W ratio, may be W×D×H] | 6 kg | — |
| AS2400 | 2× 1200AS2 | 4ch | Not confirmed via direct page access | — | — |
| AS4800 | 4× 1200AS2 | 8ch | 450×180×420mm (W×H×D) | 21 kg | $3,200 |

**Note on AS1200 dimensions:** The search engine returned "450 × 305 × 185 mm" for the AS1200 — if interpreted as W×H×D, that would make it taller (305mm) than the AS4800 (180mm) despite having only 1 module. This is suspicious. It's more likely to be W×D×H meaning 450mm wide × 305mm deep × 185mm tall, or the dimensions may be in a different order. [UNVERIFIED — source is web search extraction, not direct page scrape]

### 5. Rack Ears and Empty Chassis Availability

**Empty chassis:** No evidence found of Apollon selling empty chassis as a product.

**Rack ears:** No evidence found of Apollon offering rack ears as an accessory (searched apollonaudio.com/shop/ and general web).

**Chassis OEM:** Unknown. The aluminum chassis is custom to Apollon Audio. No chassis manufacturer or OEM source identified. [UNVERIFIED — no diyAudio thread identified the chassis supplier]

### 6. Replication Feasibility in Standard Enclosures

The 2-column × 2-high vertical layout requires a chassis that is:
- Width: minimum ~220mm (2 × 100mm modules + 20mm margin)
- Depth: minimum ~330mm (300mm module + 30mm for rear connector clearance)
- Height: minimum ~150mm (2 × 63mm + 24mm for standoffs/clearance)

**Hammond 1444 series:** These are small general-purpose chassis, not deep enough for the 300mm module length in most variants. Not suitable for multichannel 1200AS2 builds.

**Bud CH-14404:** Not found in search results for ICEpower builds. No community evidence of this chassis being used with 1200AS2.

**Practical alternatives for DIY 4× 1200AS2 build:**

The Apollon AS4800 chassis at 450×180×420mm is close to a custom solution. For rack-mount replication:
- A 4U (177.8mm) 19" rack case would provide: 482.6mm W × 177.8mm H × variable D
- Typical 4U rack chassis depth: 350–500mm available from Toroidy, Modushop (Pesante), Hifi2000
- **Modushop Galaxy/Pesante 4U:** Available in 300–500mm depths, 430–465mm internal width — this would fit 2× 100mm modules side-by-side and accommodate 300mm depth with room to spare
- The Apollon itself could be used as the chassis reference: at 450mm wide it is narrower than 19" panel width but could be modified with rack ears if the side panels have adequate thickness

**Key constraint for rack format:** If building a rack-equivalent with 4× 1200AS2 in the vertical-stack 2-column layout, a 4U 19" case with ~400mm+ internal depth is sufficient. Total module footprint per column: 100mm wide × 300mm deep × 126mm high (2 stacked).

---

## Comparison Table — Chassis Options for 4× 1200AS2

| Option | W (mm) | H (mm) | D (mm) | Rack? | Est. Cost | Notes |
|--------|--------|--------|--------|-------|-----------|-------|
| Apollon AS4800 (complete amp) | 450 | 180 | 420 | No | $3,200 | Turnkey; no empty chassis sold |
| Modushop Pesante 4U × 400mm | ~430 internal | 177 | 400 | Yes (4U) | ~$200–300 | DIY; fits 2-col layout; rack ears included |
| Modushop Pesante 4U × 500mm | ~430 internal | 177 | 500 | Yes (4U) | ~$250–350 | More depth margin; better for connectors |
| Hammond 1444 series | Varies | Varies | Varies | Some variants | $50–150 | Too small for 4× 1200AS2 |

[UNVERIFIED — Modushop pricing is estimated from general market knowledge, not confirmed current pricing]

---

## Follow-up Tasks Created

None created — research is self-contained. If pursuing a DIY 4× 1200AS2 rack build, create an investigate task for Modushop Pesante chassis fit-check.

---

## Bidirectional Search

- **Searched FOR:** Apollon AS4800 specifications, dimensions, rack mount capability, internal photos, ICEpower 1200AS2 module dimensions, module layout 2×2, diyAudio chassis builds, ASR teardown
- **Searched AGAINST:** AS4800 rack-mount variant, Apollon rack ears accessory, chassis dimensions inconsistency, module layout geometrically possible with wider arrangement, empty chassis sale, chassis OEM supplier identification
- **Contradicting evidence found:** No direct contradiction found. No ASR teardown of the AS4800 was found (only AS1200 reviewed and Hypex NC2K torn down). The AS1200 dimensions returned by search ("450×305×185mm") are suspicious and flagged [UNVERIFIED] — if that H dimension is correct it would be anomalous. No evidence of rack-mount variant or rack ears for any Apollon ICEpower model was found. The geometric analysis eliminates two of three possible 2×2 layouts, leaving vertical stacking as the only feasible interpretation.

---

## Recommendations

1. **The AS4800 is a desktop unit, not rack-mount.** 450mm wide with no rack ears, 180mm height not aligned to standard U increments.

2. **The 2×2 module layout is almost certainly 2 columns × 2 vertically stacked**, with module long axis running front-to-back. The "rotated 90°" observation in the photo is consistent with seeing the narrow 100mm face of each module at the front, which would look "rotated" relative to a traditional horizontal 2-channel amp layout.

3. **Replication in a rack chassis is feasible.** A 4U 19" rack chassis with ≥400mm internal depth accommodates the layout. Modushop Pesante series is the most commonly used chassis in the diyAudio community for heavy Class D builds. [UNVERIFIED — not confirmed for 1200AS2 specifically]

4. **Apollon does not sell empty chassis or rack ears.** DIY replication requires a third-party chassis supplier.

5. **Confidence level:** Medium-high for dimensions (confirmed via multiple web sources), medium for layout interpretation (geometric deduction from confirmed dimensions — no teardown photo with explicit annotations found).

---

## Sources

1. [AS4800 Product Page — Apollon Audio](https://apollonaudio.com/product/as4800-icepower-based-class-d-8-channel-amplifier/)
2. [AS4800 Old Product Page — Apollon Audio](https://old.apollonaudio.com/icepower-1200as2-based-class-d-multichannel-amplifier-8-channel-as-4800/)
3. [ICEpower 1200AS2 — Parts Express (dimensions confirmed)](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)
4. [ICEpower 1200AS2 — SoundImports (dimensions confirmed)](https://www.soundimports.eu/en/icepower-1200as2.html)
5. [ICEpower 1200AS2 Datasheet PDF — ICEpower Audio](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
6. [AS4800 For Sale — US Audio Mart (price reference)](https://www.usaudiomart.com/details/649584778-apollon-audio-as4800-8-channel-amplifier/)
7. [AS1200 Product Page — Apollon Audio](https://apollonaudio.com/product/as1200-icepower-based-class-d-amplifier/)
8. [AS2400 Product Page — Apollon Audio](https://apollonaudio.com/product/as2400-icepower-based-class-d-4-channel-amplifier/)
9. [Apollon Audio Shop](https://apollonaudio.com/shop/)
10. [Owners Thread — AVForums (AS4800 discussions)](https://www.avforums.com/threads/apollon-amplifier-discussion-help-experiences.2167553/)
11. [Apollon Audio AS1200 Review — Audio Science Review](https://www.audiosciencereview.com/forum/index.php?threads/apollon-audio-as1200-review-stereo-power-amplifier.9373/)
12. [Apollon Audio Custom Class D — AVS Forum](https://www.avsforum.com/threads/apollon-audio-custom-class-d-amplifiers.3203842/)
