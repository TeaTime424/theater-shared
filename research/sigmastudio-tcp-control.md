# SigmaStudio TCP/IP Control Protocol Research

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-02
**Revision:** 1.0
**Author:** Research assessment for home theater DSP automation

## Executive Summary

The SigmaStudio TCP/IP protocol is a well-documented, binary protocol used by Analog Devices' SigmaStudio IDE to communicate with SigmaDSP processors over a network. Multiple open-source implementations exist in C and Python, enabling direct register-level and parameter-level control of ADAU-series DSPs without SigmaStudio in the loop. This is directly relevant to automated measurement-to-DSP-adjustment workflows for a 9.4.6 Dolby Atmos system with a 16-subwoofer array, where iterative REW measurement → filter coefficient → DSP upload cycles could be fully automated.

---

## 1. Protocol Specification

### 1.1 Transport Layer

| Parameter | Value |
|-----------|-------|
| Transport | TCP/IP (IPv4 and IPv6) |
| Default Port | **8086** (sigma-tcp official, TCPi) or **8087** (sigmadsp/blus-audio) |
| Byte Order | Big-endian (network byte order) |
| Connection Model | Server listens, SigmaStudio or Python client connects |
| Session | Sequential connections accepted; one client at a time typical |

### 1.2 Protocol Variants

There are **two distinct protocol formats** depending on the DSP family:

| Protocol | DSP Family | Header Size | Address Width |
|----------|-----------|-------------|---------------|
| TCPIP1701 / TCPIP1401 | ADAU1701, ADAU1401, ADAU1702 | 8 bytes | 2 bytes (16-bit) |
| TCPIPADAU1452 / TCPIPADAU1761 | ADAU144x, ADAU145x, ADAU146x | 14 bytes | 2 bytes (16-bit) |

**Critical gotcha:** The TCPIP1701 protocol uses different header lengths and field widths than the ADAU145x protocol. Mixing them up will cause silent failures or garbled data.

### 1.3 ADAU144x/145x/146x Packet Format (Primary — for ADAU1452)

This is the protocol relevant to a home theater setup using the ADAU1452.

#### Write Packet (Client → Server)

| Offset | Size | Field | Description |
|--------|------|-------|-------------|
| 0 | 1 | Control | `0x09` = Write operation |
| 1 | 1 | Block/Safeload | Bit flag: safeload write indicator |
| 2 | 1 | Channel | Channel number |
| 3-6 | 4 | Total Length | Total packet length (big-endian) |
| 7 | 1 | Chip Address | I2C device address of DSP |
| 8-11 | 4 | Data Length | Payload data length (big-endian) |
| 12-13 | 2 | Module Address | Target register/parameter address (big-endian) |
| 14+ | N | Data Payload | Raw data bytes to write |

#### Read Request (Client → Server)

| Offset | Size | Field | Description |
|--------|------|-------|-------------|
| 0 | 1 | Control | `0x0A` = Read request |
| 1-4 | 4 | Total Length | Total packet length (big-endian) |
| 5 | 1 | Chip Address | I2C device address of DSP |
| 6-9 | 4 | Data Length | Number of bytes to read (big-endian) |
| 10-11 | 2 | Module Address | Source register/parameter address (big-endian) |
| 12-13 | 2 | Reserved | Reserved for future use |

#### Read Response (Server → Client)

| Offset | Size | Field | Description |
|--------|------|-------|-------------|
| 0 | 1 | Control | `0x0B` = Read response |
| 1-4 | 4 | Total Length | Total packet length (big-endian) |
| 5 | 1 | Chip Address | I2C device address of DSP |
| 6-9 | 4 | Data Length | Payload data length (big-endian) |
| 10-11 | 2 | Module Address | Source register/parameter address (big-endian) |
| 12 | 1 | Success/Fail | 0 = success, 1 = failure |
| 13 | 1 | Reserved | Reserved for future use |
| 14+ | N | Data Payload | Read data bytes |

### 1.4 Simplified Protocol (sigma-tcp official / ADAU1701)

