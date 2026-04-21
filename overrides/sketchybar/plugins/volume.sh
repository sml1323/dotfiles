#!/bin/bash

VOLUME=$(osascript -e 'output volume of (get volume settings)')

if [ "$SENDER" = "volume_change" ]; then
  VOLUME=$INFO

elif command -v betterdisplaycli 2>&1 >/dev/null; then
  if [ "$VOLUME" = "missing value" ]; then
    VOLUME=$(betterdisplaycli get -ddc -value -vcp=audioSpeakerVolume -displayWithMainStatus)
  fi
fi

case $VOLUME in
[6-9][0-9] | 100)
  ICON="" # nf-fa-volume_up
  ;;
[3-5][0-9])
  ICON="" # nf-fa-volume_down
  ;;
[1-9] | [1-2][0-9])
  ICON="" # nf-fa-volume_off
  ;;
*) ICON="" ;; # nf-fa-volume_mute (0 or mute)
esac

sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
