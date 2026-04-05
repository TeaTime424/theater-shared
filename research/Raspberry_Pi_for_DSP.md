# Raspberry Pi Selection for ADAU1452 DSP Control

**Status:** RESEARCH --- Not adopted
**Date:** 2026-03-02
**Revision:** 1.0
**Author:** Research assessment for home theater DSP automation
**Related:** `research/sigmastudio-tcp-control.md`, `research/DIY_DSP_4x8_Design.md`

## Executive Summary

A Raspberry Pi serves as the hardware bridge between a Windows measurement PC and an ADAU1452 DSP board, running the blus-audio/sigmadsp backend as a systemd service. The Pi communicates with the DSP via SPI and exposes a gRPC interface (port 50051) for remote parameter read/write. It performs no audio processing --- just register relay.

**Recommendation:** Raspberry Pi 4 Model B, 2GB RAM ($55) is the optimal choice. It provides proven sigmadsp compatibility, adequate RAM headroom for Python + gRPC + OS, Gigabit Ethernet, identical SPI pinout to all other 40-pin Pi models, and the most mature driver ecosystem. The Pi 5 works but costs more and introduces SPI driver complexity with no benefit for this workload. The Pi Zero 2 W is too RAM-constrained at 512MB.

**Total recommended build cost: ~$87**

---

## 1. Use Case Requirements

| Requirement | Detail |
|-------------|--------|
| Primary function | Run sigmadsp backend (blus-audio) as systemd service |
| Communication to DSP | SPI (GPIO 8/9/10/11) + GPIO 17 (RESET) + GPIO 22 (SELFBOOT) |
| Communication to PC | gRPC server on port 50051, Ethernet (same LAN) |
| Uptime | 24/7, headless, in AV rack |
| Audio processing | None --- all DSP happens on the ADAU1452 |
| Display output | Not needed |
| USB peripherals | Not needed |
| WiFi | Not needed (Ethernet preferred for reliability) |
| Desktop environment | Not needed (Raspberry Pi OS Lite) |

---

## 2. Pi Model Comparison

### 2.1 Hardware Specifications

| Specification | Pi Zero 2 W | Pi 4 Model B | Pi 5 |
|---------------|-------------|--------------|------|
| **SoC** | BCM2710A1 | BCM2711 | BCM2712 |
| **CPU** | Quad Cortex-A53, 1.0 GHz | Quad Cortex-A72, 1.5 GHz | Quad Cortex-A76, 2.4 GHz |
| **RAM options** | 512 MB only | 1/2/4/8 GB | 1/2/4/8/16 GB |
| **Ethernet** | None (WiFi only) | Gigabit | Gigabit |
| **SPI0 pins** | GPIO 8/9/10/11 (40-pin header) | GPIO 8/9/10/11 (40-pin header) | GPIO 8/9/10/11 (40-pin header) |
| **GPIO header** | 40-pin (unpopulated) | 40-pin (populated) | 40-pin (populated) |
| **GPIO chip** | /dev/gpiochip0 | /dev/gpiochip0 | /dev/gpiochip4 |
| **SPI driver** | spi-bcm2835 | spi-bcm2835 | spi-rp1 (via RP1 southbridge) |
| **Power connector** | Micro USB | USB-C | USB-C |
| **Power draw (idle)** | ~0.4W | ~2.7W | ~3.5W |
| **Power draw (load)** | ~1.8W | ~6.4W | ~10W |
| **Recommended PSU** | 5V/1.2A | 5V/3A (15W) | 5V/5A (27W) |
| **Tested with sigmadsp** | No (not documented) | **Yes** | **Yes** |
| **Base price (1GB)** | $15 (512 MB) | $35 | $45 |

### 2.2 SPI Pin Mapping (Identical Across All 40-Pin Models)

| Function | GPIO | Physical Pin | ADAU1452 Connection |
|----------|------|-------------|---------------------|
| MOSI | GPIO 10 | Pin 19 | SPI_MOSI |
| MISO | GPIO 9 | Pin 21 | SPI_MISO |
| SCLK | GPIO 11 | Pin 23 | SPI_SCLK |
| CE0 | GPIO 8 | Pin 24 | SPI_SS (chip select) |
| RESET | GPIO 17 | Pin 11 | RESET (active low) |
| SELFBOOT | GPIO 22 | Pin 15 | SELFBOOT_EN |

