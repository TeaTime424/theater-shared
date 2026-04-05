# Seating &amp; Riser Platform
## Home Theater System - Rev 5.8

**Document Purpose:** Seating configuration, riser platform construction, and rear wall system.

**Last Updated:** December 2025 - Nearfield UMII18-22 integration, "Weapons-Grade Bass"

---

## Seating Configuration

### Row 1 (Front Row)
- **Position:** 13 feet from screen
- **Elevation:** Ground level (0 inches)
- **Seating:** 11-foot couch (freestanding)
- **Viewing angle:** Intentionally extreme (immersive experience)
- **Tactile bass:** 
  - Nearfield subwoofers behind couch (2× dual-UMII18 cabinets)
  - Aura Pro bass shakers (4× per couch, 2 per seat)

### Row 2 (Back Row)
- **Position:** 18 feet from screen
- **Elevation:** 24 inches (on riser platform)
- **Seating:** 11-foot couch (freestanding)
- **Viewing angle:** Standard reference viewing
- **Tactile bass:**
  - Nearfield subwoofers behind couch (2× dual-UMII18 cabinets)
  - Aura Pro bass shakers (4× per couch, 2 per seat)

---

## Tactile Bass Systems

### Nearfield Subwoofers (Primary Chest Impact)

| Parameter | Front Pair | Rear Pair |
|-----------|------------|-----------|
| Drivers | 4× UMII18-22 | 4× UMII18-22 |
| Enclosures | 2× dual-driver sealed | 2× dual-driver sealed |
| Location | Riser face (integrated) | Console table (furniture-grade) |
| Distance from listener | ~15" from chest | ~15" from chest |
| Amplification | 1× NX6000D stereo @ 8Ω | 1× NX6000D stereo @ 8Ω |
| SPL @ 15Hz @ 15" | ~120+ dB | ~120+ dB |
| Target frequency | 15-40 Hz | 15-40 Hz |

**Purpose:** Deliver extreme low-frequency chest pressure and physical impact that main subs cannot achieve at distance.

### Bass Shakers (Seat Vibration)

| Parameter | Value |
|-----------|-------|
| Model | Aura Pro AST-2B-4 |
| Quantity | 16 total (2 per seat × 8 seats) |
| Mounting | Bolted to couch frame |
| Amplification | 1× NX6000D bridged @ 4Ω |
| Target frequency | 30-80 Hz |
| Role | Direct seat vibration, punch, rumble |

**Purpose:** Add "you feel it in your bones" tactile vibration that nearfield subs cannot achieve (direct mechanical coupling).

### Combined Tactile Experience

| System | Frequency | Sensation |
|--------|-----------|-----------|
| Main subs (8×) | 20-80 Hz | Room pressurization, "wall of bass" |
| Nearfield subs (8×) | 15-40 Hz | Chest compression, "kicked in the chest" |
| Bass shakers (16×) | 30-80 Hz | Seat vibration, "bones rattling" |

All three systems run simultaneously for the full "weapons-grade" experience.

---

## Front Nearfield Integration (Row 1)

### Location: Built into Riser Face

The front nearfield subwoofers are integrated into the riser platform face, firing toward the front couch.

**Physical Arrangement:**
```
                    SCREEN
                      │
          ┌───────────┴───────────┐
          │                       │
          │     FRONT COUCH       │
          │     (Row 1)           │
          │                       │
          └───────────┬───────────┘
                      │ ~15"
    ┌─────────────────┴─────────────────┐
    │  [NF-L]    RISER FACE    [NF-R]   │ ← Nearfield subs built-in
    │                                    │
    │          RISER PLATFORM            │
    │                                    │
    │          REAR COUCH (Row 2)        │
    └────────────────────────────────────┘
```

**Construction:**
- Enclosures built into riser face structure
- Drivers fire forward toward row 1 couch backs
- Fabric grille to match riser aesthetics
- ~15" from listener chest level when seated

