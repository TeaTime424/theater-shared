# SKILL: Subwoofer Construction Diagram Generation

## Overview

This skill covers generating technical construction diagrams for DIY subwoofer enclosures using Python and matplotlib. The diagrams are designed for clarity, printability, and contractor communication.

## Environment

- **Runtime:** Python 3 with matplotlib, numpy
- **Output:** PNG files at 150 DPI (print-quality)
- **Canvas:** White background, sized for the content (typically 14-20" wide figures)

## Color Palette

```python
# Standard colors for subwoofer diagrams
MDF_COLOR = '#D4A574'      # Light wood tone - box shell panels
BAFFLE_COLOR = '#A07050'   # Darker wood - baffle (distinguishes from shell)
BRACE_COLOR = '#8B6914'    # Golden brown - internal bracing
SEALED_COLOR = '#E8D8C8'   # Light tan - sealed volume cavity
INTERNAL_COLOR = '#F5E6D3' # Very light - general internal space
DIMENSION_COLOR = '#0066CC' # Blue - primary dimensions
SECONDARY_DIM = '#006600'   # Green - secondary dimensions
ACCENT_COLOR = '#CC0000'    # Red - critical callouts (baffle thickness, etc.)
```

## Common Diagram Types

### 1. Side Cross-Section

Shows depth breakdown: back panel → sealed volume → baffle → recess

```python
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import Rectangle

def create_side_crosssection(external_d, external_h, mdf_t, baffle_t, recess, sealed_depth):
    """
    Create side cross-section showing depth breakdown.
    
    Parameters:
    - external_d: Total external depth (e.g., 22")
    - external_h: Total external height (e.g., 48")
    - mdf_t: MDF thickness (typically 0.75")
    - baffle_t: Baffle thickness (e.g., 1.5" for double)
    - recess: Front recess depth (e.g., 3")
    - sealed_depth: Internal sealed depth (calculated)
    """
    fig, ax = plt.subplots(1, 1, figsize=(12, 10))
    ax.set_xlim(-4, external_d + 6)
    ax.set_ylim(-6, external_h + 6)
    ax.set_aspect('equal')
    
    # Back panel
    ax.add_patch(Rectangle((0, 0), mdf_t, external_h, 
                           facecolor='#D4A574', edgecolor='black', linewidth=2))
    
    # Top panel
    ax.add_patch(Rectangle((0, external_h - mdf_t), external_d, mdf_t,
                           facecolor='#D4A574', edgecolor='black', linewidth=2))
    
    # Bottom panel
    ax.add_patch(Rectangle((0, 0), external_d, mdf_t,
                           facecolor='#D4A574', edgecolor='black', linewidth=2))
    
    # Sealed volume (lighter fill)
    baffle_back_x = external_d - recess - baffle_t
    ax.add_patch(Rectangle((mdf_t, mdf_t), baffle_back_x - mdf_t, external_h - 2*mdf_t,
                           facecolor='#E8D8C8', edgecolor='none'))
    
    # Baffle (darker)
    ax.add_patch(Rectangle((baffle_back_x, mdf_t), baffle_t, external_h - 2*mdf_t,
                           facecolor='#A07050', edgecolor='black', linewidth=2))
    
    # Dimension: total depth
    ax.annotate('', xy=(0, -3), xytext=(external_d, -3),
                arrowprops=dict(arrowstyle='<->', color='#0066CC', lw=2))
    ax.text(external_d/2, -4.5, f'{external_d}" total depth', 
            ha='center', fontsize=12, color='#0066CC', fontweight='bold')
    
    # Dimension: sealed depth
    ax.annotate('', xy=(mdf_t, -1.5), xytext=(baffle_back_x, -1.5),
                arrowprops=dict(arrowstyle='<->', color='#006600', lw=1.5))
    ax.text((mdf_t + baffle_back_x)/2, -2.3, f'{sealed_depth}" sealed', 
            ha='center', fontsize=10, color='#006600')
    
    # Dimension: baffle thickness (top, red for emphasis)
    baffle_front_x = external_d - recess
    ax.annotate('', xy=(baffle_back_x, external_h + 1.5), xytext=(baffle_front_x, external_h + 1.5),
                arrowprops=dict(arrowstyle='<->', color='#CC0000', lw=1.5))
    ax.text((baffle_back_x + baffle_front_x)/2, external_h + 2.5, f'{baffle_t}" baffle',
            ha='center', fontsize=10, color='#CC0000', fontweight='bold')
    
    ax.axis('off')
    return fig, ax
```

### 2. Window Brace Cut Diagram

Shows brace outer dimensions with window cutout highlighted.

```python
def create_brace_diagram(outer_w, outer_d, window_w, window_d, title, border=2.0):
    """
    Create a single window brace cut diagram.
    
    Parameters:
    - outer_w: Outer width of brace
    - outer_d: Outer depth of brace (spans back to baffle)
    - window_w: Window cutout width
    - window_d: Window cutout depth
    - title: Brace identifier (e.g., "BRACE A (Top Horizontal)")
    - border: Solid border width around window (default 2")
    """
    fig, ax = plt.subplots(figsize=(8, 6))
    ax.set_xlim(-2, outer_w + 6)
    ax.set_ylim(-2, outer_d + 4)
    ax.set_aspect('equal')
    ax.set_title(title, fontsize=11, fontweight='bold')
    
    # Outer brace (solid color)
    ax.add_patch(Rectangle((0, 0), outer_w, outer_d,
                           facecolor='#8B6914', edgecolor='black', linewidth=2))
    
    # Window cutout (white)
    window_x = border
    window_y = border
    ax.add_patch(Rectangle((window_x, window_y), window_w, window_d,
                           facecolor='white', edgecolor='black', linewidth=1.5))
    
    # Label window
    ax.text(outer_w/2, outer_d/2, f'{window_w}" × {window_d}"\nwindow cutout',
            ha='center', va='center', fontsize=10)
    
    # Outer dimensions
    ax.annotate('', xy=(0, -1), xytext=(outer_w, -1),
                arrowprops=dict(arrowstyle='<->', color='#0066CC', lw=1.5))
    ax.text(outer_w/2, -1.8, f'{outer_w}"', ha='center', fontsize=10, 
            color='#0066CC', fontweight='bold')
    
    ax.annotate('', xy=(outer_w + 3, 0), xytext=(outer_w + 3, outer_d),
                arrowprops=dict(arrowstyle='<->', color='#0066CC', lw=1.5))
    ax.text(outer_w + 4, outer_d/2, f'{outer_d}"', ha='left', va='center',
            fontsize=10, color='#0066CC', fontweight='bold', rotation=90)
    
    # Border callout
    ax.text(border/2, outer_d/2, f'{border}"', ha='center', va='center',
            fontsize=8, color='white')
    
    ax.axis('off')
    return fig, ax
```

### 3. Multi-Panel Brace Layout

Shows all braces in a grid with summary.

```python
def create_brace_grid(brace_depth, h_brace_width=26, v_brace_height=17, border=2.0):
    """
    Create a 2×3 grid of brace cut diagrams with summary panel.
    
    Parameters:
    - brace_depth: Common depth for all braces (sealed depth)
    - h_brace_width: Horizontal brace width (default 26")
    - v_brace_height: Vertical brace height (default 17")
    - border: Solid border width (default 2")
    """
    fig, axes = plt.subplots(2, 3, figsize=(20, 14))
    fig.suptitle(f'Internal Bracing - Cut Diagrams (All 3/4" MDF)\nBrace depth: {brace_depth}"', 
                 fontsize=16, fontweight='bold', y=0.98)
    
    h_window_w = h_brace_width - 2*border
    h_window_d = brace_depth - 2*border
    v_window_h = v_brace_height - 2*border
    
    BRACE_COLOR = '#8B6914'
    
    def draw_h_brace(ax, title):
        ax.set_xlim(-2, h_brace_width + 6)
        ax.set_ylim(-2, brace_depth + 4)
        ax.set_aspect('equal')
        ax.set_title(title, fontsize=11, fontweight='bold')
        
        ax.add_patch(Rectangle((0, 0), h_brace_width, brace_depth, 
                               facecolor=BRACE_COLOR, edgecolor='black', linewidth=2))
        ax.add_patch(Rectangle((border, border), h_window_w, h_window_d, 
                               facecolor='white', edgecolor='black', linewidth=1.5))
        ax.text(h_brace_width/2, brace_depth/2, 
                f'{h_window_w}" × {h_window_d:.2f}"\nwindow cutout', 
                ha='center', va='center', fontsize=10)
        
        # Dimensions
        ax.annotate('', xy=(0, -1), xytext=(h_brace_width, -1),
                    arrowprops=dict(arrowstyle='<->', color='#0066CC', lw=1.5))
        ax.text(h_brace_width/2, -1.8, f'{h_brace_width}"', 
                ha='center', fontsize=10, color='#0066CC', fontweight='bold')
        ax.axis('off')
    
    def draw_v_brace(ax, title):
        ax.set_xlim(-2, v_brace_height + 6)
        ax.set_ylim(-2, brace_depth + 4)
        ax.set_aspect('equal')
        ax.set_title(title, fontsize=11, fontweight='bold')
        
        ax.add_patch(Rectangle((0, 0), v_brace_height, brace_depth,
                               facecolor=BRACE_COLOR, edgecolor='black', linewidth=2))
        ax.add_patch(Rectangle((border, border), v_window_h, h_window_d,
                               facecolor='white', edgecolor='black', linewidth=1.5))
        ax.text(v_brace_height/2, brace_depth/2,
                f'{v_window_h}" × {h_window_d:.2f}"\nwindow', 
                ha='center', va='center', fontsize=9)
        ax.axis('off')
    
    # Draw braces
    draw_h_brace(axes[0,0], f'BRACE A (Top Horizontal)\n{h_brace_width}" × 3" × {brace_depth}"')
    draw_h_brace(axes[0,1], f'BRACE B (Middle Horizontal)\n{h_brace_width}" × 3" × {brace_depth}"')
    draw_h_brace(axes[0,2], f'BRACE C (Bottom Horizontal)\n{h_brace_width}" × 3" × {brace_depth}"')
    draw_v_brace(axes[1,0], f'BRACE V1 (Lower Vertical)\n3" × {v_brace_height}" × {brace_depth}"')
    draw_v_brace(axes[1,1], f'BRACE V2 (Upper Vertical)\n3" × {v_brace_height}" × {brace_depth}"')
    
    # Summary panel
    ax = axes[1,2]
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 10)
    ax.set_title('BRACE CUT LIST', fontsize=11, fontweight='bold')
    
    summary = f"""WINDOW BRACE DESIGN

HORIZONTAL BRACES (×3):
  Outer: {h_brace_width}" × {brace_depth}" × 0.75"
  Window: {h_window_w}" × {h_window_d:.2f}"
  Border: {border}" all sides

VERTICAL BRACES (×2):
  Outer: {v_brace_height}" × {brace_depth}" × 0.75"
  Window: {v_window_h}" × {h_window_d:.2f}"
  Border: {border}" all sides

TOTAL MDF: ~0.25 sheets"""

    ax.text(0.5, 9.5, summary, ha='left', va='top', fontsize=10, family='monospace',
            bbox=dict(boxstyle='round', facecolor='#ffffcc', edgecolor='#cccc00', pad=0.5))
    ax.axis('off')
    
    return fig, axes
```

### 4. Specifications Panel

Monospace text box with all key dimensions.

```python
def create_specs_text(specs_dict):
    """
    Generate monospace specifications text block.
    
    Parameters:
    - specs_dict: Ordered dict with section headers as keys, 
                  list of (label, value) tuples as values
    
    Returns: Formatted string for ax.text()
    """
    lines = ["╔" + "═"*55 + "╗"]
    
    for section, items in specs_dict.items():
        lines.append("║  " + section.ljust(53) + "║")
        lines.append("║  " + "─"*len(section) + " "*(53-len(section)) + "║")
        for label, value in items:
            line = f"  {label}: {value}"
            lines.append("║" + line.ljust(55) + "║")
        lines.append("║" + " "*55 + "║")
    
    lines.append("╚" + "═"*55 + "╝")
    return '\n'.join(lines)
```

## Layout Patterns

### Side-by-Side (Diagram + Specs)

```python
fig, axes = plt.subplots(1, 2, figsize=(18, 11))
fig.suptitle('Design Title', fontsize=16, fontweight='bold', y=0.98)
# axes[0] = visual diagram
# axes[1] = specifications panel
plt.tight_layout(rect=[0, 0, 1, 0.95])
```

### Grid Layout (Multiple Braces)

```python
fig, axes = plt.subplots(2, 3, figsize=(20, 14))
# Row 0: Horizontal braces A, B, C
# Row 1: Vertical braces V1, V2, Summary
```

## Dimension Annotation Patterns

### Horizontal Arrow with Label Below

```python
ax.annotate('', xy=(x1, y), xytext=(x2, y),
            arrowprops=dict(arrowstyle='<->', color='#0066CC', lw=2))
ax.text((x1+x2)/2, y - offset, f'{dimension}"', 
        ha='center', fontsize=12, color='#0066CC', fontweight='bold')
```

### Vertical Dimension (Rotated Text)

```python
ax.annotate('', xy=(x, y1), xytext=(x, y2),
            arrowprops=dict(arrowstyle='<->', color='#0066CC', lw=1.5))
ax.text(x + offset, (y1+y2)/2, f'{dimension}"', 
        ha='left', va='center', fontsize=10, color='#0066CC', rotation=90)
```

## Output Best Practices

1. **Resolution:** 150 DPI for print, 100 DPI for screen-only
2. **Save format:** PNG with white background
3. **File naming:** Descriptive, underscore-separated (e.g., `revised_12.5ft3_crosssection.png`)
4. **Copy to outputs:** Always copy final images to `/mnt/user-data/outputs/`

```python
plt.tight_layout(rect=[0, 0, 1, 0.95])  # Leave room for suptitle
plt.savefig('/home/claude/diagram_name.png', dpi=150, bbox_inches='tight', facecolor='white')
plt.close()

# Copy to outputs for user access
import shutil
shutil.copy('/home/claude/diagram_name.png', '/mnt/user-data/outputs/')
```

## Window Brace Calculations

```python
def calculate_window_brace(outer_width, outer_depth, border=2.0):
    """
    Calculate window cutout dimensions for a brace.
    Standard: 2" solid border on all sides.
    """
    window_width = outer_width - 2 * border
    window_depth = outer_depth - 2 * border
    return window_width, window_depth

# Example for 22" depth enclosure (16.75" sealed):
# Horizontal brace: 26" × 16.75" outer → 22" × 12.75" window
# Vertical brace: 17" × 16.75" outer → 13" × 12.75" window
```

## Enclosure Dimension Chain

When depth changes, recalculate everything:

```python
def calculate_enclosure_dimensions(target_gross_ft3, internal_w, internal_h, 
                                    mdf_t=0.75, baffle_t=1.5, recess=3.0):
    """
    Calculate all enclosure dimensions from target volume.
    """
    target_in3 = target_gross_ft3 * 1728
    internal_area = internal_w * internal_h
    sealed_depth = target_in3 / internal_area
    
    external_depth = sealed_depth + mdf_t + baffle_t + recess
    
    # Round to practical dimension (nearest 0.5")
    external_depth = round(external_depth * 2) / 2
    
    # Recalculate actual volume with rounded depth
    sealed_depth = external_depth - mdf_t - baffle_t - recess
    actual_volume = (internal_w * internal_h * sealed_depth) / 1728
    
    return {
        'external_depth': external_depth,
        'sealed_depth': sealed_depth,
        'gross_volume_ft3': actual_volume,
        'brace_depth': sealed_depth,
        'window_depth': sealed_depth - 4.0,  # 2" border each side
    }

# Example:
# dims = calculate_enclosure_dimensions(12.5, 28.5, 46.5)
# → external_depth: 22", sealed_depth: 16.75", gross_volume: 12.85 ft³
```

## Complete Example

```python
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

# Enclosure parameters
EXTERNAL_W, EXTERNAL_H, EXTERNAL_D = 30.0, 48.0, 22.0
MDF_T, BAFFLE_T, RECESS = 0.75, 1.5, 3.0

internal_w = EXTERNAL_W - 2*MDF_T  # 28.5"
internal_h = EXTERNAL_H - 2*MDF_T  # 46.5"
sealed_depth = EXTERNAL_D - MDF_T - BAFFLE_T - RECESS  # 16.75"
volume_ft3 = (internal_w * internal_h * sealed_depth) / 1728  # 12.85

# Generate cross-section with specs
fig, axes = plt.subplots(1, 2, figsize=(18, 11))
fig.suptitle(f'Rear Vertical Subwoofer - {EXTERNAL_W}"×{EXTERNAL_H}"×{EXTERNAL_D}"',
             fontsize=16, fontweight='bold')

# Left: cross-section diagram
ax1 = axes[0]
ax1.set_xlim(-4, 30)
ax1.set_ylim(-6, 56)
ax1.set_aspect('equal')
# ... draw panels, dimensions

# Right: specs
ax2 = axes[1]
ax2.text(0.5, 9.5, specs_text, family='monospace', fontsize=10)
ax2.axis('off')

plt.savefig('/home/claude/crosssection.png', dpi=150, bbox_inches='tight', facecolor='white')
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Text overlapping | Increase figure size or reduce font size |
| Arrows not visible | Check xy vs xytext order (xy=arrowhead) |
| Colors too similar | Use distinct palette (shell vs baffle vs brace) |
| Dimensions wrong | Verify calculation chain, check W/H/D assignment |
| File not accessible | Copy from /home/claude/ to /mnt/user-data/outputs/ |

## Related Files

- `C:\Claude\HT\Rear_Vertical_Subwoofer_Cutting_Layout.md` - Construction document
- `C:\Claude\HT\journal.txt` - Project development log
