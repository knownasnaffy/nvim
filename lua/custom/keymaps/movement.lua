local map = vim.keymap.set

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Page scroll keys (I hate control key)
map('n', '<M-d>', '<C-d>')
map('n', '<M-f>', '<C-f>')
map('n', '<M-u>', '<C-u>')
map('n', '<M-b>', '<C-b>')

map('n', 'K', '<C-d>', { desc = 'Scroll down half-page' })
map('n', 'L', '<C-u>', { desc = 'Scroll up half-page' })

-- Movement between wrapped lines
map({ 'n', 'v' }, 'k', 'gj', { desc = 'Move down by display line' })
map({ 'n', 'v' }, 'l', 'gk', { desc = 'Move up by display line' })
map('n', '0', 'g0', { desc = 'Move to beginning of display line' })
map('n', '$', 'g$', { desc = 'Move to end of display line' })

map({ 'n', 'v' }, 'j', 'h')
map({ 'n', 'v' }, ';', 'l')
