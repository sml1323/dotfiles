#!/usr/bin/env bash
# rollback-phase13.sh — Phase 13 (Everforest 통일) 원클릭 롤백
#
# 동작:
#   1) ~/dotfiles/.phase13-backup-path 에 기록된 백업 폴더에서 원본 복원
#   2) hendrikmi nvim init.lua 원복
#   3) sketchybar / borders 재시작, Ghostty는 reload 안내
#
# 사용: bash ~/dotfiles/scripts/rollback-phase13.sh

set -euo pipefail

say() { printf "\033[1;36m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m!!\033[0m %s\n" "$*"; }

BACKUP_PATH_FILE="$HOME/dotfiles/.phase13-backup-path"
if [ ! -f "$BACKUP_PATH_FILE" ]; then
  warn "백업 경로 파일 없음: $BACKUP_PATH_FILE"
  exit 1
fi

BACKUP=$(cat "$BACKUP_PATH_FILE")
if [ ! -d "$BACKUP" ]; then
  warn "백업 폴더 없음: $BACKUP"
  exit 1
fi

say "복원 원본: $BACKUP"

# 1) SketchyBar colors.sh
if [ -f "$BACKUP/sketchybar/colors.sh" ]; then
  cp "$BACKUP/sketchybar/colors.sh" ~/.config/sketchybar/colors.sh
  say "restored sketchybar/colors.sh"
fi

# 2) JankyBorders bordersrc
if [ -f "$BACKUP/borders/bordersrc" ]; then
  cp "$BACKUP/borders/bordersrc" ~/.config/borders/bordersrc
  say "restored borders/bordersrc"
fi

# 3) Ghostty config
GHOSTTY_LIB="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
if [ -f "$BACKUP/ghostty/config" ]; then
  cp "$BACKUP/ghostty/config" "$GHOSTTY_LIB"
  say "restored Ghostty Library config"
fi

# 4) hendrikmi nvim init.lua + 추가된 everforest 테마 파일 제거
HENDRIKMI_NVIM="$HOME/third-party/hendrikmi-dotfiles/nvim"
if [ -f "$BACKUP/hendrikmi-nvim/init.lua" ]; then
  cp "$BACKUP/hendrikmi-nvim/init.lua" "$HENDRIKMI_NVIM/init.lua"
  say "restored hendrikmi nvim/init.lua"
fi
EVERFOREST_THEME="$HENDRIKMI_NVIM/lua/plugins/themes/everforest.lua"
if [ -f "$EVERFOREST_THEME" ]; then
  rm "$EVERFOREST_THEME"
  say "removed $EVERFOREST_THEME"
fi

# 5) zsh custom.zsh (NVIM_THEME export 제거용)
if [ -f "$BACKUP/zsh/custom.zsh" ]; then
  cp "$BACKUP/zsh/custom.zsh" ~/.config/zsh/custom.zsh
  # dotfiles overrides도 같이 원복
  cp "$BACKUP/zsh/custom.zsh" ~/dotfiles/overrides/zsh/custom.zsh
  say "restored zsh/custom.zsh (NVIM_THEME 제거됨)"
fi

# 6) 서비스 재시작
say "sketchybar --reload"
sketchybar --reload 2>/dev/null || true

say "brew services restart borders"
brew services restart felixkratz/formulae/borders 2>/dev/null || true

cat <<EOF

\033[1;32m✓ 롤백 완료\033[0m

남은 수동 작업:
  1. Ghostty: ⌘+Shift+, 로 config reload (또는 재시작)
  2. 새 셸 탭 열기 (zsh custom.zsh 다시 로드, NVIM_THEME 해제)
  3. nvim 실행 → Nord 테마 복귀 확인
  4. dotfiles repo의 Phase 13 커밋이 남아있으면:
       cd ~/dotfiles && git log --oneline
       git reset --hard <pre-phase13-sha>
       git push --force-with-lease   # (원격에도 이미 push된 경우만)
EOF
