local M = {}

local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local previewers = require 'telescope.previewers'

local storage = require 'http_codes.storage'

function M.show_picker()
  local data = storage.read_cache()

  local entries = {}
  for _, status in ipairs(data.statuses) do
    table.insert(entries, {
      display = status.code .. ' ' .. status.name,
      ordinal = status.code .. ' ' .. status.name .. ' ' .. status.content.plain_text,
      value = status,
    })
  end

  pickers
    .new({}, {
      prompt_title = 'HTTP Status Codes (RFC 9110)',
      finder = finders.new_table {
        results = entries,
        entry_maker = function(entry)
          return entry
        end,
      },
      sorter = conf.generic_sorter {},
      previewer = previewers.new_buffer_previewer {
        title = 'Status Code Details',
        define_preview = function(self, entry)
          local status = entry.value
          local lines = vim.split(status.content.plain_text, '\n')

          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
          vim.bo[self.state.bufnr].filetype = 'markdown'
          vim.wo[self.state.winid].wrap = true
          vim.wo[self.state.winid].conceallevel = 0
        end,
      },
    })
    :find()
end

return M
