# Garage Conversion — Detached Building
## Gym + Home Theater (9.4.4 Atmos) + WC
## Rev 7.0 Aligned — Version 3.7

**Created:** February 23, 2026
**Updated:** March 13, 2026 — v3.7: Defer nearfield subs, reduce shakers 16 to 8
**Status:** ACTIVE OPTION — More likely build scenario than reference design

---

## Building Specifications

### Existing Structure

| Parameter | Value |
|-----------|-------|
| Type | Detached garage (separate building from house) |
| Internal dimensions | 29' × 23' × 10' |
| Floor area | 667 sq ft |
| Volume | 6,670 cu ft |
| Ceiling height | 10 feet |
| Slab | Concrete |
| Insulation | Fully insulated (walls + attic) |
| Attic | Yes, insulated |
| Electrical | 100A subpanel |
| Internet | 1 Gbps |
| HVAC | None (must add) |
| Plumbing | None (must add for WC) |

### Existing Openings

| Opening | Location | Current | Conversion |
|---------|----------|---------|------------|
| Garage door 1 | South wall (left) | 96" overhead door | 62" window + sliding door |
| Garage door 2 | South wall (right) | 145" overhead door | Double patio doors + 26" window |
| Personnel door | East wall | Standard 36" | Retained (theater entry via vestibule) |

### House Context

| Factor | Detail |
|--------|--------|
| Primary garage | Attached 2-car garage on house (retained) |
| Relationship | Detached — separate structure, no shared walls |
| Soundproofing | **Not required** (separate building, no neighbors affected) |
| Acoustic treatment | Quality treatment inside theater only (reverb/modal control) |

---

## Space Plan

### Layout Concept

The 29' × 23' building is partitioned with an east-west wall. The theater occupies the north half (14' deep × 25' wide), with the screen on the west wall. The gym occupies the south half (8' deep × 26' wide) with converted garage door openings for natural light. A 4'-wide strip on the east side houses the equipment closet (north) and entry vestibule (south), accessed via the existing 36" personnel door.

```
        29' (east-west)
    ←————————————————————————————→
    +——————————————————————+——————+  ↑
    |                      | Eq   |  |
    |   Home Theater       | Closet  |
    |   14' × 25'          | 4×6  |  14' (N-S)
    |                      +——————+  |
    |   Screen on          | Entry|  |
    |   west wall ■■■      | 4×8  |  |
    |                      | [36"door]
    +——————————————————————+——————+  ↓
    | 3×8 |                       |
    |     |     Gym  8' × 26'     |  8' (N-S)
    | 62" |                       |
    | win | sliding  Patio Doors  | 26"win
    +—————+———————————————————————+
          South wall (garage door openings converted)
```

**Based on actual floor plan** (garage3.bmp). Equipment closet accessed from entry vestibule. Theater entered from vestibule (light-lock). Gym entered from converted south wall openings.

### Zone Dimensions

| Zone | Dimensions | Area | Volume | Purpose |
|------|-----------|------|--------|---------|
| Theater | 25' W × 14' D × 10' H | 350 sq ft | 3,500 cu ft | Home theater (screen on west wall) |
| Equipment closet | 4' × 6' | 24 sq ft | — | Amps, DSP, network (NE corner) |
| Entry/vestibule | 4' × 8' | 32 sq ft | — | Light-lock, theater + closet access |
| Gym | 26' W × 8' D | ~208 sq ft | — | Home gym |
| 3' × 8' alcove | 3' × 8' | 24 sq ft | — | SW corner (storage/utility) |
| **Total** | | **~638 sq ft** | | Plus wall thickness ≈ 667 sq ft |

### Theater Entry & Circulation

The 36" personnel door (east wall) opens into the entry vestibule (4' × 8'). From the vestibule:
- **North door** → equipment closet (service access without entering theater)
- **West door** → theater (light-lock — both doors closed = no light bleed)
- **South** → gym area (through or past partition)

No windows in the theater zone. The vestibule serves as the light-lock between the exterior door and the theater.

---

## Theater Room Specifications

