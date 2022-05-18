(import-macros {: color!} :hibiscus.vim)

(require :core.plugins)
(require :core.settings)
;;(require :core.autocmds)
(require :keymaps)

;; TODO: automate process to math theme with nix theme!
;; Set neovim colorscheme
(color! Catppuccin)
