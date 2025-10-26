return {
    "rcarriga/nvim-notify",
    keys = {
        vim.keymap.set("n", "<leader>st", "<cmd>Telescope notify<Enter>", { desc = "[S]earch Notifications" }),
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("notify").setup({
            render = "wrapped-default",
            timeout = 3,
            max_width = 50,
            max_height = 8,
        })
    end,
}
