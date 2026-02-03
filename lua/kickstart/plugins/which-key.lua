return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = 'modern',
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- Document existing key chains
    spec = {
      {
        '<leader>c',
        group = '[C]ode',
        mode = { 'n', 'x' },
        icon = {
          icon = '',
          color = 'purple',
        },
      },
      {
        '<leader>S',
        group = '[S]nippet',
        mode = { 'n', 'x' },
        icon = {
          icon = '',
          color = 'green',
        },
      },
      {
        '<leader>n',
        group = '[N]eorg',
        mode = { 'n' },
        icon = {
          icon = '',
          color = 'purple',
        },
      },
      {
        '<leader>l',
        group = '[L]ist',
        mode = { 'n' },
        icon = {
          icon = '',
          color = 'purple',
        },
      },
      {
        '<leader>i',
        group = '[I]nsert',
        mode = { 'n' },
        icon = {
          icon = '',
          color = 'purple',
        },
      },
      {
        '<leader>cc',
        group = '[C]olors',
        mode = { 'n', 'x' },
        icon = {
          icon = '',
          color = 'purple',
        },
      },
      {
        '<leader>a',
        group = '[A]PI testing',
        mode = { 'n' },
        icon = {
          icon = '',
          color = 'purple',
        },
      },
      {
        '<leader>p',
        group = '[P]ersistence sessions',
        icon = {
          icon = '󰅒',
          color = 'yellow',
        },
      },
      { '<leader>d', group = '[D]ocument', icon = {
        icon = '󰈔',
      } },
      { '<leader>r', group = '[R]ename', icon = {
        icon = '󰑕',
        color = 'blue',
      } },
      { '<leader>s', group = '[S]earch', icon = {
        icon = '',
        color = 'green',
        mode = { 'n', 'v' },
      } },
      { '<leader>w', group = '[W]indow Management', icon = {
        icon = '',
      } },
      { '<leader>t', group = '[T]oggle', icon = {
        icon = '󰔡',
        color = 'yellow',
      } },
      { '<leader>x', group = 'Fi[x] Trouble', mode = { 'n', 'v' }, icon = {
        icon = '󰁨',
      } },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      {
        '<leader>g',
        group = '[G]it commands',
        icon = {
          icon = '󰊢',
          color = 'orange',
        },
      },
      {
        '<leader>b',
        group = '[B]uffer Management',
        icon = {
          icon = '󰓩',
          color = 'blue',
        },
      },
    },
  },
}
