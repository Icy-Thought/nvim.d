(import-macros {: map!} :macros.keybind)

(local ALG (require :align))

(local action (require :lspsaga.codeaction))
(local diagnostic (require :lspsaga.diagnostic))
(local definition (require :lspsaga.definition))
(local hover (require :lspsaga.hover))
(local rename (require :lspsaga.rename))
(local signature (require :lspsaga.signature))

(fn visual-code-action! []
  (vim.fn.feedkeys (vim.api.nvim_replace_termcodes :<C-U> true false true))
  (action.range_code_action))

(fn saga-smart-scroll! [direction]
  (if (= direction :up)
      ((. (require :lspsaga.action) :smart_scroll_with_saga) 1)
      (= direction :down)
      ((. (require :lspsaga.action) :smart_scroll_with_saga) (- 1))))

(fn saga-err-jump! [direction]
  (let [severity vim.diagnostic.severity.ERROR]
    (if (= direction :prev) (diagnostic.goto_prev {: severity})
        (= direction :next) (diagnostic.goto_next {: severity}))))

(map! [n] "<leader>lf" "<CMD>FormatWrite<CR>"
        {:noremap true
         :silent true
         :desc "Format Buffer"})

(map! [n] "gh" "<CMD>Lspsaga lsp_finder<CR>"
        {:noremap true
         :silent true
         :desc "Lookup code definition + reference"})

(map! [n] "ca" action.code_action ;; TODO:
        {:noremap true
         :silent true
         :desc "Code action (Cursor)"})

(map! [v] "<leader>ca" action.code_action ;; TODO:
        {:noremap true
         :silent true
         :desc "Code action (Cursor)"})


(map! [v] "<leader>ca" visual-code-action!
        {:noremap true
         :silent true
         :desc "Code action (selection)"})

(map! [n] "K" hover.render_hover_doc ;; TODO:
        {:noremap true
         :silent true
         :desc "Bring forward Hover-DOC"})

(map! [n] "<C-b>" saga-smart-scroll("up") ;; TODO:
        {:noremap true
         :silent true
         :desc "Scroll Hover-DOC up"})

(map! [n] "<C-f>" saga-smart-scroll("down") ;; TODO:
        {:noremap true
         :silent true
         :desc "Scroll Hover-DOC down | def. preview"})

(map! [n] "gs" signature.signature_help ;; TODO:
        {:noremap true
         :silent true
         :desc "Show signature help"})

(map! [n] "gr" rename.lsp_rename ;; TODO:
        {:noremap true
         :silent true
         :desc "Rename selected def."})

(map! [n] "gd" definition.preview_definition ;; TODO:
        {:noremap true
         :silent true
         :desc "Preview item def."})

(map! [n] "<leader>cd" diagnostic.show_line_diagnostics ;; TODO:
        {:noremap true
         :silent true
         :desc "Show line diagnostics"})

(map! [n] "[e" diagnostic.goto_prev ;; TODO:
        {:noremap true
         :silent true
         :desc "Goto previous diagnostic"})

(map! [n] "]e" diagnostic.goto_next ;; TODO:
        :with_noremap()
        :with_desc("Goto next diagnostic"),

(map! [n] "[E" saga-err-jump!("prev") ;; TODO:
        :with_noremap()
        :with_desc("Jump to previous Err"),

(map! [n] "]E" saga-err-jump!("next") ;; TODO:
        :with_noremap()
        :with_desc("Jump to next Err"),
