return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
    "stevearc/conform.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
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

    require("fidget").setup()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "rust_analyzer",
        "lua_ls",
        -- "pyright",
        -- "gopls",
        -- "tailwindcss",
        -- "ts_ls",
        -- "volar",
        -- "vue_ls",
        -- "taplo",
        -- "clangd",
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

        -- ["ts_ls"] = function()
        --   local mason_registry = require("mason-registry")
        --   local vue_ls_path = mason_registry.get_package("vue-language-server"):get_install_path()
        --       .. "/node_modules/@vue/language-server"
        --   lspconfig.ts_ls.setup {
        --     -- on_attach = on_attach,
        --     -- capabilities = capabilities,
        --     init_options = {
        --       plugins = { -- I think this was my breakthrough that made it work
        --         {
        --           name = "@vue/typescript-plugin",
        --           location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        --           languages = { "javascript", "typescript", "vue" },
        --           -- location = "/usr/local/lib/node_modules/@vue/language-server",
        --           -- location = "/usr/local/lib/node_modules/@vue/language-server",
        --           -- location = vue_ls_path,
        --           -- languages = { "vue" },
        --         },
        --       },
        --     },
        --     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        --   }
        -- end,

        -- ["vue_ls"] = function()
        --   lspconfig.vue_ls.setup {
        --     -- on_attach = on_attach,
        --     capabilities = capabilities,
        --     init_options = {
        --       vue = {
        --         hybridMode = false,
        --       },
        --     },
        --     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        --   }
        -- end,
      }
    })

    -- lspconfig.ts_ls.setup {
    --   cmd = { 'typescript-language-server', '--stdio' },
    --   filetypes = {
    --     'javascript',
    --     'javascriptreact',
    --     'javascript.jsx',
    --     'typescript',
    --     'typescriptreact',
    --     'typescript.tsx',
    --     'vue',
    --   },
    --   init_options = {
    --     plugins = {
    --       {
    --         name = '@vue/typescript-plugin',
    --         location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
    --         languages = { 'vue' },
    --       },
    --     },
    --   },
    --   root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
    --   single_file_support = true,
    --   settings = {
    --     javascript = {
    --       inlayHints = {
    --         includeInlayEnumMemberValueHints = true,
    --         includeInlayFunctionLikeReturnTypeHints = true,
    --         includeInlayFunctionParameterTypeHints = true,
    --         includeInlayParameterNameHints = 'none',
    --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    --         includeInlayPropertyDeclarationTypeHints = true,
    --         includeInlayVariableTypeHints = true,
    --       },
    --     },
    --     typescript = {
    --       inlayHints = {
    --         includeInlayEnumMemberValueHints = true,
    --         includeInlayFunctionLikeReturnTypeHints = true,
    --         includeInlayFunctionParameterTypeHints = true,
    --         includeInlayParameterNameHints = 'none',
    --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    --         includeInlayPropertyDeclarationTypeHints = true,
    --         includeInlayVariableTypeHints = true,
    --       },
    --     },
    --   },
    --   -- init_options = {
    --   --   plugins = {
    --   --     {
    --   --       name = "@vue/typescript-plugin",
    --   --       location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
    --   --       languages = { "javascript", "typescript", "vue" },
    --   --     },
    --   --   },
    --   -- },
    --   -- filetypes = {
    --   --   "javascript",
    --   --   "typescript",
    --   --   "vue",
    --   -- },
    -- }
    --
    -- lspconfig.vue_ls.setup {
    --   cmd = { 'vue-language-server', '--stdio' },
    --   filetypes = { 'vue' },
    --   init_options = {
    --     typescript = {
    --       tsdk = vim.fn.expand('~/') .. '.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib',
    --     },
    --     preferences = {
    --       disableSuggestions = false,
    --     },
    --     languageFeatures = {
    --       implementation = true,
    --       references = true,
    --       definition = true,
    --       typeDefinition = true,
    --       callHierarchy = true,
    --       hover = true,
    --       rename = true,
    --       renameFileRefactoring = true,
    --       signatureHelp = true,
    --       codeAction = true,
    --       workspaceSymbol = true,
    --       diagnostics = true,
    --       semanticTokens = true,
    --       completion = {
    --         defaultTagNameCase = 'both',
    --         defaultAttrNameCase = 'kebabCase',
    --         getDocumentNameCasesRequest = false,
    --         getDocumentSelectionRequest = false,
    --       },
    --     },
    --     vue = {
    --       hybridMode = false,
    --     },
    --   },
    --   settings = {
    --     typescript = {
    --       inlayHints = {
    --         enumMemberValues = {
    --           enabled = true,
    --         },
    --         functionLikeReturnTypes = {
    --           enabled = true,
    --         },
    --         propertyDeclarationTypes = {
    --           enabled = true,
    --         },
    --         parameterTypes = {
    --           enabled = true,
    --           suppressWhenArgumentMatchesName = true,
    --         },
    --         variableTypes = {
    --           enabled = true,
    --         },
    --       },
    --     },
    --   },
    -- }

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

        ["<C-l>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-h>"] = cmp.mapping(function()
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
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
