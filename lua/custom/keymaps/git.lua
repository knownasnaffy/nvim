local map = vim.keymap.set

map('n', '<leader>gc', function()
  -- Prompt for the commit message
  local message = vim.fn.input 'Enter commit message: '
  if message ~= '' then
    vim.cmd('G commit -m ' .. vim.fn.shellescape(message))
  else
    print 'Commit canceled.'
  end
end, { desc = 'Git [C]ommit with message', nowait = false })

map('n', '<leader>gC', function()
  vim.cmd 'G commit --amend --no-edit'
  print 'Amended last commit (without changing message).'
end, { desc = 'Git [C]ommit amend last' })

map('n', '<leader>ga', function()
  vim.cmd 'silent! G add %'
  print('File staged: ' .. vim.fn.expand '%')
end, { desc = 'Git [A]dd current file' })

map('n', '<leader>gs', function()
  vim.cmd 'G'
end, { desc = 'Git [S]tatus' })

map('n', '<leader>gA', function()
  vim.cmd 'silent! G add .'
  print 'All changes staged.'
end, { desc = 'Git stage [A]ll changes' })

map('n', '<leader>gu', function()
  vim.cmd 'silent! G reset %'
  print('Changes unstaged: ' .. vim.fn.expand '%')
end, { desc = 'Git [U]nstage current file' })

map('n', '<leader>gd', function()
  vim.ui.input({ prompt = 'Discard changes in current file? (y/n): ' }, function(input)
    if input and input:lower() == 'y' then
      vim.cmd 'G read'
      print('Changes discarded: ' .. vim.fn.expand '%')
    else
      print 'Discard canceled.'
    end
  end)
end, { desc = 'Git [D]iscard changes in current file' })

map('n', '<leader>gP', function()
  vim.cmd 'G pull'
  print 'Pulled changes from remote.'
end, { desc = 'Git [P]ull changes from remote' })

map('n', '<leader>gp', function()
  vim.cmd 'G push'
  print 'Pushed changes to remote.'
end, { desc = 'Git [P]ush changes to remote' })

map('n', '<leader>gD', function()
  vim.cmd 'G diff %'
end, { desc = 'Git [D]iff current file' })

map('n', '<leader>gm', function()
  vim.cmd 'G mergetool'
end, { desc = 'Git [M]ergetool for conflicts' })

map('n', '<leader>gl', function()
  vim.cmd 'G log --oneline --graph --decorate --all'
end, { desc = 'Git [L]og (compact)' })

map('n', ']x', '/^<<<<<<<\\|=======\\|>>>>>>>\\n', { desc = 'Next merge conflict' })
map('n', '[x', '?^<<<<<<<\\|=======\\|>>>>>>>\\n', { desc = 'Previous merge conflict' })
