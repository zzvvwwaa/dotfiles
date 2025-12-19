#!/bin/bash

# --- Configuration ---
WALL_DIR="$HOME/Pictures/Wallpapers"
WOFI_STYLE="$HOME/.config/wofi/style.css"
# ---------------------

# Check if directory exists
if [ ! -d "$WALL_DIR" ]; then
    echo "Directory not found: $WALL_DIR"
    exit 1
fi

# Select wallpaper
SELECTED=$(ls "$WALL_DIR" | wofi --dmenu --prompt "Select Wallpaper" --style "$WOFI_STYLE")

if [ -n "$SELECTED" ]; then
    FULLPATH="$WALL_DIR/$SELECTED"
    
    # 1. Preload the new wallpaper
    hyprctl hyprpaper preload "$FULLPATH"
    
    # 2. Set the wallpaper for all monitors
    # We use a loop to ensure it applies to every active monitor
    for monitor in $(hyprctl monitors | grep 'Monitor' | awk '{print $2}'); do
        hyprctl hyprpaper wallpaper "$monitor,$FULLPATH"
    done

    # 3. (Optional) Unload all other wallpapers to save memory
    hyprctl hyprpaper unload all
fi
