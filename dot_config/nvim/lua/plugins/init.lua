-- [[ plugins.lua ]]

-- Lazy.nvim Installation Function
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim Setup
require("lazy").setup({
    -- Lazy.nvim can manage itself
    "folke/lazy.nvim",

    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvimtools/none-ls-extras.nvim",
    },
    "onsails/lspkind-nvim",
    "MunifTanjim/prettier.nvim",
    -- {
    --     "glepnir/lspsaga.nvim",
    --     branch = "main",
    --     config = function()
    --         local saga = require("lspsaga")
    --
    --         saga.init_lsp_saga({
    --             -- your configuration
    --         })
    --     end,
    -- },

    -- use 'xiyaowong/transparent.nvim'

    {
        "delphinus/cellwidths.nvim",
        config = function()
            -- 'listchars' と 'fillchars' を事前に設定しておくのがお勧めです。
            -- vim.opt.listchars = { eol = "⏎" }
            -- vim.opt.fillchars = { eob = "‣" }
            require("cellwidths").setup({
            name = "default",
            -- name = "empty",          -- 空の設定です。
            -- name = "default",        -- vim-ambiwidth のデフォルトです。
            -- name = "cica",           -- vim-ambiwidth の Cica 用設定です。
            -- name = "sfmono_square",  -- SF Mono Square 用設定です。
            })
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        -- run = ':TSUpdate',
        build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        }
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        }
    },
    {
        "xiyaowong/telescope-emoji.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        }
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension("frecency")
        end,
        dependencies = {
            "kkharji/sqlite.lua",
            "nvim-telescope/telescope.nvim",
        }
    },
    {
        "nvim-telescope/telescope-packer.nvim",
        config = function()
            require("telescope").load_extension("packer")
        end,
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope.nvim",
        }
    },
    -- {
    --     "nvim-telescope/telescope-symbols.nvim",
    --     config = function()
    --         require("telescope").load_extension("symbols")
    --     end,
    --     dependencies = {
    --         "nvim-telescope/telescope.nvim",
    --     }
    -- },

    -- Filer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
    },

    -- Completion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-emoji",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "ray-x/cmp-treesitter",
    -- AI
    -- "codota/tabnine-vim",
    -- {
    --     "tzachar/cmp-tabnine",
    --     build = "./install.sh",
    --     dependencies = "hrsh7th/nvim-cmp"
    -- },
    -- "github/copilot.vim",
    -- "hrsh7th/cmp-copilot",
    -- {
    --     "zbirenbaum/copilot.lua",
    --     event = "VimEnter",
    --     config = function()
    --         vim.defer_fn(function()
    --             require("copilot").setup()
    --         end, 100)
    --     end,
    -- },

    -- {
    --     "zbirenbaum/copilot-cmp",
    --     after = { "copilot.lua" },
    --     config = function ()
    --         require("copilot_cmp").setup({
    --             method = "getCompletionsCycling",
    --             formatters = {
    --                 label = require("copilot_cmp.format").format_label_text,
    --                 insert_text = require("copilot_cmp.format").format_insert_text,
    --                 preview = require("copilot_cmp.format").deindent,
    --             },
    --         })
    --     end
    -- },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup({}) end,
    },
    -- Indent Visualization
    "lukas-reineke/indent-blankline.nvim",

    -- Statusline
    "nvim-tree/nvim-web-devicons",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
    },

    -- Tabline
    {
        "romgrk/barbar.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- {
    --     "akinsho/bufferline.nvim",
    --     tag = "v3.*",
    --     dependencies = "kyazdani42/nvim-web-devicons"
    -- },

    -- Startup
    -- {
    --     "nvimdev/dashboard-nvim",
    --     dependencies = { "nvim-tree/nvim-web-devicons" }
    -- },

    -- Colorscheme
    "dracula/vim",
    "folke/tokyonight.nvim",
    "sainnhe/everforest",
    "morhetz/gruvbox",
    "sonph/onehalf",
    "sainnhe/gruvbox-material",
    "sainnhe/sonokai",
    "joshdick/onedark.vim",
    "arcticicestudio/nord-vim",
    "tomasr/molokai",
    "junegunn/seoul256.vim",
    "cocopon/iceberg.vim",

    -- For tmux
    "edkolev/tmuxline.vim",
}, {
    git = {
        timeout = 120,
    },
    ui = {
        border = "rounded",
    },
})
-- }}}
vim.opt.termguicolors = true
-- vim.cmd('colorscheme darkblue')
-- require("bufferline").setup({})

