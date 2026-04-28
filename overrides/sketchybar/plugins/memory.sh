#!/bin/bash

PAGE_SIZE=$(vm_stat | head -1 | grep -oE '[0-9]+')
TOTAL=$(sysctl -n hw.memsize)

USED=$(vm_stat | awk -v ps="$PAGE_SIZE" '
  /Pages active/                 { active = $3 + 0 }
  /Pages wired down/             { wired  = $4 + 0 }
  /Pages occupied by compressor/ { comp   = $5 + 0 }
  END                            { print (active + wired + comp) * ps }
')

MEM_PERCENT=$(( USED * 100 / TOTAL ))

sketchybar --set "$NAME" label="${MEM_PERCENT}%"
