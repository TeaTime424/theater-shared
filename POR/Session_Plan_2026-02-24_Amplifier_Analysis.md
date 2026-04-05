# Tomorrow's Session Plan
## Subwoofer System Analysis — Garage Conversion Option 1

**Date:** February 24, 2026  
**Goal:** Determine amplifier requirements and evaluate ICEpower 1200AS1/AS2 vs Behringer NX6000D

---

## Session Outline

### Part 1: Room Boundary Subwoofer Analysis

**Objective:** Calculate actual SPL capability at MLP considering room gain and boundary loading

**Key Questions:**
1. What is the room gain curve for a 3,500 cu ft sealed room?
2. How does corner loading affect the 4-corner array (8 drivers)?
3. What is the nearfield contribution at 15" distance (2 drivers)?
4. What is the combined system response at MLP?

**Analysis Tasks:**
- [ ] Calculate room gain for 14' × 25' × 10' room (Schroeder frequency, modal behavior)
- [ ] Model corner loading gain (+10-12 dB expected at full boundary)
- [ ] Model sealed box response for UMII18-22 in target enclosure volumes
- [ ] Calculate half-space vs quarter-space vs eighth-space loading scenarios
- [ ] Determine target SPL at 20Hz, 25Hz, 30Hz at MLP (13.6' from front wall)

**Reference Data Needed:**
- UMII18-22 T/S parameters (Fs=22Hz, Qts=0.53, Vas=248L, Xmax=28mm)
- Target enclosure volumes (corner columns ~10 cu ft/driver, nearfield TBD)
- Room dimensions and driver positions

---

### Part 2: Amplifier Power Requirements

**Objective:** Determine minimum and recommended amplifier power per driver

**Key Questions:**
1. What power is needed to reach Xmax at 20Hz in the sealed alignment?
2. What is the thermal limit vs mechanical limit?
3. What headroom do we want above reference level?
4. How does burst duration affect real-world performance?

**Analysis Tasks:**
- [ ] Calculate power to reach Xmax at key frequencies (15Hz, 20Hz, 25Hz, 30Hz)
- [ ] Model cone excursion vs power vs frequency
- [ ] Determine continuous vs burst power requirements
- [ ] Factor in EQ requirements (if any boost needed below corner frequency)

**Target Specs:**
- Reference level: 105 dB at MLP
- Headroom target: +10 dB above reference (115 dB peaks)
- Frequency response: Flat to 20 Hz, -3dB at ~15 Hz

---

### Part 3: Amplifier Comparison — NX6000D vs ICEpower 1200AS1/AS2

**Objective:** Evaluate whether ICEpower upgrade is justified for this smaller room

#### Behringer NX6000D (Current Plan)

| Spec | Value |
|------|-------|
| Channels | 2 per unit |
| Power @ 4Ω | 1600W per channel (bridged: 3000W @ 8Ω) |
| Power @ 2Ω | 3000W per channel |
| Burst capability | ~15 seconds at full power (120V) |
| Cooling | Forced air (requires Noctua mod for quiet) |
| 12V trigger | Requires relay mod |
| Cost | ~$500 per unit |
| Units needed | 5 (for 10 drivers) |
| **Total cost** | **~$2,500** |

#### ICEpower 1200AS1 (Mono)

| Spec | Value |
|------|-------|
| Channels | 1 (mono module) |
| Power @ 4Ω (240V) | 1200W |
| Power @ 4Ω (120V) | ~1000W |
| Power @ 2Ω | Not rated (2.7Ω minimum) |
| Burst capability | 90 seconds at 240V |
| Cooling | Fanless (ICEedge) |
| 12V trigger | Built-in |
| Cost | ~$280 per module |
| Modules needed | 10 (one per driver) |
| **Total cost** | **~$2,800** |

#### ICEpower 1200AS2 (Stereo)

| Spec | Value |
|------|-------|
| Channels | 2 per module |
| Power @ 4Ω (240V) | 700W per channel |
| Power @ 4Ω (120V) | 670W per channel |
| Burst capability | 90 seconds at 240V |
| Cooling | Fanless (ICEedge) |
| 12V trigger | Built-in |
| Vmon/Imon | Per-channel monitoring |
| Cost | ~$373 per module |
| Modules needed | 5 (for 10 drivers) |
| **Total cost** | **~$1,865** |

#### Comparison Matrix

| Factor | NX6000D | 1200AS1 | 1200AS2 |
|--------|---------|---------|---------|
| Power per driver @ 4Ω | ~800W* | 1200W | 700W |
| Individual driver control | No (pairs) | Yes | Yes |
| Fanless operation | No (mod) | Yes | Yes |
| 12V trigger native | No (mod) | Yes | Yes |
| 240V benefit | Minimal | 6× burst | 6× burst |
| Driver monitoring | No | No | Yes (Vmon/Imon) |
| Total cost | $2,500 | $2,800 | $1,865 |
| Complexity | Mods needed | Simple | Simple |

*NX6000D in bridged mode driving 2 drivers in series = ~800W per driver equivalent

**Key Analysis Questions:**
1. Is 700W/driver (1200AS2) enough for this room?
2. Does the smaller room (3,500 vs 4,160 cu ft) reduce power requirements?
3. Is individual driver control valuable for a 10-driver system?
4. What's the real cost delta after NX6000D mods (fan + trigger)?

---

### Part 4: Decision Framework

**Factors to Weigh:**

1. **Performance adequacy** — Can we hit 115 dB peaks at 20 Hz?
2. **Thermal headroom** — Continuous power for action movie sequences
3. **System complexity** — Mods, wiring, troubleshooting
4. **Future flexibility** — Expandability, spare strategy
5. **Total cost** — Including mods, wiring, mounting

**Decision Tree:**
```
Is 700W/driver sufficient for 115 dB @ 20 Hz in this room?
├── YES → 1200AS2 is clear winner ($1,865, fanless, triggers, monitoring)
└── NO → Need more power
    ├── Is 1200W/driver sufficient?
    │   ├── YES → 1200AS1 ($2,800, fanless, triggers)
    │   └── NO → NX6000D or consider fewer/larger drivers
    └── Consider hybrid: 1200AS2 for corners, 1200AS1 for nearfield
```

---

## Preparation for Tomorrow

**Documents to Reference:**
- [x] ICEpower_1200AS2_Reference.md (already in project)
- [ ] Pull NX6000D specifications
- [ ] UMII18-22 spec sheet (in project)

**Tools Needed:**
- WinISD or similar for box modeling
- Room gain calculator
- SPL/power/excursion calculator

**Data to Gather:**
- Exact enclosure volumes for corner columns
- Nearfield enclosure volume options
- DSP filter requirements (HPF, EQ)

---

## Success Criteria

By end of session, we should have:

1. ✅ SPL capability chart: frequency vs SPL at MLP for the 10-driver system
2. ✅ Power requirement: minimum watts per driver to hit targets
3. ✅ Amplifier recommendation: NX6000D vs 1200AS1 vs 1200AS2
4. ✅ Updated budget impact analysis
5. ✅ Updated Garage_Conversion_Option1.md with final amplifier selection

---

*Plan created: February 23, 2026*
