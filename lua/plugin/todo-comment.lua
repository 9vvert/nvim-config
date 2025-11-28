local keymap = require("vim.keymap")
return
-- Highlight todo, notes, etc in comments
{
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },

    config = function()
        require("todo-comments").setup({
            vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Todo Telescope" }),
        })
    end,
}
