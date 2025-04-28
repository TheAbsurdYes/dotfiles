return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    columns = {
      -- "permissions",
      -- "size",
      -- "mtime",
      "icon",
    },
    delete_to_trash = true,
    watch_for_changes = true,
    keymaps = {
      ["h"] = { "actions.parent", mode = "n" },
      ["q"] = { "actions.close", mode = "n" },
      ["l"] = "actions.select",
    }
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    { '<leader>j', ':Oil<CR>', desc = 'Open parent directory', silent = true },
  },
}
