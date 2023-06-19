local opt = vim.opt
local g = vim.g

g.undotree_WindowLayout = 2
g.undotree_SetFocusWhenToggle = true

opt.number = true
opt.relativenumber = true
opt.clipboard = ""

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

local augroup = vim.api.nvim_create_augroup("SPGroup", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup,
  pattern = { "*.lua" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})
