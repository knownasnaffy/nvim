local M = {}

local fetch = require 'http_codes.fetch'
local telescope = require 'http_codes.telescope'

function M.download() fetch.download_and_cache() end

function M.search() telescope.show_picker() end

function M.setup()
  vim.api.nvim_create_user_command('HTTPCodesDownload', M.download, {})
  vim.api.nvim_create_user_command('HTTPCodes', M.search, {})
end

return M
