# Source: hendriknielaender/.dotfiles

- URL: https://github.com/hendriknielaender/.dotfiles
- 도입 시점: 2026-04-20 (Ghostty 스타일만 참고)

## 차용한 부분

**Ghostty config에서 `background-opacity` + `background-blur` 조합 아이디어만 가져옴**:

```
background = 000000
background-opacity = 0.5    # hendriknielaender 원본은 0.2 (더 투명)
background-blur = 20
```

→ `overrides/ghostty/config`에 반영.

## 차용 안 한 부분

- `theme = stardust` (커스텀 테마, 패키지 필요)
- `font-family = "FiraMono Nerd Font"`, `font-size = 20` (개인 취향)
- `macos-titlebar-style = tabs` (우린 `transparent` 쓰는 중)
- `keybind = ctrl+h=goto_split:left` 등 Ghostty native split 이동 — **tmux/nvim의 Ctrl+hjkl과 충돌**이라 의도적으로 제외
- `keybind = cmd+h/l = previous/next_tab` — macOS 기본 ⌘1/⌘2 사용 중
- `shift+enter=text:\n` — 일시 적용했다가 Claude Code에서 무반응으로 제거

## 라이선스

해당 repo의 라이선스 따름 (저장소 확인).
