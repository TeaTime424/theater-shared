# miniDSP Flex HTx -- Spec Sheet

**Status:** RESEARCH -- Not adopted
**Date:** 2026-03-19

## Price

| Variant | USD |
|---------|-----|
| Flex HTx (full: eARC + balanced + unbalanced) | $949 |
| Flex HTx (TRS balanced I/O only, no eARC) | $570 |

Dirac Live license is an additional purchase.

## I/O Configuration

### Inputs (8-channel)
| Type | Channels | Connector |
|------|----------|-----------|
| Analog unbalanced | 8 | RCA |
| Analog balanced | 8 | 6.35mm TRS (1/4") |
| HDMI eARC/ARC | up to 8 (LPCM) | HDMI |
| USB Audio | up to 8 | USB-B |
| S/PDIF coaxial | 2 (stereo) | RCA |
| Toslink optical | 2 (stereo) | Toslink |

### Outputs (8-channel)
| Type | Channels | Connector |
|------|----------|-----------|
| Analog unbalanced | 8 | RCA |
| Analog balanced | 8 | 6.35mm TRS (1/4") |

**No XLR connectors** -- all balanced I/O is 1/4" TRS.

## Output Voltage

| Connection | Max Output |
|------------|-----------|
| Balanced (TRS) | 4 Vrms |
| Unbalanced (RCA) | 2 Vrms |

## Sample Rate

- Internal DSP processing: **48 kHz** (fixed)
- USB/HDMI input: accepts 44.1-96 kHz (resampled to 48k internally)
- S/PDIF/Toslink: accepts up to 216 kHz (resampled to 48k internally)
- Biquad coefficients must be designed for 48 kHz

## DSP Chip

- **Analog Devices ADSP-21489 SHARC** @ 400 MHz
- 32-bit floating-point
- USB audio processor: XMOS

## DAC / ADC

- ADC: AKM AK5578EN (8-channel)
- DAC: 4x ESS ES9017S (configured as stereo pairs)

## PEQ

| Location | Bands | Notes |
|----------|-------|-------|
| Output channels | 10 per channel | Always available |
| Input channels | 10 per channel | Added via firmware update (was not available at launch) |

### Filter Types
- Peak (parametric)
- High Shelf
- Low Shelf
- All-Pass
- Gain: +/- 16 dB in 0.1 dB steps

### Minimum Frequency
- **GUI mode:** ~20 Hz (standard Device Console slider range; not explicitly documented below 20 Hz)
- **Biquad/Advanced mode:** No frequency limit -- arbitrary biquad coefficients can target any frequency including sub-20 Hz. Coefficients must be designed at 48 kHz sample rate. Paste format: `b0, b1, b2, a1, a2`

## Crossover

- Butterworth: 6, 12, 18, 24, 30, 36, 42, 48 dB/oct
- Linkwitz-Riley: 12, 24, 48 dB/oct
- Bessel: 12 dB/oct

## Delay

- **Max per output channel: 30 ms** (~10.3 m / 33.8 ft)
- Significantly less than 2x4 HD (80 ms) -- potential limitation for distant sub arrays

## Bass Management

- Dedicated bass management page in Device Console
- Extracts LFE + low-frequency content from selected input channels
- Configurable high-pass and low-pass crossover filters
- Routes bass to one or multiple subwoofer outputs
- Matrix mixer downstream of bass management and Dirac Live
- Can be used as active crossover for DIY multi-way speakers

## Dirac Live

- **Dirac Live 3.x Full Range (20 Hz - 20 kHz)** -- optional paid upgrade
- 8-channel correction
- Applied post-bass-management in signal chain

## API / Automation

| Feature | Status |
|---------|--------|
| Official REST API | **None** |
| Official plugin API | **None** |
| minidsp-rs / ezBEQ | **Not compatible** -- different message format than older miniDSP devices |
| ezBEQ workaround | Possible via loading biquads into output PEQ slots manually |
| Community WebSocket shim | Exists -- exposes preset, source, master gain, mute, per-channel controls via HTTP/WebSocket. Intended for Home Assistant / Node-RED integration |
| XML preset import | Not documented |
| IR remote | Yes (included) |
| HDMI CEC | Yes |
| 12V trigger | Yes (3.5mm jack) |

**Key limitation:** No official API. The community WebSocket shim is the only programmatic control path.

## Audio Performance

| Metric | Balanced (TRS) | Unbalanced (RCA) |
|--------|----------------|-------------------|
| SNR | 120 dB(A) | 124 dB(A) |
| THD+N | -114 dB (0.0002%) | -117 dB (0.00014%) |
| Crosstalk | -130 dB | -120 dB |
| Freq response | 20 Hz - 20 kHz +/- 0.1 dB | same |

## Physical

- Dimensions: 41.5 x 429 x 236 mm (1.63 x 16.9 x 9.29")
- Full-width rack form factor (rack-mountable with optional adapters)
- Power: 12V / 1.6A external switching supply
- Consumption: 16.5W idle, 3.7W standby
- Presets: 4 stored on device

## Real-World User Experience (AVS Forum / Reviews)

### Positives
- Clean signal path, very low noise floor -- measured SNR exceeds spec
- Bass integration with Dirac noticeably tightens bottom octaves
- 8x8 balanced I/O in this price range is unique
- Works well for multi-sub arrays (up to 8 subs with independent PEQ/delay/gain)
- Biquad import from REW works reliably for sub-20 Hz correction
- No signal flow quirks reported in recent firmware

### Negatives / Limitations
- **30 ms max delay** per output -- significantly less than 2x4 HD (80 ms). May be insufficient for large rooms with distant sub placement
- **48 kHz only** -- no 96 kHz processing option (other Flex models support 96k)
- **No official API** -- no minidsp-rs support, no ezBEQ automation without workarounds
- **Input PEQ was missing at launch** -- added later via firmware update; verify current firmware
- **No XLR** -- balanced is 1/4" TRS only, requires TRS-to-XLR adapters for pro gear
- GUI PEQ slider may not go below 20 Hz (must use biquad mode for sub-20 Hz filters)

### Comparison vs ADAU1452 (Current POR)
| Feature | Flex HTx | ADAU1452 (custom) |
|---------|----------|-------------------|
| Sample rate | 48 kHz | 48 kHz (configurable) |
| Floating point | Yes (32-bit) | No (8.24 fixed-point) |
| PEQ bands/ch | 10 | Unlimited (limited by program memory) |
| Sub-20 Hz filters | Via biquad import | Native |
| Balanced output | 4 Vrms TRS | Depends on output stage |
| API control | Community shim only | Full SigmaStudio COM |
| Dirac Live | Yes (paid) | No |
| Bass management | Built-in GUI | Must program manually |
| Price | $949 | ~$50 (board) + custom build |
| Effort | Plug and play | Significant DIY |

## Sources

- [miniDSP Flex HTx Product Page](https://www.minidsp.com/products/ht-series/flex-htx)
- [HomeTheaterHifi Review](https://hometheaterhifi.com/reviews/receiver-processor/processors/minidsp-flex-htx-digital-audio-processor-review/)
- [audioXpress Review](https://audioxpress.com/article/outboard-dsp-minidsp-flex-htx-audio-processor)
- [AVS Forum Discussion](https://www.avsforum.com/threads/minidsp-flex-htx-8x8-balanced-dsp.3287947/)
- [Audiophonics Specs](https://www.audiophonics.fr/en/dsp-av-processors/minidsp-flex-htx-p-18495.html)
- [miniDSP User Manual](https://docs.minidsp.com/product-manuals/flex-htx/index.html)
- [Community WebSocket Shim](https://www.minidsp.com/community/threads/flex-htx-websocket-telemetry-rest-control-shim-reference-implementation.24146/)
- [ASR Forum Thread](https://www.audiosciencereview.com/forum/index.php?threads/minidsp-flex-htx.49512/)
