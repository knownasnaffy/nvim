return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    {
      '<leader>cca',
      '<Cmd>CodeCompanionActions<CR>',
    },
    {
      '<leader>cct',
      '<Cmd>CodeCompanionChat Toggle<CR>',
    },
  },
  lazy = false,
  opts = {
    display = { action_palette = { provider = 'snacks' } },
    adapters = {
      http = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            schema = {
              model = {
                default = 'qwen2.5-coder:7b-instruct-q5_K_M',
              },
            },
          })
        end,
      },
    },
    interactions = {
      chat = {
        adapter = {
          name = 'kiro',
        },
      },
      inline = {
        adapter = 'ollama',
        -- model = 'qwen2.5-coder:7b-instruct-q5_K_M',
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = 'DEBUG', -- or "TRACE"
    },
  },
}
