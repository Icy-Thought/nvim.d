(local {: str? : nil? : tbl? : ->str} (require :macros.lib.types))

(tset _G :ereshkigal/plugins [])
(tset _G :ereshkigal/rock [])

(λ pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})]
    (doto options (tset 1 identifier))))

(λ rock [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})]
    (doto options (tset 1 identifier))))

(λ use-package! [identifier ?options]
  "Declares a plugin with its options. This macro adds it to the
  ereshkigal/core/packer global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.ereshkigal/plugins (pack identifier ?options)))

(λ rock! [identifier ?options]
  "Declares a rock with its options. This macro adds it to the ereshkigal/rock
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.ereshkigal/rock (rock identifier ?options)))

;; make life easier
(λ load-file [file]
  "Configure a plugin by loading a file from the `plugins/` directory.
  Valid arguements:
    - file -> a symbol
  Example of use:
  ```fennel
  (use-package! :anuvyklack/hydra.nvim {:config (load-file hydras)})
  ```"
  (assert-compile (sym? file) "expected symbol for file" file)
  (let [file (->str file)]
    `#(require (.. "plugins." ,file))))

(λ load-theme [theme]
  "Configure theme-specific settings provided by the theme-plugin itself by
  loading the conf-file from the `themes/` director.
  Valid arguements:
    - file -> a symbol
  Example of use:
  ```fennel
  (use-package! :catppuccin/nvim {:config (load-theme catppuccin)})
  ```"
  (assert-compile (sym? theme) "expected symbol for theme" theme)
  (let [theme (->str theme)]
    `#(require (.. "themes." ,theme))))

(λ load-keymap [theme]
  "Configure plugin-specific keybindings by defining the desired binding in the
  `keymaps` directory and later enable/disable those bindings through the
  `config` option for the installed plugin.
  Valid arguements:
    - file -> a symbol
  Example of use:
  ```fennel
  (use-package! :catppuccin/nvim {:config (load-keymap basics)})
  ```"
  (assert-compile (sym? keymap) "expected symbol for keymap" keymap)
  (let [keymap (->str keymap)]
    `#(require (.. "keymaps." ,keymap))))

(λ load-lang [lang]
  "Configure a language-specific plugin by loading a file from the
  `completion/server` directory.
  Valid arguements:
    - lang -> a symbol
  Example of use:
  ```fennel
  (use-package! :mfussenegger/nvim-jdtls {:ft :java :config (load-lang java)})
  ```"
  (assert-compile (sym? lang) "expected symbol for lang" lang)
  (let [lang (->str lang)]
    `#(require (.. "plugins.completion.server." ,lang))))

(λ call-setup [name]
 "Configures a plugin by calling its setup function.
  Valid arguements:
    - name -> a symbol
  Example of use:
  ```fennel
  (use-package! :j-hui/fidget.nvim {:config (call-setup :fidget)})
  ```"
  (assert-compile (sym? name) "expected symbol for lang" name)
  (let [name (->str name)]
    `(λ []
        ((. (require ,name) :setup)))))

(λ unpack! []
  "Initializes the plugin manager with the plugins previously declared and
  their respective options."
  (let [packs (icollect [_ v (ipairs _G.ereshkigal/plugins)] `(use ,v))
        rocks (icollect [_ v (ipairs _G.ereshkigal/rock)] `(use_rocks ,v))]
    (tset _G :ereshkigal/plugins [])
    (tset _G :ereshkigal/rock [])
    `((. (require :packer) :startup)
      (fn []
        ,(unpack (icollect [_ v (ipairs packs) :into rocks] v))))))

{: rock
 : pack
 : rock!
 : use-package!
 : load-file
 : load-theme
 : load-keymap
 : load-lang
 : call-setup
 : unpack!}
