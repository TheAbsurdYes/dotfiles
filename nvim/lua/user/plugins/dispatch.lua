return {
  'tpope/vim-dispatch',
  config = function ()
    vim.keymap.set('n', '<leader>ps', ':Focus ')
    vim.keymap.set('n', '<leader>pr', '<cmd>Dispatch<CR>', { silent = true })
  end
}
