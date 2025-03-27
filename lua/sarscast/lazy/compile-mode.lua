return {
    "ej-shafran/compile-mode.nvim",
    -- tag = "v5.*",
    -- you can just use the latest version:
    -- branch = "latest",
    -- or the most up-to-date updates:
    -- branch = "nightly",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "m00qek/baleia.nvim", tag = "v1.3.0" },
        -- if you want to enable coloring of ANSI escape codes in
        -- compilation output, add:
        -- :make and makeprg, :grep and grepprg.
    },
    config = function()
        ---@type CompileModeOpts
        vim.g.compile_mode = {
            -- to add ANSI escape code support, add:
            default_command = "",
            baleia_setup = true,
            -- auto_jump_to_first_error = true,
            use_diagnostics = true,
        }
        vim.keymap.set("n", "<leader>x", "<cmd>below Compile 12<cr>")
        vim.keymap.set("n", "[e", "<cmd>NextError<cr>")
        vim.keymap.set("n", "]e", "<cmd>PrevError<cr>")
    end
}
