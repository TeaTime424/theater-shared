# Marantz AV 10 — Complete I/O Specification Sheet

**Status:** RESEARCH — Not adopted (superseded by Denon AVR-X6800H in Option D)
**Date:** 2026-03-20
**Related:** None

---

## Executive Summary

The Marantz AV 10 is a 15.4-channel AV preamplifier/processor with full XLR balanced pre-outs on all 17.4 channels, HDMI 2.1 across all 7 inputs, and a flagship analog signal path. Output voltage is 6.5 Vrms RCA / 12.9 Vrms XLR (measured at 0.1% THD+N). It is the reference Marantz separates processor for 2022–2024 and was the prior candidate for this project before being replaced by the AVR-X6800H in Option D.

---

## 1. Audio Inputs

### HDMI (Audio Extraction)
| Parameter | Value |
|-----------|-------|
| HDMI inputs | 7 |
| HDMI version | 2.1 |
| eARC support | Yes — on HDMI OUT 1 (receives audio from TV) |
| ARC support | Yes (backward compatible with eARC port) |
| Supported audio via eARC | Multichannel PCM, Dolby TrueHD, Dolby Atmos, DTS-HD, DTS:X |
| Max passthrough | 8K/60Hz, 4K/120Hz |
| Gaming features | ALLM, VRR, QFT |
| HDCP | 2.3 |

### Analog Inputs
| Input | Count | Connector | Notes |
|-------|-------|-----------|-------|
| Stereo RCA | 5 | RCA pairs | Unbalanced |
| Balanced XLR | 1 | XLR (stereo pair) | Balanced stereo input |
| Phono | 1 | RCA | MM (Moving Magnet) only — no MC |
| FM/AM antenna | 1 set | 75Ω coax (F) + bare wire | Tuner inputs |

Total analog audio inputs: 5× RCA stereo + 1× XLR stereo + 1× Phono MM

### Digital Inputs
| Type | Count | Connector |
|------|-------|-----------|
| Coaxial S/PDIF | 2 | RCA |
| Optical TOSLINK | 2 | TOSLINK |

### USB
| Port | Location | Purpose | Spec |
|------|----------|---------|------|
| USB Type-A | Front panel (behind door) | Media playback (USB memory) | Plays DSD up to 5.6 MHz, FLAC up to 192 kHz |
| USB Type-A | Rear panel | Power supply only — 5V/1.5A | Cannot play audio |

Note: USB hubs not supported on playback port.

### Network Audio
| Feature | Support |
|---------|---------|
| HEOS Built-in | Yes — multi-room streaming |
| AirPlay | AirPlay 2 |
| Bluetooth (receive) | Yes — A2DP 1.4, AVRCP 1.5 profile |
| Bluetooth codec | SBC only [verified from manual Bluetooth spec section] |
| Bluetooth version | 5.4 |
| Bluetooth range | ~30 m line-of-sight |
| Spotify Connect | Yes |
| Roon Ready | Yes |
| TIDAL Connect | Yes |
| Qobuz Connect | Yes |
| Internet Radio | Yes (TuneIn) |

---

## 2. Audio Outputs

### Pre-Out Channels — Full Layout
The AV 10 provides **17.4 channels** of pre-outs, with BOTH RCA and XLR balanced connectors for every channel (i.e., each channel has a dedicated RCA jack AND a dedicated XLR jack — they are not shared/switched).

| Channel Group | Channels | RCA | XLR |
|---------------|----------|-----|-----|
| Front L/R | 2 | Yes | Yes |
| Center | 1 | Yes | Yes |
| Surround L/R | 2 | Yes | Yes |
| Surround Back L/R | 2 | Yes | Yes |
| Height 1 L/R (Front Height) | 2 | Yes | Yes |
| Height 2 L/R (Rear Height) | 2 | Yes | Yes |
| Height 3 L/R (Top Middle or alt) | 2 | Yes | Yes |
| Front Wide L/R | 2 | Yes | Yes |
| **Subtotal main channels** | **17** | Yes | Yes |
| Subwoofer OUT 1–4 | 4 | Yes (RCA) | No XLR on sub outs |

