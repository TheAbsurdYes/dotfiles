-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- one dark theme
  -- { import = 'user.plugins.onedark' },

  -- colorscheme
  { import = 'user.plugins.colorscheme' },

  -- Commenting support.
  'tpope/vim-commentary',

  -- Add, change, and delete surrounding text.
  { import = 'user.plugins.surround' },

  -- Useful commands like :Rename and :SudoWrite.
  { 'tpope/vim-eunuch' },

  -- Pairs of handy bracket mappings, like [b and ]b.
  { 'tpope/vim-unimpaired' },

  -- Indent autodetection with editorconfig support.
  { 'tpope/vim-sleuth' },

  -- Allow plugins to enable repeating of commands.
  { 'tpope/vim-repeat' },

  -- Add more languages.
  -- {'sheerun/vim-polyglot'},

  -- Navigate seamlessly between Vim windows and Tmux panes.
  -- {'christoomey/vim-tmux-navigator'},

  -- Jump to the last location when opening a file.
  { 'farmergreg/vim-lastplace' },

  -- Enable * searching with visually selected text.
  { 'nelstrom/vim-visual-star-search' },

  -- Automatically create parent dirs when saving.
  { 'jessarcher/vim-heritage' },

  -- Text objects for HTML attributes.
  {
    'whatyouhide/vim-textobj-xmlattr',
    dependencies = 'kana/vim-textobj-user',
  },

  -- Automatically set the working directory to the project root.
  { import = "user.plugins.vim-rooter" },

  -- Automatically add closing brackets, quotes, etc.
  { 'windwp/nvim-autopairs',                 config = true },

  -- Add smooth scrolling to avoid jarring jumps
  -- { 'karb94/neoscroll.nvim', config = true },

  -- All closing buffers without closing the split window.
  { import = "user.plugins.bufdelete" },

  -- Split arrays and methods onto multiple lines, or join them back up.
  { import = "user.plugins.treesj" },

  -- Automatically fix indentation when pasting code.
  { import = "user.plugins.vim-pasta" },

  -- Fuzzy finder
  { import = 'user.plugins.telescope' },

  -- File tree sidebar
  -- { import = 'user.plugins.nvim-tree'},
  { import = 'user.plugins.oil' },

  -- A Status line.
  { import = 'user.plugins.lualine' },

  -- Display buffers as tabs.
  -- { import = 'user.plugins.bufferline'},

  -- Display indentation lines.
  { import = 'user.plugins.indent-blankline' },

  { import = 'user.plugins.dashboard-nvim' },

  { import = 'user.plugins.gitsigns' },

  { 'tpope/vim-fugitive',                    dependencies = 'tpope/vim-rhubarb' },

  --- Floating terminal.
  { import = 'user.plugins.floaterm' },

  -- Improved syntax highlighting
  { import = 'user.plugins.treesitter' },

  -- Language Server Protocol.
  { import = 'user.plugins.lspconfig' },

  -- Completion
  -- { import = 'user.plugins.cmp' },
  { import = 'user.plugins.blink' },

  -- PHP Refactoring Tools
  { import = 'user.plugins.phpactor' },

  -- Project Configuration.
  { import = 'user.plugins.projectionist' },

  -- Testing helper
  { import = 'user.plugins.vim-test' },

  -- Folke noice
  { import = 'user.plugins.noice' },

  -- Orgmode
  { import = 'user.plugins.orgmode' },

  -- venv
  { import = 'user.plugins.venv' },

  -- harpoon
  { import = 'user.plugins.harpoon' },

  -- text case manipulation
  { import = 'user.plugins.text-case' },

  -- database stuff
  { import = 'user.plugins.dadbod' },

  -- better commands I guess
  { import = 'user.plugins.dispatch' },

  -- code snapshot
  { import = 'user.plugins.codesnap' },

  { import = 'user.plugins.snacks' },

  { import = 'user.plugins.refactoring' },

  -- { import = 'user.plugins.avante' },

  -- multiple cursors
  -- { import = 'user.plugins.multi' },

  -- tab-out feature
  { import = 'user.plugins.tab-out' },

  -- multiple cursors
  { import = 'user.plugins.multicursor' },

  -- compile mode
  -- { import = 'user.plugins.compile-mode' },

  { import = 'user.plugins.quicker'},

  -- linter
  { import = 'user.plugins.nvim-lint'},

  -- formatter
  { import = 'user.plugins.conform'},

  -- { import = 'user.plugins.nvim-dap' }

  -- { import = 'user.plugins.mason-nvim-dap' }

  -- { import = 'user.plugins.nvim-dap-ui' }

})
