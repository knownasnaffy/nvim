local M = {}

local curl = require 'plenary.curl'
local parser = require 'http_codes.parser'
local storage = require 'http_codes.storage'

local RFC_URL = 'https://datatracker.ietf.org/doc/html/rfc9110'

function M.download_and_cache()
  local response = curl.get(RFC_URL, {
    timeout = 30000,
    accept = 'text/html',
  })

  if response.status ~= 200 then
    error('Failed to fetch RFC 9110: HTTP ' .. response.status)
  end

  local data = parser.parse_html(response.body)
  storage.write_cache(data)

  print 'HTTP status codes downloaded and cached successfully'
end

return M
