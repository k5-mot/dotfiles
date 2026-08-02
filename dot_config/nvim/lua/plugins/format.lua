-- [[ plugins/format ]]

local status, conform = pcall(require, "conform")
if (not status) then return end

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
    },
    format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
    },
})

--- 現在のbufferをproject-local formatterまたはLSP fallbackで整形します。
--- @return nil
local function format_current_buffer()
    conform.format({ async = true, lsp_format = "fallback" })
end

vim.keymap.set("n", "<space>f", format_current_buffer, { noremap = true, silent = true })
