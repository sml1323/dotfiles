#!/bin/bash

sketchybar --add item wifi right \
  --subscribe wifi wifi_change \
  --set wifi \
  icon="" \
  update_freq=30 \
  script="$PLUGIN_DIR/wifi.sh" \
  click_script="open 'x-apple.systempreferences:com.apple.wifi-settings-extension'"
