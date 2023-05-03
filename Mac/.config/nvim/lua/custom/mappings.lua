local M = {}

M.disabled = {
  n = {
    ["<C-n>"] = "",
    ["<leader>n"] = "",
  },
}

M.general = {
  n = {
    ["<C-y>"] = { '"+y', "yank to the system clipboard" },
  },

  v = {
    ["<C-y>"] = { '"+y', "yank to the system clipboard" },
  },

  i = {
    ["jk"] = { "<ESC>", "Enter normal mode" },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<CMD> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.toggleterm = {
  t = {
    ["jk"] = { [[<C-\><C-n>]], "Enter normal terminal mode" },
    ["<C-h>"] = { [[<C-\><C-n><C-W>h]], "Window left" },
    ["<C-j>"] = { [[<C-\><C-n><C-W>j]], "Window down" },
    ["<C-k>"] = { [[<C-\><C-n><C-W>k]], "Window up" },
    ["<C-l>"] = { [[<C-\><C-n><C-W>l]], "Window right" },
  },
}

M.vim_tmux_navigator = {
  n = {
    ["<C-h>"] = { "<CMD>TmuxNavigateLeft<CR>", "Window left" },
    ["<C-j>"] = { "<CMD>TmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<CMD>TmuxNavigateUp<CR>", "Window up" },
    ["<C-l>"] = { "<CMD>TmuxNavigateRight<CR>", "Window right" },
  },
}

M.undotree = {
  n = {
    ["<leader>u"] = { "<CMD>UndotreeToggle<CR>", "Toggle Undotree" },
  },
}

return M
