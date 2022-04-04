;;; /======================/
;;; / Dependency Assertion /
;;; /======================/
(local {: warn!} (require :lib.io))
(fn nil? [x] (= nil x))

(when (nil? (require :lsp))
  (warn! "Could not load config.null-ls as config.lsp could not be loaded.")
  (lua :return))

;;; /===============/
;;; / Configuration /
;;; /===============/
(local {: deep-merge} (require :lib.table))
(local {: setup
        :builtins {: formatting
                   : diagnostics
                   : hover
                   : completion
                   :code_actions actions}} (require :null-ls))
(local {:global-options {:on_attach on-attach}} (require :lsp))

(local sources [formatting.stylua
                formatting.prettierd
                formatting.markdownlint
                formatting.sqlformat
                formatting.black
                formatting.isort
                diagnostics.flake8])

(setup {: sources
        :on_attach on-attach})
