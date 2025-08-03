return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    local copilot = require 'copilot'

    copilot.setup {}

    -- add some default keybinds
  end,
}
