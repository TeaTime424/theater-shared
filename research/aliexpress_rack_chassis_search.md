# AliExpress Rack Chassis Search — ICEpower 1200AS2

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-25
**Related:** research/verify_adau1701_dac_voltage.md

## Executive Summary

AliExpress carries a large selection of 2U and 3U 19" rack chassis, but nearly all audio-specific aluminum chassis top out at 300–320mm internal depth — far short of the ≥350mm requirement for the 1200AS2 (300mm module + ~76mm connector clearance). Industrial IT server chassis reach 400–480mm depth but are SGCC steel with only aluminum front panels, and have fixed rear panels with pre-punched server-style cutouts. The closest viable options are a handful of 2U industrial chassis at 400–480mm depth (steel body, aluminum face), plus the ModuShop/HiFi2000 Dissipante line which is European-sourced and not AliExpress. Genuinely deep all-aluminum AliExpress chassis suitable for audio amp use do not exist at this depth.

## Key Constraint

**ICEpower 1200AS2 dimensions:** 300mm (L) × 270mm (W) × 72mm (H)
**Minimum chassis internal depth needed:** 300mm module + 50–76mm connector overhang = ~350–376mm internal depth minimum
**2U internal height:** ~70–75mm — marginal for 72mm module height; 3U gives comfortable clearance

---

## Product Catalog — AliExpress Listings Found

### Category A: Audio-Specific Aluminum Chassis (KYYSLB, YGH, BRZ — Depth TOO SHALLOW)

These are all-aluminum profile chassis designed for audio DIY but have insufficient depth.

