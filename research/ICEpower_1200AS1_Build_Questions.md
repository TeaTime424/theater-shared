# ICEpower 1200AS1 Build — Open Questions

**Date:** February 2025
**Status:** Planning phase — unanswered questions for follow-up
**Context:** Evaluating ICEpower 1200AS1 modules as potential replacement for NX6000D platform across sub/nearfield amplification. Tactile system (Aura Pro shakers) likely stays NX6000D.

---

## Current System: NX6000D Allocation (Baseline)

| Subsystem | NX6000D Units | Channels | Load | Drivers |
|-----------|--------------|----------|------|---------|
| Main subs (corners) | 2 | 4 | 8Ω (2 drivers series) | 8× UMII18-22 |
| Front nearfield | 2 | 4 | 8Ω | 4× UMII18-22 |
| Rear nearfield | 2 | 4 | 8Ω | 4× UMII18-22 |
| Tactile shakers | 1 | bridged | 4Ω | 16× Aura Pro |
| Spares | 2 | — | — | — |
| **Total** | **9 units** | **~13 ch** | | **16 drivers + 16 shakers** |

**NX6000D total cost (current plan):** 9 × $519 = $4,671 + $240 Noctua fans + trigger mod parts/time

---

## ICEpower Replacement Scope

### What Gets Replaced?
- [ ] Main subs: 4 channels → 4× ICEpower 1200AS1
- [ ] Front nearfield: 4 channels → 4× ICEpower 1200AS1
- [ ] Rear nearfield: 4 channels → 4× ICEpower 1200AS1
- [ ] **Tactile: KEEP on NX6000D** — low-fidelity application, bridged mode needed, ICEpower overkill

**Total ICEpower modules needed:** 12 (if replacing all sub/nearfield channels)
**Remaining NX6000D:** 1 (tactile) + 1 spare = 2

---

## Unanswered Questions

### 1. IMPEDANCE MATCH
- ICEpower 1200AS1 rated for **1200W @ 4Ω, 600W @ 8Ω**
- Current drivers wired to **8Ω** (dual 2Ω coils in series = 4Ω per driver, two drivers in series = 8Ω for mains; single driver 4Ω for nearfield?)
- **Q: Confirm impedance per channel for each subsystem.** If nearfield is 4Ω per channel, ICEpower delivers full 1200W. If 8Ω, it's 600W — still massive headroom but different math.
- **Q: Is 600W @ 8Ω sufficient for every channel, or does the nearfield proximity gain analysis assume more power?**

