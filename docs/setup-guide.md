# hendrikmi/dotfiles 도입 — 현재 적용 상태

최종 업데이트: 2026-04-20
출처 repo: https://github.com/hendrikmi/dotfiles
Clone 위치: `~/third-party/hendrikmi-dotfiles/` (66MB, 로컬에 init.lua / debug.lua 수정 있음)
백업: `~/dotfiles-backup-20260418/`

---

## 0. 한눈에 보는 상태

| 도구 | 도입 여부 | 비고 |
|------|---------|------|
| **Ghostty** | ✅ | hendrikmi 기반 + 개인 오버라이드 (투명 배경 이미지) |
| **zsh** | ✅ | **완전 교체** (oh-my-zsh 떼고 hendrikmi 스타일 plain zsh) |
| **starship** | ✅ | hendrikmi config 심링크 |
| **nvim (hendrikmi)** | ✅ | **default `nvim`** (2026-04-20 전환). LazyVim은 `nvl` alias로 접근 가능 |
| **tmux** | ✅ | hendrikmi tmux.conf + TPM + LazyVim에 navigator 추가 (2026-04-20) |
| **yazi, lazygit** | ✅ | brew 설치 상태, alias 있음 |
| **eza, neofetch, starship, bat** | ✅ | brew 새로 설치 |
| **oh-my-zsh** | ⚠️ | 바이너리는 남음, .zshrc에서 **참조 안 함** (사실상 비활성) |

---

## 1. Ghostty

### 1-1. 설정 구조
| 경로 | 내용 |
|------|------|
| `~/.config/ghostty` → hendrikmi 심링크 | hendrikmi 기본값 (theme=nord, cursor=bar, font-size=12.5 등) |
| `~/Library/Application Support/com.mitchellh.ghostty/config` | 개인 오버라이드 (self-contained, include 안 씀) |

### 1-2. 개인 오버라이드 내용
```
command = zsh --login                   # tmux 자동 attach 끔
macos-titlebar-style = transparent      # 창 드래그 가능
background-image = /Users/imseungmin/Pictures/terminal-backgrounds/valentin-petrov-gs-02.jpg
background-image-opacity = 0.85
background-image-position = center
background-image-fit = cover
```

### 1-3. 자주 쓰는 단축키
- `⌘ + Shift + ,` — config reload (재시작 없이 적용)
- `⌘ T` / `⌘ N` — 새 탭 / 새 창
- `⌘ W` — 탭 닫기
- 메뉴바 `Ghostty → Reload Configuration`

### 1-4. 설정 수정
Library config 파일 열고 줄 추가/수정:
```
~/Library/Application Support/com.mitchellh.ghostty/config
```
- 이미지 바꾸기: `background-image = /path/to/new.jpg`
- 투명도: `background-image-opacity = 0.5` (낮을수록 흐림)
- 불투명: `background-opacity = 0.8` 추가 (텍스트 배경 투명도)

### 1-5. 롤백
```
cp ~/dotfiles-backup-20260418/ghostty-library-config \
   "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
rm ~/.config/ghostty
```

---

## 2. zsh

### 2-1. 구조
| 경로 | 타입 | 내용 |
|------|------|------|
| `~/.zshrc` | 심링크 → hendrikmi | custom.zsh + aliases.zsh만 source (minimal) |
| `~/.zshenv` | 심링크 → hendrikmi | XDG, locale, EDITOR=nvim, NVIM_THEME=nord, LDFLAGS |
| `~/.config/zsh/custom.zsh` | **내 사본** | hendrikmi 베이스 + pyenv 주석 + 개인 env vars |
| `~/.config/zsh/aliases.zsh` | **내 사본** | hendrikmi git/nvim/eza aliases + nvh alias |
| `~/.config/zsh/git-completion.{bash,zsh}` | 심링크 | git 완성 |

### 2-2. 개인 환경변수 (custom.zsh에 들어있음)
- `~/.local/bin` PATH (uv)
- `~/.local/bin/env` source (uv)
- `~/.antigravity/antigravity/bin` PATH
- x-cmd 로드 (`~/.x-cmd.root/X`)
- `BUN_INSTALL`, Bun PATH, Bun completions
- ~~pyenv~~ (주석 처리됨, 사용자 uv 씀)
- ~~npm-global PATH~~ (주석, Node 스택 안 씀)

### 2-3. 제공되는 46개 alias (일부 발췌)

**시스템**: `c` (clear), `e` (exit), `shutdown`, `restart`

**git** (30+개):
- `g` / `ga` / `gs` / `gss` / `gd` / `gp` / `gpo`
- `gco` / `gcob` / `gcofzf` (fzf로 브랜치 체크아웃)
- `gafzf` / `grfzf` / `grsfzf` — fzf 기반 git add/restore
- `gcm` / `gc` / `gqc` / `gqcp` (ticket-id 자동 prefix 커밋)
- `glgg` (graph log)

