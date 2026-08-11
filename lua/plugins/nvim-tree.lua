return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        filters = {
          dotfiles = false,
          git_ignored = false,
        },

        update_focused_file = {
          enable = true,
          update_root = false,
        },

        sync_root_with_cwd = true,
        respect_buf_cwd = true,
      }

      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
    end,
  },
}
