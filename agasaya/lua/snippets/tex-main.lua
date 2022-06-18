local ls = require("luasnip")
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local parse = ls.parser.parse_snippet

-- Input custom snippets from here onwards
local tex_template = [[
\documentclass[a4paper,12pt]{article}
\usepackage[a4paper, margin=1in, total={20cm,27cm}]{geometry}

usepackage[swedish]{babel}
\usepackage[T1]{fontenc}
\usepackage[normalem]{ulem}
\usepackage[utf8]{inputenc}
\usepackage{amsmath, amssymb, cancel}
\usepackage{capt-of}
\usepackage{fancyvrb}
\usepackage{gfsartemisia-euler}
\usepackage{graphicx}
\usepackage{longtable}
\usepackage{rotating}
\usepackage{tikz}
\usepackage{wrapfig}

\usepackage{xcolor}
\pagecolor[HTML]{1F1F28} % Change page-color
\color[HTML]{DCD7BA} % Change text-color

\author{$1}
\date{\today}
\title{$2}

\begin{document}
\maketitle
\tableofcontents
$0
\addcontentsline{toc}{section}{Unnumbered Section}
\end{document}]]

local rec_ls
rec_ls = function()
    return sn(nil, {
        c(1, {
            -- WARNING: Having the sn(...) as the first choice will cause infinite recursion.
            t({ "" }),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        }),
    })
end

ls.add_snippets("tex", {
    s("ls", {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(1),
        d(2, rec_ls, {}),
        t({ "", "\\end{itemize}" }),
        i(0),
    }),
    s("enum", {
        t({ "\\begin{enumerate}", "\t\\item " }),
        i(1),
        d(2, rec_ls, {}),
        t({ "", "\\end{enumerate}" }),
        i(0),
    }),
    parse({ trig = "template" }, tex_template),
})
