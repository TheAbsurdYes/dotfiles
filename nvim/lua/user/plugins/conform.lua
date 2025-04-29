return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      php = { "pint" },
      vue = { "prettierd", "prettier" },
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      rust = { "rustfmt", lsp_format = "fallback" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 1000,
      -- lsp_format = "fallback",
    },
  },
}
