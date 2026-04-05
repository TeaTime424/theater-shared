---
name: obj-model-generation
description: "3D OBJ model generation with proper face winding, ring-based construction for circular geometry, material definitions, and unit scaling. Use when creating speaker cabinets, enclosures, or other 3D models with circular features like woofer cones, ports, or domes."
---

# OBJ 3D Model Generation

## Overview

Generate valid OBJ files with correct face orientation, materials, and proper unit handling. This skill covers lessons learned from building speaker cabinet models with complex circular geometry.

## Critical Rules

### Coordinate System Standard

**ALWAYS USE THIS CONVENTION** for cabinet/enclosure models:

| Axis | Direction | Description |
|------|-----------|-------------|
| **X** | Left → Right | Width |
| **Y** | Bottom → Top | Height |
| **Z** | Front → Back | Depth (0 at back, positive toward front) |

### Face Winding Order

**THE FUNDAMENTAL RULE**: Faces viewed from outside must have counter-clockwise (CCW) winding. The face normal (via right-hand rule) points outward.

**To flip winding**: `[a, b, c, d]` → `[a, d, c, b]`

**DEBUGGING**: If face appears as wireframe from front but solid from behind → winding is inverted.

## Circular Cutouts: The Proven Approach

### ✅ DO: Corner Fan Method (PROVEN WORKING)

This method was validated through extensive testing. It divides the baffle into rectangular regions, each containing one hole, then fans triangles from region corners to the outer ring.

**Key insight**: Split baffle at midpoints between holes. Each hole gets its own rectangular region with 4 corners that fan to the outer ring.

