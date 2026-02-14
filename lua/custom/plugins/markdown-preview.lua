return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && bun install',
  init = function() vim.g.mkdp_filetypes = { 'markdown' } end,
  ft = { 'markdown' },
  keys = {

    {
      '<leader>oM',
      '<Cmd>MarkdownPreviewToggle<CR>',
      desc = 'Hover [O]ver the [I]mage the cursor is at',
    },
  },
}
