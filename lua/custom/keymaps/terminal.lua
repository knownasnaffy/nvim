local map = vim.keymap.set

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<M-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<M-j>', '<Down>')
map('t', '<M-k>', '<Up>')
map('t', '<M-h>', '<Left>')
map('t', '<M-l>', '<Right>')
map('t', '<M-w><M-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })
map('t', '<M-w><M-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
map('t', '<M-w><M-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })
map('t', '<M-w><M-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
