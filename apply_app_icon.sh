#!/bin/bash

# Little Moon App Icon Generator and Applier
# This script generates all required iOS app icon sizes from a 1024x1024 source image
# and applies them to the Xcode project

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project paths
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$PROJECT_DIR/Little Moon/Assets.xcassets/AppIcon.appiconset"
SOURCE_ICON="$PROJECT_DIR/AppIcon-1024.png"

echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Little Moon App Icon Generator${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════${NC}\n"

# Check if source icon exists
if [ ! -f "$SOURCE_ICON" ]; then
    echo -e "${RED}✗ Error: Source icon not found!${NC}"
    echo -e "${YELLOW}Please place your 1024x1024 PNG icon at:${NC}"
    echo -e "${YELLOW}$SOURCE_ICON${NC}\n"
    echo -e "${BLUE}Tip: Use the prompts in APP_ICON_PROMPT.md to generate your icon${NC}"
    exit 1
fi

# Check if ImageMagick or sips is available
if command -v magick &> /dev/null; then
    CONVERTER="magick"
    echo -e "${GREEN}✓ Using ImageMagick for image processing${NC}"
elif command -v convert &> /dev/null; then
    CONVERTER="convert"
    echo -e "${GREEN}✓ Using ImageMagick (convert) for image processing${NC}"
elif command -v sips &> /dev/null; then
    CONVERTER="sips"
    echo -e "${GREEN}✓ Using macOS sips for image processing${NC}"
else
    echo -e "${RED}✗ Error: No image processing tool found!${NC}"
    echo -e "${YELLOW}Please install ImageMagick:${NC}"
    echo -e "${YELLOW}  brew install imagemagick${NC}"
    exit 1
fi

# Verify source image dimensions
if [ "$CONVERTER" = "sips" ]; then
    dimensions=$(sips -g pixelWidth -g pixelHeight "$SOURCE_ICON" | grep -E "pixelWidth|pixelHeight" | awk '{print $2}')
    width=$(echo "$dimensions" | head -1)
    height=$(echo "$dimensions" | tail -1)
else
    dimensions=$(magick identify -format "%wx%h" "$SOURCE_ICON" 2>/dev/null || convert identify -format "%wx%h" "$SOURCE_ICON")
    width=$(echo "$dimensions" | cut -d'x' -f1)
    height=$(echo "$dimensions" | cut -d'x' -f2)
fi

if [ "$width" != "1024" ] || [ "$height" != "1024" ]; then
    echo -e "${RED}✗ Error: Source icon must be 1024x1024 pixels${NC}"
    echo -e "${YELLOW}Current size: ${width}x${height}${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Source icon verified: 1024x1024${NC}\n"

# Create or clean AppIcon directory
mkdir -p "$ASSETS_DIR"
rm -f "$ASSETS_DIR"/*.png

# iOS App Icon sizes (size@scale)
# Format: "filename:size:scale:idiom:role"
declare -a SIZES=(
    "AppIcon-20@2x.png:20:2:iphone:"
    "AppIcon-20@3x.png:20:3:iphone:"
    "AppIcon-29@2x.png:29:2:iphone:"
    "AppIcon-29@3x.png:29:3:iphone:"
    "AppIcon-40@2x.png:40:2:iphone:"
    "AppIcon-40@3x.png:40:3:iphone:"
    "AppIcon-60@2x.png:60:2:iphone:"
    "AppIcon-60@3x.png:60:3:iphone:"
    "AppIcon-1024.png:1024:1:ios-marketing:"
)

echo -e "${BLUE}Generating icon sizes...${NC}\n"

# Function to resize image
resize_image() {
    local output="$1"
    local size="$2"
    
    if [ "$CONVERTER" = "sips" ]; then
        sips -z "$size" "$size" "$SOURCE_ICON" --out "$output" &> /dev/null
    else
        magick "$SOURCE_ICON" -resize "${size}x${size}" "$output" 2>/dev/null || \
        convert "$SOURCE_ICON" -resize "${size}x${size}" "$output"
    fi
}

# Generate all sizes
for item in "${SIZES[@]}"; do
    IFS=':' read -r filename size scale idiom role <<< "$item"
    actual_size=$((size * scale))
    output_path="$ASSETS_DIR/$filename"
    
    printf "  ${YELLOW}→${NC} Generating %-25s %4dx%-4d " "$filename" "$actual_size" "$actual_size"
    resize_image "$output_path" "$actual_size"
    echo -e "${GREEN}✓${NC}"
done

# Generate Contents.json
echo -e "\n${BLUE}Creating Contents.json...${NC}"

cat > "$ASSETS_DIR/Contents.json" << 'EOF'
{
  "images" : [
    {
      "filename" : "AppIcon-20@2x.png",
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "20x20"
    },
    {
      "filename" : "AppIcon-20@3x.png",
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "20x20"
    },
    {
      "filename" : "AppIcon-29@2x.png",
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "29x29"
    },
    {
      "filename" : "AppIcon-29@3x.png",
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "29x29"
    },
    {
      "filename" : "AppIcon-40@2x.png",
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "40x40"
    },
    {
      "filename" : "AppIcon-40@3x.png",
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "40x40"
    },
    {
      "filename" : "AppIcon-60@2x.png",
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "60x60"
    },
    {
      "filename" : "AppIcon-60@3x.png",
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "60x60"
    },
    {
      "filename" : "AppIcon-1024.png",
      "idiom" : "ios-marketing",
      "scale" : "1x",
      "size" : "1024x1024"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF

echo -e "${GREEN}✓ Contents.json created${NC}\n"

# Summary
echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ App icon successfully generated and applied!${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════${NC}\n"
echo -e "${YELLOW}Generated files:${NC}"
ls -lh "$ASSETS_DIR"/*.png | awk '{printf "  %s (%s)\n", $9, $5}'

echo -e "\n${BLUE}Next steps:${NC}"
echo -e "  1. Open the Xcode project"
echo -e "  2. Clean build folder (⇧⌘K)"
echo -e "  3. Build and run the app"
echo -e "  4. Check the app icon on the simulator/device\n"

echo -e "${GREEN}Done! 🌙${NC}\n"
