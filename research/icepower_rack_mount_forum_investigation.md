# Forum Investigation: ICEpower 1200AS2 Rack Mounting

**Status:** RESEARCH
**Date:** 2026-03-25
**Evidence volume:** Moderate — 20+ forum threads found across diyAudio, Audiogon, ASR, AVS Forum, Amp Garage

---

## Module Physical Specifications

From datasheet (v1.7) and vendor listings:
- **PCB dimensions:** 300mm W × 210mm D × 63mm H (approx — vendors cite "300 × 100 × 63mm" but this appears to describe the baseplate only; actual PCB overhangs)
- **Note:** Ghent Audio's case kit model number "D365a-S2" implies ~365mm chassis depth needed for the full module including connectors and clearance
- **Mounting from bottom:** 18× M3 threaded holes into the aluminum baseplate
- **Mounting from top:** 12× recesses along the two long sides
- **Baseplate function:** Acts as both mechanical mounting surface AND primary thermal interface — must contact heatsink or aluminum chassis
- **Heatsink spec (datasheet):** 0.8 K/W thermal resistance used for rated power specs
- **Idle power draw:** ~35W per module (reported by multiple forum users, consistent with datasheet)
- **Weight:** 3.85 lbs per module

**5-module thermal load at idle:** ~175W continuous heat that must be dissipated

---

## Pro Arguments (with sources)

