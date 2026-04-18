return {
  name = "clangd",
  cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
  init_options = {
    fallbackFlags = { "-std=c++17" },
  },
  config = {
    settings = {
      clangd = {
        -- Enable semantic tokens
        semanticTokens = true,
      },
    },
  },
}
