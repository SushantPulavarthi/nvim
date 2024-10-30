return {
    -- 'ThePrimeagen/vim-be-good',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
    },
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                columns = { "icons" },
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                keymaps = {
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                    ["<M-h>"] = false,
                },
                view_options = {
                    show_hidden = true,
                },
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>")
            vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")
            vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = true,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        opts = {
            options = {
                icons_enabled = false,
            },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

            require("ibl").setup({
                indent = {
                    char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
                },
                scope = {
                    show_start = false,
                    show_end = false,
                },
            })
        end
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {}
    },
    {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup({
                init = function()
                    -- Require providers
                    require("hover.providers.lsp")
                    -- require('hover.providers.gh')
                    -- require('hover.providers.gh_user')
                    -- require('hover.providers.jira')
                    require("hover.providers.man")
                    -- require('hover.providers.dictionary')
                end,
                preview_opts = {
                    border = "rounded",
                },
                -- Whether the contents of a currently open hover window should be moved
                -- to a :h preview-window when pressing the hover keymap.
                preview_window = false,
                title = true,
            })
        end,
    },
    -- {
    --     "linux-cultist/venv-selector.nvim",
    --     dependencies = {
    --         "neovim/nvim-lspconfig",
    --         "nvim-telescope/telescope.nvim",
    --         "mfussenegger/nvim-dap-python",
    --     },
    --     opts = {
    --         dap_enabled = true, -- makes the debugger work with venv
    --     },
    -- },
}
