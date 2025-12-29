-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
███████╗██╗██████╗ ███████╗███████╗██╗  ██╗   ██╗
██╔════╝██║██╔══██╗██╔════╝██╔════╝██║  ╚██╗ ██╔╝
█████╗  ██║██████╔╝█████╗  █████╗  ██║   ╚████╔╝
██╔══╝  ██║██╔══██╗██╔══╝  ██╔══╝  ██║    ╚██╔╝ 
██║     ██║██║  ██║███████╗██║     ███████╗██║ 
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝ 
]],
        },
      },
    },
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function() vim.cmd "colorscheme rose-pine" end,
  },

  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    lazy = false,
    config = function()
      require("kanagawa").setup {
        compile = true, -- cache highlights, faster startup
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- set true if you hate backgrounds
        dimInactive = false,
        terminalColors = true,

        colors = {
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
          },
        },

        overrides = function(colors)
          local c = colors.palette
          return {
            -- cleaner line numbers
            LineNr = { fg = c.sumiInk4 },
            CursorLineNr = { fg = c.crystalBlue, bold = true },

            -- floats that don’t burn your eyes
            NormalFloat = { bg = c.sumiInk1 },
            FloatBorder = { fg = c.sumiInk4 },

            -- diagnostics that don’t scream
            DiagnosticVirtualTextError = { fg = c.peachRed },
            DiagnosticVirtualTextWarn = { fg = c.surimiOrange },
            DiagnosticVirtualTextInfo = { fg = c.waveAqua1 },
            DiagnosticVirtualTextHint = { fg = c.springGreen },

            -- popup menus
            Pmenu = { bg = c.sumiInk1 },
            PmenuSel = { bg = c.waveBlue1 },
          }
        end,
      }

      -- pick ONE variant
      vim.cmd "colorscheme kanagawa-wave"
      -- vim.cmd("colorscheme kanagawa-dragon")
      -- vim.cmd("colorscheme kanagawa-lotus")
    end,
  },

  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim" },
  { "nvim-mini/mini.nvim", version = "*" },
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup {
        livePreview = true,
        themes = { "rose-pine", "kanagawa", "catppuccin", "gruvbox", "astrodark" },
      }
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",

      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = true } end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<leader>T",
        "<cmd>Themery<cr>",
        desc = "Theme switcher",
      },
    },
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "Normal",
              FloatBorder = "DiagnosticInfo",
            },
          },
        },
      },
    },
  },
}
