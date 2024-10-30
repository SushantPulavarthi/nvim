return {
    {
        "lervag/vimtex",
        config = function()
            -- vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe'
            vim.g.vimtex_view_method='zathura'
            vim.g.vimtex_view_general_viewer="zathura"
            vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.tex_conceal = 'abdmg'
        end,
    },
}
