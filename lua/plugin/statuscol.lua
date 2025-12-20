return {
    "luukvbaal/statuscol.nvim",
    config = function()
        -- Custom function to show both absolute and relative line numbers
        -- vim.api.nvim_set_hl(0, "current_vert_split", { fg = "#ffa500", bg = "NONE" })
        local function lnum_both()
            local lnum = vim.v.lnum
            local relnum = vim.v.lnum == vim.fn.line(".") and 0 or math.abs(vim.v.lnum - vim.fn.line("."))
            return string.format("%3d %2d", lnum, relnum)
        end
        require("statuscol").setup({
            setopt = true,
            ft_ignore = { "neo-tree" },
            segments = {
                -- git signs
                {
                    sign = {
                        namespace = { "gitsigns.*" },
                        name = { "gitsigns.*" },
                    },
                },

                -- number lines
                {
                    text = { lnum_both, " " },
                    condition = {
                        function(args)
                            return vim.v.lnum ~= vim.fn.line(".")
                        end,
                    },
                    click = "v:lua.ScLa",
                },
                {
                    text = { lnum_both, " " },
                    hl = "current_vert_split",
                    condition = {
                        function(args)
                            return vim.v.lnum == vim.fn.line(".")
                        end,
                    },
                    click = "v:lua.ScLa",
                },
                -- error/warnning symbols
                {
                    sign = {
                        maxwidth = 1,
                        fillchar = " ",
                        namespace = { ".*" },
                        name = { ".*" },
                        -- set auto to false: allocate a place for sign even if it doesn't exist
                        auto = false,
                    },
                },
                -- vertical split line
                {
                    text = { " . " },
                    condition = {
                        function(args)
                            return vim.v.lnum ~= vim.fn.line(".")
                        end,
                    },
                },
                {
                    text = { "-> " },
                    hl = "current_vert_split",
                    condition = {
                        function(args)
                            return vim.v.lnum == vim.fn.line(".")
                        end,
                    },
                },
            },
        })
    end,
}
