(local {: add_snippets
        : snippet
        : snippet_node
        : choice_node
        : text_node
        : insert_node
        : dynamic_node} (require :luasnip))

(let [s snippet
      sn snippet_node
      c choice_node
      t text_node
      i insert_node
      d dynamic_node
      rep (. (require :luasnip.extras) :rep)]

  (add_snippets :tex
                [(s {:trig :init :name "Minimal LaTeX template"}
                     [(t ["\\documentclass[10pt,a4paper,twocolumn]{report}"
                          "\\setcounter{secnumdepth}{4}"
                          ""
                          "\\usepackage[margin=2cm]{geometry}"
                          "\\setlength{\\columnsep}{1.5cm}"
                          "\\setlength{\\columnseprule}{0.2pt}"
                          ""
                          "\\usepackage[T1]{fontenc}"
                          "\\usepackage[normalem]{ulem}"
                          "\\usepackage[utf8]{inputenc}"
                          "\\usepackage{amsmath,amssymb,cancel}"
                          "\\usepackage{capt-of}"
                          "\\usepackage{fancyvrb}"
                          "\\usepackage{gfsartemisia-euler}"
                          "\\usepackage{graphicx}"
                          "\\usepackage{hyperref}"
                          "\\usepackage{longtable}"
                          "\\usepackage[parfill]{parskip}"
                          "\\usepackage{rotating}"
                          "\\usepackage{wrapfig}"
                          ""
                          "\\usepackage{etoolbox}"
                          "\\AtBeginEnvironment{quote}{\\itshape}"
                          ""
                          "\\usepackage{xcolor}"
                          "\\pagecolor[HTML]{1F1F28} % Change page-color"
                          "\\color[HTML]{DCD7BA} % Change text-color"
                          ""
                          "\\author{"])
                      (i 1)
                      (t ["}" "\\date{"])
                      (i 2)
                      (t ["}" "\\title{"])
                      (i 3)
                      (t ["}" "\\hypersetup{" "    pdfauthor={"])
                      (rep 1)
                      (t ["}" "    pdftitle={"])
                      (rep 3)
                      (t ["}" "    pdfkeywords={"])
                      (i 4)
                      (t ["}" "    pdfsubject={"])
                      (rep 4)
                      (t ["}" "    pdflang={"])
                      (i 5)
                      (t ["}"
                          "}"
                          ""
                          "\\begin{document}"
                          "\\maketitle"
                          "\\tableofcontents"
                          ""
                          ""])
                      (i 0)
                      (t [""
                          ""
                          "\\addcontentsline{toc}{section}{Unnumbered Section}"
                          "\\end{document}"])])
                (s {:trig :eqn :name "Non-numbered eqnarray"}
                   [(t {1 "\\begin{eqnarray*}" 2 "    "})
                    (i 0)
                    (t ["" "\\end{eqnarray*}"])])
                (s {:trig :alt :name "Non-numbered alignat"}
                   [(t "\\begin{alignat*}[")
                    (i 1 :n)
                    (t {1 "]" 2 "    "})
                    (i 0)
                    (t ["" "\\end{alignat*}"])])
                (s {:trig :rm :name "Display plain text"}
                   [(t "\\textrm{") 
                    (i 1)
                    (t "}")
                    (i 0)])
                (s {:trig :smallcaps :name :CAPSLOCK}
                   [(t "\\textsc{") 
                    (i 1)
                    (t "}")
                    (i 0)])
                (s {:trig :reals :name "Correctly display R in Real"}
                   [(t "\\mathbb{R}")
                    (i 0)])]
                {}))
