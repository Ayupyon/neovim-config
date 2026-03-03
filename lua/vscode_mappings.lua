local map = vim.keymap.set
local vscode = require('vscode')

-- 1. 基础编辑体验增强
map('n', 'x', '"_x') -- x 不删入剪贴板
-- map('i', 'jk', '<ESC>') -- jk退出编辑模式 -- 这个需要在vscode中设置
map("n", ";", ":", { desc = "CMD enter command mode" })

-- 2. 调用 VSCode 原生功能 (替代复杂的 Vim 插件)
-- 快速搜索文件
map('n', '<leader>ff', function() vscode.action('workbench.action.quickOpen') end)
-- 全局搜索文本
map('n', '<leader>fg', function() vscode.action('workbench.action.findInFiles') end)
-- 显示代码大纲 (类似 Tagbar)
map('n', '<leader>o', function() vscode.action('outline.focus') end)
-- 代码重命名
map('n', '<leader>rn', function() vscode.action('editor.action.rename') end)
-- 格式化代码
map('n', '<leader>f', function() vscode.action('editor.action.formatDocument') end)
-- 向后跳转
map('n', '<leader>nb', function() vscode.action('workbench.action.navigateBack') end)
-- 向前跳转
map('n', '<leader>nf', function() vscode.action('workbench.action.navigateForward') end)

