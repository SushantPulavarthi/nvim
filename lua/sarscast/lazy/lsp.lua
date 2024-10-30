return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local luasnip = require('luasnip')

        local winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None'
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -- -- ruff uses an LSP proxy, therefore it needs to be enabled as if it
        -- -- were a LSP. In practice, ruff only provides linter-like diagnostics
        -- -- and some code actions, and is not a full LSP yet.
        -- require("lspconfig").ruff_lsp.setup({
        --     -- organize imports disabled, since we are already using `isort` for that
        --     -- alternative, this can be enabled to make `organize imports`
        --     -- available as code action
        --     settings = {
        --         organizeImports = false,
        --     },
        --     -- disable ruff as hover provider to avoid conflicts with pyright
        --     on_attach = function(client) client.server_capabilities.hoverProvider = false end,
        -- })

        require("lspconfig").hls.setup({
            capabilities = capabilities
        })

        require("lspconfig").pyright.setup({
            capabilities = capabilities,
        })

        -- setup taplo with completion capabilities
        require("lspconfig").taplo.setup({
            capabilities = capabilities,
        })

        -- require("lspconfig").zls.setup({
        --     capabilities = capabilities,
        --     settings = {
        --         zls = {
        --             enable_autofix = true,
        --         }
        --     },
        -- })

        require("fidget").setup()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                -- "pyright",
                -- "taplo",
                -- "tailwindcss",
                -- "volar",
                -- "clangd",
                "lua_ls",
                "rust_analyzer",
            },
            handlers = {
                function(server_name) -- default handler
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                ["zls"] = function()
                    lspconfig.zls.setup({
                        capabilities = capabilities,
                        settings = {
                            zls = {
                                enable_autofix = true,
                                warn_style = true,
                            }
                        },
                    })
                end,


                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,
            }
        })

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            cmp.PreselectMode.None,
            window = {
                completion = {
                    -- border = 'rounded',
                    --
                    winhighlight = winhighlight,
                    scrollbar = true,
                },
                documentation = {
                    -- border = 'rounded',
                    winhighlight = winhighlight,
                    max_height = math.floor(vim.o.lines * 0.6),
                    max_width = math.floor(vim.o.columns * 0.4),
                },
            },
            mapping = cmp.mapping.preset.insert({
                -- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                -- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(), -- opens menu
                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),

                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                        if #cmp.get_entries() == 1 then
                            cmp.confirm({ select = true })
                        end
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     if require("copilot.suggestion").is_visible() then
                --         require("copilot.suggestion").accept()
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),

                ["<leader>j"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- ["<leader>k"] = cmp.mapping(function()
                --     if luasnip.jumpable(-1) then
                --         luasnip.jump(-1)
                --     end
                -- end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            }),
        })

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
