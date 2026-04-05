# ══════════════════════════════════════════════════════════════════════════════
# NEARFIELD SUBWOOFER - CORRECTED CONFIGURATION
# NX6000 HAS NO BRIDGE MODE
# ══════════════════════════════════════════════════════════════════════════════

## ⚠️ CRITICAL CORRECTION

**The NX6000 CANNOT be bridged.** The manual explicitly states:

> "MODE SWITCH Choose the amplifier mode by toggling the sliding MODE SWITCH 
> between the MONO, STEREO, and BRIDGE positions **(NX6000: no BRIDGE mode.)**"

The NX6000 is internally already a bridged design (two NX3000 modules bridged internally).

---

## NX6000 Power Output (STEREO Mode)

| Load | Power per Channel |
|------|-------------------|
| 2Ω | 3,000W (check min impedance) |
| **4Ω** | **3,000W** ← Target |
| 8Ω | 1,600W |
| 16Ω | ~800W (estimated) |

---

## CORRECTED DRIVER WIRING: 2s2p per Cabinet

**Configuration:** 2 series pairs in parallel = **4Ω per cabinet**

```
CABINET 1 (4Ω)                      CABINET 2 (4Ω)
┌────────────────────────┐          ┌────────────────────────┐
│                        │          │                        │
│  D1──D2 (8Ω) ──┬── (+) │          │  D5──D6 (8Ω) ──┬── (+) │
│                │       │          │                │       │
│  D3──D4 (8Ω) ──┴── (-) │          │  D7──D8 (8Ω) ──┴── (-) │
│                        │          │                        │
│  8Ω ∥ 8Ω = 4Ω          │          │  8Ω ∥ 8Ω = 4Ω          │
└───────────┬────────────┘          └───────────┬────────────┘
            │                                   │
            ▼                                   ▼
        NX6000 CH.A                         NX6000 CH.B
        (3,000W @ 4Ω)                       (3,000W @ 4Ω)
```

### Impedance Calculation

| Stage | Calculation | Result |
|-------|-------------|--------|
| Per driver | DVC coils in series | 4Ω |
| 2 drivers series | 4Ω + 4Ω | 8Ω |
| 2 pairs parallel | 8Ω ∥ 8Ω | **4Ω per cabinet** |

---

## AMPLIFIER CONNECTION

```
┌─────────────────────────────────────────────────────────────────┐
│                      NX6000 REAR PANEL                          │
│                                                                 │
│     CH.A INPUT              CH.B INPUT                          │
│     (from miniDSP Out 1)    (from miniDSP Out 2)                │
│         │                        │                              │
│         ▼                        ▼                              │
│     ┌───────┐                ┌───────┐                          │
│     │ XLR   │                │ XLR   │                          │
│     └───────┘                └───────┘                          │
│                                                                 │
│     CH.A OUTPUT              CH.B OUTPUT                        │
│     (Speakon)                (Speakon)                          │
│         │                        │                              │
│         ▼                        ▼                              │
│     CABINET 1                CABINET 2                          │
│       (4Ω)                     (4Ω)                             │
│                                                                 │
│     MODE SWITCH: STEREO                                         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## COMPLETE SIGNAL CHAIN (CORRECTED)

```
┌─────────────────┐
│   Marantz AV10  │
│   Sub 1-4 Out   │
└────────┬────────┘
         │ 4× Analog
         ▼
┌─────────────────┐
│ miniDSP 10x10HD │  ← Sums 4 channels to 1
└────────┬────────┘
         │ 1× Analog
         ▼
┌─────────────────┐
│ miniDSP 2x4 HD  │  ← LT + HPF biquads
│                 │
│  Output 1 ──────────→ NX6000 CH.A
│  Output 2 ──────────→ NX6000 CH.B
│  (same signal)  │
└─────────────────┘
         
┌─────────────────────────────┐
│        NX6000               │
│   MODE: STEREO              │
│                             │
│   CH.A          CH.B        │
│  3000W @4Ω    3000W @4Ω     │
└────┬──────────────┬─────────┘
     │              │
     ▼              ▼
┌─────────┐    ┌─────────┐
│CABINET 1│    │CABINET 2│
│  2s2p   │    │  2s2p   │
│  (4Ω)   │    │  (4Ω)   │
└─────────┘    └─────────┘
```

---

## POWER ANALYSIS (CORRECTED)

| Configuration | Value |
|---------------|-------|
| Load per channel | 4Ω |
| Power per channel | 3,000W |
| **Total system power** | **6,000W** |

### For 95 dB @ 10 Hz (with LT):

| Metric | Value |
|--------|-------|
| Required power | ~49W total |
| Available power | 6,000W |
| **Headroom** | **~21 dB** |

### For MAX output @ 10 Hz (113 dB):

| Metric | Value |
|--------|-------|
| Required power | ~3,235W total |
| Available power | 6,000W |
| **Headroom** | **~2.7 dB** |

---

## KEY CORRECTION

| Original (Wrong) | Corrected |
|------------------|-----------|
| NX6000 bridged @ 8Ω | NX6000 **STEREO** @ 4Ω per channel |
| 1,600W (doesn't exist!) | **6,000W total** |
| 4 series per cabinet (16Ω) | **2s2p per cabinet (4Ω)** |
| Both cabinets parallel | **Each cabinet to separate channel** |

**The corrected configuration actually provides 3.75× MORE power!**

---

## miniDSP 2x4 HD Routing

Route the same processed signal to both outputs:

| Output | Destination |
|--------|-------------|
| Output 1 | NX6000 Channel A → Cabinet 1 |
| Output 2 | NX6000 Channel B → Cabinet 2 |

Both outputs use the same biquads (LT + HPF).
