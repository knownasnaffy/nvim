-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>st',
      ':TodoTelescope<CR>',
      desc = '[S]earch [T]odos',
    },
  },
  opts = { signs = false },
}
