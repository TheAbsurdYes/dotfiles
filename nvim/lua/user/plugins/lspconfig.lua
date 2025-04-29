return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    -- { 'jose-elias-alvarez/null-ls.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    -- 'jayp0521/mason-null-ls.nvim',
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    -- Setup Mason to automatically install LSP servers
    require('mason').setup()
    require('mason-lspconfig').setup({ automatic_installation = true })

    -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Lua
    require('lspconfig').lua_ls.setup({
      -- enabled = false,
      single_file_support = true,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            workspaceWord = true,
            callSnippet = "Both",
          },
          misc = {
            parameters = {
              -- "--log-level=trace",
            },
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
          doc = {
            privateName = { "^_" },
          },
          type = {
            castNumberToInteger = true,
          },
          diagnostics = {
            disable = { "incomplete-signature-doc", "trailing-space" },
            -- enable = false,
            groupSeverity = {
              strong = "Warning",
              strict = "Warning",
            },
            groupFileStatus = {
              ["ambiguity"] = "Opened",
              ["await"] = "Opened",
              ["codestyle"] = "None",
              ["duplicate"] = "Opened",
              ["global"] = "Opened",
              ["luadoc"] = "Opened",
              ["redefined"] = "Opened",
              ["strict"] = "Opened",
              ["strong"] = "Opened",
              ["type-check"] = "Opened",
              ["unbalanced"] = "Opened",
              ["unused"] = "Opened",
            },
            unusedLocalExclude = { "_*" },
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              continuation_indent_size = "2",
            },
          },
        },
      },
    })

    -- PHP
    require('lspconfig').intelephense.setup({
      commands = {
        IntelephenseIndex = {
          function()
            vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
          end,
        },
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.buf.inlay_hint(bufnr, true)
        -- end
      end,
      capabilities = capabilities
    })

    require('lspconfig').phpactor.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.completionProvider = false
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.implementationProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.renameProvider = false
        client.server_capabilities.selectionRangeProvider = false
        client.server_capabilities.signatureHelpProvider = false
        client.server_capabilities.typeDefinitionProvider = false
        client.server_capabilities.workspaceSymbolProvider = false
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.documentHighlightProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
      },
      handlers = {
        ['textDocument/publishDiagnostics'] = function() end
      }
    })

    -- Vue, JavaScript, TypeScript
    require('lspconfig').volar.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.buf.inlay_hint(bufnr, true)
        -- end
      end,
      -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
      -- This drastically improves the responsiveness of diagnostic updates on change
      -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    })

    local mason_registry = require('mason-registry')
    local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
        '/node_modules/@vue/language-server'

    local util = require('lspconfig.util')

    require('lspconfig').ts_ls.setup({
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
          },
        },
        preferences = {
          importModuleSpecifierPreference = 'non-relative',
        },
      },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
      },
    })

    -- Prisma
    require('lspconfig').prismals.setup({ capabilities = capabilities })

    -- Tailwind CSS
    require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

    require('lspconfig').emmet_ls.setup({
      capabilities = capabilities,
    })

    -- JSON
    require('lspconfig').jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      },
    })

    -- require('lspconfig').clangd.setup({
    --   on_attach = function(client, bufnr)
    --     client.server_capabilities.signatureHelpProvider = false
    --     on_attach(client, bufnr)
    --   end,
    --   capabilities = capabilities
    -- })

    require('lspconfig').elixirls.setup({
      capabilities = capabilities,
    })

    require('lspconfig').pyright.setup({
      capabilities = capabilities,
      filetypes = { "python" },
      root_dir = function(filename)
        local root_files = {
          'pyproject.toml',
          'setup.py',
          'setup.cfg',
          'requirements.txt',
          'Pipfile',
          'pyrightconfig.json',
          '.venv',
          '.git',
        }

        return util.root_pattern(unpack(root_files))(filename) or vim.fs.dirname(filename)
      end,
    })

    require('lspconfig').yamlls.setup({
      capabilities = capabilities,
      filetypes = { "yaml" },
    })

    require('lspconfig').texlab.setup({
      capabilities = capabilities,
    })

    require('lspconfig').rust_analyzer.setup({
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true
          },
          diagnostics = {
            enable = false,
          }
        }
      }
    })

    -- null-ls
    -- local null_ls = require('null-ls')
    -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    -- null_ls.setup({
    --   temp_dir = '/tmp',
    --   sources = {
    --     null_ls.builtins.diagnostics.eslint_d.with({
    --       condition = function(utils)
    --         return utils.root_has_file({ '.eslintrc.js' })
    --       end,
    --     }),
    --     -- null_ls.builtins.diagnostics.phpstan, -- TODO: Only if config file
    --     null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
    --     null_ls.builtins.formatting.eslint_d.with({
    --       condition = function(utils)
    --         return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json' })
    --       end,
    --     }),
    --     null_ls.builtins.formatting.pint.with({
    --       condition = function(utils)
    --         return utils.root_has_file({ 'vendor/bin/pint' })
    --       end,
    --     }),
    --     null_ls.builtins.formatting.prettier.with({
    --       condition = function(utils)
    --         return utils.root_has_file({
    --           '.prettierrc',
    --           '.prettierrc.json',
    --           '.prettierrc.yml',
    --           '.prettierrc.js',
    --           'prettier.config.js',
    --         })
    --       end,
    --     }),

    --     -- c stuff
    --     null_ls.builtins.formatting.clang_format,

    --     -- python
    --     null_ls.builtins.diagnostics.mypy.with({
    --       extra_args = function()
    --         local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
    --         return { "--python-executable", virtual .. "/bin/python3", "--disable-error-code=import-untyped" }
    --       end,
    --     }),
    --     null_ls.builtins.diagnostics.ruff,
    --     null_ls.builtins.formatting.black,
    --   },
    --   on_attach = function(client, bufnr)
    --     if client.supports_method("textDocument/formatting") then
    --       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --       vim.api.nvim_create_autocmd("BufWritePre", {
    --         group = augroup,
    --         buffer = bufnr,
    --         callback = function()
    --           vim.lsp.buf.format({
    --             bufnr = bufnr,
    --             timeout_ms = 5000,
    --           })
    --         end,
    --       })
    --     end
    --   end,
    -- })

    -- require('mason-null-ls').setup({ automatic_installation = true })

    -- Keymaps
    vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
    vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
    vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- Command
    vim.api.nvim_create_user_command('Format', function()
      vim.lsp.buf.format({ timeout_ms = 5000 })
    end, {})

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        source = true,
      }
    })

    -- Sign configuration
    vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
  end,
}
