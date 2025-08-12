return {
  'AckslD/nvim-neoclip.lua',
  lazy = false,
  requires = {
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('neoclip').setup {
      keys = {
        telescope = {
          n = {
            replay = 'rp',
          },
        },
      },
    }
    require('telescope').load_extension 'neoclip'
  end,
}
