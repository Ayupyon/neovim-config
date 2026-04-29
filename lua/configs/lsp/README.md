# neovim lsp配置踩坑

## C++相关

+ clangd默认识别项目根目录的`compile_commands.json`文件，所以如果`compile_commands.json`文件默认被生成在其他位置，需要使用软链接将其链接到项目根目录。

  ```sh
  ln -s compile_commands.json /path/to/compile_commands.json
  ```

  参考：https://github.com/neovim/nvim-lspconfig/blob/master/lsp/clangd.lua

## Python相关

+ pyright默认可以识别项目根目录下的`.venv`虚拟环境，如果虚拟环境在其他路径可以通过`pyproject.toml`的`[tool.pyright]`选项或者`pyrightconfig.json`指定`venvPath`和`venv`字段，`venvPath`指定根目录，`venv`指定虚拟环境所在文件夹，pyright查找虚拟环境时会拼接`venv`到`venvPath`中。
