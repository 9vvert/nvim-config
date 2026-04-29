return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            interactions = {
                chat = {
                    -- You can specify an adapter by name and model (both ACP and HTTP)
                    adapter = {
                        name = "copilot",
                        model = "gpt-4.1",
                    },
                },
                inline = {
                    adapter = {
                        name = "copilot",
                        model = "gpt-4.1",
                    },
                },
                cmd = {
                    adapter = {
                        name = "copilot",
                        model = "gpt-4.1",
                    },
                },
                background = {
                    adapter = {
                        name = "copilot",
                        model = "gpt-4.1",
                    },
                },
            },
            -- NOTE: The log_level is in `opts.opts`
            opts = {
                log_level = "DEBUG",
            },
        },

        keys = {
            {
                "<leader>a",
                "<cmd>CodeCompanionChat Toggle<cr>",
                mode = { "n", "v" },
                desc = "Toggle CodeCompanion chat",
            },
            -- {
            --     "<leader>ai",
            --     "<cmd>CodeCompanion<cr>",
            --     mode = { "n", "v" },
            --     desc = "CodeCompanion inline",
            -- },
            -- {
            --     "<leader>al",
            --     "<cmd>CodeCompanionCLI<cr>",
            --     mode = "n",
            --     desc = "CodeCompanion CLI",
            -- },
            -- {
            --     "<leader>ad",
            --     "<cmd>CodeCompanionCmd<cr>",
            --     mode = "n",
            --     desc = "Generate command with CodeCompanion",
            -- },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        dependencies = {
            "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
        },
        cmd = "Copilot",
        -- only used to auth, so disabled its suggestion
        -- NOTE: run ":Copilot auth"
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
}
