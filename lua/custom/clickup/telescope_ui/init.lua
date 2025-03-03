local M = {}

M.select_workspace = require 'custom.clickup.telescope_ui.workspace'
M.select_space = require 'custom.clickup.telescope_ui.space'
M.select_list = require 'custom.clickup.telescope_ui.list'

vim.keymap.set('n', '<Leader>ns', M.select_workspace, { desc = 'Show ClickUp Popup' })

return M
