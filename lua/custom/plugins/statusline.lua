return { -- Statusline and Tabline
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local statusline_theme = require 'lualine.themes.auto'

    statusline_theme.normal.a.gui = 'bold'

    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    require('lualine').setup {
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '/', right = '\\' },
        theme = statusline_theme,
        disabled_filetypes = { -- Filetypes to disable lualine for.
          statusline = {
            'neo-tree',
            'neo-tree-popup',
          }, -- only ignores the ft for statusline.
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'filename',
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 1, -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '', -- Text to show when the file is modified.
              readonly = '', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[Unsaved]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for newly created file before first write
            },
          },
        },
        lualine_c = {
          {
            'diff',
            colored = true, -- Displays a colored diff status if set to true
            -- diff_color = {
            --   -- Same color values as the general color option can be used here.
            --   added = 'LuaLineDiffAdd', -- Changes the diff's added color
            --   modified = 'LuaLineDiffChange', -- Changes the diff's modified color
            --   removed = 'LuaLineDiffDelete', -- Changes the diff's removed color you
            -- },
            symbols = { added = ' ', modified = ' ', removed = ' ' }, -- Changes the symbols used by the diff.
            source = diff_source, -- A function that works as a data source for diff.
            -- It must return a table as such:
            --   { added = add_count, modified = modified_count, removed = removed_count }
            -- or nil on failure. count <= 0 won't be displayed.
          },
        },
        lualine_x = {
          { -- Recording status
            ---@diagnostic disable-next-line:undefined-field
            require('noice').api.status.mode.get,
            cond = function()
              ---@diagnostic disable-next-line:undefined-field
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            color = { fg = '#ff9e64' },
          },
          'diagnostics',
        },
        lualine_y = { 'progress' },
        -- <line number>:<column number>
        lualine_z = { '%l:%c' },
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
