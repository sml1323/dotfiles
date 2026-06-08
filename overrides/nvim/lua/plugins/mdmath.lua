-- mdmath.nvim — 마크다운 LaTeX 수식을 KaTeX로 렌더해 inline 이미지로 표시.
-- Kitty Graphics Protocol 사용 (Ghostty + tmux allow-passthrough on).
-- 의존성: node, npm, ImageMagick, rsvg-convert, markdown_inline 파서.
return {
  'Thiago4532/mdmath.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'markdown' },
  opts = {
    filetypes = { 'markdown' },
    hide_on_insert = true,
    dynamic = true,
  },
}
