local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "LSP show diagnostics" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, bufnr)
  end,
})

-- workaround for nvim 0.12 removed :Lsp* commands which also removed :LspLog to check lsp log
-- conveniently.
vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.tabnew(vim.lsp.log.get_filename())
end, {
  desc = "Opens the Nvim LSP client log",
})

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
  vim.lsp.config(config.name, config.config)
  vim.lsp.enable(config.name)
end

vim.lsp.log.set_level("debug")
