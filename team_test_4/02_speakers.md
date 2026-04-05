# Speaker System — 13 Channels

## Channel Summary

| Group | Model | Qty | Channels | Sensitivity | Impedance | Amplifier | Cost |
|-------|-------|-----|----------|-------------|-----------|-----------|------|
| LCR | DIYSG Titan-815LX | 3 | L, C, R | 99 dB | 6 ohm (4.2 min) | ATI AT525NC | $0 (owned) |
| Surrounds | DIYSG Volt-10 | 4 | SL, SR, SBL, SBR | 95 dB | 8 ohm | X6800H internal | $968 |
| Atmos | DIYSG Volt-10 | 4 | TFL, TFR, TRL, TRR | 95 dB | 8 ohm | X6800H internal | $968 |
| Front Wides | DIYSG Volt-10 | 2 | FWL, FWR | 95 dB | 8 ohm | ATI AT525NC | $484 |
| Isolation | Sorbothane 50 duro | 12 | -- | -- | -- | -- | $84 |
| **Total** | | **13** | | | | | **$2,504** |

## LCR: DIYSG Titan-815LX

| Parameter | Value |
|-----------|-------|
| Model | DIYSG Titan-815LX |
| Quantity | 3 (owned) |
| Sensitivity | 99 dB @ 1W/1m |
| Impedance | **6 ohm nominal, 4.2 ohm minimum** |
| Power handling | 400W |
| Crossover | 80 Hz HPF |
| Cabinet tuning | 40 Hz (ported) |
| Enclosure | **Ported -- line panels, DO NOT stuff** |
| Dimensions | 19.5" W x 42.5" H x 21.5" D |
| Amplifier | ATI AT525NC (NCore, ~300W into 6 ohm) |

**CRITICAL:** Titan-815LX is 6 ohm nominal, NOT 8 ohm. Some documentation incorrectly lists 8 ohm. The ATI AT525NC NCore modules handle 4 ohm minimum loads without issue.

### SPL Calculation — LCR

```
SPL @ 1W/1m = 99 dB
ATI power into 6 ohm = ~300W
SPL @ 1m = 99 + 10*log10(300) = 99 + 24.8 = 123.8 dB

Row 1 distance = 10.5 ft = 3.20 m
Distance loss = 20*log10(3.20/1.0) = 10.1 dB
SPL @ Row 1 = 123.8 - 10.1 = 113.7 dB

Row 2 distance = 15.0 ft = 4.57 m
Distance loss = 20*log10(4.57/1.0) = 13.2 dB
SPL @ Row 2 = 123.8 - 13.2 = 110.6 dB

Headroom vs 95 dB target:
  Row 1: +18.7 dB
  Row 2: +15.6 dB
```

## Surrounds: DIYSG Volt-10

| Parameter | Value |
|-----------|-------|
| Model | DIYSG Volt-10 (coaxial point source) |
| Quantity | 4 |
| Channels | SL, SR, SBL, SBR |
| Sensitivity | **95 dB** @ 1W/1m |
| Impedance | 8 ohm |
| Dimensions | 14.0" W x 14.0" H x 9.4" D |
| Amplifier | X6800H internal (140W/ch @ 8 ohm) |

**CRITICAL:** Volt-10 sensitivity is **95 dB**, not 98 dB. Early documentation had an error (C10).

### SPL Calculation — Surrounds

```
SPL @ 1W/1m = 95 dB
X6800H power @ 8 ohm = 140W
SPL @ 1m = 95 + 10*log10(140) = 95 + 21.5 = 116.5 dB

Side surrounds distance = ~7 ft = 2.13 m (half room width)
Distance loss = 20*log10(2.13/1.0) = 6.6 dB
SPL @ seat = 116.5 - 6.6 = 109.9 dB

Rear surrounds distance = ~8 ft = 2.44 m
Distance loss = 20*log10(2.44/1.0) = 7.7 dB
SPL @ seat = 116.5 - 7.7 = 108.8 dB

Headroom vs 95 dB target: +13.8 to +14.9 dB
```

## Atmos Heights: DIYSG Volt-10

| Parameter | Value |
|-----------|-------|
| Quantity | 4 |
| Channels | TFL, TFR, TRL, TRR |
| Mounting | Ceiling |
| Spread | ~4 ft from walls |
| Amplifier | X6800H internal (140W/ch @ 8 ohm) |

### SPL Calculation — Atmos

```
SPL @ 1W/1m = 95 dB
X6800H power = 140W
SPL @ 1m = 116.5 dB

Ceiling distance to seated ear = ~7 ft = 2.13 m (10' ceiling - 3' seated ear)
Distance loss = 20*log10(2.13/1.0) = 6.6 dB
SPL @ seat = 116.5 - 6.6 = 109.9 dB

Headroom vs 95 dB target: +14.9 dB
```

## Front Wides: DIYSG Volt-10

| Parameter | Value |
|-----------|-------|
| Quantity | 2 |
| Channels | FWL, FWR |
| Mounting | Wall mount, flanking screen |
| Amplifier | ATI AT525NC (200W @ 8 ohm) |

### SPL Calculation — Front Wides

```
SPL @ 1W/1m = 95 dB
ATI power @ 8 ohm = 200W
SPL @ 1m = 95 + 10*log10(200) = 95 + 23.0 = 118.0 dB

Distance to Row 1 MLP = ~11 ft = 3.35 m
Distance loss = 20*log10(3.35/1.0) = 10.5 dB
SPL @ Row 1 = 118.0 - 10.5 = 107.5 dB

Headroom vs 95 dB target: +12.5 dB
```

## Timbral Matching

All 10 surround/Atmos/wide speakers are identical Volt-10 coaxial drivers. This ensures consistent timbre for panned objects across the entire surround hemisphere. The LCR Titan-815LX uses different drivers but operates below the 80 Hz crossover in a distinct frequency range where timbral matching is less critical.

## Critical Assessment: Why X6800H + ATI vs A1H

| Factor | X6800H + ATI | A1H (standalone) |
|--------|-------------|-------------------|
| LCR power | ATI NCore ~300W @ 6 ohm | A1H internal ~150W @ 8 ohm |
| Processing | 13.4ch, Dirac Full/BC/ART | 13.4ch, Dirac Full/BC/ART |
| Cost | $3,700 + $0 (ATI owned) = $3,700 | $6,500 |
| Savings | -- | -$2,800 worse |
| LCR headroom | +15-19 dB | +12-16 dB |
| Channel count | 9.4.4 sufficient | Same |

**Verdict:** X6800H + already-owned ATI delivers more LCR power at $2,800 less cost. The A1H's premium buys nothing useful for this room size and speaker complement. ATI NCore modules are superior to A1H internal amps for the 6-ohm Titan loads.