All three Pi models expose identical SPI0 pins on the 40-pin header. The physical wiring to the ADAU1452 board is the same regardless of which Pi you choose.

---

## 3. Analysis by Model

### 3.1 Pi Zero 2 W --- Eliminated

**Why it fails:**

1. **512 MB RAM is insufficient.** Raspberry Pi OS Lite consumes ~120-150 MB at idle. Python 3.11+ with gRPC libraries (grpcio) consumes 50-100 MB at baseline. The sigmadsp backend adds its own overhead. That leaves <250 MB free, with no headroom for pip installs, system updates, or memory spikes during gRPC compilation. Users on the Pi forums report Python applications becoming unresponsive on the Zero 2 W due to RAM exhaustion.

2. **No Ethernet.** The Zero 2 W only has 2.4 GHz WiFi (802.11n). For a 24/7 headless service in a rack, wired Ethernet is far more reliable. WiFi adds failure modes: signal strength, interference from AV equipment, DHCP lease issues.

3. **Micro USB power.** Less robust connector than USB-C for permanent installations. Micro USB ports are known to develop intermittent connections over time.

4. **Unpopulated GPIO header.** Requires soldering, which is fine but adds a step and potential failure point.

5. **Not tested with sigmadsp.** The blus-audio project documents testing on Pi 4 and Pi 5 only. No guarantee the SPI backend works correctly on the BCM2710A1.

6. **Thermal concerns.** The Zero 2 W has no heatsink mounting surface and limited thermal dissipation options. In a warm AV rack (30-40C ambient), sustained operation could cause throttling.

**Verdict:** Eliminated. The $20-30 savings is not worth the risk for a 24/7 service.

### 3.2 Pi 4 Model B --- Recommended

**Why it wins:**

1. **Proven sigmadsp compatibility.** The blus-audio project explicitly documents testing on Pi 4 with Raspberry Pi OS 12 (bookworm). This is the reference platform.

2. **Mature SPI driver.** The BCM2711 uses the well-established spi-bcm2835 kernel driver. GPIO access via /dev/gpiochip0. No driver translation layers. Maximum community support and troubleshooting resources.

3. **Gigabit Ethernet.** True Gigabit (not shared with USB like Pi 3). Rock-solid for a gRPC service on a local network.

4. **2GB is the sweet spot.** OS Lite (~130 MB) + Python + sigmadsp + gRPC (~100 MB) + headroom = ~400-500 MB active use. A 2GB model provides 4x the working set, leaving ample room for system updates, pip installs, log buffers, and occasional memory spikes from gRPC.

5. **USB-C power.** Robust connector for permanent installation.

6. **Excellent passive cooling options.** The Flirc case and Geekworm aluminum cases are proven for 24/7 operation on Pi 4, with CPU temps of 48-62C under load at 25C ambient.

7. **Lower power draw than Pi 5.** ~2.7W idle is trivial in a theater rack on a 100A subpanel.

8. **Price.** $55 for the 2GB model (as of March 2026). This is $10 more than the Pi 5 1GB but includes 2x the RAM.

**SPI gotcha: None.** The Pi 4 SPI0 at /dev/spidev0.0 works with the sigmadsp default configuration (bus_number: 0, device_address: 0) with no modifications.

**Verdict:** Recommended. Best balance of proven compatibility, adequate performance, and cost.

### 3.3 Pi 5 --- Acceptable Alternative

**Why it works but is not preferred:**

1. **Also tested with sigmadsp.** The blus-audio project confirms Pi 5 compatibility.

2. **Massively overpowered.** A quad Cortex-A76 at 2.4 GHz is 2-3x the performance of the Pi 4 for a workload that uses <5% of a single Pi 4 core. The gRPC server spends 99.9% of its time idle, waiting for commands.

3. **SPI driver change.** The Pi 5 uses the RP1 southbridge chip for all GPIO/SPI/I2C. GPIO pins are on /dev/gpiochip4 (not gpiochip0), and SPI uses the spi-rp1 driver instead of spi-bcm2835. While sigmadsp has been tested on Pi 5, this is a newer driver stack with less community history. Any GPIO library using the old RPi.GPIO must be replaced with rpi-lgpio or gpiod.

