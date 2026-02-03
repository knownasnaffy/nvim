local getFileName = function()
  local cwd = vim.fn.getcwd() -- Current working directory (absolute)
  local file_path = vim.fn.expand '%:p:h' -- Absolute path of current file's directory
  local relative_path = file_path:gsub(cwd .. '/', '') -- Remove cwd prefix to get relative

  return '/images/' .. relative_path .. '/' .. vim.fn.expand '%:t:r'
end

return {
  'https://github.com/dfendr/clipboard-image.nvim',
  config = function()
    require('clipboard-image').setup {
      -- Default configuration for all filetype
      default = {
        img_dir = 'images',
        img_name = function() return os.date '%Y-%m-%d-%H-%M-%S' end, -- Example result: "2021-04-13-10-04-18"
        affix = '<\n  %s\n>', -- Multi lines affix
      },
      -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
      -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
      -- Missing options from `markdown` field will be replaced by options from `default` field
      -- markdown = {
      --   img_dir = function()
      --     return 'public/' .. getFileName()
      --   end,
      --   img_dir_txt = getFileName,
      --   -- img_handler = function(img) -- New feature from PR #22
      --   --   local script = string.format('./image_compressor.sh "%s"', img.path)
      --   --   os.execute(script)
      --   -- end,
      -- },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>p', '<cmd>PasteImg<CR>')
  end,
}
