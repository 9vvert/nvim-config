return {

        {
        'nvim-tree/nvim-web-devicons',
        lazy = false,
        opts = {},
        config = function()
        require('nvim-web-devicons').setup {
            color_icons = true,
            -- globally enable default icons (default to false)
            -- will get overriden by `get_icons` option
            default = true,
            -- globally enable "strict" selection of icons - icon will be looked up in
            -- different tables, first by filename, and if not found by extension; this
            -- prevents cases when file doesn't have any extension but still gets some icon
            -- because its name happened to match some extension (default to false)
            strict = true,
            -- set the light or dark variant manually, instead of relying on `background`
            -- (default to nil)
            variant = 'light|dark',
            -- override blend value for all highlight groups :h highlight-blend.
            -- setting this value to `0` will make all icons opaque. in practice this means
            -- that icons width will not be affected by pumblend option (see issue #608)
            -- (default to nil)
            blend = 0,
        }
        end,
    },
}