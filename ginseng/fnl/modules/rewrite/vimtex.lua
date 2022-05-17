-- Editor settings
vim.g.tex_conceal = ""
vim.g.vimtex_fold_manual = 1
vim.g.tex_comment_nospell = 1

-- Compile & View methods
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_compiler_method = "tectonic"

-- vim.g.vimtex_compiler_tectonic = {
--   build_dir = '',
--   options = {
--     '--keep-logs',
--     '--synctex'
--   }
-- }
-- vim.cmd [[autocmd BufWritePost *.tex silent VimtexCompile]]
