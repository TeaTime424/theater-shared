# ADAU1452 + CS42448 Board Assessment — Research Notes

**Date:** 2026-03-14
**Board:** "ADAU1452 DSP CS42448 AD1938-CODEC 4 inputs and 8 outputs Decoding Board"
**Status:** Owned, not bench tested
**Source:** AliExpress/Amazon Chinese board

## Known Issues (from diyAudio thread: "low cost ADAU1452 China board", 28+ pages)

### Noise Floor
- Permanent noise on all boards when no input signal, described as "wind-like"
- At 192kHz sample rate: noise is very high
- At 48kHz sample rate: noise drops to ~-80dB (still marginal for hi-fi)
- Root cause: cheap opamps + ceramic capacitors on analog stages

### Opamp Problems
- Ships with OPA1612 (not rail-to-rail) — wrong choice for the supply voltage
- Fix: replace with OPA2340 (rail-to-rail, 5V compatible)
- After replacement: THD drops by "orders of magnitude"
- Some channels may still be problematic due to ceramic caps

### Capacitor Distortion
- Ceramic SMD caps on CS42448 input/output stages cause measurable distortion
- 3rd harmonic is high with original caps
- Fix: replace with film or MLCC C0G/NP0 types

### Analog Output Filter
- CS42448 board has passive analog output filter that degrades performance
- Recommendation: remove the filter entirely

### Output Signal Issues
- Multiple reports of no output despite input detection working
- AD1938 codec variant: DC offset on outputs (1.5VDC)
- ADAU1452+AD1938: missing low frequency range (response drops from 20kHz down)

### CS42448 ADC Limitation
- ADC struggles at 192kHz — recommend 48-96kHz operation
- DAC can handle 192kHz but no benefit if ADC can't keep up

### CS42448 Specs (datasheet)
- 108 dB SNR (on paper)
- 6 ADC + 8 DAC channels
- 24-bit resolution
- Actual performance on cheap boards: significantly below datasheet

## Comparison: ADAU1452 Board vs Wondom ADAU1701 (APM2)

| Attribute | ADAU1452+CS42448 Board | Wondom APM2 (ADAU1701) |
|-----------|----------------------|----------------------|
| DSP chip | ADAU1452 (80-bit ALU) | ADAU1701 (56-bit ALU) |
| Fixed-point | 8.24 | 5.23 |
| Instructions | 6,144 | 1,024 |
| I/O | 4 in / 8 out | 2 in / 4 out |
| Low-freq precision | Superior (80-bit) | Adequate for >10Hz filters |
| ADC/DAC | CS42448 (external codec) | Integrated (on-chip) |
| Board quality | Chinese clone, known issues | Wondom production board, proven |
| Community support | Extensive troubleshooting needed | Widely used in DIY audio |
| Analog output | Unbalanced only (needs buffer for balanced) | Unbalanced (APM3 extension available) |
| Price | ~$60 | ~$35-45 per unit |
| Programmer | USBi or ICP5 | ICP1 or ICP5 |
| SigmaStudio | Yes (same toolchain) | Yes (same toolchain) |
| Proven in project | No (not bench tested) | Yes (tools/dsp/ pipeline works) |

## Signal Chain Concern: Unbalanced to ICEpower 1200AS2

The 1200AS2 has balanced (differential) inputs. The CS42448 and ADAU1701 both output unbalanced.

Options:
1. **Direct unbalanced** — wire signal to hot, ground to cold. Works but loses ~6dB CMRR advantage. Susceptible to ground loops over long runs.
2. **DRV134/THAT1646 balanced drivers** — active balanced output. Adds $50-65 and a PCB per channel.
3. **Wondom ADAU1701 has same issue** — also unbalanced output. Same solutions apply.

## Multi-ADAU1701 Topology (Alternative)

For 4 sub outputs (2 corner pairs + 1 nearfield pair + 1 tactile pair):
- 2× Wondom APM2: each provides 2 in / 4 out
- Total: 4 in / 8 out (matches the ADAU1452 board)
- Each APM2 is ~$35-45. Total: $70-90 (vs $60 for ADAU1452 board)
- Each is independently proven with existing tools/dsp/ pipeline
- Each uses ADAU1701's integrated ADC/DAC (no external codec)
- 5.23 fixed-point is less precise for sub-20Hz, but adequate with careful coefficient design
- SigmaStudio can address both in one project

## Sources
- [diyAudio: low cost ADAU1452 China board (28+ pages)](https://www.diyaudio.com/community/threads/low-cost-adau1452-china-board.309680/)
- [EngineerZone: ADAU1452+CS42448 no output](https://ez.analog.com/dsp/sigmadsp/f/q-a/571081/adau1452-cs42448--no-output)
- [diyAudio: ADAU1452+AD1938 DSP crossover](https://www.diyaudio.com/community/threads/adau1452-ad1938-dsp-crossover.423506/)
- [diyAudio: ADAU1452+AD1938 weird SPL response](https://www.diyaudio.com/community/threads/adau1452-ad1938-weird-spl-response.434801/)
- [Wondom APM2 product page](https://store.sure-electronics.com/product/AA-AP23122)
- [ICEpower 1200AS2 datasheet](https://shop.icepoweraudio.com/wp-content/uploads/2023/02/ICEpower1200AS1-2-Datasheet_1_7.pdf)
