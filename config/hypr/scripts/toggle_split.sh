#!/bin/bash
set -x # Add this line

# Define a file to store the current split direction state
STATE_FILE="$HOME/.config/hypr/split_direction_state"

# Read the current state. If the file doesn't exist, default to 'horizontal'.
# This 'horizontal' state means the *next* time you run the script, it will
# set the split to 'vertical'.
if [ -f "$STATE_FILE" ]; then
    CURRENT_DIRECTION=$(cat "$STATE_FILE")
else
    # Default to horizontal if state file doesn't exist (e.g., first run or after reboot)
    CURRENT_DIRECTION="horizontal"
fi

# Toggle the split direction
if [ "$CURRENT_DIRECTION" == "horizontal" ]; then
    hyprctl dispatch layoutmsg dwindle:splitv
    echo "vertical" > "$STATE_FILE"
    # Optional: uncomment the line below if you want a notification
    # notify-send "Hyprland Split" "Switched to Vertical Split (Top/Bottom)"
else
    hyprctl dispatch layoutmsg dwindle:splith
    echo "horizontal" > "$STATE_FILE"
    # Optional: uncomment the line below if you want a notification
    # notify-send "Hyprland Split" "Switched to Horizontal Split (Left/Right)"
fi
