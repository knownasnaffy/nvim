return {
  'booperlv/nvim-gomove',
  keys = {
    {
      '<A-j>',
      '<Plug>GoNSMLeft',
    },
    {
      '<A-k>',
      '<Plug>GoNSMDown',
    },
    {
      '<A-l>',
      '<Plug>GoNSMUp',
    },
    {
      '<A-;>',
      '<Plug>GoNSMRight',
    },
    {
      '<A-j>',
      '<Plug>GoVSMLeft',
      mode = 'x',
    },
    {
      '<A-k>',
      '<Plug>GoVSMDown',
      mode = 'x',
    },
    {
      '<A-l>',
      '<Plug>GoVSMUp',
      mode = 'x',
    },
    {
      '<A-;>',
      '<Plug>GoVSMRight',
      mode = 'x',
    },
    {
      '<A-S-k>',
      '<Plug>GoNSDDown',
    },
    {
      '<A-S-l>',
      '<Plug>GoNSDUp',
    },
    {
      '<A-S-k>',
      '<Plug>GoVSDDown',
      mode = 'x',
    },
    {
      '<A-S-l>',
      '<Plug>GoVSDUp',
      mode = 'x',
    },
  },
  opts = {
    -- whether or not to map default key bindings, (true/false)
    map_defaults = false,
    -- whether or not to reindent lines moved vertically (true/false)
    reindent = true,
    -- whether or not to undojoin same direction moves (true/false)
    undojoin = true,
    -- whether to not to move past end column when moving blocks horizontally, (true/false)
    move_past_end_col = true,
  },
}
