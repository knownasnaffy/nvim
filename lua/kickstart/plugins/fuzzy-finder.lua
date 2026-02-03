return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    -- Lazy plugins related info
    'tsakirist/telescope-lazy.nvim',

    -- Emoji picker
    'nvim-telescope/telescope-symbols.nvim',

    'nvim-telescope/telescope-github.nvim',

    -- Images
    'dharmx/telescope-media.nvim',
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
      keys = {
        {
          '<leader>sg',
          ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
          desc = '[S]earch by [G]rep',
        },
      },
    },

    'crispgm/telescope-heading.nvim',

    'ggandor/leap.nvim',
  },
  config = function()
    local function get_targets(picker)
      local scroller = require 'telescope.pickers.scroller'
      local wininfo = vim.fn.getwininfo(picker.results_win)[1]
      local bottom = wininfo.botline - 2 -- skip the current row
      local top = math.max(scroller.top(picker.sorting_strategy, picker.max_results, picker.manager:num_results()), wininfo.topline - 1)
      local targets = {}
      for lnum = bottom, top, -1 do
        table.insert(targets, { wininfo = wininfo, pos = { lnum + 1, 1 } })
      end
      return targets
    end

    local function pick_with_leap(buf)
      local picker = require('telescope.actions.state').get_current_picker(buf)
      require('leap').leap {
        targets = get_targets(picker),
        action = function(target)
          picker:set_selection(target.pos[1] - 1)
          require('telescope.actions').select_default(buf)
        end,
      }
    end

    local function select_with_leap(buf)
      local picker = require('telescope.actions.state').get_current_picker(buf)
      require('leap').leap {
        targets = get_targets(picker),
        action = function(target)
          picker:set_selection(target.pos[1] - 1)
        end,
      }
    end

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        results_title = '',
        prompt_title = '',
        file_ignore_patterns = { '.git/', 'venv/', 'node_modules/', '.next/' },
        mappings = {
          i = {
            ['<M-l>'] = 'move_selection_previous',
            ['<M-k>'] = 'move_selection_next',
            ['<M-S-l>'] = 'results_scrolling_up',
            ['<M-S-k>'] = 'results_scrolling_down',
            ['<M-b>'] = 'preview_scrolling_up',
            ['<M-f>'] = 'preview_scrolling_down',
            ['<M-q>'] = 'close',
            ['<M-/>'] = 'which_key',
            ['<M-w>'] = { '<esc>vbda', type = 'command' },
            ['<M-p>'] = pick_with_leap,
            ['<M-P>'] = select_with_leap,
          },
          n = {
            ['<M-l>'] = 'move_selection_previous',
            ['<M-k>'] = 'move_selection_next',
            ['l'] = 'move_selection_previous',
            ['k'] = 'move_selection_next',
            [';'] = { 'l', type = 'command' },
            ['j'] = { 'h', type = 'command' },
            ['<M-b>'] = 'preview_scrolling_up',
            ['<M-f>'] = 'preview_scrolling_down',
            ['<M-q>'] = 'close',
            ['<M-/>'] = 'which_key',
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
        live_grep = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden', -- Search hidden files/folders
            '--glob',
            '!bun.lock',
            -- '--no-ignore', -- Ignore .gitignore/.ignore
          },
        },
        git_branches = {
          mappings = {
            i = {
              ['<M-A>'] = 'git_create_branch',
              ['<M-D>'] = 'git_delete_branch',
              ['<M-Y>'] = 'git_merge_branch',
              ['<M-S>'] = 'git_switch_branch',
            },
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_cursor(),
        },
        package_info = {
          -- Optional theme (the extension doesn't set a default theme)
          theme = 'dropdown',
        },
        -- Type information can be loaded via 'https://github.com/folke/lazydev.nvim'
        -- by adding the below two annotations:
        ---@module "telescope._extensions.lazy"
        ---@type TelescopeLazy.Config
        lazy = {
          mappings = {
            open_in_file_browser = '<M-S-O>',
            open_in_browser = '<M-o>',
            open_in_terminal = '<M-t>',
            open_in_live_grep = '<M-g>',
            open_in_find_files = '<M-S-F>',
            open_lazy_root_live_grep = '<M-r>g',
            open_lazy_root_find_files = '<M-r>f',
            change_cwd_to_plugin = '<M-c>',
          },
        },
        media = {
          backend = 'ueberzug',
          flags = {
            ueberzug = { xmove = -22, ymove = -3, warnings = true, supress_backend_warning = false },
          },
        },
        live_grep_args = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden', -- Search hidden files/folders
            '--glob',
            '!bun.lock',
            -- '--no-ignore', -- Ignore .gitignore/.ignore
          },
          mappings = {
            i = {
              ['<M-r>'] = require('telescope-live-grep-args.actions').quote_prompt(),
              ['<M-i>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' },
              -- freeze the current list and start a fuzzy search in the frozen list
              ['<M-space>'] = require('telescope-live-grep-args.actions').to_fuzzy_refine,
            },
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'gh')
    pcall(require('telescope').load_extension, 'media_files')
    pcall(require('telescope').load_extension, 'live_grep_args')
    pcall(require('telescope').load_extension, 'heading')
    require('http_codes').setup()
    -- pcall(require('telescope').load_extension 'rest')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sc', builtin.oldfiles, { desc = '[S]earch [C]losed Files' })
    vim.keymap.set('n', '<leader>se', function()
      builtin.symbols { sources = { 'emoji' } }
    end, { desc = '[S]earch [E]mojies' })

    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sN', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    vim.keymap.set('n', '<leader>sn', '<Cmd>Telescope notify<CR>', { desc = '[S]earch [N]otifications' })
    vim.keymap.set('n', '<leader>sl', '<Cmd>Telescope lazy<CR>', { desc = '[S]earch [L]azy Plugins' })
    vim.keymap.set('n', '<leader>sH', '<Cmd>Telescope heading<CR>', { desc = '[S]earch [H]eadings' })
  end,
}
