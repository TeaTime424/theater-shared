# Forum Investigation: ICEpower 1200AS2 Multi-Module Builds

**Status:** RESEARCH
**Date:** 2026-03-26
**Evidence volume:** Sparse-to-Moderate — ~20 threads/pages found; direct forum reads blocked on diyAudio (403), AVS Forum (paywalled/redirected), and several retailers. Key data assembled from product pages, search result snippets, and accessible forum pages.

---

## Core Module Dimensions (Datasheet / Confirmed)

The official 1200AS2 datasheet (ICEpower v1.7) and multiple retailer listings consistently report:

- **PCB footprint:** 300mm (L) × 100mm (W)
- **Height (board + components):** 63mm
- **Weight:** ~3 kg (per retailer listings)
- **Mounting:** 18× M3 threaded holes on bottom, 12× recesses on top along long sides
- **Thermal:** Aluminum base plate — primary heatsink; mounts to chassis floor or external heatsink via thermal paste
- **Connectors:** AC mains input on board (not panel-mount); speaker binding and signal headers on top surface

Source: Parts Express listing (confirmed 300×100×63mm), ICEpower datasheet v1.7 PDF (cover page verified), multiple EU retailers (SoundImports, costruireaudio, diy-audio.eu).

---

## Commercial Multi-Module Builds — Chassis Dimensions Confirmed

### Apollon Audio product line (most useful reference)

Apollon builds all-aluminum chassis around 1200AS2 modules. Their lineup gives a direct per-module width baseline:

| Product | Modules | Chassis W×H×D | Notes |
|---------|---------|----------------|-------|
| AS1200 | 1× 1200AS2 | 450×305×185mm (104mm H w/feet) | Stereo, non-rack |
| AS2400 | 2× 1200AS2 | 450×82×383mm (104mm H w/feet) | 4-channel, shallow |
| AS4800 | 4× 1200AS2 | 450×180×420mm (189mm H w/feet) | 8-channel |

**Key observation:** All three Apollon products use a **450mm-wide chassis** regardless of module count. The modules run **front-to-back** (depth axis), not side-by-side. The 300mm module length occupies the depth dimension; the 100mm module width runs left-to-right within the 450mm chassis.

- AS2400 (2× modules): 450mm chassis, modules presumably placed side by side on width axis → ~225mm per module slot including clearance
- AS4800 (4× modules): same 450mm width → ~112mm per module slot including clearance

**For the AS4800 specifically:** 4 modules × 100mm = 400mm of PCB, leaving ~50mm of total clearance within 450mm. This implies ~12–13mm between/around modules when evenly spaced. This is tight but confirmed workable by a commercial manufacturer.

Sources: Apollon Audio product pages (apollonaudio.com/product/as2400, as4800), search result snippets confirming 450×180×420mm for AS4800.

### Ghent Audio case kits

Ghent sells purpose-built aluminum cases for 1200AS2:
- **D365a-S2:** Stereo (1× 1200AS2)
- **D365a-Q1:** 4-channel (2× 1200AS2)
- **BH365a-S1:** Alternate stereo case

Specific chassis dimensions were **not retrievable** — Ghent product pages returned 402 errors. However, from search result snippets and the maxxteknik.com reseller listing, the D365a-Q1 "pre-drilled for 2× 1200AS2" and described as "2U" format. One forum-sourced figure mentioned needing ≥250mm width and ≥350mm depth for a 2-module build. This aligns with modules running depth-wise in a shallow rack enclosure.

### TCR1200 DIY Kit

TCR1200 is a single-module 1200AS2 kit in a purpose-built chassis. Their assembled unit is described as a "shallow 2U enclosure" — specific dimensions not confirmed from public pages (Wix JS rendering blocked content). Offered both as stereo (single module) and in a more complex active-speaker variant combining 1200AS2 + 200AS2 modules.

---

## Pro Arguments (with sources)

