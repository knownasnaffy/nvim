local map = vim.keymap.set

-- Move to previous/next
local function buffer_switch(direction)
  local count = vim.v.count > 0 and vim.v.count or 1
  vim.cmd((direction == 'next' and 'bnext ' or 'bprevious ') .. count)
end

map('n', '<A-.>', function()
  buffer_switch 'next'
end, { desc = 'Go to next buffer' })
map('n', '<A-,>', function()
  buffer_switch 'previous'
end, { desc = 'Go to previous buffer' })

-- Re-order to previous/next
-- map('n', '<A-S-,>', '<Cmd>BufferMovePrevious<CR>')
-- map('n', '<A-S-.>', '<Cmd>BufferMoveNext<CR>')

-- Close buffer
map('n', '<A-q>', '<Cmd>bd<CR>')

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>bf<CR>')
map('n', '<A-0>', '<Cmd>bl<CR>')
