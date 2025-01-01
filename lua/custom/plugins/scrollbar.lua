return {
  'petertriho/nvim-scrollbar',
  dependencies = { 'lewis6991/gitsigns.nvim' },
  config = function()
    require('scrollbar').setup {}

    require('scrollbar.handlers.search').setup {
      override_lens = function() end,
    }
  end,
}
