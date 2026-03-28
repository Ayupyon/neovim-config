# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration repository. It was previously based on NvChad but has been refactored to a standalone setup.

## Architecture

The configuration has a **dual-mode design**:
- **Native Neovim mode**: Uses lazy.nvim to load plugins from `lua/plugins/`
- **VSCode mode**: Uses vscode-neovim integration with settings in `lua/configs/vscode/`

The mode is detected in `init.lua` by checking `vim.g.vscode`.

## Directory Structure

- `init.lua` - Entry point, sets leader key and loads either VSCode or native config
- `lua/options.lua` - Neovim options (cursorline, listchars, termguicolors, clipboard handling)
- `lua/mappings.lua` - Global key mappings (leader key is Space)
- `lua/plugins/` - Individual plugin specifications using lazy.nvim spec format
- `lua/configs/lazy.lua` - lazy.nvim configuration (disables many default plugins for performance)
- `lua/configs/lsp/init.lua` - Loads LSP configs for: cpp, rust, lua, html, css, python, typst, go
- `lua/configs/lsp/*.lua` - Language-specific LSP server configurations
- `lua/configs/vscode/` - VSCode-specific options and mappings

## Key Mappings (Native Neovim)

- `<Space>` - Leader key
- `;` - Enter command mode
- `jj` - Escape in insert mode
- `<C-s>` - Save
- `<C-z>` - Undo
- `<C-y>` - Redo
- `<C-_>` - Toggle comment
- `gb` - Jump back
- `gf` - Jump forward
- `gh` - LSP hover
- `ge` - Show diagnostics
- `<A-.>` - LSP code action
- `<leader>ff` - Telescope find files
- `<leader>fg` - Telescope live grep
- `<leader>fb` - Telescope buffers
- `<leader>fh` - Telescope help tags
- `<leader>?` - Show which-key popup

## VSCode-Specific Mappings

When running as VSCode extension, mappings call VSCode native actions instead of plugins:
- `<leader>ff` - Quick open
- `<leader>fg` - Find in files
- `<leader>o` - Focus outline
- `<leader>rn` - Rename
- `<leader>f` - Format document
- `gi` - Go to implementation
- `gI` - Peek implementation

## Code Style

- Format with StyLua (120 char width, 2 spaces, double quotes)
- Configured in `.stylua.toml`
- Plugin specs use LazySpec type annotations (---@type LazySpec)

## Adding a New Plugin

1. Create `lua/plugins/<plugin-name>.lua` with lazy.nvim spec format
2. Follow existing pattern: return `{ "owner/repo", opts = {...} }`

## Adding LSP Support

1. Create `lua/configs/lsp/<language>.lua` returning `{ name = "...", config = {...} }`
2. Add language to the list in `lua/configs/lsp/init.lua`

## Clipboard Handling

The config auto-detects SSH vs local usage:
- SSH (via `SSH_TTY`): Uses OSC 52 for clipboard
- Local: Uses system clipboard via `unnamedplus`