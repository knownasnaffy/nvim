local map = vim.keymap.set

map('n', '<M-s>', '<Esc><Cmd>w<CR>a')
map('n', '<M-r>', '<C-r>')

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

require 'vscode-custom.keymaps.movement'
require 'vscode-custom.keymaps.window'
