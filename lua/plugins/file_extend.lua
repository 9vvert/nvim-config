return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        -- NOTE: this doesn't need to be loaded
        ft = { "markdown", "codecompanion" },
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            -- NOTE: this only workds after loaded
            file_types = { "markdown", "codecompanion" },
        },
    },
}
