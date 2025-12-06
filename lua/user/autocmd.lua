-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
-- reset diagnostic color after changing scheme
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        local colors = {
            Error = "#ff5555",
            Warn = "#ffaa00",
            Info = "#00aaff",
            Hint = "#aaaaaa",
        }

        for type, color in pairs(colors) do
            vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. type, { undercurl = true, sp = color })
        end
    end,
})

-- use space tab in haskell
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "haskell" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
})
