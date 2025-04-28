return {
    'famiu/bufdelete.nvim',
    config = function()
      vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>', {silent = true})
      vim.keymap.set('n', '<Leader>Q', ':bufdo Bdelete<CR>', {silent = true})
    end,
}
