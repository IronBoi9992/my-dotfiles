#!/bin/bash
#
# Master Hyprland Startup Script (Corrected)
# Controls the entire startup sequence to prevent race conditions.
#

# --- Configuration ---
ANIMATED_WALLPAPER="/home/nfis/Downloads/getsuga.gif"
STATIC_WALLPAPER="/home/nfis/Downloads/fire.jpg"
STATIC_WALLPAPER2="/home/nfis/Downloads/black-sky.jpg"
ANIMATION_DURATION=7.3 # Total time to wait before switching to static
# ---

# --- Function to switch wallpaper after a delay ---
switch_to_static() {
    sleep "$ANIMATION_DURATION"
    swww img --outputs eDP-1 "$STATIC_WALLPAPER2" --transition-type simple --transition-fps 60 
    swww img --outputs HDMI-A-1 "$STATIC_WALLPAPER2" --transition-type simple --transition-fps 60 
}


# --- MAIN EXECUTION ---

# 1. Start the swww daemon in the background using the correct command
swww-daemon &
# 2. CRUCIAL: Wait a moment for the daemon to initialize
sleep 1

# 3. Now, set the initial animated wallpaper
#swww img --outputs HDMI-A-1,eDP-1 "$ANIMATED_WALLPAPER" --transition-type none

# 4. Start the background timer to switch to the final wallpaper
switch_to_static &

# 5. Launch all other applications
killall -q waybar


/usr/lib/xdg-desktop-portal-hyprland &
/usr/lib/xdg-desktop-portal-gtk &


echo "Master startup script executed successfully."
exit 0

