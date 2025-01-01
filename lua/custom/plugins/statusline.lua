return { -- Statusline and Tabline
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local statusline_theme = require 'lualine.themes.auto'

    statusline_theme.normal.a.gui = 'bold'

    require('lualine').setup {
      options = {
        section_separators = { left = '', right = '' },
        theme = statusline_theme,
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
            source = nil, -- A function that works as a data source for diff.
            -- It must return a table as such:
            --   { added = add_count, modified = modified_count, removed = removed_count }
            -- or nil on failure. count <= 0 won't be displayed.
          },
        },
        lualine_x = { 'diagnostics' },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'location' },
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            'tabs',
            -- tab_max_length = 40, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
            -- max_length = vim.o.columns / 3, -- Maximum width of tabs component.
            -- Note:
            -- It can also be a function that returns
            -- the value of `max_length` dynamically.
            mode = 1, -- 0: Shows tab_nr
            -- 1: Shows tab_name
            -- 2: Shows tab_nr + tab_name

            -- path = 0, -- 0: just shows the filename
            -- -- 1: shows the relative path and shorten $HOME to ~
            -- -- 2: shows the full path
            -- -- 3: shows the full path and shorten $HOME to ~
            --
            -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
            use_mode_colors = false,

            tabs_color = {
              -- Same values as the general color option can be used here.
              active = 'lualine_a_normal', -- Color for active tab.
              inactive = 'lualine_b_normal', -- Color for inactive tab.
            },

            show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
            symbols = {
              modified = '', -- Text to show when the file is modified.
            },

            -- fmt = function(name, context)
            --   -- Show + if buffer is modified in tab
            --   local buflist = vim.fn.tabpagebuflist(context.tabnr)
            --   local winnr = vim.fn.tabpagewinnr(context.tabnr)
            --   local bufnr = buflist[winnr]
            --   local mod = vim.fn.getbufvar(bufnr, '&mod')
            --
            --   return name .. (mod == 1 and ' +' or '')
            -- end,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
