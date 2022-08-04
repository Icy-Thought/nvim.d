(import-macros {: load-file} :macros.package)

(local lsp (require :lspconfig))

;;; Diagnostics configuration
(let [{: config 
       : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text false ;; lsp_lines handles this
           :update_in_insert true
           :severity_sort true
           :float {:show_header false :border :rounded}})
  (sign_define :DiagnosticSignError 
               {:text "" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn 
               {:text "" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo 
               {:text "" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint 
               {:text "" :texthl :DiagnosticSignHint}))

;;; Minor UI-improvements
(let [{: with : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help 
             {:border :rounded}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover 
             {:border :rounded})))

(fn reload_lsp []
  (vim.lsp.stop_client (vim.lsp.get_active_clients))
  (vim.cmd :edit))

(fn open_lsp_log []
  (let [path (vim.lsp.get_log_path)]
    (vim.cmd (.. "edit " path))))

(vim.cmd "command! -nargs=0 LspLog call v:lua.open_lsp_log()")
(vim.cmd "command! -nargs=0 LspRestart call v:lua.reload_lsp()")

(load-file completion.servers)                                                                                                                                                                  	
