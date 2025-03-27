return {
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            -- vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe'
            vim.g.vimtex_view_method='zathura'
            vim.g.vimtex_view_general_viewer="zathura"
            vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.tex_conceal = 'abdmg'
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "/home/sushant/.texfiles/",
                -- out_dir = "/home/sushant/.texfiles/"
            }
        end,
    },
}
