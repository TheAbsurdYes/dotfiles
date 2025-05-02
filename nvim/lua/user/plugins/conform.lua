return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      php = { "pint" },
      vue = { "biome", "eslint_d", stop_after_first = true },
      javascript = { "biome", "eslint_d", stop_after_first = true },
      typescript = { "biome", "eslint_d", stop_after_first = true },
      typescriptreact = { "biome", "eslint_d", stop_after_first = true },
      rust = { "rustfmt", lsp_format = "fallback" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 1000,
      -- lsp_format = "fallback",
    },
  },
}
