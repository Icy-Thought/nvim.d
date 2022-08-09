(local Hydra (require :hydra))
(local {: cmd} (require :hydra.keymap-util))

(local normal-lspsaga-hint "
                     Lspsaga (Normal)

  _f_: LSP-Finder                  _r_: Rename Definition
  _a_: Code Action                 _l_: Line Diagnostic
  _h_: Hover-DOC                   _j_: Preview Diagnostics
  _s_: Signature Help              _k_: Next Diagnostics
  _d_: Preview Definition          _p_: Previous Error Diagnostic
  _c_: Format Buffer               _n_: Next Error Diagnostic
^
  _<Enter>_: Format + Save Buffer                   _q_: Quit
")

(local action (require :lspsaga.codeaction))
(local diagnostic (require :lspsaga.diagnostic))
(local definition (require :lspsaga.definition))
(local hover (require :lspsaga.hover))
(local rename (require :lspsaga.rename))
(local signature (require :lspsaga.signaturehelp))

(Hydra {:name :lspsaga-normal
        :hint normal-lspsaga-hint
        :config {:color :teal
                 :invoke_on_body true
                 :hint {:position :middle
                        :border :rounded}}
        :mode :n
        :body :<Leader>l
        :heads [[:f (cmd "Lspsaga lsp_finder")
                    {:desc "Lookup code definition + reference"}]
                [:a (fn []
                      (action.code_action))
                    {:desc "Cursor code action"}]
                [:h (fn []
                      (hover.render_hover_doc))
                    {:desc "Bring forward Hover-DOC"}]
                [:s (fn []
                      (signature.signature_help))
                    {:desc "Display signature help"}]
                [:d (fn []
                      (rename.lsp_rename))
                    {:desc "Rename selected definition"}]
                [:c (cmd "Format")
                    {:desc "Format current buffer"}]
                [:r (fn []
                      (definition.preview_definition))
                    {:desc "Preview item definition"}]
                [:l (fn []
                      (diagnostic.show_line_diagnostics))
                    {:desc "Show line diagnostics"}]
                [:j (fn []
                      (diagnostic.goto_prev))
                    {:desc "Goto previous diagnostic"}]
                [:k (fn []
                      (diagnostic.goto_next))
                    {:desc "Goto next diagnostic"}]
                [:p (fn []
                      (diagnostic.goto_prev {:severity :severity}))
                    {:desc "Jump to previous Err"}]
                [:n (fn []
                      (diagnostic.goto_next {:severity :severity}))
                    {:desc "Jump to previous Err"}]
                [:<Enter> (cmd "FormatWrite")
                          {:desc "Format and save current buffer"}]
                [:q nil {:exit true :nowait true}]]})


;; Visual lspsaga hints
(local visual-lspsaga-hint "
             Lspsaga (Visual)

  _a_: Code Action
^
                                _q_: Quit
")

(fn visual-code-action []
  (vim.fn.feedkeys (vim.api.nvim_replace_termcodes :<C-U> true false true))
  (action.range_code_action))

(Hydra {:name :lspsaga-visual
        :hint visual-lspsaga-hint
        :config {:color :blue
                 :invoke_on_body true
                 :hint {:position :middle
                        :border :rounded}}
        :mode :v
        :body :<Leader>l
        :heads [[:a (fn []
                      (visual-code-action))
                    {:desc "Visual code action"}]
                [:q nil {:exit true :nowait true}]]})
