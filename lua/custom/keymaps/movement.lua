local map = vim.keymap.set

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Page scroll keys (I hate control key)
map({ 'n', 'x' }, '<M-d>', '<C-d>')
map({ 'n', 'x' }, '<M-f>', '<C-f>')
map({ 'n', 'x' }, '<M-u>', '<C-u>')
map({ 'n', 'x' }, '<M-b>', '<C-b>')

map({ 'n', 'x' }, 'K', '<C-d>', { desc = 'Scroll down half-page' })
map({ 'n', 'x' }, 'L', '<C-u>', { desc = 'Scroll up half-page' })
map({ 'n', 'x' }, '<leader>j', '^', { desc = 'Move to the first non-blank character in the line' })
map({ 'n', 'x' }, '<leader>;', '$', { desc = 'Move to the last character in the line' })

-- Movement between wrapped lines
map({ 'n', 'x', 'o' }, 'k', 'gj', { desc = 'Move down by display line' })
map({ 'n', 'x', 'o' }, 'l', 'gk', { desc = 'Move up by display line' })
map({ 'n', 'x', 'o' }, 'j', 'h')
map({ 'n', 'x', 'o' }, ';', 'l')
map('n', '0', 'g0', { desc = 'Move to beginning of display line' })
map('n', '$', 'g$', { desc = 'Move to end of display line' })

-- Next and previous options
map({ 'n', 'x', 'i' }, '<A-n>', '<C-n>')
map({ 'n', 'x', 'i' }, '<A-p>', '<C-p>')

-- Exiting visual and insert mode
map({ 'v', 'i' }, '<A-q>', '<Esc>')

-- Movement in insert and command-line mode
map({ 'c' }, '<A-q>', '<C-u><Esc>')
map({ 'c', 'i' }, '<A-w>', '<C-w>')
map({ 'c', 'i' }, '<A-d>', '<C-Del>')
map({ 'c', 'i' }, '<A-j>', '<Left>')
map({ 'c', 'i' }, '<A-k>', '<Down>')
map({ 'c', 'i' }, '<A-l>', '<Up>')
map({ 'c', 'i' }, '<A-;>', '<Right>')

-- Navigation in history
map({ 'n' }, '<A-o>', '<C-o>')
map({ 'n' }, '<A-i>', '<C-i>')
