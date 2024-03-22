(local Hydra (require :hydra))
(local {: cmd} (require :hydra.keymap-util))

(local terminal-hint "
                  Toggle-Term

  _v_: Vertical                _t_: Tabbed
  _f_: Float                   _p_: Python-Env
^
  _<Enter>_: horizontal        _q_: Quit
")

(Hydra {:name :toggle-term
        :hint terminal-hint
        :config {:color :teal
                 :invoke_on_body true
                 :hint {:position :middle
                        :border :rounded}}
        :mode :n
        :body :<Leader>t
        :heads [[:v (cmd "ToggleTerm size=80 direction=vertical")
                    {:desc "launch vertical terminal"}]
                [:f (cmd "ToggleTerm direction=float")]
                [:t (cmd "ToggleTerm direction=tab")]
                [:p (cmd "lua _PYTHON_TOGGLE")]
                [:<Enter> (cmd "ToggleTerm size=10 direction=horizontal")]
                [:q nil {:exit true :nowait true}]]})
