local function rotate_lsp_log()
  local log_path = vim.lsp.get_log_path()
  local cmd = string.format("tail -c %dM %s > %s.tmp && mv %s.tmp %s", 100, log_path, log_path, log_path, log_path)
  vim.fn.jobstart(cmd, { detach = true })
end

-- 在 Neovim 启动时执行一次
rotate_lsp_log()
