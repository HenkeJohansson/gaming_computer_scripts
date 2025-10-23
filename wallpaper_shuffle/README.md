# Wallpaper Shuffle

Ett enkelt skript som slumpmässigt växlar KDE Plasma-bakgrund med jämna mellanrum via en systemd-timer.

Filer
- [wallpaper_shuffle.sh](wallpaper_shuffle/wallpaper_shuffle.sh) — huvudskriptet som väljer bild och sätter bakgrunden.
- [wallpaper-shuffle.service](wallpaper_shuffle/wallpaper-shuffle.service) — systemd-enhet (oneshot) som kör skriptet.
- [wallpaper-shuffle.timer](wallpaper_shuffle/wallpaper-shuffle.timer) — systemd-timer som triggar servicen (standard: varje timme).
- [install.sh](wallpaper_shuffle/install.sh) — installationsskript som installerar och aktiverar timern.
- [uninstall.sh](wallpaper_shuffle/uninstall.sh) — avinstallationsskript som stänger av och tar bort enheterna.

Snabb översikt
- Skriptet läser bilder från `WALLDIR` (standard: `$HOME/Pictures/Wallpapers/Gaming`) och bygger en kö i `$HOME/.cache/wallpaper_queue`.
- Den sätter bakgrunden med `plasma-apply-wallpaperimage` och sparar vald bild i `$HOME/.cache/wallpaper_state`.
- Timern är konfigurerad i [wallpaper-shuffle.timer](wallpaper_shuffle/wallpaper-shuffle.timer) och kör servicen enligt den.

Förutsättningar
- KDE Plasma (för `plasma-apply-wallpaperimage`).
- systemd user units (timers).
- Linux-verktyg: `find`, `shuf`, `ddcutil` används inte av detta skript men finns i workspace (se övriga skript).
- Se källkod: [wallpaper_shuffle.sh](wallpaper_shuffle/wallpaper_shuffle.sh).

Installera
1. Kör installationsskriptet:
   ./install.sh
   (eller)
   bash wallpaper_shuffle/install.sh

Installationsskriptet kopierar enheterna till `~/.config/systemd/user/`, laddar om daemonen och aktiverar timern. Se [install.sh](wallpaper_shuffle/install.sh).

Avinstallera
1. Kör:
   ./uninstall.sh
   (eller)
   bash wallpaper_shuffle/uninstall.sh

Detta inaktiverar timern och tar bort enhetsfilerna. Se [uninstall.sh](wallpaper_shuffle/uninstall.sh).

Köra manuellt
- Kör skriptet direkt:
  bash wallpaper_shuffle/wallpaper_shuffle.sh
- Eller kör service en gång:
  systemctl --user start wallpaper-shuffle.service

Anpassa
- Ändra bildmappen i [wallpaper_shuffle.sh](wallpaper_shuffle/wallpaper_shuffle.sh) genom att justera `WALLDIR`.
- Töm eller förnya kön om du vill börja om:
  rm ~/.cache/wallpaper_queue
  (Nästa körning skapar en ny kö.)

Felsökning
- Kontrollera timer/status:
  systemctl --user list-timers
  systemctl --user status wallpaper-shuffle.service
- Kolla innehållet i kön:
  cat ~/.cache/wallpaper_queue
- Skriptet loggar inte aktivt; kör det manuellt för att se felmeddelanden.

Relaterade filer i workspace
- [toggle_secondary_monitor.sh](toggle_secondary_monitor.sh)
- [mesa_version_output](mesa_version_output)
- [scripts.code-workspace](scripts.code-workspace)
- Repository root: [README.md](README.md)

Licens
- Enkel personlig användning. Anpassa fritt.