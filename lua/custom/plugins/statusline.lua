return { -- Statusline and Tabline
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', { 'AndreM222/copilot-lualine' } },
  config = function()
    local statusline_theme = require 'lualine.themes.auto'

    statusline_theme.normal.a.gui = 'bold'
    statusline_theme.insert.a.gui = 'bold'
    statusline_theme.command.a.gui = 'bold'
    statusline_theme.terminal.a.gui = 'bold'
    statusline_theme.visual.a.gui = 'bold'

    require('lualine').setup {
      options = {
        section_separators = { left = ' ', right = ' ' },
        component_separators = { left = '', right = '' },
        theme = statusline_theme,
        disabled_filetypes = { -- Filetypes to disable lualine for.
          statusline = {
            'neo-tree',
            'neo-tree-popup',
            'undotree',
            'snacks_dashboard',
          }, -- only ignores the ft for statusline.
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              local prefixes = {
                terminal = ' ', -- Error icon
                normal = ' ', -- Warning icon
                insert = ' ', -- Info icon
                command = '󰘳 ', -- Hint icon
                visual = '󰈈 ', -- Hint icon
                ['v-line'] = '󰈈 ', -- Hint icon
                ['v-block'] = '󰈈 ', -- Hint icon
              }

              local lower_input = string.lower(str)
              local prefix = prefixes[lower_input] or ''

              return prefix .. str
            end,
            padding = { left = 2, right = 2 },
          },
        },
        lualine_b = {
          {
            'FugitiveHead',
            icon = '󰘬',
            {
              padding = { left = 2, right = 2 },
            },
            fmt = function(name) return name ~= '' and (name .. ' ') or '' end,
          },
        },
        lualine_c = {
          {
            'filename',
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 1, -- 0: Just the filename
            icon = '',
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '', -- Text to show when the file is modified.
              readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[Unsaved]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for newly created file before first write
            },
            padding = { left = 1, right = 2 },
          },
        },
        lualine_x = {
          {
            'searchcount',
            icon = '',
            color = { fg = '#e0af68' },
            padding = { left = 2, right = 1 },
          },
          { -- Recording status
            ---@diagnostic disable-next-line:undefined-field
            require('noice').api.status.mode.get,
            cond = function()
              ---@diagnostic disable-next-line:undefined-field
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            color = { fg = '#bb9af7' },
            padding = { left = 1, right = 1 },
          },
          {
            'copilot',
            show_count = true,
            padding = { left = 1, right = 1 },
          },
        },
        lualine_y = { { 'progress', icon = '󰦕', padding = { left = 2, right = 1 } } },
        -- <line number>:<column number>
        lualine_z = { { '%l:%c', icon = '', padding = { left = 2, right = 2 } } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'location' },
        lualine_z = {},
      },
    }
  end,
}
