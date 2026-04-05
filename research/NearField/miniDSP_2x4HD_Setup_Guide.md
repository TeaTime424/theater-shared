# ══════════════════════════════════════════════════════════════════════════════
# miniDSP 2x4 HD SETUP GUIDE
# Nearfield Subwoofer Linkwitz Transform Configuration
# ══════════════════════════════════════════════════════════════════════════════

## PREREQUISITES

- miniDSP 2x4 HD hardware
- miniDSP 2x4 HD plugin software installed
- USB cable for configuration
- Sample rate: 96 kHz (Dirac Live DISABLED)

## STEP 1: CONNECT AND LAUNCH SOFTWARE

1. Connect miniDSP 2x4 HD to computer via USB
2. Launch "miniDSP 2x4 HD" plugin software
3. Click "Connect" to establish communication

## STEP 2: VERIFY SAMPLE RATE

1. Go to: **Settings** (gear icon)
2. Confirm **Sample Rate: 96 kHz**
3. If Dirac Live is enabled, DISABLE it (coefficients are calculated for 96 kHz)

⚠️ If you must use 48 kHz, the biquad coefficients must be recalculated!

## STEP 3: CONFIGURE ROUTING MATRIX

Navigate to: **Routing** tab

Set the routing matrix as follows:

```
                 OUT 1    OUT 2    OUT 3    OUT 4
              ┌────────┬────────┬────────┬────────┐
    INPUT 1   │   ✓    │   ✓    │        │        │
              ├────────┼────────┼────────┼────────┤
    INPUT 2   │        │        │        │        │
              └────────┴────────┴────────┴────────┘
```

- Check boxes for: Input 1 → Output 1, Input 1 → Output 2
- All other routing boxes: UNCHECKED

## STEP 4: CONFIGURE INPUT

Navigate to: **Input** tab

### Input 1 Settings:
| Parameter | Value |
|-----------|-------|
| Gain | **0 dB** |
| PEQ | All bands **BYPASSED** |

### Input 2 Settings:
| Parameter | Value |
|-----------|-------|
| Gain | 0 dB |
| PEQ | All bands BYPASSED |
| (Not used) | |

## STEP 5: CONFIGURE OUTPUT 1 PEQ (Custom Biquads)

Navigate to: **Output** tab → **Output 1** → **PEQ**

### Enable Advanced/Custom Biquad Mode:
- Click the **Advanced** or **Biquad** button to enable custom coefficient entry
- You need to enter coefficients for 3 biquad filters

### BIQUAD 1: Linkwitz Transform
```
b0 =  1.0009457376
b1 = -1.9990705154
b2 =  0.9981326947
a1 = -1.9990742598
a2 =  0.9990746880
```

### BIQUAD 2: Subsonic HPF (Section 1)
```
b0 =  0.9997685917
b1 = -1.9995371834
b2 =  0.9997685917
a1 = -1.9995371298
a2 =  0.9995372369
```

### BIQUAD 3: Subsonic HPF (Section 2)
```
b0 =  0.9997685917
b1 = -1.9995371834
b2 =  0.9997685917
a1 = -1.9995371298
a2 =  0.9995372369
```

### Remaining Biquad Slots (4-10):
- Set to **BYPASS** or leave as flat (all b=0, a=0 or default)

## STEP 6: CONFIGURE OUTPUT 1 SETTINGS

Still in **Output 1**:

| Parameter | Value |
|-----------|-------|
| **Gain** | **0 dB** (adjust later if needed) |
| **Delay** | **0.00 ms** (adjust for time alignment) |
| **Polarity** | **Normal (0°)** |
| **Mute** | **OFF** |

### Crossover Settings (Output 1):
| Filter | Setting |
|--------|---------|
| **HPF** | **BYPASS** (using custom biquad) |
| **LPF** | **BYPASS** (or 80-100 Hz optional) |

## STEP 7: CONFIGURE OUTPUT 2 (COPY FROM OUTPUT 1)

Navigate to: **Output** tab → **Output 2** → **PEQ**

**Option A: Manual Copy**
Enter the exact same biquad coefficients as Output 1:
- Biquad 1: Linkwitz Transform (same coefficients)
- Biquad 2: Subsonic HPF Section 1 (same coefficients)
- Biquad 3: Subsonic HPF Section 2 (same coefficients)

**Option B: Use Copy Function (if available)**
- Right-click Output 1 → Copy
- Right-click Output 2 → Paste

### Output 2 Settings:
| Parameter | Value |
|-----------|-------|
| **Gain** | **0 dB** (match Output 1) |
| **Delay** | **0.00 ms** (match Output 1) |
| **Polarity** | **Normal (0°)** ← NOT inverted! |
| **Mute** | **OFF** |

### Crossover Settings (Output 2):
| Filter | Setting |
|--------|---------|
| **HPF** | **BYPASS** |
| **LPF** | **BYPASS** |

## STEP 8: DISABLE UNUSED OUTPUTS

Navigate to: **Output 3** and **Output 4**

| Parameter | Value |
|-----------|-------|
| Mute | **ON** (muted) |
| Gain | 0 dB |
| All PEQ | BYPASS |

## STEP 9: MASTER VOLUME

Navigate to: **Output** tab → **Master**

| Parameter | Value |
|-----------|-------|
| Master Volume | **0 dB** (adjust as needed) |
| Mute | **OFF** |

## STEP 10: SAVE CONFIGURATION

1. Click **Synchronize** to write settings to hardware
2. Go to: **File** → **Save Configuration**
3. Save as: `Nearfield_LT_96kHz.xml` (or similar)

