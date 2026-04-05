# ADAU1701 Windows I2C Bridge Research: sigma_tcp on Windows

**Status:** RESEARCH -- Not adopted
**Date:** 2026-03-04
**Revision:** 1.0
**Related:** `research/ADAU1701_PC_Calibration_System.md`, `research/sigmastudio-tcp-control.md`

---

## Executive Summary

The goal is to get Python code on a Windows 11 PC talking to an ADAU1701 on a Wondom APM2 board, with the USBi/ICP5 programmer already connected. After discovering that SigmaStudio is a TCP **client** (not server), we need a server that Python can also talk to, or a completely different transport. This document evaluates all practical options.

**Bottom line:** There are **four viable paths**, ranked by practicality:

| Rank | Option | Cost | Complexity | Reliability |
|------|--------|------|-----------|-------------|
| 1 | **SigmaStudio COM automation** (win32com) | $0 | Low | High |
| 2 | **FT232H USB-to-I2C** (direct Python I2C) | ~$15 | Low-Medium | High |
| 3 | **Wei1234c/SigmaDSP** (USBi as I2C adapter) | $0 | Medium | Medium |
| 4 | **Custom sigma_tcp server on Windows** (FT232H backend) | ~$15 | High | High |

**Recommended path:** Option 1 (COM automation) for immediate use with zero cost, then Option 2 (FT232H) as a standalone solution that does not require SigmaStudio running.

---

## 1. Can sigma_tcp Run on Windows?

### 1.1 Short Answer: Not Directly

