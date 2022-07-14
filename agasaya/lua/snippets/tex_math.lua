local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

local in_mathzone = require("utils.math").in_mathzone

local function add_math_snippets(lang, snips, opts)
    for _, v in pairs(snips) do
        v.condition = in_mathzone
    end
    ls.add_snippets(lang, snips, opts)
end

local auto_snippets = {
    s({ trig = "([^%s]*[^%)])//", regTrig = true }, {
        d(1, function(_, snip)
            local selected = snip.env.TM_SELECTED_TEXT[1]
            if selected then
                return sn(
                    nil,
                    { t("\\frac{"), t(selected), t("}{"), i(1), t("}") }
                )
            end
            f(function(_, snip)
                return "Captured Text: " .. snip.captures[1] .. "."
            end)
            if snip.captures[1] == " " then
                return sn(nil, { t("\\frac{"), i(1), t("}{"), i(2), t("}") })
            end
            return sn(
                nil,
                { t("\\frac{"), t(snip.captures[1]), t("}{"), i(1), t("}") }
            )
        end),
        i(0),
    }),
    s("...", { t("\\ldots "), i(0) }),
    s("~=", { t("\\approx "), i(0) }),
    s("!=", { t("\\neq "), i(0) }),
    s("!>", { t("\\mapsto "), i(0) }),
    s("->", { t("\\to "), i(0) }),
    s("=>", { t("\\implies "), i(0) }),
    s("<->", { t("\\leftrightarrow "), i(0) }),
    s("<=", { t("\\le "), i(0) }),
    s("==", { t("&=& "), i(0) }),
    s(">=", { t("\\ge "), i(0) }),
    s("//", { t("\\frac{"), i(1), t("}{"), i(2), t("}") }),
    s("\\\\\\", { t("\\setminus "), i(0) }),
    s("bcs", { t("\\because ") }),
    s("box", { t("\\boxed{"), i(1), t("} "), i(0) }),
    s("cc", { t("\\subset "), i(0) }),
    s("cdot", { t("\\cdot "), i(0) }),
    s("compl", { t("^{C} "), i(0) }),
    s("dint", { t("\\int_{"), i(1), t("}^{"), i(2), t("} "), i(0) }),
    s("inn", { t("\\in "), i(0) }),
    s("lll", { t("\\ell "), i(0) }),
    s("mcal", { t("\\mathcal{"), i(1), t("} "), i(0) }),
    s("msrc", { t("\\mathsrc{"), i(1), t("} "), i(0) }),
    s("nabl", { t("\\nabla "), i(0) }),
    s("notin", { t("\\not\\in "), i(0) }),
    s("ooo", { t("\\infty{"), i(1), t("} "), i(0) }),
    s("set", { t("\\{"), i(1), t("\\}  "), i(0) }),
    s("qq", { t("\\quad "), i(0) }),
    s("xx", { t("\\times "), i(0) }),
    s("NN", { t("\\N "), i(0) }),
    s("Nn", { t("\\cap "), i(0) }),
    s("UU", { t("\\cup "), i(0) }),
    s({ trig = "transp", wordTrig = false }, { t("^{\\intercal} "), i(0) }),
    s({ trig = "inv", wordTrig = false }, { t("^{-1} "), i(0) }),
    s({ trig = "__", wordTrig = false }, { t("_{"), i(1), t("} "), i(0) }),
    s({ trig = ">>", wordTrig = false }, { t("\\gg "), i(0) }),
    s({ trig = "<<", wordTrig = false }, { t("\\ll "), i(0) }),
}

for _, v in pairs({ "bar", "hat", "vec", "tilde" }) do
    auto_snippets[#auto_snippets + 1] = s(
        { trig = ("\\?%s"):format(v), regTrig = true },
        { t(("\\%s{"):format(v)), i(1), t("}"), i(0) }
    )
    auto_snippets[#auto_snippets + 1] = s(
        { trig = "([^%s]*)" .. v, regTrig = true },
        {
            d(1, function(_, snip, _)
                return sn(
                    nil,
                    { t(("\\%s{%s}"):format(v, snip.captures[1])) },
                    i(0)
                )
            end),
        }
    )
end

add_math_snippets("tex", auto_snippets, { type = "autosnippets" })

local general_snippets = {
    s("||", { t("\\mid "), i(0) }),
    s("ceil", { t("\\left\\lceil"), i(1), t("\\right\\rceil"), i(0) }),
    s("bmat", { t("\\begin{bmatrix} "), i(1), t("\\end{bmatrix} "), i(0) }),
    s("pmat", { t("\\begin{pmatrix} "), i(1), t("\\end{pmatrix} "), i(0) }),
    s("derive", {
        t("\\frac{d"),
        i(1, "y"),
        t("}{d"),
        i(2, "x"),
        t("} = "),
        i(0),
    }),
    s("partial", {
        t({ "\\frac{\\partial " }),
        i(1),
        t({ "}{\\partial " }),
        i(2),
        t({ "}" }),
        i(0),
    }),
    s("integral", { t("\\int_{"), i(1), t("}^{"), i(2), t("} "), i(0) }),
}

add_math_snippets("tex", general_snippets, {})

local container_snippets = {
    s(
        { trig = "()", name = "Parenthesis" },
        { t("\\left("), i(1), t("\\right)"), i(0) }
    ),
    s(
        { trig = "[]", name = "Brackets" },
        { t("\\left["), i(1), t("\\right]"), i(0) }
    ),
    s(
        { trig = "[]", name = "Curly Brackets" },
        { t("\\left{"), i(1), t("\\right}"), i(0) }
    ),
    s({ trig = "(", name = "Left Parenthesis" }, { t("\\left("), i(0) }),
    s({ trig = ")", name = "Right Parenthesis" }, { t("\\right)"), i(0) }),
    s({ trig = "[", name = "Left Bracket" }, { t("\\left["), i(0) }),
    s({ trig = "]", name = "Right Bracket" }, { t("\\right]"), i(0) }),
    s({ trig = "{", name = "Left Curly Bracket" }, { t("\\left{"), i(0) }),
    s({ trig = "}", name = "Right Curly Bracket" }, { t("\\right}"), i(0) }),
}

add_math_snippets("tex", container_snippets, {})
