#!/bin/bash

WALLDIR="$HOME/Pictures/Wallpapers/Gaming"
QUEUEFILE="$HOME/.cache/wallpaper_queue"
STATEFILE="$HOME/.cache/wallpaper_state"

mkdir -p "$(dirname "$QUEUEFILE")"

# If no que, create one (paths to the images)
if [[ ! -s "$QUEUEFILE" ]]; then
    find "$WALLDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf > "$QUEUEFILE"
fi

# Get first image path from que
PIC=$(head -n 1 "$QUEUEFILE")

# Set image as background
if [[ -n "$PIC" && -f "$PIC" ]]; then
    plasma-apply-wallpaperimage "$PIC"

    # Save in statefile
    echo "$PIC" > "$STATEFILE"

    # remove  image path from que
    tail -n +2 "$QUEUEFILE" > "$QUEUEFILE.tmp" && mv "$QUEUEFILE.tmp" "$QUEUEFILE"
else
    echo "No valid images found in $WALLDIR"
fi
