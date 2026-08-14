-- 표 정렬과 wrap은 원리상 같이 못 산다.
-- render-markdown은 "표의 한 행 = 화면의 한 줄"을 전제로 세로선 위치를 계산하는데,
-- wrap이 긴 행을 접어버리면 정렬이 무너진다.
-- 그래도 실제로 읽는 건 대부분 긴 문단이라 wrap 기본 on. 표 볼 땐 <leader>uw 로 끈다.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

vim.keymap.set('n', '<leader>uw', function()
  vim.opt_local.wrap = not vim.opt_local.wrap:get()
  vim.notify('wrap ' .. (vim.opt_local.wrap:get() and 'on' or 'off'))
end, { buffer = true, desc = 'Toggle wrap' })
