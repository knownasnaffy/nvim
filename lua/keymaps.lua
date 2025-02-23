-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set

map('n', '<M-s>', '<Cmd>w<CR>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Undo-tree keymaps
map('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Open [U]ndo Tree' })

-- Git keymaps
require 'custom.keymaps.git'

-- Buffer management keymaps
require 'custom.keymaps.buffers'

-- Terminal mode
require 'custom.keymaps.terminal'

require 'custom.keymaps.movement'

-- Keybinds to make split navigation easier.
require 'custom.keymaps.windows'
