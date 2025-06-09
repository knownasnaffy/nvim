return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    {
      '<M-`>',
      '<Cmd>ToggleTerm<CR>',
      desc = 'Toggle terminal',
      mode = { 'n', 't' },
    },
  },
  opts = {--[[ things you want to change go here]]
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    -- on_open = function()
    --   vim.cmd 'startinsert'
    -- end, -- function to run when the terminal opens
  },
}