-- local db = require('dashboard')
-- db.custom_header = {
-- "",
-- "",
-- "",
-- "",
-- "",
-- "██╗░░██╗███████╗░░░░░░███╗░░░███╗░█████╗░████████╗██╗░██████╗     ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗",
-- "██║░██╔╝██╔════╝░░░░░░████╗░████║██╔══██╗╚══██╔══╝╚█║██╔════╝     ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║",
-- "█████═╝░██████╗░█████╗██╔████╔██║██║░░██║░░░██║░░░░╚╝╚█████╗░     ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║",
-- "██╔═██╗░╚════██╗╚════╝██║╚██╔╝██║██║░░██║░░░██║░░░░░░░╚═══██╗     ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║",
-- "██║░╚██╗██████╔╝░░░░░░██║░╚═╝░██║╚█████╔╝░░░██║░░░░░░██████╔╝     ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║",
-- "╚═╝░░╚═╝╚═════╝░░░░░░░╚═╝░░░░░╚═╝░╚════╝░░░░╚═╝░░░░░░╚═════╝░     ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
-- "",
-- "",
-- "",
-- "█▀▀ █░█ ▄▀█ █▄░█ █▀▀ █▀▀   █▄▄ █▀▀ █▀▀ █▀█ █▀█ █▀▀   █▄█ █▀█ █░█   █░█ ▄▀█ █░█ █▀▀   ▀█▀ █▀█ ░",
-- "█▄▄ █▀█ █▀█ █░▀█ █▄█ ██▄   █▄█ ██▄ █▀░ █▄█ █▀▄ ██▄   ░█░ █▄█ █▄█   █▀█ █▀█ ▀▄▀ ██▄   ░█░ █▄█ ▄",
-- "",
-- "",
-- }

-- db.custom_center = {
--     {
--         icon = '  ',
--         desc = 'Recently latest session                 ',
--         shortcut = 'SPC s l',
--         action ='SessionLoad'
--     },
--     {
--         icon = '  ',
--         desc = 'Recently opened files                   ',
--         action =  'DashboardFindHistory',
--         shortcut = 'SPC f h'
--     },
--     {
--         icon = '  ',
--         desc = 'Find  File                              ',
--         action = 'Telescope find_files find_command=rg,--hidden,--files',
--         shortcut = 'SPC f f'
--     },
--     {
--         icon = '  ',
--         desc ='File Browser                            ',
--         action =  'Telescope file_browser',
--         shortcut = 'SPC f b'
--     },
--     {
--         icon = '  ',
--         desc = 'Find  word                              ',
--         action = 'Telescope live_grep',
--         shortcut = 'SPC f w'
--     },
--     -- {
--     --     icon = '  ',
--     --     desc = 'Open Personal dotfiles                  ',
--     --     action = 'Telescope dotfiles path=' .. os.getenv('HOME') ..'Documents/GitHub/dotfiles',
--     --     shortcut = 'SPC f d'
--     -- },
-- }

--   local function footer()
--     -- Number of plugins
--     --local total_plugins = vim.tbl_keys(packer_plugins)
--     local datetime = os.date("%d-%m-%Y %H:%M:%S")
--     local plugins_text = "   "
--     --1  .. total_plugins
--       .. " plugins"
--       .. "   v"
--       .. vim.version().major
--       .. "."
--       .. vim.version().minor
--       .. "."
--       .. vim.version().patch
--       .. "   "
--       .. datetime
--
--     -- Quote
--     --local fortune = require "alpha.fortune"
--     --local quote = table.concat(fortune(), "\n")
--
--     return plugins_text
--     --.. "\n" .. quote
--   end
--
--
-- db.custom_footer = footer

require('plugins.statusline')
require('plugins.lsp')
require('plugins.completion')
require('plugins.colorscheme')
require('plugins.editor')
require('plugins.syntax')
require('plugins.filer')
require('plugins.telescope')

local status, transparent = pcall(require, "transparent")
if (status) then

    -- require("transparent").setup({ -- Optional, you don't have to run setup.
    --     groups = { -- table: default groups
    --         'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    --         'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    --         'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    --         'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    --         'EndOfBuffer',
    --     },
    --     extra_groups = {}, -- table: additional groups that should be cleared
    --     exclude_groups = {}, -- table: groups you don't want to clear
    -- })
end

-- local status, sonokai = pcall(require, 'sonokai')
-- if (not status) then return end
-- vim.cmd('colorscheme sonokai')
-- if packer_plugins['sonokai'] and packer_plugins['sonokai'].loaded then
--     -- print('Coc is Loaded!')
-- end
vim.cmd('colorscheme sonokai')
