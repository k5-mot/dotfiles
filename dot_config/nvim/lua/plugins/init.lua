-- [[ plugins.lua ]]

-- lazy.nvimを未導入環境でも起動できるようにbootstrapする。
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=v11.17.5",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

--- 全角曖昧幅文字の表示幅を標準プロファイルで調整します。
--- 引数: なし。
--- @return nil
--- 副作用: cellwidths.nvimの文字幅設定をNeovimへ反映します。
local function setup_cellwidths()
    -- 'listchars' と 'fillchars' を事前に設定しておくのがお勧めです。
    -- vim.opt.listchars = { eol = "⏎" }
    -- vim.opt.fillchars = { eob = "‣" }
    require("cellwidths").setup {
        name = "default",
        -- name = "empty",          -- 空の設定です。
        -- name = "default",        -- vim-ambiwidth のデフォルトです。
        -- name = "cica",           -- vim-ambiwidth の Cica 用設定です。
        -- name = "sfmono_square",  -- SF Mono Square 用設定です。
    }
end

--- 括弧や引用符の自動補完を有効化します。
--- 引数: なし。
--- @return nil
--- 副作用: nvim-autopairsのinsert mode補助を有効化します。
local function setup_autopairs()
    require("nvim-autopairs").setup {}
end

require("lazy").setup({
    -- lazy.nvim自身もlazy.nvimで管理する。
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
    {
        "delphinus/cellwidths.nvim",
        config = setup_cellwidths,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    {
        "xiyaowong/telescope-emoji.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    -- Filer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },

    -- Completion
    {
        "Saghen/blink.cmp",
        version = "1.*",
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        config = setup_autopairs,
    },
    -- Indent Visualization
    "lukas-reineke/indent-blankline.nvim",

    -- Statusline
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
    },

    -- Colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    "sainnhe/gruvbox-material",
    "sainnhe/sonokai",
    "joshdick/onedark.vim",
}, {
    git = {
        timeout = 120,
    },
    rocks = {
        enabled = false,
    },
    ui = {
        border = "rounded",
    },
})
-- }}}
vim.opt.termguicolors = true

require "plugins.statusline"
require "plugins.lsp"
require "plugins.format"
require "plugins.lint"
require "plugins.completion"
require "plugins.colorscheme"
require "plugins.editor"
require "plugins.syntax"
require "plugins.filer"
require "plugins.telescope"

vim.cmd "colorscheme catppuccin"
