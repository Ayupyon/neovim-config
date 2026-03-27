---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = "VimEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "mason-org/mason.nvim", opts = {} },
    },
    opts = function()
      local mod = require "configs.lsp.init"
      return {
        -- ensure_installed = mod.ensure_installed,
      }
    end,
  },
}
