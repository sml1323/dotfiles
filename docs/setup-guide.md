# Setup Guide — 현재 적용 상태

최종 업데이트: 2026-04-21
베이스: [hendrikmi/dotfiles](https://github.com/hendrikmi/dotfiles)
내 repo: [sml1323/dotfiles](https://github.com/sml1323/dotfiles)
Clone 위치: `~/third-party/hendrikmi-dotfiles/`
백업: `~/dotfiles-backup-20260418/`

---

## 0. 한눈에 보는 상태

| 도구 | 상태 | 비고 |
|------|------|------|
| **Ghostty** | ✅ | 개인 오버라이드 = dark glass (검정 배경 + 투명 + 블러 + copy-on-select 끔) |
| **zsh** | ✅ | plain zsh (oh-my-zsh 버림) + hendrikmi `.zshrc`/`.zshenv` 심링크 + 개인 `custom.zsh`/`aliases.zsh` |
| **starship** | ✅ | hendrikmi config 심링크 |
| **tmux** | ✅ | hendrikmi tmux.conf + TPM + LazyVim에 vim-tmux-navigator 추가 |
| **nvim (hendrikmi)** | ✅ | **default `nvim`**. init.lua/debug.lua 로컬 수정 |
| **nvim (LazyVim)** | ✅ | `nvl` alias로 병행 접근 (전체 보존) |
| **yazi** | ✅ | hendrikmi 설정 심링크 |
| **VSCode** | ✅ | settings/keybindings 심링크 |
| **eza, neofetch, bat, starship** | ✅ | brew 추가 설치 |
| **karabiner** | ❌ 미적용 | Caps Lock → Ctrl 매핑이 한영 전환과 충돌 |
| **rectangle, vim, dbeaver** | ❌ 미적용 | |
| **oh-my-zsh** | ⚠️ | 바이너리는 남음 (`~/.oh-my-zsh`), 참조 안 됨 |
| **Powerlevel10k** | ⚠️ | brew 바이너리 남음, 참조 안 됨 |

---

## 1. Ghostty

### 1-1. 설정 구조
현재 Ghostty는 **Library config에 self-contained**로 설정. XDG 심링크는 **제거됨**.

| 경로 | 내용 |
|------|------|
| `~/Library/Application Support/com.mitchellh.ghostty/config` | 개인 설정 (모든 값 여기) |
| `~/.config/ghostty` | 없음 (제거됨) |

### 1-2. 적용된 값

```
command = zsh --login              # tmux 자동 attach 안 함 (수동)
macos-titlebar-style = transparent # 창 드래그 가능
background = 000000                # 검정
background-opacity = 0.5           # 50% 투명
background-blur = 20               # 블러
copy-on-select = false             # 드래그 선택만으로 복사 안 함
```

이 설정의 소스 파일: [`overrides/ghostty/config`](../overrides/ghostty/config)

### 1-3. 단축키
- `⌘+Shift+,` — config reload
- `⌘T / ⌘N / ⌘W` — 탭 / 창 / 닫기
- 드래그로 선택 후 **`⌘C`로 명시 복사** (자동 복사 비활성)

### 1-4. 롤백
```
cp ~/dotfiles-backup-20260418/ghostty-library-config \
   "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
```

---

## 2. zsh

### 2-1. 구조

| 경로 | 타입 | 내용 |
|------|------|------|
| `~/.zshrc` | 심링크 → hendrikmi | 최소 loader (`custom.zsh` + `aliases.zsh` source만) |
| `~/.zshenv` | 심링크 → hendrikmi | XDG 경로, locale, `EDITOR=nvim`, `NVIM_THEME=nord`, LDFLAGS 등 |
| `~/.config/zsh/git-completion.{bash,zsh}` | 심링크 → hendrikmi | git 완성 |
| `~/.config/zsh/custom.zsh` | **내 사본** (`overrides/zsh/custom.zsh`) | 아래 2-2 |
| `~/.config/zsh/aliases.zsh` | **내 사본** (`overrides/zsh/aliases.zsh`) | 아래 2-3 |

### 2-2. `custom.zsh` — 로드되는 기능 전체

| 섹션 | 내용 |
|------|------|
| **Homebrew** | `eval "$(/opt/homebrew/bin/brew shellenv)"` + `HOMEBREW_NO_AUTO_UPDATE=1` |
| **Ghostty CLI** | `$GHOSTTY_BIN_DIR` PATH 추가 (Ghostty.app의 CLI를 터미널에서) |
| **Python** | ~~pyenv~~ 주석 (사용자 uv 씀) · `~/.local/bin` PATH · `.local/bin/env` source |
| **Starship** | `STARSHIP_CONFIG` + `eval "$(starship init zsh)"` |
| **Git completion** | `zstyle` + `fpath` + `compinit` |
| **Editor** | `MANPAGER='nvim +Man!'` |
| **fzf** | `source <(fzf --zsh)` + Ctrl+T 미리보기(`bat`) + ALT+C = `ç` 매핑 |
| **fzf 함수** | `fd`(디렉토리 fuzzy → cd), `fh`(history fuzzy → run) |
| **zoxide** | `eval "$(zoxide init zsh)"` (`z <dir>`, `zi`) |
| **yazi 래퍼** | `y` 함수 — yazi 나갈 때 CWD 따라옴 |
| **zsh 플러그인** | `zsh-syntax-highlighting` + `zsh-autosuggestions` (brew path) |
| **vi mode** | `bindkey -v` + 커서 모양 (beam=insert, block=normal) + `v`로 edit-command-line |
| **vi yank** | vicmd `y` → `pbcopy` (시스템 클립보드) |
| **nosleep 함수** | 덮개 닫아도 sleep 안 되게 (`sudo pmset` + `caffeinate`) |
| **개인 env vars** | `Antigravity` PATH · x-cmd 로드 · `BUN_INSTALL` + completions |
| **npm global** | 주석 처리 (Node 스택 안 씀) |

### 2-3. `aliases.zsh` — 46개 alias

**시스템**: `c`(clear), `e`(exit), `shutdown`, `restart`

**Git** (30+개):
- `g / ga / gs / gss / gd / gf / gl / gp / gpo`
- `gb / gbr / gco / gcob`
- `gcm / gc / gqc / gqcp` (ticket-id 자동 prefix)
- `gafzf / grfzf / grsfzf / gcofzf` (fzf 통합)
- `glgg` (graph log)

**nvim**: `v` / `vi` (poetry 자동 감지) · **`nvl`** (LazyVim)

**ls (eza)**: `ls` / `ll` / `la` / `lt`

**기타**: `lg`(lazygit) · `y`(yazi) · `doc`($HOME/Documents) · `dow`($HOME/Downloads)

### 2-4. 켜져 있는 주요 동작

| 누르면 | 동작 |
|--------|------|
| `Ctrl+T` | fzf 파일 검색 + bat 미리보기 |
| `Ctrl+R` | fzf history |
| `ç` (Option+C on Mac) | fzf 디렉토리 이동 |
| `Esc` (insert mode) | normal mode |
| `v` (normal mode) | nvim으로 현재 명령줄 편집 |
| `y` (normal mode, 선택 후) | 시스템 클립보드 복사 |

### 2-5. 제거된 것
- **oh-my-zsh** (theme robbyrussell / yarn-docker-node-npm-nvm plugins)
- **Powerlevel10k instant prompt**
- plugins 배열 중복 선언

---

## 3. starship

| 경로 | 타입 |
|------|------|
| `~/.config/starship/starship.toml` | 심링크 → hendrikmi |

`STARSHIP_CONFIG` 환경변수로 이 경로 명시 (custom.zsh). 끄기: custom.zsh에서 starship init 줄 제거.

---

## 4. tmux

| 경로 | 타입 |
|------|------|
| `~/.config/tmux/tmux.conf` | 심링크 → hendrikmi |
| `~/.tmux/plugins/tpm` | TPM clone |

### 4-1. 핵심 설정
- **Prefix = `Ctrl+Space`** (한영 전환 단축키에서 해제 필수)
- **마우스 on** — pane 드래그/클릭/스크롤
- **기본 shell = zsh**
- **status-position = top**
- **true color 지원** + `detach-on-destroy off`
- **base-index = 1** (1번부터 번호 매김)
- **vi mode** for copy
- **Nord 색감 상태바** (hendrikmi 스타일)

### 4-2. 플러그인 (TPM으로 설치)
- `vim-tmux-navigator` — nvim 창 ↔ tmux pane 통합 이동
- `tmux-resurrect` — 세션 저장/복원 (`Prefix+Ctrl+s` / `Prefix+Ctrl+r`)
- `tmux-continuum` — 자동 저장 (15분, 기본 OFF)
- `hendrikmi/tmux-cpu-mem-monitor` — 상태바에 CPU/메모리

### 4-3. 주요 키
전체 목록은 [`keys-cheatsheet.md`](keys-cheatsheet.md) tmux 섹션 참고.

---

## 5. Neovim

### 5-1. 두 환경 병행

| 명령 | nvim |
|------|------|
| `nvim` | **hendrikmi** (default) |
| `nvl` (= `NVIM_APPNAME=nvim-lazyvim nvim`) | LazyVim (격리) |

### 5-2. hendrikmi nvim 경로

| 경로 | 내용 |
|------|------|
| `~/.config/nvim` | 심링크 → hendrikmi repo의 nvim 디렉토리 |
| `~/.local/share/nvim/` | 플러그인 데이터 |
| `~/.local/share/nvim-hendrikmi` | **심링크 → `~/.local/share/nvim`** (하위호환, mason 절대경로 대비) |

### 5-3. hendrikmi repo 로컬 수정 (upstream pull 시 conflict 주의)

- `nvim/init.lua`:
  - `require 'tools.wezterm-img-preview'` → **주석** (Ghostty 사용)
  - `-- require 'plugins.bufferline'` → **주석 해제** (탭바 활성화)
- `nvim/lua/plugins/debug.lua`:
  - `require('dap-python').setup()` → `setup('/Library/Frameworks/Python.framework/Versions/3.12/bin/python3')` (brew Python 3.14에 debugpy 없음)

### 5-4. LazyVim 경로 (보존)

| 경로 | 내용 |
|------|------|
| `~/.config/nvim-lazyvim` | LazyVim config + 커스텀(dap_python, ruff, markdown_safe) + 추가된 `plugins/vim-tmux-navigator.lua` |
| `~/.local/share/nvim-lazyvim` | LazyVim 플러그인 데이터 |

### 5-5. LSP (mason 자동 설치)
`lua_ls`, `pylsp`, `ruff`, `jsonls`, `yamlls`, `sqlls`, `terraformls`, `bashls`, `dockerls`, `docker_compose_language_service`, `html`, `stylua`

### 5-6. 키맵
[`keys-cheatsheet.md`](keys-cheatsheet.md) 참고.

---

## 6. yazi

| 경로 | 타입 |
|------|------|
| `~/.config/yazi` | 심링크 → hendrikmi (`flavors/`, `yazi.toml`, `theme.toml`, `package.toml` 전체) |

이전 사용자 yazi 설정 → `~/dotfiles-backup-20260418/yazi/`로 백업.

터미널에서 `y` (쉘 함수) 또는 `yazi` 실행.

---

## 7. VSCode

| 경로 | 타입 |
|------|------|
| `~/Library/Application Support/Code/User/settings.json` | 심링크 → hendrikmi |
| `~/Library/Application Support/Code/User/keybindings.json` | 심링크 → hendrikmi |

기존 settings.json → `~/dotfiles-backup-20260418/vscode-settings.json.backup`.

---

## 8. 새로 brew로 설치된 CLI

| 도구 | 용도 |
|------|------|
| `eza` | ls 대체 (아이콘/git) |
| `neofetch` | 시스템 정보 |
| `starship` | 프롬프트 |
| `bat` | cat 대체, fzf 미리보기 |
| `screenresolution` | neofetch 의존성 |

기존 설치분과 연동: `fzf`, `zoxide`, `yazi`, `lazygit`, `ripgrep`, `zsh-autosuggestions`, `zsh-syntax-highlighting`

---

## 9. 미도입 (선택)

### karabiner — 적용 안 함
- hendrikmi Karabiner의 **Caps Lock → Ctrl/Esc 매핑**이 **한영 전환(Caps Lock)**과 충돌
- Hyper 키 런처, Rectangle 연동 등 유용한 기능 있지만 사용자 환경에서 비용 > 이득
- 상세: [`sources/hendrikmi.md`](../sources/hendrikmi.md)

### rectangle, vim, dbeaver
사용 안 함. 필요 시 개별 심링크 가능.

---

## 10. 전체 롤백

```bash
# Ghostty
cp ~/dotfiles-backup-20260418/ghostty-library-config \
   "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# zsh
rm ~/.zshrc ~/.zshenv
cp ~/dotfiles-backup-20260418/.zshrc ~/.zshrc
cp ~/dotfiles-backup-20260418/.zshenv ~/.zshenv
rm -rf ~/.config/zsh ~/.config/starship

# nvim (hendrikmi)
rm ~/.config/nvim
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
rm ~/.local/share/nvim-hendrikmi ~/.local/state/nvim-hendrikmi ~/.cache/nvim-hendrikmi

# LazyVim 복귀
mv ~/.config/nvim-lazyvim ~/.config/nvim
mv ~/.local/share/nvim-lazyvim ~/.local/share/nvim
mv ~/.local/state/nvim-lazyvim ~/.local/state/nvim
mv ~/.cache/nvim-lazyvim ~/.cache/nvim

# tmux
rm -rf ~/.config/tmux ~/.tmux/plugins

# yazi
rm ~/.config/yazi
cp -R ~/dotfiles-backup-20260418/yazi ~/.config/yazi

# VSCode
VSC="$HOME/Library/Application Support/Code/User"
rm "$VSC/settings.json" "$VSC/keybindings.json"
cp ~/dotfiles-backup-20260418/vscode-settings.json.backup "$VSC/settings.json"

# hendrikmi repo (선택)
rm -rf ~/third-party/hendrikmi-dotfiles

# 추가 brew 도구 (선택)
brew uninstall eza neofetch starship bat
```

---

## 11. 이 repo 구조

```
~/dotfiles/
├── README.md
├── install.sh              # 새 머신 자동 설치
├── overrides/              # 내 개인 파일 (hendrikmi 위에 덮어쓰기)
│   ├── ghostty/config
│   ├── zsh/{custom.zsh, aliases.zsh}
│   └── nvim-lazyvim/plugins/vim-tmux-navigator.lua
├── sources/                # 차용 출처 기록
├── docs/                   # 이 가이드 + 키 치트시트
└── backgrounds/            # 터미널 배경 이미지
```
