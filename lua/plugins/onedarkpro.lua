---@type LazySpec
return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      -- require("onedarkpro").setup {
      --   highlights = {
      --     ["@function.builtin"] = {},
      --     ["@lsp.mod.mutable.rust"] = {
      --       underline = true,
      --     },
      --   },
      --
      --   styles = {},
      -- }
      --
      -- vim.cmd "colorscheme onedark"
    end,
  },
}
