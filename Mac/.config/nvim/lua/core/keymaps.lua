-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function getOpts(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- jk to enter Normal mode
vim.keymap.set('i', 'jk', '<ESC>', getOpts 'Enter Nomrmal Mode')

-- save file
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', getOpts 'Save File with Formatting')

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w<CR>', getOpts 'Save File without Formatting')

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', getOpts 'Quit File')

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', getOpts 'Delete Character without Copying')

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', getOpts 'Page Down with cursor in the center')
vim.keymap.set('n', '<C-u>', '<C-u>zz', getOpts 'Page Up with cursor in the center')

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', getOpts 'Center Cursor when finding next occurrence')
vim.keymap.set('n', 'N', 'Nzzzv', getOpts 'Center Cursor when finding previous occurrence')

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', getOpts 'Goto Next Buffer')
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', getOpts 'Goto Previous Buffer')
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', getOpts 'Close Buffer')
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', getOpts 'Create New Buffer')

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', getOpts 'Split Window Vertically')
vim.keymap.set('n', '<leader>h', '<C-w>s', getOpts 'Split Window Horizontally')
vim.keymap.set('n', '<leader>se', '<C-w>=', getOpts 'Make Split Windows Equal Width and Height')
vim.keymap.set('n', '<leader>xs', ':close<CR>', getOpts 'Close Current Split Window')

-- Resize Splits
vim.keymap.set('n', '<A-Up>', ':resize +2<CR>', getOpts 'Resize Up')
vim.keymap.set('n', '<A-Down>', ':resize -2<CR>', getOpts 'Resize Down')
vim.keymap.set('n', '<A-Left>', ':vertical resize +2<CR>', getOpts 'Resize Left')
vim.keymap.set('n', '<A-Right>', ':vertical resize -2<CR>', getOpts 'Resize Right')

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', getOpts 'Toggle Line Wrap')

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', getOpts 'Stay in visual mode when indenting')
vim.keymap.set('v', '>', '>gv', getOpts 'Stay in visual mode when de-indenting')

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', getOpts 'Paste without copying')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
