# 04 — Amplification & DSP

Option D Home Theater — Signal Chain Reference

---

## Processor

| Parameter | Value |
|-----------|-------|
| Model | Denon AVR-X6800H |
| Price | $3,700 |
| Processing | 13.4 channels |
| Internal amp | 11 channels x 140W @ 8 ohm |
| Sub outputs | 4 independent pre-outs |
| Pre-outs | 13.4ch full set |
| Room correction | Audyssey (included) + Dirac Live (license) |
| Assignment | Internal amp drives 8 channels: SL, SR, SBL, SBR, TFL, TFR, TRL, TRR |

### Dirac Live Bundle

| License | Price |
|---------|-------|
| Full Bandwidth | $349 |
| Bass Control | $299 |
| ART | $299 |
| **Bundle total** | **$799** |

ART (Active Room Treatment) sends unique MIMO signals per sub output. Corner subs must preserve per-channel independence — no passive summing before DSP.

---

## External Speaker Amplification

| Parameter | Value |
|-----------|-------|
| Model | ATI AT525NC |
| Status | Owned ($2,500 value, $0 spend) |
| Topology | 5ch x 200W @ 8 ohm / 300W @ 6 ohm, NCore |
| Assignment | L, C, R, FWL, FWR via X6800H pre-outs |
| Load | LCR = 6 ohm nominal (4.2 ohm min), FW = 8 ohm |

Titan-815LX at 6 ohm gets 300W from the ATI — 124 dB @ 1m, 108 dB at Row 1. 13 dB headroom over -10 dB reference target.

---

## Sub Amplification

| Parameter | Value |
|-----------|-------|
| Model | ICEpower 1200AS2 |
| Quantity | 5 (3 active + 2 spare) |
| Unit price | $373 |
| Total | $1,865 + $200 chassis = $2,065 |
| Voltage | 240V native (single 20A/240V circuit for all) |
| Power | 620W/ch @ 8 ohm continuous |
| Channels | 2 per module |
| Cooling | Fanless — zero acoustic noise |
| Mods required | None |
| AUX5V | Yes — powers APM2 DSP boards |

### ICEpower Assignment

| Unit | Channel A | Channel B | Load |
|------|-----------|-----------|------|
| 1 | FL corner sub | FR corner sub | 8 ohm |
| 2 | RL corner sub | RR corner sub | 8 ohm |
| 3 | Tactile (shakers) | — | varies |
| 4 | Spare (nearfield if added) | — | — |
| 5 | Spare | — | — |

### Why ICEpower 1200AS2 Over NX6000D

| Factor | ICEpower 1200AS2 | Behringer NX6000D |
|--------|-------------------|-------------------|
| Power @ 15Hz, 8 ohm | 620W (no derating) | ~440-500W (71% of rated) |
| Voltage | 240V native | 120V (240V requires rewire) |
| Cooling | Fanless | Fan (acoustic noise) |
| Mods | None | Potentially needs fan swap |
| Idle power | ~8W per module | ~40W per amp |
| Circuit count | 1x 20A/240V for all | Multiple 120V circuits |
| Cost (5 units) | $2,065 | ~$2,800-3,000 |
| Form factor | Modules in custom chassis | Rack-mount, large |

Verdict: Equal or better power at infrasonic frequencies, zero mods, half idle draw, single circuit, $800-1000 savings.

---

## Sub DSP

| Parameter | Value |
|-----------|-------|
| Platform | 2x Wondom APM2 (ADAU1701) |
| Fixed-point | 5.23 |
| Price | 2x $40 = $80 |
| Power | 5V from ICEpower 1200AS2 AUX5V output |
| Capabilities | HPF to DC, PEQ, delay, level, crossover |
| Replaces | DSP-408 + miniDSP chain |

**CORRECTED:** Sub DSP is ADAU1701 on APM2 boards, NOT ADAU1452+CS42448.

### ADAU1701 Biquad Convention

```
Coefficient order: [b0, b1, b2, -a1, -a2]
a1 and a2 are NEGATED vs scipy.signal output.
Unity: b0 = 0x00800000, all others = 0.
```

---

## Backup

| Parameter | Value |
|-----------|-------|
| Model | Denon X4700 |
| Status | Owned ($1,200 value) |
| Channels | 9 x 125W |
| Role | Backup if X6800H or ATI fails |

---

## Signal Flow

