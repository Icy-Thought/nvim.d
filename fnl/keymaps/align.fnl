(local Hydra (require :hydra))
(local {: operator
        : align_to_char
        : align_to_string} (require :align))

(local align-hint "
                   Alignment

  _a_: 1 Character      _l_: Lua Pattern
  _d_: 2 Character      _p_: Paragraph -> String
  _w_: String           _c_: Paragraph -> 1 Character

^^^^                    _q_: Quit!
")

(Hydra {:name :align
        :hint align-hint
        :config {:color :teal
                 :invoke_on_body true
                 :hint {:position :middle
                        :border :rounded}}
        :mode :x
        :body :<Leader>a
        :heads [[:a (fn []
                      (align_to_char 1 true))]
                [:d (fn []
                      (align_to_char 2 true true))]
                [:w (fn []
                      (align_to_string false true true))]
                [:l (fn []
                      (align_to_string true true true))]
                [:p (fn []
                      (operator (align_to_string {:is_pattern false
                                                  :reverse true
                                                  :preview true})))]
                [:c (fn []
                      (operator (align_to_char {:reverse true})))]
                [:q nil {:exit true :nowait true}]]})
