(local {: setup : add_rules} (require :nvim-autopairs))

(local rule! (require :nvim-autopairs.rule))
(local cond! (require :nvim-autopairs.conds))

(setup)

(add_rules [(: (: (rule! "(" ")" [:tex :latex]) :with_pair
                  (cond!.not_before_text "\\")) :with_pair
               (cond!.not_before_text "@"))])

(add_rules [(rule! "\\(" "\\)" [:tex :latex])])

(add_rules [(rule! "\\[" "\\]" [:tex :latex])])

(add_rules [(: (rule! "\\left(" "\\right)" [:tex :latex]) :with_pair
               (cond!.not_before_text "\\"))])

(local cmp (require :cmp))
(local cmp-autopairs (require :nvim-autopairs.completion.cmp))
(cmp.event:on :confirm_done (cmp-autopairs.on_confirm_done))

