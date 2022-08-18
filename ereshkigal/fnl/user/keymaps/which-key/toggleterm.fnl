(import-macros {: map!} :macros.keybind)

(map! [n] :<leader>tp "<CMD>lua _PYTHON_TOGGLE<CR>"
      {:noremap true :silent true :desc "Python Terminal Environment"})

(map! [n] :<leader>tf "<CMD>ToggleTerm direction=float<CR>"
      {:noremap true :silent true :desc "Floating Terminal"})

(map! [n] :<leader>th "<CMD>ToggleTerm size=10 direction=horizontal<CR>"
      {:noremap true :silent true :desc "Horizontal Terminal"})

(map! [n] :<leader>tv "<CMD>ToggleTerm size=80 direction=vertical<CR>"
      {:noremap true :silent true :desc "Vertical Terminal"})

(map! [n] :<leader>tt "<CMD>ToggleTerm direction=tab<CR>"
      {:noremap true :silent true :desc "Tabbed Terminal"})

(local category {:t {:name :Terminal}})
((. (require :which-key) :register) category)
