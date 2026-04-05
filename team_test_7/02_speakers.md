# 02 — Speaker System
## 13 Channels: 9.4.4 Dolby Atmos

All specs from `specs.yaml`.

---

## Channel Matrix

| Channel | Speaker | Sensitivity | Impedance | Amplifier | Power | SPL @ Seat | vs 95 dB |
|---------|---------|-------------|-----------|-----------|-------|------------|----------|
| L | Titan-815LX | 99 dB | 6Ω | ATI NCore | ~300W | ~108 dB | **+13 dB** |
| C | Titan-815LX | 99 dB | 6Ω | ATI NCore | ~300W | ~108 dB | **+13 dB** |
| R | Titan-815LX | 99 dB | 6Ω | ATI NCore | ~300W | ~108 dB | **+13 dB** |
| FWL | Volt-10 | 95 dB | 8Ω | ATI NCore | ~200W | ~107 dB | **+12 dB** |
| FWR | Volt-10 | 95 dB | 8Ω | ATI NCore | ~200W | ~107 dB | **+12 dB** |
| SL | Volt-10 | 95 dB | 8Ω | X6800H | ~100W | ~107 dB | **+12 dB** |
| SR | Volt-10 | 95 dB | 8Ω | X6800H | ~100W | ~107 dB | **+12 dB** |
| SBL | Volt-10 | 95 dB | 8Ω | X6800H | ~100W | ~107 dB | **+12 dB** |
| SBR | Volt-10 | 95 dB | 8Ω | X6800H | ~100W | ~107 dB | **+12 dB** |
| TFL | Volt-10 | 95 dB | 8Ω | X6800H | ~100W | ~105 dB | **+10 dB** |
| TFR | Volt-10 | 95 dB | 8Ω | X6800H | ~100W | ~105 dB | **+10 dB** |
| TRL | Volt-10 | 95 dB | 8Ω | X6800H | ~100W | ~105 dB | **+10 dB** |
| TRR | Volt-10 | 95 dB | 8Ω | X6800H | ~100W | ~105 dB | **+10 dB** |

**Every channel exceeds 95 dB target by 10+ dB.** Weakest link: ceiling heights at +10 dB (longer throw).

---

## LCR: DIYSG Titan-815LX

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | 99 dB @ 2.83V/1m | DIYSG |
| Impedance | 6Ω nominal, 4.2Ω minimum @ 110 Hz | Matt Grant (HiFi Circuit) |
| Power handling | 400W (with 80 Hz crossover) | Matt Grant |
| Cabinet tuning | 40 Hz (ported) | Matt Grant |
| Crossover to subs | 60-80 Hz | Matt Grant |
| Dimensions | 19.5"W × 42.5"H × 21.5"D | POR source OBJ |
| Status | **OWNED** — 3 units | |

### SPL Calculation (LCR)

```
SPL @ 1m = sensitivity + 10*log10(power)
         = 99 + 10*log10(300)
         = 99 + 24.8
         = 123.8 dB

Distance to Row 1: 10.5 ft = 3.2 m
Distance loss: 20*log10(3.2) = 10.1 dB
Free-field SPL @ Row 1: 123.8 - 10.1 = 113.7 dB

Room gain at mid frequencies: +3-5 dB (conservative)
Effective SPL @ Row 1: ~108 dB (conservative)

Distance to Row 2: 15.0 ft = 4.57 m
Distance loss: 20*log10(4.57) = 13.2 dB
Free-field SPL @ Row 2: 123.8 - 13.2 = 110.6 dB
Effective SPL @ Row 2: ~104 dB (conservative)
```

**Headroom: +9 to +13 dB over 95 dB target.** ATI NCore provides premium amplification at $0 (owned).

### Placement

