(local Hydra (require :hydra))

;; Visuals
(local visuals-hint "
  ^ ^     פּ Visuals
  ^
  _z_: TrueZen Ataraxis
  _p_: TS Playground
  _h_: TS Highlight Capture
  ^
  ^^^^              _q_: Quit!
")

(Hydra {:name :Visuals
        :hint visuals-hint
        :config {:color :teal
                 :invoke_on_body true
                 :hint {:position :middle
                        :border :rounded}}
        :mode [:n :x]
        :body :<leader>z
        :heads [[:z (fn []
                     (vim.cmd :TZAtaraxis))] ;; true-zen
                [:p (fn []
                     (vim.cmd :TSPlayground))]
                [:h (fn []
                     (vim.cmd :TSHighlightCapturesUnderCursor))]
                [:q nil {:exit true}]]})
