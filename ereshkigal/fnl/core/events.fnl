(require-macros :macros.event)
(import-macros {: set!} :macros.option)

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;; require custom parinfer plugin on InsertEnter
;; hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(augroup! parinfer
          (autocmd! InsertEnter * '(require :plugins.editor.parinfer)))
