# Room, Electrical & HVAC
## Option D — 17'x23'x10' Theater

**Source of truth:** `specs.yaml` | **Date:** 2026-03-14

---

## 1. Existing Structure

| Parameter | Value |
|-----------|-------|
| Type | Detached garage (separate building) |
| Internal dimensions | 29' x 23' x 10' |
| Floor area | 667 sq ft |
| Slab | Concrete |
| Insulation | Fully insulated (walls + attic) |
| Electrical | 100A Square D subpanel |
| Internet | 1 Gbps |
| HVAC | None (must add) |
| Soundproofing | Not required (detached, no neighbors) |

## 2. Partition Wall

| Spec | Value |
|------|-------|
| Orientation | North-south, at 12' from west wall |
| Construction | 2x6 studs, floor to ceiling, 23' run |
| Insulation | R-19 batts |
| Vapor barrier | 6-mil poly on theater (conditioned) side |
| Both sides | Drywall, taped, finished |
| STC estimate | ~45 (standard 2x6 + R-19 + drywall) |
| Speaker mounting | FWL and SL mount on this wall — use blocking between studs |
| HVAC head | MrCool indoor unit mounts here, 7-8' high |

**Cable pass-throughs (PLAN BEFORE DRYWALL):**

| Penetration | Location | Size | Purpose |
|-------------|----------|------|---------|
| 1 | NE corner, 3' high | 4" conduit | Sub signal cables (4x RCA from X6800H to 2x APM2 ADAU1701, 4x RCA APM2 to 1200AS2) |
| 2 | NE corner, 5' high | 4" conduit | Speaker cables (LCR + FW to ATI) |
| 3 | NE corner, 8' high | 2" conduit | HDMI to projector, control wiring |
| 4 | 2-4' from north wall, 7' high | 3.5" hole | HVAC lineset (sealed with acoustic putty) |

Seal all penetrations with fire-rated acoustic putty after cable installation.

## 3. Theater Zone: 17'x23'x10'

