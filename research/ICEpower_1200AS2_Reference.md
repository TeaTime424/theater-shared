# ICEpower 1200AS2 — Quick Reference
## 2-Channel 1200W Class D Amplifier Module with Integrated PFC Power Supply

**Datasheet:** [ICEpower1200AS1-2-Datasheet_1_7.pdf](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)  
**Supplier:** [Parts Express #326-117](https://www.parts-express.com/ICEpower-1200AS2-ICEedge-Based-Class-D-Amplifier-Module-With-Built-In-Power-Supply-2-x-1200W-326-117) — $372.98 + free shipping  
**Wiring Harness Kit:** Parts Express #326-290 (sold separately)

---

## Output Power

| Condition | 230V/50Hz | 120V/60Hz | 100V/50Hz |
|-----------|-----------|-----------|-----------|
| **Per channel, both driven, ≤1% THD @ 4Ω** | **700W** | **670W** | 460W |
| Per channel, both driven, ≤1% THD @ 8Ω | 620W | 610W | — |
| One channel driven, ≤1% THD @ 4Ω | 1,250W | 1,250W | 970W |
| One channel driven, ≤1% THD @ 8Ω | 620W | 620W | — |

### Burst & Continuous Limits

| Parameter | 230V | 120V |
|-----------|------|------|
| **Burst duration at full power (both ch, 600W/ch @ 4Ω)** | **90 sec** | **15 sec** |
| Continuous power w/o thermal shutdown (both ch combined) | 280W | 270W |
| Burst duration at full power (one ch, 1200W @ 4Ω) | 90 sec | 15 sec |
| Continuous power w/o thermal shutdown (one ch) | 290W | 280W |

### Power Bandwidth

| Parameter | Value |
|-----------|-------|
| Upper bandwidth @ full power (-3dB) | 25 kHz |
| **Lower bandwidth @ full power (-3dB)** | **20 Hz** |
| Upper bandwidth @ 10W (-3dB) | 50 kHz |
| Lower bandwidth @ 10W (-3dB) | 3 Hz |

---

## Audio Performance

| Parameter | Value |
|-----------|-------|
| THD+N @ 1kHz, 10W/4Ω | 0.003% |
| Dynamic range (A-weighted) | 127 dB |
| Dynamic range (unweighted) | 123 dB |
| Output noise (A-weighted) | 30 µV |
| Output noise (unweighted) | 45 µV |
| Channel separation @ 1kHz, 12W/4Ω | -110 dB |
| IMD3 (18+19kHz) | -97 dB |
| Frequency response 20Hz–20kHz | +0/-0.5 dB |
| Voltage gain | 25.8 dB |
| Input sensitivity (1200W/4Ω) | 5.0 Vp |
| Output impedance @ 1kHz | 6 mΩ |
| Damping factor @ 1kHz/4Ω | ~667 |

---

## Electrical

| Parameter | Value |
|-----------|-------|
| Mains input | 100–240V AC, 50/60Hz (universal PFC, auto-sensing) |
| **Minimum load impedance** | **2.7Ω** |
| Maximum output voltage | 100 Vp |
| Maximum output current | 38 Ap |
| Capacitive load limit | 400 nF |
| Input impedance (balanced) | 38 kΩ per leg |
| Idle consumption (both ch enabled) | 35W |
| Idle consumption (amp disabled) | 19W |
| Standby consumption | 250 mW (230V) / 140 mW (120V) |
| Power efficiency @ 2×600W/4Ω | ~79% |
| Power factor @ 1200W | 0.92 |
| PWM switching frequency | 500 kHz |

---

## Monitoring & Control

### Voltage/Current Monitors (P106)
- **Vmon:** Real-time speaker output voltage, gain = 0.12×, ±0.1dB / 20Hz–20kHz
- **Imon:** Real-time speaker output current, equiv. sense R = 0.33Ω, ±0.1dB / 20Hz–20kHz
- Output impedance: 100Ω (use differential input for best SNR)
- One Vmon + Imon pair per channel (4 signals total on 1200AS2)

### Control Inputs (Active High, 50kΩ pull-down)
- **Standby:** Puts module in low-power standby mode
- **AmpDisable:** Mutes amplifier, all supplies remain active
- **Trigger:** 12V-tolerant input, wakes module from standby (P102 pin 18)
- **SignalSense:** Auto-on when audio detected (>3mV RMS), 13-min timeout

### Status Outputs (Open Collector, active low)
- **Clip1/Clip2:** Per-channel voltage clipping indicator
- **Protect:** Module shutdown indicator (overcurrent, thermal, subsonic)
- **AmpReady:** Amplifier operational and passing audio
- **TempWarning:** Thermal warning (amp >110°C or PSU >85°C)
- **Ilim1/Ilim2:** Per-channel overcurrent event indicator
- **ON / STBY:** Module state indicators

### Thermal Thresholds
| Event | Amplifier | PSU |
|-------|-----------|-----|
| Warning | 110°C | 85°C |
| Progressive clip | 120°C | 90°C |
| Shutdown | 125°C | 95°C |
| Reset (resume) | 100°C | 87°C |

---

## Auxiliary Power Outputs

| Supply | Voltage | Current | Notes |
|--------|---------|---------|-------|
| DVDD | 5V ±0.2V | 1A (40mA in standby) | For control/DSP circuits |
| DVDDstby | 5V | 40mA | Active in standby mode |
| AVDD | +15V ±2V | 500mA | For analog front-end |
| AVSS | -15V ±2V | 500mA | For analog front-end |
| VD/VS (hanger bus) | ±63V nom | 5A (NOT overcurrent protected!) | Requires external 5A fast fuse |

**Note:** Total AVDD + AVSS + VDD + VSS consumption must not exceed 15W.

---

## Mechanical

| Parameter | Value |
|-----------|-------|
| Dimensions (L × W × H) | 300 × 100 × 63 mm (11.8 × 3.9 × 2.5 in) |
| Weight | 1,250g (1200AS2) |
| Baseplate | Aluminum, acts as heatsink + mounting interface |
| Mounting | 18× M3 threaded holes (bottom) or 12× edge recesses (top) |
| M3 thread depth | 5.0 mm |
| Mounting torque | 0.5 Nm |
| Operating temp (fanless) | 0–40°C ambient |
| Operating temp (with fan) | 0–60°C ambient |
| Storage temp | -40–70°C |
| Vibration rating | 2.1g RMS |
| Shock rating | 40g |

---

## Connectors

| Connector | Type | Function |
|-----------|------|----------|
| P100 | JST B2P3-VH | AC mains (Live + Neutral) |
| P101 | JST B14B-PHDSS | Basic control (standby, clip, protect, aux power) |
| P102 | JST B22B-PHDSS | Advanced control (trigger, signal sense, temp, status) |
| P105 | JST B6B-PH-K-S | Audio input (2ch balanced) |
| P106 | JST B8B-PH-K-S | Vmon/Imon outputs (2ch) |
| P107 | JST B4P-VH | Speaker output ch1 |
| P108 | JST B4P-VH | Speaker output ch2 |
| P104 | JST B03P-NV | Hanger rail supply (±63V DC bus) |
| P103 | JST B8B-PHDSS | Hanger control (low-voltage supplies) |

---

## Timing

| Event | Duration |
|-------|----------|
| Mains → audio ready | 2.4 sec |
| Standby → audio ready | 1.5 sec |
| AmpDisable release | 500 ms |
| Protection recovery | 9.5 sec |
| Thermal recovery | 500 ms (after temp drops below reset threshold) |
| Signal sense timeout | 13 min |

---

## Safety & EMC

- **Safety:** IEC/UL 62368-1 (2nd & 3rd edition), CAN/CSA C22.2 No. 62368-1
- **EMC Emissions:** EN 55032 Class B, FCC Part 15 Subpart B Class B
- **EMC Immunity:** EN 55020, EN 61000-4-2/3/4 (ESD, radiated, burst)
- **Harmonics:** EN 61000-3-2, EN 61000-3-3

---

## Application Notes for HT Build

**Our configuration:** 10× modules, 240V mains, 4Ω loads (UMII18-22 DVC wired series)

- At 240V both-channels-driven: **700W/ch @ 4Ω** with **90-second burst** capability
- At typical movie playback levels (50-200W): Well within continuous thermal limits
- Fanless operation viable at 40°C ambient — theater room will be climate controlled
- 12V trigger (P102 pin 18) allows centralized power control from AV processor
- Vmon/Imon enables DSP-based driver protection (excursion limiting, thermal monitoring)
- Balanced audio inputs pair directly with DSP-408 balanced outputs
- Module can be mounted vertically on aluminum rack plates for convection cooling

---

*Condensed from ICEpower1200AS1-2-Datasheet v1.7 (2023-06-07)*  
*Created: February 20, 2025*
