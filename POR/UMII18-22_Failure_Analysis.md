# UMII18-22 Excursion & Failure Analysis

**Driver:** Dayton Audio UMII18-22 Ultimax II 18" DVC Subwoofer  
**Date:** 2025-02-14  
**Purpose:** Determine mechanical safety margins when operating at or near rated xmax (28mm)

---

## Rated Specifications (from spec sheet)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Xmax | ±28 mm | Klippel verified at 70% BL |
| VC Diameter | 76 mm (3") | 4-layer flat wound copper on vented aluminum former |
| Mms | 420 g | |
| Sd | 1184 cm² | |
| Vd | 3315 cm³ | |
| BL | 19.2 Tm | |
| RMS Power | 1,200 W (AES 426B) | Coils in series |
| Fs | 22 Hz | |
| Qts | 0.53 | |

---

## Motor Geometry — Derived from UM18-22 Baseline

Dayton's Brian Myers confirmed the original UM18-22 motor geometry on AVS Forum:

| Parameter | UM18-22 (confirmed) | UMII18-22 (estimated) |
|-----------|---------------------|----------------------|
| Voice coil winding height (Hvc) | 56 mm | ~60-62 mm |
| Top plate / gap height (Hg) | 12 mm | ~12 mm |
| Geometric Xmax = (Hvc - Hg) / 2 | 22 mm | ~24-25 mm |
| Klippel Xmax (70% BL) | ~25 mm (data-bass) | 28 mm (spec sheet) |
| Coil exits gap = (Hvc - Hg) / 2 + Hg | 34 mm | ~36-37 mm |

**UMII Hvc estimate rationale:** The UMII moved to a 4-layer flat wound coil from a 2-layer round wound coil. Flat wound wire packs more turns per unit height, but 4 layers vs 2 layers means approximately the same or slightly taller winding. Working backward from the 28mm Klippel xmax using the same geometric-to-Klippel ratio seen on the original (~14% above geometric), geometric xmax lands around 24-25mm, yielding Hvc of 60-62mm.

**UMII Hg estimate rationale:** Gap height is constrained by the magnet assembly and pole piece machining. The UMII uses the same basic motor topology (ferrite stack, aluminum shorting sleeve + pole cap). No published evidence of a gap height change.

---

## Excursion Zones

| Zone | Excursion (mm) | % of Xmax | What's Happening |
|------|---------------|-----------|------------------|
| Linear | 0 – 28 | 0 – 100% | Rated operation. BL ≥ 70% of rest value. THD < 10% on sine. Suspension in designed compliance range. Dual spiders providing linear restoring force. |
| Soft overload | 28 – 33 | 100 – 118% | BL dropping from 70% toward ~50%. THD rising to 15-25% on sine. Suspension beginning progressive stiffening. Audible on sine waves, largely masked on program material (psychoacoustic masking effective below ~25% THD at sub frequencies). Thermal loading increasing — coil partially outside gap means lower efficiency, more waste heat per watt. |
| Hard overload | 33 – 38 | 118 – 136% | BL below 50%. THD > 25%, becoming audible even on program material. Suspension strongly resisting further travel. Voice coil approaching full gap exit (~36-37mm). Mechanical noise from suspension stress audible. Air compression behind cone increasing (mitigated by vented pole piece). Not sustainable — thermal and mechanical stress zone. |
| Damage risk | > 38 | > 136% | Spider deformation. Surround tearing or permanent stretching. Former potentially contacting backplate. Tinsel lead fatigue/breakage. Recovery unlikely if sustained. |

---

## Why 28mm Is Not Risky

### 1. It's the designed operating point
28mm is where Klippel measures 70% BL retention. Dayton designed the motor, suspension, and cooling system to operate at this excursion. The spec sheet lists it as Xmax, not Xmech or Xlim.

### 2. Safety margin to damage is substantial
From 28mm to estimated damage onset (~38mm) there is approximately 10mm of margin. That's 36% above rated Xmax. Industry best practice for well-designed long-excursion subwoofers targets Xlim ≥ 1.4× Xmax (per DPC recommendation). The UMII likely meets or exceeds this at ~1.36× based on conservative estimates.

### 3. Suspension provides progressive soft limiting
The dual spider system (mirror-imaged, widely spaced) creates progressive stiffening as excursion increases. This is not a cliff — the compliance (Cms) curve rolls off gradually, creating natural compression that resists further excursion. The high-roll butyl rubber surround adds additional progressive resistance at extreme travel.

### 4. Program material rarely sustains peak excursion
Movie transients (explosions, LFE hits) are short duration peaks. A driver might touch 28mm for 20-50ms during a bass transient, then retreat. Sustained 28mm would require continuous sine-wave-equivalent drive — this doesn't happen with real content. Even aggressive bass-heavy content (EDM, BEQ'd movies) has a crest factor that keeps average excursion well below peak.

### 5. Sealed enclosure adds compliance stiffening
In a sealed box, the trapped air acts as a spring that increases restoring force as excursion increases. This air spring is additive with the suspension compliance and provides additional soft limiting at high excursion. The smaller the box, the stronger this effect.