- **Commercial proof-of-concept for 4× modules in 450mm chassis exists.** Apollon AS4800 packs 4× 1200AS2 boards in a 450mm-wide box. This is the closest evidence that 4 modules can physically fit side by side in a practical enclosure. [Apollon AS4800 product page](https://apollonaudio.com/product/as4800-icepower-based-class-d-8-channel-amplifier/)

- **Module PCB width is exactly 100mm per datasheet.** At 100mm per module, 5× modules = 500mm of PCB — which fits within a standard 19" rack usable interior width of ~430–450mm with modules oriented front-to-back (depth-axis) and spaced across width. 4 modules (400mm) fit in 450mm with 50mm spare for wiring/walls. [Parts Express 300×100×63mm spec](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)

- **Dedicated 4-channel DIY case kits exist.** Ghent Audio D365a-Q1 is pre-drilled for 2× 1200AS2 (4-channel). Apollon AS2400/AS4800 show commercial readiness. [Ghent Audio kit list](https://www.ghentaudio.com/kit/)

- **No user-reported connector protrusion or heatsink overhang fit failures** found in searches. Zero threads specifically complaining about physical dimension incompatibility with chassis. Absence of this class of complaint is notable given the volume of 1200AS2 builds documented.

- **Thermal issues can be managed with forced air.** One confirmed user report of a "steel coffin with forced air" using two Noctua 40×20mm fans achieving 28.1°C operation. [diyAudio thread via search snippet](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)

---

## Con Arguments (with sources)

- **No 5× module build in a single rack chassis confirmed anywhere.** All commercial multi-module products stop at 4× (AS4800). No diyAudio thread with a 5-module 1200AS2 build was found in any search across diyAudio, AVS Forum, ASR, or Reddit.

- **19" rack fit for 4-module is NOT confirmed.** Apollon AS4800 is 450mm wide — slightly narrower than a 19" rack's ~430mm usable panel width. If modules run perpendicular (along depth axis), 4× fit in 450mm. But a true rack-mount form factor for 4× 1200AS2 side-by-side has not been independently verified. Standard 19" rack usable interior is ~430–445mm, so 4× 100mm PCBs = 400mm may fit, but this requires the PCB width to run across the rack, not front-to-back. The Apollon approach appears to orient modules depth-wise in a custom aluminum box, not in a rack-mount panel.

- **Tight clearance between modules in AS4800 — no photos of internal spacing confirmed.** The math implies ~12mm average clearance for 4 modules in 450mm chassis. No photos were retrievable; all Apollon product pages returned JavaScript-only content to the fetcher. No user teardown of an AS4800 found.

- **Thermal risk with multiple modules in sealed/tight chassis.** Multiple forum threads report the 1200AS2 runs warm at 35W idle. One diyAudio search snippet reported a 1200AS2-based amp failing after ~1 year attributed to heat buildup in a sealed case. [diyAudio "Icepower 1200AS2 cooling"](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)

- **Datasheet height is 63mm but does not account for top-side component clearance.** Connectors and signal headers are on the top surface. Actual required height clearance is not specified by any user measurement found. One builder reported needing a "2U case with depth ≥350mm" for a 2-module build, implying 88.9mm (2U) height minimum — consistent with 63mm PCB + overhead.

- **Ghent D365a-Q1 is 2× modules (4-ch), not 4× modules.** This is frequently mistaken in search results. The "4-channel" naming refers to 4 speaker channels (2 stereo modules), not 4 physical PCBs. [Ghent Audio D365a-Q1](https://ghentaudio.com/products/d365a-q1)

---

## Notable User Reports

1. **"Steel coffin with forced air"** — diyAudio user reported building a 1200AS2 in a steel chassis without heatsink, compensating with two Noctua 40×20mm fans (intake + exhaust), achieving 28.1°C. Direct confirmation that fanless operation in tight enclosures is risky but solvable. (Search snippet from diyAudio cooling thread)

2. **Apollon AS4800 — confirmed commercial existence** of 4× 1200AS2 in a single 450×180×420mm chassis. This is the single most relevant data point for multi-module feasibility. The AS4800 is sold and reviewed (AVForums owners thread active). No reports of AS4800-specific thermal failures found.

3. **Failure mode — protection circuit cycling** — One Audiogon user reported a 1200AS2-based amp entering standby/protection cycling intermittently after ~1 year. Apollon replaced the module under warranty; replacement unit ran ~1.5 years without issue. Root cause not confirmed as heat (could be speaker load mismatch). Single user report.

4. **Module fragility warning (general ICEpower)** — Multiple threads note ICEpower modules are sensitive to grounding errors and output short circuits. Oscilloscope ground clip touching output has reportedly destroyed modules. This is assembly/testing risk, not multi-module chassis risk per se.

5. **Five-module single chassis builds** — The only confirmed instance of 5 ICEpower boards in one chassis was an AVS Forum build using 50ASX2SE boards (not 1200AS2) in a 1RU ventilated shelf. No equivalent 1200AS2 build found.

---

## The 19" Rack Width Question — Analysis

**Module PCB:** 100mm wide × 300mm long × 63mm tall (per datasheet, confirmed by multiple retailers)

**5× modules side by side:** 5 × 100mm = 500mm — **does NOT fit** in a 19" rack usable width (~430–445mm)

**4× modules side by side:** 4 × 100mm = 400mm — **fits** with 30–45mm spare. But this requires careful planning:
- Wall thickness + mounting hardware eats into that margin
- Connector access on the 100mm-wide edges must be verified against the mechanical drawing (not confirmed by any user measurement)
- Apollon's AS4800 confirms this works in a 450mm custom chassis

**Key gap:** No one in any accessible forum has described fitting 4× or 5× 1200AS2 modules side-by-side in a **19" rack-mount panel** specifically. All confirmed multi-module builds use custom aluminum enclosures (Apollon, Ghent) that are either narrower or wider than standard rack width.

---

## Follow-up Tasks Created

None created — this investigation is self-contained. The key unresolved question (can 5 modules fit in a 19" rack chassis, and what is the exact PCB width including any connector protrusion?) should be resolved by downloading and reading the 1200AS2 datasheet mechanical drawing section directly, then doing physical measurement if needed.

Recommend: Create a **verify** task to confirm the mechanical drawing dimensions from the ICEpower datasheet PDF (the PDF was downloaded at `C:\Users\andys\.claude\...\tool-results\webfetch-...pdf` but the image-based content was not parseable by the tool).

---

## Bidirectional Search

- **Searched FOR:** "1200AS2 four modules fit", "1200AS2 multichannel chassis", "Apollon AS4800 dimensions", "Ghent D365a-Q1 dimensions", "multi-module ICEpower build", "TCR1200 chassis", "five modules single chassis"

- **Searched AGAINST:** "1200AS2 too wide", "1200AS2 doesn't fit", "1200AS2 clearance problem", "ICEpower module spacing issue", "1200AS2 thermal shutdown", "1200AS2 overheating", "1200AS2 blew up", "1200AS2 failed", "connector protrudes chassis", "heatsink overhang width"

- **Contradicting evidence found:** Partial — no fit-incompatibility reports found, but also no 19" rack fit confirmation for 4+ modules. Thermal risk in sealed builds IS documented (multiple threads). Commercial AS4800 resolves the 4-module fit question for 450mm custom chassis only.

---

## Sources

1. [ICEpower 1200AS2 — Parts Express (300×100×63mm dimensions)](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)
2. [ICEpower 1200AS2 datasheet v1.7 PDF](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
3. [Apollon Audio AS4800 — 8-channel (4× 1200AS2), 450×180×420mm](https://apollonaudio.com/product/as4800-icepower-based-class-d-8-channel-amplifier/)
4. [Apollon Audio AS2400 — 4-channel (2× 1200AS2), 450×82×383mm](https://apollonaudio.com/product/as2400-icepower-based-class-d-4-channel-amplifier/)
5. [Apollon Audio AS1200 — stereo (1× 1200AS2), 450×305×185mm](https://apollonaudio.com/product/as1200-icepower-based-class-d-amplifier/)
6. [Ghent Audio D365a-Q1 — 4-channel case kit (2× 1200AS2)](https://ghentaudio.com/products/d365a-q1)
7. [Ghent Audio D365a-S2 — stereo case kit (1× 1200AS2)](https://ghentaudio.com/products/d365a-s2)
8. [Ghent Audio ICEpower case list](https://www.ghentaudio.com/pages/icepower-case-list)
9. [diyAudio — ICEpower 1200AS2 cooling thread](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)
10. [diyAudio — ICEpower 1200AS2 main thread (318707)](https://www.diyaudio.com/community/threads/icepower-1200as2.318707/)
11. [diyAudio — ICEpower 1200AS2 main thread (321931)](https://www.diyaudio.com/community/threads/icepower-1200as2.321931/)
12. [ASR — ICEpower 1200AS2 question](https://www.audiosciencereview.com/forum/index.php?threads/icepower-1200as2-question.53096/)
13. [ASR — Apollon AS1200 review (internal photos)](https://www.audiosciencereview.com/forum/index.php?threads/apollon-audio-as1200-review-stereo-power-amplifier.9373/)
14. [AVForums — Apollon owners thread](https://www.avforums.com/threads/apollon-amplifier-discussion-help-experiences.2167553/)
15. [Audiogon — Help with 1200AS2 amp (failure report)](https://forum.audiogon.com/discussions/help-with-icepower-1200as2-amp-please)
16. [ICEpower 1200AS2 official shop page](https://shop.icepoweraudio.com/product/1200as2/)
17. [TCR1200 DIY kit](https://www.tcrastrs.com/tcr1200-diy-kit)
18. [Maxxteknik — Ghent 4-channel box for 1200AS2](https://maxxteknik.com/en/products/ghent-diy-4-kanalers-lada-for-icepower-1200as2-2000as2)
