# Speaker System
## Option D — 13 Channels (9.4.4 Dolby Atmos)

**Source of truth:** `specs.yaml` | **Date:** 2026-03-14

---

## System Overview

| Channel Group | Model | Qty | Sensitivity | Impedance | Amplifier | Status |
|---------------|-------|-----|-------------|-----------|-----------|--------|
| LCR | Titan-815LX | 3 | 99 dB | 6 ohm (4.2 min) | ATI AT525NC (~270W/ch) | Owned |
| Front Wides | Volt-10 V2 | 2 | 95 dB | 8 ohm | ATI AT525NC (~200W/ch) | Buy |
| Surrounds | Volt-10 V2 | 4 | 95 dB | 8 ohm | X6800H internal (~100-140W) | Buy |
| Atmos Heights | Volt-10 V2 | 4 | 95 dB | 8 ohm | X6800H internal (~100-140W) | Buy |
| **Total** | | **13** | | | | |

---

## LCR: DIYSG Titan-815LX (3 speakers)

| Parameter | Value |
|-----------|-------|
| Sensitivity | 99 dB @ 2.83V/1m |
| Impedance | 6 ohm nominal, 4.2 ohm minimum @ 110 Hz |
| Power handling | 400W (with 80 Hz crossover) |
| Cabinet tuning | 40 Hz (ported — line panels, don't stuff) |
| Crossover | 60-80 Hz to subs |
| Placement | On stage deck (27" elevation), behind AT screen |
| Isolation | Sorbothane 50 durometer hemispheres, 4/speaker, 12 total ($84) |
| Spacing | L/R at ~25 deg from MLP, well within 148" screen width |

### SPL at Listening Position

Amplifier: ATI AT525NC, ~270W into 6 ohm (NCore, realistic estimate).

| Metric | Calculation | Result |
|--------|-------------|--------|
| SPL @ 1m | 99 + 10*log10(270) = 99 + 24.3 | ~123 dB |
| Distance loss to Row 1 (10.5 ft = 3.2m) | -20*log10(3.2) | -10.1 dB |
| Room gain (mid-freq, typical) | | +3 dB |
| **SPL @ Row 1** | | **~116 dB** |
| **SPL @ Row 2** (15 ft = 4.6m) | 123 - 13.2 + 3 | **~113 dB** |
| Headroom over 95 dB target (Row 1) | | **+21 dB** |
| Headroom over 95 dB target (Row 2) | | **+18 dB** |

**Note:** These are single-channel estimates. All-channels-driven power may be lower (~100W from ATI into 6 ohm), giving ~108 dB at Row 1 — still +13 dB over target. The GC_Option1.md "~108 dB" figure uses this conservative methodology.

---

## Front Wides: Volt-10 V2 (2 speakers)

| Channel | Position | Mounting | Angle from MLP |
|---------|----------|----------|----------------|
| FWL | West wall (partition), between screen and MLP | Wall mount | ~55 deg |
| FWR | East wall, between screen and MLP | Wall mount | ~55 deg |

Amplifier: ATI AT525NC (~200W into 8 ohm).

| Metric | Result |
|--------|--------|
| SPL @ 1m | 95 + 23 = 118 dB |
| Distance to MLP (~8 ft = 2.4m) | -7.6 dB |
| Room gain | +3 dB |
| **SPL @ MLP** | **~113 dB** |
| Headroom over 95 dB | **+18 dB** |

---

## Surrounds: Volt-10 V2 (4 speakers)

| Channel | Position | Mounting | Angle from MLP |
|---------|----------|----------|----------------|
| SL | West wall (partition), beside MLP | Wall mount, ear height | ~90 deg |
| SR | East wall, beside MLP | Wall mount, ear height | ~90 deg |
| SBL | South wall (rear) | Wall mount, above backrest | ~145 deg |
| SBR | South wall (rear) | Wall mount, above backrest | ~145 deg |

Amplifier: X6800H internal (~100-140W into 8 ohm).

| Metric | Result |
|--------|--------|
| SPL @ 1m (at 100W ACD) | 95 + 20 = 115 dB |
| Distance (~8.5 ft sides, ~7 ft rears = avg 2.4m) | -7.6 dB |
| Room gain | +3 dB |
| **SPL @ MLP** | **~110 dB** |
| Headroom over 95 dB | **+15 dB** |

---

## Atmos Heights: Volt-10 V2 (4 speakers)

| Channel | Position | Mounting |
|---------|----------|----------|
| TFL | Ceiling, above front stage area | Ceiling mount |
| TFR | Ceiling, above front stage area | Ceiling mount |
| TRL | Ceiling, above rear seating | Ceiling mount |
| TRR | Ceiling, above rear seating | Ceiling mount |

Amplifier: X6800H internal (~100-140W into 8 ohm).

| Metric | Result |
|--------|--------|
| SPL @ 1m (at 100W ACD) | 95 + 20 = 115 dB |
| Distance (~10 ft front, ~8 ft rear = avg 2.7m) | -8.6 dB |
| Room gain | +3 dB |
| **SPL @ MLP** | **~109 dB** |
| Headroom over 95 dB | **+14 dB** |

---

## Complete Channel Matrix

| Channel | Speaker | Amp | Power (W) | SPL @ Row 1 | Headroom vs 95 dB |
|---------|---------|-----|-----------|-------------|-------------------|
| L | Titan-815LX | ATI AT525NC | ~270 @ 6 ohm | ~116 dB | +21 dB |
| C | Titan-815LX | ATI AT525NC | ~270 @ 6 ohm | ~116 dB | +21 dB |
| R | Titan-815LX | ATI AT525NC | ~270 @ 6 ohm | ~116 dB | +21 dB |
| FWL | Volt-10 | ATI AT525NC | ~200 @ 8 ohm | ~113 dB | +18 dB |
| FWR | Volt-10 | ATI AT525NC | ~200 @ 8 ohm | ~113 dB | +18 dB |
| SL | Volt-10 | X6800H | ~100-140 | ~110 dB | +15 dB |
| SR | Volt-10 | X6800H | ~100-140 | ~110 dB | +15 dB |
| SBL | Volt-10 | X6800H | ~100-140 | ~110 dB | +15 dB |
| SBR | Volt-10 | X6800H | ~100-140 | ~110 dB | +15 dB |
| TFL | Volt-10 | X6800H | ~100-140 | ~109 dB | +14 dB |
| TFR | Volt-10 | X6800H | ~100-140 | ~109 dB | +14 dB |
| TRL | Volt-10 | X6800H | ~100-140 | ~109 dB | +14 dB |
| TRR | Volt-10 | X6800H | ~100-140 | ~109 dB | +14 dB |

**Minimum headroom: +14 dB (Atmos heights).** All channels exceed target by substantial margin.

---

## Critical Assessment

**Why Titan-815LX for LCR:**
- 99 dB sensitivity is exceptional — dominates from any amplifier
- Proven DIYSG design with extensive community validation
- Already owned ($4,800 sunk) — zero additional cost
- Ported enclosure provides extension to 40 Hz before sub handoff
- 6 ohm load is handled easily by ATI NCore (rated for 4 ohm)

**Why Volt-10 for all surround/Atmos/FW:**
- Coaxial point source — superior off-axis response for surround/Atmos duty
- 10 identical speakers = perfect timbral matching across all non-LCR channels
- 95 dB sensitivity provides massive headroom in a 17'-wide room
- $242/speaker is exceptional value for this performance level

**Weaknesses:**
- 6 ohm LCR load: ATI handles it fine (NCore topology). X6800H internal would also work but ATI is better matched.
- Volt-10 95 dB sensitivity is moderate vs horn-loaded alternatives — but at 7-8.5' distances in this room, headroom is +14-18 dB. Not a concern.
- 4 height channels vs 6 in reference design: dropped TML/TMR. At 23' depth, overhead pan resolution is reduced for front-to-rear effects. This is the real trade-off — saves $484 + processor cost difference. Adequate for most content; noticeable on demo material with precise overhead panning.

**What would change this:** If the X6800H is upgraded to a 15.4+ channel processor in the future, adding TML/TMR would cost $484 (2 more Volt-10s) + ceiling install. The room and wiring can accommodate this without construction changes.
