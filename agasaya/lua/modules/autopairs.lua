local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

-- Initialize without config
npairs.setup()

-- Use built-in conditions
local cond = require("nvim-autopairs.conds")
npairs.add_rules({
    Rule("(", ")", { "tex", "latex" })
        :with_pair(cond.not_before_text("\\"))
        :with_pair(cond.not_before_text("@")),
})

npairs.add_rules({
    Rule("\\(", "\\)", { "tex", "latex" }),
})

npairs.add_rules({
    Rule("\\[", "\\]", { "tex", "latex" }),
})

npairs.add_rules({
    Rule("\\left(", "\\right)", { "tex", "latex" }):with_pair(
        cond.not_before_text("\\")
    ),
})

-- If you want insert `(` after select function or method item
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
