return { -- Autoformat
  'mhartington/formatter.nvim',
  config = function()
    -- Utilities for creating configurations
    local util = require 'formatter.util'

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require('formatter').setup {
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order

        lua = {
          -- "formatter.filetypes.lua" defines default configurations for the
          -- "lua" filetype
          require('formatter.filetypes.lua').stylua,

          -- You can also define your own configuration
          -- function()
          --   -- Supports conditional formatting
          --   if util.get_current_buffer_file_name() == 'special.lua' then
          --     return nil
          --   end
          --
          --   -- Full specification of configurations is down below and in Vim help
          --   -- files
          --   return {
          --     exe = 'stylua',
          --     args = {
          --       '--search-parent-directories',
          --       '--stdin-filepath',
          --       util.escape_path(util.get_current_buffer_file_path()),
          --       '--',
          --       '-',
          --     },
          --     stdin = true,
          --   }
          -- end,
        },

        javascriptreact = {
          require 'formatter.defaults.prettier',
        },
        javascript = {
          require 'formatter.defaults.prettier',
        },
        typescript = {
          require 'formatter.defaults.prettier',
        },
        typescriptreact = {
          require 'formatter.defaults.prettier',
        },
        json = {
          require('formatter.filetypes.json').prettier,
        },
        css = {
          require('formatter.filetypes.css').prettier,
        },
        html = {
          require('formatter.filetypes.html').prettier,
        },
        toml = {
          require('formatter.filetypes.toml').taplo,
        },
        yaml = {
          require('formatter.filetypes.yaml').prettier,
        },
        python = {
          require('formatter.filetypes.python').black,
        },
        dart = {
          require('formatter.filetypes.dart').dartformat,
        },
        cpp = {
          require('formatter.filetypes.cpp').clangformat,
        },
        sh = {
          function()
            -- Supports conditional formatting

            -- Full specification of configurations is down below and in Vim help
            -- files
            return {
              exe = 'beautysh',
              args = {
                util.escape_path(util.get_current_buffer_file_path()),
              },
            }
          end,
        },
        go = {
          require('formatter.filetypes.go').gofmt,
        },
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ['*'] = {
          -- "formatter.filetypes.any" defines default configurations for any
          -- filetype
          require('formatter.filetypes.any').remove_trailing_whitespace,
          -- Remove trailing whitespace without 'sed'
          -- require("formatter.filetypes.any").substitute_trailing_whitespace,
        },
      },
    }
    vim.keymap.set('n', '<M-s>', '<Cmd>w | FormatWrite<CR>', { desc = '[F]ormat buffer' })
  end,
}