**ls 대체**:
- `ls` → `eza --all --icons=always`
- `ll` → `eza -l --icons=always --git`
- `la` → `eza -la --icons=always --git`
- `lt` → `eza -T --icons=always -L 2`

**nvim**:
- `v` / `vi` → `nvim` (poetry 프로젝트면 `poetry run nvim`)
- `nvh` → **`NVIM_APPNAME=nvim-hendrikmi nvim`** (hendrikmi nvim)

**기타**: `lg` (lazygit), `y` (yazi with cwd), `doc` (~/Documents), `dow` (~/Downloads)

### 2-4. 함수
- **fd** — fzf로 디렉토리 선택해서 cd
- **fh** — fzf로 history 검색해서 실행
- **y** — yazi wrapper (나갈 때 CWD 반영)
- **quick_commit** — 브랜치명에서 ticket ID 추출해 커밋
- **nosleep** — 덮개 닫아도 sleep 안 되게

### 2-5. vi mode
`bindkey -v` 켜짐. `Esc`로 normal mode.
- normal mode 커서: `block`
- insert mode 커서: `beam`
- `vicmd`에서 `y` → 시스템 클립보드 복사 (pbcopy)
- `vicmd`에서 `v` → nvim으로 현재 라인 편집

### 2-6. fzf 통합
- `Ctrl+T` — 파일 선택 (bat 미리보기)
- `Ctrl+R` — history
- `ç` (ALT+C on Mac) — 디렉토리 이동

### 2-7. 롤백
```
rm ~/.zshrc ~/.zshenv
cp ~/dotfiles-backup-20260418/.zshrc ~/.zshrc
cp ~/dotfiles-backup-20260418/.zshenv ~/.zshenv
rm -rf ~/.config/zsh ~/.config/starship
```

---

## 3. starship (프롬프트)

| 경로 | 타입 |
|------|------|
| `~/.config/starship/starship.toml` | 심링크 → hendrikmi |
| `STARSHIP_CONFIG` 환경변수 | custom.zsh에서 위 경로로 export |

끄기: custom.zsh에서 `eval "$(starship init zsh)"` 줄 삭제.

설정 수정 원하면 심링크 풀고 사본으로:
```
rm ~/.config/starship/starship.toml
cp ~/third-party/hendrikmi-dotfiles/starship/starship.toml ~/.config/starship/starship.toml
```

---

## 4. Neovim

### 4-1. 두 환경 병행
| 명령 | 실행되는 nvim |
|------|--------------|
| `nvim` | **사용자 LazyVim** (기존 그대로, 건드리지 않음) |
| `nvh` (= `NVIM_APPNAME=nvim-hendrikmi nvim`) | **hendrikmi nvim** (격리 환경) |

### 4-2. LazyVim 위치 (보존됨)
- config: `~/.config/nvim/` (LazyVim/starter 기반, 개인 커스텀)
- plugin data: `~/.local/share/nvim/`
- 커스텀 플러그인: `dap_python`, `ruff`, `markdown_safe`

### 4-3. hendrikmi nvim 위치 (격리)
- config: `~/.config/nvim-hendrikmi` → `~/third-party/hendrikmi-dotfiles/nvim` (심링크)
- plugin data: `~/.local/share/nvim-hendrikmi/`
- 커스텀 수정:
  - `init.lua`: bufferline 주석 해제 (탭바 활성화)
  - `debug.lua`: `dap-python.setup('/Library/Frameworks/Python.framework/Versions/3.12/bin/python3')` — 사용자 Python 3.12 경로 명시

### 4-4. hendrikmi nvim 주요 키 (leader = `<space>`)

**파일 탐색 / 검색**
- `<space>e` — neo-tree (왼쪽 사이드바)
- `<space>w` — neo-tree (float)
- `<space>sf` — 파일 찾기 (fuzzy)
- `<space>sg` — grep
- `<space>so` — 최근 파일
- `<space>sb` / `<space><space>` — 버퍼 목록
- `<space>sw` — 커서 단어 검색

**neo-tree 안에서**
- `a` — 파일/폴더 생성 (끝에 `/`면 폴더)
- `r` — rename, `d` — delete, `y`/`x`/`p` — copy/cut/paste

**버퍼/창**
- `<Tab>` / `<S-Tab>` — 다음/이전 버퍼
- `<space>x` — 버퍼 닫기
- `<space>b` — 새 빈 버퍼 (단, debug 모드에선 breakpoint와 충돌 가능)
- `<space>v` / `<space>h` — 세로/가로 split
- **`Ctrl+h/j/k/l`** — 창 포커스 이동

**LSP**
- `gd` — definition (goto)
- `gr` — references
- `gI` — implementation
- `K` — hover 문서
- `<space>rn` — rename 심볼
- `<space>ca` — code action
- `<space>ds` — document symbols
- `<space>ws` — workspace symbols

