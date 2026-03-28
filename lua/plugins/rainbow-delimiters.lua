---@type LazySpec
return {
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      if vim.o.background == "dark" then
        vim.cmd [[
          highlight clear RainbowDelimiterRed
          highlight RainbowDelimiterRed guifg=#f38ba8
          highlight clear RainbowDelimiterYellow
          highlight RainbowDelimiterYellow guifg=#fae3b0
          highlight clear RainbowDelimiterBlue
          highlight RainbowDelimiterBlue guifg=#89b4fa
          highlight clear RainbowDelimiterOrange
          highlight RainbowDelimiterOrange guifg=#f8bd96
          highlight clear RainbowDelimiterGreen
          highlight RainbowDelimiterGreen guifg=#abe9b3
          highlight clear RainbowDelimiterViolet
          highlight RainbowDelimiterViolet guifg=#cba6f7
          highlight clear RainbowDelimiterCyan
          highlight RainbowDelimiterCyan guifg=#89dceb
        ]]
      else
        vim.cmd [[
          highlight clear RainbowDelimiterRed
          highlight RainbowDelimiterRed guifg=#de2c2e
          highlight clear RainbowDelimiterYellow
          highlight RainbowDelimiterYellow guifg=#b08800
          highlight clear RainbowDelimiterBlue
          highlight RainbowDelimiterBlue guifg=#015cc5
          highlight clear RainbowDelimiterOrange
          highlight RainbowDelimiterOrange guifg=#d15704
          highlight clear RainbowDelimiterGreen
          highlight RainbowDelimiterGreen guifg=#18654b
          highlight clear RainbowDelimiterViolet
          highlight RainbowDelimiterViolet guifg=#5b32a3
          highlight clear RainbowDelimiterCyan
          highlight RainbowDelimiterCyan guifg=#0798bc
        ]]
      end

      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = "rainbow-delimiters.strategy.global",
          vim = "rainbow-delimiters.strategy.local",
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
}
