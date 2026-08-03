-- [[ plugins/lint ]]

local status, lint = pcall(require, "lint")
if not status then
    return
end

lint.linters_by_ft = {
    python = { "ruff" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
}

--- 現在のbufferに対応するproject-local linterを実行します。
--- @return nil
local function try_project_lint()
    lint.try_lint()
end

local lint_group = vim.api.nvim_create_augroup("project_local_lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = lint_group,
    callback = try_project_lint,
})
