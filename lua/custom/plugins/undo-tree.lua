return {
  'mbbill/undotree',
  keys = { {
    '<leader>u',
    vim.cmd.UndotreeToggle,
    desc = 'Open File [U]ndo Tree',
  } },
  config = function()
    -- 1 = Both left; 2 = tree left, diff bottom; 3 = both right; 4 = tree right, diff bottom;
    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_SplitWidth = 40
    -- Auto focus
    vim.g.undotree_SetFocusWhenToggle = 1
    -- Disable help line
    vim.g.undotree_HelpLine = 0
    -- Highlight groups
    vim.g.undotree_HighlightSyntaxAdd = 'DiagnosticHint'
    vim.g.undotree_HighlightSyntaxChange = 'DiagnosticInfo'
    vim.g.undotree_HighlightSyntaxDel = 'DiagnosticError'
    -- Disable statuscolumn
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'undotree',
      callback = function()
        vim.opt_local.statuscolumn = ''
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.foldcolumn = '0'

        vim.keymap.set('n', '<M-r>', '<Plug>UndotreeRedo', { buffer = true, desc = 'Redo' })
      end,
    })
  end,
}
