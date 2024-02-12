local helpers = require('sarscast.snippets.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s({ trig = "ff" },
        fmta(
            [[
      def <>(<>):
          <><>
      ]],
            {
                i(1),
                i(2),
                c(3, {
                    t(""),
                    sn(nil, { t({ "\"\"\"", "" }), t("    "), i(1, ""), t({ "", "    \"\"\"", "    " }) }),
                }),
                -- t("    "),
                d(4, get_visual),
            }
        ),
        { condition = line_begin }
    ),
    s({
            trig = "ii",
            dscr = "init method",
        },
        fmta(
            [[
            def __init__(self<>):
                <>
            ]]
            ,
            {
                i(1, " Parameters"),
                i(2, "TODO")
            }
        )
    ),
    s({
            trig = "main",
            dscr = "main method",
        },
        fmta(
            [[
            if __name__ == "__main__":
                <>
            ]]
            ,
            {
                i(1, "TODO"),
            }
        )
    ),
    s({ trig = "cc" },
        fmta(
            [[
      """
      <>
      """
      ]],
            {
                d(1, get_visual),
            }
        ),
        { condition = line_begin }
    ),
}
