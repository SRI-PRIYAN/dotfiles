---@type ChadrcConfig
local M = {}
M.ui = {
  theme = "catppuccin",
  tabufline = {
    lazyload = false,
  },
}
M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"
return M
