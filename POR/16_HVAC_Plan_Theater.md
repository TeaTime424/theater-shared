# HVAC Plan — Home Theater (Theater Side Only)
## POR Scope: Theater Zone Only

**Document Purpose:** Complete HVAC specification for the home theater space.
**POR Scope:** Theater side only. Gym/equipment room HVAC is a separate future document.
**Status:** Planning — Pre-purchase
**Created:** 2026-03-13
**Supersedes:** HVAC section of `07_Lighting_and_HVAC.md` (which remains valid for lighting)

---

## 1. Space Definition

| Parameter | Value |
|-----------|-------|
| Room dimensions | 17' × 23' × 10' |
| Volume | 3,910 cu ft |
| Conditioned area | 391 sq ft |
| Adjacent space | Gym/equipment room (sealed shared wall, no HVAC transfer) |
| Thermal isolation | Fully sealed from gym — humidity and temperature independent |
| Panel location | Theater side |

---

## 2. Thermal Load Analysis

Equipment rack is **fully outside the theater** in the adjacent gym space, thermally isolated by the sealed shared wall. Theater HVAC handles only:

| Heat Source | BTU/hr | Notes |
|-------------|--------|-------|
| Occupants (max 2 sedentary) | ~800 | 400 BTU/hr per person |
| Projector | ~1,000–1,500 | Laser projector, ceiling-mounted |
| Envelope (walls/ceiling) | ~2,000–3,500 | Central NC climate, insulated construction |
| Lighting (work lights, off during viewing) | ~500 | Only relevant during setup |
| **Total peak** | **~4,300–6,300 BTU/hr** | |

**Key insight:** With no electronics in the theater, the 12,000 BTU unit provides ~90–175% headroom over peak load. This means the unit will operate at low/silent fan speed almost exclusively during viewing — critical for noise floor.

**Usage pattern modifier:** The theater is an almost exclusively nighttime activity. NC summer outdoor temps at typical viewing hours (8pm–1am) run 70–85°F vs 92–98°F peak afternoon, reducing the outdoor-to-indoor delta by ~60%. Nighttime envelope load drops to ~800–1,500 BTU/hr, bringing total actual load down to ~2,600–3,800 BTU/hr — well below even the 9K unit's rated capacity.

---

## 3. Unit Sizing Investigation — 9K vs 12K

Given the low actual load, the question was raised whether the 9K unit is viable and whether it represents a meaningful saving.

### Price Comparison (5th Gen E-Star, complete system)

| Unit | Price | Delta |
|------|-------|-------|
| 9K | ~$2,329 | — |
| 12K | ~$2,359 | **+$30** |

**The saving is $30. The 9K is not a viable cost-reduction strategy.**

### Why the 9K is Still Wrong for This Space

**Coverage rating:** The 9K is rated for up to 350–400 sq ft. The theater is 391 sq ft with 10 ft ceilings — already at or slightly over the rated coverage before volume correction.

**Inverter minimum output floor:** Both units are inverter-driven and modulate down, but not infinitely. The 9K's minimum output floor is approximately 2,700–3,600 BTU/hr. On a typical nighttime session the actual load (~2,600–3,800 BTU/hr) can fall at or below this floor, causing short-cycling — the unit hits setpoint, shuts off, overshoots, kicks back on repeatedly. This is inefficient and increases compressor wear over time.

**Humidity control:** A sealed theater with occupants generates moisture regardless of time of day or outdoor temperature. The 12K's greater headroom means it reaches setpoint faster and then idles — superior humidity management in a space where humidity isolation is a stated design requirement.

**Nighttime use reinforces the 12K:** Counterintuitively, the nighttime-only usage pattern is an argument *for* the 12K rather than against it. Lower outdoor temps mean the unit operates near its minimum modulation threshold more often. The 12K handles this more gracefully due to larger coil thermal mass and a higher minimum output floor that better matches the actual load range.

**Why the 9K exists at all:** MrCool's product line is segmented by coverage area, not cost. The 9K serves genuinely small spaces (200–350 sq ft) where the 12K would short-cycle on mild days. The pricing delta is negligible at the bottom of the range because manufacturing cost differences are minor — the real pricing spread emerges above 12K (18K at $2,909, 24K at $3,329). The 9K is not an inferior product; it is simply the wrong tool for this space at this price point.

**Verdict:** 12K is the correct unit. The 9K offers no meaningful saving and introduces real operational risks.

---

## 4. System Selection

### Selected Unit: MrCool DIY 5th Generation 12K BTU — 230V Single Zone

**Model:** DIY-12-HP-WM-230D25-O (E-Star) or DIYHH-12-HP-WM-230D25-O (Hyper Heat)
**Refrigerant:** R-454B (pre-charged, no vacuum required)
**SEER2:** 23.5
**Voltage:** 208–230V / 60Hz / 1-phase

#### Why This Unit

