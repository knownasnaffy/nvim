return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  -- I dont want this running every time I open a file, so I will trigger it manually when I need it
  -- event = 'InsertEnter',
  config = function()
    local copilot = require 'copilot'

    copilot.setup {
      fyletypes = {
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
            -- disable for .env files
            return false
          end
          return true
        end,
        typescriptreact = false,
      },
    }

    -- add some default keybinds
  end,
}
