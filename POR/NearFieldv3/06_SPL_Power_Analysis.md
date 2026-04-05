# V3 Nearfield SPL & Power Analysis

## System Parameters

| Parameter | Value |
|-----------|-------|
| Drivers per Cabinet | 4 |
| Driver Model | UMII10-22 |
| Cone Area (Sd) | 327.8 cm² |
| Xmax | 20 mm |
| Sensitivity | 83.6 dB @ 2.83V/1m |
| Cabinet Impedance | 4Ω |
| Listening Distance | 18" (0.457 m) |
| DSP Boost @ 10Hz | +19.5 dB |

---

## Amplifier Power

### Behringer NX6000 Real-World Power @ 4Ω

| Frequency | Rated | Real-World |
|-----------|-------|------------|
| 40Hz+ | 3,000W | 1,600-2,000W |
| 20-40Hz | 3,000W | 1,200-1,600W |
| <20Hz | 3,000W | 800-1,200W |

**Design Figure @ 10Hz:** 1,000W per channel (conservative)

---

## SPL vs Power @ 10Hz

### Per Cabinet at 18" Distance

| Target SPL | Power Required | Status | Headroom |
|------------|----------------|--------|----------|
| **95 dB** | **129W** | ✓ OK | +8.9 dB |
| 100 dB | 407W | ✓ OK | +3.9 dB |
| 101.5 dB | ~600W | ⚠️ Xmax | 0 dB |
| 105 dB | 1,286W | ✗ Exceeds | - |
| 110 dB | 4,066W | ✗ Exceeds | - |

---

## System Limits

### Excursion Limit

At 10Hz with 4 drivers at Xmax (20mm):

```
SPL_max = 112.3 + 10×log10(4) + 20×log10(0.03278) + 20×log10(100) + 20×log10(0.020) - 20×log10(0.457)
        = 112.3 + 6.0 - 29.7 + 40.0 - 34.0 + 6.8
        = 101.5 dB
```

**Maximum SPL (excursion-limited): 101.5 dB @ 10Hz @ 18"**

### Amplifier Limit

At 1,000W real-world power @ 10Hz:

**Maximum SPL (amp-limited): 103.9 dB @ 10Hz @ 18"**

### Actual System Limit

| Limit Type | Maximum SPL |
|------------|-------------|
| Excursion (Xmax) | 101.5 dB |
| Amplifier (1,000W) | 103.9 dB |
| **System Limit** | **101.5 dB** (excursion) |

---

## Target Performance

### Design Target: 95 dB @ 10Hz

| Metric | Value |
|--------|-------|
| Required Power | 129W |
| Driver Excursion | ~35% of Xmax |
| Headroom to Limit | +6.5 dB (excursion) |
| Headroom to Amp | +8.9 dB |

---

## Frequency Response (Acoustic)

### After DSP + Sealed Box

| Frequency | Response | Notes |
|-----------|----------|-------|
| 3 Hz | -40.0 dB | Subsonic protection |
| 5 Hz | -18.2 dB | HPF rolloff |
| **10 Hz** | **-3.5 dB** | **Target F3** |
| 15 Hz | -0.9 dB | Nearly flat |
| 20 Hz | -0.3 dB | Flat |
| 38 Hz | 0.0 dB | Reference |
| 80 Hz | 0.0 dB | Flat |

---

## Power Budget by SPL Target

### For System Design Verification

| Target | Power/Cabinet | Total Power (4 cab) | Amps Needed |
|--------|---------------|---------------------|-------------|
| 95 dB | 129W | 516W | ✓ 2× NX6000 |
| 100 dB | 407W | 1,628W | ✓ 2× NX6000 |
| Max (101.5 dB) | ~600W | 2,400W | ✓ 2× NX6000 |

---

## Comparison: Nearfield vs Main Subs

| System | Distance | Target SPL | Power | Purpose |
|--------|----------|------------|-------|---------|
| Main (4× dual 18") | 13-18 ft | 115+ dB | 14,000W | Room pressurization |
| **Nearfield (4× quad 10")** | **18"** | **95 dB** | **~500W** | **Tactile impact** |

The nearfield system doesn't need to pressurize the room - it provides localized tactile bass impact at the seating position. Much lower SPL is needed due to proximity.

---

## Efficiency Analysis

### Why 95 dB is Adequate

| Factor | Main Subs | Nearfield |
|--------|-----------|-----------|
| Distance | 13-18 ft | 18 inches |
| Distance Ratio | 1× | 0.08× |
| SPL Gain from Proximity | 0 dB | +22 dB |
| Required SPL for Same Impact | 115 dB | ~93-95 dB |

At 18" distance, 95 dB provides the same perceived impact as 115+ dB at the main listening position.

---

## Thermal Considerations

### At 95 dB Target (129W)

| Parameter | Value |
|-----------|-------|
| Power per Cabinet | 129W |
| Power per Driver | 32W |
| Driver Rating | 600W RMS |
| Thermal Utilization | **5%** |

Extremely low thermal stress - these drivers will never get warm at target levels.

### At Maximum (101.5 dB, ~600W)

| Parameter | Value |
|-----------|-------|
| Power per Cabinet | 600W |
| Power per Driver | 150W |
| Driver Rating | 600W RMS |
| Thermal Utilization | **25%** |

Still well within thermal limits even at maximum output.

---

## Summary

| Metric | Value |
|--------|-------|
| **Target SPL** | **95 dB @ 10Hz @ 18"** |
| **Power Required** | **129W per cabinet** |
| **Maximum SPL** | **101.5 dB (excursion-limited)** |
| **Headroom Above Target** | **+6.5 dB** |
| **System Cost** | **~$4,500** |

The V3 nearfield system easily achieves the 95 dB tactile bass target with substantial headroom for peaks, while operating the drivers at a small fraction of their rated capacity.

---

*Document Version: 3.0*
*Created: December 2024*
