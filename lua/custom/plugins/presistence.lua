return {
  -- enabled = false,
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  keys = {
    {
      '<leader>pS',
      function()
        require('persistence').load()
      end,
      desc = 'Load session for current directory',
    },
    {
      '<leader>ps',
      function()
        require('persistence').select()
      end,
      desc = 'Select a session to load',
    },
    {
      '<leader>pl',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Load last session',
    },
    {
      '<leader>pd',
      function()
        require('persistence').stop()
      end,
      desc = 'Stop Persistence (session won’t be saved)',
    },
  },
  opts = {},
}
