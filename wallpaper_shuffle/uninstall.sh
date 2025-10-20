#!/bin/bash
set -e

SERVICE_NAME="wallpaper-shuffle"
SYSTEMD_DIR="$HOME/.config/systemd/user"
SCRIPT_DIR="$HOME/scripts/wallpaper_shuffle"

echo "::: Uninstalling Wallpaper Shuffle..."

# Stoppa och ta bort timern & servicen
systemctl --user disable --now "$SERVICE_NAME.timer" || true
systemctl --user disable --now "$SERVICE_NAME.service" || true

# Ta bort symlänkar
rm -f "$SYSTEMD_DIR/$SERVICE_NAME.timer"
rm -f "$SYSTEMD_DIR/$SERVICE_NAME.service"

# Ladda om systemd
systemctl --user daemon-reload

echo
echo "::: Uninstalled!"
echo "::: Check user timers to confirm it's removed:"
systemctl --user list-timers | grep "$SERVICE_NAME" || echo "::: Timer not found, all clean."
