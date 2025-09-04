return {
  'uga-rosa/ccc.nvim',
  config = function()
    local ccc = require 'ccc'
    local map = vim.keymap.set

    ccc.setup {
      highlighter = {
        auto_enable = false,
        lsp = true,
      },
    }

    map('n', '<leader>ccc', ':CccConvert<CR>', { desc = '[C]onvert color under cursor' })
    map('n', '<leader>ccp', ':CccPick<CR>', { desc = '[P]ick and modify color under cursor' })
  end,
}
