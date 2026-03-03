---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "go",      -- Go 核心
        "gomod",   -- go.mod
        "gosum",   -- go.sum
        "gowork",  -- go.work (多模块工作区)
        "asm",     -- 汇编（阅读 runtime 必装）
        "make",    -- 阅读 Makefile
        "markdown", -- 阅读源码中的文档说明
        "rust",
        "cpp",
        "python",
      },
      highlight = {
        enable = true, -- 开启高亮
        additional_vim_regex_highlighting = false,
      },
    },
  },

  { -- Sticky scroll
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
}
