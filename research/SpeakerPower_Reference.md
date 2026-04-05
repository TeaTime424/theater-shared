# SpeakerPower Amplifier Reference
## Subwoofer Amplification for Reference Home Theater

**Document Purpose:** Evaluate SpeakerPower amplifiers as alternative to NX6000D for ULF performance  
**Created:** January 2025  
**Application:** 16× Dayton UMII18-22 subwoofer system  
**Key Advantage:** Full sustained power at 5Hz-500Hz (no ULF derating)

---

## Why SpeakerPower?

### The NX6000D ULF Problem

The Behringer NX6000D and similar pro-audio Class D amplifiers exhibit significant power derating below 30Hz:

| Frequency | NX6000D @ 8Ω | % of Rated |
|-----------|--------------|------------|
| 40Hz+ | ~850W | 100% |
| 30Hz | ~850W | ~100% |
| 20Hz | ~750W | ~88% |
| **15Hz** | **~600W** | **~71%** |
| 10Hz | ~450W | ~53% |

This derating is common in amplifiers designed for live sound where content below 30Hz is rare.

### SpeakerPower's Solution

SpeakerPower amplifiers are **purpose-built for subwoofer duty** with sustained full power at ULF:

- **Frequency Response:** 5Hz to 500Hz (±1.5dB) for larger models
- **Sustained Power:** Rated power is continuous, not burst/peak
- **ULF Derating:** None - full power available at 5Hz
- **Thermal Design:** Over 90% efficient, virtually fanless operation
- **Industry Adoption:** Used by Seaton Sound, Danley Sound Labs, Power Sound Audio, JTR Speakers, Deep Sea Sound

**Key Quote (GSG Audio):**
> "Full, sustained, power delivered at bass frequencies vs. the common 'burst' power or 'marketing specs' ratings used by many other manufacturers--with SpeakerPower amps, you get the advertised power."

---

## Product Lineup (2025)

### Rack Mount Amplifiers (2U, Dual Channel)

| Model | Power @ 2Ω | Power @ 4Ω | Power @ 8Ω | Freq Response | AC Mains | Direct Price |
|-------|------------|------------|------------|---------------|----------|--------------|
| **SP2-12000-HT** | 6,000W/ch | 3,200W/ch | 1,800W/ch | 5Hz-500Hz | 100-265VAC (full @ 240V) | **$3,399** |
| **SP2-8000-HT** | 4,000W/ch | 2,600W/ch | 1,500W/ch | 5Hz-500Hz | 100-125VAC only | **$2,999** |
| **SP2-6400-HT** | 3,000W/ch | 3,200W/ch | 1,800W/ch | 5Hz-500Hz | 100-265VAC | TBD |
| **SP2-4800-HT** | 2,000W/ch | 2,400W/ch | 1,400W/ch | 5Hz-500Hz | 100-125VAC only | **$2,699** |
| SP2-2400-HT | Stable | 1,200W/ch | 600W/ch | **20Hz-500Hz** | 100-265VAC | $2,199 |
| SP2-1400-HT | Stable | 700W/ch | 350W/ch | TBD | 100-125VAC | TBD |

**⚠️ Note:** SP2-2400-HT has 20Hz minimum frequency response - unsuitable for 15Hz nearfield target.

### Plate Amplifiers (Mono, for Enclosure Mounting)

| Model | Power @ 2Ω | Power @ 4Ω | Power @ 8Ω | AC Mains | Direct Price |
|-------|------------|------------|------------|----------|--------------|
| SP1-6000-HT | 6,000W | 3,400W | 1,800W | 208-240VAC | $1,749 |
| SP1-4000-HT | 4,000W | 2,600W | 1,500W | 100-125VAC | $1,499 |
| SP1-3200-HT | TBD | TBD | TBD | TBD | $1,649 |
| SP1-2400-HT | 2,000W | 2,400W | 1,400W | 100-125VAC | $1,399 |
| SP1-1200-HT | TBD | TBD | TBD | TBD | $929 |
| SP1-700-HT | 1,000W@2.7Ω | 700W | 350W | 100-125VAC | TBD |

