return {
    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },

            -- Allows extra capabilities provided by blink.cmp
            "saghen/blink.cmp",
        },
        config = function()
            -- Brief aside: **What is LSP?**
            --
            -- LSP is an initialism you've probably heard, but might not understand what it is.
            --
            -- LSP stands for Language Server Protocol. It's a protocol that helps editors
            -- and language tooling communicate in a standardized fashion.
            --
            -- In general, you have a "server" which is some tool built to understand a particular
            -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
            -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
            -- processes that communicate with some "client" - in this case, Neovim!
            --
            -- LSP provides Neovim with features like:
            --  - Go to definition
            --  - Find references
            --  - Autocompletion
            --  - Symbol Search
            --  - and more!
            --
            -- Thus, Language Servers are external tools that must be installed separately from
            -- Neovim. This is where `mason` and related plugins come into play.
            --
            -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
            -- and elegantly composed help section, `:help lsp-vs-treesitter`

            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                    -- to define small helper and utility functions so you don't have to repeat yourself.
                    --
                    -- In this case, we create a function that lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- Rename the variable under your cursor.
                    --  Most Language Servers support renaming across files, etc.
                    map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

                    -- Find references for the word under your cursor.
                    map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                    -- Jump to the implementation of the word under your cursor.
                    --  Useful when your language has ways of declaring types without an actual implementation.
                    map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-t>.
                    map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    -- Fuzzy find all the symbols in your current document.
                    --  Symbols are things like variables, functions, types, etc.
                    map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

                    -- Fuzzy find all the symbols in your current workspace.
                    --  Similar to document symbols, except searches over your entire project.
                    map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

                    -- Jump to the type of the word under your cursor.
                    --  Useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

                    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                    ---@param client vim.lsp.Client
                    ---@param method vim.lsp.protocol.Method
                    ---@param bufnr? integer some lsp support methods only in specific files
                    ---@return boolean
                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has "nvim-0.11" == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client_supports_method(
                            client,
                            vim.lsp.protocol.Methods.textDocument_documentHighlight,
                            event.buf
                        )
                    then
                        local highlight_augroup =
                            vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if
                        client
                        and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                    then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, "[T]oggle Inlay [H]ints")
                    end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = "rounded", source = "if_many" },
                underline = { severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR } },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                } or {},

                virtual_text = false, --[[ {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
        }, ]]
            }

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- But for many setups, the LSP (`ts_ls`) will work just fine
                -- ts_ls = {},
                --
                ast_grep = {},
                clangd = {},
                cmake = {},
                pyright = {},
                ruby_lsp = {},
                rust_analyzer = {},
                ts_ls = {},
                -- gopls = {},
                yamlls = {},
                asm_lsp = {},
                awk_ls = {},

                hls = {},

                lua_ls = {
                    -- cmd = { ... },
                    -- filetypes = { ... },
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            --
            -- To check the current status of installed tools and/or manually install
            -- other tools, you can run
            --    :Mason
            --
            -- You can press `g?` for help in this menu.
            --
            -- `mason` had to be setup earlier: to configure its options see the
            -- `dependencies` table for `nvim-lspconfig` above.
            --
            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua", -- Used to format Lua code
            })
            require("mason-tool-installer").setup { ensure_installed = ensure_installed }

            require("mason-lspconfig").setup {
                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
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
        opts = {
            signs = false, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "todo" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = {} },
                INFO = { icon = " ", color = "info", alt = { "SOME" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            gui_style = {
                fg = "NONE", -- The gui style to use for the fg highlight group.
                bg = "BOLD", -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "", -- "fg" or "bg" or empty
                keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            colors = {
                error = { "#DC2626" },
                warning = { "#f59842" },
                todo = { "#e0e86d" },
                info = { "#2563EB" },
                hint = { "#10B981" },
                default = { "#7C3AED" },
                test = { "#FF00FF" },
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },
        },

        keys = {

            "<leader>st",
            "<cmd>TodoTelescope<CR>",
            mode = "n",
            desc = "Todo Telescope",
        },
    },
}