```
SOURCES (HDMI) ─────────────────────────────────────┐
                                                     v
                                              ┌─────────────┐
                                              │  Denon       │
                                              │  AVR-X6800H  │
                                              │  (13.4ch     │
                                              │   processing)│
                                              └──┬──┬──┬─────┘
                                                 │  │  │
               ┌─────────────────────────────────┘  │  └──────────────────┐
               │                                    │                     │
               v                                    v                     v
    ┌──────────────────┐              ┌──────────────────┐    ┌───────────────────┐
    │ 5ch Pre-outs     │              │ 8ch Speaker outs │    │ 4x Sub Pre-outs   │
    │ L/C/R/FWL/FWR    │              │ SL/SR/SBL/SBR    │    │ (Dirac ART MIMO)  │
    └────────┬─────────┘              │ TFL/TFR/TRL/TRR  │    └────────┬──────────┘
             │                        └────────┬─────────┘             │
             v                                 │                       v
    ┌──────────────────┐                       │          ┌───────────────────────┐
    │ ATI AT525NC      │                       │          │ 2x Wondom APM2        │
    │ 5ch NCore        │                       │          │ (ADAU1701, 5.23 FP)   │
    │ 200W/ch @ 8Ω     │                       │          │ PEQ / HPF / delay     │
    │ 300W/ch @ 6Ω     │                       │          │ Powered: ICEpower 5V  │
    └────────┬─────────┘                       │          └────────┬──────────────┘
             │                                 │                   │
             v                                 v                   v
    ┌──────────────────┐          ┌──────────────────┐   ┌────────────────────────┐
    │ 3x Titan-815LX   │          │ 10x Volt-10      │   │ 5x ICEpower 1200AS2   │
    │ (L/C/R)          │          │ (4 surr + 4 Atmos│   │ 620W/ch @ 8Ω, 240V   │
    │ + 2x Volt-10     │          │  + 2 front wide) │   │ Fanless               │
    │ (FWL/FWR)        │          │                  │   └────────┬──────────────┘
    └──────────────────┘          └──────────────────┘            │
                                                        ┌────────┴────────┐
                                                        v                 v
                                               ┌──────────────┐  ┌──────────────┐
                                               │ 8x UMII18-22 │  │ 8x Aura Pro  │
                                               │ Corner subs   │  │ Bass shakers │
                                               │ (4 cabinets)  │  │ (1/seat)     │
                                               └──────────────┘  └──────────────┘
```

---

## Gain Staging Verification

| Interface | Signal | Level | Notes |
|-----------|--------|-------|-------|
| X6800H sub pre-out | Line | ~2V RMS typical | Standard Denon pre-out level |
| APM2 input | Line | ~2V RMS | Line-level input, no issues — matched to consumer gear |
| APM2 output | Line | ~2V RMS max | ADAU1701 output via on-board DAC |
| ICEpower 1200AS2 input | Line | 1V RMS for rated power | Input sensitivity well matched — APM2 output may need +6 dB gain to fully drive amp. Verify at commissioning. |
| X6800H pre-out → ATI | Line | ~2V RMS | Standard consumer pre-out to pro amp input — no issues |
| X6800H speaker out | Amplified | 140W/ch @ 8 ohm | Direct to Volt-10 (95 dB, 8 ohm) — 117 dB @ 1m |

**Watch item:** ICEpower 1200AS2 input sensitivity is 1V RMS for full output. APM2 DAC output may be slightly below this at max. Not a problem — DSP gain can compensate, and full 620W is rarely needed. Verify gain structure during commissioning.

---

## Cost Summary

| Item | Qty | Unit | Total |
|------|-----|------|-------|
| Denon AVR-X6800H | 1 | $3,700 | $3,700 |
| Dirac Live bundle | 1 | $799 | $799 |
| Wondom APM2 (ADAU1701) | 2 | $40 | $80 |
| ATI AT525NC | 1 | owned | $0 |
| Denon X4700 | 1 | owned | $0 |
| ICEpower 1200AS2 | 5 | $373 | $1,865 |
| Amp chassis/wiring | 1 | $200 | $200 |
| **Amplification & DSP total** | | | **$6,644** |

Owned equipment value: ATI ($2,500) + X4700 ($1,200) = $3,700.

---

## Critical Assessment

**Strengths:**
- X6800H is the right processor — 13.4ch processing covers 9.4.6 with room to spare, and 11ch internal amp eliminates external amp for surrounds/heights.
- ATI AT525NC owned and proven — 300W into Titan's 6 ohm load is overkill for -10 dB reference. No purchase risk.
- ICEpower 1200AS2 is the correct sub amp choice — fanless, 240V native, no infrasonic derating, no mods. One circuit runs everything.
- APM2 boards at $40 each are disposable if they fail. AUX5V power from ICEpower eliminates separate PSU.

**Risks:**
- ADAU1701 is 5.23 fixed-point with limited dynamic range (28.12 format = ~144 dB). Adequate for sub duty but no headroom for cascaded high-Q filters. Keep filter count per channel to 5 or fewer.
- APM2 analog bypass flaw (Wondom design): if DSP bypassed, signal must route directly to amp via RCA, not through APM2 analog path. Plan alternate RCA routing for emergency bypass.
- Dirac ART requires 4 independent sub outputs maintained through DSP to amps. Current topology preserves this (4 pre-outs → 2 APM2 → 4 ICEpower channels). Do not merge channels.
- Five ICEpower modules on one 20A/240V circuit: 5 x 8W idle = 40W. Peak draw during bass transients could approach 15A. 20A breaker has margin but watch inrush at power-on — stagger startup.

**No-go items:**
- NX6000D: rejected — infrasonic derating, fan noise, 120V multi-circuit, higher cost.
- ADAU1452+CS42448: corrected out — APM2 boards use ADAU1701.
