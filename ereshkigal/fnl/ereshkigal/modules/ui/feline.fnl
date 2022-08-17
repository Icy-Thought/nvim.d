(local {: setup} (require :feline))
(local catppuccin (require :catppuccin.groups.integrations.feline))

(catppuccin.setup {})

(setup {:components (catppuccin.get)})
