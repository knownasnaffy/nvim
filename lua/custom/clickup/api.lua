local plenary = require 'plenary.curl'

local M = {}

local function get_clickup_token()
  local token = vim.fn.system('pass clickup/api_token'):gsub('\n', '')
  if token == '' then error 'ClickUp API token not found in pass' end
  return token
end

function M.get_workspaces()
  return plenary.get('https://api.clickup.com/api/v2/team', {
    headers = { Authorization = get_clickup_token() },
  })
end

function M.get_spaces(workspace_id)
  return plenary.get('https://api.clickup.com/api/v2/team/' .. workspace_id .. '/space', {
    headers = { Authorization = get_clickup_token() },
  })
end

function M.get_lists(space_id)
  return plenary.get('https://api.clickup.com/api/v2/space/' .. space_id .. '/folder/', {
    headers = { Authorization = get_clickup_token() },
  })
end

return M
