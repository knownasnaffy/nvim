return {
  {
    'vhyrro/luarocks.nvim',
    branch = 'go-away-python',
  },
  {
    'rest-nvim/rest.nvim',
    event = 'VeryLazy',
    ft = { 'http' },
    dependencies = {
      {
        'luarocks.nvim',
      },
    },
    keys = {
      {
        '<leader>ar',
        ':Rest run<CR>',
      },
      {
        '<leader>aS',
        ':Rest env show<CR>',
      },
      {
        '<leader>as',
        ':Rest env select<CR>',
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = '*.http',
        callback = function()
          vim.cmd('Rest env set ' .. vim.fn.expand '%:p:h' .. '/.env')
        end,
      })

      require 'rest-nvim'
      ---@type rest.Opts
      vim.g.rest_nvim = {
        -- ...
        request = {
          hooks = {},
        },
      }
    end,
  },
}
