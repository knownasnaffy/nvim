local M = {}

local Path = require 'plenary.path'

local CACHE_FILENAME = 'http-codes-rfc9110.json'

function M.get_cache_path()
  local state_dir = vim.fn.stdpath 'state'
  return Path:new(state_dir, CACHE_FILENAME)
end

function M.write_cache(data)
  local cache_path = M.get_cache_path()
  local state_dir = cache_path:parent()

  if not state_dir:exists() then state_dir:mkdir { parents = true } end

  local json_data = vim.json.encode(data)
  local temp_path = Path:new(state_dir.filename, CACHE_FILENAME .. '.tmp')

  temp_path:write(json_data, 'w')

  local success = os.rename(temp_path.filename, cache_path.filename)
  if not success then
    temp_path:rm()
    error 'Failed to write cache file atomically'
  end
end

function M.read_cache()
  local cache_path = M.get_cache_path()

  if not cache_path:exists() then error 'Cache file not found. Run :HTTPCodesDownload first.' end

  local content = cache_path:read()
  local ok, data = pcall(vim.json.decode, content)

  if not ok then error 'Invalid cache file format' end

  return data
end

return M
