---@diagnostic disable: undefined-global, undefined-doc-name
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<M-`>',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle terminal',
      mode = { 'n', 't' },
    },
    {
      '<leader>gb',
      function()
        Snacks.gitbrowse()
      end,
      desc = '[B]rowser file in git remote',
    },
    {
      '<M-q>',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete current buffer',
    },
  },
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    buffdelete = { enabled = true },
    dashboard = {
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
      },
    },
    indent = { enabled = true },
    -- notifier = { enabled = true },
    quickfile = { enabled = true },
    -- scroll = { enabled = true },
    statuscolumn = {
      enabled = true,
    },
    -- words = { enabled = true },
    terminal = {},
  },
}