The official ADI `sigma-tcp` utility uses a simpler 8-byte header:

| Offset | Size | Field | Description |
|--------|------|-------|-------------|
| 0 | 1 | Command Type | `0x0A` = Read, `0x0B` = Write |
| 1-2 | 2 | Total Length | Packet length (big-endian) |
| 3 | 1 | Status/Reserved | Status byte |
| 4-5 | 2 | Data Length | Payload length (big-endian) |
| 6-7 | 2 | Address | Target register address (big-endian) |
| 8+ | N | Payload | Data bytes |

**Note:** In this variant, the Read command (`0x0A`) is sent by the client, and the server responds with a Write command (`0x0B`) containing the requested data. This overloading of `0x0B` for both "write to DSP" and "read response" is a known source of confusion.

### 1.5 Safeload Protocol (ADAU1452)

Safeload writes prevent audio glitches during parameter updates. On the ADAU1452:

| Register | Address | Purpose |
|----------|---------|---------|
| Safeload Data 0-4 | `0x6000`–`0x6004` | Up to 5 words of parameter data |
| Safeload Target Address | `0x6005` | Destination address (target - 1) |
| Safeload Trigger/Count | `0x6006` | Number of words + trigger (1-5) |

**Data format:** ADAU1452 uses **8.24 fixed-point** (32-bit) for parameter values.

**Procedure:**
1. Write data to `0x6000`–`0x6004` (up to 5 parameters)
2. Write target address to `0x6005` (actual target address minus 1)
3. Write word count to `0x6006` (triggers the safeload)

**Critical gotcha:** The target address written to `0x6005` must be the actual destination address **minus one**. This off-by-one is documented in the datasheet but frequently missed.

---

## 2. What Can Be Controlled

### 2.1 Parameter RAM Contents

All signal processing blocks in a SigmaDSP program store their coefficients in Parameter RAM. Via TCP/IP register writes, you can modify:

| Parameter Type | Description | Typical Use |
|---------------|-------------|-------------|
| **Volume/Gain** | Linear or dB gain multipliers | Channel levels, subwoofer trim |
| **Mute** | Binary on/off flags | Channel muting |
| **IIR Filter Coefficients** | Biquad coefficients (b0, b1, b2, a1, a2) | Parametric EQ, crossover filters |
| **FIR Filter Coefficients** | Tap weights | Room correction, linear-phase crossovers |
| **Delay** | Sample delay values | Time alignment, distance compensation |
| **Dynamics** | Threshold, ratio, attack, release | Limiters, compressors |
| **Mixer Levels** | Cross-point gains in mixer matrices | Routing, summing |
| **Crossover Frequencies** | Filter coefficients (calculated externally) | High-pass, low-pass, bandpass |
| **Phase Inversion** | Polarity flip flag | Subwoofer phase alignment |

### 2.2 Important Caveat

**You do not write "frequency = 80 Hz" to the DSP.** You must:
1. Calculate biquad coefficients for the desired filter (e.g., 80 Hz Butterworth LPF)
2. Convert to the DSP's fixed-point format (8.24 for ADAU1452)
3. Write the raw coefficient bytes to the correct Parameter RAM address via safeload

This means a Python automation layer must include DSP filter coefficient math (scipy.signal or equivalent).

---

## 3. Supported Chips

### 3.1 Chip Compatibility Matrix

