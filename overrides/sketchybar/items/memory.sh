#!/bin/bash

sketchybar --add item memory right \
  --set memory update_freq=5 \
               icon=􀫦 \
               padding_left=0 \
               script="$PLUGIN_DIR/memory.sh"
