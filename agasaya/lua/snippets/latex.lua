local ls = require("luasnip")
local lsxt = require("luasnip.extras")

-- Luasnippet: shortcuts
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local parse = ls.parser.parse_snippet
local rep = lsxt.rep
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node

local function is_math(...)
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local function sin(trigger, expansion)
    return s({ trig = trigger }, expansion, { condition = is_math })
end

local iter_item
iter_item = function()
    return sn(nil, {
        c(1, {
            -- WARNING: Having the sn(...) as the first choice will cause infinite recursion.
            t({ "" }),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, {
                t({ "", "\t\\item " }),
                i(1),
                d(2, iter_item, {}),
            }),
        }),
    })
end

ls.add_snippets(nil, {
    tex = {
        -- `is_math` dependent (Symbols)
        sin("->", { t("\\rightarrow ") }),
        sin("=>", { t("\\Rightarrow ") }),
        sin("==", { t("&=& ") }),
        sin("~=", { t("\\approx ") }),
        sin(":.", { t("\\because ") }),

        -- `is_math` dependent (Text)
        sin("qq", { t("\\quad ") }),
        sin("box", { t("\\boxed{"), i(1), t("}") }),
        sin("diffn", {
            t("\\frac{d"),
            i(1, "y"),
            t("}{d"),
            i(2, "x"),
            t("}"),
        }),
        sin("text", { t("\\text{"), i(1), t("}") }),

        -- normal-mode snippets
        s({ trig = "ls", name = "Auto-Itemize" }, {
            t({ "\\begin{itemize}", "\t\\item " }),
            i(1),
            d(2, iter_item, {}),
            t({ "", "\\end{itemize}" }),
            i(0),
        }),
        s({ trig = "enum", name = "Auto-Enumerate" }, {
            t({ "\\begin{enumerate}", "\t\\item " }),
            i(1),
            d(2, iter_item, {}),
            t({ "", "\\end{enumerate}" }),
            i(0),
        }),
        s({ trig = "eqn", name = "eqnarray" }, {
            t({ "\\begin{eqnarray}", "    " }),
            i(0),
            t({ "", "\\end{eqnarray}" }),
        }),
        s({ trig = "alt", name = "Alignat" }, {
            t("\\begin{alignat}["),
            i(1, "n"),
            t({ "]", "    " }),
            i(0),
            t({ "", "\\end{alignat}" }),
        }),
        s({ trig = "min_temp", name = "Minimal Template" }, {
            t({
                "\\documentclass[a4paper,12pt]{article}",
                "\\usepackage[a4paper, margin=1in, total={20cm,27cm}]{geometry}",
                "",
                "\\usepackage[swedish]{babel}",
                "\\usepackage[T1]{fontenc}",
                "\\usepackage[normalem]{ulem}",
                "\\usepackage[utf8]{insertenc}",
                "\\usepackage{amsmath, amssymb, cancel}",
                "\\usepackage{capt-of}",
                "\\usepackage{fancyvrb}",
                "\\usepackage{gfsartemisia-euler}",
                "\\usepackage{graphicx}",
                "\\usepackage{hyperref}",
                "\\usepackage{longtable}",
                "\\usepackage{rotating}",
                "\\usepackage{tikz}",
                "\\usepackage{wrapfig}",
                "",
                "\\usepackage{xcolor}",
                "\\pagecolor[HTML]{1F1F28} % Change page-color",
                "\\color[HTML]{DCD7BA} % Change text-color",
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
    },
})
