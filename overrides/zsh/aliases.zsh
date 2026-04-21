# ~/.config/zsh/aliases.zsh
# Started as a copy of hendrikmi's aliases.zsh.

# ============================================================
# System
# ============================================================
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias c='clear'
alias e='exit'

# ============================================================
# Git
# ============================================================
alias g='git'
alias ga='git add'
alias gafzf='git ls-files -m -o --exclude-standard | grep -v "__pycache__" | fzf -m --print0 | xargs -0 -o -t git add'
alias grmfzf='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git rm'
alias grfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore'
alias grsfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore --staged'
alias gf='git fetch'
alias gs='git status'
alias gss='git status -s'
alias gup='git fetch && git rebase'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias glo='git pull origin'
alias gl='git pull'
alias gb='git branch '
alias gbr='git branch -r'
alias gd='git diff'
alias gco='git checkout '
alias gcob='git checkout -b '
alias gcofzf='git branch | fzf | xargs git checkout'
alias gre='git remote'
alias gres='git remote show'
alias glgg='git log --graph --max-count=5 --decorate --pretty="oneline"'
alias gm='git merge'
alias gp='git push'
alias gpo='git push origin'
alias gc='git commit -v'
alias gcm='git commit -m'

# Ticketed quick-commit (branch name의 앞 2 토큰을 ticket ID로)
quick_commit() {
  local branch_name ticket_id commit_message push_flag
  branch_name=$(git branch --show-current)
  ticket_id=$(echo "$branch_name" | awk -F '-' '{print toupper($1"-"$2)}')
  commit_message="$ticket_id: $*"
  push_flag=$1

  if [[ "$push_flag" == "push" ]]; then
    commit_message="$ticket_id: ${*:2}"
    git commit --no-verify -m "$commit_message" && git push
  else
    git commit --no-verify -m "$commit_message"
  fi
}
alias gqc='quick_commit'
alias gqcp='quick_commit push'

# ============================================================
# Neovim (poetry 환경에서 실행 시 poetry run nvim)
# ============================================================
poetry_run_nvim() {
  if command -v poetry >/dev/null 2>&1 && [ -f "poetry.lock" ]; then
    poetry run nvim "$@"
  else
    nvim "$@"
  fi
}
alias vi='poetry_run_nvim'
alias v='poetry_run_nvim'

# hendrikmi는 이제 default `nvim`. LazyVim은 격리 실행.
alias nvl='NVIM_APPNAME=nvim-lazyvim nvim'

# ============================================================
# Folders
# ============================================================
alias doc="$HOME/Documents"
alias dow="$HOME/Downloads"

# ============================================================
# Ranger (ranger 설치 안 함 — 주석)
# ============================================================
# alias r=". ranger"

# ============================================================
# ls 대체 (eza)
# ============================================================
alias ls="eza --all --icons=always"
alias ll="eza -l --icons=always --git"
alias la="eza -la --icons=always --git"
alias lt="eza -T --icons=always -L 2"

# ============================================================
# Lazygit
# ============================================================
alias lg="lazygit"
