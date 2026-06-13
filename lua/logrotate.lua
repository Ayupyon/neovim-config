--- asynchronously read last 100MB content of lsp log file
--- and write it back
local function async_rotate_lsp_log()
  local log_path = vim.lsp.log.get_filename()
  local MB = 1024 * 1024;
  local max_size = 100 * MB
  local uv = vim.loop

  uv.fs_stat(log_path, function(err, stat)
    if err or not stat or stat.size <= max_size then
      return
    end

    -- 438 is decimal representation of 0666 octal number,
    -- used for file premission
    uv.fs_open(log_path, "r", 438, function(open_err, fd)
      if open_err then
        return
      end

      -- read last 100MB from log file
      local offset = stat.size - max_size
      uv.fs_read(fd, max_size, offset, function(read_err, data)
        uv.fs_close(fd)
        if read_err or not data then
          return
        end

        -- write back to log file
        uv.fs_open(log_path, "w", 438, function(write_err, write_fd)
          if write_err then
            return
          end

          uv.fs_write(write_fd, data, 0, function(final_err)
            uv.fs_close(write_fd)
            if not final_err then
              vim.schedule(function()
                vim.notify("LSP log rotated (100MB kept) asynchronously.")
              end)
            end
          end)
        end)
      end)
    end)
  end)
end

-- only do lsp rotate when a neovim instance is launching
async_rotate_lsp_log()
