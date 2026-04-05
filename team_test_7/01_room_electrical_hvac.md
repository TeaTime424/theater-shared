# 01 — Room, Electrical & HVAC
## Option D: 17'×23'×10' Theater (N-S Partition)

All specs from `specs.yaml`. Do not hardcode numbers elsewhere.

---

## Room Geometry

| Parameter | Value | Source |
|-----------|-------|--------|
| Width (E-W) | 17 ft (204") | Partition to east wall |
| Depth (N-S) | 23 ft (276") | Screen wall to rear |
| Height | 10 ft (120") | Floor to ceiling |
| Volume | 3,910 cu ft | 17 × 23 × 10 |
| Area | 391 sq ft | |
| Room ratio (H:W:D) | 1 : 1.7 : 2.3 | Close to reference 1:1.6:2.6 |
| Orientation | Screen on NORTH wall, seating faces north | |

### Room Modes (Axial)

| Dimension | Length | Mode (Hz) | Calculation |
|-----------|--------|-----------|-------------|
| Width | 17 ft | 33.2 Hz | 1130 / (2 × 17) |
| Depth | 23 ft | 24.6 Hz | 1130 / (2 × 23) |
| Height | 10 ft | 56.5 Hz | 1130 / (2 × 10) |

No problematic axial mode overlaps. Width and depth first modes are well-separated (8.6 Hz apart). The 24.6 Hz depth mode falls near the sub system's Fc (30 Hz) — sealed alignment + Dirac Bass Control handles this.

**Tangential modes:** W×D = 41.3 Hz, W×H = 65.5 Hz, D×H = 61.6 Hz.

### Critical: Why N-S Partition

| Factor | N-S (Option D) | E-W (POR) |
|--------|---------------|-----------|
| Theater width | 17 ft | 14 ft |
| Theater depth | 23 ft | 25 ft |
| Volume | 3,910 cu ft | 3,500 cu ft |
| Screen wall width | 17 ft | 14 ft |
| Room ratio | 1:1.7:2.3 (better) | 1:1.4:2.5 |
| Gym dimensions | 12×23 (functional) | 8×26 (cramped) |
| Equipment isolation | Closet on gym side | Closet via vestibule |

---

## Partition Wall

| Spec | Value |
|------|-------|
| Orientation | North-south, at X=138-144 (12 ft from west exterior wall) |
| Construction | 2×6 stud wall, floor to ceiling |
| Insulation | R-19 batts (2×6 cavity) |
| Vapor barrier | 6-mil poly on theater (conditioned) side |
| Theater face | Drywall, taped, finished, painted |
| Gym face | Drywall, finished |
| Length | 23 ft (full N-S span) |
| STC (estimated) | 45-50 |
| Speaker mounts | FWL and SL mount on partition — use blocking between studs |

---

## Equipment Closet

| Spec | Value |
|------|-------|
| Location | NE corner of GYM (X=90-138, Z=228-276) |
| Side | **LEFT of stage** when facing screen (low X, gym side) |
| Dimensions | 4 ft × 4 ft (16 sq ft) |
| Access | From gym side — no theater disruption |
| Contains | X6800H, ATI AT525NC, 5× ICEpower 1200AS2, 2× APM2, rack, UPS, network |
| Cable routing | Through partition wall to stage area (inches from LCR and sub DSP) |
| Cooling | Ventilation to gym space |
| Equipment rack | 42U open frame (24"W × 78"H × 30"D) at X=102-126, Z=240-270 |

**Why gym side:** Fan noise and heat completely isolated from theater by partition wall. Service access from gym — no entering theater during use.

---

## Door

| Spec | Value |
|------|-------|
| Location | **EAST wall** (X=342-348), 5 ft from NE corner (Z=198-234) |
| Type | Existing 36" personnel door (retained) |
| Opening | 36" W × 80" H |
| Entry | Direct into theater — no vestibule, no light-lock |
| Note | Door is closed during use. Weatherstrip for light/sound if needed. |

---

## Electrical

### Feed from House

| Spec | Value |
|------|-------|
| Wire | **#2 Aluminum** (rated 90A @ 75°C per NEC 310.16) |
| Voltage | 240V |
| Breaker at main panel | **60A** (CORRECTED — source docs said 100A) |
| Upgrade path | Swap to 90A breaker ($30 Square D QO290) — no rewire |

### Existing Loads on Panel

| Equipment | Draw | Circuit |
|-----------|------|---------|
| Pentair IntelliFlow VSF pool pump | ~5A @ 240V typical | 30A/240V (oversized) |
| Gas pool heater | ~100W | Same 30A circuit |
| Minor lighting | ~2A | 15A/120V |

### NEC Calculated Load

| Load | Amps @ 240V |
|------|-------------|
| Sub amplifiers (5× ICEpower peak) | ~8A |
| Processor + speaker amps (120V circuits) | ~10A equivalent |
| HVAC condenser | ~10A |
| Projector | ~2A equivalent |
| Pool pump | ~5A |
| Lighting + misc | ~5A |
| **Total calculated** | **~39.6A** |
| **Panel capacity** | **60A** |
| **Headroom** | **34%** |

Pool pump scheduling (low RPM during theater hours) is the $0 mitigation for any load concern.

### Dedicated Circuits

| Circuit | Rating | Load | Cost |
|---------|--------|------|------|
| A — Sub amps | 20A/240V | 5× ICEpower 1200AS2 (175W idle, ~1000W movie) | $400 |
| HVAC | 20A/240V | MrCool 12K condenser | $600 |
| C — Processor/amps | 20A/120V | X6800H + ATI AT525NC + APM2 + sources | $400 |
| D — Projector | 20A/120V | JVC NZ500 (dedicated, ceiling run) | $400 |
| F — Gym | 20A/120V | Outlets + lighting | $400 |

---

## HVAC

### Selected Unit

| Spec | Value |
|------|-------|
| Model | MrCool DIY 5th Gen 12K BTU 230V |
| Refrigerant | R-454B (pre-charged) |
| SEER2 | 23.5 |
| Noise (silent mode) | 23.5 dB(A) |
| System cost | $2,359 |
| Hardware | ~$200 |
| **Total** | **$2,559** |

### Placement

| Spec | Value |
|------|-------|
| Location | Partition wall (west wall of theater) |
| Height | 7-8 ft |
| Position | 2-4 ft south of screen/north wall |
| Finish | Painted flat black |
| Lineset route | Condenser (north exterior) → gym → partition → head unit (~10-14 ft) |
| Condensate | Gravity drain through partition to gym side |

### Why This Unit & Placement

- 12K provides ~90-175% headroom over 4,300-6,300 BTU/hr peak load
- Nighttime usage (8pm-1am) reduces actual load to ~2,600-3,800 BTU/hr
- Silent mode at/below room ambient — effectively inaudible
- 9K rejected: $30 savings, short-cycling risk at nighttime loads
- Pioneer rejected: R-410A end-of-life, not DIY, worse warranty
- Ducted rejected: $4,700+ installed, no DIY, lose room independence
- Behind-screen rejected: overcrowded space, serviceability, condensate risk

### Thermal Load (Equipment Outside Theater)

| Source | BTU/hr |
|--------|--------|
| Occupants (2 sedentary) | ~800 |
| Projector (ceiling) | ~1,000-1,500 |
| Building envelope | ~2,000-3,500 |
| Lighting (off during viewing) | ~500 |
| **Peak total** | **~4,300-6,300** |

Equipment rack is in the gym-side closet — no electronics heat in theater.

---

## Critical Assessment

### Settled
- Room dimensions (17×23×10) — building is fixed
- N-S partition orientation — chosen, superior to E-W
- MrCool 12K on partition wall — investigated, decided
- 60A electrical feed — verified, adequate

### Needs Monitoring
- NEC load at 39.6A/60A (34% headroom) — watch if future loads added
- Partition STC 45-50 — adequate for gym noise but test with free weights
- Rear clearance behind Row 2 (~1 ft) — tight, may need stage depth reduction

---

*All values from specs.yaml. Document generated 2026-03-16.*
