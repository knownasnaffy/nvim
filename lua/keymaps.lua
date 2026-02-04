-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set

map('i', '<M-s>', '<Esc><Cmd>w<CR>a')
map('n', '<M-r>', '<C-r>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<M-h>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Utility keymaps
map('n', 'vad', 'ggVG', { desc = '[V]isual [A]round [D]ocument' })
map('n', 'g;', function()
  local url = vim.fn.expand '<cfile>'
  if url ~= '' then vim.fn.jobstart({ 'xdg-open', url }, { detach = true }) end
end, { desc = 'Open stuff under cursor' })

-- Git keymaps
require 'custom.keymaps.git'

-- Buffer management keymaps
require 'custom.keymaps.buffers'

-- Terminal mode
require 'custom.keymaps.terminal'

require 'custom.keymaps.movement'

-- Keybinds to make split navigation easier.
require 'custom.keymaps.windows'
