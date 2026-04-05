# ICEpower 700AS2 for Speaker Amplification — Alternative Option
## Research Assessment: Replace Buckeye NC252MP with ICEpower 700AS2

**Date:** February 20, 2025  
**Status:** RESEARCH — Not adopted. POR remains 2× Buckeye NC252MP.  
**Revisit:** Prior to build (2027) — reassess pricing, availability, and the announced ICEpower Conductor/ICC5 update to 700AS2.

---

## Summary

The ICEpower 700AS2 offers a compelling cost and power argument for replacing the Buckeye Hypex NC252MP as the main speaker amplifier platform. It would unify all amplification on the ICEpower AS-series family (shared with the 1200AS2 sub modules), save ~$1,025, and deliver significantly more power headroom.

However, **independent measurements and listening tests consistently show the 700AS2 is audibly inferior to Hypex nCore for full-range speaker duty.** The 700AS2 uses ICEpower's older pre-ICEedge topology (not the ICEedge used in the 1200AS2), and exhibits higher noise floor, non-flat frequency response, elevated low-level distortion, and greater phase shift — all of which affect dialog clarity, spatial precision, and ambient detail in a reference home theater.

**Recommendation:** Keep Buckeye NC252MP (Hypex nCore) as POR for speaker amplification. Each platform does what it does best — ICEedge (1200AS2) for bass power, nCore (NC252MP) for full-range transparency. Revisit if ICEpower's announced Conductor/ICC5 update to the 700AS2 closes the quality gap.

---

## POR Baseline: Buckeye NC252MP

| Parameter | Value |
|-----------|-------|
| Amplifier | 2× Buckeye Hypex NC252MP 8-channel |
| Technology | Hypex nCore |
| Cost | 2 × $1,475 = **$2,950** |
| Power @ 4Ω | 250W/ch |
| Power @ 6Ω (Titan-815LX) | ~200W/ch |
| Power @ 8Ω (Volt-10) | 150W/ch |
| Channels | 16 total (13 used + 3 spare) |
| Form factor | 2× professional rack-mount chassis |
| Inputs | XLR balanced |
| Outputs | Binding posts |
| 12V trigger | Yes |
| Validated | Dylan at Buckeye confirmed <15A combined @ 120V |

---

## Alternative: ICEpower 700AS2

### Module Specifications

