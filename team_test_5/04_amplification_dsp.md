# 04 — Amplification & DSP

**Date:** 2026-03-15
**References:** specs.yaml, POR/15_DSP_Subwoofer_Processing.md, nx6000d-vs-icepower verdict

---

## 1. Amplification Architecture

### Three Amp Tiers

| Tier | Amp | Channels | Assignment | Status |
|------|-----|----------|------------|--------|
| **LCR + FW** | ATI AT525NC | 5 | L, C, R, FWL, FWR | Owned ($0) |
| **Surr + Atmos** | X6800H internal | 8 | SL, SR, SBL, SBR, TFL, TFR, TRL, TRR | Internal to processor |
| **Subs + Tactile** | ICEpower 1200AS2 | 5 modules (10 ch) | Corner subs, shakers, 2 spare | To purchase |

### ATI AT525NC

| Parameter | Value |
|-----------|-------|
| Topology | NCore class D |
| Channels | 5 |
| Power @ 8 ohm | 200W |
| Power @ 6 ohm | ~300W |
| Assignment | L, C, R (6 ohm), FWL, FWR (8 ohm) |
| Connection | X6800H pre-outs (5 channels) |
| Status | Already owned |

### Denon AVR-X6800H Internal

| Parameter | Value |
|-----------|-------|
| Channels | 11 internal (8 used for surround/Atmos) |
| Power @ 8 ohm | 140W (2ch driven) / ~100W (all channels) |
| Processing | 13.4 channels |
| Sub outputs | 4 independent (RCA) |
| Pre-outs | 13.4ch (5 used for ATI) |
| Output voltage | 2.0 Vrms (pre-outs) |
| Dirac | Full + Bass Control + ART ($947 total licensing) |

### ICEpower 1200AS2

| Parameter | Value |
|-----------|-------|
| Quantity | 5 modules |
| Power @ 4 ohm | 1,200W |
| Power @ 8 ohm | 620W |
| Input sensitivity | 5.0 Vp (3.54 Vrms) for full power |
| Voltage gain | 25.8 dB (19.5x) |
| Input impedance | 38k ohm per leg |
| Voltage | 100-240V auto-sensing PFC |
| Idle power | 35W per unit (175W total for 5) |
| Fanless | Yes |
| Modifications | None required |
| AUX 5V output | 1A (powers APM2 DSP boards) |
| Cost | $373 each, $1,865 total + $200 chassis |

---

## 2. DSP System — 2x Wondom APM2 (ADAU1701)

| Parameter | Value |
|-----------|-------|
| Chip | ADAU1701 |
| Quantity | 2 boards |
| Per-board I/O | 2 in / 4 out |
| Combined I/O | 4 in / 8 out |
| Word length | 28-bit (5.23 fixed-point) |
| ADC full-scale | **2.0 Vrms** (with 18k series resistor on APM2) |
| DAC full-scale | **0.9 Vrms** |
| Power source | ICEpower AUX 5V rail |
| Power draw | ~300 mA @ 5V per board (within 1A limit) |
| Cost | $45 each, $90 total |

### Routing Matrix

```
APM2 Board 1 (2 in / 4 out):
  IN 1: X6800H Sub Front L  ->  OUT 1: Corner FL (ICEpower #1 Ch A)
  IN 2: X6800H Sub Front R  ->  OUT 2: Corner FR (ICEpower #1 Ch B)
                             ->  OUT 3: Front tactile derived (ICEpower #3 Ch A)
                             ->  OUT 4: Available

APM2 Board 2 (2 in / 4 out):
  IN 3: X6800H Sub Rear L   ->  OUT 5: Corner RL (ICEpower #2 Ch A)
  IN 4: X6800H Sub Rear R   ->  OUT 6: Corner RR (ICEpower #2 Ch B)
                             ->  OUT 7: Rear tactile derived (ICEpower #3 Ch B)
                             ->  OUT 8: Available
```

### Per-Output Processing

| Output | Source | Processing |
|--------|--------|-----------|
| Corner subs (OUT 1-2, 5-6) | Direct from input | HPF 5Hz BW2 + PEQ x10 + Gain |
| Tactile (OUT 3, 7) | Sum of L+R inputs | HPF 10Hz + LPF 80Hz + PEQ x10 + Gain |
| Available (OUT 4, 8) | -- | Reserved for nearfield (deferred) |

### ADAU1701 vs ADAU1452

The POR originally specified an ADAU1452 + CS42448 board. The corrected design uses 2x APM2 (ADAU1701). Trade-offs:

| Factor | 2x APM2 (ADAU1701) | ADAU1452 + CS42448 |
|--------|--------------------|--------------------|
| Cost | $90 | ~$60 |
| I/O | 4-in/8-out (2 boards) | 4-in/8-out (1 board) |
| DAC output | 0.9 Vrms | ~1.4 Vrms single-ended |
| Instructions | 2x 1024 | 6,144 |
| Internal summing | Requires per-board L+R sum | Full 4-input matrix |
| Status | On bench, tested | Not yet purchased |
| Fix for voltage | DRV134 ($30) | DRV134 ($30) or direct |

---

## 3. Signal Flow

