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
opt.scrolloff = 5

local spgroup = vim.api.nvim_create_augroup("SPGroup", {})

-- Custom tab width for certain files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = spgroup,
  pattern = { "*.lua" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})

-- Put the Cursor in the position where it was before closing the file the last time
vim.api.nvim_create_autocmd("BufReadPost", {
  group = spgroup,
  pattern = "*",
  callback = function()
    local line = vim.fn.line
    if line "'\"" > 0 and line "'\"" <= line "$" then
      vim.cmd [[ normal! g`" ]]
    end
  end,
})
