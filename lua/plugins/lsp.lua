return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
            ensure_installed = {
                "c",
                "cpp",
                "java",
                "asm",
                "llvm",
                "objdump",
                "cmake",
                "make",
                "go",
                "javascript",
                "typescript",
                "json",
                "lua",
                "latex",
                "markdown",
                "python",
                "rust",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            -- List of parsers to ignore installing (or "all")
            -- ignore_install = { "javascript" },

            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
                enable = true,

                -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                -- the name of the parser)
                -- list of language that will be disabled
                -- disable = { "c", "rust" },
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

                --[[ disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end, ]]

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble<cr>",
                desc = "Open Trouble Pannels",
            },
            {
                "<leader>xD",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xd",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        priority = 100,
        -- opts = {
        --   -- Style preset for diagnostic messages
        --   -- Available options: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
        --   preset = "powerline",
        --
        --   -- Set the background of the diagnostic to transparent
        --   transparent_bg = false,
        --
        --   -- Set the background of the cursorline to transparent (only for the first diagnostic)
        --   -- Default is true in the source code, not false as in the old README
        --   transparent_cursorline = true,
        --
        --   hi = {
        --     -- Highlight group for error messages
        --     error = "DiagnosticError",
        --
        --     -- Highlight group for warning messages
        --     warn = "DiagnosticWarn",
        --
        --     -- Highlight group for informational messages
        --     info = "DiagnosticInfo",
        --
        --     -- Highlight group for hint or suggestion messages
        --     hint = "DiagnosticHint",
        --
        --     -- Highlight group for diagnostic arrows
        --     arrow = "NonText",
        --
        --     -- Background color for diagnostics
        --     -- Can be a highlight group or a hexadecimal color (#RRGGBB)
        --     background = "CursorLine",
        --
        --     -- Color blending option for the diagnostic background
        --     -- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
        --     -- Default is "Normal" in the source code
        --     mixing_color = "Normal",
        --   },
        --
        --   options = {
        --     -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
        --     show_source = {
        --       enabled = false,
        --       -- Show source only when multiple sources exist for the same diagnostic
        --       if_many = true,
        --     },
        --
        --     -- Use icons defined in the diagnostic configuration instead of preset icons
        --     use_icons_from_diagnostic = true,
        --
        --     -- Set the arrow icon to the same color as the first diagnostic severity
        --     set_arrow_to_diag_color = true,
        --
        --     -- Add messages to diagnostics when multiline diagnostics are enabled
        --     -- If set to false, only signs will be displayed
        --     add_messages = true,
        --
        --     -- Time (in milliseconds) to throttle updates while moving the cursor
        --     -- Increase this value for better performance on slow computers
        --     -- Set to 0 for immediate updates and better visual feedback
        --     throttle = 20,
        --
        --     -- Minimum message length before wrapping to a new line
        --     softwrap = 30,
        --
        --     -- Configuration for multiline diagnostics
        --     -- Can be a boolean or a table with detailed options
        --     multilines = {
        --       -- Enable multiline diagnostic messages
        --       enabled = false,
        --
        --       -- Always show messages on all lines for multiline diagnostics
        --       always_show = false,
        --
        --       -- Trim whitespaces from the start/end of each line
        --       trim_whitespaces = false,
        --
        --       -- Replace tabs with this many spaces in multiline diagnostics
        --       tabstop = 4,
        --     },
        --
        --     -- Display all diagnostic messages on the cursor line, not just those under cursor
        --     show_all_diags_on_cursorline = true,
        --
        --     -- Enable diagnostics in Insert mode
        --     -- If enabled, consider setting throttle to 0 to avoid visual artifacts
        --     enable_on_insert = false,
        --
        --     -- Enable diagnostics in Select mode (e.g., when auto-completing with Blink)
        --     enable_on_select = false,
        --
        --     -- Manage how diagnostic messages handle overflow
        --     overflow = {
        --       -- Overflow handling mode:
        --       -- "wrap" - Split long messages into multiple lines
        --       -- "none" - Do not truncate messages
        --       -- "oneline" - Keep the message on a single line, even if it's long
        --       mode = "wrap",
        --
        --       -- Trigger wrapping this many characters earlier when mode == "wrap"
        --       -- Increase if the last few characters of wrapped diagnostics are obscured
        --       -- If set to 0, the last word in a line may not be showns fully
        --       -- The config in statuscol may affects this ! (wider status colume needs larger padding to work normally. but good news is that neo-tree doesn't matter since it will adjust autmatically)
        --       padding = 16,
        --     },
        --
        --     -- Configuration for breaking long messages into separate lines
        --     break_line = {
        --       -- Enable breaking messages after a specific length
        --       enabled = false,
        --
        --       -- Number of characters after which to break the line
        --       after = 30,
        --     },
        --
        --     -- Custom format function for diagnostic messages
        --     -- Function receives a diagnostic object and should return a string
        --     -- Example: function(diagnostic) return diagnostic.message .. " [" .. diagnostic.source .. "]" end
        --     format = nil,
        --
        --     -- Virtual text display configuration
        --     virt_texts = {
        --       -- Priority for virtual text display (higher values appear on top)
        --       -- Increase if other plugins (like GitBlame) override diagnostics
        --       priority = 2048,
        --     },
        --
        --     -- Filter diagnostics by severity levels
        --     -- Available severities: vim.diagnostic.severity.ERROR, WARN, INFO, HINT
        --     severity = {
        --       vim.diagnostic.severity.ERROR,
        --       vim.diagnostic.severity.WARN,
        --       vim.diagnostic.severity.INFO,
        --       vim.diagnostic.severity.HINT,
        --     },
        --
        --     -- Events to attach diagnostics to buffers
        --     -- Default: { "LspAttach" }
        --     -- Only change if the plugin doesn't work with your configuration
        --     overwrite_events = nil,
        --   },
        --
        --   -- List of filetypes to disable the plugin for
        --   disabled_ft = {},
        --   signs = {
        --     left = "", -- Left border character
        --     right = "", -- Right border character
        --     diag = "●", -- Diagnostic indicator character
        --     arrow = "    ", -- Arrow pointing to diagnostic
        --     up_arrow = "    ", -- Upward arrow for multiline
        --     vertical = " │", -- Vertical line for multiline
        --     vertical_end = " └", -- End of vertical line for multiline
        --   },
        --   blend = {
        --     factor = 0.22, -- Transparency factor (0.0 = transparent, 1.0 = opaque)
        --   },
        -- },
    },
    ------------------ comments ----------------
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },

        config = function()
            require("todo-comments").setup {
                vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Todo Telescope" }),
            }
        end,
    },
}
