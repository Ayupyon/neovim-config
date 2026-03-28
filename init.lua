local function set_leader()
  vim.g.mapleader = " "
end

local function set_vscode()
  require "configs.vscode.options"
  vim.schedule(function()
    require "configs.vscode.mappings"
  end)
end

local function set_lazy()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
  end

  vim.opt.rtp:prepend(lazypath)

  local lazy_config = require "configs.lazy"
  require("lazy").setup({
    spec = { import = "plugins" },
  }, lazy_config)
end

set_leader()

if vim.g.vscode then
  set_vscode()
else
  set_lazy()

  require "options"
  require "tab"

  vim.schedule(function()
    require "mappings"
  end)
end
