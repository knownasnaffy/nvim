return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<M-s>',
      '<Cmd>w<CR>',
      desc = 'Save buffer',
    },
  },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        astro = { 'prettier' },
        lua = { 'stylua' },

        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },

        json = { 'prettier' },
        jsonc = { 'prettier' },

        css = { 'prettier' },
        html = { 'prettier' },
        yaml = { 'prettier' },

        toml = { 'taplo' },

        python = { 'black' },

        dart = { 'dart_format' },

        cpp = { 'clang_format' },

        sh = { 'beautysh' },

        qml = { 'qmlformat' },

        go = { 'gofmt' },

        rust = { 'rustfmt' },

        xml = { 'xmlformat' },
      },

      format_on_save = {
        timeout_ms = 1000,
        lsp_format = 'fallback',
      },
    }
  end,
}
