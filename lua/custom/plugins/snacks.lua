---@diagnostic disable: undefined-global, undefined-doc-name
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>gB',
      function() Snacks.gitbrowse() end,
      desc = '[B]rowse file in git remote',
    },
    {
      '<M-q>',
      function() Snacks.bufdelete() end,
      desc = 'Delete current buffer',
    },
    {
      '<leader>.',
      function() Snacks.scratch() end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>oi',
      function() Snacks.image.hover() end,
      desc = 'Hover [O]ver the [I]mage the cursor is at',
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

          -- Command:
          -- figlet -f "DOS Rebel" -w 300 ::::::NOX::::::
          -- Needed to add the spacing between colons and letters manually
          -- This weird looking thing is the result of trying to fight trailing space vs centered layout
          header = [[
  ██████   █████    ███████    █████ █████
░░██████ ░░███   ███░░░░░███ ░░███ ░░███
 ░███░███ ░███  ███     ░░███ ░░███ ███
░███░░███░███ ░███      ░███  ░░█████
 ░███ ░░██████ ░███      ░███   ███░███
 ░███  ░░█████ ░░███     ███   ███ ░░███
  █████  ░░█████ ░░░███████░   █████ █████
░░░░░    ░░░░░    ░░░░░░░    ░░░░░ ░░░░░
]],
        },
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
        },
      },
      image = {
        doc = {
          inline = false,
          float = false,
        },
      },
      indent = {
        enabled = true,
        filter = function(buf)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == '' and vim.bo[buf].filetype ~= 'norg'
        end,
      },
      scroll = {
        animate = {
          duration = { step = 10, total = 100 },
          easing = 'linear',
        },
      },
      scope = {},
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