4. **Higher power draw.** Requires 27W PSU ($12) vs 15W for Pi 4 ($8). Draws ~3.5W idle --- not a concern for power cost, but the 27W PSU is physically larger.

5. **Price.** The Pi 5 1GB ($45) is cheaper than the Pi 4 2GB ($55), but you get half the RAM. The Pi 5 2GB ($65) costs $10 more than the Pi 4 2GB for performance you do not need.

**SPI gotcha:** The spidev interface (/dev/spidev0.0) still works the same way at the application level, but the underlying driver is different. If you encounter issues, you cannot fall back to the BCM2835 driver --- you must debug the RP1 stack.

**Verdict:** Acceptable if Pi 4 is unavailable. The 2GB Pi 5 at $65 is the correct choice if going this route.

---

## 4. RAM Analysis

| Component | Estimated RAM Usage |
|-----------|-------------------|
| Raspberry Pi OS Lite (bookworm, 64-bit) | 120-150 MB |
| Python 3.11 interpreter | 15-25 MB |
| sigmadsp backend (with SPI driver) | 20-40 MB |
| grpcio library (idle server) | 30-60 MB |
| System buffers / kernel / journald | 50-80 MB |
| **Total estimated** | **235-355 MB** |
| **Recommended minimum** | **512 MB (tight), 1 GB (comfortable), 2 GB (headroom)** |

**Why not 1GB?** It works, but:
- `pip install` and `pipx install` can spike to 200+ MB during package compilation
- System updates (`apt upgrade`) can consume significant temporary memory
- gRPC Python has documented memory leak issues in some versions --- 2GB provides buffer against gradual growth over weeks/months of uptime
- The cost difference between 1GB and 2GB is $20 (Pi 4) or $20 (Pi 5) --- trivial for a $76K theater

**Why not 4GB+?** Pure waste. You will never use more than 500 MB for this workload. The extra $20-60 buys nothing.

---

## 5. Cooling for 24/7 Rack Operation

### 5.1 Thermal Context

The Pi will sit in an AV equipment rack alongside amplifiers. Ambient temperature inside the rack could be 30-40C depending on ventilation. The Pi 4's CPU throttles at 80C. For 24/7 reliability, target <65C under worst-case load.

### 5.2 Passive Cooling is Sufficient

This workload is extremely light --- the CPU will spend >99% of its time at idle. A passive aluminum case is more than adequate and eliminates fan noise (important in a theater) and fan failure modes (important for 24/7).

### 5.3 Case Recommendations

| Case | Type | Pi 4 Temp (Load) | Pi 4 Temp (Idle) | Price | Notes |
|------|------|-------------------|-------------------|-------|-------|
| **Flirc Pi 4 Case** | Aluminum + thermal pad | ~48C @ 25C amb | ~38C | ~$16 | Gold standard for passive cooling. Proven 24/7 |
| Geekworm P173 | Aluminum + thermal pillars | ~50C @ 25C amb | ~40C | ~$10 | Budget option, works well |
| Argon NEO | Aluminum shell | ~52C @ 25C amb | ~42C | ~$15 | Good, slightly less cooling than Flirc |

**Recommendation:** Flirc case ($16). It is the most proven passive cooling solution for Pi 4 in 24/7 applications. Users consistently report temperatures under 50C at idle and under 65C under sustained load. At 30-40C ambient in a rack, idle temperatures will be ~45-55C --- well within safe margins for this near-idle workload.

### 5.4 Rack Mounting Options

For integration into a standard 19" AV rack:

| Option | Description | Price | Notes |
|--------|-------------|-------|-------|
| Velcro/double-sided tape | Mount Flirc case to rack shelf | ~$5 | Simplest, effective |
| UCTRONICS 1U rack mount | 19" 1U tray holding 1-4 Pis | ~$50 | Overkill for one Pi |
| DIN rail clip + adapter | DIN rail mount case | ~$15-25 | Good if rack has DIN rail |
| 3D-printed bracket | Custom mount for Flirc case | ~$5 | If you have a printer |

**Recommendation:** Velcro mount on an existing rack shelf. The Pi plus Flirc case weighs ~150g. A $2 strip of industrial Velcro is the most practical solution. Save the 1U rack mount for when you have multiple Pis.

---

## 6. Power Supply