```python
#!/usr/bin/env python3
"""
Proven working template for baffle with circular cutouts.
Tested and validated - do not modify winding without testing.
"""
import math

SEG = 32  # Circle segments
R, T, L, B = 0, SEG//4, SEG//2, 3*SEG//4  # Cardinal indices: Right, Top, Left, Bottom

def ring(v_func, cx, cy, z, r):
    """Create ring of vertices. v_func should return 1-indexed vertex ID."""
    return [v_func(cx + r * math.cos(2 * math.pi * i / SEG),
                   cy + r * math.sin(2 * math.pi * i / SEG), z) for i in range(SEG)]

def build_baffle_with_two_holes(v, quad, tri, 
                                 bx1, by1, bx2, by2,  # Baffle bounds
                                 ZF, ZB,               # Front/back Z
                                 H1_X, H1_Y,           # Hole 1 center
                                 H2_X, H2_Y,           # Hole 2 center
                                 CUTOUT_R, OUTER_R):   # Inner/outer radii
    """
    Build baffle with two circular cutouts using proven corner-fan method.
    
    v(x,y,z) - vertex function returning 1-indexed ID
    quad(a,b,c,d) - quad face function
    tri(a,b,c) - triangle face function
    """
    mid_x = (H1_X + H2_X) / 2  # Split point between holes
    
    # Create rings for both holes
    h1_in_f = ring(v, H1_X, H1_Y, ZF, CUTOUT_R)
    h1_out_f = ring(v, H1_X, H1_Y, ZF, OUTER_R)
    h1_in_b = ring(v, H1_X, H1_Y, ZB, CUTOUT_R)
    h1_out_b = ring(v, H1_X, H1_Y, ZB, OUTER_R)
    
    h2_in_f = ring(v, H2_X, H2_Y, ZF, CUTOUT_R)
    h2_out_f = ring(v, H2_X, H2_Y, ZF, OUTER_R)
    h2_in_b = ring(v, H2_X, H2_Y, ZB, CUTOUT_R)
    h2_out_b = ring(v, H2_X, H2_Y, ZB, OUTER_R)
    
    # === CYLINDER WALLS (hole interior) ===
    for i in range(SEG):
        ni = (i + 1) % SEG
        quad(h1_in_f[i], h1_in_f[ni], h1_in_b[ni], h1_in_b[i])
        quad(h2_in_f[i], h2_in_f[ni], h2_in_b[ni], h2_in_b[i])
    
    # === DONUTS - FRONT FACE ===
    # CRITICAL WINDING: outer[i], outer[ni], inner[ni], inner[i]
    for i in range(SEG):
        ni = (i + 1) % SEG
        quad(h1_out_f[i], h1_out_f[ni], h1_in_f[ni], h1_in_f[i])
        quad(h2_out_f[i], h2_out_f[ni], h2_in_f[ni], h2_in_f[i])
    
    # === FRONT FACE OUTER REGION ===
    # Region corners (front)
    bl = v(bx1, by1, ZF)  # bottom-left
    tl = v(bx1, by2, ZF)  # top-left
    bm = v(mid_x, by1, ZF)  # bottom-middle (between holes)
    tm = v(mid_x, by2, ZF)  # top-middle
    br = v(bx2, by1, ZF)  # bottom-right
    tr = v(bx2, by2, ZF)  # top-right
    
    # H1 (left hole): fan from 4 corners to outer ring quadrants
    for i in range(L, B):           # BL corner → left-bottom quadrant
        tri(bl, h1_out_f[i+1], h1_out_f[i])
    for i in range(T, L):           # TL corner → top-left quadrant
        tri(tl, h1_out_f[i+1], h1_out_f[i])
    for i in range(B, SEG):         # BM corner → bottom-right quadrant (wrapping)
        ni = (i + 1) % SEG
        tri(bm, h1_out_f[ni], h1_out_f[i])
    for i in range(0, R):
        tri(bm, h1_out_f[i+1], h1_out_f[i])
    for i in range(R, T):           # TM corner → top-right quadrant
        tri(tm, h1_out_f[i+1], h1_out_f[i])
    
    # H1 edge triangles (connect corners to cardinal points)
    tri(bl, bm, h1_out_f[B])
    tri(tl, bl, h1_out_f[L])
    tri(tm, tl, h1_out_f[T])
    tri(bm, tm, h1_out_f[R])
    
    # H2 (right hole): fan from 4 corners to outer ring quadrants
    for i in range(L, B):           # BM corner → left-bottom quadrant
        tri(bm, h2_out_f[i+1], h2_out_f[i])
    for i in range(T, L):           # TM corner → top-left quadrant
        tri(tm, h2_out_f[i+1], h2_out_f[i])
    for i in range(B, SEG):         # BR corner → bottom-right quadrant (wrapping)
        ni = (i + 1) % SEG
        tri(br, h2_out_f[ni], h2_out_f[i])
    for i in range(0, R):
        tri(br, h2_out_f[i+1], h2_out_f[i])
    for i in range(R, T):           # TR corner → top-right quadrant
        tri(tr, h2_out_f[i+1], h2_out_f[i])
    
    # H2 edge triangles
    tri(bm, br, h2_out_f[B])
    tri(tm, bm, h2_out_f[L])
    tri(tr, tm, h2_out_f[T])
    tri(br, tr, h2_out_f[R])
    
    # === DONUTS - BACK FACE (reversed winding) ===
    for i in range(SEG):
        ni = (i + 1) % SEG
        quad(h1_out_b[i], h1_in_b[i], h1_in_b[ni], h1_out_b[ni])
        quad(h2_out_b[i], h2_in_b[i], h2_in_b[ni], h2_out_b[ni])
    
    # Region corners (back)
    bl_b = v(bx1, by1, ZB)
    tl_b = v(bx1, by2, ZB)
    bm_b = v(mid_x, by1, ZB)
    tm_b = v(mid_x, by2, ZB)
    br_b = v(bx2, by1, ZB)
    tr_b = v(bx2, by2, ZB)
    
    # H1 back (reversed winding - swap vertex order)
    for i in range(L, B):
        tri(bl_b, h1_out_b[i], h1_out_b[i+1])
    for i in range(T, L):
        tri(tl_b, h1_out_b[i], h1_out_b[i+1])
    for i in range(B, SEG):
        ni = (i + 1) % SEG
        tri(bm_b, h1_out_b[i], h1_out_b[ni])
    for i in range(0, R):
        tri(bm_b, h1_out_b[i], h1_out_b[i+1])
    for i in range(R, T):
        tri(tm_b, h1_out_b[i], h1_out_b[i+1])
    
    tri(bl_b, h1_out_b[B], bm_b)
    tri(tl_b, h1_out_b[L], bl_b)
    tri(tm_b, h1_out_b[T], tl_b)
    tri(bm_b, h1_out_b[R], tm_b)
    
    # H2 back
    for i in range(L, B):
        tri(bm_b, h2_out_b[i], h2_out_b[i+1])
    for i in range(T, L):
        tri(tm_b, h2_out_b[i], h2_out_b[i+1])
    for i in range(B, SEG):
        ni = (i + 1) % SEG
        tri(br_b, h2_out_b[i], h2_out_b[ni])
    for i in range(0, R):
        tri(br_b, h2_out_b[i], h2_out_b[i+1])
    for i in range(R, T):
        tri(tr_b, h2_out_b[i], h2_out_b[i+1])
    
    tri(bm_b, h2_out_b[B], br_b)
    tri(tm_b, h2_out_b[L], bm_b)
    tri(tr_b, h2_out_b[T], tm_b)
    tri(br_b, h2_out_b[R], tr_b)
```

