-- [[ plugins/format ]]

local status, conform = pcall(require, "conform")
if not status then
    return
end

--- 指定したcommandがPATH上で実行可能か確認します。
--- @param command string 確認するcommand名です。
--- @return boolean commandが実行可能な場合はtrue、それ以外はfalseを返します。
local function command_exists(command)
    return vim.fn.executable(command) == 1
end

--- 利用可能なproject-local formatterだけをfiletype別に組み立てます。
--- @return table filetypeをkey、formatter名一覧をvalueにしたconform.nvim設定を返します。
local function build_formatters_by_ft()
    local formatters_by_ft = {}

    if command_exists "stylua" then
        formatters_by_ft.lua = { "stylua" }
    end

    if command_exists "ruff" then
        formatters_by_ft.python = { "ruff_format" }
    end

    if command_exists "prettier" then
        local prettier_filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "json",
            "jsonc",
            "css",
            "scss",
            "less",
            "markdown",
            "yaml",
        }

        for _, filetype in ipairs(prettier_filetypes) do
            formatters_by_ft[filetype] = { "prettier" }
        end
    end

    return formatters_by_ft
end

conform.setup {
    formatters_by_ft = build_formatters_by_ft(),
    format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
    },
}

--- 現在のbufferをproject-local formatterまたはLSP fallbackで整形します。
--- @return nil
local function format_current_buffer()
    conform.format { async = true, lsp_format = "fallback" }
end

vim.keymap.set("n", "<space>f", format_current_buffer, { noremap = true, silent = true })
