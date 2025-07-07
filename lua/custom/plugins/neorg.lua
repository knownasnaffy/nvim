return {
  'nvim-neorg/neorg',
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  -- enabled = false,
  version = '*', -- Pin Neorg to the latest stable release
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-neorg/neorg-telescope' },
    {
      'michaelb/sniprun',
      branch = 'master',

      build = 'sh install.sh',
      -- do 'sh install.sh 1' if you want to force compile locally
      -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

      config = function()
        require('sniprun').setup {
          interpreter_options = {
            TypeScript_original = {
              interpreter = 'node',
            },
          },
        }
      end,
    },
  },
  config = function()
    local map = vim.keymap.set
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {
          config = {
            icon_preset = 'varied',
          },
        },
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
            },
          },
        },
        ['core.esupports.metagen'] = {
          config = {
            author = 'Barinderpreet Singh',
          },
        },
        ['core.integrations.telescope'] = {},
      },
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'norg',
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = 'n'
        map('n', '<leader>nt', '<Cmd>Neorg toc<CR>')
        map('n', '<M-Space>', '<Plug>(neorg.qol.todo-items.todo.task-cycle)')
        map('i', '<M-Space>', '<Cmd>Telescope neorg insert_link<CR>')
      end,
    })
  end,
}
