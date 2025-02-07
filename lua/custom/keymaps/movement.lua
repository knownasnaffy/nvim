local map = vim.keymap.set

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Page scroll keys (I hate control key)
map('n', '<M-d>', '<C-d>')
map('n', '<M-f>', '<C-f>')
map('n', '<M-u>', '<C-u>')
map('n', '<M-b>', '<C-b>')
