-- Allow cursor to move one position past end of line in normal mode.
-- Default vim behavior pins cursor on the last char ($ stops one short),
-- which feels off compared to LazyVim/VSCode. `onemore` is the conservative fix.
vim.opt.virtualedit = 'onemore'
