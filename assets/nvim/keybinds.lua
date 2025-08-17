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

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- auto commands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

