return {
    { "evesdropper/luasnip-latex-snippets.nvim" },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install js_regexp",

        dependencipes = {
            "rafamadriz/friendly-snippets",
            "evesdropper/luasnip-latex-snippets.nvim",
        },

        config = function(_, opts)
            local ls = require("luasnip")


            require("luasnip").config.set_config({
                -- Allow autotrigger snippets
                enable_autosnippets = true,
                -- For equivalent of UltiSnips visual selection
                store_selection_keys = "<Tab>",
                -- -- Don't store snippet history for less overhead
                -- history = false,
                -- -- Event on which to check for exiting a snippet's region
                -- region_check_events = 'InsertEnter',
                -- delete_check_events = 'InsertLeave',
            })

            if opts then
                ls.config.setup(opts)
            end
            vim.tbl_map(function(type)
                require("luasnip.loaders.from_" .. type).lazy_load()
            end, { "vscode", "snipmate", "lua" })

            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })

            -- friendly-snippets - enable standardized comments snippets
            ls.filetype_extend("typescript", { "tsdoc" })
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("lua", { "luadoc" })
            ls.filetype_extend("python", { "pydoc" })
            ls.filetype_extend("rust", { "rustdoc" })
            ls.filetype_extend("cs", { "csharpdoc" })
            ls.filetype_extend("java", { "javadoc" })
            ls.filetype_extend("c", { "cdoc" })
            ls.filetype_extend("cpp", { "cppdoc" })
            ls.filetype_extend("php", { "phpdoc" })
            ls.filetype_extend("kotlin", { "kdoc" })
            ls.filetype_extend("ruby", { "rdoc" })
            ls.filetype_extend("sh", { "shelldoc" })
            -- require("luasnip.loaders.from_vscode").load()
            require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/sarscast/snippets/" })
            require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/sarscast/snippets/tex" })

            -- snippet_path = debug.getinfo(1).source:sub(2):gsub("init.lua", "luasnippets")
            -- require("luasnip.loaders.from_lua").lazy_load({ paths = snippet_path })


            vim.keymap.set('', '<Leader>U',
                '<Cmd>lua require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/lua/sarscast/snippets/"})<CR><Cmd>echo "Snippets refreshed!"<CR>')
            ls.config.set_config({ enable_autosnippets = true })
        end,
    },
    {
        "benfowler/telescope-luasnip.nvim",
        lazy = true,
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>sz", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },
        },
        config = function()
            require("telescope").load_extension("luasnip")
        end,
    },
}
