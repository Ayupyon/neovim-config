---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    event = "VimEnter",
    opts = {},
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  },
}
