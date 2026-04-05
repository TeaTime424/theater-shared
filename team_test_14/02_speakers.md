# Speaker System — All Channels

## Channel Inventory (13 Channels)

| Ch # | Label | Model | Sensitivity | Impedance | Amp | Power (W) | Distance (m) | SPL at MLP (dB) | Headroom vs 95 dB |
|------|-------|-------|-------------|-----------|-----|-----------|--------------|-----------------|-------------------|
| 1 | L | Titan-815LX | 99 dB | 6 Ω | ATI AT525NC | 250 | 3.0 | 112.2 | +17.2 |
| 2 | C | Titan-815LX | 99 dB | 6 Ω | ATI AT525NC | 250 | 3.0 | 112.2 | +17.2 |
| 3 | R | Titan-815LX | 99 dB | 6 Ω | ATI AT525NC | 250 | 3.0 | 112.2 | +17.2 |
| 4 | Ls | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 150 | 2.5 | 105.8 | +10.8 |
| 5 | Rs | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 150 | 2.5 | 105.8 | +10.8 |
| 6 | Lss | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 150 | 2.5 | 105.8 | +10.8 |
| 7 | Rss | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 150 | 2.5 | 105.8 | +10.8 |
| 8 | TFL | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 100 | 2.5 | 103.0 | +8.0 |
| 9 | TFR | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 100 | 2.5 | 103.0 | +8.0 |
| 10 | TML | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 100 | 2.5 | 103.0 | +8.0 |
| 11 | TMR | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 100 | 2.5 | 103.0 | +8.0 |
| 12 | TRL | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 100 | 2.5 | 103.0 | +8.0 |
| 13 | TRR | Volt-10 | 95 dB | 8 Ω | AVR-X6800H | 100 | 2.5 | 103.0 | +8.0 |

All channels clear the 95 dB target with at least +8 dB headroom.

---

## SPL Formula

```
SPL = sensitivity + 10*log10(power) - 20*log10(distance_m)
```

### LCR example (Titan-815LX, 250 W, 3 m):

```
SPL = 99 + 10*log10(250) - 20*log10(3.0)
    = 99 + 10*2.398 - 20*0.477
    = 99 + 23.98 - 9.54
    = 112.2 dB
```

### Surround example (Volt-10, 150 W, 2.5 m):

```
SPL = 95 + 10*log10(150) - 20*log10(2.5)
    = 95 + 10*2.176 - 20*0.398
    = 95 + 21.76 - 7.96
    = 108.8 dB
```

### Atmos example (Volt-10, 100 W, 2.5 m):

```
SPL = 95 + 10*log10(100) - 20*log10(2.5)
    = 95 + 10*2.0 - 20*0.398
    = 95 + 20.0 - 7.96
    = 107.0 dB
```

Note: AVR-X6800H internal amp channels vary by load. Figures above use representative per-channel power estimates. The -10 dB reference target (95 dB) is met with substantial margin on all channels before any Dirac gain allocation.

---

## Speaker Notes

### Titan-815LX (LCR)
- **Impedance:** 6 Ω nominal (NOT 8 Ω) — amp must be rated for 6 Ω loads. ATI AT525NC is.
- **Enclosure:** Ported — line panels are open baffles mounted in port area. **Do not stuff the ports.**
- **Why Titan for LCR:** 99 dB sensitivity is the key reason. The 170" acoustically transparent (AT) screen sits between the audience and the LCR speakers. AT screens impose 1-3 dB insertion loss depending on fabric and angle. Starting with a 99 dB driver gives 4 dB of margin over the 95 dB surround/Atmos drivers before any screen loss is applied. At the 95 dB reference target this headroom is critical — the center channel in particular carries dialogue and must hold level cleanly. The Titan's 99 dB sensitivity also means the ATI AT525NC can run at moderate power levels, reducing thermal stress and distortion.

### Volt-10 (Surrounds + Atmos, 10 channels)
- **Sensitivity:** 95 dB (NOT 98 dB — earlier docs were wrong, DIYSG spec is 95 dB)
- **Why all-Volt-10 for surrounds and Atmos:** Timbral matching. All 10 non-LCR channels use the identical driver/enclosure combination. Dolby Atmos object panning moves audio across surround and overhead channels continuously. If surround and Atmos channels use different drivers with different frequency responses, tonal character shifts as objects move — audible as "coloration" when sounds pan overhead. A single identical driver across all 10 channels eliminates this. The Volt-10 is a coaxial point source, which also maintains consistent off-axis response across all seating positions.
- **Impedance:** 8 Ω — clean match for the AVR-X6800H internal amplification on surround/Atmos channels.