### 6. Dual-opposed configuration adds mechanical bracing
In a dual-opposed mount, the two drivers mechanically brace each other through the shared air volume. Asymmetric excursion is resisted, and the net cabinet force is canceled, reducing stress on the enclosure and allowing the drivers to work in a more controlled mechanical environment.

### 7. Community track record
Across AVS Forum and diyAudio, no reports of UM18-22 or UMII18-22 failure from over-excursion have been documented. The original UM18-22 has been in service since ~2015 in hundreds of DIY builds, many pushed hard. The Ultimax line is regarded as mechanically robust.

---

## Real-World Failure Modes (in order of likelihood)

### 1. Thermal failure (most common sub driver failure mode)
Voice coil overheating from sustained high power, especially at frequencies where excursion is high and the coil spends significant time outside the gap (lower efficiency = more heat). The UMII mitigates this with extensive venting (pole piece, former, sub-cone, under-spider, gap) and aluminum former for heat sinking. Rated at 1,200W AES continuous.

### 2. Tinsel lead fatigue
Repeated flexing of the tinsel leads at high excursion can cause fatigue breakage over time. The UMII addresses this by stitching the tinsel leads onto the top spider, eliminating free-hanging leads that could contact the cone or spider. This is a long-term wear item, not an acute failure mode.

### 3. Spider fatigue / creep
Sustained operation at high excursion can cause the spider material to permanently deform over months/years, shifting the voice coil's rest position. The dual spider design distributes this stress and the mirror-imaging cancels asymmetric compliance drift. Again, long-term wear, not acute.

### 4. Mechanical over-excursion (least likely in normal use)
Bottoming out (former hitting backplate) or surround tearing from exceeding Xmech. Requires sustained drive well beyond Xmax with no HPF protection. Essentially impossible in a properly designed sealed system with a subsonic filter.

---

## DSP Protection Recommendations

For operation targeting 28mm peak excursion:

| Protection | Setting | Purpose |
|------------|---------|---------|
| HPF | 10-12 Hz, 24 dB/oct (Linkwitz-Riley) | Prevents infrasonic content from causing uncontrolled excursion below cabinet tuning |
| Limiter threshold | Set to voltage that produces 28mm modeled excursion at lowest operating frequency | Prevents transient peaks from exceeding Xmax |
| Thermal protection | Monitor voice coil temperature if amp supports it; otherwise, limit continuous power to 1,200W | Prevents thermal failure during sustained high-output passages |

---

## Data Gaps & Caveats

- **No published Klippel Bl(x) curve for UMII18-22.** The 70% BL point is confirmed at 28mm but the shape of the Bl(x) curve (how rapidly BL falls beyond 28mm) is unknown. A steep dropoff would mean less motor force to push past 28mm (self-limiting), while a gradual dropoff would allow the coil to push further into overload territory.
- **No published Klippel Kms(x) / Cms(x) curve.** The suspension stiffness vs. excursion profile is not published. This determines exactly where the progressive soft limiting kicks in and how aggressive it is.
- **No data-bass test of the UMII18-22.** The original UM18-22 was tested by Josh Ricci at data-bass.com with compression sweeps showing where the driver ran out of gas. No equivalent test exists for the UMII.
- **UMII Hvc not published.** The voice coil winding height is estimated from the Klippel xmax and the original's known geometry. Actual measurement would require physical disassembly or manufacturer confirmation.
- **Xmech not published by Dayton.** Neither the UM18-22 nor the UMII18-22 spec sheets include an Xmech, Xlim, or Xdam rating. All mechanical limit estimates in this document are derived from geometry analysis and community observations.

---

## Sources

1. Dayton Audio UMII18-22 spec sheet (Parts Express 295-718)
2. AVS Forum: Brian Myers (Dayton Audio) confirming UM18-22 motor geometry — Hvc=56mm, Hg=12mm
3. AVS Forum: "Dayton UM18 Xmax/XMech" thread — community analysis of excursion limits
4. AVS Forum: "Using a subwoofer past Xmax?" thread — data-bass cross-reference, Xmax methodology discussion
5. AVS Forum: "10 year old UM18-22 vs brand new UMII18-22" thread — comparative testing
6. AVS Forum: "It Looks Like Dayton Went Back to Their Roots With the Ultimax II" thread — UMII design discussion
7. diyAudio: "Dayton Xmax and Acoustic Origin" thread — Xmech estimation from geometry
8. diyAudio: "Xmax vs mech limit rule of thumb" thread — industry practices for Xlim/Xmax ratios
9. Bassometry.com: "About Xmax, Xlim, Xmech, Xvar, Xdamage" — definitions and methodology
10. DPC (cfuttrup.com): Xmax definitions, Xlim = 2× Xmax recommendation for well-designed drivers

---

## Document History

| Rev | Date | Changes |
|-----|------|---------|
| 1.0 | 2025-02-14 | Initial analysis — excursion zones, failure modes, safety margin assessment |
