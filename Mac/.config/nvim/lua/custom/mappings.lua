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
    ["J"] = { ":m '>+1<CR>gv=gv", "Move the visual selection down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move the visual selection up" },
    ["<"] = { "<gv", "Keep Visual Selection while indenting" },
    [">"] = { ">gv", "Keep Visual Selection while indenting" },
  },

  i = {
    ["jk"] = { "<ESC>", "Enter normal mode" },
  },
}

M.telescope = {
  n = {
    ["<leader>cb"] = { "<CMD>Telescope neoclip<CR>", "Open Clipboard" },
  },
}

M.tabufline = {
  n = {
    ["<tab>"] = { "<CMD>bnext<CR>", "Goto next buffer" },
    ["<S-tab>"] = { "<CMD>bprevious<CR>", "Goto prev buffer" },
    ["<leader>x"] = { "<CMD>bdelete<CR>", "Close buffer" },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<CMD>NvimTreeToggle<CR>", "toggle nvimtree" },
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