**Pricing Sources:**
- SpeakerPower.com (direct): Current 2025 pricing
- GSG Audio Design: $4,099 / $3,659 / $2,639 (higher, may be outdated)
- RK Audio: $4,099 / $3,659 / $2,639 (dealer pricing)

---

## Detailed Specifications

### SP2-8000-HT (Recommended for 120V Systems)

**Overview:**
- Dual monoblock architecture in 2U rack chassis
- Optimized for maximum power on 120V circuits
- Full bridge outputs eliminate current pumping
- Stable at 1Ω loads

**Power Ratings (Per Channel, Both Channels Driven):**

| Load | Continuous Power | Voltage |
|------|------------------|---------|
| 1Ω | Stable | — |
| 2Ω | 4,000W | — |
| 4Ω | 2,600W | — |
| 8Ω | 1,500W | 115 VRMS (162 Vp) |

**Specifications:**

| Parameter | Value |
|-----------|-------|
| Topology | Class D |
| Power Supply | 4,000W per monoblock module |
| Frequency Response | 5Hz to 500Hz (±1.5dB) |
| Amplifier Gain | 45dB |
| AC Mains | 100-125VAC 50/60Hz (120V only) |
| Standby Power | 20W |
| Input Sensitivity | 316mV (at max gain) |
| Input Impedance | 10kΩ (unbalanced) / 20kΩ (balanced) |
| Output Impedance | <0.01Ω (5Hz-500Hz) |
| Cooling | Extruded aluminum heatsink per module |
| Fans | Temperature activated @ 175°F (80°C) |
| Dimensions | 3.5"H × 19"W × 14.5"D (2RU) |
| Weight | 22 lbs (9.97 kg) |

**Front Panel Controls (Per Channel):**
1. **GAIN** — 0dB (max) to MUTE (min), 316mV input sensitivity at max
2. **LF ADJUST** — 40Hz tone shelf, ±12dB ("Bass Boost")
3. **CROSSOVER** — 60Hz to OUT (500Hz bypass)
4. **DELAY** — 0ms to 20ms

**Rear Panel Connections:**
- 3.5mm minijack: 12V trigger (IN/THRU)
- RCA: Single-ended input per channel
- XLR: Balanced input with loop-through (THRU) per channel
- IEC C13: AC mains connector
- Binding posts: Two paralleled 5-way posts per channel (up to 12AWG)

**Operating Modes:**
1. **ON** — Amplifier always on
2. **AUTO** — Signal sense with 20-minute timeout
3. **OFF/TRIG** — 12V trigger enables amplifier

---

### SP2-12000-HT (For 240V Systems)

Same features as SP2-8000-HT with higher power output when supplied 240VAC.

**Power Ratings @ 240VAC (Per Channel):**

| Load | Continuous Power |
|------|------------------|
| 1Ω | Stable |
| 2Ω | 6,000W |
| 4Ω | 3,200W |
| 8Ω | 1,800W |

**Power Ratings @ 120VAC (Per Channel):**

| Load | Continuous Power |
|------|------------------|
| 2Ω | 3,000W |
| 4Ω | 2,150W |
| 8Ω | 1,200W |

**AC Mains:** 100-265VAC 50/60Hz (Universal, full power at 220-240V)

**Note:** If using 120V outlets, the SP2-8000-HT is the better choice as it's optimized for that voltage.

---

### SP2-4800-HT (Budget Option)

**Unusual Power Curve:** Delivers MORE power at 4Ω than 2Ω due to topology optimization.

**Power Ratings (Per Channel):**

| Load | Continuous Power |
|------|------------------|
| 2Ω | 2,000W |
| **4Ω** | **2,400W** |
| 8Ω | 1,400W |

**AC Mains:** 100-125VAC 50/60Hz (120V only)

Still delivers **1,400W @ 8Ω** — exceeds NX6000D real-world output at ULF frequencies.

---

## System Configuration Options

### Current System Requirements

**Subwoofer Array:**
- 8× main drivers (4 corners × 2 drivers each)
- 8× nearfield drivers (4 enclosures × 2 drivers each)
- Total: 16× Dayton UMII18-22

**Driver Specifications:**
- Voice coil: Dual 2Ω (wired series = 4Ω per driver)
- RMS Power: 1,200W
- Target frequencies: 20Hz (mains), 15Hz (nearfield)

