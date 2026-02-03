local M = {}

local function get_nvim_data_path() return vim.fn.stdpath 'data' .. '/clickup_settings.json' end

function M.load_settings()
  local path = get_nvim_data_path()
  local file = io.open(path, 'r')
  if not file then return {} end
  local content = file:read '*a'
  file:close()
  return vim.fn.json_decode(content) or {}
end

function M.save_list_id(list_id)
  local settings = M.load_settings()
  local cwd = vim.fn.getcwd()
  settings[cwd] = { list_id = list_id }

  local file = io.open(get_nvim_data_path(), 'w')
  if file then
    file:write(vim.fn.json_encode(settings))
    file:close()
    print('Saved List ID: ' .. list_id .. ' for ' .. cwd)
  else
    print 'Failed to save settings'
  end
end

return M
