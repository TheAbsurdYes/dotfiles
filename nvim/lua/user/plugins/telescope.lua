return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  keys = {
    { '<leader><leader>', function() require('telescope.builtin').find_files() end },
    { '<leader>fh',       function() require('telescope.builtin').help_tags() end },
    { '<leader>F',        function() require('telescope.builtin').find_files({ no_ignore = true, prompt_title =
      'All Files' }) end },
    { '<leader>b',        function() require('telescope.builtin').buffers() end },
    { '<leader>g',        function() require('telescope').extensions.live_grep_args.live_grep_args() end },
    { '<leader>h',        function() require('telescope.builtin').oldfiles() end },
    { '<leader>s',        function() require('telescope.builtin').lsp_document_symbols() end },
    { '<leader>y',        function() require('telescope.builtin').lsp_workspace_symbols() end },
    { '<leader>w',        function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end },
    { '<leader>x',        function() require('telescope.builtin').diagnostics() end },
    { 'z=',        function() require('telescope.builtin').spell_suggest() end },
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        path_display = { truncate = 1 },
        prompt_prefix = '   ',
        selection_caret = '  ',
        layout_config = {
          prompt_position = 'top',
        },
        preview = {
          timeout = 200,
        },
        sorting_strategy = 'ascending',
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-Down>'] = actions.cycle_history_next,
            ['<C-Up>'] = actions.cycle_history_prev,
          },
        },
        file_ignore_patterns = { '.git/' },
      },
      extensions = {
        live_grep_args = {
          mappings = {
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
        fzf = {},
        ['ui-select'] = {},
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          previewer = false,
          layout_config = {
            width = 80,
          },
        },
        oldfiles = {
          prompt_title = 'History',
        },
        lsp_references = {
          previewer = false,
        },
        lsp_definitions = {
          previewer = false,
        },
        lsp_document_symbols = {
          symbol_width = 55,
        },
      },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
  end,
}
