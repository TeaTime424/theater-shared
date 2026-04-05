# Technical Note: SpeakerPower Sub-Bass Power Delivery Advantage

**Date:** 2025-02-19  
**Context:** ICEpower 1200AS1 4-channel sub amp build evaluation  
**Status:** Reference note — not a deciding factor for current build, but important for future discussions

---

## The Problem: SMPS-Based Class D Amps Derate at Low Frequencies

All Class D amplifiers that use an integrated SMPS (switched-mode power supply) — including ICEpower 1200AS1, Behringer NX6000D, and most pro-audio Class D amps — share a fundamental limitation: **the SMPS cannot deliver full rated power at very low frequencies.**

This is not a Class D amplifier problem. It is a **power supply energy storage problem.**

### Why It Happens

The SMPS converts AC mains into a regulated DC bus (e.g., ±63V on the ICEpower). The Class D output stage switches from this DC bus. Between the SMPS output and the amp input sits a bank of DC bus capacitors — the energy reservoir.

- At **1kHz**, a half-cycle is 0.5ms. The amp draws current in one direction briefly, then reverses. The bus caps barely discharge between SMPS replenishment cycles. Full power is trivially available.
- At **20Hz**, a half-cycle is 25ms (50× longer). The amp sustains high current draw in one direction for 25ms. The bus caps drain significantly. The SMPS struggles to keep up at full rated power.
- At **5Hz**, a half-cycle is 100ms. The bus caps cannot maintain voltage under full load. The amp clips early. Power is substantially derated.

### ICEpower 1200AS1 Specific Numbers (from datasheet)

- **-3dB at 3Hz** at low power (10W) — the amp section itself is essentially flat to DC
- **-3dB at 20Hz** at full rated power (1200W/4Ω) — the SMPS is the bottleneck
- Full power burst at 120V is sustainable for only **15 seconds** (vs 90 sec at 230V)
- Continuous power without thermal shutdown (0.8 K/W heatsink, 25°C): **280W**

### Behringer NX6000D Comparison

The Behringer uses the same SMPS → DC bus → Class D architecture but derates more aggressively, with frequency-dependent power limiting kicking in around 40-50Hz. The ICEpower is meaningfully better (flat to 20Hz vs Behringer limiting above 40Hz), but both share the same fundamental physics.

---

## SpeakerPower's Solution: Direct Mains Operation

SpeakerPower (founded by Brian Oppegard, former Director of Engineering at QSC for 11 years) designed their amplifiers specifically for sustained high-power subwoofer duty by **eliminating the SMPS entirely.**

### Architecture

- **Conventional SMPS Class D:** Wall AC → SMPS → regulated DC bus (bottleneck) → Class D amp
- **SpeakerPower:** Wall AC → rectifier/filter → Class D amp (no intermediate conversion)

The Class D output stage switches from **rectified and filtered mains** directly. The energy source is the electrical grid itself — functionally unlimited at any frequency. At 5Hz, the amp draws sustained current from the wall for a full 100ms half-cycle with no DC bus capacitor bottleneck.

### Result

SpeakerPower specs their amps at **5Hz–500Hz ±1.5dB at full rated power.** This is not marketing — it is a direct consequence of the power supply architecture.

### Additional Design Features

- **Full bridge outputs** — eliminates bus pumping (current transfer between ±rails during low-frequency half-cycles). SpeakerPower explicitly markets "no current pumping" as a feature.
- **Built-in GFI** (ground fault interrupter) — necessary because without galvanic isolation, speaker outputs are referenced to mains. Safety-critical design element.

### Tradeoffs vs SMPS-Based Designs

| Feature | SMPS (ICEpower) | Direct Mains (SpeakerPower) |
|---|---|---|
| Full power at 5Hz | No (derated) | **Yes** |
| Galvanic isolation | Yes | No (GFI protected) |
| Universal voltage | Yes (100-240V auto) | Some models 120V-only |
| Compact/lightweight | Yes (1150g per module) | Heavier |
| PFC compliance | Built-in | N/A (direct mains) |
| DIY-friendly modules | Yes (available retail) | No (complete amps only) |

---

## Relevant SpeakerPower Products for This Project's Use Case

If 4-channel × 1200W/4Ω with true sub-bass power delivery were required:

- **SP4-4800-MCR** — 4 × 1200W/4Ω rack mount, $3,129, 100-240VAC, XLR inputs only, basic DSP (gain, balance, HPF). This is a multi-channel rack amp, NOT the HT-specific model.
- **SP2-4800-HT** — 2 × 2400W/4Ω rack mount, $3,329, per-channel subwoofer DSP (delay, LF adjust, crossover). Would need two units for 4 channels = $6,658.

---

## Bottom Line

The ICEpower 1200AS1 is flat to 20Hz at full power and is excellent for subwoofer duty in the vast majority of real-world content. The sub-20Hz derating only matters for sustained infrasonic content (rare in movies, present in some test signals and synthesized bass). SpeakerPower's direct-mains architecture is the only Class D approach that truly delivers full rated power at infrasonic frequencies, at roughly 2× the cost and zero DIY flexibility.

For future amplifier discussions: any time someone claims a Class D amp delivers "full power at all frequencies," ask whether it uses an SMPS or direct mains. If SMPS, check the datasheet for the full-power lower bandwidth spec — it will not be 5Hz.

---

## ⚠️ Reality Check: This Limitation Does Not Matter for This System

**Added:** February 2025 — Recurring grounding note

The SMPS low-frequency derating discussed above is academically interesting but **practically irrelevant** for this theater's bass architecture. This note exists to prevent spec-chasing from overriding system-level thinking.

### Why It Doesn't Matter

**1. Movie content doesn't go there with meaningful energy.**
The vast majority of theatrical LFE mixes are HPF'd at the dubbing stage. Sustained content below 15Hz is extremely rare, even in reference bass-heavy titles (War of the Worlds, Edge of Tomorrow, Tron Legacy). Sub-15Hz energy in movies is typically transient peaks, not sustained passages that would trigger SMPS derating.

**2. The three-layer bass system covers each other's weaknesses by design.**

| Layer | Target Band | Why Amp Derating Doesn't Matter |
|-------|-------------|--------------------------------|
| Far-field (8× UMII18-22, corners) | 20Hz+ room fill | NX6000D fully capable at 20Hz+. Corner loading adds +12-15dB free gain. |
| Near-field (8× UMII18-22, 15" from chest) | 15Hz chest impact | ~20dB proximity gain means actual amp power needed at 15Hz is a fraction of rated. Derating is swamped by headroom. |
| Tactile (16× Aura Pro, seat-mounted) | 20-80Hz punch/feel | Mechanical coupling bypasses air entirely. No relationship to amplifier frequency response. |

**3. The frequencies where SMPS derates hardest are where tactile takes over.**
Sub-15Hz "feel" is delivered through the shakers via direct mechanical coupling to the seat — not through air moved by speakers powered by amplifiers. The amplifier's ability to deliver full power at 5Hz is irrelevant when a different subsystem handles that band through a completely different physical mechanism.

### The Spec-Chasing Trap

It is easy to get drawn into comparing amplifier specs at frequencies that don't matter for the actual use case. The NX6000D was selected for **cost, platform uniformity, and adequate real-world performance** — not for infrasonic bragging rights. SpeakerPower's direct-mains architecture is a genuine engineering achievement, but solving a problem this system doesn't have at 2× the cost and zero DIY flexibility is not a good trade.

**If this topic comes up again in future discussions, reference this note.**
