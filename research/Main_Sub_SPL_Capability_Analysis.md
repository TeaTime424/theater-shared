# Main Subwoofer SPL Capability Analysis

## System Configuration
- **Drivers:** 8× Dayton UMII18-22 (Xmax = 28mm)
- **Layout:** 4 corners × 2 drivers each, floor-to-ceiling triangular columns
- **Amplification:** 4× Behringer NX6000D @ 8Ω (850W baseline per channel)
- **Corner Loading Gain:** +12 dB (equivalent to 16× power multiplication)

---

## NX6000D Power Derating at ULF

| Frequency | Power Available | Derating |
|-----------|-----------------|----------|
| 40Hz+ | 850W | 100% |
| 30Hz | 824W | 97% |
| 20Hz | 799W | 94% |
| 15Hz | 727W | 86% |
| 10Hz | 654W | 77% |
| 5Hz | 463W | 54% |

---

## Maximum SPL Capability (Raw, No LT)

| Freq | NX6000D | Max SPL | Excursion | Limiting Factor |
|------|---------|---------|-----------|-----------------|
| 5Hz | 463W | 77 dB | 28mm (100%) | XMAX |
| 7Hz | 548W | 89 dB | 28mm (100%) | XMAX |
| 10Hz | 654W | 101 dB | 28mm (100%) | XMAX |
| 12Hz | 683W | 105 dB | 28mm (100%) | XMAX |
| 14Hz | 712W | 108 dB | 27mm (95%) | AMP |
| 16Hz | 741W | 111 dB | 25mm (89%) | AMP |
| 18Hz | 770W | 113 dB | 23mm (82%) | AMP |
| 20Hz | 799W | 115 dB | 21mm (76%) | AMP |
| 30Hz | 824W | 120 dB | 12mm (42%) | AMP |
| 50Hz | 850W | 122 dB | 6mm (23%) | AMP |
| 80Hz | 850W | 123 dB | 1mm (4%) | AMP |

### THX Reference Achievement
- **THX LFE (115 dB):** Achieved down to ~21 Hz
- **THX Main (105 dB):** Achieved down to ~12 Hz
- **Crossover point:** ~13 Hz (excursion-limited below, amp-limited above)

---

## Listening Scenarios

### Scenario 1: Full THX Reference (115 dB LFE)
- Rare "reference" viewing sessions
- System operates near maximum capability below 20Hz
- Excursion at 75-100% of Xmax in deep bass

### Scenario 2: Everyday Flat (-10 dB / 105 dB LFE)
| Freq | Headroom | Excursion |
|------|----------|-----------|
| 10Hz | -4 dB | 9mm (32%) |
| 14Hz | +3 dB | 8mm (30%) |
| 20Hz | +10 dB | 7mm (24%) |
| 30Hz | +15 dB | 4mm (13%) |

- **105 dB achieved down to:** 12 Hz
- **Excursion:** ~32% of max across all frequencies
- System is loafing with massive headroom

### Scenario 3: Hot Subs (+5 dB) — Mains @ -10 dB, Subs +5 dB Hot (110 dB LFE)
| Freq | Max SPL | vs 110 dB | Excursion @ 110 dB | Status |
|------|---------|-----------|-------------------|--------|
| 10Hz | 101 dB | -9 dB | 28mm (100%) | Short |
| 14Hz | 108 dB | -2 dB | 27mm (95%) | Close |
| 16Hz | 111 dB | +1 dB | 23mm (84%) | ✓ OK |
| 20Hz | 115 dB | +5 dB | 12mm (44%) | ✓ Easy |
| 30Hz | 120 dB | +10 dB | 4mm (14%) | ✓ Easy |

- **110 dB achieved down to:** ~16 Hz
- Comfortable everyday operation with enhanced bass impact
- Drivers and amps operating well within limits

---

## Key Findings

### Why Corner Loading Matters
- +12 dB gain from full boundary reinforcement
- Equivalent to 16× power multiplication
- Without corner loading, would need ~108,000W total to achieve same output
- This is the primary enabler of the system's capability

### Two Operating Regimes
1. **Above ~13 Hz:** Amplifier-limited
   - More power = more SPL
   - NX6000D derating costs a few dB but plenty of headroom remains

2. **Below ~13 Hz:** Excursion-limited
   - Drivers at Xmax regardless of available power
   - SPL drops ~12 dB/octave (physics of moving air at infrasonic frequencies)
   - More amp power won't help

### NX6000D Derating Impact
- At 10Hz: 77% power (654W vs 850W baseline)
- At 20Hz: 94% power (799W vs 850W baseline)
- Derating is largely irrelevant below 13Hz (excursion-limited anyway)
- Derating matters 14-40Hz but system still exceeds THX reference

### Practical Implications
- **Everyday hot subs (+5dB):** Fully supported from 16Hz up
- **Reference capability:** Preserved for special viewing sessions
- **Thermal/mechanical stress:** Minimal at everyday levels
- **Headroom for transients:** Substantial even with hot subs

---

## Summary

The corner-loaded main subwoofer system delivers:
- **THX LFE reference (115 dB)** down to 21 Hz
- **THX main reference (105 dB)** down to 12 Hz
- **Hot subs (110 dB)** down to 16 Hz for everyday listening

The +12 dB corner loading gain is the key enabler, effectively multiplying amplifier power by 16×. Below ~13 Hz, driver excursion (not amplifier power) becomes the limiting factor - the physics of moving air at infrasonic frequencies with 28mm Xmax.

For everyday listening at -10 dB with +5 dB hot subs, the system operates comfortably within its limits with substantial headroom for dynamic peaks.

---

*Analysis Date: January 2025*
*Related: Home_Theater_System_Rev5.9_Consolidated.md, Behringer_NX6000_Reference.md*
