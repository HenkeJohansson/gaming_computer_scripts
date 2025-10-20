#!/bin/bash

# Sekundär skärm
DISPLAY_NUM=1
IS_SECONDARY_MONITOR_OFF="$HOME/.secondary_monitor_off"

if [ -f "$IS_SECONDARY_MONITOR_OFF" ]; then
  echo "Tänder sekundära skärmen..."
  ddcutil --display $DISPLAY_NUM setvcp D6 1
  rm "$IS_SECONDARY_MONITOR_OFF"
else
  echo "Släcker sekundära skärmen..."
  ddcutil --display $DISPLAY_NUM setvcp D6 4
  touch "$IS_SECONDARY_MONITOR_OFF"
fi
