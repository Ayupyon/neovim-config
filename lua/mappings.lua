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

-- Clear search highlight with ESC
map("n", "<ESC>", "<cmd> nohlsearch <cr>", { desc = "clear search highlight" })
