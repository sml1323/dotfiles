# hendrikmi — nvim & tmux 키 치트시트

빠른 참조용. 자세한 가이드는 `hendrikmi-setup-guide.md`.

**리더키**: `<space>` (leader) · **tmux prefix**: `Ctrl+Space`

---

## Neovim (기본 `nvim` 명령, hendrikmi)

### 기본 조작

| 목적 | 키 |
|------|----|
| 저장 | `Ctrl+s` |
| 종료 | `Ctrl+q` |
| 모두 종료 | `:qa` / `:qa!` (변경 버리고) |
| 저장 안 하고 파일 다시 열기 | `:e!` |
| 검색 하이라이트 끄기 | `Esc` |
| insert 모드 빠져나오기 | `Esc` 또는 `jk` / `kj` |
| 삭제 (레지스터 거치지 않음) | `x` |
| 시스템 클립보드 복사 | `<space>y` (visual) / `<space>Y` (전체 줄) |
| 붙여넣기 (visual, 복사본 유지) | `p` |

### 파일 / 검색 (Telescope)

| 목적 | 키 |
|------|----|
| 파일 찾기 (fuzzy) | `<space>sf` |
| 전체 grep | `<space>sg` |
| 커서 단어 검색 | `<space>sw` |
| 최근 파일 | `<space>so` |
| 버퍼 목록 | `<space>sb` 또는 `<space><space>` |
| 도움말 검색 | `<space>sh` |
| diagnostics 검색 | `<space>sd` |
| 검색 재개 (이전 쿼리 복원) | `<space>sr` |
| 현재 파일에서 검색 | `<space>/` |
| git 파일 | `<space>gf` |
| git commits | `<space>gc` |
| git branches | `<space>gb` |
| git status (diff) | `<space>gs` |

### 파일 탐색기 (neo-tree)

| 목적 | 키 |
|------|----|
| 왼쪽 사이드바 토글 | `<space>e` |
| float 모드 | `<space>w` |
| git status 뷰 | `<space>ngs` |

**neo-tree 내부에서**:
| 키 | 동작 |
|----|------|
| `a` | 파일/폴더 생성 (끝에 `/` 붙이면 폴더, 중간 경로 자동 생성) |
| `A` | 폴더만 생성 |
| `r` | rename |
| `d` | delete |
| `y` / `x` / `p` | copy / cut / paste |
| `c` / `m` | copy-to / move-to (경로 입력) |
| `Y` | 전체 경로 클립보드 복사 |
| `Enter` / `s` / `S` / `t` | 열기 / 세로분할 / 가로분할 / 새 탭 |
| `H` | 숨김 파일 토글 |
| `R` | refresh |
| `?` | 이 창 전체 키맵 |

### 파일 관리자 (oil.nvim)

| 목적 | 키 |
|------|----|
| 현재 디렉토리 buffer로 열기 | `:Oil` |
| 상위 폴더로 | `-` |
| 편집처럼 파일 추가/삭제/rename | `dd` (삭제), `yy` (복사), 그냥 편집 후 `:w` |

### LSP (language server)

| 목적 | 키 |
|------|----|
| 정의로 이동 (goto definition) | `gd` |
| 참조 찾기 | `gr` |
| 구현으로 이동 | `gI` |
| 타입 정의 | `<space>D` |
| 호버 문서 (hover) | `K` |
| 심볼 이름 바꾸기 | `<space>rn` |
| code action | `<space>ca` |
| 현재 파일 심볼 | `<space>ds` |
| 전체 workspace 심볼 | `<space>ws` |
| 선언으로 (C의 header 같은) | `gD` |
| 이전 위치로 | `Ctrl+o` |
| 다시 앞으로 | `Ctrl+i` |
| 이전/다음 diagnostic | `[d` / `]d` |
| diagnostic 창 열기 | `<space>d` |
| diagnostic 목록 | `<space>q` |
| diagnostic on/off | `<space>do` |
| inlay hints 토글 | `<space>th` |

### 버퍼 / 창 / 탭