| Parameter | Value |
|-----------|-------|
| Width | 17 ft (E-W) |
| Depth | 23 ft (N-S, screen wall to south exterior) |
| Height | 10 ft |
| Area | 391 sq ft |
| Volume | 3,910 cu ft |
| Room ratio (H:W:D) | 1 : 1.7 : 2.3 |
| Screen wall | North (17' wide) |
| Entry door | East wall, 36" personnel door |
| Partition wall | West (theater side wall) |
| Rear wall | South (exterior) |

**Axial room modes:**
- Width (17'): 33.0 Hz
- Length (23'): 24.6 Hz
- Height (10'): 56.5 Hz
- Bolt ratio good — no degenerate stacking.

## 4. Equipment Closet

| Spec | Value |
|------|-------|
| Location | NE corner of gym |
| Dimensions | 4' x 4' (16 sq ft) |
| Access | From gym side |
| Construction | Framed walls, interior door |
| Contents | X6800H, ATI AT525NC, 4x 1200AS2 (+ 1 spare), 2x APM2 (ADAU1701), UPS, network |
| Cable routing | Through partition wall to theater stage area |

**Heat load & ventilation:**
- Total idle heat: ~750W (5x 1200AS2 @ 35W + X6800H ~200W + ATI ~200W + misc ~175W)
- 4'x4'x10' = 160 cu ft
- Without ventilation: temperature rise of ~15-20 degF/hour above ambient
- **Required:** Passive vent to gym (12"x12" grille top and bottom) OR small exhaust fan (80 CFM)
- Gym is unconditioned initially — closet heat contributes to gym warming

## 5. Flooring & Finish

| Surface | Spec |
|---------|------|
| Theater | Carpet + pad (391 sq ft), $1,000 budget |
| Gym | Concrete slab as-is |
| Paint | Theater + closet, flat dark colors |
| Trim | Theater only, baseboards |

## 6. Openings

| Opening | Current | Conversion |
|---------|---------|------------|
| Right garage door (theater/south wall) | 145" overhead | Removed, sealed, paneled to match exterior |
| Left garage door (gym/south wall) | 96" overhead | Retained as-is (gym ventilation + access) |
| Personnel door (east wall) | 36" standard | Retained (theater entry) |

No vestibule. Door closed during use. Weatherstrip for light control.

---

## 7. Electrical

### Panel

| Parameter | Value |
|-----------|-------|
| Panel | 100A Square D |
| Current load | ~20A (existing lighting) |
| Post-build estimated load | ~75-80A (all circuits + HVAC) |
| Remaining headroom | ~20-25A |

### Circuit Schedule

| Circuit | Type | Load | Est. Draw | Wire | Cost |
|---------|------|------|-----------|------|------|
| HVAC | 20A/240V | MrCool 12K condenser | ~10A typical | 12 AWG 3-conductor | $600 |
| A | 20A/240V | 5x ICEpower 1200AS2 | 175W idle, ~2kW burst | 12 AWG 3-conductor | $400 |
| C | 20A/120V | X6800H + ATI + ADAU1452 + sources | ~500W | 12 AWG | $400 |
| D | 20A/120V | Projector (ceiling run) | ~350W | 12 AWG | $400 |
| F | 20A/120V | Gym | Variable | 12 AWG | $400 |

**Load analysis:**
- Idle: HVAC ~10A@240V + Subs ~0.75A@240V + Processor ~4.2A@120V + Projector ~3A@120V = ~25A equivalent
- Peak (movie climax): Subs burst to ~2kW (~8.3A@240V), processor to ~800W, projector same = ~35A equivalent
- Well within 100A service.

---

## 8. HVAC

### System

| Spec | Value |
|------|-------|
| Model | MrCool DIY 5th Gen 12K BTU |
| Voltage | 230V |
| SEER2 | 23.5 |
| Installation | DIY Quick Connect (no EPA 608, no vacuum pump) |
| System cost | $2,359 |
| Hardware cost | ~$200 |
| Total | ~$2,559 |

### Placement

| Element | Location |
|---------|----------|
| Indoor head | Partition wall (west wall of theater), 7-8' high, 2-4' south of north wall |
| Outdoor condenser | North exterior wall (ground pad or wall brackets) |
| Lineset route | Condenser → through north wall → across gym → through partition → up to head |
| Lineset run | ~10-14 ft (well within 25' Quick Connect limit) |
| Condensate | Gravity drain through partition wall to gym side |

### Noise

| Mode | dB(A) |
|------|-------|
| Silent | 23.5 |
| Low | 31-37 |
| Medium | 38-41 |

Pre-cool protocol: run at medium/high before movie, drop to silent for playback. At typical nighttime load (~2,600-3,800 BTU/hr), unit idles at silent/off during viewing.

### Why This Configuration

- **MrCool over Pioneer:** DIY Quick Connect, R-454B (not end-of-life R-410A), lifetime warranty
- **12K over 9K:** $30 delta, 9K short-cycles at nighttime loads
- **Partition wall over behind-screen:** Better airflow, simpler condensate, no vent engineering, clear of LCR/subs
- **230V over 115V:** More efficient, matches planned 240V circuits

### Noise Targets

| Metric | Target |
|--------|--------|
| NC rating | NC-20 to NC-25 |
| HVAC contribution at MLP | < 25 dB(A) during viewing |
| Background noise floor | 21-25 dB(A) (all equipment off) |

---

**Critical assessment:**

The room construction is straightforward — one partition wall, one closet, seal one garage door. The biggest risk is the equipment closet thermal load (750W in 160 cu ft). Without ventilation, this will overheat. The simplest solution is two passive grilles (top and bottom of closet wall to gym). If gym gets too warm, add a small exhaust fan. Design this BEFORE drywall.

The partition wall cable pass-throughs must be planned before the wall goes up. Four penetrations at specific heights handle all cable routing. Miss these and you're drilling through a finished, insulated, drywalled wall.
