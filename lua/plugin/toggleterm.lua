return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            vim.keymap.set("n", "<M-t>", ":ToggleTerm direction=float<Enter>", { desc = "toggle new float terminal" }),
            vim.keymap.set("n", "<M-g>", ":ToggleTerm<Enter>", { desc = "toggle new bottom terminal" }),
        })
    end,
}
