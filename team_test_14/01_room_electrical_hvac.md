# Room, Electrical & HVAC — Option D

All numbers sourced from `specs.yaml` unless otherwise noted.

---

## Room Dimensions

| Zone | Dimensions | X Range | Volume |
|------|-----------|---------|--------|
| Total building | 29'×23'×10' (348"×276"×120") | X=0–348 | — |
| Theater (east) | 17'×23'×10' (204"×276"×120") | X=144–348 | 3,910 cu ft |
| Gym (west) | 12'×23'×10' | X=0–144 | — |
| Partition wall | 6" wall | X=138–144 | — |

Source: `specs.yaml → room.total_building`, `room.theater_zone`, `room.gym_zone`, `room.partition`

---

## Equipment Closet

- Location: gym side (west of partition)
- X range: X=90–138, Z=228–276
- Houses: dedicated subpanel, DSP rack, amp rack

Source: `specs.yaml → electrical.subpanel` (dedicated in equipment closet); closet coordinates consistent with gym zone X=0–144.

---

## HVAC

| Parameter | Value |
|-----------|-------|
| Model | MrCool DIY 12K |
| Placement | Partition wall, painted flat black |
| Price | $2,359 |
| Noise floor | ~23 dB(A) |

Source: `specs.yaml → hvac.model`, `hvac.placement`, `hvac.price`, `hvac.noise_dba`

The partition wall mount keeps the indoor head unit inside the theater zone while the compressor exhausts to the gym side. 23 dB(A) is below the theater's ambient noise target.

---

## Electrical

### Feed Specification

| Parameter | Value |
|-----------|-------|
| Conductor | #2 Al |
| Voltage | 240V |
| Breaker at main panel | **60A** (NOT 100A — source docs had error) |
| Subpanel location | Dedicated in equipment closet |

Source: `specs.yaml → electrical.feed`, `electrical.note`, `electrical.subpanel`

### Load Calculation

Pool loads are on the same service feed (NEC calculated):

| Load | Draw |
|------|------|
| Pentair IntelliFlow VSF | Variable (NEC calculated) |
| Pool heater | Gas (no electrical draw included) |
| **NEC calculated total pool load** | **39.6A** |

Source: `specs.yaml → pool_loads.nec_calculated_load_A`, `pool_loads.pentair_intelliflow_vsf`, `pool_loads.heater`

### Headroom Calculation

```
Breaker capacity:       60.0 A    (specs.yaml → electrical.feed)
NEC pool load:         -39.6 A    (specs.yaml → pool_loads.nec_calculated_load_A)
                       ------
Available headroom:     20.4 A

Headroom %: (60 - 39.6) / 60 = 20.4 / 60 = 34%
```

34% headroom on the 60A feed with pool loads running at NEC calculated draw.

### Pool Pump Scheduling Note

The Pentair IntelliFlow VSF is variable-speed. NEC load is calculated at maximum draw. In practice, scheduling pool pump operation during off-peak theater hours (daytime) eliminates the concurrent load overlap, making the full 60A available for theater operation during evening/nighttime use.

---

## Upgrade Path

| Parameter | Value |
|-----------|-------|
| Action | 90A breaker swap at main panel |
| Cost | $50 |
| Rewire required | No |

Source: `specs.yaml → upgrade_path.description`, `upgrade_path.cost`, `upgrade_path.note`

Swapping the 60A breaker for a 90A at the main panel is the only change needed. The #2 Al conductor is rated for 90A at 75°C (NEC 310.15), so no rewire is required. This raises available headroom from 20.4A to 50.4A — sufficient for the full 5× ICEpower 1200AS2 sub amp array at 240V.

Upgraded headroom calculation:
```
90A breaker - 39.6A pool load = 50.4A available
Headroom %: (90 - 39.6) / 90 = 44%
```
