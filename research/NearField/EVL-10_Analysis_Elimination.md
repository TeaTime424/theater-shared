# Skar EVL-10 D4 - Analysis & Elimination

## Summary

**The Skar EVL-10 D4 is NOT recommended for this nearfield tactile application** despite its impressive Xmax specification. The high Fs (44 Hz) and low sensitivity (81.9 dB) result in impractical power requirements for infrasonic reproduction.

---

## Driver Specifications

| Parameter | EVL-10 D4 | UMII10-22 | Comparison |
|-----------|-----------|-----------|------------|
| Price | $130 | $170 | EVL -$40 |
| Fs | 44 Hz | 31 Hz | EVL +13 Hz worse |
| Qts | 0.62 | 0.72 | Similar |
| Vas | 6.5 L | 19.5 L | EVL much smaller |
| Xmax | 23.5 mm | 20.0 mm | EVL +3.5 mm better |
| Sd | 314 cm² | 328 cm² | Similar |
| Sensitivity | 81.9 dB | 83.6 dB | EVL -1.7 dB worse |
| Mount Depth | 181 mm | 152 mm | EVL +29 mm deeper |

---

## Sealed Box Performance (21.2L)

| Parameter | EVL-10 D4 | UMII10-22 |
|-----------|-----------|-----------|
| Qtc | 0.71 | 1.00 |
| Fc | 50.3 Hz | 43.0 Hz |
| F3 | ~52 Hz | ~34 Hz |

The EVL-10's higher Fs results in:
- **Higher Fc** (50 Hz vs 43 Hz)
- **Higher F3** (52 Hz vs 34 Hz)
- **More rolloff at low frequencies**

---

## Power Requirements Comparison

**8 Drivers @ 15", Target: 105 dB**

| Frequency | EVL-10 Power | UMII10-22 Power | Ratio |
|-----------|--------------|-----------------|-------|
| 10 Hz | **4,747 W** | 1,618 W | 2.9× more |
| 15 Hz | **943 W** | 301 W | 3.1× more |
| 20 Hz | **303 W** | 89 W | 3.4× more |
| 30 Hz | **66 W** | 16 W | 4.1× more |

---

## Why EVL-10 Needs 3× More Power

### 1. Higher Fs = More Rolloff
```
@ 10 Hz:
  EVL-10: -28.1 dB (50.3 Hz Fc)
  UMII10: -25.1 dB (43.0 Hz Fc)
  Difference: 3 dB = 2× power
```

### 2. Lower Sensitivity
```
  EVL-10: 81.9 dB
  UMII10: 83.6 dB
  Difference: 1.7 dB = 1.5× power
```

### 3. Combined Effect
```
  3 dB + 1.7 dB = 4.7 dB difference
  10^(4.7/10) = 2.95× more power needed
```

---

## Amplifier Implications

**For 10 Hz @ 105 dB per cabinet:**

| Driver | Total Power | Per Channel (2S2P) | Amp Requirement |
|--------|-------------|--------------------| ----------------|
| EVL-10 | 4,747 W | 2,373 W @ 4Ω | **Impractical** |
| UMII10 | 1,618 W | 809 W @ 4Ω | NX6000D (3000W/ch) |

The EVL-10 would require:
- Custom amplification (~$2,000+ per channel)
- Or multiple amps bridged
- Or accepting reduced infrasonic capability

---

## Excursion Analysis

**Both drivers have adequate Xmax for this application:**

| Driver | Xmax | Excursion @ 10Hz/105dB | Utilization |
|--------|------|------------------------|-------------|
| EVL-10 | 23.5 mm | 7.3 mm | 31% ✓ |
| UMII10 | 20.0 mm | 7.0 mm | 35% ✓ |

The EVL-10's superior Xmax (23.5 mm vs 20.0 mm) provides no practical advantage because **excursion is not the limiting factor** - power is.

---

## Cost Analysis

**Initial Impression (Drivers Only):**
```
EVL-10:  16 × $130 = $2,080 (saves $640)
UMII10:  16 × $170 = $2,720
```

**Reality (Including Amplification):**
```
EVL-10:  $2,080 + $4,000+ (2× high-power amps) = $6,080+
UMII10:  $2,720 + $1,000 (2× NX6000D)          = $3,720
```

The EVL-10's driver cost savings are **more than erased** by amplifier requirements.

---

## The Fundamental Problem

The EVL-10 is designed for **ported car audio enclosures** where:
- The port extends low-frequency response
- High Fs is compensated by port tuning
- High power is available (car audio amps commonly 1000W+)

In a **sealed home audio application**:
- No port to extend response
- High Fs directly limits low-frequency output
- Power requirements become impractical

---

## Verdict

| Criterion | EVL-10 | UMII10 | Winner |
|-----------|--------|--------|--------|
| 10 Hz capability | Impractical | Achievable | UMII10 |
| Power efficiency | Poor | Good | UMII10 |
| System cost | ~$6,000+ | ~$3,700 | UMII10 |
| Xmax headroom | 69% | 65% | Tie |
| Driver cost | $2,080 | $2,720 | EVL-10 |

**The UMII10-22 wins decisively** for sealed nearfield tactile application.

---

## When EVL-10 Would Be Appropriate

- Ported enclosure tuned to 25-30 Hz
- Car audio with high-power amplification
- Applications not requiring infrasonic (<20 Hz) output
- Budget builds accepting 20 Hz+ limitation

---

*Analysis completed December 2025*
