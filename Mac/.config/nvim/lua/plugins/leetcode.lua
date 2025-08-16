return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html', -- if you have `nvim-treesitter` installed
  dependencies = {
    -- include a picker of your choice, see picker section for more details
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('leetcode').setup {
      cmd = 'Leet',
    }

    vim.keymap.set('n', '<leader>ld', '<CMD>Leet desc<CR>', { desc = 'Toggle Leetcode Description' })
  end,
}
