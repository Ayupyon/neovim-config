local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "file save" })
map({ "n", "i", "v" }, "<C-z>", "<cmd> undo <cr>", { desc = "history undo" })
map({ "n", "i", "v" }, "<C-y>", "<cmd> redo <cr>", { desc = "history redo" })
map("n", "<C-_>", "gcc", { desc = "comment toggle", remap = true })
map("i", "<C-_>", "<Esc>gcc^i", { desc = "comment toggle", remap = true })
map("v", "<C-_>", "gc", { desc = "comment toggle", remap = true })

-- Clipboard mappings for SSH (y to system clipboard)
-- map({ "n", "v" }, "y", '"+y', { desc = "yank to system clipboard" })
-- map("n", "yy", '"+yy', { desc = "yank line to system clipboard" })
-- map("v", "Y", '"+Y', { desc = "yank to system clipboard" })

map("n", "gb", "<C-o>", { desc = "jump back" })
map("n", "gf", "<C-i>", { desc = "jump forward" })
map("n", "gh", vim.lsp.buf.hover, { desc = "LSP hover" }) -- 等同于 `K`
map("n", "ge", vim.diagnostic.open_float, { desc = "LSP show diagnostics" }) -- 唤出诊断信息，这个没有默认快捷键，我推荐大家都映射一下
map({ "n", "i", "v" }, "<A-.>", vim.lsp.buf.code_action, { desc = "LSP code action" }) -- 唤出代码操作（由于 Vim/Neovim 中对 `Ctrl-.` 的映射有些问题，这里用 Alt 替代）

-- Clear search highlight with ESC
map("n", "<ESC>", ":nohlsearch<CR>", { desc = "clear search highlight" })
