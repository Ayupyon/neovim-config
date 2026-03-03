local M = {}

--- 通用lsp配置
local nvlsp = require "nvchad.configs.lspconfig"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    nvlsp.on_attach(_, bufnr)
    if client:supports_method("textDocument/inlayHint", bufnr) then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    if client:supports_method("textDocument/codeLens", bufnr) then
      vim.lsp.codelens.refresh { bufnr = bufnr }
      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh { bufnr = bufnr }
        end,
      })
    end
  end,
})

vim.lsp.config("*", {
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})

--- 单独lsp配置
M.ensure_installed = {}

local configs = {
  "cpp",
  "rust",
  "lua",
  "html",
  "css",
  "python",
  "typst",
  "go",
}

local prefix = "configs.lsp."

for _, name in ipairs(configs) do
  local config = require(prefix .. name)
  table.insert(M.ensure_installed, config.name)
  vim.lsp.config(config.name, config.config)
end

return M
