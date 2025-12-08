return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
        { "<M-,>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        { "<M-.>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
        {
            "<M-/>",
            function()
                local is_neotree_open = require("neo-tree.sources.manager").get_state("filesystem").winid

                if is_neotree_open then
                    vim.cmd("Neotree toggle")
                    vim.cmd("bdelete")
                    vim.cmd("Neotree toggle")
                else
                    vim.cmd("bdelete")
                end
            end,
            desc = "Close tab",
        },
    },
    config = function()
        require("bufferline").setup({
            options = {
                separator_style = "slant",
                buffer_close_icon = "󰅖",
                modified_icon = "● ",
                close_icon = " ",
                left_trunc_marker = " ",
                right_trunc_marker = " ",
                -- diagnostics
                diagnostics = "nvim_lsp",
                diagnostics_update_on_event = true, -- use nvim's diagnostic handler
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    return "(" .. count .. ")"
                end,

                --
                color_icons = true, -- whether or not to add the filetype icon highlights
            },
            -- groups = {
            --     options = {
            --         toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
            --     },
            --     items = {
            --         {
            --             name = "Tests", -- Mandatory
            --             highlight = { underline = true, sp = "blue" }, -- Optional
            --             priority = 2, -- determines where it will appear relative to other groups (Optional)
            --             icon = " ", -- Optional
            --             matcher = function(buf) -- Mandatory
            --                 return buf.filename:match("%_test") or buf.filename:match("%_spec")
            --             end,
            --         },
            --         {
            --             name = "Docs",
            --             highlight = { undercurl = true, sp = "green" },
            --             auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
            --             matcher = function(buf)
            --                 return buf.filename:match("%.md") or buf.filename:match("%.txt")
            --             end,
            --             separator = { -- Optional
            --                 style = require("bufferline.groups").separator.tab,
            --             },
            --         },
            --     },
            -- },
        })
    end,
}