## STEP 11: VERIFY CONFIGURATION

### Visual Check:
The PEQ frequency response graph should show:
- Large boost below ~43 Hz (Linkwitz Transform)
- Steep rolloff below ~5 Hz (Subsonic HPF)
- Flat response above ~50 Hz

### Expected Response Shape:
```
     +25 │                    
         │         ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
     +20 │        ╱
         │       ╱
     +15 │      ╱
         │     ╱
     +10 │    ╱
         │   ╱
      +5 │  ╱
         │ ╱
       0 │╱─────────────────────────────
         │
      -5 │
         │╲
     -10 │ ╲
         │  ╲
     -20 │   ╲
         └────┬────┬────┬────┬────┬────
              5   10   20   40   80  160 Hz
```

## CONFIGURATION SUMMARY TABLE

| Section | Parameter | Value |
|---------|-----------|-------|
| **Sample Rate** | | 96 kHz |
| **Routing** | Input 1 → Out 1 | ✓ ON |
| **Routing** | Input 1 → Out 2 | ✓ ON |
| **Routing** | All others | OFF |
| **Input 1** | Gain | 0 dB |
| **Input 1** | PEQ | All BYPASS |
| **Output 1** | Biquad 1 | LT (see coefficients) |
| **Output 1** | Biquad 2 | HPF Sec 1 (see coefficients) |
| **Output 1** | Biquad 3 | HPF Sec 2 (see coefficients) |
| **Output 1** | Gain | 0 dB |
| **Output 1** | Delay | 0 ms |
| **Output 1** | Polarity | Normal |
| **Output 1** | HPF/LPF | BYPASS |
| **Output 2** | Biquad 1-3 | Same as Output 1 |
| **Output 2** | Gain | 0 dB |
| **Output 2** | Delay | 0 ms |
| **Output 2** | Polarity | Normal |
| **Output 2** | HPF/LPF | BYPASS |
| **Output 3-4** | Mute | ON |
| **Master** | Volume | 0 dB |

## TROUBLESHOOTING

### If response looks inverted or wrong:
Try alternate coefficient signs (some firmware versions invert a1/a2):

**Biquad 1 (Alternate):**
```
b0 =  1.0009457376
b1 = -1.9990705154
b2 =  0.9981326947
a1 =  1.9990742598    ← POSITIVE
a2 = -0.9990746880    ← NEGATIVE
```

**Biquad 2 & 3 (Alternate):**
```
b0 =  0.9997685917
b1 = -1.9995371834
b2 =  0.9997685917
a1 =  1.9995371298    ← POSITIVE
a2 = -0.9995372369    ← NEGATIVE
```

### If no bass output:
- Check routing matrix (Input 1 must route to both outputs)
- Check output mutes are OFF
- Verify physical connections

### If distortion/clipping:
- Reduce Input 1 gain (try -6 dB)
- Or reduce Output 1 & 2 gains equally
- Monitor miniDSP clip indicators in software

## PHYSICAL CONNECTIONS

```
┌──────────────────────────────────────────────────────────────────┐
│                    miniDSP 2x4 HD REAR PANEL                     │
│                                                                  │
│   ┌─────────┐                              ┌─────────────────┐   │
│   │ INPUT 1 │ ← Summed Sub Signal (XLR)    │     USB         │   │
│   │  (XLR)  │                              │  (to computer)  │   │
│   └─────────┘                              └─────────────────┘   │
│   ┌─────────┐                                                    │
│   │ INPUT 2 │    (not used)                                      │
│   │  (XLR)  │                                                    │
│   └─────────┘                                                    │
│                                                                  │
│   ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐            │
│   │ OUTPUT1 │  │ OUTPUT2 │  │ OUTPUT3 │  │ OUTPUT4 │            │
│   │  (XLR)  │  │  (XLR)  │  │  (XLR)  │  │  (XLR)  │            │
│   └────┬────┘  └────┬────┘  └─────────┘  └─────────┘            │
│        │            │         (unused)     (unused)              │
└────────┼────────────┼────────────────────────────────────────────┘
         │            │
         ▼            ▼
    NX6000 CH.A   NX6000 CH.B
    
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
│   from miniDSP  from miniDSP    Cabinet 1    Cabinet 2          │
│     Output 1      Output 2        (4Ω)         (4Ω)             │
│                                                                  │
│   MODE SWITCH: [STEREO]                                          │
└──────────────────────────────────────────────────────────────────┘
```

## BIQUAD COEFFICIENTS QUICK REFERENCE

Copy-paste ready format:

### Biquad 1 - Linkwitz Transform
| Coeff | Value |
|-------|-------|
| b0 | 1.0009457376 |
| b1 | -1.9990705154 |
| b2 | 0.9981326947 |
| a1 | -1.9990742598 |
| a2 | 0.9990746880 |

### Biquad 2 - HPF Section 1
| Coeff | Value |
|-------|-------|
| b0 | 0.9997685917 |
| b1 | -1.9995371834 |
| b2 | 0.9997685917 |
| a1 | -1.9995371298 |
| a2 | 0.9995372369 |

### Biquad 3 - HPF Section 2
| Coeff | Value |
|-------|-------|
| b0 | 0.9997685917 |
| b1 | -1.9995371834 |
| b2 | 0.9997685917 |
| a1 | -1.9995371298 |
| a2 | 0.9995372369 |

---
Document: miniDSP_2x4HD_Setup_Guide.md
Version: 1.0
For: Nearfield Subwoofer System (8× UMII10-22, NX6000 Stereo)
