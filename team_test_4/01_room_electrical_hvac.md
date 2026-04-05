# Room, Electrical & HVAC

## Room Dimensions

| Dimension | Value (ft) | Value (in) |
|-----------|-----------|------------|
| Width (E-W) | 17.0 | 204 |
| Depth (N-S) | 23.0 | 276 |
| Height | 10.0 | 120 |
| Volume | 3,910 cu ft | -- |
| Floor area | 391 sq ft | -- |
| Ratio (H:W:D) | 1 : 1.7 : 2.3 | -- |

## Room Modes (Axial)

Formula: f = c / (2L), where c = 1,125 ft/s

| Axis | Length (ft) | f1 (Hz) | f2 (Hz) | f3 (Hz) |
|------|-----------|---------|---------|---------|
| Length (N-S) | 23.0 | 1125/(2x23) = **24.5** | 49.0 | 73.5 |
| Width (E-W) | 17.0 | 1125/(2x17) = **33.1** | 66.2 | 99.3 |
| Height | 10.0 | 1125/(2x10) = **56.3** | 112.5 | 168.8 |

First three axial modes: 24.5, 33.1, 56.3 Hz. The 24.5 Hz length mode falls within the sub passband -- corner-loaded subs at all 4 corners provide best mode excitation uniformity.

## N-S Partition Layout

| Zone | Dimensions | Purpose |
|------|-----------|---------|
| Theater (east) | 17' x 23' x 10' | Main theater space |
| Gym (west) | 12' x 23' x 10' | Exercise / utility |
| Partition | N-S, 12' from west wall | Standard 2x4 framed wall |
| Equipment closet | 4' x 4', NE corner of gym | All electronics |
| Entry | 36" door, east wall, south end | Theater access |

### Equipment Closet

| Parameter | Value |
|-----------|-------|
| Location | NE corner of gym side |
| Size | 4' x 4' |
| Access | From gym side |
| Cable routing | Through partition wall to theater |
| Heat load (idle) | ~425W (X6800H 100W + ATI 75W + ICEpower 175W + misc 75W) |
| Ventilation | Passive grille to gym or small exhaust fan |
| Contains | X6800H, ATI AT525NC, 5x ICEpower 1200AS2, 2x APM2, UPS, network switch |

## Electrical

### Subpanel

100A Square D subpanel, fed from house main.

### Circuit Schedule

| Circuit | Rating | Load | Cost |
|---------|--------|------|------|
| A | 20A / 240V | 5x ICEpower 1200AS2 (sub amps) | $400 |
| B | 20A / 120V | X6800H + ATI + APM2 + sources | $400 |
| C | 20A / 120V | Projector (dedicated, ceiling run) | $400 |
| D | 20A / 230V | HVAC (MrCool 12K) | $400 |
| E | 20A / 120V | WC + gym GFI outlets | $400 |
| **Total** | **5 circuits** | | **$2,000** |

### Load Analysis

| Circuit | Max Draw (W) | Breaker Capacity (W) | Utilization |
|---------|-------------|----------------------|-------------|
| A (240V) | 5x 620W = 3,100W peak; 175W idle | 4,800W | 65% peak |
| B (120V) | ~600W peak | 2,400W | 25% |
| C (120V) | ~400W | 2,400W | 17% |
| D (230V) | ~1,200W | 4,600W | 26% |
| E (120V) | ~600W | 2,400W | 25% |

All circuits well within rating. Sub amps on dedicated 240V eliminates ground loop risk with AV gear on Circuit B.

## HVAC

### System Specification

| Parameter | Value |
|-----------|-------|
| Model | MrCool DIY 5th Gen 12K BTU |
| Voltage | 230V |
| SEER2 | 23.5 |
| Noise (silent mode) | 23.5 dB(A) |
| System cost | $2,359 |
| Hardware (disconnect, breaker, wire, condensate) | $200 |
| **Total installed** | **$2,559** |

### Placement

| Parameter | Value |
|-----------|-------|
| Location | Partition wall (west wall of theater) |
| Height | 7-8 ft from floor |
| Position | 2-4 ft south of north wall |
| Finish | Painted flat black |
| Lineset route | Through partition to gym, then north exterior wall |

### Thermal Load

| Source | BTU/hr |
|--------|--------|
| Electronics (idle ~425W) | ~1,450 |
| 8 humans @ 400 BTU/hr | ~3,200 |
| Projector (~400W) | ~1,365 |
| Envelope (insulated garage) | ~500 |
| **Total estimated** | **~6,500** |
| MrCool capacity | 12,000 |
| **Headroom** | **~85%** |

### Critical Assessment: HVAC

**Why MrCool over alternatives:**
- Pioneer: louder at comparable settings, less reliable compressor cycling
- Portable/window units: 45+ dB(A) -- disqualifying for theater
- Ducted mini-split: 2-3x cost, marginal noise benefit since MrCool already hits 23.5 dB(A)
- Central HVAC: garage has no existing ductwork; retrofit cost prohibitive

**Why partition wall over behind-screen:**
- Behind-screen placement blocks AT screen airflow and creates turbulence noise at screen surface
- Partition wall keeps unit accessible from gym side for maintenance
- Lineset route is shorter through partition than through ceiling to north wall
- Unit at 7-8 ft on side wall provides better air distribution than high-mounted behind screen
- Painted flat black on partition wall -- visually invisible in dark room
