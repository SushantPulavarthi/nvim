return {
    {
        "lervag/vimtex",
        config = function()
            -- vim.g.vimtex_view_general_viewer = '~/.local/bin/sumatrapdf.sh'
            -- vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
            -- vim.g.tex_flavor='latex'
            vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe'
            vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
            -- vim.g.vimtex_view_method='zathura'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.tex_conceal = 'abdmg'
            -- vim.g.vimtex_view_general_viewer = 'SumatraPDF'
            -- vim.g.vimtex_view_general_options = '-reuse-instance @pdf'
            --        vim.g.vimtex_view_general_viewer = '~/.local/bin/sumatrapdf.sh'
            --        vim.g.vimtex_view_general_options
            --            \ = '-reuse-instance -forward-search @tex @line @pdf'
            --
            -- vim.g.vimtex_view_general_viewer = '~/.local/bin/sumatrapdf.sh'
            -- vim.g.vimtex_view_general_options
            --       \ = '-reuse-instance -forward-search @tex @line @pdf'
            -- vim.g.vimtex_view_general_options_latexmk = '-reuse-instance'
            -- vim.g.vimtex_view_method = 'sumatrapdf'
            -- vim.g.vimtex_view_method = 'zathura'
            -- vim.g.vimtex_view_general_viewer = 'okular'
            -- vim.g.vimtex_view_general_viewer = 'SumatraPDF -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\""'
            -- -- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
            -- vim.g.vimtex_compiler_method = '~/Downloads/latexrun/latexrun'
        end,
    },
}
