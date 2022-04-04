(import-macros {: map!} :macros.binding)

;; Telescope -> Display project's todo list
(map! [n] "<localleader>pt" "<cmd>TodoTelescope<cr>"
          "List Project Tasks")
