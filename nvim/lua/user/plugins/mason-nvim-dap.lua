return {
  "jay-babu/mason-nvim-dap.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
  },
  opts = {
    handlers = {},
    ensure_installed = {
      'codelldb',
    },
  },
}
