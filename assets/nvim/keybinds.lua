-- general navigation
vim.keymap.set({"n","v"}, "H", "^")  -- go to start of line
vim.keymap.set({"n","v"}, "L", "$")  -- go to end of line

-- split navigation
vim.keymap.set("n", "<C-j>", "<C-W><C-j>")  -- move to split below
vim.keymap.set("n", "<C-k>", "<C-W><C-k>")  -- move to split above
vim.keymap.set("n", "<C-l>", "<C-W><C-l>")  -- move to split right
vim.keymap.set("n", "<C-h>", "<C-W><C-h>")  -- move to split left

-- terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")  -- exit terminal mode

-- search
vim.keymap.set("n", "<leader>/", ":noh<CR>")  -- clear search highlight
vim.keymap.set("n", "<Esc>", ":noh<CR>")  -- clear search highlight

-- edit
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")  -- move line up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")  -- move line down

-- claude code
vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>")  -- toggle Claude

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

-- auto commands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

