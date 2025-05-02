return {
  'mfussenegger/nvim-lint',
  config = function()
    -- enable eslint_d tracking for nvim is running
    vim.env.ESLINT_D_PPID = vim.fn.getpid()
    -- disable error when no eslint
    vim.env.ESLINT_D_MISS = "ignore"

    require('lint').linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      php = { 'phpstan' },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
