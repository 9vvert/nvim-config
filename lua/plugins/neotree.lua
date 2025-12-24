return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
        vim.keymap.set("n", "<M-r>", "<cmd>Neotree show toggle<Enter>", { desc = "file explorer" }),
        vim.keymap.set("n", "<M-R>", ":Neotree ", { desc = "file explorer" }),
    },
    config = function()
        require("neo-tree").setup({
            window = {
                width = 30,
                auto_expand_width = true,
            },
        })
    end,
}