### 2. PHYSICAL LAYOUT
- Module dimensions: 300mm × 100mm × 63mm (12" × 4" × 2.5")
- **Q: Can 4 modules fit in a 3U chassis with adequate thermal spacing?**
  - 4 × 100mm width = 400mm. Standard 19" rack usable width ~430mm. Tight but possible.
  - 63mm height in 3U (133mm internal) — leaves ~70mm for airflow above.
  - Need to confirm: do modules require side spacing or only top/bottom airflow?
- **Q: Would 2U × 2 modules be safer thermally?** More chassis, more rack space, but guaranteed airflow.
- **Q: Total rack space impact?** 
  - 3U×4ch option: 3 chassis × 3U = 9U for 12 channels
  - 2U×2ch option: 6 chassis × 2U = 12U for 12 channels
  - Current NX6000D: 9 units × 2U = 18U (but includes tactile + spares)

### 3. AC POWER & DISTRIBUTION
- Each 1200AS1 has its own integrated SMPS and IEC-compatible mains input
- **Q: What is the inrush current per module at startup?** Relevant for breaker sizing.
- **Q: Does the 12V trigger provide sequenced soft-start, or do all modules hit mains simultaneously?**
- **Q: Total continuous AC draw for 12 modules at realistic listening levels?** (Not full power — realistic music/movie average)
- **Q: Dedicated circuit(s) needed?** Current electrical plan assumed NX6000D draw — need to revalidate.
- Cross-ref: `electrical_load_analysis.md` in POR

### 4. SIGNAL INPUT & GAIN STRUCTURE
- ICEpower 1200AS1 input: **differential balanced** via unterminated wires
- **Q: What is the input sensitivity/gain?** Need to match MiniDSP output levels.
- **Q: Does it accept standard +4dBu balanced from MiniDSP Flex/DSP-408?**
- **Q: Any input buffer or just direct to amp stage?** Relevant for noise floor with long cable runs from rack.
- NX6000D had XLR input jacks built in — ICEpower needs panel-mount XLR wired to harness.

### 5. PROTECTION & LIMITING
- NX6000D has built-in DSP limiters protecting speakers from over-excursion
- ICEpower has over-current, short, and thermal protection — but no **speaker excursion limiting**
- **Q: Is the MiniDSP stack handling all limiter duties anyway?** If yes, NX6000D limiters were redundant.
- **Q: What happens when ICEpower hits protection — hard mute or graceful limiting?**
- Cross-ref: `UMII18-22_Excursion_Limits_Reference.md` for driver protection requirements

### 6. 12V TRIGGER DETAILS
- ICEpower has 12V trigger / signal sense built in
- **Q: Confirm trigger behavior — does 12V on the control pin = amp on?**
- **Q: Can all modules share a single 12V trigger bus (daisy-chain)?**
- **Q: What is the standby power draw per module?** ErP compliant suggests <0.5W.
- **Q: Wake-on-signal-sense — is it reliable for always-ready theater use, or does it have false-trigger/delayed-wake issues?**
- This potentially eliminates the entire NX6000D trigger mod project (relay boards, distribution box, etc.)

### 7. COST COMPARISON (FULL SYSTEM)

**ICEpower approach (12ch sub/nearfield + 1 NX6000D tactile):**
| Item | Qty | Unit | Subtotal |
|------|-----|------|----------|
| ICEpower 1200AS1 | 12 | $300 | $3,600 |
| Harness sets (×12) | 12 | ~$21 | $252 |
| Chassis (3U×4ch) | 3 | ~$80 | $240 |
| Panel connectors, wiring, hardware | 3 | ~$100 | $300 |
| NX6000D (tactile + spare) | 2 | $519 | $1,038 |
| Noctua fans (tactile NX6000D only) | 2 | $30 | $60 |
| **ICEpower Total** | | | **~$5,490** |

**NX6000D approach (current plan — all Behringer):**
| Item | Qty | Unit | Subtotal |
|------|-----|------|----------|
| NX6000D | 9 | $519 | $4,671 |
| Noctua fans | 18 | ~$13 | $240 |
| 12V trigger mod (relay boards, distribution box, parts) | 1 | ~$150 | $150 |
| 12V trigger mod (design/build time) | — | — | ??? |
| **NX6000D Total** | | | **~$5,061 + time** |

**Delta: ~$430 more for ICEpower** — before accounting for:
- Eliminated trigger mod project (hours of design, build, test)
- Eliminated fan mod on 12 units (vs 2)
- No warranty theater (already void on modded Behringers)
- Module-level repair vs full-unit replacement
- Better low-frequency performance (flat to 20Hz vs NX6000D derating ~40Hz)
- Reduced rack space (9U vs 18U)

### 8. SPARE STRATEGY
- NX6000D plan: 2 full spare amps ($1,038)
- ICEpower plan: 1-2 spare modules ($300-600) + keep 1 spare NX6000D for tactile
- **Q: Is 1 spare module sufficient, or stock 2?**
- Module swap is faster than NX6000D swap (no recabling DSP/rack)

### 9. CHASSIS DESIGN
- This is a DIY build — no off-the-shelf ICEpower rack units exist at this power level
- **Q: Custom chassis or modify commercial 3U/2U enclosures?**
- **Q: CNC routed panels (Andy has CNC access) vs hand-fabricated?**
- **Q: Ventilation strategy — passive convection or low-speed fans for insurance?**
- **Q: Front panel design — LEDs for power/signal/clip per channel?**

### 10. TIMELINE & PHASING
- **Q: Build one 4-channel prototype chassis first, validate in test system?**
- **Q: Does this change the build sequence in `08_Construction_Timeline.md`?**
- **Q: Parts Express stock — are 12+ units available or will this require a bulk order?**

---

## Decision Framework

This is NOT a clear-cut "ICEpower wins" or "stay with Behringer" decision. The comparison is:

| Factor | NX6000D | ICEpower |
|--------|---------|----------|
| Per-channel cost | Lower | Slightly higher |
| Total system cost | ~$5,061 | ~$5,490 |
| 12V trigger | DIY mod (complex) | Built in |
| Cooling | Fan mod required | Passive (fanless) |
| Warranty | Void after fan mod | None (DIY build) |
| Rack space | 18U | 9U |
| Low-freq performance | Derates ~40Hz | Derates ~20Hz |
| Serviceability | Swap whole 2ch amp | Swap single module |
| Availability | Intermittent scarcity | Parts Express US stock |
| Build complexity | Plug and play + mods | Full chassis fabrication |
| Onboard DSP | Has it (bypassed anyway) | None (MiniDSP handles it) |
| Spares cost | $1,038 (2 full units) | $300-600 (1-2 modules) |

**The deciding factors are likely:**
1. Whether Andy wants to take on chassis fabrication (CNC panels, wiring, integration)
2. Whether the rack space savings matter for the equipment layout
3. Whether eliminating the trigger mod project is worth the cost delta
4. Availability of 12+ modules at time of purchase

---

## References

- `SpeakerPower_SMPS_vs_DirectMains_Architecture.md` — SMPS derating analysis + reality check
- `Subwoofer_Amplifier_Comparison.md` — Original NX6000D selection rationale
- `03_Subwoofer_System.md` — Driver specs, channel allocation
- `Tactile_Bass_Shaker_System.md` — Shaker system (stays NX6000D)
- `electrical_load_analysis.md` — AC power budget (needs update if ICEpower selected)
- `NX6000_12V_Trigger_Mod.md` — Trigger mod that ICEpower eliminates