| PSU | Pi Model | Output | Price | Notes |
|-----|----------|--------|-------|-------|
| **Official Raspberry Pi 15W PSU** | Pi 4 | 5.1V / 3A, USB-C | ~$8 | Recommended. Correct voltage regulation |
| Official Raspberry Pi 27W PSU | Pi 5 | 5.1V / 5A, USB-C | ~$12 | Required for Pi 5 |
| CanaKit 3.5A USB-C | Pi 4 | 5V / 3.5A, USB-C | ~$10 | Good alternative |
| Generic USB-C charger | Either | Varies | ~$5-15 | Risk of undervoltage warnings |

**Recommendation:** Official Raspberry Pi 15W USB-C PSU ($8). It is designed specifically for the Pi 4, provides stable 5.1V, and is UL-listed. Do not use random phone chargers --- they cause undervoltage throttling and random crashes, which are unacceptable for a 24/7 service.

**Power draw context:** The Pi 4 at idle draws ~2.7W. On a theater system with a dedicated 100A/240V subpanel, this is 0.00001% of capacity. Power cost is approximately $2.40/year at $0.10/kWh.

---

## 7. SPI Compatibility Gotchas

### 7.1 ADAU1452 SPI Requirements

| Parameter | ADAU1452 Spec | Pi SPI Capability |
|-----------|---------------|-------------------|
| SPI mode | Mode 0 (CPOL=0, CPHA=0) | Supported |
| Max SCLK | 22 MHz | Pi 4 default: configurable up to 125 MHz |
| Byte order | MSB first | Default on Pi |
| CS polarity | Active low | Default on Pi |
| Data width | 8-bit | Default on Pi |

### 7.2 SPI Initialization Sequence

The ADAU1452 requires a specific SPI initialization: toggle SS (chip select) three times after reset to switch the control port from I2C mode to SPI mode. The sigmadsp backend handles this automatically when configured for SPI protocol.

### 7.3 Pi 4 SPI: No Issues

The Pi 4 uses the spi-bcm2835 kernel driver, which is the most mature and widely tested SPI implementation in the Raspberry Pi ecosystem. Configuration:

```
# /boot/config.txt (Pi 4)
dtparam=spi=on
```

The spidev interface appears at `/dev/spidev0.0` (SPI0, CE0). The sigmadsp configuration maps directly:

```yaml
# /var/lib/sigmadsp/config.yaml
dsp:
  protocol: "spi"
  bus_number: 0      # SPI0
  device_address: 0  # CE0
```

### 7.4 Pi 5 SPI: Minor Differences

The Pi 5 routes SPI through the RP1 southbridge chip. Key differences:

1. **GPIO chip numbering.** Pins are on `/dev/gpiochip4`, not `/dev/gpiochip0`. The sigmadsp backend uses the `gpiod` library (not RPi.GPIO), so this is handled correctly if running a recent version. Older code using RPi.GPIO will break.

2. **SPI driver.** Uses `spi-rp1` instead of `spi-bcm2835`. The spidev userspace interface is the same, but timing characteristics may differ slightly. For the ADAU1452's modest SPI requirements (well under 22 MHz), this is unlikely to cause issues.

3. **SPI clock accuracy.** The RP1 derives SPI clocks differently than the BCM2711. Reports on the Pi forums indicate some SPI speed discrepancies on early Pi 5 firmware. Ensure firmware is up to date.

### 7.5 Pi Zero 2 W SPI: Untested with sigmadsp

While the SPI hardware is compatible, the blus-audio project has not tested on this platform. The BCM2710A1 SoC uses the same spi-bcm2835 driver as the Pi 4, so it should work in theory, but "should work" is not acceptable for a 24/7 production service.

---

## 8. Software Stack Summary

```
┌─────────────────────────────────────────┐
│  Raspberry Pi 4 (2 GB)                  │
│  Raspberry Pi OS Lite (bookworm, 64-bit)│
│                                         │
│  ┌───────────────────────────────────┐  │
│  │  sigmadsp-backend (systemd)       │  │
│  │    ├─ TCP server (port 8087)      │  │
│  │    │    └─ SigmaStudio compat     │  │
│  │    ├─ gRPC server (port 50051)    │  │
│  │    │    └─ Windows PC connects    │  │
│  │    ├─ SPI driver (/dev/spidev0.0) │  │
│  │    │    └─ ADAU1452 registers     │  │
│  │    ├─ GPIO 17 (RESET, active low) │  │
│  │    └─ GPIO 22 (SELFBOOT)         │  │
│  └───────────────────────────────────┘  │
│                                         │
│  Network: Ethernet (static IP)          │
│  No GUI, no desktop, no audio output    │
└─────────────────────────────────────────┘
         │ SPI (4-wire + 2 GPIO)
         ▼
┌─────────────────────────────────────────┐
│  ADAU1452 DSP Board                     │
│  (e.g., Chinese ADAU1452+CS42448 board) │
│  4-in / 8-out analog audio              │
└─────────────────────────────────────────┘
```

