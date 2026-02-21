return {
  'willothy/flatten.nvim',
  -- enabled = false,
  opts = function()
    ---@type Terminal?
    local saved_terminal

    return {
      window = {
        open = 'alternate',
      },
      hooks = {
        should_block = function(argv)
          -- Note that argv contains all the parts of the CLI command, including
          -- Neovim's path, commands, options and files.
          -- See: :help v:argv

          -- In this case, we would block if we find the `-b` flag
          -- This allows you to use `nvim -b file1` instead of
          -- `nvim --cmd 'let g:flatten_wait=1' file1`
          return vim.tbl_contains(argv, '-b')
            or vim.tbl_contains(argv, '/etc')
            or vim.tbl_contains(argv, '/var')
            or vim.tbl_contains(argv, '/usr')
            or vim.tbl_contains(argv, '/bin')
            or vim.tbl_contains(argv, '/boot')

          -- Alternatively, we can block if we find the diff-mode option
          -- return vim.tbl_contains(argv, "-d")
        end,
        pre_open = function()
          local term = require 'toggleterm.terminal'
          local termid = term.get_focused_id()
          saved_terminal = term.get(termid)
        end,
        ---@diagnostic disable-next-line: unused-local
        post_open = function(bufnr, winnr, ft, is_blocking)
          vim.cmd 'ToggleTerm' -- Toggle the active terminal

          -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
          -- If you just want the toggleable terminal integration, ignore this bit
          if ft == 'gitcommit' or ft == 'gitrebase' then
            vim.api.nvim_create_autocmd('BufWritePost', {
              buffer = bufnr,
              once = true,
              callback = vim.schedule_wrap(function() vim.api.nvim_buf_delete(bufnr, {}) end),
            })
          end
        end,
        block_end = function()
          -- After blocking ends (for a git commit, etc), reopen the terminal
          vim.schedule(function()
            if saved_terminal then vim.cmd 'ToggleTerm' end
          end)
        end,
      },
    }
  end,
  -- Ensure that it runs first to minimize delay when opening file from terminal
  lazy = false,
  priority = 1001,
}
