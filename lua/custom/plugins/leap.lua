return {
  'https://codeberg.org/andyg/leap.nvim',
  config = function() vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap)') end,
}
