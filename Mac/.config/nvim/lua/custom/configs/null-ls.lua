local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
-- local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier,
  formatting.stylua,
  formatting.yapf,
  formatting.isort,
}

-- Format on Save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,

  sources = sources,
}
