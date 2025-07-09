return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          enabled = false,
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'folke/lazydev.nvim',
    'moyiz/blink-emoji.nvim',
  },
  --- @module 'blink.cmp'Add commentMore actions
  --- @type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains({ 'norg' }, vim.bo.filetype)
    end,
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --Add commentMore actions
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'none',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:Add commentMore actions
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      ['<M-Space>'] = { 'show', 'show', 'hide_documentation' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<S-CR>'] = { 'fallback' },
      ['<M-e>'] = { 'cancel', 'fallback' },
      ['<M-k>'] = { 'select_next', 'fallback' },
      ['<M-l>'] = { 'select_prev', 'fallback' },
      ['<M-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<M-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<M-i>'] = { 'snippet_forward', 'fallback' },
      ['<M-o>'] = { 'snippet_backward', 'fallback' },
    },

    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = false } },
      sources = { 'cmdline' },
    },

    term = {
      enabled = false,
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = {
        -- Automatically show the completion menu
        auto_show = false,

        -- nvim-cmp style menu
        draw = {
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind', gap = 1 },
          },
        },
      },

      ghost_text = { enabled = true, show_with_menu = false },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev', 'emoji' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        emoji = {
          module = 'blink-emoji',
          name = 'Emoji',
          score_offset = 15, -- Tune by preference
          opts = {
            insert = true, -- Insert emoji (default) or complete its name
            ---@type string|table|fun():table
            trigger = function()
              return { ':' }
            end,
          },
          should_show_items = function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
              { 'gitcommit', 'markdown' },
              vim.o.filetype
            )
          end,
        },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = {
      sorts = {
        'exact',
        -- defaults
        'score',
        'sort_text',
      },
      implementation = 'prefer_rust_with_warning',
    },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
