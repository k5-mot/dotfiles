local cache_dir
if vim.fn.has "win64" == 1 then
    cache_dir = os.getenv "USERPROFILE" .. "/.cache/nvim/"
else
    cache_dir = os.getenv "HOME" .. "/.cache/nvim/"
end

-- 未使用providerのhealth warningを避ける
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.filetype.add {
    extension = {
        mdx = "markdown.mdx",
    },
    pattern = {
        [".*%.c%.doxygen"] = "c.doxygen",
        [".*%.cpp%.doxygen"] = "cpp.doxygen",
    },
}

-- Character code
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
-- vim.opt.fileencodings = 'iso-2022-jp,ucs-bom,sjis,utf-8,euc-jp,cp932,default,latin1'
vim.opt.fileencodings = "ucs-bom,utf-8,iso-2022-jp,cp932,euc-jp,default,latin"
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,mac,dos"
vim.opt.ambiwidth = "single"

-- Terminal
vim.opt.termguicolors = true
vim.opt.title = true

-- Number
vim.opt.number = true
-- vim.opt.colorcolumn = '100'
vim.opt.signcolumn = "number"

-- Fold
vim.opt.foldenable = true
vim.opt.foldmethod = "marker"
-- vim.opt.foldmethod = { 'indent', 'marker' }
vim.opt.foldlevel = 2
vim.opt.foldcolumn = "3"

-- Invisible characters
vim.opt.list = true
vim.opt.listchars:append "tab:|‣"
vim.opt.listchars:append "trail:␣"
vim.opt.listchars:append "extends:»"
vim.opt.listchars:append "precedes:«"
vim.opt.listchars:append "nbsp:␣"
vim.opt.listchars:append "eol:↲"
vim.opt.listchars:append "space:⋅"

-- Visual mode
vim.opt.virtualedit = "block"

-- Buffer
vim.opt.hidden = true

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Bell
vim.opt.errorbells = false
vim.opt.visualbell = true

-- Indent
--vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.shiftround = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "min:20,shift:2"

-- TAB to SPACE
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = -1

-- Statusline, Commandline
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.showmode = false

vim.opt.cmdheight = 1

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.ignorecase = true

-- Backup (*~)
vim.opt.backup = true
vim.opt.backupdir = cache_dir .. "backup/"
vim.opt.writebackup = true
-- vim.opt.backupext   = '.back'

-- Swapfile (*.swap)
vim.opt.swapfile = true
vim.opt.directory = cache_dir .. "swap/"
vim.opt.updatetime = 30000
vim.opt.updatecount = 500

-- Undofile (*.undo)
vim.opt.undofile = true
vim.opt.undodir = cache_dir .. "undo/"

-- Viewfile (*.view)
--vim.opt.viewdir     = cache_dir .. 'view/'
--vim.opt.viewoptions = 'folds,cursor,curdir,slash,unix'

-- History
vim.opt.history = 5000

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Mouse control (Normal, Visual, Insert)
vim.opt.mouse = "nvi"
if vim.env.DISPLAY ~= nil or vim.env.WAYLAND_DISPLAY ~= nil or vim.fn.executable "win32yank.exe" == 1 then
    vim.o.clipboard = vim.o.clipboard .. "unnamedplus"
end

vim.cmd "autocmd!"

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

--- 保存前に編集可能なbufferだけ末尾空白を削除します。
--- @param event table autocommand eventです。
--- @return nil
local function trim_trailing_whitespace(event)
    if not vim.bo[event.buf].modifiable then
        return
    end

    vim.cmd [[%s/\s\+$//e]]
end

-- Remove whitespace on save
autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = trim_trailing_whitespace,
})

-- Don't auto commenting new lines
autocmd({ "BufEnter" }, {
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
})

-- Restore cursor location when file is opened
autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

-- -- Save Fold state
-- augroup("FoldRestore", {})
-- autocmd({"BufWinLeave"}, {
--     group    = "FoldRestore",
--     pattern  = "*",
--     callback = function () vim.cmd("mkview") end,
-- })
-- autocmd({"BufWinEnter"}, {
--     group    = "FoldRestore",
--     pattern  = "*",
--     callback = function () vim.cmd("silent mkview") end,
-- })