The official `sigma_tcp` from Analog Devices ([analogdevicesinc/sigma-tcp](https://github.com/analogdevicesinc/sigma-tcp)) is:
- Written in C for Linux
- Uses Linux I2C device files (`/dev/i2c-X`) or Linux kernel regmap
- Archived since October 2019
- Has no Windows build system or Windows I2C backend

The community fork ([aventuri/sigma_tcp](https://github.com/aventuri/sigma_tcp)) is similarly Linux-only, tested on ARM SBCs (Cubieboard with Allwinner A10).

The [blus-audio/sigmadsp](https://github.com/blus-audio/sigmadsp) Python package (the most maintained option) is:
- Explicitly Linux/Raspberry Pi targeted
- Uses `raspi-config` for SPI/I2C setup
- Installs as a systemd service
- Default port: 8087

### 1.2 Could You Port It?

Theoretically yes. The sigma_tcp protocol is simple (see Section 5 below), and the I2C backend is pluggable. You would need to:
1. Replace the Linux I2C backend with an FT232H/pyftdi backend
2. Implement the TCP server in Python (straightforward)
3. Handle the TCPIP1701 protocol variant (8-byte header)

This is **Option 4** in the ranking -- viable but the most work.

---

## 2. Can You Use the USBi/ICP5 from Python?

### 2.1 Hardware Architecture

The USBi (EVAL-ADUSB2EBZ) and its Wondom clones (ICP1, ICP3, ICP5) are based on the **Cypress CY7C68013A** (FX2LP) USB microcontroller. Key facts:

| Property | Value |
|----------|-------|
| USB Chip | Cypress CY7C68013A (FX2LP) |
| USB VID | 0x0456 (Analog Devices) |
| USB PID | 0x7031 (programmed USBi) or 0x7030 (unprogrammed) |
| Driver | CyUSB.sys (from SigmaStudio USB drivers folder) |
| Communication | USB vendor-specific bulk transfers |
| I2C/SPI | Firmware-controlled, not a standard USB-I2C bridge |

### 2.2 USBi USB Protocol

SigmaStudio communicates with the USBi using **USB vendor-specific request commands**:

| Command | Code | Purpose |
|---------|------|---------|
| B2 | 0xB2 | Write bytes at memory address |
| B3 | 0xB3 | Set address pointer |
| B4 | 0xB4 | Read bytes |
| B5 | 0xB5 | Finalize write |
| B6 | 0xB6 | Finalize read |

These are USB control/bulk transfers with a proprietary protocol. The USBi firmware (loaded from EEPROM at boot) implements these commands and translates them to I2C/SPI transactions on the DSP side.

### 2.3 Accessing USBi from Python (Wei1234c Approach)

[Wei1234c/SigmaDSP](https://github.com/Wei1234c/SigmaDSP) has successfully used the USBi as a general-purpose USB-to-I2C converter from Python. The approach:

1. Uses [Wei1234c/Bridges](https://github.com/Wei1234c/Bridges) library as an abstraction layer
2. **Bridges** wraps either USBi or FTDI FT232H behind a common I2C interface
3. For USBi: communicates via USB vendor requests (pyusb)
4. For FT232H: communicates via MPSSE protocol (pyftdi)
5. Both present as a standard `machine.I2C`-compatible object

**Windows setup for USBi via pyusb:**
1. Install Zadig (USB driver tool)
2. Replace the CyUSB driver with libusb/WinUSB driver
3. Install `pyusb` via pip
4. **WARNING:** Replacing the driver means SigmaStudio can no longer use the USBi simultaneously

**Key limitation:** USBi hangs when processing data chunks > 512KB. Wei1234c's code handles this by chunking writes.

### 2.4 Verdict on USBi

Using USBi from Python **is possible** but has major drawbacks:
- Requires driver swap (Zadig) -- **breaks SigmaStudio access**
- Cannot use SigmaStudio and Python simultaneously on the same USBi
- The USB protocol is proprietary and reverse-engineered
- Less reliable than FT232H (known to hang on large transfers)

---

## 3. FT232H USB-to-I2C: The Clean Path

### 3.1 How It Works

The FTDI FT232H is a USB-to-serial/SPI/I2C converter with excellent Python support:

| Property | Value |
|----------|-------|
| Chip | FTDI FT232H |
| USB VID | 0x0403 (FTDI) |
| Interface | I2C master via MPSSE engine |
| Clock | Up to 400 kHz (standard I2C) or 3.4 MHz (HS) |
| GPIO | Up to 14 GPIO pins alongside I2C |
| Price | ~$15 (Adafruit breakout) or ~$8 (generic) |
| Python Library | `pyftdi` (pure Python, cross-platform) |

### 3.2 Windows Setup

```bash
pip install pyftdi pyusb
```

On Windows, use Zadig to install the libusb-win32 or WinUSB driver for the FT232H. This does NOT affect the USBi since they have different VID/PID values.

### 3.3 Python I2C Example

```python
from pyftdi.i2c import I2cController

# Open FT232H
i2c = I2cController()
i2c.configure('ftdi://ftdi:232h/1')

# Get port for ADAU1701 (7-bit address 0x34)
dsp = i2c.get_port(0x34)

# Write to parameter RAM: address 0x0000, data [b0, b1, b2, -a1, -a2]
# Address is 16-bit, sent as 2 bytes before data
subaddr = (0x0000).to_bytes(2, 'big')
data = b'\x00\x80\x00\x00'  # b0 = 1.0 in 5.23
dsp.write(subaddr + data)

# Read 4 bytes from address 0x0000
dsp.write(subaddr)  # Set address pointer
result = dsp.read(4)
```

### 3.4 Wiring FT232H to APM2

The Wondom APM2 has an I2C programming header (6-pin). The connections needed:

| FT232H Pin | APM2 Header Pin | Signal |
|------------|----------------|--------|
| AD1 (SDA) | SDA | I2C Data |
| AD0 (SCL) | SCL | I2C Clock |
| GND | GND | Ground |

**Do NOT connect VCC from FT232H to APM2** -- the APM2 has its own power supply. Only connect SDA, SCL, and GND.

**Pull-up resistors:** The APM2 board already has 2.2k pull-ups on SDA/SCL. The FT232H has internal pull-ups that can be enabled. With both present, the effective pull-up is ~1.1k, which is fine for I2C at 100-400 kHz.

### 3.5 Multi-Master Concern

The FT232H MPSSE engine is an **I2C master only** -- it does NOT support multi-master arbitration. This means:

- **Do not connect FT232H to the I2C bus while the USBi/ICP5 is also connected and SigmaStudio is actively communicating.** Two masters without arbitration will corrupt the bus.
- **Safe scenario:** USBi/ICP5 for initial program download and EEPROM writes (via SigmaStudio), then disconnect USBi and use FT232H for runtime parameter control.
- **Alternative safe scenario:** Leave both physically connected, but only use one at a time. When SigmaStudio is idle (not actively downloading), the USBi is not driving the bus, so the FT232H can safely communicate.

### 3.6 I2C Bus Access on the APM2

The Wondom APM2 (AA-AP23122) programming header uses a 6-pin connector:

| Pin | Signal | Notes |
|-----|--------|-------|
| 1 | SDA | I2C data |
| 2 | SCL | I2C clock |
| 3 | RST | Reset (active low) |
| 4 | WP | Write Protect (bridge to GND for EEPROM write) |
| 5 | GND | Ground |
| 6 | VCC | 3.3V (from board) |

The I2C bus is directly accessible on this header. You can solder a second header or use dupont jumper wires to tap SDA, SCL, and GND for the FT232H.

---

## 4. ADAU1701 I2C Details

### 4.1 I2C Address

| Format | Value | Notes |
|--------|-------|-------|
| 8-bit (write) | 0x68 | As stated in datasheet |
| 8-bit (read) | 0x69 | Write address + 1 |
| 7-bit | **0x34** | What Python/Linux I2C tools use |

The ADAU1701 datasheet uses 8-bit addressing (0x68/0x69). Python's `pyftdi` and Linux `i2c-tools` use 7-bit addressing (0x34). The address pins (ADDR0, ADDR1) on the ADAU1701 can change this, but the Wondom APM2 leaves them at the default.

**In selfboot mode**, the I2C address is fixed at 0x68 (write) / 0x69 (read) regardless of ADDR pin settings. The ADDR pins are repurposed in selfboot mode.

### 4.2 Memory Map

| Region | Address Range | Size | Access |
|--------|--------------|------|--------|
| Parameter RAM | 0x0000 -- 0x03FF | 1024 words (4 bytes each) | Read/Write |
| Program RAM | 0x0400 -- 0x07FF | 1024 words (5 bytes each) | Read/Write |
| Control Registers | 0x0800 -- 0x0827 | 40 registers | Read/Write |
| Safeload Data 0-4 | 0x0810 -- 0x0814 | 5 registers (5 bytes each) | Write |
| Safeload Addr 0-4 | 0x0815 -- 0x0819 | 5 registers (2 bytes each) | Write |

### 4.3 I2C Write Format

```
[START] [0x68] [ACK] [SubAddr_MSB] [ACK] [SubAddr_LSB] [ACK] [Data0] [ACK] ... [DataN] [ACK] [STOP]
```

- Subaddress: 16-bit, big-endian (MSB first)
- Data: variable length, auto-increments after each word
- Parameter RAM words: 4 bytes each (28-bit value, MSB-aligned)
- Program RAM words: 5 bytes each (40-bit instructions)

### 4.4 I2C Read Format

**Important ADAU1701 quirk:** The read operation requires a **repeated start** (no STOP between write and read phases). Some I2C libraries insert a STOP by default, which causes the read to fail.

```
[START] [0x68] [ACK] [SubAddr_MSB] [ACK] [SubAddr_LSB] [ACK]
[REPEATED START] [0x69] [ACK] [Data0] [ACK] ... [DataN] [NACK] [STOP]
```

`pyftdi` handles repeated starts correctly with `i2c.read_from(addr, readcount)`.

### 4.5 Safeload Procedure (ADAU1701)

The ADAU1701 **does** have safeload, contrary to what some sources claim. The procedure:

1. Write target parameter address to Safeload Address Register (0x0815-0x0819)
2. Write 5-byte data word to corresponding Safeload Data Register (0x0810-0x0814)
3. Repeat for up to 5 parameters
4. Set the IST (Initiate SafeLoad Transfer) bit in the Core Register (0x081C)
   - Read current Core Register value
   - Set bit 5 (IST bit)
   - Write back

**Safeload data format:** 5 bytes per word (not 4). The first byte is 0x00 padding, followed by the 4-byte (28-bit) parameter value.

---

## 5. The Four Viable Options (Detailed)

### 5.1 Option 1: SigmaStudio COM Automation (RECOMMENDED FOR IMMEDIATE USE)

SigmaStudio exposes a COM/ActiveX automation server that Python can control via `win32com`. This is the **only zero-cost, zero-hardware option** and works with the existing USBi/ICP5.

**Architecture:**
```
Python (win32com) --> COM --> SigmaStudio --> USBi/ICP5 --> I2C --> ADAU1701
```

**Setup:**
```bash
pip install pywin32
```

**Python code:**
```python
import win32com.client

# Connect to running SigmaStudio
server = win32com.client.Dispatch("Analog.SigmaStudioServer.SigmaStudioServer")

# IC name must match the IC in your SigmaStudio project
IC_NAME = "IC 1"  # or whatever your ADAU1701 is named in the project

# Write a parameter (SigmaStudio handles fixed-point conversion)
server.PARAMETER_WRITE_FLOAT(IC_NAME, 0x0000, 1.0)

# Write raw register bytes
import array
data = array.array('B', [0x00, 0x80, 0x00, 0x00])
server.REGISTER_WRITE_ARRAY(IC_NAME, 0x0000, 4, data)

# Read a register
value = server.REGISTER_READ(IC_NAME, 0x0000, 4)

# Safeload write (SigmaStudio handles the full safeload sequence)
server.REGISTER_SAFELOAD_WRITE(IC_NAME, 0x0000, 4, 0x00800000)

# Safeload array write
data = array.array('B', [0x00, 0x80, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00])
server.REGISTER_SAFELOAD_ARRAY(IC_NAME, 0x0000, 20, data)
```

**Full method list (relevant subset):**

| Method | Signature | Purpose |
|--------|-----------|---------|
| `REGISTER_WRITE` | `(ICName, addr, numBytes, data)` | Write integer to register |
| `REGISTER_READ` | `(ICName, addr, numBytes)` -> int | Read register |
| `REGISTER_WRITE_ARRAY` | `(ICName, addr, numBytes, byteArray)` | Write byte array |
| `REGISTER_READ_ARRAY` | `(ICName, addr, numBytes)` -> bytes | Read byte array |
| `REGISTER_SAFELOAD_WRITE` | `(ICName, addr, numBytes, data)` | Safeload single value |
| `REGISTER_SAFELOAD_ARRAY` | `(ICName, addr, numBytes, byteArray)` | Safeload byte array |
| `PARAMETER_WRITE` | `(ICName, addr, intBits, fracBits, value)` | Write with format conversion |
| `PARAMETER_WRITE_FLOAT` | `(ICName, addr, value)` | Write float (auto-convert) |
| `PARAMETER_READ` | `(ICName, addr, intBits, fracBits)` -> float | Read with format conversion |
| `PARAMETER_READ_FLOAT` | `(ICName, addr)` -> float | Read float (auto-convert) |
| `COMPILE_PROJECT` | `()` | Compile current project |
| `DOWNLOAD` | `()` | Download compiled project to DSP |
| `EXPORT_SYSTEM_FILES` | `(path)` | Export .params, .hex, etc. |

**Advantages:**
- Zero additional hardware cost
- Uses the existing USBi/ICP5 connection
- SigmaStudio handles I2C protocol, safeload sequencing, fixed-point conversion
- `PARAMETER_WRITE_FLOAT` eliminates the need for manual 5.23 conversion
- Safeload is handled automatically
- Can also compile and download projects programmatically
- Works right now with hardware already connected

**Disadvantages:**
- SigmaStudio must be running on the same PC (GUI open)
- COM automation can be fragile (version sensitivity, registration issues)
- Cannot run headless -- needs SigmaStudio window
- Slower than direct I2C (COM overhead + SigmaStudio processing)
- SigmaStudio 4.7 may have quirks with Python 3 COM bindings

**Impact on existing code:** The `client_1701.py` TCP client would need a parallel COM client class. The interface (`read_register`, `write_register`, `write_biquad`, etc.) can be kept identical.

### 5.2 Option 2: FT232H Direct I2C (RECOMMENDED FOR STANDALONE USE)

Use an FTDI FT232H breakout board as a USB-to-I2C adapter. Python talks directly to the ADAU1701 over I2C -- no SigmaStudio needed at runtime.

**Architecture:**
```
Python (pyftdi) --> USB --> FT232H --> I2C --> ADAU1701
```

**Hardware needed:** Adafruit FT232H Breakout (~$15) or generic FT232H module (~$8)

**Setup:**
```bash
pip install pyftdi
```
Then use Zadig to install WinUSB driver for the FT232H (does not affect USBi).

**Python code:**
```python
from pyftdi.i2c import I2cController
import struct

ADAU1701_ADDR = 0x34  # 7-bit I2C address

class FT232HADAU1701:
    def __init__(self, url='ftdi://ftdi:232h/1'):
        self.ctrl = I2cController()
        self.ctrl.configure(url)
        self.port = self.ctrl.get_port(ADAU1701_ADDR)

    def write_register(self, address: int, data: bytes) -> None:
        """Write data to parameter/register at 16-bit address."""
        subaddr = struct.pack('>H', address)
        self.port.write(subaddr + data)

    def read_register(self, address: int, length: int) -> bytes:
        """Read from 16-bit address using repeated start."""
        subaddr = struct.pack('>H', address)
        return self.port.exchange(subaddr, length)

    def write_biquad(self, base_addr: int, band: int,
                     b0: int, b1: int, b2: int, neg_a1: int, neg_a2: int):
        """Write 5 biquad coefficients in 5.23 fixed-point."""
        addr = base_addr + band * 5
        data = struct.pack('>5i', b0, b1, b2, neg_a1, neg_a2)
        self.write_register(addr, data)

    def safeload_write(self, target_addrs: list[int], data_words: list[int]):
        """Perform safeload write of up to 5 parameters."""
        assert len(target_addrs) == len(data_words) <= 5

        for i, (addr, word) in enumerate(zip(target_addrs, data_words)):
            # Safeload address register (0x0815 + i): 2 bytes
            self.write_register(0x0815 + i, struct.pack('>H', addr))
            # Safeload data register (0x0810 + i): 5 bytes (1 pad + 4 data)
            self.write_register(0x0810 + i,
                                b'\x00' + struct.pack('>i', word))

        # Trigger: set IST bit (bit 5) in core register 0x081C
        core_reg = self.read_register(0x081C, 2)
        core_val = int.from_bytes(core_reg, 'big')
        core_val |= (1 << 5)  # Set IST bit
        self.write_register(0x081C, struct.pack('>H', core_val))
```

**Advantages:**
- SigmaStudio not required at runtime
- Direct, fast I2C communication
- Full control over all registers and memory
- `pyftdi` is well-maintained, pure Python, cross-platform
- The FT232H has its own USB VID/PID, so Zadig does not affect the USBi driver
- Can coexist with USBi (separate USB devices, but only one drives I2C at a time)

**Disadvantages:**
- Requires purchasing an FT232H breakout (~$15)
- Must handle I2C protocol details manually (subaddress format, safeload sequence)
- Must implement 5.23 fixed-point conversion yourself (already done in `coefficients.py`)
- Multi-master concern if USBi is also connected (see Section 3.5)
- Need to solder or use jumper wires for physical connection to APM2 header

### 5.3 Option 3: Wei1234c/SigmaDSP (USBi as I2C Adapter)

Use Wei1234c's Python package to turn the existing USBi/ICP5 into a general-purpose I2C adapter.

**Architecture:**
```
Python (Wei1234c/SigmaDSP) --> pyusb --> USBi --> I2C --> ADAU1701
```

**Repositories:**
- [Wei1234c/SigmaDSP](https://github.com/Wei1234c/SigmaDSP) -- high-level DSP control
- [Wei1234c/Bridges](https://github.com/Wei1234c/Bridges) -- USB-to-I2C abstraction
- [Wei1234c/TCPi](https://github.com/Wei1234c/TCPi) -- TCP/IP channel tools

**Setup:**
```bash
pip install pyusb
# Then use Zadig to switch USBi from CyUSB to libusb/WinUSB driver
```

**Key code from Bridges:**
```python
from bridges.ftdi.controllers.i2c import I2cController
I2C = I2cController().I2C
i2c = I2C(freq=400000)
```

Or with USBi directly:
```python
# Wei1234c's package handles USBi vendor commands internally
from sigma.sigma_dsp.adau.adau1701 import ADAU1701
dsp = ADAU1701(bus=i2c)
dsp.write_parameter(address, value)
```

**Advantages:**
- Uses existing USBi/ICP5 hardware -- no additional purchase
- High-level API (can read SigmaStudio project XML for parameter names)
- Cross-platform (same code on Windows/Linux/ESP32)
- Proven to work with ADAU1701/ADAU1401

**Disadvantages:**
- **Requires Zadig driver swap** -- once you switch the USBi driver to libusb, SigmaStudio can no longer see it. Must swap back to use SigmaStudio.
- USBi is known to hang on large transfers (>512K chunks)
- Wei1234c packages have multiple dependencies and are not as well-documented
- Less actively maintained
- "Not high speed, obvious latency" -- acknowledged by author

### 5.4 Option 4: Custom sigma_tcp Server on Windows

Build a Python-based sigma_tcp-compatible server that uses FT232H for I2C transport. Both SigmaStudio and Python clients connect to it on localhost:8086.

**Architecture:**
```
SigmaStudio (TCP client) --\
                            +--> sigma_tcp server (Python) --> FT232H --> I2C --> ADAU1701
Python client (TCP) -------/     (localhost:8086)
```

**This is the architecture shown in the ADAU1701_PC_Calibration_System.md Section 2.1.**

The TCPIP1701 protocol is simple enough to implement in Python. The 8-byte header format (already documented in `client_1701.py`):

| Offset | Size | Field |
|--------|------|-------|
| 0 | 1 | Command (0x0A=Read, 0x0B=Write) |
| 1-2 | 2 | Total length |
| 3 | 1 | Status |
| 4-5 | 2 | Data length |
| 6-7 | 2 | Address (16-bit) |
| 8+ | N | Payload |

**Server pseudocode:**
```python
import socket
import struct
from pyftdi.i2c import I2cController

ADAU1701_ADDR = 0x34
PORT = 8086

def handle_client(conn, dsp_port):
    while True:
        header = recv_exact(conn, 8)
        cmd = header[0]
        data_len = (header[4] << 8) | header[5]
        address = (header[6] << 8) | header[7]

        if cmd == 0x0B:  # Write
            payload = recv_exact(conn, data_len)
            subaddr = struct.pack('>H', address)
            dsp_port.write(subaddr + payload)

        elif cmd == 0x0A:  # Read
            subaddr = struct.pack('>H', address)
            result = dsp_port.exchange(subaddr, data_len)
            # Send response as 0x0B (write) with data
            resp_len = 8 + len(result)
            resp = bytes([0x0B,
                         (resp_len >> 8) & 0xFF, resp_len & 0xFF,
                         0x00,
                         (len(result) >> 8) & 0xFF, len(result) & 0xFF,
                         (address >> 8) & 0xFF, address & 0xFF])
            conn.sendall(resp + result)
```

**Advantages:**
- Both SigmaStudio and Python can share the same I2C bridge
- Compatible with the existing `client_1701.py` TCP client code
- SigmaStudio can do project downloads while Python does parameter writes
- Clean separation of concerns

**Disadvantages:**
- Most complex to implement and debug
- Requires FT232H (~$15)
- TCPIP1701 protocol has known quirks (UTF-8 encoding bug with values > 127)
- Single-threaded access to I2C means requests must be serialized
- Must handle connection management for multiple clients
- SigmaStudio's TCPIP1701 may behave differently than expected (known bugs reported)

---

## 6. Comparison Matrix

| Feature | COM Automation | FT232H Direct | Wei1234c/USBi | Custom sigma_tcp |
|---------|---------------|---------------|---------------|-----------------|
| **Hardware cost** | $0 | ~$15 | $0 | ~$15 |
| **Needs SigmaStudio running** | Yes | No | No | Optional |
| **Read registers** | Yes | Yes | Yes | Yes |
| **Write registers** | Yes | Yes | Yes | Yes |
| **Safeload** | Yes (handled by SS) | Yes (manual) | Unknown | Yes (manual) |
| **Fixed-point conversion** | Auto (PARAMETER_WRITE_FLOAT) | Manual | Partial | Manual |
| **Coexists with USBi** | Native | Yes (different USB) | No (driver swap) | Yes (different USB) |
| **Python dependencies** | pywin32 | pyftdi | pyusb + Wei1234c | pyftdi + custom |
| **Implementation effort** | Low | Low-Medium | Medium | High |
| **Headless operation** | No | Yes | Yes | Yes |
| **Compile & download projects** | Yes | No | No | Yes (via SS TCPIP) |
| **Latency** | Medium (~10ms) | Low (~1ms) | Medium | Medium |
| **Reliability** | High (official API) | High (proven lib) | Medium | Depends on impl |

---

## 7. Recommended Implementation Plan

### Phase 1: Immediate (COM Automation) -- $0, ~2 hours

1. Install `pywin32`: `pip install pywin32`
2. Create `tools/dsp/client_1701_com.py` alongside existing `client_1701.py`
3. Implement the same interface (`read_register`, `write_register`, `write_biquad`, `set_volume`, etc.)
4. Internal calls go through `win32com.client` to SigmaStudio
5. SigmaStudio handles all I2C details, safeload, format conversion
6. Test with SigmaStudio open and connected to APM2 via ICP5

**This gets us running today with zero additional hardware.**

### Phase 2: Standalone (FT232H) -- ~$15, ~4 hours

1. Order Adafruit FT232H breakout (or generic module)
2. Wire FT232H to APM2 I2C header (SDA, SCL, GND -- 3 wires)
3. Install Zadig driver for FT232H (does not affect USBi)
4. Create `tools/dsp/client_1701_i2c.py` with `pyftdi` backend
5. Implement safeload sequence manually
6. This version works without SigmaStudio running

### Phase 3: Optional (sigma_tcp Server) -- 0 cost, ~8 hours

If we want SigmaStudio to also use the FT232H (for real-time monitoring while Python does parameter writes):
1. Implement TCPIP1701 server in Python
2. FT232H backend for I2C
3. Both SigmaStudio and Python connect to localhost:8086
4. Serialize I2C access with a lock

### What NOT to Do

- Do not try to run the C `sigma_tcp` on Windows -- it is deeply Linux-specific
- Do not use Zadig to swap the USBi driver unless you are committed to not using SigmaStudio simultaneously
- Do not connect both FT232H and USBi to the I2C bus while both are actively communicating

---

## 8. ADAU1701 Safeload Reference (for FT232H Direct Path)

For the COM path, SigmaStudio handles safeload. For direct I2C, here is the complete procedure:

### 8.1 Register Addresses

| Register | Address | Width | Purpose |
|----------|---------|-------|---------|
| Safeload Data 0 | 0x0810 | 5 bytes | Data word 0 (1 pad + 4 data) |
| Safeload Data 1 | 0x0811 | 5 bytes | Data word 1 |
| Safeload Data 2 | 0x0812 | 5 bytes | Data word 2 |
| Safeload Data 3 | 0x0813 | 5 bytes | Data word 3 |
| Safeload Data 4 | 0x0814 | 5 bytes | Data word 4 |
| Safeload Addr 0 | 0x0815 | 2 bytes | Target param address 0 |
| Safeload Addr 1 | 0x0816 | 2 bytes | Target param address 1 |
| Safeload Addr 2 | 0x0817 | 2 bytes | Target param address 2 |
| Safeload Addr 3 | 0x0818 | 2 bytes | Target param address 3 |
| Safeload Addr 4 | 0x0819 | 2 bytes | Target param address 4 |
| Core Register | 0x081C | 2 bytes | IST bit = bit 5 (triggers safeload) |

### 8.2 Procedure

```python
def safeload_biquad(dsp, target_base_addr: int, coeffs: list[int]):
    """Safeload a complete biquad (5 coefficients) to ADAU1701.

    Args:
        dsp: I2C port object (pyftdi)
        target_base_addr: Parameter RAM address of first coefficient
        coeffs: [b0, b1, b2, neg_a1, neg_a2] in 5.23 fixed-point
    """
    import struct

    for i, coeff in enumerate(coeffs):
        # Write safeload address register
        dsp.write(struct.pack('>HH', 0x0815 + i, target_base_addr + i))

        # Write safeload data register (5 bytes: 0x00 pad + 4 data bytes)
        data = struct.pack('>H', 0x0810 + i) + b'\x00' + struct.pack('>i', coeff)
        dsp.write(data)

    # Trigger safeload: read core register, set IST bit, write back
    core_data = dsp.exchange(struct.pack('>H', 0x081C), 2)
    core_val = int.from_bytes(core_data, 'big')
    core_val |= (1 << 5)  # Set IST (bit 5)
    dsp.write(struct.pack('>HH', 0x081C, core_val))
```

### 8.3 Important Notes

- **ADAU1701 vs ADAU1452 safeload:** The ADAU1701 uses address `0x0810` for safeload data. The ADAU1452 uses `0x6000`. They are completely different.
- **ADAU1701 safeload data is 5 bytes** (padded to match the 28-bit word width with a leading 0x00 byte). The ADAU1452 safeload data is 4 bytes.
- **The IST bit auto-clears** after the safeload transfer completes. No need to clear it manually.
- **ADAU1701 safeload does NOT have the "target address minus 1" quirk** of the ADAU1452. Write the actual target address.

---

## 9. Correcting client_1701.py

The existing `tools/dsp/client_1701.py` was written under the assumption that SigmaStudio runs a TCP server on port 8086. **This assumption was incorrect** (SigmaStudio is a TCP client, not server). The file's docstring and code need updating:

**Current state:** The TCP client code is structurally correct for the TCPIP1701 protocol but has nowhere to connect to. It would work if we build the sigma_tcp server (Option 4) or find another TCPIP1701 server.

**Immediate fix:** Create a COM-based alternative (`client_1701_com.py`) that provides the same API but routes through SigmaStudio's COM server.

**Future:** If FT232H is purchased, create `client_1701_i2c.py` for direct I2C access.

All three clients should implement the same interface so the calibration pipeline (`runner.py`, `eq.py`) does not need to change.

---

## 10. Sources

1. [Wei1234c/SigmaDSP](https://github.com/Wei1234c/SigmaDSP) -- Python ADAU1701 control from PC/ESP32
2. [Wei1234c/TCPi](https://github.com/Wei1234c/TCPi) -- SigmaStudio TCP/IP channel tools
3. [Wei1234c/Bridges](https://github.com/Wei1234c/Bridges) -- USB-to-I2C abstraction (FT232H/USBi)
4. [blus-audio/sigmadsp](https://github.com/blus-audio/sigmadsp) -- Python DSP control (Linux/RPi only)
5. [analogdevicesinc/sigma-tcp](https://github.com/analogdevicesinc/sigma-tcp) -- Official reference (archived)
6. [aventuri/sigma_tcp](https://github.com/aventuri/sigma_tcp) -- Community fork for ADAU1452
7. [hasaranga/SigmaESP32](https://github.com/hasaranga/SigmaESP32) -- ESP32 TCPIP1701 server
8. [freeDSP/TUTORIAL-I2C](https://github.com/freeDSP/TUTORIAL-I2C) -- ADAU1701 register definitions
9. [freeDSP/freeUSBi](https://github.com/freeDSP/freeUSBi) -- Open-source USBi clone
10. [Analog Devices Wiki -- TCP/IP Channels](https://wiki.analog.com/resources/tools-software/sigmastudio/usingsigmastudio/tcpipchannels) -- Protocol specification
11. [Analog Devices Wiki -- SigmaStudioServer](https://wiki.analog.com/resources/tools-software/sigmastudio/usingsigmastudio/scripting/server) -- COM automation API
12. [Analog Devices -- ADAU1701 Datasheet](https://www.analog.com/media/en/technical-documentation/data-sheets/adau1701.pdf)
13. [Implementing Safeload Writes on the ADAU1701](https://ez.analog.com/dsp/sigmadsp/w/documents/5182/implementing-safeload-writes-on-the-adau1701)
14. [PyFTDI Documentation](https://eblot.github.io/pyftdi/api/i2c.html) -- FT232H I2C API
15. [DIYAudio -- Low cost USBi programmer](https://www.diyaudio.com/community/threads/low-cost-usbi-programmer-using-cypress-cy7c68013a-board.269111/) -- USBi VID/PID details
16. [DIYAudio -- Control SigmaDSP from PC](https://www.diyaudio.com/community/threads/control-sigmadsp-adau1701-adau1401-from-pc.384039/) -- Community discussion
17. [Wondom APM2 Datasheet (Sure Electronics)](https://store.sure-electronics.com/product/AA-AP23122)
18. [Adafruit FT232H with I2C](https://learn.adafruit.com/circuitpython-on-any-computer-with-ft232h/i2c) -- Windows setup guide
19. [TCPIP1701 Protocol Bug Report](https://ez.analog.com/dsp/sigmadsp/f/discussions/100080/bug-report-sigmastudio-dsp-readback-via-tcp-tcpip1701-not-working) -- Known protocol issues

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-04 | Initial research -- four viable paths identified and ranked |
