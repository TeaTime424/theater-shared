# V3 Nearfield Amplifier Configuration

## Amplifier Selection

### Behringer NX6000 / NX6000D

| Specification | Value |
|---------------|-------|
| Model | NX6000 or NX6000D |
| Configuration | **Stereo Mode** |
| Load per Channel | 4Ω |
| Units Required | 2 (one per couch) |
| Price | ~$433-500 each |

---

## Power Specifications

### Manufacturer Rated

| Load | Power per Channel |
|------|-------------------|
| 8Ω | 1,600W |
| 4Ω | 3,000W |
| 2Ω | 6,000W |

### Real-World (Forum-Verified)

| Frequency | Rated @ 4Ω | Real-World @ 4Ω |
|-----------|------------|-----------------|
| 40Hz+ | 3,000W | 1,600-2,000W |
| 20-40Hz | 3,000W | 1,200-1,600W |
| **<20Hz** | 3,000W | **800-1,200W** |

**Design Figure @ 10Hz:** 1,000W per channel (conservative)

---

## NX6000 vs NX6000D

| Feature | NX6000 | NX6000D |
|---------|--------|---------|
| Power | Same | Same |
| DSP | None | Built-in |
| Price | ~$433 | ~$500 |
| Recommendation | ✓ Use | OK |

**Note:** DSP not needed since miniDSP 2x4 HD handles all processing upstream.

---

## Wiring Diagram (Per Couch)

```
┌─────────────────────────────────────────────────────────────────┐
│                    miniDSP 2x4 HD                               │
│                                                                 │
│   OUTPUT 1 ──────────────────────► XLR Cable                    │
│   OUTPUT 2 ──────────────────────► XLR Cable                    │
└───────────────────────────────────────┬─────────────────────────┘
                                        │
                                        ▼
┌─────────────────────────────────────────────────────────────────┐
│                  NX6000 REAR PANEL                              │
│                                                                 │
│   ┌─────────┐  ┌─────────┐      ┌─────────┐  ┌─────────┐        │
│   │  CH.A   │  │  CH.B   │      │  CH.A   │  │  CH.B   │        │
│   │  INPUT  │  │  INPUT  │      │ OUTPUT  │  │ OUTPUT  │        │
│   │  (XLR)  │  │  (XLR)  │      │(Speakon)│  │(Speakon)│        │
│   └────┬────┘  └────┬────┘      └────┬────┘  └────┬────┘        │
│        │            │                │            │              │
│        ▲            ▲                ▼            ▼              │
│   from miniDSP  from miniDSP    Cabinet L    Cabinet R          │
│     Output 1      Output 2        (4Ω)         (4Ω)             │
└─────────────────────────────────────────────────────────────────┘

NX6000 FRONT PANEL:
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   [POWER]   [CH.A GAIN]   [CH.B GAIN]   [MODE: STEREO]         │
│      ●          ◐              ◐            [●]                 │
│                                                                 │
│   [LIMIT A]              [LIMIT B]                              │
│      ○                      ○            (should NOT illuminate │
│                                           during normal use)    │
└─────────────────────────────────────────────────────────────────┘
```

---

## Front Panel Settings

| Control | Setting |
|---------|---------|
| Power | ON |
| Mode | **STEREO** |
| CH.A Gain | 12 o'clock (adjust during calibration) |
| CH.B Gain | Match CH.A |

---

## Mode Switch Position

```
         ┌─────────────────┐
         │   MODE SWITCH   │
         │                 │
         │  [ ] PARALLEL   │
         │  [ ] BRIDGE     │
         │  [●] STEREO  ◄──┼── USE THIS
         │                 │
         └─────────────────┘
```

**IMPORTANT:** Must be in STEREO mode for independent channel operation.

---

## Rear Panel Connections

### Inputs (from miniDSP)

| Input | Connection |
|-------|------------|
| CH.A Input (XLR) | miniDSP Output 1 |
| CH.B Input (XLR) | miniDSP Output 2 |

### Outputs (to Cabinets)

| Output | Connection | Load |
|--------|------------|------|
| CH.A Output (Speakon) | Cabinet L | 4Ω |
| CH.B Output (Speakon) | Cabinet R | 4Ω |

---

## Speakon Wiring

### NL4 Speakon Pinout

| Pin | Function |
|-----|----------|
| 1+ | Hot (+) |
| 1- | Return (-) |
| 2+ | Not used |
| 2- | Not used |

### Cable Assembly

```
    NX6000 Output                Cabinet Terminal
    ┌─────────┐                    ┌─────────┐
    │  1+ ●───┼────────────────────┼───● 1+  │
    │  1- ●───┼────────────────────┼───● 1-  │
    │  2+ ○   │                    │   ○ 2+  │
    │  2- ○   │                    │   ○ 2-  │
    └─────────┘                    └─────────┘
```

---

## Gain Structure

### Signal Chain Levels

| Stage | Level | Notes |
|-------|-------|-------|
| AVR Sub Out | 0 dBu | Reference |
| miniDSP Input | 0 dBu | Unity gain |
| miniDSP Output | 0 dBu | Adjust as needed |
| NX6000 Input | 0 dBu | After XLR cable |
| NX6000 Gain | 12 o'clock | Starting point |

### Calibration Procedure

1. Set miniDSP output gain to **0 dB**
2. Set NX6000 gains to **12 o'clock**
3. Play 10 Hz test tone at moderate level
4. Monitor NX6000 **LIMIT LED**:
   - Should NOT illuminate during normal playback
   - Occasional flicker on peaks is acceptable
5. If LIMIT LED stays on:
   - Reduce miniDSP output gain by 3 dB
   - Repeat test
6. Calibrate with AVR/processor to achieve 95 dB target

---

## Thermal Considerations

### Operating Environment

| Condition | Recommendation |
|-----------|----------------|
| Location | Ventilated rack or open area |
| Clearance | 1U above and below |
| Airflow | Do not block front/rear vents |
| Temperature | <35°C ambient |

### Fan Modification (Optional)

Stock fans can be loud. Community-recommended mod:
- Replace stock fans with Noctua NF-A4x20 FLX
- Reduces noise significantly
- Maintains adequate cooling for home theater duty

---

## Protection Features

| Feature | Behavior |
|---------|----------|
| Thermal Protection | Auto-limits output when hot |
| Clip Limiting | Soft limiting prevents hard clipping |
| DC Protection | Disconnects output on DC fault |
| Short Protection | Survives brief shorts |

---

## Troubleshooting

| Symptom | Cause | Solution |
|---------|-------|----------|
| No output | Mode switch wrong | Set to STEREO |
| LIMIT LED always on | Gain too high | Reduce miniDSP output |
| Distortion | Clipping | Reduce input level |
| Overheating | Poor ventilation | Improve airflow |
| Hum/buzz | Ground loop | Use ground lift adapter |

---

## Equipment List (Per Couch)

| Item | Qty | Unit Price | Total |
|------|-----|------------|-------|
| Behringer NX6000 | 1 | $433 | $433 |
| XLR Cable (6ft) | 2 | $10 | $20 |
| Speakon Cable (10ft) | 2 | $15 | $30 |
| **Subtotal** | | | **$483** |

---

*Document Version: 3.0*
*Created: December 2024*
