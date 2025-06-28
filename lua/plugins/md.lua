return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    -- ---@module 'render-markdown'
    -- ---@type render.md.UserConfig
    ft = { "markdown" },
    config = function()
      require('render-markdown').setup({
        render_modes = true,
        checkbox = {
          unchecked = { icon = '✘ ' },
          checked = { icon = '✔ ', scope_highlight = '@markup.strikethrough' },
          custom = {
            important = { raw = '[~]', rendered = '󰓎 ', highlight = 'DiagnosticWarn' },
          },
        },

        quote = { repeat_linebreak = true },
        win_options = {
          showbreak = { default = '', rendered = '  ' },
          breakindent = { default = false, rendered = true },
          breakindentopt = { default = '', rendered = '' },
        },
        sign = { enabled = false },
      })
    end
  }
}

-- {
--   "epwalsh/obsidian.nvim",
--   version = "*",  -- recommended, use latest release instead of latest commit
--   lazy = true,
--   ft = "markdown",
--   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
--   -- event = {
--   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
--   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
--   --   "BufReadPre path/to/my-vault/**.md",
--   --   "BufNewFile path/to/my-vault/**.md",
--   -- },
--   dependencies = {
--     -- Required.
--     "nvim-lua/plenary.nvim",
--   },
--   opts = {
--     workspaces = {
--       {
--         name = "personal",
--         path = "~/Notes/",
--       },
--       -- {
--       --   name = "work",
--       --   path = "~/vaults/work",
--       -- },
--     },
--
--     completion = {
--       nvim_cmp = true,
--       min_chars = 2,
--       new_notes_location = "notes_subdir",
--     },
--   },
-- }