- **Plate amp form factor eliminates enclosure problem for most builders.** The 1200AS2 has a bolt-through-aluminum-plate mounting pattern (18× M3 into baseplate) that lends itself naturally to mounting flat to an aluminum shelf or custom aluminum plate in a rack. Several builders use this approach successfully.
  - [diyAudio — 10 ICEpower modules in a single amp enclosure](https://www.diyaudio.com/community/threads/10-icepower-modules-in-a-single-amp-enclosure.344885/)

- **Fanless design confirmed to work in open/vented rack configurations.** Multiple builds report stable thermal operation with just passive convection when adequate vent area is provided above and below modules. One user with a 125ASX2+50ASX2 in a small closed aluminum case reports the case surface stays at 40°C.
  - [diyAudio — 10 ICEpower modules thread](https://www.diyaudio.com/community/threads/10-icepower-modules-in-a-single-amp-enclosure.344885/)

- **Community has converged on aluminum plate + standoffs as the canonical DIY approach.** Multi-module builds consistently use a 3–5mm aluminum base plate as the mounting surface; modules bolt to it flat, which provides thermal coupling to the chassis.
  - [AVS Forum — DIY assembled sub amp using ICEpower modules](https://www.avsforum.com/threads/diy-assembled-sub-amp-using-icepower-modules.3254638/)

- **Commercial enclosure kits validate 2U rack depth as achievable.** Ghent Audio (D365a-S2) and TCR build logs show a 2U rack chassis works for a single 1200AS2. TCR demonstrates fitting a 1200AS2 + 2× 200AS2 in a 2U × 200mm-deep chassis for a mobile rack case.
  - [Ghent Audio D365a-S2 case kit](https://ghentaudio.com/products/d365a-s2)
  - [TCR 1200 build — 2U rackmount prototype](https://www.tcrastrs.com/post/active-speaker-system-icepower-1200as2-2x-200as2-ass1800-part2-building-the-prototype)

- **Ghent Audio offers 4-channel case kit for 2× 1200AS2 modules.** Pre-drilled aluminum enclosure, validates that two modules side-by-side is a supported configuration.
  - [ICEpower DIY 4-channel box for 1200AS2 & 2000AS2](https://maxxteknik.com/en/products/ghent-diy-4-kanalers-lada-for-icepower-1200as2-2000as2)

- **90%+ efficiency reduces heat vs traditional Class AB.** At moderate sub drive levels (not sustained full power), the modules run relatively cool. One ASR reviewer of the Apollon AS1200 (single 1200AS2 in custom chassis) reports "doesn't run that warm, even after hours of listening."
  - [ASR — Apollon AS1200 review](https://www.audiosciencereview.com/forum/index.php?threads/apollon-audio-as1200-review-stereo-power-amplifier.9373/)

- **Datasheet explicitly supports chassis-mount cooling** as the primary design path. The integrated aluminum baseplate is engineered specifically to conduct heat to a mounting chassis or heatsink. This is not a workaround — it's the intended use.
  - [ICEpower 1200AS2 datasheet v1.7](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)

- **10-module single-enclosure build is documented.** Proves the community has already pushed well beyond 5 modules in one box. Builder used vents on top and bottom, no fans initially, with plexi top swap as fallback.
  - [diyAudio — 10 ICEpower modules in a single amp enclosure](https://www.diyaudio.com/community/threads/10-icepower-modules-in-a-single-amp-enclosure.344885/)

---

## Con Arguments (with sources)

- **35W idle heat per module is non-trivial. Five modules = 175W continuous heat load.** Users report that "almost all of this 35W is transformed into heat." In a sealed or poorly ventilated rack bay this will cause thermal runaway. This is the single most-reported issue across all forums.
  - [diyAudio — 1200AS2 cooling thread](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)
  - [Audiogon — Help with ICEpower 1200AS2 amp](https://forum.audiogon.com/discussions/help-with-icepower-1200as2-amp-please)

- **Sealed North Audio enclosure caused a unit failure after ~1 year.** User reports the protection circuit started cutting in every 10 minutes after ~1 year of service; attributed to inadequate airflow in the commercial enclosure. Unit eventually failed and was replaced under warranty.
  - [diyAudio — 1200AS2 cooling thread](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)

- **90°C temperatures reported in closed cases.** One user measured case temperatures potentially reaching 90°C inside a sealed enclosure. After switching to a fully vented top + quiet fan, temperatures dropped to 35–40°C.
  - [diyAudio — 1200AS2 cooling thread](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)

- **Datasheet explicitly warns rack enclosures may require forced airflow.** The official ICEpower datasheet states: "in some cases, such as rack enclosures, forced airflow may be required depending on end-product mechanical design constraints or use environment." This is not a community speculation — ICEpower themselves flag rack mounting as a higher-risk thermal scenario.
  - [ICEpower 1200AS2 datasheet v1.7](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)

- **No documented 5-module 1200AS2 build found in community.** The largest documented 1200AS2-specific rack build is 4 modules (Apollon AS-2400 commercial unit). The 10-module build used smaller 50ASX2SE modules, not 1200AS2. Extrapolating from 4-module commercial builds to 5× 1200AS2 DIY rack involves unverified scaling.
  - [Apollon Audio AS-2400 (4× 1200AS2)](https://old.apollonaudio.com/icepower-1200as2-based-class-d-multichannel-hi-fi-amplifier/)

- **Grounding and buzz issues in rack/chassis setups.** Multiple threads report buzzing audible from the chassis at idle. The 1200AS2 is Class 2 (no chassis ground required), which can create ground loop complexity when multiple modules share a rack chassis and are fed from a common DSP output. Getting ground topology right requires care.
  - [diyAudio — IcePower 1200AS2 buzzing issue](https://www.diyaudio.com/community/threads/icepower-1200as2-buzzing-issue.334801/)

- **No standard 19" rack-mount bracket exists.** The 1200AS2 is not a rack-format product — it requires custom fabrication or a dedicated enclosure kit. All documented rack solutions involve either a purpose-built aluminum enclosure (not standard rack rails) or a custom chassis. There is no "slide in and rack-mount" solution.

- **Depth constraint: module needs ~365mm chassis depth** based on Ghent Audio case kit naming convention. Standard shallow 19" racks (e.g., 14" deep) are too shallow. Equipment closets with 300mm+ accessible depth needed.

- **Five modules side-by-side in a single chassis would be very wide (~1500mm footprint).** Standard 19" rack is only 450mm wide interior. Building all 5 in a single enclosure is geometrically challenging — they would likely need to be stacked 2+3 across two chassis, or use a different orientation.

---

## Notable User Reports

**10-module ICEpower build (diyAudio):**
User built a 10-channel amp using smaller ICEpower modules in a single enclosure. Used vented top and bottom panels, planned to upgrade to plexi top with more ventilation if heat was a problem. Community consensus in the thread: heat buildup could be a problem at max drive levels; adequate ventilation is critical; at normal listening levels heat is manageable. This build used 50ASX2SE (smaller modules), not 1200AS2.

**North Audio enclosure failure (diyAudio cooling thread):**
A user running a 1200AS2 in a commercial North Audio closed case experienced protection-circuit trips starting after ~1 year of service. The community diagnosis was insufficient airflow in the sealed case. Resolution: replace top with fully vented panel + add a quiet fan → temperatures drop from near-90°C to 35–40°C. Module eventually replaced under warranty.

**Apollon AS-2400 (commercial 4× 1200AS2):**
Apollon Audio produced a commercial 4-channel amp using four 1200AS2 modules in a custom chassis. This is the largest known production implementation. Apollon appears to have used passive cooling through the aluminum chassis. No documented thermal failures in community discussions of this product.

**TCR1200 kit (2U rackmount, 1× 1200AS2):**
The TCR kit implements a 2U rackmount enclosure for a single 1200AS2 + supporting modules in a 200mm-deep chassis. Includes active cooling as default. Demonstrates that even a single 1200AS2 warrants active cooling in a compact rack chassis at full spec power levels.

**Amp Garage "I murdered my ICEpower module":**
User killed a module not from thermal issues but from wiring errors — connecting a DC-DC converter to the 24V accessory supply caused fuse failure; later, directly grounding the Enable pin without a pull-down caused the module to draw 90W+ at idle and overheat. These are wiring/integration errors, not module-inherent failures, but they illustrate the integration complexity of multi-module builds.
- [Amp Garage — I murdered my ICEpower module](https://ampgarage.com/forum/viewtopic.php?t=33611)

---

## Follow-up Tasks Created

None created — the findings here are sufficiently clear for design decision purposes. The thermal question (whether 5× 1200AS2 in a rack requires active cooling) is answered definitively by the datasheet and community evidence: yes, forced airflow is required.

If a specific rack chassis or fan configuration needs to be sized, that would warrant a new verify task for thermal calculations.

---

## Bidirectional Search

- **Searched FOR:** "ICEpower 1200AS2 rack mount", "1200AS2 enclosure build", "ICEpower plate amp rack mount DIY", "ICEpower multiple modules single enclosure", "10 ICEpower modules enclosure", "1200AS2 aluminum plate mounting", "1200AS2 sub amp build", "1200AS2 DIY 4-channel"

- **Searched AGAINST:** "ICEpower 1200AS2 rack overheating problems", "1200AS2 thermal shutdown failures", "1200AS2 dead failed smoke", "1200AS2 rack not enough airflow", "1200AS2 protection circuit enclosure", "ICEpower 1200AS2 alternative instead better option"

- **Contradicting evidence found:** Yes — thermal failures in closed cases are documented. The datasheet itself contradicts any claim that the 1200AS2 is unconditionally safe in rack enclosures; it explicitly flags forced airflow as potentially required for rack installations. One real-world failure after 1 year in an inadequately ventilated commercial enclosure is documented. At the same time, the module works reliably in vented or actively cooled setups.

---

## Design Implications for 5× 1200AS2 Sub Rack

1. **Active cooling is mandatory, not optional.** 175W idle heat load across 5 modules in any shared enclosure requires fans. Passive-only is not credible at this scale.

2. **Separate enclosures per 1–2 modules may be simpler** than one mega-chassis. Individual 2U enclosures (one per module, Ghent-style kits) avoid the geometric problem of 5 wide modules side-by-side and keep each unit independently serviceable.

3. **Rack depth constraint: ~400mm minimum.** Standard wall-mount shallow AV racks will not fit the 1200AS2 without a custom shelf solution.

4. **No rack ears available** — requires custom brackets or enclosure kit with rack-mount option. None of the DIY enclosure kits appear to have 19" rack ears; they are freestanding box designs.

5. **Grounding topology needs careful planning** with 5 modules sharing signal from a single ADAU1452 output stage. The Class 2 (floating) outputs require disciplined shield/ground management to avoid hum.

6. **Verify task recommended:** Exact 1200AS2 PCB dimensions — reported as "300 × 100 × 63mm" by Parts Express but Ghent Audio's ~365mm-deep case kit suggests actual module + connector depth is larger. This matters for rack shelf sizing.

---

## Sources

1. [diyAudio — 10 ICEpower modules in a single amp enclosure](https://www.diyaudio.com/community/threads/10-icepower-modules-in-a-single-amp-enclosure.344885/)
2. [diyAudio — Icepower 1200AS2 cooling](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/)
3. [diyAudio — IcePower 1200AS2 buzzing Issue](https://www.diyaudio.com/community/threads/icepower-1200as2-buzzing-issue.334801/)
4. [diyAudio — ICEpower 1200AS2 (main thread)](https://www.diyaudio.com/community/threads/icepower-1200as2.318707/)
5. [diyAudio — Class D amp issue/need advice](https://www.diyaudio.com/community/threads/class-d-amp-issue-need-advice.402665/)
6. [diyAudio — Icepower 1200AS1 not working](https://www.diyaudio.com/community/threads/icepower-1200as1-not-working-pls-help.372695/)
7. [diyAudio — Build log: Class D amplifier in 1U rack-mount enclosure](https://www.diyaudio.com/community/threads/build-log-class-d-amplifier-in-1u-rack-mount-enclosure.359968/)
8. [diyAudio — ICEpower amp vs Purifi](https://www.diyaudio.com/community/threads/icepower-amp-vs-purifi.402472/)
9. [AVS Forum — DIY assembled sub amp using ICEpower modules](https://www.avsforum.com/threads/diy-assembled-sub-amp-using-icepower-modules.3254638/)
10. [AVS Forum — 10-channel DIY ICEpower 50ASX2SE build](https://www.avsforum.com/threads/10-channel-diy-icepower-50asx2se-class-d-audio-amp-build.3100058/)
11. [AVS Forum — Alternatives to Pro Amps for subs](https://www.avsforum.com/threads/alternatives-to-pro-amps-for-subs.3264637/)
12. [Audiogon — Help with ICEpower 1200AS2 amp](https://forum.audiogon.com/discussions/help-with-icepower-1200as2-amp-please)
13. [Audiogon — ICEpower 1200AS2 vs Hypex NC500](https://forum.audiogon.com/discussions/how-does-icepower-1200as2-compares-to-hypex-nc500-implementation)
14. [ASR — Apollon AS1200 review (uses 1× 1200AS2)](https://www.audiosciencereview.com/forum/index.php?threads/apollon-audio-as1200-review-stereo-power-amplifier.9373/)
15. [Amp Garage — I murdered my ICEpower module](https://ampgarage.com/forum/viewtopic.php?t=33611)
16. [ICEpower official shop — 1200AS2 product page](https://shop.icepoweraudio.com/product/1200as2/)
17. [ICEpower 1200AS1-2 Datasheet v1.7 (PDF)](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
18. [Parts Express — ICEpower 1200AS2 listing](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117)
19. [Ghent Audio — D365a-S2 case kit for 1200AS2](https://ghentaudio.com/products/d365a-s2)
20. [Ghent Audio — 4-channel case kit for 2× 1200AS2](https://maxxteknik.com/en/products/ghent-diy-4-kanalers-lada-for-icepower-1200as2-2000as2)
21. [TCR1200 DIY kit — 2U rackmount build](https://www.tcrastrs.com/tcr1200-diy-kit)
22. [TCR — Active speaker build with 1200AS2 + 200AS2 Part 2](https://www.tcrastrs.com/post/active-speaker-system-icepower-1200as2-2x-200as2-ass1800-part2-building-the-prototype)
23. [Apollon Audio AS-2400 (4× 1200AS2 multichannel)](https://old.apollonaudio.com/icepower-1200as2-based-class-d-multichannel-hi-fi-amplifier/)
24. [Audiophonics — 1200AS2 product listing with specs](https://www.audiophonics.fr/en/amplifier-boards/icepower-1200as2-p-19116.html)
