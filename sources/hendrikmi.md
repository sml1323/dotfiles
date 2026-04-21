# Source: hendrikmi/dotfiles

- URL: https://github.com/hendrikmi/dotfiles
- Clone 위치: `~/third-party/hendrikmi-dotfiles/`
- 도입 시점: 2026-04-17 ~ 2026-04-20

## 차용한 부분

| 항목 | 방식 | 심링크 경로 |
|------|------|------------|
| zsh (.zshrc, .zshenv) | 심링크 | `~/.zshrc`, `~/.zshenv` |
| zsh git-completion | 심링크 | `~/.config/zsh/git-completion.{bash,zsh}` |
| starship config | 심링크 | `~/.config/starship/starship.toml` |
| tmux config | 심링크 | `~/.config/tmux/tmux.conf` |
| nvim (전체) | 심링크 (default) | `~/.config/nvim` |
| yazi config | 심링크 | `~/.config/yazi` |
| VSCode settings/keybindings | 심링크 | `Code/User/*.json` |
| Ghostty config | ~~심링크~~ 제거, 개인 오버라이드만 사용 | `~/.config/ghostty` |
| karabiner | **미도입** (한영 Caps Lock 충돌) | — |
| rectangle, vim, dbeaver | 미도입 | — |

## 로컬 수정 (hendrikmi clone 안의 파일 변경)

하위호환을 위해 **hendrikmi repo 자체를 수정**한 부분 (upstream pull 시 conflict 주의):

- `nvim/init.lua`:
  - `require 'tools.wezterm-img-preview'` → **주석 처리** (Ghostty 씀, wezterm CLI 없음)
  - `-- require 'plugins.bufferline'` → **주석 해제** (탭바 활성화)
- `nvim/lua/plugins/debug.lua`:
  - `require('dap-python').setup()` → `setup('/Library/Frameworks/Python.framework/Versions/3.12/bin/python3')` 로 수정 (brew python 3.14에 debugpy 없어서)

## 원복 방법

```bash
cd ~/third-party/hendrikmi-dotfiles
git checkout nvim/init.lua nvim/lua/plugins/debug.lua
```

## 미사용/버린 기능

- **oh-my-zsh**: hendrikmi 스타일에 맞춰 plain zsh로 마이그레이션 (기존 oh-my-zsh + Powerlevel10k 중복 충돌)
- **pyenv**: `custom.zsh`에서 주석 처리 (사용자 uv 씀)
- **Node plugins (npm, yarn, nvm 등)**: 사용자 Node 스택 안 씀

## 라이선스

hendrikmi repo의 라이선스 따름 (저장소 확인: https://github.com/hendrikmi/dotfiles).