```
SOURCES (HDMI/streaming)
    |
    v
DENON AVR-X6800H
    |--- Dirac Live Full + Bass Control + ART processing
    |
    |--- Pre-outs (5ch) ---------> ATI AT525NC (NCore 5ch)
    |    L, C, R, FWL, FWR              |
    |                              L   C   R   FWL  FWR
    |                              |   |   |    |    |
    |                            Titan-815LX   Volt-10
    |
    |--- Speaker outs (8ch) ----> Direct to speakers
    |    SL, SR, SBL, SBR              |
    |    TFL, TFR, TRL, TRR      Volt-10 (wall/ceiling)
    |
    |--- Sub pre-outs (4ch) ---> 2x APM2 (ADAU1701 DSP)
         Sub FL, FR, RL, RR           |
         (2.0 Vrms)              HPF + PEQ + Gain
                                       |
                                  DAC output (0.9 Vrms)
                                       |
                                  ICEpower 1200AS2
                                  (38.5W/ch @ 8 ohm)
                                       |
                                  +----+----+----+
                                  |    |    |    |
                                 NW   NE   SW   SE
                                Corner subs (8 ohm each)
                                       |
                                  ICEpower #3
                                       |
                                  Bass shakers (8x Aura Pro)
```

---

## 4. Gain Staging

### Stage-by-Stage Voltage

| Stage | Voltage | Notes |
|-------|---------|-------|
| X6800H sub pre-out | 2.0 Vrms nominal | Industry standard for Denon pre-outs |
| APM2 ADC input | 2.0 Vrms full-scale | **No clipping** — ADC handles full AVR output |
| ADAU1701 internal | Digital (5.23 fixed-point) | Ample headroom |
| APM2 DAC output | 0.9 Vrms max (0 dBFS) | **Bottleneck** |
| ICEpower input needed | 3.61 Vrms for 620W @ 8 ohm | Gap: 0.9 vs 3.61 Vrms |
| Actual amp output | 0.9 x 19.5 = 17.55 Vrms | 38.5W @ 8 ohm |

### ADC: Not an Issue

The ADAU1701 ADC full-scale is **2.0 Vrms** with the 18k series input resistor that the Wondom APM2 uses. The X6800H outputs 2.0 Vrms. The input sits right at full-scale under normal conditions. At typical listening levels (-15 to -20 dB volume), the sub pre-out delivers ~0.5-1.5 Vrms — well within range. No attenuation needed.

### DAC: Known Limitation

The ADAU1701 DAC outputs maximum 0.9 Vrms. The ICEpower 1200AS2 needs 3.61 Vrms for full 620W at 8 ohm. This limits amplifier output to **38.5W per channel** — 6.2% of rated power, a 12 dB headroom loss.

**Impact assessment:**
- At 38.5W/ch with 4 corners + boundary gain: **120.5 dB passband**
- At 20 Hz (after sealed rolloff): **~114.5 dB**
- vs 105 dB THX LFE target: **+9.5 dB headroom** — still exceeds reference
- The system works. The "weapons-grade" margin is reduced but target is met.

### DRV134 Fix Path

| Parameter | Value |
|-----------|-------|
| Component | Texas Instruments DRV134 balanced line driver |
| Output | Up to 10 Vrms balanced |
| Power | From ICEpower AVDD/AVSS rails |
| Cost | ~$30 in parts for 8 channels |
| Effect | Recovers full 620W/ch (12 dB of headroom) |
| When | Post-build upgrade if headroom is desired |

### Dirac ART Compatibility

Dirac ART (Active Room Treatment) operates on the X6800H's 4 independent sub outputs. Each sub output is independently optimized for its corner placement. The APM2 DSP preserves this independence by routing each input directly to its corresponding corner output. The per-channel PEQ in the ADAU1701 provides fine room correction that Dirac doesn't handle (narrow modes, seat-to-seat variation).

**Key:** The APM2 DSP does NOT sum or cross-mix the 4 corner sub channels. Each corner channel passes straight through with only HPF + PEQ + gain. This preserves Dirac ART's per-channel optimization.

---

## 5. APM2 Power from ICEpower AUX5V

| Parameter | Value |
|-----------|-------|
| ICEpower AUX 5V rail capacity | 1A per module |
| APM2 board power draw | ~300 mA @ 5V |
| Margin | 700 mA (70% headroom) |
| Connection | Short wire from ICEpower DVDD 5V header to APM2 power input |
| Board 1 power | From ICEpower #1 AUX5V |
| Board 2 power | From ICEpower #2 AUX5V |

---

## Critical Assessment

**Strengths:**
- Zero amplifier modifications (fanless, 240V native, no DSP bypass)
- Half the idle power of NX6000D alternative (175W vs 300-375W)
- Single 240V circuit for all sub amps
- ADC handles full AVR output voltage — no input clipping
- ATI NCore provides premium LCR amplification at $0

**Concerns:**
- DAC voltage limitation reduces usable amp power to 38.5W/ch (12 dB loss)
- Two separate DSP boards means no cross-board summing for nearfield derived channels
- DRV134 fix is straightforward but adds complexity
- 2x APM2 (2x1024 instructions) has less DSP capacity than ADAU1452 (6,144 instructions)

**Recommendation:** Build with APM2 as-is. The system exceeds target SPL even at 38.5W/ch. Add DRV134 line drivers as a post-build upgrade if more headroom is desired. The $30 fix recovers the full 620W/ch.

---

**Document Version:** 1.0