| Chip | Family | Protocol | RAM | Sample Rate | I/O | Best For |
|------|--------|----------|-----|-------------|-----|----------|
| ADAU1401 | 140x | TCPIP1701 | Limited | 48 kHz | 2-in/4-out | Simple crossovers |
| ADAU1401A | 140x | TCPIP1701 | Limited | 48 kHz | 2-in/4-out | Simple crossovers |
| ADAU1701 | 170x | TCPIP1701 | 1024 instructions | 48/96 kHz | 2-in/4-out | Basic EQ/crossover |
| ADAU1702 | 170x | TCPIP1701 | 512 instructions | 48/96 kHz | 2-in/2-out | Minimal processing |
| **ADAU1452** | **145x** | **TCPIPADAU1452** | **6144 instructions, 40kW data** | **48/96/192 kHz** | **TDM multi-ch** | **Home theater** |
| ADAU1451 | 145x | TCPIPADAU1452 | 4096 instructions | 48/96/192 kHz | TDM multi-ch | Mid-range |
| ADAU1450 | 145x | TCPIPADAU1452 | 2048 instructions | 48/96/192 kHz | TDM multi-ch | Entry |
| ADAU1463 | 146x | TCPIPADAU1452 | Same as 1452 | 48/96/192 kHz | TDM multi-ch | Pin-compatible 1452 |
| ADAU1467 | 146x | TCPIPADAU1452 | Same as 1452 | 48/96/192 kHz | TDM multi-ch | Pin-compatible 1452 |
| ADAU144x | 144x | TCPIPADAU1452 | Varies | Varies | Varies | Various |

### 3.2 ADAU1452 — The Home Theater Choice

The ADAU1452 is the most capable chip for multi-channel audio processing:

- **294.912 MHz** clock speed
- **6144 SIMD instructions** per sample at 48 kHz (3072 at 96 kHz)
- **40k words** data RAM → ~800 ms digital delay pool
- **8.24 fixed-point** (32-bit) parameter format
- **TDM input/output** — up to 32 channels in/out via serial ports
- **Software safeload** — glitch-free parameter updates
- **Self-boot** from external EEPROM/SPI flash
- Available on the **freeDSP Aurora** open-source board (8-in/8-out, S/PDIF, ADAT, USB Audio Class 2, WiFi, Bluetooth)

---

## 4. Available Tools

### 4.1 blus-audio/sigmadsp (Python — Primary Recommendation)

**Repository:** https://github.com/blus-audio/sigmadsp
**PyPI:** https://pypi.org/project/sigmadsp/
**Version:** 3.0.14 (August 2025)
**License:** GPLv3+

**What it does:** Full Python application that acts as a TCP server on port 8087 for SigmaStudio, while also providing a gRPC interface and CLI for programmatic control. Designed to run on Raspberry Pi as a systemd service.

**Supported chips:**
- ADAU170x (tested) — config: `adau1x0x`
- ADAU140x (untested but register-compatible) — config: `adau1x0x`
- ADAU145x (tested) — config: `adau14xx`
- ADAU146x (tested) — config: `adau14xx`

**Architecture:**
```
SigmaStudio ──TCP:8087──► sigmadsp backend ──SPI/I2C──► DSP
                              │
Python CLI ──gRPC:50051──────┘
```

**Key features:**
- SPI and I2C communication backends
- TCP server compatible with SigmaStudio workflow
- gRPC remote procedure call interface (port 50051)
- CLI commands: `set-volume`, `change-volume`, `read-register`, `reset`, `load-parameters`
- Parameter file parsing from SigmaStudio exports (`.params` files)
- Safety hash verification to prevent mismatched parameter files
- GPIO-based DSP reset (hard/soft)
- Self-boot pin management
- Systemd service integration

**Configuration (`/var/lib/sigmadsp/config.yaml`):**
```yaml
host:
  ip: "0.0.0.0"
  port: 8087
backend:
  port: 50051
dsp:
  type: "adau14xx"       # or "adau1x0x"
  protocol: "spi"        # or "i2c"
  bus_number: 0
  device_address: 0
pins:
  reset:
    number: 17
    active_high: false
  self_boot:
    number: 22
    active_high: true
```

**CLI Examples:**
```bash
sigmadsp set-volume -6.0          # Set volume to -6 dB
sigmadsp change-volume -3.0       # Reduce volume by 3 dB
sigmadsp read-register 0x0000 4   # Read 4 bytes from address 0
sigmadsp reset                     # Reset DSP
sigmadsp load-parameters file.params  # Load SigmaStudio params
```

