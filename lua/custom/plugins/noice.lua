return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      progress = {
        enabled = false,
      },
    },
    routes = {
      -- Disable file written messages
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
      -- Disable hidden file toggle in neo-tree
      {
        filter = {
          event = 'msg_show',
          find = 'Toggling hidden files:',
        },
        opts = { skip = true },
      },
    },
    -- Display cmdline popup below prompt
    views = {
      cmdline_popup = {
        position = {
          row = 5,
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
      },
      popupmenu = {
        relative = 'editor',
        position = {
          row = 8,
          col = '50%',
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = 'rounded',
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
        },
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
  },
}
