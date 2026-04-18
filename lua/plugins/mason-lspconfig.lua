---@type LazySpec
return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = "VimEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "mason-org/mason.nvim", opts = {} },
    },
    opts = function()
      -- local mod = require "configs.lsp.init"
      return {}
    end,
  },
}
