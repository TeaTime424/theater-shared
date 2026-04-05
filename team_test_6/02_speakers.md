# Speaker Channels — 9.4.4 Dolby Atmos + Front Wides

**Source of Truth:** `specs.yaml`
**Configuration:** 13 speaker channels (9 bed + 4 height)
**Target SPL:** 95 dB at MLP (-10 dB Reference)

---

## Channel Matrix

| Ch | Model | Sens (dB) | Z (ohm) | Amp | Power (W) | Dist (ft) | SPL @ MLP (dB) | Headroom (dB) |
|---|---|---|---|---|---|---|---|---|
| L | Titan-815LX | 99 | 6 | ATI AT525NC | 300 | 10.5 | 113.7 | +18.7 |
| C | Titan-815LX | 99 | 6 | ATI AT525NC | 300 | 10.5 | 113.7 | +18.7 |
| R | Titan-815LX | 99 | 6 | ATI AT525NC | 300 | 10.5 | 113.7 | +18.7 |
| FWL | Volt-10 | 95 | 8 | ATI AT525NC | 200 | 8.5 | 108.7 | +13.7 |
| FWR | Volt-10 | 95 | 8 | ATI AT525NC | 200 | 8.5 | 108.7 | +13.7 |
| SL | Volt-10 | 95 | 8 | X6800H | 140 | 8.5 | 108.2 | +13.2 |
| SR | Volt-10 | 95 | 8 | X6800H | 140 | 8.5 | 108.2 | +13.2 |
| SBL | Volt-10 | 95 | 8 | X6800H | 140 | 10.0 | 106.8 | +11.8 |
| SBR | Volt-10 | 95 | 8 | X6800H | 140 | 10.0 | 106.8 | +11.8 |
| TFL | Volt-10 | 95 | 8 | X6800H | 140 | 7.0 | 109.9 | +14.9 |
| TFR | Volt-10 | 95 | 8 | X6800H | 140 | 7.0 | 109.9 | +14.9 |
| TRL | Volt-10 | 95 | 8 | X6800H | 140 | 7.0 | 109.9 | +14.9 |
| TRR | Volt-10 | 95 | 8 | X6800H | 140 | 7.0 | 109.9 | +14.9 |

All channels exceed 95 dB target. Minimum headroom: +11.8 dB (surround backs).

---

## LCR — DIYSG Titan-815LX

| Parameter | Value |
|---|---|
| Model | DIYSG Titan-815LX |
| Quantity | 3 |
| Sensitivity | 99 dB (1W/1m) |
| Impedance | 6 ohm nominal, 4.2 ohm minimum |
| Power handling | 400W |
| Crossover | 80 Hz (to subs) |
| Cabinet tuning | 40 Hz |
| Enclosure | Ported — line panels, do NOT stuff |
| Dimensions | 19.5" W x 42.5" H x 21.5" D |
| Position | Behind AT screen on north wall |
| Status | OWNED |

### LCR Amplification

| Parameter | Value |
|---|---|
| Amp | ATI AT525NC (5-channel NCore) |
| Power @ 8 ohm | 200W |
| Power @ 6 ohm | 300W |
| Channels used | 3 of 5 (L, C, R) — remaining 2 for FWL, FWR |
| Signal path | X6800H pre-out (L/C/R) --> ATI AT525NC --> Titan-815LX |
| Status | OWNED ($2,500 value) |

### LCR SPL Calculation

```
SPL = sensitivity + 10*log10(power) - 20*log10(distance/1m)

Distance: 10.5 ft = 3.2 m (Row 1 to screen wall)

SPL = 99 + 10*log10(300) - 20*log10(3.2)
    = 99 + 24.77 - 10.10
    = 113.7 dB at MLP

Headroom = 113.7 - 95 = 18.7 dB
```

---

## Surrounds / Atmos / Front Wides — DIYSG Volt-10 V2

| Parameter | Value |
|---|---|
| Model | DIYSG Volt-10 V2 |
| Quantity | 10 |
| Sensitivity | 95 dB (1W/1m) -- CORRECTED from 98 dB |
| Impedance | 8 ohm |
| Crossover | 80 Hz (to subs) |
| Type | Coaxial point source |
| Dimensions | 14" W x 14" H x 9.4" D |
| Status | TO BUY |

All 10 surround/Atmos/front-wide channels use identical Volt-10 for timbral matching across the entire surround field.

### Channel Assignments

