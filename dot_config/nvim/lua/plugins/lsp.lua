-- [[ plugins/lsp ]]

local status, mason = pcall(require, "mason")
if not status then
    return
end

local lsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not lsp_status then
    return
end

mason.setup()

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

mason_lspconfig.setup {
    ensure_installed = lsp_servers,
    automatic_installation = true,
}

local blink_status, blink = pcall(require, "blink.cmp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
if blink_status then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

local telescope_status, telescope_builtin = pcall(require, "telescope.builtin")

--- TelescopeのLSP pickerを優先し、利用できない場合はnative LSPへfallbackします。
--- @param picker_name string telescope.builtin上のpicker関数名です。
--- @param fallback function Telescopeが使えない場合に実行するnative LSP関数です。
--- @return nil
local function run_telescope_lsp_picker(picker_name, fallback)
    if telescope_status and type(telescope_builtin[picker_name]) == "function" then
        telescope_builtin[picker_name]()
        return
    end

    fallback()
end

--- 前後のdiagnosticへseverity指定付きで移動します。
--- @param count integer 移動方向と件数です。負数なら前、正数なら次へ移動します。
--- @param severity integer|nil 絞り込むdiagnostic severityです。
--- @return nil
local function jump_diagnostic(count, severity)
    vim.diagnostic.jump {
        count = count,
        severity = severity,
        float = true,
    }
end

--- 前のdiagnosticへ移動します。
--- 引数: なし。
--- @return nil
local function goto_previous_diagnostic()
    jump_diagnostic(-1)
end

--- 次のdiagnosticへ移動します。
--- 引数: なし。
--- @return nil
local function goto_next_diagnostic()
    jump_diagnostic(1)
end

--- 前のerror diagnosticへ移動します。
--- 引数: なし。
--- @return nil
local function goto_previous_error()
    jump_diagnostic(-1, vim.diagnostic.severity.ERROR)
end

--- 次のerror diagnosticへ移動します。
--- 引数: なし。
--- @return nil
local function goto_next_error()
    jump_diagnostic(1, vim.diagnostic.severity.ERROR)
end

--- 行単位のdiagnosticをfloating windowで表示します。
--- 引数: なし。
--- @return nil
local function show_line_diagnostics()
    vim.diagnostic.open_float(nil, {
        scope = "line",
        border = "rounded",
    })
end

--- cursor位置のdiagnosticをfloating windowで表示します。
--- 引数: なし。
--- @return nil
local function show_cursor_diagnostics()
    vim.diagnostic.open_float(nil, {
        scope = "cursor",
        border = "rounded",
    })
end

--- buffer内のdiagnosticをlocation listで表示します。
--- 引数: なし。
--- @return nil
local function show_buffer_diagnostics()
    vim.diagnostic.setloclist {
        open = true,
    }
end

--- workspace全体のdiagnosticをquickfix listで表示します。
--- 引数: なし。
--- @return nil
local function show_workspace_diagnostics()
    vim.diagnostic.setqflist {
        open = true,
    }
end

--- LSP参照をTelescopeまたはnative LSPで表示します。
--- 引数: なし。
--- @return nil
local function show_lsp_references()
    run_telescope_lsp_picker("lsp_references", vim.lsp.buf.references)
end

--- LSP定義をTelescopeまたはnative LSPで表示します。
--- 引数: なし。
--- @return nil
local function show_lsp_definitions()
    run_telescope_lsp_picker("lsp_definitions", vim.lsp.buf.definition)
end

--- LSP型定義をTelescopeまたはnative LSPで表示します。
--- 引数: なし。
--- @return nil
local function show_lsp_type_definitions()
    run_telescope_lsp_picker("lsp_type_definitions", vim.lsp.buf.type_definition)
end

--- 現在のworkspace folder一覧を表示します。
--- 引数: なし。
--- @return nil
local function show_workspace_folders()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

--- incoming callsをnative LSPで表示します。
--- 引数: なし。
--- @return nil
local function show_incoming_calls()
    vim.lsp.buf.incoming_calls()
end

--- outgoing callsをnative LSPで表示します。
--- 引数: なし。
--- @return nil
local function show_outgoing_calls()
    vim.lsp.buf.outgoing_calls()
end

local diagnostic_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", show_line_diagnostics, diagnostic_opts)
vim.keymap.set("n", "[d", goto_previous_diagnostic, diagnostic_opts)
vim.keymap.set("n", "]d", goto_next_diagnostic, diagnostic_opts)
vim.keymap.set("n", "<space>q", show_buffer_diagnostics, diagnostic_opts)

--- LSP serverがbufferへattachされた直後にbuffer local keymapを設定します。
--- @param client table attachされたLSP clientです。
--- @param bufnr integer keymapを設定するbuffer番号です。
--- @return nil
local function on_attach(client, bufnr)
    -- 標準補完の入口をLSPへ向ける。
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- buffer local keymapはLSPがattachしたbufferだけへ閉じる。
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", show_workspace_folders, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", show_lsp_references, bufopts)

    vim.keymap.set("n", "gh", show_lsp_references, bufopts)
    vim.keymap.set("n", "gp", show_lsp_definitions, bufopts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "gY", show_lsp_type_definitions, bufopts)
    vim.keymap.set("n", "<leader>sl", show_line_diagnostics, bufopts)
    vim.keymap.set("n", "<leader>sc", show_cursor_diagnostics, bufopts)
    vim.keymap.set("n", "<leader>sb", show_buffer_diagnostics, bufopts)
    vim.keymap.set("n", "<leader>sw", show_workspace_diagnostics, bufopts)
    vim.keymap.set("n", "[e", goto_previous_diagnostic, bufopts)
    vim.keymap.set("n", "]e", goto_next_diagnostic, bufopts)
    vim.keymap.set("n", "[E", goto_previous_error, bufopts)
    vim.keymap.set("n", "]E", goto_next_error, bufopts)
    vim.keymap.set("n", "<leader>ci", show_incoming_calls, bufopts)
    vim.keymap.set("n", "<leader>co", show_outgoing_calls, bufopts)
end

local lsp_flags = {
    -- 入力中の診断更新を抑えてLSP serverへの負荷を下げる。
    debounce_text_changes = 150,
}

vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
})

vim.lsp.enable(lsp_servers)