- On stage deck (27" elevation), behind 170" AT screen
- Mounted on Sorbothane 50 Durometer isolation pucks (4 per speaker, 12 total)
- L/R spread: ~±25° from MLP
- Center: 0° on axis

### Titan-815LX Notes

- **Ported enclosure** — line panels, do NOT stuff
- 6Ω nominal is NOT 8Ω — amp must handle reactive low-impedance load
- ATI NCore handles 4.2Ω minimum impedance without issue
- Cross at 60-80 Hz to subwoofers

---

## Surrounds/Atmos/FW: DIYSG Volt-10 V2

| Parameter | Value | Source |
|-----------|-------|--------|
| Sensitivity | **95 dB** @ 2.83V/1m | DIYSG official (NOT 98 dB) |
| Impedance | 8Ω nominal | DIYSG |
| Power range | 10-450W | DIYSG |
| Frequency response | 70 Hz - 20 kHz (sealed) | DIYSG |
| Internal crossover | 2000 Hz | DIYSG |
| Woofer | Denovo Audio CX-10 (custom Eminence) | DIYSG |
| Compression driver | Custom Celestion CDX1-1446 | DIYSG |
| Dimensions | 14"W × 14"H × 9.4"D | POR source OBJ |

### SPL Calculation (Surrounds)

```
SPL @ 1m = 95 + 10*log10(100) = 95 + 20 = 115 dB

Side surrounds distance: ~8.5 ft (17' room / 2) = 2.6 m
Distance loss: 20*log10(2.6) = 8.3 dB
SPL @ seat: 115 - 8.3 = 106.7 dB
With room gain: ~107 dB

Headroom: +12 dB over 95 dB target
```

### SPL Calculation (Heights)

```
Ceiling to seat distance: ~10 ft = 3.05 m
Distance loss: 20*log10(3.05) = 9.7 dB
SPL @ seat: 115 - 9.7 = 105.3 dB

Headroom: +10 dB over 95 dB target
```

### Why Volt-10 for All Surround/Atmos

- **Coaxial point source** — compression driver fires through woofer center
- Superior off-axis response for multi-row seating
- Ideal for ceiling mounting (height channels)
- **Timbral matching** — all 10 surround/Atmos/FW channels identical
- $242 per unit — excellent cost/performance ratio

### Channel Assignments

| Group | Channels | Mounting | Amplifier |
|-------|----------|----------|-----------|
| Front Wides | FWL (partition wall), FWR (east wall) | Wall mount, between screen and MLP | ATI AT525NC |
| Side Surrounds | SL (partition wall), SR (east wall) | Wall mount, beside MLP, ~90° | X6800H internal |
| Surround Backs | SBL (south wall), SBR (south wall) | Wall mount, ~145° | X6800H internal |
| Top Front | TFL, TFR | Ceiling mount, above front wides | X6800H internal |
| Top Rear | TRL, TRR | Ceiling mount, above Row 2 | X6800H internal |

### Why 9.4.4 (Not 9.4.6)

- X6800H provides 13.4ch processing (9.4.4 max without external processing)
- Dropped TML/TMR (middle heights) saves 2× Volt-10 ($484) and simplifies wiring
- Front wides improve lateral fill in 17' room where side walls are relatively close
- 4 height channels provide excellent Atmos coverage for 23' depth
- $2,800 savings (X6800H vs A1H) funds the quality build

---

## Speaker Isolation

| Spec | Value |
|------|-------|
| Product | Sorbothane 50 Durometer Hemispheres |
| Size | 1.5" diameter × 0.5" thick |
| Per speaker | 4 pucks (rectangular pattern) |
| Total | 12 pucks (3 LCR speakers) |
| Cost | ~$7/puck, $84 total |

Decouples LCR from stage deck vibration. Essential at reference system investment level.

---

## Cost Summary

| Item | Qty | Unit | Total | Status |
|------|-----|------|-------|--------|
| Titan-815LX | 3 | $1,600 | $4,800 | **Owned** |
| Volt-10 | 10 | $242 | $2,420 | To buy |
| Sorbothane | 12 | $7 | $84 | To buy |
| **Speakers total (to buy)** | | | **$2,504** | |
| **Speakers total (incl. owned)** | | | **$7,304** | |

---

## Critical Assessment

### Settled
- Titan-815LX for LCR — owned, 99 dB, proven design
- Volt-10 for all surround/Atmos — timbral matching, point source, cost-effective
- ATI AT525NC for LCR+FW — owned, NCore quality, $0 cost
- X6800H internal amps for surround/height — 100W provides 10+ dB headroom

### Known Weakness
- Volt-10 at 95 dB sensitivity requires more power than 99 dB Titan — but X6800H's 100W provides 10+ dB headroom, so this is academic
- All surround/height speakers cross at 80 Hz to subs — X6800H's bass management handles this

---

*All values from specs.yaml. Document generated 2026-03-16.*