**Enclosure Specifications:**
| Parameter | Value |
|-----------|-------|
| Quantity | 2 enclosures (4 drivers total) |
| Configuration | Dual-UMII18 sealed per enclosure |
| Physical volume | **16 ft³ per enclosure** |
| Stuffing | Heavy polyfill (~16 lbs each) |
| Virtual volume | **~22 ft³ per enclosure** |
| External dimensions | ~46"W × 22"H × 34"D |
| Fc | ~30 Hz |
| Qtc | ~0.71 |
| Orientation | Forward-firing (toward row 1) |
| Finish | Fabric-wrapped to match riser |

**Why 16 cu ft + stuffing:**

The riser cavity is 8 feet deep — the enclosures only use 34" of that, leaving 62" for wiring and access. Heavy polyfill stuffing makes the box appear ~40% larger acoustically, dropping Fc from 39 Hz to 30 Hz and providing +5 dB headroom at 15 Hz vs the original 8 cu ft plan.

---

## Rear Nearfield Integration (Row 2)

### Location: Floor-Standing Console Tower

The rear nearfield subwoofers are housed in a floor-standing console that extends from floor to usable-surface height, taking advantage of the full 60" vertical space.

**Physical Arrangement:**
```
    ┌────────────────────────────────────┐
    │          RISER PLATFORM            │
    │                                    │
    │          REAR COUCH (Row 2)        │
    │                                    │
    └───────────────────┬────────────────┘
                        │ ~15"
    ┌───────────────────┴────────────────┐ ← 60" from floor (usable top)
    │                                    │
    │  [NF-L]  CONSOLE TOWER   [NF-R]    │ ← Drivers at chest height
    │                                    │
    │         (full height)              │
    │                                    │
    └────────────────────────────────────┘ ← Floor (0")
```

**Console Tower Design:**
| Parameter | Value |
|-----------|-------|
| External dimensions | 84"W × 24"D × **60"H** |
| Enclosures | 2× dual-UMII18 sealed (one per end) |
| Physical volume | **~25 ft³ per enclosure** |
| Stuffing | Heavy polyfill (~25 lbs each) |
| Virtual volume | **~34 ft³ per enclosure** |
| Fc | **~27 Hz** |
| Qtc | **~0.65** |
| Top surface | Usable (remotes, drinks, etc.) |
| Finish | Furniture-grade (match room décor) |
| Construction | MDF with veneer or paint |

**Why floor-standing (vs on-platform):**

Extending to the floor adds 24" of free height, increasing enclosure volume from ~14 cu ft to ~25 cu ft:

| Config | Physical Vol | Virtual Vol | Fc | 15 Hz Headroom |
|--------|--------------|-------------|-----|----------------|
| On platform (old) | 14 cu ft | ~19 cu ft | 31 Hz | +4 dB |
| **To floor (new)** | **25 cu ft** | **~34 cu ft** | **27 Hz** | **+7 dB** |

