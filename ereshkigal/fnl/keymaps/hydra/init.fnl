;; Copyright (c) 2022 Jaawerth. All Rights Reserved.

(local {: tbl?
        : ->str} (require :macros.lib.types))

;; bind vim.api and vim.fn for convenience, and rebind _G.vim as a local
(local {:api va
        :fn vf &as vim} _G.vim)
(local {:nvim_err_writeln echoerr} va)

(λ module-loaded? [mod-name]
  "If module has already loaded:
  returns: (values mod-name (. package.loaded mod-name)); else nil"
  (match (. package.loaded mod-name)
    mod (values mod-name mod)))

(λ load-hydra! [file]
   (if (module-loaded? file)
     (require (.. "keymaps.hydra." (tostring file)))
     (echoerr (: "Failed to load keymap \"%s\": hydra not loaded" :format file))))

;; Load hydra keymaps
(let [plugin-bindings [:align
                       :gitsigns
                       :rust-tools
                       :telescope
                       :nvim-treesitter
                       :toggleterm]]
  (each [_ keymap (ipairs plugin-bindings)]
    (load-hydra! keymap)))

;; Require our non-plugin dependent mappings
(require :keymaps.hydra.options)
