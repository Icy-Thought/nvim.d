(local {: add_snippets
        : choice_node
        : dynamic_node
        : function_node
        : insert_node
        : snippet
        : snippet_node
        : text_node} (require :luasnip))

(local {: in-mathzone?} (require :utils.math-mode))

(fn math-snippet [lang snips opts]
  (each [_ v (pairs snips)]
    (set v.condition in-mathzone?))
  (add_snippets lang snips opts))

(let [c choice_node
      d dynamic_node
      f function_node
      i insert_node
      rep (. (require :luasnip.extras) :rep)
      s snippet
      sn snippet_node
      t text_node]

  ;; Append n-lines when needed
  (fn newline [n]
    (set-forcibly! n (or n 1))
    (local lines {1 ""})
    (for [_ 1 n 1]
      (tset lines (+ (length lines) 1) ""))
    (t lines))

  (local auto-snippets
         [(s {:trig "([^%s]*[^%)])//" :regTrig true}
             [(d 1 (fn [_ snip]
                     (let [selected (. snip.env.TM_SELECTED_TEXT 1)]
                       (if selected
                           (sn nil [(t "\\frac{")
                                    (t selected)
                                    (t "}{")
                                    (i 1)
                                    (t "}")])
                           (do
                             (f (fn [_ snip]
                                  (.. "Captured Text: " (. snip.captures 1) ".")))
                             (if (= (. snip.captures 1) " ")
                                 (sn nil [(t "\\frac{")
                                          (i 1)
                                          (t "}{")
                                          (i 2)
                                          (t "}")])
                                 (sn nil [(t "\\frac{")
                                          (t (. snip.captures 1))
                                          (t "}{")
                                          (i 1)
                                          (t "}")])))))))
              (i 0)])
          (s ".." [(t "\\cdot ") (i 0)])
          (s "..." [(t "\\ldots ") (i 0)])
          (s "~=" [(t "\\approx ") (i 0)])
          (s "!=" [(t "\\neq ") (i 0)])
          (s "!>" [(t "\\mapsto ") (i 0)])
          (s "->" [(t "\\to ") (i 0)])
          (s "=>" [(t "\\implies ") (i 0)])
          (s "<->" [(t "\\leftrightarrow ") (i 0)])
          (s "<=" [(t "\\le ") (i 0)])
          (s "==" [(t "&=& ") (i 0)])
          (s ">=" [(t "\\ge ") (i 0)])
          (s "//" [(t "\\frac{") (i 1) (t "}{") (i 2) (t "}")])
          (s "\\\\~" [(t "\\\\~\\\\") (newline 1) (i 0)])
          (s "\\\\\\" [(t "\\setminus ") (i 0)])
          (s :bcs [(t "\\because ")])
          (s :box [(t "\\boxed{") (i 1) (t "} ") (i 0)])
          (s :cc [(t "\\subset ") (i 0)])
          (s :compl [(t "^{C} ") (i 0)])
          (s :dint [(t "\\int_{") (i 1) (t "}^{") (i 2) (t "} ") (i 0)])
          (s :inn [(t "\\in ") (i 0)])
          (s :lll [(t "\\ell ") (i 0)])
          (s :mcal [(t "\\mathcal{") (i 1) (t "} ") (i 0)])
          (s :msrc [(t "\\mathsrc{") (i 1) (t "} ") (i 0)])
          (s :nabl [(t "\\nabla ") (i 0)])
          (s :notin [(t "\\not\\in ") (i 0)])
          (s :ooo [(t "\\infty{") (i 1) (t "} ") (i 0)])
          (s :set [(t "\\{") (i 1) (t "\\}  ") (i 0)])
          (s :qq [(t "\\quad ") (i 0)])
          (s :xx [(t "\\times ") (i 0)])
          (s :NN [(t "\\N ") (i 0)])
          (s :Nn [(t "\\cap ") (i 0)])
          (s :UU [(t "\\cup ") (i 0)])
          (s {:trig :transp :wordTrig false} [(t "^{\\intercal} ") (i 0)])
          (s {:trig :inv :wordTrig false} [(t "^{-1} ") (i 0)])
          (s {:trig "__" :wordTrig false} [(t "_{") (i 1) (t "} ") (i 0)])
          (s {:trig ">>" :wordTrig false} [(t "\\gg ") (i 0)])
          (s {:trig "<<" :wordTrig false} [(t "\\ll ") (i 0)])
          (s :sin [(t "\\sin(") (i 1 :x) (t ") ") (i 0)])
          (s :cos [(t "\\cos(") (i 1 :x) (t ") ") (i 0)])
          (s :tan [(t "\\tan(") (i 1 :x) (t ") ") (i 0)])])

  (each [_ v (pairs [:bar :hat :vec :tilde])]
    (tset auto-snippets (+ (length auto-snippets) 1)
          (s {:trig (: "\\?%s" :format v) :regTrig true}
             [(t (: "\\%s{" :format v)) (i 1) (t "}") (i 0)]))

    (tset auto-snippets (+ (length auto-snippets) 1)
          (s {:trig (.. "([^%s]*)" v) :regTrig true}
             [(d 1 (fn [_ snip _]
                     (sn nil
                         [(t (: "\\%s{%s}" :format v (. snip.captures 1)))]
                         (i 0))))])))

  (math-snippet :tex auto-snippets {:type :autosnippets})

  (local general-snippets
         [(s "||" {1 (t "\\mid ") 2 (i 0)})
          (s :ceil [(t "\\left\\lceil") (i 1) (t "\\right\\rceil") (i 0)])
          (s :bmat [(t "\\begin{bmatrix} ") (i 1) (t "\\end{bmatrix} ") (i 0)])
          (s :pmat [(t "\\begin{pmatrix} ") (i 1) (t "\\end{pmatrix} ") (i 0)])
          (s :sqrt [(t "\\sqrt{") (i 1) (t "} ") (i 0)])
          (s :lim [(t "\\lim\\limits_{")
                   (i 1 :x)
                   (t " \\to ")
                   (i 2 :0)
                   (t "} ")
                   (i 0)])
          (s :derive
             [(t "\\frac{d")
              (i 1 :y)
              (t "}{d")
              (i 2 :x)
              (t "} ")
              (i 0)])
          (s :partial
             [(t {1 "\\frac{\\partial "})
              (i 1)
              (t {1 "}{\\partial "})
              (i 2)
              (t {1 "} "})
              (i 0)])
          (s :integral
             [(t "\\int_{")
              (i 1)
              (t "}^{")
              (i 2)
              (t "} ")
              (i 0)])])

  (math-snippet :tex general-snippets {})

  (local container-snippets
         [(s {:trig "()" :name :Parenthesis}
             [(t "\\left(") (i 1) (t "\\right)") (i 0)])
          (s {:trig "[]" :name :Brackets}
             [(t "\\left[") (i 1) (t "\\right]") (i 0)])
          (s {:trig "[]" :name "Curly Brackets"}
             {1 (t "\\left{") 2 (i 1) 3 (t "\\right}") 4 (i 0)})
          (s {:trig "(" :name "Left Parenthesis"} [(t "\\left(") (i 0)])
          (s {:trig ")" :name "Right Parenthesis"} [(t "\\right)") (i 0)])
          (s {:trig "[" :name "Left Bracket"} [(t "\\left[") (i 0)])
          (s {:trig "]" :name "Right Bracket"} [(t "\\right]") (i 0)])
          (s {:trig "{" :name "Left Curly Bracket"} [(t "\\left{") (i 0)])
          (s {:trig "}" :name "Right Curly Bracket"} [(t "\\right}") (i 0)])])

  (math-snippet :tex container-snippets {}))
