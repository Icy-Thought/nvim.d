local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep

local iterate_item
iterate_item = function()
    return sn(nil, {
        c(1, {
            -- WARNING: Having the sn(...) as the first choice will cause infinite recursion.
            t({ "" }),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, {
                t({ "", "\t\\item " }),
                i(1),
                d(2, iterate_item, {}),
            }),
        }),
    })
end

ls.add_snippets("tex", {
    s({ trig = "init", name = "Minimal LaTeX template" }, {
        t({
            "\\documentclass[10pt,a4paper,twocolumn]{report}",
            "\\setcounter{secnumdepth}{4}",
            "\\setcounter{tocdepth}{3}",
            "",
            "\\usepackage[margin=2cm]{geometry}",
            "\\setlength{\\columnsep}{1.5cm}",
            "\\setlength{\\columnseprule}{0.2pt}",
            "",
            "\\usepackage[T1]{fontenc}",
            "\\usepackage[normalem]{ulem}",
            "\\usepackage[parfill]{parskip}",
            "\\usepackage[utf8]{inputenc}",
            "",
            "\\usepackage{gfsartemisia-euler}",
            "\\usepackage{amsmath,amssymb,cancel}",
            "",
            "\\usepackage{capt-of}",
            "\\usepackage{enumitem}",
            "\\usepackage{fancyvrb}",
            "\\usepackage{graphicx}",
            "\\usepackage{hyperref}",
            "\\usepackage{longtable}",
            "\\usepackage{rotating}",
            "\\usepackage{wrapfig}",
            "",
            "\\usepackage{etoolbox}",
            "\\AtBeginEnvironment{quote}{\\itshape}",
            "",
            "\\usepackage{xcolor}",
            "\\pagecolor[HTML]{141414} % Change page-color",
            "\\color[HTML]{FFFFFF} % Change text-color",
            "",
            "\\author{",
        }),
        i(1),
        t({ "}", "\\date{" }),
        i(2),
        t({ "}", "\\title{" }),
        i(3),
        t({ "}", "\\hypersetup{", "    pdfauthor={" }),
        rep(1),
        t({ "}", "    pdftitle={" }),
        rep(3),
        t({ "}", "    pdfkeywords={" }),
        i(4),
        t({ "}", "    pdfsubject={" }),
        rep(4),
        t({ "}", "    pdflang={" }),
        i(5),
        t({
            "}",
            "}",
            "",
            "\\begin{document}",
            "\\maketitle",
            "\\tableofcontents",
            "",
            "",
        }),
        i(0),
        t({
            "",
            "",
            "\\addcontentsline{toc}{section}{Unnumbered Section}",
            "\\end{document}",
        }),
    }),
    s({ trig = "ls", name = "Auto-Itemize" }, {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(1),
        d(2, iterate_item, {}),
        t({ "", "\\end{itemize}" }),
        i(0),
    }),
    s({ trig = "enum", name = "Auto-Enumerate" }, {
        t({ "\\begin{enumerate}", "\t\\item " }),
        i(1),
        d(2, iterate_item, {}),
        t({ "", "\\end{enumerate}" }),
        i(0),
    }),
    s({ trig = "eqn", name = "Non-numbered eqnarray" }, {
        t({ "\\begin{eqnarray*}", "    " }),
        i(0),
        t({ "", "\\end{eqnarray*}" }),
    }),
    s({ trig = "alt", name = "Non-numbered alignat" }, {
        t("\\begin{alignat*}["),
        i(1, "n"),
        t({ "]", "    " }),
        i(0),
        t({ "", "\\end{alignat*}" }),
    }),
    s({ trig = "rm", name = "Display plain text" }, {
        t("\\textrm{"),
        i(1),
        t("}"),
        i(0),
    }),
    s({ trig = "smallcaps", name = "CAPSLOCK" }, {
        t("\\textsc{"),
        i(1),
        t("}"),
        i(0),
    }),
    s({ trig = "reals", name = "Correctly display R in Real" }, {
        t("\\mathbb{R}"),
        i(0),
    }),
}, {})