- 12K BTU is the correct size — right-sized for actual theater load with equipment isolated
- Oversized relative to actual load = runs on low/silent mode during movies
- Silent mode: 23.5 dB(A) — effectively inaudible against any movie content
- Single-zone: independent circuit, independent refrigerant, failure does not affect gym
- DIY Quick Connect lineset: no HVAC contractor required for installation
- 230V is significantly more efficient than 115V equivalent; actual running draw estimated ~10A at typical load, well within 20A circuit

#### Why Not Other Options (Investigated 2026-03-13)

| Option | Reason Rejected | Reference |
|--------|-----------------|-----------|
| Pioneer WYS 12K 230V | End-of-life R-410A, NOT DIY (requires vacuum pump + flare connections), worse warranty (5yr vs lifetime), 1 dB noise difference is imperceptible | `investigations/hvac-theater-setup/07_pioneer_assessment.md` |
| Ducted mini-split (18-24K, both rooms) | $4,700–6,100 installed vs $5,100 for two independent wall-mounts; no DIY; marginal noise gain; lose room independence | `investigations/hvac-theater-setup/09_ducted_assessment.md` |
| Behind-screen installation | Rejected in favor of partition wall mount — overcrowded space behind screen (LCR + sub cabs), fake-wall venting requires complex engineering, poor serviceability, condensate risk near speakers | `investigations/hvac-theater-setup/08_partition_wall_assessment.md` |
| Ceiling cassette | Not available in single-zone Quick Connect configuration |
| Shared multi-zone system | Gym and theater are sealed — independent control required |
| 9K unit | $30 savings, short-cycling risk at nighttime loads — see Section 3 |

#### Noise Investigation Summary

All units in the 21–25 dB(A) range are functionally equivalent for this theater. The room's natural ambient noise floor (21–25 dB(A) with nothing running) means no unit in this range is audible above ambient. Movie content at even quiet dialogue (45–55 dB SPL) masks all of them by 20+ dB. The pre-cool protocol (unit off or at silent during viewing) makes the entire noise comparison academic. Choose on cost, DIY feasibility, and reliability — not noise. Reference: `investigations/hvac-theater-setup/06_noise_assessment.md`.

---

## 5. Electrical Requirements

| Parameter | Value |
|-----------|-------|
| Voltage | 230V (208–230V acceptable) |
| Breaker | 20A double-pole (Square D, matches existing panel) |
| Minimum circuit ampacity | 15A |
| Wire gauge | 12 AWG 3-conductor (2 hot + ground) |
| Estimated run length | Short — panel is on theater side (~15–30 ft) |
| Disconnect | Non-fused AC-rated 240V disconnect, within 6 ft of outdoor condenser |
| Indoor head power | Low-voltage 24V communications only — no line voltage to head unit |
| Estimated running draw | ~10A at typical load (well under 20A breaker) |

### Panel Status

| Parameter | Value |
|-----------|-------|
| Panel type | Square D 100A |
| Current load | ~20A (minor lighting) |
| Post-theater-HVAC load | ~30A estimated |
| Remaining headroom | ~70A |
| Future gym unit | Additional 20A double-pole — headroom exists |
| Note | Full electronics rack on 30A 240V circuit (future) will bring total load to ~75–80A — within 100A panel but worth monitoring as build progresses |

---

## 6. Noise Performance

Critical specification for a reference theater environment.

| Fan Speed | dB(A) | Context |
|-----------|-------|---------|
| Silent mode | 23.5 | Near-inaudible, rustling leaves equivalent |
| Low | ~31–37 | Quiet library |
| Medium | ~38–41 | Soft conversation |
| High | ~42+ | Not expected during viewing |

**Operational expectation:** With ~4,300–6,300 BTU/hr actual load in a pre-cooled room, the unit will run at silent/low speed throughout most viewing sessions. Pre-cooling protocol (run at medium/high before movie starts, drop to silent for playback) recommended.

**Compressor:** Located outdoors — no compressor noise inside theater. Only fan noise is audible from the indoor head unit.

---

## 7. Parts List — Complete Theater Install

All costs approximate as of March 2026.

### Included in System Package (~$2,359)

| Item | Notes |
|------|-------|
| Indoor wall-mount air handler (12K BTU) | 31.6" W × 11.7" H × 7.4" D, ~24 lbs |
| Outdoor condenser unit | Pre-charged with R-454B |
| 25 ft Quick Connect lineset | No vacuum pump required |
| DIYPro cable | Replaces electrical conduit for lineset run |
| Wireless remote | Includes Follow Me function |
| SmartHVAC WiFi module | Alexa / Google Assistant compatible |
| Wall mounting hardware | Bracket and wall sleeve included |

### Additional Required Items (~$175–280)

| Item | Est. Cost | Notes |
|------|-----------|-------|
| Condenser wall/pad mount brackets | $50–60 | L-bracket wall mount or ground pad |
| Non-fused AC disconnect (240V 30A) | $25–40 | Required within 6 ft of outdoor unit |
| 12 AWG 3-conductor wire (~25–30 ft) | $20–35 | Short run, panel on theater side |
| 20A double-pole Square D breaker | $15–25 | Matches existing panel |
| Lineset cover/raceway (exterior) | $30–60 | Cosmetic, protects lineset on exterior wall |
| Condensate drain tubing + fittings | $15–25 | Route to floor drain or condensate pump |

