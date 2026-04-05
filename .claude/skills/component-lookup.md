# Skill: Component Lookup

## Trigger
Activate this skill when the user asks about:
- Physical dimensions, sizes, or clearances of any theater component
- Speaker, driver, amplifier, or DSP specifications
- Component costs or pricing
- Impedance, sensitivity, power handling, or other electrical specs
- Compatibility or fitment questions (e.g., "will X fit in Y?")
- Wiring configurations or impedance calculations
- Component comparisons within the system

## Data Source
Load the component database from `research/component_database.json`. This file contains verified dimensions, specs, and costs for every major component in the system, sourced from the POR config files and design documents.

## How to Respond

1. **Read the database first.** Always load `research/component_database.json` before answering any spec question. Do not rely on memory or CLAUDE.md alone — the database has precise values from the actual config files.

2. **Cite exact values.** When reporting dimensions, always include units (inches, mm, lbs, watts, ohms). For dimensions available in multiple units, provide both.

3. **Flag known gotchas.** Each component has a `notes` array with critical warnings. Always surface relevant notes — especially:
   - Titan-815LX: 6 ohm nominal (not 8), ported (don't stuff), two-piece modular
   - Volt-10: Sensitivity is 95 dB (not the previously incorrect 98 dB)
   - UMII18-22: Only 2 ohm and 8 ohm practical; 4 ohm impossible with dual 2-ohm VCs
   - NX6000D: Real-world power is 40-50% below manufacturer ratings
   - DSP-408: HPF/LPF minimum is 20 Hz, not 10 Hz
   - miniDSP 2x4 HD: Inverted a1/a2 biquad signs vs standard convention

4. **Clearance and fitment calculations.** When asked about fitment:
   - Use the database dimensions, not approximations
   - Show the math explicitly
   - Account for panel thickness, baffle thickness, and mounting hardware
   - Reference the triangular corner column constraint: 170-inch screen needs 156.4 inches clear width

5. **Cost questions.** Report per-unit and system-total costs. Note that prices are as of March 2026 and may vary by the 2027 build date.

6. **Cross-reference POR documents.** If the database doesn't have a specific value, check the relevant POR config file:
   - `POR/titan_815lx/intermediates/config.py` — Titan-815LX detailed dimensions
   - `POR/volt10/intermediates/config.py` — Volt-10 detailed dimensions
   - `POR/umii18_22/intermediates/config.py` — UMII18-22 driver geometry
   - `POR/triangular_corner_sub/intermediates/config.py` — Corner column design
   - `POR/nearfield_front_18/intermediates/config.py` — Front nearfield cabinet
   - `POR/NearFieldv3/scripts/config.py` — V3 nearfield cabinet
   - `POR/11_Budget_Summary.md` — Full budget breakdown
   - `POR/06_Electronics_and_Control.md` — Electronics specs and signal flow

## Example Queries and Responses

**Q: "How wide is a Volt-10?"**
A: Read database, report: 14.0 inches wide x 14.0 inches tall. Standard depth 9.25 inches (surrounds), Atmos depth 7.0 inches (ceiling mount).

**Q: "What impedance should I wire the UMII18-22 at?"**
A: 8 ohm (series wiring of dual 2-ohm voice coils) is the POR configuration. Note: 4 ohm is impossible with the dual 2-ohm VC topology. Only 2 ohm and 8 ohm are practical.

**Q: "How much power does the NX6000D actually make?"**
A: Report both manufacturer and real-world figures. At 8 ohm (POR wiring): approximately 850W/ch real-world. At 4 ohm: 1,200-1,600W/ch real-world (manufacturer claims 3,000W). Include frequency derating for infrasonic use.
