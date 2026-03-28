return {
  name = "html",
  config = {
    settings = {
      html = {
        -- Enable semantic tokens (default for cssls/html, but explicitly set)
        suggest = {
          autoTags = true,
        },
      },
    },
  },
}
