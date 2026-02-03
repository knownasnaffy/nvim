local function get_clickup_token()
  local token = vim.fn.system('pass clickup/api_token'):gsub('\n', '')
  if token == '' then error 'ClickUp API token not found in pass' end
  return token
end

return { get_clickup_token = get_clickup_token }
