return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- table.insert(opts.routes or {}, {
    --   filter = {
    --     event = "notify",
    --     find = "No information available",
    --   },
    --   opts = { skip = true },
    -- })

    -- opts.presets.lsp_doc_border = true
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      opts = {
        timeout = 10000,
      }
    },
  }
}
