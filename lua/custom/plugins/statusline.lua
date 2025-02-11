return { -- Statusline and Tabline
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local statusline_theme = require 'lualine.themes.auto'

    statusline_theme.normal.a.gui = 'bold'
    statusline_theme.insert.a.gui = 'bold'
    statusline_theme.command.a.gui = 'bold'
    statusline_theme.terminal.a.gui = 'bold'

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

    local function battery_status()
      local handle = io.popen 'acpi -b'
      if not handle then
        return '' -- Default icon for unavailable status
      end

      local result = handle:read '*a'
      handle:close()

      -- Extract battery percentage and status
      local percentage = tonumber(result:match '(%d?%d?%d)%%')
      local status = result:match 'Battery %d+: ([%a%s]+),' or 'Unknown'

      if not percentage then
        return '' -- Default fallback
      end
      local discharging = status:lower():find 'discharging'

      local icon
      if percentage < 20 then
        icon = discharging and ' 󰚥 ' or '  ' -- Warning icon for low battery
      elseif percentage >= 20 and percentage < 40 then
        icon = discharging and '  ' or '  ' -- Low battery icon
      elseif percentage >= 40 and percentage < 60 then
        icon = discharging and '  ' or '  ' -- Mid-level battery icon
      elseif percentage >= 60 and percentage < 80 then
        icon = discharging and '  ' or '  ' -- High battery icon
      elseif percentage >= 80 and percentage <= 100 then
        icon = discharging and '  ' or ' 󰚦 ' -- Full battery icon
      else
        icon = ' ' -- Default fallback icon
      end

      return icon
    end

    local tabline_section_y = function() -- Make separator `\` color same as section color
      return ' 󰦖 %{strftime("%H:%M")}'
    end

    require('lualine').setup {
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        theme = statusline_theme,
        disabled_filetypes = { -- Filetypes to disable lualine for.
          statusline = {
            'neo-tree',
            'neo-tree-popup',
          }, -- only ignores the ft for statusline.
        },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, padding = { left = 1, right = 2 } } },
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
              readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[Unsaved]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for newly created file before first write
            },
            padding = { left = 2, right = 1 },
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
            padding = { left = 2, right = 1 },
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
            padding = { left = 1, right = 2 },
          },
        },
        lualine_y = { { 'progress', icon = '󰦕', padding = { left = 1, right = 1 } }, { '%l:%c', icon = '', padding = { left = 1, right = 2 } } },
        -- <line number>:<column number>
        lualine_z = { { tabline_section_y, separator = { right = '' }, padding = { left = 2, right = 1 } } },
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
