(local {: name
        : hint
        : config
        : mode
        : body
        : heads} (require :hydra))

;; Visuals
(local visuals-hint "
  ^ ^     פּ Visuals
  ^
  _z_ TrueZen Ataraxis
  _p_ TS Playground
  _h_ TS Highlight Capture
  ^
  ^^^^              _<Esc>_
")

(name :Visuals)
(hint visuals-hint)

(config {:color :teal
         :invoke_on_body true
         :hint {:border :solid :position :middle}})

(mode [:n :x])
(body :<leader>z)
(heads [[:z (fn []
              (vim.cmd :TZAtaraxis))] ;; true-zen
        [:p (fn []
              (vim.cmd :TSPlayground))]
        [:h (fn []
              (vim.cmd :TSHighlightCapturesUnderCursor))]
        [:<Esc> nil {:exit true}]])
