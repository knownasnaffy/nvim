-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Git keymaps
map('n', '<leader>gc', function()
  -- Prompt for the commit message
  vim.ui.input({ prompt = 'Enter commit message: ' }, function(input)
    if input then
      -- Execute the Git commit command with the message
      vim.cmd('G commit -m ' .. vim.fn.shellescape(input))
    else
      -- Handle case when input is nil (e.g., user cancels the prompt)
      print 'Commit canceled.'
    end
  end)
end, { desc = '[G]it [C]ommit with message' })

map('n', '<leader>ga', function()
  vim.cmd 'G add %'
  print('File staged: ' .. vim.fn.expand '%')
end, { desc = '[G]it [A]dd current file' })

map('n', '<leader>gs', function()
  vim.cmd 'G'
end, { desc = '[G]it [S]tatus' })

map('n', '<leader>gA', function()
  vim.cmd 'G add .'
  print 'All changes staged.'
end, { desc = '[G]it stage [A]ll changes' })

map('n', '<leader>gu', function()
  vim.cmd 'G reset %'
  print('Changes unstaged: ' .. vim.fn.expand '%')
end, { desc = '[G]it [U]nstage current file' })

map('n', '<leader>gd', function()
  vim.ui.input({ prompt = 'Discard changes in current file? (y/n): ' }, function(input)
    if input and input:lower() == 'y' then
      vim.cmd 'G checkout %'
      print('Changes discarded: ' .. vim.fn.expand '%')
    else
      print 'Discard canceled.'
    end
  end)
end, { desc = '[G]it [D]iscard changes in current file' })

map('n', '<leader>gp', function()
  vim.cmd 'G pull'
  print 'Pulled changes from remote.'
end, { desc = '[G]it [P]ull changes from remote' })

map('n', '<leader>gP', function()
  vim.cmd 'G push'
  print 'Pushed changes to remote.'
end, { desc = '[G]it [P]ush changes to remote' })

map('n', '<leader>gD', function()
  vim.cmd 'G diff %'
end, { desc = '[G]it [D]iff current file' })

map('n', '<leader>gm', function()
  vim.cmd 'G mergetool'
end, { desc = '[G]it [M]ergetool for conflicts' })

map('n', '<leader>gco', function()
  vim.ui.input({ prompt = 'Enter branch name to checkout: ' }, function(branch)
    if branch then
      vim.cmd('G checkout ' .. vim.fn.shellescape(branch))
      print('Checked out to branch: ' .. branch)
    else
      print 'Checkout canceled.'
    end
  end)
end, { desc = '[G]it [C]heck[O]ut branch' })

map('n', '<leader>gcb', function()
  vim.ui.input({ prompt = 'Enter new branch name: ' }, function(branch)
    if branch then
      vim.cmd('G checkout -b ' .. vim.fn.shellescape(branch))
      print('Switched to new branch: ' .. branch)
    else
      print 'Branch creation canceled.'
    end
  end)
end, { desc = '[G]it [C]reate [B]ranch' })

-- Tab management keymaps
map('n', '<M-w>w', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
map('n', '<M-w>q', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
map('n', '<M-w>l', '<cmd>tabnext<CR>', { desc = 'Go to next tab' })
map('n', '<M-w>h', '<cmd>tabprevious<CR>', { desc = 'Go to previous tab' })

-- Buffer management keymaps
local function buffer_switch(direction)
  local count = vim.v.count > 0 and vim.v.count or 1
  vim.cmd((direction == 'next' and 'bnext ' or 'bprevious ') .. count)
end

map('n', '<M-w><M-l>', function()
  buffer_switch 'next'
end, { desc = 'Go to next buffer' })
map('n', '<M-w><M-k>', function()
  buffer_switch 'next'
end, { desc = 'Go to next buffer' })
map('n', '<M-w><M-j>', function()
  buffer_switch 'previous'
end, { desc = 'Go to previous buffer' })
map('n', '<M-w><M-h>', function()
  buffer_switch 'previous'
end, { desc = 'Go to previous buffer' })

map('n', '<M-w><M-q>', '<cmd>BufferClose<CR>', { desc = 'Close current tab' })

map('n', '<M-w>9', '<cmd>bl<CR>', { desc = 'Go to last buffer' })
map('n', '<M-w>1', '<cmd>bf<CR>', { desc = 'Go to first buffer' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
