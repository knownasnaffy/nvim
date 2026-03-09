---@diagnostic disable: undefined-global, undefined-doc-name
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>gB',
      function() Snacks.gitbrowse() end,
      desc = '[B]rowse file in git remote',
    },
    {
      '<M-q>',
      function() Snacks.bufdelete() end,
      desc = 'Delete current buffer',
    },
    {
      '<leader>.',
      function() Snacks.scratch() end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>oi',
      function() Snacks.image.hover() end,
      desc = 'Hover [O]ver the [I]mage the cursor is at',
    },

    -- Pickers
    { '<leader>sb', function() Snacks.picker.buffers() end, desc = 'Find Existing [B]uffers' },

    { '<leader><leader>', function() Snacks.picker.smart() end, desc = 'Smart search' },
    {
      '<leader>sf',
      function() Snacks.picker.files() end,
      desc = 'Search [F]iles',
    },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Search by [G]rep' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Search current [W]ord', mode = { 'n', 'x' } },
    { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Fuzzily search in current buffer' },
    { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = 'Search [/] in Open Files' },

    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'Search [R]esume' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Search [D]iagnostics' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Search [K]eymaps' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Search [H]elp' },
    { '<leader>sp', function() Snacks.picker.lazy() end, desc = 'Search Lazy [P]lugins' },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'Search [I]cons' },
    { '<leader>sm', function() Snacks.picker.man() end, desc = 'Search [M]an Pages' },
    { '<leader>sl', function() Snacks.picker.lsp_config() end, desc = 'Search [L]SP Configs' },

    { '<leader>sn', function()
      Snacks.picker.notifications {
        filter = 'trace',
      }
    end, desc = 'Search [N]otifications' },
    { '<leader>sN', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Search [N]eovim files' },
    { '<leader>ss', function() Snacks.picker.scratch() end, desc = 'Search [S]cratch buffers' },
    { '<leader>sS', function() Snacks.picker.pickers() end, desc = 'Search [S]nacks pickers' },
    { '<leader>sc', function() Snacks.picker.recent() end, desc = 'Search [C]losed Files' },

    -- Git related
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches {
          all = true,
          win = {
            input = {
              keys = {
                ['<M-a>'] = { 'git_branch_add', mode = { 'n', 'i' } },
                ['<M-S-d>'] = { 'git_branch_del', mode = { 'n', 'i' } },
              },
            },
          },
        }
      end,
      desc = 'Git [B]ranches',
    },
    { '<leader>gl', function() Snacks.picker.git_log { layout = { hidden = { 'preview' } } } end, desc = 'Git [L]og' },
    { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log [L]ine' },
    { '<leader>ge', function() Snacks.picker.git_status() end, desc = 'Git [S]tatus' },
    { '<leader>gs', function() Snacks.picker.git_stash() end, desc = 'Git [S]tash' },
    { '<leader>gD', function() Snacks.picker.git_diff() end, desc = 'Git [D]iff (Hunks)' },
    { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log [F]ile' },
  },
  config = function()
    require('snacks').setup {
      picker = {
        ui_select = true,
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
        win = {
          -- input window
          input = {
            keys = {
              ['<M-q>'] = { 'cancel', mode = 'i' },
              ['<M-Space>'] = { 'select_and_next', mode = { 'i', 'n' } },
              ['<M-S-Space>'] = { 'select_and_prev', mode = { 'i', 'n' } },
              ['<M-a>'] = { 'select_all', mode = { 'i', 'n' } },
              ['<M-w>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
              ['<M-k>'] = { 'list_down', mode = { 'i', 'n' } },
              ['<M-l>'] = { 'list_up', mode = { 'i', 'n' } },
              ['<M-h>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
              ['<M-i>'] = { 'toggle_ignored', mode = { 'i', 'n' } },
              ['<M-Tab>'] = { 'cycle_win', mode = { 'i', 'n' } },
              ['<M-b>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
              ['<M-f>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
              ['<M-S-k>'] = { 'list_scroll_down', mode = { 'i', 'n' } },
              ['<M-S-l>'] = { 'list_scroll_up', mode = { 'i', 'n' } },
              ['<M-s>'] = { 'edit_split', mode = { 'i', 'n' } },
              ['<M-S-s>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
              ['<M-r><M-a>'] = { 'insert_cWORD', mode = 'i' },
              ['<M-r><M-f>'] = { 'insert_file', mode = 'i' },
              ['<M-r><M-l>'] = { 'insert_line', mode = 'i' },
              ['<M-r><M-p>'] = { 'insert_file_full', mode = 'i' },

              ['k'] = 'list_down',
              ['l'] = 'list_up',
              ['j'] = { 'h', expr = true },
            },
            b = {
              minipairs_disable = true,
            },
          },
          -- preview window
          preview = {
            keys = {
              ['<M-Tab>'] = { 'cycle_win', mode = { 'i', 'n' } },
            },
          },
          -- result list window
          list = {
            keys = {
              ['<M-q>'] = 'cancel',
              ['<M-Tab>'] = { 'cycle_win', mode = { 'i', 'n' } },
              ['<M-Space>'] = { 'select_and_next', mode = { 'i', 'n' } },
              ['<M-S-Space>'] = { 'select_and_prev', mode = { 'i', 'n' } },
              ['j'] = { 'h', expr = true },
              ['k'] = 'list_down',
              ['l'] = 'list_up',
              ['<a-d>'] = 'inspect',
              ['<M-h>'] = 'toggle_hidden',
              ['<M-i>'] = 'toggle_ignored',
              ['<M-a>'] = 'select_all',
              ['<M-b>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
              ['<M-f>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
              ['<M-s>'] = { 'edit_split', mode = { 'i', 'n' } },
              ['<M-S-s>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
            },
            wo = {
              conceallevel = 2,
              concealcursor = 'nvc',
            },
          },
        },
      },
      buffdelete = { enabled = true },
      dashboard = {
        preset = {

          -- Command:
          -- figlet -f "DOS Rebel" -w 300 ::::::NOX::::::
          -- Needed to add the spacing between colons and letters manually
          -- This weird looking thing is the result of trying to fight trailing space vs centered layout
          header = [[




  ██████   █████    ███████    █████ █████
░░██████ ░░███   ███░░░░░███ ░░███ ░░███
 ░███░███ ░███  ███     ░░███ ░░███ ███
░███░░███░███ ░███      ░███  ░░█████
 ░███ ░░██████ ░███      ░███   ███░███
 ░███  ░░█████ ░░███     ███   ███ ░░███
  █████  ░░█████ ░░░███████░   █████ █████
░░░░░    ░░░░░    ░░░░░░░    ░░░░░ ░░░░░
]],
        },
        formats = {
          key = function(item) return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } } end,
        },
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 3, height = 23 },
        },
      },
      image = {
        enabled = false,
        doc = {
          inline = false,
          float = false,
        },
      },
      indent = {
        enabled = true,
        filter = function(buf)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == '' and vim.bo[buf].filetype ~= 'norg'
        end,
      },
      scroll = {
        animate = {
          duration = { step = 10, total = 100 },
          easing = 'linear',
        },
      },
      scope = {},
      -- notifier = { enabled = true },
      quickfile = { enabled = true },
      -- scroll = { enabled = true },
      statuscolumn = {
        enabled = true,
      },
      -- words = { enabled = true },
      terminal = { enabled = false },
      notifier = {},
    }
  end,
}
