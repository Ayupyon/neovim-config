---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          'cpp',
          'go',
          'python',
          'bash',
          'lua',
          'rust',
          'javascript',
          'typescript',
          'html',
          'css',
          'json',
          'yaml'
        },
        callback = function()
            vim.treesitter.start()
        end,
      })
    end
  },
}
