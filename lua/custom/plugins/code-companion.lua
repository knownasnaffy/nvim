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
    interactions = {
      chat = {
        -- You can specify an adapter by name and model (both ACP and HTTP)
        adapter = {
          name = 'kiro',
          -- model = 'gpt-4.1',
        },
      },
      -- Or, just specify the adapter by name
      inline = {
        adapter = 'gemini_cli',
      },
      -- cmd = {
      --   adapter = 'kiro-cli',
      -- },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = 'DEBUG', -- or "TRACE"
    },
  },
}
