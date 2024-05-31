local helpers = require('sarscast.snippets.luasnip-helper-funcs')

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta

-- Math context detection-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

local line_begin = require("luasnip.extras.expand_conditions").line_begin
local get_visual = helpers.get_visual

return {
    -- LATEX QUOTATION MARK
    s({ trig = "``" },
        fmta(
            "``<>''",
            {
                d(1, get_visual),
            }
        )
    ),
    -- Equation, choice for labels
    s(
        {
            trig = "beq",
            dscr = "Expands 'beq' into an equation environment, with a choice for labels",
        },
        fmta(
            [[
        \begin{equation}<>
          <>
        \end{equation}
      ]],
            { c(1,
                {
                    sn(2, -- Choose to specify an equation label
                        {
                            t("\\label{eq:"),
                            i(1),
                            t("}"),
                        }
                    ),
                    t([[]]), -- Choose no label
                },
                {}
            ),
                i(2) }
        )
    ),

    -- Figure environment
    s({ trig = "foofig", dscr = "Use 'fig' for figure environmennt, with options" },
        fmta(
            [[
        \begin{figure}<>
          \centering
          \includegraphics<>{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
      ]],
            {
                -- Optional [htbp] field
                c(1,
                    {
                        t([[]]),     -- Choice 1, empty
                        t("[htbp]"), -- Choice 2, this may be turned into a snippet
                    },
                    {}
                ),
                -- Options for includegraphics
                c(2,
                    {
                        t([[]]), -- Choice 1, empty
                        sn(3,    -- Choice 2, this may be turned into a snippet
                            {
                                t("[width="),
                                i(1),
                                t("\\textwidth]"),
                            }
                        ),
                    },
                    {}
                ),
                i(3, "filename"),
                i(4, "text"),
                i(5, "label"),
            }
        ),
        { condition = line_begin }
    ),

}
