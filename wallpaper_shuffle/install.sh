#!/bin/bash
set -e

SERVICE_NAME="wallpaper-shuffle"
SYSTEMD_DIR="$HOME/.config/systemd/user"
SCRIPT_DIR="$HOME/scripts/wallpaper_shuffle"

echo "::: Installing Wallpaper Shuffle..."

mkdir -p "$SYSTEMD_DIR"

# Stop and remove old timer and sevice if they exist
if systemctl --user list-unit-files | grep -q "$SERVICE_NAME.timer"; then
    echo "::: Removing old systemd units..."
    systemctl --user disable --now "$SERVICE_NAME.timer" || true
    systemctl --user disable --now "$SERVICE_NAME.service" || true
fi

rm -f "$SYSTEMD_DIR/$SERVICE_NAME.service"
rm -f "$SYSTEMD_DIR/$SERVICE_NAME.timer"

ln -sf "$SCRIPT_DIR/$SERVICE_NAME.service" "$SYSTEMD_DIR/$SERVICE_NAME.service"
ln -sf "$SCRIPT_DIR/$SERVICE_NAME.timer" "$SYSTEMD_DIR/$SERVICE_NAME.timer"

chmod +x "$SCRIPT_DIR/wallpaper_shuffle.sh"

systemctl --user daemon-reload

mkdir -p "$SYSTEMD_DIR/plasma-workspace.target.wants"
ln -sf "$SCRIPT_DIR/$SERVICE_NAME.timer" "$SYSTEMD_DIR/plasma-workspace.target.wants/$SERVICE_NAME.timer"

systemctl --user enable --now "$SERVICE_NAME.timer"

systemctl --user start "$SERVICE_NAME.service"

# Wait for NEXT
sleep 1

# Check status
echo
echo "::: Timer status:"
#systemctl --user list-timers | grep "$SERVICE_NAME"
systemctl --user list-timers

cat $HOME/.cache/wallpaper_que

echo
echo "::: Timer and service installed."
echo "::: Installation done!."
