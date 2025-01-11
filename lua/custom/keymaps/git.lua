local map = vim.keymap.set

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
