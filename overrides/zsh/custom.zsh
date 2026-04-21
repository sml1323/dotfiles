# ~/.config/zsh/custom.zsh
# Started as a copy of hendrikmi's custom.zsh, with personal overrides.
# hendrikmi 원본: ~/third-party/hendrikmi-dotfiles/zsh/custom.zsh

# ============================================================
# Homebrew (PATH 설정 — 반드시 맨 위)
# ============================================================
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1

# ============================================================
# Ghostty CLI on PATH
# ============================================================
export GHOSTTY_BIN_DIR="/Applications/Ghostty.app/Contents/MacOS"
export PATH="$GHOSTTY_BIN_DIR:$PATH"

# ============================================================
# Python — uv 사용 (pyenv 안 씀, hendrikmi 원본의 pyenv 섹션은 주석)
# ============================================================
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# uv가 /Users/imseungmin/.local/bin에 설치됨
export PATH="$HOME/.local/bin:$PATH"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# ============================================================
# Starship prompt
# ============================================================
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
# starship config palette $STARSHIP_THEME  # .zshenv의 STARSHIP_THEME 변수로 팔레트 선택

# ============================================================
# Git completion
# ============================================================
zstyle ':completion:*:*:git:*' script $HOME/.config/zsh/git-completion.bash
fpath=($HOME/.config/zsh $fpath)
autoload -Uz compinit && compinit

# ============================================================
# Neovim as MANPAGER
# ============================================================
export MANPAGER='nvim +Man!'

# ============================================================
# fzf — keybindings + fuzzy completion
# ============================================================
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

bindkey "ç" fzf-cd-widget  # ALT+C on Mac

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - fuzzy history search & execute
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# ============================================================
# zoxide (better cd)
# ============================================================
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ============================================================
# yazi — directory-change-aware wrapper
# ============================================================
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ============================================================
# zsh 플러그인 (brew로 설치)
# ============================================================
if [[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  (( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
  ZSH_HIGHLIGHT_STYLES[path]=none
  ZSH_HIGHLIGHT_STYLES[path_prefix]=none
fi

if [[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ============================================================
# Vi mode (hendrikmi 원본과 동일)
# ============================================================
bindkey -v
export KEYTIMEOUT=1
export VI_MODE_SET_CURSOR=true

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[2 q'
  else
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
  zle -K viins
  echo -ne '\e[6 q'
}
zle -N zle-line-init
echo -ne '\e[6 q'

function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | pbcopy -i
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# ============================================================
# nosleep — 덮개 닫아도 sleep 안 되게
# ============================================================
nosleep() {
  sudo pmset -a disablesleep 1
  caffeinate -si &
  local pid=$!
  trap "kill $pid 2>/dev/null; sudo pmset -a disablesleep 0; trap - INT" INT
  wait $pid
  sudo pmset -a disablesleep 0
}

# ============================================================
# === 사용자 개인 환경변수 (마이그레이션 from old .zshrc) ===
# ============================================================

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# x-cmd (대형 shell framework — 느리면 주석 처리)
[ -f "$HOME/.x-cmd.root/X" ] && . "$HOME/.x-cmd.root/X"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# npm global (Node/JS 스택 안 쓰므로 주석 — 필요하면 풀기)
# export PATH="$HOME/.npm-global/bin:$PATH"