---

## 9. Recommended Configuration and Cost Breakdown

### 9.1 Primary Recommendation: Pi 4 (2GB)

| Item | Product | Price | Source |
|------|---------|-------|--------|
| **Raspberry Pi 4 Model B, 2GB** | SC1146 | $55 | Authorized reseller (PiShop, CanaKit) |
| **Flirc Pi 4 Case** | Aluminum passive cooling | $16 | Amazon / Flirc.tv |
| **Official Pi 15W PSU** | USB-C, 5.1V/3A | $8 | Authorized reseller |
| **microSD card (32GB)** | Samsung EVO Select or SanDisk Extreme | $8 | Amazon |
| **Ethernet cable (Cat6, 3ft)** | Generic | $3 | Amazon |
| **Velcro strips** | Industrial, for rack mounting | $2 | Amazon |
| **Total** | | **~$92** | |

### 9.2 Budget Alternative: Pi 4 (1GB)

| Item | Product | Price |
|------|---------|-------|
| Raspberry Pi 4 Model B, 1GB | SC1145 | $35 |
| Geekworm P173 aluminum case | Passive cooling | $10 |
| Official Pi 15W PSU | USB-C, 5.1V/3A | $8 |
| microSD card (32GB) | Samsung EVO Select | $8 |
| Ethernet cable (Cat6, 3ft) | Generic | $3 |
| **Total** | | **~$64** |

**Trade-off:** Saves $28 but RAM headroom is tighter. Acceptable if you never run pip install on the Pi itself (install via SD card image instead) and accept potential issues with gRPC memory growth over time.

### 9.3 Pi 5 Alternative (If Pi 4 Unavailable)

| Item | Product | Price |
|------|---------|-------|
| Raspberry Pi 5, 2GB | SC1688 | $65 |
| Flirc Pi 5 Case | Aluminum passive cooling | $16 |
| Official Pi 27W PSU | USB-C, 5.1V/5A | $12 |
| microSD card (32GB) | Samsung EVO Select | $8 |
| Ethernet cable (Cat6, 3ft) | Generic | $3 |
| **Total** | | **~$104** |

**Trade-off:** Costs $12 more than Pi 4 recommendation for no tangible benefit in this workload. Higher power draw (27W PSU required). RP1 SPI driver is newer with less field history. Only choose this if Pi 4 2GB is out of stock.

---

## 10. Model Decision Matrix

| Factor | Pi Zero 2 W | Pi 4 (2GB) | Pi 5 (2GB) |
|--------|-------------|------------|------------|
| **Price (board only)** | $15 | $55 | $65 |
| **Price (complete build)** | ~$40 | ~$92 | ~$104 |
| **RAM** | 512 MB (insufficient) | 2 GB (comfortable) | 2 GB (comfortable) |
| **Ethernet** | No (WiFi only) | Gigabit | Gigabit |
| **sigmadsp tested** | No | **Yes** | **Yes** |
| **SPI driver maturity** | Mature (BCM2835) | **Mature (BCM2835)** | New (RP1) |
| **GPIO compatibility** | gpiochip0 | **gpiochip0** | gpiochip4 (different) |
| **Passive cooling** | Difficult | **Excellent options** | Good options |
| **24/7 reliability** | Risky (RAM, WiFi) | **Proven** | Proven |
| **CPU for workload** | Adequate | **More than adequate** | Massive overkill |
| **Power draw (idle)** | 0.4W | 2.7W | 3.5W |
| **Availability (2026)** | Good ($15 protected) | Moderate (in production) | Good |
| **Overall score** | **Eliminated** | **Recommended** | Acceptable |

---

## 11. Setup Checklist (Post-Purchase)

