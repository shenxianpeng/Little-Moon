#!/usr/bin/env python3
"""
Little Moon App Icon Generator (Python version)
Generates all required iOS app icon sizes from a 1024x1024 source image
Requires: Pillow (PIL)
Install: pip3 install Pillow
"""

import os
import sys
import json
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("❌ Error: Pillow (PIL) is not installed")
    print("\nPlease install it using:")
    print("  pip3 install Pillow")
    print("or")
    print("  python3 -m pip install Pillow")
    sys.exit(1)

# Colors
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    NC = '\033[0m'

# Project paths
PROJECT_DIR = Path(__file__).parent
ASSETS_DIR = PROJECT_DIR / "Little Moon" / "Assets.xcassets" / "AppIcon.appiconset"
SOURCE_ICON = PROJECT_DIR / "AppIcon-1024.png"

# iOS App Icon sizes
ICON_SIZES = [
    {"filename": "AppIcon-20@2x.png", "size": 40, "idiom": "iphone", "scale": "2x", "point_size": "20x20"},
    {"filename": "AppIcon-20@3x.png", "size": 60, "idiom": "iphone", "scale": "3x", "point_size": "20x20"},
    {"filename": "AppIcon-29@2x.png", "size": 58, "idiom": "iphone", "scale": "2x", "point_size": "29x29"},
    {"filename": "AppIcon-29@3x.png", "size": 87, "idiom": "iphone", "scale": "3x", "point_size": "29x29"},
    {"filename": "AppIcon-40@2x.png", "size": 80, "idiom": "iphone", "scale": "2x", "point_size": "40x40"},
    {"filename": "AppIcon-40@3x.png", "size": 120, "idiom": "iphone", "scale": "3x", "point_size": "40x40"},
    {"filename": "AppIcon-60@2x.png", "size": 120, "idiom": "iphone", "scale": "2x", "point_size": "60x60"},
    {"filename": "AppIcon-60@3x.png", "size": 180, "idiom": "iphone", "scale": "3x", "point_size": "60x60"},
    {"filename": "AppIcon-1024.png", "size": 1024, "idiom": "ios-marketing", "scale": "1x", "point_size": "1024x1024"},
]

def print_header():
    print(f"{Colors.BLUE}{'═' * 47}{Colors.NC}")
    print(f"{Colors.BLUE}  Little Moon App Icon Generator (Python){Colors.NC}")
    print(f"{Colors.BLUE}{'═' * 47}{Colors.NC}\n")

def check_source_icon():
    """Check if source icon exists and has correct dimensions"""
    if not SOURCE_ICON.exists():
        print(f"{Colors.RED}✗ Error: Source icon not found!{Colors.NC}")
        print(f"{Colors.YELLOW}Please place your 1024x1024 PNG icon at:{Colors.NC}")
        print(f"{Colors.YELLOW}{SOURCE_ICON}{Colors.NC}\n")
        print(f"{Colors.BLUE}Tip: Use the prompts in APP_ICON_PROMPT.md to generate your icon{Colors.NC}")
        sys.exit(1)
    
    try:
        with Image.open(SOURCE_ICON) as img:
            width, height = img.size
            if width != 1024 or height != 1024:
                print(f"{Colors.RED}✗ Error: Source icon must be 1024x1024 pixels{Colors.NC}")
                print(f"{Colors.YELLOW}Current size: {width}x{height}{Colors.NC}")
                sys.exit(1)
            
            # Check if image has transparency (should not for iOS icons)
            if img.mode == 'RGBA':
                print(f"{Colors.YELLOW}⚠ Warning: Image has transparency. Converting to RGB...{Colors.NC}")
                # Convert RGBA to RGB with white background
                rgb_img = Image.new('RGB', img.size, (255, 255, 255))
                rgb_img.paste(img, mask=img.split()[3] if len(img.split()) == 4 else None)
                rgb_img.save(SOURCE_ICON)
                print(f"{Colors.GREEN}✓ Converted to RGB{Colors.NC}")
    except Exception as e:
        print(f"{Colors.RED}✗ Error reading source icon: {e}{Colors.NC}")
        sys.exit(1)
    
    print(f"{Colors.GREEN}✓ Source icon verified: 1024x1024{Colors.NC}\n")

def generate_icons():
    """Generate all required icon sizes"""
    # Create directory if it doesn't exist
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    
    # Remove old icons
    for file in ASSETS_DIR.glob("*.png"):
        file.unlink()
    
    print(f"{Colors.BLUE}Generating icon sizes...{Colors.NC}\n")
    
    # Open source image once
    with Image.open(SOURCE_ICON) as source_img:
        # Ensure RGB mode
        if source_img.mode != 'RGB':
            source_img = source_img.convert('RGB')
        
        for icon_spec in ICON_SIZES:
            filename = icon_spec["filename"]
            size = icon_spec["size"]
            output_path = ASSETS_DIR / filename
            
            print(f"  {Colors.YELLOW}→{Colors.NC} Generating {filename:<25} {size:4d}x{size:<4d} ", end='')
            
            # Resize with high-quality Lanczos resampling
            resized = source_img.resize((size, size), Image.Resampling.LANCZOS)
            resized.save(output_path, "PNG", optimize=True)
            
            print(f"{Colors.GREEN}✓{Colors.NC}")

def generate_contents_json():
    """Generate Contents.json for Xcode asset catalog"""
    print(f"\n{Colors.BLUE}Creating Contents.json...{Colors.NC}")
    
    images = []
    for spec in ICON_SIZES:
        images.append({
            "filename": spec["filename"],
            "idiom": spec["idiom"],
            "scale": spec["scale"],
            "size": spec["point_size"]
        })
    
    contents = {
        "images": images,
        "info": {
            "author": "xcode",
            "version": 1
        }
    }
    
    contents_path = ASSETS_DIR / "Contents.json"
    with open(contents_path, 'w') as f:
        json.dump(contents, f, indent=2)
    
    print(f"{Colors.GREEN}✓ Contents.json created{Colors.NC}\n")

def print_summary():
    """Print completion summary"""
    print(f"{Colors.BLUE}{'═' * 47}{Colors.NC}")
    print(f"{Colors.GREEN}✓ App icon successfully generated and applied!{Colors.NC}")
    print(f"{Colors.BLUE}{'═' * 47}{Colors.NC}\n")
    
    print(f"{Colors.YELLOW}Generated files:{Colors.NC}")
    for icon_file in sorted(ASSETS_DIR.glob("*.png")):
        size = icon_file.stat().st_size
        size_kb = size / 1024
        print(f"  {icon_file.name} ({size_kb:.1f} KB)")
    
    print(f"\n{Colors.BLUE}Next steps:{Colors.NC}")
    print("  1. Open the Xcode project")
    print("  2. Clean build folder (⇧⌘K)")
    print("  3. Build and run the app")
    print("  4. Check the app icon on the simulator/device\n")
    
    print(f"{Colors.GREEN}Done! 🌙{Colors.NC}\n")

def main():
    """Main execution"""
    try:
        print_header()
        check_source_icon()
        generate_icons()
        generate_contents_json()
        print_summary()
    except KeyboardInterrupt:
        print(f"\n\n{Colors.YELLOW}Operation cancelled by user{Colors.NC}")
        sys.exit(0)
    except Exception as e:
        print(f"\n{Colors.RED}✗ Unexpected error: {e}{Colors.NC}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
