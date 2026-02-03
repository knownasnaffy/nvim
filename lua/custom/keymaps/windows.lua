local map = vim.keymap.set

--  See `:help wincmd` for a list of all window commands
--
--  Switching between windows
map('n', '<leader>wj', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<leader>w;', '<C-w>l', { desc = 'Move focus to the right window' })
map('n', '<leader>wk', '<C-w>j', { desc = 'Move focus to the lower window' })
map('n', '<leader>wl', '<C-w>k', { desc = 'Move focus to the upper window' })
map('n', '<leader>ww', '<C-w>w', { desc = 'Switch window' })

-- Resizing
map('n', '<leader>w+', '<C-w>+', { desc = 'Increase window height' })
map('n', '<leader>w-', '<C-w>-', { desc = 'Decrease window height' })
map('n', '<leader>w>', '<C-w>>', { desc = 'Increase window width' })
map('n', '<leader>w<', '<C-w><', { desc = 'Decrease window width' })

-- Managing splits
map('n', '<leader>ws', '<C-w>s', { desc = 'Split window horizontally' })
map('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
map('n', '<leader>wm', '<C-w>| <C-w>_', { desc = 'Maximize window' })
map('n', '<leader>wr', '<C-w>=', { desc = 'Reset window sizes' })

map('n', '<leader>wJ', '<C-w>H', { desc = 'Move current window to the left' })
map('n', '<leader>w:', '<C-w>L', { desc = 'Move current window to the right' })
map('n', '<leader>wK', '<C-w>J', { desc = 'Move current window to the bottom' })
map('n', '<leader>wL', '<C-w>K', { desc = 'Move current window to the top' })

-- Closing windows
map('n', '<leader>wq', '<C-w>q', { desc = 'Close current window' })
map('n', '<leader>woq', '<C-w>o', { desc = 'Close other windows' })
map('n', '<leader>waq', '<Cmd>qa<CR>', { desc = 'Close all windows' })

-- Tabs
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft ~= 'norg' then
      vim.keymap.set('n', '<leader>wtn', '<Cmd>tabnew<CR>', { buffer = args.buf, desc = '[N]ew tab' })
      vim.keymap.set('n', '<leader>wtc', '<Cmd>tabclose<CR>', { buffer = args.buf, desc = '[C]lose tab' })
      vim.keymap.set('n', '<leader>wt;', '<Cmd>tabn<CR>', { buffer = args.buf, desc = 'Previous tab' })
      vim.keymap.set('n', '<leader>wtj', '<Cmd>tabN<CR>', { buffer = args.buf, desc = 'Next tab' })
    end
  end,
})