**Limitations:**
- Currently supports only **one adjustable volume cell** (`adjustable_volume_main`). Multiple volume cells planned via naming convention `adjustable_volume_<name>`.
- Requires SigmaStudio `.params` file export — no raw coefficient writing from the CLI.
- Parameter file must include a `safety_hash` DC cell for version verification.
- Primary target is Raspberry Pi; other platforms may require adaptation.
- No direct "set EQ frequency" command — must recalculate coefficients and re-export params.

### 4.2 Wei1234c/TCPi (Python — Protocol Toolkit)

**Repository:** https://github.com/Wei1234c/TCPi
**License:** Not specified

**What it does:** Python package implementing the SigmaStudio TCP/IP channel protocol for both PC and ESP32 (MicroPython). Provides bidirectional read/write access to DSP memory.

**Supported chips:**
- ADAU1701, ADAU1702, ADAU1401, ADAU1401A

**Architecture:**
```
SigmaStudio ──TCP:8086──► Server (PC + FT232H, or ESP32)──I2C──► DSP
Python Script ──TCP:8086──► Same server
```

**Key features:**
- Read AND write to DSP memory (Program RAM, Parameter RAM, EEPROM)
- Cross-platform: same code runs on PC and ESP32 without modification
- Can act as both TCP client and server
- ESP32 server enables wireless DSP control
- Direct memory addressing for any DSP location

**Limitations:**
- **Only supports ADAU14xx/17xx family** (not ADAU145x/146x)
- "Not high speed, obvious latency" — acknowledged by author
- ESP32 with 8MB PSRAM recommended for SigmaStudio's bulk uploads
- Requires separate `Utilities` package dependency
- Less actively maintained than sigmadsp

### 4.3 Wei1234c/SigmaDSP (Python — High-Level Proxy)

**Repository:** https://github.com/Wei1234c/SigmaDSP

**What it does:** Reads SigmaStudio project XML files and generates Python proxy objects for each DSP algorithm block. Provides high-level methods like `set_frequency()` and `set_dB()` instead of raw register writes.

**Supported chips:**
- ADAU1701, ADAU1702, ADAU1401, ADAU1401A

**Key features:**
- Automatic proxy generation from SigmaStudio XML exports
- High-level parameter methods (frequency, gain, etc.)
- Demonstrated automatic room correction optimization
- Cross-platform (PC, Raspberry Pi, ESP32)
- Load/save to binary files, SigmaStudio text exports, EEPROM

**Limitations:**
- **Only supports ADAU14xx/17xx** — not ADAU1452
- Most SigmaStudio toolbox algorithms remain untested
- Requires FTDI FT232H USB-I2C adapter for PC operation
- Multiple additional package dependencies

### 4.4 analogdevicesinc/sigma-tcp (C — Official Reference)

**Repository:** https://github.com/analogdevicesinc/sigma-tcp
**Status:** Archived (October 2019)
**License:** GPL

**What it does:** The official Analog Devices reference implementation of the SigmaStudio TCP/IP server for Linux. Written in C, provides the canonical protocol implementation.

**Architecture:**
```
SigmaStudio ──TCP:8086──► sigma-tcp ──I2C/regmap──► DSP
```

**Supported backends:**
- I2C (`i2c_backend_ops`)
- Linux regmap (`regmap_backend_ops`)

**Key features:**
- Canonical protocol implementation
- Minimal, well-structured C code
- Pluggable backend architecture

**Limitations:**
- **Archived — no longer maintained**
- Linux only
- No Python bindings
- No high-level parameter abstraction
- Server only (no client library)

### 4.5 aventuri/sigma_tcp (C — ADAU1452 Fork)

**Repository:** https://github.com/aventuri/sigma_tcp

**What it does:** C gateway specifically targeting the ADAU1452, bridging SigmaStudio to DSP via I2C on ARM single-board computers.

**Tested with:**
- SigmaStudio v3.14.1 (Build 1675)
- Cubieboard (Allwinner A10 SoC)
- ADAU1452 via I2C

**Usage:**
```bash
./sigma_tcp i2c /dev/i2c-1 0x3b
```

**Limitations:**
- C only, no Python bindings
- ARM SBC specific
- Limited documentation

### 4.6 MCUdude/SigmaDSP (Arduino Library)

