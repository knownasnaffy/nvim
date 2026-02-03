local plenary = require 'plenary.curl'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local get_clickup_token = require('custom.clickup.utils').get_clickup_token
local save_list_id = require('custom.clickup.settings').save_list_id

local function select_list(space_id)
  local token = get_clickup_token()
  local url = 'https://api.clickup.com/api/v2/space/' .. space_id .. '/folder/'
  local response = plenary.get(url, { headers = { Authorization = token } })

  if not response.body then
    print 'No response from ClickUp API'
    return
  end

  local data = vim.json.decode(response.body)
  if not data.folders or #data.folders == 0 then
    print 'No folders found'
    return
  end

  local choices = {}
  for _, folder in ipairs(data.folders) do
    for _, list in ipairs(folder.lists or {}) do
      table.insert(choices, { display = folder.name .. ' → ' .. list.name, id = list.id })
    end
  end

  if #choices == 0 then
    print 'No lists found'
    return
  end

  pickers
    .new({}, {
      prompt_title = 'Select List',
      finder = finders.new_table {
        results = choices,
        entry_maker = function(entry) return { value = entry.id, display = entry.display, ordinal = entry.display } end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        map('i', '<CR>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            print('Selected List ID: ' .. selection.value)
            save_list_id(selection.value)
          end
        end)
        return true
      end,
    })
    :find()
end

return select_list
