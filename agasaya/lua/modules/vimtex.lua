-- Editor settings
vim.g.vimtex_fold_enabled = true
vim.g.vimtex_fold_manual = true
vim.g.tex_comment_nospell = true
vim.g.vimtex_syntax_enabled = true
vim.g.vimtex_syntax_conceal_disable = true -- \alpha -> α (very slow)

-- Compile & view methods
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
