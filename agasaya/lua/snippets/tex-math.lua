local ls = require("luasnip")
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local parse = ls.parser.parse_snippet

local tex = {}
tex.in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end

local tex_rightarrow = [[\rightarrow]]
local tex_rightarrow2 = [[\Rightarrow]]
local tex_quad = [[\quad]]
local tex_qquad = [[\qquad]]

ls.add_snippets("tex", {
    parse({ trig = "->" }, tex_rightarrow, { condition = tex.in_text }),
    parse({ trig = "=>" }, tex_rightarrow2, { condition = tex.in_text }),
    parse({ trig = "quad" }, tex_quad, { condition = tex.in_text }),
    parse({ trig = "qquad" }, tex_qquad, { condition = tex.in_text }),
})
