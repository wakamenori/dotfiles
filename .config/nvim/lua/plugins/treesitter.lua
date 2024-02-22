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
    -- context_commentstring = {
    --     enable = true,
    -- },
}
vim.g.skip_ts_context_commentstring_module = true
require('hlargs').setup()

local tsj = require('treesj')
local langs = {--[[ configuration for languages ]]}

tsj.setup({
  -- Use default keymaps
  -- (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = true,

  -- Node with syntax error will not be formatted
  check_syntax_error = true,

  -- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 120,

  -- hold|start|end:
  -- hold - cursor follows the node/place on which it was called
  -- start - cursor jumps to the first symbol of the node being formatted
  -- end - cursor jumps to the last symbol of the node being formatted
  cursor_behavior = 'hold',

  -- Notify about possible problems or not
  notify = true,
  langs = langs,

  -- Use `dot` for repeat action
  dot_repeat = true,
})
