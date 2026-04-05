# Room, Electrical & HVAC — Option D Design Package

**Status:** DRAFT — Phase 4 design doc
**Source authority:** specs.yaml (2026-03-21)
**All numbers cite specs.yaml. Any spec carrying verification_status "UNVERIFIED" is tagged below.**

---

## 1. Room Dimensions

### Theater Zone (east of partition)

| Dimension | Value | Source |
|-----------|-------|--------|
| Width | 17 ft | specs.yaml room.theater_zone.width_ft |
| Depth | 23 ft | specs.yaml room.theater_zone.depth_ft |
| Height | 10 ft (120 in) | specs.yaml room.theater_zone.height_ft / ceiling_height_in |
| Volume | 3,910 cu ft | specs.yaml room.theater_zone.volume_cuft |

### Gym Zone (west of partition)

| Dimension | Value | Source |
|-----------|-------|--------|
| Width | 12 ft | specs.yaml room.gym_zone.width_ft |
| Depth | 23 ft | specs.yaml room.gym_zone.depth_ft |

### Partition Wall

| Property | Value | Source |
|----------|-------|--------|
| X position | X=138 to X=144 (inches) | specs.yaml room.partition.X1_in / X2_in |
| Thickness | 6 in | specs.yaml room.partition.thickness_in |
| Construction | 2×4 framed | specs.yaml room.partition.type |

Coordinate system: X = West→East (0 = west exterior wall), Y = Floor→Ceiling, Z = South→North. All units in inches unless stated. (specs.yaml room.coordinate_system)

### Equipment Closet

Located on the **gym side (west of partition)**. NOT on theater side.

| Property | Value | Source |
|----------|-------|--------|
| Side | Gym (west of partition) | specs.yaml equipment_closet.side |
| Size | 4×4 ft | specs.yaml equipment_closet.size_ft |
| Coordinates | X=90–138, Z=228–276, Y=0–120 | specs.yaml equipment_closet.coordinates |
| Equipment rack | X=102–126, Z=240–270, Y=0–78 | specs.yaml equipment_closet.equipment_rack.coordinates |
| Thermal note | ICEpower 1200AS2 is fanless; 175 W idle from 5 units. Closet passive ventilation should be verified. | specs.yaml equipment_closet.ventilation_note |

---

## 2. HVAC

**Model:** MrCool DIY 5th Gen 12K [UNVERIFIED — POR doc only, not cross-referenced against vendor pricing]

| Property | Value | Source |
|----------|-------|--------|
| Standard model number | DIY-12-HP-WM-230D25-O (E-Star) | specs.yaml hvac.model_numbers.standard |
| Hyper Heat model number | DIYHH-12-HP-WM-230D25-O | specs.yaml hvac.model_numbers.hyper_heat |
| Capacity | 12,000 BTU | specs.yaml hvac.btu |
| Voltage | 208–230 V / 60 Hz / 1-phase | specs.yaml hvac.voltage |
| SEER2 | 23.5 | specs.yaml hvac.seer2 |
| Noise level | ~23 dB(A) (silent mode; AT screen attenuates ~0.5–2 dB, not 3–5 dB) | specs.yaml hvac.noise_dba / noise_note |
| Refrigerant | R-454B (pre-charged, no vacuum pump required) | specs.yaml hvac.refrigerant |
| Placement | Partition wall (west wall of theater), 7–8 ft high, 2–4 ft from north wall, painted flat black | specs.yaml hvac.placement |

**Cost** [UNVERIFIED — POR doc only, not cross-referenced against vendor pricing]:

| Item | Cost |
|------|------|
| System package | $2,359 |
| Additional hardware (low–high) | $175–$280 |
| **Total (midpoint)** | **~$2,600** |

Note: POR Rev 7.0 allocated $1,800. Confirmed gap of $750–$839. (specs.yaml hvac.total_cost_note)

### HVAC Electrical Circuit

| Property | Value | Source |
|----------|-------|--------|
| Breaker | 20A double-pole Square D | specs.yaml electrical.hvac_circuit.breaker |
| Voltage | 230 V | specs.yaml electrical.hvac_circuit.voltage |
| Wire | 12 AWG 3-conductor | specs.yaml electrical.hvac_circuit.wire |

---

## 3. Electrical

### Subpanel

| Property | Value | Source |
|----------|-------|--------|
| Rating | 100 A | specs.yaml electrical.subpanel.rating_A |
| Feed wire / main breaker | **[UNVERIFIED — #2 Al / 60A breaker NOT found in any POR source doc. Do not treat as confirmed.]** | specs.yaml electrical.subpanel.feed_wire |

The 100 A subpanel is the only confirmed subpanel figure. Feed wire gauge and main breaker size are not documented in any POR doc. (specs.yaml electrical.subpanel.note)

### Sub Amplifier Circuit

| Property | Value | Source |
|----------|-------|--------|
| Breaker | 20A double-pole | specs.yaml electrical.sub_amp_circuit.breaker |
| Voltage | 240 V | specs.yaml electrical.sub_amp_circuit.voltage |
| Load | 5× ICEpower 1200AS2 — idle 140 W total, peak ~2,600 W | specs.yaml electrical.sub_amp_circuit.load_note |

### A/V Circuit

| Property | Value | Source |
|----------|-------|--------|
| Breaker | 20A | specs.yaml electrical.av_circuit.breaker |
| Voltage | 120 V | specs.yaml electrical.av_circuit.voltage |
| Load | AVR-X6800H + ATI AT525NC + DSP + sources — idle ~154 W, peak ~1,306 W | specs.yaml electrical.av_circuit.load_note |

### HVAC Circuit

See Section 2 above.

### Installation Cost

TBD — no line item in Option D source docs. Estimate $1,500–$3,000 (Analyst G6). (specs.yaml electrical.installation_cost)

---

## 4. Notes on Unverified Items

| Item | Status | Action Required |
|------|--------|-----------------|
| HVAC system cost ($2,600) | [UNVERIFIED — POR doc only] | Cross-reference vendor pricing before purchasing |
| #2 Al / 60A feed wire for subpanel | [UNVERIFIED — not found in any POR doc] | Confirm with electrician or locate source doc |
| Electrical installation cost estimate | Gap G6 — no line item | Obtain contractor quote |
