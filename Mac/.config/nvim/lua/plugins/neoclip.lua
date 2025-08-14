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
    vim.keymap.set('n', '<leader>cb', '<CMD>Telescope neoclip<CR>', { desc = 'Open Clipboard History' })
  end,
}