**Repository:** https://github.com/MCUdude/SigmaDSP
**License:** LGPL-3.0

**What it does:** Arduino library for programming and controlling ADAU1401/1701/1702 over I2C. Includes parameter generator scripts.

**Relevance:** Not directly usable for TCP/IP control, but the parameter generator scripts (`DSP_parameter_generator.ps1` / `.sh`) are useful for extracting parameter addresses from SigmaStudio exports.

### 4.7 SigmaStudio Scripting Server (Windows COM/ActiveX)

**Interface:** .NET / ActiveX COM server (`Analog.SigmaStudioServer.dll`)
**Requirement:** SigmaStudio must be running on the same Windows PC

**Capabilities (comprehensive):**
- Project management: `NEW_PROJECT`, `OPEN_PROJECT`, `SAVE_PROJECT`, `COMPILE_PROJECT`, `DOWNLOAD`
- Register operations: `REGISTER_WRITE`, `REGISTER_READ`, `REGISTER_SAFELOAD_WRITE`
- Parameter operations: `PARAMETER_WRITE`, `PARAMETER_WRITE_FLOAT`, `PARAMETER_READ`
- Design manipulation: `INSERT_OBJECT`, `CONNECT_OBJECT`, `SET_OBJECT_PROPERTY`
- Schematic control: `SET_SAMPLING_RATE`, `SET_BLOCK_SIZE`, `TOGGLE_FREEZE_SCHEMATIC`
- Execution: `RUN_SCRIPT`, `RUN_SCRIPT_FILE`
- SHARC processor support: `BOOT_SHARC`, `READ_MIPS_SHARC`

**Python access via COM:**
```python
import win32com.client
ss = win32com.client.Dispatch("Analog.SigmaStudioServer")
ss.OPEN_PROJECT("my_project.dspproj")
ss.COMPILE_PROJECT()
ss.DOWNLOAD()
ss.PARAMETER_WRITE_FLOAT("Module_Name", 0.5)
ss.REGISTER_SAFELOAD_WRITE(addr, data)
```

**Limitations:**
- **Windows only** — requires SigmaStudio installed and running
- COM automation can be fragile (versioning, registration issues)
- SigmaStudio must remain in foreground for some operations
- Not suitable for headless Linux/Raspberry Pi deployments

### 4.8 SigmaStudio+ (Apache Thrift API)

**Platform:** SigmaStudio+ (next-gen IDE from ADI)
**API:** Apache Thrift-based scripting

**Status:** Early/limited documentation. Users report the Thrift API exists and Python scripts work, but examples are sparse — mostly "hello world" level. Some users have successfully created Python scripts for ADAU1452-based boards.

**Limitations:**
- Poorly documented
- Limited community examples
- Still requires SigmaStudio+ running on Windows

---

## 5. Tool Comparison

| Feature | sigmadsp (blus-audio) | TCPi (Wei1234c) | SigmaDSP (Wei1234c) | sigma-tcp (ADI) | SS Scripting Server | aventuri/sigma_tcp |
|---------|----------------------|-----------------|---------------------|-----------------|--------------------|--------------------|
| **Language** | Python 3.9+ | Python / MicroPython | Python | C | COM/.NET (Python via win32com) | C |
| **ADAU1452 Support** | Yes (tested) | No (1401/1701 only) | No (1401/1701 only) | Yes (implied) | Yes | Yes (primary) |
| **Protocol** | TCP server (8087) | TCP client/server (8086) | Direct I2C via FT232H | TCP server (8086) | COM automation | TCP server (8086) |
| **Read Registers** | Yes | Yes | Yes | Yes | Yes | Yes |
| **Write Registers** | Yes | Yes | Yes | Yes | Yes | Yes |
| **Safeload** | Via SigmaStudio | Not documented | Not documented | Yes | Yes | Not documented |
| **High-Level API** | Volume only | Raw memory | set_frequency, set_dB | None | Full SigmaStudio API | None |
| **Runs Headless** | Yes (systemd) | Yes | Partial | Yes | No (needs SigmaStudio) | Yes |
| **Platform** | Linux (RPi primary) | PC / ESP32 | PC / ESP32 / RPi | Linux | Windows only | Linux (ARM SBC) |
| **Active Maintenance** | Yes (v3.0.14, 2025) | Low | Low | Archived (2019) | ADI maintained | Low |
| **gRPC Interface** | Yes | No | No | No | No | No |
| **Parameter Files** | SigmaStudio .params | XML project files | XML project files | None | Native | None |
| **License** | GPLv3+ | Unknown | Unknown | GPL | Proprietary | GPL-3.0 |
| **Ease of Integration** | High | Medium | Medium | Low (C) | Medium (Windows only) | Low (C) |

