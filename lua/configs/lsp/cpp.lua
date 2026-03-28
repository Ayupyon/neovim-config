return {
  name = "clangd",
  config = {
    settings = {
      clangd = {
        -- Enable semantic tokens
        semanticTokens = true,
        cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
        init_options = {
          fallbackFlags = { "-std=c++17" },
        },
      },
    },
  },
}
