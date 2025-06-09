---@diagnostic disable: undefined-global, undefined-doc-name
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>gb',
      function()
        Snacks.gitbrowse()
      end,
      desc = '[B]rowse file in git remote',
    },
    {
      '<M-q>',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete current buffer',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
  },
  config = function()
    require('snacks').setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      buffdelete = { enabled = true },
      dashboard = {
        preset = {

          header = [[
   ███╗   ██╗ █████╗ ███████╗███████╗██╗   ██╗
   ████╗  ██║██╔══██╗██╔════╝██╔════╝╚██╗ ██╔╝
  ██╔██╗ ██║███████║█████╗  █████╗   ╚████╔╝
 ██║╚██╗██║██╔══██║██╔══╝  ██╔══╝    ╚██╔╝
██║ ╚████║██║  ██║██║     ██║        ██║
   ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝        ╚═╝   ]],
        },
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
      terminal = { enabled = false },
    }
  end,
}
