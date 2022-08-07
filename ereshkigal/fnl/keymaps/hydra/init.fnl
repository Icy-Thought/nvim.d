(local {: tbl?
        : ->str} (require :macros.lib.types))

;; Work in progress
;; TODO: require `keymap.hydra.X` only if X has been installed.
;; (X = plugin)

(λ plugin-exists? [status-ok? plugin-name]
  (if [(package.loaded plugin-name) tbl?]
      plugin-name nil))

(λ load-hydra [file]
   (if (not= plugin-exists? nil)
       (let [file (->str file)]
         (require (.. :keymap.hydra. file)))
       (print "Failed to load keymap.")))

(local plugin-bindings [:gitsigns
                        :rust-tools
                        :telescope
                        :nvim-treesitter])

(each [keymap (plugin-bindings)]
  (load-hydra keymap))

(load-hydra :options)
