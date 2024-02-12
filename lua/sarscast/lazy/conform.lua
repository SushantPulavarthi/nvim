return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- load the plugin before saving
        keys = {
            {
                "<leader>f",
                function() require("conform").format({ lsp_fallback = true }) end,
                desc = "Format",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                markdown = { "inject" },
                javascript = { { "prettierd", "prettier" } },
                typst = { "typstfmt" },
                latex = { "latexindent" },
            },
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
            "mfussenegger/nvim-dap-python",
        },
        opts = {
            dap_enabled = true, -- makes the debugger work with venv
        },
    },
}
