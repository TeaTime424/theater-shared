# Dual-Opposed Sofa Table Subwoofer — Experiment

**Status:** Experimental build  
**Driver:** 2x Dayton Audio UMII18-22  
**Amplifier:** Behringer NX6000D (stereo mode, 1 ch per driver)  
**DSP:** miniDSP 2x4 HD  
**Configuration:** Sealed, horizontal dual-opposed (cones OUT), force-canceling  
**Form Factor:** Sofa table / console (~31.75" total height with top surface)  
**Baffle Recess:** 2" inset each end (cone protection + excursion clearance)

---

## Concept

Drivers mounted on each end panel, **cones facing outward**. Both push outward simultaneously -- the equal-and-opposite reaction forces cancel inside the cabinet, eliminating vibration and "walking." The shared sealed air volume sits between the two magnet assemblies inside.

```
SIDE VIEW -- SECTION THROUGH LONG AXIS:

         2"    1.5"              41.0"               1.5"   2"
       recess baffle           internal             baffle recess
    <-cone  [--||===||==============================||===||--]  cone->
               ||   ||  MAGNET <-- air --> MAGNET  ||   ||
    <-cone  [--||===||==============================||===||--]  cone->
                              48.0" external

    <-- PUSH        Both push outward simultaneously        PUSH -->
                    Cabinet reaction forces CANCEL
    Cones live in 2" recess -- 1.3" margin past Xmax
```

---

## External Dimensions

| Dimension | Value | Notes |
|-----------|-------|-------|
| Length | 48" | Long axis (driver-to-driver) |
| Width | 24" | Front-to-back |
| Height | 30" | Cabinet box only |
| **With table top** | **31.75"** | + 0.5" floor feet + 0.5" iso feet + 0.75" top |

## Height Stack

```
Table top:          0.75"   (finished surface, 1" overhang per side -> 50" x 26")
Sorbothane feet:    0.50"   (isolate table from vibrating cabinet)
Cabinet:           30.00"   (main structure)
Rubber feet:        0.50"   (isolate cabinet from floor)
Total:             31.75"   (fits standard sofa table range: 25-34")
```

## Panel Construction

| Panel | Qty | Thickness | Dimensions | Notes |
|-------|-----|-----------|------------|-------|
| End baffles | 4 (2 per end) | 0.75" ea = **1.5" doubled** | 24" x 30" | Driver mounting, T-nuts |
| Top | 1 | 0.75" | 48" x 24" | |
| Bottom | 1 | 0.75" | 48" x 24" | |
| Side (front) | 1 | 0.75" | 48" x 28.5" | Between top and bottom |
| Side (rear) | 1 | 0.75" | 48" x 28.5" | Terminal cup mounts here |
| Window braces | 2 | 0.75" | 22.5" x 4" | 12" center window |

**Material:** 2x sheets 4'x8'x0.75" plywood (Baltic birch or MDF)  
**Waste:** ~12%

## Internal Dimensions

| Dimension | Value | Calculation |
|-----------|-------|-------------|
| Length | 41.0" | 48 - 2x(2.0 recess + 1.5 baffle) |
| Width | 22.5" | 24 - 2x0.75 |
| Height | 28.5" | 30 - 2x0.75 |
| **Gross volume** | **15.2 cu ft** | 26,283 cu in |
| Driver displacement | -0.234 cu ft | 2 x 0.117 |
| Bracing | -0.30 cu ft | 2 window braces |
| **Net volume** | **~14.7 cu ft** | |
| **Per driver** | **~7.3 cu ft** | |

## Driver Orientation and Clearances

**CRITICAL: Cones face OUTWARD, magnets face INWARD.**

| Detail | Value |
|--------|-------|
| Left driver | Cone faces LEFT (outward), magnet faces right (inward) |
| Right driver | Cone faces RIGHT (outward), magnet faces left (inward) |
| Motor gap inside | 20.6" between magnet assemblies |
| Recess depth | 2.0" each end |
| Recess margin | 1.30" past Xmax (cone protected at full excursion) |
| Frame-to-wall clearance | 2.0" each side |
| Bolt circle-to-wall | 2.38" |
| Height clearance | 5.0" top/bottom |

```
END PANEL INTERIOR (22.5" x 28.5"):

    +------------------------+
    |         5.0"           |
    |      +----------+      |
    |      |          |      |
    | 2.0" |  16.875" | 2.0" |  28.5"
    |      |  cutout  |      |
    |      +----------+      |
    |         5.0"           |
    +------------------------+
             22.5"
```

## Sealed Alignment

### Empty (no stuffing)

| Parameter | Value |
|-----------|-------|
| Qtc | 0.785 |
| Fc | 32.6 Hz |
| F3 (anechoic) | ~33 Hz |
| Character | Slightly underdamped |

### Stuffed -- Design Target

| Parameter | Value |
|-----------|-------|
| **Qtc** | **0.731** |
| **Fc** | **30.4 Hz** |
| **F3 (anechoic)** | **~30 Hz** |
| **F3 (in-room, wall+floor)** | **~20 Hz** |
| Character | Near-Butterworth -- tight, extended, accurate |

### Polyfill Stuffing

| Parameter | Value |
|-----------|-------|
| Density | 1.5 lb/cu ft |
| Free air space | ~13.9 cu ft |
| Stuffing weight | ~21 lbs |
| Volume multiplier | 1.32x (+32% apparent volume) |
| Virtual volume/driver | 9.7 cu ft (vs 7.3 physical) |
| Physics | Isothermal shift -- gamma from 1.4 toward 1.0 |

Heavy polyfill more than compensates for the 2" recess volume loss. The stuffed alignment (Qtc 0.731) is tighter than the original no-recess empty alignment (Qtc 0.765), with deeper extension (Fc 30.4 vs 31.7 Hz).

---

## Real-World Operating Envelope

This sub is a standalone piece for everyday listening -- **not** part of the dedicated theater's layered bass system (corner arrays + nearfield 18s + 16 shakers). The theater system handles chest compression and room pressurization. This sub handles clean, flat, effortless bass at casual listening levels.

### Typical Listening Levels

| Use | Master Vol | LFE Peaks | Power @20Hz | Excursion | %Xmax |
|-----|-----------|-----------|-------------|-----------|-------|
| Loud movie | -10 dB | 95 dB | 4W | 2.3mm | 8% |
| Normal movie | -15 dB | 90 dB | 1.3W | 1.3mm | 5% |
| Loud music | -20 dB | 85 dB | 0.4W | 0.7mm | 3% |
| Quiet music | -25 dB | 80 dB | 0.1W | 0.4mm | 1% |

The NX6000D provides ~1,200W real-world -- roughly **300x more power than needed**. The sub will idle its entire life, delivering distortion-free bass with zero stress.

### EQ Strategy: Reverse Linkwitz Transform (Shelf-Down)

Stuffed sealed rolloff: ~7.7 dB from passband to 20 Hz.

| Approach | Method | Excursion impact | Headroom |
|----------|--------|-----------------|----------|
| Traditional LT | Boost 20 Hz by +7.7 dB | 2.4x more excursion | Reduced |
| **Reverse shelf** | **Cut 60 Hz+ by -7.7 dB** | **No change (natural)** | **Maximum** |

Reverse approach achieves flat response by reducing output above the inflection point rather than boosting below it. Overall level drops ~8 dB, which is irrelevant given the massive headroom. Excursion follows the natural sealed curve -- no boost, no stress.

HPF @ 18 Hz remains mandatory for subsonic protection.

---

## Theoretical Maximum SPL

### At Various Power Levels (per driver, @ 20Hz, stuffed alignment)

These maximums are academic -- at typical -15 dB listening, the sub draws ~1W and uses 5% of Xmax.

| Power/driver | Excursion | %Xmax | SPL @1m (dual) | + Placement (+6dB) | Status |
|-------------|-----------|-------|----------------|-------------------|--------|
| 100W | 12.9mm | 46% | 101.2 dB | 107.2 dB | Loafing |
| 225W | 19.3mm | 69% | 104.7 dB | 110.7 dB | Comfortable |
| 350W | 24.1mm | 86% | 106.6 dB | 112.6 dB | Working |
| **500W** | **28.8mm** | **103%** | **108.2 dB** | **114.2 dB** | **At Xmax** |

---

## Amplifier and DSP Configuration

### NX6000D -- Stereo Mode

| Channel | Load | Assignment |
|---------|------|------------|
| A | 4 ohm | Left-end driver (VCs in series: 2+2 ohm) |
| B | 4 ohm | Right-end driver (VCs in series: 2+2 ohm) |

Real-world power at 4 ohm: ~1,200-1,600W per channel. Vastly exceeds requirements at all listening levels.

### miniDSP 2x4 HD

```
Input 1 <- LFE / line-level source

Processing:
  HPF:  18 Hz, LR4 (MANDATORY -- driver protection)
  LPF:  80 Hz, LR4 (blend with mains)
  Reverse shelf: -7.7 dB above ~35 Hz (flatten response vs boosting below Fc)
  PEQ:  As needed for room correction
  Gain: Minimal reduction needed (reverse shelf handles level)

Output 1 -> NX6000D Ch A (left driver)
Output 2 -> NX6000D Ch B (right driver)
```

### Wiring

```
Source -> miniDSP 2x4 HD Input (RCA)
          |
miniDSP Out 1 -> NX6000D Ch A Input (XLR)
miniDSP Out 2 -> NX6000D Ch B Input (XLR)
          |
NX6000D Ch A Speakon -> Left driver (4 ohm, VCs series)
NX6000D Ch B Speakon -> Right driver (4 ohm, VCs series)
```

**Polarity:** Both drivers wired the same polarity. The dual-opposed force cancellation comes from the physical orientation (facing opposite directions), not from wiring inversion.

---

## Assembly Sequence

1. Cut all panels from 2 sheets of plywood
2. Laminate end baffles -- glue pairs (2 x 0.75" = 1.5" per end)
3. Cut 16.875" driver holes centered on each doubled baffle
4. Drill T-nut holes -- 8x per baffle on 17.75" bolt circle
5. Install T-nuts -- press from inside face of each baffle
6. Cut window braces -- 22.5" x 4" with 12" center window
7. Assemble box -- bottom + sides + baffles, Titebond III + brad nails
8. Install braces -- 13" from each end baffle
9. Seal seams -- silicone caulk all internal joints
10. Install top panel -- glue + brad nails
11. Apply gasket tape -- around driver cutouts (exterior face)
12. Mount drivers from outside -- 1/4-20 bolts through frame into T-nuts
13. Wire drivers -- VCs in series per driver, leads to terminal cup(s)
14. Install terminal cup on rear panel
15. Stuff heavily -- ~21 lbs polyfill at 1.5 lb/cf throughout cavity
16. Install protective grilles on each end

## Weight Estimate

| Component | Weight |
|-----------|--------|
| Drivers (x2) | 94 lbs |
| End baffles (4 panels) | 45 lbs |
| Top + Bottom | 36 lbs |
| Sides (x2) | 43 lbs |
| Braces + hardware | 10 lbs |
| Polyfill stuffing | 21 lbs |
| **Total cabinet** | **~249 lbs** |

## Hardware

| Item | Qty | Notes |
|------|-----|-------|
| 1/4-20 x 2.5" bolts | 16 | 8 per driver, through 1.5" baffle |
| 1/4-20 T-nuts | 16 | Pressed into baffle interior face |
| Terminal cup (dual post) | 1-2 | Rear panel mount |
| 18ga x 2" brad nails | ~150 | Assembly |
| Titebond III | 24 oz | Glue (extra for baffle lamination) |
| Silicone caulk | 1 tube | Air sealing |
| Gasket tape | 2 rolls | Driver sealing |
| 14 AWG speaker wire | 20 ft | Internal wiring |
| Polyfill | ~21 lbs | 1.5 lb/cf heavy stuffing |
| Rubber feet | 4-8 | Floor isolation |
| Sorbothane hemispheres | 4 | Table top isolation |
| Protective grilles | 2 | One per end, 18"+ opening |

---

## Comparison to Existing Designs

| Parameter | Cube (29.5 cubed) | **Sofa Table (48x24x30)** | NF Front (60x31x23) |
|-----------|-------------|---------------------------|---------------------|
| Form factor | Corner cube | **Sofa table** | Console/table |
| Driver orient. | Vertical (up/down) | **Horizontal (ends out)** | Front-firing |
| Gross volume | 12.4 cu ft | **15.2 cu ft** | ~16 cu ft |
| Per driver (phys/virt) | 6.0 cf | **7.3/9.7 cf** | ~7.5 cf |
| Qtc (stuffed) | 0.83 | **0.731** | ~0.78 |
| Fc (stuffed) | 34.5 Hz | **30.4 Hz** | ~32 Hz |
| Force cancel | Yes (vertical) | **Yes (horizontal)** | No |
| Boundary gain | +12 dB (corner) | **+6 dB (wall+floor)** | +6 dB (wall+floor) |
| Footprint | 6.0 sq ft | **8.0 sq ft** | 9.6 sq ft |
| Weight | ~289 lbs | **~249 lbs** | ~260 lbs |

---

## Files

```
dual_opposed_sofa_table/
  specifications.md            <- This file
  diagrams/
    do_01_cross_sections.png
    do_02_top_down.png
    do_03_height_stack.png
    do_04_performance.png
    do_05_response_curves.png
  intermediates/
    config.py                  <- Shared config (empty + stuffed alignments)
    generate_all.py            <- Master generator
    do_01_cross_sections.py
    do_02_top_down.py
    do_03_height_stack.py
    do_04_performance.py
    do_05_response_curves.py
```

Generate diagrams: `cd intermediates && python generate_all.py`

---

*Document Version: 1.1*  
*Created: February 2026*  
*Updated: February 2026 -- added stuffed alignment, real-world operating envelope, reverse LT strategy*  
*Location: D:\Projects\Claude\theater\experiments\dual_opposed_sofa_table\*
