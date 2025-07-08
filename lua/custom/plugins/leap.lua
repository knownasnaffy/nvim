return {
  'ggandor/leap.nvim',
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>(leap)')
  end,
}
