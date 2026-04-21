#!/bin/bash

default=(
  padding_left=1
  padding_right=1
  icon.font="Hack Nerd Font:Bold:17.0"
  label.font="Hack Nerd Font:Bold:14.0"
  icon.color="$ACCENT_COLOR"
  label.color="$ACCENT_COLOR"
  icon.padding_left=2
  icon.padding_right=2
  label.padding_left=2
  label.padding_right=2
  background.color="$ITEM_BG_COLOR"
  background.corner_radius=5
  background.height=24
  background.drawing=off
)

sketchybar --default "${default[@]}"

sketchybar --add event aerospace_workspace_change
sketchybar --add event aerospace_mode_change
sketchybar --add event display_volume_change
