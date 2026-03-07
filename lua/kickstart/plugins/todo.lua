-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>st',
      function() Snacks.picker.todo_comments() end,
      desc = '[S]earch [T]odos',
    },
  },
  opts = { signs = false },
}