| Product | Ext. Dims (W×H×D mm) | Material | Rack Ears | Rear Panel | Price (USD) | AliExpress URL | Verdict |
|---------|----------------------|----------|-----------|------------|-------------|----------------|---------|
| KYYSLB 2U All-Aluminum Amplifier Chassis | 438×88×300 | All aluminum CNC | No | Removable | ~$64–96 | [item/4000280824154](https://www.aliexpress.com/item/4000280824154.html) | FAIL — 300mm depth |
| KYYSLB 2U (variant) All-Aluminum | 438×88×300 | All aluminum CNC | No | Removable | ~$71 | [item/1005002966038686](https://www.aliexpress.com/item/1005002966038686.html) | FAIL — 300mm depth |
| DIY Amplifier Case (unnamed seller) | 445×89×300 | Aluminum | No | Removable | ~$79 | [item/32793318955](https://www.aliexpress.com/item/32793318955.html) | FAIL — 300mm depth |
| YGH 002 3U Rack Chassis | 482×132×295 or 320 | Aluminum | Yes (19") | Removable | ~$87–104 | [item/32843030824](https://www.aliexpress.com/item/32843030824.html) | FAIL — 295/320mm depth |
| Full Aluminum 3U Chassis | 445×132×300 | All aluminum | No — 445mm not 482 | Removable | ~$96 | [item/32814664493](https://www.aliexpress.com/item/32814664493.html) | FAIL — not rack, 300mm depth |
| 19" 3U Aluminum Chassis | 482×132×320 | Aluminum | Yes (19") | Removable | ~$116 | [item/32793824797](https://www.aliexpress.com/item/32793824797.html) | FAIL — 320mm depth |

**Note on KYYSLB:** No 19" rack ears on audio models. KYYSLB WA51 internal dimensions confirmed at 420mm W × 83mm H × 300mm D (front panel 8mm, rear 4mm, sides 3mm). The 2U E360 series chassis (described in diyAudio forum) is also a freestanding desktop amp chassis with no rack ears.

---

### Category B: Industrial IT Server Chassis (Steel body, aluminum front — Depth ADEQUATE but not audio-specific)

These are IT rack server chassis with 400–480mm depth. Body is SGCC steel (not aluminum). Rear panel is a fixed punched steel wall with expansion slots — requires significant modification or replacement.

| Product | Ext. Dims (W×H×D mm) | Material | Rack Ears | Rear Panel | Price (USD) | AliExpress URL | Notes |
|---------|----------------------|----------|-----------|------------|-------------|----------------|-------|
| 2U Industrial Control Chassis 480mm Deep | 482×88.5×480 | Aluminum front, SGCC steel body | Yes (19") | Fixed steel, slotted | ~$95 | [item/1005002972868527](https://www.aliexpress.com/item/1005002972868527.html) | Steel body only; rear has 4 expansion slots — must replace rear |
| 19" 2U Rack Chassis 400mm (2U400L) | 428×88.5×400 | Aluminum front panel, 1.0mm SGCC steel body | Yes (19") | Fixed steel, multi-slot | ~$71 | [item/1005003229772178](https://www.aliexpress.com/item/1005003229772178.html) | Heavy IT-style rear panel; not suitable as-is |
| 2U Chassis Short 400mm (dual-channel variant) | 428×88.5×400 | SGCC steel, aluminum front panel | Yes (19") | Fixed steel | ~$103 | [item/1005002973578579](https://www.aliexpress.com/item/1005002973578579.html) | Server chassis — fixed rear |
| Standard 19" 2U Rack Mount ATX 550mm | 482×88.5×550 | Aluminum front panel, SGCC steel | Yes (19") | Fixed steel | ~$75 | [item/1005002554027285](https://www.aliexpress.com/item/1005002554027285.html) | Deep enough; steel rear must be replaced or cut |
| Flexible 2U Server Chassis 400mm Hotswap | 428×88.5×400 | Steel | Yes (19") | Fixed steel | ~$129 | [item/32914889535](https://www.aliexpress.com/item/32914889535.html) | NVR/firewall chassis — wrong application |
| 2U Rack Chassis Depth 350mm | 482×88.5×350 | Aluminum panel, steel body | Yes (19") | Fixed steel | ~$50 | [item/1005002599482151](https://www.aliexpress.com/item/1005002599482151.html) | Borderline depth; steel rear |

---

### Category C: Near-Miss / Specialty (non-AliExpress but China-sourced, referenced in searches)

| Product | Ext. Dims (W×H×D mm) | Internal Depth | Material | Rack Ears | Rear Panel | Price (USD) | Source | Notes |
|---------|----------------------|----------------|----------|-----------|------------|-------------|--------|-------|
| ModuShop Dissipante 2U 400mm | ~430×88×400 | ~380mm estimated | All aluminum (10mm front, 3mm covers/rear) | No — tabletop | Removable (separate panel) | ~$150–200 | modushop.biz / diy-audio.eu | European. No rack ears. Excellent quality. |
| diyAudio Store 2025 Deluxe 2U | 440×86×413 ext | 400mm internal | Aluminum + steel base | No — tabletop | Included (3mm) | $330 | diyaudiostore.com | No rack ears. Premium US-stocked. |
| Ghent Audio D365A-S2 (stereo 1200AS2 kit) | 200×90×376 ext | 365mm internal | All aluminum (black lacquered) | No — narrow desktop | Included | ~$300–400 | ghentaudio.com / maxxteknik.com | Designed specifically for 1200AS2. Not rack. |
| Yongu Case 2U Rack Enclosure (C09B) | 482.6×88.9×250 | <230mm | Aluminum | Yes (19") | Removable | $80 | yongucase.com | Too shallow |
| Yongu Case 2U*358 (F series) | 358mm width — not 482 | ~340mm | Aluminum | Not confirmed | Removable | $162 | yongucase.com | Wrong width |

---

## Critical Depth Analysis

The ICEpower 1200AS2 requires:
- Module body: 300mm L × 270mm W × 72mm H
- Connector clearance at rear: estimated 50–76mm (IEC C20 inlet, barrier strip speaker outputs, signal input)
- **Total internal depth required: ~350–376mm minimum**
- **2U internal height: ~70–75mm** — the 1200AS2 at 72mm H is a tight fit in 2U; 3U (132mm internal) has comfortable clearance

**Ghent Audio validation:** Their D365A-S2 case for the 1200AS2 has 365mm internal depth. This is the manufacturer-validated minimum. Any chassis with <365mm internal depth is not confirmed to work.

---

## Comparison Table — Depth-Qualified Candidates Only

(Internal depth ≥350mm, or close enough to evaluate)

| Candidate | Internal Depth | Rack? | All-Al? | Removable Rear | Price (USD) | Source | Suitability |
|-----------|---------------|-------|---------|----------------|-------------|--------|-------------|
| 2U Industrial 480mm Deep (AliExpress) | ~450mm est. | Yes, 19" | No (steel body) | No — fixed steel | ~$95 | AliExpress | Rear must be fabricated. Body workable. |
| 2U Rack 550mm ATX (AliExpress) | ~510mm est. | Yes, 19" | No (steel body) | No — fixed steel | ~$75 | AliExpress | Too deep; rear must be replaced |
| 2U Rack 400mm (2U400L, AliExpress) | ~370mm est. | Yes, 19" | No (steel body) | No — fixed steel | ~$71 | AliExpress | Marginal depth; rear must be fabricated |
| Ghent Audio D365A-S2 | 365mm confirmed | No | Yes (all-Al) | Yes — designed for it | ~$300–400 | ghentaudio.com | Purpose-built for 1200AS2, not rack |
| ModuShop Dissipante 2U 400mm | ~380mm est. | No | Yes (all-Al) | Yes — separate panel | ~$150–200 | modushop.biz | High quality; no rack ears |
| diyAudio Store 2025 Deluxe 2U | 400mm confirmed | No | Partial (al + steel) | Yes | $330 | diyaudiostore.com | Excellent; no rack ears |

---

## Key Findings

1. **No AliExpress chassis meets all three criteria simultaneously:** adequate depth (≥350mm internal) + all-aluminum + removable rear panel + 19" rack ears. This combination does not exist on AliExpress as of March 2026.

2. **KYYSLB and similar audio brands max out at 300–320mm depth.** These are excellent quality for their size but too shallow for the 1200AS2.

3. **YGH 002 3U (482×132mm) is the only AliExpress rack chassis with 19" ears and removable rear, but depth is only 295–320mm.** Too shallow.

4. **Industrial IT server chassis at 400–480mm depth are viable raw material** — steel body with aluminum face, 19" rack ears confirmed, but rear panel is fixed punched steel with expansion slots. The rear panel would need to be cut out and replaced with a custom aluminum panel. This is the most promising AliExpress path if rack mounting is required.

5. **Purpose-built 1200AS2 chassis exist outside AliExpress:** Ghent Audio D365A-S2 (desktop, confirmed fit), ModuShop Dissipante 2U 400mm (desktop, excellent quality). Neither has rack ears.

6. **A hybrid approach** — AliExpress industrial chassis as the rack shell, with a custom rear panel fabricated separately — is likely the most cost-effective rack solution.

7. **3U height strongly preferred** — the 1200AS2 at 72mm height is too tight for 2U internal clearance (~70–75mm). 3U (internal ~115–120mm) allows heat rise, wiring, and safe removal.

---

## Seller Risk Warning

One documented AliExpress fraud case found (diyAudio forum): seller QJ HIFI audio Store sent fake tracking numbers and false delivery photos, resulting in $250 loss. AliExpress sided with seller. Use only sellers with high order counts and established positive reviews. Pay with credit card for chargeback protection.

---

## Bidirectional Search

- **Searched FOR:** "2U rack chassis aluminum amplifier AliExpress," "KYYSLB 2U chassis specifications," "YGH 002 3U rack chassis," "2U 480mm depth rack chassis AliExpress," "ICEpower 1200AS2 chassis dimensions," "Ghent Audio D365A-S2 dimensions," "3U aluminum amplifier chassis 19 inch rack," "2U chassis 400mm 450mm 480mm depth"
- **Searched AGAINST:** "AliExpress chassis quality problems," "KYYSLB chassis issues," "AliExpress aluminum chassis negative review," "AliExpress fraud amplifier chassis shipping"
- **Contradicting evidence found:** Yes — documented AliExpress fraud case (QJ HIFI audio Store, diyAudio forum thread) involving non-delivery and fake tracking. AliExpress dispute resolution sided with fraudulent seller. Also: KYYSLB and comparable audio chassis brands max at 300mm depth — contradicts any assumption that audio-branded AliExpress chassis will fit the 1200AS2.

---

## Recommendations

**If rack mounting is required:** Use an AliExpress industrial IT server chassis at 400–480mm depth (~$71–95) as the structural shell. Plan to fabricate or purchase a custom aluminum rear panel. The 2U Industrial Control Chassis 480mm deep (item/1005002972868527, ~$95) is the deepest option with 19" ears. Note: 2U internal height is tight for the 1200AS2 — verify with actual caliper measurement of the module before ordering.

**If rack mounting is not required:** Ghent Audio D365A-S2 is the validated solution for the 1200AS2 ($300–400, designed specifically for this module, 365mm confirmed internal depth). ModuShop Dissipante 2U 400mm is a high-quality alternative ($150–200) with removable rear panel.

**Confidence:** Medium. AliExpress product pages were inaccessible via direct fetch (redirect-to-login). Dimensions sourced from search result snippets, cached descriptions, and third-party mirror sites. Recommend confirming dimensions with seller before purchase. Critical specs (internal depth, internal height clearance) should be verified via seller message or measurement.

---

## Sources

1. AliExpress KYYSLB 2U 438-88-300mm chassis — https://www.aliexpress.com/item/4000280824154.html
2. AliExpress 2U Industrial Control Chassis 480mm Deep — https://www.aliexpress.com/item/1005002972868527.html
3. AliExpress 19" 2U Rack Chassis 400mm (2U400L) — https://www.aliexpress.com/item/1005003229772178.html
4. AliExpress Standard 19" 2U ATX 550mm — https://www.aliexpress.com/item/1005002554027285.html
5. AliExpress YGH 002 3U 19" Rack Chassis — https://www.aliexpress.com/item/32843030824.html (depth 295/320mm)
6. AliExpress 3U Aluminum Chassis 482×132×320mm — https://www.aliexpress.com/item/32793824797.html
7. AliExpress DIY Amplifier Case 445×89×300mm — https://www.aliexpress.com/item/32793318955.html
8. AliExpress 2U Chassis 350mm Depth — https://www.aliexpress.com/item/1005002599482151.html
9. Ghent Audio D365A-S2 stereo case for ICEpower 1200AS2 — https://ghentaudio.com/products/d365a-s2
10. Maxxteknik Ghent 2-channel box for ICEpower 1200AS2 (dimensions confirmed) — https://maxxteknik.com/en/products/ghent-diy-2-kanalers-lada-for-icepower-1200as2-2000as2
11. diyAudio Store 2025 Deluxe 2U chassis — https://diyaudiostore.com/products/2025-deluxe-chassis-2u
12. ModuShop Dissipante 2U 400mm — https://modushop.biz/site/index.php?route=product/product&product_id=195
13. Yongu Case 2U Amplifier Cabinet Chassis — https://yongucase.com/products/2u-amplifier-cabinet-chassis
14. AliExpress fraud warning (diyAudio forum) — https://www.diyaudio.com/community/threads/qj-hifi-audio-store-on-aliexpress-com-the-aluminum-amplifier-enclosures-that-never-arrived.421264/
15. 2U400L chassis specs (Tecisoft mirror) — https://www.tecisoft.com/products/2u-server-chassis-standard-19-inch-rack-mounted-server-chassis-front-panel-mounting-ears-and-handles-are-aluminum-profiles-four-slot-rear-window-empty-chassis
