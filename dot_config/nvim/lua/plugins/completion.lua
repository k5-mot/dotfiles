-- [[ plugins/completion ]]

local status, blink = pcall(require, "blink.cmp")
if not status then
    return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

blink.setup {
    keymap = {
        preset = "none",
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
    },
    sources = {
        -- emojiはTelescope pickerで扱い、補完候補には混ぜない。
        default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
        list = {
            selection = {
                preselect = true,
                auto_insert = false,
            },
        },
        menu = {
            border = "rounded",
        },
        documentation = {
            auto_show = false,
            window = {
                border = "rounded",
            },
        },
    },
    signature = {
        enabled = true,
        window = {
            border = "rounded",
        },
    },
    cmdline = {
        enabled = true,
        keymap = {
            preset = "cmdline",
        },
    },
}
