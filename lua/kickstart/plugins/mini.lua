return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Move any selection in any direction
    --
    -- 'v' to enter visual mode and select items
    -- 'V' to select the whole line
    -- <M-{h,j,k,l}> to move the stuff around
    require('mini.move').setup {
      mappings = {
        -- left = '',
        -- right = '',
        -- line_left = '',
        -- line_right = '',
      },
    }

    -- Set up dashboard
    require('mini.starter').setup()
  end,
}
