return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
        "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
        require("lspsaga").setup({})

        vim.keymap.set("n", "<leader>pd", ":Lspsaga peek_definition<Enter>", { desc = "Lspsaga peek definition" })
        vim.keymap.set(
            "n",
            "<leader>pD",
            ":Lspsaga peek_type_definition<Enter>",
            { desc = "Lspsaga peek type definition" }
        )
        vim.keymap.set("n", "<leader>gd", ":Lspsaga goto_definition<Enter>", { desc = "Lspsaga goto definition" })
        vim.keymap.set(
            "n",
            "<leader>gD",
            ":Lspsaga goto_type_definition<Enter>",
            { desc = "Lspsaga goto type definition" }
        )
        vim.keymap.set("n", "<leader>F", ":Lspsaga finder<Enter>", { desc = "Lspsaga symbol finder" })
        vim.keymap.set("n", "<leader>o", ":Lspsaga outline<Enter>", { desc = "Lspsaga outline" })
    end,
}
