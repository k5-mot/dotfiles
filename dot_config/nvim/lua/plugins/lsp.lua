-- [[ plugins/lsp ]]

local status, mason = pcall(require, "mason")
if (not status) then return end
local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not status) then return end
local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

-- LSP {{{

require('mason').setup()

local lsp_servers = {
    "bashls",
    "clangd",
    "denols",
    "elmls",
    "emmet_ls",
    "eslint",
    "grammarly",
    "jdtls",
    "jsonls",
    "lua_ls",
    "marksman",
    "pyright",
    "rust_analyzer",
    "svlangserver",
    "texlab",
    "ts_ls",
    "vimls",
}

require("mason-lspconfig").setup({
    ensure_installed = lsp_servers,
    automatic_installation = true,
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

--- LSP serverがbufferへattachされた直後にbuffer local keymapを設定します。
--- @param client table attachされたLSP clientです。
--- @param bufnr integer keymapを設定するbuffer番号です。
--- @return nil
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

for _, server_name in ipairs(lsp_servers) do
    if lspconfig[server_name] then
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            flags = lsp_flags,
        })
    end
end

-- Lspsaga Configuration
local status, lspsaga = pcall(require, "lspsaga")
if (status) then
    lspsaga.setup({
        ui = {
            border = "rounded",
        },
        symbol_in_winbar = {
            enable = true,
        },
        lightbulb = {
            enable = true,
            sign = true,
        },
    })

    --- Lspsagaで前のerror diagnosticへ移動します。
    --- 引数: なし。
    --- @return nil
    local function goto_previous_error()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end

    --- Lspsagaで次のerror diagnosticへ移動します。
    --- 引数: なし。
    --- @return nil
    local function goto_next_error()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end

    -- Lspsagaの主要操作を標準LSP keymapと衝突しにくい形で割り当てる。
    local keymap = vim.keymap.set

    keymap("n", "gh", "<cmd>Lspsaga finder<CR>", { noremap = true, silent = true, desc = "Lspsaga finder" })
    keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { noremap = true, silent = true, desc = "Lspsaga goto definition" })
    keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true, desc = "Lspsaga peek definition" })
    keymap("n", "gy", "<cmd>Lspsaga goto_type_definition<CR>", { noremap = true, silent = true, desc = "Lspsaga goto type definition" })
    keymap("n", "gY", "<cmd>Lspsaga peek_type_definition<CR>", { noremap = true, silent = true, desc = "Lspsaga peek type definition" })

    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { noremap = true, silent = true, desc = "Lspsaga code action" })
    keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { noremap = true, silent = true, desc = "Lspsaga rename" })
    keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { noremap = true, silent = true, desc = "Lspsaga outline" })
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true, desc = "Lspsaga hover" })
    keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", { noremap = true, silent = true, desc = "Lspsaga floating terminal" })

    keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { noremap = true, silent = true, desc = "Lspsaga line diagnostics" })
    keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { noremap = true, silent = true, desc = "Lspsaga cursor diagnostics" })
    keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { noremap = true, silent = true, desc = "Lspsaga buffer diagnostics" })
    keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { noremap = true, silent = true, desc = "Lspsaga workspace diagnostics" })
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { noremap = true, silent = true, desc = "Lspsaga previous diagnostic" })
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { noremap = true, silent = true, desc = "Lspsaga next diagnostic" })

    keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { noremap = true, silent = true, desc = "Lspsaga incoming calls" })
    keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { noremap = true, silent = true, desc = "Lspsaga outgoing calls" })

    keymap("n", "[E", goto_previous_error, { noremap = true, silent = true, desc = "Lspsaga previous error" })
    keymap("n", "]E", goto_next_error, { noremap = true, silent = true, desc = "Lspsaga next error" })
end

-- Reference highlight
-- vim.cmd [[
-- set updatetime=500
-- highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- "augroup lsp_document_highlight
-- "autocmd!
-- "autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
-- "autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
-- "augroup END
-- ]]

-- }}}