### Option A: 8Ω Wiring (Current Configuration)

Wire two drivers in series per enclosure: 4Ω + 4Ω = 8Ω

**SP2-8000-HT Configuration:**

| Unit | Assignment | Load | Power/Ch | Per Driver |
|------|------------|------|----------|------------|
| #1 | Main FL + FR corners | 8Ω | 1,500W | ~750W |
| #2 | Main RL + RR corners | 8Ω | 1,500W | ~750W |
| #3 | Front nearfield (2 cabs) | 8Ω | 1,500W | ~750W |
| #4 | Rear nearfield (2 cabs) | 8Ω | 1,500W | ~750W |

**Cost:** 4× $2,999 = **$11,996**

**SP2-4800-HT Configuration:**

| Unit | Assignment | Load | Power/Ch | Per Driver |
|------|------------|------|----------|------------|
| #1 | Main FL + FR corners | 8Ω | 1,400W | ~700W |
| #2 | Main RL + RR corners | 8Ω | 1,400W | ~700W |
| #3 | Front nearfield (2 cabs) | 8Ω | 1,400W | ~700W |
| #4 | Rear nearfield (2 cabs) | 8Ω | 1,400W | ~700W |

**Cost:** 4× $2,699 = **$10,796**

---

### Option B: 2Ω Wiring (Maximum Power)

Wire two drivers in parallel per enclosure: 4Ω || 4Ω = 2Ω

**SP2-8000-HT Configuration:**

| Unit | Assignment | Load | Power/Ch | Per Driver |
|------|------------|------|----------|------------|
| #1 | Main FL + FR corners | 2Ω | 4,000W | ~2,000W |
| #2 | Main RL + RR corners | 2Ω | 4,000W | ~2,000W |
| #3 | Front nearfield (2 cabs) | 2Ω | 4,000W | ~2,000W |
| #4 | Rear nearfield (2 cabs) | 2Ω | 4,000W | ~2,000W |

**Cost:** 4× $2,999 = **$11,996**

**⚠️ Warning:** 2,000W per driver exceeds UMII18-22 thermal rating (1,200W RMS). Requires DSP voltage limiting. Benefit: Zero power limitation at any frequency — full headroom available.

---

### Option C: 4Ω Per Driver (Individual Driver Control)

Each driver gets its own amp channel at 4Ω.

**SP2-8000-HT Configuration (8 units required):**

| Units | Assignment | Load | Power/Driver |
|-------|------------|------|--------------|
| #1-2 | Main FL + FR (4 drivers) | 4Ω | 2,600W |
| #3-4 | Main RL + RR (4 drivers) | 4Ω | 2,600W |
| #5-6 | Front nearfield (4 drivers) | 4Ω | 2,600W |
| #7-8 | Rear nearfield (4 drivers) | 4Ω | 2,600W |

**Cost:** 8× $2,999 = **$23,992**

**Benefits:**
- Individual driver control and protection
- Maximum flexibility for future upgrades
- Ultimate redundancy (lose one channel, not entire sub)
- Compatible with StormAudio individual driver correction

---

### Option D: Plate Amplifiers (Enclosure-Mounted)

Use SP1-4000-HT plate amps mounted to each dual-driver enclosure.

**Configuration:**
- 8× SP1-4000-HT (one per dual-driver enclosure)
- Wire drivers in parallel: 4Ω || 4Ω = 2Ω per enclosure
- Power: 4,000W per enclosure (2,000W per driver)

**Cost:** 8× $1,499 = **$11,992**

**Pros:**
- Self-contained (no external rack wiring)
- Each enclosure is standalone powered
- Simplified signal distribution

**Cons:**
- No centralized control
- Harder to access for adjustment
- Requires power outlet at each enclosure location

---

## Cost Comparison

| Configuration | Amps | Wiring | Total Cost | vs NX6000D |
|---------------|------|--------|------------|------------|
| **NX6000D (current plan)** | 6 | 8Ω | **$3,294** | Baseline |
| SP2-4800-HT × 4 | 4 | 8Ω | **$10,796** | +$7,502 |
| SP2-8000-HT × 4 | 4 | 8Ω | **$11,996** | +$8,702 |
| SP1-4000-HT × 8 (plate) | 8 | 2Ω | **$11,992** | +$8,698 |
| SP2-8000-HT × 4 | 4 | 2Ω | **$11,996** | +$8,702 |
| SP2-8000-HT × 8 | 8 | 4Ω | **$23,992** | +$20,698 |

