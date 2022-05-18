(import-macros {: color!} :hibiscus.vim)

(require :core.plugins)
(require :core.settings)

(require :keymaps.default)
(require :keymaps.which-key)

;; TODO: automate process to math theme with nix theme!
;; Set neovim colorscheme
(color! "Catppuccin")
