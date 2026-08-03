-- [[ plugins/filer ]]

local status, neotree = pcall(require, "neo-tree")
if not status then
    return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--- neo-tree bufferで現在行を見失いにくくするためcursorlineを有効化します。
--- 引数: なし。
--- @return nil
--- 副作用: 現在windowのlocal cursorline設定を変更します。
local function enable_filer_cursorline()
    vim.opt_local.cursorline = true
end

neotree.setup {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
        indent = {
            with_markers = true,
            with_expanders = true,
        },
        git_status = {
            symbols = {
                added = " ",
                modified = " ",
                deleted = " ",
                renamed = " ",
                untracked = " ",
                ignored = " ",
                unstaged = " ",
                staged = " ",
                conflict = " ",
            },
        },
    },
    window = {
        position = "left",
        width = 30,
        mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
            ["<space>"] = "toggle_node",
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
        },
    },
    filesystem = {
        bind_to_cwd = true,
        cwd_target = {
            sidebar = "tab",
            current = "window",
        },
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
                ".git",
            },
        },
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
    },
    diagnostics = {
        symbols = {
            hint = " ",
            info = " ",
            warn = " ",
            error = " ",
        },
    },
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = enable_filer_cursorline,
        },
    },
}
