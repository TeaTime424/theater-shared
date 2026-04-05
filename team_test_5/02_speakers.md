# 02 — Speaker System

**Date:** 2026-03-15
**Configuration:** 9.4.4 Dolby Atmos (13 channels)
**Target:** -10 dB Reference (95 dB at MLP)

---

## Channel Summary

| # | Channel | Model | Sensitivity | Impedance | Amp | Power (W) |
|---|---------|-------|-------------|-----------|-----|-----------|
| 1 | L | Titan-815LX | 99 dB | 6 ohm | ATI AT525NC | ~300 |
| 2 | C | Titan-815LX | 99 dB | 6 ohm | ATI AT525NC | ~300 |
| 3 | R | Titan-815LX | 99 dB | 6 ohm | ATI AT525NC | ~300 |
| 4 | FWL | Volt-10 | 95 dB | 8 ohm | ATI AT525NC | ~200 |
| 5 | FWR | Volt-10 | 95 dB | 8 ohm | ATI AT525NC | ~200 |
| 6 | SL | Volt-10 | 95 dB | 8 ohm | X6800H int. | ~140 |
| 7 | SR | Volt-10 | 95 dB | 8 ohm | X6800H int. | ~140 |
| 8 | SBL | Volt-10 | 95 dB | 8 ohm | X6800H int. | ~140 |
| 9 | SBR | Volt-10 | 95 dB | 8 ohm | X6800H int. | ~140 |
| 10 | TFL | Volt-10 | 95 dB | 8 ohm | X6800H int. | ~140 |
| 11 | TFR | Volt-10 | 95 dB | 8 ohm | X6800H int. | ~140 |
| 12 | TRL | Volt-10 | 95 dB | 8 ohm | X6800H int. | ~140 |
| 13 | TRR | Volt-10 | 95 dB | 8 ohm | X6800H int. | ~140 |

---

## LCR — DIYSG Titan-815LX

