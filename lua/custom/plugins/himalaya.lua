return {
  'himalaya.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  dev = true,
  -- Disable lazy loading if you want to use Himalaya when vim starts, i.e, `nvim +':Himalaya'`
  lazy = false,
  opts = {
    icons_enabled = true,
    wrap_folder_navigation = false, -- wrap to first/last when navigating
    keymaps = {
      listing = {
        ['s'] = 'folder_picker',
        ['r'] = function() require('himalaya.folder').reload() end,
        ['gr'] = 'none',
      },
    },
  },
  keys = {
    { '<leader>oh', '<Cmd>Himalaya<CR>', desc = '[O]pen [H]imalaya' },
  },
}

-- return {
--   'knownasnaffy/himalaya.nvim',
--   dependencies = { 'MunifTanjim/nui.nvim' },
--   opts = {
--     icons_enabled = true, -- enable nerd font icons
--   },
--   keys = {
--     { '<leader>oh', '<Cmd>Himalaya<CR>', desc = '[O]pen [H]imalaya' },
--   },
-- }
--
