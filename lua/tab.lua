local function set_tab(size)
  local opt = vim.opt
  opt.shiftwidth = size
  opt.tabstop = size
  opt.softtabstop = size
  opt.expandtab = true
end

local function file_set_tab(patterns, size)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = patterns,
    callback = function ()
      set_tab(2)
    end
  })
end

file_set_tab({"lua"}, 2)

local M = {}
M.set_tab = set_tab
return M