### Optional

| Item | Est. Cost | Notes |
|------|-----------|-------|
| Condensate pump | ~$30 | Only if gravity drain not possible |
| Lineset extension kit | ~$75–150 | Only if wall penetration path exceeds 25 ft |
| Surge protector (DITEK or equivalent) | ~$80 | Recommended for equipment protection |

### Total Estimated Cost

| | |
|-|--|
| System package | ~$2,359 |
| Required additional hardware | ~$175–280 |
| **Total (DIY, no labor)** | **~$2,550–2,650** |
| Professional install (if needed) | +$500–1,500 |

---

## 8. Installation Overview

### Head Unit Placement: Partition Wall (West Wall of Theater)

**Location:** Mounted on the N-S partition wall (west wall of theater), 7–8 feet high, 2–4 feet south of the screen/north wall. Paint flat black to minimize visual impact.

**Why partition wall (not behind screen):**
- **Better airflow** — side-wall mount blows across the 17' room width, textbook mini-split placement
- **Better serviceability** — filter cleaning with a step ladder, not accessing a confined space behind the screen
- **Simpler condensate** — gravity drain through partition wall to gym side, visible and maintainable
- **No vent engineering** — eliminates the need to design fake-wall pass-throughs (sizing, velocity calcs, acoustic foam lining)
- **No speaker conflict** — positioned north of FWL (front wide left) and well above SL (side surround left), both of which mount on the same wall
- **Minimal noise penalty** — approximately 1–3 dB(A) closer to MLP than behind-screen, but still below room ambient at silent mode

**Lineset route:** Outdoor condenser (north exterior wall) → through north wall → through gym space → through partition wall → up to head unit at 7–8' on partition wall. Total run: ~10–14 feet, well within 25' Quick Connect limit.

### Physical Installation Steps

1. **Mark head unit position** on partition wall — 7–8' high, 2–4' from north wall, clear of FWL and SL speaker positions
2. **Drill 3–3.5" hole** through partition wall for lineset pass-through — seal with acoustic putty around lineset (minimal impact on partition STC)
3. **Route lineset through gym** to north exterior wall — drill exterior wall penetration angled slightly downward
4. **Mount outdoor condenser** on north exterior wall brackets or ground pad
5. **Snap Quick Connect fittings** — no tools, no vacuum, no refrigerant handling
6. **Route condensate drain** through partition wall to gym side — gravity drain to floor or condensate pump
7. **Wire disconnect box** — line voltage from panel to disconnect, low-voltage comms to head unit
8. **Install 20A double-pole breaker** in panel
9. **Paint head unit flat black** — functional, not cosmetic
10. **Power up** — follow MrCool startup sequence, verify operation in all modes

### Acoustic Isolation Notes

- Lineset penetration through partition wall is a single sealed 3.5" hole with acoustic putty — negligible impact on wall STC (45–50)
- Head unit fan noise at silent mode (23.5 dB(A)) is at or below room ambient — effectively inaudible
- Each room (theater, gym) has fully independent HVAC — no shared ductwork or refrigerant
- Pre-cool protocol (run at medium/high before movie, drop to silent for playback) eliminates noise concern during quiet passages
- Unit is NOT on the shared wall in the acoustic isolation sense — it is mounted ON the partition wall surface on the theater side, with only a sealed lineset penetration through the wall

---

## 9. Warranty & Support

| Coverage | Term |
|----------|------|
| Compressor (registered) | Limited lifetime (via MrCool Care Program) |
| Compressor (standard) | 7 years |
| Parts | 5 years |
| Registration requirement | Must register on MrCool website within warranty window |
| Care Program | Requires biannual cleaning kit purchase (~$117 × 2/yr) for lifetime coverage |

---

## 10. Future Considerations

- **Gym HVAC:** Separate 12K 230V single-zone unit — to be specified in a future document. Same product family, independent circuit. Active rack exhaust will significantly reduce gym cooling load.
- **Panel upgrade:** If full electronics rack (30A 240V) + both HVAC units + future loads approach 90A, a 200A panel upgrade should be evaluated prior to final build phase.
- **Home Assistant integration:** MrCool SmartHVAC app supports Alexa/Google — integration with existing HA on Synology DS1520+ via cloud or local API worth investigating for automation (pre-cool on movie start trigger, etc.)

---

## 11. Related Documents

- `07_Lighting_and_HVAC.md` — Lighting plan + original HVAC placeholder (superseded for HVAC by this document)
- `06_Electronics_and_Control.md` — Equipment rack thermal load (gym side)
- `11_Budget_Summary.md` — Update to include HVAC line item
- `electrical_load_analysis.md` — Panel load analysis

---

**Document Version:** 1.2 — Placement changed to partition wall; alternatives investigated (Pioneer, ducted, behind-screen); noise assessment added
**Author:** POR / Claude session
**Date:** 2026-03-13
**Updated:** 2026-03-13
