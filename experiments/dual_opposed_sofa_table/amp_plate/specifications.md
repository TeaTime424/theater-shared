# ICEpower 1200AS1 Dual Module Amp Plate — Design Specification

**Project:** Dual Opposed Subwoofer Prototype  
**Status:** Plan of Record (POR)  
**Created:** February 2026  
**Updated:** February 2026  
**Location:** D:\Projects\Claude\theater\experiments\dual_opposed_sofa_table\amp_plate\

---

## Overview

Custom aluminum mounting plate for 2× ICEpower 1200AS1 mono amplifier modules, integrated into the back panel of the dual-opposed subwoofer prototype. Single IEC inlet with internal power distribution, single XLR input split to both modules.

---

## Module Specifications (ICEpower 1200AS1)

| Parameter | Value |
|-----------|-------|
| Dimensions (L × W × H) | 300 × 100 × 63 mm (11.81" × 3.94" × 2.48") |
| Weight | 1,150g per module |
| Mounting | 18× M3 threaded holes (bottom), 5.0mm depth |
| Mounting torque | 0.5 Nm |
| Baseplate thickness | ~3mm aluminum |
| Power output | 1,200W @ 4Ω / 600W @ 8Ω |
| Mains input | 100-240V AC, 50/60Hz (universal PFC) |
| Idle consumption | 27W per module |
| Operating temp (fanless) | 0-40°C ambient |

---

## Plate Design

### Aluminum Plate Dimensions

| Parameter | Value | Notes |
|-----------|-------|-------|
| Width | 14.0" (355.6mm) | Fits 2 modules side-by-side + margins |
| Height | 12.0" (304.8mm) | Module length + connector clearance |
| Thickness | 0.125" (3.2mm) | 6061-T6 aluminum |
| Material | 6061-T6 aluminum | Good thermal conductivity, easy machining |

### Module Layout (Interior View)

```
              14.0" (355.6mm)
    ←─────────────────────────────────→
    
    ┌─────────────────────────────────┐  ↑
    │                                 │  │
    │  ┌───────────┐  ┌───────────┐   │  │
    │  │           │  │           │   │  │
    │  │  MODULE   │  │  MODULE   │   │  │
    │  │    #1     │  │    #2     │   │  │ 12.0"
    │  │  (LEFT)   │  │  (RIGHT)  │   │  │
    │  │           │  │           │   │  │
    │  │  11.81"   │  │  11.81"   │   │  │
    │  │    ×      │  │    ×      │   │  │
    │  │  3.94"    │  │  3.94"    │   │  │
    │  │           │  │           │   │  │
    │  └───────────┘  └───────────┘   │  │
    │        ↑  0.5" gap  ↑           │  │
    │  ┌────┐              ┌────┐     │  │
    │  │IEC │              │XLR │     │  ↓
    └──┴────┴──────────────┴────┴─────┘
           ↑ connectors at bottom ↑
```

### Module Positions (from plate left edge, bottom edge)

| Module | Left Edge X | Center X | Center Y |
|--------|-------------|----------|----------|
| #1 | 2.81" | 4.78" | 6.00" |
| #2 | 7.25" | 9.22" | 6.00" |

---

## External Connections

### IEC Inlet (Single, Shared)

| Parameter | Value |
|-----------|-------|
| Type | IEC C14 panel mount with fuse holder |
| Position | Bottom of plate, left of center |
| Cutout | Per IEC standard (~27.5 × 19.5mm) |
| Fuse | 10A slow-blow (covers 2× modules) |

### Audio Input (Single)

| Parameter | Value |
|-----------|-------|
| Type | XLR 3-pin female panel mount |
| Quantity | 1 |
| Position | Bottom of plate, right of center |
| Internal | Signal Y-splits to both module P105 inputs |

### Speaker Outputs

**No panel connectors.** Speaker wires run internally from module P107 directly to driver terminals. Wires pass through holes in the plywood shield (no sealing required — shield is polyfill barrier only).

---

## Internal Wiring

### AC Power Distribution

Single IEC inlet splits to both modules internally:

```
IEC C14 Inlet
    │
    ├── Fuse (10A slow-blow)
    │
    └── Junction (brass butt splices or terminal block)
        │
        ├── Module #1 P100 (Live + Neutral)
        │
        └── Module #2 P100 (Live + Neutral)
```

**Wire gauge:** 14 AWG minimum (handles ~15A, modules draw ~6A each at full power)

### Safety Ground

Both module baseplates bonded to aluminum plate, plate bonded to IEC ground terminal.

### Audio Connections (Internal Y-Split)

```
XLR Panel Input
    │
    └── Y-splitter (or parallel wiring)
        │
        ├── Module #1 P105 (balanced input)
        │
        └── Module #2 P105 (balanced input)
```

Both modules receive identical signal. 38kΩ input impedance per module means parallel load is 19kΩ — well within typical source capability.

### Speaker Connections (Internal)

| Module | Connection | Wire | Destination |
|--------|------------|------|-------------|
| #1 | P107 harness | 12 AWG, ~3 ft | Top driver terminals |
| #2 | P107 harness | 12 AWG, ~3 ft | Bottom driver terminals |

Wires exit amp cavity through holes in shield, routed through stuffed chamber to driver terminal cups.

---

## Enclosure Integration — Rail Design (POR)

### Concept

Two horizontal plywood rails mount to the back panel interior, above and below the cutout. A plywood shield spans across the rails, creating a polyfill barrier. The plate mounts from exterior with gasket seal.

```
CROSS-SECTION (side view)

                                    ← EXTERIOR
    ┌──────────────────────────────────┤ back panel (¾")
    │                               ┌──┤ 
    │                               │▓▓│ ← plate (⅛") + gasket (AIR SEAL)
    │                               │▓▓│
    │   stuffed                     │░░│ ← modules (2.5" deep)
    │   chamber                     │░░│
    │                               │░░│
    │                            ═══╪══│ ← top rail (¾" × 3.5" deep)
    │                            ┌──┘  │
    │                            │▒▒▒▒▒│ ← shield (½" ply)
    │                            └──┐  │
    │                            ═══╪══│ ← bottom rail
    │                               │  │
    └───────────────────────────────┴──┘
                                 
    ← stuffed chamber │ amp cavity │ exterior →
```

### Key Points

1. **Air seal is at plate-to-panel interface** (gasket around cutout perimeter)
2. **Shield is polyfill barrier only** — not pressure sealed
3. **Rails provide structural support** for shield, no cantilevered cleats
4. **Service access:** Remove plate from exterior → full access to modules

### Rail Specifications

| Parameter | Value |
|-----------|-------|
| Material | ¾" plywood |
| Depth | 3.5" (from back panel face) |
| Width | ~18" (wider than cutout) |
| Quantity | 2 (top and bottom) |
| Attachment | Glue + screws to back panel interior |

### Shield Specifications

| Parameter | Value |
|-----------|-------|
| Material | ½" plywood |
| Size | Spans rail-to-rail, ~18" × 16" |
| Wire holes | 2× ~1" diameter for speaker wires |
| Attachment | Screws to front face of rails |

### Back Panel Cutout

| Parameter | Value |
|-----------|-------|
| Cutout size | 14.25" × 12.25" (plate + 0.125" clearance) |
| Position | Centered horizontally, ~6" from bottom |
| Gasket | Closed-cell foam tape around perimeter |

---

## Assembly Sequence

### Phase 1: Build Plate Assembly (Bench Work)

1. **Fabricate plate**
   - Cut 14" × 12" from 0.125" 6061-T6 sheet
   - Deburr edges
   - Drill M3 clearance holes for module mounting (36 holes)
   - Drill #10 clearance holes for panel mounting (4 corners)
   - Cut IEC inlet rectangle
   - Drill XLR hole

2. **Install panel connectors**
   - IEC inlet (bottom, left of center)
   - XLR input (bottom, right of center)

3. **Wire AC distribution**
   - IEC hot → fuse → junction → both module P100
   - IEC neutral → junction → both module P100
   - Ground: IEC ground → plate → module baseplates

4. **Mount modules**
   - Position modules on plate interior
   - Secure with M3 screws (0.5 Nm torque)
   - Connect wiring harnesses

5. **Wire signal**
   - XLR → Y-split → both module P105 inputs
   - Module P107 outputs → 12 AWG leads (leave long for routing)

6. **Test**
   - Verify AC wiring (no shorts)
   - Power up, check for smoke/heat
   - Signal test with dummy load if available

### Phase 2: Prepare Enclosure

1. **Cut back panel cutout**
   - 14.25" × 12.25" rectangle
   - Centered horizontally, ~6" from bottom

2. **Cut rails**
   - 2× strips: ¾" × 3.5" × ~18"

3. **Attach rails**
   - Position above and below cutout (~0.5" gap from cutout edge)
   - Glue + screw to back panel interior

4. **Cut shield**
   - ½" plywood, sized to span rails
   - Drill 2× wire holes (~1" diameter)

### Phase 3: Final Assembly

1. **Route speaker wires through shield holes**

2. **Screw shield to rail front faces**

3. **Apply gasket tape to cutout perimeter**

4. **Insert plate assembly from exterior**
   - Feed speaker wire leads into cavity first
   - Seat plate against gasket

5. **Secure plate with #10 screws from interior**
   - Or from exterior if using countersunk holes in plate

6. **Connect speaker wires to driver terminals**

7. **Final test before closing enclosure**

---

## Thermal Considerations

### Heat Dissipation

| Condition | Dissipated Power | Notes |
|-----------|------------------|-------|
| Idle (both modules) | ~54W | 27W × 2 |
| 1/8 power (150W audio) | ~50W per module | Typical movie peaks |
| Full power (1200W audio) | ~300W per module | Rare, thermal limiting |

### Cooling Strategy

- **Primary:** Conduction through aluminum plate to exterior air
- **Secondary:** Convection from plate exterior surface
- **Margin:** 40°C ambient fanless rating, climate-controlled room
- **Note:** Plate faces exterior, heatsink effect is optimal

---

## Parts List

| Item | Quantity | Source | Est. Cost |
|------|----------|--------|-----------|
| ICEpower 1200AS1 module | 2 | Parts Express #326-119 | $600 |
| ICEpower wiring harness | 2 | Parts Express #326-290 | $50 |
| 6061-T6 aluminum plate 14"×12"×0.125" | 1 | Online Metals / local | $30 |
| IEC C14 inlet w/ fuse holder | 1 | Mouser/DigiKey | $8 |
| XLR 3-pin female panel mount | 1 | Parts Express | $6 |
| 14 AWG stranded wire (black) | 6 ft | Local | $5 |
| 14 AWG stranded wire (white) | 6 ft | Local | $5 |
| 12 AWG speaker wire | 8 ft | Parts Express | $8 |
| Ring terminals, butt splices | Assorted | Local | $10 |
| #10-24 × 0.5" machine screws | 8 | Local | $5 |
| M3 × 8mm screws (module mounting) | 36 | McMaster-Carr | $12 |
| 10A slow-blow fuse (5×20mm) | 2 | DigiKey | $3 |
| Closed-cell foam gasket tape | 1 roll | Local | $5 |
| ¾" plywood (rails) | ~2 sq ft | Scrap | $0 |
| ½" plywood (shield) | ~2 sq ft | Scrap | $0 |
| **TOTAL** | | | **~$747** |

---

## Safety Notes

- **AC Mains:** 120/240V AC. Ensure proper grounding, appropriate wire gauges, fuse protection.
- **Capacitor discharge:** Modules retain charge. Wait 5 minutes after power removal before servicing.
- **Thermal:** Modules can reach 100°C+ under sustained load. Do not touch baseplate during/after heavy use.
- **Polarity:** Verify speaker wiring polarity. Both drivers should push outward simultaneously (force cancellation).

---

## Diagrams

Generated from Python scripts in `intermediates/` folder:

| Diagram | File | Description |
|---------|------|-------------|
| Drilling diagram | `ap_01_drilling_diagram.png` | Hole positions for plate fabrication |
| Enclosure integration | `ap_02_enclosure_integration.png` | Legacy 4-sided box concept (superseded) |
| Rail integration (POR) | `ap_03_hybrid_integration.png` | Two-rail design with shield |

Regenerate diagrams: `cd intermediates && python generate_all.py`

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | Feb 2026 | Initial design specification |
| 2.0 | Feb 2026 | **POR:** Rail integration design, single XLR, connectors at bottom |

---

*Location: D:\Projects\Claude\theater\experiments\dual_opposed_sofa_table\amp_plate\specifications.md*
