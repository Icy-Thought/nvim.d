;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3

;; use opt-in filetype.lua instead of vimscript default
;; EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
(tset vim.g :did_load_filetypes 1)
(tset vim.g :do_filetype_lua 1)

;; Temporarily disable syntax and filetype to improve startup time
(vim.api.nvim_command "syntax off")
(vim.api.nvim_command "filetype off")
(vim.api.nvim_command "filetype plugin indent off")

;; Load configuration core
(require :core)

(fn installed! [plugin-name]
  "Check if a plugin is installed or not"
  (= 0 (vim.fn.empty (vim.fn.glob (string.format "%s/packer/opt/%s"
                                                 (.. (vim.fn.stdpath :data)
                                                     :/site/pack)
                                                 plugin-name)))))

;; Defer plugins loading
(vim.defer_fn (lambda loading []
                ;; Re-enable syntax and filetype
                (command! "syntax on")
                (command! "filetype on")
                (command! "filetype plugin indent on")
                ;; Load colorscheme
                (when (installed! :doom-one.nvim)
                  (command! "packadd doom-one.nvim")
                  (command! "colorscheme doom-one"))
                ;; Load plugins
                (when (installed! :packer.nvim)
                  ;; Tree-sitter
                  (when (installed! :nvim-treesitter)
                    (command! "PackerLoad nvim-treesitter"))
                  ;; Statusline components
                  (when (installed! :nvim-gps)
                    (command! "PackerLoad nvim-gps"))
                  ;; Statusline
                  (when (installed! :heirline.nvim)
                    (command! "PackerLoad heirline.nvim"))
                  ;; Telescope
                  (when (installed! :telescope.nvim)
                    (command! "PackerLoad telescope.nvim")))
                ;; Fix some plugins stuff, e.g. tree-sitter modules
                (command! "doautocmd BufEnter")
                ;; Launch *scratch* buffer if no arguments were passed to Neovim 
                ((. (require :utils.scratch) :load))) 0)

;;; init.fnl ends here
