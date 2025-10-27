return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
    },
    config = function()
        require("barbar").setup({})
        -- order the buffer
        vim.keymap.set("n", "<leader>bon", "<cmd>BufferOrderByName<CR>", { desc = "Buffer Order by Name" })
        vim.keymap.set("n", "<leader>bod", "<cmd>BufferOrderByDirectory<CR>", { desc = "Buffer Order by Directory" })
        vim.keymap.set("n", "<leader>bol", "<cmd>BufferOrderByLanguage<CR>", { desc = "Buffer Order by Language" })
        vim.keymap.set(
            "n",
            "<leader>bow",
            "<cmd>BufferOrderByWindowNumber<CR>",
            { desc = "Buffer Order by Window Number" }
        )
        vim.keymap.set(
            "n",
            "<leader>bob",
            "<cmd>BufferOrderByBufferNumber<CR>",
            { desc = "Buffer Order by Buffer Number" }
        )
        -- move between buffers & adjust buffer position
        vim.keymap.set("n", "<M-,>", "<cmd>BufferPrevious<CR>", { desc = "Move to previous buffer" })
        vim.keymap.set("n", "<M-.>", "<cmd>BufferNext<CR>", { desc = "Move to next buffer" })
        vim.keymap.set("n", "<M-<>", "<cmd>BufferMovePrevious<CR>", { desc = "Swap with previous buffer" })
        vim.keymap.set("n", "<M->>", "<cmd>BufferMoveNext<CR>", { desc = "Swap with next buffer" })
        -- close/restore buffer
        vim.keymap.set("n", "<M-/>", "<cmd>BufferClose<CR>", { desc = "Close buffer" })
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
    end,
    -- barbar PLUGIN --
}