1. Flash Raspberry Pi OS Lite (64-bit, bookworm) to microSD via Raspberry Pi Imager
2. Enable SSH, set static IP, disable WiFi/Bluetooth in imager advanced settings
3. Boot Pi, SSH in
4. Enable SPI: `sudo raspi-config` -> Interface Options -> SPI -> Enable
5. Verify SPI device exists: `ls /dev/spidev0.0`
6. Install sigmadsp: `sudo apt install git && git clone https://github.com/blus-audio/sigmadsp && cd sigmadsp && ./install.sh`
7. Edit `/var/lib/sigmadsp/config.yaml` (set SPI, pin numbers, DSP type `adau14xx`)
8. Wire SPI + GPIO to ADAU1452 board (6 wires + GND)
9. Start service: `sudo systemctl start sigmadsp`
10. Test from Windows PC: `sigmadsp --host <pi-ip> read-register 0x0000 4`
11. Verify gRPC connectivity from Python client on Windows

---

## 12. Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Pi 4 2GB out of stock | Medium | Low | Fall back to Pi 5 2GB ($65) or Pi 4 1GB ($35) |
| SPI communication failure | Low | High | Verify wiring, check SPI mode, test with `spidev_test` utility |
| gRPC memory leak over time | Medium | Low | Set up systemd watchdog with automatic restart; 2GB provides buffer |
| Thermal throttling in rack | Low | Medium | Flirc case keeps idle temps <55C even at 35C ambient |
| microSD card failure | Medium | Medium | Use quality card (Samsung/SanDisk), enable read-only rootfs overlay, keep backup image |
| Power supply failure | Low | Low | Official PSU is UL-listed; keep a spare |
| sigmadsp software update breaks SPI | Low | Medium | Pin to known-good version, test updates in staging |

---

## 13. Conclusion

For a dedicated SPI-to-gRPC bridge running the sigmadsp backend 24/7 in a home theater rack:

- **Buy:** Raspberry Pi 4 Model B, 2GB ($55)
- **Case:** Flirc aluminum passive ($16)
- **PSU:** Official 15W USB-C ($8)
- **Storage:** 32GB Samsung/SanDisk microSD ($8)
- **Total: ~$87-92**

The Pi 4 2GB is the Goldilocks choice: enough RAM to be comfortable, proven SPI drivers, documented sigmadsp compatibility, excellent passive cooling options, and the most mature software ecosystem. The Pi Zero 2 W is too constrained, and the Pi 5 adds cost and driver complexity for zero benefit in this near-idle workload.

In the context of a $76K theater build, the ~$30 difference between the cheapest viable option (Pi 4 1GB at $64 total) and the recommended option (Pi 4 2GB at $92 total) is negligible. Buy the 2GB model and forget about it.

---

## References

1. blus-audio/sigmadsp (GitHub): https://github.com/blus-audio/sigmadsp
2. sigmadsp (PyPI): https://pypi.org/project/sigmadsp/
3. ADAU1452 Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adau1452.pdf
4. Raspberry Pi SPI Pinout: https://pinout.xyz/pinout/spi
5. Raspberry Pi 5 RP1 southbridge: https://www.raspberrypi.com/news/rp1-the-silicon-controlling-raspberry-pi-5-i-o-designed-here-at-raspberry-pi/
6. Raspberry Pi 5 gpiochip4 change: https://forums.raspberrypi.com/viewtopic.php?t=364196
7. Pi 5 SPI driver differences: https://forums.raspberrypi.com/viewtopic.php?t=360436
8. Flirc Pi 4 Case: https://flirc.tv/products/flirc-raspberry-pi-4-case-silver
9. Raspberry Pi pricing (2026): https://www.raspberrypi.com/news/more-memory-driven-price-rises/
10. Geekworm P173 case: https://geekworm.com/products/raspberry-pi-4-heavy-duty-aluminum-passive-cooling-metal-case
11. Official Raspberry Pi 15W PSU: https://www.raspberrypi.com/products/type-c-power-supply/
12. rpi-lgpio (Pi 5 GPIO compatibility): https://rpi-lgpio.readthedocs.io/en/latest/differences.html
13. gRPC Python memory issues: https://github.com/grpc/grpc/issues/22123
14. Raspberry Pi authorized resellers: https://www.raspberrypi.com/resellers/

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-02 | Initial research assessment |
