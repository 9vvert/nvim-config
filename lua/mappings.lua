require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map({ "n", "v" }, "<M-h>", "5h")
map({ "n", "v" }, "<M-j>", "5j")
map({ "n", "v" }, "<M-k>", "5k")
map({ "n", "v" }, "<M-l>", "5l")

-- Ignore mouse clicks so focus/cursor stays put; scroll/resize still works with mouse=a
map({ "", "i", "c" }, "<LeftMouse>", "<Nop>")
map({ "", "i", "c" }, "<LeftRelease>", "<Nop>")
map({ "", "i", "c" }, "<2-LeftMouse>", "<Nop>")
map({ "", "i", "c" }, "<RightMouse>", "<Nop>")
map({ "", "i", "c" }, "<MiddleMouse>", "<Nop>")

-- tabufline
nomap("n", "<Tab>")
nomap("n", "<S-Tab>")
nomap("n", "<leader>x")
map("n", "<M-,>", function()
  require("nvchad.tabufline").prev()
end)
map("n", "<M-.>", function()
  require("nvchad.tabufline").next()
end)
map("n", "<M-/>", function()
  require("nvchad.tabufline").close_buffer()
end)
