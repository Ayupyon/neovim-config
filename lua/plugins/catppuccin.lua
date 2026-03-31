---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavor = "mocha",
        no_italic = true,
      }
      vim.cmd "colorscheme catppuccin-nvim"
    end,
  },
}
