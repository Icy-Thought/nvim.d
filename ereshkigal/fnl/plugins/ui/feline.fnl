(local {: setup} (require :feline))
(local catppuccin (require :catppuccin.groups.integrations.feline))

(catppuccin.setup {})

(setup {:components (catppuccin.get)})

;; TODO
;; General look -> pull colors from used theme!
