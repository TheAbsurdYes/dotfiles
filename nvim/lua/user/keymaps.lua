-- Space is my leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

---- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

---- Maintain the cursor position when yanking a visual selection
---- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

---- Disable annoying command line thing
vim.keymap.set('n', 'q:', ':q<CR>')

---- Easy insertion of a trailing ; or , from insert mode
vim.keymap.set('i', ';;', '<Esc>A;<Esc>');
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

---- Quickly clear search highlighting.
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>')

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
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")
