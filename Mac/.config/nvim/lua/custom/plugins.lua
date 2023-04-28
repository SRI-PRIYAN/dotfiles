local plugins = {
  --------------------------- Configuring Existing Plugins ---------------------------
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        file_ignore_patterns = { "node_modules", ".git" },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua", "c", "cpp", "java", "python" },
    },
  },

  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "pyright",
        "prettier",
        "stylua",
        "yapf",
        "isort",
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
  },

  {
    "NvChad/nvterm",
    enabled = false,
  },

  --------------------------------- Custom Plugins ------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<leader>`", "<CMD>ToggleTerm<CR>", desc = "ToggleTerm" },
    },
    config = function()
      require "custom.configs.toggleterm"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}

return plugins
