local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    s({
            trig = "snip-multiline",
            dscr = "Template for a new multiline snippet",
        },
        fmta(
            [[
            s({
                trig="<>",
                dscr="<>",
            },
            fmta(
            \[\[
                <>
            \]\],
            {
                <>
            }
            )
            ),
            ]],
            {
                i(1, "Trigger"),
                i(2, "Description"),
                i(3, "Snippet Value"),
                i(4, "Delimiters"),
            })
    ),
    s({
            trig = "snip",
            dscr = "Template for a new snippet",
        },
        fmta(
            [[
            s({
                trig="<>",
                dscr="<>",
            },
            fmta(
            "<>",
            {
                <>
            }
            )
            ),
            ]],
            {
                i(1, "Trigger"),
                i(2, "Description"),
                i(3, "Snippet Value"),
                i(4, "Delimiters"),
            })
    )
}
