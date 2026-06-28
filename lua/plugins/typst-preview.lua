local tinymist_bin_path = "tinymist"
if vim.fn.has "win32" == 1 then
  tinymist_bin_path = "tinymist.cmd"
end

---@type LazySpec
return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  opts = {
    dependencies_bin = {
      tinymist = tinymist_bin_path,
      websocat = nil
    },
  },
}