---

## 6. Feasibility of Claude Code Integration

### 6.1 Option A: MCP Server Wrapping sigmadsp gRPC

The most practical integration path for Claude Code:

```
Claude Code ──MCP Protocol──► MCP Server (Python)
                                    │
                                    ├──gRPC:50051──► sigmadsp backend ──SPI/I2C──► DSP
                                    │
                                    └──TCP:8087──► Direct protocol implementation
```

**Implementation approach:**
1. Build a Python MCP server that wraps sigmadsp's gRPC interface
2. Expose tools like `read_dsp_register`, `write_dsp_register`, `set_volume`, `load_parameters`
3. Add coefficient calculation tools (biquad, FIR, delay) using scipy.signal
4. Claude Code can then orchestrate: measure → analyze → calculate filters → upload

**Required MCP tools:**
- `dsp_read_register(address, length)` — Read raw register data
- `dsp_write_register(address, data)` — Write raw register data
- `dsp_safeload_write(target_address, data_words)` — Glitch-free parameter write
- `dsp_set_volume(channel, db)` — Set channel volume
- `dsp_calculate_biquad(filter_type, frequency, q, gain, sample_rate)` — Compute filter coefficients
- `dsp_calculate_crossover(type, frequency, order, sample_rate)` — Compute crossover coefficients
- `dsp_upload_eq(channel, biquad_index, coefficients)` — Write EQ to specific slot
- `dsp_get_parameter_map()` — List all addressable parameters from SigmaStudio export

### 6.2 Option B: Pure Python Module (No MCP)

A standalone Python module that Claude Code invokes via shell:

```python
# sigmadsp_control.py — Claude Code callable module
import socket
import struct
from scipy.signal import iirfilter, bilinear_zpk, zpk2sos

class SigmaDSPController:
    """Direct TCP/IP control of ADAU1452 via SigmaStudio protocol."""

    WRITE_CMD = 0x09      # ADAU145x write
    READ_CMD = 0x0A       # ADAU145x read request
    READ_RESP = 0x0B      # ADAU145x read response

    SAFELOAD_DATA_BASE = 0x6000
    SAFELOAD_ADDR_REG = 0x6005
    SAFELOAD_TRIGGER = 0x6006

    def __init__(self, host="192.168.1.100", port=8087):
        self.host = host
        self.port = port
        self.sock = None

    def connect(self):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.connect((self.host, self.port))

    def write_register(self, address, data, chip_addr=0x70):
        """Write data to DSP register via TCP/IP protocol."""
        data_len = len(data)
        total_len = 14 + data_len
        header = struct.pack(">BBBI4sH",
            self.WRITE_CMD,         # Control byte
            0,                       # Block/safeload flag
            0,                       # Channel
            total_len,               # Total length
            bytes([chip_addr]),      # Chip address
            data_len,                # Data length
            address                  # Module address
        )
        self.sock.sendall(header + data)

    def safeload_write(self, target_addr, params):
        """Safeload write up to 5 parameters without audio glitch."""
        assert len(params) <= 5, "Safeload supports max 5 parameters"
        for i, param in enumerate(params):
            self.write_register(self.SAFELOAD_DATA_BASE + i,
                                param.to_bytes(4, 'big'))
        self.write_register(self.SAFELOAD_ADDR_REG,
                            (target_addr - 1).to_bytes(4, 'big'))
        self.write_register(self.SAFELOAD_TRIGGER,
                            len(params).to_bytes(4, 'big'))

    def float_to_8_24(self, value):
        """Convert float to ADAU1452 8.24 fixed-point."""
        return int(value * (1 << 24)) & 0xFFFFFFFF

    def biquad_to_params(self, b, a):
        """Convert scipy biquad coefficients to ADAU1452 format.

        ADAU1452 biquad format:
          b0, b1, b2, -a1, -a2 (a0 normalized to 1.0)
        Note: a1 and a2 signs are NEGATED vs scipy convention.
        """
        b0 = self.float_to_8_24(b[0] / a[0])
        b1 = self.float_to_8_24(b[1] / a[0])
        b2 = self.float_to_8_24(b[2] / a[0])
        a1 = self.float_to_8_24(-a[1] / a[0])  # Negated
        a2 = self.float_to_8_24(-a[2] / a[0])  # Negated
        return [b0, b1, b2, a1, a2]
```

