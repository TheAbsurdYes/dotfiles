return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    scope = {
      show_start = false,
    },
    exclude = {
      filetypes = {
        'help',
        'terminal',
        'dashboard',
        'packer',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
      },
      buftypes = {
        'terminal',
        'NvimTree',
      }
    }
  }
}
