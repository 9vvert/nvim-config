return {
    "nvimtools/hydra.nvim",
    config = function()
        -- create hydras in here
        local Hydra = require("hydra")
        Hydra({
            -- string? only used in auto-generated hint
            name = "RESIZE",

            -- string | string[] modes where the hydra exists, same as `vim.keymap.set()` accepts
            mode = "n",

            -- string? key required to activate the hydra, when excluded, you can use
            -- Hydra:activate()
            body = "<leader>r",

            heads = {
                { "h", "5<C-w><" },
                { "l", "5<C-w>>" },
                { "j", "5<C-w>-" },
                { "k", "5<C-w>+" },
            },
            -- -- these are explained below
            -- config = {
            --     -- see :h hydra-heads
            --     exit = false, -- set the default exit value for each head in the hydra
            --
            --     -- decides what to do when a key which doesn't belong to any head is pressed
            --     --   nil: hydra exits and foreign key behaves normally, as if the hydra wasn't active
            --     --   "warn": hydra stays active, issues a warning and doesn't run the foreign key
            --     --   "run": hydra stays active, runs the foreign key
            --     foreign_keys = nil,
            --
            --     -- see `:h hydra-colors`
            --     color = "pink", -- "red" | "amaranth" | "teal" | "pink"
            --
            --     -- define a hydra for the given buffer, pass `true` for current buf
            --     buffer = nil,
            --
            --     -- when true, summon the hydra after pressing only the `body` keys. Normally a head is
            --     -- required
            --     invoke_on_body = false,
            --
            --     -- description used for the body keymap when `invoke_on_body` is true
            --     desc = nil, -- when nil, "[Hydra] .. name" is used
            --
            --     -- see :h hydra-hooks
            --     on_enter = function()
            --         print("Hydra enter")
            --         vim.bo.modifiable = false -- temporarily set `nomodifiable` while Hydra is active
            --     end,
            --     on_exit = function()
            --         print("Hydra exit")
            --         -- No need to set modifiable back here
            --     end,
            --     -- on_enter = nil, -- called when the hydra is activated
            --     -- on_exit = nil, -- called before the hydra is deactivated
            --     on_key = nil, -- called after every hydra head
            --
            --     -- timeout after which the hydra is automatically disabled. Calling any head
            --     -- will refresh the timeout
            --     --   true: timeout set to value of 'timeoutlen' (:h 'timeoutlen')
            --     --   5000: set to desired number of milliseconds
            --     timeout = false, -- by default hydras wait forever
            --
            --     -- see :h hydra-hint-hint-configuration
            --     hint = {
            --         show_name = true,
            --         position = { "bottom" },
            --         offset = 0,
            --         float_opts = {},
            --     },
            -- },
        })
    end,
}
