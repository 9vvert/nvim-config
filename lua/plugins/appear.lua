return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "eldritch",
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      vim.keymap.set("n", "<leader>si", "<cmd>Telescope notify<Enter>", { desc = "[S]earch [N]otifications" }),
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("notify").setup {
        render = "wrapped-default",
        timeout = 3,
        max_width = 50,
        max_height = 8,
      }
    end,
  },

  {
    "luukvbaal/statuscol.nvim",
    config = function()
      -- Custom function to show both absolute and relative line numbers
      -- vim.api.nvim_set_hl(0, "current_vert_split", { fg = "#ffa500", bg = "NONE" })
      local function lnum_both()
        local lnum = vim.v.lnum
        local relnum = vim.v.lnum == vim.fn.line "." and 0 or math.abs(vim.v.lnum - vim.fn.line ".")
        return string.format("%3d %2d", lnum, relnum)
      end
      require("statuscol").setup {
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
                return vim.v.lnum ~= vim.fn.line "."
              end,
            },
            click = "v:lua.ScLa",
          },
          {
            text = { lnum_both, " " },
            hl = "current_vert_split",
            condition = {
              function(args)
                return vim.v.lnum == vim.fn.line "."
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
                return vim.v.lnum ~= vim.fn.line "."
              end,
            },
          },
          {
            text = { "-> " },
            hl = "current_vert_split",
            condition = {
              function(args)
                return vim.v.lnum == vim.fn.line "."
              end,
            },
          },
        },
      }
    end,
  },
}
