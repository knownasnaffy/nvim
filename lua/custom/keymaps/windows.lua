local map = vim.keymap.set

--  See `:help wincmd` for a list of all window commands
map('n', '<leader>wh', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<leader>wl', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<leader>wj', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<leader>wk', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<leader>wq', '<C-w>q', { desc = 'Close current window window' })
