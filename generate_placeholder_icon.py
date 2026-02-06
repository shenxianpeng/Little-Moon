#!/usr/bin/env python3
"""
Generate a simple placeholder icon for Little Moon
This creates a basic crescent moon icon with gradient background
"""

try:
    from PIL import Image, ImageDraw
except ImportError:
    print("❌ Pillow is required. Install with: pip3 install Pillow")
    exit(1)

import math
from pathlib import Path

# Output path
output_path = Path(__file__).parent / "AppIcon-1024.png"

# Create image with gradient background
size = 1024
img = Image.new('RGB', (size, size))
draw = ImageDraw.Draw(img)

# Create gradient background (dark blue to purple)
for y in range(size):
    # Interpolate between dark blue and purple
    ratio = y / size
    r = int(26 + (70 - 26) * ratio)      # 1A -> 46
    g = int(26 + (26 - 26) * ratio)      # 1A -> 1A
    b = int(62 + (71 - 62) * ratio)      # 3E -> 47
    draw.rectangle([(0, y), (size, y+1)], fill=(r, g, b))

# Draw crescent moon
center_x, center_y = size // 2, size // 2 - 50
moon_radius = 280

# Draw full moon circle (golden color)
moon_color = (247, 231, 206)  # #F7E7CE
draw.ellipse(
    [(center_x - moon_radius, center_y - moon_radius),
     (center_x + moon_radius, center_y + moon_radius)],
    fill=moon_color
)

# Draw overlapping circle to create crescent (same as background gradient)
overlap_x = center_x + 120
overlap_y = center_y
overlap_radius = 280
# Use a dark blue color similar to the background
dark_blue = (30, 30, 60)
draw.ellipse(
    [(overlap_x - overlap_radius, overlap_y - overlap_radius),
     (overlap_x + overlap_radius, overlap_y + overlap_radius)],
    fill=dark_blue
)

# Add some stars
import random
random.seed(42)  # Consistent stars
star_color = (255, 255, 230, 180)

for _ in range(30):
    x = random.randint(50, size - 50)
    y = random.randint(50, size - 50)
    # Skip if too close to moon
    dist = math.sqrt((x - center_x)**2 + (y - center_y)**2)
    if dist < moon_radius + 80:
        continue
    
    star_size = random.randint(2, 6)
    # Draw star as small circle
    star_img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    star_draw = ImageDraw.Draw(star_img)
    star_draw.ellipse(
        [(x - star_size, y - star_size), (x + star_size, y + star_size)],
        fill=(255, 255, 240)
    )
    img.paste(star_img, (0, 0), star_img)

# Save
img.save(output_path, 'PNG', optimize=True)
print(f"✓ Generated placeholder icon: {output_path}")
print(f"  Size: {size}x{size}")
print(f"\nThis is a simple placeholder. For a professional icon:")
print(f"  1. Use the prompts in APP_ICON_PROMPT.md")
print(f"  2. Generate with AI (Midjourney, DALL-E, etc.)")
print(f"  3. Replace AppIcon-1024.png with your design")
print(f"\nTo apply this icon to the app, run:")
print(f"  python3 apply_app_icon.py")
