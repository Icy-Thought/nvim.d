(import-macros {: buf-map!} :macros.keybind)

(local action (require :lspsaga.codeaction))
(local diagnostic (require :lspsaga.diagnostic))
(local definition (require :lspsaga.definition))
(local hover (require :lspsaga.hover))
(local rename (require :lspsaga.rename))
(local signature (require :lspsaga.signaturehelp))

;; Function for quicker access:
(local {: ->str} (require :macros.lib.types))

(fn visual-code-action! []
  (vim.fn.feedkeys (vim.api.nvim_replace_termcodes :<C-U> true false true))
  (action.range_code_action))

(fn saga-smart-scroll! [direction]
  (let [direction (->str direction)]
    (if (= direction :up)
        ((. (require :lspsaga.action) :smart_scroll_with_saga) 1)
        (= direction :down)
        ((. (require :lspsaga.action) :smart_scroll_with_saga) (- 1)))))

(fn saga-err-jump! [direction]
  (let [direction (->str direction)]
    (let [severity vim.diagnostic.severity.ERROR]
      (if (= direction :prev) (diagnostic.goto_prev {: severity})
          (= direction :next) (diagnostic.goto_next {: severity})))))

(buf-map! [n] :<leader>lf :<CMD>FormatWrite<CR>
          {:noremap true :silent true :desc "Format Buffer"})

(buf-map! [n] :gh "<CMD>Lspsaga lsp_finder<CR>"
          {:noremap true
           :silent true
           :desc "Lookup code definition + reference"})

(buf-map! [n] :ca action.code_action ;; TODO:
          {:noremap true :silent true :desc "Code action (Cursor)"})

(buf-map! [v] :<leader>ca action.code_action ;; TODO:
          {:noremap true :silent true :desc "Code action (Cursor)"})

(buf-map! [v] :<leader>ca visual-code-action!
          {:noremap true :silent true :desc "Code action (selection)"})

(buf-map! [n] :K hover.render_hover_doc ;; TODO:
          {:noremap true :silent true :desc "Bring forward Hover-DOC"})

(buf-map! [n] :<C-b> (fn []
                       (saga-smart-scroll! :up)) ;; TODO:
          {:noremap true :silent true :desc "Scroll Hover-DOC up"})

(buf-map! [n] :<C-f> (fn []
                       (saga-smart-scroll! :down))
          ;; TODO:
          {:noremap true
           :silent true
           :desc "Scroll Hover-DOC down | def. preview"})

(buf-map! [n] :gs signature.signature_help ;; TODO:
          {:noremap true :silent true :desc "Show signature help"})

(buf-map! [n] :gr rename.lsp_rename ;; TODO:
          {:noremap true :silent true :desc "Rename selected def."})

(buf-map! [n] :gd definition.preview_definition ;; TODO:
          {:noremap true :silent true :desc "Preview item def."})

(buf-map! [n] :<leader>cd diagnostic.show_line_diagnostics ;; TODO:
          {:noremap true :silent true :desc "Show line diagnostics"})

(buf-map! [n] "[e" diagnostic.goto_prev ;; TODO:
          {:noremap true :silent true :desc "Goto previous diagnostic"})

(buf-map! [n] "]e" diagnostic.goto_next ;; TODO:
          {:noremap true :silent true :desc "Goto next diagnostic"})

(buf-map! [n] "[E" (fn []
                     (saga-err-jump! :prev)) ;; TODO:
          {:noremap true :silent true :desc "Jump to previous Err"})

(buf-map! [n] "]E" (fn []
                     (saga-err-jump! :next)) ;; TODO:
          {:noremap true :silent true :desc "Jump to next Err"})