Total pre-out connectors on rear panel: 17× RCA + 17× XLR (main) + 4× RCA (sub) = **38 RCA + 17 XLR**

Note: The "17.4" designation means 17 main channels + 4 independent subwoofer outputs.

### Output Voltage

| Output | Rated | Measured @0.1% THD+N | Measured @1% THD+N | Source |
|--------|-------|----------------------|---------------------|--------|
| RCA pre-outs | 1.2 Vrms (nominal) | 6.5 Vrms | 6.8 Vrms | Audioholics review |
| XLR pre-outs | 2.4 Vrms (nominal) | 12.9 Vrms | 13.6 Vrms | Audioholics review |

The rated 1.2V/2.4V are standard signal levels; the measured clipping voltages of 6.5/12.9 Vrms represent maximum headroom before distortion. This is exceptional headroom — approximately 14 dB above standard.

SINAD: ~101 dB (XLR), ~100 dB (RCA) — both measured with 7 channels driven simultaneously.

### Subwoofer Outputs
| Parameter | Value |
|-----------|-------|
| Count | 4 independent |
| Connector | RCA (unbalanced) |
| XLR option | No — sub outs are RCA only |
| Sub EQ HT | Yes — individual delay and level trim per sub output |

### Headphone Output
| Parameter | Value |
|-----------|-------|
| Present | Yes |
| Location | Front panel (behind hinged door) |
| Connector | 6.35mm (¼") TRS |
| Notes | Disables speaker outputs when plugged in |

### Zone 2 / Zone 3 Outputs
| Zone | Audio Out | Video Out | Notes |
|------|-----------|-----------|-------|
| Zone 2 | Stereo RCA pre-out | HDMI (dedicated HDMI ZONE2 OUT) | HDMI audio in Zone 2: 2-channel PCM only; sources: HDMI 1–7, analog |
| Zone 3 | Stereo RCA pre-out | None (audio only) | Stereo only |

Zone 2 and Zone 3 pre-outs are included in the 17.4 channel count (they share the same physical pre-out jacks but are switchable).

---

## 3. Video I/O

### HDMI Inputs
| Parameter | Value |
|-----------|-------|
| Count | 7 |
| Version | HDMI 2.1 on all 7 |
| Max resolution | 8K/60Hz |
| 4K/120Hz | Yes |
| VRR | Yes |
| ALLM | Yes |
| QFT | Yes |
| HDCP | 2.3 |
| 8K upscaling | Yes (from 1080p/4K) |

### HDMI Outputs
| Output | Version | Max Resolution | Features |
|--------|---------|---------------|---------|
| HDMI OUT 1 | 2.1 | 8K/60Hz | eARC, primary display |
| HDMI OUT 2 | 2.1 | 8K/60Hz | Secondary display (same zone) |
| HDMI ZONE 2 OUT | 2.1 | 4K (limited) | Zone 2 video distribution, 2ch PCM audio only |

Total HDMI outputs: 3 (2 main + 1 zone)

### Legacy Video I/O
None. No composite, component, or S-Video on the AV 10.

---

## 4. Processing

| Parameter | Value |
|-----------|-------|
| Total processing channels | 15.4 (15 assignable + 4 subwoofer) |
| Maximum Atmos config | 9.4.6 (9 floor + 4 sub + 6 height) — confirmed by Marantz manual |
| Dolby Atmos | Yes |
| DTS:X | Yes |
| DTS:X Pro | Yes (up to 15.1 channels) |
| Auro-3D | Yes |
| IMAX Enhanced | Yes |
| Sony 360 Reality Audio | Yes |
| Dolby TrueHD | Yes |
| DTS-HD Master Audio | Yes |
| Room correction | Audyssey MultEQ XT32 |
| Audyssey features | MultEQ XT32, Dynamic EQ, Dynamic Volume, LFC, Sub EQ HT |
| Sub EQ HT | Yes — calibrates up to 4 subs individually |
| Dirac Live | Upgradeable (paid add-on) |
| DSD playback | Up to DSD 5.6 MHz (128) via USB |
| FLAC | Up to 192 kHz/24-bit |

---

## 5. Control and Network

### Network Connectivity
| Feature | Spec |
|---------|------|
| Ethernet | 100BASE-TX (RJ-45) |
| Wi-Fi | IEEE 802.11 a/b/g/n/ac (2.4 GHz + 5 GHz) — Wi-Fi 5 class |
| Bluetooth | v5.4, 2.4 GHz, Class 1 |
| BT transmit | Yes (re-transmit to BT headphones — A2DP transmitter) |
| BT receive | Yes (from phones/tablets — A2DP receiver) |
| BT codec | SBC only (no AAC, no aptX) |

### Control Ports
| Port | Count | Connector | Spec |
|------|-------|-----------|------|
| RS-232C | 1 | DB-9 | Home automation control |
| IR Flasher IN | 1 | 3.5mm mono | IR repeater input |
| Remote Control IN | 1 | 3.5mm | Marantz system bus IN |
| Remote Control OUT | 1 | 3.5mm | Marantz system bus OUT |
| AMP CONTROL | 1 set | 3.5mm | Controls Marantz AMP 10 specifically |
| 12V DC Trigger OUT | 2 | 3.5mm mono | 12V DC, max 150 mA each |
| DC OUT (power supply) | Multiple | 3.5mm mono | 12V DC / 150 mA — for accessories |

Note: Trigger Out 1 and Trigger Out 2 can be independently configured to activate based on zone power state, input selection, or HDMI output selection.

### USB Ports (Summary)
| Port | Location | Type | Function |
|------|----------|------|----------|
| USB-A | Front panel | Type-A | Media playback from USB storage |
| USB-A | Rear panel | Type-A | 5V/1.5A power supply only |

---

## 6. Physical Specifications
| Parameter | Value |
|-----------|-------|
| Dimensions (W×D×H) | 17.4" × 19.0" × 7.4" (without antenna) |
| Weight | 37.0 lbs |
| Power supply | AC 120V, 60 Hz |
| Power consumption | 100W |
| Standby (network off) | 0.2W |
| CEC standby | 0.5W |
| Operating temperature | 41°F – 95°F (5°C – 35°C) |

---

## Comparison Table: AV 10 vs. Denon AVR-X6800H (for project reference)

| Feature | Marantz AV 10 | Denon AVR-X6800H |
|---------|--------------|------------------|
| Processing channels | 15.4 | 11.4 |
| Pre-out connector | RCA + XLR on all ch | RCA only |
| Subwoofer outputs | 4 | 2 |
| Max sub outs | 4 | 2 |
| Max Atmos config | 9.4.6 | 7.4.4 |
| HDMI inputs | 7 | 8 |
| HDMI version | 2.1 all | 2.1 all |
| Built-in amplification | None (pre-amp only) | 11ch (140W/ch) |
| Dirac Live | Add-on (paid) | Full (included) |
| Audyssey | MultEQ XT32 | MultEQ XT32 |
| Price | ~$8,000 | ~$2,200 |
| Project status | Not adopted | **Active (Option D)** |

---

## Bidirectional Search

- **Searched FOR:** Marantz AV10 full I/O specs, HDMI counts, pre-out voltages, analog inputs, Bluetooth specs, Wi-Fi specs, zone outputs, control ports, processing channels
- **Searched AGAINST:** Claims of XLR on sub outs (not confirmed — sub outs are RCA only), claims of aptX or AAC Bluetooth codec (manual confirms SBC only), claims of Wi-Fi 6 (confirmed 802.11ac = Wi-Fi 5 class)
- **Contradicting evidence found:** Yes — minor: some sources implied all pre-outs are on "17.4 RCA + 17.4 XLR" as if they were separate channels; confirmed that RCA and XLR share the same channels (not additive). Bluetooth codec claims of "aptX" appeared in one retailer description but the official Marantz manual Bluetooth section lists only SBC. Sub outs are confirmed RCA only (no XLR) despite some descriptions not clarifying this.

---

## Recommendations

The AV 10 is not the current project choice — the Denon AVR-X6800H is adopted in Option D for cost reasons and because Dirac Live Full + Bass Control + ART is included. However, if the project ever reconsiders separates (e.g., for maximum channel count or full XLR balanced signal chain to the AMP 10), the AV 10 is well-documented and its I/O is now fully characterized.

Key practical notes:
- The 4 subwoofer outputs with individual Sub EQ HT trim is a significant advantage for the 8-corner-sub array
- XLR pre-outs at 12.9 Vrms headroom are exceptional and would pair well with the ICEpower 1200AS2 amps
- The Bluetooth SBC-only limitation is a minor inconvenience for casual listening but irrelevant for theater use
- HDMI Zone 2 out is limited to 2ch PCM audio — important if Zone 2 audio quality matters

**Confidence:** High — specs sourced from Marantz official manual pages, Marantz support pages, and corroborated by Upscale Audio product listing. Output voltages sourced from Audioholics measured review.

---

## Sources

1. [Marantz AV 10 Official Product Page (US)](https://www.marantz.com/en-us/product/av-processors-pre-amplifiers/av-10/300584.html)
2. [Marantz AV 10 Online Manual — High Performance Specs](https://manuals.marantz.com/AV10/NA/EN/GFNFSYsavbhwwe.php)
3. [Marantz AV 10 Online Manual — General Specs](https://manuals.marantz.com/AV10/NA/EN/GFNFSYbsjxinov.php)
4. [Marantz AV 10 Online Manual — Bluetooth Section](https://manuals.marantz.com/AV10/NA/EN/PCIRSYjjurmynj.php)
5. [Marantz AV 10 Online Manual — Wireless LAN](https://manuals.marantz.com/AV10/NA/EN/SEHFSYstaewjcx.php)
6. [Marantz AV 10 Online Manual — Front Panel](https://manuals.marantz.com/AV10/NA/EN/GFNFSYpztnjoik.php)
7. [Marantz AV 10 Online Manual — Rear Panel](https://manuals.marantz.com/AV10/NA/EN/DNTXSYultsfrsy.php)
8. [Marantz AV 10 Online Manual — DC OUT Jacks](https://manuals.marantz.com/AV10/NA/EN/SEHFSYkjharxjo.php)
9. [Marantz AV 10 Online Manual — Trigger Outputs](https://manuals.marantz.com/AV10/NA/EN/GFNFSYnkzkogdr.php)
10. [Marantz AV 10 Online Manual — USB Port](https://manuals.marantz.com/AV10/NA/EN/WBSPSYcyejcjxr.php)
11. [Marantz AV 10 Online Manual — HDMI About](https://manuals.marantz.com/AV10/NA/EN/GFNFSYdtphpnek.php)
12. [Marantz AV 10 Online Manual — Zone Connections](https://manuals.marantz.com/AV10/NA/EN/PCIRSYclbdufqa.php)
13. [Marantz AV 10 Online Manual — Zone 2/3 Setup](https://manuals.marantz.com/AV10/NA/EN/GFNFSYztpsvccs.php)
14. [Marantz AV 10 Online Manual — Audyssey Setup](https://manuals.marantz.com/AV10/NA/EN/GFNFSYhguxmdhl.php)
15. [Marantz Support — Max RCA/XLR Output Voltage](https://support.marantz.com/app/answers/detail/a_id/14542/~/max-voltage-output-from-an-avs-rca-and-xlr-pre-outs)
16. [Marantz Support — 12V Trigger Spec](https://support.marantz.com/app/answers/detail/a_id/14461/~/12v-dc-trigger-out-max-specification-for-av-and-avr)
17. [Upscale Audio — AV 10 Product Page](https://upscaleaudio.com/products/marantz-av10-15-4-channel-a-v-preamp-processor)
18. [Audioholics — Marantz AV 10 15.4CH Review (measured output voltages)](https://www.audioholics.com/av-preamp-processor-reviews/marantz-av-10-15.4ch-processor)
19. [Marantz AV 10 Online Manual — Bluetooth Listening](https://manuals.marantz.com/AV10/NA/EN/SEHFSYeqzwufsj.php)

## Follow-up Tasks Created

- Task #2 (pre-existing): Verify Marantz AV 10 I/O specs against 3+ independent sources — blocked by this task, now unblocked.
