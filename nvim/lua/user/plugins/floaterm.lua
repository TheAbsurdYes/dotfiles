return {
    'voldikss/vim-floaterm',
    keys = {
      { "<C-_>", ':FloatermToggle<CR>', silent = true },
      { "<C-_>", '<C-\\><C-n>:FloatermToggle<CR>', mode = 't', silent = true },
      { '<esc><esc>', '<C-\\><C-n>', mode = 't' },
    },
    init = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
    end,
  }
