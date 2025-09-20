local map = vim.keymap.set

map('t', '<M-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<M-,>', '<Cmd>1ToggleTerm<CR>', { desc = 'Go to terminal 1' })
map('t', '<M-.>', '<Cmd>2ToggleTerm<CR>', { desc = 'Go to terminal 2' })
