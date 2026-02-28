require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local opt = vim.opt

--- 允许workspace local config
opt.exrc = true

--- Windows下使用PowerShell作为默认Shell
--- Use PowerShell as default Shell on Windows
if vim.fn.has "win32" == 1 then
  opt.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
  opt.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
  opt.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
  opt.shellpipe = '2>&1 | %{ "$_" } | tee %s; exit $LastExitCode'
  opt.shellquote = ""
  opt.shellxquote = ""
end

--- Common
-- NvChad 默认只设置高亮当前行的行号，这里把整行也高亮了
opt.cursorlineopt = "both"

-- 显示特殊字符，比如尾随空格和 Tab
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- 用来控制你滚动时上下至少要在视图里保留多少行
opt.scrolloff = 10

-- 关闭line wrap
opt.wrap = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "plaintex", "typst" },
  callback = function()
    opt.wrap = true      -- 开启折行
    opt.linebreak = true -- 不在单词中间断开
  end,
})

--- 在SSH中启用OSC 52支持，不在SSH下则使用系统剪贴板
--- Enable OSC 52 for copying to system clipboard in SSH
-- See: https://github.com/neovim/neovim/issues/28611#issuecomment-2147744670
if os.getenv "SSH_TTY" then
  vim.g.clipboard = {
    name = "OSC 52",
    -- Try to use OSC 52 escape sequences to copy to system clipboard
    -- It should not break anything if it’s not supported
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy "+",
      ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    -- Disable paste since it does not work in some terminals,
    -- i.e., xterm.js (many app based on Web tech use this)
    paste = {
      ["+"] = function(lines)
        return vim.split(vim.fn.getreg '"', "\n")
      end,
      ["*"] = function(lines)
        return vim.split(vim.fn.getreg '"', "\n")
      end,
    },
  }
else
  opt.clipboard = "unnamedplus"
end
