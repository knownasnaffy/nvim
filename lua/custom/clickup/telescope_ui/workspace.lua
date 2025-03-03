local plenary = require 'plenary.curl'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local get_clickup_token = require('custom.clickup.utils').get_clickup_token
local select_space = require 'custom.clickup.telescope_ui.space'

local function select_workspace()
  local token = get_clickup_token()
  local response = plenary.get('https://api.clickup.com/api/v2/team', {
    headers = { Authorization = token },
  })

  if not response.body then
    print 'No response from ClickUp API'
    return
  end

  local data = vim.json.decode(response.body)
  if not data.teams or #data.teams == 0 then
    print 'No teams found'
    return
  end

  local choices = {}
  for _, team in ipairs(data.teams) do
    table.insert(choices, { display = team.name, id = team.id })
  end

  pickers
    .new({}, {
      prompt_title = 'Select Workspace',
      finder = finders.new_table {
        results = choices,
        entry_maker = function(entry)
          return { value = entry.id, display = entry.display, ordinal = entry.display }
        end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        map('i', '<CR>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            select_space(selection.value)
          end
        end)
        return true
      end,
    })
    :find()
end

return select_workspace
