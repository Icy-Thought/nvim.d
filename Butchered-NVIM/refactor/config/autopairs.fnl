(local {: setup} (require :nvim-autopairs))

(setup {:check_ts true
        :ts_config {:lua "string"
                    :javascript "template_string"
                    :java false}
        :fast_wrap {:map :<M-e>
                    :chars ["{" "[" "(" "\"" "'"]
                    :pattern (string.gsub " [%\"%\"%)%>%]%)%}%,] " "%s+" "")
                    :offset (- 1)
                    :end_key "$"
                    :keys "qwertyuiopzxcvbnmasdfghjkl"
                    :check_comma true
                    :highlight "Search"
                    :highlight_grey "Comment"}})

(local cmp (require :cmp))
(local cmp-autopairs (require :nvim-autopairs.completion.cmp))

(cmp.event:on :confirm_done
              (cmp-autopairs.on_confirm_done {:map_char {:tex ""}}))
(tset cmp-autopairs.lisp (+ (length cmp-autopairs.lisp) 1) :racket)
