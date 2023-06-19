---@type ChadrcConfig
local M = {}
M.ui = {
  theme = "catppuccin",
  tabufline = {
    lazyload = false,
    overriden_modules = function()
      return {
        buttons = function()
          return ""
        end,
      }
    end,
  },
}
M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"
return M
