local defaultFormatOpts = { async = false, timeout_ms = 5000, lsp_fallback = true }
return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>f",
        function() require("conform").format(defaultFormatOpts) end,
        desc = "Format",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "goimports_reviser", "gofmt" },
          lua = { "stylua" },
          python = { "isort", "black" },
          markdown = { "inject" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          css = { "prettier" },
          sh = { "shfmt" },
          toml = { "taplo" },
          c = { "clangd" },
          -- yaml = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          typst = { "typstfmt" },
          latex = { "latexindent" },
        },
        -- format_on_save = defaultFormatOpts,
        -- default_format_opts = defaultFormatOpts,
        format_on_save = {
          lsp_format = "fallback",
          timeout_ms = 1000,
        },
      })
    end,
  }
}
