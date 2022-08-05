(require-macros :macros.event)
(import-macros {: set!} :macros.option)

;; More eager auto-read
(augroup! auto-read-on-steroids
          (autocmd! FocusGained * "checktime"))

;; Auto-change dir on BufEnter
(augroup! follow-buffer-dir
          (autocmd! BufEnter * "silent! lcd %:p:h"))

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;; Auto move to the location of the last edit (TODO)
;; [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]]

;; Force write shada on nvim-exit
;; (augroup! force-write-shada
;;           (autocmd! BufReadPost * TODO))
;; [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]]

;; require custom parinfer plugin on InsertEnter
;; hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(augroup! parinfer
          (autocmd! InsertEnter * '(require :plugins.editor.parinfer)))

;; Close Nvim-Tree if == last window
;; (augroup! last-nvimtree-close
;;          (autocmd! BufEnter * TODO))
;; [[++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]

;; Equalize window dimensions after resize
(augroup! auto-window-resize
          (autocmd! VimResized * "tabdo wincmd ="))

;; Limit char-width = 80 chars
(augroup! character-width-limit
          (autocmd! FileType "markdown,norg" '(set! textwidth 80)))

;; Auto-compile Catppuccin after PackerCompile
;; (augroup! colorscheme-compile
;;     (autocmd! User :PackerCompileDone (vim.cmd :CatppuccinCompile)))
