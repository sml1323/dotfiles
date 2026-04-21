#!/bin/bash

music=(
  script="$PLUGIN_DIR/youtube-music.sh"
  click_script="$PLUGIN_DIR/youtube-music.sh"
  label.padding_right=8
  label.font="Hack Nerd Font:Bold:17.0"
  padding_right=0
  icon=""
  icon.font="Hack Nerd Font:Bold:17.0"
  display=1
  # drawing=off
  label="Loading…"
  # background.image=media.artwork
  background.image.scale=0.7
  background.image.corner_radius=8
  background.image.border_color="$TRANSPARENT"
  background.color="$TRANSPARENT"
  icon.padding_left=36
  icon.padding_right=8
  label.align=left
  # label.width=130
  update_freq=10
  label.max_chars=40
  scroll_texts=on
  # --subscribe music mouse.entered
  # mouse.clicked
  # mouse.exited
  # mouse.exited.global
)

sketchybar \
  --add item music right \
  --set music "${music[@]}"
