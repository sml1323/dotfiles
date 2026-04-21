# macOS Ricing — AeroSpace · SketchyBar · JankyBorders 치트시트

빠른 참조용. 설치 기록은 `task_plan.md` 참조.

**AeroSpace 기준**: modifier = `Alt` (Option)

---

## AeroSpace — 타일링 WM

### 워크스페이스 이동

| 키 | 동작 |
|----|------|
| `Alt+q` | 워크스페이스 1 |
| `Alt+w` | 워크스페이스 2 |
| `Alt+e` | 워크스페이스 3 |
| `Alt+r` | 워크스페이스 4 |
| `Alt+t` | 워크스페이스 5 |
| `Alt+y` | 워크스페이스 6 |
| `Alt+7` | 워크스페이스 7 (`Alt+u`는 macOS 데드키 충돌로 대체) |
| `Alt+i` | 워크스페이스 8 |
| `Alt+o` | 워크스페이스 9 |

### 창 이동 (현재 창 → 워크스페이스)

| 키 | 동작 |
|----|------|
| `Alt+Shift+q` ~ `Alt+Shift+o` | 현재 창을 각 워크스페이스로 이동 |

### 포커스 이동

| 키 | 동작 |
|----|------|
| `Alt+h/j/k/l` | 좌/하/상/우 창으로 포커스 (모니터 경계 통과) |
| `Alt+Shift+h/j/k/l` | 현재 창을 좌/하/상/우로 이동 (모니터 경계 통과) |
| `Alt+Shift+m` | 현재 워크스페이스를 다른 모니터로 이동 |

### 멀티 모니터 워크스페이스 배분

| 워크스페이스 | 키 | 모니터 |
|------------|-----|--------|
| 1~5 | `Alt+q/w/e/r/t` | 맥북 (main) |
| 6~9 | `Alt+y/7/i/o` | 외부 모니터 (없으면 맥북으로 폴백) |

- 포커스 이동 시 마우스 커서도 해당 모니터로 자동 이동 (`on-focused-monitor-changed`)

### 레이아웃 / 크기

| 키 | 동작 |
|----|------|
| `Alt+/` | 분할 방향 전환 (수평↔수직) |
| `Alt+,` | accordion 레이아웃 |
| `Alt+Shift+minus` | 창을 floating으로 전환 |
| `Alt+Shift+=` | 창을 tiling으로 전환 |
| `Alt+Shift+f` | 전체화면 토글 |
| `Alt+Shift+r` | AeroSpace 레이아웃 리셋 |
| `Alt+r` + hjkl | resize 모드 진입 후 크기 조절 |

### 앱 자동 배치 (on-window-detected)

| 앱 | 워크스페이스 |
|----|------------|
| Ghostty | 2 |
| Chrome / Safari / Arc | 3 |
| Slack / WhatsApp / Telegram | 4 |
| Obsidian / Notion | 5 |
| Cron | 1 |

### 기타

| 키 | 동작 |
|----|------|
| `Alt+Shift+q` | AeroSpace 종료 |
| `Alt+Shift+c` | config 리로드 |

---

## SketchyBar — 상단 상태바

### 아이템 구성 (왼쪽 → 오른쪽)

```
[workspaces] | [front_app]          [music]  [wifi] [battery] [volume] [date]
```

### 인터랙션

| 아이템 | 좌클릭 | 우클릭 | 중간클릭 |
|--------|--------|--------|---------|
| music | 재생/일시정지 | 다음 곡 | YouTube Music 앱 열기 |
| wifi | System Settings WiFi 패널 열기 | — | — |
| 워크스페이스 | 해당 workspace로 이동 | — | — |

### 설정 파일

| 파일 | 역할 |
|------|------|
| `~/.config/sketchybar/sketchybarrc` | 메인 진입점, 아이템 활성화 |
| `~/.config/sketchybar/bar.sh` | 바 스타일 (높이, 위치, 색상) |
| `~/.config/sketchybar/defaults.sh` | 전체 기본값 (폰트, 패딩, 색상) |
| `~/.config/sketchybar/colors.sh` | 색상 팔레트 |
| `~/.config/sketchybar/items/` | 각 아이템 정의 |
| `~/.config/sketchybar/plugins/` | 아이템 갱신 스크립트 |

### 관리 명령

```bash
brew services restart sketchybar   # 재시작
brew services stop sketchybar      # 중지
sketchybar --query <item>          # 아이템 현재 상태 확인
sketchybar --reload                # 설정 리로드 (재시작 없이)
```

### YouTube Music API 서버 설정

- 앱: th-ch/youtube-music (GitHub 릴리즈에서 DMG 설치)
- 확장 → API 서버 [베타] → 활성화
- 인증 정책: **인증 없음**
- 포트: `26538`

---

## JankyBorders — 창 테두리 하이라이트

활성 창에 글로우 테두리, 비활성 창에 어두운 테두리 표시.

### 설정 파일

`~/.config/borders/bordersrc`

```bash
options=(
  style=round
  width=5.0
  hidpi=on
  "active_color=glow(0xaa80a8fc)"   # 파란 글로우
  inactive_color=0x44414550
  background_color=0x00000000
)
borders "${options[@]}"
```

**주의**: `glow()` 구문은 반드시 따옴표로 감싸야 함. 안 하면 bash syntax error.

### 관리 명령

```bash
brew services restart felixkratz/formulae/borders
brew services stop felixkratz/formulae/borders
```

---

## 전체 서비스 상태 확인

```bash
brew services list | grep -E "sketchybar|borders|aerospace"
```

---

## 롤백

| 도구 | 명령 |
|------|------|
| SketchyBar | `brew services stop sketchybar && brew uninstall sketchybar` |
| JankyBorders | `brew services stop felixkratz/formulae/borders && brew uninstall borders` |
| AeroSpace | `brew uninstall --cask aerospace && rm -rf ~/.config/aerospace` |
| macOS 메뉴바 복구 | `defaults write NSGlobalDomain _HIHideMenuBar -bool false && killall SystemUIServer` |

파일: `~/dotfiles/docs/ricing-cheatsheet.md`
