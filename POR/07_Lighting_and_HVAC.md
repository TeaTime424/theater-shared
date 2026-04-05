# Lighting & HVAC Systems
## Home Theater System - Rev 5.2 Extract

**Document Purpose:** Lighting philosophy and HVAC requirements.

**Source:** Extracted from Home_Theater_System_Complete_Design_Rev5_2.md

---

## Lighting System

### Philosophy: Zero Ambient Lighting

**Operational Mode:**
- Pitch black during movie playback
- Only screen illumination visible
- No sconces, rope lights, step lights, or ambient sources
- Maximizes contrast and immersion

**Rationale:**
- User has experience with zero-light theaters (current setup)
- Prioritizes image quality and immersion over convenience
- Dedicated reference theater (not multi-purpose space)

**Work Lights:**
- Full overhead lighting for setup, cleaning, maintenance
- Recessed can lights (multiple zones)
- Dimmable (0-100%)
- Warm color temperature (2700-3000K)
- Smart control: Single-button switching (Movie = all off, Work = all on)
- Avoid positioning directly over screen (prevents hot spots on AT fabric)

### Safety Considerations (Zero-Light Environment)

**Riser Edge Safety:**
- Back edge: Solid backrest wall (physical barrier)
- Left/Right edges: Riser extends to 1/2" from walls (no fall hazard)
- Front edge: Only exposed edge
 - Couch positioned 2-3 feet back from edge
 - Occupants learn room layout (muscle memory)

**Optional Safety Enhancements:**
- Glow-in-the-dark tape on front riser edge (photoluminescent, charges from work lights)
- Tactile floor transition (different carpet texture at riser approach)
- Phone flashlight with red filter app (preserves night vision if needed)

**Emergency Egress:**
- Exit signage: Code-minimum compliant (photoluminescent or low-power LED)
- Position where visible but doesn't affect viewing
- Check local building codes for requirements

**User Comfort:**
- Pre-movie bathroom protocol (everyone goes before starting)
- Pause for breaks (work lights on during intermission)
- Guests briefed on room layout before lights go out

---

## HVAC Requirements

### Thermal Load Summary

With the equipment cabinet thermally isolated (ducted intake/exhaust to adjacent spaces), the theater HVAC only handles three heat sources:

| Heat Source | Load | Notes |
|-------------|------|-------|
| ~~Equipment cabinet~~ | ~~2,700-4,100 BTU/hr~~ | **Isolated - not in theater load** |
| Occupants | 400 BTU/hr per person | 8 seats × 400 = 3,200 BTU/hr max |
| Projector | ~1,000-2,000 BTU/hr | Depends on model, lamp vs laser |
| Envelope (walls/ceiling) | 2,000-4,000 BTU/hr | Depends on insulation, adjacent temps |
| **Total theater load** | **~6,200-9,200 BTU/hr** | During normal viewing |

### Equipment Cabinet Thermal Isolation

The equipment cabinet is **thermally decoupled** from the theater via balanced active ventilation. Both intake and exhaust are ducted to spaces outside the theater, meaning:

- Equipment heat **never enters** the theater space
- No acoustic penetration from ventilation ducts
- Cabinet operates as an independent thermal zone

For equipment cabinet ventilation specifications, see [[06_Electronics_and_Control#Thermal Load (Equipment Cabinet)]].

**Equipment heat load (for reference - handled by cabinet ventilation, not theater HVAC):**

| Condition | Power Draw | Heat Output |
|-----------|------------|-------------|
| Typical movie | 800-1,200W | 2,700-4,100 BTU/hr |
| Heavy bass scene | 3,000W | 10,236 BTU/hr |
| Reference peak | 5,200W | 17,742 BTU/hr |

This heat is exhausted to adjacent space/attic, not the theater.

### Room HVAC Sizing

**Room dimensions:** 16' × 26' × 10' = 4,160 cu ft

**Total cooling load estimate (equipment heat isolated):**

| Component | BTU/hr | Notes |
|-----------|--------|-------|
| Envelope (walls, ceiling) | 2,000-4,000 | Depends on insulation, adjacent temps |
| ~~Equipment~~ | ~~3,500~~ | **Isolated via dedicated ventilation** |
| Occupants (8 max) | 3,200 | 400 BTU/hr per person |
| Projector | 1,500 | Ceiling-mounted, some heat rises to attic |
| Lighting (when on) | 500 | Work lights only, off during viewing |
| **Total peak** | **~7,000-9,200 BTU/hr** | |

**Recommended capacity:** 1 ton (12,000 BTU) dedicated system or zone
- Adequate for theater-only loads with equipment isolated
- Provides ~30% headroom for peak conditions
- Smaller system = quieter operation, lower cost
- If equipment isolation fails, 1 ton is undersized - consider 1.5 ton for redundancy

### Noise Considerations

| Source | Target | Notes |
|--------|--------|-------|
| Supply/return registers | NC-25 or below | Use low-velocity design |
| Equipment cabinet fans | <25 dB at MLP | Noctua fans on NX6000D amps |
| Mini-split (if used) | <30 dB | Select quiet model |
| Ducted system | NC-25 | Remote air handler preferred |

**Best practice:** Locate air handler outside theater (mechanical room, attic) with insulated supply/return ducts. Avoid wall-mounted mini-split heads in direct line of sight from seating.

---

**Document Version:** 1.1 (HVAC thermal analysis added)
**Created:** November 22, 2025
**Updated:** December 30, 2025 — Added equipment thermal load analysis and HVAC sizing