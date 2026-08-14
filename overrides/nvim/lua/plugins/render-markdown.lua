-- 투명 배경(nord_disable_background) 환경에서 표 padding이 회색 반창고처럼 보이는 문제 해결.
-- render-markdown의 TableFill은 기본적으로 Conceal에 링크되는데, nord의 Conceal은
-- bg=#2E3440(불투명)이라 투명한 본문 위에서 혼자 튄다. 해당 그룹들의 bg만 없앤다.
local function clear_fill_bg()
  for _, group in ipairs({
    'Conceal',
    'RenderMarkdownTableFill',
    'RenderMarkdownTableHead',
    'RenderMarkdownTableRow',
  }) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    hl.bg = nil
    hl.ctermbg = nil
    vim.api.nvim_set_hl(0, group, hl)
  end
end

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'markdown' },
  opts = {
    sign = { enabled = false },
    -- heading = { width = 'block' },
    completions = { lsp = { enabled = true } },
    -- LaTeX 렌더 끔. latex2text 외부 프로세스 호출이 느리고 CPU를 먹음.
    latex = { enabled = false },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)
    clear_fill_bg()
    -- 테마를 바꾸면 하이라이트가 초기화되므로 매번 다시 지운다.
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('RenderMarkdownTransparentFill', { clear = true }),
      callback = clear_fill_bg,
    })
  end,
}
