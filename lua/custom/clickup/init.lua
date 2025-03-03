local M = {}

M.select_workspace = require('custom.clickup.telescope_ui').select_workspace

vim.keymap.set('n', '<Leader>ns', M.select_workspace, { desc = 'Show ClickUp Popup' })

return M
