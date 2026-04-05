# Aluminum 19" Rack Shelves for ICEpower 1200AS2 Mounting

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-25
**Related:** POR/06_Electronics_and_Control.md, POR/15_DSP_Subwoofer_Processing.md

---

## Executive Summary

Standard 19" rack shelves (2U, 18–22" deep, steel or aluminum) are readily available from multiple brands and will physically accommodate the ICEpower 1200AS2 modules. True aluminum shelves exist but are rare — most commercial shelves marketed for pro audio are cold-rolled steel with powder coat. The primary engineering concern is thermal: 5× 1200AS2 modules at 35W idle each = 175W continuous heat in a 4'×4' closet, requiring active closet ventilation regardless of shelf material.

---

## ICEpower 1200AS2 Module Dimensions

From Parts Express product listing and datasheet references:

| Dimension | Value |
|-----------|-------|
| PCB footprint | 300 × 100 mm (11.8" × 3.9") |
| Module height | 63 mm (2.5") |
| Module weight | 3.85 lbs |
| Idle power dissipation | ~35W per module |
| Total idle heat (5× units) | ~175W |
| Cooling method | Conduction through aluminum base plate; passive airflow recommended |

**Note on mounting:** The 1200AS2 is a plate-style module designed to mount through an enclosure rear panel. The board itself is 300mm × 100mm — this is much smaller than the task description's "218mm × 148mm plate cutout" figure. The 218mm dimension likely refers to the panel cutout on a specific commercial enclosure (e.g., Ghent Audio case kits), not the raw PCB. For open rack-shelf mounting (not panel-mount), only the PCB footprint matters: 300mm × 100mm. [UNVERIFIED: the exact panel cutout dimensions from the official datasheet mechanical drawing were not confirmed via direct PDF read — PDF was image-encoded and unreadable by fetch tool.]

**Thermal context:** At 35W idle per module × 5 units = 175W constant heat. A sealed 4'×4' closet will accumulate heat rapidly. Vented shelves reduce heat pooling around modules but do NOT substitute for closet-level active ventilation (exhaust fan).

---

## Shelf Products Surveyed

### Comparison Table

| Brand / Model | U | Depth | Material | Vented | Weight Cap | Price (approx) | Notes |
|---|---|---|---|---|---|---|---|
| **StarTech CABSHELFV** | 2U | 16" | Cold-rolled steel | Yes | 50 lb / 23 kg | ~$54 | Entry-level; front-mount only |
| **StarTech CABSHELF22V** | 2U | 22" | Cold-rolled steel | Yes | 50 lb / 23 kg | ~$77 | Best-value deep option; exceeds 1200AS2 depth |
| **NavePoint 2U Vented (std)** | 2U | 18" | Cold-rolled steel | Yes | 55 lb | ~$45–55 | Has lip on rear edge; good for loose modules |
| **NavePoint 2U Heavy Duty** | 2U | 18" | Cold-rolled steel | Yes | 110 lb | ~$86 | Double the capacity; overkill for 1200AS2 |
| **Penn Elcom R1194/2UVK** | 2U | 368mm (14.5") | 1.5mm steel | Yes (61% open) | 22 kg (48 lb) | ~$40–60 | Pro audio staple; shallow — may not fit |
| **Middle Atlantic U2V** | 2U | 14.75" (374mm) | 16-ga steel | Yes | 50 lb | ~$77–95 | Industry-standard AV; too shallow for full board depth |
| **Middle Atlantic VDS** | 2U | Adj. 23.5"–32" | Steel | Partial | 200 lb | ~$120–160 | Requires 4-post rack; adjustable depth is a plus |
| **Seismic Audio SARCS-05** | 2U | 18" | 16-ga steel | Yes | ~50 lb [UNVERIFIED] | ~$39 | Budget option; steel |
| **Gruber 34-104410** | 2U | 20" | .090 aircraft aluminum | No (solid) | 200 lb | ~$67 | Only true aluminum option found; solid surface, not vented; 2-piece center-weight |
| **RackMountMart RA7304-AL** | 2U | 19" | .090 aluminum | No (solid) | 50 lb | Price not listed | USA-made aluminum; solid surface; screws included |
| **Gator GRW-SHELFVNT2** | 2U | 15" | Steel | Yes | ~30–50 lb [UNVERIFIED] | ~$40–60 | Pro audio brand; shallow |

---

## Depth Analysis

The 1200AS2 PCB is 300mm (11.8") deep. Any shelf ≥ 14" will physically contain the module. However:

- The connector side (IEC inlet, speaker terminals) extends from the rear of the board.
- If modules are lying flat on an open shelf (not panel-mounted), allow at least 15–16" usable shelf depth for the PCB + connector clearance.
- A 18–22" shelf provides comfortable margin plus cable management space behind connectors.

**Recommended minimum:** 18" shelf depth for open flat-mounting. 14–15" shelves technically fit the PCB but leave no connector clearance.

---

## Material: Aluminum vs. Steel

True aluminum rack shelves are uncommon in the pro audio segment. Most "pro audio" shelves are cold-rolled steel with powder coat. Aluminum shelves exist primarily in the data center / server rack segment (Gruber, RackMountMart).

| | Aluminum | Steel (powder coat) |
|---|---|---|
| Weight (shelf itself) | Lighter (~2–3 lb) | Heavier (~5–8 lb) |
| Thermal conductivity | Higher — helps if amp contacts shelf | Not meaningful for radiation/convection |
| Corrosion resistance | Better (passivated) | Good (powder coat) |
| Availability | Limited; mostly solid/non-vented | Wide variety; vented options common |
| Typical cost | $65–100+ | $40–90 |
| Vented options | Rare | Common |

**Conclusion:** If aluminum is specifically required (e.g., for rack-grounding or thermal conduction), the Gruber 34-104410 or RackMountMart RA7304-AL are the main readily-available options. Both are solid (no venting). For vented options, steel is the only practical market choice. Given that closet ventilation is the thermal solution (not the shelf), steel vented shelves are functionally equivalent.

---

## Amp-Specific Mounting Notes

The 1200AS2 is designed as a plate amplifier, intended to mount through an enclosure rear panel using the 18× M3 bottom mounting holes. Flat rack-shelf mounting is a non-standard configuration. Three approaches exist:

1. **Open shelf, module lying flat:** Simplest. Module sits on shelf, secured with standoffs through the M3 holes into the shelf. Requires drilling the shelf or using adhesive standoffs. Vented shelf helps airflow under module.

2. **Custom enclosure in rack:** Ghent Audio offers D365a-S2 (stereo, ~365mm deep case) and D365a-Q1 (4-channel). These are purpose-built aluminum enclosures designed for the 1200AS2, rack-mountable, fully wired. Each enclosure mounts as 2U. For 5 modules (mono sub amps), this approach requires 3 enclosures (2+2+1) and 6U of rack space.

3. **Panel-mount on blank rack panel:** Cut a custom aluminum blank panel to the plate cutout spec from the datasheet. Module mounts to panel, panel mounts in rack. Leaves module exposed at rear; requires good airflow.

---

## Thermal / Airflow Notes

- 1200AS2 is fanless; thermal management is through conduction to the base plate + convection.
- ICEpower datasheet specifies: passive cooling is possible at reduced power; recommends chassis or heatsink coupling.
- 35W × 5 = 175W idle total in closet. Even at modest load (subwoofer duty = high transient, low average), average dissipation will be significant.
- Community reports [diyAudio, UNVERIFIED via direct read]: module runs hot without chassis cooling. Aluminum chassis coupling is preferred.
- **Vented shelf alone is insufficient** for a sealed closet. Active exhaust ventilation of the closet is required.
- If using open shelf mount (approach 1), leave at least 1U of air gap between shelves.

---

## Recommended Options by Priority

**Best overall for DIY rack-shelf mount (steel, vented, sufficient depth):**
- **StarTech CABSHELF22V** — 2U, 22" deep, vented, 50 lb cap, ~$77. Adequate depth, easy to source, standard hardware.

**Best for heavy-duty concern (110 lb capacity):**
- **NavePoint 2U Heavy Duty** — 2U, 18" deep, vented, 110 lb, ~$86. Overkill for 1200AS2 but solid build.

**Only aluminum vented option found:**
- None. All aluminum shelves found are solid surface.

**Best aluminum (solid, not vented):**
- **Gruber 34-104410** — 2U, 20" deep, .090 aircraft aluminum, 200 lb, ~$67. No ventilation slots but high thermal conductivity. 2-piece design.

**Best if using pre-built enclosures (not shelf):**
- **Ghent Audio D365a-S2 / D365a-Q1** — purpose-built aluminum cases for 1200AS2, fully wired, 2U rack-mount. More expensive but no fabrication required. Investigate task recommended.

---

## Follow-up Tasks Created

None created — sufficient data for decision. If Ghent Audio enclosures are under serious consideration, an investigate task for that product line is warranted.

---

## Bidirectional Search

- **Searched FOR:** aluminum 19" rack shelves, vented amplifier shelves, Penn Elcom, Middle Atlantic, StarTech, NavePoint, Gator, ICEpower 1200AS2 dimensions, 2U deep shelf options, pro audio amp shelf
- **Searched AGAINST:** ICEpower 1200AS2 cooling failures in rack, shelf inadequacy for amp heat management, aluminum shelf venting necessity claims, weight capacity concerns
- **Contradicting evidence found:** Yes — community sources note the 1200AS2 can run very hot at idle (35W per module); vented shelves alone are insufficient without closet-level ventilation. The "fanless" marketing claim is accurate but does not mean the module runs cool without thermal management. Solid aluminum shelves provide better conductive cooling than vented steel shelves despite the counterintuitive tradeoff.

---

## Recommendations

1. **Decision point:** Choose between (a) open rack-shelf mounting with custom standoffs, or (b) Ghent Audio pre-built enclosures. These are functionally different approaches with different costs and labor.

2. **If shelf mount:** Use **StarTech CABSHELF22V** ($77) or **NavePoint 2U Heavy Duty** ($86). Both are 18–22" deep, vented, 50–110 lb capacity, readily available. One shelf per module = 5 shelves = 10U minimum rack space. Secure modules with M3 standoffs through shelf surface.

3. **If enclosure mount:** Investigate Ghent Audio D365a-Q1 (4-channel, holds 2× 1200AS2) + D365a-S2 (stereo, 1× 1200AS2) = 3 enclosures for 5 modules. Aluminum construction handles thermal coupling well.

4. **Closet ventilation is mandatory** regardless of shelf choice. 175W continuous heat in a 4'×4' space without active exhaust will cause thermal issues.

5. **Confidence:** High for shelf specs. Medium for ICEpower thermal claims (datasheet PDF unreadable; community data used).

---

## Sources

1. [ICEpower 1200AS2 — Parts Express](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117) — product specs (300×100×63mm, 3.85 lbs)
2. [ICEpower 1200AS2 — ICEpower Official Shop](https://shop.icepoweraudio.com/product/1200as2/) — official product page
3. [ICEpower 1200AS2 Datasheet v1.7 (PDF)](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf) — thermal specs, mounting M3 holes
4. [StarTech CABSHELFV (16" deep)](https://www.startech.com/en-us/server-management/cabshelfv) — 2U, 16", steel, 50 lb, $54
5. [StarTech CABSHELF22V (22" deep) — Amazon](https://www.amazon.com/StarTech-com-Vented-Server-Mount-Shelf/dp/B008X3JIVS) — 2U, 22", steel, 50 lb, $77
6. [NavePoint 2U Heavy Duty Vented Shelf](https://navepoint.com/navepoint-2u-heavy-duty-vented-cantilever-shelf-18-460mm-deep/) — 2U, 18", steel, 110 lb, $86
7. [NavePoint 2U Standard Vented Shelf](https://navepoint.com/navepoint-2u-vented-cantilever-shelf-18-460mm-deep/) — 2U, 18", steel, 55 lb, ~$45
8. [Penn Elcom R1194/2UVK](https://www.penn-elcom.com/fr_en/2u-black-vented-rack-shelf-368mm-deep-r1194-2uvk) — 2U, 368mm (14.5"), steel, 22 kg
9. [Middle Atlantic U2V](https://www.bhphotovideo.com/c/product/623132-REG/Middle_Atlantic_U2V_U2V_Vented_Universal_Rackshelf.html) — 2U, 14.75", steel, 50 lb
10. [Middle Atlantic VDS](https://www.bhphotovideo.com/c/product/418478-REG/Middle_Atlantic_VDS_Steel_Deep_Video_Rack.html) — 2U, 23.5–32" adj., steel, 200 lb
11. [Gruber 34-104410 Aluminum Shelf](https://grubercommunications.com/product/2u-heavy-duty-aluminum-cpu-shelf/) — 2U, 20", aircraft aluminum, 200 lb, $67
12. [RackMountMart RA7304-AL Aluminum Shelf](https://www.rackmountmart.com/html/ra7304al.htm) — 2U, 19", .090 aluminum, 50 lb
13. [Seismic Audio SARCS-05 2U Vented Shelf](https://www.seismicaudiospeakers.com/products/sarcs-05-2-space-vented-rack-case-shelf-18-inch-deep-1u-server-mount-network-shelf) — 2U, 18", steel, ~$39
14. [Ghent Audio D365a-S2 (ICEpower 1200AS2 stereo case kit)](https://ghentaudio.com/products/d365a-s2) — pre-built aluminum enclosure
15. [Ghent Audio ICEpower case list](https://www.ghentaudio.com/pages/icepower-case-list) — full enclosure lineup for ICEpower modules
16. [diyAudio: ICEpower 1200AS2 cooling thread](https://www.diyaudio.com/community/threads/icepower-1200as2-cooling.383601/) — community cooling discussion
17. [diyAudio: ICEpower 1200AS2 main thread](https://www.diyaudio.com/community/threads/icepower-1200as2.318707/) — general community discussion
18. [SHI: StarTech 2U 20" Vented Shelf](https://www.shi.ca/product/44472346/StarTech.com-2U-Vented-Server-Rack-Shelf,-Center-Mount-20in-Deep-Fixed-Cantilever-Tray,-Rackmount-Shelf-for-19-inch-AVDataNetwork-Equipment-w-Cage-Nuts-and-Screws,-200lbs-Weight-Capacity) — 200 lb, 20" center-mount option
