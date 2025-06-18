#!/bin/bash

# Define a file to store the current audio state (stereo or right_only)
STATE_FILE="$HOME/.config/waybar/right_channel_state"

# Get the current default audio sink (your headphones/speakers)
DEFAULT_SINK=$(pactl get-default-sink)

# Read the current state. If the file doesn't exist, default to 'stereo'.
if [ -f "$STATE_FILE" ]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
else
    # Default to stereo if the state file doesn't exist
    CURRENT_STATE="stereo"
fi

# Toggle the audio mode
if [ "$CURRENT_STATE" == "stereo" ]; then
    # Switch to Right Channel Only (Left channel 0%, Right channel 100%)
    pactl set-sink-volume "$DEFAULT_SINK" 0% 100%
    echo "right_only" > "$STATE_FILE"
    notify-send "Audio Mode" "Right Channel Only" -i audio-volume-high
else
    # Switch back to Stereo (Both channels 100%)
    pactl set-sink-volume "$DEFAULT_SINK" 100% 100%
    echo "stereo" > "$STATE_FILE"
    notify-send "Audio Mode" "Stereo" -i audio-volume-high
fi
