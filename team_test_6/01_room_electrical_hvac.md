# Room, Electrical, and HVAC Specifications

**Source of Truth:** `specs.yaml`
**Layout:** Option D — N-S partition

---

## Room Dimensions

| Parameter | Value |
|---|---|
| Theater (east zone) | 17' W x 23' D x 10' H |
| Gym (west zone) | 12' W x 23' D x 10' H |
| Building total | 29' x 23' x 10' |
| Theater area | 391 sq ft |
| Theater volume | 3,910 cu ft |
| Ceiling height | 10' (120") |

## Building Context

29' x 23' detached garage, separate structure from house. Two existing garage door openings on south wall (one per zone). Building has existing 100A subpanel on east wall, fed from house main panel.

### Partition Wall

| Parameter | Value |
|---|---|
| Orientation | North-South |
| Position | 12' from west exterior wall |
| Construction | 2x6 framing, insulated, drywalled both sides |
| Height | Floor to ceiling (10') |
| Length | 23' (full depth) |
| Theater side | West wall of theater zone |
| Gym side | East wall of gym zone |
| Phase 1 cost | $2,500 (framing + insulation + drywall + finish + equipment closet) |

### Equipment Closet

| Parameter | Value |
|---|---|
| Location | NW corner of building (gym side of partition) |
| Dimensions | 4' x 4' |
| Coordinates | X: 90-138", Z: 228-276" |
| Access | From gym side |
| Cable routing | Through partition wall to theater |
| Ventilation | Passive or small exhaust fan |
| Contents | X6800H, ICEpower amps, APM2 DSP, rack |

### Door

| Parameter | Value |
|---|---|
| Wall | East (exterior) |
| Width | 36" |
| Position | 62" from NE corner |
| Height | 80" (standard) |
| Type | Direct entry — no vestibule or light-lock |
| Light control | Blackout curtain or light trap baffle if needed |

### Garage Door Openings (South Wall)

| Opening | Treatment | Cost |
|---|---|---|
| Left (theater side) | Remove door, frame, install window, insulate, finish exterior | $2,000 |
| Right (gym side) | Remove door, seal opening, finish exterior | $900 |

---

## Electrical

### Feed from House

| Parameter | Value |
|---|---|
| Wire | #2 Aluminum 240V |
| Wire rating | 90A @ 75C (NEC 310.16) |
| Breaker at house | 60A |
| Run | House main panel to garage subpanel |
| Subpanel | 100A rated (in garage building, east wall) |

### NEC Load Calculation

| Load | Current (A) |
|---|---|
| Sub amps (4x ICEpower 1200AS2 @ 240V) | 6.0 |
| Processor/amps (X6800H + ATI, 120V leg) | 10.0 |
| Projector (120V leg) | 3.0 |
| HVAC (MrCool 12K outdoor unit) | 7.6 |
| Gym outlets + lighting | 5.0 |
| Pool pump (Pentair IntelliFlow VSF) | 5.0 |
| Pool heater (gas, electric ignition only) | 1.0 |
| Lighting (theater + gym) | 2.0 |
| **Total calculated load** | **39.6A** |
| **Breaker capacity** | **60A** |
| **Headroom** | **34%** |

### Circuit Table

| Circuit | Rating | Load Description | Estimated Draw |
|---|---|---|---|
| A | 20A / 240V | 4x ICEpower 1200AS2 sub amps (175W idle each) | 6A @ 240V |
| C | 20A / 120V | X6800H, ATI AT525NC, APM2 DSP, sources | 10A @ 120V |
| D | 20A / 120V | Projector (dedicated, ceiling run) | 3A @ 120V |
| E | 20A / 240V | MrCool HVAC outdoor unit | 7.6A @ 240V |
| F | 20A / 120V | Gym outlets, lighting | 5A @ 120V |
| (existing) | 30A / 240V | Pool pump + gas heater | 6A @ 240V |

Total new circuits: 5. Phase 1 cost: $1,800.

### Upgrade Path

If future loads are added (gym HVAC, nearfield sub amps, additional outlets):

1. Swap house breaker from 60A to 90A QO290 — **$30 part, no rewire needed**
2. #2 Al wire already rated for 90A @ 75C
3. Adds 30A of headroom (50.4A additional capacity)
4. Only trigger: calculated load exceeding 48A (80% of 60A continuous)

---

## HVAC

### System Selection

| Parameter | Value |
|---|---|
| Model | MrCool DIY 5th Gen 12K BTU 230V |
| Type | Mini-split, single zone |
| Capacity | 12,000 BTU (1 ton) |
| Voltage | 230V (Circuit E) |
| System price | $2,359 |
| Additional hardware | $200 (disconnect, breaker, wire, raceway, condensate) |
| **Total installed** | **$2,559** |

### Placement

| Parameter | Value |
|---|---|
| Indoor unit | Partition wall (west wall of theater) |
| Height | 7-8 ft above floor |
| Position | 2-4 ft south of north wall |
| Finish | Painted flat black |
| Noise (silent mode) | 23.5 dB(A) |
| Outdoor unit | West exterior wall, ground level |
| Line set run | Short — straight through partition + exterior wall |

### Noise Assessment

| Source | Level |
|---|---|
| MrCool silent mode | 23.5 dB(A) |
| Theater ambient target | <30 dB(A) NC-25 |
| Whisper threshold | 30 dB(A) |
| Verdict | 6.5 dB below whisper — inaudible during content |

---

## Critical Assessments

### Why Partition Wall HVAC Mount (Not Screen Wall, Not Ceiling)

- Screen wall is AT screen + LCR + sub cabinets — no room for indoor unit
- Ceiling-mounted would require ductwork, adding noise and cost
- Partition wall puts indoor unit on theater's west wall, close to outdoor unit (short line set)
- High mount (7-8 ft) keeps it above head height, out of viewing angles
- Painted black = visually disappears in dark theater

**What would change it:** If theater needed >12K BTU (unlikely at 3,910 cu ft with insulated partition), would add second unit on east wall or switch to ducted.

### Why 60A Feed Is Sufficient

- NEC calculated load: 39.6A = 66% of 60A capacity
- 34% headroom covers startup inrush and simultaneous peak loads
- Pool pump is variable speed (IntelliFlow VSF) — typical draw is 5A, not nameplate max
- Gas heater draws negligible electric (ignition + controller only, on oversized 30A breaker)
- Upgrade to 90A is a $30 breaker swap if ever needed — no rewire

**What would change it:** Adding gym HVAC (second MrCool 12K, +7.6A) and nearfield sub amp (+1.5A) would push to ~48.7A — still within 60A but at 81% continuous. At that point, swap to 90A.

### Why No Vestibule / Light-Lock

- East wall door with 62" offset from screen wall — not direct line-of-sight to screen
- Riser and seating geometry block most light paths
- Blackout curtain at door is $50 vs $3,000+ vestibule construction
- Removed from Phase 1 budget, saving cost and floor space

**What would change it:** If ambient light from door area proves problematic during use, add a simple light trap baffle ($200) rather than full vestibule.