---

## Performance Analysis

### Power Comparison at Target Frequencies

**At 8Ω Load (Current Wiring):**

| Frequency | NX6000D | SP2-8000-HT | SP Advantage |
|-----------|---------|-------------|--------------|
| 40Hz | ~850W | 1,500W | +2.5 dB |
| 30Hz | ~850W | 1,500W | +2.5 dB |
| **20Hz** | **~750W** | **1,500W** | **+3.0 dB** |
| **15Hz** | **~600W** | **1,500W** | **+4.0 dB** |
| 10Hz | ~450W | 1,500W | +5.2 dB |

**Impact on System Performance:**

At 15Hz (nearfield target):
- NX6000D: ~600W/channel = ~300W per driver
- SP2-8000-HT: 1,500W/channel = ~750W per driver
- **+4 dB more headroom** at the critical nearfield frequency

At 20Hz (main sub target):
- NX6000D: ~750W/channel = ~375W per driver  
- SP2-8000-HT: 1,500W/channel = ~750W per driver
- **+3 dB more headroom** at primary reference frequency

### Thermal Performance

**Forum Reports (AVS Forum, Home Theater Shack):**

> "In the last ~1.5 years I've only seen the fans actually turn on two or three times. I've measured SPL levels just north of 139db at the seats in my HT room with just these two subs and a single SpeakerPower amp!"

> "These drivers have an unusually low Re of 0.7ohm, and even though the impedance drops to ~1.1ohm while loaded in an Othorn, the SP2-12000 has effortlessly drove these subs all while remaining cold to the touch."

> "SpeakerPower amps can do in excess of 1/3 their sustained power rating, with no time limit, prior to the fans coming on."

**Comparison to NX6000D:**
- NX6000D requires fan modification (Noctua swap) for quiet operation
- SP2-8000-HT fans rarely activate in home theater use
- Higher efficiency (~93%) = less heat generation

---

## Operational Features

### DSP Controls (All HT Models)

| Control | Function | Range |
|---------|----------|-------|
| GAIN | Input sensitivity adjustment | 0dB (max) to MUTE |
| LF ADJUST | Low frequency shelf EQ | ±12dB @ 40Hz |
| CROSSOVER | Low-pass filter | 60Hz to OUT (500Hz bypass) |
| DELAY | Time alignment | 0-20ms |

**Note:** SpeakerPower HT models can be ordered **without** the built-in high-pass filter if external DSP (Dayton DSP-408, miniDSP) handles subsonic protection.

### 12V Trigger Integration

- 3.5mm minijack input and loop-through output
- Compatible with Marantz AV10 trigger output
- Daisy-chain multiple amps from single trigger source
- OFF/TRIG mode provides true standby until triggered

### Protection Systems

- DC protection
- Overload protection  
- Low impedance protection
- Short circuit protection
- Under/over-voltage protection
- Overheating protection
- Soft-start (prevents breaker trips)
- Peak and RMS limiting (graceful ~3dB reduction vs hard shutdown)

---

## Electrical Requirements

### SP2-8000-HT (120V Optimized)

| Parameter | Value |
|-----------|-------|
| AC Input | 100-125VAC 50/60Hz |
| Plug Type | NEMA 5-15 or 5-20 |
| Max Draw | ~20A at full power (both channels, 2Ω) |
| Recommended Circuit | Dedicated 20A |

**For 4× SP2-8000-HT:**
- 4× dedicated 20A circuits recommended
- Or 2× 20A circuits with careful load management
- Current design already allocates multiple 20A circuits for subwoofer amplification

### SP2-12000-HT (240V Required for Full Power)

| Parameter | Value |
|-----------|-------|
| AC Input | 100-265VAC 50/60Hz |
| Plug Type | L6-20 or L6-30 (locking) |
| Full Power | Requires 208-240VAC |
| Recommended Circuit | Dedicated 30A @ 240V |

**Note:** At 120V, SP2-12000-HT delivers reduced power (similar to SP2-8000-HT). Only choose SP2-12000-HT if 240V circuits are available.

