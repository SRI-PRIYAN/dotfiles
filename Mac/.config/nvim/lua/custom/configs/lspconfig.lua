local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.textDocument.completion.completionItem = {
  snippetSupport = false,
}

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- general conifgs
local servers = { "clangd" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- specialized configs
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      pythonPath = "/opt/homebrew/bin/python3.10",
    },
  },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),

  settings = {
    gopls = {
      completeUnimported = true,

      analyses = {
        unusedparams = true,
      },
    },
  },
}
