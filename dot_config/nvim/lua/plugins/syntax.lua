-- [[ plugins/syntax ]]

local status, treesitter = pcall(require, "nvim-treesitter")
if not status then
    return
end

local parser_names = {
    "bash",
    "bibtex",
    "c",
    "c_sharp",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "fortran",
    "go",
    "graphql",
    "html",
    "http",
    "java",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "ninja",
    "perl",
    "php",
    "python",
    "r",
    "ruby",
    "rust",
    "scss",
    "toml",
    "vue",
    "yaml",
    "zig",
}

--- nvim-treesitterで利用可能なparserだけを抽出します。
--- @param candidates string[] 導入候補のparser名一覧です。
--- @return string[] 利用可能なparser名一覧です。
local function filter_available_parsers(candidates)
    if type(treesitter.get_available) ~= "function" then
        return candidates
    end

    local available = {}
    for _, parser_name in ipairs(treesitter.get_available()) do
        available[parser_name] = true
    end

    local filtered = {}
    for _, parser_name in ipairs(candidates) do
        if available[parser_name] then
            table.insert(filtered, parser_name)
        end
    end

    return filtered
end

--- 大きいbufferでTree-sitter highlightを避けるべきか判定します。
--- @param bufnr integer 判定対象のbuffer番号です。
--- @return boolean 100KiBを超える通常ファイルならtrue、それ以外はfalseです。
local function is_large_buffer(bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    if filename == "" then
        return false
    end

    local ok, stats = pcall(vim.uv.fs_stat, filename)
    return ok and stats ~= nil and stats.size > 100 * 1024
end

--- FileType検出後にTree-sitter highlightを開始します。
--- @param event table autocmdから渡されるevent情報です。
--- @return nil
local function start_treesitter(event)
    if is_large_buffer(event.buf) then
        return
    end

    pcall(vim.treesitter.start, event.buf)
end

treesitter.install(filter_available_parsers(parser_names))

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("dotfiles_treesitter", { clear = true }),
    callback = start_treesitter,
})