| Channels | Amp | Power/Ch | Signal Path |
|---|---|---|---|
| FWL, FWR (2) | ATI AT525NC | 200W @ 8 ohm | X6800H pre-out --> ATI |
| SL, SR, SBL, SBR (4) | X6800H internal | 140W @ 8 ohm | Internal amp |
| TFL, TFR, TRL, TRR (4) | X6800H internal | 140W @ 8 ohm | Internal amp |

X6800H uses 8 of 11 internal amp channels for surrounds + heights.
ATI uses 5 of 5 channels (3 LCR + 2 front wides).

### Surround SPL Calculation (Side Surrounds)

```
SPL = sensitivity + 10*log10(power) - 20*log10(distance/1m)

Distance: 8.5 ft = 2.59 m (half theater width to side wall)

SPL = 95 + 10*log10(140) - 20*log10(2.59)
    = 95 + 21.46 - 8.27
    = 108.2 dB at MLP

Headroom = 108.2 - 95 = 13.2 dB
```

### Surround Back SPL Calculation

```
Distance: 10.0 ft = 3.05 m (Row 1 to rear wall)

SPL = 95 + 10*log10(140) - 20*log10(3.05)
    = 95 + 21.46 - 9.69
    = 106.8 dB at MLP

Headroom = 106.8 - 95 = 11.8 dB
```

### Height SPL Calculation

```
Distance: ~7.0 ft = 2.13 m (ceiling to ear height, hypotenuse)

SPL = 95 + 10*log10(140) - 20*log10(2.13)
    = 95 + 21.46 - 6.57
    = 109.9 dB at MLP

Headroom = 109.9 - 95 = 14.9 dB
```

---

## Speaker Isolation

| Parameter | Value |
|---|---|
| Product | Sorbothane 50 duro hemispheres |
| Quantity | 12 (4 per LCR speaker) |
| Unit price | $7 |
| Total | $84 |
| Purpose | Decouple Titan-815LX from stage/shelf to reduce structural vibration transfer |

---

## Cost Table

| Item | Qty | Unit Price | Total | Status |
|---|---|---|---|---|
| Titan-815LX | 3 | $1,600 | $4,800 | Owned |
| ATI AT525NC | 1 | $2,500 | $2,500 | Owned |
| Volt-10 V2 | 10 | $242 | $2,420 | To buy |
| Sorbothane pucks | 12 | $7 | $84 | To buy |
| **Speaker subtotal (to buy)** | | | **$2,504** | |
| **Speaker subtotal (owned)** | | | **$7,300** | |

---

## Processor Selection

### Denon AVR-X6800H

| Parameter | Value |
|---|---|
| Price | $3,700 |
| Processing channels | 13.4 |
| Internal amp channels | 11 |
| Power per channel (8 ohm) | 140W |
| Sub outputs | 4 (independent for Dirac ART MIMO) |
| Pre-outs | 13.4ch |
| Room correction | Audyssey (included) + Dirac Live (license) |
| HDMI | 3 in / 2 out, 8K/4K120 |

### Dirac Live Licenses

| License | Price |
|---|---|
| Full Bandwidth | $349 |
| Bass Control | $299 |
| ART (Active Room Treatment) | $299 |
| **Bundle** | **$799** |

---

## Critical Assessment

### Why X6800H + ATI (Not Marantz AV10 or Denon A1H)

- X6800H at $3,700 vs A1H at $7,500 — saves $3,800
- X6800H has 11 internal amp channels — enough for all 8 surround/height channels
- ATI AT525NC (owned) handles LCR + front wides at higher power than X6800H internal
- X6800H has 4 independent sub outputs for Dirac ART MIMO
- Same Dirac Live support as A1H
- Backup: owned Denon X4700 (9ch, 125W) can substitute if X6800H fails

**What would change it:**
- If X6800H dropped below 7 usable internal amp channels (it has 11, so this is not a concern)
- If A1H price dropped to within $1,000 of X6800H
- If Dirac ART required features only available on A1H (it does not — ART works with X6800H's 4 sub outputs)

### Why Not Separate Processor + Amp Rack

- X6800H combines processing + 11 amplifier channels in one box
- Separate processor (AV10, $3,500) + 8ch amp ($2,000+) = $5,500+ for same capability
- More boxes = more rack space, more cables, more failure points
- ATI AT525NC already covers the 5 channels that need external amplification
- Total amp cost: $0 (ATI owned) + $3,700 (X6800H) = $3,700 vs $5,500+ alternative
