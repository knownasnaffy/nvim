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
      -- {
      --   '<leader>af',
      --   '<C-w>l:set ma<CR>/@_RES<CR>:nohlsearch<CR>jV:!jq<CR><C-w>h',
      --   desc = 'Rest json format',
      -- },
    },
    config = function()
      vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = '*.http',
        callback = function()
          vim.cmd('Rest env set ' .. vim.fn.expand '%:p:h' .. '/.env')
        end,
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'json',
        callback = function(ev)
          vim.bo[ev.buf].formatprg = 'jq'
        end,
      })

      require 'rest-nvim'
      ---@type rest.Opts
      vim.g.rest_nvim = {
        request = {
          hooks = {},
        },
        ui = {
          keybinds = {
            next = 'O',
            prev = 'I',
          },
        },
      }
    end,
  },
}