### 6.3 Option C: Hybrid — sigmadsp Backend + Custom Python Client

Use the blus-audio/sigmadsp as the hardware backend (running on Raspberry Pi connected to DSP), and write a custom Python client that speaks to it over gRPC. The client runs on the measurement PC alongside Claude Code.

```
Measurement PC                          Raspberry Pi
┌─────────────────────┐                ┌──────────────────┐
│ REW / UMIK-1        │                │ sigmadsp backend  │
│ Claude Code         │                │   ↕ gRPC:50051   │
│ Python MCP Server   │──── gRPC ─────►│   ↕ SPI/I2C      │
│   └─ scipy.signal   │                │ ADAU1452 DSP     │
└─────────────────────┘                └──────────────────┘
```

### 6.4 Recommended Path

**Option C (Hybrid)** is the most practical:
1. Use sigmadsp (blus-audio) as the proven, maintained hardware bridge
2. Write a thin Python gRPC client for register-level access
3. Build coefficient calculation in scipy.signal on the measurement PC
4. Wrap everything in an MCP server for Claude Code orchestration
5. REW measurements feed into Claude Code analysis, which computes corrections and pushes them to the DSP

---

## 7. Relevance to Home Theater System

### 7.1 System Context

The target system is a 9.4.6 Dolby Atmos configuration:
- 3x LCR (Titan-815LX)
- 4x Surrounds (Volt-10)
- 6x Atmos heights (Volt-10)
- 16x Subwoofers (Dayton UMII18-22) in main array + nearfield
- 16x Tactile transducers (Aura Pro AST-2B-4)

### 7.2 Where SigmaDSP TCP Control Fits

| Application | How TCP Control Helps |
|-------------|----------------------|
| **Subwoofer EQ** | Automated measurement → PEQ coefficient → safeload write cycles for 16 subs |
| **Crossover Tuning** | Adjust crossover frequencies and slopes without touching SigmaStudio GUI |
| **Time Alignment** | Read delay values, adjust based on measured impulse response |
| **Level Matching** | Automated gain trim across all channels to match reference levels |
| **Room Correction** | Iterative measure → correct → measure loops for bass optimization |
| **Tactile Tuning** | Independent EQ/crossover for bass shakers without affecting main audio |
| **A/B Testing** | Instant parameter switching between correction profiles |
| **Measurement Automation** | Claude Code drives REW measurement, analyzes result, updates DSP, re-measures |

### 7.3 Architecture for 16-Sub Array Control

For a 16-subwoofer array, you need significant DSP resources. Options:

**Option A: Multiple ADAU1452 boards**
- 2-3x freeDSP Aurora (8-in/8-out each)
- Each controlled via separate sigmadsp instance
- Daisy-chain or star topology I2C/SPI

**Option B: ADAU1452 + Dayton DSP-408 hybrid**
- ADAU1452 for complex processing (FIR EQ, crossovers)
- Dayton DSP-408 for per-subwoofer channel level/delay
- TCP control for ADAU1452, serial/USB for DSP-408

