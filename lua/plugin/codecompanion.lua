return {
    "olimorris/codecompanion.nvim",
    version = "v17.33.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>ic", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion Chat" },
        { "<leader>ii", ":CodeCompanion copilot ", mode = { "v" }, desc = "Toggle CodeCompanion Chat" },
        { "<leader>ii", ":CodeCompanion copilot #{buffer} ", mode = { "n" }, desc = "Toggle CodeCompanion Chat" },
    },
    opts = {
        -- 这里直接用字符串指定 Copilot 适配器
        strategies = {
            chat = {
                adapter = {
                    name = "copilot",
                    model = "gpt-4.1",
                },
            },
            inline = { adapter = "copilot" },
            cmd = { adapter = "copilot" },
        },
        -- NOTE: log_level 要放在 opts.opts 里
        opts = {
            log_level = "DEBUG",
        },
    },
}
