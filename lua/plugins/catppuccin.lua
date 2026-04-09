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
        highlight_overrides = {
          mocha = function(mocha)
            return {
              -- fix for cpp treesitter bug
              ["@lsp.typemod.variable.functionScope.cpp"] = {
                fg = mocha.text,
              },
            }
          end,
        },
      }
      vim.cmd "colorscheme catppuccin-nvim"
    end,
  },
}
