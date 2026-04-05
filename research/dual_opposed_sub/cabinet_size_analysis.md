# Dual-Opposed Subwoofer - Cabinet Size Analysis

## Driver: Dayton Audio UMII18-22 (×2, dual-opposed)

| Parameter | Value |
|-----------|-------|
| Fs | 22 Hz |
| Qts | 0.53 |
| Vas | 248.2 L (8.77 cu ft) |
| Xmax | 28 mm |
| Sd | 1225 cm² |
| Sensitivity | 90.7 dB @ 2.83V/1m |
| Power | 1,200 W RMS each |

---

## Cabinet Size Comparison

### Sealed Box Parameters

| Total Volume | Per Driver | Qtc | Fc | F3 (anechoic) | Alignment |
|--------------|------------|-----|-----|---------------|-----------|
| 12 cu ft | 6.0 cu ft | 0.83 | 34.5 Hz | 30 Hz | Optimal |
| 10 cu ft | 5.0 cu ft | 0.88 | 36.5 Hz | 31 Hz | Excellent |
| 8 cu ft | 0.95 | 39.3 Hz | 32 Hz | Good |
| 7 cu ft | 3.5 cu ft | 1.00 | 41.4 Hz | 33 Hz | Practical minimum |
| 6 cu ft | 3.0 cu ft | 1.05 | 43.6 Hz | 35 Hz | Getting boomy |

### Qtc Reference

| Qtc | Character |
|-----|-----------|
| 0.707 | Butterworth (maximally flat) |
| 0.8 - 0.9 | Slight warmth, excellent transients |
| 0.95 | Minor ~1 dB peak, still well-controlled |
| 1.0+ | Audible overhang, entering "boomy" territory |

---

## SPL Capability @ 20 Hz with 700W

| Volume | Anechoic | In-Room (corner) | Headroom vs 105 dB ref |
|--------|----------|------------------|------------------------|
| 12 cu ft | 113 dB | ~123 dB | +18 dB |
| 10 cu ft | 112 dB | ~122 dB | +17 dB |
| 8 cu ft | 111 dB | ~121 dB | +16 dB |
| 7 cu ft | 110 dB | ~120 dB | +15 dB |

All configurations exceed THX reference (105 dB) by a wide margin.

---

## Xmax-Limited Output

Displacement capability is identical regardless of box size (Xmax and Sd don't change).

| Frequency | Max SPL (anechoic) | Max SPL (in-room, corner) |
|-----------|-------------------|---------------------------|
| 10 Hz | 112 dB | 124 dB |
| 16 Hz | 120 dB | 130 dB |
| 20 Hz | 124 dB | 134 dB |
| 25 Hz | 128 dB | 138 dB |

**Xmax-limited extension to 105 dB reference:**
- Anechoic: ~7 Hz
- In-room (corner): ~8 Hz

---

## Group Delay Analysis

Verified against WinISD modeling.

| Frequency | 12 cu ft | 10 cu ft | 8 cu ft | 1 Cycle Threshold |
|-----------|----------|----------|---------|-------------------|
| 20 Hz | ~29 ms | ~29 ms | ~29 ms | 50 ms |
| 50 Hz | ~4 ms | ~5 ms | ~5 ms | 20 ms |

**Key findings:**
- All box sizes show nearly identical group delay at 20 Hz
- Group delay at 50 Hz is only 5 ms (well under 1-cycle threshold)
- The 8 cu ft box is NOT boomy — delay at Fc is well-controlled
- Differences between box sizes appear primarily in the 30-45 Hz region

---

## Minimum Box Size

### By SPL (theoretical)
To achieve 105 dB @ 20 Hz in-room: ~1 cu ft (but Qtc would be 2.2+, unusable)

### By Qtc (practical)
| Qtc Target | Volume | Notes |
|------------|--------|-------|
| Qtc ≤ 1.0 | 7 cu ft | Practical minimum, still 120 dB @ 20 Hz in-room |
| Qtc ≤ 0.95 | 8 cu ft | Good balance, 121 dB @ 20 Hz in-room |
| Qtc ≤ 0.85 | 10-12 cu ft | Optimal damping and transient response |

**SPL is never the limiting factor** — these drivers have so much displacement that output capability exceeds requirements in any reasonable enclosure. The constraint is Qtc and bass quality.

---

## Dirac Correction

Dirac Live can easily correct:
- The ~1 dB peak at Fc in an 8 cu ft box
- Minor group delay differences between alignments
- Room mode interactions

After Dirac processing, an 8 cu ft and 12 cu ft box would measure and sound virtually identical.

---

## Recommendations

| Priority | Recommended Volume | Rationale |
|----------|-------------------|-----------|
| Optimal quality | 10-12 cu ft | Qtc 0.83-0.88, best transient response |
| Good balance | 8 cu ft | Qtc 0.95, compact, Dirac handles the rest |
| Minimum practical | 7 cu ft | Qtc 1.0, still 15 dB over reference |

For the dual-opposed corner-loaded design, **8 cu ft is a practical choice** that balances size, weight, and performance. The higher Qtc is easily corrected by Dirac, and SPL capability far exceeds THX reference requirements.

---

*Cabinet Size Analysis — Dual-Opposed Subwoofer*
*Document Version: 1.0*
*November 2025*