---

## Reliability and Support

### Manufacturer Information

- **Company:** SpeakerPower
- **Location:** USA (designed, assembled, supported)
- **Owner:** Brian Oppegaard
- **Lead Time:** 2-4 weeks typical (in-stock items ship next day)
- **Warranty:** Contact for current terms

### Commercial Adoption

SpeakerPower amplifiers power subwoofers from:
- **Seaton Sound** — F18, SubMersive
- **JTR Speakers** — Orbit Shifter, Captivator
- **Power Sound Audio** — Various models
- **Danley Sound Labs** — Professional systems
- **Deep Sea Sound** — Reference subwoofers

### Forum Reputation

Active presence on:
- AVS Forum (Official SpeakerPower thread)
- Home Theater Shack (Official thread)
- DIYAudio

Brian Oppegaard responds directly to technical questions.

---

## Purchasing

### Direct from SpeakerPower

**Website:** https://www.speakerpower.com  
**Current Pricing (January 2025):**
- SP2-12000-HT: $3,399
- SP2-8000-HT: $2,999
- SP2-4800-HT: $2,699
- SP2-2400-HT: $2,199

**Shipping:** Free ground shipping in USA

### Authorized Dealers

| Dealer | SP2-8000-HT Price | Notes |
|--------|-------------------|-------|
| GSG Audio Design | $3,659 | May have cart discount |
| RK Audio | $3,659 | Phone orders |
| Madisound | TBD | Plate amps available |

**Recommendation:** Purchase direct from SpeakerPower for best pricing and direct support.

---

## Recommendation for This System

### Primary Recommendation: SP2-8000-HT × 4 @ 8Ω

**Configuration:**
- 4× SP2-8000-HT rack mount amplifiers
- 8Ω wiring (current dual-driver series configuration)
- 1,500W per channel sustained at all frequencies

**Cost:** $11,996

**Why This Configuration:**

1. **Full ULF Performance** — No derating at 15-20Hz target frequencies
2. **120V Optimized** — Works with existing/planned electrical infrastructure
3. **Adequate Power** — 750W per driver with zero frequency-dependent limiting
4. **Thermal Margin** — Virtually fanless at home theater duty cycles
5. **Integration Features** — 12V trigger, XLR balanced, built-in DSP backup
6. **Industry Proven** — Same platform powers commercial reference systems

### Alternative: SP2-4800-HT × 4 @ 8Ω (Budget Option)

**Cost:** $10,796 (saves $1,200)

**Trade-off:** 1,400W vs 1,500W @ 8Ω — marginal difference (~0.3 dB)

### Future Consideration: 2Ω Wiring

If maximum headroom desired, rewire enclosures for 2Ω:
- Same 4× SP2-8000-HT
- 4,000W per channel (2,000W per driver)
- Requires DSP limiting to protect drivers
- Provides ~5 dB additional headroom above 8Ω configuration

---

## Decision Summary

| Factor | NX6000D | SP2-8000-HT |
|--------|---------|-------------|
| Cost (4 main + spare) | $3,294 | $11,996 |
| Power @ 8Ω @ 20Hz | ~750W (derated) | 1,500W (full) |
| Power @ 8Ω @ 15Hz | ~600W (derated) | 1,500W (full) |
| ULF Headroom | Limited | Full |
| Frequency Response | Derates <30Hz | 5Hz-500Hz flat |
| Fan Noise | Requires mod | Virtually fanless |
| 12V Trigger | Requires mod | Built-in |
| Support | Community | Direct manufacturer |
| Used By | DIY community | Commercial manufacturers |

**Premium:** ~$8,700 for full ULF capability

**Value Proposition:** For a $75,000+ reference system targeting 15Hz nearfield performance, the SpeakerPower premium eliminates the fundamental limitation of budget pro-audio amplification at ULF frequencies.

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | January 2025 | Initial creation |

---

**Sources:**
- SpeakerPower.com (product pages, specifications)
- GSG Audio Design (dealer information)
- AVS Forum (Official SpeakerPower thread, user reports)
- Home Theater Shack (Official thread)
- DIYAudio (SP1-4000 review thread)
- RK Audio (dealer pricing)
