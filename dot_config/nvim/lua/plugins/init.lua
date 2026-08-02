-- [[ plugins.lua ]]

-- Lazy.nvim Installation Function
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=v11.17.5",
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
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    "onsails/lspkind-nvim",
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },

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

    -- Colorscheme
    "sainnhe/gruvbox-material",
    "sainnhe/sonokai",
    "joshdick/onedark.vim",

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

require('plugins.statusline')
require('plugins.lsp')
require('plugins.format')
require('plugins.lint')
require('plugins.completion')
require('plugins.colorscheme')
require('plugins.editor')
require('plugins.syntax')
require('plugins.filer')
require('plugins.telescope')

vim.cmd('colorscheme sonokai')
