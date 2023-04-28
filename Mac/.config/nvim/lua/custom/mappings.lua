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
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
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
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Window left" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Window up" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Window right" },
  },
}

return M
