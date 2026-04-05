# Equipment Room Design Session - Save Point
**Date:** December 10, 2025

## Summary
Designing external equipment room adjacent to theater (front left corner) with separate access from hallway.

## Room Dimensions
- **Theater:** 16' W × 26' D × 10' H
- **Stage:** 30" deep × 30" high deck, full 16' width
- **Equipment Room:** 4' W × 6' D (24 sq ft)

## Equipment Room Location
- Front left corner of theater
- Shares wall with theater left wall AND front wall
- Cable penetration through shared wall directly into stage/false wall area

## Door Configuration (STILL REFINING)
- **Door A (Theater):** User wants this on the shared wall between equipment room and theater
- **Door B (Equipment Room):** Opens outward into hallway from bottom of equipment room

User's latest annotation shows both doors accessed from same hallway corner, but the exact swing direction and position of Door A still needs adjustment. The theater door should open INTO the theater from the shared wall.

## Equipment
- 2× 42U racks (84U total capacity)
- 22U equipment needed
- Racks positioned at front of equipment room (near cable penetration)

## Cable Runs (from equipment room)
| Destination | Distance |
|-------------|----------|
| Left Titan | ~4' |
| Center Titan | ~8' |
| Right Titan | ~14' |
| Left Sub | ~6' |
| Right Sub | ~16' |

## Key Files
- `/home/claude/equip_room_design_v5.py` - Latest iteration (needs door adjustment)
- Output: `/mnt/user-data/outputs/equip_room_plan.png`

## What Needs to Be Fixed
Door A position/swing - user marked up the diagram but current rendering doesn't match their intent. Need to clarify:
1. Exact position of Door A on the shared wall
2. Which direction Door A swings (into theater? into equipment room?)
3. Alignment relationship between Door A and Door B

## Context from User Markups
User has provided several annotated screenshots showing:
1. Equipment room at front left corner ✓
2. Door B at bottom of equipment room, opening into hallway ✓
3. Door A appears to be on the RIGHT side of equipment room (shared wall with theater), positioned near the bottom corner, swinging INTO the theater

The hallway wraps around the bottom-left corner, providing access to both doors.

## Stage Configuration (for reference)
- 11' LCR span (132")
- 3× Titan-815LX speakers (22"W × 48"H × 20"D)
- 33" gaps between speakers
- Sub pockets: 51" each side (L and R)
- Center section: 90" with rack bays below deck

## Next Steps
1. Get clarification on exact Door A position and swing direction
2. Update diagram to match user's intent
3. Generate section view showing vertical relationships
4. Create cable schedule with final distances
