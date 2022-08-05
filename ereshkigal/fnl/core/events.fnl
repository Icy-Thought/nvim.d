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
(augroup! last-nvimtree-close
         (autocmd! BufEnter * (fn []
                                (when (and (and (not (: (vim.fn.expand "%:p") :match :.git))
                                                (> (vim.fn.line "'\"") 1))
                                           (<= (vim.fn.line "'\"") (vim.fn.line "$")))
                                  (vim.cmd "normal! g'\"")
                                  (vim.cmd "normal zz")))))


;; Force write shada on nvim-exit
(augroup! force-write-shada
          (autocmd! VimLeave * (fn []
                                 (if (= (vim.fn.has :nvim-0.7) 1)
                                     (vim.cmd :wshada!)
                                     (vim.cmd :wviminfo!)))))

;; require custom parinfer plugin on InsertEnter
;; hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(augroup! parinfer
          (autocmd! InsertEnter * '(require :plugins.editor.parinfer)))

;; Close Nvim-Tree if == last window
(augroup! last-nvimtree-close
         (autocmd! BufEnter * (fn []
                                (when (and (= (vim.fn.winnr "$") 1)
                                           (= (vim.fn.bufname)
                                              (.. :NvimTree_ (vim.fn.tabpagenr))))
                                  (vim.cmd :quit)))))

;; Equalize window dimensions after resize
(augroup! auto-window-resize
          (autocmd! VimResized * "tabdo wincmd ="))

;; Limit char-width = 80 chars
(augroup! character-width-limit
          (autocmd! FileType "markdown,norg" '(set! textwidth 80)))