**Option C: Dedicated DSP platform (miniDSP SHD, DDRC-88BM)**
- These have their own control protocols (not SigmaStudio TCP)
- Less flexible but more turnkey

### 7.4 Practical Workflow

```
1. Deploy SigmaStudio project to ADAU1452 (one-time design)
     ↓
2. Export parameter file (.params) with named cells
     ↓
3. Map parameter addresses to logical names (EQ1_freq, Sub3_gain, etc.)
     ↓
4. Automated measurement cycle:
     a. Claude Code triggers REW measurement via CLI
     b. REW exports impulse response / frequency response
     c. Claude Code analyzes response, computes correction filters
     d. Python calculates biquad coefficients (scipy.signal)
     e. Coefficients converted to 8.24 fixed-point
     f. Safeload write via TCP/IP to ADAU1452
     g. Repeat from (a) until target response achieved
```

### 7.5 Gotchas for Home Theater Integration

1. **Coefficient format matters.** ADAU1452 uses 8.24 fixed-point. Overflow at values >= 128.0 or < -128.0. Most audio coefficients fit, but be careful with high-gain PEQ boosts.

2. **Safeload is essential.** Never write raw coefficients to Parameter RAM without safeload — you will hear clicks and pops at reference levels.

3. **Address mapping is manual.** You must export the parameter address map from SigmaStudio and maintain a lookup table. Any change to the SigmaStudio project may shift addresses.

4. **Processing budget.** At 48 kHz, ADAU1452 has 6144 instructions per sample. A typical 5-band PEQ uses ~30 instructions per channel. 16 subwoofer channels x 10-band PEQ = ~4800 instructions — tight but feasible on one chip. FIR filters consume far more resources.

5. **Latency.** TCP/IP adds ~1-10 ms latency per parameter write. Not audible for static correction, but not suitable for real-time adaptive processing.

6. **The Dayton DSP-408 HPF minimum is 20 Hz, not 10 Hz.** If using Dayton units alongside ADAU1452, infrasonic filtering must be handled on the ADAU1452 side.

7. **miniDSP 2x4 HD biquad format requires inverted a1/a2 signs** — different from ADAU1452 convention. If mixing platforms, coefficient conversion code must account for this.

---

## 8. References

1. Analog Devices Wiki — TCP/IP Channels (ADAU144x/145x/146x): https://wiki.analog.com/resources/tools-software/sigmastudio/usingsigmastudio/tcpipchannels
2. Analog Devices Wiki — SigmaStudio Scripting Server: https://wiki.analog.com/resources/tools-software/sigmastudio/usingsigmastudio/scripting/server
3. Analog Devices Wiki — SigmaStudio Scripting: https://wiki.analog.com/resources/tools-software/sigmastudio/usingsigmastudio/scripting
4. blus-audio/sigmadsp (PyPI): https://pypi.org/project/sigmadsp/
5. blus-audio/sigmadsp (GitHub): https://github.com/blus-audio/sigmadsp
6. Wei1234c/TCPi: https://github.com/Wei1234c/TCPi
7. Wei1234c/SigmaDSP: https://github.com/Wei1234c/SigmaDSP
8. analogdevicesinc/sigma-tcp (Official, Archived): https://github.com/analogdevicesinc/sigma-tcp
9. aventuri/sigma_tcp (ADAU1452 fork): https://github.com/aventuri/sigma_tcp
10. MCUdude/SigmaDSP (Arduino): https://github.com/MCUdude/SigmaDSP
11. Clockworks AppNote003 — A2B Control from Python: https://clk.works/2020/09/a2b-control-from-python-via-sigmastudio-appnote003/
12. ADI — Software Safeload Write Procedure: https://ez.analog.com/dsp/sigmadsp/w/documents/5203/how-do-i-execute-a-software-safeload-write
13. ADAU1452 Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adau1452.pdf
14. freeDSP Aurora (ADAU1452 board): https://github.com/freeDSP/freeDSP-aurora
15. SigmaStudio+: https://www.analog.com/en/resources/evaluation-hardware-and-software/software/sigmastudio-plus.html
