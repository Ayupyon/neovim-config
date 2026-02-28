return {
  name = "rust_analyzer",
  config = {
    settings = {
      ["rust-analyzer"] = {
        inlayHints = {
          typeHints = {
            enable = true,
          },
        },
      },
    },
  },
}