| Parameter | Value | vs Reference (16'×26') |
|-----------|-------|------------------------|
| Width | 14 feet (north-south) | -2 feet |
| Depth | 25 feet (east-west) | -1 foot |
| Height | 10 feet | Same |
| Volume | 3,500 cu ft | -15.9% |
| Screen wall | West wall (14' wide) | — |
| Seating faces | West | — |
| Room gain vs reference | +0.8 dB (estimated) | Smaller room = more gain |
| Screen | 145" diagonal, 2.35:1 AT | -25" |
| Room ratio (H:W:D) | 1 : 1.4 : 2.5 | Good — long axis aids modal spacing |

### Seating Geometry

Screen on west wall. "Front wall" = west wall. Seating faces west.

| Row | From Front Wall | From Screen | Viewing Angle (145") | Assessment |
|-----|----------------|-------------|---------------------|------------|
| **Row 1 (MLP)** | 14.0' | 10.5' | **56°** | Immersive (IMAX-like) |
| **Row 2** | 18.5' | 15.0' | **41°** | THX Ideal |

| Dimension | Value |
|-----------|-------|
| Stage depth | 3' |
| Screen surface | 3.5' from west wall |
| Row spacing (MLP to MLP) | 4.5' |
| Riser front edge | 16.0' from west wall |
| Riser depth | 4.5' |
| Space behind Row 2 | 4.0' (rear treatment + entry vestibule wall) |

**Note:** The 25' depth provides generous space behind Row 2 (4') compared to the previous 15'×22' layout (1'). This allows proper rear wall treatment and potential for a third row in the future.

### Screen Fit

- 145" 2.35:1 image width: 11.1 feet
- Room width (screen wall): 14 feet
- Clearance per side: 1.45 feet (17.4") — tight but adequate for LCR behind AT screen
- Titan-815LX L/R at ~25° from MLP: speaker span ~9.8', well within screen width

---

## Speaker Configuration: 9.4.4 Dolby Atmos

**Total: 13 powered channels (9 bed + 4 height)**

The 14' room width benefits from front wide channels — at 14' with close seating distances, FWL/FWR provide meaningful lateral envelopment that wider rooms achieve naturally. The height layer uses 4 channels (front + rear pairs) which provides excellent overhead coverage for this room size.

### Bed Layer (9 channels)

Screen on west wall. "Left" = south wall (audience perspective). "Rear" = east wall.

| Speaker | Position | Angle from MLP | Mounting |
|---------|----------|----------------|----------|
| L | Stage (west wall), behind AT screen | ~25° | On stage deck |
| C | Stage (west wall), behind AT screen | 0° | On stage deck |
| R | Stage (west wall), behind AT screen | ~25° | On stage deck |
| FWL | South wall, between screen and MLP | ~55° | Wall mount |
| FWR | North wall, between screen and MLP | ~55° | Wall mount |
| SL | South wall, beside MLP | ~90° | Wall mount |
| SR | North wall, beside MLP | ~90° | Wall mount |
| SBL | East wall (rear) | ~145° | Wall mount |
| SBR | East wall (rear) | ~145° | Wall mount |

### Height Layer (4 channels)

| Speaker | Position | Mounting |
|---------|----------|----------|
| TFL | Above L/R axis, front | Ceiling |
| TFR | Above L/R axis, front | Ceiling |
| TRL | Above L/R axis, rear | Ceiling |
| TRR | Above L/R axis, rear | Ceiling |

**Note:** Middle heights (TML/TMR) dropped from 9.4.6 to 9.4.4. At 25' room depth, 4 height channels (front + rear pairs) provide excellent Atmos coverage with good separation.

### Speaker Models

| Application | Model | Qty | Sensitivity | Impedance | Unit Cost | Total |
|-------------|-------|-----|-------------|-----------|-----------|-------|
| LCR | DIYSG Titan-815LX | 3 | 99 dB | 6Ω (4.2Ω min) | ~$1,600 | $4,800 |
| Surr + Atmos + FW | DIYSG Volt-10 | 10 | 95 dB | 8Ω | $242 | $2,420 |
| Isolation | Sorbothane 50 duro | 12 | — | — | $7 | $84 |
| **Total** | | **13** | | | | **$7,304** |

⚠️ **Note:** Volt-10 sensitivity is **95 dB** per DIYSG spec (v1 incorrectly listed 98 dB).

### Why 9.4.4 with Front Wides

The X6800H provides 13.4ch processing and 11 internal amplifier channels. This design uses all 13 processing channels with external amplification for LCR + front wides:

1. Front wides improve lateral fill in a 14' room where side walls are close
2. 9 bed channels maximize horizontal envelopment
3. 4 height channels provide excellent overhead Atmos coverage for 25' depth
4. Only 10× Volt-10 needed ($2,420) vs 12 in previous 9.4.6 config

---

## Amplifier Matching

### Target Level: -10 dB Reference (95 dB)

Same target as Rev 7.0 reference. Speaker amplification is split between the ATI AT525NC (LCR + front wides via pre-outs) and X6800H internal amps (surrounds + heights).

### LCR + Front Wide Channels — ATI AT525NC (via X6800H pre-outs)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Amplifier | ATI AT525NC (5ch × 200W NCore) | Already owned |
| Channels | L, C, R, FWL, FWR | 5 of 5 channels used |
| Power @ 6Ω (LCR) | ~300W | NCore into 6Ω |
| Power @ 8Ω (FW) | ~200W | NCore rated |
| SPL @ 1m (LCR) | ~124 dB | 99 dB + 25 dB |
| SPL @ Row 1 (10.5 ft from screen) | ~108 dB | After distance losses |
| SPL @ Row 2 (15 ft from screen) | ~104 dB | After distance losses |
| vs -10 dB Target (95 dB) | **+9 to +13 dB** | Excellent headroom |

### Surround/Height Channels — X6800H Internal Amps (8 channels)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Amplifier | X6800H internal (140W × 11 @ 8Ω rated) | 8 of 11 channels used |
| Channels | SL, SR, SBL, SBR, TFL, TFR, TRL, TRR | |
| Power @ 8Ω | ~100-140W | All-channels to 2ch driven |
| SPL @ 1m | 117 dB | 95 dB + 22 dB |
| SPL @ ~7 ft (surrounds, 14' room width) | ~110 dB | 14' room = closer side walls |
| vs -10 dB Target (95 dB) | **+13 to +15 dB** | Substantial headroom |

**Key advantages:**
- ATI AT525NC provides premium NCore amplification for LCR at $0 additional cost (already owned)
- X6800H internal amps have 3 unused channels — growth path if needed
- 14' width means surrounds are ~7' from MLP, yielding 3-4 dB more headroom than the 16' reference room

---

## Subwoofer System

### Configuration

| Subsystem | Drivers | Enclosure | Location |
|-----------|---------|-----------|----------|
| Corner array | 8× UMII18-22 | 4× triangular floor-to-ceiling columns (2/corner) | All 4 corners |
| Nearfield *(deferred)* | 4× UMII18-22 | 2× dual-opposed sealed cabinets | Riser face (2) + sofa table (2) |
| **Total (initial)** | **8× UMII18-22** | | |
| **Total (with deferred)** | **12× UMII18-22** | | |

### System Metrics

| Metric | This Design | Reference | Delta |
|--------|-------------|-----------|-------|
| Total drivers (initial) | 8 | 16 | -8 |
| Total drivers (with deferred nearfield) | 12 | 16 | -4 |
| Room volume | 3,500 cu ft | 4,160 cu ft | -15.9% |
| Driver density | 3.43 per 1,000 cu ft | 3.85 per 1,000 cu ft | -11% |
| Room gain vs reference | +0.8 dB | baseline | +0.8 dB |
| Net SPL delta | ~-1.0 dB | baseline | Negligible |

The smaller room volume largely compensates for fewer drivers. Net bass performance is within ~1 dB of the reference design — essentially identical.

### Corner Sub Columns (Same as Reference)

- 4 triangular floor-to-ceiling columns, 2 drivers per column
- Sealed, 8-9 cu ft per driver
- 8Ω series wiring per column (dual 2Ω VCs in series = 4Ω per driver, 2 in series = 8Ω)
- Boundary loading: +11 dB corner gain + ~6 dB acoustic summing

### Nearfield Subs (Deferred — Add Post-Build If Needed)

- **Status:** Deferred to post-build validation. Space reserved. Add 4 drivers ($1,400) + cabinet ($200) + repurpose spare amp if chest-compression effect is missed after living with corner subs.
- **Riser face:** 2× UMII18-22, dual-opposed in riser structure
- **Sofa table:** 2× UMII18-22, dual-opposed in console table between rows
- Dual-opposed configuration cancels cabinet vibration
- Each pair wired parallel = 4Ω per ICEpower channel

### Estimated Performance

| Metric | Value | Notes |
|--------|-------|-------|
| Corner array @ 20Hz @ MLP | ~113 dB | With room gain + boundary loading |
| Nearfield @ 15Hz @ 15" *(deferred)* | ~115+ dB | Chest compression range |
| Bass extension (-3 dB) | ~15 Hz | Sealed + room gain |
| System headroom vs reference (105 dB) | +8 dB @ 20Hz | At MLP |

---

## Tactile Bass Shaker System

Carried over from reference design (omitted from v1 in error).

| Parameter | Value |
|-----------|-------|
| Model | Aura Pro AST-2B-4 |
| Quantity | 8 (1 per seat × 4 seats × 2 couches) |
| Amplifier | 1× ICEpower 1200AS2 |
| Bandwidth | 20-80 Hz (Fs = 40 Hz) |
| Purpose | Direct seat vibration — kick, punch, rumble |
| Unit cost | $70 |
| Total cost | $560 |
| Deferred | Can double to 2/seat (16 total) for +$560 if desired |

---

## Electronics & DSP

### Processor / Amplifier

| Spec | Value |
|------|-------|
| **Processor** | Denon AVR-X6800H |
| **MSRP** | ~$3,700 |
| **Processing** | 13.4 channels |
| **Internal amps** | 11 channels × 140W @ 8Ω (2ch driven) |
| **Configuration** | 9.4.4 Dolby Atmos |
| **Room correction** | Dirac Live Full + Bass Control + ART ($799 bundle) |
| **Sub outputs** | 4 independent |
| **Pre-outs** | 13.4ch (used: L/C/R/FWL/FWR to ATI AT525NC) |
| **Location** | Equipment room (gym-side access) |
| | |
| **External amp** | ATI AT525NC (5ch × 200W NCore) |
| **ATI assignment** | L, C, R, FWL, FWR (via X6800H pre-outs) |
| **ATI status** | Already owned — $0 additional cost |
| | |
| **Backup amp** | Denon X4700 (spare, 9×125W) |
| **Backup status** | Already owned — available if needed |

### Why X6800H Over AVR-A1H

| Factor | X6800H | A1H | Winner |
|--------|--------|-----|--------|
| Cost | ~$3,700 | ~$6,500 | X6800H (-$2,800) |
| Processing | 13.4ch (9.4.4) | 15.4ch (9.4.6) | A1H (but 9.4.4 sufficient) |
| Internal amps | 11 × 140W | 15 × 150W | A1H (but ATI covers LCR) |
| LCR amplification | ATI NCore 200W (superior) | Internal 150W | X6800H + ATI |
| Sub outputs | 4 independent | 4 independent | Tie |
| Dirac ART | Yes (license) | Yes (license) | Tie |
| Pre-outs | 13.4ch | 17.4ch | A1H (unused capacity) |
| Net cost (incl. Dirac) | $4,499 | $7,299 | **X6800H (-$2,800)** |

**Key insight:** The X6800H + ATI AT525NC combo provides *better* LCR amplification (NCore 200W vs A1H internal 150W) at $2,800 less cost, at the expense of 2 height channels (middle pair). The 25' depth actually benefits from middle heights more than a 22' room would, but 4 heights still provide excellent Atmos coverage and the $2,800 savings is significant.

### Subwoofer Amplification

| Unit | Assignment | Load | Power/Ch |
|------|-----------|------|----------|
| ICEpower 1200AS2 #1 | Corner FL (top + bottom drivers) | 4Ω each | 1,200W |
| ICEpower 1200AS2 #2 | Corner FR (top + bottom drivers) | 4Ω each | 1,200W |
| ICEpower 1200AS2 #3 | Corner RL (top + bottom drivers) | 4Ω each | 1,200W |
| ICEpower 1200AS2 #4 | Corner RR (top + bottom drivers) | 4Ω each | 1,200W |
| Behringer NX6000D | Tactile (bass shakers) | varies | ~850W |
| **Total** | **4× 1200AS2 + 1× NX6000D** (8 sub channels + 2 tactile) | | |

**Driver wiring:** Each driver's dual 2Ω voice coils wired in series = 4Ω per driver. Individual amp channel per driver (no series pairs). Amp at 58% utilization at driver Xmax (700W @ 20Hz) — driver limits before amp, correct engineering order.

All 4 ICEpower modules in a single Bud CH-14404 2U rack chassis in equipment closet. Fanless. 240V native (single 20A/240V circuit). NX6000D (existing spare) on 120V circuit for tactile.

### Bass Management DSP

| Component | Function |
|-----------|----------|
| 2× ADAU1701 (APM2) | 4-in/8-out sub/tactile DSP — HPF to DC (5 Hz), PEQ ×10/ch, gain, mono summing |
| 4× PCM5102 DAC | External I2S DAC (2.1 Vrms), bypasses APM2 internal DAC |
| 8× THAT1646 | Balanced line drivers (3.54 Vrms differential → 620W/ch from ICEpower) |
| ICP5 programmer switch | SPST toggle on ribbon cable — PROGRAM/RUN mode selector |

The ADAU1701 eliminates the DSP-408's 20Hz HPF floor and the need for a separate miniDSP for sub-20Hz processing. Uses 30% of instruction budget per board. Automated calibration via `tools/dsp/` Python + REW + SigmaStudio COM pipeline. Full details: POR/15_DSP_Subwoofer_Processing.md.

### Signal Flow

```
Sources → Denon X6800H (Dirac ART processing, 13.4ch)
              ↓                    ↓                    ↓
    Pre-Outs (5ch)        Speaker Outputs (8ch)   4× Sub Pre-Outs
         ↓                 direct to speakers            ↓
    ATI AT525NC                    ↓              2× ADAU1701 (APM2)
    (5ch NCore)           ┌────────┼────────┐    + PCM5102 + THAT1646
         ↓                ↓        ↓        ↓           ↓
    ┌────┼────┐         Surr(4)  Heights(4)  ↓    ┌──────┼──────┐
    ↓    ↓    ↓          Volt-10  Volt-10   Corner       Shakers
   LCR   FW                                Subs
  Titan  Volt-10                           (1200AS2      (NX6000D
 -815LX                                    #1-4)         spare)
                                             ↓              ↓
                                          8 drvrs        8 shkrs
                                          (4Ω each)     (owned)
```

---

## Equipment Room

| Spec | Value |
|------|-------|
| Location | Northeast corner (4' × 6' closet) |
| Dimensions | 4' × 6' (24 sq ft) |
| Access | Door from entry vestibule (not from theater) |
| Contains | X6800H, ATI AT525NC, 4× ICEpower 1200AS2 (1 rack chassis), NX6000D (tactile), 2× ADAU1701 (APM2) + balanced output, UPS, network switch |
| Cooling | Ventilation grille to theater conditioned space, or dedicated exhaust |
| Heat load | ~750W idle (all equipment) |

### Benefits

- Heat-generating equipment outside theater listening area
- NX6000D fan noise (17 dB modded) isolated from theater by closet wall
- Cable runs through shared wall to theater (short)
- Service access via vestibule — no need to enter theater
- Equipment closet at rear of theater (near entry) — convenient for source connections

---

## HVAC

**Current:** None — must be added.

| System | Recommendation |
|--------|----------------|
| Type | Ductless mini-split heat pump |
| Brand | Mitsubishi/Fujitsu (quiet operation) |
| Zones | 2 indoor heads: theater + gym (equipment room shares gym zone) |
| Theater head | 9,000 BTU — room volume + equipment heat |
| Gym head | 12,000 BTU — higher activity heat load |
| Outdoor unit | Single multi-zone condenser |
| Estimated cost | $4,000-6,000 installed |

Theater head should be ceiling-cassette type for minimal visual impact and quiet operation (<20 dB).

---

## Electrical

### Existing

- 100A subpanel (already in building)
- Standard lighting circuits

### Required Additions

| Circuit | Rating | Load |
|---------|--------|------|
| Circuit A — Sub amps | 20A / 240V | 4× ICEpower 1200AS2 (single circuit, 140W idle) |
| Circuit B — Tactile amp | 20A / 120V | NX6000D (existing spare, ~30W idle) |
| Circuit C — Processor + Amps + DSP | 20A / 120V | X6800H, ATI AT525NC, ADAU1452, sources |
| Circuit D — Projector | 20A / 120V | Projector (dedicated, ceiling) |
| Circuit E — Mini-split | 30A / 240V | HVAC outdoor unit |
| Circuit F — WC + Gym | 20A / 120V | GFI outlets, lighting |

100A subpanel has ample capacity for all circuits. ICEpower 1200AS2 runs natively on 240V (single circuit for all sub amps). One 20A/120V circuit freed vs previous NX6000D plan.

---

## Labor & Permits

**All work is owner DIY.** No contractor labor is budgeted. All line items below are materials, equipment, and permit fees only.

**Location:** Central NC (Lee County)

### NC Homeowner Permits

All work is fully permitted. North Carolina allows homeowners to perform their own work on owner-occupied property for all trades:

| Trade | Permit Required | Homeowner DIY | Notes |
|-------|----------------|---------------|-------|
| Electrical | Yes | Yes | Adding circuits from existing 100A panel |
| Plumbing | Yes | Yes | Water + sewer run to detached building |
| Mechanical (HVAC) | Yes | Yes | Pre-charged mini-split (MrCool DIY or similar) avoids EPA 608 requirement |
| Building (structural) | Yes | Yes | Change of use: garage → living space |
| **Total permits** | **3-4 separate** | | Budget: ~$1,000 |

All work subject to Lee County inspection at each stage (rough-in, final).

---

## Budget — Phase 1: Building Prep

Building prep converts the detached garage into three finished zones (theater, gym, WC) with all required infrastructure. This phase stands alone as a property improvement regardless of theater equipment.

### Openings

| # | Item | Cost |
|---|------|------|
| 1 | Left garage door removal + framing | $800 |
| 2 | Window purchase + install (left opening) | $800 |
| 3 | Left opening insulation + exterior finish | $400 |
| 4 | Right garage door removal + framing | $800 |
| 5 | Patio door purchase | $1,000 |
| 6 | Patio door install + exterior finish | $700 |
| | **Openings subtotal** | **$4,500** |

### Partition Walls & Rooms

| # | Item | Cost |
|---|------|------|
| 7 | Partition wall framing (lumber, 2×6) | $500 |
| 8 | Partition wall insulation + drywall | $600 |
| 9 | Partition wall finish (tape, mud, paint) | $400 |
| 10 | Equipment closet framing + door (4×6, NE corner) | $500 |
| 11 | Equipment closet finish (drywall, ventilation) | $500 |
| 12 | Light-lock vestibule (framing + doors) | $1,000 |
| | **Partition subtotal** | **$3,500** |

### WC (Half Bath)

| # | Item | Cost |
|---|------|------|
| 13 | Plumbing: trench + water supply to building | $1,000 |
| 14 | Plumbing: drain/sewer run to building | $1,000 |
| 15 | Plumbing: rough-in inside WC | $1,000 |
| 16 | Toilet | $300 |
| 17 | Vanity + sink + faucet | $400 |
| 18 | Tile floor + exhaust fan + finish | $800 |
| | **WC subtotal** | **$4,500** |

### HVAC (Theater Only — Gym Deferred)

| # | Item | Cost |
|---|------|------|
| 19 | MrCool DIY 12K system (condenser + head + lineset + Quick Connect) | $2,359 |
| 20 | HVAC hardware (disconnect, breaker, wire, raceway, condensate) | $200 |
| | **HVAC subtotal** | **$2,559** |

See `POR/16_HVAC_Plan_Theater.md` for full HVAC specification. Gym HVAC deferred — add second independent MrCool DIY 12K unit (~$2,550) later if needed.

### Electrical

| # | Item | Cost |
|---|------|------|
| 21 | Circuit A — sub amps 1 (20A/120V) | $400 |
| 22 | Circuit B — sub amps 2 (20A/120V) | $400 |
| 23 | Circuit C — Processor/amps/DSP (20A/120V) | $400 |
| 24 | Circuit D — projector, ceiling run (20A/120V) | $400 |
| 25 | Circuit F — WC + gym GFI (20A/120V) | $400 |
| | **Electrical subtotal** | **$2,000** |

### Flooring

| # | Item | Cost |
|---|------|------|
| 26 | Theater carpet + pad (350 sq ft) | $1,000 |
| 27 | Gym rubber tile flooring (220 sq ft) | $500 |
| | **Flooring subtotal** | **$1,500** |

### Finish & Permits

| # | Item | Cost |
|---|------|------|
| 28 | Paint (all zones) | $400 |
| 29 | Trim + baseboards | $400 |
| 30 | Interior doors (3: theater, equip room, WC) | $500 |
| 31 | Lighting (theater + gym + WC) | $700 |
| 32 | Permits (3-4 trades) | $1,000 |
| 33 | Architectural plans | $1,000 |
| | **Finish & permits subtotal** | **$4,000** |

### Phase 1 Total

| Category | Cost |
|----------|------|
| Openings | $4,500 |
| Partition walls & rooms | $3,500 |
| WC (half bath) | $4,500 |
| HVAC | $2,559 |
| Electrical | $2,000 |
| Flooring | $1,500 |
| Finish & permits | $4,000 |
| **Phase 1 — Building Prep Total** | **$22,559** |

---

## Budget — Phase 2: Home Theater

Theater construction and A/V equipment. Assumes Phase 1 (building prep) is complete — the room is finished, conditioned, and has dedicated electrical circuits.

### Already Owned Inventory

| Item | Value | Status |
|------|-------|--------|
| 3× DIYSG Titan-815LX (LCR) | $4,800 | Owned |
| ATI AT525NC (5ch × 200W NCore) | $2,500 | Owned |
| 2× Dayton UMII18-22 (sub drivers) | $700 | Owned |
| Acoustic treatment materials (absorption, diffusion, bass traps) | $4,250 | Owned |
| Denon X4700 (spare, 9×125W — backup amp) | $1,200 | Owned |
| **Total owned** | **$13,450** | |

### Projector & Screen

| # | Item | Cost |
|---|------|------|
| 37 | JVC DLA-NZ500 (native 4K D-ILA, laser, 40,000:1 CR) | $5,999 |
| 38 | 170" 16:9 AT screen (frame + fabric) | $1,000 |
| 39 | AT screen shipping + mounting hardware | $500 |
| 40 | Projector ceiling mount | $100 |
| | **Projector & screen subtotal** | **$7,599** |

### Processor & Amplification

| # | Item | Cost |
|---|------|------|
| 41 | Denon AVR-X6800H | $3,700 |
| 42 | Dirac Live Full Bandwidth license | $349 |
| 43 | Dirac Live Bass Control license | $299 |
| 44 | Dirac Live ART license | $299 |
| 45 | 2× ADAU1701 (APM2) + Sonic Imagery 898B balanced output | $525 |
| — | ATI AT525NC (LCR + FW amp) | $0 (owned) |
| | **Processor & DSP subtotal** | **$5,172** |

### Speakers (10× Volt-10 — LCR already owned)

| # | Item | Cost |
|---|------|------|
| 47 | Volt-10 × 2 (FWL + FWR) | $484 |
| 48 | Volt-10 × 2 (SL + SR) | $484 |
| 49 | Volt-10 × 2 (SBL + SBR) | $484 |
| 50 | Volt-10 × 2 (TFL + TFR) | $484 |
| 51 | Volt-10 × 2 (TRL + TRR) | $484 |
| 52 | Sorbothane isolation pucks × 12 | $84 |
| | **Speakers subtotal** | **$2,504** |

### Subwoofer Drivers (6 to buy — 2 already owned, 4 nearfield deferred)

| # | Item | Cost |
|---|------|------|
| 54-59 | UMII18-22 × 6 (@ $350 each) | $2,100 |
| | **Sub drivers subtotal** | **$2,100** |

*Deferred: 4× UMII18-22 nearfield drivers ($1,400) — add post-build if needed.*

### Subwoofer Amplifiers

| # | Item | Cost |
|---|------|------|
| 64 | ICEpower 1200AS2 #1 (corner FL, 2 drivers @ 4Ω) | $373 |
| 65 | ICEpower 1200AS2 #2 (corner FR, 2 drivers @ 4Ω) | $373 |
| 66 | ICEpower 1200AS2 #3 (corner RL, 2 drivers @ 4Ω) | $373 |
| 67 | ICEpower 1200AS2 #4 (corner RR, 2 drivers @ 4Ω) | $373 |
| 68 | Bud CH-14404 rack chassis (all 4 modules) | $100 |
| | Tactile: NX6000D (existing spare, owned) | $0 |
| | **Sub amps subtotal** | **$1,592** |

### Subwoofer Enclosures (DIY materials)

| # | Item | Cost |
|---|------|------|
| 79 | Corner column #1 (plywood, bracing, sealant, OC 703) | $350 |
| 80 | Corner column #2 | $350 |
| 81 | Corner column #3 | $350 |
| 82 | Corner column #4 | $350 |
| ~~83~~ | ~~Nearfield cabinet — riser (deferred)~~ | ~~$200~~ |
| ~~84~~ | ~~Nearfield cabinet — sofa table (deferred)~~ | ~~$200~~ |
| | **Sub enclosures subtotal** | **$1,400** |

*Deferred: 2 nearfield enclosures ($400) — build post-validation.*

### Bass Shakers (Reduced: 8 shakers, 1 per seat)

| # | Item | Cost |
|---|------|------|
| 85 | Aura Pro AST-2B-4 × 4 (couch 1, 1/seat) | $280 |
| 86 | Aura Pro AST-2B-4 × 4 (couch 2, 1/seat) | $280 |
| 87 | Shaker wiring + connectors | $100 |
| | **Bass shakers subtotal** | **$660** |

*Deferred: Can double to 2/seat (16 total) for +$560 shakers + $100 wiring if desired.*

### Seating

| # | Item | Cost |
|---|------|------|
| 90 | Row 1 couch (4-seat) | $1,000 |
| 91 | Row 2 couch (4-seat) | $1,000 |
| | **Seating subtotal** | **$2,000** |

### Theater Construction (DIY materials)

| # | Item | Cost |
|---|------|------|
| 92 | Stage platform (lumber, CLD, hardware) | $540 |
| 93 | Riser frame sections (lumber, hardware) | $800 |
| 94 | Riser CLD decking | $500 |
| 95 | Riser carpet | $200 |
| 96 | Acoustic treatment installation (materials owned) | $0 |
| | **Theater construction subtotal** | **$2,040** |

### Infrastructure & Wiring

| # | Item | Cost |
|---|------|------|
| 97 | Equipment rack (open frame) | $550 |
| 98 | Speaker wire (500 ft, 12 AWG) | $150 |
| 99 | RCA/XLR signal cables | $100 |
| 100 | SpeakON connectors + cables | $100 |
| 101 | HDMI cables (source → AVR, AVR → projector) | $80 |
| 102 | Miscellaneous hardware, brackets, screws | $100 |
| | **Infrastructure subtotal** | **$1,080** |

### Phase 2 Summary

| Category | Cost |
|----------|------|
| Projector & screen | $7,599 |
| Processor & DSP | $5,172 |
| Speakers (10× Volt-10 + isolation) | $2,504 |
| Sub drivers (6× UMII18-22, 4 nearfield deferred) | $2,100 |
| Sub amps (4× ICEpower 1200AS2 + chassis) | $1,592 |
| Sub enclosures (4 columns, 2 nearfield deferred) | $1,400 |
| Bass shakers (8× Aura Pro + wiring, reduced from 16) | $660 |
| Seating (2 couches) | $2,000 |
| Theater construction (stage + riser) | $2,040 |
| Infrastructure & wiring | $1,080 |
| **Phase 2 — Home Theater Remaining Spend** | **$26,620** |
| **Phase 2 — Already Owned** | **$13,450** |
| **Phase 2 — Total System Value** | **$39,605** |

---

## Total Project Budget

| Phase | Remaining Spend | Already Owned | Total Value |
|-------|----------------|---------------|-------------|
| Phase 1 — Building Prep | $22,559 | — | $22,559 |
| Phase 2 — Home Theater | $26,155 | $13,450 | $39,605 |
| **Grand Total** | **$48,714** | **$13,450** | **$62,164** |

**Out-of-pocket: ~$48,700** for a fully converted detached building with gym, half bath, and reference-grade 9.4.4 Atmos theater.

Phase 1 (building prep) can proceed independently and adds property value regardless of Phase 2. The two phases can be separated by months or years if needed.

### Comparison to Reference Design

| | Reference (Rev 7.0) | Garage Conversion v3 | Delta |
|---|---------------------|---------------------|-------|
| Configuration | 9.4.6 (A1H, 15ch) | 9.4.4 (X6800H + ATI, 13ch) | -2 height ch |
| A/V full value | ~$72,000 | ~$39,600 | -$32,400 |
| A/V remaining spend | ~$58,550 (same owned items) | ~$26,200 | -$32,350 |
| Room construction | Not budgeted (new build) | ~$22,600 | +$22,600 |
| Bonus: gym + WC | No | Yes | Significant |
| **Total out-of-pocket** | **~$58,550 + room** | **~$48,700** | **Less + more** |

**Key insight:** The X6800H + ATI AT525NC combo saves $2,800 vs A1H while providing *better* LCR amplification (NCore 200W vs internal 150W). Combined with dropping 2 middle heights ($484 saved on Volt-10s), out-of-pocket drops to ~$48,700 (with nearfield subs and extra shakers deferred). The ATI was already owned from the current system — it's free to redeploy.

---

## Property Value Analysis

### Positive Factors

| Factor | Impact | Notes |
|--------|--------|-------|
| **No garage loss** | Critical | Attached 2-car garage remains — eliminates the #1 concern with garage conversions |
| **Added living space** | +$25-40K | ~667 sq ft of permitted, finished, conditioned space |
| **Added bathroom** | +$10-15K | Half bath in outbuilding — appraisers value this highly |
| **Multi-use space** | Broad appeal | Gym + theater + WC — not a single-purpose room |
| **Fully permitted** | Required | Counts toward home square footage for appraisal |
| **Separate structure** | Premium | Detached finished building is increasingly desirable (WFH, guest suite, studio) |
| **Existing infrastructure** | Cost savings | 100A electrical + internet already in place reduces conversion cost |
| **Reversibility** | Low risk | Future buyer could convert back or repurpose (home office, ADU, etc.) |

### Negative Factors

| Factor | Impact | Notes |
|--------|--------|-------|
| **A/V equipment depreciation** | High | Electronics have near-zero property value — personal property, not real estate |
| **Specialty room** | Moderate | Not all buyers want a theater — but the room itself has value regardless |
| **Detached garage loss** | Minor | Some buyers want workshop/storage space — mitigated by attached garage |
| **Conversion ROI** | 60-80% | Typical for garage conversions with permits |

### Estimated Property Value Impact

| Component | Out-of-Pocket | Added Value | ROI |
|-----------|---------------|-------------|-----|
| Phase 1 — Building prep | ~$22,600 | $20,000-35,000 | 88-155% |
| Phase 2 — Home theater (remaining spend) | ~$28,600 | $5,000-10,000 | 17-35% |
| **Total** | **~$51,200** | **$25,000-45,000** | **49-88%** |

### How to Think About It

The project has two distinct financial profiles:

1. **Phase 1 — Building prep (~$24K)** is a **real estate investment**. You're adding ~667 sq ft of permitted, conditioned living space with a bathroom to a detached building that already has electrical and internet. At $24K in materials (all DIY labor), this is one of the highest-ROI home improvements available — especially since no primary garage is lost. Expected return: 83-146% of cost.

2. **Phase 2 — Home theater (~$30K remaining spend)** is a **lifestyle purchase**. Electronics are personal property — a future buyer values the *room*, not the gear. However, at ~$29K with the JVC NZ500 and $13,450 already in hand, the hobby cost is very reasonable for a reference-grade 9.4.4 Atmos system.

**Bottom line:** Phase 1 more than pays for itself in property value. The ~$29K theater spend is the cost of the hobby, offset by ~$5-10K in theater-as-amenity value = **~$20-25K net cost of enjoyment**.

### Future Flexibility

If priorities change, the detached building supports many alternative uses without major renovation:
- Home office / creative studio
- Guest suite (add kitchenette → ADU potential)
- Rental income (check local ADU regulations)
- Workshop / maker space (keep gym, convert theater)

The theater partition wall, acoustic treatment, and riser are removable — the building reverts to open space easily.

---

## Performance Targets

| Metric | Target | Notes |
|--------|--------|-------|
| Reference level | -10 dB (95 dB at MLP) | All channels |
| LCR headroom | +9 to +13 dB above target | |
| Surround/Atmos headroom | +13 to +15 dB above target | 14' width = closer side walls |
| Bass extension (-3 dB) | 15 Hz | Sealed + room gain + nearfield |
| Bass headroom @ 20 Hz | +8 dB above reference | At MLP |
| Row 1 viewing angle | 56° | Immersive (IMAX-like) |
| Row 2 viewing angle | 41° | THX Ideal |

### Performance vs Reference Design

| Metric | Reference | Garage v3 | Assessment |
|--------|-----------|-----------|------------|
| Speaker headroom | +7-12 dB | +9-15 dB | **Better** (14' width + NCore LCR) |
| LCR amplification | A1H internal 150W | ATI NCore 200W | **Better** |
| Bass SPL @ 20 Hz | ~113 dB | ~113 dB | **Equal** (room gain compensates) |
| Nearfield count | 8 drivers | 0 initial (4 deferred) | Deferred — add post-build |
| Bed channels | 7 (no front wides) | 9 (with front wides) | **Better** |
| Height channels | 6 | 4 | Reduced (adequate at 25' depth) |
| Atmos config | 7.4.6 (A1H) | 9.4.4 (X6800H + ATI) | Trade-off: more bed, fewer height |
| Viewing angle (Row 2) | ~39° (170" 2.35:1) | ~45° (170" 16:9) | **Option D** |
| Tactile (shakers) | 16× Aura Pro | 8× Aura Pro (1/seat) | Reduced — can double later |

---

## Construction Sequence

### Phase 1: Structural Conversion (~4-6 weeks)
1. Permits and architectural plans
2. Garage door removal, framing window and patio door openings
3. Window and patio door installation
4. Partition wall framing (theater/gym/equipment room/WC)
5. Plumbing rough-in (water supply + drain to building)
6. Electrical rough-in (dedicated circuits)
7. HVAC installation (mini-split)
8. Drywall, paint, trim
9. Flooring (gym rubber, theater carpet, WC tile)
10. WC fixtures
11. Inspection / final permit

### Phase 2: Theater Build (~6-8 weeks, overlaps Phase 1)
1. Stage platform construction
2. Corner subwoofer column construction (workshop)
3. Riser platform construction (workshop)
4. Transport and install stage, subs, riser
5. ~~Nearfield sub integration~~ *(deferred)*
6. AT screen and false wall
7. Speaker installation (all 13 channels)
8. Equipment room rack and wiring
9. Bass shaker installation in couches (8 shakers, 1/seat)

### Phase 3: Calibration (~1-2 weeks)
1. Dirac Live measurements
2. Dirac Bass Control optimization
3. Dirac ART configuration
4. DSP-408 + miniDSP sub processing
5. Level matching and verification
6. Subjective evaluation and fine-tuning

**Total project duration:** ~10-14 weeks (structural + theater + calibration)

---

## Option D: North-South Partition — Wider Theater + Proper Gym (Under Consideration)

**Status:** OPTION — challenging the POR. Offers a larger theater room closer to the reference design with a properly functional gym.

An alternative partition orientation: instead of an east-west wall giving a shallow 14'×25' theater and a cramped 8'×26' gym, run the partition **north-south** between the two garage door openings. The theater takes the east side (17'×23'), the gym takes the west side (12'×23') with both garage door openings for natural light.

### Concept

- **North-south partition** at ~12' from the west wall, running between the two garage door openings
- **Theater (east side):** 17'×23'×10' — screen on north wall, entry via existing 36" door on east wall
- **Gym (west side):** 12'×23' — both converted garage door openings provide natural light and ventilation
- **Equipment closet:** 4'×4' in NE corner of gym, backed against partition wall + north wall — cables pass through partition directly to screen/stage
- **No vestibule or light-lock** — 36" door opens directly into theater
- **No WC** — walk to house (can add later on gym side)
- **Single partition wall** — simplest possible construction
- **Left garage door (gym side):** Stays as-is — working garage door for ventilation and access
- **Right garage door (theater side):** Removed, opening sealed (panel/brick to match exterior)
- **Functional, not cosmetic** — gym side stays raw (concrete slab, wood paneling, no finish work)

### Layout

```
        29' (east-west)
    ←————————————————————————————→
    +———————————+————————————————————————+  ↑
    |       ┌──┐|  SCREEN 170" 16:9      |  |
    |       |Eq||  ■■■■■■■■■■■■■        |  |
    |       |4×4|  Stage                |  |
    |       └──┘|                        |  |
    |           |   Theater              |  23'
    |   Gym     |   17' × 23'            |  |
    |  12'×23'  |                        |  |
    |           |         Row 1          |  |
    |           |         Row 2          |  |
    | windows + |                    [36"|  |
    | patio drs |                    door]  |
    +———————————+————————————————————————+  ↓
      South wall (garage door openings converted)
```

**Screen on north wall (17' wide).** Equipment closet in NE corner of gym — accessed from gym, cables pass through partition to stage. 36" personnel door on east wall is the theater entry.

### Theater Room: 17'×23'×10'

| Parameter | Option D | POR (14'×25') | Reference (16'×26') |
|-----------|---------|---------------|---------------------|
| Width | **17 feet** | 14 feet | 16 feet |
| Depth | **23 feet** | 25 feet | 26 feet |
| Height | 10 feet | 10 feet | 10 feet |
| Area | **391 sq ft** | 350 sq ft | 416 sq ft |
| Volume | **3,910 cu ft** | 3,500 cu ft | 4,160 cu ft |
| Room ratio (H:W:D) | **1 : 1.7 : 2.3** | 1 : 1.4 : 2.5 | 1 : 1.6 : 2.6 |
| Room gain vs reference | +0.3 dB | +0.8 dB | baseline |

**Closer to the reference design** than the POR layout in width, volume, and room ratio.

### Screen Fit

- 170" 16:9 screen width: 12.3 feet (148"), height: 6.9 feet (83")
- Screen wall (north): 17 feet
- Clearance per side: **2.3 feet (28")** — room for corner treatment
- 2.35:1 scope movies letterbox within 16:9 frame (~161" diagonal image)
- 16:9 content (TV, gaming) uses full 170" screen
- Titan-815LX L/R at ~25° from MLP: speaker span ~10', well within screen width

### Seating Geometry

Screen on north wall. Seating faces north.

| Row | From North Wall | From Screen | Viewing Angle (170" 16:9) | Assessment |
|-----|----------------|-------------|---------------------|------------|
| **Row 1 (MLP)** | 14.0' | 10.5' | **61°** | IMAX-class |
| **Row 2** | 18.5' | 15.0' | **45°** | THX Ideal+ |

| Dimension | Value |
|-----------|-------|
| Stage depth | 3' |
| Screen surface | 3.5' from north wall |
| Row spacing (MLP to MLP) | 4.5' |
| Riser front edge | 16.0' from north wall |
| Riser depth | 4.5' |
| Space behind Row 2 | **1.0'** (tight — rear wall is south exterior) |

**Note:** 23' depth is 2' shorter than the POR's 25'. Row 2 rear clearance drops to ~1'. Adequate for seating but minimal space for rear wall acoustic treatment. Consider reducing stage depth to 2.5' or row spacing to 4' to recover clearance.

### Speaker Configuration: 9.4.4 Dolby Atmos

Same 13-channel configuration as POR. The wider room improves lateral speaker placement.

**Bed Layer (9 channels)** — Screen on north wall. "Left" = west (partition wall). "Rear" = south wall.

| Speaker | Position | Angle from MLP | Mounting |
|---------|----------|----------------|----------|
| L | Stage (north wall), behind AT screen | ~25° | On stage deck |
| C | Stage (north wall), behind AT screen | 0° | On stage deck |
| R | Stage (north wall), behind AT screen | ~25° | On stage deck |
| FWL | West wall (partition), between screen and MLP | ~55° | Wall mount |
| FWR | East wall, between screen and MLP | ~55° | Wall mount |
| SL | West wall (partition), beside MLP | ~90° | Wall mount |
| SR | East wall, beside MLP | ~90° | Wall mount |
| SBL | South wall (rear) | ~145° | Wall mount |
| SBR | South wall (rear) | ~145° | Wall mount |

**Height Layer (4 channels)** — Same as POR: TFL, TFR, TRL, TRR ceiling-mounted.

**Key advantage:** At 17' width, surrounds are ~8.5' from MLP (vs ~7' in POR's 14' room). This is closer to the reference design's geometry and provides better spatial imaging.

### Subwoofer System

12-driver configuration using stacked rectangular cabinets flanking the screen and rear walls, replacing the POR's triangular floor-to-ceiling corner columns.

#### Corner Subs (8 drivers in 4 cabinets)

| Position | Drivers | Cabinet | Boundary loading |
|----------|---------|---------|-----------------|
| Screen left (NW corner) | 2× UMII18-22 stacked | ~20"W × 20"D × 72"H sealed | Floor + north wall + partition wall |
| Screen right (NE corner) | 2× UMII18-22 stacked | same | Floor + north wall + east wall |
| Rear left (SW corner) | 2× UMII18-22 stacked | same | Floor + south wall + partition wall |
| Rear right (SE corner) | 2× UMII18-22 stacked | same | Floor + south wall + east wall |

Each cabinet: ~8.5 cu ft per driver (17 cu ft total), sealed, 8Ω series wiring.

**Front pair** sits in the 2.3' clearance on each side of the 170" screen. The cabinets serve as structural bookends for the screen wall — the AT screen frame mounts across the top of the sub cabinets (or to a simple header spanning between them). The stage platform spans between the front pair. No separate false wall framing required.

**Rear pair** sits in the corners behind Row 2. The 20" cabinet depth pushes Row 2 forward ~8" — negligible impact on seating geometry.

**Advantages over POR triangular columns:**
- Simple rectangular plywood boxes vs custom triangular geometry
- 6' tall vs 10' floor-to-ceiling — easier to build, move, and place
- Front pair doubles as screen wall structure — eliminates false wall framing
- Stage deck simply spans between front cabinets
- Front pair hidden behind AT screen edges

#### Nearfield Subs (4 drivers) — Deferred

**Status:** Deferred to post-build validation. Space behind Row 1 reserved. Add drivers + cabinet + repurpose spare ICEpower amp if needed.

- **Behind Row 1:** 4× UMII18-22 in a single full-width cabinet (8' wide × 12.5" deep × ~20" tall)
- Forward-facing — drivers fire toward Row 1 couch back
- Row 1 couch backs directly against the cabinet — full-body nearfield bass + tactile effect
- Cabinet depth only 12.5" (11" driver depth + 1.5" rear wall) — not dual-opposed, saving ~12" of depth
- Sits in front of riser platform

**Initial: 8× UMII18-22** (8 corner). **With deferred nearfield: 12×** (8 corner + 4 nearfield).

### Equipment Closet

| Spec | Value |
|------|-------|
| Location | NE corner of gym (backed against partition + north wall) |
| Dimensions | 4' × 4' (16 sq ft) |
| Access | From gym side |
| Contains | X6800H, ATI AT525NC, 4× ICEpower 1200AS2 (1 rack chassis), NX6000D (tactile), ADAU1452, UPS, network |
| Cable routing | Through partition wall directly to screen/stage area |
| Cooling | Ventilation to gym space (uncritical — gym is conditioned) |

**Advantages over POR equipment closet:**
- Fan noise and heat completely isolated from theater by partition wall
- Service access from gym — no entering theater during a movie
- Cable pass-throughs are inches from LCR and sub DSP
- Simpler construction — just a 4'×4' framed closet in the corner

### Gym: 12'×23' (276 sq ft)

| Parameter | Option D | POR | Assessment |
|-----------|---------|-----|------------|
| Dimensions | **12' × 23'** | 8' × 26' | Wider, more functional |
| Area | **276 sq ft** | 208 sq ft | +33% |
| Depth for equipment | **12'** | 8' | Power rack + working space |
| Natural light | Both garage door openings | Both openings | Same |
| Equipment closet impact | -16 sq ft (NE corner) | N/A | 260 sq ft usable — still excellent |

**Equipment fit at 12' depth:**
- Jacked Up Power Rack: 4' deep + 8' working space in front — deadlifts, bench press, all barbell work
- Treadmill: oriented along 23' length — fits easily
- Free weights: spread along walls
- All equipment oriented longways along 23' — the key insight that makes this work

### Partition Wall

| Spec | Value |
|------|-------|
| Orientation | North-south, at ~12' from west wall |
| Position | Between the two garage door openings on the south wall |
| Construction | 2×6 stud wall, floor to ceiling |
| Insulation | R-19 batts (2×6 cavity) |
| Vapor barrier | 6-mil poly on theater (conditioned) side |
| Theater face | Drywall, taped, finished, painted |
| Gym face | Drywall, finished |
| Length | 23' (full north-south span of building) |

### HVAC

| System | Recommendation |
|--------|----------------|
| Type | Ductless mini-split heat pump |
| Unit | MrCool DIY 5th Gen 12K BTU, 230V (Quick Connect, no contractor) |
| Zones | 1 indoor head (theater only) |
| Theater head | Wall-mount on partition wall, 7–8' high, 2–4' from screen wall, painted flat black |
| Noise | 23.5 dB(A) silent mode — at or below room ambient |
| Lineset | Outdoor condenser (north wall) → gym → partition wall → head unit (~10–14' run) |
| Condensate | Gravity drain through partition wall to gym side |
| Gym | Deferred — garage door ventilation. Add independent MrCool 12K later (~$2,550) |
| Outdoor unit | Single-zone condenser (north exterior wall) |
| Cost | ~$2,550 total (system $2,359 + hardware ~$200) |
| Spec doc | `POR/16_HVAC_Plan_Theater.md` |

### Option D Budget — Phase 1: Building Prep

| # | Item | Cost |
|---|------|------|
| 1 | Right garage door (theater side) removal + panel/brick to match exterior | $800 |
| 2 | N-S partition wall framing (2×6, 23' run) | $400 |
| 3 | Partition wall insulation (R-19) + vapor barrier | $500 |
| 4 | Partition wall drywall + finish (both sides) | $600 |
| 5 | Equipment closet framing + door (4×4, gym NE corner) | $400 |
| 6 | Equipment closet finish + cable pass-throughs | $300 |
| 7 | MrCool DIY 12K system (condenser + head + lineset + Quick Connect) | $2,359 |
| 8 | HVAC hardware (disconnect, breaker, wire, raceway, condensate) | $200 |
| 9 | 240V circuit for condenser | $600 |
| 10 | Circuit A — sub amps (20A/240V, single circuit) | $400 |
| 11 | Circuit C — processor/amps/DSP (20A/120V) | $400 |
| 12 | Circuit D — projector ceiling run (20A/120V) | $400 |
| 13 | Circuit F — gym (20A/120V) | $400 |
| 14 | Theater carpet + pad (391 sq ft) | $1,000 |
| 15 | Paint (theater + equip closet) | $200 |
| 16 | Trim + baseboards (theater only) | $200 |
| 17 | Interior door (equipment closet) | $200 |
| 18 | Lighting (theater + gym) | $700 |
| 19 | Permits (building + electrical + HVAC) | $800 |
| 20 | Plans (simplified scope) | $400 |
| | **Phase 1 — Building Prep Total** | **$11,059** |

**Notes:**
- **Left garage door (gym side):** Remains as-is — working garage door. Provides ventilation, equipment access, and natural light for gym. No conversion work.
- **Right garage door (theater side):** Removed, opening paneled or bricked to match existing exterior. Structural + weather + thermal seal.
- **Gym finish:** Functional, not cosmetic. Concrete slab stays. Existing wood paneling stays. No rubber flooring, no paint, no trim.
- **Gym HVAC:** Deferred. Garage door + fans for ventilation. If HVAC is needed later, add a second independent MrCool DIY 12K unit (~$2,550). Theater and gym units are fully independent (separate condensers, separate circuits).
- **Theater HVAC head:** MrCool DIY 12K wall-mount on partition wall, 7–8' high, painted flat black. Lineset routes through partition wall to gym, then to outdoor condenser on north wall.

### Option D Grand Total

| Phase | Remaining Spend | Already Owned | Total Value |
|-------|----------------|---------------|-------------|
| Phase 1 — Building Prep | $11,059 | — | $11,059 |
| Phase 2 — Home Theater | $25,565 | $13,450 | $39,015 |
| **Grand Total** | **$36,624** | **$13,450** | **$50,074** |

### Option D vs POR

| Factor | Option D (N-S Partition) | POR (E-W Partition) | Winner |
|--------|------------------------|--------------------|---------|
| Theater dimensions | 17'×23' (3,910 cu ft) | 14'×25' (3,500 cu ft) | **Option D** (+12%) |
| Closeness to reference | 1:1.7:2.3 ratio | 1:1.4:2.5 ratio | **Option D** (ref is 1:1.6:2.6) |
| Screen wall width | 17' | 14' | **Option D** (+3' for LCR) |
| Theater depth | 23' | 25' | POR (+2' rear clearance) |
| Gym dimensions | 12'×23' (276 sq ft) | 8'×26' (208 sq ft) | **Option D** (+33%) |
| Gym functionality | Power rack + full working space | Rack fits but tight | **Option D** |
| Equipment noise isolation | Closet on gym side of partition | Closet in theater via vestibule | **Option D** |
| Equipment access | From gym (no theater disruption) | Via vestibule (no theater disruption) | Tie |
| WC | No | Yes | POR |
| Light control | Door closed | Vestibule light-lock (2 doors) | Tie (door is closed during use) |
| Internal walls | 1 partition + closet + baffle | Partition + closet + vestibule + WC | **Option D** (simpler) |
| Construction complexity | Simple — one long wall | Multiple rooms, plumbing | **Option D** |
| Building prep cost | $11,059 | $22,559 | **Option D** (-$11,500) |
| **Total out-of-pocket** | **$36,624** | **$48,714** | **Option D** (-$12,090) |

### What You Gain Over POR

- **$12,100 less out-of-pocket** ($39.1K vs $51.2K)
- **Larger theater** — 17'×23' vs 14'×25', closer to reference design in every dimension
- **Wider screen wall** — 17' vs 14', more room for LCR spread behind AT screen
- **Functional gym** — 12' depth fits power rack properly (vs 8' barely adequate)
- **Equipment isolated from theater** — closet on gym side, fan noise behind partition wall
- **Simpler construction** — one partition wall, no vestibule, no WC plumbing, fewer doors
- **Better room ratio** — 1:1.7:2.3 vs 1:1.4:2.5 (reference is 1:1.6:2.6)

### What You Give Up

- **No WC** — walk to house (can add to gym side later)
- **2' less depth** — 23' vs 25', tighter rear clearance behind Row 2
- **No light-lock vestibule** — door is closed during use
- **Less property value add** — no bathroom, simpler conversion
- **Partition wall is theater side wall** — FWL and SL mount on partition; must be built solid for speaker mounting and acoustic isolation from gym

### Risks

| Risk | Severity | Notes |
|------|----------|-------|
| **Gym noise through partition** | Low-Moderate | R-19 insulated 2×6 wall provides good isolation; free weights dropping is the loudest source — rubber flooring helps |
| **Rear clearance behind Row 2** | Low | 1' is tight; reduce stage depth or row spacing by 0.5' each to gain 1' |
| **Light leak from 36" door** | Very Low | Door is closed during use; weatherstrip if needed |
| **Speaker mounting on partition wall** | Low | FWL/SL mount on partition — use blocking between studs for solid mount points |
| **Partition wall acoustic transmission** | Low | 2×6 with R-19 + drywall both sides ≈ STC 45-50; adequate for gym-to-theater isolation |

### Future WC Addition

A half bath can be added to the gym side later (SW corner, near plumbing entry point from house):
- Plumbing rough-in from house to detached building: ~$2,000
- WC fixtures and finish: ~$1,500
- Theater is not disrupted — all work on gym side

---

## Key Differences Across Versions

| Item | v1 | v2 | v3 | Rationale |
|------|----|----|----|-----------|
| Building dimensions | Assumed 14'×25' | Actual 29'×23' | Same | Real measurements |
| Theater dimensions | 14'×25' (3,500 cu ft) | 15'×22' (3,300 cu ft) | **14'×25' (3,500 cu ft)** | Actual floor plan |
| Scope | Theater only | Theater + gym + WC | Same | Full conversion |
| Processor | A1H ($6,500) | A1H ($6,500) | **X6800H ($3,700)** | -$2,800, 9.4.4 sufficient |
| Speaker amps | A1H internal (15ch) | A1H internal (15ch) | **ATI AT525NC (LCR+FW) + X6800H (8ch)** | NCore LCR, $0 cost (owned) |
| Config | 9.4.6 | 9.4.6 | **9.4.4** | Dropped middle heights |
| Speaker channels | 15 | 15 | **13** | -2 heights (TML/TMR) |
| Volt-10 count | — | 12 | **10** | -2 (middle heights removed) |
| Owned inventory | N/A | $9,750 | **$13,450** | Added ATI AT525NC + X4700 |
| Projector | $25-30K | JVC NZ500 $6K | Same | Native 4K D-ILA |
| Budget (out-of-pocket) | ~$65-70K | ~$57K | **~$48,700** | X6800H + fewer Volt-10s + ICEpower + ADAU1452 + deferrals |
| Budget (Phase 2 spend) | — | ~$33K | **~$26,200** | -$6,800 |
| Labor | Not specified | All owner DIY | Same | Central NC, Lee County |
| Base revision | Rev 6.0 | Rev 7.0 | Rev 7.0 | Current POR |

---

## Related Documents

- [00_Master_Index.md](00_Master_Index.md) — Rev 7.0 documentation suite
- [05_Speaker_System.md](05_Speaker_System.md) — Speaker specs (Rev 7.0)
- [06_Electronics_and_Control.md](06_Electronics_and_Control.md) — Electronics (Rev 7.0)
- [11_Budget_Summary.md](11_Budget_Summary.md) — Reference budget (Rev 7.0)
- [03_Subwoofer_System.md](03_Subwoofer_System.md) — Subwoofer design details
- [Tactile_Bass_Shaker_System.md](Tactile_Bass_Shaker_System.md) — Shaker system

---

**Document Version:** 3.6
**Created:** February 23, 2026
**Updated:** March 12, 2026
**Changes v2.0:** Real building dimensions (29'×23'), full conversion scope (gym+theater+WC), Rev 7.0 alignment, property value analysis, corrected Volt-10 sensitivity, restored bass shakers + miniDSP, HVAC + plumbing scope
**Changes v2.1:** Added owned inventory (LCR, 2 subs, treatment materials = $9,750), projector budget reduced to $5K, budget restructured to show remaining spend vs full value
**Changes v2.2:** Projector POR set to JVC DLA-NZ500 ($5,999) — native 4K D-ILA, laser, 40,000:1 native contrast, best-in-class for dedicated dark room
**Changes v2.3:** Budget split into Phase 1 (Building Prep) and Phase 2 (Home Theater); all work owner DIY with $0 labor; NC homeowner permit notes (Central NC, Lee County); granular line-item breakdown (102 items, no line >$1K except projector and AVR); total out-of-pocket revised to ~$57K
**Changes v3.0:** Processor changed from Denon AVR-A1H ($6,500) to Denon AVR-X6800H ($3,700); config changed from 9.4.6 to 9.4.4 (dropped middle heights TML/TMR); LCR + front wide amplification via ATI AT525NC (5ch NCore, already owned) through X6800H pre-outs; X6800H internal amps for 8 surround/height channels; owned inventory updated to $13,450 (added ATI AT525NC + Denon X4700 spare); Volt-10 count reduced from 12 to 10; out-of-pocket revised to ~$53,700
**Changes v3.1:** Added Option B — non-permanent installation using full 29'×23' garage with freestanding false walls over garage doors, no structural conversion, $35.4K out-of-pocket vs $53.7K full conversion. Status: under consideration, not adopted as POR.
**Changes v3.2:** Added Option C — partition only, no gym/WC finish. Build theater partition walls + equipment room + HVAC for theater only, leave garage side raw. Same 14'×25' theater as POR (all specs apply unchanged), $41K out-of-pocket. Garage side remains usable. Status: under consideration.
**Changes v3.3:** Updated all dimensions to actual floor plan (14'×25' theater per garage3.bmp), screen on west wall, corrected seating geometry and speaker angles for new orientation.
**Changes v3.4:** Replaced Options B and C with Option D — north-south partition giving 17'×23' theater (east side) + 12'×23' gym (west side). 170" 16:9 AT screen on 17' north wall. Stacked rectangular sub cabinets flanking screen and rear walls replace triangular corner columns — front pair doubles as screen wall structure, simplifying stage build. Larger theater closer to reference design, properly functional gym, equipment closet on gym side behind screen.
**Changes v3.5:** Sub amps changed from 5× NX6000D to 5× ICEpower 1200AS2 (240V, fanless, no derating below 30Hz). Sub DSP changed from DSP-408 + miniDSP to ADAU1452 (filters to DC, eliminates 20Hz floor). Single 20A/240V circuit replaces two 20A/120V circuits. POR out-of-pocket revised to ~$51,200 (HVAC corrected to $2,559 per 16_HVAC_Plan_Theater.md). Option D revised to ~$44,900.
**Changes v3.6:** Option D simplified to functional-not-cosmetic approach. Gym-side garage door stays as-is (working door). Theater-side door removed and sealed (panel/brick). Gym finish eliminated (concrete slab, existing paneling). Gym HVAC deferred (garage door ventilation). Theater mini-split head located behind AT screen. Option D Phase 1 revised to $11,300. Total out-of-pocket $39,325.
**Changes v3.7:** Bass investigation deferral applied. Nearfield subs (4× UMII18-22) deferred to post-build validation — space reserved, add later if chest-compression effect is missed. Bass shakers reduced from 16 to 8 (1 per seat, community standard). ICEpower #4 becomes spare (reassign to nearfield if added). Saves ~$2,460 immediate. POR out-of-pocket revised to ~$48,700. Option D revised to ~$36,600.
