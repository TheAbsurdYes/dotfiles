return {
  'kyazdani42/nvim-tree.lua',
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys = {
    { '<Leader>j', ':NvimTreeFindFileToggle<CR>', { silent = true } },
  },
  opts = {
    git = {
      ignore = false,
    },
    view = {
      width = 40,
    },
    renderer = {
      highlight_opened_files = 'name',
      group_empty = true,
      icons = {
        show = {
          folder_arrow = false,
        },
        glyphs = {
          git = {
            unstaged = "◌",
            untracked = "󰐕",
            ignored = "󱙄",
          },
        },
      },
      indent_markers = {
        enable = true,
      },
    },
    filters = {
      custom = {
        "^\\.ide.php$",
        "^\\.git$",
      },
    },
  },
  config = function(plugin, opts)
    require('nvim-tree').setup(opts)

    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
      pattern = "NvimTree_*",
      callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
      end
    })
  end,
}
