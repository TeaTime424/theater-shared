# Nearfield Subwoofer Amplifier Configuration - V3 Cabinet Design

## System Overview

| Parameter | Value |
|-----------|-------|
| **Cabinet Design** | V3 (48"×30"×12") |
| **Drivers per Cabinet** | 4× UMII10-22 |
| **Wiring** | 2s2p = 4Ω per cabinet |
| **Cabinets per Couch** | 2 |
| **Total Cabinets** | 4 |
| **Total Drivers** | 16 |

---

## V3 Cabinet Acoustic Parameters

| Parameter | Value |
|-----------|-------|
| Net Volume | ~5.7 ft³ |
| Volume per Driver | 40.3 L |
| **Fc** | **38 Hz** |
| **Qtc** | **0.88** |
| Natural F3 | ~32 Hz |

---

## Amplifier Selection

### Behringer NX6000 or NX6000D

| Specification | Value |
|---------------|-------|
| Configuration | **Stereo Mode** |
| Load per Channel | 4Ω (one cabinet) |
| Amps per Couch | 1 |
| Total Amps | 2 |

### Real-World Power Output (Forum-Verified)

| Frequency | Rated | Real-World |
|-----------|-------|------------|
| 40Hz+ | 3,000W/ch | 1,600-2,000W/ch |
| 20-40Hz | 3,000W/ch | 1,200-1,600W/ch |
| **<20Hz** | 3,000W/ch | **800-1,200W/ch** |
| **Both channels** | 6,000W total | **2,000-2,400W total** |

Conservative design figure @ 10Hz: ~1,000W per channel

---

## Signal Chain (Per Couch)

```
Summed Sub Signal (Mono)
         │
         ▼
   miniDSP 2x4 HD
         │
         ├─► Output 1 → NX6000 CH.A → Cabinet L (4Ω)
         └─► Output 2 → NX6000 CH.B → Cabinet R (4Ω)
```

---

## Power Budget Analysis (V3 Cabinet)

### Target: 95 dB @ 10 Hz @ 18" Distance

| Parameter | Value |
|-----------|-------|
| Required Power | ~49W total |
| Available Power | ~2,000W (real-world) |
| **Headroom** | **~16 dB** |

### V3 vs Original Boost Comparison

| Design | Boost @ 10Hz | Power Headroom |
|--------|--------------|----------------|
| Original (Fc=43, Qtc=1.0) | +21.6 dB | 16 dB |
| **V3 (Fc=38, Qtc=0.88)** | **+19.5 dB** | **~18 dB** |

The V3 cabinet requires ~2 dB less boost, improving power headroom.

### Maximum SPL @ 10 Hz (Amplifier-Limited)

| Target SPL | Power Required | Status |
|------------|----------------|--------|
| 95 dB | 49W | ✓ 16+ dB headroom |
| 100 dB | 155W | ✓ 11+ dB headroom |
| 105 dB | 490W | ✓ 6+ dB headroom |
| 110 dB | 1,550W | ✓ Achievable |
| **111 dB** | **1,950W** | ⚠️ Near amp limit |

---

## NX6000 Configuration

### Front Panel Settings

| Control | Setting |
|---------|---------|
| Mode | **STEREO** |
| CH.A Gain | 12 o'clock (adjust during calibration) |
| CH.B Gain | Match CH.A |

### Rear Panel Connections

```
┌──────────────────────────────────────────────────────────────────┐
│                    NX6000 REAR PANEL                             │
│                                                                  │
│   ┌─────────┐  ┌─────────┐      ┌─────────┐  ┌─────────┐        │
│   │  CH.A   │  │  CH.B   │      │  CH.A   │  │  CH.B   │        │
│   │  INPUT  │  │  INPUT  │      │ OUTPUT  │  │ OUTPUT  │        │
│   │  (XLR)  │  │  (XLR)  │      │(Speakon)│  │(Speakon)│        │
│   └────┬────┘  └────┬────┘      └────┬────┘  └────┬────┘        │
│        │            │                │            │              │
│        ▲            ▲                ▼            ▼              │
│   from miniDSP  from miniDSP    Cabinet L    Cabinet R          │
│     Output 1      Output 2        (4Ω)         (4Ω)             │
└──────────────────────────────────────────────────────────────────┘
```

---

## Wiring per Cabinet

### 4× UMII10-22, 2s2p = 4Ω

```
         ┌─────────────────┐
         │    SPEAKON+     │
         │                 │
    ┌────┴────┐       ┌────┴────┐
    │ Driver 1 │       │ Driver 2 │
    │   4Ω     │       │   4Ω     │
    │  (2+2Ω)  │       │  (2+2Ω)  │
    └────┬────┘       └────┬────┘
         │ (series)        │
    ┌────┴────┐       ┌────┴────┐
    │ Driver 3 │       │ Driver 4 │
    │   4Ω     │       │   4Ω     │
    │  (2+2Ω)  │       │  (2+2Ω)  │
    └────┬────┘       └────┬────┘
         │                 │
         └────────┬────────┘
              (parallel)
                  │
            SPEAKON- (4Ω)
```

**Voice Coil Wiring:** Series (2Ω + 2Ω = 4Ω per driver)

---

## Calibration Procedure

1. Set NX6000 gains to 12 o'clock
2. Set miniDSP output gains to 0 dB
3. Play 10 Hz test tone at moderate level
4. Monitor NX6000 LIMIT LED:
   - Should NOT illuminate during normal playback
   - Occasional flicker on peaks is acceptable
5. If LIMIT LED stays on:
   - Reduce miniDSP output gain by 3 dB
   - Repeat test
6. Calibrate with AVR/processor to achieve target SPL

---

## Equipment List (Per Couch)

| Item | Qty | Unit Cost | Total |
|------|-----|-----------|-------|
| Behringer NX6000/NX6000D | 1 | $433-500 | $433-500 |
| miniDSP 2x4 HD | 1 | $225 | $225 |
| XLR cables (6ft) | 2 | $10 | $20 |
| Speakon cables | 2 | $15 | $30 |
| **Subtotal** | | | **$708-755** |

---

## Document History

- v1.0 - Initial (8-driver cabinet, Fc=43Hz)
- v2.0 - Real-world power analysis added
- **v3.0** - V3 cabinet design (4-driver, Fc=38Hz, Qtc=0.88)
  - Updated acoustic parameters
  - ~2 dB less boost required
  - Improved power headroom

---

*Document: Nearfield_Amp_Config.md*
*Version: 3.0*
*Updated: December 2024*
