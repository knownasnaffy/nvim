-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'r'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.termguicolors = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Wrap at word boundaries
vim.opt.linebreak = true
-- Enable break indent
vim.opt.breakindent = true

-- Fold
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99
vim.opt.foldtext = 'v:lua.custom_fold_text()'

function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart) -- Get first line of fold
  local fold_size = vim.v.foldend - vim.v.foldstart + 1 -- Number of folded lines
  return line .. ' 󰁂 ' .. fold_size .. ' lines '
end

-- Save undo history
vim.opt.undofile = true

-- Session settings
vim.opt.sessionoptions:append 'globals'
vim.api.nvim_create_user_command('Mksession', function(attr)
  vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })

  -- Neovim 0.8+
  vim.cmd.mksession { bang = attr.bang, args = attr.fargs }

  -- Neovim 0.7
  -- vim.api.nvim_command('mksession ' .. (attr.bang and '!' or '') .. attr.args)
end, { bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?' })

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
