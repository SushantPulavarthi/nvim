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
local c = ls.choice_node

return {
  s({
      trig = "op-",
      snippetType = "autosnippet"
    },
    fmta(
      [[
            { <>, "<>", &execute_<>, <>, <>, },
            ]],
      {
        i(1, "Operator"),
        i(2, "Description"),
        i(3),
        i(4, "Length"),
        i(5, "Timing"),
      })
  ),
  s("ctrig", t("also loaded!!")),
  s("autotrig", t("autotriggered, if enabled"))
}
