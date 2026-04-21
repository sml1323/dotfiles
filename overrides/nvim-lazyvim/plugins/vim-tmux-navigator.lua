-- Seamless navigation between LazyVim splits and tmux panes
-- Matches hendrikmi tmux.conf's vim-tmux-navigator config so Ctrl+hjkl works
-- across nvim <-> tmux boundaries.
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
  init = function()
    -- When inside a zoomed tmux pane, stay zoomed when moving back to vim
    vim.g.tmux_navigator_preserve_zoom = 1
  end,
}