### Critical Winding Rules (TESTED)

| Face | Winding Order | Notes |
|------|---------------|-------|
| **Front donut** | `outer[i], outer[ni], inner[ni], inner[i]` | Normal points +Z (toward viewer) |
| **Back donut** | `outer[i], inner[i], inner[ni], outer[ni]` | Normal points -Z (away from viewer) |
| **Front fan tri** | `corner, ring[i+1], ring[i]` | CCW from front |
| **Back fan tri** | `corner, ring[i], ring[i+1]` | CCW from back (reversed) |
| **Cylinder wall** | `front[i], front[ni], back[ni], back[i]` | Normal points into hole center |

### Cardinal Indices for SEG=32

| Index | Angle | Direction | Calculation |
|-------|-------|-----------|-------------|
| R = 0 | 0° | Right (+X) | 0 |
| T = 8 | 90° | Top (+Y) | SEG//4 |
| L = 16 | 180° | Left (-X) | SEG//2 |
| B = 24 | 270° | Bottom (-Y) | 3*SEG//4 |

### ❌ DON'T: These Approaches Failed

1. **Delaunay triangulation** - Creates spikes/starbursts across holes
2. **Fan from edge midpoints** - Overlapping triangles, gaps
3. **Grid stitching** - Complex, inconsistent winding
4. **Quad-strip to edges** - Index management nightmare

## Simple Box Construction

```python
def box(v, quad, x1, y1, z1, x2, y2, z2):
    """Create axis-aligned box with correct winding."""
    x1, x2 = min(x1, x2), max(x1, x2)
    y1, y2 = min(y1, y2), max(y1, y2)
    z1, z2 = min(z1, z2), max(z1, z2)
    vs = [v(x1,y1,z1), v(x2,y1,z1), v(x2,y2,z1), v(x1,y2,z1),  # back face
          v(x1,y1,z2), v(x2,y1,z2), v(x2,y2,z2), v(x1,y2,z2)]  # front face
    quad(vs[0], vs[3], vs[2], vs[1])  # back
    quad(vs[4], vs[5], vs[6], vs[7])  # front
    quad(vs[0], vs[4], vs[7], vs[3])  # left
    quad(vs[1], vs[2], vs[6], vs[5])  # right
    quad(vs[0], vs[1], vs[5], vs[4])  # bottom
    quad(vs[3], vs[7], vs[6], vs[2])  # top
```

## Vertex Caching

Avoid duplicate vertices at shared points:

```python
vcache = {}

def v(x, y, z):
    key = (round(x, 4), round(y, 4), round(z, 4))
    if key in vcache:
        return vcache[key]
    verts.append((x * 2.54, y * 2.54, z * 2.54))  # Scale for cm import
    idx = len(verts)
    vcache[key] = idx
    return idx
```

## Unit Scaling

OBJ files have no inherent units. For inch models viewed in cm:
```python
scale = 2.54
f.write(f"v {x*scale:.4f} {y*scale:.4f} {z*scale:.4f}\n")
```

## Materials (MTL File)

```
newmtl plywood
Kd 0.55 0.45 0.35

newmtl baffle
Kd 0.4 0.35 0.25

newmtl dark
Kd 0.1 0.1 0.1
```

### Transparency
```
newmtl grille
Kd 0.15 0.15 0.18
d 0.30      # 30% opaque
Tr 0.70     # 70% transparent (redundant but compatible)
```

## Complete Working Example

See `/home/claude/generate_cabinet_v11.py` for the tested, working implementation that produces correct OBJ output.

## Golden Rules Summary

1. **Split baffle at hole midpoints** - Each hole gets rectangular region
2. **Fan from 4 corners per hole** - Corner → outer ring quadrant
3. **Front donut**: `outer[i], outer[ni], inner[ni], inner[i]`
4. **Back donut**: Reverse the winding
5. **Front tris**: `corner, ring[i+1], ring[i]`
6. **Back tris**: `corner, ring[i], ring[i+1]`
7. **OUTER_R = CUTOUT_R + 2"** - Buffer between cutout and fan origin
8. **Test after EVERY change** - Don't batch changes

## Debugging Checklist

| Symptom | Cause | Fix |
|---------|-------|-----|
| Black circles (donut) | Wrong donut winding | Swap inner↔outer in quad |
| Black triangles in fan | Wrong tri winding | Swap ring[i]↔ring[i+1] |
| Gaps at edges | Missing edge triangles | Add tri(corner1, corner2, ring[cardinal]) |
| Overlapping faces | Duplicate fans | Check quadrant ranges don't overlap |
