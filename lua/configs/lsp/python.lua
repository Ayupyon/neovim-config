return {
  name = "pyright",
  config = {
    settings = {
      python = {
        -- Enable semantic tokens (pyright supports this by default)
        analysis = {
          typeCheckingMode = "basic",
        },
      },
    },
  },
}
