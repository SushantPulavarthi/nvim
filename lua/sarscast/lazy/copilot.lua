return {
    "zbirenbaum/copilot.lua",
    -- Require using :Copilot to enable
    cmd = "Copilot",
    config = function()
        require("copilot").setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                accept = false, -- disable built-in keymapping
                auto_trigger = true,
                keymap = {
                    accept = "<M-y>",
                    accept_word = "<M-W>",
                    accept_line = "<M-Y>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-e>",
                },
            },
        })

        local cmp = require("cmp")
        local copilot = require("copilot.suggestion")
        local luasnip = require("luasnip")

        local function set_trigger(trigger)
            vim.b.copilot_suggestion_auto_trigger = trigger
            vim.b.copilot_suggestion_hidden = not trigger
        end

        cmp.event:on("menu_opened", function()
            if copilot.is_visible() then
                copilot.dismiss()
            end
            set_trigger(false)
        end)

        -- Disable suggestions when inside a snippet.
        cmp.event:on('menu_closed', function()
            set_trigger(not luasnip.expand_or_locally_jumpable())
        end)
        vim.api.nvim_create_autocmd('User', {
            pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
            callback = function()
                set_trigger(not luasnip.expand_or_locally_jumpable())
            end,
        })
    end,
}
