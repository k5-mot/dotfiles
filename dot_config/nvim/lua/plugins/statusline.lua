-- [[ plugins/statusline ]]

local status, lualine = pcall(require, "lualine")
if not status then
    return
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            {
                "diff",
                colored = true,
                symbols = { added = " ", modified = " ", removed = " " },
            },
            {
                "diagnostics",
                sections = { "error", "warn", "info", "hint" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                colored = true,
                update_in_insert = false,
                always_visible = true,
            },
        },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = {
            {
                "buffers",
                mode = 2,
                symbols = {
                    alternate_file = "",
                    modified = " ●",
                },
            },
        },
        lualine_z = {
            {
                "tabs",
                mode = 2,
            },
        },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = { "lazy", "mason", "neo-tree", "quickfix" },
}
