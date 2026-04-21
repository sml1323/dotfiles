#!/usr/bin/env bash
# install.sh — sml1323 dotfiles 설치 스크립트
# 새 macOS 머신에서 dotfiles 전체 세팅을 복원.
#
# 동작:
#   1) hendrikmi/dotfiles를 ~/third-party/hendrikmi-dotfiles 로 clone
#   2) hendrikmi 원본을 심링크 (zsh, tmux, starship, nvim, yazi, vscode)
#   3) overrides/ 의 개인 파일을 해당 경로로 복사 (hendrikmi 위에 덮어씀)
#   4) TPM clone, brew 필수 도구 확인
#
# 주의: 기존 config가 있으면 덮어씀 — 실행 전 백업 권장.

set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
HENDRIKMI="$HOME/third-party/hendrikmi-dotfiles"
BACKUP="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

say() { printf "\033[1;36m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m!!\033[0m %s\n" "$*"; }

# -----------------------------------------------------------------------------
# 0. 사전 확인
# -----------------------------------------------------------------------------
command -v brew >/dev/null || {
  warn "Homebrew 없음. 먼저 설치: https://brew.sh"
  exit 1
}

# -----------------------------------------------------------------------------
# 1. 백업
# -----------------------------------------------------------------------------
say "기존 설정 백업 → $BACKUP"
mkdir -p "$BACKUP"
for f in ~/.zshrc ~/.zshenv ~/.gitconfig; do
  [ -e "$f" ] && cp "$f" "$BACKUP/" 2>/dev/null || true
done
[ -d ~/.config/ghostty ] && cp -R ~/.config/ghostty "$BACKUP/ghostty" 2>/dev/null || true
[ -d ~/.config/nvim ] && cp -R ~/.config/nvim "$BACKUP/nvim" 2>/dev/null || true
LIB_CONFIG="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
[ -e "$LIB_CONFIG" ] && cp "$LIB_CONFIG" "$BACKUP/ghostty-library-config" 2>/dev/null || true

# -----------------------------------------------------------------------------
# 2. hendrikmi clone
# -----------------------------------------------------------------------------
if [ ! -d "$HENDRIKMI" ]; then
  say "hendrikmi/dotfiles clone → $HENDRIKMI"
  mkdir -p "$(dirname "$HENDRIKMI")"
  git clone https://github.com/hendrikmi/dotfiles.git "$HENDRIKMI"
else
  say "hendrikmi 이미 clone됨: $HENDRIKMI"
fi

# -----------------------------------------------------------------------------
# 3. brew 설치
# -----------------------------------------------------------------------------
say "필수 brew 도구 설치"
for pkg in starship eza neofetch bat tmux fzf zoxide yazi lazygit ripgrep zsh-autosuggestions zsh-syntax-highlighting; do
  brew list "$pkg" >/dev/null 2>&1 || brew install "$pkg"
done

# -----------------------------------------------------------------------------
# 4. TPM
# -----------------------------------------------------------------------------
[ -d ~/.tmux/plugins/tpm ] || {
  say "TPM clone"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# -----------------------------------------------------------------------------
# 5. 심링크 (hendrikmi 원본)
# -----------------------------------------------------------------------------
say "hendrikmi 심링크"
mkdir -p ~/.config/zsh ~/.config/tmux ~/.config/starship

ln -sfn "$HENDRIKMI/zsh/.zshrc"                ~/.zshrc
ln -sfn "$HENDRIKMI/zsh/.zshenv"               ~/.zshenv
ln -sfn "$HENDRIKMI/zsh/git-completion.bash"   ~/.config/zsh/git-completion.bash
ln -sfn "$HENDRIKMI/zsh/git-completion.zsh"    ~/.config/zsh/git-completion.zsh
ln -sfn "$HENDRIKMI/starship/starship.toml"    ~/.config/starship/starship.toml
ln -sfn "$HENDRIKMI/tmux/tmux.conf"            ~/.config/tmux/tmux.conf
ln -sfn "$HENDRIKMI/nvim"                      ~/.config/nvim
ln -sfn "$HENDRIKMI/yazi"                      ~/.config/yazi

VSC="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSC"
ln -sfn "$HENDRIKMI/vscode/settings.json"     "$VSC/settings.json"
ln -sfn "$HENDRIKMI/vscode/keybindings.json"  "$VSC/keybindings.json"

# -----------------------------------------------------------------------------
# 6. 개인 오버라이드 (overrides/)
# -----------------------------------------------------------------------------
say "개인 오버라이드 적용"

# Ghostty — Library 경로에 덮어쓰기 (XDG는 hendrikmi XDG가 아니라 비움)
mkdir -p "$(dirname "$LIB_CONFIG")"
cp "$DOTFILES/overrides/ghostty/config" "$LIB_CONFIG"

# XDG Ghostty 심링크는 제거 (Library config가 모든 걸 관리)
rm -f ~/.config/ghostty 2>/dev/null || true

# zsh 개인 사본
cp "$DOTFILES/overrides/zsh/custom.zsh"    ~/.config/zsh/custom.zsh
cp "$DOTFILES/overrides/zsh/aliases.zsh"   ~/.config/zsh/aliases.zsh

# LazyVim 플러그인 (LazyVim 환경이 있을 때만 복사)
if [ -d ~/.config/nvim-lazyvim ]; then
  mkdir -p ~/.config/nvim-lazyvim/lua/plugins
  cp "$DOTFILES/overrides/nvim-lazyvim/plugins/vim-tmux-navigator.lua" \
     ~/.config/nvim-lazyvim/lua/plugins/vim-tmux-navigator.lua
fi

# -----------------------------------------------------------------------------
# 7. hendrikmi 로컬 수정 (repo clone 안의 파일 손대기)
# -----------------------------------------------------------------------------
say "hendrikmi nvim 로컬 수정 (wezterm off, bufferline on, dap-python 경로)"

# wezterm-img-preview 비활성
sed -i '' "s|^require 'tools.wezterm-img-preview'|-- require 'tools.wezterm-img-preview'|g" \
  "$HENDRIKMI/nvim/init.lua" 2>/dev/null || true

# bufferline 활성화
sed -i '' "s|^  -- require 'plugins.bufferline',|  require 'plugins.bufferline',|g" \
  "$HENDRIKMI/nvim/init.lua" 2>/dev/null || true

# dap-python Python 경로 명시 (Python 3.12 기준)
PYTHON_PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin/python3"
if [ -x "$PYTHON_PATH" ]; then
  sed -i '' "s|^    require('dap-python').setup()|    require('dap-python').setup('$PYTHON_PATH')|g" \
    "$HENDRIKMI/nvim/lua/plugins/debug.lua" 2>/dev/null || true
fi

# -----------------------------------------------------------------------------
# 8. 완료
# -----------------------------------------------------------------------------
cat <<EOF

\033[1;32m✓ 설치 완료\033[0m

다음 단계:
  1. 터미널 재시작 (또는 새 탭)
  2. tmux 진입 후 Prefix(Ctrl+Space) + Shift+I → TPM 플러그인 설치
  3. Ghostty: ⌘+Shift+, 로 config reload
  4. nvim 실행 → lazy.nvim이 플러그인 자동 설치
  5. :Mason → LSP 설치 진행 확인

백업: $BACKUP
자세한 가이드: $DOTFILES/docs/setup-guide.md
EOF
