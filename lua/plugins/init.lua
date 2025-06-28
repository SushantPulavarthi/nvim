return {
  {
    'numToStr/Comment.nvim',
    config = true,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
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
          ["<C-p>"] = false,
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
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    config = function()
      require("no-neck-pain").setup({
        buffers = {
          right = {
            enabled = false,
          },
          scratchPad = {
            enabled = true,
            location = "~/Notes/nvim_scratch/"
          },
          bo = {
            filetype = "md"
          },
        },
        fallbackOnBufferDelete = true,
        autocmds = {
          enableOnVimEnter = false,
          reloadOnColorSchemeChange = true,
        },
      })
    end
  },
  -- {
  --   "christoomey/vim-tmux-navigator",
  --   event = "VeryLazy",
  --   cmd = {
  --     "TmuxNavigateLeft",
  --     "TmuxNavigateDown",
  --     "TmuxNavigateUp",
  --     "TmuxNavigateRight",
  --     "TmuxNavigatePrevious",
  --   },
  --   keys = {
  --     { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
  --     { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
  --     { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
  --     { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
  --     { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  --   },
  -- },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   lazy = false,
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = {},
  -- }
}