**디버그** (DAP)
- `F5` — start/continue
- `F1/F2/F3` — step into/over/out
- `<space>b` — breakpoint 토글
- `<space>B` — 조건부 breakpoint
- `F7` — DAP UI 토글

**편집**
- `jk` / `kj` (insert mode) — Esc 대체
- `<A-j>` / `<A-k>` (visual) — 라인 이동
- `<space>j` — 커서 단어 교체 (next occurrence로 점프하며 편집)
- `<space>y` / `<space>Y` — 시스템 클립보드 복사
- `x` — 레지스터 안 거치고 삭제

**탭(vim tab, bufferline 아님)**
- `<space>to` / `<space>tx` / `<space>tn` / `<space>tp` — open/close/next/prev

**기타**
- `Ctrl+s` — 저장
- `Ctrl+q` — 종료
- `Esc` — 검색 하이라이트 끄기
- `<space>ss` / `<space>sl` — 세션 저장/로드 (`.session.vim`)

### 4-5. 설치된 LSP (mason 자동)
`lua_ls`, `pylsp`, `ruff`, `jsonls`, `yamlls`, `sqlls`, `terraformls`, `bashls`, `dockerls`, `docker_compose_language_service`, `html` + `stylua` (포매터)

설치 장소: `~/.local/share/nvim-hendrikmi/mason/packages/`

관리: `:Mason` / `:LspInfo`

### 4-6. 디버거
- **debugpy** — Python (사용자 Python 3.12 site-packages의 것 사용)
- Go, Rust 등 추가 원하면 `debug.lua`의 `ensure_installed`에 추가

### 4-7. hendrikmi nvim 완전 삭제
```
rm -rf ~/.config/nvim-hendrikmi \
       ~/.local/share/nvim-hendrikmi \
       ~/.local/state/nvim-hendrikmi \
       ~/.cache/nvim-hendrikmi
```

---

## 5. 새로 설치된 CLI (brew)

| 도구 | 용도 |
|------|------|
| `eza` | ls 대체 (아이콘, git 상태) |
| `neofetch` | 시스템 정보 출력 |
| `starship` | 프롬프트 |
| `bat` | cat 대체 (하이라이팅, fzf 미리보기용) |
| `screenresolution` | neofetch 의존성 |

기존 설치된 것 중 연동:
- `fzf`, `zoxide`, `yazi`, `lazygit`, `ripgrep`, `zsh-autosuggestions`, `zsh-syntax-highlighting` (brew)

---

## 6. 아직 미도입 항목 (선택)

### tmux (현재 OFF)
- 바이너리는 brew에 있음
- 수동 실행하면 기본 tmux (prefix = Ctrl+b)
- hendrikmi tmux.conf 적용하면 prefix = `Ctrl+Space`, 상태바, vim-tmux-navigator 등
- ⚠️ 적용 시 한영 전환 단축키 충돌 확인 필요 (`Ctrl+Space` 쓰는지)
- ⚠️ LazyVim은 vim-tmux-navigator 없음 → 창 이동 가로채짐. 플러그인 추가 필요

### zsh 관련 정리 (참조 안 됨, 무해)
- `~/.oh-my-zsh/` 디렉토리
- `powerlevel10k` brew package

제거하려면:
```
rm -rf ~/.oh-my-zsh
brew uninstall powerlevel10k
```

### karabiner-elements, rectangle, yazi config, vim 등
hendrikmi repo에는 있지만 아직 심링크 안 함. 필요하면 개별 심링크 가능.

---

## 7. 전체 롤백

최후의 수단 — hendrikmi 관련 전부 원복:

```bash
# Ghostty
cp ~/dotfiles-backup-20260418/ghostty-library-config \
   "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
rm ~/.config/ghostty

# zsh
rm ~/.zshrc ~/.zshenv
cp ~/dotfiles-backup-20260418/.zshrc ~/.zshrc
cp ~/dotfiles-backup-20260418/.zshenv ~/.zshenv
rm -rf ~/.config/zsh ~/.config/starship

# nvim-hendrikmi
rm -rf ~/.config/nvim-hendrikmi \
       ~/.local/share/nvim-hendrikmi \
       ~/.local/state/nvim-hendrikmi \
       ~/.cache/nvim-hendrikmi

# 설치한 brew 도구 제거 (선택)
brew uninstall eza neofetch starship bat

# hendrikmi repo 자체 삭제 (선택)
rm -rf ~/third-party/hendrikmi-dotfiles
rmdir ~/third-party 2>/dev/null
```

---

## 8. 파일 참조

| 파일 | 용도 |
|------|------|
| `/Users/imseungmin/work/research/task_plan.md` | 작업 계획 |
| `/Users/imseungmin/work/research/findings.md` | repo 분석 |
| `/Users/imseungmin/work/research/progress.md` | 진행 로그 |
| **이 파일** (`hendrikmi-setup-guide.md`) | 최종 설정 가이드 |
