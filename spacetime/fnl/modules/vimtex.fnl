(import-macros {: augroup!
                : g!} :hibiscus.vim)

;; Aesthetics
(g! tex_conceal "")
(g! vimtex_fold_manual 1)
(g! tex_comment_nospell 1)

;; Compiler + PDF-Viewer
(g! vimtex_compiler_progname :nvr)
(g! vimtex_view_method :zathura)
(g! vimtex_view_general_viewer :zathura)

;; Tectonic = default compiler
;; (g! vimtex_compiler_method :tectonic)
;; (g! vimtex_compiler_tectonic {:build_dir ""
;;                               :options ["--keep-logs" "--synctex"]})

;; (augroup! :LaTeXCompile 
;;     [[BufWritePost] *.tex "silent VimtexCompile"])