| 목적 | 키 |
|------|----|
| 다음/이전 버퍼 | `Tab` / `Shift+Tab` |
| 새 빈 버퍼 | `<space>b` |
| 현재 버퍼 닫기 | `<space>x` |
| 세로 분할 (현재 버퍼) | `<space>v` |
| 가로 분할 (현재 버퍼) | `<space>h` |
| 분할 균등 크기 | `<space>se` |
| **현재 창 닫기** | `<space>xs` or `:q` |
| **창 이동 (nvim↔tmux pane 통합)** | `Ctrl+h/j/k/l` |
| 창 크기 조절 | `↑/↓` (가로 2), `←/→` (세로 2) |
| 새 탭 (vim tab) | `<space>to` |
| 탭 닫기 | `<space>tx` |
| 다음/이전 탭 | `<space>tn` / `<space>tp` |

**참고**: `<space>v` / `<space>h`는 "같은 파일을 두 창에서" 여는 것. **각 창에 다른 파일** 띄우려면 분할 후 포커스 이동 + `<space>sf` 또는 `:e 파일명`.

### 편집 팁

| 목적 | 키 |
|------|----|
| visual 모드 라인 이동 | `Alt+j` / `Alt+k` |
| 들여쓰기 후 선택 유지 | `<` / `>` |
| 커서 단어 교체 후 다음 매치로 | `<space>j` |
| 숫자 +1 / -1 | `<space>+` / `<space>-` |
| 줄 감싸기 토글 | `<space>lw` |

### 디버거 (DAP)

| 목적 | 키 |
|------|----|
| 시작 / 계속 | `F5` |
| step into / over / out | `F1` / `F2` / `F3` |
| breakpoint 토글 | `<space>b` (⚠️ 새 버퍼 키와 충돌 — 디버그 모드에서 breakpoint 우선) |
| 조건부 breakpoint | `<space>B` |
| DAP UI 토글 | `F7` |

### 세션

| 목적 | 키 |
|------|----|
| 현재 세션 저장 | `<space>ss` → `.session.vim` 생성 |
| 세션 로드 | `<space>sl` |

### lazygit / git

| 목적 | 키 |
|------|----|
| lazygit 띄우기 | `<space>lg` |

### plugin 관리

| 명령 | 동작 |
|------|------|
| `:Lazy` | 플러그인 UI |
| `:Lazy sync` | 업데이트/설치 |
| `:Mason` | LSP/formatter 관리 UI |
| `:LspInfo` | 현재 버퍼 LSP 상태 |
| `:LspLog` | LSP 로그 |
| `:checkhealth` | 환경 진단 |

---

## tmux

### prefix + 1회 키

**prefix = `Ctrl+Space`** (Ctrl 누른 채 Space. 떼고 다음 키)

### 세션 / 윈도우 / 페인 개념

```
server (백그라운드 데몬)
  └─ session (로그인, 이름 예: work)
      └─ window (탭 같은 것)
          └─ pane (화면 분할 조각)
```

### 세션 (밖에서 실행)

| 명령 | 동작 |
|------|------|
| `tmux` | 기본 세션 attach 또는 새로 만들기 |
| `tmux new -s work` | 이름 지정해서 새 세션 |
| `tmux ls` | 세션 목록 |
| `tmux a` / `tmux attach -t work` | attach |
| `tmux kill-session -t work` | 특정 세션 종료 |
| `tmux kill-server` | 전체 종료 |

### 세션 (prefix)

| 키 | 동작 |
|----|------|
| `P d` | detach (세션 살리고 빠짐) |
| `P s` | 세션 목록 (tree view) |
| `P $` | 세션 이름 바꾸기 |
| `P (` / `P )` | 이전 / 다음 세션 |

### 윈도우 (탭 같은 것)

| 키 | 동작 |
|----|------|
| `P c` | 새 window (현재 디렉토리) |
| `P 1` ~ `P 9` | 번호로 이동 |
| `P n` / `P p` | 다음 / 이전 |
| `P ,` | window 이름 바꾸기 |
| `P &` | window 닫기 (y 확인) |
| `P w` | window 목록 |
| `P Shift+←` / `P Shift+→` | window 순서 바꾸기 |

### 페인 (현재 window 안에서 분할)