| Parameter | Value | Source |
|-----------|-------|--------|
| Type | 2-channel stereo, integrated PSU | Datasheet v1.8 |
| Technology | Pre-ICEedge (older LLC topology) | Wyred4Sound, ICEpower |
| Power @ 4Ω (both driven, 230V) | ~400W/ch | Datasheet |
| Power @ 8Ω (both driven, 230V) | 335W/ch | Datasheet |
| Total system power (230V) | 1,100W | Datasheet |
| Dynamic range | 117 dB(A) | Datasheet |
| THD+N @ 1W/4Ω/1kHz | 0.005% | Datasheet |
| Output impedance | 6 mΩ | Datasheet |
| Damping factor @ 4Ω | ~667 | Datasheet |
| Efficiency @ 2×350W/8Ω | 86.5% | Datasheet |
| Minimum load | 2.7Ω | Datasheet |
| Mains | 100-240V universal, auto-sensing | Datasheet |
| Standby | 0.15W @ 230V | Datasheet |
| 12V trigger | Yes (built-in) | Datasheet |
| Signal sense | Yes (auto-on) | Datasheet |
| Aux outputs | ±15V/0.5A, 5.1V/1A | Datasheet |
| Hanger bus | 43V DC (for 300A1 expansion) | Datasheet |
| Connectors | JST (same family as 1200AS2) | Datasheet |
| Dimensions | 275 × 100 × 46 mm | Datasheet |
| Weight | 975g | Datasheet |
| Price | $299.98 (Parts Express #326-113) | PE Feb 2025 |
| Bulk price | $274.98 @ 4+ units | PE Feb 2025 |
| Cable set | Included (unlike 1200AS2) | PE listing |

### Proposed Configuration

7× ICEpower 700AS2 modules = 14 channels (13 used + 1 spare)

| Module | Assignment |
|--------|------------|
| #1 | L + C |
| #2 | R + SL |
| #3 | SR + SBL |
| #4 | SBR + Atmos FL |
| #5 | Atmos FR + Atmos FC |
| #6 | Atmos RL + Atmos RR |
| #7 | Atmos RC + spare |

**Cost:** 7 × $274.98 (bulk) = **$1,925**

---

## Comparison

### Cost & Power

| Factor | Buckeye NC252MP (POR) | ICEpower 700AS2 |
|--------|----------------------|-----------------|
| **Cost** | $2,950 | **$1,925** |
| **Savings** | — | **$1,025** |
| Power @ 8Ω (Volt-10) | 150W | **335W** |
| Power @ 6Ω (Titan-815LX) | ~200W | **~500W** |
| Atmos SPL vs THX Reference | -1 to 0 dB | **+3-5 dB** |
| Surround SPL vs THX Reference | 0 dB | **+3 dB** |

### Electrical

| Factor | Buckeye NC252MP | ICEpower 700AS2 |
|--------|----------------|-----------------|
| Physical units | 2 chassis | 7 modules |
| AC connections | 2 | 7 |
| Mains voltage | 120V only | Universal (120/240V) |
| Subpanel fit | 1× 15A/120V circuit | 1× 20A/240V circuit |
| Idle (all on, no signal) | ~110W est. | ~150-175W est. |
| Peak transient (all ch) | ~2,000W | ~2,500W |

### Platform Unification

| Factor | Buckeye (POR) | ICEpower 700AS2 |
|--------|--------------|-----------------|
| Sub amp platform | ICEpower 1200AS2 (different) | **Same AS-series family** |
| Connector type | XLR/binding (different from subs) | **JST (same as subs)** |
| 12V trigger interface | Different from subs | **Identical to subs** |
| Spare cross-compatibility | No (different platforms) | **1200AS2 can emergency-sub** |
| Supplier | Buckeye + Parts Express | **Parts Express only** |

### Audio Quality — THE CRITICAL DIFFERENTIATOR

| Factor | Buckeye NC252MP (nCore) | ICEpower 700AS2 |
|--------|------------------------|-----------------|
| Technology generation | Hypex nCore (current) | Pre-ICEedge (older) |
| Noise floor | Very low | **Higher** (Alpha Audio) |
| Frequency response | Flat | **Non-flat, filter influence** (Alpha Audio) |
| Low-level distortion | Very low | **Elevated** — microdetail affected (Alpha Audio) |
| Phase shift @ 20kHz | ~17° (NC400 ref.) | **~35°** (diyAudio) |
| Listening impression | Transparent, detailed | **"Intrusive and cluttered"** (Alpha Audio) |
| Vocal reproduction | Clean | **"Edge" on vocals** (Alpha Audio) |
| Piano/harmonics | Accurate | **"Virtually no harmonics"** (Alpha Audio) |
| Community consensus | Top-tier Class D | Good for subs, not as refined for full-range |

---

## Audio Quality Evidence

### Alpha Audio Triple Test (May 2023)

Alpha Audio conducted a direct comparison of the ICEpower 700AS2 against Hypex Nilai (nCore successor) and Purifi Eigentakt. Key findings for the 700AS2:

- **Noise floor:** Higher than both competitors
- **Frequency response:** Not flat — shows influence of output filter
- **Low-level distortion:** Notably higher — "where the microdetail gets lost"
- **Power supply:** Less clean than Hypex or Purifi — peaks from circuitry visible on spectrum analyzer
- **Channel separation:** Excellent (better than both competitors — one positive)
- **Listening panel:** Described as "more intrusive and cluttered" vs. competitors
- **Verdict:** "Don't expect Hypex or Purifi quality. The ICEpower does not offer that."

Source: alpha-audio.net — "Triple Test: Hypex Nilai, Purifi Eigentakt Eval1, ICEpower 700AS2"

### diyAudio / ASR Community

Multiple experienced builders report the 700AS2 is best suited for subwoofer duty rather than full-range speakers. One owner with both 700AS2 and NC502MP side-by-side stated they "wouldn't use the ICEpower for any more than sub duty" due to phase shift characteristics.

Broader community consensus places Hypex nCore and Purifi Eigentakt in a clearly higher tier than ICEpower for full-range amplification, while acknowledging ICEpower offers excellent value at its price point.

### Technology Generation Gap

The 700AS2 and 1200AS2 are **different technology generations:**

| | 700AS2 | 1200AS2 |
|--|--------|---------|
| Topology | Pre-ICEedge (older LLC) | **ICEedge** (newest) |
| Dynamic range | 117 dB(A) | **127 dB(A)** |
| Output noise (A-wtd) | Not specified | **30 µV** |
| THD+N @ 10W/4Ω | 0.005% @ 1W | **0.003%** @ 10W |
| Vmon/Imon | No | **Yes** |
| Phase shift @ 20kHz | ~35° | ~70° (higher, but different application) |

Wyred 4 Sound confirmed publicly: the 700AS2 is "not made with the new ICEedge topology" but is "the newest non-ICEedge circuit." The 1200AS2 selected for subwoofers is the superior module — but its audio quality advantages are irrelevant below 80Hz where room acoustics dominate.

### ICEpower Conductor/ICC5 Update (Announced March 2025)

ICEpower announced they will update the 700AS2 (among others) with their new **Conductor topology and ICC5 integrated gate driver chips.** Per audioXpress reporting, this is claimed to take "audio quality to the next level." However:

- No updated datasheet available yet
- No independent measurements or reviews
- No confirmed availability date
- Unknown if Parts Express will stock updated version
- Unknown pricing impact

**This is the key variable to reassess at build time.** If the updated 700AS2 closes the gap with nCore, the cost/power/unification advantages become very compelling.

---

## Why This Matters for a Reference Theater

In a system designed for THX Reference playback, the channels carrying full-range content (LCR, surrounds, Atmos) reproduce:

- **Dialog intelligibility:** Quiet scenes with whispered dialog — low-level distortion directly impacts clarity
- **Ambient spatial cues:** Room tone, reverb tails, atmospheric effects — requires low noise floor and accurate phase
- **Atmos object panning:** Overhead effects that move across the soundfield — phase coherence matters
- **Music scores:** Orchestral dynamics, piano, strings — exactly the content where Alpha Audio found the 700AS2 lacking
- **Surround envelopment:** The sense of "being there" — requires consistent tonal balance and low coloration

The $1,025 savings is meaningful, but in a $76,000 system targeting no-compromise reference performance, choosing the known-inferior amplifier for the channels that carry 100% of dialog and spatial information would be a false economy.

For subwoofer duty below 80Hz, none of these factors matter — the 1200AS2 is the right choice there.

---

## Electrical Integration (if adopted)

### Subpanel Allocation

All 7 modules on a single 20A/240V circuit:
- Peak all-channels: ~10.4A @ 240V — well within 20A
- Replaces breaker 7 (15A/120V) in current plan with one 20A/240V double-pole
- Unifies all amplification on 240V

### Estimated Mains Draw (per module)

| Condition | Output | Mains Draw | @ 240V |
|-----------|--------|-----------|--------|
| Standby | 0 | 0.15W | negligible |
| Idle (on, no signal) | 0 | ~20-25W | ~0.1A |
| Typical movie (30W avg/ch) | 60W | ~75W | 0.3A |
| Loud passage (150W/ch) | 300W | ~360W | 1.5A |
| Full rated (350W/ch @ 8Ω) | 700W | ~810W | 3.4A |

### All 7 Modules Combined

| Condition | Total Mains | @ 240V |
|-----------|------------|--------|
| Idle | ~150-175W | ~0.7A |
| Typical movie | ~525W | 2.2A |
| Loud peaks | ~2,500W | 10.4A |

---

## Decision Framework for Build Time (2027)

### Adopt 700AS2 if:

1. ICEpower Conductor/ICC5 update ships with measured performance competitive with nCore
2. Price advantage remains significant ($1,000+)
3. Platform unification value justified by build complexity reduction
4. Listening comparison (if possible) confirms acceptable quality for surround/Atmos duty

### Keep Buckeye NC252MP if:

1. 700AS2 update hasn't shipped or hasn't been independently measured
2. Audio quality gap persists in measurements/reviews
3. Buckeye pricing remains stable or decreases
4. Simplicity of 2 chassis vs 7 modules preferred for rack design

### Consider 1200AS2 for all channels if:

1. Price drops make 8× modules competitive (~$2,400-2,600 range)
2. ICEedge audio quality verified acceptable for full-range by independent reviewers
3. Would provide true single-platform unification across entire system
4. Note: current cost would be 8× $373 = $2,984 — essentially same as Buckeye with more complexity

---

## Budget Impact Summary

| Scenario | Speaker Amps | Sub Amps | Total Amps |
|----------|-------------|----------|------------|
| **POR: Buckeye** | **$2,950** | **$3,730** | **$6,680** |
| Alt: 7× 700AS2 | $1,925 | $3,730 | $5,655 |
| Alt: 8× 700AS2 (extra spare) | $2,200 | $3,730 | $5,930 |
| Alt: 8× 1200AS2 (ICEedge) | $2,984 | $3,730 | $6,714 |

---

## References

- ICEpower 700AS2 Datasheet v1.8 (2020-05-13)
- ICEpower 1200AS2 Datasheet v1.7 (2023-06-07)
- Alpha Audio: "Triple Test: Hypex Nilai, Purifi Eigentakt Eval1, ICEpower 700AS2" (May 2023)
- audioXpress: "ICEpower Updates Existing Amplifier Modules with New Technology" (March 2025)
- Audiophile Style: "A Class D Exploration and Comparative Review" (April 2019)
- diyAudio: Phase shift discussions, idle power consumption threads
- Parts Express pricing verified February 2025

---

*Document Version: 2.0*  
*Created: February 20, 2025*  
*Status: Research alternative — POR remains Buckeye NC252MP*  
*Next review: Pre-build (2027) — check Conductor/ICC5 update status*
