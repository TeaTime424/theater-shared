# Speaker System — Option D Home Theater

Source authority: `specs.yaml` (2026-03-21). All numbers from that file only.

---

## All Channels

| Channel | Model | Sensitivity (dB/W/m) | Impedance | Amp | Power (W) | SPL at MLP (dB) |
|---------|-------|----------------------|-----------|-----|-----------|-----------------|
| L | DIYSG Titan-815LX | 97.75 | 6Ω nom / 4.2Ω min | ATI AT525NC | 300 W @ 6Ω | 111.3 |
| C | DIYSG Titan-815LX | 97.75 | 6Ω nom / 4.2Ω min | ATI AT525NC | 300 W @ 6Ω | 111.3 |
| R | DIYSG Titan-815LX | 97.75 | 6Ω nom / 4.2Ω min | ATI AT525NC | 300 W @ 6Ω | 111.3 |
| FWL | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | ATI AT525NC | 200 W @ 8Ω | 108.0 |
| FWR | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | ATI AT525NC | 200 W @ 8Ω | 108.0 |
| SL | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 107.0 |
| SR | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 107.0 |
| SBL | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 107.0 |
| SBR | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 107.0 |
| TFL | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 105.5 |
| TFR | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 105.5 |
| TRL | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 105.5 |
| TRR | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 105.5 |
| TML | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 105.5 |
| TMR | DIYSG Volt-10 V2 | 95.0 | 8Ω nom | Denon AVR-X6800H | 100 W @ 8Ω | 105.5 |

Total speaker count: 3 Titan-815LX + 12 Volt-10 V2 = 15 drivers.
Volt-10 count: 12 per Critic ruling (§1I) — 4 surrounds + 6 Atmos + 2 front wide.

---

## SPL Calculation

Formula: `SPL = Sensitivity(1W/1m) + 10*log10(Power_W) - 20*log10(Distance_m)`

### LCR (Titan-815LX)

- Sensitivity(1W/1m) = 97.75 dB
  - Note: DIYSG spec sheet rates 99 dB at 2.83V/1m. At 6Ω nominal, 2.83V = 1.334W (not 1W). Correction: 99 - 10*log10(1.334) = 99 - 1.25 = **97.75 dB/W/m**.
- Power = 300 W (ATI AT525NC into 6Ω)
- Distance = 3.658 m (12 ft)
- SPL = 97.75 + 10*log10(300) - 20*log10(3.658)
- SPL = 97.75 + 24.77 - 11.27 = **111.3 dB**

### Surrounds (Volt-10 V2)

- Sensitivity(1W/1m) = 95.0 dB
  - Note: 8Ω nominal, 2.83V/1m spec directly equals 1W/1m. No correction needed.
- Power = 100 W (AVR all-channel rating)
- Distance = 2.5 m
- SPL = 95.0 + 10*log10(100) - 20*log10(2.5)
- SPL = 95.0 + 20.0 - 7.96 = **107.0 dB**

### Atmos (Volt-10 V2)

- Sensitivity(1W/1m) = 95.0 dB
- Power = 100 W
- Distance = 3.0 m (ceiling height ~3 m to MLP)
- SPL = 95.0 + 10*log10(100) - 20*log10(3.0)
- SPL = 95.0 + 20.0 - 9.54 = **105.5 dB**

### Front Wide (Volt-10 V2)

- Sensitivity(1W/1m) = 95.0 dB
- Power = 200 W (ATI AT525NC into 8Ω)
- Distance = 2.5 m (estimated, similar to surrounds)
- SPL = 95.0 + 10*log10(200) - 20*log10(2.5)
- SPL = 95.0 + 23.01 - 7.96 = **110.0 dB**

---

## Headroom vs 95 dB Target

Target: 95 dB at MLP (-10 dB Reference level).

| Channel Group | SPL at MLP (dB) | Headroom (dB) | Meets Target |
|---------------|-----------------|---------------|--------------|
| LCR (Titan-815LX) | 111.3 | +16.3 | Yes |
| Front Wide (Volt-10) | 110.0 | +15.0 | Yes |
| Surrounds (Volt-10) | 107.0 | +12.0 | Yes |
| Atmos (Volt-10) | 105.5 | +10.5 | Yes |

All channels exceed 95 dB target by at least 10.5 dB. Headroom accounts for room losses, absorption, and Dirac Live correction overhead.

---

## Speaker Notes

### Titan-815LX (LCR)

- Impedance: **6Ω nominal, 4.2Ω minimum at 110 Hz** — NOT 8Ω. ATI AT525NC rated for 4Ω loads.
- Enclosure: **ported** — line panels are present, do NOT stuff the port. Stuffing kills bass extension.
- Sensitivity correction applied: 2.83V/1m spec (99 dB) converted to 1W/1m (97.75 dB) for 6Ω load.
- Source: specs.yaml `speakers.lcr`

### Volt-10 V2 (Surrounds, Atmos, Front Wide)

- Sensitivity: **95 dB at 1W/1m** — corrected from earlier design docs that incorrectly stated 98 dB (v5.0 error).
- Impedance: 8Ω nominal — 2.83V spec = 1W spec, no correction needed.
- Count: **12 total** per Critic ruling §1I. CLAUDE.md states 10 — that figure predates the front wide addition and is stale.
- Source: specs.yaml `speakers.surround_atmos`, `tmp_critic.md §1I`

---

## Design Rationale

**All-Volt-10 surrounds and Atmos:** Timbral matching across all non-LCR channels. Identical driver, cabinet geometry, and polar response in all surround and overhead positions eliminates tonal inconsistency as sound pans around the room. Coaxial point-source design keeps off-axis response consistent at varied MLP distances.

**Titan-815LX for LCR:** High sensitivity (97.75 dB/W/m) and high output capability required for the LCR channels, which must reproduce full-range content including cinema-level transients at the 3.66 m screen-to-MLP distance. The 99 dB (2.83V) spec translates to 111+ dB at MLP with only 300W — well above the 95 dB target with headroom for dynamic peaks.

**Amplification split:** ATI AT525NC handles the demanding LCR + front wide loads (6Ω and 4Ω capable). AVR-X6800H internal amplification handles the 8Ω surrounds and Atmos where 100W all-channel is sufficient for the 95 dB target.
