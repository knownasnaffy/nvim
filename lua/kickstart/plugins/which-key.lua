return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'modern',
    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 0,

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
