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

local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

local mat = function(args, snip)
    print(args)
    print(snip)
    local rows = tonumber(snip.captures[2])
    local cols = tonumber(snip.captures[3])
    local nodes = {}
    local ins_indx = 1
    for j = 1, rows do
        table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert(nodes, t(" & "))
            table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ "\\\\", "" }))
    end
    -- fix last node.
    nodes[#nodes] = t("\\\\")
    return sn(nil, nodes)
end

local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

local function math()
    return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

return {
    s({
            trig = "template",
            dscr = "Basic Template",
        },
        fmta(
            [[
\documentclass[12pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath,amsthm,amssymb,amsfonts,
hyperref, color, graphicx}
\def\lc{\left\lceil}
\def\rc{\right\rceil}

\makeatletter
\renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
  \hskip -\arraycolsep
  \let\@ifnextchar\new@ifnextchar
  \array{#1}}
\makeatother

\maketitle{<>}
\author{}
\date{}

\begin{document}
\maketitle
\vspace{-1.5cm}
    <>
\end{document}
    ]],
            {
                i(1),
                i(2)
            }
        )
    ),
    s(
        { trig = "([%sbBpvV])mat(%d+)x(%d+)r", snippetType = "autosnippet", regTrig = true, wordTrig = false, dscr =
        "[bBpvV]matrix of A x B size" },
        fmta([[
    \begin{<>}
    <>
    \end{<>}]],
            {
                f(function(_, snip)
                    if snip.captures[1] == " " then
                        return "matrix"
                    else
                        return snip.captures[1] .. "matrix"
                    end
                end),
                d(1, mat),
                f(function(_, snip)
                    return snip.captures[1] .. "matrix"
                end)
            }),
        { condition = math }
    ),
    s({
            trig = "fmat(%d+)x(%d+)",
            regTrig = true,
            dscr = "Generate Matrix",

        },
        fmta(
            [[
        <>_<>
    ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                f(function(_, snip) return snip.captures[2] end)
            }
        )
    ),
    s({
            trig = "enum",
            snippetType = "autosnippet",
            dscr = "enumerate",
        },
        fmta(
            [[
      \begin{enumerate}
          <>
      \end{enumerate}
    ]],
            {
                i(1),
            }
        )
    ),
    s({
            trig = "beg",
            snippetType = "autosnippet",
            dscr = "Begin{} / end{}",
        },
        fmta(
            [[
      \begin{<>}
          <>
      \end{<>}
    ]],
            {
                i(1),
                i(2),
                rep(1), -- this node repeats insert node i(1)
            }
        )
    ),
    s({
            trig = "...",
            dscr = "ldots",
        },
        fmta(
            "\\ldots",
            {
            }
        )
    ),
    --\land
    s({
            trig = "^^",
            snippetType = "autosnippet",
            desc = "Expands '^^' into '\\land'"
        },
        t("\\land")
    ),
    s({
            trig = "¬¬",
            snippetType = "autosnippet",
            desc = "Expands ¬¬ into '\\neg'"
        },
        t("\\neg")
    ),
    s({
            trig = "phi",
            snippetType = "autosnippet",
            desc = "Expands 'phi' into '\\phi'"
        },
        t("\\phi")
    ),
    s({
            trig = "top",
            desc = "Expands 'top' into '\\top'"
        },
        t("\\top")
    ),
    s({
            trig = "bot",
            desc = "Expands 'bot' into '\\bot'"
        },
        t("\\bot")
    ),
    s({
            trig = "psi",
            snippetType = "autosnippet",
            desc = "Expands 'psi' into '\\psi'"
        },
        t("\\psi")
    ),
    s({
            trig = "||",
            snippetType = "autosnippet",
            desc = "Expands '||' into '\\lor'"
        },
        t("\\lor")
    ),
    s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" },
        fmta(
            "\\texttt{<>}",
            { i(1) }
        )
    ),
    -- \frac
    s({ trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'" },
        fmt(
            "\\frac{<>}{<>}",
            {
                i(1),
                i(2)
            },
            { delimiters = "<>" } -- manually specifying angle bracket delimiters
        )
    ),
    -- Equation
    s({ trig = "eq", dscr = "Expands 'eq' into an equation environment" },
        fmta(
            [[
       \begin{equation*}
           <>
       \end{equation*}
     ]],
            { i(1) }
        )
    ),
}
