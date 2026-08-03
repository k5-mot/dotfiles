-- [[ plugins/telescope ]]

local status, telescope = pcall(require, "telescope")
if not status then
    return
end

local builtin = require "telescope.builtin"

--- hidden fileを含めてTelescopeでfile検索を開きます。
--- 引数: なし。
--- @return nil
local function find_files()
    builtin.find_files { no_ignore = false, hidden = true }
end

--- 現在bufferのdirectory pathを返します。
--- 引数: なし。
--- @return string 現在bufferの親directory pathです。
local function telescope_buffer_dir()
    return vim.fn.expand "%:p:h"
end

--- Telescope file browserを現在bufferのdirectory起点で開きます。
--- 引数: なし。
--- @return nil
local function open_file_browser()
    telescope.extensions.file_browser.file_browser {
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40 },
    }
end

--- 選択したemojiをclipboardへ保存します。
--- @param emoji table telescope-emojiから渡されるemoji候補です。
--- @return nil
--- 副作用: `+` registerを更新し、貼り付け案内を表示します。
local function copy_emoji(emoji)
    vim.fn.setreg("+", emoji.value)
    print(
        [[絵文字をclipboardへコピーしました。p または "*p で貼り付けられます: ]] .. emoji.value
    )
end

vim.keymap.set("n", "ff", find_files, {})
vim.keymap.set("n", "fg", builtin.live_grep, {})
vim.keymap.set("n", "fb", builtin.buffers, {})
vim.keymap.set("n", "fh", builtin.help_tags, {})
vim.keymap.set("n", "ft", open_file_browser, { noremap = true })

telescope.setup {
    extensions = {
        file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
                ["i"] = {},
                ["n"] = {},
            },
        },
        emoji = {
            action = copy_emoji,
        },
    },
}

telescope.load_extension "file_browser"
telescope.load_extension "emoji"