| Parameter | Value |
|-----------|-------|
| Sensitivity | 99 dB @ 2.83V/1m |
| Impedance | 6 ohm nominal (4.2 ohm minimum) |
| Enclosure | Ported (40 Hz tuning) — line panels, don't stuff |
| Crossover | 80 Hz to subs |
| Dimensions | 19.5" W x 42.5" H x 21.5" D |
| Placement | On stage deck (8" elevation) behind 170" AT screen |
| Status | Owned (3 units) |

### SPL Calculation — LCR

**Power:** ATI AT525NC delivers ~300W into 6 ohm (NCore).

SPL @ 1m = 99 + 10*log10(300) = 99 + 24.8 = **123.8 dB**

| Row | Distance | Distance Loss | Room Gain | SPL at Seat | Headroom vs 95 dB |
|-----|----------|---------------|-----------|-------------|-------------------|
| Row 1 | 10.5 ft (3.2 m) | -10.1 dB | +3 dB | **116.7 dB** | **+21.7 dB** |
| Row 2 | 15.0 ft (4.57 m) | -13.2 dB | +3 dB | **113.6 dB** | **+18.6 dB** |

*Note: +3 dB room gain is a mid-band estimate. Real-world SPL will be lower due to crossover losses, power compression, and crest factor. The original Option D document estimates 108 dB @ Row 1 and 104 dB @ Row 2 (+9 to +13 dB headroom), which is more conservative and realistic. Either way, headroom is abundant.*

---

## Front Wides — DIYSG Volt-10

| Parameter | Value |
|-----------|-------|
| Channels | FWL (partition wall), FWR (east wall) |
| Position | Between screen and Row 1, ~55 degrees from MLP |
| Amp | ATI AT525NC channels 4-5 (~200W @ 8 ohm) |

### SPL Calculation — Front Wides

SPL @ 1m = 95 + 10*log10(200) = 95 + 23.0 = **118.0 dB**

| Row | Distance | Distance Loss | Room Gain | SPL at Seat | Headroom vs 95 dB |
|-----|----------|---------------|-----------|-------------|-------------------|
| Row 1 | ~7 ft (2.1 m) | -6.5 dB | +3 dB | **114.5 dB** | **+19.5 dB** |
| Row 2 | ~10 ft (3.05 m) | -9.7 dB | +3 dB | **111.3 dB** | **+16.3 dB** |

---

## Side Surrounds — DIYSG Volt-10

| Parameter | Value |
|-----------|-------|
| Channels | SL (partition wall), SR (east wall) |
| Position | Beside Row 1 MLP, ~90 degrees |
| Amp | X6800H internal (~140W @ 8 ohm) |

### SPL Calculation — Side Surrounds

SPL @ 1m = 95 + 10*log10(140) = 95 + 21.5 = **116.5 dB**

| Row | Distance | Distance Loss | Room Gain | SPL at Seat | Headroom vs 95 dB |
|-----|----------|---------------|-----------|-------------|-------------------|
| Row 1 | ~8.5 ft (2.6 m) | -8.3 dB | +3 dB | **111.2 dB** | **+16.2 dB** |
| Row 2 | ~8.5 ft | -8.3 dB | +3 dB | **111.2 dB** | **+16.2 dB** |

*17' room width -> speakers are ~8.5' from center MLP at each row.*

---

## Rear Surrounds — DIYSG Volt-10

| Parameter | Value |
|-----------|-------|
| Channels | SBL, SBR (south wall) |
| Position | ~145 degrees from MLP, spread 6' apart |
| Amp | X6800H internal (~140W @ 8 ohm) |

### SPL Calculation — Rear Surrounds

| Row | Distance | Distance Loss | Room Gain | SPL at Seat | Headroom vs 95 dB |
|-----|----------|---------------|-----------|-------------|-------------------|
| Row 1 | ~10 ft (3.05 m) | -9.7 dB | +3 dB | **109.8 dB** | **+14.8 dB** |
| Row 2 | ~4 ft (1.2 m) | -1.7 dB | +3 dB | **117.8 dB** | **+22.8 dB** |

---

## Atmos Heights — DIYSG Volt-10

| Parameter | Value |
|-----------|-------|
| Channels | TFL, TFR (front), TRL, TRR (rear) |
| Spread | ~4' from center each side |
| Mounting | Ceiling (10' height) |
| Amp | X6800H internal (~140W @ 8 ohm) |

### SPL Calculation — Atmos

| Position | Distance from Row 1 | Distance Loss | SPL at Seat | Headroom vs 95 dB |
|----------|---------------------|---------------|-------------|-------------------|
| Front heights | ~12 ft (3.66 m) | -11.3 dB | **108.2 dB** | **+13.2 dB** |
| Rear heights | ~10 ft (3.05 m) | -9.7 dB | **109.8 dB** | **+14.8 dB** |

---

## All-Channel Summary

| Channel Group | SPL at Row 1 | SPL at Row 2 | Min Headroom vs 95 dB |
|---------------|-------------|-------------|----------------------|
| LCR | 116.7 dB | 113.6 dB | +18.6 dB |
| Front Wides | 114.5 dB | 111.3 dB | +16.3 dB |
| Side Surrounds | 111.2 dB | 111.2 dB | +16.2 dB |
| Rear Surrounds | 109.8 dB | 117.8 dB | +14.8 dB |
| Atmos Heights | 108.2 dB | 109.8 dB | +13.2 dB |

**All channels exceed 95 dB target with minimum +13.2 dB headroom.** The weakest link is the front Atmos heights at Row 1 (12 ft distance from ceiling). Even at the most conservative estimate, 108 dB is 13 dB above target — more than sufficient.

---

## Volt-10 Specifications

| Parameter | Value |
|-----------|-------|
| Sensitivity | 95 dB @ 2.83V/1m |
| Impedance | 8 ohm nominal |
| Power Range | 10-450W |
| Response | 70 Hz - 20 kHz (sealed) |
| Woofer | Denovo Audio CX-10 |
| Compression Driver | Custom Celestion CDX1-1446 |
| Design | Coaxial point source |
| Dimensions | 14" x 14" x 9.4" |
| Cost | $242 each |

**Why Volt-10 for all surround/Atmos:** Coaxial point source provides superior off-axis response — critical for multi-row seating and ceiling mounting. All 10 surround/Atmos speakers are identical for timbral matching.

---

## Cost Summary

| Item | Qty | Cost Each | Total |
|------|-----|-----------|-------|
| Titan-815LX | 3 | $1,600 | $4,800 (owned) |
| Volt-10 | 10 | $242 | $2,420 |
| Sorbothane isolation | 12 | $7 | $84 |
| **Total speakers** | **13** | | **$7,304** |
| **To buy** | | | **$2,504** |

---

## Critical Assessment

**Strengths:**
- All channels exceed 95 dB target by 13+ dB — massive headroom
- ATI NCore for LCR delivers better amplification than any AVR internal ($0 additional)
- Volt-10 coaxial design is ideal for surround/Atmos
- 17' width provides better lateral speaker geometry than 14' POR layout

**Concerns:**
- Front wides and side surrounds mount on partition wall — requires solid blocking between studs
- Atmos heights at 4-channel (no middle pair) lose some overhead coverage vs 9.4.6
- Room gain estimate (+3 dB) is approximate; real performance will be verified at calibration

---

**Document Version:** 1.0
