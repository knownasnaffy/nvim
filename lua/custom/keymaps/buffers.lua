local map = vim.keymap.set

-- Move to previous/next
local function buffer_switch(direction)
  local count = vim.v.count > 0 and vim.v.count or 1
  vim.cmd((direction == 'next' and 'BufferNext ' or 'BufferPrevious ') .. count)
end

map('n', '<A-.>', function()
  buffer_switch 'next'
end, { desc = 'Go to next buffer' })
map('n', '<A-,>', function()
  buffer_switch 'previous'
end, { desc = 'Go to previous buffer' })

-- Re-order to previous/next
map('n', '<A-S-,>', '<Cmd>BufferMovePrevious<CR>')
map('n', '<A-S-.>', '<Cmd>BufferMoveNext<CR>')

-- Close buffer BufferRestore
-- map('n', '<A-q>', '<Cmd>bd<CR>')

-- Restore buffer
map('n', '<leader>br', '<Cmd>BufferRestore<CR>', { desc = '[R]estore last close buffer' })

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>')

-- Magic buffer-picking mode
map('n', '<leader>bp', '<Cmd>BufferPick<CR>', { desc = 'Magic buffer [P]icker' })
map('n', '<leader>bd', '<Cmd>BufferPickDelete<CR>', { desc = 'Magic buffer [D]eleter' })

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
map('n', '<leader>bqo', '<Cmd>BufferCloseAllButCurrent<CR>', { desc = 'Close [O]ther buffers' })
map('n', '<leader>bqr', '<Cmd>BufferCloseBuffersRight<CR>', { desc = 'Close buffers to the [R]ight' })
map('n', '<leader>bql', '<Cmd>BufferCloseBuffersLeft<CR>', { desc = 'Close buffers to the [L]eft' })

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
map('n', '<A-0>', '<Cmd>BufferLast<CR>')
