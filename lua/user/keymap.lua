-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

-- Split Window
vim.keymap.set("n", "<leader>cv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>ch", "<cmd>split<CR>", { desc = "Split window horizonally" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Custom keybinds
vim.keymap.set("n", "<M-h>", "5h", { desc = "Move left quickly" })
vim.keymap.set("n", "<M-l>", "5l", { desc = "Move right quickly" })
vim.keymap.set("n", "<M-j>", "5j", { desc = "Move lower quickly" })
vim.keymap.set("n", "<M-k>", "5k", { desc = "Move upper quickly" })
vim.keymap.set("n", "<M-e>", "5<C-e>", { desc = "Move screen down quickly" })
vim.keymap.set("n", "<M-y>", "5<C-y>", { desc = "Move screen up quickly" })

-- use emacs keybinds in insert mode
vim.keymap.set("i", "<C-f>", "<right>", { desc = "Move forward" })
vim.keymap.set("i", "<C-b>", "<left>", { desc = "Move backward" })
vim.keymap.set("i", "<C-e>", "<end>", { desc = "Move to end" })
vim.keymap.set("i", "<C-a>", "<home>", { desc = "Move to begin" })

-- smart split keymappings
-- vim.keymap.set('n', '<leader>wh', require('smart-splits').resize_left)

-- bracket and indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- vim.keymap.set('i', '(', '()<left>', { desc = 'Move forward' })
-- vim.keymap.set('i', '[', '[]<left>', { desc = 'Move backward' })
-- vim.keymap.set('i', '{', '{}<left>', { desc = 'Move forward' })
-- vim.keymap.set('i', "'", "''<left>", { desc = 'Move backward' })
-- vim.keymap.set('i', '"', '""<left>', { desc = 'Move backward' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- barbar PLUGIN --
-- order the buffer
vim.keymap.set("n", "<leader>bon", "<cmd>BufferOrderByName<CR>", { desc = "Buffer Order by Name" })
vim.keymap.set("n", "<leader>bod", "<cmd>BufferOrderByDirectory<CR>", { desc = "Buffer Order by Directory" })
vim.keymap.set("n", "<leader>bol", "<cmd>BufferOrderByLanguage<CR>", { desc = "Buffer Order by Language" })
vim.keymap.set("n", "<leader>bow", "<cmd>BufferOrderByWindowNumber<CR>", { desc = "Buffer Order by Window Number" })
vim.keymap.set("n", "<leader>bob", "<cmd>BufferOrderByBufferNumber<CR>", { desc = "Buffer Order by Buffer Number" })
-- move between buffers & adjust buffer position
vim.keymap.set("n", "<M-,>", "<cmd>BufferPrevious<CR>", { desc = "Move to previous buffer" })
vim.keymap.set("n", "<M-.>", "<cmd>BufferNext<CR>", { desc = "Move to next buffer" })
vim.keymap.set("n", "<M-<>", "<cmd>BufferMovePrevious<CR>", { desc = "Swap with previous buffer" })
vim.keymap.set("n", "<M->>", "<cmd>BufferMoveNext<CR>", { desc = "Swap with next buffer" })
-- close/restore buffer
vim.keymap.set("n", "<M-c>", "<cmd>BufferClose<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<M-s-c>", "<cmd>BufferRestore<CR>", { desc = "Restore buffer" })
-- magic buffer mode
vim.keymap.set("n", "<leader>bs", "<cmd>BufferPick<CR>", { desc = "Select buffer in magic mode" })
vim.keymap.set("n", "<leader>bk", "<cmd>BufferPickDelete<CR>", { desc = "Kill buffer in magic mode" })
-- goto buffer in position
vim.keymap.set("n", "<M-0>", "<cmd>BufferLast<CR>", { desc = "Goto last buffer" })
vim.keymap.set("n", "<M-1>", "<cmd>BufferGoto 1<CR>", { desc = "goto buffer 1" })
vim.keymap.set("n", "<M-2>", "<cmd>BufferGoto 2<CR>", { desc = "goto buffer 2" })
vim.keymap.set("n", "<M-3>", "<cmd>BufferGoto 3<CR>", { desc = "goto buffer 3" })
vim.keymap.set("n", "<M-4>", "<cmd>BufferGoto 4<CR>", { desc = "goto buffer 4" })
vim.keymap.set("n", "<M-5>", "<cmd>BufferGoto 5<CR>", { desc = "Goto buffer 5" })
vim.keymap.set("n", "<M-6>", "<cmd>BufferGoto 6<CR>", { desc = "Goto buffer 6" })
vim.keymap.set("n", "<M-7>", "<cmd>BufferGoto 7<CR>", { desc = "Goto buffer 7" })
vim.keymap.set("n", "<M-8>", "<cmd>BufferGoto 8<CR>", { desc = "Goto buffer 8" })
vim.keymap.set("n", "<M-9>", "<cmd>BufferGoto 9<CR>", { desc = "Goto buffer 9" })
