(import-macros {: color!} :hibiscus.vim)

(require :core.packer)
(require :core.options)

(require :keymaps.default)
(require :keymaps.which-key)

;; TODO: automate process to math theme with nix theme!
;; Set neovim colorscheme
(color! "Catppuccin")
