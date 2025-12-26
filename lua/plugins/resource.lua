return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
        config = function()
            -- Telescope is a fuzzy finder that comes with a lot of different things that
            -- it can fuzzy find! It's more than just a "file finder", it can search
            -- many different aspects of Neovim, your workspace, LSP, and more!
            --
            -- The easiest way to use Telescope, is to start by doing something like:
            --  :Telescope help_tags
            --
            -- After running this command, a window will open up and you're able to
            -- type in the prompt window. You'll see a list of `help_tags` options and
            -- a corresponding preview of the help.
            --
            -- Two important keymaps to use while in Telescope are:
            --  - Insert mode: <c-/>
            --  - Normal mode: ?
            --
            -- This opens a window that shows you all of the keymaps for the current
            -- Telescope picker. This is really useful to discover what Telescope can
            -- do as well as how to actually do it!

            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`
            require("telescope").setup {
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                -- defaults = {
                --   mappings = {
                --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                --   },
                -- },
                -- pickers = {}
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            -- See `:help telescope.builtin`
            local builtin = require "telescope.builtin"
            vim.keymap.set("n", "<leader>shp", builtin.help_tags, { desc = "[S]earch [H]el[p]" })
            vim.keymap.set("n", "<leader>skm", builtin.keymaps, { desc = "[S]earch [K]ey[m]aps" })
            vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>se", builtin.resume, { desc = "[S]earch R[e]sume" })
            vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "[S]earch [R]e[g]ister" })
            vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            -- vim.keymap.set("n", "<leader>so", "<cmd>Lspsaga outline<CR>", { desc = "Lspsaga [O]utline" })
            vim.keymap.set("n", "<leader>sa", builtin.marks, { desc = "[S]earch [M]ark" })

            -- LSP

            vim.keymap.set("n", "<leader>lsw", builtin.lsp_workspace_symbols, { desc = "[L]ist [W]orkspace [S]ymbol" })
            vim.keymap.set("n", "<leader>lsd", builtin.lsp_document_symbols, { desc = "[L]ist [D]ocument [S]ymbol" })
            vim.keymap.set("n", "<leader>lts", builtin.treesitter, { desc = "[L]ist [T]ree[s]itter" })
            vim.keymap.set("n", "<leader>lqf", builtin.quickfix, { desc = "[L]ist [Q]uickfix" })
            vim.keymap.set("n", "<leader>lic", builtin.lsp_incoming_calls, { desc = "[L]ist [I]ncoming [C]alls" })
            vim.keymap.set("n", "<leader>loc", builtin.lsp_outgoing_calls, { desc = "[L]ist [O]utgoing [C]alls" })
            vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "[L]ist [R]eference" })
            vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "[L]ist [D]efinition" })
            vim.keymap.set("n", "<leader>lm", builtin.lsp_implementations, { desc = "[L]ist I[m]plementations" })
            vim.keymap.set("n", "<leader>ltd", builtin.lsp_type_definitions, { desc = "[L]ist [T]ype [D]efinition" })

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set("n", "<leader>sb", function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = "[/] Fuzzily search in current buffer" })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set("n", "<leader>s/", function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                }
            end, { desc = "[S]earch [/] in Open Files" })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set("n", "<leader>sn", function()
                builtin.find_files { cwd = vim.fn.stdpath "config" }
            end, { desc = "[S]earch [N]eovim files" })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
        keys = {
            vim.keymap.set("n", "<M-r>", "<cmd>Neotree show toggle<Enter>", { desc = "file explorer" }),
            vim.keymap.set("n", "<M-R>", ":Neotree ", { desc = "file explorer" }),
        },
        config = function()
            require("neo-tree").setup {
                window = {
                    width = 30,
                    auto_expand_width = true,
                },
            }
        end,
    },
}
