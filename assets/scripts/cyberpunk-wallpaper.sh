#!/usr/bin/env bash

# Cyberpunk Wallpaper Cycler Script
# Cycles through cyberpunk wallpapers in order

WALLPAPER_DIR="/etc/nixos/assets/wallpapers/cyberpunk"
STATE_FILE="/tmp/cyberpunk-wallpaper-state"

# Array of cyberpunk wallpapers in order
WALLPAPERS=(
    "cyberpunk-lucy.webp"    # Start with Lucy (index 0)
    "cyberpunk-city.webp"    # Then city (index 1) 
    "cyberpunk-car.webp"     # Then car (index 2)
)

# Read current index, default to 0
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE")
else
    CURRENT_INDEX=0
fi

# Cycle to next wallpaper
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
WALLPAPER="${WALLPAPERS[$NEXT_INDEX]}"

# Cyberpunk glitch effects array
GLITCH_EFFECTS=(
    "wipe --transition-angle 15 --transition-step 200 --transition-duration 0.8 --transition-fps 60"
    "wave --transition-angle 45 --transition-wave 30,15 --transition-step 150 --transition-duration 1.2"
    "grow --transition-pos random --transition-step 255 --transition-duration 0.6"
    "wipe --transition-angle 135 --transition-step 180 --transition-duration 0.9"
    "outer --transition-pos center --transition-step 200 --transition-duration 0.7"
    "wipe --transition-angle 270 --transition-step 220 --transition-duration 0.5"
)

# Select random glitch effect
RANDOM_EFFECT=${GLITCH_EFFECTS[$RANDOM % ${#GLITCH_EFFECTS[@]}]}

# Apply wallpaper with cyberpunk glitch transition
echo "🔥 Cyberpunk glitch transition: $WALLPAPER"
swww img "$WALLPAPER_DIR/$WALLPAPER" --transition-type $RANDOM_EFFECT

# Save state for next cycle
echo "$NEXT_INDEX" > "$STATE_FILE"