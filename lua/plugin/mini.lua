return {
    {
        "nvim-mini/mini.nvim",
        version = "*",
        config = function()
            -- text editing
            -- require("mini.pairs").setup({})
            -- require("mini.surround").setup({})
            --

            -- apperance
            require("mini.indentscope").setup({})
            require("mini.map").setup({})
            require("mini.diff").setup({})
        end,
    },
}
