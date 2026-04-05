# V3 Nearfield DSP Configuration

## DSP Selection

### miniDSP 2x4 HD

| Specification | Value |
|---------------|-------|
| Model | 2x4 HD |
| Sample Rate | 96 kHz |
| Units Required | 2 (one per couch) |
| Price | ~$225 each |
| Link | [miniDSP](https://www.minidsp.com/products/minidsp-in-a-box/minidsp-2x4-hd) |

---

## Why miniDSP 2x4 HD?

| Requirement | Dayton DSP-408 | miniDSP 2x4 HD |
|-------------|----------------|----------------|
| HPF below 20Hz | ✗ Min 20Hz | ✓ Custom biquad |
| Linkwitz Transform | ✗ No custom biquad | ✓ Full biquad support |
| 10 Hz processing | ✗ Cannot configure | ✓ Works to DC |

The Dayton DSP-408's HPF minimum is 20Hz, making it unsuitable for 10Hz Linkwitz Transform.

---

## Signal Flow

```
AVR Subwoofer Output (Mono)
         │
         ▼
┌─────────────────────────────────────────────────────────────────┐
│                    miniDSP 2x4 HD                               │
│                                                                 │
│  INPUT 1 ──────────────────────────────────────────────────     │
│     │                                                           │
│     ├──► [BIQUAD 1: Linkwitz Transform]                         │
│     │    Fc=38Hz, Qtc=0.88 → Fp=10Hz, Qp=0.707                  │
│     │                                                           │
│     ├──► [BIQUAD 2: Subsonic HPF 5Hz]                           │
│     │    12 dB/octave                                           │
│     │                                                           │
│     ├──► [BIQUAD 3: Subsonic HPF 5Hz]                           │
│     │    12 dB/octave (cascaded = 24 dB/oct total)              │
│     │                                                           │
│     ├──────────────────────────────────────► OUTPUT 1           │
│     └──────────────────────────────────────► OUTPUT 2           │
│                                                                 │
│  INPUT 2   (unused)                                             │
│  OUTPUT 3  (unused)                                             │
│  OUTPUT 4  (unused)                                             │
└─────────────────────────────────────────────────────────────────┘
         │                    │
         ▼                    ▼
   NX6000 CH.A          NX6000 CH.B
```

---

## Routing Matrix

```
┌─────────┬──────────┬──────────┬──────────┬──────────┐
│         │ Output 1 │ Output 2 │ Output 3 │ Output 4 │
├─────────┼──────────┼──────────┼──────────┼──────────┤
│ Input 1 │   ON ✓   │   ON ✓   │   OFF    │   OFF    │
│ Input 2 │   OFF    │   OFF    │   OFF    │   OFF    │
└─────────┴──────────┴──────────┴──────────┴──────────┘
```

---

## V3 Cabinet Parameters

| Parameter | Value |
|-----------|-------|
| Net Volume per Driver | 40.3 L |
| **Fc** | **38 Hz** |
| **Qtc** | **0.88** |

---

## Biquad Coefficients (96 kHz Sample Rate)

### IMPORTANT: miniDSP 2x4 HD Sign Convention

```
Standard DSP:    H(z) = (b0 + b1*z^-1 + b2*z^-2) / (1 + a1*z^-1 + a2*z^-2)
miniDSP 2x4 HD:  H(z) = (b0 + b1*z^-1 + b2*z^-2) / (1 - a1*z^-1 - a2*z^-2)
```

**Result:** a1 is POSITIVE, a2 is NEGATIVE (opposite of standard convention)

---

## Biquad 1: Linkwitz Transform

Transforms sealed box response from Fc=38Hz, Qtc=0.88 to Fp=10Hz, Qp=0.707

```
biquad1,
b0=1.0009512511,
b1=-1.9990713825,
b2=0.9981263141,
a1=1.9990742598,
a2=-0.9990746880
```

---

## Biquad 2: Subsonic HPF (1 of 2)

Butterworth HPF @ 5 Hz, Q = 0.707

```
biquad2,
b0=0.9997685917,
b1=-1.9995371834,
b2=0.9997685917,
a1=1.9995371298,
a2=-0.9995372369
```

---

## Biquad 3: Subsonic HPF (2 of 2)

Identical to Biquad 2, cascaded for 24 dB/octave total

```
biquad3,
b0=0.9997685917,
b1=-1.9995371834,
b2=0.9997685917,
a1=1.9995371298,
a2=-0.9995372369
```

---

## Complete Paste Block

Copy and paste into miniDSP software for each output:

```
biquad1,
b0=1.0009512511,
b1=-1.9990713825,
b2=0.9981263141,
a1=1.9990742598,
a2=-0.9990746880

biquad2,
b0=0.9997685917,
b1=-1.9995371834,
b2=0.9997685917,
a1=1.9995371298,
a2=-0.9995372369

biquad3,
b0=0.9997685917,
b1=-1.9995371834,
b2=0.9997685917,
a1=1.9995371298,
a2=-0.9995372369
```

---

## Expected DSP Response

| Frequency | Response |
|-----------|----------|
| 5 Hz | +16.9 dB |
| 10 Hz | +19.5 dB |
| 20 Hz | +10.3 dB |
| 38 Hz | +1.1 dB |
| 50 Hz | -0.3 dB |
| 80 Hz | -0.5 dB |
| 100 Hz | -0.4 dB |

**Note:** miniDSP GUI only displays to 10Hz and +20dB. The curve will appear clipped at the edges but the DSP processes the full coefficients correctly.

---

## Output Settings

### Output 1

| Setting | Value |
|---------|-------|
| Gain | 0 dB (adjust during calibration) |
| Delay | 0 ms (adjust for time alignment) |
| Polarity | Normal (0°) |
| Mute | OFF |
| HPF | BYPASS (using biquads) |
| LPF | BYPASS |

### Output 2

| Setting | Value |
|---------|-------|
| Gain | 0 dB |
| Delay | 0 ms |
| Polarity | Normal (0°) |
| Mute | OFF |
| HPF | BYPASS |
| LPF | BYPASS |

---

## Input Settings

### Input 1

| Setting | Value |
|---------|-------|
| Gain | 0 dB |
| PEQ | All bypassed |

---

## Setup Procedure

1. **Connect** miniDSP to computer via USB
2. **Launch** miniDSP software
3. **Set sample rate** to 96 kHz (if not default)
4. **Configure routing** per matrix above
5. **Open Output 1** PEQ section
6. **Enable Custom Biquad** mode for filters 1-3
7. **Paste coefficients** for each biquad
8. **Repeat** for Output 2
9. **Set output gains** to 0 dB
10. **Verify** response curve looks correct
11. **Save preset**

---

## Verification

After loading coefficients, the miniDSP response curve should show:
- Steep boost rising from ~40Hz down to 10Hz
- Peak around +19-20 dB at 10Hz
- Steep rolloff below 5Hz
- Flat response above 50Hz

If the curve looks inverted (huge cut instead of boost), the a1/a2 signs may need to be flipped.

---

## Connections

### Rear Panel

| Connector | Connection |
|-----------|------------|
| INPUT 1 (RCA/XLR) | AVR subwoofer output |
| OUTPUT 1 (RCA/XLR) | NX6000 CH.A Input |
| OUTPUT 2 (RCA/XLR) | NX6000 CH.B Input |

### USB

| Use | Purpose |
|-----|---------|
| Configuration | Connect to PC for setup |
| Normal Operation | Disconnected (standalone) |

---

## Equipment List (Per Couch)

| Item | Qty | Unit Price | Total |
|------|-----|------------|-------|
| miniDSP 2x4 HD | 1 | $225 | $225 |
| RCA to XLR adapter | 2 | $5 | $10 |
| **Subtotal** | | | **$235** |

---

*Document Version: 3.0*
*Created: December 2024*
