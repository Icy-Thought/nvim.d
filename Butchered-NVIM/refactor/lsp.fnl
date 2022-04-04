;;; /======================/
;;; / Dependency Assertion /
;;; /======================/
(let [{: assert-dependencies!} (require :lib.dependency)]
  (when (not (assert-dependencies!
               :lsp [:lsp_signature
                     :lsp_extensions
                     :lspconfig
                     :cmp_nvim_lsp
                     :schemastore])) (lua :return)))

;;; /==========================/
;;; / Diagnostic configuration /
;;; /==========================/
(let [{: config
       : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text {:severity {:min severity.INFO}}
           :update_in_insert false
           :severity_sort true
           :float {:show_header false
                   :border "single"}})
  (sign_define :DiagnosticSignError {:text "" :texthl "DiagnosticSignError"}
               :DiagnosticSignWarn {:text "" :texthl "DiagnosticSignWarn"}
               :DiagnosticSignInfo {:text "" :texthl "DiagnosticSignInfo"}
               :DiagnosticSignHint {:text "" :texthl "DiagnosticSignHint"}))

;;; /=========================/
;;; / Aesthetic configuration /
;;; /=========================/
(let [{: with
       : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp (with handlers.signature_help {:border "rounded"}))
  (set vim.lsp.handlers.textDocument/hover (with handlers.hover {:border "rounded"})))

;;; =======================
;;; On-attach configuration
;;; =======================
(fn on-attach [client bufnr]
  (import-macros {: local-set!} :macros.option)
  (import-macros {: buf-map!} :macros.binding)
  (import-macros {: augroup!
                  : autocmd!} :macros.event)

  (local {:document_formatting has-formatting?
          :document_range_formatting has-range-formatting?} client.resolved_capabilities)
  (local {:formatting_seq_sync format-seq-sync!
          :hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :code_action open-code-action-float!
          :rename rename!} vim.lsp.buf)
  (local {:open_float open-line-diag-float!
          :goto_prev goto-diag-prev!
          :goto_next goto-diag-next!} vim.diagnostic)
  (local {:inlay_hints inlay-hints!} (require :lsp_extensions))
  (local {:lsp_implementations open-impl-float!
          :lsp_references open-ref-float!
          :diagnostics open-diag-float!
          :lsp_document_symbols open-local-symbol-float!
          :lsp_workspace_symbols open-workspace-symbol-float!} (require :telescope.builtin))

  ;;; /===============/
  ;;; / LSP Signature /
  ;;; /===============/
  (let [signature (require :lsp_signature)]
    (signature.on_attach {:bind true
                          :doc_lines 0
                          :floating_window_above_cur_line true
                          :fix_pos true
                          :hint_enable false
                          :hint_prefix "● "
                          :hint_scheme "DiagnosticSignInfo"}
                         bufnr))

  ;;; /-===========/
  ;;; / Completion /
  ;;; /============/
  ;; Enable omnifunc-completion
  (local-set! omnifunc "v:lua.vim.lsp.omnifunc")

  ;;; /=============/
  ;;; / Keybindings /
  ;;; /=============/
  ;; Show documentation
  (buf-map! [n] "K" open-doc-float!)
  ;; Open code-actions menu
  (buf-map! [nv] "<localleader>a" open-code-action-float!)
  ;; Rename symbol
  (buf-map! [nv] "<localleader>rn" rename!)
  ;; Show line diagnostics
  (buf-map! [n] "<localleader>d" open-line-diag-float!)
  ;; Go to diagnostic
  (buf-map! [n] "[d" goto-diag-prev!)
  (buf-map! [n] "]d" goto-diag-next!)
  ;; Go to declaration
  (buf-map! [n] "<localleader>gD" goto-declaration!)
  ;; Go to definition
  (buf-map! [n] "<localleader>gd" goto-definition!)
  ;; Go to type definition
  (buf-map! [n] "<localleader>gt" goto-type-definition!)
  ;; List implementations
  (buf-map! [n] "<localleader>li" open-impl-float!)
  ;; List references
  (buf-map! [n] "<localleader>lr" open-ref-float!)
  ;; List document diagnostics
  (buf-map! [n] "<localleader>ld" (open-diag-float! {:bufnr 0}))
  ;; List workspace diagnostics
  (buf-map! [n] "<localleader>lD" open-diag-float!)
  ;; List document symbols
  (buf-map! [n] "<localleader>ls" open-local-symbol-float!)
  ;; List workspace symbols
  (buf-map! [n] "<localleader>lS" open-workspace-symbol-float!)

  ;;; /========/
  ;;; / Events /
  ;;; /========/
  ;; Format buffer before saving
  (when has-formatting?
    (augroup! lsp-format-before-saving
              (autocmd! BufWritePre <buffer>
                        (format-seq-sync! nil 1000 [:null-ls]))))
  ;; Display hints on hover
  (augroup! lsp-display-hints
            (autocmd! [CursorHold CursorHoldI] *.rs
                      (inlay-hints! {}))))

;;; /============================/
;;; / Capabilities Configuration /
;;; /============================/
(local capabilities (let [{: update_capabilities} (require :cmp_nvim_lsp)
                          {: make_client_capabilities} vim.lsp.protocol]
                      (update_capabilities (make_client_capabilities))))

;;; /===========================/
;;; / Global Options Definition /
;;; /===========================/
(local global-options {:on_attach on-attach
                       : capabilities})

;;; /======================/
;;; / Client Configuration /
;;; /======================/
(local {: deep-merge} (require :lib.table))
(local config (require :lspconfig))
(local {: expand} vim.fn)

;; Docker
(config.dockerls.setup global-options)
;; Nix
(config.rnix.setup 
  (deep-merge 
    global-options
    {:settings {:formattingProvider "nixfmt"}}))
;; Bash
(config.bashls.setup global-options)
;; Python
(config.pyright.setup (deep-merge
                        global-options
                        {:settings {:python {:venvPath (expand "$HOME/.pyenv/versions")}}}))
;; Rust
(config.rust_analyzer.setup global-options)
;; Javascript & Typescript
(config.tsserver.setup
  (deep-merge
    global-options
    {:on_attach (fn [client bufnr]
                  (set client.resolved_capabilities.document_formatting false)
                  (set client.resolved_capabilities.document_range_formatting false)
                  (on-attach client bufnr))}))
;; ESLint
(config.eslint.setup global-options)
;; CSS
(config.cssls.setup global-options)
;; Html
(config.html.setup global-options)
;; Json
(let [{: json} (require :schemastore)]
  (config.jsonls.setup
    (deep-merge
      global-options
      {:settings {:json {:schemas (json.schemas)}}
       :on_attach (fn [client bufnr]
                    (set client.resolved_capabilities.document_formatting false)
                    (set client.resolved_capabilities.document_range_formatting false)
                    (on-attach client bufnr))})))
;; Yaml
(config.yamlls.setup global-options)
;; Toml
(config.taplo.setup global-options)
;; Clojure
(config.clojure_lsp.setup global-options)

;;; ------------------------------ ;;;

{: global-options}
