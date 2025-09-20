-- Simple EditorConfig command
vim.api.nvim_create_user_command('EditorConfig', function()
  -- Find project root
  local root_patterns = { '.git', 'package.json', 'node_modules' }
  local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

  -- Fallback to current directory if no root found
  if not root_dir then
    root_dir = vim.fn.getcwd()
  end

  local editorconfig_path = root_dir .. '/.editorconfig'

  -- Check if .editorconfig already exists
  if vim.fn.filereadable(editorconfig_path) == 1 then
    print('.editorconfig already exists at: ' .. editorconfig_path)
    return
  end

  -- Simple content
  local content = {
    'root = true',
    '',
    '[*]',
    'insert_final_newline = true',
    'indent_style = space',
    'indent_size = 2',
    'charset = utf-8',
  }

  -- Write the file
  vim.fn.writefile(content, editorconfig_path)
  print('Created .editorconfig at: ' .. editorconfig_path)
end, { desc = 'Create .editorconfig in project root' })
