# Behringer NX6000 / NX6000D Amplifier Reference

## Overview

The Behringer NX6000 and NX6000D are ultra-lightweight Class-D power amplifiers designed for professional audio applications. Both models share the same power output specifications but differ in features and operating modes.

## Key Specifications (Both Models)

| Parameter | Manufacturer Spec |
|-----------|-------------------|
| Power @ 4Ω (per channel) | 3,000 W |
| Power @ 8Ω (per channel) | 1,600 W |
| Total Power | 6,000 W (both channels) |
| Amplifier Class | Class D |
| Rack Size | 2U |
| Weight (NX6000) | 13 lbs / 5.9 kg |
| Weight (NX6000D) | 13.2 lbs / 6.0 kg |
| Operating Temperature | 5°C to 45°C (41°F to 113°F) |

## ⚠️ REAL-WORLD POWER OUTPUT (Forum-Verified)

Behringer's published specifications are optimistic. Independent testing by forum members reveals significantly lower sustained power output.

### Manufacturer Claims vs Real-World @ 4Ω

| Metric | Behringer Spec | Real-World (Tested) |
|--------|----------------|---------------------|
| Per channel (both driven) | 3,000W | **1,200 - 1,600W** |
| Per channel (single driven) | 3,000W | **1,800 - 2,000W** |
| Burst/peak (brief) | 3,000W | **2,000 - 2,400W** |
| **Total (stereo, sustained)** | 6,000W | **2,400 - 3,200W** |

### Test Sources

**AVS Forum - notnyt's amp dyno (iNuke 6000):**
> "These amps can burst to 3kW at 40Hz, but can't sustain more than 2.4kW. They go into protect fairly quickly at those levels."

**AVS Forum - NX6000D measurement thread:**
> "Real world power for the 6k @ 4 ohms for sub duties will make 1200 watts a channel when both channels are used."
> "~1800W peak and 1600W RMS for 1ch for sub use... 3000W peak and 2400W RMS for both channels."

**Speakerplans Forum bench test (NU6000):**
> "Behringer: 2.05kW @ 4Ω for full-range/mid-top duty, 1.80kW @ 4Ω for Bass duty"

**DIYAudio:**
> "NX6000 is actually pretty powerful and will do ~2kW per channel into 4 ohms."

### ⚠️ Low Frequency Power Reduction

Multiple testers noted significant power drop at frequencies below 30 Hz:

**DIYAudio - bolserst's NU3000 tests:**
> "At 20Hz into 4 ohms power dropped to 280W after about 10 seconds"

| Frequency Range | Estimated Real-World Power @ 4Ω |
|-----------------|----------------------------------|
| 40Hz+ (mid-bass) | 1,600 - 2,000W per channel |
| 20-40Hz (deep bass) | 1,200 - 1,600W per channel |
| **<20Hz (infrasonic)** | **800 - 1,200W per channel** |

### Design Implications

- For typical home theater use (30Hz+), expect ~1,600W per channel sustained
- For deep bass systems targeting 20Hz, plan for ~1,200W per channel
- For infrasonic systems (10Hz LT), conservatively assume **~1,000W per channel**
- The amp provides excellent value despite being ~40-50% of rated specs
- Always design with real-world figures, not manufacturer claims

## Input/Output Connections

| Connection | Type |
|------------|------|
| Inputs | Combo XLR / ¼" TRS (balanced) / ¼" TS (unbalanced) |
| Outputs | NL4 Speakon (twist-lock) |
| Input Impedance | 10kΩ (unbalanced), 20kΩ (balanced) |

## Critical Difference: Operating Modes

### NX6000 (Non-DSP Version)

**⚠️ NO BRIDGE MODE AVAILABLE**

The official manual explicitly states:
> "MODE SWITCH Choose the amplifier mode by toggling the sliding MODE SWITCH between the MONO, STEREO, and BRIDGE positions **(NX6000: no BRIDGE mode.)**"

| Mode | Description |
|------|-------------|
| STEREO | Independent L/R channels |
| MONO (Dual Mono) | Same signal to both channels |

The NX6000 is internally already a bridged design (essentially two NX3000 modules bridged internally), which is why external bridging is not available.

### NX6000D (DSP Version)

The NX6000D **does support bridge mode** via its DSP controls.

| Mode | Description |
|------|-------------|
| STEREO | Independent L/R channels |
| DUAL (Dual Mono) | Same signal to both channels |
| BRIDGE | Combined mono output |
| BIAMP1 / BIAMP2 | Bi-amplification modes |

## NX6000D DSP Features

The NX6000D includes built-in DSP with 24-bit/96kHz converters:

| Feature | Specification |
|---------|---------------|
| Delay | Sophisticated delay processing |
| Crossover | 3 filter types, up to 48 dB/octave |
| EQ | 8 parametric + 2 dynamic |
| Dynamics | Compressor/limiter processing |
| Control | Front panel LCD or USB (NX EDIT software) |
| Security | Lockable settings |

### ⚠️ NX6000D DSP Frequency Limitation

**The NX6000D DSP minimum frequency is 20 Hz.**

The NX EDIT software and front panel controls do not allow configuring filters, EQ, or crossover points below 20 Hz. This is a hard limitation of the DSP firmware.

| DSP Function | Minimum Frequency |
|--------------|-------------------|
| HPF/LPF | 20 Hz |
| Parametric EQ | 20 Hz |
| Crossover | 20 Hz |

**Implication for deep bass applications:** The NX6000D's built-in DSP **cannot** be used for:
- Linkwitz Transform extending response below 20 Hz
- Subsonic high-pass filters below 20 Hz (e.g., 5 Hz or 10 Hz protection filters)
- Any EQ or filter work in the infrasonic range

