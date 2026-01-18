local M = {}

local Job = require 'plenary.job'
local parser = require 'http_codes.parser'
local storage = require 'http_codes.storage'

local RFC_URL = 'https://datatracker.ietf.org/doc/html/rfc9110'

function M.download_and_cache()
  print 'Starting HTTP status codes download...'

  Job:new({
    command = 'curl',
    args = {
      '-s',
      '-H',
      'Accept: text/html',
      '--max-time',
      '30',
      RFC_URL,
    },
    on_exit = function(j, return_val)
      if return_val ~= 0 then
        print('Error: Failed to fetch RFC 9110 (curl exit code: ' .. return_val .. ')')
        return
      end

      local html = table.concat(j:result(), '\n')
      if #html == 0 then
        print 'Error: Empty response from RFC 9110'
        return
      end

      local success, result = pcall(function()
        local data = parser.parse_html(html)
        storage.write_cache(data)
        return data
      end)

      if success then
        print 'HTTP status codes downloaded and cached successfully'
      else
        print('Error parsing RFC 9110: ' .. tostring(result))
      end
    end,
  }):start()
end

return M
