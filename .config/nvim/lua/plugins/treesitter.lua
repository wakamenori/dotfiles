require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "typescript",
        "tsx",
        "python",
        "lua",
        "yaml",
        "json",
        "jsonc",
        "json5",
        "css",
        "html",
        "bash",
        "javascript",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "markdown",
        "markdown_inline",
        "toml",
        "vim",
        "sql",
        "diff",
        "dockerfile"
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
}
require('hlargs').setup()
require("ts-node-action").setup({})
vim.keymap.set({ "n" }, "U", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