For subwoofer systems requiring processing below 20 Hz, an external DSP is mandatory (e.g., miniDSP 2x4 HD, which supports custom biquad coefficients at any frequency).

## Common Features (Both Models)

- **SmartSense Technology**: Loudspeaker impedance compensation for linear frequency response at any load
- **Zero-Attack Limiters**: Maximum output with reliable overload protection
- **Built-in Crossover Switch**: FULLRANGE, LF (<100 Hz), HF (>100 Hz) modes
- **Protection Circuits**: Over-current, over-temperature, DC protection
- **Variable Speed Fan**: Auto-adjusting for thermal management
- **Circuit Breaker**: Resettable protection (no fuses to replace)

## LED Indicators

| LED | Function |
|-----|----------|
| SIGNAL (4-segment) | Input signal level |
| LIMIT | Limiter activation (reduce gain if continuously lit) |
| PROTECT | Fault condition (over-current, over-temp, etc.) |
| POWER | Unit powered on |

## Minimum Load Impedance

| Mode | Minimum Load |
|------|--------------|
| Stereo | 2Ω per channel (verify with manual) |
| Bridge (NX6000D only) | 4Ω |

## Practical Implications for Home Theater Use

### Using NX6000 (No Bridge)

Since bridge mode is unavailable, the NX6000 must operate in stereo mode:
- Each channel drives a separate speaker/cabinet
- Maximum 3,000W per channel @ 4Ω
- Total system power: 6,000W (if both channels used)
- Signal must be split (Y-cable or DSP routing) to feed both channels

### Using NX6000D (Bridge Available)

The NX6000D offers more flexibility:
- Can bridge for mono operation at higher power into higher impedance loads
- Built-in DSP eliminates need for external processing **above 20 Hz**
- Crossover and EQ can be configured directly on the amp

### Deep Bass / Infrasonic Applications

For systems requiring response extension below 20 Hz (Linkwitz Transform, subsonic filtering):

| Component | Can Handle Sub-20Hz? |
|-----------|---------------------|
| NX6000 DSP | N/A (no DSP) |
| NX6000D DSP | **NO** - 20 Hz minimum |
| miniDSP 2x4 HD | **YES** - custom biquads |
| miniDSP 10x10 HD | **YES** - custom biquads |

**Recommendation:** Use NX6000 or NX6000D as power amplifier only, with external DSP (miniDSP 2x4 HD) handling all sub-20 Hz processing including Linkwitz Transform and subsonic protection.

## Power Consumption

| Condition | Power Draw |
|-----------|------------|
| 1/8 rated power @ 4Ω | 620W |

Note: Maximum continuous power output is limited by AC mains capacity. A standard 15A circuit provides ~1,800W maximum, limiting real-world continuous output regardless of amplifier ratings.

## Fan Noise Consideration

Both models use variable-speed cooling fans that can be audible in quiet environments. For home theater use in the listening room, consider:
- Locating the amplifier in a separate equipment room
- Fan modification (third-party, voids warranty)
- Alternative amplifiers with quieter cooling

## Price Reference (Approximate, 2024-2025)

| Model | Street Price |
|-------|--------------|
| NX6000 | ~$400-450 |
| NX6000D | ~$500-550 |

## Summary: NX6000 vs NX6000D

| Feature | NX6000 | NX6000D |
|---------|--------|---------|
| Power Output | Same | Same |
| Bridge Mode | **NO** | Yes |
| Built-in DSP | No | Yes (delay, EQ, crossover, dynamics) |
| DSP Minimum Frequency | N/A | **20 Hz** |
| Front Panel LCD | No | Yes |
| USB Control | No | Yes (NX EDIT software) |
| Price | Lower | Higher |

## Recommendation for Subwoofer Applications

- **NX6000**: Use in STEREO mode with separate cabinet per channel. Requires external DSP for crossover/EQ. Good value choice when external DSP is already planned.
- **NX6000D**: More versatile with built-in processing above 20 Hz. Can bridge if needed. The DSP is useful for delays and mid/high crossovers but **cannot handle sub-20 Hz processing**.

For the nearfield subwoofer application with 2 cabinets (4Ω each) requiring Linkwitz Transform to 10 Hz:
- **Either NX6000 or NX6000D** works as the power amp
- **External miniDSP 2x4 HD required** for LT and subsonic HPF regardless of amp choice
- One amp per couch in STEREO mode: Channel A → Cabinet 1, Channel B → Cabinet 2
- Real-world power: **~1,000-1,200W per channel @ 4Ω** at 10Hz (see Real-World Power section)
- Still provides **15+ dB headroom** above 95 dB target

## NX6000 / NX6000D Interchangeability

For applications using external DSP for sub-20Hz processing (Linkwitz Transform, subsonic HPF), the NX6000 and NX6000D are **fully interchangeable**. Purchase whichever is available at time of build.

| Shared Capability | Rated | Real-World |
|-------------------|-------|------------|
| Power @ 4Ω | 3,000W/ch | ~1,200-1,600W/ch |
| Power @ 4Ω (10Hz) | 3,000W/ch | ~1,000W/ch |
| Power @ 8Ω | 1,600W/ch | ~800-1,000W/ch |
| Stereo mode | Yes (both) | - |
| Input connectors | XLR / ¼" TRS combo | - |
| Output connectors | NL4 Speakon | - |
| Rack size | 2U | - |
| Weight | ~13 lbs | - |

The NX6000D's additional features (bridge mode, built-in DSP, LCD, USB control) are not required when:
- Operating in stereo mode (one channel per cabinet)
- Using external DSP for all filtering below 20 Hz

**Documentation convention:** References to "NX6000" in system designs should be interpreted as "NX6000 or NX6000D" unless bridge mode or built-in DSP is specifically required.
