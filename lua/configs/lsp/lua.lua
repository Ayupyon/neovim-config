local lua_ls_settings = {
  Lua = {
    hint = {
      enable = true,
      paramName = "Literal",
    },

    codeLens = {
      enable = true,
    },

    workspace = {
      maxPreload = 1000000,
      preloadFileSize = 10000,
    },
  },
}

-- If current working directory is Neovim config directory
local in_neovim_config_dir = (function()
  local stdpath_config = vim.fn.stdpath "config"
  local config_dirs = type(stdpath_config) == "string" and { stdpath_config } or stdpath_config
  ---@diagnostic disable-next-line: param-type-mismatch
  for _, dir in ipairs(config_dirs) do
    if vim.fn.getcwd():find(dir, 1, true) then
      return true
    end
  end
end)()

if in_neovim_config_dir then
  -- Add vim to globals for type hinting
  lua_ls_settings.Lua.diagnostic = lua_ls_settings.Lua.diagnostic or {}
  lua_ls_settings.Lua.diagnostic.globals = lua_ls_settings.Lua.diagnostic.globals or {}
  table.insert(lua_ls_settings.Lua.diagnostic.globals, "vim")

  -- Add all plugins installed with lazy.nvim to `workspace.library` for type hinting
  lua_ls_settings.Lua.workspace.library = vim.list_extend({
    vim.fn.expand "$VIMRUNTIME/lua",
    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
    "${3rd}/busted/library", -- Unit testing
    "${3rd}/luassert/library", -- Unit testing
    "${3rd}/luv/library", -- libuv bindings (`vim.uv`)
  }, vim.fn.glob(vim.fn.stdpath "data" .. "/lazy/*", true, true))
end

return {
  name = "lua_ls",
  config = {
    settings = lua_ls_settings,
  },
}
