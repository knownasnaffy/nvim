return {
  -- enabled = false,
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'Load session for current directory',
    },
    {
      '<leader>qS',
      function()
        require('persistence').select()
      end,
      desc = 'Select a session to load',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Load last session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = 'Stop Persistence (session won’t be saved)',
    },
  },
  opts = {
    -- options = {--[[<other options>,]]
    --   'globals',
    -- },
    -- pre_save = function()
    --   vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
    -- end,
  },
}
