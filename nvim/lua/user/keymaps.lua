-- Space is my leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

---- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

---- Maintain the cursor position when yanking a visual selection
---- http://ddrscott.github.io/log/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

---- Disable annoying command line thing
-- vim.keymap.set('n', 'q:', ':q<CR>')

---- Easy insertion of a trailing ; or , from insert mode
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

vim.keymap.set('n', ';;', 'A;<Esc>')
vim.keymap.set('n', ',,', 'A,<Esc>')

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

---- Quickly clear search highlighting.
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>', { silent = true})
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>', { silent = true })

---- Open the current file in the default program (on Mac this should just be just `open`)
vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>')

---- Allow gf to open non-existent files
--vim.keymap.set('', 'gf', ':edit <cfile><CR>')

---- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

---- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<CR>')

---- Move text up and down
-- vim.keymap.set('i', '<C-j>', '<Esc>:move .+1<CR>==gi')
-- vim.keymap.set('i', '<C-k>', '<Esc>:move .-2<CR>==gi')
-- vim.keymap.set('n', '<C-j>', ':move .+1<CR>==')
-- vim.keymap.set('n', '<C-k>', ':move .-2<CR>==')
vim.keymap.set('x', '<C-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<C-k>', ":move '<-2<CR>gv-gv")

vim.keymap.set('n', 'gh', '0')
vim.keymap.set('n', 'gl', '$')

vim.keymap.set('n', '<leader>zz', '<cmd>w<CR>', { silent = true })
vim.keymap.set('n', '<leader>za', '<cmd>wa<CR>', { silent = true })

vim.keymap.set('n', '<C-J>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<C-K>', '<cmd>cprev<CR>')

---- Debbuging helpers
-- vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>')
-- vim.keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>')
-- vim.keymap.set("n", "<leader>dl", ":DapStepInto<CR>")
-- vim.keymap.set("n", "<leader>dj", ":DapStepOver<CR>")
-- vim.keymap.set("n", "<leader>dh", ":DapStepOut<CR>")
-- vim.keymap.set("n", "<leader>dz", ":ZoomWinTabToggle<CR>")
-- vim.keymap.set(
--     "n",
--     "<leader>dgt",  -- dg as in debu[g] [t]race
--     ":lua require('dap').set_log_level('TRACE')<CR>"
-- )
-- vim.keymap.set(
--     "n",
--     "<leader>dge",  -- dg as in debu[g] [e]dit
--     function()
--         vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log")
--     end
-- )
-- vim.keymap.set("n", "<F1>", ":DapStepOut<CR>")
-- vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
-- vim.keymap.set("n", "<F3>", ":DapStepInto<CR>")
-- vim.keymap.set(
--     "n",
--     "<leader>d-",
--     function()
--         require("dap").restart()
--     end
-- )
-- vim.keymap.set(
--     "n",
--     "<leader>d_",
--     function()
--         require("dap").terminate()
--         require("dapui").close()
--     end
-- )