| 키 | 동작 |
|----|------|
| `P \` | 세로 분할 (좌우, 현재 pwd) |
| `P -` | 가로 분할 (상하, 현재 pwd) |
| **`Ctrl+h/j/k/l`** | **pane 이동 (prefix 없음! nvim과 통합)** |
| `P h/j/k/l` | **pane 경계 5만큼 이동** (repeat: `P h h h` 연타) |
| `P m` 또는 `P z` | **zoom 토글** (전체 확대 ↔ 원래 분할 복귀) |
| `P Space` | **레이아웃 프리셋 순환** (정렬 자동 조정) |
| `P { ` / `P }` | 현재 pane을 이전/다음과 위치 교환 |
| `P x` | 현재 pane 닫기 (y 확인) |
| `P !` | 현재 pane을 새 window로 분리 |
| `P q` | pane 번호 잠깐 표시 |
| `P o` | pane 순서대로 포커스 이동 |
| `P ;` | 이전 활성 pane으로 |
| (마우스) | pane 경계 드래그로 크기 조절, 클릭으로 포커스 |

### 복사 모드 (vim 스타일)

| 키 | 동작 |
|----|------|
| `P [` | copy mode 진입 |
| `hjkl` / `w` / `b` 등 | vim 이동 |
| `/ pattern` | 검색 |
| `v` | 선택 시작 |
| `y` | 복사 (시스템 클립보드 pbcopy) |
| `Esc` / `q` | copy mode 나가기 |
| `P P` (대문자) | 복사한 것 붙여넣기 |

### 설정 / 플러그인

| 동작 | 방법 |
|------|------|
| tmux.conf 리로드 | `P r` |
| 플러그인 설치 | `P Shift+i` (대문자 I — TPM) |
| 플러그인 업데이트 | `P Shift+u` |
| 플러그인 제거 | `P Alt+u` |

### 마우스

`mouse on` 활성화됨. 클릭으로 pane 포커스, 드래그로 크기 조절, 휠로 스크롤.

### 상태바 읽는 법 (상단)

**왼쪽**: `세션명 | window목록`
- 현재 window는 cyan+bold, 앞 아이콘, `󰍋` = zoom 상태

**오른쪽**: CPU · 메모리 · 디스크 · 배터리 (tmux-cpu-mem-monitor)

### 자주 쓰는 워크플로 예시

**프로젝트 시작**:
```
tmux new -s celebook
   P \                      # 세로 분할 → 오른쪽에 AI 채팅
   Ctrl+l                   # 오른쪽으로 이동
   claude                   # 거기서 AI 실행
   Ctrl+h                   # 왼쪽 돌아가서 nvim
   nvim
```

**세션 detach → 재진입**:
```
P d                          # 나와서 Ghostty 닫아도 살아있음
...나중에...
tmux a                       # 마지막 세션 복귀
```

**자주 오가는 세션 여럿**:
```
P s                          # 세션 tree에서 골라서 이동
```

---

## LazyVim 비교 (기존 익숙했던 키)

`nvl` 실행하면 기존 LazyVim. 같이 병행 가능.

| LazyVim | hendrikmi |
|---------|----------|
| `<space>ff` | `<space>sf` |
| `<space>fb` | `<space>sb` |
| `<space>fr` | `<space>so` |
| `<space>sg` | `<space>sg` ✅ |
| `<space>gg` (lazygit) | `<space>lg` |
| `<S-l>` / `<S-h>` (buffer) | `<Tab>` / `<S-Tab>` |
| `<space>bd` | `<space>x` |
| `<space>qq` | `Ctrl+q` |

**공통 (변화 없음)**: `gd`, `gr`, `K`, `Ctrl+o`, `[d`, `]d`, `<space>rn`, `<space>ca`

---

## 막힐 때 디버그

| 증상 | 확인 |
|------|------|
| tmux에서 키 안 먹음 | `tmux show -g prefix` (prefix 확인) · Ctrl+Space 한영 해제했나 |
| nvim LSP 안 붙음 | `:LspInfo` · `:Mason`에서 설치 상태 |
| Python dap 실패 | `debug.lua`의 python 경로 확인 |
| `nvh` / `nvl` alias 안 먹음 | `source ~/.zshrc` 또는 새 탭 |
| 창 분할했는데 같은 파일 | 정상. 각 창에서 `<space>sf`로 다른 파일 열기 |

파일: `~/work/research/hendrikmi-keys-cheatsheet.md`
