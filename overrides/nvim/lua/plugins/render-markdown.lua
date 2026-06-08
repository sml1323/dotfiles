return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'markdown' },
  opts = {
    sign = { enabled = false },
    -- heading = { width = 'block' },
    completions = { lsp = { enabled = true } },
    -- LaTeX은 mdmath.nvim이 이미지로 렌더하므로 텍스트 변환은 끔 (중복 방지).
    -- mdmath가 안 되는 환경이면 이 줄을 지워 latex2text 텍스트 렌더로 fallback.
    latex = { enabled = false },
  },
}
