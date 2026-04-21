#!/bin/bash

SSID=$(system_profiler SPAirPortDataType 2>/dev/null | awk '/Current Network Information:/{getline; print $1}' | tr -d ':' | head -1)

if [ -z "$SSID" ]; then
  sketchybar --set "$NAME" label="▂___" icon=""
else
  RSSI=$(system_profiler SPAirPortDataType 2>/dev/null | awk '/Signal \/ Noise:/{print $4; exit}' | tr -d '-')
  if [ -z "$RSSI" ]; then RSSI=0; fi

  if [ "$RSSI" -ge 75 ]; then
    BARS="▂___"   # 약 (-75 이하)
  elif [ "$RSSI" -ge 65 ]; then
    BARS="▂▄__"   # 중약
  elif [ "$RSSI" -ge 55 ]; then
    BARS="▂▄▆_"   # 중강
  else
    BARS="▂▄▆█"   # 강
  fi

  sketchybar --set "$NAME" label="$BARS" icon=""
fi
