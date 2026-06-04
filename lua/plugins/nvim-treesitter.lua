local common_parsers = {
  "cpp",
  "go",
  "python",
  "bash",
  "lua",
  "rust",
  "javascript",
  "typescript",
  "html",
  "css",
  "json",
  "yaml",
  "typst",
  "markdown",
  "toml",
}

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = common_parsers,
        callback = function()
          vim.treesitter.start()
        end,
      })

      vim.api.nvim_create_user_command("TSInstallCommon", function()
        -- Print a message so you know it started
        vim.notify("Installing common Tree-sitter parsers...", vim.log.levels.INFO)

        -- Pass the list of parsers to the TSInstall command
        vim.cmd("TSInstall " .. table.concat(common_parsers, " "))
      end, { desc = "install common treesitters" })
    end,
  },
}
