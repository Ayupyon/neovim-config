return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gitsigns = require "gitsigns"

        vim.keymap.set("n", "[h", function()
          gitsigns.nav_hunk("prev")
        end, { buffer = buffer, desc = "Previous Git hunk" })
        vim.keymap.set("n", "]h", function()
          gitsigns.nav_hunk("next")
        end, { buffer = buffer, desc = "Next Git hunk" })
        vim.keymap.set("n", "<leader>ph", gitsigns.preview_hunk, { buffer = buffer, desc = "Preview Git hunk" })
      end,
    },
  },
}
