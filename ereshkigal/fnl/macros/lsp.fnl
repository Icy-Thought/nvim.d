(local cmp-nvim-lsp (require :cmp_nvim_lsp))

(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities (cmp-nvim-lsp.update_capabilities capabilities))

(fn enhance-attach [client bufnr]
  (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
  (set client.server_capabilities.document_formatting false)
  (set client.server_capabilities.document_range_formatting false))

(λ lsp-init! []
  (:on-attach enhance-attach)
  (:capabilities capabilities))

{: lsp-init!}