**Acoustic Considerations:**
- Drivers positioned at chest height (~42-48" from floor)
- Drivers fire forward toward row 2 couch backs
- Grille cloth on front face
- Internal bracing for cabinet rigidity
- ~15" from listener chest level when seated
- Console sits in front of riser edge (no deck cutouts needed)

---

### Riser Platform Specifications

**Dimensions:**
- Width: 16 feet (wall-to-wall)
- Depth: 8 feet
- Height: 24 inches from floor to deck surface
- Total area: 128 square feet

**Construction Method:** Sectional assembly (4 sections)
- Four 8' × 4' frame sections built separately
- Transported and assembled in room
- Connected with structural fasteners
- Continuous decking across entire platform

**Support Structure:**
- Method: Stud wall framing (most rigid)
- Bottom plate: 2×6 laid flat (1.5" height)
- Vertical studs: 2×6 cut to 14" tall, standing vertical
- Top plate: 2×6 laid flat (1.5" height)
- Subtotal frame height: 17" (1.5 + 14 + 1.5)

**Platform Frame:**
- Joists: 2×6 on edge, 16" on-center spacing
- Direction: Front-to-back (8-foot span)
- Joist height: 5.5" (brings platform to 22.5" from floor)
- Rim joists: 2×6 perimeter frame
- Blocking: Mid-span cross-bracing between joists

**Decking System (Constrained Layer Damping):**
- Bottom deck: 3/4" plywood (BC grade or better)
- Damping layer: Green Glue Noiseproofing Compound (~8 tubes)
- Top deck: 3/4" plywood (BC grade or better)
- Total deck height: 1.5" (brings total to 24")

**Riser Face Modification (Nearfield Integration):**
- Cut openings in riser face for 2× nearfield enclosures
- Each opening: ~26"W × 48"H
- Positions: Left and right thirds of riser face
- Structural header above each opening
- Nearfield enclosures slide into openings from rear

---

### Riser Construction with Nearfield Integration

**Modified Build Sequence:**

1. **Build frame sections** (workshop) — leave riser face open where nearfields go
2. **Build nearfield enclosures** (workshop) — sized to fit riser face openings
3. **Transport all to room**
4. **Assemble riser frame**
5. **Install nearfield enclosures** into riser face openings
6. **Complete riser face** around enclosures
7. **Install joists and decking**
8. **Install fabric grilles** over nearfield drivers
9. **Wire nearfields** to NX6000D #3

---

### Rear Corner Subwoofer Integration (Platform-Penetrating Design)

The rear triangular corner subwoofers penetrate through the platform, with full-height 96" columns identical in volume to front corners. The platform acts as the acoustic boundary for corner loading.

**Key Insight:** The platform surface acts as an acoustic boundary at 20 Hz (solid, massive, reflective). By positioning drivers near the platform level, we achieve corner loading at the platform boundary rather than the floor.

#### Column Configuration (Per Rear Corner)

**Bottom Cabinet (0-48" from floor):**
- **One driver at TOP of cabinet** (~27" AFF, 3" above platform)
- Volume below platform contributes to enclosure
- Platform penetrates at 24"
- Weight: ~180 lbs

**Top Cabinet (48-96" from floor):**
- **One driver at BOTTOM of cabinet** (~51" AFF, 3" above joint)
- Remaining volume above driver
- Weight: ~130 lbs

```
SIDE VIEW — REAR CORNER (PLATFORM-PENETRATING):

                    ┌─────┐ ← 96" (ceiling)
                    │▒▒▒▒▒│
                    │▒▒▒▒▒│  TOP CABINET
                    │▒▒▒▒▒│  (driver at BOTTOM)
                    │▒┌─┐▒│
                    │▒│•│▒│ ← Upper driver ~51" AFF
                    │▒└─┘▒│
    ════════════════╠═════╣════ ← 48" (sealed joint)
                    │▒┌─┐▒│
                    │▒│•│▒│ ← Lower driver ~27" AFF (3" above platform!)
                    │▒└─┘▒│  BOTTOM CABINET
    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╬═════╬▓▓▓▓ ← 24" PLATFORM (corner loading boundary!)
                    │▒▒▒▒▒│  (driver at TOP)
                    │▒▒▒▒▒│  Volume below platform
                    │▒▒▒▒▒│  contributes to enclosure
    ════════════════╪═════╪════ ← Floor (0")
                    └─────┘
    
    ▒ = OC 703 + AT fabric facing
    ▓ = Platform structure
    • = Driver
```

#### Platform Penetration Details

**Cutout Requirements:**

| Parameter | Value |
|-----------|-------|
| Cabinet external footprint | ~26" × 26" (right triangle) |
| Clearance needed | 1" all sides |
| **Platform cutout size** | **~28" × 28" right triangle** |
| Cutout location | Rear corners of platform |

```
PLAN VIEW — PLATFORM WITH SUB PENETRATIONS:

    REAR WALL
    ══════════════════════════════════════════
    │                                          │
    │   ┌─────┐                      ┌─────┐   │
    │   │/////│ ← Triangular         │/////│   │
    │   │/RL//│    cutout in         │//RR/│   │
    │   │/////│    platform          │/////│   │
    │   └─────┘                      └─────┘   │
    │         ╔════════════════════════╗       │
    │         ║                        ║       │
    │         ║    SOLID PLATFORM     ║       │
    │         ║      (ROW 2)          ║       │
    │         ║                        ║       │
    │         ╚════════════════════════╝       │
    │                                          │
    ══════════════════════════════════════════
    
    ///// = Triangular cutout (~28" × 28")
    Platform is SOLID except for sub penetrations
```

#### Structural Requirements

For platform to act as acoustic boundary, it must be solid and massive:

| Component | Specification |
|-----------|---------------|
| Joists | 2×10 @ 16" OC minimum |
| Deck | 3/4" plywood (double layer at corners) |
| Corner blocking | Double joists around cutouts |
| Point load capacity | 400+ lbs per corner |
| Cutout edge trim | 2×4 frame around each cutout |

**Blocking Detail Around Cutout:**

```
FRAMING PLAN — CORNER CUTOUT:

    ════════════════════ ← Rear wall
    │    │    │    │
    │  ╔═╬════╬═╗  │
    │  ║ │    │ ║  │  ← Double header
    │  ║ │CUT │ ║  │
    │  ║ │OUT │ ║  │  ← 28"×28" triangular
    │  ║ │    │ ║  │
    │  ╚═╬════╬═╝  │
    │    │    │    │  ← Double blocking
    ────┴────┴────┴────
         ↑
    Joists @ 16" OC
```

#### Why Platform-Penetrating Works

| Factor | Explanation |
|--------|-------------|
| Platform as boundary | Solid 2×10 + 3/4" plywood is acoustically massive at 20 Hz |
| Corner loading | Quarter-space loading at platform/wall/wall intersection |
| Volume preserved | Full 96" column = 10.25 cu ft per driver (same as fronts) |
| Driver coupling | Lower driver 3" above platform = excellent boundary coupling |
| No performance loss | Fc, Qtc, output identical to front corners |

#### Comparison: Front vs Rear Corners

| Parameter | Front Corners | Rear Corners |
|-----------|---------------|---------------|
| Column height | 96" | 96" |
| Volume per driver | 10.25 cu ft | 10.25 cu ft |
| Corner boundary | Floor (0") | Platform (24") |
| Lower driver height | 11" above boundary | 3" above boundary |
| Upper driver height | 32" above boundary | 27" above boundary |
| Corner loading gain | +10-12 dB | +10-12 dB |
| Platform | Gap required | **Solid (penetration)** |

**Construction Notes:**
- Install bottom cabinet in corner before platform deck is installed
- Platform cutout allows cabinet to pass through
- Complete platform framing, then install top cabinet
- Seal joint with battle-ready dual seal (same as front corners)
- Apply OC 703 + AT fabric after both cabinets joined
- Run speaker cables through platform cavity to equipment rack

---

### Rear Wall System (Behind Row 2)

**Configuration:** Three-section modular system
- Center: Solid backrest wall (couch support)
- Left/Right: Removable AT fabric panels (equipment access)

**Note:** Console table with rear nearfields sits in front of rear wall, not integrated into it.

**Solid Backrest Wall (Center Section):**
- Width: 12 feet (11-foot couch + 6" margin each side)
- Height: 36 inches from riser surface (60 inches from floor)
- Depth: 3.5-5.5 inches (2×4 or 2×6 frame)
- Construction: Fabric-wrapped acoustic panel
- Purpose: Couch backrest + bass trap + safety barrier

**Removable AT Panels (Left/Right Sections):**
- Dimensions: 30" wide × 40" tall each
- Purpose: Access to equipment/wiring behind console table

---

### Couch Requirements

**Standard couches work fine.** No special preparation needed because:
- Nearfield subs are behind (not under) couches
- Bass shakers bolt to existing couch frame
- No Crowson transducers (no structural mods)

**Couch Selection Criteria:**
- Solid wood frame (for shaker mounting)
- 11-foot width (fits room proportions)
- Comfortable for 4-hour movie sessions
- Dark fabric (doesn't reflect screen light)

**Couch Isolation:**
- Sorbothane hemispheres under each foot
- Purpose: Decouple from floor/riser vibration
- Quantity: 6-8 pads per couch

---

**Document Version:** 3.1 (Weapons-Grade Bass + Triangular Columns)
**Created:** November 22, 2025
**Updated:** December 2025 — Rev 5.9 triangular corner column integration
