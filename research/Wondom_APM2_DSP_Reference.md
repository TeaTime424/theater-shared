# Wondom APM2 DSP Development Kit Reference

**Purpose:** Learning SigmaStudio DSP programming for sub-20Hz filter design  
**Application:** Theater nearfield subwoofer Linkwitz Transform and bass shaker processing  
**Created:** January 2025

---

## Kit Components

| Component | Model | ASIN | Function |
|-----------|-------|------|----------|
| DSP Kernel Board | APM2 (AA-AP23122) | B07HHNQ74B | ADAU1701 DSP, 2-in/4-out |
| I/O Extension Board | APM3 (AA-AA11428) | B07HHNZ44R | RCA + 3.5mm jacks |
| Programmer | ICP5 (DB-DP11226) | B0CBP9YHYZ | SigmaStudio interface |

---

## Physical Stack (Top to Bottom)

```
┌─────────────────────┐
│        APM2         │  ← DSP board (black PCB)
│   (DSP Kernel)      │     6-pin cable connects here
├─────────────────────┤
│     Standoffs       │
├─────────────────────┤
│        APM3         │  ← I/O board  
│   (RCA/3.5mm)       │     Audio in/out here
├─────────────────────┤
│     Standoffs       │
├─────────────────────┤
│        ICP5         │  ← Programmer (blue PCB)
│    (Programmer)     │     USB to PC here
└─────────────────────┘
```

---

## Connections

| Cable | From | To |
|-------|------|-----|
| USB cable | PC | ICP5 USB port |
| USB-C cable | 5V power adapter | APM2 power jack |
| 6-pin ribbon cable | ICP5 | APM2 white connector |
| 10-pin ribbon cable | APM2 | APM3 (optional, for audio I/O) |

---

## ICP5 Switch Settings

| Switch | Position | Purpose |
|--------|----------|---------|
| SW4 | **IIC** | I2C protocol (not SPI) |
| SW | **PROGRAM** | Programming mode |

---

## APM2 Programming Header Pinout

The white connector on APM2 has exposed pins labeled:

```
┌───────┬───────┬───────┬───────┬───────┬───────┐
│ RESET │  +5V  │  GND  │  WP   │  SCL  │  SDA  │
└───────┴───────┴───────┴───────┴───────┴───────┘
```

**WP = Write Protect** - Must be grounded to write to EEPROM

---

## ⚠️ CRITICAL: EEPROM Write Protect Jumper

The APM2's EEPROM is **write-protected by default**. To write programs to EEPROM:

### You MUST bridge GND and WP pins during EEPROM write

**Method:** Use a small flathead screwdriver to touch both pins simultaneously

```
Pins (looking at exposed metal pins on connector):

RESET  +5V  GND  WP  SCL  SDA
             │    │
             └────┘
               ▲
        Touch both pins with
        screwdriver blade here
```

**Hold the screwdriver in place for the entire duration of the EEPROM write operation.**

---

## SigmaStudio Hardware Configuration

In the Hardware Configuration tab, add these blocks and connect them:

```
┌──────────┐
│   USBi   │
│          ├────────► ADAU1701 (IC 1)
│          │
│          ├────────► E2Prom (IC 2)
└──────────┘
```

1. Drag **USBi** from Communication Channels
2. Drag **ADAU1701** from ICs
3. Drag **E2Prom** from ICs
4. Connect USBi pin 1 → ADAU1701
5. Connect USBi pin 2 → E2Prom

---

## Programming Workflow

### Live Programming (temporary, lost on power cycle):

1. Verify all cables connected
2. APM2 powered via USB-C
3. Click **"Link Compile Download"**
4. Status bar shows **"Active: Compiled"**

### EEPROM Programming (permanent, survives power cycle):

1. Complete Live Programming first (status = "Active: Compiled")
2. **Bridge GND + WP pins with screwdriver**
3. Right-click **ADAU1701** → **"Write Latest Compilation to E2PROM"**
4. Select **I2C** protocol
5. Click **OK**
6. Click **"Start Download"**
7. **Hold screwdriver until progress bar completes 100%**
8. Release screwdriver

### Verify Self-Boot:

1. Unplug 6-pin cable from APM2
2. Unplug USB-C power from APM2
3. Wait 5 seconds
4. Plug USB-C power back in
5. Wait 5 seconds
6. Plug 6-pin cable back in
7. Click **"Link Compile Connect"** (NOT Download)
8. Status bar should show **"Active: Downloaded"** = Success

---

## Troubleshooting

| Problem | Cause | Solution |
|---------|-------|----------|
| EEPROM write hangs | WP not grounded | Bridge GND + WP with screwdriver |
| Link Compile Download fails | ICP5 switch wrong | Set SW4 to IIC, SW to PROGRAM |
| No communication | APM2 not powered | Connect USB-C 5V power to APM2 |
| Self-boot fails ("Ready" not "Active") | Write didn't complete | Redo EEPROM write, hold jumper until 100% |
| USB shows red in SigmaStudio | Driver issue | Reinstall SigmaStudio USB drivers |

---

## DSP Specifications (ADAU1701)

| Parameter | Value |
|-----------|-------|
| Inputs | 2 (stereo ADC) |
| Outputs | 4 (quad DAC) |
| Sample Rate | 48 kHz |
| Bit Depth | 28-bit / 56-bit processing |
| Program RAM | 1024 instructions |
| Parameter RAM | 1024 words |
| Dynamic Range | 98.5 dB |
| ADC THD | -83 dB |
| DAC THD | -90 dB |

---

## Key Limitations

| Limitation | Notes |
|------------|-------|
| Min filter frequency | DSP can go below 20Hz (unlike NX6000D DSP which is limited to 20Hz) |
| EEPROM size | ~8-9 kB max program size |
| Processing power | 1024 instructions per sample |

---

## Application to Theater Project

This DSP kit is for learning SigmaStudio concepts that apply to:

- **Nearfield subwoofers:** Linkwitz Transform to extend sealed box response below 20Hz
- **Bass shakers:** Bandpass filter (20-80Hz) with proper high-pass protection
- **Infrasonic HPF:** Protect drivers from subsonic content

Skills learned here transfer directly to larger DSPs (ADAU1452/1466) for the full theater build.

---

*Document created: January 2025*
*Last verified: January 2025*
