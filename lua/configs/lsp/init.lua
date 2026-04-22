local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- 代码补全
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits", "sortText", "filterText" },
    },
  }

  -- 文本同步
  capabilities.textDocument.synchronization = {
    dynamicRegistration = true,
    didSave = true,
    willSave = true,
    willSaveWaitUntil = true,
  }

  -- 诊断
  capabilities.textDocument.publishDiagnostics = {
    tagSupport = { valueSet = { 1, 2 } },
    versionSupport = true,
    codeDescriptionSupport = true,
    dataSupport = true,
  }

  -- 禁用 dynamicRegistration
  capabilities.textDocument.synchronization = {
    didSave = true,
    dynamicRegistration = false, -- 关键！
    willSave = false,
    willSaveWaitUntil = false,
  }

  -- 悬停提示
  capabilities.textDocument.hover = {
    dynamicRegistration = true,
    contentFormat = { "markdown", "plaintext" },
  }

  -- 代码操作
  capabilities.textDocument.codeAction = {
    dynamicRegistration = true,
    codeActionLiteralSupport = {
      codeActionKind = {
        valueSet = {
          "quickfix",
          "refactor",
          "refactor.extract",
          "refactor.inline",
          "refactor.rewrite",
          "source",
          "source.organizeImports",
        },
      },
    },
    resolveSupport = {
      properties = { "edit", "command" },
    },
  }

  -- 集成 cmp 能力
  -- local cmp_nvim_lsp = require('cmp_nvim_lsp')
  -- capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  return capabilities
end

local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- ========== 基础快捷键 ==========
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

  -- ========== 编辑快捷键 ==========
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- ========== 诊断快捷键 ==========
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, opts)
  vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

  -- ========== 范围格式化 ==========
  if client:supports_method "textDocument/rangeFormatting" then
    vim.keymap.set("x", "<leader>fw", function()
      vim.lsp.buf.format { async = false }
    end, opts)
  end

  -- ========== 代码透镜（如果支持）==========
  if client:supports_method "textDocument/codeLens" then
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("LspCodeLens_" .. bufnr, {}),
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.enable()
      end,
    })

    vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
  end

  -- ========== 内联提示（Neovim 0.10+）==========
  if vim.lsp.inlay_hint then
    if client:supports_method "textDocument/inlayHint" then
      vim.keymap.set("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, opts)
    end
  end

  -- ========== 自定义快捷键 ==========
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
end

local capabilities = get_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, bufnr)
  end,
})

vim.lsp.config("*", {
  capabilities = capabilities,
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
end
