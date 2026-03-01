return {
  'uga-rosa/ccc.nvim',
  keys = {
    {
      '<leader>tc',
      '<Cmd>CccHighlighterToggle<CR>',
      desc = '[T]oggle [C]olor Highlighter',
    },
    {
      '<leader>ccc',
      ':CccConvert<CR>',
      desc = '[C]onvert color under cursor',
    },
    {
      '<leader>ccp',
      ':CccPick<CR>',
      desc = '[P]ick and modify color under cursor',
    },
  },
  config = function()
    local ccc = require 'ccc'

    ccc.setup {
      highlighter = {
        auto_enable = false,
        lsp = true,
      },
    }
  end,
}
